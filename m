From: Lai Jiangshan <eag0628@gmail.com>
Subject: Re: [PATCH 1/3] urcu: avoid "expression result unused"
 from clang
Date: Sun, 9 Dec 2012 09:01:20 +0800
Message-ID: <CACvQF53-yf90t5o2-s6vjVvUotvVogrBgu4LM7FrsbWgEa1+ng__8238.73032718456$1355014935$gmane$org@mail.gmail.com>
References: <1354872295-32371-1-git-send-email-laijs@cn.fujitsu.com>
	<20121207165848.GB12338@Krystal>
	<CACvQF53+x_PDd+aOtM0k2wN0BJZXRMkB3pjXxfvsV=HkdknM=Q@mail.gmail.com>
	<CACvQF514yxBjppYFKJEqX=n31LdU6dTqBg9-7kn5AoTy0i7=Lw@mail.gmail.com>
	<20121208150023.GA16943@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0732893119=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <eag0628@gmail.com>) id 1ThVGo-0000Kd-2W
	for lttng-dev@lists.lttng.org; Sat, 08 Dec 2012 20:01:26 -0500
Received: by mail-oa0-f48.google.com with SMTP id h2so1793760oag.35
	for <lttng-dev@lists.lttng.org>; Sat, 08 Dec 2012 17:01:20 -0800 (PST)
In-Reply-To: <20121208150023.GA16943@Krystal>
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

--===============0732893119==
Content-Type: multipart/alternative; boundary=14dae9399d2b99720a04d060fcfd

--14dae9399d2b99720a04d060fcfd
Content-Type: text/plain; charset=ISO-8859-1

On Saturday, December 8, 2012, Mathieu Desnoyers wrote:

> * Lai Jiangshan (eag0628@gmail.com <javascript:;>) wrote:
> > How about the one in yy.diff?
> >
> > xx.diff fixes the one what I had sent in 1/3 patch, but it may still
> > cause warning in future if the complier become more strict.
>
> Hrm. In any cases, I think that even with the 2 patches you propose, the
> warning "unused expression return" would still be valid (because we end
> up not using the result of the outer statement-expression). We might
> want to consider simpler approaches:
>
> 1 - Add the missing (void) casts before each CMM_STORE_SHARED() in the
>     code. I don't like this because it makes the CMM_STORE_SHARED common
>     case more cumbersome to use.


I don't like it either, it is not friendly.


> 2 - Change the CMM_STORE_SHARED() API so it does not return anything.
>     I think most use-cases don't involve using its return value anyway.



It will break the original goal:
CMM_STORE_SHARED() can be used as chained assignment:
tmp = CMM_STORE_SHARED(x, v)
CMM_STORE_SHARED(y, CMM_STORE_SHARED(x, v))
func(CMM_STORE_SHARED(x,v))



> Thoughts ?
>
> Thanks,
>
> Mathieu
>
> >
> > On Sat, Dec 8, 2012 at 1:27 AM, Lai Jiangshan <eag0628@gmail.com<javascript:;>>
> wrote:
> > >
> > >
> > > On Saturday, December 8, 2012, Mathieu Desnoyers wrote:
> > >>
> > >> * Lai Jiangshan (laijs@cn.fujitsu.com <javascript:;>) wrote:
> > >> > The last expression result is unused and clang will complain.
> > >> > The trick in the patch supresses the complaint
> > >>
> > >> Hrm, but with this patch, gcc complains:
> > >>
> > >> rculfhash.c:1921:3: warning: variable '_w' set but not used
> > >> [-Wunused-but-set-variable]
> > >>
> > >> using
> > >>
> > >> gcc version 4.7.2 (Debian 4.7.2-4)
> > >
> > >
> > > Ouch, my gcc is too old
> > >
> > >
> > >>
> > >>
> > >> Thoughts ?
> > >>
> > >> Thanks,
> > >>
> > >> Mathieu
> > >>
> > >> >
> > >> > Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com <javascript:;>>
> > >> > ---
> > >> >  urcu/system.h        |    5 ++++-
> > >> >  2 files changed, 4 insertions(+), 1 deletions(-)
> > >> >
> > >> > diff --git a/urcu/system.h b/urcu/system.h
> > >> > index 2a45f22..6b7b0af 100644
> > >> > --- a/urcu/system.h
> > >> > +++ b/urcu/system.h
> > >> > @@ -46,12 +46,15 @@
> > >> >  /*
> > >> >   * Store v into x, where x is located in shared memory. Performs
> the
> > >> >   * required cache flush after writing. Returns v.
> > >> > + * "_w" here avoids the warning from clang:
> > >> > + *   warning: expression result unused [-Wunused-value]
> > >> >   */
> > >> >  #define CMM_STORE_SHARED(x, v)               \
> > >> >       ({                              \
> > >> >               __typeof__(x) _v = _CMM_STORE_SHARED(x, v);     \
> > >> > +             __typeof__(x) _w;       \
> > >> >               cmm_smp_wmc();          \
> > >> > -             _v;                     \
> > >> > +             _w = _v;                \
> > >> >       })
> > >> >
> > >> >  #endif /* _URCU_SYSTEM_H */
> > >> > --
> > >> > 1.7.4.4
> > >> >
> > >> >
> > >> > _______________________________________________
> > >> > lttng-dev mailing list
> > >> > lttng-dev@lists.lttng.org <javascript:;>
> > >> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > >>
> > >>
> > >> --
> > >> Mathieu Desnoyers
> > >> Operating System Efficiency R&D Consultant
> > >> EfficiOS Inc.
> > >> http://www.efficios.com
> > >>
> > >> _______________________________________________
> > >> lttng-dev mailing list
> > >> lttng-dev@lists.lttng.org <javascript:;>
> > >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
>
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
>

--14dae9399d2b99720a04d060fcfd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, December 8, 2012, Mathieu Desnoyers  wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">* Lai Jiangshan (<a href=3D"javascript:;" onclick=
=3D"_e(event, &#39;cvml&#39;, &#39;eag0628@gmail.com&#39;)">eag0628@gmail.c=
om</a>) wrote:<br>

&gt; How about the one in yy.diff?<br>
&gt;<br>
&gt; xx.diff fixes the one what I had sent in 1/3 patch, but it may still<b=
r>
&gt; cause warning in future if the complier become more strict.<br>
<br>
Hrm. In any cases, I think that even with the 2 patches you propose, the<br=
>
warning &quot;unused expression return&quot; would still be valid (because =
we end<br>
up not using the result of the outer statement-expression). We might<br>
want to consider simpler approaches:<br>
<br>
1 - Add the missing (void) casts before each CMM_STORE_SHARED() in the<br>
=A0 =A0 code. I don&#39;t like this because it makes the CMM_STORE_SHARED c=
ommon<br>
=A0 =A0 case more cumbersome to use.</blockquote><div><br></div><div>I don&=
#39;t like it either, it is not friendly.</div><div>=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">

2 - Change the CMM_STORE_SHARED() API so it does not return anything.<br>
=A0 =A0 I think most use-cases don&#39;t involve using its return value any=
way.</blockquote><div><br></div><span class=3D"Apple-style-span" style><br>=
</span><div dir=3D"ltr">It will break the original goal:</div><span class=
=3D"Apple-style-span" style>CMM_STORE_SHARED() can be used as chained assig=
nment:</span><div>
<span class=3D"Apple-style-span" style dir=3D"ltr">tmp =3D=A0</span><span c=
lass=3D"Apple-style-span" style dir=3D"ltr"><span class=3D"Apple-style-span=
" style>CMM_STORE_SHARED(x, v)</span><br></span></div><div><span class=3D"A=
pple-style-span" style dir=3D"ltr">CMM_STORE_SHARED(y,=A0</span><span class=
=3D"Apple-style-span" style>CMM_STORE_SHARED(x, v))</span></div>
<div><span class=3D"Apple-style-span" style dir=3D"ltr">func(</span><span c=
lass=3D"Apple-style-span" style>CMM_STORE_SHARED(x,v))<span></span></span><=
span class=3D"Apple-style-span" style dir=3D"ltr"><br></span><div dir=3D"lt=
r"><br></div>
<div dir=3D"ltr"><br></div></div><div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Thoughts ?<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
&gt;<br>
&gt; On Sat, Dec 8, 2012 at 1:27 AM, Lai Jiangshan &lt;<a href=3D"javascrip=
t:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;eag0628@gmail.com&#39;)">eag=
0628@gmail.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On Saturday, December 8, 2012, Mathieu Desnoyers wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; * Lai Jiangshan (<a href=3D"javascript:;" onclick=3D"_e(event=
, &#39;cvml&#39;, &#39;laijs@cn.fujitsu.com&#39;)">laijs@cn.fujitsu.com</a>=
) wrote:<br>
&gt; &gt;&gt; &gt; The last expression result is unused and clang will comp=
lain.<br>
&gt; &gt;&gt; &gt; The trick in the patch supresses the complaint<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Hrm, but with this patch, gcc complains:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; rculfhash.c:1921:3: warning: variable &#39;_w&#39; set but no=
t used<br>
&gt; &gt;&gt; [-Wunused-but-set-variable]<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; using<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; gcc version 4.7.2 (Debian 4.7.2-4)<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Ouch, my gcc is too old<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thoughts ?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Mathieu<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Signed-off-by: Lai Jiangshan &lt;<a href=3D"javascript:;=
" onclick=3D"_e(event, &#39;cvml&#39;, &#39;laijs@cn.fujitsu.com&#39;)">lai=
js@cn.fujitsu.com</a>&gt;<br>
&gt; &gt;&gt; &gt; ---<br>
&gt; &gt;&gt; &gt; =A0urcu/system.h =A0 =A0 =A0 =A0| =A0 =A05 ++++-<br>
&gt; &gt;&gt; &gt; =A02 files changed, 4 insertions(+), 1 deletions(-)<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; diff --git a/urcu/system.h b/urcu/system.h<br>
&gt; &gt;&gt; &gt; index 2a45f22..6b7b0af 100644<br>
&gt; &gt;&gt; &gt; --- a/urcu/system.h<br>
&gt; &gt;&gt; &gt; +++ b/urcu/system.h<br>
&gt; &gt;&gt; &gt; @@ -46,12 +46,15 @@<br>
&gt; &gt;&gt; &gt; =A0/*<br>
&gt; &gt;&gt; &gt; =A0 * Store v into x, where x is located in shared memor=
y. Performs the<br>
&gt; &gt;&gt; &gt; =A0 * required cache flush after writing. Returns v.<br>
&gt; &gt;&gt; &gt; + * &quot;_w&quot; here avoids the warning from clang:<b=
r>
&gt; &gt;&gt; &gt; + * =A0 warning: expression result unused [-Wunused-valu=
e]<br>
&gt; &gt;&gt; &gt; =A0 */<br>
&gt; &gt;&gt; &gt; =A0#define CMM_STORE_SHARED(x, v) =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 \<br>
&gt; &gt;&gt; &gt; =A0 =A0 =A0 ({ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0\<br>
&gt; &gt;&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 __typeof__(x) _v =3D _CMM_ST=
ORE_SHARED(x, v); =A0 =A0 \<br>
&gt; &gt;&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 __typeof__(x) _w; =A0 =A0 =A0 =
\<br>
&gt; &gt;&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmm_smp_wmc(); =A0 =A0 =A0 =
=A0 =A0\<br>
&gt; &gt;&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 _v; =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 \<br>
&gt; &gt;&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 _w =3D _v; =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0\<br>
&gt; &gt;&gt; &gt; =A0 =A0 =A0 })<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; =A0#endif /* _URCU_SYSTEM_H */<br>
&gt; &gt;&gt; &gt; --<br>
&gt; &gt;&gt; &gt; 1.7.4.4<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; _______________________________________________<br>
&gt; &gt;&gt; &gt; lttng-dev mailing list<br>
&gt; &gt;&gt; &gt; <a href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&=
#39;, &#39;lttng-dev@lists.lttng.org&#39;)">lttng-dev@lists.lttng.org</a><b=
r>
&gt; &gt;&gt; &gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listin=
fo/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/list=
info/lttng-dev</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; --<br>
&gt; &gt;&gt; Mathieu Desnoyers<br>
&gt; &gt;&gt; Operating System Efficiency R&amp;D Consultant<br>
&gt; &gt;&gt; EfficiOS Inc.<br>
&gt; &gt;&gt; <a href=3D"http://www.efficios.com" target=3D"_blank">http://=
www.efficios.com</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; _______________________________________________<br>
&gt; &gt;&gt; lttng-dev mailing list<br>
&gt; &gt;&gt; <a href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;,=
 &#39;lttng-dev@lists.lttng.org&#39;)">lttng-dev@lists.lttng.org</a><br>
&gt; &gt;&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lt=
tng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/=
lttng-dev</a><br>
<br>
<br>
<br>
<br>
--<br>
Mathieu Desnoyers<br>
Operating System Efficiency R&amp;D Consultant<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</blockquote></div>

--14dae9399d2b99720a04d060fcfd--


--===============0732893119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0732893119==--
