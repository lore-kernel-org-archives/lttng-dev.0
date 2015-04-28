From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: set UST register timeout to -1
	as test default
Date: Tue, 28 Apr 2015 10:16:37 -0400
Message-ID: <1430230597-25836-1-git-send-email-mathieu.desnoyers__6709.94895413077$1430230717$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Yn6Jm-0001u9-IG
 for lttng-dev@lists.lttng.org; Tue, 28 Apr 2015 10:17:08 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On busy systems, it's possible to spuriously hit the default 3 seconds
timeout for UST registration to sessiond, thus causing tests to be flaky
on those systems.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tests/utils/utils.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index c3d8bd4..5f86ece 100644
--- a/tests/utils/utils.sh
+++ b/tests/utils/utils.sh
@@ -27,6 +27,11 @@ KERNEL_MAJOR_VERSION=2
 KERNEL_MINOR_VERSION=6
 KERNEL_PATCHLEVEL_VERSION=27
 
+# We set the default UST register timeout to "wait forever", so that
+# basic tests don't have to worry about hitting timeouts on busy
+# systems. Specialized tests should test those corner-cases.
+export LTTNG_UST_REGISTER_TIMEOUT=-1
+
 source $TESTDIR/utils/tap/tap.sh
 
 function print_ok ()
-- 
2.1.4
