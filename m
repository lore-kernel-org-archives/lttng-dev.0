From: simon.marchi@polymtl.ca
Subject: [PATCH lttng-tools 1/5] bash completion: Remove --event
	for add-context
Date: Mon, 29 Jul 2013 15:22:41 -0400
Message-ID: <1375125765-16063-1-git-send-email-simon.marchi__29094.5081193515$1375125907$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [132.207.72.18] (helo=stationx.dorsal.polymtl.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simark@stationx.dorsal.polymtl.ca>)
	id 1V3t1b-0005Bz-KR
	for lttng-dev@lists.lttng.org; Mon, 29 Jul 2013 15:22:36 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

From: Simon Marchi <simon.marchi@polymtl.ca>

--event has been remove in 601d5acf42ebdb05ff8aa19f12fd9bdad3602781.

Reported-by: Daniel U. Thibault <daniel.thibault@drdc-rddc.gc.ca>
Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 extras/lttng-bash_completion |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/extras/lttng-bash_completion b/extras/lttng-bash_completion
index b515be0..efd5f58 100644
--- a/extras/lttng-bash_completion
+++ b/extras/lttng-bash_completion
@@ -32,9 +32,6 @@ _lttng_cmd_add_context() {
 	--channel|-c)
 		return
 		;;
-	--event|-e)
-		return
-		;;
 	--type|-t)
 		return
 		;;
-- 
1.7.1
