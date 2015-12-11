From: Jeffrey Chen <cpthk@hotmail.com>
Subject: LTTng hourly/weekly/monthly tracing
Date: Thu, 10 Dec 2015 16:55:16 -0800
Message-ID: <BLU169-W447A3DEAC7E4B31C9336F9ABEA0__6327.59032673693$1449795410$gmane$org@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1279911161=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from blu004-omc3s9.hotmail.com ([65.55.116.84])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <cpthk@hotmail.com>) id 1a7BzW-0005Rs-Jn
 for lttng-dev@lists.lttng.org; Thu, 10 Dec 2015 19:55:30 -0500
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

--===============1279911161==
Content-Type: multipart/alternative;
	boundary="_d4b61cb1-1a29-4994-9a80-a329eb76833a_"

--_d4b61cb1-1a29-4994-9a80-a329eb76833a_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi:

I am using LTTng for tracing user-space application. Does LTTng support hou=
rly/weekly/monthly rollover tracing? Some of the tracing libraries like log=
4j supports this=2C it will separate traces into different files for each h=
our/week/month depending on your setup. You could start to read the older t=
races while the user application is still running and writing traces. Does =
LTTng support this kind of feature? If not=2C what is the closest I could g=
et? Ideally=2C I need to read the trace while the trace session is still ru=
nning. It doesn't have to be real-time trace=2C could be couple hours old. =
I saw that LTTng has the snapshot mode=2C but it is still not exactly the s=
ame as the one I need=2C Snapshot mode could suffer from event lost=2C sinc=
e it keeps overwriting old events. Thanks.

 		 	   		  =

--_d4b61cb1-1a29-4994-9a80-a329eb76833a_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 12pt=3B
font-family:Calibri
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>Hi:<br><br>I am using LTTng for =
tracing user-space application. Does LTTng support hourly/weekly/monthly ro=
llover tracing? Some of the tracing libraries like log4j supports this=2C i=
t will separate traces into different files for each hour/week/month depend=
ing on your setup. You could start to read the older traces while the user =
application is still running and writing traces. Does LTTng support this ki=
nd of feature? If not=2C what is the closest I could get? Ideally=2C I need=
 to read the trace while the trace session is still running. It doesn't hav=
e to be real-time trace=2C could be couple hours old. I saw that LTTng has =
the snapshot mode=2C but it is still not exactly the same as the one I need=
=2C Snapshot mode could suffer from event lost=2C since it keeps overwritin=
g old events. Thanks.<br><br> 		 	   		  </div></body>
</html>=

--_d4b61cb1-1a29-4994-9a80-a329eb76833a_--


--===============1279911161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1279911161==--
