From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace 3/4] Extend test_bitfield coverage
Date: Tue, 14 May 2019 16:30:55 -0400
Message-ID: <20190514203056.24565-3-mathieu.desnoyers__40910.0925595098$1557865950$gmane$org@efficios.com>
References: <20190514203056.24565-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 453Tpw6ZczzyRB
 for <lttng-dev@lists.lttng.org>; Tue, 14 May 2019 16:31:04 -0400 (EDT)
In-Reply-To: <20190514203056.24565-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, simon.marchi@efficios.com, joraj@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

test_bitfield was mainly testing various write unit size. Add
variations of read unit size as well.

Previously, the test was only covering input from a 32-bit integer.
Additionally test source and destination of 64-bit.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Change-Id: Ic2b7849140e04fe7cca3de576e31bfef8f0a03ae
---
 tests/lib/test_bitfield.c | 562 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 491 insertions(+), 71 deletions(-)

diff --git a/tests/lib/test_bitfield.c b/tests/lib/test_bitfield.c
index efbbc30e..59bf89fd 100644
--- a/tests/lib/test_bitfield.c
+++ b/tests/lib/test_bitfield.c
@@ -3,7 +3,7 @@
  *
  * BabelTrace - bitfield test program
  *
- * Copyright 2010 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright 2010-2019 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -40,39 +40,109 @@ void fct(void)
 /* Test array size, in bytes */
 #define TEST_LEN 128
 #define NR_TESTS 10
-#define SIGNED_TEST_DESC_FMT_STR "Writing and reading back 0x%X, signed"
-#define UNSIGNED_TEST_DESC_FMT_STR "Writing and reading back 0x%X, unsigned"
+#define SIGNED_INT_READ_TEST_DESC_FMT_STR "Writing and reading back 0x%X, signed int dest, varying read unit size"
+#define SIGNED_INT_WRITE_TEST_DESC_FMT_STR "Writing and reading back 0x%X, signed int source, varying write unit size"
+#define SIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR "Writing and reading back 0x%llX, signed long long dest, varying read unit size"
+#define SIGNED_LONG_LONG_WRITE_TEST_DESC_FMT_STR "Writing and reading back 0x%llX, signed long long source, varying write unit size"
+#define UNSIGNED_INT_READ_TEST_DESC_FMT_STR "Writing and reading back 0x%X, unsigned int dest, varying read unit size"
+#define UNSIGNED_INT_WRITE_TEST_DESC_FMT_STR "Writing and reading back 0x%X, unsigned int source, varying write unit size"
+#define UNSIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR "Writing and reading back 0x%llX, unsigned long long dest, varying read unit size"
+#define UNSIGNED_LONG_LONG_WRITE_TEST_DESC_FMT_STR "Writing and reading back 0x%llX, unsigned long long source, varying write unit size"
 #define DIAG_FMT_STR "Failed reading value written \"%s\"-wise, with start=%i" \
 	" and length=%i. Read %llX"
 
-unsigned int srcrand;
+unsigned int srcrand_ui;
+unsigned long long srcrand_ull;
 
+/*
+ * fls: returns the position of the most significant bit.
+ * Returns 0 if no bit is set, else returns the position of the most
+ * significant bit (from 1 to 32 on 32-bit, from 1 to 64 on 64-bit).
+ */
 #if defined(__i386) || defined(__x86_64)
-
-static inline int fls(int x)
+static
+unsigned int fls_u32(uint32_t x)
 {
 	int r;
-	asm("bsrl %1,%0\n\t"
-	    "cmovzl %2,%0"
-	    : "=&r" (r) : "rm" (x), "rm" (-1));
+
+	__asm__ ("bsrl %1,%0\n\t"
+	    "jnz 1f\n\t"
+	    "movl $-1,%0\n\t"
+	    "1:\n\t"
+	    : "=r" (r) : "rm" (x));
 	return r + 1;
 }
-
+#define HAS_FLS_U32
 #elif defined(__PPC__)
-
-static __inline__ int fls(unsigned int x)
+static
+unsigned int fls_u32(uint32_t x)
 {
 	int lz;
 
-	asm ("cntlzw %0,%1" : "=r" (lz) : "r" (x));
+	__asm__ ("cntlzw %0,%1" : "=r" (lz) : "r" (x));
 	return 32 - lz;
 }
+#define HAS_FLS_U32
+#endif
+
+#if defined(__x86_64)
+static
+unsigned int fls_u64(uint64_t x)
+{
+	long r;
 
-#else
+	__asm__ ("bsrq %1,%0\n\t"
+	    "jnz 1f\n\t"
+	    "movq $-1,%0\n\t"
+	    "1:\n\t"
+	    : "=r" (r) : "rm" (x));
+	return r + 1;
+}
+#define HAS_FLS_U64
+#endif
+
+#ifndef HAS_FLS_U64
+static
+unsigned int fls_u64(uint64_t x)
+{
+	unsigned int r = 64;
+
+	if (!x)
+		return 0;
+
+	if (!(x & 0xFFFFFFFF00000000ULL)) {
+		x <<= 32;
+		r -= 32;
+	}
+	if (!(x & 0xFFFF000000000000ULL)) {
+		x <<= 16;
+		r -= 16;
+	}
+	if (!(x & 0xFF00000000000000ULL)) {
+		x <<= 8;
+		r -= 8;
+	}
+	if (!(x & 0xF000000000000000ULL)) {
+		x <<= 4;
+		r -= 4;
+	}
+	if (!(x & 0xC000000000000000ULL)) {
+		x <<= 2;
+		r -= 2;
+	}
+	if (!(x & 0x8000000000000000ULL)) {
+		x <<= 1;
+		r -= 1;
+	}
+	return r;
+}
+#endif
 
-static int fls(unsigned int x)
+#ifndef HAS_FLS_U32
+static
+unsigned int fls_u32(uint32_t x)
 {
-	int r = 32;
+	unsigned int r = 32;
 
 	if (!x)
 		return 0;
@@ -98,7 +168,6 @@ static int fls(unsigned int x)
 	}
 	return r;
 }
-
 #endif
 
 #define print_byte_array(c, len)	\
@@ -133,9 +202,9 @@ do {					\
 	(val) != (ref);							\
 })
 
-void run_test_unsigned(void)
+void run_test_unsigned_write(void)
 {
-	unsigned int src, nrbits;
+	unsigned int src_ui, nrbits_ui, nrbits_ull;
 	union {
 		unsigned char c[TEST_LEN];
 		unsigned short s[TEST_LEN/sizeof(unsigned short)];
@@ -143,62 +212,229 @@ void run_test_unsigned(void)
 		unsigned long l[TEST_LEN/sizeof(unsigned long)];
 		unsigned long long ll[TEST_LEN/sizeof(unsigned long long)];
 	} target;
-	unsigned long long readval;
+	unsigned long long src_ull, readval;
 	unsigned int s, l;
 
-	src = srcrand;
-	nrbits = fls(src);
+	src_ui = srcrand_ui;
+	nrbits_ui = fls_u32(src_ui);
 
+	/* Write from unsigned integer src input. */
 	for (s = 0; s < CHAR_BIT * TEST_LEN; s++) {
-		for (l = nrbits; l < (CHAR_BIT * TEST_LEN) - s; l++) {
+		for (l = nrbits_ui; l < (CHAR_BIT * TEST_LEN) - s; l++) {
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.c, unsigned char, s, l, src);
+			bt_bitfield_write(target.c, unsigned char, s, l, src_ui);
 			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
-			if (check_result(src, readval, target.c, unsigned char,
-					  s, l, UNSIGNED_TEST_DESC_FMT_STR)) {
+			if (check_result(src_ui, readval, target.c, unsigned char,
+					  s, l, UNSIGNED_INT_WRITE_TEST_DESC_FMT_STR)) {
 				return;
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.s, unsigned short, s, l, src);
+			bt_bitfield_write(target.s, unsigned short, s, l, src_ui);
 			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
-			if (check_result(src, readval, target.c, unsigned short,
-					  s, l, UNSIGNED_TEST_DESC_FMT_STR)) {
+			if (check_result(src_ui, readval, target.c, unsigned short,
+					  s, l, UNSIGNED_INT_WRITE_TEST_DESC_FMT_STR)) {
 				return;
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.i, unsigned int, s, l, src);
+			bt_bitfield_write(target.i, unsigned int, s, l, src_ui);
 			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
-			if (check_result(src, readval, target.c, unsigned int,
-					   s, l, UNSIGNED_TEST_DESC_FMT_STR)) {
+			if (check_result(src_ui, readval, target.c, unsigned int,
+					   s, l, UNSIGNED_INT_WRITE_TEST_DESC_FMT_STR)) {
 				return;
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.l, unsigned long, s, l, src);
+			bt_bitfield_write(target.l, unsigned long, s, l, src_ui);
 			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
-			if (check_result(src, readval, target.c, unsigned long,
-					  s, l, UNSIGNED_TEST_DESC_FMT_STR)) {
+			if (check_result(src_ui, readval, target.c, unsigned long,
+					  s, l, UNSIGNED_INT_WRITE_TEST_DESC_FMT_STR)) {
 				return;
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.ll, unsigned long long, s, l, src);
+			bt_bitfield_write(target.ll, unsigned long long, s, l, src_ui);
 			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
-			if (check_result(src, readval, target.c, unsigned long long,
-				     s, l, UNSIGNED_TEST_DESC_FMT_STR)) {
+			if (check_result(src_ui, readval, target.c, unsigned long long,
+				     s, l, UNSIGNED_INT_WRITE_TEST_DESC_FMT_STR)) {
 				return;
 			}
 		}
 	}
+	pass(UNSIGNED_INT_WRITE_TEST_DESC_FMT_STR, src_ui);
+
+	src_ull = srcrand_ull;
+	nrbits_ull = fls_u64(src_ull);
+
+	/* Write from unsigned long long src input. */
+	for (s = 0; s < CHAR_BIT * TEST_LEN; s++) {
+		for (l = nrbits_ull; l < (CHAR_BIT * TEST_LEN) - s; l++) {
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.c, unsigned char, s, l, src_ull);
+			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
+			if (check_result(src_ull, readval, target.c, unsigned char,
+					  s, l, UNSIGNED_LONG_LONG_WRITE_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.s, unsigned short, s, l, src_ull);
+			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
+			if (check_result(src_ull, readval, target.c, unsigned short,
+					  s, l, UNSIGNED_LONG_LONG_WRITE_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.i, unsigned int, s, l, src_ull);
+			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
+			if (check_result(src_ull, readval, target.c, unsigned int,
+					   s, l, UNSIGNED_LONG_LONG_WRITE_TEST_DESC_FMT_STR)) {
+				return;
+			}
 
-	pass(UNSIGNED_TEST_DESC_FMT_STR, src);
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.l, unsigned long, s, l, src_ull);
+			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
+			if (check_result(src_ull, readval, target.c, unsigned long,
+					  s, l, UNSIGNED_LONG_LONG_WRITE_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.ll, unsigned long long, s, l, src_ull);
+			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
+			if (check_result(src_ull, readval, target.c, unsigned long long,
+				     s, l, UNSIGNED_LONG_LONG_WRITE_TEST_DESC_FMT_STR)) {
+				return;
+			}
+		}
+	}
+	pass(UNSIGNED_LONG_LONG_WRITE_TEST_DESC_FMT_STR, src_ull);
 }
 
-void run_test_signed(void)
+void run_test_unsigned_read(void)
 {
-	int src, nrbits;
+	unsigned int src_ui, nrbits_ui, nrbits_ull, readval_ui;
+	union {
+		unsigned char c[TEST_LEN];
+		unsigned short s[TEST_LEN/sizeof(unsigned short)];
+		unsigned int i[TEST_LEN/sizeof(unsigned int)];
+		unsigned long l[TEST_LEN/sizeof(unsigned long)];
+		unsigned long long ll[TEST_LEN/sizeof(unsigned long long)];
+	} target;
+	unsigned long long src_ull, readval_ull;
+	unsigned int s, l;
+
+	src_ui = srcrand_ui;
+	nrbits_ui = fls_u32(src_ui);
+
+	/* Read to unsigned integer readval output. */
+	for (s = 0; s < CHAR_BIT * TEST_LEN; s++) {
+		for (l = nrbits_ui; l < (CHAR_BIT * TEST_LEN) - s; l++) {
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.c, unsigned char, s, l, src_ui);
+			bt_bitfield_read(target.c, unsigned char, s, l, &readval_ui);
+			if (check_result(src_ui, readval_ui, target.c, unsigned char,
+					  s, l, UNSIGNED_INT_READ_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.s, unsigned char, s, l, src_ui);
+			bt_bitfield_read(target.c, unsigned short, s, l, &readval_ui);
+			if (check_result(src_ui, readval_ui, target.c, unsigned short,
+					  s, l, UNSIGNED_INT_READ_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.i, unsigned char, s, l, src_ui);
+			bt_bitfield_read(target.c, unsigned int, s, l, &readval_ui);
+			if (check_result(src_ui, readval_ui, target.c, unsigned int,
+					   s, l, UNSIGNED_INT_READ_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.l, unsigned char, s, l, src_ui);
+			bt_bitfield_read(target.c, unsigned long, s, l, &readval_ui);
+			if (check_result(src_ui, readval_ui, target.c, unsigned long,
+					  s, l, UNSIGNED_INT_READ_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.ll, unsigned char, s, l, src_ui);
+			bt_bitfield_read(target.c, unsigned long long, s, l, &readval_ui);
+			if (check_result(src_ui, readval_ui, target.c, unsigned long long,
+				     s, l, UNSIGNED_INT_READ_TEST_DESC_FMT_STR)) {
+				return;
+			}
+		}
+	}
+	pass(UNSIGNED_INT_READ_TEST_DESC_FMT_STR, src_ui);
+
+	src_ull = srcrand_ull;
+	nrbits_ull = fls_u64(src_ull);
+
+	/* Read to unsigned long long readval output. */
+	for (s = 0; s < CHAR_BIT * TEST_LEN; s++) {
+		for (l = nrbits_ull; l < (CHAR_BIT * TEST_LEN) - s; l++) {
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.c, unsigned char, s, l, src_ull);
+			bt_bitfield_read(target.c, unsigned char, s, l, &readval_ull);
+			if (check_result(src_ull, readval_ull, target.c, unsigned char,
+					  s, l, UNSIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.s, unsigned char, s, l, src_ull);
+			bt_bitfield_read(target.c, unsigned short, s, l, &readval_ull);
+			if (check_result(src_ull, readval_ull, target.c, unsigned short,
+					  s, l, UNSIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.i, unsigned char, s, l, src_ull);
+			bt_bitfield_read(target.c, unsigned int, s, l, &readval_ull);
+			if (check_result(src_ull, readval_ull, target.c, unsigned int,
+					   s, l, UNSIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.l, unsigned char, s, l, src_ull);
+			bt_bitfield_read(target.c, unsigned long, s, l, &readval_ull);
+			if (check_result(src_ull, readval_ull, target.c, unsigned long,
+					  s, l, UNSIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.ll, unsigned char, s, l, src_ull);
+			bt_bitfield_read(target.c, unsigned long long, s, l, &readval_ull);
+			if (check_result(src_ull, readval_ull, target.c, unsigned long long,
+				     s, l, UNSIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
+				return;
+			}
+		}
+	}
+	pass(UNSIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR, src_ull);
+}
+
+void run_test_unsigned(void)
+{
+	run_test_unsigned_write();
+	run_test_unsigned_read();
+}
+
+void run_test_signed_write(void)
+{
+	int src_i, nrbits_i, nrbits_ll;
 	union {
 		signed char c[TEST_LEN];
 		short s[TEST_LEN/sizeof(short)];
@@ -206,88 +442,272 @@ void run_test_signed(void)
 		long l[TEST_LEN/sizeof(long)];
 		long long ll[TEST_LEN/sizeof(long long)];
 	} target;
-	long long readval;
+	long long src_ll, readval;
 	unsigned int s, l;
 
-	src = srcrand;
-	if (src & 0x80000000U)
-		nrbits = fls(~src) + 1;	/* Find least significant bit conveying sign */
+	src_i = srcrand_ui;
+	if (src_i & 0x80000000U)
+		nrbits_i = fls_u32(~src_i) + 1;	/* Find least significant bit conveying sign */
+	else
+		nrbits_i = fls_u32(src_i) + 1;	/* Keep sign at 0 */
+
+	/* Write from signed integer src input. */
+	for (s = 0; s < CHAR_BIT * TEST_LEN; s++) {
+		for (l = nrbits_i; l < (CHAR_BIT * TEST_LEN) - s; l++) {
+			init_byte_array(target.c, TEST_LEN, 0x0);
+			bt_bitfield_write(target.c, signed char, s, l, src_i);
+			bt_bitfield_read(target.c, signed char, s, l, &readval);
+			if (check_result(src_i, readval, target.c, signed char,
+					  s, l, SIGNED_INT_WRITE_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0x0);
+			bt_bitfield_write(target.s, short, s, l, src_i);
+			bt_bitfield_read(target.c, signed char, s, l, &readval);
+			if (check_result(src_i, readval, target.c, short,
+					  s, l, SIGNED_INT_WRITE_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0x0);
+			bt_bitfield_write(target.i, int, s, l, src_i);
+			bt_bitfield_read(target.c, signed char, s, l, &readval);
+			if (check_result(src_i, readval, target.c, int,
+					  s, l, SIGNED_INT_WRITE_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0x0);
+			bt_bitfield_write(target.l, long, s, l, src_i);
+			bt_bitfield_read(target.c, signed char, s, l, &readval);
+			if (check_result(src_i, readval, target.c, long,
+					  s, l, SIGNED_INT_WRITE_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0x0);
+			bt_bitfield_write(target.ll, long long, s, l, src_i);
+			bt_bitfield_read(target.c, signed char, s, l, &readval);
+			if (check_result(src_i, readval, target.c, long long,
+					  s, l, SIGNED_INT_WRITE_TEST_DESC_FMT_STR)) {
+				return;
+			}
+		}
+	}
+	pass(SIGNED_INT_WRITE_TEST_DESC_FMT_STR, src_i);
+
+	src_ll = srcrand_ull;
+	if (src_ll & 0x8000000000000000ULL)
+		nrbits_ll = fls_u64(~src_ll) + 1;	/* Find least significant bit conveying sign */
 	else
-		nrbits = fls(src) + 1;	/* Keep sign at 0 */
+		nrbits_ll = fls_u64(src_ll) + 1;	/* Keep sign at 0 */
 
+	/* Write from signed long long src input. */
 	for (s = 0; s < CHAR_BIT * TEST_LEN; s++) {
-		for (l = nrbits; l < (CHAR_BIT * TEST_LEN) - s; l++) {
+		for (l = nrbits_ll; l < (CHAR_BIT * TEST_LEN) - s; l++) {
 			init_byte_array(target.c, TEST_LEN, 0x0);
-			bt_bitfield_write(target.c, signed char, s, l, src);
+			bt_bitfield_write(target.c, signed char, s, l, src_ll);
 			bt_bitfield_read(target.c, signed char, s, l, &readval);
-			if (check_result(src, readval, target.c, signed char,
-					  s, l, SIGNED_TEST_DESC_FMT_STR)) {
+			if (check_result(src_ll, readval, target.c, signed char,
+					  s, l, SIGNED_LONG_LONG_WRITE_TEST_DESC_FMT_STR)) {
 				return;
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0x0);
-			bt_bitfield_write(target.s, short, s, l, src);
+			bt_bitfield_write(target.s, short, s, l, src_ll);
 			bt_bitfield_read(target.c, signed char, s, l, &readval);
-			if (check_result(src, readval, target.c, short,
-					  s, l, SIGNED_TEST_DESC_FMT_STR)) {
+			if (check_result(src_ll, readval, target.c, short,
+					  s, l, SIGNED_LONG_LONG_WRITE_TEST_DESC_FMT_STR)) {
 				return;
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0x0);
-			bt_bitfield_write(target.i, int, s, l, src);
+			bt_bitfield_write(target.i, int, s, l, src_ll);
 			bt_bitfield_read(target.c, signed char, s, l, &readval);
-			if (check_result(src, readval, target.c, int,
-					  s, l, SIGNED_TEST_DESC_FMT_STR)) {
+			if (check_result(src_ll, readval, target.c, int,
+					  s, l, SIGNED_LONG_LONG_WRITE_TEST_DESC_FMT_STR)) {
 				return;
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0x0);
-			bt_bitfield_write(target.l, long, s, l, src);
+			bt_bitfield_write(target.l, long, s, l, src_ll);
 			bt_bitfield_read(target.c, signed char, s, l, &readval);
-			if (check_result(src, readval, target.c, long,
-					  s, l, SIGNED_TEST_DESC_FMT_STR)) {
+			if (check_result(src_ll, readval, target.c, long,
+					  s, l, SIGNED_LONG_LONG_WRITE_TEST_DESC_FMT_STR)) {
 				return;
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0x0);
-			bt_bitfield_write(target.ll, long long, s, l, src);
+			bt_bitfield_write(target.ll, long long, s, l, src_ll);
 			bt_bitfield_read(target.c, signed char, s, l, &readval);
-			if (check_result(src, readval, target.c, long long,
-					  s, l, SIGNED_TEST_DESC_FMT_STR)) {
+			if (check_result(src_ll, readval, target.c, long long,
+					  s, l, SIGNED_LONG_LONG_WRITE_TEST_DESC_FMT_STR)) {
 				return;
 			}
 		}
 	}
+	pass(SIGNED_LONG_LONG_WRITE_TEST_DESC_FMT_STR, src_ll);
+}
 
-	pass(SIGNED_TEST_DESC_FMT_STR, src);
+void run_test_signed_read(void)
+{
+	int src_i, nrbits_i, nrbits_ll, readval_i;
+	union {
+		unsigned char c[TEST_LEN];
+		unsigned short s[TEST_LEN/sizeof(unsigned short)];
+		unsigned int i[TEST_LEN/sizeof(unsigned int)];
+		unsigned long l[TEST_LEN/sizeof(unsigned long)];
+		unsigned long long ll[TEST_LEN/sizeof(unsigned long long)];
+	} target;
+	long long src_ll, readval_ll;
+	unsigned int s, l;
+
+	src_i = srcrand_ui;
+	if (src_i & 0x80000000U)
+		nrbits_i = fls_u32(~src_i) + 1;	/* Find least significant bit conveying sign */
+	else
+		nrbits_i = fls_u32(src_i) + 1;	/* Keep sign at 0 */
+
+	/* Read to signed integer readval output. */
+	for (s = 0; s < CHAR_BIT * TEST_LEN; s++) {
+		for (l = nrbits_i; l < (CHAR_BIT * TEST_LEN) - s; l++) {
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.c, signed char, s, l, src_i);
+			bt_bitfield_read(target.c, signed char, s, l, &readval_i);
+			if (check_result(src_i, readval_i, target.c, signed char,
+					  s, l, SIGNED_INT_READ_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.s, signed char, s, l, src_i);
+			bt_bitfield_read(target.c, short, s, l, &readval_i);
+			if (check_result(src_i, readval_i, target.c, short,
+					  s, l, SIGNED_INT_READ_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.i, signed char, s, l, src_i);
+			bt_bitfield_read(target.c, int, s, l, &readval_i);
+			if (check_result(src_i, readval_i, target.c, int,
+					   s, l, SIGNED_INT_READ_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.l, signed char, s, l, src_i);
+			bt_bitfield_read(target.c, long, s, l, &readval_i);
+			if (check_result(src_i, readval_i, target.c, long,
+					  s, l, SIGNED_INT_READ_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.ll, signed char, s, l, src_i);
+			bt_bitfield_read(target.c, long long, s, l, &readval_i);
+			if (check_result(src_i, readval_i, target.c, long long,
+				     s, l, SIGNED_INT_READ_TEST_DESC_FMT_STR)) {
+				return;
+			}
+		}
+	}
+	pass(SIGNED_INT_READ_TEST_DESC_FMT_STR, src_i);
+
+	src_ll = srcrand_ull;
+	if (src_ll & 0x8000000000000000ULL)
+		nrbits_ll = fls_u64(~src_ll) + 1;	/* Find least significant bit conveying sign */
+	else
+		nrbits_ll = fls_u64(src_ll) + 1;	/* Keep sign at 0 */
+
+	/* Read to unsigned long long readval output. */
+	for (s = 0; s < CHAR_BIT * TEST_LEN; s++) {
+		for (l = nrbits_ll; l < (CHAR_BIT * TEST_LEN) - s; l++) {
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.c, signed char, s, l, src_ll);
+			bt_bitfield_read(target.c, signed char, s, l, &readval_ll);
+			if (check_result(src_ll, readval_ll, target.c, signed char,
+					  s, l, SIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.s, signed char, s, l, src_ll);
+			bt_bitfield_read(target.c, short, s, l, &readval_ll);
+			if (check_result(src_ll, readval_ll, target.c, short,
+					  s, l, SIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.i, signed char, s, l, src_ll);
+			bt_bitfield_read(target.c, int, s, l, &readval_ll);
+			if (check_result(src_ll, readval_ll, target.c, int,
+					   s, l, SIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.l, signed char, s, l, src_ll);
+			bt_bitfield_read(target.c, long, s, l, &readval_ll);
+			if (check_result(src_ll, readval_ll, target.c, long,
+					  s, l, SIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.ll, signed char, s, l, src_ll);
+			bt_bitfield_read(target.c, long long, s, l, &readval_ll);
+			if (check_result(src_ll, readval_ll, target.c, long long,
+				     s, l, SIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
+				return;
+			}
+		}
+	}
+	pass(SIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR, src_ll);
+}
+
+void run_test_signed(void)
+{
+	run_test_signed_write();
+	run_test_signed_read();
 }
 
 void run_test(void)
 {
 	int i;
-	plan_tests(NR_TESTS * 2 + 6);
+	plan_tests(NR_TESTS * 8 + 24);
 
 	srand(time(NULL));
 
-	srcrand = 0;
+	srcrand_ui = 0;
+	srcrand_ull = 0;
 	run_test_unsigned();
-	srcrand = 0;
+	srcrand_ui = 0;
+	srcrand_ull = 0;
 	run_test_signed();
 
-	srcrand = 1;
+	srcrand_ui = 1;
+	srcrand_ull = 1;
 	run_test_unsigned();
 
-	srcrand = ~0U;
+	srcrand_ui = ~0U;
+	srcrand_ull = ~0ULL;
 	run_test_unsigned();
 
-	srcrand = -1;
+	srcrand_ui = -1U;
+	srcrand_ull = -1ULL;
 	run_test_signed();
 
-	srcrand = (int)0x80000000U;
+	srcrand_ui = 0x80000000U;
+	srcrand_ull = 0x8000000000000000ULL;
 	run_test_signed();
 
 	for (i = 0; i < NR_TESTS; i++) {
-		srcrand = rand();
+		srcrand_ui = rand();
+		srcrand_ull = ((unsigned long long) (unsigned int) rand() << 32) |
+				(unsigned long long) (unsigned int) rand();
 		run_test_unsigned();
 		run_test_signed();
 	}
-- 
2.11.0
