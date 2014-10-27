From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: [PATCH lttng-tools] Fix: mi test: possible race between
	listing UST events and testapp start
Date: Sun, 26 Oct 2014 21:21:46 -0400
Message-ID: <1414372906-22433-1-git-send-email-jonathan.r.julien__16957.4835258119$1414372963$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.r.julien@gmail.com>) id 1XiZ0M-0001qU-8O
 for lttng-dev@lists.lttng.org; Sun, 26 Oct 2014 21:21:54 -0400
Received: by mail-ig0-f182.google.com with SMTP id hn18so4853841igb.9
 for <lttng-dev@lists.lttng.org>; Sun, 26 Oct 2014 18:21:48 -0700 (PDT)
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

Signed-off-by: Jonathan Rajotte <jonathan.r.julien@gmail.com>
---
 tests/regression/tools/mi/test_mi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/regression/tools/mi/test_mi b/tests/regression/tools/mi/test_mi
index fa46b51..7acec18 100755
--- a/tests/regression/tools/mi/test_mi
+++ b/tests/regression/tools/mi/test_mi
@@ -507,6 +507,11 @@ function test_list_ust_event ()
 
 	#Begin testing
 	$TESTAPP_BIN $NR_USEC_WAIT & 2>/dev/null
+	pid=$!
+
+	#Wait for TESTAPP to run
+	while ! kill -0 $pid 2> /dev/null; do :; done
+
 	list_lttng_with_opts "-u -f"
 	$XML_VALIDATE $OUTPUT_DEST
 	ok $? "Mi test: list ust event xsd validation"
-- 
1.9.1
