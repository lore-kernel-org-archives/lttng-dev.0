From: Xiaona Han <xiaonahappy13@gmail.com>
Subject: [PATCH babeltrace] Make python bindings compile with
	trunk
Date: Thu, 27 Jun 2013 20:54:55 +0800
Message-ID: <CAMMh03NJNPvYEcXLcaUBhiJTgM2hEQm1Q8-pL0nRSixNPc0ctA__42794.689074117$1372337744$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0397859753=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <xiaonahappy13@gmail.com>) id 1UsBj3-00015P-2q
	for lttng-dev@lists.lttng.org; Thu, 27 Jun 2013 08:55:01 -0400
Received: by mail-ob0-f173.google.com with SMTP id wc20so672708obb.4
	for <lttng-dev@lists.lttng.org>; Thu, 27 Jun 2013 05:54:55 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0397859753==
Content-Type: multipart/alternative; boundary=001a11c3059ed3f16d04e022445c

--001a11c3059ed3f16d04e022445c
Content-Type: text/plain; charset=ISO-8859-1

Signed-off-by: Xiaona Han <xiaonahappy13@gmail.com>
---
 bindings/python/babeltrace.i.in      |   73
+++++++++++++++++-----------------
 bindings/python/python-complements.c |   12 +++---
 bindings/python/python-complements.h |    8 ++--
 3 files changed, 46 insertions(+), 47 deletions(-)

diff --git a/bindings/python/babeltrace.i.in b/bindings/python/
babeltrace.i.in
index a5426c8..bb0a9b3 100644
--- a/bindings/python/babeltrace.i.in
+++ b/bindings/python/babeltrace.i.in
@@ -45,7 +45,6 @@ trace to it."
 #include <babeltrace/iterator-internal.h>
 #include <babeltrace/format.h>
 #include <babeltrace/list.h>
-#include <babeltrace/uuid.h>
 #include <babeltrace/types.h>
 #include <babeltrace/ctf/iterator.h>
 #include "python-complements.h"
@@ -74,8 +73,8 @@ typedef int bt_intern_str;

 struct bt_context *bt_context_create(void);
 int bt_context_add_trace(struct bt_context *ctx, const char *path, const
char *format,
-        void (*packet_seek)(struct stream_pos *pos, size_t index, int
whence),
-        struct mmap_stream_list *stream_list, FILE *metadata);
+        void (*packet_seek)(struct bt_stream_pos *pos, size_t index, int
whence),
+        struct bt_mmap_stream_list *stream_list, FILE *metadata);
 void bt_context_remove_trace(struct bt_context *ctx, int trace_id);
 void bt_context_get(struct bt_context *ctx);
 void bt_context_put(struct bt_context *ctx);
@@ -192,7 +191,7 @@ class Context:

 extern struct format *bt_lookup_format(bt_intern_str qname);
 extern void bt_fprintf_format_list(FILE *fp);
-extern int bt_register_format(struct format *format);
+extern int bt_register_format(struct bt_format *format);

 %pythoncode %{

@@ -550,58 +549,58 @@ struct bt_ctf_event *bt_ctf_iter_read_event(struct
bt_ctf_iter *iter);
         const struct bt_ctf_event *ctf_event);

 %rename("_bt_ctf_get_field") bt_ctf_get_field(const struct bt_ctf_event
*ctf_event,
-        const struct definition *scope,    const char *field);
+        const struct bt_definition *scope,    const char *field);
 %rename("_bt_ctf_get_index") bt_ctf_get_index(const struct bt_ctf_event
*ctf_event,
-        const struct definition *field,    unsigned int index);
-%rename("_bt_ctf_field_name") bt_ctf_field_name(const struct definition
*field);
-%rename("_bt_ctf_field_type") bt_ctf_field_type(const struct declaration
*field);
+        const struct bt_definition *field,    unsigned int index);
+%rename("_bt_ctf_field_name") bt_ctf_field_name(const struct bt_definition
*field);
+%rename("_bt_ctf_field_type") bt_ctf_field_type(const struct
bt_declaration *field);
 %rename("_bt_ctf_get_int_signedness") bt_ctf_get_int_signedness(
-        const struct declaration *field);
-%rename("_bt_ctf_get_int_base") bt_ctf_get_int_base(const struct
declaration *field);
+        const struct bt_declaration *field);
+%rename("_bt_ctf_get_int_base") bt_ctf_get_int_base(const struct
bt_declaration *field);
 %rename("_bt_ctf_get_int_byte_order") bt_ctf_get_int_byte_order(
-        const struct declaration *field);
-%rename("_bt_ctf_get_int_len") bt_ctf_get_int_len(const struct declaration
*field);
-%rename("_bt_ctf_get_encoding") bt_ctf_get_encoding(const struct
declaration *field);
-%rename("_bt_ctf_get_array_len") bt_ctf_get_array_len(const struct
declaration *field);
-%rename("_bt_ctf_get_uint64") bt_ctf_get_uint64(const struct definition
*field);
-%rename("_bt_ctf_get_int64") bt_ctf_get_int64(const struct definition
*field);
-%rename("_bt_ctf_get_char_array") bt_ctf_get_char_array(const struct
definition *field);
-%rename("_bt_ctf_get_string") bt_ctf_get_string(const struct definition
*field);
+        const struct bt_declaration *field);
+%rename("_bt_ctf_get_int_len") bt_ctf_get_int_len(const struct
bt_declaration *field);
+%rename("_bt_ctf_get_encoding") bt_ctf_get_encoding(const struct
bt_declaration *field);
+%rename("_bt_ctf_get_array_len") bt_ctf_get_array_len(const struct
bt_declaration *field);
+%rename("_bt_ctf_get_uint64") bt_ctf_get_uint64(const struct bt_definition
*field);
+%rename("_bt_ctf_get_int64") bt_ctf_get_int64(const struct bt_definition
*field);
+%rename("_bt_ctf_get_char_array") bt_ctf_get_char_array(const struct
bt_definition *field);
+%rename("_bt_ctf_get_string") bt_ctf_get_string(const struct bt_definition
*field);
 %rename("_bt_ctf_field_get_error") bt_ctf_field_get_error(void);
 %rename("_bt_ctf_get_decl_event_name") bt_ctf_get_decl_event_name(const
struct
         bt_ctf_event_decl *event);
 %rename("_bt_ctf_get_decl_field_name") bt_ctf_get_decl_field_name(
         const struct bt_ctf_field_decl *field);
 %rename("_bt_ctf_get_decl_from_def") bt_ctf_get_decl_from_def(
-        const struct definition *field);
+        const struct bt_definition *field);

-const struct definition *bt_ctf_get_top_level_scope(const struct
bt_ctf_event *ctf_event,
+const struct bt_definition *bt_ctf_get_top_level_scope(const struct
bt_ctf_event *ctf_event,
         enum bt_ctf_scope scope);
 const char *bt_ctf_event_name(const struct bt_ctf_event *ctf_event);
 uint64_t bt_ctf_get_timestamp(const struct bt_ctf_event *ctf_event);
 uint64_t bt_ctf_get_cycles(const struct bt_ctf_event *ctf_event);
-const struct definition *bt_ctf_get_field(const struct bt_ctf_event
*ctf_event,
-        const struct definition *scope,
+const struct bt_definition *bt_ctf_get_field(const struct bt_ctf_event
*ctf_event,
+        const struct bt_definition *scope,
         const char *field);
-const struct definition *bt_ctf_get_index(const struct bt_ctf_event
*ctf_event,
-        const struct definition *field,
+const struct bt_definition *bt_ctf_get_index(const struct bt_ctf_event
*ctf_event,
+        const struct bt_definition *field,
         unsigned int index);
-const char *bt_ctf_field_name(const struct definition *field);
-enum ctf_type_id bt_ctf_field_type(const struct declaration *field);
-int bt_ctf_get_int_signedness(const struct declaration *field);
-int bt_ctf_get_int_base(const struct declaration *field);
-int bt_ctf_get_int_byte_order(const struct declaration *field);
-ssize_t bt_ctf_get_int_len(const struct declaration *field);
-enum ctf_string_encoding bt_ctf_get_encoding(const struct declaration
*field);
-int bt_ctf_get_array_len(const struct declaration *field);
-uint64_t bt_ctf_get_uint64(const struct definition *field);
-int64_t bt_ctf_get_int64(const struct definition *field);
-char *bt_ctf_get_char_array(const struct definition *field);
-char *bt_ctf_get_string(const struct definition *field);
+const char *bt_ctf_field_name(const struct bt_definition *field);
+enum ctf_type_id bt_ctf_field_type(const struct bt_declaration *field);
+int bt_ctf_get_int_signedness(const struct bt_declaration *field);
+int bt_ctf_get_int_base(const struct bt_declaration *field);
+int bt_ctf_get_int_byte_order(const struct bt_declaration *field);
+ssize_t bt_ctf_get_int_len(const struct bt_declaration *field);
+enum ctf_string_encoding bt_ctf_get_encoding(const struct bt_declaration
*field);
+int bt_ctf_get_array_len(const struct bt_declaration *field);
+uint64_t bt_ctf_get_uint64(const struct bt_definition *field);
+int64_t bt_ctf_get_int64(const struct bt_definition *field);
+char *bt_ctf_get_char_array(const struct bt_definition *field);
+char *bt_ctf_get_string(const struct bt_definition *field);
 int bt_ctf_field_get_error(void);
 const char *bt_ctf_get_decl_event_name(const struct bt_ctf_event_decl
*event);
 const char *bt_ctf_get_decl_field_name(const struct bt_ctf_field_decl
*field);
-const struct declaration *bt_ctf_get_decl_from_def(const struct definition
*field);
+const struct bt_declaration *bt_ctf_get_decl_from_def(const struct
bt_definition *field);

 %pythoncode%{

diff --git a/bindings/python/python-complements.c
b/bindings/python/python-complements.c
index a4ee37e..aa65555 100644
--- a/bindings/python/python-complements.c
+++ b/bindings/python/python-complements.c
@@ -44,16 +44,16 @@ void _bt_file_close(FILE *fp)
 */

 /* ctf-field-list */
-struct definition **_bt_python_field_listcaller(
+struct bt_definition **_bt_python_field_listcaller(
         const struct bt_ctf_event *ctf_event,
-        const struct definition *scope)
+        const struct bt_definition *scope)
 {
-    struct definition **list;
+    struct bt_definition **list;
     unsigned int count;
     int ret;

     ret = bt_ctf_get_field_list(ctf_event, scope,
-        (const struct definition * const **)&list, &count);
+        (const struct bt_definition * const **)&list, &count);

     if (ret < 0)    /* For python to know an error occured */
         list = NULL;
@@ -63,8 +63,8 @@ struct definition **_bt_python_field_listcaller(
     return list;
 }

-struct definition *_bt_python_field_one_from_list(
-        struct definition **list, int index)
+struct bt_definition *_bt_python_field_one_from_list(
+        struct bt_definition **list, int index)
 {
     return list[index];
 }
diff --git a/bindings/python/python-complements.h
b/bindings/python/python-complements.h
index 9597d70..4335d8a 100644
--- a/bindings/python/python-complements.h
+++ b/bindings/python/python-complements.h
@@ -32,11 +32,11 @@ FILE *_bt_file_open(char *file_path, char *mode);
 void _bt_file_close(FILE *fp);

 /* ctf-field-list */
-struct definition **_bt_python_field_listcaller(
+struct bt_definition **_bt_python_field_listcaller(
         const struct bt_ctf_event *ctf_event,
-        const struct definition *scope);
-struct definition *_bt_python_field_one_from_list(
-        struct definition **list, int index);
+        const struct bt_definition *scope);
+struct bt_definition *_bt_python_field_one_from_list(
+        struct bt_definition **list, int index);

 /* event_decl_list */
 struct bt_ctf_event_decl **_bt_python_event_decl_listcaller(
-- 
1.7.1

--001a11c3059ed3f16d04e022445c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Signed-off-by: Xiaona Han &lt;<a href=3D"mailto:xiaonahapp=
y13@gmail.com">xiaonahappy13@gmail.com</a>&gt;<br>---<br>=A0bindings/python=
/<a href=3D"http://babeltrace.i.in">babeltrace.i.in</a>=A0=A0=A0=A0=A0 |=A0=
=A0 73 +++++++++++++++++-----------------<br>
=A0bindings/python/python-complements.c |=A0=A0 12 +++---<br>=A0bindings/py=
thon/python-complements.h |=A0=A0=A0 8 ++--<br>=A03 files changed, 46 inser=
tions(+), 47 deletions(-)<br><br>diff --git a/bindings/python/<a href=3D"ht=
tp://babeltrace.i.in">babeltrace.i.in</a> b/bindings/python/<a href=3D"http=
://babeltrace.i.in">babeltrace.i.in</a><br>
index a5426c8..bb0a9b3 100644<br>--- a/bindings/python/<a href=3D"http://ba=
beltrace.i.in">babeltrace.i.in</a><br>+++ b/bindings/python/<a href=3D"http=
://babeltrace.i.in">babeltrace.i.in</a><br>@@ -45,7 +45,6 @@ trace to it.&q=
uot;<br>
=A0#include &lt;babeltrace/iterator-internal.h&gt;<br>=A0#include &lt;babel=
trace/format.h&gt;<br>=A0#include &lt;babeltrace/list.h&gt;<br>-#include &l=
t;babeltrace/uuid.h&gt;<br>=A0#include &lt;babeltrace/types.h&gt;<br>=A0#in=
clude &lt;babeltrace/ctf/iterator.h&gt;<br>
=A0#include &quot;python-complements.h&quot;<br>@@ -74,8 +73,8 @@ typedef i=
nt bt_intern_str;<br>=A0<br>=A0struct bt_context *bt_context_create(void);<=
br>=A0int bt_context_add_trace(struct bt_context *ctx, const char *path, co=
nst char *format,<br>
-=A0=A0 =A0=A0=A0 =A0void (*packet_seek)(struct stream_pos *pos, size_t ind=
ex, int whence),<br>-=A0=A0 =A0=A0=A0 =A0struct mmap_stream_list *stream_li=
st, FILE *metadata);<br>+=A0=A0 =A0=A0=A0 =A0void (*packet_seek)(struct bt_=
stream_pos *pos, size_t index, int whence),<br>
+=A0=A0 =A0=A0=A0 =A0struct bt_mmap_stream_list *stream_list, FILE *metadat=
a);<br>=A0void bt_context_remove_trace(struct bt_context *ctx, int trace_id=
);<br>=A0void bt_context_get(struct bt_context *ctx);<br>=A0void bt_context=
_put(struct bt_context *ctx);<br>
@@ -192,7 +191,7 @@ class Context:<br>=A0<br>=A0extern struct format *bt_lo=
okup_format(bt_intern_str qname);<br>=A0extern void bt_fprintf_format_list(=
FILE *fp);<br>-extern int bt_register_format(struct format *format);<br>+ex=
tern int bt_register_format(struct bt_format *format);<br>
=A0<br>=A0%pythoncode %{<br>=A0<br>@@ -550,58 +549,58 @@ struct bt_ctf_even=
t *bt_ctf_iter_read_event(struct bt_ctf_iter *iter);<br>=A0=A0=A0=A0 =A0=A0=
=A0 const struct bt_ctf_event *ctf_event);<br>=A0<br>=A0%rename(&quot;_bt_c=
tf_get_field&quot;) bt_ctf_get_field(const struct bt_ctf_event *ctf_event,<=
br>
-=A0=A0 =A0=A0=A0 =A0const struct definition *scope,=A0=A0 =A0const char *f=
ield);<br>+=A0=A0 =A0=A0=A0 =A0const struct bt_definition *scope,=A0=A0 =A0=
const char *field);<br>=A0%rename(&quot;_bt_ctf_get_index&quot;) bt_ctf_get=
_index(const struct bt_ctf_event *ctf_event,<br>
-=A0=A0 =A0=A0=A0 =A0const struct definition *field,=A0=A0 =A0unsigned int =
index);<br>-%rename(&quot;_bt_ctf_field_name&quot;) bt_ctf_field_name(const=
 struct definition *field);<br>-%rename(&quot;_bt_ctf_field_type&quot;) bt_=
ctf_field_type(const struct declaration *field);<br>
+=A0=A0 =A0=A0=A0 =A0const struct bt_definition *field,=A0=A0 =A0unsigned i=
nt index);<br>+%rename(&quot;_bt_ctf_field_name&quot;) bt_ctf_field_name(co=
nst struct bt_definition *field);<br>+%rename(&quot;_bt_ctf_field_type&quot=
;) bt_ctf_field_type(const struct bt_declaration *field);<br>
=A0%rename(&quot;_bt_ctf_get_int_signedness&quot;) bt_ctf_get_int_signednes=
s(<br>-=A0=A0 =A0=A0=A0 =A0const struct declaration *field);<br>-%rename(&q=
uot;_bt_ctf_get_int_base&quot;) bt_ctf_get_int_base(const struct declaratio=
n *field);<br>
+=A0=A0 =A0=A0=A0 =A0const struct bt_declaration *field);<br>+%rename(&quot=
;_bt_ctf_get_int_base&quot;) bt_ctf_get_int_base(const struct bt_declaratio=
n *field);<br>=A0%rename(&quot;_bt_ctf_get_int_byte_order&quot;) bt_ctf_get=
_int_byte_order(<br>
-=A0=A0 =A0=A0=A0 =A0const struct declaration *field);<br>-%rename(&quot;_b=
t_ctf_get_int_len&quot;) bt_ctf_get_int_len(const struct declaration *field=
);<br>-%rename(&quot;_bt_ctf_get_encoding&quot;) bt_ctf_get_encoding(const =
struct declaration *field);<br>
-%rename(&quot;_bt_ctf_get_array_len&quot;) bt_ctf_get_array_len(const stru=
ct declaration *field);<br>-%rename(&quot;_bt_ctf_get_uint64&quot;) bt_ctf_=
get_uint64(const struct definition *field);<br>-%rename(&quot;_bt_ctf_get_i=
nt64&quot;) bt_ctf_get_int64(const struct definition *field);<br>
-%rename(&quot;_bt_ctf_get_char_array&quot;) bt_ctf_get_char_array(const st=
ruct definition *field);<br>-%rename(&quot;_bt_ctf_get_string&quot;) bt_ctf=
_get_string(const struct definition *field);<br>+=A0=A0 =A0=A0=A0 =A0const =
struct bt_declaration *field);<br>
+%rename(&quot;_bt_ctf_get_int_len&quot;) bt_ctf_get_int_len(const struct b=
t_declaration *field);<br>+%rename(&quot;_bt_ctf_get_encoding&quot;) bt_ctf=
_get_encoding(const struct bt_declaration *field);<br>+%rename(&quot;_bt_ct=
f_get_array_len&quot;) bt_ctf_get_array_len(const struct bt_declaration *fi=
eld);<br>
+%rename(&quot;_bt_ctf_get_uint64&quot;) bt_ctf_get_uint64(const struct bt_=
definition *field);<br>+%rename(&quot;_bt_ctf_get_int64&quot;) bt_ctf_get_i=
nt64(const struct bt_definition *field);<br>+%rename(&quot;_bt_ctf_get_char=
_array&quot;) bt_ctf_get_char_array(const struct bt_definition *field);<br>
+%rename(&quot;_bt_ctf_get_string&quot;) bt_ctf_get_string(const struct bt_=
definition *field);<br>=A0%rename(&quot;_bt_ctf_field_get_error&quot;) bt_c=
tf_field_get_error(void);<br>=A0%rename(&quot;_bt_ctf_get_decl_event_name&q=
uot;) bt_ctf_get_decl_event_name(const struct<br>
=A0=A0=A0=A0 =A0=A0=A0 bt_ctf_event_decl *event);<br>=A0%rename(&quot;_bt_c=
tf_get_decl_field_name&quot;) bt_ctf_get_decl_field_name(<br>=A0=A0=A0=A0 =
=A0=A0=A0 const struct bt_ctf_field_decl *field);<br>=A0%rename(&quot;_bt_c=
tf_get_decl_from_def&quot;) bt_ctf_get_decl_from_def(<br>
-=A0=A0 =A0=A0=A0 =A0const struct definition *field);<br>+=A0=A0 =A0=A0=A0 =
=A0const struct bt_definition *field);<br>=A0<br>-const struct definition *=
bt_ctf_get_top_level_scope(const struct bt_ctf_event *ctf_event,<br>+const =
struct bt_definition *bt_ctf_get_top_level_scope(const struct bt_ctf_event =
*ctf_event,<br>
=A0=A0=A0=A0 =A0=A0=A0 enum bt_ctf_scope scope);<br>=A0const char *bt_ctf_e=
vent_name(const struct bt_ctf_event *ctf_event);<br>=A0uint64_t bt_ctf_get_=
timestamp(const struct bt_ctf_event *ctf_event);<br>=A0uint64_t bt_ctf_get_=
cycles(const struct bt_ctf_event *ctf_event);<br>
-const struct definition *bt_ctf_get_field(const struct bt_ctf_event *ctf_e=
vent,<br>-=A0=A0 =A0=A0=A0 =A0const struct definition *scope,<br>+const str=
uct bt_definition *bt_ctf_get_field(const struct bt_ctf_event *ctf_event,<b=
r>+=A0=A0 =A0=A0=A0 =A0const struct bt_definition *scope,<br>
=A0=A0=A0=A0 =A0=A0=A0 const char *field);<br>-const struct definition *bt_=
ctf_get_index(const struct bt_ctf_event *ctf_event,<br>-=A0=A0 =A0=A0=A0 =
=A0const struct definition *field,<br>+const struct bt_definition *bt_ctf_g=
et_index(const struct bt_ctf_event *ctf_event,<br>
+=A0=A0 =A0=A0=A0 =A0const struct bt_definition *field,<br>=A0=A0=A0=A0 =A0=
=A0=A0 unsigned int index);<br>-const char *bt_ctf_field_name(const struct =
definition *field);<br>-enum ctf_type_id bt_ctf_field_type(const struct dec=
laration *field);<br>-int bt_ctf_get_int_signedness(const struct declaratio=
n *field);<br>
-int bt_ctf_get_int_base(const struct declaration *field);<br>-int bt_ctf_g=
et_int_byte_order(const struct declaration *field);<br>-ssize_t bt_ctf_get_=
int_len(const struct declaration *field);<br>-enum ctf_string_encoding bt_c=
tf_get_encoding(const struct declaration *field);<br>
-int bt_ctf_get_array_len(const struct declaration *field);<br>-uint64_t bt=
_ctf_get_uint64(const struct definition *field);<br>-int64_t bt_ctf_get_int=
64(const struct definition *field);<br>-char *bt_ctf_get_char_array(const s=
truct definition *field);<br>
-char *bt_ctf_get_string(const struct definition *field);<br>+const char *b=
t_ctf_field_name(const struct bt_definition *field);<br>+enum ctf_type_id b=
t_ctf_field_type(const struct bt_declaration *field);<br>+int bt_ctf_get_in=
t_signedness(const struct bt_declaration *field);<br>
+int bt_ctf_get_int_base(const struct bt_declaration *field);<br>+int bt_ct=
f_get_int_byte_order(const struct bt_declaration *field);<br>+ssize_t bt_ct=
f_get_int_len(const struct bt_declaration *field);<br>+enum ctf_string_enco=
ding bt_ctf_get_encoding(const struct bt_declaration *field);<br>
+int bt_ctf_get_array_len(const struct bt_declaration *field);<br>+uint64_t=
 bt_ctf_get_uint64(const struct bt_definition *field);<br>+int64_t bt_ctf_g=
et_int64(const struct bt_definition *field);<br>+char *bt_ctf_get_char_arra=
y(const struct bt_definition *field);<br>
+char *bt_ctf_get_string(const struct bt_definition *field);<br>=A0int bt_c=
tf_field_get_error(void);<br>=A0const char *bt_ctf_get_decl_event_name(cons=
t struct bt_ctf_event_decl *event);<br>=A0const char *bt_ctf_get_decl_field=
_name(const struct bt_ctf_field_decl *field);<br>
-const struct declaration *bt_ctf_get_decl_from_def(const struct definition=
 *field);<br>+const struct bt_declaration *bt_ctf_get_decl_from_def(const s=
truct bt_definition *field);<br>=A0<br>=A0%pythoncode%{<br>=A0<br>diff --gi=
t a/bindings/python/python-complements.c b/bindings/python/python-complemen=
ts.c<br>
index a4ee37e..aa65555 100644<br>--- a/bindings/python/python-complements.c=
<br>+++ b/bindings/python/python-complements.c<br>@@ -44,16 +44,16 @@ void =
_bt_file_close(FILE *fp)<br>=A0*/<br>=A0<br>=A0/* ctf-field-list */<br>-str=
uct definition **_bt_python_field_listcaller(<br>
+struct bt_definition **_bt_python_field_listcaller(<br>=A0=A0=A0=A0 =A0=A0=
=A0 const struct bt_ctf_event *ctf_event,<br>-=A0=A0 =A0=A0=A0 =A0const str=
uct definition *scope)<br>+=A0=A0 =A0=A0=A0 =A0const struct bt_definition *=
scope)<br>=A0{<br>-=A0=A0 =A0struct definition **list;<br>
+=A0=A0 =A0struct bt_definition **list;<br>=A0=A0=A0=A0 unsigned int count;=
<br>=A0=A0=A0=A0 int ret;<br>=A0<br>=A0=A0=A0=A0 ret =3D bt_ctf_get_field_l=
ist(ctf_event, scope,<br>-=A0=A0 =A0=A0=A0 =A0(const struct definition * co=
nst **)&amp;list, &amp;count);<br>+=A0=A0 =A0=A0=A0 =A0(const struct bt_def=
inition * const **)&amp;list, &amp;count);<br>
=A0<br>=A0=A0=A0=A0 if (ret &lt; 0)=A0=A0 =A0/* For python to know an error=
 occured */<br>=A0=A0=A0=A0 =A0=A0=A0 list =3D NULL;<br>@@ -63,8 +63,8 @@ s=
truct definition **_bt_python_field_listcaller(<br>=A0=A0=A0=A0 return list=
;<br>=A0}<br>=A0<br>-struct definition *_bt_python_field_one_from_list(<br>
-=A0=A0 =A0=A0=A0 =A0struct definition **list, int index)<br>+struct bt_def=
inition *_bt_python_field_one_from_list(<br>+=A0=A0 =A0=A0=A0 =A0struct bt_=
definition **list, int index)<br>=A0{<br>=A0=A0=A0=A0 return list[index];<b=
r>=A0}<br>diff --git a/bindings/python/python-complements.h b/bindings/pyth=
on/python-complements.h<br>
index 9597d70..4335d8a 100644<br>--- a/bindings/python/python-complements.h=
<br>+++ b/bindings/python/python-complements.h<br>@@ -32,11 +32,11 @@ FILE =
*_bt_file_open(char *file_path, char *mode);<br>=A0void _bt_file_close(FILE=
 *fp);<br>
=A0<br>=A0/* ctf-field-list */<br>-struct definition **_bt_python_field_lis=
tcaller(<br>+struct bt_definition **_bt_python_field_listcaller(<br>=A0=A0=
=A0=A0 =A0=A0=A0 const struct bt_ctf_event *ctf_event,<br>-=A0=A0 =A0=A0=A0=
 =A0const struct definition *scope);<br>
-struct definition *_bt_python_field_one_from_list(<br>-=A0=A0 =A0=A0=A0 =
=A0struct definition **list, int index);<br>+=A0=A0 =A0=A0=A0 =A0const stru=
ct bt_definition *scope);<br>+struct bt_definition *_bt_python_field_one_fr=
om_list(<br>+=A0=A0 =A0=A0=A0 =A0struct bt_definition **list, int index);<b=
r>
=A0<br>=A0/* event_decl_list */<br>=A0struct bt_ctf_event_decl **_bt_python=
_event_decl_listcaller(<br>-- <br>1.7.1<br><br></div>

--001a11c3059ed3f16d04e022445c--


--===============0397859753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0397859753==--
