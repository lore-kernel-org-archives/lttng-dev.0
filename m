From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@gmail.com>
Subject: Re: lttng-tools backport request: Fix: error.h ->
	common/error.h
Date: Thu, 6 Oct 2016 08:34:58 -0400
Message-ID: <CA+jJMxtxjCwmjHHnFxWnoJawG8t+cmQtm+HVQvfWt9sG=hsWQw__43471.7908771292$1475759142$gmane$org@mail.gmail.com>
References: <4f48032d-049c-5e3a-f635-f7978a5ad783@mentor.com>
 <90905ba7-d102-c9f3-6fb3-67eb630b6558@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4222605320281407822=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-f194.google.com (mail-ua0-f194.google.com
 [209.85.217.194])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id D385AA3B0D
 for <lttng-dev@lists.lttng.org>; Thu,  6 Oct 2016 12:36:36 +0000 (UTC)
Received: by mail-ua0-f194.google.com with SMTP id 49so680626uac.0
 for <lttng-dev@lists.lttng.org>; Thu, 06 Oct 2016 05:34:59 -0700 (PDT)
In-Reply-To: <90905ba7-d102-c9f3-6fb3-67eb630b6558@mentor.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Nathan Lynch <Nathan_Lynch@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============4222605320281407822==
Content-Type: multipart/alternative; boundary=001a113cf758990931053e3185b8

--001a113cf758990931053e3185b8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I have merged the patch in 2.8.

Thanks for reporting!
J=C3=A9r=C3=A9mie

On Oct 3, 2016 4:43 PM, "Nathan Lynch" <Nathan_Lynch@mentor.com> wrote:

> On 10/03/2016 10:36 AM, Nathan Lynch wrote:
> > Can this be backported to the stable-2.8 branch?
> >
> > commit 6712db617fe9
> > Author: Michael Jeanson <mjeanson@efficios.com>
> > Date:   Wed Jun 15 17:18:03 2016 -0400
> >
> >     Fix: error.h -> common/error.h
> >
> > OE is carrying this patch for its lttng-tools 2.8 package in order to
> > build against musl libc:
> >
> > http://lists.openembedded.org/pipermail/openembedded-core/
> 2016-September/126851.html
> >
> > I haven't personally verified the problem or the patch, but it seems
> > like an obvious, low-risk fix?
>
> I've now verified that the patch is necessary for cross-compiling with a
> musl toolchain.
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--001a113cf758990931053e3185b8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I have merged the patch in 2.8.</p>
<p dir=3D"ltr">Thanks for reporting!<br>
J=C3=A9r=C3=A9mie</p>
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Oct 3, 2016 4:=
43 PM, &quot;Nathan Lynch&quot; &lt;<a href=3D"mailto:Nathan_Lynch@mentor.c=
om">Nathan_Lynch@mentor.com</a>&gt; wrote:<br type=3D"attribution"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">On 10/03/2016 10:36 AM, Nathan Lynch wrote:<br>
&gt; Can this be backported to the stable-2.8 branch?<br>
&gt;<br>
&gt; commit 6712db617fe9<br>
&gt; Author: Michael Jeanson &lt;<a href=3D"mailto:mjeanson@efficios.com">m=
jeanson@efficios.com</a>&gt;<br>
&gt; Date:=C2=A0 =C2=A0Wed Jun 15 17:18:03 2016 -0400<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Fix: error.h -&gt; common/error.h<br>
&gt;<br>
&gt; OE is carrying this patch for its lttng-tools 2.8 package in order to<=
br>
&gt; build against musl libc:<br>
&gt;<br>
&gt; <a href=3D"http://lists.openembedded.org/pipermail/openembedded-core/2=
016-September/126851.html" rel=3D"noreferrer" target=3D"_blank">http://list=
s.openembedded.org/<wbr>pipermail/openembedded-core/<wbr>2016-September/126=
851.html</a><br>
&gt;<br>
&gt; I haven&#39;t personally verified the problem or the patch, but it see=
ms<br>
&gt; like an obvious, low-risk fix?<br>
<br>
I&#39;ve now verified that the patch is necessary for cross-compiling with =
a<br>
musl toolchain.<br>
<br>
______________________________<wbr>_________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-<wbr>bin/mail=
man/listinfo/lttng-dev</a><br>
</blockquote></div></div>

--001a113cf758990931053e3185b8--

--===============4222605320281407822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4222605320281407822==--
