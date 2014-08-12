From: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Subject: [PATCH lttng-tool] Fix: list command: revert merge
	error made when adding mi on pretty printing
Date: Tue, 12 Aug 2014 13:55:40 -0400
Message-ID: <1407866140-6261-1-git-send-email-jonathan.r.julien__37032.0097114474$1407866226$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@ericsson.com>)
 id 1XHGIi-0007ML-HJ
 for lttng-dev@lists.lttng.org; Tue, 12 Aug 2014 13:56:06 -0400
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
 src/bin/lttng/commands/list.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
index e3ff4f1..ccffdc7 100644
--- a/src/bin/lttng/commands/list.c
+++ b/src/bin/lttng/commands/list.c
@@ -1271,14 +1271,10 @@ static int list_sessions(const char *session_name)
 					break;
 				}
 			} else {
-				MSG("  %d) %s (%s) [%s%s]", i + 1,
-						sessions[i].name, sessions[i].path,
+				MSG("  %d) %s (%s) [%s%s]", i + 1, sessions[i].name,
+						sessions[i].path,
 						active_string(sessions[i].enabled),
 						snapshot_string(sessions[i].snapshot_mode));
-				MSG("%sTrace path: %s", indent4, sessions[i].path);
-				MSG("%sLive timer interval (usec): %u\n", indent4,
-						sessions[i].live_timer_interval);
-				break;
 			}
 		}
 
-- 
2.0.4
