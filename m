From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 3/3] Fix: Generation of bytecode
	longer than 32768 bytes fails
Date: Mon, 27 Aug 2012 14:48:21 -0400
Message-ID: <1346093301-25274-4-git-send-email-christian.babeux__7535.9936607585$1346093366$gmane$org@efficios.com>
References: <1346093301-25274-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-iy0-f176.google.com ([209.85.210.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1T64Mv-0004kh-EY
	for lttng-dev@lists.lttng.org; Mon, 27 Aug 2012 14:49:01 -0400
Received: by mail-iy0-f176.google.com with SMTP id t4so10155357iag.35
	for <lttng-dev@lists.lttng.org>; Mon, 27 Aug 2012 11:49:01 -0700 (PDT)
In-Reply-To: <1346093301-25274-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

The bytecode buffer length field is currently limited to a uint16_t.
A larger buffer, lttng_filter_bytecode_alloc, is the underlying storage
for the bytecode.

The current allocation policy dictate that the alloc buffer size must be
doubled everytime the bytecode size plus padding exceeds its capacity.

A problem arise when generating bytecode larger than 32768 bytes.

e.g.:

Legend
* required_len: new bytecode len
* old_len: current alloc_len
* new_len: new alloc_len

src/bin/lttng/lttng enable-event event:bla -s foo -u --filter "`perl -e 'print "intfield" . " && 1" x2730'`"
UST event ust_tests_hello:tptest created in channel channel0
[debug liblttng-ctl] Generating IR... [debug liblttng-ctl] done
[debug liblttng-ctl] Validating IR... [debug liblttng-ctl] done
[debug liblttng-ctl] Generating bytecode... required_len = 11, old_len = 4, new_len = 16
required_len = 7, old_len = 4, new_len = 8
required_len = 16, old_len = 8, new_len = 16
required_len = 19, old_len = 16, new_len = 32
required_len = 40, old_len = 32, new_len = 64
required_len = 67, old_len = 64, new_len = 128
required_len = 136, old_len = 128, new_len = 256
required_len = 259, old_len = 256, new_len = 512
required_len = 520, old_len = 512, new_len = 1024
required_len = 1027, old_len = 1024, new_len = 2048
required_len = 2056, old_len = 2048, new_len = 4096
required_len = 4099, old_len = 4096, new_len = 8192
required_len = 8200, old_len = 8192, new_len = 16384
required_len = 16387, old_len = 16384, new_len = 32768
required_len = 32776, old_len = 32768, new_len = 65536 <-- Overflow 16-bits
Generate bytecode error
Error: Error setting filter

The last new_len exceed the range of 16-bits values. In order to support
the largest bytecode length (65535), the underlying alloc buffer len must
be able to store more than 65535. Fix this by using a uint32_t for alloc_len.

Also, add a check to ensure that a bytecode longer than LTTNG_FILTER_MAX_LEN
(65535) bytes can't be generated.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 src/lib/lttng-ctl/filter/filter-bytecode.h                  | 2 +-
 src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/lib/lttng-ctl/filter/filter-bytecode.h b/src/lib/lttng-ctl/filter/filter-bytecode.h
index 5d2559d..d364ee2 100644
--- a/src/lib/lttng-ctl/filter/filter-bytecode.h
+++ b/src/lib/lttng-ctl/filter/filter-bytecode.h
@@ -176,7 +176,7 @@ struct return_op {
 } __attribute__((packed));
 
 struct lttng_filter_bytecode_alloc {
-	uint16_t alloc_len;
+	uint32_t alloc_len;
 	struct lttng_filter_bytecode b;
 };
 
diff --git a/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c b/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
index 71da21c..98f8375 100644
--- a/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
+++ b/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
@@ -95,14 +95,15 @@ int32_t bytecode_reserve(struct lttng_filter_bytecode_alloc **fb, uint32_t align
 	int32_t ret;
 	uint32_t padding = offset_align((*fb)->b.len, align);
 
+	if ((*fb)->b.len + padding + len > LTTNG_FILTER_MAX_LEN)
+		return -EINVAL;
+
 	if ((*fb)->b.len + padding + len > (*fb)->alloc_len) {
 		uint32_t new_len =
 			max_t(uint32_t, 1U << get_count_order((*fb)->b.len + padding + len),
 				(*fb)->alloc_len << 1);
 		uint32_t old_len = (*fb)->alloc_len;
 
-		if (new_len > 0xFFFF)
-			return -EINVAL;
 		*fb = realloc(*fb, sizeof(struct lttng_filter_bytecode_alloc) + new_len);
 		if (!*fb)
 			return -ENOMEM;
-- 
1.7.11.4
