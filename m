From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace 4/4] Cleanup: test_bitfield: pass
 source integers as parameters
Date: Wed, 15 May 2019 17:46:53 -0400
Message-ID: <20190515214653.15059-4-mathieu.desnoyers__20673.9420000062$1557956937$gmane$org@efficios.com>
References: <20190515214653.15059-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 4547SB6Dmvzynj
 for <lttng-dev@lists.lttng.org>; Wed, 15 May 2019 17:47:06 -0400 (EDT)
In-Reply-To: <20190515214653.15059-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, joraj@efficios.com, simon.marchi@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

It is a good practice to pass arguments as parameters rather
than through global variables.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Change-Id: I0d7cc94b1d492ca53ad29b1d39831ee6288b2672
---
 tests/lib/test_bitfield.c | 85 +++++++++++++++++------------------------------
 1 file changed, 30 insertions(+), 55 deletions(-)

diff --git a/tests/lib/test_bitfield.c b/tests/lib/test_bitfield.c
index 59bf89fd..63168fcd 100644
--- a/tests/lib/test_bitfield.c
+++ b/tests/lib/test_bitfield.c
@@ -51,9 +51,6 @@ void fct(void)
 #define DIAG_FMT_STR "Failed reading value written \"%s\"-wise, with start=%i" \
 	" and length=%i. Read %llX"
 
-unsigned int srcrand_ui;
-unsigned long long srcrand_ull;
-
 /*
  * fls: returns the position of the most significant bit.
  * Returns 0 if no bit is set, else returns the position of the most
@@ -202,9 +199,9 @@ do {					\
 	(val) != (ref);							\
 })
 
-void run_test_unsigned_write(void)
+void run_test_unsigned_write(unsigned int src_ui, unsigned long long src_ull)
 {
-	unsigned int src_ui, nrbits_ui, nrbits_ull;
+	unsigned int nrbits_ui, nrbits_ull;
 	union {
 		unsigned char c[TEST_LEN];
 		unsigned short s[TEST_LEN/sizeof(unsigned short)];
@@ -212,10 +209,9 @@ void run_test_unsigned_write(void)
 		unsigned long l[TEST_LEN/sizeof(unsigned long)];
 		unsigned long long ll[TEST_LEN/sizeof(unsigned long long)];
 	} target;
-	unsigned long long src_ull, readval;
+	unsigned long long readval;
 	unsigned int s, l;
 
-	src_ui = srcrand_ui;
 	nrbits_ui = fls_u32(src_ui);
 
 	/* Write from unsigned integer src input. */
@@ -264,7 +260,6 @@ void run_test_unsigned_write(void)
 	}
 	pass(UNSIGNED_INT_WRITE_TEST_DESC_FMT_STR, src_ui);
 
-	src_ull = srcrand_ull;
 	nrbits_ull = fls_u64(src_ull);
 
 	/* Write from unsigned long long src input. */
@@ -314,9 +309,9 @@ void run_test_unsigned_write(void)
 	pass(UNSIGNED_LONG_LONG_WRITE_TEST_DESC_FMT_STR, src_ull);
 }
 
-void run_test_unsigned_read(void)
+void run_test_unsigned_read(unsigned int src_ui, unsigned long long src_ull)
 {
-	unsigned int src_ui, nrbits_ui, nrbits_ull, readval_ui;
+	unsigned int nrbits_ui, nrbits_ull, readval_ui;
 	union {
 		unsigned char c[TEST_LEN];
 		unsigned short s[TEST_LEN/sizeof(unsigned short)];
@@ -324,10 +319,9 @@ void run_test_unsigned_read(void)
 		unsigned long l[TEST_LEN/sizeof(unsigned long)];
 		unsigned long long ll[TEST_LEN/sizeof(unsigned long long)];
 	} target;
-	unsigned long long src_ull, readval_ull;
+	unsigned long long readval_ull;
 	unsigned int s, l;
 
-	src_ui = srcrand_ui;
 	nrbits_ui = fls_u32(src_ui);
 
 	/* Read to unsigned integer readval output. */
@@ -376,7 +370,6 @@ void run_test_unsigned_read(void)
 	}
 	pass(UNSIGNED_INT_READ_TEST_DESC_FMT_STR, src_ui);
 
-	src_ull = srcrand_ull;
 	nrbits_ull = fls_u64(src_ull);
 
 	/* Read to unsigned long long readval output. */
@@ -426,15 +419,15 @@ void run_test_unsigned_read(void)
 	pass(UNSIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR, src_ull);
 }
 
-void run_test_unsigned(void)
+void run_test_unsigned(unsigned int src_ui, unsigned long long src_ull)
 {
-	run_test_unsigned_write();
-	run_test_unsigned_read();
+	run_test_unsigned_write(src_ui, src_ull);
+	run_test_unsigned_read(src_ui, src_ull);
 }
 
-void run_test_signed_write(void)
+void run_test_signed_write(int src_i, long long src_ll)
 {
-	int src_i, nrbits_i, nrbits_ll;
+	int nrbits_i, nrbits_ll;
 	union {
 		signed char c[TEST_LEN];
 		short s[TEST_LEN/sizeof(short)];
@@ -442,10 +435,9 @@ void run_test_signed_write(void)
 		long l[TEST_LEN/sizeof(long)];
 		long long ll[TEST_LEN/sizeof(long long)];
 	} target;
-	long long src_ll, readval;
+	long long readval;
 	unsigned int s, l;
 
-	src_i = srcrand_ui;
 	if (src_i & 0x80000000U)
 		nrbits_i = fls_u32(~src_i) + 1;	/* Find least significant bit conveying sign */
 	else
@@ -497,7 +489,6 @@ void run_test_signed_write(void)
 	}
 	pass(SIGNED_INT_WRITE_TEST_DESC_FMT_STR, src_i);
 
-	src_ll = srcrand_ull;
 	if (src_ll & 0x8000000000000000ULL)
 		nrbits_ll = fls_u64(~src_ll) + 1;	/* Find least significant bit conveying sign */
 	else
@@ -550,9 +541,9 @@ void run_test_signed_write(void)
 	pass(SIGNED_LONG_LONG_WRITE_TEST_DESC_FMT_STR, src_ll);
 }
 
-void run_test_signed_read(void)
+void run_test_signed_read(int src_i, long long src_ll)
 {
-	int src_i, nrbits_i, nrbits_ll, readval_i;
+	int nrbits_i, nrbits_ll, readval_i;
 	union {
 		unsigned char c[TEST_LEN];
 		unsigned short s[TEST_LEN/sizeof(unsigned short)];
@@ -560,10 +551,9 @@ void run_test_signed_read(void)
 		unsigned long l[TEST_LEN/sizeof(unsigned long)];
 		unsigned long long ll[TEST_LEN/sizeof(unsigned long long)];
 	} target;
-	long long src_ll, readval_ll;
+	long long readval_ll;
 	unsigned int s, l;
 
-	src_i = srcrand_ui;
 	if (src_i & 0x80000000U)
 		nrbits_i = fls_u32(~src_i) + 1;	/* Find least significant bit conveying sign */
 	else
@@ -615,7 +605,6 @@ void run_test_signed_read(void)
 	}
 	pass(SIGNED_INT_READ_TEST_DESC_FMT_STR, src_i);
 
-	src_ll = srcrand_ull;
 	if (src_ll & 0x8000000000000000ULL)
 		nrbits_ll = fls_u64(~src_ll) + 1;	/* Find least significant bit conveying sign */
 	else
@@ -668,48 +657,34 @@ void run_test_signed_read(void)
 	pass(SIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR, src_ll);
 }
 
-void run_test_signed(void)
+void run_test_signed(int src_i, long long src_ll)
 {
-	run_test_signed_write();
-	run_test_signed_read();
+	run_test_signed_write(src_i, src_ll);
+	run_test_signed_read(src_i, src_ll);
 }
 
 void run_test(void)
 {
 	int i;
+
 	plan_tests(NR_TESTS * 8 + 24);
 
 	srand(time(NULL));
 
-	srcrand_ui = 0;
-	srcrand_ull = 0;
-	run_test_unsigned();
-	srcrand_ui = 0;
-	srcrand_ull = 0;
-	run_test_signed();
-
-	srcrand_ui = 1;
-	srcrand_ull = 1;
-	run_test_unsigned();
-
-	srcrand_ui = ~0U;
-	srcrand_ull = ~0ULL;
-	run_test_unsigned();
-
-	srcrand_ui = -1U;
-	srcrand_ull = -1ULL;
-	run_test_signed();
-
-	srcrand_ui = 0x80000000U;
-	srcrand_ull = 0x8000000000000000ULL;
-	run_test_signed();
+	run_test_unsigned(0, 0);
+	run_test_signed(0, 0);
+	run_test_unsigned(1, 1);
+	run_test_unsigned(~0U, ~0ULL);
+	run_test_signed(-1U, -1ULL);
+	run_test_signed(0x80000000U, 0x8000000000000000ULL);
 
 	for (i = 0; i < NR_TESTS; i++) {
-		srcrand_ui = rand();
-		srcrand_ull = ((unsigned long long) (unsigned int) rand() << 32) |
+		unsigned int src_ui = rand();
+		unsigned long long src_ull = ((unsigned long long) (unsigned int) rand() << 32) |
 				(unsigned long long) (unsigned int) rand();
-		run_test_unsigned();
-		run_test_signed();
+
+		run_test_unsigned(src_ui, src_ull);
+		run_test_signed((int) src_ui, (long long) src_ull);
 	}
 }
 
-- 
2.11.0
