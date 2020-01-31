From: =?UTF-8?Q?Maxime_Roussin=2DB=C3=A9langer?=
 <maxime.roussinbelanger@gmail.com>
Subject: Re: [PATCH] Introduce vtracef
Date: Fri, 31 Jan 2020 18:17:24 -0500
Message-ID: <CAE=T-s4CT=YkGRV_5QDLnvVqZcGCqz2x-LeDcUKdVAA+goKcyA@mail.gmail.com>
References: <20200131215501.19536-1-maxime.roussinbelanger@gmail.com>
 <569392e8-be60-26e1-a2d4-72112e6acbac@simark.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3542073465027032504=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 by lists.lttng.org (Postfix) with ESMTPS id 488Y6R66r6z24PP
 for <lttng-dev@lists.lttng.org>; Fri, 31 Jan 2020 18:17:51 -0500 (EST)
Received: by mail-io1-xd43.google.com with SMTP id z16so5403768iod.11
 for <lttng-dev@lists.lttng.org>; Fri, 31 Jan 2020 15:17:51 -0800 (PST)
In-Reply-To: <569392e8-be60-26e1-a2d4-72112e6acbac@simark.ca>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Simon Marchi <simark@simark.ca>
Cc: lttng-dev@lists.lttng.org, champagne.guillaume.c@gmail.com
List-Id: lttng-dev@lists.lttng.org

--===============3542073465027032504==
Content-Type: multipart/alternative; boundary="0000000000004dff8b059d77c8a3"

--0000000000004dff8b059d77c8a3
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

On Fri, Jan 31, 2020 at 6:03 PM Simon Marchi <simark@simark.ca> wrote:
>
> Hi Maxime,
>
> Tip for next time: this mailing is used for many projects, so it helps
> to include the project name in the patch prefix.  You can do so by using
>
>   --subject-prefix="PATCH lttng-ust"
>
> on you git-send-email command line.

Will do!

>
> On 2020-01-31 4:55 p.m., Maxime Roussin-Belanger wrote:
> > vtracef accepts a va_list argument to simplify tracing
> > functions which use a va_list
> >
> > Here's an example from wpa_supplicant that I wanted to
> > trace:
> >
> > void wpa_debug(int level, const char* fmt, ...) {
> >
> >     va_list ap;
> >     va_start(ap, fmt);
> >
> >     ...
> >     // The call I want to easily trace with vtracef
> >     vprintf(fmt, ap);
> >
> >     ...
> >     va_end(ap);
> > }
> >
> > wpa_debug is used a fair amount and it would be annoying to
> > replace all the wpa_debug calls with tracef.
> >
> > With vtracef, it simplifies the find and replace effort by
> > only changing it at one place.
>
> The shortcoming, as you mentiond on IRC, is that it doesn't support SDT
integration.  The tracef
> macro call has a `STAP_PROBEV` call, but it doesn't seem possible to use
that here.  The number
> of arguments in a va_list is known at runtime (in fact it's not really
known by the va_list itself),
> whereas STAP_PROBEV wants to know the number of arguments at compile time.
>
> I think it would still be useful to have vtracef, for the use case
explained above, but have it
> documented that it is not integrated with the stap probes (unless
somebody has a magic idea that
> would make it work).  But that will be for the maintainer to decide.

Where would that be? In the man page? If so it would be the first time
editing/creating a man page.
It seems fairly simple, but I probably need some guidance on where to start.

>
> Note that if the feature is accepted, it will require at least a man page
update. An update in
> doc/examples/demo-tracef/demo-tracef.c would also be nice, to have an
example of how it can be used.

Looking at the example, maybe I should create another file demo-vtracef.c?

Max.

>
> Simon
>
> >
> > Signed-off-by: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com
>
> > ---
> >  include/lttng/tracef.h | 10 ++++++++++
> >  liblttng-ust/tracef.c  | 18 +++++++++++-------
> >  2 files changed, 21 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/lttng/tracef.h b/include/lttng/tracef.h
> > index 0c59c9ae..e3a7587d 100644
> > --- a/include/lttng/tracef.h
> > +++ b/include/lttng/tracef.h
> > @@ -32,13 +32,23 @@ extern "C" {
> >  extern
> >  void _lttng_ust_tracef(const char *fmt, ...);
> >
> > +extern
> > +void _lttng_ust_vtracef(const char *fmt, va_list ap);
> > +
> >  #define tracef(fmt, ...)                                             \
> >       do {                                                            \
> >               LTTNG_STAP_PROBEV(tracepoint_lttng_ust_tracef, event, ##
__VA_ARGS__); \
> >               if
(caa_unlikely(__tracepoint_lttng_ust_tracef___event.state)) \
> >                       _lttng_ust_tracef(fmt, ## __VA_ARGS__);         \
> >       } while (0)
> >
> > +#ifndef LTTNG_UST_HAVE_SDT_INTEGRATION
> > +#define vtracef(fmt, ap)                                             \
> > +     do {                                                            \
> > +             if
(caa_unlikely(__tracepoint_lttng_ust_tracef___event.state)) \
> > +                     _lttng_ust_vtracef(fmt, ap);            \
> > +     } while (0)
> > +#endif
>
> If we end up with what I suggested above (vtracef documented not to
integrate an
> stap probe), this #ifndef would go away,
>
> >  #ifdef __cplusplus
> >  }
> >  #endif
> > diff --git a/liblttng-ust/tracef.c b/liblttng-ust/tracef.c
> > index ea98e43e..2a809eed 100644
> > --- a/liblttng-ust/tracef.c
> > +++ b/liblttng-ust/tracef.c
> > @@ -29,20 +29,24 @@
> >  #define TRACEPOINT_DEFINE
> >  #include "lttng-ust-tracef-provider.h"
> >
> > -void _lttng_ust_tracef(const char *fmt, ...)
> > +void _lttng_ust_vtracef(const char *fmt, va_list ap)
> >  {
> > -     va_list ap;
> >       char *msg;
> > -     int len;
> > -
> > -     va_start(ap, fmt);
> > -     len = vasprintf(&msg, fmt, ap);
> > +     const int len = vasprintf(&msg, fmt, ap);
> >       /* len does not include the final \0 */
> >       if (len < 0)
> > -             goto end;
> > +             return;
>
> We try to have a single exit point in each function, to facilitate
> resource management in the case of errors, so please keep the goto
> end pattern:
>
>   ...
>
>   if (len < 0)
>     goto end;
>
>   ...
>
> end:
>   return
> }
>
> >       __tracepoint_cb_lttng_ust_tracef___event(msg, len,
> >               LTTNG_UST_CALLER_IP());
> >       free(msg);
> > +}
> > +
> > +void _lttng_ust_tracef(const char *fmt, ...)
> > +{
> > +     va_list ap;
> > +
> > +     va_start(ap, fmt);
> > +     _lttng_ust_vtracef(fmt, ap);
> >  end:
>
> You can remove the end label here.
>
> Simon

--0000000000004dff8b059d77c8a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Simon,<br><br>On Fri, Jan 31, 2020 at 6:03 PM Simon Mar=
chi &lt;<a href=3D"mailto:simark@simark.ca">simark@simark.ca</a>&gt; wrote:=
<br>&gt;<br>&gt; Hi Maxime,<br>&gt;<br>&gt; Tip for next time: this mailing=
 is used for many projects, so it helps<br>&gt; to include the project name=
 in the patch prefix.=C2=A0 You can do so by using<br>&gt;<br>&gt; =C2=A0 -=
-subject-prefix=3D&quot;PATCH lttng-ust&quot;<br>&gt;<br>&gt; on you git-se=
nd-email command line.<div><br></div><div>Will do!</div><div><br>&gt;<br>&g=
t; On 2020-01-31 4:55 p.m., Maxime Roussin-Belanger wrote:<br>&gt; &gt; vtr=
acef accepts a va_list argument to simplify tracing<br>&gt; &gt; functions =
which use a va_list<br>&gt; &gt;<br>&gt; &gt; Here&#39;s an example from wp=
a_supplicant that I wanted to<br>&gt; &gt; trace:<br>&gt; &gt;<br>&gt; &gt;=
 void wpa_debug(int level, const char* fmt, ...) {<br>&gt; &gt;<br>&gt; &gt=
; =C2=A0 =C2=A0 va_list ap;<br>&gt; &gt; =C2=A0 =C2=A0 va_start(ap, fmt);<b=
r>&gt; &gt;<br>&gt; &gt; =C2=A0 =C2=A0 ...<br>&gt; &gt; =C2=A0 =C2=A0 // Th=
e call I want to easily trace with vtracef<br>&gt; &gt; =C2=A0 =C2=A0 vprin=
tf(fmt, ap);<br>&gt; &gt;<br>&gt; &gt; =C2=A0 =C2=A0 ...<br>&gt; &gt; =C2=
=A0 =C2=A0 va_end(ap);<br>&gt; &gt; }<br>&gt; &gt;<br>&gt; &gt; wpa_debug i=
s used a fair amount and it would be annoying to<br>&gt; &gt; replace all t=
he wpa_debug calls with tracef.<br>&gt; &gt;<br>&gt; &gt; With vtracef, it =
simplifies the find and replace effort by<br>&gt; &gt; only changing it at =
one place.<br>&gt;<br>&gt; The shortcoming, as you mentiond on IRC, is that=
 it doesn&#39;t support SDT integration.=C2=A0 The tracef<br>&gt; macro cal=
l has a `STAP_PROBEV` call, but it doesn&#39;t seem possible to use that he=
re.=C2=A0 The number<br>&gt; of arguments in a va_list is known at runtime =
(in fact it&#39;s not really known by the va_list itself),<br>&gt; whereas =
STAP_PROBEV wants to know the number of arguments at compile time.<br>&gt;<=
br>&gt; I think it would still be useful to have vtracef, for the use case =
explained above, but have it<br>&gt; documented that it is not integrated w=
ith the stap probes (unless somebody has a magic idea that<br>&gt; would ma=
ke it work).=C2=A0 But that will be for the maintainer to decide.</div><div=
><br></div><div>Where would that be? In the man page? If so it would be the=
 first time editing/creating a man page.</div><div>It seems fairly simple, =
but I probably need some guidance on where to start.</div><div><br>&gt;<br>=
&gt; Note that if the feature is accepted, it will require at least a man p=
age update. An update in<br>&gt; doc/examples/demo-tracef/demo-tracef.c wou=
ld also be nice, to have an example of how it can be used.</div><div><br></=
div><div>Looking at the example, maybe I should create another file demo-vt=
racef.c?</div><div><br></div><div>Max.</div><div><br>&gt;<br>&gt; Simon<br>=
&gt;<br>&gt; &gt;<br>&gt; &gt; Signed-off-by: Maxime Roussin-Belanger &lt;<=
a href=3D"mailto:maxime.roussinbelanger@gmail.com">maxime.roussinbelanger@g=
mail.com</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt; =C2=A0include/lttng/tracef.h=
 | 10 ++++++++++<br>&gt; &gt; =C2=A0liblttng-ust/tracef.c =C2=A0| 18 ++++++=
+++++-------<br>&gt; &gt; =C2=A02 files changed, 21 insertions(+), 7 deleti=
ons(-)<br>&gt; &gt;<br>&gt; &gt; diff --git a/include/lttng/tracef.h b/incl=
ude/lttng/tracef.h<br>&gt; &gt; index 0c59c9ae..e3a7587d 100644<br>&gt; &gt=
; --- a/include/lttng/tracef.h<br>&gt; &gt; +++ b/include/lttng/tracef.h<br=
>&gt; &gt; @@ -32,13 +32,23 @@ extern &quot;C&quot; {<br>&gt; &gt; =C2=A0ex=
tern<br>&gt; &gt; =C2=A0void _lttng_ust_tracef(const char *fmt, ...);<br>&g=
t; &gt; <br>&gt; &gt; +extern<br>&gt; &gt; +void _lttng_ust_vtracef(const c=
har *fmt, va_list ap);<br>&gt; &gt; +<br>&gt; &gt; =C2=A0#define tracef(fmt=
, ...) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 \<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 do { =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LTTNG_STAP_PROBEV(tracepoint_lttng_ust_trac=
ef, event, ## __VA_ARGS__); \<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (caa_unlikely(__tracepoint_lttng_ust_tracef___event.st=
ate)) \<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 _lttng_ust_tracef(fmt, ## __VA_ARGS__); =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 \<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 } while (0)<br>&gt; &=
gt; <br>&gt; &gt; +#ifndef LTTNG_UST_HAVE_SDT_INTEGRATION<br>&gt; &gt; +#de=
fine vtracef(fmt, ap) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>&gt; &gt; + =C2=A0 =C2=A0 do { =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>&gt; &gt; + =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (caa_unlikely(__tracepoint_lttng_ust=
_tracef___event.state)) \<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _lttng_ust_vtracef(fmt, ap); =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>&gt; &gt; + =C2=A0 =C2=A0 } while (0)<b=
r>&gt; &gt; +#endif<br>&gt;<br>&gt; If we end up with what I suggested abov=
e (vtracef documented not to integrate an<br>&gt; stap probe), this #ifndef=
 would go away,<br>&gt;<br>&gt; &gt; =C2=A0#ifdef __cplusplus<br>&gt; &gt; =
=C2=A0}<br>&gt; &gt; =C2=A0#endif<br>&gt; &gt; diff --git a/liblttng-ust/tr=
acef.c b/liblttng-ust/tracef.c<br>&gt; &gt; index ea98e43e..2a809eed 100644=
<br>&gt; &gt; --- a/liblttng-ust/tracef.c<br>&gt; &gt; +++ b/liblttng-ust/t=
racef.c<br>&gt; &gt; @@ -29,20 +29,24 @@<br>&gt; &gt; =C2=A0#define TRACEPO=
INT_DEFINE<br>&gt; &gt; =C2=A0#include &quot;lttng-ust-tracef-provider.h&qu=
ot;<br>&gt; &gt; <br>&gt; &gt; -void _lttng_ust_tracef(const char *fmt, ...=
)<br>&gt; &gt; +void _lttng_ust_vtracef(const char *fmt, va_list ap)<br>&gt=
; &gt; =C2=A0{<br>&gt; &gt; - =C2=A0 =C2=A0 va_list ap;<br>&gt; &gt; =C2=A0=
 =C2=A0 =C2=A0 char *msg;<br>&gt; &gt; - =C2=A0 =C2=A0 int len;<br>&gt; &gt=
; -<br>&gt; &gt; - =C2=A0 =C2=A0 va_start(ap, fmt);<br>&gt; &gt; - =C2=A0 =
=C2=A0 len =3D vasprintf(&amp;msg, fmt, ap);<br>&gt; &gt; + =C2=A0 =C2=A0 c=
onst int len =3D vasprintf(&amp;msg, fmt, ap);<br>&gt; &gt; =C2=A0 =C2=A0 =
=C2=A0 /* len does not include the final \0 */<br>&gt; &gt; =C2=A0 =C2=A0 =
=C2=A0 if (len &lt; 0)<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto end;<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
eturn;<br>&gt;<br>&gt; We try to have a single exit point in each function,=
 to facilitate<br>&gt; resource management in the case of errors, so please=
 keep the goto<br>&gt; end pattern:<br>&gt;<br>&gt; =C2=A0 ...<br>&gt;<br>&=
gt; =C2=A0 if (len &lt; 0)<br>&gt; =C2=A0 =C2=A0 goto end;<br>&gt;<br>&gt; =
=C2=A0 ...<br>&gt;<br>&gt; end:<br>&gt; =C2=A0 return<br>&gt; }<br>&gt;<br>=
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 __tracepoint_cb_lttng_ust_tracef___event(msg=
, len,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LTTNG_=
UST_CALLER_IP());<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 free(msg);<br>&gt; &gt;=
 +}<br>&gt; &gt; +<br>&gt; &gt; +void _lttng_ust_tracef(const char *fmt, ..=
.)<br>&gt; &gt; +{<br>&gt; &gt; + =C2=A0 =C2=A0 va_list ap;<br>&gt; &gt; +<=
br>&gt; &gt; + =C2=A0 =C2=A0 va_start(ap, fmt);<br>&gt; &gt; + =C2=A0 =C2=
=A0 _lttng_ust_vtracef(fmt, ap);<br>&gt; &gt; =C2=A0end:<br>&gt;<br>&gt; Yo=
u can remove the end label here.<br>&gt;<br>&gt; Simon</div></div>

--0000000000004dff8b059d77c8a3--

--===============3542073465027032504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3542073465027032504==--
