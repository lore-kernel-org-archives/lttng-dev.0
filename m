From: jagadeesh konakalla <kjagadeesh27@gmail.com>
Subject: Regarding lttng ust trace-point usage
Date: Tue, 14 Aug 2018 17:36:26 +0530
Message-ID: <CAEQd43P0u=ikq=OKOjO0fC1vhwFEmvH0fEBRENzCbPLx8aP0eA__14133.5355387584$1534263226$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8809567987577473309=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by lists.lttng.org (Postfix) with ESMTPS id 41qWXh1rhFz14fY
 for <lttng-dev@lists.lttng.org>; Tue, 14 Aug 2018 08:06:28 -0400 (EDT)
Received: by mail-ed1-x52f.google.com with SMTP id e6-v6so9997704edr.2
 for <lttng-dev@lists.lttng.org>; Tue, 14 Aug 2018 05:06:27 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: mathieu.desnoyers@efficios.com, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============8809567987577473309==
Content-Type: multipart/alternative; boundary="0000000000001484e00573640a3d"

--0000000000001484e00573640a3d
Content-Type: text/plain; charset="UTF-8"

Hi Mathieu,

This is Jagadeesh. I am user of lttng tools.

I have one query regarding the lttng ust usage.

I have written my linux application which has trace point API's to trace
the user application.
My requirement is to do both kernel domain trace and user domain trace for
my application.

When i start the lttng and then run my application, i do not see any
issues. I mean to say that i get all the user trace events and kernel
events.

If i start the application, then i configure and start the lttng, i see
some user events are not captured at the start (may be dropped). I have
observed that there is a delay in the first kernel event occurrence to
first user event occurrence. I have not seen this behavior if i start the
lttng and run my application.

Here is my question : Is this the expected behavior ?
or
Are there any settings that can help me to resolve this issue ?

Version of lttng used :
lttng-tools (2.9.4)
lttng-modules (2.9.1)
lttng-libust (2.9.0 )

I appreciate your help. Please let me know if you need more information.

With regards,
Jagadeesh K.

--0000000000001484e00573640a3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Mathieu,<div><br></div><div>This is Jagadeesh. I am use=
r of lttng tools.<br><div><br></div><div>I have one query regarding the ltt=
ng ust usage.</div><div><br></div><div>I have written my linux application =
which has trace point API&#39;s to trace the user application.=C2=A0</div><=
div>My requirement is to do both kernel domain trace and user domain trace =
for my application.=C2=A0</div><div><br></div><div>When i start the lttng a=
nd then run my application, i do not see any issues. I mean to say that i g=
et all the user trace events and kernel events.</div><div><br></div><div>If=
 i start the application, then i configure and start the lttng, i see some =
user events are not captured at the start (may be dropped). I have observed=
 that there is a delay in the first kernel event occurrence to first user e=
vent occurrence. I have not seen this behavior if i start the lttng and run=
 my application.=C2=A0</div><div><br></div><div>Here is my question : Is th=
is the expected behavior ?=C2=A0</div><div>or=C2=A0</div><div>Are there any=
 settings that can help me to resolve this issue ?</div><div><br></div><div=
>Version of lttng used :=C2=A0</div><div>lttng-tools (2.9.4)</div></div><di=
v>lttng-modules (2.9.1)</div><div>lttng-libust (2.9.0 )</div><div><br></div=
><div>I appreciate your help. Please let me know if you need more informati=
on.</div><div><br></div><div>With regards,</div><div>Jagadeesh K.</div></di=
v>

--0000000000001484e00573640a3d--

--===============8809567987577473309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8809567987577473309==--
