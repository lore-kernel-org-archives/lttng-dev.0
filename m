From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Subject: =?utf-8?q?lttng_index_file_not_closed_when_rotating?=
Date: Mon, 25 Apr 2016 17:10:03 +0800
Message-ID: <a055198e-ed92-47e5-9d29-68abc982e608.zhenyu.ren__17885.440219152$1461575434$gmane$org@aliyun.com>
Reply-To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7207180041271353738=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpcm9-319.freemail.mail.aliyun.com
 (smtpcm9-319.freemail.mail.aliyun.com [110.75.46.19])
 by evm-lttng-1.efficios.com (Postfix) with ESMTP id 4F9DFA3273
 for <lttng-dev@lists.lttng.org>; Mon, 25 Apr 2016 09:10:12 +0000 (UTC)
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

--===============7207180041271353738==
Content-Type: multipart/alternative;
  boundary="----=ALIBOUNDARY_8586_5756c940_571ddeeb_59579"

------=ALIBOUNDARY_8586_5756c940_571ddeeb_59579
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,Dev=0A=C2=A0=C2=A0 I am using lttng-tools 2.6.0 , it seems that lttng-consu=
merd does not close old index file when rotating to a new one. =0A=C2=A0=C2=A0=
 lsof -p $lttng-consumerd |wc -l=C2=A0 showes file number is keeping increased=
... =0A=C2=A0=C2=A0 Does anyone know this bug?=0AThankszhenyu.ren=0A
------=ALIBOUNDARY_8586_5756c940_571ddeeb_59579
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div class=3D"__aliyun_email_body_block"><div style=3D"clear: both;"><span sty=
le=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: rgb(0,=
 0, 0);">Hi,Dev</span></div><div style=3D"clear: both;"><span style=3D"font-fa=
mily: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: rgb(0, 0, 0);"><br =
></span></div><div style=3D"clear: both;"><span style=3D"font-family: Tahoma,A=
rial,STHeiti,SimSun; font-size: 14px; color: rgb(0, 0, 0);">&nbsp;&nbsp; I am =
using lttng-tools 2.6.0 , it seems that lttng-consumerd does not close old ind=
ex file when rotating to a new one. </span></div><div style=3D"clear: both;"><=
span style=3D"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color=
: rgb(0, 0, 0);"><br ></span></div><div style=3D"clear: both;"><span style=3D"=
font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: rgb(0, 0, 0)=
;">&nbsp;&nbsp; lsof -p $lttng-consumerd |wc -l&nbsp; showes file number is ke=
eping increased... </span></div><div style=3D"clear: both;"><span style=3D"fon=
t-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: rgb(0, 0, 0);">=
<br ></span></div><div style=3D"clear: both;"><span style=3D"font-family: Taho=
ma,Arial,STHeiti,SimSun; font-size: 14px; color: rgb(0, 0, 0);">&nbsp;&nbsp; D=
oes anyone know this bug?</span></div><div style=3D"clear: both;"><span style=3D=
"font-family: Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: rgb(0, 0, 0=
);"><br ></span></div><div style=3D"clear: both;"><span style=3D"font-family: =
Tahoma,Arial,STHeiti,SimSun; font-size: 14px; color: rgb(0, 0, 0);">Thanks</sp=
an></div><div style=3D"clear: both;"><span style=3D"font-family: Tahoma,Arial,=
STHeiti,SimSun; font-size: 14px; color: rgb(0, 0, 0);">zhenyu.ren<br ></span><=
/div></div>
------=ALIBOUNDARY_8586_5756c940_571ddeeb_59579--


--===============7207180041271353738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7207180041271353738==--
