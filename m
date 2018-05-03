From: Anders Wallin <wallinux@gmail.com>
Subject: Re: lttng-tools 2.10.4 broken when auto loading session
Date: Thu, 03 May 2018 13:23:08 +0000
Message-ID: <CAF2baFdhPU0MU8QsuC3TnFySTtKJK3tYd-Xs7UDoD1HDSbK91Q__38903.7499241114$1525353682$gmane$org@mail.gmail.com>
References: <CAF2baFdqgzUQyfDn6gi8-+SvDYy058EzMkG8k3a5gnA1Df7tnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2570985329985982456=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ot0-x232.google.com (mail-ot0-x232.google.com
 [IPv6:2607:f8b0:4003:c0f::232])
 by lists.lttng.org (Postfix) with ESMTPS id 40cG6w3d52z17JG
 for <lttng-dev@lists.lttng.org>; Thu,  3 May 2018 09:23:20 -0400 (EDT)
Received: by mail-ot0-x232.google.com with SMTP id g7-v6so20569357otj.11
 for <lttng-dev@lists.lttng.org>; Thu, 03 May 2018 06:23:20 -0700 (PDT)
In-Reply-To: <CAF2baFdqgzUQyfDn6gi8-+SvDYy058EzMkG8k3a5gnA1Df7tnw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2570985329985982456==
Content-Type: multipart/alternative; boundary="0000000000005b7940056b4d1b2f"

--0000000000005b7940056b4d1b2f
Content-Type: text/plain; charset="UTF-8"

25258405ed9590fcbcfb02c10dd8c018dba3a7bd introduced the bug

tors 3 maj 2018 kl 14:27 skrev Anders Wallin <wallinux@gmail.com>:

> Hi,
>
> lttng-tools hangs when a session is stored /etc/lttng/session/auto/
>
> $ head -10 /etc/lttng/sessions/auto/test.lttng
> <?xml version="1.0" encoding="UTF-8"?>
> <sessions>
>         <session>
>                 <name>test</name>
>                 <domains>
>                         <domain>
>                                 <type>UST</type>
>                                 <buffer_type>PER_UID</buffer_type>
>                                 <channels>
>                                         <channel>
> $ lttng-sessiond -d  # Hanging forever
>
> I will continue investigate why, but I though you wanna know ASAP
>
> Regards
> Anders Wallin
>
>

--0000000000005b7940056b4d1b2f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">25258405ed9590fcbcfb02c10dd8c018dba3a7bd introduced the bu=
g<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">tors 3 maj 2018 =
kl 14:27 skrev Anders Wallin &lt;<a href=3D"mailto:wallinux@gmail.com">wall=
inux@gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D=
"ltr">Hi,<div><br></div><div>lttng-tools hangs when a session is stored /et=
c/lttng/session/auto/<br><div><br></div><div>$ head -10 /etc/lttng/sessions=
/auto/test.lttng=C2=A0</div><div>&lt;?xml version=3D&quot;1.0&quot; encodin=
g=3D&quot;UTF-8&quot;?&gt;</div><div>&lt;sessions&gt;</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &lt;session&gt;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &lt;name&gt;test&lt;/name&gt;</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;domains&gt;</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &lt;domain&gt;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;t=
ype&gt;UST&lt;/type&gt;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;=
buffer_type&gt;PER_UID&lt;/buffer_type&gt;</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &lt;channels&gt;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;channel&gt;</div><div>$ lttng-se=
ssiond -d=C2=A0 # Hanging forever<br><br>I will continue investigate why, b=
ut I though you wanna know ASAP<br><br>Regards</div></div></div><div dir=3D=
"ltr"><div>Anders Wallin</div><div><br></div></div></blockquote></div>

--0000000000005b7940056b4d1b2f--

--===============2570985329985982456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2570985329985982456==--
