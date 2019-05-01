From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools v2 18/20] Add serdes functions
 for lttng_snapshot_output
Date: Wed,  1 May 2019 15:34:42 -0400
Message-ID: <20190501193444.17403-19-ylamarre__19589.1467666783$1556739701$gmane$org@efficios.com>
References: <20190501193444.17403-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44vTB85N5Qz1Kcd
 for <lttng-dev@lists.lttng.org>; Wed,  1 May 2019 15:34:56 -0400 (EDT)
In-Reply-To: <20190501193444.17403-1-ylamarre@efficios.com>
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

Since those structs are only transferred across unix sockets, endianness
is kept in host order.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
1) Fixed spelling errors
2) Added missing asserts

 include/lttng/snapshot-internal.h        |  3 +++
 src/common/sessiond-comm/sessiond-comm.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/lttng/snapshot-internal.h b/include/lttng/snapshot-internal.h
index 9bde25fb..2280cb85 100644
--- a/include/lttng/snapshot-internal.h
+++ b/include/lttng/snapshot-internal.h
@@ -74,4 +74,7 @@ struct lttng_snapshot_output_list {
 	struct lttng_snapshot_output *array;
 };
 
+int lttng_snapshot_output_serialize(struct lttng_snapshot_output_serialized *dst, const struct lttng_snapshot_output *src);
+int lttng_snapshot_output_deserialize(struct lttng_snapshot_output *dst, const struct lttng_snapshot_output_serialized *src);
+
 #endif /* LTTNG_SNAPSHOT_INTERNAL_ABI_H */
diff --git a/src/common/sessiond-comm/sessiond-comm.c b/src/common/sessiond-comm/sessiond-comm.c
index 01e564af..1397e8ac 100644
--- a/src/common/sessiond-comm/sessiond-comm.c
+++ b/src/common/sessiond-comm/sessiond-comm.c
@@ -77,6 +77,36 @@ static const char *lttcomm_readable_code[] = {
 static unsigned long network_timeout;
 
 LTTNG_HIDDEN
+int lttng_snapshot_output_serialize(struct lttng_snapshot_output_serialized *dst,
+		const struct lttng_snapshot_output *src)
+{
+	assert(src && dst);
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
+	assert(src && dst);
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
