From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH babeltrace 2/5] Tests: Rename tests under lib
	with tests naming convention
Date: Tue, 20 Aug 2013 17:38:18 -0400
Message-ID: <1377034701-5142-2-git-send-email-christian.babeux__36734.0531935499$1377034984$gmane$org@efficios.com>
References: <1377034701-5142-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f45.google.com ([209.85.128.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1VBtdP-0005Pj-BA
	for lttng-dev@lists.lttng.org; Tue, 20 Aug 2013 17:38:47 -0400
Received: by mail-qe0-f45.google.com with SMTP id nc12so562584qeb.32
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 14:38:33 -0700 (PDT)
In-Reply-To: <1377034701-5142-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/lib/Makefile.am     |   8 +-
 tests/lib/runall.sh       |   6 +-
 tests/lib/test-bitfield.c | 363 ----------------------------------------------
 tests/lib/test-seeks.c    | 302 --------------------------------------
 tests/lib/test_bitfield.c | 363 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/lib/test_seek.c     | 302 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 672 insertions(+), 672 deletions(-)
 delete mode 100644 tests/lib/test-bitfield.c
 delete mode 100644 tests/lib/test-seeks.c
 create mode 100644 tests/lib/test_bitfield.c
 create mode 100644 tests/lib/test_seek.c

diff --git a/tests/lib/Makefile.am b/tests/lib/Makefile.am
index 6ae694d..a7de0a9 100644
--- a/tests/lib/Makefile.am
+++ b/tests/lib/Makefile.am
@@ -6,16 +6,16 @@ LIBTAP=$(top_builddir)/tests/utils/tap/libtap.la
 
 libtestcommon_a_SOURCES = common.c common.h
 
-test_seeks_LDADD = $(LIBTAP) libtestcommon.a \
+test_seek_LDADD = $(LIBTAP) libtestcommon.a \
 	$(top_builddir)/lib/libbabeltrace.la \
 	$(top_builddir)/formats/ctf/libbabeltrace-ctf.la
 
 test_bitfield_LDADD = $(LIBTAP) libtestcommon.a
 
-noinst_PROGRAMS = test-seeks test-bitfield
+noinst_PROGRAMS = test_seek test_bitfield
 
-test_seeks_SOURCES = test-seeks.c
-test_bitfield_SOURCES = test-bitfield.c
+test_seek_SOURCES = test_seek.c
+test_bitfield_SOURCES = test_bitfield.c
 
 EXTRA_DIST = runall.sh
 
diff --git a/tests/lib/runall.sh b/tests/lib/runall.sh
index b5522ad..5c28299 100755
--- a/tests/lib/runall.sh
+++ b/tests/lib/runall.sh
@@ -1,9 +1,9 @@
 #!/bin/sh
 # run Seeks tests
 # With a trace than contains empty packets
-./test-seeks ../ctf-traces/succeed/wk-heartbeat-u/ 1351532897586558519 1351532897591331194
+./test_seek ../ctf-traces/succeed/wk-heartbeat-u/ 1351532897586558519 1351532897591331194
 # With a bigger trace
-./test-seeks ../ctf-traces/succeed/lttng-modules-2.0-pre5/ 61334174524234 61336381998396
+./test_seek ../ctf-traces/succeed/lttng-modules-2.0-pre5/ 61334174524234 61336381998396
 
 # run bitfield tests
-./test-bitfield
+./test_bitfield
diff --git a/tests/lib/test-bitfield.c b/tests/lib/test-bitfield.c
deleted file mode 100644
index 16e8a57..0000000
--- a/tests/lib/test-bitfield.c
+++ /dev/null
@@ -1,363 +0,0 @@
-/*
- * test-bitfield.c
- *
- * BabelTrace - bitfield test program
- *
- * Copyright 2010 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; under version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#define _GNU_SOURCE
-#include <babeltrace/bitfield.h>
-#include <time.h>
-#include <stdlib.h>
-#include <stdio.h>
-
-#include <tap/tap.h>
-
-unsigned int glob;
-
-/*
- * This function is only declared to show the size of a bitfield write in
- * objdump.
- */
-void fct(void)
-{
-	bt_bitfield_write(&glob, unsigned int, 12, 15, 0x12345678);
-}
-
-/* Test array size, in bytes */
-#define TEST_LEN 128
-#define NR_TESTS 10
-#define SIGNED_TEST_DESC_FMT_STR "Writing and reading back 0x%X, signed"
-#define UNSIGNED_TEST_DESC_FMT_STR "Writing and reading back 0x%X, unsigned"
-#define DIAG_FMT_STR "Failed reading value written \"%s\"-wise, with start=%i" \
-	" and length=%i. Read %llX"
-
-unsigned int srcrand;
-
-#if defined(__i386) || defined(__x86_64)
-
-static inline int fls(int x)
-{
-	int r;
-	asm("bsrl %1,%0\n\t"
-	    "cmovzl %2,%0"
-	    : "=&r" (r) : "rm" (x), "rm" (-1));
-	return r + 1;
-}
-
-#elif defined(__PPC__)
-
-static __inline__ int fls(unsigned int x)
-{
-	int lz;
-
-	asm ("cntlzw %0,%1" : "=r" (lz) : "r" (x));
-	return 32 - lz;
-}
-
-#else
-
-static int fls(unsigned int x)
-{
-	int r = 32;
-
-	if (!x)
-		return 0;
-	if (!(x & 0xFFFF0000U)) {
-		x <<= 16;
-		r -= 16;
-	}
-	if (!(x & 0xFF000000U)) {
-		x <<= 8;
-		r -= 8;
-	}
-	if (!(x & 0xF0000000U)) {
-		x <<= 4;
-		r -= 4;
-	}
-	if (!(x & 0xC0000000U)) {
-		x <<= 2;
-		r -= 2;
-	}
-	if (!(x & 0x80000000U)) {
-		x <<= 1;
-		r -= 1;
-	}
-	return r;
-}
-
-#endif
-
-#define print_byte_array(c, len)	\
-do {					\
-	unsigned long i;		\
-					\
-	for (i = 0; i < (len); i++) {	\
-		printf("0x%X", (c)[i]);	\
-		if (i != (len) - 1)	\
-			printf(" ");	\
-	}				\
-	printf("\n");			\
-} while (0)
-
-#define init_byte_array(c, len, val)	\
-do {					\
-	unsigned long i;		\
-					\
-	for (i = 0; i < (len); i++)	\
-		(c)[i] = (val);		\
-} while (0)
-
-#define check_result(ref, val, buffer, typename, start, len,		\
-		     desc_fmt_str)					\
-({									\
-	if ((val) != (ref)) {						\
-		fail(desc_fmt_str, ref);				\
-		diag(DIAG_FMT_STR, #typename, start, len, val);		\
-		printf("# ");						\
-		print_byte_array(buffer, TEST_LEN);			\
-	}								\
-	(val) != (ref);							\
-})
-
-void run_test_unsigned(void)
-{
-	unsigned int src, nrbits;
-	union {
-		unsigned char c[TEST_LEN];
-		unsigned short s[TEST_LEN/sizeof(unsigned short)];
-		unsigned int i[TEST_LEN/sizeof(unsigned int)];
-		unsigned long l[TEST_LEN/sizeof(unsigned long)];
-		unsigned long long ll[TEST_LEN/sizeof(unsigned long long)];
-	} target;
-	unsigned long long readval;
-	unsigned int s, l;
-
-	src = srcrand;
-	nrbits = fls(src);
-
-	for (s = 0; s < CHAR_BIT * TEST_LEN; s++) {
-		for (l = nrbits; l < (CHAR_BIT * TEST_LEN) - s; l++) {
-			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.c, unsigned char, s, l, src);
-			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
-			if (check_result(src, readval, target.c, unsigned char,
-					  s, l, UNSIGNED_TEST_DESC_FMT_STR)) {
-				return;
-			}
-
-			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.s, unsigned short, s, l, src);
-			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
-			if (check_result(src, readval, target.c, unsigned short,
-					  s, l, UNSIGNED_TEST_DESC_FMT_STR)) {
-				return;
-			}
-
-			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.i, unsigned int, s, l, src);
-			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
-			if (check_result(src, readval, target.c, unsigned int,
-					   s, l, UNSIGNED_TEST_DESC_FMT_STR)) {
-				return;
-			}
-
-			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.l, unsigned long, s, l, src);
-			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
-			if (check_result(src, readval, target.c, unsigned long,
-					  s, l, UNSIGNED_TEST_DESC_FMT_STR)) {
-				return;
-			}
-
-			init_byte_array(target.c, TEST_LEN, 0xFF);
-			bt_bitfield_write(target.ll, unsigned long long, s, l, src);
-			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
-			if (check_result(src, readval, target.c, unsigned long long,
-				     s, l, UNSIGNED_TEST_DESC_FMT_STR)) {
-				return;
-			}
-		}
-	}
-
-	pass(UNSIGNED_TEST_DESC_FMT_STR, src);
-}
-
-void run_test_signed(void)
-{
-	int src, nrbits;
-	union {
-		signed char c[TEST_LEN];
-		short s[TEST_LEN/sizeof(short)];
-		int i[TEST_LEN/sizeof(int)];
-		long l[TEST_LEN/sizeof(long)];
-		long long ll[TEST_LEN/sizeof(long long)];
-	} target;
-	long long readval;
-	unsigned int s, l;
-
-	src = srcrand;
-	if (src & 0x80000000U)
-		nrbits = fls(~src) + 1;	/* Find least significant bit conveying sign */
-	else
-		nrbits = fls(src) + 1;	/* Keep sign at 0 */
-
-	for (s = 0; s < CHAR_BIT * TEST_LEN; s++) {
-		for (l = nrbits; l < (CHAR_BIT * TEST_LEN) - s; l++) {
-			init_byte_array(target.c, TEST_LEN, 0x0);
-			bt_bitfield_write(target.c, signed char, s, l, src);
-			bt_bitfield_read(target.c, signed char, s, l, &readval);
-			if (check_result(src, readval, target.c, signed char,
-					  s, l, SIGNED_TEST_DESC_FMT_STR)) {
-				return;
-			}
-
-			init_byte_array(target.c, TEST_LEN, 0x0);
-			bt_bitfield_write(target.s, short, s, l, src);
-			bt_bitfield_read(target.c, signed char, s, l, &readval);
-			if (check_result(src, readval, target.c, short,
-					  s, l, SIGNED_TEST_DESC_FMT_STR)) {
-				return;
-			}
-
-			init_byte_array(target.c, TEST_LEN, 0x0);
-			bt_bitfield_write(target.i, int, s, l, src);
-			bt_bitfield_read(target.c, signed char, s, l, &readval);
-			if (check_result(src, readval, target.c, int,
-					  s, l, SIGNED_TEST_DESC_FMT_STR)) {
-				return;
-			}
-
-			init_byte_array(target.c, TEST_LEN, 0x0);
-			bt_bitfield_write(target.l, long, s, l, src);
-			bt_bitfield_read(target.c, signed char, s, l, &readval);
-			if (check_result(src, readval, target.c, long,
-					  s, l, SIGNED_TEST_DESC_FMT_STR)) {
-				return;
-			}
-
-			init_byte_array(target.c, TEST_LEN, 0x0);
-			bt_bitfield_write(target.ll, long long, s, l, src);
-			bt_bitfield_read(target.c, signed char, s, l, &readval);
-			if (check_result(src, readval, target.c, long long,
-					  s, l, SIGNED_TEST_DESC_FMT_STR)) {
-				return;
-			}
-		}
-	}
-
-	pass(SIGNED_TEST_DESC_FMT_STR, src);
-}
-
-void run_test(void)
-{
-	int i;
-	plan_tests(NR_TESTS * 2 + 6);
-
-	srand(time(NULL));
-
-	srcrand = 0;
-	run_test_unsigned();
-	srcrand = 0;
-	run_test_signed();
-
-	srcrand = 1;
-	run_test_unsigned();
-
-	srcrand = ~0U;
-	run_test_unsigned();
-
-	srcrand = -1;
-	run_test_signed();
-
-	srcrand = (int)0x80000000U;
-	run_test_signed();
-
-	for (i = 0; i < NR_TESTS; i++) {
-		srcrand = rand();
-		run_test_unsigned();
-		run_test_signed();
-	}
-}
-
-static
-int print_encodings(unsigned long src, unsigned int shift, unsigned int len)
-{
-	union {
-		unsigned char c[8];
-		unsigned short s[4];
-		unsigned int i[2];
-		unsigned long l[2];
-		unsigned long long ll[1];
-	} target;
-	unsigned long long readval;
-
-	init_byte_array(target.c, 8, 0xFF);
-	bt_bitfield_write(target.c, unsigned char, shift, len, src);
-	printf("bytewise\n");
-	print_byte_array(target.c, 8);
-
-	init_byte_array(target.c, 8, 0xFF);
-	bt_bitfield_write(target.s, unsigned short, shift, len, src);
-	printf("shortwise\n");
-	print_byte_array(target.c, 8);
-
-	init_byte_array(target.c, 8, 0xFF);
-	bt_bitfield_write(target.i, unsigned int, shift, len, src);
-	printf("intwise\n");
-	print_byte_array(target.c, 8);
-
-	init_byte_array(target.c, 8, 0xFF);
-	bt_bitfield_write(target.l, unsigned long, shift, len, src);
-	printf("longwise\n");
-	print_byte_array(target.c, 8);
-
-	init_byte_array(target.c, 8, 0xFF);
-	bt_bitfield_write(target.ll, unsigned long long, shift, len, src);
-	printf("lluwise\n");
-	print_byte_array(target.c, 8);
-
-	bt_bitfield_read(target.c, unsigned char, shift, len, &readval);
-	printf("read: %llX\n", readval);
-	print_byte_array(target.c, 8);
-
-	return 0;
-}
-
-int main(int argc, char **argv)
-{
-	if (argc > 1) {
-		/* Print encodings */
-		unsigned long src;
-		unsigned int shift, len;
-
-		src = atoi(argv[1]);
-		if (argc > 2)
-			shift = atoi(argv[2]);
-		else
-			shift = 12;
-		if (argc > 3)
-			len = atoi(argv[3]);
-		else
-			len = 40;
-		return print_encodings(src, shift, len);
-	}
-
-	/* Run tap-formated tests */
-	run_test();
-	return exit_status();
-}
diff --git a/tests/lib/test-seeks.c b/tests/lib/test-seeks.c
deleted file mode 100644
index b33f80d..0000000
--- a/tests/lib/test-seeks.c
+++ /dev/null
@@ -1,302 +0,0 @@
-/*
- * test-seeks.c
- *
- * Lib BabelTrace - Seeks test program
- *
- * Copyright 2012 - Yannick Brosseau <yannick.brosseau@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; under version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-#define _GNU_SOURCE
-#include <babeltrace/context.h>
-#include <babeltrace/iterator.h>
-#include <babeltrace/ctf/iterator.h>
-#include <babeltrace/ctf/events.h>
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <limits.h>
-
-#include <tap/tap.h>
-#include "common.h"
-
-#define NR_TESTS	29
-
-void run_seek_begin(char *path, uint64_t expected_begin)
-{
-	struct bt_context *ctx;
-	struct bt_ctf_iter *iter;
-	struct bt_ctf_event *event;
-	struct bt_iter_pos newpos;
-	int ret;
-	uint64_t timestamp_begin;
-	uint64_t timestamp_seek_begin;
-
-	/* Open the trace */
-	ctx = create_context_with_path(path);
-	if (!ctx) {
-		plan_skip_all("Cannot create valid context");
-	}
-
-	/* Create iterator with null begin and end */
-	iter = bt_ctf_iter_create(ctx, NULL, NULL);
-	if (!iter) {
-		plan_skip_all("Cannot create valid iterator");
-	}
-
-	event = bt_ctf_iter_read_event(iter);
-
-	ok(event, "Event valid");
-
-	/* Validate that the first timestamp is right */
-	timestamp_begin = bt_ctf_get_timestamp(event);
-
-	ok1(timestamp_begin == expected_begin);
-
-	/* Validate that we get the same value after a seek begin */
-	newpos.type = BT_SEEK_BEGIN;
-	ret = bt_iter_set_pos(bt_ctf_get_iter(iter), &newpos);
-
-	ok(ret == 0, "Seek begin retval %d", ret);
-
-	event = bt_ctf_iter_read_event(iter);
-
-	ok(event, "Event valid");
-
-	timestamp_seek_begin = bt_ctf_get_timestamp(event);
-
-	ok1(timestamp_begin == timestamp_seek_begin);
-
-	bt_context_put(ctx);
-}
-
-
-void run_seek_last(char *path, uint64_t expected_last)
-{
-	struct bt_context *ctx;
-	struct bt_ctf_iter *iter;
-	struct bt_ctf_event *event;
-	struct bt_iter_pos newpos;
-	int ret;
-	uint64_t timestamp_last;
-
-	/* Open the trace */
-	ctx = create_context_with_path(path);
-	if (!ctx) {
-		plan_skip_all("Cannot create valid context");
-	}
-
-	/* Create iterator with null last and end */
-	iter = bt_ctf_iter_create(ctx, NULL, NULL);
-	if (!iter) {
-		plan_skip_all("Cannot create valid iterator");
-	}
-
-	event = bt_ctf_iter_read_event(iter);
-
-	ok(event, "Event valid at beginning");
-
-	/* Seek to last */
-	newpos.type = BT_SEEK_LAST;
-	ret = bt_iter_set_pos(bt_ctf_get_iter(iter), &newpos);
-
-	ok(ret == 0, "Seek last retval %d", ret);
-
-	event = bt_ctf_iter_read_event(iter);
-
-	ok(event, "Event valid at last position");
-
-	timestamp_last = bt_ctf_get_timestamp(event);
-
-	ok1(timestamp_last == expected_last);
-
-	/* Try to read next event */
-	ret = bt_iter_next(bt_ctf_get_iter(iter));
-
-	ok(ret == 0, "iter next should return an error");
-
-	event = bt_ctf_iter_read_event(iter);
-
-	ok(event == 0, "Event after last should be invalid");
-
-	bt_context_put(ctx);
-}
-
-void run_seek_time_at_last(char *path, uint64_t expected_last)
-{
-	struct bt_context *ctx;
-	struct bt_ctf_iter *iter;
-	struct bt_ctf_event *event;
-	struct bt_iter_pos newpos;
-	int ret;
-	uint64_t timestamp_last;
-
-	/* Open the trace */
-	ctx = create_context_with_path(path);
-	if (!ctx) {
-		plan_skip_all("Cannot create valid context");
-	}
-
-	/* Create iterator with null last and end */
-	iter = bt_ctf_iter_create(ctx, NULL, NULL);
-	if (!iter) {
-		plan_skip_all("Cannot create valid iterator");
-	}
-
-	event = bt_ctf_iter_read_event(iter);
-
-	ok(event, "Event valid at beginning");
-
-	/* Seek to last */
-	newpos.type = BT_SEEK_TIME;
-	newpos.u.seek_time = expected_last;
-	ret = bt_iter_set_pos(bt_ctf_get_iter(iter), &newpos);
-
-	ok(ret == 0, "Seek time at last retval %d", ret);
-
-	event = bt_ctf_iter_read_event(iter);
-
-	ok(event, "Event valid at last position");
-
-	timestamp_last = bt_ctf_get_timestamp(event);
-
-	ok1(timestamp_last == expected_last);
-
-	/* Try to read next event */
-	ret = bt_iter_next(bt_ctf_get_iter(iter));
-
-	ok(ret == 0, "iter next should return an error");
-
-	event = bt_ctf_iter_read_event(iter);
-
-	ok(event == 0, "Event after last should be invalid");
-
-	bt_context_put(ctx);
-}
-
-void run_seek_cycles(char *path,
-		uint64_t expected_begin,
-		uint64_t expected_last)
-{
-	struct bt_context *ctx;
-	struct bt_ctf_iter *iter;
-	struct bt_ctf_event *event;
-	struct bt_iter_pos newpos;
-	int ret;
-	uint64_t timestamp;
-
-	/* Open the trace */
-	ctx = create_context_with_path(path);
-	if (!ctx) {
-		plan_skip_all("Cannot create valid context");
-	}
-
-	/* Create iterator with null last and end */
-	iter = bt_ctf_iter_create(ctx, NULL, NULL);
-	if (!iter) {
-		plan_skip_all("Cannot create valid iterator");
-	}
-
-	event = bt_ctf_iter_read_event(iter);
-
-	ok(event, "Event valid at beginning");
-
-	/* Seek to last */
-	newpos.type = BT_SEEK_LAST;
-	ret = bt_iter_set_pos(bt_ctf_get_iter(iter), &newpos);
-
-	ok(ret == 0, "Seek last retval %d", ret);
-
-	event = bt_ctf_iter_read_event(iter);
-
-	ok(event, "Event valid at last position");
-
-	timestamp = bt_ctf_get_timestamp(event);
-
-	ok1(timestamp == expected_last);
-
-	/* Try to read next event */
-	ret = bt_iter_next(bt_ctf_get_iter(iter));
-
-	ok(ret == 0, "iter next should return an error");
-
-	event = bt_ctf_iter_read_event(iter);
-
-	ok(event == 0, "Event after last should be invalid");
-
-	/* Seek to BEGIN */
-	newpos.type = BT_SEEK_BEGIN;
-	ret = bt_iter_set_pos(bt_ctf_get_iter(iter), &newpos);
-
-	ok(ret == 0, "Seek begin retval %d", ret);
-
-	event = bt_ctf_iter_read_event(iter);
-
-	ok(event, "Event valid at first position");
-
-	timestamp = bt_ctf_get_timestamp(event);
-
-	ok1(timestamp == expected_begin);
-
-	/* Seek last again */
-	newpos.type = BT_SEEK_LAST;
-	ret = bt_iter_set_pos(bt_ctf_get_iter(iter), &newpos);
-
-	ok(ret == 0, "Seek last retval %d", ret);
-
-	event = bt_ctf_iter_read_event(iter);
-
-	ok(event, "Event valid at last position");
-
-	timestamp = bt_ctf_get_timestamp(event);
-
-	ok1(timestamp == expected_last);
-
-	bt_context_put(ctx);
-}
-
-int main(int argc, char **argv)
-{
-	char *path;
-	uint64_t expected_begin;
-	uint64_t expected_last;
-
-	plan_tests(NR_TESTS);
-
-	if (argc < 4) {
-		plan_skip_all("Invalid arguments: need a trace path and the start and last timestamp");
-
-	}
-
-	/* Parse arguments (Trace, begin timestamp) */
-	path = argv[1];
-
-	expected_begin = strtoull(argv[2], NULL, 0);
-	if (ULLONG_MAX == expected_begin && errno == ERANGE) {
-		plan_skip_all("Invalid value for begin timestamp");
-	}
-
-	expected_last = strtoull(argv[3], NULL, 0);
-	if (ULLONG_MAX == expected_last && errno == ERANGE) {
-		plan_skip_all("Invalid value for last timestamp");
-	}
-
-	run_seek_begin(path, expected_begin);
-	run_seek_time_at_last(path, expected_last);
-	run_seek_last(path, expected_last);
-	run_seek_cycles(path, expected_begin, expected_last);
-
-	return exit_status();
-}
diff --git a/tests/lib/test_bitfield.c b/tests/lib/test_bitfield.c
new file mode 100644
index 0000000..16e8a57
--- /dev/null
+++ b/tests/lib/test_bitfield.c
@@ -0,0 +1,363 @@
+/*
+ * test-bitfield.c
+ *
+ * BabelTrace - bitfield test program
+ *
+ * Copyright 2010 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; under version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#define _GNU_SOURCE
+#include <babeltrace/bitfield.h>
+#include <time.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#include <tap/tap.h>
+
+unsigned int glob;
+
+/*
+ * This function is only declared to show the size of a bitfield write in
+ * objdump.
+ */
+void fct(void)
+{
+	bt_bitfield_write(&glob, unsigned int, 12, 15, 0x12345678);
+}
+
+/* Test array size, in bytes */
+#define TEST_LEN 128
+#define NR_TESTS 10
+#define SIGNED_TEST_DESC_FMT_STR "Writing and reading back 0x%X, signed"
+#define UNSIGNED_TEST_DESC_FMT_STR "Writing and reading back 0x%X, unsigned"
+#define DIAG_FMT_STR "Failed reading value written \"%s\"-wise, with start=%i" \
+	" and length=%i. Read %llX"
+
+unsigned int srcrand;
+
+#if defined(__i386) || defined(__x86_64)
+
+static inline int fls(int x)
+{
+	int r;
+	asm("bsrl %1,%0\n\t"
+	    "cmovzl %2,%0"
+	    : "=&r" (r) : "rm" (x), "rm" (-1));
+	return r + 1;
+}
+
+#elif defined(__PPC__)
+
+static __inline__ int fls(unsigned int x)
+{
+	int lz;
+
+	asm ("cntlzw %0,%1" : "=r" (lz) : "r" (x));
+	return 32 - lz;
+}
+
+#else
+
+static int fls(unsigned int x)
+{
+	int r = 32;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xFFFF0000U)) {
+		x <<= 16;
+		r -= 16;
+	}
+	if (!(x & 0xFF000000U)) {
+		x <<= 8;
+		r -= 8;
+	}
+	if (!(x & 0xF0000000U)) {
+		x <<= 4;
+		r -= 4;
+	}
+	if (!(x & 0xC0000000U)) {
+		x <<= 2;
+		r -= 2;
+	}
+	if (!(x & 0x80000000U)) {
+		x <<= 1;
+		r -= 1;
+	}
+	return r;
+}
+
+#endif
+
+#define print_byte_array(c, len)	\
+do {					\
+	unsigned long i;		\
+					\
+	for (i = 0; i < (len); i++) {	\
+		printf("0x%X", (c)[i]);	\
+		if (i != (len) - 1)	\
+			printf(" ");	\
+	}				\
+	printf("\n");			\
+} while (0)
+
+#define init_byte_array(c, len, val)	\
+do {					\
+	unsigned long i;		\
+					\
+	for (i = 0; i < (len); i++)	\
+		(c)[i] = (val);		\
+} while (0)
+
+#define check_result(ref, val, buffer, typename, start, len,		\
+		     desc_fmt_str)					\
+({									\
+	if ((val) != (ref)) {						\
+		fail(desc_fmt_str, ref);				\
+		diag(DIAG_FMT_STR, #typename, start, len, val);		\
+		printf("# ");						\
+		print_byte_array(buffer, TEST_LEN);			\
+	}								\
+	(val) != (ref);							\
+})
+
+void run_test_unsigned(void)
+{
+	unsigned int src, nrbits;
+	union {
+		unsigned char c[TEST_LEN];
+		unsigned short s[TEST_LEN/sizeof(unsigned short)];
+		unsigned int i[TEST_LEN/sizeof(unsigned int)];
+		unsigned long l[TEST_LEN/sizeof(unsigned long)];
+		unsigned long long ll[TEST_LEN/sizeof(unsigned long long)];
+	} target;
+	unsigned long long readval;
+	unsigned int s, l;
+
+	src = srcrand;
+	nrbits = fls(src);
+
+	for (s = 0; s < CHAR_BIT * TEST_LEN; s++) {
+		for (l = nrbits; l < (CHAR_BIT * TEST_LEN) - s; l++) {
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.c, unsigned char, s, l, src);
+			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
+			if (check_result(src, readval, target.c, unsigned char,
+					  s, l, UNSIGNED_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.s, unsigned short, s, l, src);
+			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
+			if (check_result(src, readval, target.c, unsigned short,
+					  s, l, UNSIGNED_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.i, unsigned int, s, l, src);
+			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
+			if (check_result(src, readval, target.c, unsigned int,
+					   s, l, UNSIGNED_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.l, unsigned long, s, l, src);
+			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
+			if (check_result(src, readval, target.c, unsigned long,
+					  s, l, UNSIGNED_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0xFF);
+			bt_bitfield_write(target.ll, unsigned long long, s, l, src);
+			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
+			if (check_result(src, readval, target.c, unsigned long long,
+				     s, l, UNSIGNED_TEST_DESC_FMT_STR)) {
+				return;
+			}
+		}
+	}
+
+	pass(UNSIGNED_TEST_DESC_FMT_STR, src);
+}
+
+void run_test_signed(void)
+{
+	int src, nrbits;
+	union {
+		signed char c[TEST_LEN];
+		short s[TEST_LEN/sizeof(short)];
+		int i[TEST_LEN/sizeof(int)];
+		long l[TEST_LEN/sizeof(long)];
+		long long ll[TEST_LEN/sizeof(long long)];
+	} target;
+	long long readval;
+	unsigned int s, l;
+
+	src = srcrand;
+	if (src & 0x80000000U)
+		nrbits = fls(~src) + 1;	/* Find least significant bit conveying sign */
+	else
+		nrbits = fls(src) + 1;	/* Keep sign at 0 */
+
+	for (s = 0; s < CHAR_BIT * TEST_LEN; s++) {
+		for (l = nrbits; l < (CHAR_BIT * TEST_LEN) - s; l++) {
+			init_byte_array(target.c, TEST_LEN, 0x0);
+			bt_bitfield_write(target.c, signed char, s, l, src);
+			bt_bitfield_read(target.c, signed char, s, l, &readval);
+			if (check_result(src, readval, target.c, signed char,
+					  s, l, SIGNED_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0x0);
+			bt_bitfield_write(target.s, short, s, l, src);
+			bt_bitfield_read(target.c, signed char, s, l, &readval);
+			if (check_result(src, readval, target.c, short,
+					  s, l, SIGNED_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0x0);
+			bt_bitfield_write(target.i, int, s, l, src);
+			bt_bitfield_read(target.c, signed char, s, l, &readval);
+			if (check_result(src, readval, target.c, int,
+					  s, l, SIGNED_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0x0);
+			bt_bitfield_write(target.l, long, s, l, src);
+			bt_bitfield_read(target.c, signed char, s, l, &readval);
+			if (check_result(src, readval, target.c, long,
+					  s, l, SIGNED_TEST_DESC_FMT_STR)) {
+				return;
+			}
+
+			init_byte_array(target.c, TEST_LEN, 0x0);
+			bt_bitfield_write(target.ll, long long, s, l, src);
+			bt_bitfield_read(target.c, signed char, s, l, &readval);
+			if (check_result(src, readval, target.c, long long,
+					  s, l, SIGNED_TEST_DESC_FMT_STR)) {
+				return;
+			}
+		}
+	}
+
+	pass(SIGNED_TEST_DESC_FMT_STR, src);
+}
+
+void run_test(void)
+{
+	int i;
+	plan_tests(NR_TESTS * 2 + 6);
+
+	srand(time(NULL));
+
+	srcrand = 0;
+	run_test_unsigned();
+	srcrand = 0;
+	run_test_signed();
+
+	srcrand = 1;
+	run_test_unsigned();
+
+	srcrand = ~0U;
+	run_test_unsigned();
+
+	srcrand = -1;
+	run_test_signed();
+
+	srcrand = (int)0x80000000U;
+	run_test_signed();
+
+	for (i = 0; i < NR_TESTS; i++) {
+		srcrand = rand();
+		run_test_unsigned();
+		run_test_signed();
+	}
+}
+
+static
+int print_encodings(unsigned long src, unsigned int shift, unsigned int len)
+{
+	union {
+		unsigned char c[8];
+		unsigned short s[4];
+		unsigned int i[2];
+		unsigned long l[2];
+		unsigned long long ll[1];
+	} target;
+	unsigned long long readval;
+
+	init_byte_array(target.c, 8, 0xFF);
+	bt_bitfield_write(target.c, unsigned char, shift, len, src);
+	printf("bytewise\n");
+	print_byte_array(target.c, 8);
+
+	init_byte_array(target.c, 8, 0xFF);
+	bt_bitfield_write(target.s, unsigned short, shift, len, src);
+	printf("shortwise\n");
+	print_byte_array(target.c, 8);
+
+	init_byte_array(target.c, 8, 0xFF);
+	bt_bitfield_write(target.i, unsigned int, shift, len, src);
+	printf("intwise\n");
+	print_byte_array(target.c, 8);
+
+	init_byte_array(target.c, 8, 0xFF);
+	bt_bitfield_write(target.l, unsigned long, shift, len, src);
+	printf("longwise\n");
+	print_byte_array(target.c, 8);
+
+	init_byte_array(target.c, 8, 0xFF);
+	bt_bitfield_write(target.ll, unsigned long long, shift, len, src);
+	printf("lluwise\n");
+	print_byte_array(target.c, 8);
+
+	bt_bitfield_read(target.c, unsigned char, shift, len, &readval);
+	printf("read: %llX\n", readval);
+	print_byte_array(target.c, 8);
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	if (argc > 1) {
+		/* Print encodings */
+		unsigned long src;
+		unsigned int shift, len;
+
+		src = atoi(argv[1]);
+		if (argc > 2)
+			shift = atoi(argv[2]);
+		else
+			shift = 12;
+		if (argc > 3)
+			len = atoi(argv[3]);
+		else
+			len = 40;
+		return print_encodings(src, shift, len);
+	}
+
+	/* Run tap-formated tests */
+	run_test();
+	return exit_status();
+}
diff --git a/tests/lib/test_seek.c b/tests/lib/test_seek.c
new file mode 100644
index 0000000..b33f80d
--- /dev/null
+++ b/tests/lib/test_seek.c
@@ -0,0 +1,302 @@
+/*
+ * test-seeks.c
+ *
+ * Lib BabelTrace - Seeks test program
+ *
+ * Copyright 2012 - Yannick Brosseau <yannick.brosseau@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; under version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+#define _GNU_SOURCE
+#include <babeltrace/context.h>
+#include <babeltrace/iterator.h>
+#include <babeltrace/ctf/iterator.h>
+#include <babeltrace/ctf/events.h>
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <limits.h>
+
+#include <tap/tap.h>
+#include "common.h"
+
+#define NR_TESTS	29
+
+void run_seek_begin(char *path, uint64_t expected_begin)
+{
+	struct bt_context *ctx;
+	struct bt_ctf_iter *iter;
+	struct bt_ctf_event *event;
+	struct bt_iter_pos newpos;
+	int ret;
+	uint64_t timestamp_begin;
+	uint64_t timestamp_seek_begin;
+
+	/* Open the trace */
+	ctx = create_context_with_path(path);
+	if (!ctx) {
+		plan_skip_all("Cannot create valid context");
+	}
+
+	/* Create iterator with null begin and end */
+	iter = bt_ctf_iter_create(ctx, NULL, NULL);
+	if (!iter) {
+		plan_skip_all("Cannot create valid iterator");
+	}
+
+	event = bt_ctf_iter_read_event(iter);
+
+	ok(event, "Event valid");
+
+	/* Validate that the first timestamp is right */
+	timestamp_begin = bt_ctf_get_timestamp(event);
+
+	ok1(timestamp_begin == expected_begin);
+
+	/* Validate that we get the same value after a seek begin */
+	newpos.type = BT_SEEK_BEGIN;
+	ret = bt_iter_set_pos(bt_ctf_get_iter(iter), &newpos);
+
+	ok(ret == 0, "Seek begin retval %d", ret);
+
+	event = bt_ctf_iter_read_event(iter);
+
+	ok(event, "Event valid");
+
+	timestamp_seek_begin = bt_ctf_get_timestamp(event);
+
+	ok1(timestamp_begin == timestamp_seek_begin);
+
+	bt_context_put(ctx);
+}
+
+
+void run_seek_last(char *path, uint64_t expected_last)
+{
+	struct bt_context *ctx;
+	struct bt_ctf_iter *iter;
+	struct bt_ctf_event *event;
+	struct bt_iter_pos newpos;
+	int ret;
+	uint64_t timestamp_last;
+
+	/* Open the trace */
+	ctx = create_context_with_path(path);
+	if (!ctx) {
+		plan_skip_all("Cannot create valid context");
+	}
+
+	/* Create iterator with null last and end */
+	iter = bt_ctf_iter_create(ctx, NULL, NULL);
+	if (!iter) {
+		plan_skip_all("Cannot create valid iterator");
+	}
+
+	event = bt_ctf_iter_read_event(iter);
+
+	ok(event, "Event valid at beginning");
+
+	/* Seek to last */
+	newpos.type = BT_SEEK_LAST;
+	ret = bt_iter_set_pos(bt_ctf_get_iter(iter), &newpos);
+
+	ok(ret == 0, "Seek last retval %d", ret);
+
+	event = bt_ctf_iter_read_event(iter);
+
+	ok(event, "Event valid at last position");
+
+	timestamp_last = bt_ctf_get_timestamp(event);
+
+	ok1(timestamp_last == expected_last);
+
+	/* Try to read next event */
+	ret = bt_iter_next(bt_ctf_get_iter(iter));
+
+	ok(ret == 0, "iter next should return an error");
+
+	event = bt_ctf_iter_read_event(iter);
+
+	ok(event == 0, "Event after last should be invalid");
+
+	bt_context_put(ctx);
+}
+
+void run_seek_time_at_last(char *path, uint64_t expected_last)
+{
+	struct bt_context *ctx;
+	struct bt_ctf_iter *iter;
+	struct bt_ctf_event *event;
+	struct bt_iter_pos newpos;
+	int ret;
+	uint64_t timestamp_last;
+
+	/* Open the trace */
+	ctx = create_context_with_path(path);
+	if (!ctx) {
+		plan_skip_all("Cannot create valid context");
+	}
+
+	/* Create iterator with null last and end */
+	iter = bt_ctf_iter_create(ctx, NULL, NULL);
+	if (!iter) {
+		plan_skip_all("Cannot create valid iterator");
+	}
+
+	event = bt_ctf_iter_read_event(iter);
+
+	ok(event, "Event valid at beginning");
+
+	/* Seek to last */
+	newpos.type = BT_SEEK_TIME;
+	newpos.u.seek_time = expected_last;
+	ret = bt_iter_set_pos(bt_ctf_get_iter(iter), &newpos);
+
+	ok(ret == 0, "Seek time at last retval %d", ret);
+
+	event = bt_ctf_iter_read_event(iter);
+
+	ok(event, "Event valid at last position");
+
+	timestamp_last = bt_ctf_get_timestamp(event);
+
+	ok1(timestamp_last == expected_last);
+
+	/* Try to read next event */
+	ret = bt_iter_next(bt_ctf_get_iter(iter));
+
+	ok(ret == 0, "iter next should return an error");
+
+	event = bt_ctf_iter_read_event(iter);
+
+	ok(event == 0, "Event after last should be invalid");
+
+	bt_context_put(ctx);
+}
+
+void run_seek_cycles(char *path,
+		uint64_t expected_begin,
+		uint64_t expected_last)
+{
+	struct bt_context *ctx;
+	struct bt_ctf_iter *iter;
+	struct bt_ctf_event *event;
+	struct bt_iter_pos newpos;
+	int ret;
+	uint64_t timestamp;
+
+	/* Open the trace */
+	ctx = create_context_with_path(path);
+	if (!ctx) {
+		plan_skip_all("Cannot create valid context");
+	}
+
+	/* Create iterator with null last and end */
+	iter = bt_ctf_iter_create(ctx, NULL, NULL);
+	if (!iter) {
+		plan_skip_all("Cannot create valid iterator");
+	}
+
+	event = bt_ctf_iter_read_event(iter);
+
+	ok(event, "Event valid at beginning");
+
+	/* Seek to last */
+	newpos.type = BT_SEEK_LAST;
+	ret = bt_iter_set_pos(bt_ctf_get_iter(iter), &newpos);
+
+	ok(ret == 0, "Seek last retval %d", ret);
+
+	event = bt_ctf_iter_read_event(iter);
+
+	ok(event, "Event valid at last position");
+
+	timestamp = bt_ctf_get_timestamp(event);
+
+	ok1(timestamp == expected_last);
+
+	/* Try to read next event */
+	ret = bt_iter_next(bt_ctf_get_iter(iter));
+
+	ok(ret == 0, "iter next should return an error");
+
+	event = bt_ctf_iter_read_event(iter);
+
+	ok(event == 0, "Event after last should be invalid");
+
+	/* Seek to BEGIN */
+	newpos.type = BT_SEEK_BEGIN;
+	ret = bt_iter_set_pos(bt_ctf_get_iter(iter), &newpos);
+
+	ok(ret == 0, "Seek begin retval %d", ret);
+
+	event = bt_ctf_iter_read_event(iter);
+
+	ok(event, "Event valid at first position");
+
+	timestamp = bt_ctf_get_timestamp(event);
+
+	ok1(timestamp == expected_begin);
+
+	/* Seek last again */
+	newpos.type = BT_SEEK_LAST;
+	ret = bt_iter_set_pos(bt_ctf_get_iter(iter), &newpos);
+
+	ok(ret == 0, "Seek last retval %d", ret);
+
+	event = bt_ctf_iter_read_event(iter);
+
+	ok(event, "Event valid at last position");
+
+	timestamp = bt_ctf_get_timestamp(event);
+
+	ok1(timestamp == expected_last);
+
+	bt_context_put(ctx);
+}
+
+int main(int argc, char **argv)
+{
+	char *path;
+	uint64_t expected_begin;
+	uint64_t expected_last;
+
+	plan_tests(NR_TESTS);
+
+	if (argc < 4) {
+		plan_skip_all("Invalid arguments: need a trace path and the start and last timestamp");
+
+	}
+
+	/* Parse arguments (Trace, begin timestamp) */
+	path = argv[1];
+
+	expected_begin = strtoull(argv[2], NULL, 0);
+	if (ULLONG_MAX == expected_begin && errno == ERANGE) {
+		plan_skip_all("Invalid value for begin timestamp");
+	}
+
+	expected_last = strtoull(argv[3], NULL, 0);
+	if (ULLONG_MAX == expected_last && errno == ERANGE) {
+		plan_skip_all("Invalid value for last timestamp");
+	}
+
+	run_seek_begin(path, expected_begin);
+	run_seek_time_at_last(path, expected_last);
+	run_seek_last(path, expected_last);
+	run_seek_cycles(path, expected_begin, expected_last);
+
+	return exit_status();
+}
-- 
1.8.3.4
