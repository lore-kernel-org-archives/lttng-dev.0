From: simon.marchi@polymtl.ca
Subject: [PATCH lttng-tools 5/5] bash completion: add calls to
	_lttng_complete_sessions
Date: Mon, 29 Jul 2013 15:22:45 -0400
Message-ID: <1375125765-16063-5-git-send-email-simon.marchi__20703.9854875349$1375126208$gmane$org@polymtl.ca>
References: <1375125765-16063-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [132.207.72.18] (helo=stationx.dorsal.polymtl.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simark@stationx.dorsal.polymtl.ca>)
	id 1V3t1b-0005C2-OJ
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

Improve a little bit the dummy implementation of
_lttng_complete_sessions and add two calls where it can be useful.

Reported-by: Daniel U. Thibault <daniel.thibault@drdc-rddc.gc.ca>
Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 extras/lttng-bash_completion |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/extras/lttng-bash_completion b/extras/lttng-bash_completion
index cc81557..bff8df7 100644
--- a/extras/lttng-bash_completion
+++ b/extras/lttng-bash_completion
@@ -16,7 +16,12 @@
 #
 
 _lttng_complete_sessions() {
-	# TODO, maybe have a lttng list --simple or something like that
+	# TODO
+	# This code does nothing for now. When there is a mecanism to get the
+	# existing sessions, use it to fill the sessions variable.
+	local sessions
+	sessions=""
+	COMPREPLY=( $(compgen -W "${sessions}" -- $cur) )
 	return
 }
 
@@ -181,6 +186,9 @@ _lttng_cmd_list() {
 		COMPREPLY=( $(compgen -W "${list_opts}" -- $cur) )
 		return
 		;;
+	*)
+		_lttng_complete_sessions
+		return
 	esac
 }
 
@@ -193,6 +201,10 @@ _lttng_cmd_setsession() {
 		COMPREPLY=( $(compgen -W "${set_session_opts}" -- $cur) )
 		return
 		;;
+	*)
+		_lttng_complete_sessions
+		return
+		;;
 	esac
 }
 
-- 
1.7.1
