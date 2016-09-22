From: Eugene Ivanov <Eugene.Ivanov@itiviti.com>
Subject: High memory consumption issue on RCU side
Date: Thu, 22 Sep 2016 18:06:02 +0000
Message-ID: <DB5PR07MB119106BFBABC4856866EE4F9FDC90__30092.572925105$1474576893$gmane$org@DB5PR07MB1191.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6830481851641615869=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0091.outbound.protection.outlook.com [104.47.2.91])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id C3CCAA42C5
 for <lttng-dev@lists.lttng.org>; Thu, 22 Sep 2016 20:42:23 +0000 (UTC)
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6830481851641615869==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DB5PR07MB119106BFBABC4856866EE4F9FDC90DB5PR07MB1191eurp_"

--_000_DB5PR07MB119106BFBABC4856866EE4F9FDC90DB5PR07MB1191eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,


I'm investigating high memory usage of my program: RSS varies between execu=
tions in range 20-50 GB, though it should be determenistic. I've found that=
 all the memory is allocated in this stack:


Allocated 17673781248 bytes in 556 allocations
        cds_lfht_alloc_bucket_table3     from liburcu-cds.so.2.0.0
        _do_cds_lfht_resize      from liburcu-cds.so.2.0.0
        do_resize_cb             from liburcu-cds.so.2.0.0
        call_rcu_thread          from liburcu-qsbr.so.2.0.0
        start_thread             from libpthread-2.12.so
        clone                    from libc-2.12.so

According pstack it should be quiescent state.  Call thread waits on syscal=
l:
syscall
call_rcu_thread
start_thread
clone

We use urcu-0.8.7, only rculfhash (QSBR). Is it some kind of leak in RCU or=
 any chance I misuse it? What would you recommend to troubleshoot the situa=
tion?

Eugene


--_000_DB5PR07MB119106BFBABC4856866EE4F9FDC90DB5PR07MB1191eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;">
<p></p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: =
16px;">Hi,</p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: =
16px;"><br>
</p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: =
16px;">I'm investigating high memory usage of my program: RSS&nbsp;varies b=
etween executions in range 20-50 GB, though it should be determenistic.&nbs=
p;I've found that all the memory is allocated
 in this stack:</p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: =
16px;"><br>
</p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: =
16px;"></p>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 16px;">
Allocated 17673781248 bytes in 556 allocations</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 16px;">
&nbsp; &nbsp; &nbsp; &nbsp; cds_lfht_alloc_bucket_table3 &nbsp; &nbsp; from=
 liburcu-cds.so.2.0.0</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 16px;">
&nbsp; &nbsp; &nbsp; &nbsp; _do_cds_lfht_resize &nbsp; &nbsp; &nbsp;from li=
burcu-cds.so.2.0.0</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 16px;">
&nbsp; &nbsp; &nbsp; &nbsp; do_resize_cb &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; from liburcu-cds.so.2.0.0</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 16px;">
&nbsp; &nbsp; &nbsp; &nbsp; call_rcu_thread &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;from liburcu-qsbr.so.2.0.0</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 16px;">
&nbsp; &nbsp; &nbsp; &nbsp; start_thread &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; from libpthread-2.12.so</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 16px;">
&nbsp; &nbsp; &nbsp; &nbsp; clone &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp;from libc-2.12.so</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 16px;">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 16px;">
According pstack it should be&nbsp;quiescent state. &nbsp;Call thread waits=
 on syscall:<br>
<div>syscall</div>
<div>call_rcu_thread</div>
<div>start_thread</div>
<div>clone</div>
<div><br>
</div>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 16px;">
<span style=3D"font-size: 12pt;">We use&nbsp;</span><span style=3D"font-siz=
e: 12pt;">urcu-0.8.7, only rculfhash (QSBR). Is it some kind of leak in RCU=
 or any chance I misuse it? What would you recommend to troubleshoot the si=
tuation?</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 16px;">
<span style=3D"font-size: 12pt;"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 16px;">
<span style=3D"font-size: 12pt;">Eugene</span></div>
<br>
<p></p>
</div>
</body>
</html>

--_000_DB5PR07MB119106BFBABC4856866EE4F9FDC90DB5PR07MB1191eurp_--

--===============6830481851641615869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6830481851641615869==--
