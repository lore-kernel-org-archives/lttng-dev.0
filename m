From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: test: use load_path instead of
	$1
Date: Thu, 14 Jan 2016 13:40:42 -0500
Message-ID: <1452796842-31174-1-git-send-email-jonathan.rajotte-julien__22725.4767822616$1452796910$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1aJmpL-0001Lf-PM
 for lttng-dev@lists.lttng.org; Thu, 14 Jan 2016 13:40:56 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

$1 is used for tap condition checking not the load path.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 tests/utils/utils.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index 3520792..42b3441 100644
--- a/tests/utils/utils.sh
+++ b/tests/utils/utils.sh
@@ -362,7 +362,7 @@ function start_lttng_sessiond_opt()
 	if [ -z $(pgrep --full lt-$SESSIOND_BIN) ]; then
 		# Have a load path ?
 		if [ -n "$load_path" ]; then
-			$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --load "$1" --background --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
+			$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --load "$load_path" --background --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
 		else
 			$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --background --consumerd32-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-path="$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
 		fi
-- 
2.5.0
