From: Michael Steppe <msteppe91@gmail.com>
Subject: Re: CentOS 7.3 Support
Date: Wed, 7 Jun 2017 06:35:58 -0400
Message-ID: <CAN7pGttcwE7t-4xtggEMcyccohSqVzUoP6tbMXrKoKOxuf++jA__22500.2630068504$1496831783$gmane$org@mail.gmail.com>
References: <CAN7pGtvjM37=3zVt2_NaQME0ZeYq+cCp+5Mq7Gy2TTdfjii1YA@mail.gmail.com>
 <20170606185955.yqbwxcg2beslrvaa@psrcode-TP-X230>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2721465518969582399=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-x236.google.com (mail-ua0-x236.google.com
 [IPv6:2607:f8b0:400c:c08::236])
 by lists.lttng.org (Postfix) with ESMTPS id 3wjQ413zGCz11bm
 for <lttng-dev@lists.lttng.org>; Wed,  7 Jun 2017 10:37:37 +0000 (UTC)
Received: by mail-ua0-x236.google.com with SMTP id m31so3971660uam.1
 for <lttng-dev@lists.lttng.org>; Wed, 07 Jun 2017 03:35:59 -0700 (PDT)
In-Reply-To: <20170606185955.yqbwxcg2beslrvaa@psrcode-TP-X230>
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

--===============2721465518969582399==
Content-Type: multipart/alternative; boundary="001a114bf1ec4672a705515c4d0b"

--001a114bf1ec4672a705515c4d0b
Content-Type: text/plain; charset="UTF-8"

Great! Thanks Jonathan. As a quick follow up question, I am now seeing some
warnings about discarded events that I remember reading about in your
release notes somewhere. Is there a way to silence these types of warnings?

Thanks again!
Michael Steppe

On Tue, Jun 6, 2017 at 2:59 PM, Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi,
>
> On Tue, Jun 06, 2017 at 01:19:11PM -0400, Michael Steppe wrote:
> > Hello!
> >
> > I had previously built LTTng-modules 2.8.0 from source without issue on
> > CentOS 7.2 (3.10.0-327 kernel). When I tried to build on CentOS 7.3
> > (3.10.0-514 kernel), however, it failed with multiple "error: struct has
> no
> > member named 'id'" and "error: struct has no member named 'name'"
> errors. I
> > tried building LTTng-modules 2.9.2 from source on CentOS 7.3 and was
> > successful (it also built successfully on CentOS 7.2).
> >
> > I was just curious at what version of LTTng-modules did the newer kernel
> in
> > CentOS 7.3 get supported. I would like to jump as small as possible, so
> if
> > there was a version of the modules between 2.8.0 and 2.9.2 that was
> > supported that would be great.
>
> In the specific case of kernel 3.10.0-514, lttng-modules stable 2.8 is
> fixed
> starting from commit f61eb2851f482baee02bb508aef01f67fdb3fbaf (stable 2.8
> branch) and 5f9ff4e230753160ccfc300d44004b117cf678ad (master branch):
>
> -----------
> commit f61eb2851f482baee02bb508aef01f67fdb3fbaf
> Author: Michael Jeanson <mjeanson@efficios.com>
> Date:   Wed Dec 7 14:17:33 2016 -0500
>
>     Fix: asoc instrumentation for RHEL 7.3
>
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> -----------
>
> Hence you can upgrade lttng-modules to any tag greater or equal to v2.8.4.
>
> If you can't upgrade to the 2.9.x stable release the v2.8.5 tag is
> your best bet.
>
> Cheers
>
> >
> > Thanks!
> > Michael Steppe
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--001a114bf1ec4672a705515c4d0b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Great! Thanks Jonathan. As a quick follow up question=
, I am now seeing some warnings about discarded events that I remember read=
ing about in your release notes somewhere. Is there a way to silence these =
types of warnings?</div><div><br></div><div>Thanks again!</div><div>Michael=
 Steppe</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote=
">On Tue, Jun 6, 2017 at 2:59 PM, Jonathan Rajotte-Julien <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com" target=3D"_bla=
nk">jonathan.rajotte-julien@efficios.com</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">Hi,<br>
<span><br>
On Tue, Jun 06, 2017 at 01:19:11PM -0400, Michael Steppe wrote:<br>
&gt; Hello!<br>
&gt;<br>
&gt; I had previously built LTTng-modules 2.8.0 from source without issue o=
n<br>
&gt; CentOS 7.2 (3.10.0-327 kernel). When I tried to build on CentOS 7.3<br=
>
&gt; (3.10.0-514 kernel), however, it failed with multiple &quot;error: str=
uct has no<br>
&gt; member named &#39;id&#39;&quot; and &quot;error: struct has no member =
named &#39;name&#39;&quot; errors. I<br>
&gt; tried building LTTng-modules 2.9.2 from source on CentOS 7.3 and was<b=
r>
&gt; successful (it also built successfully on CentOS 7.2).<br>
&gt;<br>
&gt; I was just curious at what version of LTTng-modules did the newer kern=
el in<br>
&gt; CentOS 7.3 get supported. I would like to jump as small as possible, s=
o if<br>
&gt; there was a version of the modules between 2.8.0 and 2.9.2 that was<br=
>
&gt; supported that would be great.<br>
<br>
</span>In the specific case of kernel <a href=3D"tel:3.10.0-514" value=3D"+=
13100514">3.10.0-514</a>, lttng-modules stable 2.8 is fixed<br>
starting from commit f61eb2851f482baee02bb508aef01f<wbr>67fdb3fbaf (stable =
2.8<br>
branch) and 5f9ff4e230753160ccfc300d44004b<wbr>117cf678ad (master branch):<=
br>
<br>
-----------<br>
commit f61eb2851f482baee02bb508aef01f<wbr>67fdb3fbaf<br>
Author: Michael Jeanson &lt;<a href=3D"mailto:mjeanson@efficios.com">mjeans=
on@efficios.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Wed Dec 7 14:17:33 2016 -0500<br>
<br>
=C2=A0 =C2=A0 Fix: asoc instrumentation for RHEL 7.3<br>
<br>
Signed-off-by: Michael Jeanson &lt;<a href=3D"mailto:mjeanson@efficios.com"=
>mjeanson@efficios.com</a>&gt;<br>
Signed-off-by: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@ef=
ficios.com">mathieu.desnoyers@efficios.<wbr>com</a>&gt;<br>
-----------<br>
<br>
Hence you can upgrade lttng-modules to any tag greater or equal to v2.8.4.<=
br>
<br>
If you can&#39;t upgrade to the 2.9.x stable release the v2.8.5 tag is<br>
your best bet.<br>
<br>
Cheers<br>
<br>
&gt;<br>
&gt; Thanks!<br>
&gt; Michael Steppe<br>
<br>
&gt; ______________________________<wbr>_________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 target=3D"_blank" rel=3D"noreferrer">https://lists.lttng.org/cgi-<wbr>bin/=
mailman/listinfo/lttng-dev</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</font></span></blockquote></div><br></div>

--001a114bf1ec4672a705515c4d0b--

--===============2721465518969582399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2721465518969582399==--
