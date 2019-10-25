From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: initialize sessions pointer to
 NULL
Date: Fri, 25 Oct 2019 17:56:26 -0400
Message-ID: <20191025215626.19148-1-jonathan.rajotte-julien__46770.7557416119$1572040642$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 470Hxr64Ntz1PW2
 for <lttng-dev@lists.lttng.org>; Fri, 25 Oct 2019 17:56:32 -0400 (EDT)
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

lttng_list_sessions does not set the passed pointer to NULL on empty
return. This lead to deallocation of non-allocated memory (segfault).

For returns of size 0, the value of the passed argument should be
considered "undefined".

Refactor error handling a bit by removing the "error" jump. Always call
free on the sessions object.

Fixes #1205

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng/commands/list.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
index 28166c8be..65d8ea6f5 100644
--- a/src/bin/lttng/commands/list.c
+++ b/src/bin/lttng/commands/list.c
@@ -1825,7 +1825,7 @@ static int list_sessions(const char *session_name)
 	int ret = CMD_SUCCESS;
 	int count, i;
 	unsigned int session_found = 0;
-	struct lttng_session *sessions;
+	struct lttng_session *sessions = NULL;
 
 	count = lttng_list_sessions(&sessions);
 	DBG("Session count %d", count);
@@ -1838,7 +1838,7 @@ static int list_sessions(const char *session_name)
 	if (lttng_opt_mi) {
 		/* Mi */
 		if (session_name == NULL) {
-			/* List all session */
+			/* List all sessions */
 			ret = mi_list_sessions(sessions, count);
 		} else {
 			/* Note : this return an open session element */
@@ -1846,7 +1846,7 @@ static int list_sessions(const char *session_name)
 		}
 		if (ret) {
 			ret = CMD_ERROR;
-			goto error;
+			goto end;
 		}
 	} else {
 		/* Pretty print */
@@ -1893,7 +1893,7 @@ static int list_sessions(const char *session_name)
 		if (!session_found && session_name != NULL) {
 			ERR("Session '%s' not found", session_name);
 			ret = CMD_ERROR;
-			goto error;
+			goto end;
 		}
 
 		if (session_name == NULL) {
@@ -1901,9 +1901,8 @@ static int list_sessions(const char *session_name)
 		}
 	}
 
-error:
-	free(sessions);
 end:
+	free(sessions);
 	return ret;
 }
 
-- 
2.17.1
