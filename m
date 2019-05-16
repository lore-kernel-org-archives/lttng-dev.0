From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 5/6] Cleanup: test: don't stop
 relayd twice
Date: Thu, 16 May 2019 15:08:00 -0400
Message-ID: <20190516190801.16878-5-mathieu.desnoyers__15426.2490965024$1558033985$gmane$org@efficios.com>
References: <20190516190801.16878-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 454gtL0HWCzyqf
 for <lttng-dev@lists.lttng.org>; Thu, 16 May 2019 15:08:10 -0400 (EDT)
In-Reply-To: <20190516190801.16878-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: joraj@efficios.com, jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 tests/regression/tools/live/test_lttng_ust | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/regression/tools/live/test_lttng_ust b/tests/regression/tools/live/test_lttng_ust
index 06017d01..830fc783 100755
--- a/tests/regression/tools/live/test_lttng_ust
+++ b/tests/regression/tools/live/test_lttng_ust
@@ -34,7 +34,7 @@ TRACE_PATH=$(mktemp -d)
 
 DIR=$(readlink -f $TESTDIR)
 
-NUM_TESTS=12
+NUM_TESTS=11
 
 source $TESTDIR/utils/utils.sh
 
@@ -84,5 +84,4 @@ stop_lttng_relayd
 
 test_custom_url
 
-stop_lttng_relayd
 stop_lttng_sessiond
-- 
2.17.1
