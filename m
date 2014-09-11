From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Subject: =?utf-8?q?How_to_analysis_a_huge_trace-collected_data?=
 =?utf-8?q?_efficiently?=
Date: Thu, 11 Sep 2014 09:38:07 +0800
Message-ID: <e4797186-ccb1-4efc-a68e-953e8575a42a__18243.1339323104$1410399545$gmane$org@aliyun.com>
Reply-To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0607263797=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpcm9-301.freemail.mail.aliyun.com ([110.75.46.1])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <zhenyu.ren@aliyun.com>) id 1XRtL4-0001fZ-3w
 for lttng-dev@lists.lttng.org; Wed, 10 Sep 2014 21:38:25 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0607263797==
Content-Type: multipart/alternative;
  boundary="----=ALIBOUNDARY_14662_498b6940_5410fcff_cc2b"

------=ALIBOUNDARY_14662_498b6940_5410fcff_cc2b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,=C2=A0 =C2=A0It's well known that tracing can produce huge data easily.So i=
f we keep tracing on a production system for a while(hour/day/week) =C2=A0,we =
may get =C2=A0a huge CTF file. It's very inefficient to analysis a huge CTF fi=
le ,especially the interested events are in some narrow time window.Is there a=
ny way to change the situation?Can we split a huge ctf file into several small=
 ctf file? Or can lttng produce a list of small time-sequence =C2=A0ctf filles=
 just like some loggers do?Thankszhenyu.ren=0A=0A
------=ALIBOUNDARY_14662_498b6940_5410fcff_cc2b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div class=3D"__aliyun_email_body_block"><div style=3D"color:#333333;font-size=
:14px;font-family:Tahoma,Arial,STHeiti,SimSun;;">Hi,</div><div style=3D"color:=
#333333;font-size:14px;font-family:Tahoma,Arial,STHeiti,SimSun;;">&nbsp; &nbsp=
;It's well known that tracing can produce huge data easily.So if we keep traci=
ng on a production system for a while(hour/day/week) &nbsp;,we may get &nbsp;a=
 huge CTF file. It's very inefficient to analysis a huge CTF file ,especially =
the interested events are in some narrow time window.Is there any way to chang=
e the situation?Can we split a huge ctf file into several small ctf file? Or c=
an lttng produce a list of small time-sequence &nbsp;ctf filles just like some=
 loggers do?</div><div style=3D"color:#333333;font-size:14px;font-family:Tahom=
a,Arial,STHeiti,SimSun;;"><br data-mce-bogus=3D"1"></div><div style=3D"color:#=
333333;font-size:14px;font-family:Tahoma,Arial,STHeiti,SimSun;;">Thanks</div><=
div style=3D"color:#333333;font-size:14px;font-family:Tahoma,Arial,STHeiti,Sim=
Sun;;">zhenyu.ren</div><div class=3D"__aliyun_signature_wrap"><br><br></div></=
div>
------=ALIBOUNDARY_14662_498b6940_5410fcff_cc2b--



--===============0607263797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0607263797==--
