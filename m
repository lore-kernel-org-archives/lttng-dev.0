From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH lttng-tools] Fix printk instrumentation
Date: Thu, 4 Jul 2013 12:57:45 -0400
Message-ID: <20130704165745.GA31483__15869.166100356$1372957108$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Uumqq-0003TC-OI
	for lttng-dev@lists.lttng.org; Thu, 04 Jul 2013 12:57:48 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: yannick.brosseau@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This patch fixes the printk instrumentation.

- It does not require a 2kB buffer on the stack anymore,
- It introduces __dynamic_array_enc_ext_2() and tp_memcpy_dyn_2(), which
  allow copying into a single variable-length buffer from two sources,
  useful for kernel < 3.5.
- It adds support for 3.10 kernel printk instrumentation.

Yannick, can you try this out on 3.4, 3.5, 3.9 and 3.10 kernels ? When
you confirm that it works, I'll split it into two patches (one for
lttng-events.h and the other for printk.h), merge, and backport this.

Only built-tested on 3.5 kernel so far.

Thanks,

Mathieu

---
diff --git a/instrumentation/events/lttng-module/printk.h b/instrumentation/events/lttng-module/printk.h
index 4c744f9..e22a2cc 100644
--- a/instrumentation/events/lttng-module/printk.h
+++ b/instrumentation/events/lttng-module/printk.h
@@ -7,7 +7,25 @@
 #include <linux/tracepoint.h>
 #include <linux/version.h>
 
-#define MSG_TRACE_MAX_LEN	2048
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0))
+
+TRACE_EVENT(console,
+	TP_PROTO(const char *text, size_t len),
+
+	TP_ARGS(text, len),
+
+	TP_STRUCT__entry(
+		__dynamic_array_text(char, msg, len)
+	),
+
+	TP_fast_assign(
+		tp_memcpy_dyn(msg, msg)
+	),
+
+	TP_printk("%s", __get_str(msg))
+)
+
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
 
 TRACE_EVENT_CONDITION(console,
 	TP_PROTO(const char *log_buf, unsigned start, unsigned end,
@@ -18,46 +36,47 @@ TRACE_EVENT_CONDITION(console,
 	TP_CONDITION(start != end),
 
 	TP_STRUCT__entry(
-		__dynamic_array_text(char, msg,
-			min_t(unsigned, end - start, MSG_TRACE_MAX_LEN) + 1)
+		__dynamic_array_text(char, msg, end - start)
 	),
 
 	TP_fast_assign(
-		tp_memcpy_dyn(msg,
-			({
-				char lmsg[MSG_TRACE_MAX_LEN + 1];
-
-				if ((end - start) > MSG_TRACE_MAX_LEN)
-					start = end - MSG_TRACE_MAX_LEN;
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0))
-				if ((start & (log_buf_len - 1)) >
-					(end & (log_buf_len - 1))) {
-					memcpy(lmsg,
-						log_buf +
-						(start & (log_buf_len - 1)),
-						log_buf_len -
-						(start & (log_buf_len - 1)));
-					memcpy(lmsg + log_buf_len -
-						(start & (log_buf_len - 1)),
-						log_buf,
-						end & (log_buf_len - 1));
-				} else
-					memcpy(lmsg,
-						log_buf +
-						(start & (log_buf_len - 1)),
-						end - start);
-#else
-				memcpy(lmsg, log_buf + start, end - start);
-#endif
-				lmsg[end - start] = 0;
-				lmsg;
-			})
-		)
+		tp_memcpy_dyn(msg, log_buf + start)
+	),
+
+	TP_printk("%s", __get_str(msg))
+)
+
+#else /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)) */
+
+TRACE_EVENT_CONDITION(console,
+	TP_PROTO(const char *log_buf, unsigned start, unsigned end,
+		 unsigned log_buf_len),
+
+	TP_ARGS(log_buf, start, end, log_buf_len),
+
+	TP_CONDITION(start != end),
+
+	TP_STRUCT__entry(
+		__dynamic_array_text_2(char, msg,
+			(start & (log_buf_len - 1)) > (end & (log_buf_len - 1))
+				? log_buf_len - (start & (log_buf_len - 1))
+				: end - start,
+			(start & (log_buf_len - 1)) > (end & (log_buf_len - 1))
+				? end & (log_buf_len - 1)
+				: 0)
+	),
+
+	TP_fast_assign(
+		tp_memcpy_dyn_2(msg,
+			log_buf + (start & (log_buf_len - 1)),
+			log_buf)
 	),
 
 	TP_printk("%s", __get_str(msg))
 )
+
+#endif
+
 #endif /* _TRACE_PRINTK_H */
 
 /* This part must be outside protection */
diff --git a/probes/lttng-events-reset.h b/probes/lttng-events-reset.h
index 44e8ba5..b601e8d 100644
--- a/probes/lttng-events-reset.h
+++ b/probes/lttng-events-reset.h
@@ -29,6 +29,9 @@
 #undef __dynamic_array_enc_ext
 #define __dynamic_array_enc_ext(_type, _item, _length, _order, _base, _encoding)
 
+#undef __dynamic_array_enc_ext_2
+#define __dynamic_array_enc_ext_2(_type, _item, _length1, _length2, _order, _base, _encoding)
+
 #undef __dynamic_array_len
 #define __dynamic_array_len(_type, _item, _length)
 
diff --git a/probes/lttng-events.h b/probes/lttng-events.h
index 8a3a886..9606204 100644
--- a/probes/lttng-events.h
+++ b/probes/lttng-events.h
@@ -236,6 +236,10 @@ void trace_##_name(void *__data);
 		},						\
 	},
 
+#undef __dynamic_array_enc_ext_2
+#define __dynamic_array_enc_ext_2(_type, _item, _length1, _length2, _order, _base, _encoding) \
+	__dynamic_array_enc_ext(_type, _item, _length1 + _length2, _order, _base, _encoding)
+
 #undef __dynamic_array
 #define __dynamic_array(_type, _item, _length)			\
 	__dynamic_array_enc_ext(_type, _item, _length, __BYTE_ORDER, 10, none)
@@ -248,6 +252,10 @@ void trace_##_name(void *__data);
 #define __dynamic_array_hex(_type, _item, _length)		\
 	__dynamic_array_enc_ext(_type, _item, _length, __BYTE_ORDER, 16, none)
 
+#undef __dynamic_array_text_2
+#define __dynamic_array_text_2(_type, _item, _length1, _length2)	\
+	__dynamic_array_enc_ext_2(_type, _item, _length1, _length2, __BYTE_ORDER, 10, UTF8)
+
 #undef __string
 #define __string(_item, _src)					\
 	{							\
@@ -407,6 +415,18 @@ static __used struct lttng_probe_desc TP_ID(__probe_desc___, TRACE_SYSTEM) = {
 	__event_len += sizeof(_type) * __dynamic_len[__dynamic_len_idx];       \
 	__dynamic_len_idx++;
 
+#undef __dynamic_array_enc_ext_2
+#define __dynamic_array_enc_ext_2(_type, _item, _length1, _length2, _order, _base, _encoding)\
+	__event_len += lib_ring_buffer_align(__event_len, lttng_alignof(u32));   \
+	__event_len += sizeof(u32);					       \
+	__event_len += lib_ring_buffer_align(__event_len, lttng_alignof(_type)); \
+	__dynamic_len[__dynamic_len_idx] = (_length1);			       \
+	__event_len += sizeof(_type) * __dynamic_len[__dynamic_len_idx];       \
+	__dynamic_len_idx++;						       \
+	__dynamic_len[__dynamic_len_idx] = (_length2);			       \
+	__event_len += sizeof(_type) * __dynamic_len[__dynamic_len_idx];       \
+	__dynamic_len_idx++;
+
 #undef __string
 #define __string(_item, _src)						       \
 	__event_len += __dynamic_len[__dynamic_len_idx++] = strlen(_src) + 1;
@@ -464,6 +484,10 @@ static inline size_t __event_get_size__##_name(size_t *__dynamic_len, _proto) \
 	__event_align = max_t(size_t, __event_align, lttng_alignof(u32));	  \
 	__event_align = max_t(size_t, __event_align, lttng_alignof(_type));
 
+#undef __dynamic_array_enc_ext_2
+#define __dynamic_array_enc_ext_2(_type, _item, _length1, _length2, _order, _base, _encoding)\
+	__dynamic_array_enc_ext(_type, _item, _length1 + _length2, _order, _base, _encoding)
+
 #undef __string
 #define __string(_item, _src)
 
@@ -510,6 +534,10 @@ static inline size_t __event_get_align__##_name(_proto)			      \
 #define __dynamic_array_enc_ext(_type, _item, _length, _order, _base, _encoding)\
 	_type	_item;
 
+#undef __dynamic_array_enc_ext_2
+#define __dynamic_array_enc_ext_2(_type, _item, _length1, _length2, _order, _base, _encoding)\
+	__dynamic_array_enc_ext(_type, _item, _length1 + _length2, _order, _base, _encoding)
+
 #undef __string
 #define __string(_item, _src)			char _item;
 
@@ -559,6 +587,15 @@ __end_field_##_item##_1:						\
 	goto __assign_##_item##_2;					\
 __end_field_##_item##_2:
 
+#undef __dynamic_array_enc_ext_2
+#define __dynamic_array_enc_ext_2(_type, _item, _length1, _length2, _order, _base, _encoding)\
+	goto __assign_##_item##_1;					\
+__end_field_##_item##_1:						\
+	goto __assign_##_item##_2;					\
+__end_field_##_item##_2:						\
+	goto __assign_##_item##_3;					\
+__end_field_##_item##_3:
+
 #undef __string
 #define __string(_item, _src)						\
 	goto __assign_##_item;						\
@@ -616,10 +653,34 @@ __assign_##dest##_2:							\
 		sizeof(__typemap.dest) * __get_dynamic_array_len(dest));\
 	goto __end_field_##dest##_2;
 
+#undef tp_memcpy_dyn_gen_2
+#define tp_memcpy_dyn_gen_2(write_ops, dest, src1, src2)		\
+__assign_##dest##_1:							\
+	{								\
+		u32 __tmpl = __dynamic_len[__dynamic_len_idx]		\
+			+ __dynamic_len[__dynamic_len_idx + 1];		\
+		lib_ring_buffer_align_ctx(&__ctx, lttng_alignof(u32));	\
+		__chan->ops->event_write(&__ctx, &__tmpl, sizeof(u32));	\
+	}								\
+	goto __end_field_##dest##_1;					\
+__assign_##dest##_2:							\
+	lib_ring_buffer_align_ctx(&__ctx, lttng_alignof(__typemap.dest));	\
+	__chan->ops->write_ops(&__ctx, src1,				\
+		sizeof(__typemap.dest) * __get_dynamic_array_len(dest));\
+	goto __end_field_##dest##_2;					\
+__assign_##dest##_3:							\
+	__chan->ops->write_ops(&__ctx, src2,				\
+		sizeof(__typemap.dest) * __get_dynamic_array_len(dest));\
+	goto __end_field_##dest##_3;
+
 #undef tp_memcpy_dyn
 #define tp_memcpy_dyn(dest, src)					\
 	tp_memcpy_dyn_gen(event_write, dest, src)
 
+#undef tp_memcpy_dyn_2
+#define tp_memcpy_dyn_2(dest, src1, src2)				\
+	tp_memcpy_dyn_gen_2(event_write, dest, src1, src2)
+
 #undef tp_memcpy_dyn_from_user
 #define tp_memcpy_dyn_from_user(dest, src)				\
 	tp_memcpy_dyn_gen(event_write_from_user, dest, src)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
