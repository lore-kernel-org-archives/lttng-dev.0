From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 2/5] Refactor: Move set session path
 to own function
Date: Fri, 25 Oct 2019 18:12:01 -0400
Message-ID: <20191025221204.29696-2-jonathan.rajotte-julien__16019.0169861139$1572041608$gmane$org@efficios.com>
References: <20191025221204.29696-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 470JHx6pswz1PXc
 for <lttng-dev@lists.lttng.org>; Fri, 25 Oct 2019 18:12:13 -0400 (EDT)
In-Reply-To: <20191025221204.29696-1-jonathan.rajotte-julien@efficios.com>
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---

Feel free to squash this into the previous commit.

---
 src/bin/lttng-sessiond/cmd.c | 64 +++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index 1dec61ea1..3ee390698 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -2739,6 +2739,42 @@ error:
 	return ret;
 }
 
+/*
+ * Set the base_path of the session only if subdir of a control uris is set.
+ * Return LTTNG_OK on success, otherwise LTTNG_ERR_*.
+ */
+static int set_session_base_path_from_uris(struct ltt_session *session,
+		size_t nb_uri,
+		struct lttng_uri *uris)
+{
+	int ret;
+	for (int i = 0; i < nb_uri; i++) {
+		if (uris[i].stype != LTTNG_STREAM_CONTROL ||
+				uris[i].subdir[0] == '\0') {
+			/* Not interested in these URIs */
+			continue;
+		}
+
+		if (session->base_path != NULL) {
+			free(session->base_path);
+			session->base_path = NULL;
+		}
+
+		/* Set session base_path */
+		session->base_path = strdup(uris[i].subdir);
+		if (!session->base_path) {
+			PERROR("Copying base path: %s", uris[i].subdir);
+			ret = LTTNG_ERR_NOMEM;
+			goto error;
+		}
+		DBG2("Setting base path for session %" PRIu64 ": %s",
+				session->id, session->base_path);
+	}
+	ret = LTTNG_OK;
+error:
+	return ret;
+}
+
 /*
  * Command LTTNG_SET_CONSUMER_URI processed by the client thread.
  */
@@ -2759,26 +2795,14 @@ int cmd_set_consumer_uri(struct ltt_session *session, size_t nb_uri,
 		goto error;
 	}
 
-	for (i = 0; i < nb_uri; i++) {
-		if (uris[i].stype != LTTNG_STREAM_CONTROL ||
-				uris[i].subdir[0] == '\0') {
-			/* Not interested in these URIs */
-			continue;
-		}
-
-		if (session->base_path != NULL) {
-			free(session->base_path);
-			session->base_path = NULL;
-		}
-
-		/* Set session base_path */
-		session->base_path = strdup(uris[i].subdir);
-		if (!session->base_path) {
-			PERROR("Copying base path: %s", uris[i].subdir);
-			goto error;
-		}
-		DBG2("Setting base path for session %" PRIu64 ": %s",
-				session->id, session->base_path);
+	/*
+	 * Set the session base path if any. This is done inside
+	 * cmd_set_consumer_uri to preserve backward compatibility of the
+	 * previous session creation api vs the session descriptor api.
+	 */
+	ret = set_session_base_path_from_uris(session, nb_uri, uris);
+	if (ret != LTTNG_OK) {
+		goto error;
 	}
 
 	/* Set the "global" consumer URIs */
-- 
2.17.1
