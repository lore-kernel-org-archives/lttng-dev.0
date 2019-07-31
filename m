From: Ravindra Kumar Meena <rmeena840@gmail.com>
Subject: Re: What is _prev_state in sched_switch?
Date: Wed, 31 Jul 2019 12:18:21 +0530
Message-ID: <CAEWVvOQ0SwAyC+BE7x07MpUZdiXZS=2v99ZvMUp_sFu9ahvYZA__1447.68245970539$1564555755$gmane$org@mail.gmail.com>
References: <CAEWVvOS48D3Jfp4==qrrODzdSSjo+-UOuvZyya1O_f2t9B9Z1A@mail.gmail.com>
 <0e850b02-3fec-a335-3f37-8579ad1b704d@gydle.com>
 <CAEWVvOSu4vbiDpMCCTHdP59xNaMsAJ74orA52amRaFfoN7jfXQ@mail.gmail.com>
 <18d63d8c-da2d-54c3-3a9a-1d77a5a3a675@gydle.com>
 <CAEWVvORgCQW8ScJZctu7dzT3QaO0PY50qmR-Aov9YHV1GkB+JQ@mail.gmail.com>
 <aa931b19-0a14-8659-aa9a-13e7f6523465@gydle.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6850364926195745459=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by lists.lttng.org (Postfix) with ESMTPS id 45z3tN1zG6z1H0T
 for <lttng-dev@lists.lttng.org>; Wed, 31 Jul 2019 02:49:00 -0400 (EDT)
Received: by mail-wm1-x329.google.com with SMTP id f17so58701706wme.2
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jul 2019 23:49:00 -0700 (PDT)
In-Reply-To: <aa931b19-0a14-8659-aa9a-13e7f6523465@gydle.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Sebastien Boisvert <sboisvert@gydle.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6850364926195745459==
Content-Type: multipart/alternative; boundary="0000000000000a0390058ef485f0"

--0000000000000a0390058ef485f0
Content-Type: text/plain; charset="UTF-8"

>
> Christophe explained, the values of _prev_state.
>
> In addition, I suggest you read those links (from general to specific):
>
> - https://en.wikipedia.org/wiki/Finite-state_machine
> - https://en.wikipedia.org/wiki/Scheduling_(computing)
> - https://www.kernel.org/doc/Documentation/scheduler/sched-design-CFS.txt


Thanks, Christophe and Sebastien for helping me out. This resolved
the problem.


-- 
*Ravindra Kumar Meena*,
B. Tech. Computer Science and Engineering,
Indian Institute of Technology (Indian School of Mines)
<https://www.iitism.ac.in/>, Dhanbad

--0000000000000a0390058ef485f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Christophe explained, the values of _prev_state.<br>
<br>
In addition, I suggest you read those links (from general to specific):<br>
<br>
- <a href=3D"https://en.wikipedia.org/wiki/Finite-state_machine" rel=3D"nor=
eferrer" target=3D"_blank">https://en.wikipedia.org/wiki/Finite-state_machi=
ne</a><br>
- <a href=3D"https://en.wikipedia.org/wiki/Scheduling_(computing)" rel=3D"n=
oreferrer" target=3D"_blank">https://en.wikipedia.org/wiki/Scheduling_(comp=
uting)</a><br>
- <a href=3D"https://www.kernel.org/doc/Documentation/scheduler/sched-desig=
n-CFS.txt" rel=3D"noreferrer" target=3D"_blank">https://www.kernel.org/doc/=
Documentation/scheduler/sched-design-CFS.txt</a></blockquote><div><br></div=
><div>Thanks, Christophe and Sebastien for helping me out. This resolved th=
e=C2=A0problem.</div></div><br clear=3D"all"><div><br></div>-- <br><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><=
font size=3D"4"><b>Ravindra Kumar Meena</b></font>,<div><span style=3D"colo=
r:rgb(102,102,102)">B. Tech. Computer Science and Engineering,<br></span></=
div><div><span style=3D"color:rgb(102,102,102)"><a href=3D"https://www.iiti=
sm.ac.in/" style=3D"color:rgb(17,85,204)" target=3D"_blank">Indian Institut=
e of Technology (Indian School of Mines)</a>, Dhanbad</span></div></div></d=
iv></div></div></div>

--0000000000000a0390058ef485f0--

--===============6850364926195745459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6850364926195745459==--
