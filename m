From: Nathan Lynch <nathan_lynch@mentor.com>
Subject: [PATCH] lttng-tools: remove bogus argument from prove
	invocation
Date: Mon, 27 Oct 2014 21:00:06 -0500
Message-ID: <1414461606-24103-1-git-send-email-nathan_lynch__1611.73235760561$1414461672$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Nathan_Lynch@mentor.com>) id 1Xiw50-0001eh-Ad
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 22:00:18 -0400
Received: from svr-orw-fem-04.mgc.mentorg.com ([147.34.97.41])
 by relay1.mentorg.com with esmtp
 id 1Xiw4u-0004m5-4a from Nathan_Lynch@mentor.com
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 19:00:08 -0700
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

An argument of "$2" was added to the prove command line in
tests/run.sh by 68270f0f604e "Mi test: Basic test structure".  This is
harmless since run.sh is never called with more than one argument, but
it is confusing, and it breaks patches in OE that add support for
running tests on the target.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 tests/run.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/run.sh b/tests/run.sh
index ce51639f7626..c6c50fd9cff9 100755
--- a/tests/run.sh
+++ b/tests/run.sh
@@ -19,4 +19,4 @@
 
 [ -z "$1" ] && echo "Error: No testlist. Please specify a testlist to run." && exit 1
 
-prove $2 --merge --exec '' - < $1
+prove --merge --exec '' - < $1
-- 
1.9.3
