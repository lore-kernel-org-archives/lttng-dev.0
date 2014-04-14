From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-ust] Fix: pad strings that are modified
	concurrently with tracing
Date: Mon, 14 Apr 2014 15:24:10 -0400
Message-ID: <1397503450-20699-1-git-send-email-mathieu.desnoyers__45890.4539853849$1397503575$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1WZmUe-0003Rr-C5
 for lttng-dev@lists.lttng.org; Mon, 14 Apr 2014 15:24:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9CD0F34025B
 for <lttng-dev@lists.lttng.org>; Mon, 14 Apr 2014 19:24:32 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Fixes #734

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/lttng/ust-events.h              |    7 ++-
 include/lttng/ust-tracepoint-event.h    |   16 +++++-
 liblttng-ust/lttng-ring-buffer-client.h |    9 +++
 libringbuffer/backend.h                 |   91 +++++++++++++++++++++++++++++++
 libringbuffer/backend_internal.h        |   12 ++++
 5 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/include/lttng/ust-events.h b/include/lttng/ust-events.h
index ac41262..3d47340 100644
--- a/include/lttng/ust-events.h
+++ b/include/lttng/ust-events.h
@@ -433,7 +433,10 @@ struct lttng_channel_ops {
 			unsigned char *uuid,
 			uint32_t chan_id);
 	void (*channel_destroy)(struct lttng_channel *chan);
-	void *_deprecated1;
+	union {
+		void *_deprecated1;
+		unsigned long has_strcpy:1;		/* ABI has strcpy */
+	} u;
 	void *_deprecated2;
 	int (*event_reserve)(struct lttng_ust_lib_ring_buffer_ctx *ctx,
 			     uint32_t event_id);
@@ -452,6 +455,8 @@ struct lttng_channel_ops {
 	int (*is_finalized)(struct channel *chan);
 	int (*is_disabled)(struct channel *chan);
 	int (*flush_buffer)(struct channel *chan, struct lttng_ust_shm_handle *handle);
+	void (*event_strcpy)(struct lttng_ust_lib_ring_buffer_ctx *ctx,
+			const char *src, size_t len);
 };
 
 /*
diff --git a/include/lttng/ust-tracepoint-event.h b/include/lttng/ust-tracepoint-event.h
index 8140b9d..d12e8bb 100644
--- a/include/lttng/ust-tracepoint-event.h
+++ b/include/lttng/ust-tracepoint-event.h
@@ -520,10 +520,24 @@ size_t __event_get_align__##_provider##___##_name(_TP_ARGS_PROTO(_args))      \
 	__chan->ops->event_write(&__ctx, _src,				\
 		sizeof(_type) * __get_dynamic_len(dest));
 
+/*
+ * __chan->ops->u.has_strcpy is a flag letting us know if the LTTng-UST
+ * tracepoint provider ABI implements event_strcpy. This dynamic check
+ * can be removed when the tracepoint provider ABI moves to 2.
+ */
+#if (LTTNG_UST_PROVIDER_MAJOR > 1)
+#error "Tracepoint probe provider major version has changed. Please remove dynamic check for has_strcpy."
+#endif
+
 #undef _ctf_string
 #define _ctf_string(_item, _src, _nowrite)			        \
 	lib_ring_buffer_align_ctx(&__ctx, lttng_alignof(*(_src)));	\
-	__chan->ops->event_write(&__ctx, _src, __get_dynamic_len(dest));
+	if (__chan->ops->u.has_strcpy)					\
+		__chan->ops->event_strcpy(&__ctx, _src,			\
+			__get_dynamic_len(dest));			\
+	else								\
+		__chan->ops->event_write(&__ctx, _src,			\
+			__get_dynamic_len(dest));
 
 /* Beware: this get len actually consumes the len value */
 #undef __get_dynamic_len
diff --git a/liblttng-ust/lttng-ring-buffer-client.h b/liblttng-ust/lttng-ring-buffer-client.h
index 87d1a8c..e734632 100644
--- a/liblttng-ust/lttng-ring-buffer-client.h
+++ b/liblttng-ust/lttng-ring-buffer-client.h
@@ -601,6 +601,13 @@ void lttng_event_write(struct lttng_ust_lib_ring_buffer_ctx *ctx, const void *sr
 	lib_ring_buffer_write(&client_config, ctx, src, len);
 }
 
+static
+void lttng_event_strcpy(struct lttng_ust_lib_ring_buffer_ctx *ctx, const char *src,
+		     size_t len)
+{
+	lib_ring_buffer_strcpy(&client_config, ctx, src, len, '#');
+}
+
 #if 0
 static
 wait_queue_head_t *lttng_get_reader_wait_queue(struct channel *chan)
@@ -651,6 +658,7 @@ static struct lttng_transport lttng_relay_transport = {
 	.ops = {
 		.channel_create = _channel_create,
 		.channel_destroy = lttng_channel_destroy,
+		.u.has_strcpy = 1,
 		.event_reserve = lttng_event_reserve,
 		.event_commit = lttng_event_commit,
 		.event_write = lttng_event_write,
@@ -660,6 +668,7 @@ static struct lttng_transport lttng_relay_transport = {
 		.is_finalized = lttng_is_finalized,
 		.is_disabled = lttng_is_disabled,
 		.flush_buffer = lttng_flush_buffer,
+		.event_strcpy = lttng_event_strcpy,
 	},
 	.client_config = &client_config,
 };
diff --git a/libringbuffer/backend.h b/libringbuffer/backend.h
index feefc7a..e7aa0ef 100644
--- a/libringbuffer/backend.h
+++ b/libringbuffer/backend.h
@@ -106,6 +106,97 @@ void lib_ring_buffer_write(const struct lttng_ust_lib_ring_buffer_config *config
 }
 
 /*
+ * Copy up to @len string bytes from @src to @dest. Stop whenever a NULL
+ * terminating character is found in @src. Returns the number of bytes
+ * copied. Does *not* terminate @dest with NULL terminating character.
+ */
+static inline
+size_t lib_ring_buffer_do_strcpy(const struct lttng_ust_lib_ring_buffer_config *config,
+		char *dest, const char *src, size_t len)
+{
+	size_t count = 0;
+
+	for (;;) {
+		char c;
+
+		/*
+		 * Only read source character once, in case it is
+		 * modified concurrently.
+		 */
+		c = CMM_LOAD_SHARED(src[count]);
+		if (!c || count >= len)
+			break;
+		lib_ring_buffer_do_copy(config, &dest[count], &c, 1);
+		count++;
+	}
+	return count;
+}
+
+/**
+ * lib_ring_buffer_strcpy - write string data to a buffer backend
+ * @config : ring buffer instance configuration
+ * @ctx: ring buffer context. (input arguments only)
+ * @src : source pointer to copy from
+ * @len : length of data to copy
+ * @pad : character to use for padding
+ *
+ * This function copies @len - 1 bytes of string data from a source
+ * pointer to a buffer backend, followed by a terminating '\0'
+ * character, at the current context offset. This is more or less a
+ * buffer backend-specific strncpy() operation. If a terminating '\0'
+ * character is found in @src before @len - 1 characters are copied, pad
+ * the buffer with @pad characters (e.g. '#').
+ */
+static inline
+void lib_ring_buffer_strcpy(const struct lttng_ust_lib_ring_buffer_config *config,
+			   struct lttng_ust_lib_ring_buffer_ctx *ctx,
+			   const char *src, size_t len, int pad)
+{
+	struct lttng_ust_lib_ring_buffer_backend *bufb = &ctx->buf->backend;
+	struct channel_backend *chanb = &ctx->chan->backend;
+	struct lttng_ust_shm_handle *handle = ctx->handle;
+	size_t sbidx, count;
+	size_t offset = ctx->buf_offset;
+	struct lttng_ust_lib_ring_buffer_backend_pages_shmp *rpages;
+	unsigned long sb_bindex, id;
+
+	if (caa_unlikely(!len))
+		return;
+	offset &= chanb->buf_size - 1;
+	sbidx = offset >> chanb->subbuf_size_order;
+	id = shmp_index(handle, bufb->buf_wsb, sbidx)->id;
+	sb_bindex = subbuffer_id_get_index(config, id);
+	rpages = shmp_index(handle, bufb->array, sb_bindex);
+	CHAN_WARN_ON(ctx->chan,
+		     config->mode == RING_BUFFER_OVERWRITE
+		     && subbuffer_id_is_noref(config, id));
+	/*
+	 * Underlying layer should never ask for writes across
+	 * subbuffers.
+	 */
+	CHAN_WARN_ON(chanb, offset >= chanb->buf_size);
+	count = lib_ring_buffer_do_strcpy(config,
+			shmp_index(handle, shmp(handle, rpages->shmp)->p,
+				offset & (chanb->subbuf_size - 1)),
+			src, len - 1);
+	offset += count;
+	/* Padding */
+	if (caa_unlikely(count < len - 1)) {
+		size_t pad_len = len - 1 - count;
+
+		lib_ring_buffer_do_memset(shmp_index(handle, shmp(handle, rpages->shmp)->p,
+				offset & (chanb->subbuf_size - 1)),
+			pad, pad_len);
+		offset += pad_len;
+	}
+	/* Final '\0' */
+	lib_ring_buffer_do_memset(shmp_index(handle, shmp(handle, rpages->shmp)->p,
+				offset & (chanb->subbuf_size - 1)),
+			'\0', 1);
+	ctx->buf_offset += len;
+}
+
+/*
  * This accessor counts the number of unread records in a buffer.
  * It only provides a consistent value if no reads not writes are performed
  * concurrently.
diff --git a/libringbuffer/backend_internal.h b/libringbuffer/backend_internal.h
index 3ab60a7..1045a60 100644
--- a/libringbuffer/backend_internal.h
+++ b/libringbuffer/backend_internal.h
@@ -447,6 +447,18 @@ do {								\
 		inline_memcpy(dest, src, __len);		\
 } while (0)
 
+/*
+ * write len bytes to dest with c
+ */
+static inline
+void lib_ring_buffer_do_memset(char *dest, int c, unsigned long len)
+{
+	unsigned long i;
+
+	for (i = 0; i < len; i++)
+		dest[i] = c;
+}
+
 /* arch-agnostic implementation */
 
 static inline int lttng_ust_fls(unsigned int x)
-- 
1.7.10.4
