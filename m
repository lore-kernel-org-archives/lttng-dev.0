From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools v2 19/20] Integrate serialized
 communication for lttng_snapshot_output
Date: Wed,  1 May 2019 15:34:43 -0400
Message-ID: <20190501193444.17403-20-ylamarre__6994.97802868194$1556739727$gmane$org@efficios.com>
References: <20190501193444.17403-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44vTB90LRGz1Kcg
 for <lttng-dev@lists.lttng.org>; Wed,  1 May 2019 15:34:57 -0400 (EDT)
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

lttng-ctl and lttng-sessiond use serialized communication for
messages using lttng_snapshot_output.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
1) Reworded commit title
2) Fixed spelling error in structure name
3) Fixed coding style issue with index declaration
4) Changed index type to more appropriate size_t
5) Added intermediary variable to avoid dereferencing of pointer more than once

 src/bin/lttng-sessiond/client.c          | 28 +++++++++++++++++++++++-----
 src/common/sessiond-comm/sessiond-comm.h |  4 ++--
 src/lib/lttng-ctl/snapshot.c             | 26 ++++++++++++++++++--------
 3 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/src/bin/lttng-sessiond/client.c b/src/bin/lttng-sessiond/client.c
index 3fb69cd9..94293b58 100644
--- a/src/bin/lttng-sessiond/client.c
+++ b/src/bin/lttng-sessiond/client.c
@@ -1738,9 +1738,12 @@ error_add_context:
 	case LTTNG_SNAPSHOT_ADD_OUTPUT:
 	{
 		struct lttcomm_lttng_output_id reply;
+		struct lttng_snapshot_output snapshot_output;
+
+		lttng_snapshot_output_deserialize(&snapshot_output, &cmd_ctx->lsm->u.snapshot_output.output);
 
 		ret = cmd_snapshot_add_output(cmd_ctx->session,
-				&cmd_ctx->lsm->u.snapshot_output.output, &reply.id);
+				&snapshot_output, &reply.id);
 		if (ret != LTTNG_OK) {
 			goto error;
 		}
@@ -1757,14 +1760,20 @@ error_add_context:
 	}
 	case LTTNG_SNAPSHOT_DEL_OUTPUT:
 	{
+		struct lttng_snapshot_output snapshot_output;
+
+		lttng_snapshot_output_deserialize(&snapshot_output, &cmd_ctx->lsm->u.snapshot_output.output);
+
 		ret = cmd_snapshot_del_output(cmd_ctx->session,
-				&cmd_ctx->lsm->u.snapshot_output.output);
+				&snapshot_output);
 		break;
 	}
 	case LTTNG_SNAPSHOT_LIST_OUTPUT:
 	{
 		ssize_t nb_output;
+		size_t i;
 		struct lttng_snapshot_output *outputs = NULL;
+		struct lttng_snapshot_output_serialized *serialized_outputs;
 
 		nb_output = cmd_snapshot_list_outputs(cmd_ctx->session, &outputs);
 		if (nb_output < 0) {
@@ -1773,9 +1782,14 @@ error_add_context:
 		}
 
 		assert((nb_output > 0 && outputs) || nb_output == 0);
-		ret = setup_lttng_msg_no_cmd_header(cmd_ctx, outputs,
-				nb_output * sizeof(struct lttng_snapshot_output));
+		serialized_outputs = malloc(sizeof(struct lttng_snapshot_output_serialized) * nb_output);
+		for (i = 0; i < nb_output; i++) {
+			lttng_snapshot_output_serialize(&serialized_outputs[i], &outputs[i]);
+		}
 		free(outputs);
+		ret = setup_lttng_msg_no_cmd_header(cmd_ctx, serialized_outputs,
+				nb_output * sizeof(struct lttng_snapshot_output_serialized));
+		free(serialized_outputs);
 
 		if (ret < 0) {
 			goto setup_error;
@@ -1786,8 +1800,12 @@ error_add_context:
 	}
 	case LTTNG_SNAPSHOT_RECORD:
 	{
+		struct lttng_snapshot_output snapshot_output;
+
+		lttng_snapshot_output_deserialize(&snapshot_output, &cmd_ctx->lsm->u.snapshot_output.output);
+
 		ret = cmd_snapshot_record(cmd_ctx->session,
-				&cmd_ctx->lsm->u.snapshot_record.output,
+				&snapshot_output,
 				cmd_ctx->lsm->u.snapshot_record.wait);
 		break;
 	}
diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index 21535eeb..6f005cc7 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -428,11 +428,11 @@ struct lttcomm_session_msg {
 			uint32_t size;
 		} LTTNG_PACKED uri;
 		struct {
-			struct lttng_snapshot_output output LTTNG_PACKED;
+			struct lttng_snapshot_output_serialized output;
 		} LTTNG_PACKED snapshot_output;
 		struct {
 			uint32_t wait;
-			struct lttng_snapshot_output output LTTNG_PACKED;
+			struct lttng_snapshot_output_serialized output;
 		} LTTNG_PACKED snapshot_record;
 		struct {
 			uint32_t nb_uri;
diff --git a/src/lib/lttng-ctl/snapshot.c b/src/lib/lttng-ctl/snapshot.c
index b30c4706..21a24d7e 100644
--- a/src/lib/lttng-ctl/snapshot.c
+++ b/src/lib/lttng-ctl/snapshot.c
@@ -47,8 +47,7 @@ int lttng_snapshot_add_output(const char *session_name,
 
 	lttng_ctl_copy_string(lsm.session.name, session_name,
 			sizeof(lsm.session.name));
-	memcpy(&lsm.u.snapshot_output.output, output,
-			sizeof(lsm.u.snapshot_output.output));
+	lttng_snapshot_output_serialize(&lsm.u.snapshot_output.output, output);
 
 	ret = lttng_ctl_ask_sessiond(&lsm, (void **) &reply);
 	if (ret < 0) {
@@ -80,8 +79,7 @@ int lttng_snapshot_del_output(const char *session_name,
 
 	lttng_ctl_copy_string(lsm.session.name, session_name,
 			sizeof(lsm.session.name));
-	memcpy(&lsm.u.snapshot_output.output, output,
-			sizeof(lsm.u.snapshot_output.output));
+	lttng_snapshot_output_serialize(&lsm.u.snapshot_output.output, output);
 
 	return lttng_ctl_ask_sessiond(&lsm, NULL);
 }
@@ -97,8 +95,10 @@ int lttng_snapshot_list_output(const char *session_name,
 		struct lttng_snapshot_output_list **list)
 {
 	int ret;
+	size_t i, count;
 	struct lttcomm_session_msg lsm;
 	struct lttng_snapshot_output_list *new_list = NULL;
+	struct lttng_snapshot_output_serialized *serialized_array;
 
 	if (!session_name || !list) {
 		ret = -LTTNG_ERR_INVALID;
@@ -117,12 +117,23 @@ int lttng_snapshot_list_output(const char *session_name,
 		goto error;
 	}
 
-	ret = lttng_ctl_ask_sessiond(&lsm, (void **) &new_list->array);
+	ret = lttng_ctl_ask_sessiond(&lsm, (void **) &serialized_array);
 	if (ret < 0) {
 		goto free_error;
 	}
 
-	new_list->count = ret / sizeof(struct lttng_snapshot_output);
+	count = ret / sizeof(struct lttng_snapshot_output_serialized);
+	new_list->count = count;
+	new_list->array = zmalloc(sizeof(struct lttng_snapshot_output) * count);
+	if (!new_list) {
+		ret = -LTTNG_ERR_NOMEM;
+		goto free_error;
+	}
+	for (i = 0; i < count; i++) {
+		lttng_snapshot_output_deserialize(&new_list->array[i], &serialized_array[i]);
+	}
+	free(serialized_array);
+
 	*list = new_list;
 	return 0;
 
@@ -207,8 +218,7 @@ int lttng_snapshot_record(const char *session_name,
 	 * record.
 	 */
 	if (output) {
-		memcpy(&lsm.u.snapshot_record.output, output,
-				sizeof(lsm.u.snapshot_record.output));
+		lttng_snapshot_output_serialize(&lsm.u.snapshot_record.output, output);
 	}
 
 	/* The wait param is ignored. */
-- 
2.11.0
