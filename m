From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 5/9] Cleanup: test: don't stop
 relayd twice
Date: Fri,  3 May 2019 09:55:43 -0400
Message-ID: <20190503135547.12968-6-mathieu.desnoyers__40822.0846600429$1556910976$gmane$org@efficios.com>
References: <20190503135547.12968-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44wYZG3R3Bz1Kcn
 for <lttng-dev@lists.lttng.org>; Fri,  3 May 2019 09:56:06 -0400 (EDT)
In-Reply-To: <20190503135547.12968-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, joraj@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
2.11.0
