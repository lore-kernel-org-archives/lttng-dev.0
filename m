From: Eugene Ivanov <Eugene.Ivanov@itiviti.com>
Subject: High memory consumption issue on RCU side
Date: Thu, 22 Sep 2016 17:57:52 +0000
Message-ID: <DB5PR07MB11918671914EDAE10EC12750FDC90__27785.2113977589$1474583510$gmane$org@DB5PR07MB1191.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1050367463993847025=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0096.outbound.protection.outlook.com [104.47.2.96])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 370B3A42E1
 for <lttng-dev@lists.lttng.org>; Thu, 22 Sep 2016 22:32:27 +0000 (UTC)
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
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1050367463993847025==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DB5PR07MB11918671914EDAE10EC12750FDC90DB5PR07MB1191eurp_"

--_000_DB5PR07MB11918671914EDAE10EC12750FDC90DB5PR07MB1191eurp_
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

--_000_DB5PR07MB11918671914EDAE10EC12750FDC90DB5PR07MB1191eurp_
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
<p>Hi,</p>
<p><br>
</p>
<p>I'm investigating high memory usage of my program: RSS&nbsp;varies betwe=
en executions in range 20-50 GB, though it should be determenistic.&nbsp;I'=
ve found that all the memory is allocated in this stack:</p>
<p><br>
</p>
<p></p>
<div>Allocated 17673781248 bytes in 556 allocations</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; cds_lfht_alloc_bucket_table3 &nbsp; &nbsp;=
 from liburcu-cds.so.2.0.0</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; _do_cds_lfht_resize &nbsp; &nbsp; &nbsp;fr=
om liburcu-cds.so.2.0.0</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; do_resize_cb &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; from liburcu-cds.so.2.0.0</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; call_rcu_thread &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;from liburcu-qsbr.so.2.0.0</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; start_thread &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; from libpthread-2.12.so</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; clone &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp;from libc-2.12.so</div>
<div><br>
</div>
<div>According pstack it should be&nbsp;<span>quiescent state. &nbsp;Call t=
hread waits on syscall:<br>
<div>syscall</div>
<div>call_rcu_thread</div>
<div>start_thread</div>
<div>clone</div>
<div><br>
</div>
</span></div>
<div><span style=3D"font-size: 12pt;">We use&nbsp;</span><span style=3D"fon=
t-size: 12pt;">urcu-0.8.7, only rculfhash (QSBR). Is it some kind of leak i=
n RCU or any chance I misuse it? What would you recommend to troubleshoot t=
he situation?</span><br>
</div>
<div><span style=3D"font-size: 12pt;"><br>
</span></div>
<div><span style=3D"font-size: 12pt;">Eugene</span></div>
<p></p>
</div>
</body>
</html>

--_000_DB5PR07MB11918671914EDAE10EC12750FDC90DB5PR07MB1191eurp_--

--===============1050367463993847025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1050367463993847025==--
