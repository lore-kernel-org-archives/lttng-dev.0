From: Tan Dung Le Tran <tan.dung.le.tran@ericsson.com>
Subject: Re: Live streaming question (lttng 2.4.0.rc4)
Date: Wed, 19 Feb 2014 15:55:02 +0000
Message-ID: <510A3668CBDB6143966144326546DA921BFA3DC1__8188.35645118288$1392825388$gmane$org@eusaamb103.ericsson.se>
References: <0C794A2958AD524DAB4175408F839BD3159514@ESESSMB109.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0147092025=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <tan.dung.le.tran@ericsson.com>) id 1WG9UL-0000wZ-ON
	for lttng-dev@lists.lttng.org; Wed, 19 Feb 2014 10:55:21 -0500
In-Reply-To: <0C794A2958AD524DAB4175408F839BD3159514@ESESSMB109.ericsson.se>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?Anette_Sch=F6tt?= <anette.schott@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0147092025==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_510A3668CBDB6143966144326546DA921BFA3DC1eusaamb103erics_"

--_000_510A3668CBDB6143966144326546DA921BFA3DC1eusaamb103erics_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Anette,

We are using the following for a live streaming:

   export TC=3DMySession

   #-- see if there is any instrumented application is running
   lttng list -u
   ps -ef |egrep 'lttng'

   #-- Launch relayd with ControlPort 53000, DataPort 53001 and LiveViewPor=
t 53002
   #   whatever relayd collects, will be stored in /tmp/$TC
   lttng-relayd  -C tcp://localhost:53000 -D tcp://localhost:53001 -L net:/=
/localhost:53002 -o /tmp/$TC &

   #-- Create session using Control and Data ports as specified in relayd
   lttng create $TC --live 1000000 -U net://localhost:53000:53001/./

   lttng list

   #-- We want to use per-Uid buffer instead of the default per-PID buffer
   lttng enable-channel chan1 -u --buffers-uid

   lttng enable-event -s $TC -u -c chan1 tracepoints_that_you_want_to_trace=
_on
   lttng start $TC;
   lttng list $TC

   #-- make sure you see the tracepoints that your session is tracing on fr=
om the
   #   output of the next command, otherwise, your session / live view will=
 not
   #   be able to capture anything
   lttng list -u

   #----- live viewing: -----

     # to get a list of viewable traces (note the live view port is used he=
re)
     babeltrace -i lttng-live  net://localhost:53002
          net://localhost:53002/host/SC-1/MySession (timer =3D 1000000, 17 =
stream(s), 0 client(s) connected)

     # Start the live view on node SC-1
     babeltrace -i lttng-live  net://localhost:53002/host/SC-1/$TC
         <you should see your trace hit now>

   #-- stop the session
   lttng stop $TC
   lttng destroy $TC

   #-- Convert what your session has captured:
   babeltrace /tmp/$TC

Hope it helps,
Tan


From: Anette Sch=F6tt [mailto:anette.schott@ericsson.com]
Sent: February-19-14 8:55 AM
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] Live streaming question (lttng 2.4.0.rc4)

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


--_000_510A3668CBDB6143966144326546DA921BFA3DC1eusaamb103erics_
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
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
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
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<body lang=3D"EN-CA" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">Hi Anette,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">We are using the following for a live streaming:<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; export TC=3DMySession<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; <o:p>
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp;&nbsp;#-- see if there is any instrumented applic=
ation is running
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp;&nbsp;lttng list &#8211;u &nbsp;&nbsp;&nbsp;&nbsp=
;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp;&nbsp;ps -ef |egrep 'lttng'<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; #-- Launch relayd with ControlPort 53000, DataPo=
rt 53001 and LiveViewPort 53002<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; #&nbsp;&nbsp; whatever relayd collects, will be =
stored in /tmp/$TC<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; lttng-relayd&nbsp; -C tcp://localhost:53000 -D t=
cp://localhost:53001 -L net://localhost:53002 -o /tmp/$TC &amp;<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp;&nbsp;#-- Create session using Control and Data p=
orts as specified in relayd<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; lttng create $TC --live 1000000 -U net://localho=
st:53000:53001/./<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; <o:p>
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp;&nbsp;lttng list<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; #-- We want to use per-Uid buffer instead of the=
 default per-PID buffer<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; lttng enable-channel chan1 -u --buffers-uid
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; lttng enable-event -s $TC -u -c chan1 tracepoint=
s_that_you_want_to_trace_on<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; lttng start $TC;&nbsp;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp;&nbsp;lttng list $TC<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; #-- make sure you see the tracepoints that your =
session is tracing on from the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; #&nbsp;&nbsp; output of the next command, otherw=
ise, your session / live view will not<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; #&nbsp;&nbsp; be able to capture anything<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; lttng list &#8211;u<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; #----- live viewing: -----<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; &nbsp;&nbsp;# to get a list of viewable traces (=
note the live view port is used here)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; &nbsp;&nbsp;babeltrace -i lttng-live&nbsp; net:/=
/localhost:53002
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;n=
et://localhost:53002/host/SC-1/MySession (timer =3D 1000000, 17 stream(s), =
0 client(s) connected)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp;&nbsp;&nbsp; # Start the live view on node SC-1&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;babeltrace -i lttng-live&nbsp; =
net://localhost:53002/host/SC-1/$TC&nbsp;&nbsp;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;you=
 should see your trace hit now&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; #-- stop the session<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; lttng stop $TC<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; lttng destroy $TC<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; #-- Convert what your session has captured:<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">&nbsp;&nbsp; babeltrace /tmp/$TC<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">Hope it helps,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D">Tan<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;fo=
nt-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span =
lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&qu=
ot;sans-serif&quot;"> Anette Sch=F6tt [mailto:anette.schott@ericsson.com]
<br>
<b>Sent:</b> February-19-14 8:55 AM<br>
<b>To:</b> lttng-dev@lists.lttng.org<br>
<b>Subject:</b> [lttng-dev] Live streaming question (lttng 2.4.0.rc4)<o:p><=
/o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I am trying to do live streamin=
g via the lttng-relayd and babeltrace (lttng 2.4.0.rc4). I am running an em=
ulator where<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I want to both generate the use=
r-space tracepoints and view them live on the same host (hope this is a val=
id use case).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I do the following:<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># lttng-relayd -d -v -L net://l=
ocalhost:5344<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG3 [1516/1516]: URI string:=
 net://localhost:5344 (in uri_parse() at uri.c:291)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG3 [1516/1516]: URI dtype: =
1, proto: 1, host: localhost, subdir: , ctrl: 5344, data: 0 (in uri_parse()=
 at uri.c:505)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG3 [1516/1516]: URI string:=
 tcp://0.0.0.0:5342 (in uri_parse() at uri.c:291)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG3 [1516/1516]: URI dtype: =
1, proto: 1, host: 0.0.0.0, subdir: , ctrl: 5342, data: 0 (in uri_parse() a=
t uri.c:505)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG3 [1516/1516]: URI string:=
 tcp://0.0.0.0:5343 (in uri_parse() at uri.c:291)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG3 [1516/1516]: URI dtype: =
1, proto: 1, host: 0.0.0.0, subdir: , ctrl: 5343, data: 0 (in uri_parse() a=
t uri.c:505)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 [1516/1516]: Signal hand=
ler set for SIGTERM, SIGUSR1, SIGPIPE and SIGINT (in set_signal_handler() a=
t main.c:435)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># lttng create s1 --live 200000=
 -U net://localhost:5344<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Session s1 created.<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Traces will be written in net:/=
/localhost:5344<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># lttng enable-channel ch1 &#82=
11;u<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">ERROR [834/838]: recvmsg inet: =
Connection reset by peer (in lttcomm_recvmsg_inet_sock() at inet.c:376)<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Error: Channel ch1: Relay daemo=
n not compatible (session s1)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Warning: Some command(s) went w=
rong<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">As all command are executed on =
the same host, why compatibility issues?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">What commands shall I use to se=
t up a live streaming?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Anette<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_510A3668CBDB6143966144326546DA921BFA3DC1eusaamb103erics_--


--===============0147092025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0147092025==--
