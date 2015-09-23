From: Mikael Beckius <mikael.beckius@ericsson.com>
Subject: Sessions are disconnected when disk is full on remote
	host
Date: Wed, 23 Sep 2015 09:48:54 +0000
Message-ID: <FEF43CBBC4664F4D80C53B178C850ADE730271__16873.1102058247$1443033531$gmane$org@ESESSMB305.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0011826696=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sesbmg22.ericsson.net ([193.180.251.48])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mikael.beckius@ericsson.com>) id 1Zegfa-0005sa-Vc
 for lttng-dev@lists.lttng.org; Wed, 23 Sep 2015 05:49:00 -0400
Content-Language: sv-SE
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0011826696==
Content-Language: sv-SE
Content-Type: multipart/alternative;
	boundary="_000_FEF43CBBC4664F4D80C53B178C850ADE730271ESESSMB305ericsso_"

--_000_FEF43CBBC4664F4D80C53B178C850ADE730271ESESSMB305ericsso_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello!

I am trying to verify the expected behaviour in the event a machine hosting=
 an lttng relay daemon runs out of disk space.

Currently it appears from testing and inspecting the source code that whene=
ver the lttng relay daemon hits an error caused by the lack of disk space a=
ll failing sessions will be disconnected. It also appears that the only way=
 to recover from this situation once disk space has been restored is to rec=
reate all the disconnected sessions.

I have also played around with different combinations of the below lttng en=
able-channel options:
--discard
--overwrite
--tracefile-count <trace file count>
--tracefile-size <trace file size>

The initial channel configuration was using the options --tracefile-count -=
-tracefile-size but both were abandoned as Babeltrace faced constant stream=
ing errors during heavy live tracing and now the trace files are growing co=
ntinuously until there is no available disk space.

I assume that --overwrite would not make any difference compared to --disca=
rd with regards to a disk full scenario. Even if you specify --tracefile-co=
unt and --tracefile-size to limit the amount of trace data from a single se=
ssion you may still face the same issue with disconnected sessions if you f=
or some reason run out of disk space.

Testing was carried out on the latest 2.6 releases and all sessions were li=
ve sessions.

So my questions are:
- Is there any way to keep sessions alive even if you run out of disk space=
?
- How can you clean up old traces once you have collected them without recr=
eating sessions?

Micke

--_000_FEF43CBBC4664F4D80C53B178C850ADE730271ESESSMB305ericsso_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style id=3D"owaParaStyle" type=3D"text/css">P {margin-top:0;margin-bottom:=
0;}</style>
</head>
<body ocsi=3D"0" fpstyle=3D"1">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">Hello!<br>
<br>
I am trying to verify the expected behaviour in the event a machine hosting=
 an lttng relay daemon runs out of disk space.<br>
<br>
Currently it appears from testing and inspecting the source code that whene=
ver the lttng relay daemon hits an error caused by the lack of disk space a=
ll failing sessions will be disconnected. It also appears that the only way=
 to recover from this situation
 once disk space has been restored is to recreate all the disconnected sess=
ions.<br>
<br>
I have also played around with different combinations of the below lttng en=
able-channel options:<br>
--discard<br>
--overwrite<br>
--tracefile-count &lt;trace file count&gt;<br>
--tracefile-size &lt;trace file size&gt;<br>
<br>
The initial channel configuration was using the options --tracefile-count -=
-tracefile-size but both were abandoned as Babeltrace faced constant stream=
ing errors during heavy live tracing and now the trace files are growing co=
ntinuously until there is no available
 disk space.<br>
<br>
I assume that --overwrite would not make any difference compared to --disca=
rd with regards to a disk full scenario. Even if you specify --tracefile-co=
unt and --tracefile-size to limit the amount of trace data from a single se=
ssion you may still face the same
 issue with disconnected sessions if you for some reason run out of disk sp=
ace.<br>
<br>
Testing was carried out on the latest 2.6 releases and all sessions were li=
ve sessions.<br>
<br>
So my questions are:<br>
- Is there any way to keep sessions alive even if you run out of disk space=
?<br>
- How can you clean up old traces once you have collected them without recr=
eating sessions?<br>
<br>
Micke<br>
</div>
</body>
</html>

--_000_FEF43CBBC4664F4D80C53B178C850ADE730271ESESSMB305ericsso_--


--===============0011826696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0011826696==--
