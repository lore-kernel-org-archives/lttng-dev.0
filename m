From: Adrien Charruel <adrien.charruel@gmail.com>
Subject: Unable to decode trace - unexpected unary expression
 for clock offset
Date: Wed, 7 Mar 2018 14:58:26 +0100
Message-ID: <CAB4MO7PKUq5YWAYB8x+3B4ergDd7NYEuXD4+2uQhoPJ=fShpWg__36524.3173241199$1520436479$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0909529627910144628=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-x22e.google.com (mail-lf0-x22e.google.com
 [IPv6:2a00:1450:4010:c07::22e])
 by lists.lttng.org (Postfix) with ESMTPS id 3zxFc93hglzqK4
 for <lttng-dev@lists.lttng.org>; Wed,  7 Mar 2018 08:58:49 -0500 (EST)
Received: by mail-lf0-x22e.google.com with SMTP id 37-v6so3358368lfs.7
 for <lttng-dev@lists.lttng.org>; Wed, 07 Mar 2018 05:58:49 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0909529627910144628==
Content-Type: multipart/alternative; boundary="94eb2c0c884c39d9620566d2f538"

--94eb2c0c884c39d9620566d2f538
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I'm running lttng on my embedded system (kernel 4.0.0).

The version of the various packages are:
* lttng-modules-2.10.5.tar.bz2
* lttng-tools-2.10.2.tar.bz2
* lttng-ust-2.10.1.tar.bz2

The trace process is OK, but upon decoding with babeltrace, I get the
following error:

> [error] ctf_clock_declaration_visit: unexpected unary expression for cloc=
k
> offset
> [error] ctf_visitor_construct_metadata: clock declaration error
> [error] Error in CTF metadata constructor -22


I found that this commit might solve the issue:

> commit 61cf588beae752e5ddfc60b6b5310f769ac9e852
> Refs: v1.2.0-439-g61cf588b
> Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> AuthorDate: Tue Feb 9 13:27:24 2016 -0500
> Commit:     J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com>
> CommitDate: Fri Feb 12 21:26:26 2016 -0500


However I use babeltrace 1.5.4-1 from debian, and I don't really wish to
recompile it by myself. It's a matter of deploying the solution for many
developpers.

Is there a way to get rid of this error?
Maybe a configuration in my embedded kernel could generate proper clocks
for tracing?

I hope there are enough information here. Thank you for any help you can
give me.

Best regards,

--=20
Adrien Charruel

--94eb2c0c884c39d9620566d2f538
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello everyone,<div><br></div><div>I&#39;m running lttng o=
n my embedded system (kernel 4.0.0).</div><div><br></div><div>The version o=
f the various packages are:</div><div>* lttng-modules-2.10.5.tar.bz2<br></d=
iv><div>* lttng-tools-2.10.2.tar.bz2<br></div><div>* lttng-ust-2.10.1.tar.b=
z2<br></div><div><br></div><div>The trace process is OK, but upon decoding =
with babeltrace, I get the following error:</div><div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">[error] ctf_clock_declaration_visit: unexpecte=
d unary expression for clock offset<br>[error] ctf_visitor_construct_metada=
ta: clock declaration error<br>[error] Error in CTF metadata constructor -2=
2</blockquote></div><div><br></div><div>I found that this commit might solv=
e the issue:</div><div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">co=
mmit 61cf588beae752e5ddfc60b6b5310f769ac9e852<br>Refs: v1.2.0-439-g61cf588b=
<br>Author:=C2=A0 =C2=A0 =C2=A0Mathieu Desnoyers &lt;<a href=3D"mailto:math=
ieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt;<br>Autho=
rDate: Tue Feb 9 13:27:24 2016 -0500<br>Commit:=C2=A0 =C2=A0 =C2=A0J=C3=A9r=
=C3=A9mie Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com">j=
eremie.galarneau@efficios.com</a>&gt;<br>CommitDate: Fri Feb 12 21:26:26 20=
16 -0500</blockquote></div><div><br></div><div>However I use babeltrace=C2=
=A01.5.4-1 from debian, and I don&#39;t really wish to recompile it by myse=
lf. It&#39;s a matter of deploying the solution for many developpers.</div>=
<div><br></div><div>Is there a way to get rid of this error?</div><div>Mayb=
e a configuration in my embedded kernel could generate proper clocks for tr=
acing?</div><div><br></div><div>I hope there are enough information here. T=
hank you for any help you can give me.</div><div><br></div><div>Best regard=
s,</div><div><br>-- <br><div class=3D"gmail-m_2622494773698372310gmail_sign=
ature">Adrien Charruel</div>
</div></div>

--94eb2c0c884c39d9620566d2f538--

--===============0909529627910144628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0909529627910144628==--
