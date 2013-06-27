From: Xiaona Han <xiaonahappy13@gmail.com>
Subject: Re: [PATCH babeltrace] Make python bindings compile
	with trunk
Date: Thu, 27 Jun 2013 23:15:35 +0800
Message-ID: <CAMMh03NfO+sXLAb_1RcFqmPBFsowPoPGvWPovh2jUaLxdHUqXA__32382.1985781708$1372346176$gmane$org@mail.gmail.com>
References: <CAMMh03NJNPvYEcXLcaUBhiJTgM2hEQm1Q8-pL0nRSixNPc0ctA@mail.gmail.com>
	<20130627131022.GA20611@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c21b04e6c3ed04e0243bcd
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <xiaonahappy13@gmail.com>) id 1UsDvB-0002Ih-1P
	for lttng-dev@lists.lttng.org; Thu, 27 Jun 2013 11:15:41 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so984954oag.20
	for <lttng-dev@lists.lttng.org>; Thu, 27 Jun 2013 08:15:35 -0700 (PDT)
In-Reply-To: <20130627131022.GA20611@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--001a11c21b04e6c3ed04e0243bcd
Content-Type: multipart/alternative; boundary=001a11c21b04e6c3ea04e0243bcb

--001a11c21b04e6c3ea04e0243bcb
Content-Type: text/plain; charset=ISO-8859-1

Hello,
  Please see the patch file.  It looks good. But after I send it by git
send-email and msmtp, it looks a little strange.

Best Regards,
Xiaona Han


2013/6/27 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> * Xiaona Han (xiaonahappy13@gmail.com) wrote:
> > Signed-off-by: Xiaona Han <xiaonahappy13@gmail.com>
> > ---
> >  bindings/python/babeltrace.i.in      |   73
> > +++++++++++++++++-----------------
> >  bindings/python/python-complements.c |   12 +++---
> >  bindings/python/python-complements.h |    8 ++--
> >  3 files changed, 46 insertions(+), 47 deletions(-)
> >
> > diff --git a/bindings/python/babeltrace.i.in b/bindings/python/
> > babeltrace.i.in
> > index a5426c8..bb0a9b3 100644
> > --- a/bindings/python/babeltrace.i.in
> > +++ b/bindings/python/babeltrace.i.in
> > @@ -45,7 +45,6 @@ trace to it."
> >  #include <babeltrace/iterator-internal.h>
> >  #include <babeltrace/format.h>
> >  #include <babeltrace/list.h>
> > -#include <babeltrace/uuid.h>
> >  #include <babeltrace/types.h>
> >  #include <babeltrace/ctf/iterator.h>
> >  #include "python-complements.h"
> > @@ -74,8 +73,8 @@ typedef int bt_intern_str;
> >
> >  struct bt_context *bt_context_create(void);
> >  int bt_context_add_trace(struct bt_context *ctx, const char *path, const
> > char *format,
> > -        void (*packet_seek)(struct stream_pos *pos, size_t index, int
> > whence),
>
> I think your patch has line wrapping issues. Please check your email
> client.
>
> Thanks,
>
> Mathieu
>
> > -        struct mmap_stream_list *stream_list, FILE *metadata);
> > +        void (*packet_seek)(struct bt_stream_pos *pos, size_t index, int
> > whence),
> > +        struct bt_mmap_stream_list *stream_list, FILE *metadata);
> >  void bt_context_remove_trace(struct bt_context *ctx, int trace_id);
> >  void bt_context_get(struct bt_context *ctx);
> >  void bt_context_put(struct bt_context *ctx);
> > @@ -192,7 +191,7 @@ class Context:
> >
> >  extern struct format *bt_lookup_format(bt_intern_str qname);
> >  extern void bt_fprintf_format_list(FILE *fp);
> > -extern int bt_register_format(struct format *format);
> > +extern int bt_register_format(struct bt_format *format);
> >
> >  %pythoncode %{
> >
> > @@ -550,58 +549,58 @@ struct bt_ctf_event *bt_ctf_iter_read_event(struct
> > bt_ctf_iter *iter);
> >          const struct bt_ctf_event *ctf_event);
> >
> >  %rename("_bt_ctf_get_field") bt_ctf_get_field(const struct bt_ctf_event
> > *ctf_event,
> > -        const struct definition *scope,    const char *field);
> > +        const struct bt_definition *scope,    const char *field);
> >  %rename("_bt_ctf_get_index") bt_ctf_get_index(const struct bt_ctf_event
> > *ctf_event,
> > -        const struct definition *field,    unsigned int index);
> > -%rename("_bt_ctf_field_name") bt_ctf_field_name(const struct definition
> > *field);
> > -%rename("_bt_ctf_field_type") bt_ctf_field_type(const struct declaration
> > *field);
> > +        const struct bt_definition *field,    unsigned int index);
> > +%rename("_bt_ctf_field_name") bt_ctf_field_name(const struct
> bt_definition
> > *field);
> > +%rename("_bt_ctf_field_type") bt_ctf_field_type(const struct
> > bt_declaration *field);
> >  %rename("_bt_ctf_get_int_signedness") bt_ctf_get_int_signedness(
> > -        const struct declaration *field);
> > -%rename("_bt_ctf_get_int_base") bt_ctf_get_int_base(const struct
> > declaration *field);
> > +        const struct bt_declaration *field);
> > +%rename("_bt_ctf_get_int_base") bt_ctf_get_int_base(const struct
> > bt_declaration *field);
> >  %rename("_bt_ctf_get_int_byte_order") bt_ctf_get_int_byte_order(
> > -        const struct declaration *field);
> > -%rename("_bt_ctf_get_int_len") bt_ctf_get_int_len(const struct
> declaration
> > *field);
> > -%rename("_bt_ctf_get_encoding") bt_ctf_get_encoding(const struct
> > declaration *field);
> > -%rename("_bt_ctf_get_array_len") bt_ctf_get_array_len(const struct
> > declaration *field);
> > -%rename("_bt_ctf_get_uint64") bt_ctf_get_uint64(const struct definition
> > *field);
> > -%rename("_bt_ctf_get_int64") bt_ctf_get_int64(const struct definition
> > *field);
> > -%rename("_bt_ctf_get_char_array") bt_ctf_get_char_array(const struct
> > definition *field);
> > -%rename("_bt_ctf_get_string") bt_ctf_get_string(const struct definition
> > *field);
> > +        const struct bt_declaration *field);
> > +%rename("_bt_ctf_get_int_len") bt_ctf_get_int_len(const struct
> > bt_declaration *field);
> > +%rename("_bt_ctf_get_encoding") bt_ctf_get_encoding(const struct
> > bt_declaration *field);
> > +%rename("_bt_ctf_get_array_len") bt_ctf_get_array_len(const struct
> > bt_declaration *field);
> > +%rename("_bt_ctf_get_uint64") bt_ctf_get_uint64(const struct
> bt_definition
> > *field);
> > +%rename("_bt_ctf_get_int64") bt_ctf_get_int64(const struct bt_definition
> > *field);
> > +%rename("_bt_ctf_get_char_array") bt_ctf_get_char_array(const struct
> > bt_definition *field);
> > +%rename("_bt_ctf_get_string") bt_ctf_get_string(const struct
> bt_definition
> > *field);
> >  %rename("_bt_ctf_field_get_error") bt_ctf_field_get_error(void);
> >  %rename("_bt_ctf_get_decl_event_name") bt_ctf_get_decl_event_name(const
> > struct
> >          bt_ctf_event_decl *event);
> >  %rename("_bt_ctf_get_decl_field_name") bt_ctf_get_decl_field_name(
> >          const struct bt_ctf_field_decl *field);
> >  %rename("_bt_ctf_get_decl_from_def") bt_ctf_get_decl_from_def(
> > -        const struct definition *field);
> > +        const struct bt_definition *field);
> >
> > -const struct definition *bt_ctf_get_top_level_scope(const struct
> > bt_ctf_event *ctf_event,
> > +const struct bt_definition *bt_ctf_get_top_level_scope(const struct
> > bt_ctf_event *ctf_event,
> >          enum bt_ctf_scope scope);
> >  const char *bt_ctf_event_name(const struct bt_ctf_event *ctf_event);
> >  uint64_t bt_ctf_get_timestamp(const struct bt_ctf_event *ctf_event);
> >  uint64_t bt_ctf_get_cycles(const struct bt_ctf_event *ctf_event);
> > -const struct definition *bt_ctf_get_field(const struct bt_ctf_event
> > *ctf_event,
> > -        const struct definition *scope,
> > +const struct bt_definition *bt_ctf_get_field(const struct bt_ctf_event
> > *ctf_event,
> > +        const struct bt_definition *scope,
> >          const char *field);
> > -const struct definition *bt_ctf_get_index(const struct bt_ctf_event
> > *ctf_event,
> > -        const struct definition *field,
> > +const struct bt_definition *bt_ctf_get_index(const struct bt_ctf_event
> > *ctf_event,
> > +        const struct bt_definition *field,
> >          unsigned int index);
> > -const char *bt_ctf_field_name(const struct definition *field);
> > -enum ctf_type_id bt_ctf_field_type(const struct declaration *field);
> > -int bt_ctf_get_int_signedness(const struct declaration *field);
> > -int bt_ctf_get_int_base(const struct declaration *field);
> > -int bt_ctf_get_int_byte_order(const struct declaration *field);
> > -ssize_t bt_ctf_get_int_len(const struct declaration *field);
> > -enum ctf_string_encoding bt_ctf_get_encoding(const struct declaration
> > *field);
> > -int bt_ctf_get_array_len(const struct declaration *field);
> > -uint64_t bt_ctf_get_uint64(const struct definition *field);
> > -int64_t bt_ctf_get_int64(const struct definition *field);
> > -char *bt_ctf_get_char_array(const struct definition *field);
> > -char *bt_ctf_get_string(const struct definition *field);
> > +const char *bt_ctf_field_name(const struct bt_definition *field);
> > +enum ctf_type_id bt_ctf_field_type(const struct bt_declaration *field);
> > +int bt_ctf_get_int_signedness(const struct bt_declaration *field);
> > +int bt_ctf_get_int_base(const struct bt_declaration *field);
> > +int bt_ctf_get_int_byte_order(const struct bt_declaration *field);
> > +ssize_t bt_ctf_get_int_len(const struct bt_declaration *field);
> > +enum ctf_string_encoding bt_ctf_get_encoding(const struct bt_declaration
> > *field);
> > +int bt_ctf_get_array_len(const struct bt_declaration *field);
> > +uint64_t bt_ctf_get_uint64(const struct bt_definition *field);
> > +int64_t bt_ctf_get_int64(const struct bt_definition *field);
> > +char *bt_ctf_get_char_array(const struct bt_definition *field);
> > +char *bt_ctf_get_string(const struct bt_definition *field);
> >  int bt_ctf_field_get_error(void);
> >  const char *bt_ctf_get_decl_event_name(const struct bt_ctf_event_decl
> > *event);
> >  const char *bt_ctf_get_decl_field_name(const struct bt_ctf_field_decl
> > *field);
> > -const struct declaration *bt_ctf_get_decl_from_def(const struct
> definition
> > *field);
> > +const struct bt_declaration *bt_ctf_get_decl_from_def(const struct
> > bt_definition *field);
> >
> >  %pythoncode%{
> >
> > diff --git a/bindings/python/python-complements.c
> > b/bindings/python/python-complements.c
> > index a4ee37e..aa65555 100644
> > --- a/bindings/python/python-complements.c
> > +++ b/bindings/python/python-complements.c
> > @@ -44,16 +44,16 @@ void _bt_file_close(FILE *fp)
> >  */
> >
> >  /* ctf-field-list */
> > -struct definition **_bt_python_field_listcaller(
> > +struct bt_definition **_bt_python_field_listcaller(
> >          const struct bt_ctf_event *ctf_event,
> > -        const struct definition *scope)
> > +        const struct bt_definition *scope)
> >  {
> > -    struct definition **list;
> > +    struct bt_definition **list;
> >      unsigned int count;
> >      int ret;
> >
> >      ret = bt_ctf_get_field_list(ctf_event, scope,
> > -        (const struct definition * const **)&list, &count);
> > +        (const struct bt_definition * const **)&list, &count);
> >
> >      if (ret < 0)    /* For python to know an error occured */
> >          list = NULL;
> > @@ -63,8 +63,8 @@ struct definition **_bt_python_field_listcaller(
> >      return list;
> >  }
> >
> > -struct definition *_bt_python_field_one_from_list(
> > -        struct definition **list, int index)
> > +struct bt_definition *_bt_python_field_one_from_list(
> > +        struct bt_definition **list, int index)
> >  {
> >      return list[index];
> >  }
> > diff --git a/bindings/python/python-complements.h
> > b/bindings/python/python-complements.h
> > index 9597d70..4335d8a 100644
> > --- a/bindings/python/python-complements.h
> > +++ b/bindings/python/python-complements.h
> > @@ -32,11 +32,11 @@ FILE *_bt_file_open(char *file_path, char *mode);
> >  void _bt_file_close(FILE *fp);
> >
> >  /* ctf-field-list */
> > -struct definition **_bt_python_field_listcaller(
> > +struct bt_definition **_bt_python_field_listcaller(
> >          const struct bt_ctf_event *ctf_event,
> > -        const struct definition *scope);
> > -struct definition *_bt_python_field_one_from_list(
> > -        struct definition **list, int index);
> > +        const struct bt_definition *scope);
> > +struct bt_definition *_bt_python_field_one_from_list(
> > +        struct bt_definition **list, int index);
> >
> >  /* event_decl_list */
> >  struct bt_ctf_event_decl **_bt_python_event_decl_listcaller(
> > --
> > 1.7.1
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--001a11c21b04e6c3ea04e0243bcb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,<br></div>=A0 Please see the patch file.=A0 It =
looks good. But after I send it by git send-email and msmtp, it looks a lit=
tle strange.<br></div><div class=3D"gmail_extra"><br clear=3D"all"><div><di=
v dir=3D"ltr">
Best Regards,<div>Xiaona Han</div></div></div>
<br><br><div class=3D"gmail_quote">2013/6/27 Mathieu Desnoyers <span dir=3D=
"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blan=
k">mathieu.desnoyers@efficios.com</a>&gt;</span><br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">* Xiaona Han (<a href=3D"mailto:xia=
onahappy13@gmail.com">xiaonahappy13@gmail.com</a>) wrote:<br>
&gt; Signed-off-by: Xiaona Han &lt;<a href=3D"mailto:xiaonahappy13@gmail.co=
m">xiaonahappy13@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0bindings/python/<a href=3D"http://babeltrace.i.in" target=3D"_blank=
">babeltrace.i.in</a> =A0 =A0 =A0| =A0 73<br>
&gt; +++++++++++++++++-----------------<br>
&gt; =A0bindings/python/python-complements.c | =A0 12 +++---<br>
&gt; =A0bindings/python/python-complements.h | =A0 =A08 ++--<br>
&gt; =A03 files changed, 46 insertions(+), 47 deletions(-)<br>
&gt;<br>
&gt; diff --git a/bindings/python/<a href=3D"http://babeltrace.i.in" target=
=3D"_blank">babeltrace.i.in</a> b/bindings/python/<br>
&gt; <a href=3D"http://babeltrace.i.in" target=3D"_blank">babeltrace.i.in</=
a><br>
&gt; index a5426c8..bb0a9b3 100644<br>
&gt; --- a/bindings/python/<a href=3D"http://babeltrace.i.in" target=3D"_bl=
ank">babeltrace.i.in</a><br>
&gt; +++ b/bindings/python/<a href=3D"http://babeltrace.i.in" target=3D"_bl=
ank">babeltrace.i.in</a><br>
&gt; @@ -45,7 +45,6 @@ trace to it.&quot;<br>
&gt; =A0#include &lt;babeltrace/iterator-internal.h&gt;<br>
&gt; =A0#include &lt;babeltrace/format.h&gt;<br>
&gt; =A0#include &lt;babeltrace/list.h&gt;<br>
&gt; -#include &lt;babeltrace/uuid.h&gt;<br>
&gt; =A0#include &lt;babeltrace/types.h&gt;<br>
&gt; =A0#include &lt;babeltrace/ctf/iterator.h&gt;<br>
&gt; =A0#include &quot;python-complements.h&quot;<br>
&gt; @@ -74,8 +73,8 @@ typedef int bt_intern_str;<br>
&gt;<br>
&gt; =A0struct bt_context *bt_context_create(void);<br>
&gt; =A0int bt_context_add_trace(struct bt_context *ctx, const char *path, =
const<br>
&gt; char *format,<br>
&gt; - =A0 =A0 =A0 =A0void (*packet_seek)(struct stream_pos *pos, size_t in=
dex, int<br>
&gt; whence),<br>
<br>
</div></div>I think your patch has line wrapping issues. Please check your =
email<br>
client.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<div><div class=3D"h5"><br>
&gt; - =A0 =A0 =A0 =A0struct mmap_stream_list *stream_list, FILE *metadata)=
;<br>
&gt; + =A0 =A0 =A0 =A0void (*packet_seek)(struct bt_stream_pos *pos, size_t=
 index, int<br>
&gt; whence),<br>
&gt; + =A0 =A0 =A0 =A0struct bt_mmap_stream_list *stream_list, FILE *metada=
ta);<br>
&gt; =A0void bt_context_remove_trace(struct bt_context *ctx, int trace_id);=
<br>
&gt; =A0void bt_context_get(struct bt_context *ctx);<br>
&gt; =A0void bt_context_put(struct bt_context *ctx);<br>
&gt; @@ -192,7 +191,7 @@ class Context:<br>
&gt;<br>
&gt; =A0extern struct format *bt_lookup_format(bt_intern_str qname);<br>
&gt; =A0extern void bt_fprintf_format_list(FILE *fp);<br>
&gt; -extern int bt_register_format(struct format *format);<br>
&gt; +extern int bt_register_format(struct bt_format *format);<br>
&gt;<br>
&gt; =A0%pythoncode %{<br>
&gt;<br>
&gt; @@ -550,58 +549,58 @@ struct bt_ctf_event *bt_ctf_iter_read_event(stru=
ct<br>
&gt; bt_ctf_iter *iter);<br>
&gt; =A0 =A0 =A0 =A0 =A0const struct bt_ctf_event *ctf_event);<br>
&gt;<br>
&gt; =A0%rename(&quot;_bt_ctf_get_field&quot;) bt_ctf_get_field(const struc=
t bt_ctf_event<br>
&gt; *ctf_event,<br>
&gt; - =A0 =A0 =A0 =A0const struct definition *scope, =A0 =A0const char *fi=
eld);<br>
&gt; + =A0 =A0 =A0 =A0const struct bt_definition *scope, =A0 =A0const char =
*field);<br>
&gt; =A0%rename(&quot;_bt_ctf_get_index&quot;) bt_ctf_get_index(const struc=
t bt_ctf_event<br>
&gt; *ctf_event,<br>
&gt; - =A0 =A0 =A0 =A0const struct definition *field, =A0 =A0unsigned int i=
ndex);<br>
&gt; -%rename(&quot;_bt_ctf_field_name&quot;) bt_ctf_field_name(const struc=
t definition<br>
&gt; *field);<br>
&gt; -%rename(&quot;_bt_ctf_field_type&quot;) bt_ctf_field_type(const struc=
t declaration<br>
&gt; *field);<br>
&gt; + =A0 =A0 =A0 =A0const struct bt_definition *field, =A0 =A0unsigned in=
t index);<br>
&gt; +%rename(&quot;_bt_ctf_field_name&quot;) bt_ctf_field_name(const struc=
t bt_definition<br>
&gt; *field);<br>
&gt; +%rename(&quot;_bt_ctf_field_type&quot;) bt_ctf_field_type(const struc=
t<br>
&gt; bt_declaration *field);<br>
&gt; =A0%rename(&quot;_bt_ctf_get_int_signedness&quot;) bt_ctf_get_int_sign=
edness(<br>
&gt; - =A0 =A0 =A0 =A0const struct declaration *field);<br>
&gt; -%rename(&quot;_bt_ctf_get_int_base&quot;) bt_ctf_get_int_base(const s=
truct<br>
&gt; declaration *field);<br>
&gt; + =A0 =A0 =A0 =A0const struct bt_declaration *field);<br>
&gt; +%rename(&quot;_bt_ctf_get_int_base&quot;) bt_ctf_get_int_base(const s=
truct<br>
&gt; bt_declaration *field);<br>
&gt; =A0%rename(&quot;_bt_ctf_get_int_byte_order&quot;) bt_ctf_get_int_byte=
_order(<br>
&gt; - =A0 =A0 =A0 =A0const struct declaration *field);<br>
&gt; -%rename(&quot;_bt_ctf_get_int_len&quot;) bt_ctf_get_int_len(const str=
uct declaration<br>
&gt; *field);<br>
&gt; -%rename(&quot;_bt_ctf_get_encoding&quot;) bt_ctf_get_encoding(const s=
truct<br>
&gt; declaration *field);<br>
&gt; -%rename(&quot;_bt_ctf_get_array_len&quot;) bt_ctf_get_array_len(const=
 struct<br>
&gt; declaration *field);<br>
&gt; -%rename(&quot;_bt_ctf_get_uint64&quot;) bt_ctf_get_uint64(const struc=
t definition<br>
&gt; *field);<br>
&gt; -%rename(&quot;_bt_ctf_get_int64&quot;) bt_ctf_get_int64(const struct =
definition<br>
&gt; *field);<br>
&gt; -%rename(&quot;_bt_ctf_get_char_array&quot;) bt_ctf_get_char_array(con=
st struct<br>
&gt; definition *field);<br>
&gt; -%rename(&quot;_bt_ctf_get_string&quot;) bt_ctf_get_string(const struc=
t definition<br>
&gt; *field);<br>
&gt; + =A0 =A0 =A0 =A0const struct bt_declaration *field);<br>
&gt; +%rename(&quot;_bt_ctf_get_int_len&quot;) bt_ctf_get_int_len(const str=
uct<br>
&gt; bt_declaration *field);<br>
&gt; +%rename(&quot;_bt_ctf_get_encoding&quot;) bt_ctf_get_encoding(const s=
truct<br>
&gt; bt_declaration *field);<br>
&gt; +%rename(&quot;_bt_ctf_get_array_len&quot;) bt_ctf_get_array_len(const=
 struct<br>
&gt; bt_declaration *field);<br>
&gt; +%rename(&quot;_bt_ctf_get_uint64&quot;) bt_ctf_get_uint64(const struc=
t bt_definition<br>
&gt; *field);<br>
&gt; +%rename(&quot;_bt_ctf_get_int64&quot;) bt_ctf_get_int64(const struct =
bt_definition<br>
&gt; *field);<br>
&gt; +%rename(&quot;_bt_ctf_get_char_array&quot;) bt_ctf_get_char_array(con=
st struct<br>
&gt; bt_definition *field);<br>
&gt; +%rename(&quot;_bt_ctf_get_string&quot;) bt_ctf_get_string(const struc=
t bt_definition<br>
&gt; *field);<br>
&gt; =A0%rename(&quot;_bt_ctf_field_get_error&quot;) bt_ctf_field_get_error=
(void);<br>
&gt; =A0%rename(&quot;_bt_ctf_get_decl_event_name&quot;) bt_ctf_get_decl_ev=
ent_name(const<br>
&gt; struct<br>
&gt; =A0 =A0 =A0 =A0 =A0bt_ctf_event_decl *event);<br>
&gt; =A0%rename(&quot;_bt_ctf_get_decl_field_name&quot;) bt_ctf_get_decl_fi=
eld_name(<br>
&gt; =A0 =A0 =A0 =A0 =A0const struct bt_ctf_field_decl *field);<br>
&gt; =A0%rename(&quot;_bt_ctf_get_decl_from_def&quot;) bt_ctf_get_decl_from=
_def(<br>
&gt; - =A0 =A0 =A0 =A0const struct definition *field);<br>
&gt; + =A0 =A0 =A0 =A0const struct bt_definition *field);<br>
&gt;<br>
&gt; -const struct definition *bt_ctf_get_top_level_scope(const struct<br>
&gt; bt_ctf_event *ctf_event,<br>
&gt; +const struct bt_definition *bt_ctf_get_top_level_scope(const struct<b=
r>
&gt; bt_ctf_event *ctf_event,<br>
&gt; =A0 =A0 =A0 =A0 =A0enum bt_ctf_scope scope);<br>
&gt; =A0const char *bt_ctf_event_name(const struct bt_ctf_event *ctf_event)=
;<br>
&gt; =A0uint64_t bt_ctf_get_timestamp(const struct bt_ctf_event *ctf_event)=
;<br>
&gt; =A0uint64_t bt_ctf_get_cycles(const struct bt_ctf_event *ctf_event);<b=
r>
&gt; -const struct definition *bt_ctf_get_field(const struct bt_ctf_event<b=
r>
&gt; *ctf_event,<br>
&gt; - =A0 =A0 =A0 =A0const struct definition *scope,<br>
&gt; +const struct bt_definition *bt_ctf_get_field(const struct bt_ctf_even=
t<br>
&gt; *ctf_event,<br>
&gt; + =A0 =A0 =A0 =A0const struct bt_definition *scope,<br>
&gt; =A0 =A0 =A0 =A0 =A0const char *field);<br>
&gt; -const struct definition *bt_ctf_get_index(const struct bt_ctf_event<b=
r>
&gt; *ctf_event,<br>
&gt; - =A0 =A0 =A0 =A0const struct definition *field,<br>
&gt; +const struct bt_definition *bt_ctf_get_index(const struct bt_ctf_even=
t<br>
&gt; *ctf_event,<br>
&gt; + =A0 =A0 =A0 =A0const struct bt_definition *field,<br>
&gt; =A0 =A0 =A0 =A0 =A0unsigned int index);<br>
&gt; -const char *bt_ctf_field_name(const struct definition *field);<br>
&gt; -enum ctf_type_id bt_ctf_field_type(const struct declaration *field);<=
br>
&gt; -int bt_ctf_get_int_signedness(const struct declaration *field);<br>
&gt; -int bt_ctf_get_int_base(const struct declaration *field);<br>
&gt; -int bt_ctf_get_int_byte_order(const struct declaration *field);<br>
&gt; -ssize_t bt_ctf_get_int_len(const struct declaration *field);<br>
&gt; -enum ctf_string_encoding bt_ctf_get_encoding(const struct declaration=
<br>
&gt; *field);<br>
&gt; -int bt_ctf_get_array_len(const struct declaration *field);<br>
&gt; -uint64_t bt_ctf_get_uint64(const struct definition *field);<br>
&gt; -int64_t bt_ctf_get_int64(const struct definition *field);<br>
&gt; -char *bt_ctf_get_char_array(const struct definition *field);<br>
&gt; -char *bt_ctf_get_string(const struct definition *field);<br>
&gt; +const char *bt_ctf_field_name(const struct bt_definition *field);<br>
&gt; +enum ctf_type_id bt_ctf_field_type(const struct bt_declaration *field=
);<br>
&gt; +int bt_ctf_get_int_signedness(const struct bt_declaration *field);<br=
>
&gt; +int bt_ctf_get_int_base(const struct bt_declaration *field);<br>
&gt; +int bt_ctf_get_int_byte_order(const struct bt_declaration *field);<br=
>
&gt; +ssize_t bt_ctf_get_int_len(const struct bt_declaration *field);<br>
&gt; +enum ctf_string_encoding bt_ctf_get_encoding(const struct bt_declarat=
ion<br>
&gt; *field);<br>
&gt; +int bt_ctf_get_array_len(const struct bt_declaration *field);<br>
&gt; +uint64_t bt_ctf_get_uint64(const struct bt_definition *field);<br>
&gt; +int64_t bt_ctf_get_int64(const struct bt_definition *field);<br>
&gt; +char *bt_ctf_get_char_array(const struct bt_definition *field);<br>
&gt; +char *bt_ctf_get_string(const struct bt_definition *field);<br>
&gt; =A0int bt_ctf_field_get_error(void);<br>
&gt; =A0const char *bt_ctf_get_decl_event_name(const struct bt_ctf_event_de=
cl<br>
&gt; *event);<br>
&gt; =A0const char *bt_ctf_get_decl_field_name(const struct bt_ctf_field_de=
cl<br>
&gt; *field);<br>
&gt; -const struct declaration *bt_ctf_get_decl_from_def(const struct defin=
ition<br>
&gt; *field);<br>
&gt; +const struct bt_declaration *bt_ctf_get_decl_from_def(const struct<br=
>
&gt; bt_definition *field);<br>
&gt;<br>
&gt; =A0%pythoncode%{<br>
&gt;<br>
&gt; diff --git a/bindings/python/python-complements.c<br>
&gt; b/bindings/python/python-complements.c<br>
&gt; index a4ee37e..aa65555 100644<br>
&gt; --- a/bindings/python/python-complements.c<br>
&gt; +++ b/bindings/python/python-complements.c<br>
&gt; @@ -44,16 +44,16 @@ void _bt_file_close(FILE *fp)<br>
&gt; =A0*/<br>
&gt;<br>
&gt; =A0/* ctf-field-list */<br>
&gt; -struct definition **_bt_python_field_listcaller(<br>
&gt; +struct bt_definition **_bt_python_field_listcaller(<br>
&gt; =A0 =A0 =A0 =A0 =A0const struct bt_ctf_event *ctf_event,<br>
&gt; - =A0 =A0 =A0 =A0const struct definition *scope)<br>
&gt; + =A0 =A0 =A0 =A0const struct bt_definition *scope)<br>
&gt; =A0{<br>
&gt; - =A0 =A0struct definition **list;<br>
&gt; + =A0 =A0struct bt_definition **list;<br>
&gt; =A0 =A0 =A0unsigned int count;<br>
&gt; =A0 =A0 =A0int ret;<br>
&gt;<br>
&gt; =A0 =A0 =A0ret =3D bt_ctf_get_field_list(ctf_event, scope,<br>
&gt; - =A0 =A0 =A0 =A0(const struct definition * const **)&amp;list, &amp;c=
ount);<br>
&gt; + =A0 =A0 =A0 =A0(const struct bt_definition * const **)&amp;list, &am=
p;count);<br>
&gt;<br>
&gt; =A0 =A0 =A0if (ret &lt; 0) =A0 =A0/* For python to know an error occur=
ed */<br>
&gt; =A0 =A0 =A0 =A0 =A0list =3D NULL;<br>
&gt; @@ -63,8 +63,8 @@ struct definition **_bt_python_field_listcaller(<br>
&gt; =A0 =A0 =A0return list;<br>
&gt; =A0}<br>
&gt;<br>
&gt; -struct definition *_bt_python_field_one_from_list(<br>
&gt; - =A0 =A0 =A0 =A0struct definition **list, int index)<br>
&gt; +struct bt_definition *_bt_python_field_one_from_list(<br>
&gt; + =A0 =A0 =A0 =A0struct bt_definition **list, int index)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0return list[index];<br>
&gt; =A0}<br>
&gt; diff --git a/bindings/python/python-complements.h<br>
&gt; b/bindings/python/python-complements.h<br>
&gt; index 9597d70..4335d8a 100644<br>
&gt; --- a/bindings/python/python-complements.h<br>
&gt; +++ b/bindings/python/python-complements.h<br>
&gt; @@ -32,11 +32,11 @@ FILE *_bt_file_open(char *file_path, char *mode);<=
br>
&gt; =A0void _bt_file_close(FILE *fp);<br>
&gt;<br>
&gt; =A0/* ctf-field-list */<br>
&gt; -struct definition **_bt_python_field_listcaller(<br>
&gt; +struct bt_definition **_bt_python_field_listcaller(<br>
&gt; =A0 =A0 =A0 =A0 =A0const struct bt_ctf_event *ctf_event,<br>
&gt; - =A0 =A0 =A0 =A0const struct definition *scope);<br>
&gt; -struct definition *_bt_python_field_one_from_list(<br>
&gt; - =A0 =A0 =A0 =A0struct definition **list, int index);<br>
&gt; + =A0 =A0 =A0 =A0const struct bt_definition *scope);<br>
&gt; +struct bt_definition *_bt_python_field_one_from_list(<br>
&gt; + =A0 =A0 =A0 =A0struct bt_definition **list, int index);<br>
&gt;<br>
&gt; =A0/* event_decl_list */<br>
&gt; =A0struct bt_ctf_event_decl **_bt_python_event_decl_listcaller(<br>
&gt; --<br>
&gt; 1.7.1<br>
<br>
</div></div>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</font></span></blockquote></div><br></div>

--001a11c21b04e6c3ea04e0243bcb--

--001a11c21b04e6c3ed04e0243bcd
Content-Type: application/octet-stream;
	name="0001-Make-python-bindings-compile-with-trunk.patch"
Content-Disposition: attachment;
	filename="0001-Make-python-bindings-compile-with-trunk.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_higkj6jv0

RnJvbSBiYzhmNjk2YWQwZTVhMzJlNjM1OWIyNDQ1ZDU4ZWUwMzc4Zjk2YjMxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBYaWFvbmEgSGFuIDx4aWFvbmFoYXBweTEzQDE2My5jb20+CkRh
dGU6IFRodSwgMjcgSnVuIDIwMTMgMTU6NDQ6MTMgKzA4MDAKU3ViamVjdDogW1BBVENIIGJhYmVs
dHJhY2VdIE1ha2UgcHl0aG9uIGJpbmRpbmdzIGNvbXBpbGUgd2l0aCB0cnVuawoKClNpZ25lZC1v
ZmYtYnk6IFhpYW9uYSA8eGlhb25haGFwcHkxM0AxNjMuY29tPgotLS0KIGJpbmRpbmdzL3B5dGhv
bi9iYWJlbHRyYWNlLmkuaW4gICAgICB8ICAgNzkgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0tCiBiaW5kaW5ncy9weXRob24vcHl0aG9uLWNvbXBsZW1lbnRzLmMgfCAgIDEyICsrKy0t
LQogYmluZGluZ3MvcHl0aG9uL3B5dGhvbi1jb21wbGVtZW50cy5oIHwgICAgOCArKy0tCiAzIGZp
bGVzIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKyksIDUxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2JpbmRpbmdzL3B5dGhvbi9iYWJlbHRyYWNlLmkuaW4gYi9iaW5kaW5ncy9weXRob24vYmFi
ZWx0cmFjZS5pLmluCmluZGV4IGE1NDI2YzguLjA2YjhkNDAgMTAwNjQ0Ci0tLSBhL2JpbmRpbmdz
L3B5dGhvbi9iYWJlbHRyYWNlLmkuaW4KKysrIGIvYmluZGluZ3MvcHl0aG9uL2JhYmVsdHJhY2Uu
aS5pbgpAQCAtNDUsNyArNDUsNiBAQCB0cmFjZSB0byBpdC4iCiAjaW5jbHVkZSA8YmFiZWx0cmFj
ZS9pdGVyYXRvci1pbnRlcm5hbC5oPgogI2luY2x1ZGUgPGJhYmVsdHJhY2UvZm9ybWF0Lmg+CiAj
aW5jbHVkZSA8YmFiZWx0cmFjZS9saXN0Lmg+Ci0jaW5jbHVkZSA8YmFiZWx0cmFjZS91dWlkLmg+
CiAjaW5jbHVkZSA8YmFiZWx0cmFjZS90eXBlcy5oPgogI2luY2x1ZGUgPGJhYmVsdHJhY2UvY3Rm
L2l0ZXJhdG9yLmg+CiAjaW5jbHVkZSAicHl0aG9uLWNvbXBsZW1lbnRzLmgiCkBAIC02Myw4ICs2
Miw4IEBAIHR5cGVkZWYgaW50IGJ0X2ludGVybl9zdHI7CiAlcmVuYW1lKCJfYnRfY29udGV4dF9j
cmVhdGUiKSBidF9jb250ZXh0X2NyZWF0ZSh2b2lkKTsKICVyZW5hbWUoIl9idF9jb250ZXh0X2Fk
ZF90cmFjZSIpIGJ0X2NvbnRleHRfYWRkX3RyYWNlKAogCQlzdHJ1Y3QgYnRfY29udGV4dCAqY3R4
LCBjb25zdCBjaGFyICpwYXRoLCBjb25zdCBjaGFyICpmb3JtYXQsCi0JCXZvaWQgKCpwYWNrZXRf
c2Vlaykoc3RydWN0IHN0cmVhbV9wb3MgKnBvcywgc2l6ZV90IGluZGV4LCBpbnQgd2hlbmNlKSwK
LQkJc3RydWN0IG1tYXBfc3RyZWFtX2xpc3QgKnN0cmVhbV9saXN0LCBGSUxFICptZXRhZGF0YSk7
CisJCXZvaWQgKCpwYWNrZXRfc2Vlaykoc3RydWN0IGJ0X3N0cmVhbV9wb3MgKnBvcywgc2l6ZV90
IGluZGV4LCBpbnQgd2hlbmNlKSwKKwkJc3RydWN0IGJ0X21tYXBfc3RyZWFtX2xpc3QgKnN0cmVh
bV9saXN0LCBGSUxFICptZXRhZGF0YSk7CiAlcmVuYW1lKCJfYnRfY29udGV4dF9yZW1vdmVfdHJh
Y2UiKSBidF9jb250ZXh0X3JlbW92ZV90cmFjZSgKIAkJc3RydWN0IGJ0X2NvbnRleHQgKmN0eCwg
aW50IHRyYWNlX2lkKTsKICVyZW5hbWUoIl9idF9jb250ZXh0X2dldCIpIGJ0X2NvbnRleHRfZ2V0
KHN0cnVjdCBidF9jb250ZXh0ICpjdHgpOwpAQCAtNzQsOCArNzMsOCBAQCB0eXBlZGVmIGludCBi
dF9pbnRlcm5fc3RyOwogCiBzdHJ1Y3QgYnRfY29udGV4dCAqYnRfY29udGV4dF9jcmVhdGUodm9p
ZCk7CiBpbnQgYnRfY29udGV4dF9hZGRfdHJhY2Uoc3RydWN0IGJ0X2NvbnRleHQgKmN0eCwgY29u
c3QgY2hhciAqcGF0aCwgY29uc3QgY2hhciAqZm9ybWF0LAotCQl2b2lkICgqcGFja2V0X3NlZWsp
KHN0cnVjdCBzdHJlYW1fcG9zICpwb3MsIHNpemVfdCBpbmRleCwgaW50IHdoZW5jZSksCi0JCXN0
cnVjdCBtbWFwX3N0cmVhbV9saXN0ICpzdHJlYW1fbGlzdCwgRklMRSAqbWV0YWRhdGEpOworCQl2
b2lkICgqcGFja2V0X3NlZWspKHN0cnVjdCBidF9zdHJlYW1fcG9zICpwb3MsIHNpemVfdCBpbmRl
eCwgaW50IHdoZW5jZSksCisJCXN0cnVjdCBidF9tbWFwX3N0cmVhbV9saXN0ICpzdHJlYW1fbGlz
dCwgRklMRSAqbWV0YWRhdGEpOwogdm9pZCBidF9jb250ZXh0X3JlbW92ZV90cmFjZShzdHJ1Y3Qg
YnRfY29udGV4dCAqY3R4LCBpbnQgdHJhY2VfaWQpOwogdm9pZCBidF9jb250ZXh0X2dldChzdHJ1
Y3QgYnRfY29udGV4dCAqY3R4KTsKIHZvaWQgYnRfY29udGV4dF9wdXQoc3RydWN0IGJ0X2NvbnRl
eHQgKmN0eCk7CkBAIC0xOTIsNyArMTkxLDcgQEAgY2xhc3MgQ29udGV4dDoKIAogZXh0ZXJuIHN0
cnVjdCBmb3JtYXQgKmJ0X2xvb2t1cF9mb3JtYXQoYnRfaW50ZXJuX3N0ciBxbmFtZSk7CiBleHRl
cm4gdm9pZCBidF9mcHJpbnRmX2Zvcm1hdF9saXN0KEZJTEUgKmZwKTsKLWV4dGVybiBpbnQgYnRf
cmVnaXN0ZXJfZm9ybWF0KHN0cnVjdCBmb3JtYXQgKmZvcm1hdCk7CitleHRlcm4gaW50IGJ0X3Jl
Z2lzdGVyX2Zvcm1hdChzdHJ1Y3QgYnRfZm9ybWF0ICpmb3JtYXQpOwogCiAlcHl0aG9uY29kZSAl
ewogCkBAIC00NTIsOCArNDUxLDYgQEAgdm9pZCBidF90cmFjZV9oYW5kbGVfZGVzdHJveShzdHJ1
Y3QgYnRfdHJhY2VfaGFuZGxlICpidCk7CiAJCXN0cnVjdCBidF9jb250ZXh0ICpjdHgsIGludCBo
YW5kbGVfaWQsIGVudW0gYnRfY2xvY2tfdHlwZSB0eXBlKTsKICVyZW5hbWUoIl9idF90cmFjZV9o
YW5kbGVfZ2V0X3RpbWVzdGFtcF9lbmQiKSBidF90cmFjZV9oYW5kbGVfZ2V0X3RpbWVzdGFtcF9l
bmQoCiAJCXN0cnVjdCBidF9jb250ZXh0ICpjdHgsIGludCBoYW5kbGVfaWQsIGVudW0gYnRfY2xv
Y2tfdHlwZSB0eXBlKTsKLSVyZW5hbWUoIl9idF90cmFjZV9oYW5kbGVfZ2V0X2lkIikgYnRfdHJh
Y2VfaGFuZGxlX2dldF9pZChzdHJ1Y3QgYnRfdHJhY2VfaGFuZGxlICp0aCk7Ci1pbnQgYnRfdHJh
Y2VfaGFuZGxlX2dldF9pZChzdHJ1Y3QgYnRfdHJhY2VfaGFuZGxlICp0aCk7CiBjb25zdCBjaGFy
ICpidF90cmFjZV9oYW5kbGVfZ2V0X3BhdGgoc3RydWN0IGJ0X2NvbnRleHQgKmN0eCwgaW50IGhh
bmRsZV9pZCk7CiB1aW50NjRfdCBidF90cmFjZV9oYW5kbGVfZ2V0X3RpbWVzdGFtcF9iZWdpbihz
dHJ1Y3QgYnRfY29udGV4dCAqY3R4LCBpbnQgaGFuZGxlX2lkLAogCQllbnVtIGJ0X2Nsb2NrX3R5
cGUgdHlwZSk7CkBAIC01NTAsNTggKzU0Nyw1OCBAQCBzdHJ1Y3QgYnRfY3RmX2V2ZW50ICpidF9j
dGZfaXRlcl9yZWFkX2V2ZW50KHN0cnVjdCBidF9jdGZfaXRlciAqaXRlcik7CiAJCWNvbnN0IHN0
cnVjdCBidF9jdGZfZXZlbnQgKmN0Zl9ldmVudCk7CiAKICVyZW5hbWUoIl9idF9jdGZfZ2V0X2Zp
ZWxkIikgYnRfY3RmX2dldF9maWVsZChjb25zdCBzdHJ1Y3QgYnRfY3RmX2V2ZW50ICpjdGZfZXZl
bnQsCi0JCWNvbnN0IHN0cnVjdCBkZWZpbml0aW9uICpzY29wZSwJY29uc3QgY2hhciAqZmllbGQp
OworCQljb25zdCBzdHJ1Y3QgYnRfZGVmaW5pdGlvbiAqc2NvcGUsCWNvbnN0IGNoYXIgKmZpZWxk
KTsKICVyZW5hbWUoIl9idF9jdGZfZ2V0X2luZGV4IikgYnRfY3RmX2dldF9pbmRleChjb25zdCBz
dHJ1Y3QgYnRfY3RmX2V2ZW50ICpjdGZfZXZlbnQsCi0JCWNvbnN0IHN0cnVjdCBkZWZpbml0aW9u
ICpmaWVsZCwJdW5zaWduZWQgaW50IGluZGV4KTsKLSVyZW5hbWUoIl9idF9jdGZfZmllbGRfbmFt
ZSIpIGJ0X2N0Zl9maWVsZF9uYW1lKGNvbnN0IHN0cnVjdCBkZWZpbml0aW9uICpmaWVsZCk7Ci0l
cmVuYW1lKCJfYnRfY3RmX2ZpZWxkX3R5cGUiKSBidF9jdGZfZmllbGRfdHlwZShjb25zdCBzdHJ1
Y3QgZGVjbGFyYXRpb24gKmZpZWxkKTsKKwkJY29uc3Qgc3RydWN0IGJ0X2RlZmluaXRpb24gKmZp
ZWxkLAl1bnNpZ25lZCBpbnQgaW5kZXgpOworJXJlbmFtZSgiX2J0X2N0Zl9maWVsZF9uYW1lIikg
YnRfY3RmX2ZpZWxkX25hbWUoY29uc3Qgc3RydWN0IGJ0X2RlZmluaXRpb24gKmZpZWxkKTsKKyVy
ZW5hbWUoIl9idF9jdGZfZmllbGRfdHlwZSIpIGJ0X2N0Zl9maWVsZF90eXBlKGNvbnN0IHN0cnVj
dCBidF9kZWNsYXJhdGlvbiAqZmllbGQpOwogJXJlbmFtZSgiX2J0X2N0Zl9nZXRfaW50X3NpZ25l
ZG5lc3MiKSBidF9jdGZfZ2V0X2ludF9zaWduZWRuZXNzKAotCQljb25zdCBzdHJ1Y3QgZGVjbGFy
YXRpb24gKmZpZWxkKTsKLSVyZW5hbWUoIl9idF9jdGZfZ2V0X2ludF9iYXNlIikgYnRfY3RmX2dl
dF9pbnRfYmFzZShjb25zdCBzdHJ1Y3QgZGVjbGFyYXRpb24gKmZpZWxkKTsKKwkJY29uc3Qgc3Ry
dWN0IGJ0X2RlY2xhcmF0aW9uICpmaWVsZCk7CislcmVuYW1lKCJfYnRfY3RmX2dldF9pbnRfYmFz
ZSIpIGJ0X2N0Zl9nZXRfaW50X2Jhc2UoY29uc3Qgc3RydWN0IGJ0X2RlY2xhcmF0aW9uICpmaWVs
ZCk7CiAlcmVuYW1lKCJfYnRfY3RmX2dldF9pbnRfYnl0ZV9vcmRlciIpIGJ0X2N0Zl9nZXRfaW50
X2J5dGVfb3JkZXIoCi0JCWNvbnN0IHN0cnVjdCBkZWNsYXJhdGlvbiAqZmllbGQpOwotJXJlbmFt
ZSgiX2J0X2N0Zl9nZXRfaW50X2xlbiIpIGJ0X2N0Zl9nZXRfaW50X2xlbihjb25zdCBzdHJ1Y3Qg
ZGVjbGFyYXRpb24gKmZpZWxkKTsKLSVyZW5hbWUoIl9idF9jdGZfZ2V0X2VuY29kaW5nIikgYnRf
Y3RmX2dldF9lbmNvZGluZyhjb25zdCBzdHJ1Y3QgZGVjbGFyYXRpb24gKmZpZWxkKTsKLSVyZW5h
bWUoIl9idF9jdGZfZ2V0X2FycmF5X2xlbiIpIGJ0X2N0Zl9nZXRfYXJyYXlfbGVuKGNvbnN0IHN0
cnVjdCBkZWNsYXJhdGlvbiAqZmllbGQpOwotJXJlbmFtZSgiX2J0X2N0Zl9nZXRfdWludDY0Iikg
YnRfY3RmX2dldF91aW50NjQoY29uc3Qgc3RydWN0IGRlZmluaXRpb24gKmZpZWxkKTsKLSVyZW5h
bWUoIl9idF9jdGZfZ2V0X2ludDY0IikgYnRfY3RmX2dldF9pbnQ2NChjb25zdCBzdHJ1Y3QgZGVm
aW5pdGlvbiAqZmllbGQpOwotJXJlbmFtZSgiX2J0X2N0Zl9nZXRfY2hhcl9hcnJheSIpIGJ0X2N0
Zl9nZXRfY2hhcl9hcnJheShjb25zdCBzdHJ1Y3QgZGVmaW5pdGlvbiAqZmllbGQpOwotJXJlbmFt
ZSgiX2J0X2N0Zl9nZXRfc3RyaW5nIikgYnRfY3RmX2dldF9zdHJpbmcoY29uc3Qgc3RydWN0IGRl
ZmluaXRpb24gKmZpZWxkKTsKKwkJY29uc3Qgc3RydWN0IGJ0X2RlY2xhcmF0aW9uICpmaWVsZCk7
CislcmVuYW1lKCJfYnRfY3RmX2dldF9pbnRfbGVuIikgYnRfY3RmX2dldF9pbnRfbGVuKGNvbnN0
IHN0cnVjdCBidF9kZWNsYXJhdGlvbiAqZmllbGQpOworJXJlbmFtZSgiX2J0X2N0Zl9nZXRfZW5j
b2RpbmciKSBidF9jdGZfZ2V0X2VuY29kaW5nKGNvbnN0IHN0cnVjdCBidF9kZWNsYXJhdGlvbiAq
ZmllbGQpOworJXJlbmFtZSgiX2J0X2N0Zl9nZXRfYXJyYXlfbGVuIikgYnRfY3RmX2dldF9hcnJh
eV9sZW4oY29uc3Qgc3RydWN0IGJ0X2RlY2xhcmF0aW9uICpmaWVsZCk7CislcmVuYW1lKCJfYnRf
Y3RmX2dldF91aW50NjQiKSBidF9jdGZfZ2V0X3VpbnQ2NChjb25zdCBzdHJ1Y3QgYnRfZGVmaW5p
dGlvbiAqZmllbGQpOworJXJlbmFtZSgiX2J0X2N0Zl9nZXRfaW50NjQiKSBidF9jdGZfZ2V0X2lu
dDY0KGNvbnN0IHN0cnVjdCBidF9kZWZpbml0aW9uICpmaWVsZCk7CislcmVuYW1lKCJfYnRfY3Rm
X2dldF9jaGFyX2FycmF5IikgYnRfY3RmX2dldF9jaGFyX2FycmF5KGNvbnN0IHN0cnVjdCBidF9k
ZWZpbml0aW9uICpmaWVsZCk7CislcmVuYW1lKCJfYnRfY3RmX2dldF9zdHJpbmciKSBidF9jdGZf
Z2V0X3N0cmluZyhjb25zdCBzdHJ1Y3QgYnRfZGVmaW5pdGlvbiAqZmllbGQpOwogJXJlbmFtZSgi
X2J0X2N0Zl9maWVsZF9nZXRfZXJyb3IiKSBidF9jdGZfZmllbGRfZ2V0X2Vycm9yKHZvaWQpOwog
JXJlbmFtZSgiX2J0X2N0Zl9nZXRfZGVjbF9ldmVudF9uYW1lIikgYnRfY3RmX2dldF9kZWNsX2V2
ZW50X25hbWUoY29uc3Qgc3RydWN0CiAJCWJ0X2N0Zl9ldmVudF9kZWNsICpldmVudCk7CiAlcmVu
YW1lKCJfYnRfY3RmX2dldF9kZWNsX2ZpZWxkX25hbWUiKSBidF9jdGZfZ2V0X2RlY2xfZmllbGRf
bmFtZSgKIAkJY29uc3Qgc3RydWN0IGJ0X2N0Zl9maWVsZF9kZWNsICpmaWVsZCk7CiAlcmVuYW1l
KCJfYnRfY3RmX2dldF9kZWNsX2Zyb21fZGVmIikgYnRfY3RmX2dldF9kZWNsX2Zyb21fZGVmKAot
CQljb25zdCBzdHJ1Y3QgZGVmaW5pdGlvbiAqZmllbGQpOworCQljb25zdCBzdHJ1Y3QgYnRfZGVm
aW5pdGlvbiAqZmllbGQpOwogCi1jb25zdCBzdHJ1Y3QgZGVmaW5pdGlvbiAqYnRfY3RmX2dldF90
b3BfbGV2ZWxfc2NvcGUoY29uc3Qgc3RydWN0IGJ0X2N0Zl9ldmVudCAqY3RmX2V2ZW50LAorY29u
c3Qgc3RydWN0IGJ0X2RlZmluaXRpb24gKmJ0X2N0Zl9nZXRfdG9wX2xldmVsX3Njb3BlKGNvbnN0
IHN0cnVjdCBidF9jdGZfZXZlbnQgKmN0Zl9ldmVudCwKIAkJZW51bSBidF9jdGZfc2NvcGUgc2Nv
cGUpOwogY29uc3QgY2hhciAqYnRfY3RmX2V2ZW50X25hbWUoY29uc3Qgc3RydWN0IGJ0X2N0Zl9l
dmVudCAqY3RmX2V2ZW50KTsKIHVpbnQ2NF90IGJ0X2N0Zl9nZXRfdGltZXN0YW1wKGNvbnN0IHN0
cnVjdCBidF9jdGZfZXZlbnQgKmN0Zl9ldmVudCk7CiB1aW50NjRfdCBidF9jdGZfZ2V0X2N5Y2xl
cyhjb25zdCBzdHJ1Y3QgYnRfY3RmX2V2ZW50ICpjdGZfZXZlbnQpOwotY29uc3Qgc3RydWN0IGRl
ZmluaXRpb24gKmJ0X2N0Zl9nZXRfZmllbGQoY29uc3Qgc3RydWN0IGJ0X2N0Zl9ldmVudCAqY3Rm
X2V2ZW50LAotCQljb25zdCBzdHJ1Y3QgZGVmaW5pdGlvbiAqc2NvcGUsCitjb25zdCBzdHJ1Y3Qg
YnRfZGVmaW5pdGlvbiAqYnRfY3RmX2dldF9maWVsZChjb25zdCBzdHJ1Y3QgYnRfY3RmX2V2ZW50
ICpjdGZfZXZlbnQsCisJCWNvbnN0IHN0cnVjdCBidF9kZWZpbml0aW9uICpzY29wZSwKIAkJY29u
c3QgY2hhciAqZmllbGQpOwotY29uc3Qgc3RydWN0IGRlZmluaXRpb24gKmJ0X2N0Zl9nZXRfaW5k
ZXgoY29uc3Qgc3RydWN0IGJ0X2N0Zl9ldmVudCAqY3RmX2V2ZW50LAotCQljb25zdCBzdHJ1Y3Qg
ZGVmaW5pdGlvbiAqZmllbGQsCitjb25zdCBzdHJ1Y3QgYnRfZGVmaW5pdGlvbiAqYnRfY3RmX2dl
dF9pbmRleChjb25zdCBzdHJ1Y3QgYnRfY3RmX2V2ZW50ICpjdGZfZXZlbnQsCisJCWNvbnN0IHN0
cnVjdCBidF9kZWZpbml0aW9uICpmaWVsZCwKIAkJdW5zaWduZWQgaW50IGluZGV4KTsKLWNvbnN0
IGNoYXIgKmJ0X2N0Zl9maWVsZF9uYW1lKGNvbnN0IHN0cnVjdCBkZWZpbml0aW9uICpmaWVsZCk7
Ci1lbnVtIGN0Zl90eXBlX2lkIGJ0X2N0Zl9maWVsZF90eXBlKGNvbnN0IHN0cnVjdCBkZWNsYXJh
dGlvbiAqZmllbGQpOwotaW50IGJ0X2N0Zl9nZXRfaW50X3NpZ25lZG5lc3MoY29uc3Qgc3RydWN0
IGRlY2xhcmF0aW9uICpmaWVsZCk7Ci1pbnQgYnRfY3RmX2dldF9pbnRfYmFzZShjb25zdCBzdHJ1
Y3QgZGVjbGFyYXRpb24gKmZpZWxkKTsKLWludCBidF9jdGZfZ2V0X2ludF9ieXRlX29yZGVyKGNv
bnN0IHN0cnVjdCBkZWNsYXJhdGlvbiAqZmllbGQpOwotc3NpemVfdCBidF9jdGZfZ2V0X2ludF9s
ZW4oY29uc3Qgc3RydWN0IGRlY2xhcmF0aW9uICpmaWVsZCk7Ci1lbnVtIGN0Zl9zdHJpbmdfZW5j
b2RpbmcgYnRfY3RmX2dldF9lbmNvZGluZyhjb25zdCBzdHJ1Y3QgZGVjbGFyYXRpb24gKmZpZWxk
KTsKLWludCBidF9jdGZfZ2V0X2FycmF5X2xlbihjb25zdCBzdHJ1Y3QgZGVjbGFyYXRpb24gKmZp
ZWxkKTsKLXVpbnQ2NF90IGJ0X2N0Zl9nZXRfdWludDY0KGNvbnN0IHN0cnVjdCBkZWZpbml0aW9u
ICpmaWVsZCk7Ci1pbnQ2NF90IGJ0X2N0Zl9nZXRfaW50NjQoY29uc3Qgc3RydWN0IGRlZmluaXRp
b24gKmZpZWxkKTsKLWNoYXIgKmJ0X2N0Zl9nZXRfY2hhcl9hcnJheShjb25zdCBzdHJ1Y3QgZGVm
aW5pdGlvbiAqZmllbGQpOwotY2hhciAqYnRfY3RmX2dldF9zdHJpbmcoY29uc3Qgc3RydWN0IGRl
ZmluaXRpb24gKmZpZWxkKTsKK2NvbnN0IGNoYXIgKmJ0X2N0Zl9maWVsZF9uYW1lKGNvbnN0IHN0
cnVjdCBidF9kZWZpbml0aW9uICpmaWVsZCk7CitlbnVtIGN0Zl90eXBlX2lkIGJ0X2N0Zl9maWVs
ZF90eXBlKGNvbnN0IHN0cnVjdCBidF9kZWNsYXJhdGlvbiAqZmllbGQpOworaW50IGJ0X2N0Zl9n
ZXRfaW50X3NpZ25lZG5lc3MoY29uc3Qgc3RydWN0IGJ0X2RlY2xhcmF0aW9uICpmaWVsZCk7Citp
bnQgYnRfY3RmX2dldF9pbnRfYmFzZShjb25zdCBzdHJ1Y3QgYnRfZGVjbGFyYXRpb24gKmZpZWxk
KTsKK2ludCBidF9jdGZfZ2V0X2ludF9ieXRlX29yZGVyKGNvbnN0IHN0cnVjdCBidF9kZWNsYXJh
dGlvbiAqZmllbGQpOworc3NpemVfdCBidF9jdGZfZ2V0X2ludF9sZW4oY29uc3Qgc3RydWN0IGJ0
X2RlY2xhcmF0aW9uICpmaWVsZCk7CitlbnVtIGN0Zl9zdHJpbmdfZW5jb2RpbmcgYnRfY3RmX2dl
dF9lbmNvZGluZyhjb25zdCBzdHJ1Y3QgYnRfZGVjbGFyYXRpb24gKmZpZWxkKTsKK2ludCBidF9j
dGZfZ2V0X2FycmF5X2xlbihjb25zdCBzdHJ1Y3QgYnRfZGVjbGFyYXRpb24gKmZpZWxkKTsKK3Vp
bnQ2NF90IGJ0X2N0Zl9nZXRfdWludDY0KGNvbnN0IHN0cnVjdCBidF9kZWZpbml0aW9uICpmaWVs
ZCk7CitpbnQ2NF90IGJ0X2N0Zl9nZXRfaW50NjQoY29uc3Qgc3RydWN0IGJ0X2RlZmluaXRpb24g
KmZpZWxkKTsKK2NoYXIgKmJ0X2N0Zl9nZXRfY2hhcl9hcnJheShjb25zdCBzdHJ1Y3QgYnRfZGVm
aW5pdGlvbiAqZmllbGQpOworY2hhciAqYnRfY3RmX2dldF9zdHJpbmcoY29uc3Qgc3RydWN0IGJ0
X2RlZmluaXRpb24gKmZpZWxkKTsKIGludCBidF9jdGZfZmllbGRfZ2V0X2Vycm9yKHZvaWQpOwog
Y29uc3QgY2hhciAqYnRfY3RmX2dldF9kZWNsX2V2ZW50X25hbWUoY29uc3Qgc3RydWN0IGJ0X2N0
Zl9ldmVudF9kZWNsICpldmVudCk7CiBjb25zdCBjaGFyICpidF9jdGZfZ2V0X2RlY2xfZmllbGRf
bmFtZShjb25zdCBzdHJ1Y3QgYnRfY3RmX2ZpZWxkX2RlY2wgKmZpZWxkKTsKLWNvbnN0IHN0cnVj
dCBkZWNsYXJhdGlvbiAqYnRfY3RmX2dldF9kZWNsX2Zyb21fZGVmKGNvbnN0IHN0cnVjdCBkZWZp
bml0aW9uICpmaWVsZCk7Citjb25zdCBzdHJ1Y3QgYnRfZGVjbGFyYXRpb24gKmJ0X2N0Zl9nZXRf
ZGVjbF9mcm9tX2RlZihjb25zdCBzdHJ1Y3QgYnRfZGVmaW5pdGlvbiAqZmllbGQpOwogCiAlcHl0
aG9uY29kZSV7CiAKZGlmZiAtLWdpdCBhL2JpbmRpbmdzL3B5dGhvbi9weXRob24tY29tcGxlbWVu
dHMuYyBiL2JpbmRpbmdzL3B5dGhvbi9weXRob24tY29tcGxlbWVudHMuYwppbmRleCBhNGVlMzdl
Li5hYTY1NTU1IDEwMDY0NAotLS0gYS9iaW5kaW5ncy9weXRob24vcHl0aG9uLWNvbXBsZW1lbnRz
LmMKKysrIGIvYmluZGluZ3MvcHl0aG9uL3B5dGhvbi1jb21wbGVtZW50cy5jCkBAIC00NCwxNiAr
NDQsMTYgQEAgdm9pZCBfYnRfZmlsZV9jbG9zZShGSUxFICpmcCkKICovCiAKIC8qIGN0Zi1maWVs
ZC1saXN0ICovCi1zdHJ1Y3QgZGVmaW5pdGlvbiAqKl9idF9weXRob25fZmllbGRfbGlzdGNhbGxl
cigKK3N0cnVjdCBidF9kZWZpbml0aW9uICoqX2J0X3B5dGhvbl9maWVsZF9saXN0Y2FsbGVyKAog
CQljb25zdCBzdHJ1Y3QgYnRfY3RmX2V2ZW50ICpjdGZfZXZlbnQsCi0JCWNvbnN0IHN0cnVjdCBk
ZWZpbml0aW9uICpzY29wZSkKKwkJY29uc3Qgc3RydWN0IGJ0X2RlZmluaXRpb24gKnNjb3BlKQog
ewotCXN0cnVjdCBkZWZpbml0aW9uICoqbGlzdDsKKwlzdHJ1Y3QgYnRfZGVmaW5pdGlvbiAqKmxp
c3Q7CiAJdW5zaWduZWQgaW50IGNvdW50OwogCWludCByZXQ7CiAKIAlyZXQgPSBidF9jdGZfZ2V0
X2ZpZWxkX2xpc3QoY3RmX2V2ZW50LCBzY29wZSwKLQkJKGNvbnN0IHN0cnVjdCBkZWZpbml0aW9u
ICogY29uc3QgKiopJmxpc3QsICZjb3VudCk7CisJCShjb25zdCBzdHJ1Y3QgYnRfZGVmaW5pdGlv
biAqIGNvbnN0ICoqKSZsaXN0LCAmY291bnQpOwogCiAJaWYgKHJldCA8IDApCS8qIEZvciBweXRo
b24gdG8ga25vdyBhbiBlcnJvciBvY2N1cmVkICovCiAJCWxpc3QgPSBOVUxMOwpAQCAtNjMsOCAr
NjMsOCBAQCBzdHJ1Y3QgZGVmaW5pdGlvbiAqKl9idF9weXRob25fZmllbGRfbGlzdGNhbGxlcigK
IAlyZXR1cm4gbGlzdDsKIH0KIAotc3RydWN0IGRlZmluaXRpb24gKl9idF9weXRob25fZmllbGRf
b25lX2Zyb21fbGlzdCgKLQkJc3RydWN0IGRlZmluaXRpb24gKipsaXN0LCBpbnQgaW5kZXgpCitz
dHJ1Y3QgYnRfZGVmaW5pdGlvbiAqX2J0X3B5dGhvbl9maWVsZF9vbmVfZnJvbV9saXN0KAorCQlz
dHJ1Y3QgYnRfZGVmaW5pdGlvbiAqKmxpc3QsIGludCBpbmRleCkKIHsKIAlyZXR1cm4gbGlzdFtp
bmRleF07CiB9CmRpZmYgLS1naXQgYS9iaW5kaW5ncy9weXRob24vcHl0aG9uLWNvbXBsZW1lbnRz
LmggYi9iaW5kaW5ncy9weXRob24vcHl0aG9uLWNvbXBsZW1lbnRzLmgKaW5kZXggOTU5N2Q3MC4u
NDMzNWQ4YSAxMDA2NDQKLS0tIGEvYmluZGluZ3MvcHl0aG9uL3B5dGhvbi1jb21wbGVtZW50cy5o
CisrKyBiL2JpbmRpbmdzL3B5dGhvbi9weXRob24tY29tcGxlbWVudHMuaApAQCAtMzIsMTEgKzMy
LDExIEBAIEZJTEUgKl9idF9maWxlX29wZW4oY2hhciAqZmlsZV9wYXRoLCBjaGFyICptb2RlKTsK
IHZvaWQgX2J0X2ZpbGVfY2xvc2UoRklMRSAqZnApOwogCiAvKiBjdGYtZmllbGQtbGlzdCAqLwot
c3RydWN0IGRlZmluaXRpb24gKipfYnRfcHl0aG9uX2ZpZWxkX2xpc3RjYWxsZXIoCitzdHJ1Y3Qg
YnRfZGVmaW5pdGlvbiAqKl9idF9weXRob25fZmllbGRfbGlzdGNhbGxlcigKIAkJY29uc3Qgc3Ry
dWN0IGJ0X2N0Zl9ldmVudCAqY3RmX2V2ZW50LAotCQljb25zdCBzdHJ1Y3QgZGVmaW5pdGlvbiAq
c2NvcGUpOwotc3RydWN0IGRlZmluaXRpb24gKl9idF9weXRob25fZmllbGRfb25lX2Zyb21fbGlz
dCgKLQkJc3RydWN0IGRlZmluaXRpb24gKipsaXN0LCBpbnQgaW5kZXgpOworCQljb25zdCBzdHJ1
Y3QgYnRfZGVmaW5pdGlvbiAqc2NvcGUpOworc3RydWN0IGJ0X2RlZmluaXRpb24gKl9idF9weXRo
b25fZmllbGRfb25lX2Zyb21fbGlzdCgKKwkJc3RydWN0IGJ0X2RlZmluaXRpb24gKipsaXN0LCBp
bnQgaW5kZXgpOwogCiAvKiBldmVudF9kZWNsX2xpc3QgKi8KIHN0cnVjdCBidF9jdGZfZXZlbnRf
ZGVjbCAqKl9idF9weXRob25fZXZlbnRfZGVjbF9saXN0Y2FsbGVyKAotLSAKMS43LjEKCg==
--001a11c21b04e6c3ed04e0243bcd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--001a11c21b04e6c3ed04e0243bcd--
