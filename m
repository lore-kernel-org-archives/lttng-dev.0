From: Ravindra Kumar Meena <rmeena840@gmail.com>
Subject: How to read multiple stream file via babeltrace?
Date: Thu, 4 Jul 2019 22:17:06 +0530
Message-ID: <CAEWVvOSCySxpcKw3dmmmW03Sbk1aT-+C3ZR5-LuKgt5w92pkYw__38390.7260069222$1562258888$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5990628770914289309=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by lists.lttng.org (Postfix) with ESMTPS id 45fkRj0tscz10SV
 for <lttng-dev@lists.lttng.org>; Thu,  4 Jul 2019 12:47:43 -0400 (EDT)
Received: by mail-wm1-x333.google.com with SMTP id h19so5688699wme.0
 for <lttng-dev@lists.lttng.org>; Thu, 04 Jul 2019 09:47:43 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5990628770914289309==
Content-Type: multipart/alternative; boundary="000000000000876ee7058cddbc8a"

--000000000000876ee7058cddbc8a
Content-Type: text/plain; charset="UTF-8"

Hi,

I have 32 binary trace files. Each file belongs to a particular CPU.

How to tell the consumer(e.g babeltrace) via metadata that the following
files belong to this particular CPU?

Thanks

-- 
*Ravindra Kumar Meena*,
B. Tech. Computer Science and Engineering,
Indian Institute of Technology (Indian School of Mines)
<https://www.iitism.ac.in/>, Dhanbad

--000000000000876ee7058cddbc8a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I have 32 binary trace files. Each =
file belongs to a particular CPU.=C2=A0</div><div><br></div><div>How to tel=
l the consumer(e.g babeltrace) via metadata that the following files belong=
 to this particular CPU?</div><div><br></div><div>Thanks<br clear=3D"all"><=
div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-smartm=
ail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><font size=
=3D"4"><b>Ravindra Kumar Meena</b></font>,<div><span style=3D"color:rgb(102=
,102,102)">B. Tech. Computer Science and Engineering,<br></span></div><div>=
<span style=3D"color:rgb(102,102,102)"><a href=3D"https://www.iitism.ac.in/=
" style=3D"color:rgb(17,85,204)" target=3D"_blank">Indian Institute of Tech=
nology (Indian School of Mines)</a>, Dhanbad</span></div></div></div></div>=
</div></div></div>

--000000000000876ee7058cddbc8a--

--===============5990628770914289309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5990628770914289309==--
