From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Typo: occured -> occurred
Date: Fri, 18 Oct 2019 17:40:06 -0400
Message-ID: <20191018214006.6126-1-mjeanson__3694.59403898276$1571434860$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46vzwM1GRSzpfL
 for <lttng-dev@lists.lttng.org>; Fri, 18 Oct 2019 17:40:18 -0400 (EDT)
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

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 include/lttng/session.h                  | 2 +-
 src/bin/lttng-sessiond/cmd.c             | 2 +-
 src/bin/lttng-sessiond/rotation-thread.c | 4 ++--
 src/bin/lttng-sessiond/session.c         | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/lttng/session.h b/include/lttng/session.h
index 7e328b625..9b2d7eb41 100644
--- a/include/lttng/session.h
+++ b/include/lttng/session.h
@@ -163,7 +163,7 @@ extern int lttng_destroy_session(const char *name);
  * an lttng_destruction_handle which can be used to wait for the completion
  * of the session's destruction. The lttng_destroy_handle can also be used
  * obtain the status and archive location of any implicit session
- * rotation that may have occured during the session's destruction.
+ * rotation that may have occurred during the session's destruction.
  *
  * Returns LTTNG_OK on success. The returned handle is owned by the caller
  * and must be free'd using lttng_destruction_handle_destroy().
diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index 71c0789b3..a164cffc0 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -4983,7 +4983,7 @@ int cmd_rotate_get_info(struct ltt_session *session,
 
 	switch (rotation_state) {
 	case LTTNG_ROTATION_STATE_NO_ROTATION:
-		DBG("Reporting that no rotation has occured within the lifetime of session \"%s\"",
+		DBG("Reporting that no rotation has occurred within the lifetime of session \"%s\"",
 				session->name);
 		goto end;
 	case LTTNG_ROTATION_STATE_EXPIRED:
diff --git a/src/bin/lttng-sessiond/rotation-thread.c b/src/bin/lttng-sessiond/rotation-thread.c
index d12bd9d01..791b0425f 100644
--- a/src/bin/lttng-sessiond/rotation-thread.c
+++ b/src/bin/lttng-sessiond/rotation-thread.c
@@ -385,7 +385,7 @@ void check_session_rotation_pending_on_consumers(struct ltt_session *session,
 				&exists_status);
 		if (ret) {
 			pthread_mutex_unlock(socket->lock);
-			ERR("Error occured while checking rotation status on consumer daemon");
+			ERR("Error occurred while checking rotation status on consumer daemon");
 			goto end;
 		}
 
@@ -414,7 +414,7 @@ skip_ust:
 				&exists_status);
 		if (ret) {
 			pthread_mutex_unlock(socket->lock);
-			ERR("Error occured while checking rotation status on consumer daemon");
+			ERR("Error occurred while checking rotation status on consumer daemon");
 			goto end;
 		}
 
diff --git a/src/bin/lttng-sessiond/session.c b/src/bin/lttng-sessiond/session.c
index 7fd4332ec..383c6fde7 100644
--- a/src/bin/lttng-sessiond/session.c
+++ b/src/bin/lttng-sessiond/session.c
@@ -1163,7 +1163,7 @@ int session_access_ok(struct ltt_session *session, uid_t uid, gid_t gid)
  *
  * Be careful of the result passed to this function. For instance,
  * on failure to launch a rotation, a client will expect the rotation
- * state to be set to "NO_ROTATION". If an error occured while the
+ * state to be set to "NO_ROTATION". If an error occurred while the
  * rotation was "ONGOING", result should be set to "ERROR", which will
  * allow a client to report it.
  *
-- 
2.17.1
