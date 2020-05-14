From: Abhinav Ranjan via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Need Help In trace generation for malloc(),
 free() calls etc
Date: Thu, 14 May 2020 10:55:32 +0530
Message-ID: <CAPC3er=7+wOR8CdtdU+PGGOgWLWMBy55jAR5jZzyzZr67mQuCA@mail.gmail.com>
References: <CAPC3ern8bkAJDnOwoYh2Om44Q2GWAPsh140FW_aPGVkdUmCwkw@mail.gmail.com>
 <CAPC3erkxTh9dSgahym7xsCjJXOV3D+kto-=UB-ApjSUOWYZVeA@mail.gmail.com>
 <20200513153312.GA2381108@joraj-alpa>
 <CAPC3erkfapoZu_WM=znEyj0ch1YiKeX7-JBiauoLh+Seee0TZA@mail.gmail.com>
 <20200513180404.GB2381108@joraj-alpa>
Reply-To: Abhinav Ranjan <abhi.abhinav240@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8772839595592032461=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 by lists.lttng.org (Postfix) with ESMTPS id 49N0PN64s1z22gX
 for <lttng-dev@lists.lttng.org>; Thu, 14 May 2020 01:25:44 -0400 (EDT)
Received: by mail-io1-xd33.google.com with SMTP id f4so1516626iov.11
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 22:25:44 -0700 (PDT)
In-Reply-To: <20200513180404.GB2381108@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============8772839595592032461==
Content-Type: multipart/alternative; boundary="0000000000009c1ac205a594ed2b"

--0000000000009c1ac205a594ed2b
Content-Type: text/plain; charset="UTF-8"

Thank You Sir,
I am sorry for the inconvenience caused to you!
Surely I'll take care of every suggestion you passed on to me.

Once again I thank you for your wonderful help!

Stay Safe and Happy!!!



On Wed, 13 May 2020 at 23:34, Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi Abhinav,
>
> Please keep the mailing list in CC for all communication:
> lttng-dev@lists.lttng.org
>
> If not, I am not interested in helping you further.
>
> On Wed, May 13, 2020 at 09:26:52PM +0530, Abhinav Ranjan wrote:
> > Hi! Jonathan thank you so much for your help and reply! Sure I'll not use
> > snapshot from next time and follow your advice.
> > In fact I figured out the issue, but Jonathan I have one specific doubt I
> > wanted to trace malloc , free call from my app only  but after using
> lttng
> > enable-event --userspace lttng_ust_libc:malloc I am seeing several
> malloc (
> > in Trace Compass)   probably from different tracepoints from
> lttng_ust_libc.
>
> You will see all malloc that the app does for its lifetime since you
> LD_PRELOAD
> the wrapper including any allocation lttng-ust does. Keep in mind that
> lttng-ust
> is not magic, lttng-ust spun threads and do some allocations to do its job.
>
> What outcome do you expect? We might be able to at least get you on the
> right
> path. In other word, what is your end goal?
>
> Cheers
>
>

-- 
Thanking You!

Regards,
Abhinav

--0000000000009c1ac205a594ed2b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Thank You Sir,<div>I am sorry for the inc=
onvenience caused to you!=C2=A0</div><div>Surely I&#39;ll take care of ever=
y suggestion you passed on to me.</div><div><br></div><div>Once again I tha=
nk you for your wonderful help!</div><div><br></div><div>Stay Safe and=C2=
=A0Happy!!!</div><div><br></div><div><br></div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 13 May 2020 at 23:34=
, Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jonathan.rajotte-julien@eff=
icios.com">jonathan.rajotte-julien@efficios.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Hi Abhinav,<br>
<br>
Please keep the mailing list in CC for all communication: <a href=3D"mailto=
:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>=
<br>
<br>
If not, I am not interested in helping you further.<br>
<br>
On Wed, May 13, 2020 at 09:26:52PM +0530, Abhinav Ranjan wrote:<br>
&gt; Hi! Jonathan thank you so much for your help and reply! Sure I&#39;ll =
not use<br>
&gt; snapshot from next time and follow your advice.<br>
&gt; In fact I figured out the issue, but Jonathan I have one specific doub=
t I<br>
&gt; wanted to trace malloc , free call from my app only=C2=A0 but after us=
ing lttng<br>
&gt; enable-event --userspace lttng_ust_libc:malloc I am seeing several mal=
loc (<br>
&gt; in Trace Compass)=C2=A0 =C2=A0probably from different tracepoints from=
 lttng_ust_libc.<br>
<br>
You will see all malloc that the app does for its lifetime since you LD_PRE=
LOAD<br>
the wrapper including any allocation lttng-ust does. Keep in mind that lttn=
g-ust<br>
is not magic, lttng-ust spun threads and do some allocations to do its job.=
<br>
<br>
What outcome do you expect? We might be able to at least get you on the rig=
ht<br>
path. In other word, what is your end goal?<br>
<br>
Cheers<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div=
 dir=3D"ltr"><div>Thanking You!</div><div><br></div><div>Regards,<br></div>=
<div>Abhinav<br></div><div><br></div></div></div></div></div></div></div></=
div>

--0000000000009c1ac205a594ed2b--

--===============8772839595592032461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8772839595592032461==--
