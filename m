From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools 14/18] Add serdes functions for
 lttng_event_context
Date: Thu, 18 Apr 2019 12:18:46 -0400
Message-ID: <20190418161850.1536-15-ylamarre__45101.815909014$1555604663$gmane$org@efficios.com>
References: <20190418161850.1536-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44lPS54TwFz1JnR
 for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2019 12:19:01 -0400 (EDT)
In-Reply-To: <20190418161850.1536-1-ylamarre@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Since those structs are only transfered across unix sockets, endianess
is kept in host order.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
 include/lttng/event-internal.h           |   6 ++
 src/common/sessiond-comm/sessiond-comm.c | 116 +++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/include/lttng/event-internal.h b/include/lttng/event-internal.h
index a43007de..ec261af4 100644
--- a/include/lttng/event-internal.h
+++ b/include/lttng/event-internal.h
@@ -95,6 +95,12 @@ struct lttng_event_extended {
 LTTNG_HIDDEN
 struct lttng_event *lttng_event_copy(const struct lttng_event *event);
 
+int lttng_event_probe_attr_serialize(struct lttng_event_serialized *dst, const struct lttng_event *src);
+int lttng_event_function_attr_serialize(struct lttng_event_serialized *dst, const struct lttng_event *src);
+int lttng_event_no_attr_serialize(struct lttng_event_serialized *dst, const struct lttng_event *src);
+int lttng_event_probe_attr_deserialize(struct lttng_event *dst, const struct lttng_event_serialized *src);
+int lttng_event_function_attr_deserialize(struct lttng_event *dst, const struct lttng_event_serialized *src);
+int lttng_event_no_attr_deserialize(struct lttng_event *dst, const struct lttng_event_serialized *src);
 int lttng_event_context_serialize(struct lttng_event_context_serialized *dst, const struct lttng_event_context *src);
 int lttng_event_context_deserialize(struct lttng_event_context *dst, const struct lttng_event_context_serialized *src);
 int lttng_event_perf_counter_ctx_serialize(struct lttng_event_perf_counter_ctx_serialized *dst, const struct lttng_event_perf_counter_ctx *src);
diff --git a/src/common/sessiond-comm/sessiond-comm.c b/src/common/sessiond-comm/sessiond-comm.c
index 84beb90d..d71abe0c 100644
--- a/src/common/sessiond-comm/sessiond-comm.c
+++ b/src/common/sessiond-comm/sessiond-comm.c
@@ -77,6 +77,122 @@ static const char *lttcomm_readable_code[] = {
 static unsigned long network_timeout;
 
 LTTNG_HIDDEN
+int lttng_event_common_serialize(struct lttng_event_serialized *dst,
+		const struct lttng_event *src)
+{
+	dst->type = (uint32_t) src->type;
+
+	memcpy(dst->name, src->name, LTTNG_SYMBOL_NAME_LEN);
+
+	dst->loglevel_type = (uint32_t) src->loglevel_type;
+	dst->loglevel = src->loglevel;
+	dst->enabled = src->enabled;
+	dst->pid = src->pid;
+	dst->filter = src->filter;
+	dst->exclusion = src->exclusion;
+	dst->flags = (uint32_t) src->flags;
+
+	return 0;
+}
+
+LTTNG_HIDDEN
+int lttng_event_common_deserialize(struct lttng_event *dst,
+		const struct lttng_event_serialized *src)
+{
+	dst->type = (enum lttng_event_type) src->type;
+
+	memcpy(dst->name, src->name, LTTNG_SYMBOL_NAME_LEN);
+
+	dst->loglevel_type = (enum lttng_loglevel_type) src->loglevel_type;
+	dst->loglevel = src->loglevel;
+	dst->enabled = src->enabled;
+	dst->pid = src->pid;
+	dst->filter = src->filter;
+	dst->exclusion = src->exclusion;
+	dst->flags = (enum lttng_event_flag) src->flags;
+
+	return 0;
+}
+
+LTTNG_HIDDEN
+int lttng_event_probe_attr_serialize(struct lttng_event_serialized *dst,
+		const struct lttng_event *src)
+{
+	assert(src && dst);
+	lttng_event_common_serialize(dst, src);
+
+	dst->attr.probe.addr = src->attr.probe.addr;
+	dst->attr.probe.offset = src->attr.probe.offset;
+
+	memcpy(dst->attr.probe.symbol_name, src->attr.probe.symbol_name, LTTNG_SYMBOL_NAME_LEN);
+
+	return 0;
+}
+
+LTTNG_HIDDEN
+int lttng_event_probe_attr_deserialize(struct lttng_event *dst,
+		const struct lttng_event_serialized *src)
+{
+	assert(src && dst);
+	lttng_event_common_deserialize(dst, src);
+
+	dst->attr.probe.addr = src->attr.probe.addr;
+	dst->attr.probe.offset = src->attr.probe.offset;
+
+	memcpy(dst->attr.probe.symbol_name, src->attr.probe.symbol_name, LTTNG_SYMBOL_NAME_LEN);
+
+	return 0;
+}
+
+LTTNG_HIDDEN
+int lttng_event_function_attr_serialize(struct lttng_event_serialized *dst,
+		const struct lttng_event *src)
+{
+	assert(src && dst);
+	lttng_event_common_serialize(dst, src);
+
+	memcpy(dst->attr.ftrace.symbol_name, src->attr.ftrace.symbol_name, LTTNG_SYMBOL_NAME_LEN);
+
+	return 0;
+}
+
+LTTNG_HIDDEN
+int lttng_event_function_attr_deserialize(struct lttng_event *dst,
+		const struct lttng_event_serialized *src)
+{
+	assert(src && dst);
+	lttng_event_common_deserialize(dst, src);
+
+	memcpy(dst->attr.ftrace.symbol_name, src->attr.ftrace.symbol_name, LTTNG_SYMBOL_NAME_LEN);
+
+	return 0;
+}
+
+LTTNG_HIDDEN
+int lttng_event_no_attr_serialize(struct lttng_event_serialized *dst,
+		const struct lttng_event *src)
+{
+	assert(src && dst);
+	lttng_event_common_serialize(dst, src);
+
+	memset(&dst->attr, 0, sizeof(dst->attr));
+
+	return 0;
+}
+
+LTTNG_HIDDEN
+int lttng_event_no_attr_deserialize(struct lttng_event *dst,
+		const struct lttng_event_serialized *src)
+{
+	assert(src && dst);
+	lttng_event_common_deserialize(dst, src);
+
+	memset(&dst->attr, 0, sizeof(dst->attr));
+
+	return 0;
+}
+
+LTTNG_HIDDEN
 int lttng_event_perf_counter_ctx_serialize(struct lttng_event_perf_counter_ctx_serialized *dst,
 		const struct lttng_event_perf_counter_ctx *src)
 {
-- 
2.11.0
