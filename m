From: Lai Jiangshan <eag0628@gmail.com>
Subject: Re: [PATCH 1/3] urcu: avoid "expression result unused"
 from clang
Date: Sat, 8 Dec 2012 01:27:27 +0800
Message-ID: <CACvQF53+x_PDd+aOtM0k2wN0BJZXRMkB3pjXxfvsV=HkdknM=Q__18505.4909823977$1354901302$gmane$org@mail.gmail.com>
References: <1354872295-32371-1-git-send-email-laijs@cn.fujitsu.com>
	<20121207165848.GB12338@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1386670246=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <eag0628@gmail.com>) id 1Th1i1-0003Mx-KG
	for lttng-dev@lists.lttng.org; Fri, 07 Dec 2012 12:27:33 -0500
Received: by mail-ob0-f176.google.com with SMTP id un3so715369obb.35
	for <lttng-dev@lists.lttng.org>; Fri, 07 Dec 2012 09:27:27 -0800 (PST)
In-Reply-To: <20121207165848.GB12338@Krystal>
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

--===============1386670246==
Content-Type: multipart/alternative; boundary=e89a8ff1c6ca93779d04d0468759

--e89a8ff1c6ca93779d04d0468759
Content-Type: text/plain; charset=ISO-8859-1

On Saturday, December 8, 2012, Mathieu Desnoyers wrote:

> * Lai Jiangshan (laijs@cn.fujitsu.com <javascript:;>) wrote:
> > The last expression result is unused and clang will complain.
> > The trick in the patch supresses the complaint
>
> Hrm, but with this patch, gcc complains:
>
> rculfhash.c:1921:3: warning: variable '_w' set but not used
> [-Wunused-but-set-variable]
>
> using
>
> gcc version 4.7.2 (Debian 4.7.2-4)


Ouch, my gcc is too old



>
> Thoughts ?
>
> Thanks,
>
> Mathieu
>
> >
> > Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com <javascript:;>>
> > ---
> >  urcu/system.h        |    5 ++++-
> >  2 files changed, 4 insertions(+), 1 deletions(-)
> >
> > diff --git a/urcu/system.h b/urcu/system.h
> > index 2a45f22..6b7b0af 100644
> > --- a/urcu/system.h
> > +++ b/urcu/system.h
> > @@ -46,12 +46,15 @@
> >  /*
> >   * Store v into x, where x is located in shared memory. Performs the
> >   * required cache flush after writing. Returns v.
> > + * "_w" here avoids the warning from clang:
> > + *   warning: expression result unused [-Wunused-value]
> >   */
> >  #define CMM_STORE_SHARED(x, v)               \
> >       ({                              \
> >               __typeof__(x) _v = _CMM_STORE_SHARED(x, v);     \
> > +             __typeof__(x) _w;       \
> >               cmm_smp_wmc();          \
> > -             _v;                     \
> > +             _w = _v;                \
> >       })
> >
> >  #endif /* _URCU_SYSTEM_H */
> > --
> > 1.7.4.4
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org <javascript:;>
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org <javascript:;>
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--e89a8ff1c6ca93779d04d0468759
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, December 8, 2012, Mathieu Desnoyers  wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">* Lai Jiangshan (<a href=3D"javascript:;" onclick=
=3D"_e(event, &#39;cvml&#39;, &#39;laijs@cn.fujitsu.com&#39;)">laijs@cn.fuj=
itsu.com</a>) wrote:<br>

&gt; The last expression result is unused and clang will complain.<br>
&gt; The trick in the patch supresses the complaint<br>
<br>
Hrm, but with this patch, gcc complains:<br>
<br>
rculfhash.c:1921:3: warning: variable &#39;_w&#39; set but not used<br>
[-Wunused-but-set-variable]<br>
<br>
using<br>
<br>
gcc version 4.7.2 (Debian 4.7.2-4)</blockquote><div><br></div><div>Ouch, my=
 gcc is too old<span></span></div><br><div>=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">

<br>
Thoughts ?<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
&gt;<br>
&gt; Signed-off-by: Lai Jiangshan &lt;<a href=3D"javascript:;" onclick=3D"_=
e(event, &#39;cvml&#39;, &#39;laijs@cn.fujitsu.com&#39;)">laijs@cn.fujitsu.=
com</a>&gt;<br>
&gt; ---<br>
&gt; =A0urcu/system.h =A0 =A0 =A0 =A0| =A0 =A05 ++++-<br>
&gt; =A02 files changed, 4 insertions(+), 1 deletions(-)<br>
&gt;<br>
&gt; diff --git a/urcu/system.h b/urcu/system.h<br>
&gt; index 2a45f22..6b7b0af 100644<br>
&gt; --- a/urcu/system.h<br>
&gt; +++ b/urcu/system.h<br>
&gt; @@ -46,12 +46,15 @@<br>
&gt; =A0/*<br>
&gt; =A0 * Store v into x, where x is located in shared memory. Performs th=
e<br>
&gt; =A0 * required cache flush after writing. Returns v.<br>
&gt; + * &quot;_w&quot; here avoids the warning from clang:<br>
&gt; + * =A0 warning: expression result unused [-Wunused-value]<br>
&gt; =A0 */<br>
&gt; =A0#define CMM_STORE_SHARED(x, v) =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
&gt; =A0 =A0 =A0 ({ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0\<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 __typeof__(x) _v =3D _CMM_STORE_SHARED(x, =
v); =A0 =A0 \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 __typeof__(x) _w; =A0 =A0 =A0 \<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmm_smp_wmc(); =A0 =A0 =A0 =A0 =A0\<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 _v; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
\<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 _w =3D _v; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<=
br>
&gt; =A0 =A0 =A0 })<br>
&gt;<br>
&gt; =A0#endif /* _URCU_SYSTEM_H */<br>
&gt; --<br>
&gt; 1.7.4.4<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;ltt=
ng-dev@lists.lttng.org&#39;)">lttng-dev@lists.lttng.org</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
<br>
<br>
--<br>
Mathieu Desnoyers<br>
Operating System Efficiency R&amp;D Consultant<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;lttng-de=
v@lists.lttng.org&#39;)">lttng-dev@lists.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</blockquote>

--e89a8ff1c6ca93779d04d0468759--


--===============1386670246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1386670246==--
