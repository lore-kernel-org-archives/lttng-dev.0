From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Test: prevent the spawning of a
	daemonized sessiond
Date: Tue,  8 Mar 2016 17:11:58 -0500
Message-ID: <1457475118-17426-1-git-send-email-jonathan.rajotte-julien__25327.2973969162$1457475232$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1adPrZ-0003IL-0m
 for lttng-dev@lists.lttng.org; Tue, 08 Mar 2016 17:12:25 -0500
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 tests/utils/utils.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index da23f7a..1067438 100644
--- a/tests/utils/utils.sh
+++ b/tests/utils/utils.sh
@@ -32,6 +32,7 @@ KERNEL_PATCHLEVEL_VERSION=27
 # basic tests don't have to worry about hitting timeouts on busy
 # systems. Specialized tests should test those corner-cases.
 export LTTNG_UST_REGISTER_TIMEOUT=-1
+export LTTNG_SESSIOND_PATH="/bin/true"
 
 source $TESTDIR/utils/tap/tap.sh
 
-- 
2.7.0
