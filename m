From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2 babeltrace 2/4] Silence compiler "always
 false comparison" warning
Date: Thu, 16 May 2019 16:58:46 -0400
Message-ID: <20190516205848.20409-2-mathieu.desnoyers__37728.3504045167$1558040384$gmane$org@efficios.com>
References: <20190516205848.20409-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 454kL66ljLz10CB
 for <lttng-dev@lists.lttng.org>; Thu, 16 May 2019 16:58:54 -0400 (EDT)
In-Reply-To: <20190516205848.20409-1-mathieu.desnoyers@efficios.com>
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

Compiling the bitfield test with gcc -Wextra generates those warnings:

 ../../include/babeltrace/bitfield-internal.h:38:45: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
 #define _bt_is_signed_type(type) ((type) -1 < (type) 0)

This is the intent of the macro. Disable compiler warnings around use of
that macro.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Change-Id: I2dd980e11ebd6cd37ae71b013925a6fca5d7b483
---
Changes since v1:
- Use stdbool.h.
---
 include/babeltrace/bitfield-internal.h | 35 ++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/include/babeltrace/bitfield-internal.h b/include/babeltrace/bitfield-internal.h
index 5ecde05e..bb0283a3 100644
--- a/include/babeltrace/bitfield-internal.h
+++ b/include/babeltrace/bitfield-internal.h
@@ -24,6 +24,7 @@
  */
 
 #include <stdint.h>	/* C99 5.2.4.2 Numerical limits */
+#include <stdbool.h>	/* C99 7.16 bool type */
 #include <babeltrace/compat/limits-internal.h>	/* C99 5.2.4.2 Numerical limits */
 #include <babeltrace/endian-internal.h>	/* Non-standard BIG_ENDIAN, LITTLE_ENDIAN, BYTE_ORDER */
 
@@ -40,6 +41,26 @@
 #error "bitfield.h requires the compiler representation of signed integers to be two's complement."
 #endif
 
+/*
+ * _bt_is_signed_type() willingly generates comparison of unsigned
+ * expression < 0, which is always false. Silence compiler warnings.
+ */
+#ifdef __GNUC__
+# define _BT_DIAG_PUSH			_Pragma("GCC diagnostic push")
+# define _BT_DIAG_POP			_Pragma("GCC diagnostic pop")
+
+# define _BT_DIAG_STRINGIFY_1(x)	#x
+# define _BT_DIAG_STRINGIFY(x)		_BT_DIAG_STRINGIFY_1(x)
+
+# define _BT_DIAG_IGNORE(option)	\
+	_Pragma(_BT_DIAG_STRINGIFY(GCC diagnostic ignored option))
+# define _BT_DIAG_IGNORE_TYPE_LIMITS	_BT_DIAG_IGNORE("-Wtype-limits")
+#else
+# define _BT_DIAG_PUSH
+# define _BT_DIAG_POP
+# define _BT_DIAG_IGNORE
+#endif
+
 #define _bt_is_signed_type(type)	((type) -1 < (type) 0)
 
 /*
@@ -359,6 +380,7 @@ do {									\
 	unsigned long ts = sizeof(type) * CHAR_BIT; /* type size */	\
 	unsigned long start_unit, end_unit, this_unit;			\
 	unsigned long end, cshift; /* cshift is "complement shift" */	\
+	bool is_signed_type;						\
 									\
 	if (!__length) {						\
 		*__vptr = 0;						\
@@ -370,7 +392,11 @@ do {									\
 	end_unit = (end + (ts - 1)) / ts;				\
 									\
 	this_unit = end_unit - 1;					\
-	if (_bt_is_signed_type(__typeof__(__v))				\
+	_BT_DIAG_PUSH							\
+	_BT_DIAG_IGNORE_TYPE_LIMITS					\
+	is_signed_type = _bt_is_signed_type(__typeof__(__v));		\
+	_BT_DIAG_POP							\
+	if (is_signed_type						\
 	    && (__ptr[this_unit] & _bt_lshift((type) 1, (end % ts ? end % ts : ts) - 1))) \
 		__v = ~(__typeof__(__v)) 0;				\
 	else								\
@@ -426,6 +452,7 @@ do {									\
 	unsigned long ts = sizeof(type) * CHAR_BIT; /* type size */	\
 	unsigned long start_unit, end_unit, this_unit;			\
 	unsigned long end, cshift; /* cshift is "complement shift" */	\
+	bool is_signed_type;						\
 									\
 	if (!__length) {						\
 		*__vptr = 0;						\
@@ -437,7 +464,11 @@ do {									\
 	end_unit = (end + (ts - 1)) / ts;				\
 									\
 	this_unit = start_unit;						\
-	if (_bt_is_signed_type(__typeof__(__v))				\
+	_BT_DIAG_PUSH							\
+	_BT_DIAG_IGNORE_TYPE_LIMITS					\
+	is_signed_type = _bt_is_signed_type(__typeof__(__v));		\
+	_BT_DIAG_POP							\
+	if (is_signed_type						\
 	    && (__ptr[this_unit] & _bt_lshift((type) 1, ts - (__start % ts) - 1))) \
 		__v = ~(__typeof__(__v)) 0;				\
 	else								\
-- 
2.11.0
