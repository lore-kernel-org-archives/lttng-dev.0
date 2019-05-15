From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace 2/4] Silence compiler "always false
 comparison" warning
Date: Wed, 15 May 2019 17:46:51 -0400
Message-ID: <20190515214653.15059-2-mathieu.desnoyers__16238.0119598069$1557956840$gmane$org@efficios.com>
References: <20190515214653.15059-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 4547S35PvZzyn7
 for <lttng-dev@lists.lttng.org>; Wed, 15 May 2019 17:46:59 -0400 (EDT)
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

Compiling the bitfield test with gcc -Wextra generates those warnings:

 ../../include/babeltrace/bitfield-internal.h:38:45: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
 #define _bt_is_signed_type(type) ((type) -1 < (type) 0)

This is the intent of the macro. Disable compiler warnings around use of
that macro.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Change-Id: I2dd980e11ebd6cd37ae71b013925a6fca5d7b483
---
 include/babeltrace/bitfield-internal.h | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/babeltrace/bitfield-internal.h b/include/babeltrace/bitfield-internal.h
index 31b18f15..01d00c13 100644
--- a/include/babeltrace/bitfield-internal.h
+++ b/include/babeltrace/bitfield-internal.h
@@ -40,6 +40,26 @@
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
@@ -347,6 +367,7 @@ do {									\
 	unsigned long ts = sizeof(type) * CHAR_BIT; /* type size */	\
 	unsigned long start_unit, end_unit, this_unit;			\
 	unsigned long end, cshift; /* cshift is "complement shift" */	\
+	int is_signed_type;						\
 									\
 	if (!__length) {						\
 		*__vptr = 0;						\
@@ -358,7 +379,11 @@ do {									\
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
@@ -414,6 +439,7 @@ do {									\
 	unsigned long ts = sizeof(type) * CHAR_BIT; /* type size */	\
 	unsigned long start_unit, end_unit, this_unit;			\
 	unsigned long end, cshift; /* cshift is "complement shift" */	\
+	int is_signed_type;						\
 									\
 	if (!__length) {						\
 		*__vptr = 0;						\
@@ -425,7 +451,11 @@ do {									\
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
