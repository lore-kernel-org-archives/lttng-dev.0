From: Zifei Tong <soariez@gmail.com>
Subject: [PATCH lttng-ust] Fix: make 'hello.cxx' compile with g++
Date: Sun, 21 Apr 2013 10:24:01 +0800
Message-ID: <1366511041-28805-1-git-send-email-soariez__19278.6405016252$1366511136$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <soariez@gmail.com>) id 1UTjxh-00075u-Qa
	for lttng-dev@lists.lttng.org; Sat, 20 Apr 2013 22:25:06 -0400
Received: by mail-pa0-f42.google.com with SMTP id kq13so2939405pab.29
	for <lttng-dev@lists.lttng.org>; Sat, 20 Apr 2013 19:25:00 -0700 (PDT)
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

Fixes #338

Signed-off-by: Zifei Tong <soariez@gmail.com>
---
 include/lttng/ringbuffer-config.h    |  5 +++++
 include/lttng/tracepoint-event.h     | 12 ++++++------
 include/lttng/ust-events.h           |  8 ++++----
 include/lttng/ust-tracepoint-event.h | 19 ++++++++++---------
 tests/hello.cxx/Makefile.am          |  2 +-
 tests/hello.cxx/tp.c                 | 26 --------------------------
 tests/hello.cxx/tp.cpp               | 26 ++++++++++++++++++++++++++
 7 files changed, 52 insertions(+), 46 deletions(-)
 delete mode 100644 tests/hello.cxx/tp.c
 create mode 100644 tests/hello.cxx/tp.cpp

diff --git a/include/lttng/ringbuffer-config.h b/include/lttng/ringbuffer-config.h
index ca52fc7..bb01eab 100644
--- a/include/lttng/ringbuffer-config.h
+++ b/include/lttng/ringbuffer-config.h
@@ -347,8 +347,13 @@ int lib_ring_buffer_check_config(const struct lttng_ust_lib_ring_buffer_config *
 			     unsigned int switch_timer_interval,
 			     unsigned int read_timer_interval)
 {
+	#ifdef __cplusplus
+	if (config->alloc == lttng_ust_lib_ring_buffer_config::RING_BUFFER_ALLOC_GLOBAL
+	    && config->sync == lttng_ust_lib_ring_buffer_config::RING_BUFFER_SYNC_PER_CPU
+	#else
 	if (config->alloc == RING_BUFFER_ALLOC_GLOBAL
 	    && config->sync == RING_BUFFER_SYNC_PER_CPU
+	#endif
 	    && switch_timer_interval)
 		return -EINVAL;
 	return 0;
diff --git a/include/lttng/tracepoint-event.h b/include/lttng/tracepoint-event.h
index 077eaa0..4630788 100644
--- a/include/lttng/tracepoint-event.h
+++ b/include/lttng/tracepoint-event.h
@@ -20,12 +20,12 @@
  * SOFTWARE.
  */
 
+#ifdef TRACEPOINT_CREATE_PROBES
+
 #ifdef __cplusplus
 extern "C" {
 #endif
 
-#ifdef TRACEPOINT_CREATE_PROBES
-
 #define __tp_stringify1(x)	#x
 #define __tp_stringify(x)	__tp_stringify1(x)
 
@@ -65,10 +65,10 @@ extern "C" {
 #undef TRACEPOINT_INCLUDE_FILE
 #undef TRACEPOINT_INCLUDE
 
-#define TRACEPOINT_CREATE_PROBES
-
-#endif /* TRACEPOINT_CREATE_PROBES */
-
 #ifdef __cplusplus
 }
 #endif
+
+#define TRACEPOINT_CREATE_PROBES
+
+#endif /* TRACEPOINT_CREATE_PROBES */
diff --git a/include/lttng/ust-events.h b/include/lttng/ust-events.h
index 749478a..4ef918b 100644
--- a/include/lttng/ust-events.h
+++ b/include/lttng/ust-events.h
@@ -90,7 +90,7 @@ struct lttng_enum_entry {
 #define __type_integer(_type, _byte_order, _base, _encoding)	\
 	{							\
 	    .atype = atype_integer,				\
-	    .u.basic.integer =					\
+	    .u = {.basic = {.integer =				\
 		{						\
 		  .size = sizeof(_type) * CHAR_BIT,		\
 		  .alignment = lttng_alignof(_type) * CHAR_BIT,	\
@@ -98,7 +98,7 @@ struct lttng_enum_entry {
 		  .reverse_byte_order = _byte_order != BYTE_ORDER,	\
 		  .base = _base,				\
 		  .encoding = lttng_encode_##_encoding,		\
-		},						\
+		}}},						\
 	}							\
 
 #define LTTNG_UST_INTEGER_TYPE_PADDING	24
@@ -124,14 +124,14 @@ struct lttng_integer_type {
 #define __type_float(_type)					\
 	{							\
 	    .atype = atype_float,				\
-	    .u.basic._float =					\
+	    .u = {.basic = {._float =				\
 		{						\
 		  .exp_dig = sizeof(_type) * CHAR_BIT		\
 				- _float_mant_dig(_type),	\
 		  .mant_dig = _float_mant_dig(_type),		\
 		  .alignment = lttng_alignof(_type) * CHAR_BIT,	\
 		  .reverse_byte_order = BYTE_ORDER != FLOAT_WORD_ORDER, \
-		},						\
+		}}},						\
 	}							\
 
 #define LTTNG_UST_FLOAT_TYPE_PADDING	24
diff --git a/include/lttng/ust-tracepoint-event.h b/include/lttng/ust-tracepoint-event.h
index e46cc1a..f8df87c 100644
--- a/include/lttng/ust-tracepoint-event.h
+++ b/include/lttng/ust-tracepoint-event.h
@@ -147,12 +147,12 @@ static const char							\
 	  .type =						\
 		{						\
 		  .atype = atype_array,				\
-		  .u.array =					\
+		  .u = {.array =				\
 			{					\
-			    .length = _length,			\
 			    .elem_type = __type_integer(_type, BYTE_ORDER, 10, _encoding), \
+			    .length = _length,			\
 			},					\
-		},						\
+		}},						\
 	  .nowrite = _nowrite,					\
 	},
 
@@ -164,11 +164,11 @@ static const char							\
 	  .type =						\
 		{						\
 		  .atype = atype_sequence,			\
-		  .u.sequence =					\
+		  .u = {.sequence =				\
 			{					\
 			    .length_type = __type_integer(_length_type, BYTE_ORDER, 10, none), \
 			    .elem_type = __type_integer(_type, BYTE_ORDER, 10, _encoding), \
-			},					\
+			}},					\
 		},						\
 	  .nowrite = _nowrite,					\
 	},
@@ -180,7 +180,7 @@ static const char							\
 	  .type =						\
 		{						\
 		  .atype = atype_string,			\
-		  .u.basic.string.encoding = lttng_encode_UTF8,	\
+		  .u = {.basic = {.string = {.encoding = lttng_encode_UTF8}}},	\
 		},						\
 	  .nowrite = _nowrite,					\
 	},
@@ -483,7 +483,7 @@ void __event_probe__##_provider##___##_name(_TP_ARGS_DATA_PROTO(_args));      \
 static									      \
 void __event_probe__##_provider##___##_name(_TP_ARGS_DATA_PROTO(_args))	      \
 {									      \
-	struct lttng_event *__event = __tp_data;			      \
+	struct lttng_event *__event = (struct lttng_event*) __tp_data;			      \
 	struct lttng_channel *__chan = __event->chan;			      \
 	struct lttng_ust_lib_ring_buffer_ctx __ctx;			      \
 	size_t __event_len, __event_align;				      \
@@ -612,13 +612,14 @@ static const char *							       \
 	__ref_model_emf_uri___##_provider##___##_name			       \
 	__attribute__((weakref ("_model_emf_uri___" #_provider "___" #_name)));\
 const struct lttng_event_desc __event_desc___##_provider##_##_name = {	       \
-	.fields = __event_fields___##_provider##___##_template,		       \
 	.name = #_provider ":" #_name,					       \
 	.probe_callback = (void (*)(void)) &__event_probe__##_provider##___##_template,\
+	.ctx = NULL,							       \
+	.fields = __event_fields___##_provider##___##_template,		       \
 	.nr_fields = _TP_ARRAY_SIZE(__event_fields___##_provider##___##_template), \
 	.loglevel = &__ref_loglevel___##_provider##___##_name,		       \
 	.signature = __tp_event_signature___##_provider##___##_template,       \
-	.u.ext.model_emf_uri = &__ref_model_emf_uri___##_provider##___##_name, \
+	.u = {.ext = {.model_emf_uri = &__ref_model_emf_uri___##_provider##___##_name}},\
 };
 
 #include TRACEPOINT_INCLUDE
diff --git a/tests/hello.cxx/Makefile.am b/tests/hello.cxx/Makefile.am
index 897416d..5f6c615 100644
--- a/tests/hello.cxx/Makefile.am
+++ b/tests/hello.cxx/Makefile.am
@@ -1,7 +1,7 @@
 AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include -Wsystem-headers
 
 noinst_PROGRAMS = hello
-hello_SOURCES = hello.cpp tp.c ust_tests_hello.h
+hello_SOURCES = hello.cpp tp.cpp ust_tests_hello.h
 hello_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la
 
 if LTTNG_UST_BUILD_WITH_LIBDL
diff --git a/tests/hello.cxx/tp.c b/tests/hello.cxx/tp.c
deleted file mode 100644
index 4790965..0000000
--- a/tests/hello.cxx/tp.c
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * tp.c
- *
- * Copyright (c) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
- * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
- */
-
-#define TRACEPOINT_CREATE_PROBES
-#include "ust_tests_hello.h"
diff --git a/tests/hello.cxx/tp.cpp b/tests/hello.cxx/tp.cpp
new file mode 100644
index 0000000..a2099ab
--- /dev/null
+++ b/tests/hello.cxx/tp.cpp
@@ -0,0 +1,26 @@
+/*
+ * tp.cpp
+ *
+ * Copyright (c) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#define TRACEPOINT_CREATE_PROBES
+#include "ust_tests_hello.h"
-- 
1.8.2.1
