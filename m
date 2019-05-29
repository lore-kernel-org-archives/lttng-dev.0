From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace 1/1] Fix: test_bitfield: extend
 coverage by removing off-by-one in bound check
Date: Wed, 29 May 2019 15:06:59 -0400
Message-ID: <20190529190659.23235-1-mathieu.desnoyers__24900.8638829522$1559156844$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45DgF86XQFz10kj
 for <lttng-dev@lists.lttng.org>; Wed, 29 May 2019 15:07:08 -0400 (EDT)
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

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Change-Id: I4fbf927d4b2ff1c8b68b05c7843298c64b68f5a4
---
 tests/lib/test_bitfield.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tests/lib/test_bitfield.c b/tests/lib/test_bitfield.c
index bc61e118..5188335b 100644
--- a/tests/lib/test_bitfield.c
+++ b/tests/lib/test_bitfield.c
@@ -161,11 +161,12 @@ void run_test_unsigned_write(unsigned int src_ui, unsigned long long src_ull)
 	unsigned long long readval;
 	unsigned int s, l;
 
+	/* The number of bits needed to represent 0 is 0. */
 	nrbits_ui = fls_u32(src_ui);
 
 	/* Write from unsigned integer src input. */
 	for (s = 0; s < CHAR_BIT * TEST_LEN; s++) {
-		for (l = nrbits_ui; l < (CHAR_BIT * TEST_LEN) - s; l++) {
+		for (l = nrbits_ui; l <= (CHAR_BIT * TEST_LEN) - s; l++) {
 			init_byte_array(target.c, TEST_LEN, 0xFF);
 			bt_bitfield_write(target.c, unsigned char, s, l, src_ui);
 			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
@@ -209,11 +210,12 @@ void run_test_unsigned_write(unsigned int src_ui, unsigned long long src_ull)
 	}
 	pass(UNSIGNED_INT_WRITE_TEST_DESC_FMT_STR, src_ui);
 
+	/* The number of bits needed to represent 0 is 0. */
 	nrbits_ull = fls_u64(src_ull);
 
 	/* Write from unsigned long long src input. */
 	for (s = 0; s < CHAR_BIT * TEST_LEN; s++) {
-		for (l = nrbits_ull; l < (CHAR_BIT * TEST_LEN) - s; l++) {
+		for (l = nrbits_ull; l <= (CHAR_BIT * TEST_LEN) - s; l++) {
 			init_byte_array(target.c, TEST_LEN, 0xFF);
 			bt_bitfield_write(target.c, unsigned char, s, l, src_ull);
 			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
@@ -271,11 +273,12 @@ void run_test_unsigned_read(unsigned int src_ui, unsigned long long src_ull)
 	unsigned long long readval_ull;
 	unsigned int s, l;
 
+	/* The number of bits needed to represent 0 is 0. */
 	nrbits_ui = fls_u32(src_ui);
 
 	/* Read to unsigned integer readval output. */
 	for (s = 0; s < CHAR_BIT * TEST_LEN; s++) {
-		for (l = nrbits_ui; l < (CHAR_BIT * TEST_LEN) - s; l++) {
+		for (l = nrbits_ui; l <= (CHAR_BIT * TEST_LEN) - s; l++) {
 			init_byte_array(target.c, TEST_LEN, 0xFF);
 			bt_bitfield_write(target.c, unsigned char, s, l, src_ui);
 			bt_bitfield_read(target.c, unsigned char, s, l, &readval_ui);
@@ -319,11 +322,12 @@ void run_test_unsigned_read(unsigned int src_ui, unsigned long long src_ull)
 	}
 	pass(UNSIGNED_INT_READ_TEST_DESC_FMT_STR, src_ui);
 
+	/* The number of bits needed to represent 0 is 0. */
 	nrbits_ull = fls_u64(src_ull);
 
 	/* Read to unsigned long long readval output. */
 	for (s = 0; s < CHAR_BIT * TEST_LEN; s++) {
-		for (l = nrbits_ull; l < (CHAR_BIT * TEST_LEN) - s; l++) {
+		for (l = nrbits_ull; l <= (CHAR_BIT * TEST_LEN) - s; l++) {
 			init_byte_array(target.c, TEST_LEN, 0xFF);
 			bt_bitfield_write(target.c, unsigned char, s, l, src_ull);
 			bt_bitfield_read(target.c, unsigned char, s, l, &readval_ull);
@@ -394,7 +398,7 @@ void run_test_signed_write(int src_i, long long src_ll)
 
 	/* Write from signed integer src input. */
 	for (s = 0; s < CHAR_BIT * TEST_LEN; s++) {
-		for (l = nrbits_i; l < (CHAR_BIT * TEST_LEN) - s; l++) {
+		for (l = nrbits_i; l <= (CHAR_BIT * TEST_LEN) - s; l++) {
 			init_byte_array(target.c, TEST_LEN, 0x0);
 			bt_bitfield_write(target.c, signed char, s, l, src_i);
 			bt_bitfield_read(target.c, signed char, s, l, &readval);
@@ -445,7 +449,7 @@ void run_test_signed_write(int src_i, long long src_ll)
 
 	/* Write from signed long long src input. */
 	for (s = 0; s < CHAR_BIT * TEST_LEN; s++) {
-		for (l = nrbits_ll; l < (CHAR_BIT * TEST_LEN) - s; l++) {
+		for (l = nrbits_ll; l <= (CHAR_BIT * TEST_LEN) - s; l++) {
 			init_byte_array(target.c, TEST_LEN, 0x0);
 			bt_bitfield_write(target.c, signed char, s, l, src_ll);
 			bt_bitfield_read(target.c, signed char, s, l, &readval);
@@ -510,7 +514,7 @@ void run_test_signed_read(int src_i, long long src_ll)
 
 	/* Read to signed integer readval output. */
 	for (s = 0; s < CHAR_BIT * TEST_LEN; s++) {
-		for (l = nrbits_i; l < (CHAR_BIT * TEST_LEN) - s; l++) {
+		for (l = nrbits_i; l <= (CHAR_BIT * TEST_LEN) - s; l++) {
 			init_byte_array(target.c, TEST_LEN, 0xFF);
 			bt_bitfield_write(target.c, signed char, s, l, src_i);
 			bt_bitfield_read(target.c, signed char, s, l, &readval_i);
@@ -561,7 +565,7 @@ void run_test_signed_read(int src_i, long long src_ll)
 
 	/* Read to signed long long readval output. */
 	for (s = 0; s < CHAR_BIT * TEST_LEN; s++) {
-		for (l = nrbits_ll; l < (CHAR_BIT * TEST_LEN) - s; l++) {
+		for (l = nrbits_ll; l <= (CHAR_BIT * TEST_LEN) - s; l++) {
 			init_byte_array(target.c, TEST_LEN, 0xFF);
 			bt_bitfield_write(target.c, signed char, s, l, src_ll);
 			bt_bitfield_read(target.c, signed char, s, l, &readval_ll);
-- 
2.11.0
