From: simon.marchi@polymtl.ca
Subject: [PATCH lttng-tools 4/5] bash completion: Fix copy-paste
	typo
Date: Mon, 29 Jul 2013 15:22:44 -0400
Message-ID: <1375125765-16063-4-git-send-email-simon.marchi__9723.60932869396$1375126006$gmane$org@polymtl.ca>
References: <1375125765-16063-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [132.207.72.18] (helo=stationx.dorsal.polymtl.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simark@stationx.dorsal.polymtl.ca>)
	id 1V3t1b-0005C1-N5
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

Reported-by: Daniel U. Thibault <daniel.thibault@drdc-rddc.gc.ca>
Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 extras/lttng-bash_completion |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/extras/lttng-bash_completion b/extras/lttng-bash_completion
index b5f861c..cc81557 100644
--- a/extras/lttng-bash_completion
+++ b/extras/lttng-bash_completion
@@ -146,7 +146,7 @@ _lttng_cmd_disablechannel() {
 
 _lttng_cmd_disableevent() {
 	local disable_event_opts
-	disable_channel_opts=$(lttng disable-event --list-options)
+	disable_event_opts=$(lttng disable-event --list-options)
 
 	case $prev in
 	--session|-s)
-- 
1.7.1
