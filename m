From: Pavan Anumula <pavan.anumula@sasken.com>
Subject: Lttng start failed
Date: Fri, 8 Jun 2012 19:24:51 +0530
Message-ID: <47D610AD9C485E458630BA38C324D3B60113FB00F9EA__32812.3207124465$1339164885$gmane$org@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1922934465=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mta-blr1.sasken.com ([203.200.200.72])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <pavan.anumula@sasken.com>) id 1SczeX-0000nJ-Om
	for lttng-dev@lists.lttng.org; Fri, 08 Jun 2012 09:55:02 -0400
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

--===============1922934465==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_47D610AD9C485E458630BA38C324D3B60113FB00F9EAEXGMBX01sas_"

--_000_47D610AD9C485E458630BA38C324D3B60113FB00F9EAEXGMBX01sas_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi ,

I am new to LTTng usage, I am trying to use LTTng 2.0.1 and LTTng-modules-2=
.0.2  for ARM(omapL138), with Linux kernel 2.6.33 wit RT-29 patch on it.

After enabling all the kernel events I am facing the below errors. I loaded=
 all the modules manually by insmod.



root@arago:~/lttng-traces# arm-none-linux-gnueabi-lttng create newsessiom
Session newsessiom created.
Traces will be written in /home/root/lttng-traces/newsessiom-20110325-15492=
2

root@arago:~/lttng-traces# arm-none-linux-gnueabi-lttng enable-event -a --k=
ernel
All kernel events are enabled in channel channel0

root@arago:~/lttng-traces# arm-none-linux-gnueabi-lttng start
LTTng: Failure to write metadata to buffers (timeout)
Error: Starting kernel trace failed

Please kindly help me on this.


Thanks in advance,
Pavan

________________________________
SASKEN BUSINESS DISCLAIMER: This message may contain confidential, propriet=
ary or legally privileged information. In case you are not the original int=
ended Recipient of the message, you must not, directly or indirectly, use, =
disclose, distribute, print, or copy any part of this message and you are r=
equested to delete it and inform the sender. Any views expressed in this me=
ssage are those of the individual sender unless otherwise stated. Nothing c=
ontained in this message shall be construed as an offer or acceptance of an=
y offer by Sasken Communication Technologies Limited ("Sasken") unless sent=
 with that express intent and with due authority of Sasken. Sasken has take=
n enough precautions to prevent the spread of viruses. However the company =
accepts no liability for any damage caused by any virus transmitted by this=
 email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html

--_000_47D610AD9C485E458630BA38C324D3B60113FB00F9EAEXGMBX01sas_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
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
<p class=3D"MsoNormal">Hi ,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am new to LTTng usage, I am trying to use LTTng 2.=
0.1 and LTTng-modules-2.0.2 &nbsp;for ARM(omapL138), with Linux kernel
<b>2.6.33</b> wit <b>RT-29</b> patch on it.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">After enabling all the kernel events I am facing the=
 below errors. I loaded all the modules manually by insmod.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:#C00000"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#C00000">root@arago:~/lttng-tra=
ces# arm-none-linux-gnueabi-lttng create newsessiom<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#C00000">Session newsessiom cre=
ated.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#C00000">Traces will be written=
 in /home/root/lttng-traces/newsessiom-20110325-154922<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"color:#C00000"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#C00000">root@arago:~/lttng-tra=
ces# arm-none-linux-gnueabi-lttng enable-event -a --kernel<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"color:#C00000">All kernel events are =
enabled in channel channel0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#C00000"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#C00000">root@arago:~/lttng-tra=
ces# arm-none-linux-gnueabi-lttng start<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#C00000">LTTng: Failure to writ=
e metadata to buffers (timeout)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#C00000">Error: Starting kernel=
 trace failed<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#C00000"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal">Please kindly help me on this.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks in advance,<o:p></o:p></p>
<p class=3D"MsoNormal">Pavan<span style=3D"color:#C00000"><o:p></o:p></span=
></p>
</div>
<br>
<hr>
<font face=3D"Arial" color=3D"Black" size=3D"2">SASKEN BUSINESS DISCLAIMER:=
 This message may contain confidential, proprietary or legally privileged i=
nformation. In case you are not the original intended Recipient of the mess=
age, you must not, directly or indirectly,
 use, disclose, distribute, print, or copy any part of this message and you=
 are requested to delete it and inform the sender. Any views expressed in t=
his message are those of the individual sender unless otherwise stated. Not=
hing contained in this message shall
 be construed as an offer or acceptance of any offer by Sasken Communicatio=
n Technologies Limited (&quot;Sasken&quot;) unless sent with that express i=
ntent and with due authority of Sasken. Sasken has taken enough precautions=
 to prevent the spread of viruses. However
 the company accepts no liability for any damage caused by any virus transm=
itted by this email.<br>
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html<br>
</font>
</body>
</html>

--_000_47D610AD9C485E458630BA38C324D3B60113FB00F9EAEXGMBX01sas_--


--===============1922934465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1922934465==--
