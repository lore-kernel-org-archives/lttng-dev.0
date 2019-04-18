From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools 08/18] Add serdes functions for
 lttng_channel
Date: Thu, 18 Apr 2019 12:18:40 -0400
Message-ID: <20190418161850.1536-9-ylamarre__16243.6928645306$1555604879$gmane$org@efficios.com>
References: <20190418161850.1536-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44lPSD0HF8z1JrX
 for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2019 12:19:07 -0400 (EDT)
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
 include/lttng/channel-internal.h         |   5 ++
 src/common/sessiond-comm/sessiond-comm.c | 105 +++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/include/lttng/channel-internal.h b/include/lttng/channel-internal.h
index c956c19d..db963f13 100644
--- a/include/lttng/channel-internal.h
+++ b/include/lttng/channel-internal.h
@@ -57,4 +57,9 @@ struct lttng_channel_extended_serialized {
 	int64_t blocking_timeout;
 } LTTNG_PACKED;
 
+int lttng_channel_serialize(struct lttng_channel_serialized *dst, const struct lttng_channel *src);
+int lttng_channel_deserialize(struct lttng_channel *dst, const struct lttng_channel_serialized *src);
+int lttng_channel_extended_deserialize(struct lttng_channel_extended *dst, const struct lttng_channel_extended_serialized *src);
+int lttng_channel_extended_serialize(struct lttng_channel_extended_serialized *dst, const struct lttng_channel_extended *src);
+int init_serialized_extended_channel(struct lttng_domain *domain, struct lttng_channel_extended_serialized *extended);
 #endif /* LTTNG_CHANNEL_INTERNAL_H */
diff --git a/src/common/sessiond-comm/sessiond-comm.c b/src/common/sessiond-comm/sessiond-comm.c
index 8aee3cd1..6dc58739 100644
--- a/src/common/sessiond-comm/sessiond-comm.c
+++ b/src/common/sessiond-comm/sessiond-comm.c
@@ -76,6 +76,111 @@ static const char *lttcomm_readable_code[] = {
 
 static unsigned long network_timeout;
 
+int init_serialized_extended_channel(struct lttng_domain *domain, struct
+		lttng_channel_extended_serialized *extended)
+{
+	assert(domain && extended);
+	switch (domain->type) {
+	case LTTNG_DOMAIN_KERNEL:
+		extended->monitor_timer_interval =
+			DEFAULT_KERNEL_CHANNEL_MONITOR_TIMER;
+		extended->blocking_timeout =
+			DEFAULT_KERNEL_CHANNEL_BLOCKING_TIMEOUT;
+		break;
+	case LTTNG_DOMAIN_UST:
+		switch (domain->buf_type) {
+		case LTTNG_BUFFER_PER_UID:
+			extended->monitor_timer_interval =
+				DEFAULT_UST_UID_CHANNEL_MONITOR_TIMER;
+			extended->blocking_timeout =
+				DEFAULT_UST_UID_CHANNEL_BLOCKING_TIMEOUT;
+			break;
+		case LTTNG_BUFFER_PER_PID:
+		default:
+			extended->monitor_timer_interval =
+				DEFAULT_UST_PID_CHANNEL_MONITOR_TIMER;
+			extended->blocking_timeout =
+				DEFAULT_UST_PID_CHANNEL_BLOCKING_TIMEOUT;
+			break;
+		}
+	default:
+		/* Default behavior: leave set to 0. */
+		break;
+	}
+
+	return 0;
+}
+
+LTTNG_HIDDEN
+int lttng_channel_extended_serialize(struct lttng_channel_extended_serialized *dst,
+		const struct lttng_channel_extended *src)
+{
+	assert(src && dst);
+	dst->discarded_events = src->discarded_events;
+	dst->lost_packets = src->lost_packets;
+	dst->monitor_timer_interval = src->monitor_timer_interval;
+	dst->blocking_timeout = src->blocking_timeout;
+	return 0;
+}
+
+LTTNG_HIDDEN
+int lttng_channel_extended_deserialize(struct lttng_channel_extended *dst,
+		const struct lttng_channel_extended_serialized *src)
+{
+	assert(src && dst);
+	dst->discarded_events = src->discarded_events;
+	dst->lost_packets = src->lost_packets;
+	dst->monitor_timer_interval = src->monitor_timer_interval;
+	dst->blocking_timeout = src->blocking_timeout;
+	return 0;
+}
+
+LTTNG_HIDDEN
+int lttng_channel_serialize(struct lttng_channel_serialized *dst,
+		const struct lttng_channel *src)
+{
+	assert(src && dst);
+	struct lttng_channel_attr_serialized *dst_attr = &dst->attr;
+	const struct lttng_channel_attr *src_attr = &src->attr;
+
+	dst_attr->overwrite = src_attr->overwrite;
+	dst_attr->subbuf_size = src_attr->subbuf_size;
+	dst_attr->num_subbuf = src_attr->num_subbuf;
+	dst_attr->switch_timer_interval = src_attr->switch_timer_interval;
+	dst_attr->read_timer_interval = src_attr->read_timer_interval;
+	dst_attr->output = (uint32_t) src_attr->output;
+	dst_attr->tracefile_size = src_attr->tracefile_size;
+	dst_attr->tracefile_count = src_attr->tracefile_count;
+	dst_attr->live_timer_interval = src_attr->live_timer_interval;
+
+	dst->enabled = src->enabled;
+	memcpy(dst->name, src->name, sizeof(dst->name));
+	return 0;
+}
+
+LTTNG_HIDDEN
+int lttng_channel_deserialize(struct lttng_channel *dst,
+		const struct lttng_channel_serialized *src)
+{
+	assert(src && dst);
+	struct lttng_channel_attr *dst_attr = &dst->attr;
+	const struct lttng_channel_attr_serialized *src_attr = &src->attr;
+
+	dst_attr->overwrite = src_attr->overwrite;
+	dst_attr->subbuf_size = src_attr->subbuf_size;
+	dst_attr->num_subbuf = src_attr->num_subbuf;
+	dst_attr->switch_timer_interval = src_attr->switch_timer_interval;
+	dst_attr->read_timer_interval = src_attr->read_timer_interval;
+	dst_attr->output = (enum lttng_event_output) src_attr->output;
+	dst_attr->tracefile_size = src_attr->tracefile_size;
+	dst_attr->tracefile_count = src_attr->tracefile_count;
+	dst_attr->live_timer_interval = src_attr->live_timer_interval;
+
+	dst->enabled = src->enabled;
+	memcpy(dst->name, src->name, sizeof(dst->name));
+	return 0;
+}
+
 LTTNG_HIDDEN
 int sockaddr_in_serialize(struct sockaddr_in_serialized *dst,
 		const struct sockaddr_in *src)
-- 
2.11.0
