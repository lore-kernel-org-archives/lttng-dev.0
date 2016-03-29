From: =?iso-8859-1?Q?Marc-Andr=E9_Laperle?= <marc-andre.laperle@ericsson.com>
Subject: Max length for trace path in LTTng MI
Date: Tue, 29 Mar 2016 17:44:28 +0000
Message-ID: <D381217948BF4C45AF756AFC995BEB9F225D5E8E__34914.8821588189$1459273512$gmane$org@eusaamb103.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2489243218818484424=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usplmg20.ericsson.net (usplmg20.ericsson.net [198.24.6.45])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id ACBCDA2EE6
 for <lttng-dev@lists.lttng.org>; Tue, 29 Mar 2016 17:44:35 +0000 (UTC)
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

--===============2489243218818484424==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_D381217948BF4C45AF756AFC995BEB9F225D5E8Eeusaamb103erics_"

--_000_D381217948BF4C45AF756AFC995BEB9F225D5E8Eeusaamb103erics_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

We have noticed a problem when a trace session uses a long output path (ove=
r 255 in length) and the session is listed with MI. The MI output format is=
 specified in a schema, here is the relevant part:

<!-- Maps to the char name[LTTNG_SYMBOL_NAME_LEN] -->
<xs:simpleType name=3D"name_type">
<xs:restriction base=3D"xs:string">
<xs:maxLength value=3D"255"/>
</xs:restriction>
</xs:simpleType>

Because of the maxLength of 255, the MI output received by the viewer (Trac=
e Compass) is deemed invalid and the session cannot be listed.

The issue was first noticed here, in a test:
https://ci.lttng.org/view/Trace%20Compass/job/tracecompass-master-linux/197=
/JAVA_TO_USE=3DOpenJDK-8,SWT_GTK3=3D0,WM=3Dmetacity,label=3Dx86-32,target-p=
latform=3Dtracecompass-e4.5/artifact/lttng/org.eclipse.tracecompass.lttng2.=
control.ui.swtbot.tests/target/work/data/.metadata/.log/*view*/

Then I described steps to reproduce this in normal usage:
https://bugs.eclipse.org/bugs/show_bug.cgi?id=3D490557

What would be the best way forward here? Would it be a solution to increase=
 this limit or would it be better perhaps to have a different element for t=
he trace output path that has either a bigger limit or no limit at all?

Thank you,
Marc-Andr=E9

--_000_D381217948BF4C45AF756AFC995BEB9F225D5E8Eeusaamb103erics_
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
10pt;">Hi,<br>
<br>
We have noticed a problem when a trace session uses a long output path (ove=
r 255 in length) and the session is listed with MI. The MI output format is=
 specified in a schema, here is the relevant part:<br>
<br>
&lt;!-- Maps to the char name[LTTNG_SYMBOL_NAME_LEN] --&gt;<br>
&lt;xs:simpleType name=3D&quot;name_type&quot;&gt;<br>
&lt;xs:restriction base=3D&quot;xs:string&quot;&gt;<br>
&lt;xs:maxLength value=3D&quot;255&quot;/&gt;<br>
&lt;/xs:restriction&gt;<br>
&lt;/xs:simpleType&gt;<br>
<br>
Because of the maxLength of 255, the MI output received by the viewer (Trac=
e Compass) is deemed invalid and the session cannot be listed.<br>
<br>
The issue was first noticed here, in a test:<br>
<a href=3D"https://ci.lttng.org/view/Trace%20Compass/job/tracecompass-maste=
r-linux/197/JAVA_TO_USE=3DOpenJDK-8,SWT_GTK3=3D0,WM=3Dmetacity,label=3Dx86-=
32,target-platform=3Dtracecompass-e4.5/artifact/lttng/org.eclipse.tracecomp=
ass.lttng2.control.ui.swtbot.tests/target/work/data/.metadata/.log/*view*/"=
 target=3D"_blank">https://ci.lttng.org/view/Trace%20Compass/job/tracecompa=
ss-master-linux/197/JAVA_TO_USE=3DOpenJDK-8,SWT_GTK3=3D0,WM=3Dmetacity,labe=
l=3Dx86-32,target-platform=3Dtracecompass-e4.5/artifact/lttng/org.eclipse.t=
racecompass.lttng2.control.ui.swtbot.tests/target/work/data/.metadata/.log/=
*view*/</a><br>
<br>
Then I described steps to reproduce this in normal usage:<br>
<a href=3D"https://bugs.eclipse.org/bugs/show_bug.cgi?id=3D490557" target=
=3D"_blank">https://bugs.eclipse.org/bugs/show_bug.cgi?id=3D490557</a><br>
<br>
What would be the best way forward here? Would it be a solution to increase=
 this limit or would it be better perhaps to have a different element for t=
he trace output path that has either a bigger limit or no limit at all?<br>
<br>
Thank you,<br>
Marc-Andr=E9<br>
</div>
</body>
</html>

--_000_D381217948BF4C45AF756AFC995BEB9F225D5E8Eeusaamb103erics_--

--===============2489243218818484424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2489243218818484424==--
