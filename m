From: John O'Sullivan <John.OSullivan@BlackBox.com>
Subject: Mixing kernel and userspace traces in a single events
	editor view
Date: Fri, 3 Aug 2018 13:57:54 +0000
Message-ID: <1533304674046.28750__16978.6851889969$1533304630$gmane$org@BlackBox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1488322020129489473=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from esa4.hc2026-0.iphmx.com (esa4.hc2026-0.iphmx.com
 [68.232.154.207])
 by lists.lttng.org (Postfix) with ESMTPS id 41hpYj4tgVz14CH
 for <lttng-dev@lists.lttng.org>; Fri,  3 Aug 2018 09:59:05 -0400 (EDT)
Content-Language: en-IE
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

--===============1488322020129489473==
Content-Language: en-IE
Content-Type: multipart/alternative;
	boundary="_000_153330467404628750BlackBoxcom_"

--_000_153330467404628750BlackBoxcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,


I using trace compass on an embedded target, I have a sample application wi=
th some user space events and I am also collecting some kernel events.

Is there some way in trace compass of looking at these in a single Events E=
ditor view so that both kernel and Userspace events are interleaved with re=
spect to time?


The script I am using on my target is;


 #!/bin/sh
HOST_IP=3D"10.xxx.xxx.xxx"
#Create a session sending the data over the network to a listening host
lttng create --set-url=3Dnet://$HOST_IP
#Create one or more events
lttng enable-event -u -a -c chan1
lttng enable-event --kernel sched_switch,sched_process_fork
#create an event for the logger
lttng enable-event --kernel lttng_logger
lttng start
echo "Loading sample aplication" > /proc/lttng-logger
/usr/bin/sample_application
echo "unLoading sample aplication" > /proc/lttng-logger
lttng destroy


The resulting traces when opened only allows me to view kernel and UST on s=
eparate tabs



regards


John

________________________________

This email and any files transmitted with it are confidential and are inten=
ded for the sole use of the individual to whom they are addressed. Black Bo=
x Corporation reserves the right to scan all e-mail traffic for restricted =
content and to monitor all e-mail in general. If you are not the intended r=
ecipient or you have received this email in error, any use, dissemination o=
r forwarding of this email is strictly prohibited. If you have received thi=
s email in error, please notify the sender by replying to this email.

--_000_153330467404628750BlackBoxcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none"><!--P{margin-top:0;margin-b=
ottom:0;} --></style>
</head>
<body dir=3D"ltr" style=3D"font-size:12pt;color:#000000;background-color:#F=
FFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi,</p>
<p><br>
</p>
<p>I using trace compass on an embedded target, I have a sample application=
 with some user space events and I am also collecting some kernel events.</=
p>
<p>Is there some way in trace compass of looking at these in a single Event=
s Editor view so that both kernel and Userspace events are interleaved with=
 respect to time?</p>
<p><br>
</p>
<p>The script I am using on my target is;</p>
<p><br>
</p>
<p>&nbsp;#!/bin/sh<br>
HOST_IP=3D&quot;10.xxx.xxx.xxx&quot;<br>
#Create a session sending the data over the network to a listening host<br>
lttng create --set-url=3Dnet://$HOST_IP<br>
#Create one or more events<br>
lttng enable-event -u -a -c chan1<br>
lttng enable-event --kernel sched_switch,sched_process_fork<br>
#create an event for the logger<br>
lttng enable-event --kernel lttng_logger<br>
lttng start<br>
echo &quot;Loading sample aplication&quot; &gt; /proc/lttng-logger<br>
/usr/bin/sample_application<br>
echo &quot;unLoading sample aplication&quot; &gt; /proc/lttng-logger<br>
lttng destroy</p>
<p><br>
</p>
<p>The resulting traces when opened only allows me to view kernel and UST o=
n separate tabs<br>
<br>
</p>
<p><br>
</p>
<p>regards</p>
<p><br>
</p>
<p>John <br>
</p>
<br>
<hr>
<font face=3D"Arial" color=3D"Gray" size=3D"1"><br>
This email and any files transmitted with it are confidential and are inten=
ded for the sole use of the individual to whom they are addressed. Black Bo=
x Corporation reserves the right to scan all e-mail traffic for restricted =
content and to monitor all e-mail
 in general. If you are not the intended recipient or you have received thi=
s email in error, any use, dissemination or forwarding of this email is str=
ictly prohibited. If you have received this email in error, please notify t=
he sender by replying to this email.<br>
</font>
</body>
</html>

--_000_153330467404628750BlackBoxcom_--

--===============1488322020129489473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1488322020129489473==--
