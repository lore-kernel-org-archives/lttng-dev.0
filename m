From: simon.marchi@polymtl.ca
Subject: [PATCH lttng-tools 2/5] bash completion: Remove
	underscores in handler function names
Date: Mon, 29 Jul 2013 15:22:42 -0400
Message-ID: <1375125765-16063-2-git-send-email-simon.marchi__10153.697015676$1375126105$gmane$org@polymtl.ca>
References: <1375125765-16063-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [132.207.72.18] (helo=stationx.dorsal.polymtl.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simark@stationx.dorsal.polymtl.ca>)
	id 1V3t1b-0005By-KP
	for lttng-dev@lists.lttng.org; Mon, 29 Jul 2013 15:22:42 -0400
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

If the command name contains a dash, it is removed to derive the
function name that will handle completion. For example, add-context
becomes _lttng_cmd_addcontext. The functions with erroneous names
were not getting called.

Reported-by: Daniel U. Thibault <daniel.thibault@drdc-rddc.gc.ca>
Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 extras/lttng-bash_completion |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/extras/lttng-bash_completion b/extras/lttng-bash_completion
index efd5f58..a90820a 100644
--- a/extras/lttng-bash_completion
+++ b/extras/lttng-bash_completion
@@ -20,7 +20,7 @@ _lttng_complete_sessions() {
 	return
 }
 
-_lttng_cmd_add_context() {
+_lttng_cmd_addcontext() {
 	local add_context_opts
 	add_context_opts=$(lttng add-context --list-options)
 
@@ -182,7 +182,7 @@ _lttng_cmd_disablechannel() {
 	esac
 }
 
-_lttng_cmd_disable_event() {
+_lttng_cmd_disableevent() {
 	local disable_event_opts
 	disable_channel_opts=$(lttng disable-event --list-options)
 
@@ -222,7 +222,7 @@ _lttng_cmd_list() {
 	esac
 }
 
-_lttng_cmd_set_session() {
+_lttng_cmd_setsession() {
 	local set_session_opts
 	set_session_opts=$(lttng set-session --list-options)
 
-- 
1.7.1
