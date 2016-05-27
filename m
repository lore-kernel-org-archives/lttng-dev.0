From: John Smith <whalajam@gmail.com>
Subject: "lttng enable-channel --tracefile-size" bug
Date: Fri, 27 May 2016 15:11:11 -0700
Message-ID: <CANgVouVswhgXmy=Dge5h2FA-7xsaJfDqOZ3=seG5dHjP=_4gmA__5525.05359887636$1464387861$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4499940287267387263=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 5B604A36D8
 for <lttng-dev@lists.lttng.org>; Fri, 27 May 2016 22:11:12 +0000 (UTC)
Received: by mail-oi0-f68.google.com with SMTP id r64so14165192oie.1
 for <lttng-dev@lists.lttng.org>; Fri, 27 May 2016 15:11:12 -0700 (PDT)
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

--===============4499940287267387263==
Content-Type: multipart/alternative; boundary=001a11358a362fe70f0533da2f19

--001a11358a362fe70f0533da2f19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,
it looks like for the "enable-channel" command, "tracefile-size" option
doesn't take effect, bellow are all the options, the resulted files have
the actual size the same as the size specified by subbuf-size option:

# lttng -V
lttng (LTTng Trace Control) 2.7.1 - Herbe =C3=A0 D=C3=A9tourne

$ lttng enable-channel chan_name -u -s session_name --discard --num-subbuf
8
            --subbuf-size 32M --tracefile-size 8K --tracefile-count 8
--buffers-pid

thanks, John

--001a11358a362fe70f0533da2f19
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,</div><div>it looks like for the &quot;enable=
-channel&quot; command, &quot;tracefile-size&quot; option doesn&#39;t take =
effect, bellow are all the options, the resulted files have the actual size=
 the same as the size specified by subbuf-size option:</div><div>=C2=A0</di=
v><div># lttng -V</div><div>lttng (LTTng Trace Control) 2.7.1 - Herbe =C3=
=A0 D=C3=A9tourne</div></div><div><br></div>$ lttng enable-channel chan_nam=
e -u -s session_name --discard --num-subbuf 8=C2=A0<div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 --subbuf-size 32M --tracefile-size 8K --tracefile-=
count 8 --buffers-pid</div><div><br></div><div>thanks, John</div></div>

--001a11358a362fe70f0533da2f19--

--===============4499940287267387263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4499940287267387263==--
