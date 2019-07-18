From: Ravindra Kumar Meena <rmeena840@gmail.com>
Subject: How to add event_header_compact?
Date: Thu, 18 Jul 2019 20:04:57 +0530
Message-ID: <CAEWVvOQiuENK7uAFD_kSyhTTCQd=vcV9WBmD3YSfnCnSuyqEpA__15891.5712659777$1563460580$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0512856866406899634=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by lists.lttng.org (Postfix) with ESMTPS id 45qGrm0fcHz1FPP
 for <lttng-dev@lists.lttng.org>; Thu, 18 Jul 2019 10:35:35 -0400 (EDT)
Received: by mail-wm1-x32d.google.com with SMTP id x15so25846214wmj.3
 for <lttng-dev@lists.lttng.org>; Thu, 18 Jul 2019 07:35:35 -0700 (PDT)
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

--===============0512856866406899634==
Content-Type: multipart/alternative; boundary="000000000000c09dba058df58500"

--000000000000c09dba058df58500
Content-Type: text/plain; charset="UTF-8"

Hi developers,

I have added event_header_compact in metadata and I have to add it in C
language so the binary stream have this header. I followed the CTF
documentation https://diamon.org/ctf/#spec6.1

struct event_header_compact {
enum : uint5_t { compact = 0 ... 30, extended = 31 } id;
variant <id> {
struct {
uint27_clock_monotonic_t timestamp;
} compact;
struct {
uint32_t id;
uint64_clock_monotonic_t timestamp;
} extended;
} v;
} align(8);

Since C does not have variant data-type. I am facing problem in adding it C
language. What should be the approach for the same? Do you have any
examples where it's been already done?

Thanks

-- 
*Ravindra Kumar Meena*,
B. Tech. Computer Science and Engineering,
Indian Institute of Technology (Indian School of Mines)
<https://www.iitism.ac.in/>, Dhanbad

--000000000000c09dba058df58500
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi developers,<div><br></div><div>I have added event_heade=
r_compact in metadata and I have to add it in C language so the binary stre=
am have this header. I followed the CTF documentation=C2=A0<a href=3D"https=
://diamon.org/ctf/#spec6.1">https://diamon.org/ctf/#spec6.1</a></div><div><=
br></div><div>struct event_header_compact {<br>	enum : uint5_t { compact =
=3D 0 ... 30, extended =3D 31 } id;<br>	variant &lt;id&gt; {<br>		struct {<=
br>			uint27_clock_monotonic_t timestamp;<br>		} compact;<br>		struct {<br>=
			uint32_t id;<br>			uint64_clock_monotonic_t timestamp;<br>		} extended;<=
br>	} v;<br>} align(8);</div><div><br></div><div>Since C does not have vari=
ant data-type. I am facing problem in adding it C language. What should be =
the approach for the same? Do you have any examples where it&#39;s been alr=
eady done?</div><div><br></div><div>Thanks<br clear=3D"all"><div><br></div>=
-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_s=
ignature"><div dir=3D"ltr"><div><div dir=3D"ltr"><font size=3D"4"><b>Ravind=
ra Kumar Meena</b></font>,<div><span style=3D"color:rgb(102,102,102)">B. Te=
ch. Computer Science and Engineering,<br></span></div><div><span style=3D"c=
olor:rgb(102,102,102)"><a href=3D"https://www.iitism.ac.in/" style=3D"color=
:rgb(17,85,204)" target=3D"_blank">Indian Institute of Technology (Indian S=
chool of Mines)</a>, Dhanbad</span></div></div></div></div></div></div></di=
v>

--000000000000c09dba058df58500--

--===============0512856866406899634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0512856866406899634==--
