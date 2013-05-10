From: "Brosseau, Yannick" <yannick.brosseau@gmail.com>
Subject: Re: [PATCH userspace-rcu] use a filled signal mask to
 disable all signals
Date: Fri, 10 May 2013 07:57:25 -0400
Message-ID: <CAEzWAeJToVnojuAqAOg8BV3kLekgcw2apOycHQf6M7m26OJueA__34188.0093598322$1368187087$gmane$org@mail.gmail.com>
References: <29C931202891DE4ABE913168E7AC43EC014227E029@ONWVEXCHMB01.ciena.com>
	<20130510113802.GA15131@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1745381336=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1Ualx5-0005NJ-6v
	for lttng-dev@lists.lttng.org; Fri, 10 May 2013 07:57:31 -0400
Received: by mail-vc0-f177.google.com with SMTP id ha12so3555578vcb.22
	for <lttng-dev@lists.lttng.org>; Fri, 10 May 2013 04:57:25 -0700 (PDT)
In-Reply-To: <20130510113802.GA15131@Krystal>
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

--===============1745381336==
Content-Type: multipart/alternative; boundary=bcaec501609bd85bb204dc5bde58

--bcaec501609bd85bb204dc5bde58
Content-Type: text/plain; charset=ISO-8859-1

On Fri, May 10, 2013 at 7:38 AM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Hi Dave,
>
> Nice catch ! I've reworked the patch to also fix compat_arch_x86.c and
> use SIG_BLOCK at those sites (details in changelog). Here is the version
> I plan to merge into userspace rcu. Thanks for spotting this!
>
> Mathieu
>
> commit 6ed4b2e64c6cef5d6d1a1c1943f29dbf4edf026a
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Fri May 10 07:30:18 2013 -0400
>     Updates by Mathieu Desnoyers:
>
>     - Use SIG_BLOCK instead of SIG_SETMASK when setting a filled mask. This
>       has the same behavior in this case (since we're blocking all
> signals),
>       but is semantically neater: if we ever some signals from that mask,
>

if we ever what? Looks like a missing word in this changelog.


>       we'd like to to a union with the signal mask already blocked by the
>       application.
>     - Also fix incorrect signal masking in compat_arch_x86.c.
>
>     Reported-by: David Pelton <dpelton@ciena.com>
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

--bcaec501609bd85bb204dc5bde58
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Fri, May 10, 2013 at 7:38 AM, Mathieu Desnoyers <span dir=3D"ltr=
">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">m=
athieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Dave,<br>
<br>
Nice catch ! I&#39;ve reworked the patch to also fix compat_arch_x86.c and<=
br>
use SIG_BLOCK at those sites (details in changelog). Here is the version<br=
>
I plan to merge into userspace rcu. Thanks for spotting this!<br>
<br>
Mathieu<br>
<br>
commit 6ed4b2e64c6cef5d6d1a1c1943f29dbf4edf026a<br>
Author: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.=
com">mathieu.desnoyers@efficios.com</a>&gt;<br>
Date: =A0 Fri May 10 07:30:18 2013 -0400<br>
=A0 =A0 Updates by Mathieu Desnoyers:<br>
<br>
=A0 =A0 - Use SIG_BLOCK instead of SIG_SETMASK when setting a filled mask. =
This<br>
=A0 =A0 =A0 has the same behavior in this case (since we&#39;re blocking al=
l signals),<br>
=A0 =A0 =A0 but is semantically neater: if we ever some signals from that m=
ask,<br></blockquote><div><br></div><div>if we ever what? Looks like a miss=
ing word in this changelog. <br></div><div>=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">

=A0 =A0 =A0 we&#39;d like to to a union with the signal mask already blocke=
d by the<br>
=A0 =A0 =A0 application.<br>
=A0 =A0 - Also fix incorrect signal masking in compat_arch_x86.c.<br>
<br>
=A0 =A0 Reported-by: David Pelton &lt;<a href=3D"mailto:dpelton@ciena.com">=
dpelton@ciena.com</a>&gt;<br>
=A0 =A0 Signed-off-by: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desn=
oyers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt;</blockquote></di=
v></div></div>

--bcaec501609bd85bb204dc5bde58--


--===============1745381336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1745381336==--
