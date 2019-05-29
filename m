From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace 1/1] Fix: test_bitfield: extend
 coverage: 0-len signed write/read
Date: Wed, 29 May 2019 15:36:25 -0400
Message-ID: <20190529193625.24465-1-mathieu.desnoyers__7249.63592817716$1559158606$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45Dgv14kdLz10mF
 for <lttng-dev@lists.lttng.org>; Wed, 29 May 2019 15:36:28 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

By convention, a 0-len bitfield write is a no-op, and a 0-len read
sets the value of the output to 0.

So we can "encode" the value 0 over a length of 0 bit. Cover this
in the test-cases for signed types. It is already covered for the
unsigned test-cases.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Change-Id: Ib6038b98167ef2cfa8c504d7ac29498e71827b38
---
 tests/lib/test_bitfield.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tests/lib/test_bitfield.c b/tests/lib/test_bitfield.c
index 5188335b..05547c07 100644
--- a/tests/lib/test_bitfield.c
+++ b/tests/lib/test_bitfield.c
@@ -391,7 +391,9 @@ void run_test_signed_write(int src_i, long long src_ll)
 	long long readval;
 	unsigned int s, l;
 
-	if (src_i & 0x80000000U)
+	if (!src_i)
+		nrbits_i = 0;			/* The number of bits needed to represent 0 is 0. */
+	else if (src_i & 0x80000000U)
 		nrbits_i = fls_u32(~src_i) + 1;	/* Find least significant bit conveying sign */
 	else
 		nrbits_i = fls_u32(src_i) + 1;	/* Keep sign at 0 */
@@ -442,7 +444,9 @@ void run_test_signed_write(int src_i, long long src_ll)
 	}
 	pass(SIGNED_INT_WRITE_TEST_DESC_FMT_STR, src_i);
 
-	if (src_ll & 0x8000000000000000ULL)
+	if (!src_ll)
+		nrbits_ll = 0;				/* The number of bits needed to represent 0 is 0. */
+	else if (src_ll & 0x8000000000000000ULL)
 		nrbits_ll = fls_u64(~src_ll) + 1;	/* Find least significant bit conveying sign */
 	else
 		nrbits_ll = fls_u64(src_ll) + 1;	/* Keep sign at 0 */
@@ -507,7 +511,9 @@ void run_test_signed_read(int src_i, long long src_ll)
 	long long readval_ll;
 	unsigned int s, l;
 
-	if (src_i & 0x80000000U)
+	if (!src_i)
+		nrbits_i = 0;			/* The number of bits needed to represent 0 is 0. */
+	else if (src_i & 0x80000000U)
 		nrbits_i = fls_u32(~src_i) + 1;	/* Find least significant bit conveying sign */
 	else
 		nrbits_i = fls_u32(src_i) + 1;	/* Keep sign at 0 */
@@ -558,6 +564,8 @@ void run_test_signed_read(int src_i, long long src_ll)
 	}
 	pass(SIGNED_INT_READ_TEST_DESC_FMT_STR, src_i);
 
+	if (!src_ll)
+		nrbits_ll = 0;				/* The number of bits needed to represent 0 is 0. */
 	if (src_ll & 0x8000000000000000ULL)
 		nrbits_ll = fls_u64(~src_ll) + 1;	/* Find least significant bit conveying sign */
 	else
-- 
2.11.0
