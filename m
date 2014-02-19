From: =?iso-8859-1?Q?Anette_Sch=F6tt?= <anette.schott@ericsson.com>
Subject: Live streaming question (lttng 2.4.0.rc4)
Date: Wed, 19 Feb 2014 13:54:47 +0000
Message-ID: <0C794A2958AD524DAB4175408F839BD3159514__42722.5102823742$1392818166$gmane$org@ESESSMB109.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1414720977=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sessmg20.ericsson.net ([193.180.251.50]
	helo=sessmg20.mgmt.ericsson.se)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <anette.schott@ericsson.com>) id 1WG7bu-0008I8-5y
	for lttng-dev@lists.lttng.org; Wed, 19 Feb 2014 08:54:57 -0500
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1414720977==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_0C794A2958AD524DAB4175408F839BD3159514ESESSMB109ericsso_"

--_000_0C794A2958AD524DAB4175408F839BD3159514ESESSMB109ericsso_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to do live streaming via the lttng-relayd and babeltrace (lttng=
 2.4.0.rc4). I am running an emulator where
I want to both generate the user-space tracepoints and view them live on th=
e same host (hope this is a valid use case).

I do the following:

# lttng-relayd -d -v -L net://localhost:5344
DEBUG3 [1516/1516]: URI string: net://localhost:5344 (in uri_parse() at uri=
.c:291)
DEBUG3 [1516/1516]: URI dtype: 1, proto: 1, host: localhost, subdir: , ctrl=
: 5344, data: 0 (in uri_parse() at uri.c:505)
DEBUG3 [1516/1516]: URI string: tcp://0.0.0.0:5342 (in uri_parse() at uri.c=
:291)
DEBUG3 [1516/1516]: URI dtype: 1, proto: 1, host: 0.0.0.0, subdir: , ctrl: =
5342, data: 0 (in uri_parse() at uri.c:505)
DEBUG3 [1516/1516]: URI string: tcp://0.0.0.0:5343 (in uri_parse() at uri.c=
:291)
DEBUG3 [1516/1516]: URI dtype: 1, proto: 1, host: 0.0.0.0, subdir: , ctrl: =
5343, data: 0 (in uri_parse() at uri.c:505)
DEBUG1 [1516/1516]: Signal handler set for SIGTERM, SIGUSR1, SIGPIPE and SI=
GINT (in set_signal_handler() at main.c:435)

# lttng create s1 --live 200000 -U net://localhost:5344
Session s1 created.
Traces will be written in net://localhost:5344

# lttng enable-channel ch1 -u
ERROR [834/838]: recvmsg inet: Connection reset by peer (in lttcomm_recvmsg=
_inet_sock() at inet.c:376)
Error: Channel ch1: Relay daemon not compatible (session s1)
Warning: Some command(s) went wrong

As all command are executed on the same host, why compatibility issues?

What commands shall I use to set up a live streaming?

Regards
Anette


--_000_0C794A2958AD524DAB4175408F839BD3159514ESESSMB109ericsso_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am trying to do live streaming via the lttng-relay=
d and babeltrace (lttng 2.4.0.rc4). I am running an emulator where<o:p></o:=
p></p>
<p class=3D"MsoNormal">I want to both generate the user-space tracepoints a=
nd view them live on the same host (hope this is a valid use case).<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I do the following:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"># lttng-relayd -d -v -L net://localhost:5344<o:p></o=
:p></p>
<p class=3D"MsoNormal">DEBUG3 [1516/1516]: URI string: net://localhost:5344=
 (in uri_parse() at uri.c:291)<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG3 [1516/1516]: URI dtype: 1, proto: 1, host: lo=
calhost, subdir: , ctrl: 5344, data: 0 (in uri_parse() at uri.c:505)<o:p></=
o:p></p>
<p class=3D"MsoNormal">DEBUG3 [1516/1516]: URI string: tcp://0.0.0.0:5342 (=
in uri_parse() at uri.c:291)<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG3 [1516/1516]: URI dtype: 1, proto: 1, host: 0.=
0.0.0, subdir: , ctrl: 5342, data: 0 (in uri_parse() at uri.c:505)<o:p></o:=
p></p>
<p class=3D"MsoNormal">DEBUG3 [1516/1516]: URI string: tcp://0.0.0.0:5343 (=
in uri_parse() at uri.c:291)<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG3 [1516/1516]: URI dtype: 1, proto: 1, host: 0.=
0.0.0, subdir: , ctrl: 5343, data: 0 (in uri_parse() at uri.c:505)<o:p></o:=
p></p>
<p class=3D"MsoNormal">DEBUG1 [1516/1516]: Signal handler set for SIGTERM, =
SIGUSR1, SIGPIPE and SIGINT (in set_signal_handler() at main.c:435)<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"># lttng create s1 --live 200000 -U net://localhost:5=
344<o:p></o:p></p>
<p class=3D"MsoNormal">Session s1 created.<o:p></o:p></p>
<p class=3D"MsoNormal">Traces will be written in net://localhost:5344<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"># lttng enable-channel ch1 &#8211;u<o:p></o:p></p>
<p class=3D"MsoNormal">ERROR [834/838]: recvmsg inet: Connection reset by p=
eer (in lttcomm_recvmsg_inet_sock() at inet.c:376)<o:p></o:p></p>
<p class=3D"MsoNormal">Error: Channel ch1: Relay daemon not compatible (ses=
sion s1)<o:p></o:p></p>
<p class=3D"MsoNormal">Warning: Some command(s) went wrong<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">As all command are executed on the same host, why co=
mpatibility issues?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">What commands shall I use to set up a live streaming=
?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Anette<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_0C794A2958AD524DAB4175408F839BD3159514ESESSMB109ericsso_--


--===============1414720977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1414720977==--
