From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools 11/18] Add serdes functions for
 lttng_event_context
Date: Thu, 18 Apr 2019 12:18:43 -0400
Message-ID: <20190418161850.1536-12-ylamarre__3494.00924039713$1555604568$gmane$org@efficios.com>
References: <20190418161850.1536-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44lPS46KrGz1Jmm
 for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2019 12:19:00 -0400 (EDT)
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
 src/common/sessiond-comm/sessiond-comm.c | 42 ++++++++++++++++++++++++++++++++
 src/common/sessiond-comm/sessiond-comm.h |  1 +
 2 files changed, 43 insertions(+)

diff --git a/src/common/sessiond-comm/sessiond-comm.c b/src/common/sessiond-comm/sessiond-comm.c
index 6dc58739..84beb90d 100644
--- a/src/common/sessiond-comm/sessiond-comm.c
+++ b/src/common/sessiond-comm/sessiond-comm.c
@@ -76,6 +76,48 @@ static const char *lttcomm_readable_code[] = {
 
 static unsigned long network_timeout;
 
+LTTNG_HIDDEN
+int lttng_event_perf_counter_ctx_serialize(struct lttng_event_perf_counter_ctx_serialized *dst,
+		const struct lttng_event_perf_counter_ctx *src)
+{
+	assert(src && dst);
+	dst->type = src->type;
+	dst->config = src->config;
+	memcpy(&dst->name, &src->name, LTTNG_SYMBOL_NAME_LEN);
+	return 0;
+}
+
+LTTNG_HIDDEN
+int lttng_event_perf_counter_ctx_deserialize(struct lttng_event_perf_counter_ctx *dst,
+		const struct lttng_event_perf_counter_ctx_serialized *src)
+{
+	assert(src && dst);
+	dst->type = src->type;
+	dst->config = src->config;
+	memcpy(&dst->name, &src->name, LTTNG_SYMBOL_NAME_LEN);
+	return 0;
+}
+
+LTTNG_HIDDEN
+int lttng_event_context_serialize(struct lttng_event_context_serialized *dst,
+		const struct lttng_event_context *src)
+{
+	assert(src && dst);
+	dst->ctx = (uint32_t) src->ctx;
+	lttng_event_perf_counter_ctx_serialize(&dst->perf_counter, &src->u.perf_counter);
+	return 0;
+}
+
+LTTNG_HIDDEN
+int lttng_event_context_deserialize(struct lttng_event_context *dst,
+		const struct lttng_event_context_serialized *src)
+{
+	assert(src && dst);
+	dst->ctx = (enum lttng_event_context_type) src->ctx;
+	lttng_event_perf_counter_ctx_deserialize(&dst->u.perf_counter, &src->perf_counter);
+	return 0;
+}
+
 int init_serialized_extended_channel(struct lttng_domain *domain, struct
 		lttng_channel_extended_serialized *extended)
 {
diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index d0905f9e..2760af3a 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -31,6 +31,7 @@
 #include <lttng/snapshot-internal.h>
 #include <lttng/save-internal.h>
 #include <lttng/channel-internal.h>
+#include <lttng/event-internal.h>
 #include <lttng/trigger/trigger-internal.h>
 #include <lttng/rotate-internal.h>
 #include <common/compat/socket.h>
-- 
2.11.0
