From: simon.marchi@polymtl.ca
Subject: [PATCH lttng-tools 2/5] Reorder functions _lttng_cmd_*
	functions in bash completion
Date: Tue, 13 Aug 2013 16:26:22 -0400
Message-ID: <1376425585-31636-2-git-send-email-simon.marchi__30581.0597179972$1376425664$gmane$org@polymtl.ca>
References: <1376425585-31636-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [132.207.72.18] (helo=stationx.dorsal.polymtl.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simark@stationx.dorsal.polymtl.ca>)
	id 1V9L9X-0005fM-G0
	for lttng-dev@lists.lttng.org; Tue, 13 Aug 2013 16:25:20 -0400
In-Reply-To: <1376425585-31636-1-git-send-email-simon.marchi@polymtl.ca>
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

Simply reorder them alphabetically to be consistent.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 extras/lttng-bash_completion |   68 ++++++++++++++++++++---------------------
 1 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/extras/lttng-bash_completion b/extras/lttng-bash_completion
index bff8df7..d5a58f3 100644
--- a/extras/lttng-bash_completion
+++ b/extras/lttng-bash_completion
@@ -50,6 +50,17 @@ _lttng_cmd_addcontext() {
 	esac
 }
 
+_lttng_cmd_calibrate() {
+	local calibrate_opts
+	calibrate_opts=$(lttng calibrate --list-options)
+
+	case $cur in
+	-*)
+		COMPREPLY=( $(compgen -W "${calibrate_opts}" -- $cur) )
+		;;
+	esac
+}
+
 _lttng_cmd_create() {
 	local create_opts
 	create_opts=$(lttng create --list-options)
@@ -82,10 +93,9 @@ _lttng_cmd_destroy() {
 		;;
 	esac
 }
-
-_lttng_cmd_enablechannel() {
-	local enable_channel_opts
-	enable_channel_opts=$(lttng enable-channel --list-options)
+_lttng_cmd_disablechannel() {
+	local disable_channel_opts
+	disable_channel_opts=$(lttng disable-channel --list-options)
 
 	case $prev in
 	--session|-s)
@@ -96,15 +106,14 @@ _lttng_cmd_enablechannel() {
 
 	case $cur in
 	-*)
-		COMPREPLY=( $(compgen -W "${enable_channel_opts}" -- $cur) )
+		COMPREPLY=( $(compgen -W "${disable_channel_opts}" -- $cur) )
 		return
 		;;
 	esac
 }
-
-_lttng_cmd_enableevent() {
-	local enable_event_opts
-	enable_event_opts=$(lttng enable-event --list-options)
+_lttng_cmd_disableevent() {
+	local disable_event_opts
+	disable_event_opts=$(lttng disable-event --list-options)
 
 	case $prev in
 	--session|-s)
@@ -114,25 +123,19 @@ _lttng_cmd_enableevent() {
 	--channel|-c)
 		return
 		;;
-	--probe)
-		return
-		;;
-	--function)
-		return
-		;;
 	esac
 
 	case $cur in
 	-*)
-		COMPREPLY=( $(compgen -W "${enable_event_opts}" -- $cur) )
+		COMPREPLY=( $(compgen -W "${disable_event_opts}" -- $cur) )
 		return
 		;;
 	esac
 }
 
-_lttng_cmd_disablechannel() {
-	local disable_channel_opts
-	disable_channel_opts=$(lttng disable-channel --list-options)
+_lttng_cmd_enablechannel() {
+	local enable_channel_opts
+	enable_channel_opts=$(lttng enable-channel --list-options)
 
 	case $prev in
 	--session|-s)
@@ -143,15 +146,15 @@ _lttng_cmd_disablechannel() {
 
 	case $cur in
 	-*)
-		COMPREPLY=( $(compgen -W "${disable_channel_opts}" -- $cur) )
+		COMPREPLY=( $(compgen -W "${enable_channel_opts}" -- $cur) )
 		return
 		;;
 	esac
 }
 
-_lttng_cmd_disableevent() {
-	local disable_event_opts
-	disable_event_opts=$(lttng disable-event --list-options)
+_lttng_cmd_enableevent() {
+	local enable_event_opts
+	enable_event_opts=$(lttng enable-event --list-options)
 
 	case $prev in
 	--session|-s)
@@ -161,11 +164,17 @@ _lttng_cmd_disableevent() {
 	--channel|-c)
 		return
 		;;
+	--probe)
+		return
+		;;
+	--function)
+		return
+		;;
 	esac
 
 	case $cur in
 	-*)
-		COMPREPLY=( $(compgen -W "${disable_event_opts}" -- $cur) )
+		COMPREPLY=( $(compgen -W "${enable_event_opts}" -- $cur) )
 		return
 		;;
 	esac
@@ -247,17 +256,6 @@ _lttng_cmd_version() {
 	esac
 }
 
-_lttng_cmd_calibrate() {
-	local calibrate_opts
-	calibrate_opts=$(lttng calibrate --list-options)
-
-	case $cur in
-	-*)
-		COMPREPLY=( $(compgen -W "${calibrate_opts}" -- $cur) )
-		;;
-	esac
-}
-
 _lttng_cmd_view() {
 	local view_opts
 		view_opts=$(lttng view --list-options)
-- 
1.7.1
