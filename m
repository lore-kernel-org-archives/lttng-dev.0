From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: LTTng Time Stamp Issue
Date: Fri, 20 Apr 2018 11:37:23 -0400
Message-ID: <CA+jJMxvKyCt4VZ6U0gLu1KGA3S==CPTkTTGErOfXgBgms68xRg__48364.6617540673$1524238552$gmane$org@mail.gmail.com>
References: <BY2PR0501MB21035DCCC28AFAD0D12C0587E3B40@BY2PR0501MB2103.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4303726100677397844=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-x231.google.com (mail-lf0-x231.google.com
 [IPv6:2a00:1450:4010:c07::231])
 by lists.lttng.org (Postfix) with ESMTPS id 40SKk3025rz14Ny
 for <lttng-dev@lists.lttng.org>; Fri, 20 Apr 2018 11:37:46 -0400 (EDT)
Received: by mail-lf0-x231.google.com with SMTP id o123-v6so3181328lfe.8
 for <lttng-dev@lists.lttng.org>; Fri, 20 Apr 2018 08:37:46 -0700 (PDT)
In-Reply-To: <BY2PR0501MB21035DCCC28AFAD0D12C0587E3B40@BY2PR0501MB2103.namprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Sai Tujala <Sai.Tujala@mathworks.in>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4303726100677397844==
Content-Type: multipart/alternative; boundary="883d24f2195c26d4ab056a49788e"

--883d24f2195c26d4ab056a49788e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm adding the LTTng mailing list in CC for the benefit of the community
and so people add to or correct my explanation.

The CTF specification describes the meaning of those fields:
http://diamon.org/ctf/#spec8

In your case, this means that the timestamps in the trace are expressed
relative to an arbitrary time set 1524226572435601778 clock ticks after
00:00:00 on 1 January 1970.

To take your specific example:
Your clock is running at 1,000,000,000 Hz, meaning the duration of a clock
tick (period) is of 1 ns.

The event has occurred at
1524226572435601778 (offset) + 00000003827855360941 (event clock value)
nanoseconds after UNIX Epoch. That leads us to around Friday, April 20,
2018 1:20:00 PM (GMT).

Regards,
J=C3=A9r=C3=A9mie



On 20 April 2018 at 11:06, Sai Tujala <Sai.Tujala@mathworks.in> wrote:

> Hi Jeremie,
>
>
>
>                 In metadata file of LTTng trace session,  offset from
> Epoch is =E2=80=9C1524226572435601778=E2=80=9D and time stamp of an event=
 in channel data
> files is starting from =E2=80=9C00000003827855360941=E2=80=9D. Can you br=
ief about
> relevance between these two time stamps.
>
>
>
> freq =3D 1000000000; /* Frequency, in Hz */
>
>         /* clock value offset from Epoch is: offset * (1/freq) */
>
>         offset =3D 1524226572435601778;
>
>
>
>
>
> Thanks & Regards,
>
> T Sai Kiran
>
>
>



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--883d24f2195c26d4ab056a49788e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div>Hi,<br><br></div><div>I&#39;=
m adding the LTTng mailing list in CC for the benefit of the community and =
so people add to or correct my explanation.<br></div><div><br>The CTF speci=
fication describes the meaning of those fields:<br><a href=3D"http://diamon=
.org/ctf/#spec8">http://diamon.org/ctf/#spec8</a><br><br></div>In your case=
, this means that the timestamps in the trace are expressed relative to an =
arbitrary time set 1524226572435601778 clock ticks after 00:00:00 on 1 Janu=
ary 1970.<br><br></div>To take your specific example:<br></div>Your clock i=
s running at 1,000,000,000 Hz, meaning the duration of a clock tick (period=
) is of 1 ns.<br><br></div>The event has occurred at<br></div>1524226572435=
601778 (offset) + 00000003827855360941 (event clock value) nanoseconds afte=
r UNIX Epoch. That leads us to around Friday, April 20, 2018 1:20:00 PM (GM=
T).<br><br></div><div>Regards,<br></div>J=C3=A9r=C3=A9mie<br><div><br><div>=
<div><div><div><br></div></div></div></div></div></div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote">On 20 April 2018 at 11:06, Sai Tujala=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:Sai.Tujala@mathworks.in" target=3D=
"_blank">Sai.Tujala@mathworks.in</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">





<div link=3D"#0563C1" vlink=3D"#954F72" lang=3D"EN-US">
<div class=3D"m_-293747052095318529WordSection1">
<p class=3D"MsoNormal">Hi Jeremie,<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 In metadata file of LTTng trace ses=
sion, =C2=A0offset from Epoch is =E2=80=9C1524226572435601778=E2=80=9D and =
time stamp of an event in channel data files is starting from =E2=80=9C0000=
0003827855360941=E2=80=9D. Can you brief about relevance between these two
 time stamps. <u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">freq =3D 1000000000; /* F=
requency, in Hz */<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* clock =
value offset from Epoch is: offset * (1/freq) */<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset =
=3D 1524226572435601778;<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Thanks &amp; Regards,<u></u><u></u></p>
<p class=3D"MsoNormal">T Sai Kiran<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
</div>

</blockquote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail_sig=
nature" data-smartmail=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>E=
fficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http:=
//www.efficios.com</a></div>
</div>

--883d24f2195c26d4ab056a49788e--

--===============4303726100677397844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4303726100677397844==--
