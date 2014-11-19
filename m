From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 5/8] Fix: high throughput test:
	reset bw limit on sigterm
Date: Wed, 19 Nov 2014 22:40:29 +0100
Message-ID: <1416433232-20080-6-git-send-email-mathieu.desnoyers__21846.1100281731$1416433378$gmane$org@efficios.com>
References: <1416433232-20080-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XrCze-0002NL-N9
 for lttng-dev@lists.lttng.org; Wed, 19 Nov 2014 16:40:56 -0500
In-Reply-To: <1416433232-20080-1-git-send-email-mathieu.desnoyers@efficios.com>
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

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tests/regression/tools/streaming/test_high_throughput_limits | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/regression/tools/streaming/test_high_throughput_limits b/tests/regression/tools/streaming/test_high_throughput_limits
index 8ed2ce5..9f75471 100755
--- a/tests/regression/tools/streaming/test_high_throughput_limits
+++ b/tests/regression/tools/streaming/test_high_throughput_limits
@@ -168,12 +168,14 @@ skip $isroot "Root access is needed to set bandwith limits. Skipping all tests."
 {
 
 	# Catch sigint and try to cleanup limits
+	trap interrupt_cleanup SIGTERM
 	trap interrupt_cleanup SIGINT
 
 	BW_LIMITS=(3200 1600 800 400 200 100 50 25)
 	for BW in ${BW_LIMITS[@]};
 	do
 		diag "Test high-throughput with bandwidth limit set to ${BW}kbits"
+
 		set_bw_limit $BW
 
 		start_lttng_sessiond
-- 
2.1.1
