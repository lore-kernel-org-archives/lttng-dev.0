From: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Subject: [PATCH lttng-tool] Fix: wrong behavior of save command
	when no session name is provided
Date: Tue, 17 Jun 2014 15:59:41 -0400
Message-ID: <1403035181-12315-1-git-send-email-jonathan.r.julien__39700.3145808869$1403035270$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@ericsson.com>)
 id 1WwzXy-0002IV-5I
 for lttng-dev@lists.lttng.org; Tue, 17 Jun 2014 16:00:03 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

No session name and no option --all should default to --all.

Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
---
 src/bin/lttng/commands/save.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/bin/lttng/commands/save.c b/src/bin/lttng/commands/save.c
index e8a4565..9be7103 100644
--- a/src/bin/lttng/commands/save.c
+++ b/src/bin/lttng/commands/save.c
@@ -93,12 +93,9 @@ int cmd_save(int argc, const char **argv)
 
 	if (!opt_save_all) {
 		session_name = poptGetArg(pc);
-		if (!session_name) {
-			ERR("A session name must be provided if the \"all\" option is not used.");
-			ret = CMD_ERROR;
-			goto end;
+		if (session_name) {
+			DBG2("Session name: %s", session_name);
 		}
-		DBG2("Session name: %s", session_name);
 	}
 
 	attr = lttng_save_session_attr_create();
-- 
2.0.0
