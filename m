From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace 1/1] Fix: test_bitfield: buffer
 overrun accesses
Date: Sat, 18 May 2019 16:25:23 -0400
Message-ID: <20190518202523.23618-1-mathieu.desnoyers__15170.0908363395$1558211488$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 455xVm02Vyzyvj
 for <lttng-dev@lists.lttng.org>; Sat, 18 May 2019 16:25:35 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, simon.marchi@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This issue is due to a type mismatch between union member vs type passed
as parameter to the macros as found by Coverity:

** CID 1401409:  Memory - corruptions  (OVERRUN)
/tests/lib/test_bitfield.c: 450 in run_test_signed_write()

Issue introduced by commit 0675eb8c07 "Extend test_bitfield coverage"

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Change-Id: I14c9d69011b369e5dc8be4305ac8bf32cc86d3dd
---
 tests/lib/test_bitfield.c | 64 +++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/tests/lib/test_bitfield.c b/tests/lib/test_bitfield.c
index 5ba566f6..bc61e118 100644
--- a/tests/lib/test_bitfield.c
+++ b/tests/lib/test_bitfield.c
@@ -285,32 +285,32 @@ void run_test_unsigned_read(unsigned int src_ui, unsigned long long src_ull)
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.s, unsigned char, s, l, src_ui);
-			bt_bitfield_read(target.c, unsigned short, s, l, &readval_ui);
+			bt_bitfield_write(target.c, unsigned char, s, l, src_ui);
+			bt_bitfield_read(target.s, unsigned short, s, l, &readval_ui);
 			if (check_result(src_ui, readval_ui, target.c, unsigned short,
 					s, l, UNSIGNED_INT_READ_TEST_DESC_FMT_STR)) {
 				return;
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.i, unsigned char, s, l, src_ui);
-			bt_bitfield_read(target.c, unsigned int, s, l, &readval_ui);
+			bt_bitfield_write(target.c, unsigned char, s, l, src_ui);
+			bt_bitfield_read(target.i, unsigned int, s, l, &readval_ui);
 			if (check_result(src_ui, readval_ui, target.c, unsigned int,
 					s, l, UNSIGNED_INT_READ_TEST_DESC_FMT_STR)) {
 				return;
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.l, unsigned char, s, l, src_ui);
-			bt_bitfield_read(target.c, unsigned long, s, l, &readval_ui);
+			bt_bitfield_write(target.c, unsigned char, s, l, src_ui);
+			bt_bitfield_read(target.l, unsigned long, s, l, &readval_ui);
 			if (check_result(src_ui, readval_ui, target.c, unsigned long,
 					s, l, UNSIGNED_INT_READ_TEST_DESC_FMT_STR)) {
 				return;
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.ll, unsigned char, s, l, src_ui);
-			bt_bitfield_read(target.c, unsigned long long, s, l, &readval_ui);
+			bt_bitfield_write(target.c, unsigned char, s, l, src_ui);
+			bt_bitfield_read(target.ll, unsigned long long, s, l, &readval_ui);
 			if (check_result(src_ui, readval_ui, target.c, unsigned long long,
 					s, l, UNSIGNED_INT_READ_TEST_DESC_FMT_STR)) {
 				return;
@@ -333,32 +333,32 @@ void run_test_unsigned_read(unsigned int src_ui, unsigned long long src_ull)
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.s, unsigned char, s, l, src_ull);
-			bt_bitfield_read(target.c, unsigned short, s, l, &readval_ull);
+			bt_bitfield_write(target.c, unsigned char, s, l, src_ull);
+			bt_bitfield_read(target.s, unsigned short, s, l, &readval_ull);
 			if (check_result(src_ull, readval_ull, target.c, unsigned short,
 					s, l, UNSIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
 				return;
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.i, unsigned char, s, l, src_ull);
-			bt_bitfield_read(target.c, unsigned int, s, l, &readval_ull);
+			bt_bitfield_write(target.c, unsigned char, s, l, src_ull);
+			bt_bitfield_read(target.i, unsigned int, s, l, &readval_ull);
 			if (check_result(src_ull, readval_ull, target.c, unsigned int,
 					s, l, UNSIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
 				return;
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.l, unsigned char, s, l, src_ull);
-			bt_bitfield_read(target.c, unsigned long, s, l, &readval_ull);
+			bt_bitfield_write(target.c, unsigned char, s, l, src_ull);
+			bt_bitfield_read(target.l, unsigned long, s, l, &readval_ull);
 			if (check_result(src_ull, readval_ull, target.c, unsigned long,
 					s, l, UNSIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
 				return;
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.ll, unsigned char, s, l, src_ull);
-			bt_bitfield_read(target.c, unsigned long long, s, l, &readval_ull);
+			bt_bitfield_write(target.c, unsigned char, s, l, src_ull);
+			bt_bitfield_read(target.ll, unsigned long long, s, l, &readval_ull);
 			if (check_result(src_ull, readval_ull, target.c, unsigned long long,
 					s, l, UNSIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
 				return;
@@ -520,32 +520,32 @@ void run_test_signed_read(int src_i, long long src_ll)
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.s, signed char, s, l, src_i);
-			bt_bitfield_read(target.c, short, s, l, &readval_i);
+			bt_bitfield_write(target.c, signed char, s, l, src_i);
+			bt_bitfield_read(target.s, short, s, l, &readval_i);
 			if (check_result(src_i, readval_i, target.c, short,
 					s, l, SIGNED_INT_READ_TEST_DESC_FMT_STR)) {
 				return;
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.i, signed char, s, l, src_i);
-			bt_bitfield_read(target.c, int, s, l, &readval_i);
+			bt_bitfield_write(target.c, signed char, s, l, src_i);
+			bt_bitfield_read(target.i, int, s, l, &readval_i);
 			if (check_result(src_i, readval_i, target.c, int,
 					s, l, SIGNED_INT_READ_TEST_DESC_FMT_STR)) {
 				return;
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.l, signed char, s, l, src_i);
-			bt_bitfield_read(target.c, long, s, l, &readval_i);
+			bt_bitfield_write(target.c, signed char, s, l, src_i);
+			bt_bitfield_read(target.l, long, s, l, &readval_i);
 			if (check_result(src_i, readval_i, target.c, long,
 					s, l, SIGNED_INT_READ_TEST_DESC_FMT_STR)) {
 				return;
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.ll, signed char, s, l, src_i);
-			bt_bitfield_read(target.c, long long, s, l, &readval_i);
+			bt_bitfield_write(target.c, signed char, s, l, src_i);
+			bt_bitfield_read(target.ll, long long, s, l, &readval_i);
 			if (check_result(src_i, readval_i, target.c, long long,
 					s, l, SIGNED_INT_READ_TEST_DESC_FMT_STR)) {
 				return;
@@ -571,32 +571,32 @@ void run_test_signed_read(int src_i, long long src_ll)
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.s, signed char, s, l, src_ll);
-			bt_bitfield_read(target.c, short, s, l, &readval_ll);
+			bt_bitfield_write(target.c, signed char, s, l, src_ll);
+			bt_bitfield_read(target.s, short, s, l, &readval_ll);
 			if (check_result(src_ll, readval_ll, target.c, short,
 					s, l, SIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
 				return;
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.i, signed char, s, l, src_ll);
-			bt_bitfield_read(target.c, int, s, l, &readval_ll);
+			bt_bitfield_write(target.c, signed char, s, l, src_ll);
+			bt_bitfield_read(target.i, int, s, l, &readval_ll);
 			if (check_result(src_ll, readval_ll, target.c, int,
 					s, l, SIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
 				return;
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.l, signed char, s, l, src_ll);
-			bt_bitfield_read(target.c, long, s, l, &readval_ll);
+			bt_bitfield_write(target.c, signed char, s, l, src_ll);
+			bt_bitfield_read(target.l, long, s, l, &readval_ll);
 			if (check_result(src_ll, readval_ll, target.c, long,
 					s, l, SIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
 				return;
 			}
 
 			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.ll, signed char, s, l, src_ll);
-			bt_bitfield_read(target.c, long long, s, l, &readval_ll);
+			bt_bitfield_write(target.c, signed char, s, l, src_ll);
+			bt_bitfield_read(target.ll, long long, s, l, &readval_ll);
 			if (check_result(src_ll, readval_ll, target.c, long long,
 					s, l, SIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
 				return;
-- 
2.11.0
