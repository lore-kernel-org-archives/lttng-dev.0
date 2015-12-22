From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Subject: =?utf-8?q?A_question_about_staring_lttng-sessiond?=
Date: Tue, 22 Dec 2015 17:57:32 +0800
Message-ID: <29bc6074-6863-4f14-bc9c-24e0f86c507c.zhenyu.ren__23975.4267888658$1450778349$gmane$org@aliyun.com>
Reply-To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0850479884=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpcm9-305.freemail.mail.aliyun.com ([110.75.46.5])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <zhenyu.ren@aliyun.com>) id 1aBJhN-0005sY-RI
 for lttng-dev@lists.lttng.org; Tue, 22 Dec 2015 04:57:48 -0500
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

--===============0850479884==
Content-Type: multipart/alternative;
  boundary="----=ALIBOUNDARY_21370_4d6c9940_56791e8c_155d2"

------=ALIBOUNDARY_21370_4d6c9940_56791e8c_155d2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,Dev-team=C2=A0 I always have a question about staring lttng-sessiond withou=
t option=C2=A0--daemonize: Why I left my console?I wrote a simple shell to sta=
rt lttng-sessiond as the following:cat ./start#!/bin/shexport=C2=A0LTTNG_SESSI=
ON_CONFIG_XSD_PATH=3D./configexport=C2=A0LTTNG_CONSUMERD64_BIN=3D./lttng-consu=
merdexec=C2=A0./lttng-sessiond=C2=A0--sig-parent=C2=A0-g=C2=A0admin[admin@rs1k=
04068=C2=A0/home/admin/install]sudo=C2=A0sh=C2=A0./start=C2=A0[zhenyu.ren@rs1k=
04068.et2sqa=C2=A0/home/zhenyu.ren]Note that user changed from admin to zhenyu=
.ren(zhenyu.ren sudo su admin previously). Where can I have a code fix to avoi=
d logging out?
------=ALIBOUNDARY_21370_4d6c9940_56791e8c_155d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div class=3D"__aliyun_email_body_block"><div style=3D"clear: both;"><span sty=
le=3D"font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; color: rgb=
(0, 0, 0);">Hi,Dev-team</span></div><div style=3D"clear: both;"><span style=3D=
"font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; color: rgb(0, 0=
, 0);"><br ></span></div><div style=3D"clear: both;"><span style=3D"font-famil=
y: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; color: rgb(0, 0, 0);">&nbs=
p; I always have a question about staring lttng-sessiond without option&nbsp;-=
-daemonize: Why I left my console?</span></div><div style=3D"clear: both;"><br=
 ></div><div style=3D"clear: both;">I wrote a simple shell to start lttng-sess=
iond as the following:</div><div style=3D"clear: both;"><br ></div><div style=3D=
"clear: both;">cat ./start</div><div style=3D"clear: both;"><br ></div><div st=
yle=3D"clear: both;">#!/bin/sh</div><div style=3D"clear: both;">export&nbsp;LT=
TNG_SESSION_CONFIG_XSD_PATH=3D./config<br >export&nbsp;LTTNG_CONSUMERD64_BIN=3D=
./lttng-consumerd<br >exec&nbsp;./lttng-sessiond&nbsp;--sig-parent&nbsp;-g&nbs=
p;admin</div><div style=3D"clear: both;"><br ></div><div style=3D"clear: both;=
"><br ></div><div style=3D"clear: both;">[admin@rs1k04068&nbsp;/home/admin/ins=
tall]sudo&nbsp;sh&nbsp;./start&nbsp;</div><div style=3D"clear: both;"><br >[zh=
enyu.ren@rs1k04068.et2sqa&nbsp;/home/zhenyu.ren]</div><div style=3D"clear: bot=
h;"><br ></div><div style=3D"clear: both;">Note that user changed from admin t=
o zhenyu.ren(zhenyu.ren sudo su admin previously). Where can I have a code fix=
 to avoid logging out?</div></div>
------=ALIBOUNDARY_21370_4d6c9940_56791e8c_155d2--



--===============0850479884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0850479884==--
