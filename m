From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools 17/18] Add serdes functions for
 lttng_snapshot_output
Date: Thu, 18 Apr 2019 12:18:49 -0400
Message-ID: <20190418161850.1536-18-ylamarre__27079.6446407743$1555604721$gmane$org@efficios.com>
References: <20190418161850.1536-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44lPS6301rz1Jp6
 for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2019 12:19:02 -0400 (EDT)
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
 include/lttng/snapshot-internal.h        |  3 +++
 src/common/sessiond-comm/sessiond-comm.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/lttng/snapshot-internal.h b/include/lttng/snapshot-internal.h
index bf9dfbe4..b269607d 100644
--- a/include/lttng/snapshot-internal.h
+++ b/include/lttng/snapshot-internal.h
@@ -73,4 +73,7 @@ struct lttng_snapshot_output_list {
 	struct lttng_snapshot_output *array;
 };
 
+int lttng_snapshot_output_serialize(struct lttng_snapshot_output_serialized *dst, const struct lttng_snapshot_output *src);
+int lttng_snapshot_output_deserialize(struct lttng_snapshot_output *dst, const struct lttng_snapshot_output_serialized *src);
+
 #endif /* LTTNG_SNAPSHOT_INTERNAL_ABI_H */
diff --git a/src/common/sessiond-comm/sessiond-comm.c b/src/common/sessiond-comm/sessiond-comm.c
index d71abe0c..863054d0 100644
--- a/src/common/sessiond-comm/sessiond-comm.c
+++ b/src/common/sessiond-comm/sessiond-comm.c
@@ -77,6 +77,34 @@ static const char *lttcomm_readable_code[] = {
 static unsigned long network_timeout;
 
 LTTNG_HIDDEN
+int lttng_snapshot_output_serialize(struct lttng_snapshot_output_serialized *dst,
+		const struct lttng_snapshot_output *src)
+{
+	dst->id = src->id;
+	dst->max_size = src->max_size;
+
+	memcpy(dst->name, src->name, LTTNG_NAME_MAX);
+	memcpy(dst->ctrl_url, src->ctrl_url, PATH_MAX);
+	memcpy(dst->data_url, src->data_url, PATH_MAX);
+
+	return 0;
+}
+
+LTTNG_HIDDEN
+int lttng_snapshot_output_deserialize(struct lttng_snapshot_output *dst,
+		const struct lttng_snapshot_output_serialized *src)
+{
+	dst->id = src->id;
+	dst->max_size = src->max_size;
+
+	memcpy(dst->name, src->name, LTTNG_NAME_MAX);
+	memcpy(dst->ctrl_url, src->ctrl_url, PATH_MAX);
+	memcpy(dst->data_url, src->data_url, PATH_MAX);
+
+	return 0;
+}
+
+LTTNG_HIDDEN
 int lttng_event_common_serialize(struct lttng_event_serialized *dst,
 		const struct lttng_event *src)
 {
-- 
2.11.0
