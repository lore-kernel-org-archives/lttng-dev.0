From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 2/2] Cleanup: Remove unused
	get_default_session_name() function
Date: Wed, 15 Aug 2012 12:39:31 -0400
Message-ID: <1345048771-18936-2-git-send-email-christian.babeux__34921.4464462877$1345048828$gmane$org@efficios.com>
References: <1345048771-18936-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yx0-f176.google.com ([209.85.213.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1T1gdO-00013T-97
	for lttng-dev@lists.lttng.org; Wed, 15 Aug 2012 12:39:54 -0400
Received: by yenm12 with SMTP id m12so2483460yen.35
	for <lttng-dev@lists.lttng.org>; Wed, 15 Aug 2012 09:39:48 -0700 (PDT)
In-Reply-To: <1345048771-18936-1-git-send-email-christian.babeux@efficios.com>
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


Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 src/bin/lttng/commands/destroy.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/src/bin/lttng/commands/destroy.c b/src/bin/lttng/commands/destroy.c
index 7b7ea0e..cdc2c53 100644
--- a/src/bin/lttng/commands/destroy.c
+++ b/src/bin/lttng/commands/destroy.c
@@ -114,21 +114,6 @@ error:
 }
 
 /*
- * get_default_session_name
- *
- * Returns the default sessions name, if any
- */
-static int get_default_session_name(char **name)
-{
-	char *session_name = get_session_name();
-	if (session_name == NULL) {
-		return CMD_ERROR;
-	}
-	*name = session_name;
-	return CMD_SUCCESS;
-}
-
-/*
  * The 'destroy <options>' first level command
  */
 int cmd_destroy(int argc, const char **argv)
-- 
1.7.11.4
