From: Simon Marchi <simon.marchi@efficios.com>
Subject: [PATCH lttng-modules] Make bitfield.h C++-friendly
Date: Mon, 19 Aug 2019 21:51:52 -0400
Message-ID: <20190820015152.22528-1-simon.marchi__1349.16254771582$1566265931$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46CDLP4RWlzsZc
 for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2019 21:51:57 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: Simon Marchi <simon.marchi@efficios.com>
List-Id: lttng-dev@lists.lttng.org

This patch changes bitfield.h to be usable in C++11.

It will probably never be compiled as C++ in the context of
lttng-modules, but this is just to keep things sync'ed across projects.

Signed-off-by: Simon Marchi <simon.marchi@efficios.com>
---
 lib/bitfield.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bitfield.h b/lib/bitfield.h
index a9e268b41530..7d5eaeaa068d 100644
--- a/lib/bitfield.h
+++ b/lib/bitfield.h
@@ -55,8 +55,12 @@
  * Produce a build-time error if the condition `cond` is non-zero.
  * Evaluates as a size_t expression.
  */
+#ifdef __cplusplus
+#define _BT_BUILD_ASSERT(cond) ([]{static_assert((cond), "");}, 0)
+#else
 #define _BT_BUILD_ASSERT(cond)					\
 	sizeof(struct { int f:(2 * !!(cond) - 1); })
+#endif
 
 /*
  * Cast value `v` to an unsigned integer of the same size as `v`.
@@ -362,7 +366,7 @@ do {									\
 do {									\
 	__typeof__(*(vptr)) *_vptr = (vptr);				\
 	__typeof__(*_vptr) _v;						\
-	type *_ptr = (void *) (ptr);					\
+	type *_ptr = (type *) (ptr);					\
 	unsigned long _start = (start), _length = (length);		\
 	type _mask, _cmask;						\
 	unsigned long _ts = sizeof(type) * CHAR_BIT; /* type size */	\
-- 
2.23.0
