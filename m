From: simon.marchi@polymtl.ca
Subject: [PATCH lttng-tools 3/5] bash completion: Remove
	deprecated consumer commands
Date: Mon, 29 Jul 2013 15:22:43 -0400
Message-ID: <1375125765-16063-3-git-send-email-simon.marchi__32197.7088497535$1375125807$gmane$org@polymtl.ca>
References: <1375125765-16063-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [132.207.72.18] (helo=stationx.dorsal.polymtl.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simark@stationx.dorsal.polymtl.ca>)
	id 1V3t1b-0005C0-Kh
	for lttng-dev@lists.lttng.org; Mon, 29 Jul 2013 15:22:36 -0400
In-Reply-To: <1375125765-16063-1-git-send-email-simon.marchi@polymtl.ca>
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

enable/disable consumer were removed a while ago. Remove autocomplete
for them to discourage people of using them.

Reported-by: Daniel U. Thibault <daniel.thibault@drdc-rddc.gc.ca>
Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 extras/lttng-bash_completion |   38 --------------------------------------
 1 files changed, 0 insertions(+), 38 deletions(-)

diff --git a/extras/lttng-bash_completion b/extras/lttng-bash_completion
index a90820a..b5f861c 100644
--- a/extras/lttng-bash_completion
+++ b/extras/lttng-bash_completion
@@ -125,44 +125,6 @@ _lttng_cmd_enableevent() {
 	esac
 }
 
-_lttng_cmd_enableconsumer() {
-	local enable_consumer_opts
-		enable_consumer_opts=$(lttng enable-consumer --list-options)
-
-	case $prev in
-	--session|-s)
-		_lttng_complete_sessions
-		return
-		;;
-	esac
-
-	case $cur in
-	-*)
-		COMPREPLY=( $(compgen -W "${enable_consumer_opts}" -- $cur) )
-		return
-		;;
-	esac
-}
-
-_lttng_cmd_disableconsumer() {
-	local disable_consumer_opts
-		disable_consumer_opts=$(lttng disable-consumer --list-options)
-
-	case $prev in
-	--session|-s)
-		_lttng_complete_sessions
-		return
-		;;
-	esac
-
-	case $cur in
-	-*)
-		COMPREPLY=( $(compgen -W "${disable_consumer_opts}" -- $cur) )
-		return
-		;;
-	esac
-}
-
 _lttng_cmd_disablechannel() {
 	local disable_channel_opts
 	disable_channel_opts=$(lttng disable-channel --list-options)
-- 
1.7.1
