From: simon.marchi@polymtl.ca
Subject: [PATCH lttng-tools 5/5] Add session name completion in
	bash completion
Date: Tue, 13 Aug 2013 16:26:25 -0400
Message-ID: <1376425585-31636-5-git-send-email-simon.marchi__44787.6905360774$1376425979$gmane$org@polymtl.ca>
References: <1376425585-31636-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [132.207.72.18] (helo=stationx.dorsal.polymtl.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simark@stationx.dorsal.polymtl.ca>)
	id 1V9L9i-0005hb-ME
	for lttng-dev@lists.lttng.org; Tue, 13 Aug 2013 16:25:31 -0400
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

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 extras/lttng-bash_completion |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/extras/lttng-bash_completion b/extras/lttng-bash_completion
index f5677e9..5800a0e 100644
--- a/extras/lttng-bash_completion
+++ b/extras/lttng-bash_completion
@@ -17,11 +17,7 @@
 
 # Generates COMPREPLY with the existing session names
 _lttng_complete_sessions() {
-	# TODO
-	# This code does nothing for now. When there is a mecanism to get the
-	# existing sessions, use it to fill the sessions variable.
-	local sessions
-	sessions=""
+	sessions=$(lttng list --mi)
 	COMPREPLY=( $(compgen -W "${sessions}" -- $cur) )
 	return
 }
-- 
1.7.1
