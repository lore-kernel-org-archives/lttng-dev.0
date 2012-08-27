From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 1/3] Fix: Filter bytecode alloc
	buffer size must be a power of 2
Date: Mon, 27 Aug 2012 14:48:19 -0400
Message-ID: <1346093301-25274-2-git-send-email-christian.babeux__48583.7800814354$1346093356$gmane$org@efficios.com>
References: <1346093301-25274-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-iy0-f176.google.com ([209.85.210.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1T64Mc-0004kh-1V
	for lttng-dev@lists.lttng.org; Mon, 27 Aug 2012 14:48:42 -0400
Received: by mail-iy0-f176.google.com with SMTP id t4so10155357iag.35
	for <lttng-dev@lists.lttng.org>; Mon, 27 Aug 2012 11:48:41 -0700 (PDT)
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

The current allocation policy for the filter bytecode buffer is to double
the size each time the underlying buffer can no longer contain the entire
bytecode plus padding.

In some cases, the initial allocation length is not a multiple of 2, thus
possibly leading to odd-looking allocation size each time the buffer size
is doubled.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 .../filter/filter-visitor-generate-bytecode.c      | 41 +++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c b/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
index 36d35c5..71da21c 100644
--- a/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
+++ b/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
@@ -38,6 +38,45 @@ static
 int recursive_visit_gen_bytecode(struct filter_parser_ctx *ctx,
 		struct ir_op *node);
 
+static inline int fls(unsigned int x)
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
+static inline int get_count_order(unsigned int count)
+{
+	int order;
+
+	order = fls(count) - 1;
+	if (count & (count - 1))
+		order++;
+	return order;
+}
+
 static
 int bytecode_init(struct lttng_filter_bytecode_alloc **fb)
 {
@@ -58,7 +97,7 @@ int32_t bytecode_reserve(struct lttng_filter_bytecode_alloc **fb, uint32_t align
 
 	if ((*fb)->b.len + padding + len > (*fb)->alloc_len) {
 		uint32_t new_len =
-			max_t(uint32_t, (*fb)->b.len + padding + len,
+			max_t(uint32_t, 1U << get_count_order((*fb)->b.len + padding + len),
 				(*fb)->alloc_len << 1);
 		uint32_t old_len = (*fb)->alloc_len;
 
-- 
1.7.11.4
