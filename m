From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace 1/1] Cleanup: test_bitfield: nr_bits
 should be unsigned
Date: Thu, 30 May 2019 16:15:22 -0400
Message-ID: <20190530201522.29931-1-mathieu.desnoyers__19976.6210558423$1559247353$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45FJjc4Dtcz106G
 for <lttng-dev@lists.lttng.org>; Thu, 30 May 2019 16:15:32 -0400 (EDT)
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

Should not have any effect on the code behavior, but removes
useless type conversions between unsigned and signed types.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Change-Id: I39096ab89936875009a68d3ab8a4546c7f1eb8ae
---
 tests/lib/test_bitfield.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/lib/test_bitfield.c b/tests/lib/test_bitfield.c
index 05547c07..9e9a52ad 100644
--- a/tests/lib/test_bitfield.c
+++ b/tests/lib/test_bitfield.c
@@ -380,7 +380,7 @@ void run_test_unsigned(unsigned int src_ui, unsigned long long src_ull)
 
 void run_test_signed_write(int src_i, long long src_ll)
 {
-	int nrbits_i, nrbits_ll;
+	unsigned int nrbits_i, nrbits_ll;
 	union {
 		signed char c[TEST_LEN];
 		short s[TEST_LEN/sizeof(short)];
@@ -500,7 +500,8 @@ void run_test_signed_write(int src_i, long long src_ll)
 
 void run_test_signed_read(int src_i, long long src_ll)
 {
-	int nrbits_i, nrbits_ll, readval_i;
+	unsigned int nrbits_i, nrbits_ll;
+	int readval_i;
 	union {
 		unsigned char c[TEST_LEN];
 		unsigned short s[TEST_LEN/sizeof(unsigned short)];
-- 
2.11.0
