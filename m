From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-modules] Fix: bitfield: left shift
 undefined behavior
Date: Tue,  7 May 2019 16:43:28 -0400
Message-ID: <20190507204328.18078-1-mathieu.desnoyers__22568.0760618829$1557261828$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44zBQY2YvFz1K5X
 for <lttng-dev@lists.lttng.org>; Tue,  7 May 2019 16:43:33 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

bitfield.h uses the left shift operator with a left operand which
may be negative. The C99 standard states that shifting a negative
value is undefined.

We also need to cast the result explicitly into the left hand
side type to deal with:

warning: large integer implicitly truncated to unsigned type [-Woverflow]

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 lib/bitfield.h | 58 +++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/lib/bitfield.h b/lib/bitfield.h
index a729db99..164e2aaf 100644
--- a/lib/bitfield.h
+++ b/lib/bitfield.h
@@ -43,13 +43,25 @@
 
 #define _bt_is_signed_type(type)	(((type)(-1)) < 0)
 
+/*
+ * NOTE: The unsigned cast ensures that we're not shifting a negative
+ * value, which is undefined in C. However, this limits the maximum
+ * type size of `type` and `v` to 64-bit. The _bt_check_max_64bit() is
+ * used to check that the users of this header do not use types with a
+ * size greater than 64-bit.
+ */
 #define _bt_unsigned_cast(type, v)					\
 ({									\
-	(sizeof(v) < sizeof(type)) ?					\
-		((type) (v)) & (~(~(type) 0 << (sizeof(v) * CHAR_BIT))) : \
-		(type) (v);						\
+	__builtin_types_compatible_p(type, int8_t) ? (uint8_t) (v) :	\
+	__builtin_types_compatible_p(type, int16_t) ? (uint16_t) (v) :	\
+	__builtin_types_compatible_p(type, int32_t) ? (uint32_t) (v) :	\
+	__builtin_types_compatible_p(type, int64_t) ? (uint64_t) (v) :	\
+	(type) (v);							\
 })
 
+/* Unsigned bitwise complement. */
+#define _bt_bitwise_not(type, v)	_bt_unsigned_cast(type, ~(type) v)
+
 /*
  * bt_bitfield_write - write integer to a bitfield in native endianness
  *
@@ -87,15 +99,15 @@ do {									\
 									\
 	/* Trim v high bits */						\
 	if (__length < sizeof(__v) * CHAR_BIT)				\
-		__v &= ~((~(typeof(__v)) 0) << __length);		\
+		__v &= (__typeof__(__v)) ~(_bt_bitwise_not(typeof(__v), 0) << __length); \
 									\
 	/* We can now append v with a simple "or", shift it piece-wise */ \
 	this_unit = start_unit;						\
 	if (start_unit == end_unit - 1) {				\
-		mask = ~((~(type) 0) << (__start % ts));		\
+		mask = (__typeof__(mask)) ~(_bt_bitwise_not(type, 0) << (__start % ts)); \
 		if (end % ts)						\
-			mask |= (~(type) 0) << (end % ts);		\
-		cmask = (type) __v << (__start % ts);			\
+			mask |= (__typeof__(mask)) (_bt_bitwise_not(type, 0) << (end % ts)); \
+		cmask = (__typeof__(cmask)) (_bt_unsigned_cast(type, __v) << (__start % ts)); \
 		cmask &= ~mask;						\
 		__ptr[this_unit] &= mask;				\
 		__ptr[this_unit] |= cmask;				\
@@ -103,8 +115,8 @@ do {									\
 	}								\
 	if (__start % ts) {						\
 		cshift = __start % ts;					\
-		mask = ~((~(type) 0) << cshift);			\
-		cmask = (type) __v << cshift;				\
+		mask = (__typeof__(mask)) ~(_bt_bitwise_not(type, 0) << cshift); \
+		cmask = (__typeof__(cmask)) (_bt_unsigned_cast(type, __v) << cshift); \
 		cmask &= ~mask;						\
 		__ptr[this_unit] &= mask;				\
 		__ptr[this_unit] |= cmask;				\
@@ -118,7 +130,7 @@ do {									\
 		__start += ts;						\
 	}								\
 	if (end % ts) {							\
-		mask = (~(type) 0) << (end % ts);			\
+		mask = (__typeof__(mask)) (_bt_bitwise_not(type, 0) << (end % ts)); \
 		cmask = (type) __v;					\
 		cmask &= ~mask;						\
 		__ptr[this_unit] &= mask;				\
@@ -146,15 +158,15 @@ do {									\
 									\
 	/* Trim v high bits */						\
 	if (__length < sizeof(__v) * CHAR_BIT)				\
-		__v &= ~((~(typeof(__v)) 0) << __length);		\
+		__v &= (__typeof__(__v)) ~(_bt_bitwise_not(typeof(__v), 0) << __length); \
 									\
 	/* We can now append v with a simple "or", shift it piece-wise */ \
 	this_unit = end_unit - 1;					\
 	if (start_unit == end_unit - 1) {				\
-		mask = ~((~(type) 0) << ((ts - (end % ts)) % ts));	\
+		mask = (__typeof__(mask)) ~(_bt_bitwise_not(type, 0) << ((ts - (end % ts)) % ts)); \
 		if (__start % ts)					\
-			mask |= (~((type) 0)) << (ts - (__start % ts));	\
-		cmask = (type) __v << ((ts - (end % ts)) % ts);		\
+			mask |= (__typeof__(mask)) (_bt_bitwise_not(type, 0) << (ts - (__start % ts))); \
+		cmask = (__typeof__(cmask)) (_bt_unsigned_cast(type, __v) << ((ts - (end % ts)) % ts)); \
 		cmask &= ~mask;						\
 		__ptr[this_unit] &= mask;				\
 		__ptr[this_unit] |= cmask;				\
@@ -162,8 +174,8 @@ do {									\
 	}								\
 	if (end % ts) {							\
 		cshift = end % ts;					\
-		mask = ~((~(type) 0) << (ts - cshift));			\
-		cmask = (type) __v << (ts - cshift);			\
+		mask = (__typeof__(mask)) ~(_bt_bitwise_not(type, 0) << (ts - cshift));	\
+		cmask = (__typeof__(cmask)) (_bt_unsigned_cast(type, __v) << (ts - cshift)); \
 		cmask &= ~mask;						\
 		__ptr[this_unit] &= mask;				\
 		__ptr[this_unit] |= cmask;				\
@@ -177,7 +189,7 @@ do {									\
 		end -= ts;						\
 	}								\
 	if (__start % ts) {						\
-		mask = (~(type) 0) << (ts - (__start % ts));		\
+		mask = (__typeof__(mask)) (_bt_bitwise_not(type, 0) << (ts - (__start % ts))); \
 		cmask = (type) __v;					\
 		cmask &= ~mask;						\
 		__ptr[this_unit] &= mask;				\
@@ -250,7 +262,7 @@ do {									\
 		cmask = __ptr[this_unit];				\
 		cmask >>= (__start % ts);				\
 		if ((end - __start) % ts) {				\
-			mask = ~((~(type) 0) << (end - __start));	\
+			mask = (__typeof__(mask)) ~(_bt_bitwise_not(type, 0) << (end - __start)); \
 			cmask &= mask;					\
 		}							\
 		__v = _bt_piecewise_lshift(__v, end - __start);		\
@@ -260,7 +272,7 @@ do {									\
 	}								\
 	if (end % ts) {							\
 		cshift = end % ts;					\
-		mask = ~((~(type) 0) << cshift);			\
+		mask = (__typeof__(mask)) ~(_bt_bitwise_not(type, 0) << cshift); \
 		cmask = __ptr[this_unit];				\
 		cmask &= mask;						\
 		__v = _bt_piecewise_lshift(__v, cshift);		\
@@ -274,7 +286,7 @@ do {									\
 		end -= ts;						\
 	}								\
 	if (__start % ts) {						\
-		mask = ~((~(type) 0) << (ts - (__start % ts)));		\
+		mask = (__typeof__(mask)) ~(_bt_bitwise_not(type, 0) << (ts - (__start % ts))); \
 		cmask = __ptr[this_unit];				\
 		cmask >>= (__start % ts);				\
 		cmask &= mask;						\
@@ -317,7 +329,7 @@ do {									\
 		cmask = __ptr[this_unit];				\
 		cmask >>= (ts - (end % ts)) % ts;			\
 		if ((end - __start) % ts) {				\
-			mask = ~((~(type) 0) << (end - __start));	\
+			mask = (__typeof__(mask)) ~(_bt_bitwise_not(type, 0) << (end - __start)); \
 			cmask &= mask;					\
 		}							\
 		__v = _bt_piecewise_lshift(__v, end - __start);		\
@@ -327,7 +339,7 @@ do {									\
 	}								\
 	if (__start % ts) {						\
 		cshift = __start % ts;					\
-		mask = ~((~(type) 0) << (ts - cshift));			\
+		mask = (__typeof__(mask)) ~(_bt_bitwise_not(type, 0) << (ts - cshift));	\
 		cmask = __ptr[this_unit];				\
 		cmask &= mask;						\
 		__v = _bt_piecewise_lshift(__v, ts - cshift);		\
@@ -341,7 +353,7 @@ do {									\
 		__start += ts;						\
 	}								\
 	if (end % ts) {							\
-		mask = ~((~(type) 0) << (end % ts));			\
+		mask = (__typeof__(mask)) ~(_bt_bitwise_not(type, 0) << (end % ts)); \
 		cmask = __ptr[this_unit];				\
 		cmask >>= ts - (end % ts);				\
 		cmask &= mask;						\
-- 
2.11.0
