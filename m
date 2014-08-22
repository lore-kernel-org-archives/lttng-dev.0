From: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Subject: [PATCH lttng-tool] Fix: list without a name is not an
	error
Date: Fri, 22 Aug 2014 16:25:47 -0400
Message-ID: <1408739147-5871-1-git-send-email-jonathan.r.julien__24298.2219359421$1408739210$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@ericsson.com>)
 id 1XKvPO-0004hg-JR
 for lttng-dev@lists.lttng.org; Fri, 22 Aug 2014 16:26:04 -0400
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

Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
---
 src/bin/lttng/commands/list.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
index ccffdc7..bd96f88 100644
--- a/src/bin/lttng/commands/list.c
+++ b/src/bin/lttng/commands/list.c
@@ -1251,7 +1251,6 @@ static int list_sessions(const char *session_name)
 		/* Pretty print */
 		if (count == 0) {
 			MSG("Currently no available tracing session");
-			ret = CMD_ERROR;
 			goto end;
 		}
 
-- 
2.0.4
