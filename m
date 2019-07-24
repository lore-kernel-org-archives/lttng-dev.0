From: Ravindra Kumar Meena <rmeena840@gmail.com>
Subject: What is _prev_state in sched_switch?
Date: Wed, 24 Jul 2019 12:14:40 +0530
Message-ID: <CAEWVvOS48D3Jfp4==qrrODzdSSjo+-UOuvZyya1O_f2t9B9Z1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8612534918926233751=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by lists.lttng.org (Postfix) with ESMTPS id 45tm7M0pTFz1FqY
 for <lttng-dev@lists.lttng.org>; Wed, 24 Jul 2019 02:45:18 -0400 (EDT)
Received: by mail-wr1-x432.google.com with SMTP id c2so42391494wrm.8
 for <lttng-dev@lists.lttng.org>; Tue, 23 Jul 2019 23:45:18 -0700 (PDT)
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

--===============8612534918926233751==
Content-Type: multipart/alternative; boundary="000000000000eb0abc058e67a6be"

--000000000000eb0abc058e67a6be
Content-Type: text/plain; charset="UTF-8"

Hi,

I had a looked at TraceCompass example. I came across sched_swithc event in
present in the metadata.

event {
name = "sched_switch";
id = 27;
stream_id = 0;
fields := struct {
integer { size = 8; align = 8; signed = 0; encoding = UTF8; base = 10; }
_prev_comm[16];
integer { size = 32; align = 8; signed = 1; encoding = none; base = 10; }
_prev_tid;
integer { size = 32; align = 8; signed = 1; encoding = none; base = 10; }
_prev_prio;
integer { size = 64; align = 8; signed = 1; encoding = none; base = 10; }
_prev_state;
integer { size = 8; align = 8; signed = 0; encoding = UTF8; base = 10; }
_next_comm[16];
integer { size = 32; align = 8; signed = 1; encoding = none; base = 10; }
_next_tid;
integer { size = 32; align = 8; signed = 1; encoding = none; base = 10; }
_next_prio;
};
};

All event.fields variables are clear to me but what does _prev_state do
here? I had a looked at its babeltrace output but found no pattern in
_prev_state value.

Please attend this email ASAP.

Thanks

-- 
*Ravindra Kumar Meena*,
B. Tech. Computer Science and Engineering,
Indian Institute of Technology (Indian School of Mines)
<https://www.iitism.ac.in/>, Dhanbad

--000000000000eb0abc058e67a6be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div>I had a looked at TraceCompas=
s example. I came across sched_swithc event in present in the metadata.<div=
><br></div><div>event {<br>	name =3D &quot;sched_switch&quot;;<br>	id =3D 2=
7;<br>	stream_id =3D 0;<br>	fields :=3D struct {<br>		integer { size =3D 8;=
 align =3D 8; signed =3D 0; encoding =3D UTF8; base =3D 10; } _prev_comm[16=
];<br>		integer { size =3D 32; align =3D 8; signed =3D 1; encoding =3D none=
; base =3D 10; } _prev_tid;<br>		integer { size =3D 32; align =3D 8; signed=
 =3D 1; encoding =3D none; base =3D 10; } _prev_prio;<br>		integer { size =
=3D 64; align =3D 8; signed =3D 1; encoding =3D none; base =3D 10; } _prev_=
state;<br>		integer { size =3D 8; align =3D 8; signed =3D 0; encoding =3D U=
TF8; base =3D 10; } _next_comm[16];<br>		integer { size =3D 32; align =3D 8=
; signed =3D 1; encoding =3D none; base =3D 10; } _next_tid;<br>integer { s=
ize =3D 32; align =3D 8; signed =3D 1; encoding =3D none; base =3D 10; } _n=
ext_prio;<br>	};<br>};</div><div><br></div><div>All event.fields variables =
are clear to me but what does _prev_state do here? I had a looked at its ba=
beltrace output but found no pattern in _prev_state value.</div><div><br></=
div><div>Please attend this email ASAP.</div><div><br></div><div>Thanks<br =
clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signatu=
re" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"lt=
r"><font size=3D"4"><b>Ravindra Kumar Meena</b></font>,<div><span style=3D"=
color:rgb(102,102,102)">B. Tech. Computer Science and Engineering,<br></spa=
n></div><div><span style=3D"color:rgb(102,102,102)"><a href=3D"https://www.=
iitism.ac.in/" style=3D"color:rgb(17,85,204)" target=3D"_blank">Indian Inst=
itute of Technology (Indian School of Mines)</a>, Dhanbad</span></div></div=
></div></div></div></div></div>

--000000000000eb0abc058e67a6be--

--===============8612534918926233751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8612534918926233751==--
