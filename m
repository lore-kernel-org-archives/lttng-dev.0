From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Subject: =?utf-8?q?clock=5Fgettime_vdso_issue?=
Date: Thu, 26 Mar 2015 15:25:49 +0800
Message-ID: <cf147ee4-5d02-423f-a352-672a739809d4__27815.2085411877$1427354853$gmane$org@aliyun.com>
Reply-To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0271007183=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpcm9-114.freemail.mail.aliyun.com ([115.124.18.14])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <zhenyu.ren@aliyun.com>) id 1Yb2Az-0002E9-38
 for lttng-dev@lists.lttng.org; Thu, 26 Mar 2015 03:26:17 -0400
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

--===============0271007183==
Content-Type: multipart/alternative;
  boundary="----=ALIBOUNDARY_8354_4a524940_5513b47d_14582"

------=ALIBOUNDARY_8354_4a524940_5513b47d_14582
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=0AHi,Team=0A=C2=A0 =C2=A0You may not feel how painful I am with a too old GLI=
BC which does NOT support vdso clock_gettime. Especially in ust case, trace_cl=
ock_read will call clock_gettime to record the time of every event.=C2=A0Does =
anyone know how to avoid system_call clock_gettime with this old GLIBC??Thanks=
 in advancezhenyu.ren=0A
------=ALIBOUNDARY_8354_4a524940_5513b47d_14582
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div class=3D"__aliyun_email_body_block"><div style=3D"font-family:Tahoma,Aria=
l,STHeiti,SimSun;font-size:14px;color:#000000;"><br></div><div style=3D"font-f=
amily:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;">Hi,Team</div>=
<div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#00=
0000;"><br></div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-si=
ze:14px;color:#000000;">&nbsp; &nbsp;You may not feel how painful I am with a =
too old GLIBC which does NOT support vdso clock_gettime. Especially in ust cas=
e, trace_clock_read will call clock_gettime to record the time of every event.=
&nbsp;</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14=
px;color:#000000;">Does anyone know how to avoid system_call clock_gettime wit=
h this old GLIBC??</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;=
font-size:14px;color:#000000;"><br data-mce-bogus=3D"1"></div><div style=3D"fo=
nt-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color:#000000;">Thanks in=
 advance</div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:=
14px;color:#000000;">zhenyu.ren</div><div class=3D"__aliyun_signature_wrap"></=
div><div style=3D"font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14px;color=
:#000000;"><br></div></div>
------=ALIBOUNDARY_8354_4a524940_5513b47d_14582--



--===============0271007183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0271007183==--
