From: Zifei Tong <soariez@gmail.com>
Subject: Re: [PATCH lttng-ust] Fix: make 'hello.cxx' compile
	with g++
Date: Mon, 22 Apr 2013 01:07:51 +0800
Message-ID: <CAJ7wx-GTRKhaZi-BryAF_mLxDoDY7xwChStmLKNxoUrOizVJLg__26772.0368378379$1366564151$gmane$org@mail.gmail.com>
References: <1366511041-28805-1-git-send-email-soariez@gmail.com>
	<20130421133753.GA26620@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1508911010=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <soariez@gmail.com>) id 1UTxki-0005kv-U3
	for lttng-dev@lists.lttng.org; Sun, 21 Apr 2013 13:08:37 -0400
Received: by mail-vb0-f46.google.com with SMTP id 11so5060315vbe.19
	for <lttng-dev@lists.lttng.org>; Sun, 21 Apr 2013 10:08:31 -0700 (PDT)
In-Reply-To: <20130421133753.GA26620@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1508911010==
Content-Type: multipart/alternative; boundary=047d7b6726666b48ee04dae2007d

--047d7b6726666b48ee04dae2007d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for your review.

> Why is this lttng_ust_lib_ring_buffer_config:: scoping needed in c++ ?

C++ will hide enumeration defined inside class/struct.

Quote from http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2011/n3242.pd=
f,
page 158:
> An enumerator declared in class scope can be referred to using the class
member access
> operators (::, . (dot) and -> (arrow))  [Example:
> struct X {
>     enum direction { left=3D=E2=80=99l=E2=80=99, right=3D=E2=80=99r=E2=80=
=99 };
> };
> void g(X* p) {
>     int i;
>     i =3D p->f(left); // error: left not in scope
>     i =3D p->f(X::right); // OK
> }
> =E2=80=94 end example ]


> inlined precompiler directives like this make the function hard to
> follow (mix of #if/#else/#endif and if/else).

I agree inlined precompiler directives is bad style. Could you suggest a
way to remove the mix of #if/#else/#endif and if/else?

> So each field need to be listed ? We usually don't put NULL
> initialization for structures that are always in zero-initialized
> memory. (coding style)

This is related to a known issue of g++:
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D55606 (Bug 55606 - sorry,
unimplemented: non-trivial designated initializers not supported).

g++'s 'trivial designated initializers' means no out-of-order
initialization, no missing
initialization (except the fields on the tail of a struct), and nested
initialization should be done in the form {.foo =3D {.bar =3D 1}} instead o=
f
{.foo.bar =3D 1}. That's why I made such modification.

> Are those changes also compatible with the LLVM c++ compiler ?
Actually, clang++ have designated initializers better supported than g++.
All the modification about designated initializers are not required for
clang++. No need to add NULL initialization, reorder initializations or
change {.foo.bar =3D 1} into {.foo =3D {.bar =3D 1}}. These (ugly) hacks ar=
e just
to make g++ happy.

Cleaned-up patch attached.

Thanks.

From 36930fdfa25a6ea67de551300263dee353df43e5 Mon Sep 17 00:00:00 2001
From: Zifei Tong <soariez@gmail.com>
Date: Sat, 20 Apr 2013 19:38:39 +0800
Subject: [PATCH lttng-ust] Fix: make 'hello.cxx' compile with g++

Fixes #338

Signed-off-by: Zifei Tong <soariez@gmail.com>
---
 include/lttng/ringbuffer-config.h    |  5 +++++
 include/lttng/tracepoint-event.h     | 12 +++++------
 include/lttng/ust-events.h           | 42
+++++++++++++++++++++++-------------
 include/lttng/ust-tracepoint-event.h | 32 +++++++++++++++++----------
 tests/hello.cxx/Makefile.am          |  2 +-
 tests/hello.cxx/tp.c                 | 26 ----------------------
 tests/hello.cxx/tp.cpp               | 26 ++++++++++++++++++++++
 7 files changed, 86 insertions(+), 59 deletions(-)
 delete mode 100644 tests/hello.cxx/tp.c
 create mode 100644 tests/hello.cxx/tp.cpp

diff --git a/include/lttng/ringbuffer-config.h
b/include/lttng/ringbuffer-config.h
index ca52fc7..bb01eab 100644
--- a/include/lttng/ringbuffer-config.h
+++ b/include/lttng/ringbuffer-config.h
@@ -347,8 +347,13 @@ int lib_ring_buffer_check_config(const struct
lttng_ust_lib_ring_buffer_config *
      unsigned int switch_timer_interval,
      unsigned int read_timer_interval)
 {
+ #ifdef __cplusplus
+ if (config->alloc =3D=3D
lttng_ust_lib_ring_buffer_config::RING_BUFFER_ALLOC_GLOBAL
+    && config->sync =3D=3D
lttng_ust_lib_ring_buffer_config::RING_BUFFER_SYNC_PER_CPU
+ #else
  if (config->alloc =3D=3D RING_BUFFER_ALLOC_GLOBAL
     && config->sync =3D=3D RING_BUFFER_SYNC_PER_CPU
+ #endif
     && switch_timer_interval)
  return -EINVAL;
  return 0;
diff --git a/include/lttng/tracepoint-event.h
b/include/lttng/tracepoint-event.h
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
 #define __tp_stringify1(x) #x
 #define __tp_stringify(x) __tp_stringify1(x)

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
index 749478a..e97cc1b 100644
--- a/include/lttng/ust-events.h
+++ b/include/lttng/ust-events.h
@@ -89,15 +89,21 @@ struct lttng_enum_entry {

 #define __type_integer(_type, _byte_order, _base, _encoding) \
  { \
-    .atype =3D atype_integer, \
-    .u.basic.integer =3D \
+  .atype =3D atype_integer, \
+  .u =3D \
  { \
-  .size =3D sizeof(_type) * CHAR_BIT, \
-  .alignment =3D lttng_alignof(_type) * CHAR_BIT, \
-  .signedness =3D lttng_is_signed_type(_type), \
-  .reverse_byte_order =3D _byte_order !=3D BYTE_ORDER, \
-  .base =3D _base, \
-  .encoding =3D lttng_encode_##_encoding, \
+  .basic =3D \
+ { \
+  .integer =3D \
+ { \
+  .size =3D sizeof(_type) * CHAR_BIT, \
+  .alignment =3D lttng_alignof(_type) * CHAR_BIT, \
+  .signedness =3D lttng_is_signed_type(_type), \
+  .reverse_byte_order =3D _byte_order !=3D BYTE_ORDER, \
+  .base =3D _base, \
+  .encoding =3D lttng_encode_##_encoding, \
+ } \
+ } \
  }, \
  } \

@@ -123,14 +129,20 @@ struct lttng_integer_type {

 #define __type_float(_type) \
  { \
-    .atype =3D atype_float, \
-    .u.basic._float =3D \
+  .atype =3D atype_float, \
+  .u =3D \
  { \
-  .exp_dig =3D sizeof(_type) * CHAR_BIT \
- - _float_mant_dig(_type), \
-  .mant_dig =3D _float_mant_dig(_type), \
-  .alignment =3D lttng_alignof(_type) * CHAR_BIT, \
-  .reverse_byte_order =3D BYTE_ORDER !=3D FLOAT_WORD_ORDER, \
+  .basic =3D \
+ { \
+  ._float =3D \
+ { \
+  .exp_dig =3D sizeof(_type) * CHAR_BIT \
+  - _float_mant_dig(_type), \
+  .mant_dig =3D _float_mant_dig(_type), \
+  .alignment =3D lttng_alignof(_type) * CHAR_BIT, \
+  .reverse_byte_order =3D BYTE_ORDER !=3D FLOAT_WORD_ORDER, \
+ }
+ }
  }, \
  } \

diff --git a/include/lttng/ust-tracepoint-event.h
b/include/lttng/ust-tracepoint-event.h
index e46cc1a..3aa946d 100644
--- a/include/lttng/ust-tracepoint-event.h
+++ b/include/lttng/ust-tracepoint-event.h
@@ -147,11 +147,14 @@ static const char \
   .type =3D \
  { \
   .atype =3D atype_array, \
-  .u.array =3D \
+  .u =3D \
  { \
-    .length =3D _length, \
-    .elem_type =3D __type_integer(_type, BYTE_ORDER, 10, _encoding), \
- }, \
+  .array =3D \
+ { \
+  .elem_type =3D __type_integer(_type, BYTE_ORDER, 10, _encoding), \
+  .length =3D _length, \
+ } \
+ } \
  }, \
   .nowrite =3D _nowrite, \
  },
@@ -164,10 +167,13 @@ static const char \
   .type =3D \
  { \
   .atype =3D atype_sequence, \
-  .u.sequence =3D \
+  .u =3D \
  { \
-    .length_type =3D __type_integer(_length_type, BYTE_ORDER, 10, none), \
-    .elem_type =3D __type_integer(_type, BYTE_ORDER, 10, _encoding), \
+  .sequence =3D
+ { \
+  .length_type =3D __type_integer(_length_type, BYTE_ORDER, 10, none), \
+  .elem_type =3D __type_integer(_type, BYTE_ORDER, 10, _encoding), \
+ }, \
  }, \
  }, \
   .nowrite =3D _nowrite, \
@@ -180,7 +186,10 @@ static const char \
   .type =3D \
  { \
   .atype =3D atype_string, \
-  .u.basic.string.encoding =3D lttng_encode_UTF8, \
+  .u =3D
+ {
+  .basic =3D { .string =3D { .encoding =3D lttng_encode_UTF8 } } \
+ }, \
  }, \
   .nowrite =3D _nowrite, \
  },
@@ -483,7 +492,7 @@ void
__event_probe__##_provider##___##_name(_TP_ARGS_DATA_PROTO(_args));      \
 static      \
 void __event_probe__##_provider##___##_name(_TP_ARGS_DATA_PROTO(_args))
   \
 {      \
- struct lttng_event *__event =3D __tp_data;      \
+ struct lttng_event *__event =3D (struct lttng_event *) __tp_data;      \
  struct lttng_channel *__chan =3D __event->chan;      \
  struct lttng_ust_lib_ring_buffer_ctx __ctx;      \
  size_t __event_len, __event_align;      \
@@ -612,13 +621,14 @@ static const char *       \
  __ref_model_emf_uri___##_provider##___##_name       \
  __attribute__((weakref ("_model_emf_uri___" #_provider "___" #_name)));\
 const struct lttng_event_desc __event_desc___##_provider##_##_name =3D {
  \
- .fields =3D __event_fields___##_provider##___##_template,       \
  .name =3D #_provider ":" #_name,       \
  .probe_callback =3D (void (*)(void))
&__event_probe__##_provider##___##_template,\
+ .ctx =3D NULL,       \
+ .fields =3D __event_fields___##_provider##___##_template,       \
  .nr_fields =3D
_TP_ARRAY_SIZE(__event_fields___##_provider##___##_template), \
  .loglevel =3D &__ref_loglevel___##_provider##___##_name,       \
  .signature =3D __tp_event_signature___##_provider##___##_template,       =
\
- .u.ext.model_emf_uri =3D &__ref_model_emf_uri___##_provider##___##_name, =
\
+ .u =3D { .ext =3D { .model_emf_uri =3D
&__ref_model_emf_uri___##_provider##___##_name } }, \
 };

 #include TRACEPOINT_INCLUDE
diff --git a/tests/hello.cxx/Makefile.am b/tests/hello.cxx/Makefile.am
index 897416d..5f6c615 100644
--- a/tests/hello.cxx/Makefile.am
+++ b/tests/hello.cxx/Makefile.am
@@ -1,7 +1,7 @@
 AM_CPPFLAGS =3D -I$(top_srcdir)/include -I$(top_builddir)/include
-Wsystem-headers

 noinst_PROGRAMS =3D hello
-hello_SOURCES =3D hello.cpp tp.c ust_tests_hello.h
+hello_SOURCES =3D hello.cpp tp.cpp ust_tests_hello.h
 hello_LDADD =3D $(top_builddir)/liblttng-ust/liblttng-ust.la

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
- * Permission is hereby granted, free of charge, to any person obtaining a
copy
- * of this software and associated documentation files (the "Software"),
to deal
- * in the Software without restriction, including without limitation the
rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or
sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included
in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE
- * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
IN THE
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
+ * Permission is hereby granted, free of charge, to any person obtaining a
copy
+ * of this software and associated documentation files (the "Software"),
to deal
+ * in the Software without restriction, including without limitation the
rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
IN THE
+ * SOFTWARE.
+ */
+
+#define TRACEPOINT_CREATE_PROBES
+#include "ust_tests_hello.h"
--=20
1.8.2.1

--
Best Regards,
=E4=BB=9D=E5=AD=90=E9=A3=9E (Zifei Tong)
College of Computer Science and Technology, Zhejiang University

soariez@gmail.com / tongzifei@zju.edu.cn

--047d7b6726666b48ee04dae2007d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>Thanks for your review.<br><br>&gt; Why is this=
 lttng_ust_lib_ring_buffer_config:: scoping needed in c++ ?<br><br>C++ will=
 hide enumeration defined inside class/struct.<br><br>Quote from <a href=3D=
"http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2011/n3242.pdf">http://=
www.open-std.org/jtc1/sc22/wg21/docs/papers/2011/n3242.pdf</a>, page 158:<b=
r>

&gt; An enumerator declared in class scope can be referred to using the cla=
ss member access<br>&gt; operators (::, . (dot) and -&gt; (arrow)) =C2=A0[E=
xample:<br>&gt; struct X {<br>&gt; =C2=A0 =C2=A0 enum direction { left=3D=
=E2=80=99l=E2=80=99, right=3D=E2=80=99r=E2=80=99 };<br>

&gt; };<br>&gt; void g(X* p) {<br>&gt; =C2=A0 =C2=A0 int i;<br>&gt; =C2=A0 =
=C2=A0 i =3D p-&gt;f(left); // error: left not in scope<br>&gt; =C2=A0 =C2=
=A0 i =3D p-&gt;f(X::right); // OK<br>&gt; }<br>&gt; =E2=80=94 end example =
]<br><br><br>&gt; inlined precompiler directives like this make the functio=
n hard to<br>

&gt; follow (mix of #if/#else/#endif and if/else).<br><br>I agree inlined p=
recompiler directives is bad style. Could you suggest a way to remove the m=
ix of #if/#else/#endif and if/else?<br><br>&gt; So each field need to be li=
sted ? We usually don&#39;t put NULL<br>

&gt; initialization for structures that are always in zero-initialized<br>&=
gt; memory. (coding style)<br><br>This is related to a known issue of g++: =
<a href=3D"http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D55606">http://gcc.=
gnu.org/bugzilla/show_bug.cgi?id=3D55606</a> (Bug 55606 - sorry, unimplemen=
ted: non-trivial designated initializers not supported).<br>

<br>g++&#39;s &#39;trivial designated initializers&#39; means no out-of-ord=
er initialization, no missing<br>initialization (except the fields on the t=
ail of a struct), and nested initialization should be done in the form {.fo=
o =3D {.bar =3D=C2=A01}} instead of {.foo.bar =3D 1}. That&#39;s why I made=
 such modification.<br>

<br>&gt; Are those changes also compatible with the LLVM c++ compiler ?<br>=
Actually, clang++ have designated initializers better supported than g++. A=
ll the modification about designated initializers are not required for clan=
g++. No need to add NULL initialization, reorder initializations or change =
{.foo.bar =3D 1} into {.foo =3D {.bar =3D 1}}. These (ugly) hacks are just =
to make g++ happy.<br>

<br>Cleaned-up patch attached.<br><div><br></div><div>Thanks.<div><br></div=
><div>From 36930fdfa25a6ea67de551300263dee353df43e5 Mon Sep 17 00:00:00 200=
1<br></div><div><div>From: Zifei Tong &lt;<a href=3D"mailto:soariez@gmail.c=
om">soariez@gmail.com</a>&gt;</div>

<div>Date: Sat, 20 Apr 2013 19:38:39 +0800</div><div>Subject: [PATCH lttng-=
ust] Fix: make &#39;hello.cxx&#39; compile with g++</div><div><br></div><di=
v>Fixes #338</div><div><br></div><div>Signed-off-by: Zifei Tong &lt;<a href=
=3D"mailto:soariez@gmail.com">soariez@gmail.com</a>&gt;</div>

<div>---</div><div>=C2=A0include/lttng/ringbuffer-config.h =C2=A0 =C2=A0| =
=C2=A05 +++++</div><div>=C2=A0include/lttng/tracepoint-event.h =C2=A0 =C2=
=A0 | 12 +++++------</div><div>=C2=A0include/lttng/ust-events.h =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 42 +++++++++++++++++++++++-------------</div>

<div>=C2=A0include/lttng/ust-tracepoint-event.h | 32 +++++++++++++++++-----=
-----</div><div>=C2=A0tests/hello.cxx/Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A02 +-</div><div>=C2=A0tests/hello.cxx/tp.c =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 26 ----------------------</div>=
<div>=C2=A0tests/hello.cxx/tp.cpp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 26 ++++++++++++++++++++++</div>

<div>=C2=A07 files changed, 86 insertions(+), 59 deletions(-)</div><div>=C2=
=A0delete mode 100644 tests/hello.cxx/tp.c</div><div>=C2=A0create mode 1006=
44 tests/hello.cxx/tp.cpp</div><div><br></div><div>diff --git a/include/ltt=
ng/ringbuffer-config.h b/include/lttng/ringbuffer-config.h</div>

<div>index ca52fc7..bb01eab 100644</div><div>--- a/include/lttng/ringbuffer=
-config.h</div><div>+++ b/include/lttng/ringbuffer-config.h</div><div>@@ -3=
47,8 +347,13 @@ int lib_ring_buffer_check_config(const struct lttng_ust_lib=
_ring_buffer_config *</div>

<div>=C2=A0<span class=3D"" style=3D"white-space:pre">			</span> =C2=A0 =C2=
=A0 unsigned int switch_timer_interval,</div><div>=C2=A0<span class=3D"" st=
yle=3D"white-space:pre">			</span> =C2=A0 =C2=A0 unsigned int read_timer_in=
terval)</div><div>=C2=A0{</div><div>+<span class=3D"" style=3D"white-space:=
pre">	</span>#ifdef __cplusplus</div>

<div>+<span class=3D"" style=3D"white-space:pre">	</span>if (config-&gt;all=
oc =3D=3D lttng_ust_lib_ring_buffer_config::RING_BUFFER_ALLOC_GLOBAL</div><=
div>+<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0 =C2=A0&amp;=
&amp; config-&gt;sync =3D=3D lttng_ust_lib_ring_buffer_config::RING_BUFFER_=
SYNC_PER_CPU</div>

<div>+<span class=3D"" style=3D"white-space:pre">	</span>#else</div><div>=
=C2=A0<span class=3D"" style=3D"white-space:pre">	</span>if (config-&gt;all=
oc =3D=3D RING_BUFFER_ALLOC_GLOBAL</div><div>=C2=A0<span class=3D"" style=
=3D"white-space:pre">	</span> =C2=A0 =C2=A0&amp;&amp; config-&gt;sync =3D=
=3D RING_BUFFER_SYNC_PER_CPU</div>

<div>+<span class=3D"" style=3D"white-space:pre">	</span>#endif</div><div>=
=C2=A0<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0 =C2=A0&amp=
;&amp; switch_timer_interval)</div><div>=C2=A0<span class=3D"" style=3D"whi=
te-space:pre">		</span>return -EINVAL;</div>

<div>=C2=A0<span class=3D"" style=3D"white-space:pre">	</span>return 0;</di=
v><div>diff --git a/include/lttng/tracepoint-event.h b/include/lttng/tracep=
oint-event.h</div><div>index 077eaa0..4630788 100644</div><div>--- a/includ=
e/lttng/tracepoint-event.h</div>

<div>+++ b/include/lttng/tracepoint-event.h</div><div>@@ -20,12 +20,12 @@</=
div><div>=C2=A0 * SOFTWARE.</div><div>=C2=A0 */</div><div>=C2=A0</div><div>=
+#ifdef TRACEPOINT_CREATE_PROBES</div><div>+</div><div>=C2=A0#ifdef __cplus=
plus</div><div>
=C2=A0extern &quot;C&quot; {</div>
<div>=C2=A0#endif</div><div>=C2=A0</div><div>-#ifdef TRACEPOINT_CREATE_PROB=
ES</div><div>-</div><div>=C2=A0#define __tp_stringify1(x)<span class=3D"" s=
tyle=3D"white-space:pre">	</span>#x</div><div>=C2=A0#define __tp_stringify(=
x)<span class=3D"" style=3D"white-space:pre">	</span>__tp_stringify1(x)</di=
v>

<div>=C2=A0</div><div>@@ -65,10 +65,10 @@ extern &quot;C&quot; {</div><div>=
=C2=A0#undef TRACEPOINT_INCLUDE_FILE</div><div>=C2=A0#undef TRACEPOINT_INCL=
UDE</div><div>=C2=A0</div><div>-#define TRACEPOINT_CREATE_PROBES</div><div>=
-</div><div>-#endif /* TRACEPOINT_CREATE_PROBES */</div>

<div>-</div><div>=C2=A0#ifdef __cplusplus</div><div>=C2=A0}</div><div>=C2=
=A0#endif</div><div>+</div><div>+#define TRACEPOINT_CREATE_PROBES</div><div=
>+</div><div>+#endif /* TRACEPOINT_CREATE_PROBES */</div><div>diff --git a/=
include/lttng/ust-events.h b/include/lttng/ust-events.h</div>

<div>index 749478a..e97cc1b 100644</div><div>--- a/include/lttng/ust-events=
.h</div><div>+++ b/include/lttng/ust-events.h</div><div>@@ -89,15 +89,21 @@=
 struct lttng_enum_entry {</div><div>=C2=A0</div><div>=C2=A0#define __type_=
integer(_type, _byte_order, _base, _encoding)<span class=3D"" style=3D"whit=
e-space:pre">	</span>\</div>

<div>=C2=A0<span class=3D"" style=3D"white-space:pre">	</span>{<span class=
=3D"" style=3D"white-space:pre">							</span>\</div><div>-<span class=3D""=
 style=3D"white-space:pre">	</span> =C2=A0 =C2=A0.atype =3D atype_integer,<=
span class=3D"" style=3D"white-space:pre">				</span>\</div>

<div>-<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0 =C2=A0.u.b=
asic.integer =3D<span class=3D"" style=3D"white-space:pre">					</span>\</d=
iv><div>+<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0.atype =
=3D atype_integer,<span class=3D"" style=3D"white-space:pre">				</span>\</=
div>

<div>+<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0.u =3D<span=
 class=3D"" style=3D"white-space:pre">							</span>\</div><div>=C2=A0<span=
 class=3D"" style=3D"white-space:pre">		</span>{<span class=3D"" style=3D"w=
hite-space:pre">						</span>\</div>

<div>-<span class=3D"" style=3D"white-space:pre">		</span> =C2=A0.size =3D =
sizeof(_type) * CHAR_BIT,<span class=3D"" style=3D"white-space:pre">		</spa=
n>\</div><div>-<span class=3D"" style=3D"white-space:pre">		</span> =C2=A0.=
alignment =3D lttng_alignof(_type) * CHAR_BIT,<span class=3D"" style=3D"whi=
te-space:pre">	</span>\</div>

<div>-<span class=3D"" style=3D"white-space:pre">		</span> =C2=A0.signednes=
s =3D lttng_is_signed_type(_type),<span class=3D"" style=3D"white-space:pre=
">	</span>\</div><div>-<span class=3D"" style=3D"white-space:pre">		</span>=
 =C2=A0.reverse_byte_order =3D _byte_order !=3D BYTE_ORDER,<span class=3D""=
 style=3D"white-space:pre">	</span>\</div>

<div>-<span class=3D"" style=3D"white-space:pre">		</span> =C2=A0.base =3D =
_base,<span class=3D"" style=3D"white-space:pre">				</span>\</div><div>-<s=
pan class=3D"" style=3D"white-space:pre">		</span> =C2=A0.encoding =3D lttn=
g_encode_##_encoding,<span class=3D"" style=3D"white-space:pre">		</span>\<=
/div>

<div>+<span class=3D"" style=3D"white-space:pre">		</span> =C2=A0.basic =3D=
 <span class=3D"" style=3D"white-space:pre">					</span>\</div><div>+<span =
class=3D"" style=3D"white-space:pre">			</span>{<span class=3D"" style=3D"w=
hite-space:pre">					</span>\</div>

<div>+<span class=3D"" style=3D"white-space:pre">			</span> =C2=A0.integer =
=3D<span class=3D"" style=3D"white-space:pre">				</span>\</div><div>+<span=
 class=3D"" style=3D"white-space:pre">				</span>{<span class=3D"" style=3D=
"white-space:pre">				</span>\</div>

<div>+<span class=3D"" style=3D"white-space:pre">				</span> =C2=A0.size =
=3D sizeof(_type) * CHAR_BIT,<span class=3D"" style=3D"white-space:pre">		<=
/span>\</div><div>+<span class=3D"" style=3D"white-space:pre">				</span> =
=C2=A0.alignment =3D lttng_alignof(_type) * CHAR_BIT,<span class=3D"" style=
=3D"white-space:pre">	</span>\</div>

<div>+<span class=3D"" style=3D"white-space:pre">				</span> =C2=A0.signedn=
ess =3D lttng_is_signed_type(_type),<span class=3D"" style=3D"white-space:p=
re">	</span>\</div><div>+<span class=3D"" style=3D"white-space:pre">				</s=
pan> =C2=A0.reverse_byte_order =3D _byte_order !=3D BYTE_ORDER,<span class=
=3D"" style=3D"white-space:pre">	</span>\</div>

<div>+<span class=3D"" style=3D"white-space:pre">				</span> =C2=A0.base =
=3D _base,<span class=3D"" style=3D"white-space:pre">				</span>\</div><div=
>+<span class=3D"" style=3D"white-space:pre">				</span> =C2=A0.encoding =
=3D lttng_encode_##_encoding,<span class=3D"" style=3D"white-space:pre">		<=
/span>\</div>

<div>+<span class=3D"" style=3D"white-space:pre">				</span>}<span class=3D=
"" style=3D"white-space:pre">				</span>\</div><div>+<span class=3D"" style=
=3D"white-space:pre">			</span>}<span class=3D"" style=3D"white-space:pre">=
					</span>\</div>

<div>=C2=A0<span class=3D"" style=3D"white-space:pre">		</span>},<span clas=
s=3D"" style=3D"white-space:pre">						</span>\</div><div>=C2=A0<span class=
=3D"" style=3D"white-space:pre">	</span>}<span class=3D"" style=3D"white-sp=
ace:pre">							</span>\</div>

<div>=C2=A0</div><div>@@ -123,14 +129,20 @@ struct lttng_integer_type {</di=
v><div>=C2=A0</div><div>=C2=A0#define __type_float(_type)<span class=3D"" s=
tyle=3D"white-space:pre">					</span>\</div><div>=C2=A0<span class=3D"" sty=
le=3D"white-space:pre">	</span>{<span class=3D"" style=3D"white-space:pre">=
							</span>\</div>

<div>-<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0 =C2=A0.aty=
pe =3D atype_float,<span class=3D"" style=3D"white-space:pre">				</span>\<=
/div><div>-<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0 =C2=
=A0.u.basic._float =3D<span class=3D"" style=3D"white-space:pre">					</spa=
n>\</div>

<div>+<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0.atype =3D =
atype_float,<span class=3D"" style=3D"white-space:pre">					</span>\</div><=
div>+<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0.u =3D<span =
class=3D"" style=3D"white-space:pre">							</span>\</div>

<div>=C2=A0<span class=3D"" style=3D"white-space:pre">		</span>{<span class=
=3D"" style=3D"white-space:pre">						</span>\</div><div>-<span class=3D"" =
style=3D"white-space:pre">		</span> =C2=A0.exp_dig =3D sizeof(_type) * CHAR=
_BIT<span class=3D"" style=3D"white-space:pre">		</span>\</div>

<div>-<span class=3D"" style=3D"white-space:pre">				</span>- _float_mant_d=
ig(_type),<span class=3D"" style=3D"white-space:pre">	</span>\</div><div>-<=
span class=3D"" style=3D"white-space:pre">		</span> =C2=A0.mant_dig =3D _fl=
oat_mant_dig(_type),<span class=3D"" style=3D"white-space:pre">		</span>\</=
div>

<div>-<span class=3D"" style=3D"white-space:pre">		</span> =C2=A0.alignment=
 =3D lttng_alignof(_type) * CHAR_BIT,<span class=3D"" style=3D"white-space:=
pre">	</span>\</div><div>-<span class=3D"" style=3D"white-space:pre">		</sp=
an> =C2=A0.reverse_byte_order =3D BYTE_ORDER !=3D FLOAT_WORD_ORDER, \</div>

<div>+<span class=3D"" style=3D"white-space:pre">		</span> =C2=A0.basic =3D=
<span class=3D"" style=3D"white-space:pre">					</span>\</div><div>+<span c=
lass=3D"" style=3D"white-space:pre">			</span>{<span class=3D"" style=3D"wh=
ite-space:pre">					</span>\</div>

<div>+<span class=3D"" style=3D"white-space:pre">			</span> =C2=A0._float =
=3D<span class=3D"" style=3D"white-space:pre">				</span>\</div><div>+<span=
 class=3D"" style=3D"white-space:pre">				</span>{<span class=3D"" style=3D=
"white-space:pre">				</span>\</div>

<div>+<span class=3D"" style=3D"white-space:pre">				</span> =C2=A0.exp_dig=
 =3D sizeof(_type) * CHAR_BIT<span class=3D"" style=3D"white-space:pre">		<=
/span>\</div><div>+<span class=3D"" style=3D"white-space:pre">						</span>=
 =C2=A0- _float_mant_dig(_type),<span class=3D"" style=3D"white-space:pre">=
	</span>\</div>

<div>+<span class=3D"" style=3D"white-space:pre">				</span> =C2=A0.mant_di=
g =3D _float_mant_dig(_type),<span class=3D"" style=3D"white-space:pre">		<=
/span>\</div><div>+<span class=3D"" style=3D"white-space:pre">				</span> =
=C2=A0.alignment =3D lttng_alignof(_type) * CHAR_BIT,<span class=3D"" style=
=3D"white-space:pre">	</span>\</div>

<div>+<span class=3D"" style=3D"white-space:pre">				</span> =C2=A0.reverse=
_byte_order =3D BYTE_ORDER !=3D FLOAT_WORD_ORDER,<span class=3D"" style=3D"=
white-space:pre">	</span>\</div><div>+<span class=3D"" style=3D"white-space=
:pre">				</span>}</div>

<div>+<span class=3D"" style=3D"white-space:pre">			</span>}</div><div>=C2=
=A0<span class=3D"" style=3D"white-space:pre">		</span>},<span class=3D"" s=
tyle=3D"white-space:pre">						</span>\</div><div>=C2=A0<span class=3D"" st=
yle=3D"white-space:pre">	</span>}<span class=3D"" style=3D"white-space:pre"=
>							</span>\</div>

<div>=C2=A0</div><div>diff --git a/include/lttng/ust-tracepoint-event.h b/i=
nclude/lttng/ust-tracepoint-event.h</div><div>index e46cc1a..3aa946d 100644=
</div><div>--- a/include/lttng/ust-tracepoint-event.h</div><div>+++ b/inclu=
de/lttng/ust-tracepoint-event.h</div>

<div>@@ -147,11 +147,14 @@ static const char<span class=3D"" style=3D"white=
-space:pre">							</span>\</div><div>=C2=A0<span class=3D"" style=3D"white=
-space:pre">	</span> =C2=A0.type =3D<span class=3D"" style=3D"white-space:p=
re">						</span>\</div>

<div>=C2=A0<span class=3D"" style=3D"white-space:pre">		</span>{<span class=
=3D"" style=3D"white-space:pre">						</span>\</div><div>=C2=A0<span class=
=3D"" style=3D"white-space:pre">		</span> =C2=A0.atype =3D atype_array,<spa=
n class=3D"" style=3D"white-space:pre">				</span>\</div>

<div>-<span class=3D"" style=3D"white-space:pre">		</span> =C2=A0.u.array =
=3D<span class=3D"" style=3D"white-space:pre">					</span>\</div><div>+<spa=
n class=3D"" style=3D"white-space:pre">		</span> =C2=A0.u =3D<span class=3D=
"" style=3D"white-space:pre">						</span>\</div>

<div>=C2=A0<span class=3D"" style=3D"white-space:pre">			</span>{<span clas=
s=3D"" style=3D"white-space:pre">					</span>\</div><div>-<span class=3D"" =
style=3D"white-space:pre">			</span> =C2=A0 =C2=A0.length =3D _length,<span=
 class=3D"" style=3D"white-space:pre">			</span>\</div>

<div>-<span class=3D"" style=3D"white-space:pre">			</span> =C2=A0 =C2=A0.e=
lem_type =3D __type_integer(_type, BYTE_ORDER, 10, _encoding), \</div><div>=
-<span class=3D"" style=3D"white-space:pre">			</span>},<span class=3D"" st=
yle=3D"white-space:pre">					</span>\</div>

<div>+<span class=3D"" style=3D"white-space:pre">			</span> =C2=A0.array =
=3D<span class=3D"" style=3D"white-space:pre">				</span>\</div><div>+<span=
 class=3D"" style=3D"white-space:pre">				</span>{<span class=3D"" style=3D=
"white-space:pre">				</span>\</div>

<div>+<span class=3D"" style=3D"white-space:pre">				</span> =C2=A0.elem_ty=
pe =3D __type_integer(_type, BYTE_ORDER, 10, _encoding), \</div><div>+<span=
 class=3D"" style=3D"white-space:pre">				</span> =C2=A0.length =3D _length=
,<span class=3D"" style=3D"white-space:pre">		</span>\</div>

<div>+<span class=3D"" style=3D"white-space:pre">				</span>}<span class=3D=
"" style=3D"white-space:pre">				</span>\</div><div>+<span class=3D"" style=
=3D"white-space:pre">			</span>}<span class=3D"" style=3D"white-space:pre">=
					</span>\</div>

<div>=C2=A0<span class=3D"" style=3D"white-space:pre">		</span>},<span clas=
s=3D"" style=3D"white-space:pre">						</span>\</div><div>=C2=A0<span class=
=3D"" style=3D"white-space:pre">	</span> =C2=A0.nowrite =3D _nowrite,<span =
class=3D"" style=3D"white-space:pre">					</span>\</div>

<div>=C2=A0<span class=3D"" style=3D"white-space:pre">	</span>},</div><div>=
@@ -164,10 +167,13 @@ static const char<span class=3D"" style=3D"white-spac=
e:pre">							</span>\</div><div>=C2=A0<span class=3D"" style=3D"white-spac=
e:pre">	</span> =C2=A0.type =3D<span class=3D"" style=3D"white-space:pre">	=
					</span>\</div>

<div>=C2=A0<span class=3D"" style=3D"white-space:pre">		</span>{<span class=
=3D"" style=3D"white-space:pre">						</span>\</div><div>=C2=A0<span class=
=3D"" style=3D"white-space:pre">		</span> =C2=A0.atype =3D atype_sequence,<=
span class=3D"" style=3D"white-space:pre">			</span>\</div>

<div>-<span class=3D"" style=3D"white-space:pre">		</span> =C2=A0.u.sequenc=
e =3D<span class=3D"" style=3D"white-space:pre">					</span>\</div><div>+<s=
pan class=3D"" style=3D"white-space:pre">		</span> =C2=A0.u =3D<span class=
=3D"" style=3D"white-space:pre">						</span>\</div>

<div>=C2=A0<span class=3D"" style=3D"white-space:pre">			</span>{<span clas=
s=3D"" style=3D"white-space:pre">					</span>\</div><div>-<span class=3D"" =
style=3D"white-space:pre">			</span> =C2=A0 =C2=A0.length_type =3D __type_i=
nteger(_length_type, BYTE_ORDER, 10, none), \</div>

<div>-<span class=3D"" style=3D"white-space:pre">			</span> =C2=A0 =C2=A0.e=
lem_type =3D __type_integer(_type, BYTE_ORDER, 10, _encoding), \</div><div>=
+<span class=3D"" style=3D"white-space:pre">			</span> =C2=A0.sequence =3D<=
/div><div>+<span class=3D"" style=3D"white-space:pre">				</span>{<span cla=
ss=3D"" style=3D"white-space:pre">				</span>\</div>

<div>+<span class=3D"" style=3D"white-space:pre">				</span> =C2=A0.length_=
type =3D __type_integer(_length_type, BYTE_ORDER, 10, none), \</div><div>+<=
span class=3D"" style=3D"white-space:pre">				</span> =C2=A0.elem_type =3D =
__type_integer(_type, BYTE_ORDER, 10, _encoding), \</div>

<div>+<span class=3D"" style=3D"white-space:pre">				</span>},<span class=
=3D"" style=3D"white-space:pre">				</span>\</div><div>=C2=A0<span class=3D=
"" style=3D"white-space:pre">			</span>},<span class=3D"" style=3D"white-sp=
ace:pre">					</span>\</div>

<div>=C2=A0<span class=3D"" style=3D"white-space:pre">		</span>},<span clas=
s=3D"" style=3D"white-space:pre">						</span>\</div><div>=C2=A0<span class=
=3D"" style=3D"white-space:pre">	</span> =C2=A0.nowrite =3D _nowrite,<span =
class=3D"" style=3D"white-space:pre">					</span>\</div>

<div>@@ -180,7 +186,10 @@ static const char<span class=3D"" style=3D"white-=
space:pre">							</span>\</div><div>=C2=A0<span class=3D"" style=3D"white-=
space:pre">	</span> =C2=A0.type =3D<span class=3D"" style=3D"white-space:pr=
e">						</span>\</div>

<div>=C2=A0<span class=3D"" style=3D"white-space:pre">		</span>{<span class=
=3D"" style=3D"white-space:pre">						</span>\</div><div>=C2=A0<span class=
=3D"" style=3D"white-space:pre">		</span> =C2=A0.atype =3D atype_string,<sp=
an class=3D"" style=3D"white-space:pre">			</span>\</div>

<div>-<span class=3D"" style=3D"white-space:pre">		</span> =C2=A0.u.basic.s=
tring.encoding =3D lttng_encode_UTF8,<span class=3D"" style=3D"white-space:=
pre">	</span>\</div><div>+<span class=3D"" style=3D"white-space:pre">		</sp=
an> =C2=A0.u =3D</div>

<div>+<span class=3D"" style=3D"white-space:pre">			</span>{</div><div>+<sp=
an class=3D"" style=3D"white-space:pre">			</span> =C2=A0.basic =3D { .stri=
ng =3D { .encoding =3D lttng_encode_UTF8 } } \</div><div>+<span class=3D"" =
style=3D"white-space:pre">			</span>},<span class=3D"" style=3D"white-space=
:pre">					</span>\</div>

<div>=C2=A0<span class=3D"" style=3D"white-space:pre">		</span>},<span clas=
s=3D"" style=3D"white-space:pre">						</span>\</div><div>=C2=A0<span class=
=3D"" style=3D"white-space:pre">	</span> =C2=A0.nowrite =3D _nowrite,<span =
class=3D"" style=3D"white-space:pre">					</span>\</div>

<div>=C2=A0<span class=3D"" style=3D"white-space:pre">	</span>},</div><div>=
@@ -483,7 +492,7 @@ void __event_probe__##_provider##___##_name(_TP_ARGS_DA=
TA_PROTO(_args)); =C2=A0 =C2=A0 =C2=A0\</div><div>=C2=A0static<span class=
=3D"" style=3D"white-space:pre">									</span> =C2=A0 =C2=A0 =C2=A0\</div=
>

<div>=C2=A0void __event_probe__##_provider##___##_name(_TP_ARGS_DATA_PROTO(=
_args))<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0 =C2=A0 =
=C2=A0\</div><div>=C2=A0{<span class=3D"" style=3D"white-space:pre">							=
		</span> =C2=A0 =C2=A0 =C2=A0\</div><div>-<span class=3D"" style=3D"white-=
space:pre">	</span>struct lttng_event *__event =3D __tp_data;<span class=3D=
"" style=3D"white-space:pre">			</span> =C2=A0 =C2=A0 =C2=A0\</div>

<div>+<span class=3D"" style=3D"white-space:pre">	</span>struct lttng_event=
 *__event =3D (struct lttng_event *) __tp_data;<span class=3D"" style=3D"wh=
ite-space:pre">			</span> =C2=A0 =C2=A0 =C2=A0\</div><div>=C2=A0<span class=
=3D"" style=3D"white-space:pre">	</span>struct lttng_channel *__chan =3D __=
event-&gt;chan;<span class=3D"" style=3D"white-space:pre">			</span> =C2=A0=
 =C2=A0 =C2=A0\</div>

<div>=C2=A0<span class=3D"" style=3D"white-space:pre">	</span>struct lttng_=
ust_lib_ring_buffer_ctx __ctx;<span class=3D"" style=3D"white-space:pre">		=
	</span> =C2=A0 =C2=A0 =C2=A0\</div><div>=C2=A0<span class=3D"" style=3D"wh=
ite-space:pre">	</span>size_t __event_len, __event_align;<span class=3D"" s=
tyle=3D"white-space:pre">				</span> =C2=A0 =C2=A0 =C2=A0\</div>

<div>@@ -612,13 +621,14 @@ static const char *<span class=3D"" style=3D"whi=
te-space:pre">							</span> =C2=A0 =C2=A0 =C2=A0 \</div><div>=C2=A0<span c=
lass=3D"" style=3D"white-space:pre">	</span>__ref_model_emf_uri___##_provid=
er##___##_name<span class=3D"" style=3D"white-space:pre">			</span> =C2=A0 =
=C2=A0 =C2=A0 \</div>

<div>=C2=A0<span class=3D"" style=3D"white-space:pre">	</span>__attribute__=
((weakref (&quot;_model_emf_uri___&quot; #_provider &quot;___&quot; #_name)=
));\</div><div>=C2=A0const struct lttng_event_desc __event_desc___##_provid=
er##_##_name =3D {<span class=3D"" style=3D"white-space:pre">	</span> =C2=
=A0 =C2=A0 =C2=A0 \</div>

<div>-<span class=3D"" style=3D"white-space:pre">	</span>.fields =3D __even=
t_fields___##_provider##___##_template,<span class=3D"" style=3D"white-spac=
e:pre">		</span> =C2=A0 =C2=A0 =C2=A0 \</div><div>=C2=A0<span class=3D"" st=
yle=3D"white-space:pre">	</span>.name =3D #_provider &quot;:&quot; #_name,<=
span class=3D"" style=3D"white-space:pre">					</span> =C2=A0 =C2=A0 =C2=A0=
 \</div>

<div>=C2=A0<span class=3D"" style=3D"white-space:pre">	</span>.probe_callba=
ck =3D (void (*)(void)) &amp;__event_probe__##_provider##___##_template,\</=
div><div>+<span class=3D"" style=3D"white-space:pre">	</span>.ctx =3D NULL,=
<span class=3D"" style=3D"white-space:pre">							</span> =C2=A0 =C2=A0 =C2=
=A0 \</div>

<div>+<span class=3D"" style=3D"white-space:pre">	</span>.fields =3D __even=
t_fields___##_provider##___##_template,<span class=3D"" style=3D"white-spac=
e:pre">		</span> =C2=A0 =C2=A0 =C2=A0 \</div><div>=C2=A0<span class=3D"" st=
yle=3D"white-space:pre">	</span>.nr_fields =3D _TP_ARRAY_SIZE(__event_field=
s___##_provider##___##_template), \</div>

<div>=C2=A0<span class=3D"" style=3D"white-space:pre">	</span>.loglevel =3D=
 &amp;__ref_loglevel___##_provider##___##_name,<span class=3D"" style=3D"wh=
ite-space:pre">		</span> =C2=A0 =C2=A0 =C2=A0 \</div><div>=C2=A0<span class=
=3D"" style=3D"white-space:pre">	</span>.signature =3D __tp_event_signature=
___##_provider##___##_template, =C2=A0 =C2=A0 =C2=A0 \</div>

<div>-<span class=3D"" style=3D"white-space:pre">	</span>.u.ext.model_emf_u=
ri =3D &amp;__ref_model_emf_uri___##_provider##___##_name, \</div><div>+<sp=
an class=3D"" style=3D"white-space:pre">	</span>.u =3D { .ext =3D { .model_=
emf_uri =3D &amp;__ref_model_emf_uri___##_provider##___##_name } }, \</div>

<div>=C2=A0};</div><div>=C2=A0</div><div>=C2=A0#include TRACEPOINT_INCLUDE<=
/div><div>diff --git a/tests/hello.cxx/Makefile.am b/tests/hello.cxx/Makefi=
le.am</div><div>index 897416d..5f6c615 100644</div><div>--- a/tests/hello.c=
xx/Makefile.am</div>

<div>+++ b/tests/hello.cxx/Makefile.am</div><div>@@ -1,7 +1,7 @@</div><div>=
=C2=A0AM_CPPFLAGS =3D -I$(top_srcdir)/include -I$(top_builddir)/include -Ws=
ystem-headers</div><div>=C2=A0</div><div>=C2=A0noinst_PROGRAMS =3D hello</d=
iv><div>-hello_SOURCES =3D hello.cpp tp.c ust_tests_hello.h</div>

<div>+hello_SOURCES =3D hello.cpp tp.cpp ust_tests_hello.h</div><div>=C2=A0=
hello_LDADD =3D $(top_builddir)/liblttng-ust/<a href=3D"http://liblttng-ust=
.la">liblttng-ust.la</a></div><div>=C2=A0</div><div>=C2=A0if LTTNG_UST_BUIL=
D_WITH_LIBDL</div>

<div>diff --git a/tests/hello.cxx/tp.c b/tests/hello.cxx/tp.c</div><div>del=
eted file mode 100644</div><div>index 4790965..0000000</div><div>--- a/test=
s/hello.cxx/tp.c</div><div>+++ /dev/null</div><div>@@ -1,26 +0,0 @@</div>

<div>-/*</div><div>- * tp.c</div><div>- *</div><div>- * Copyright (c) 2011 =
Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com">mat=
hieu.desnoyers@efficios.com</a>&gt;</div><div>- *</div><div>- * Permission =
is hereby granted, free of charge, to any person obtaining a copy</div>

<div>- * of this software and associated documentation files (the &quot;Sof=
tware&quot;), to deal</div><div>- * in the Software without restriction, in=
cluding without limitation the rights</div><div>- * to use, copy, modify, m=
erge, publish, distribute, sublicense, and/or sell</div>

<div>- * copies of the Software, and to permit persons to whom the Software=
 is</div><div>- * furnished to do so, subject to the following conditions:<=
/div><div>- *</div><div>- * The above copyright notice and this permission =
notice shall be included in</div>

<div>- * all copies or substantial portions of the Software.</div><div>- *<=
/div><div>- * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY =
OF ANY KIND, EXPRESS OR</div><div>- * IMPLIED, INCLUDING BUT NOT LIMITED TO=
 THE WARRANTIES OF MERCHANTABILITY,</div>

<div>- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT =
SHALL THE</div><div>- * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAI=
M, DAMAGES OR OTHER</div><div>- * LIABILITY, WHETHER IN AN ACTION OF CONTRA=
CT, TORT OR OTHERWISE, ARISING FROM,</div>

<div>- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEAL=
INGS IN THE</div><div>- * SOFTWARE.</div><div>- */</div><div>-</div><div>-#=
define TRACEPOINT_CREATE_PROBES</div><div>-#include &quot;ust_tests_hello.h=
&quot;</div>

<div>diff --git a/tests/hello.cxx/tp.cpp b/tests/hello.cxx/tp.cpp</div><div=
>new file mode 100644</div><div>index 0000000..a2099ab</div><div>--- /dev/n=
ull</div><div>+++ b/tests/hello.cxx/tp.cpp</div><div>@@ -0,0 +1,26 @@</div>

<div>+/*</div><div>+ * tp.cpp</div><div>+ *</div><div>+ * Copyright (c) 201=
1 Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com">m=
athieu.desnoyers@efficios.com</a>&gt;</div><div>+ *</div><div>+ * Permissio=
n is hereby granted, free of charge, to any person obtaining a copy</div>

<div>+ * of this software and associated documentation files (the &quot;Sof=
tware&quot;), to deal</div><div>+ * in the Software without restriction, in=
cluding without limitation the rights</div><div>+ * to use, copy, modify, m=
erge, publish, distribute, sublicense, and/or sell</div>

<div>+ * copies of the Software, and to permit persons to whom the Software=
 is</div><div>+ * furnished to do so, subject to the following conditions:<=
/div><div>+ *</div><div>+ * The above copyright notice and this permission =
notice shall be included in</div>

<div>+ * all copies or substantial portions of the Software.</div><div>+ *<=
/div><div>+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY =
OF ANY KIND, EXPRESS OR</div><div>+ * IMPLIED, INCLUDING BUT NOT LIMITED TO=
 THE WARRANTIES OF MERCHANTABILITY,</div>

<div>+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT =
SHALL THE</div><div>+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAI=
M, DAMAGES OR OTHER</div><div>+ * LIABILITY, WHETHER IN AN ACTION OF CONTRA=
CT, TORT OR OTHERWISE, ARISING FROM,</div>

<div>+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEAL=
INGS IN THE</div><div>+ * SOFTWARE.</div><div>+ */</div><div>+</div><div>+#=
define TRACEPOINT_CREATE_PROBES</div><div>+#include &quot;ust_tests_hello.h=
&quot;</div>

<div>--=C2=A0</div><div>1.8.2.1</div></div><div><br>--<br>Best Regards,<br>=
=E4=BB=9D=E5=AD=90=E9=A3=9E (Zifei Tong)<br>College of Computer Science and=
 Technology, Zhejiang University<br><br><a href=3D"mailto:soariez@gmail.com=
">soariez@gmail.com</a> / <a href=3D"mailto:tongzifei@zju.edu.cn">tongzifei=
@zju.edu.cn</a></div>

</div></div>

--047d7b6726666b48ee04dae2007d--


--===============1508911010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1508911010==--
