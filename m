From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix: Invalid free on
	session_name when destroying session
Date: Wed, 15 Aug 2012 12:39:30 -0400
Message-ID: <1345048771-18936-1-git-send-email-christian.babeux__1352.05611954934$1345048828$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-gg0-f176.google.com ([209.85.161.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1T1gdG-00013G-7b
	for lttng-dev@lists.lttng.org; Wed, 15 Aug 2012 12:39:46 -0400
Received: by ggke5 with SMTP id e5so2479863ggk.35
	for <lttng-dev@lists.lttng.org>; Wed, 15 Aug 2012 09:39:40 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The session_name should not be free(3) if the user has specified
a session name on the command line. Also, the caller is responsible to
free the allocated string when calling get_session_name().
Handle both cases gracefully.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 src/bin/lttng/commands/destroy.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/src/bin/lttng/commands/destroy.c b/src/bin/lttng/commands/destroy.c
index 5b69cb5..7b7ea0e 100644
--- a/src/bin/lttng/commands/destroy.c
+++ b/src/bin/lttng/commands/destroy.c
@@ -28,6 +28,7 @@
 
 #include <common/sessiond-comm/sessiond-comm.h>
 
+static char *opt_session_name;
 static int opt_destroy_all;
 
 enum {
@@ -156,28 +157,32 @@ int cmd_destroy(int argc, const char **argv)
 		goto end;
 	}
 
-	session_name = (char *) poptGetArg(pc);
-
-	/*
-	 * ignore session name in case all
-	 * sessions are to be destroyed
-	 */
+	/* Ignore session name in case all sessions are to be destroyed */
 	if (opt_destroy_all) {
 		ret = destroy_all_sessions();
 		goto end;
 	}
-	if (session_name == NULL) {
-		ret = get_default_session_name(&session_name);
-		if (ret < 0 || session_name == NULL) {
+
+	opt_session_name = (char *) poptGetArg(pc);
+
+	if (opt_session_name == NULL) {
+		/* No session name specified, lookup default */
+		session_name = get_session_name();
+		if (session_name == NULL) {
+			ret = CMD_ERROR;
 			goto end;
 		}
+	} else {
+		session_name = opt_session_name;
 	}
+
 	ret = destroy_session(session_name);
 
 end:
-	poptFreeContext(pc);
-	if (session_name != NULL) {
+	if (opt_session_name == NULL) {
 		free(session_name);
 	}
+
+	poptFreeContext(pc);
 	return ret;
 }
-- 
1.7.11.4
