From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Subject: =?utf-8?q?if_lttng-sessiond_crashed?=
Date: Fri, 18 Dec 2015 15:56:26 +0800
Message-ID: <e1a18587-379c-47c4-b049-ca7125be16a3.zhenyu.ren__31997.9271655486$1450425492$gmane$org@aliyun.com>
Reply-To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1756518610=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out12.mail.aliyun.com ([205.204.117.241])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <zhenyu.ren@aliyun.com>) id 1a9puO-0002SC-HV
 for lttng-dev@lists.lttng.org; Fri, 18 Dec 2015 02:57:03 -0500
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

--===============1756518610==
Content-Type: multipart/alternative;
  boundary="----=ALIBOUNDARY_20196_50c5a940_5673bc2a_a336"

------=ALIBOUNDARY_20196_50c5a940_5673bc2a_a336
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,=C2=A0 =C2=A0I know that when the enabled event is hitted , the=C2=A0instru=
mented app will call=C2=A0__event_probe__##_provider##___##_template() to writ=
e data into memory and lttng-consumerd will consume these data from buffer to =
disk. If lttng-sessiond(include lttng-consumed) does crash (not be signal-kill=
ed) in the middle of tracing process, what will happen in these instrumented a=
pps? Will they crash too ? Will they continue wirting data into buffer for eve=
r??Thankszhenyu.ren
------=ALIBOUNDARY_20196_50c5a940_5673bc2a_a336
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div class=3D"__aliyun_email_body_block"><div style=3D"clear: both;"><span sty=
le=3D"font-family: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; color: rgb=
(0, 0, 0);">Hi,</span></div><div style=3D"clear: both;"><span style=3D"font-fa=
mily: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; color: rgb(0, 0, 0);"><=
br ></span></div><div style=3D"clear: both;"><span style=3D"font-family: Tahom=
a, Arial, STHeiti, SimSun; font-size: 14px; color: rgb(0, 0, 0);">&nbsp; &nbsp=
;I know that <span style=3D"color: rgb(0, 0, 0); font-family: Tahoma, Arial, S=
THeiti, SimSun; font-size: 14px; font-style: normal; font-variant: normal; fon=
t-weight: normal; line-height: 23px; text-align: start; text-indent: 0px; text=
-transform: none; widows: auto; background-color: rgb(255, 255, 255); float: n=
one; display: inline !important;">when the enabled event is hitted , the&nbsp;=
</span>instrumented app will call&nbsp;__event_probe__##_provider##___##_templ=
ate() to write data into memory and lttng-consumerd will consume these data fr=
om buffer to disk. If lttng-sessiond(include lttng-consumed) does crash (not b=
e signal-killed) in the middle of tracing process, what will happen in these i=
nstrumented apps? Will they crash too ? Will they continue wirting data into b=
uffer for ever??</span></div><div style=3D"clear: both;"><span style=3D"font-f=
amily: Tahoma, Arial, STHeiti, SimSun; font-size: 14px; color: rgb(0, 0, 0);">=
<br ></span></div><div style=3D"clear: both;"><span style=3D"font-family: Taho=
ma, Arial, STHeiti, SimSun; font-size: 14px; color: rgb(0, 0, 0);">Thanks</spa=
n></div><div style=3D"clear: both;"><span style=3D"font-family: Tahoma, Arial,=
 STHeiti, SimSun; font-size: 14px; color: rgb(0, 0, 0);">zhenyu.ren</span></di=
v></div>
------=ALIBOUNDARY_20196_50c5a940_5673bc2a_a336--



--===============1756518610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1756518610==--
