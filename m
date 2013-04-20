From: Hari Prasad Kalavakunta <Hari.Prasad@radisys.com>
Subject: Re: lttng-tools-2.1.1 for linux-3.4.3
Date: Sat, 20 Apr 2013 00:34:38 +0000
Message-ID: <05E83BDD0E1F054FA73F00F6970F05C606310B__12289.6030582071$1366418191$gmane$org@CH1PRD0810MB394.namprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2024156475=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]
	helo=tx2outboundpool.messaging.microsoft.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Hari.Prasad@radisys.com>) id 1UTLmd-0003Yw-VU
	for lttng-dev@lists.lttng.org; Fri, 19 Apr 2013 20:36:04 -0400
Received: from mail240-tx2 (localhost [127.0.0.1])	by
	mail240-tx2-R.bigfish.com (Postfix) with ESMTP id 2073C3201FD	for
	<lttng-dev@lists.lttng.org>; Sat, 20 Apr 2013 00:35:56 +0000 (UTC)
Received: from TX2EHSMHS040.bigfish.com (unknown [10.9.14.229])	by
	mail240-tx2.bigfish.com (Postfix) with ESMTP id 12FC442004E	for
	<lttng-dev@lists.lttng.org>; Sat, 20 Apr 2013 00:34:40 +0000 (UTC)
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

--===============2024156475==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_05E83BDD0E1F054FA73F00F6970F05C606310BCH1PRD0810MB394na_"

--_000_05E83BDD0E1F054FA73F00F6970F05C606310BCH1PRD0810MB394na_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello lttng-dev,

Bison version upgrade to 2.4 took care of the earlier blocker.

Undefined references to htobe64 and htobe32 are thrown. Could you please di=
rect me if this is known one.

../../../src/common/.libs/libconsumer.a(consumer.o): In function `write_rel=
ayd_metadata_id':
/root/lttng2.1/lttng-tools-2.1.1/src/common/consumer.c:1290: undefined refe=
rence to `htobe64'
/root/lttng2.1/lttng-tools-2.1.1/src/common/consumer.c:1291: undefined refe=
rence to `htobe32'

Regards,
Hari

From: Hari Prasad Kalavakunta
Sent: Friday, April 19, 2013 9:18 PM
To: lttng-dev@lists.lttng.org
Subject: lttng-tools-2.1.1 for linux-3.4.3

Hello lttng-dev,

When cross compiling lttng-tools-2.1.1 for PowerPC-32 bit, I am running int=
o few issues. Could you please let me know what is wrong here.

First, there was a problem using EPOLL feature.

$ CFLAGS=3D"-m32 -g -O2" ./configure --prefix=3D/home/xxx/linux-3.4.3/ --ho=
st=3Dpowerpc-linux
$ make

make[3]: Entering directory `/home/xxx/lttng2.1/lttng-tools-2.1.1/src/commo=
n/compat'
  CC     compat-epoll.lo
In file included from compat-epoll.c:31:
poll.h:76: error: 'EPOLL_CLOEXEC' undeclared here (not in a function)


To go past this problem, I have chosen not to use EPOLL through ax_have_epo=
ll_cppflags flag

$ export ax_cv_have_epoll =3Dno
$ CFLAGS=3D"-m32 -g -O2" ./configure --prefix=3D/home/xxx/linux-3.4.3/ --ho=
st=3Dpowerpc-linux
$ make

YACC   filter-parser.c
/home/xxx/lttng2.1/lttng-tools-2.1.1/src/lib/lttng-ctl/filter/filter-parser=
.y:299.9-16: syntax error, unexpected identifier, expecting string


This time parser appears have some kind of issue. Also, there are few warni=
ngs as shown below that indicates to me that configure is not done in the c=
orrect way.
consumer.c: In function 'write_relayd_stream_header':
consumer.c:749: warning: implicit declaration of function 'htobe64'
consumer.c:750: warning: implicit declaration of function 'htobe32'

Could you please let me know what could be wrong here. Your help is appreci=
ated. Except of lttng-tools, all other components have be successfully buil=
d and installed.

Regards,
Hari

--_000_05E83BDD0E1F054FA73F00F6970F05C606310BCH1PRD0810MB394na_
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
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
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
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Hello lttng-dev,<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Bison version upgrade =
to 2.4 took care of the earlier blocker.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Undefined references to htobe64 and htobe32 are thrown. Could you please di=
rect me if this is known one.<span style=3D"color:#1F497D"><o:p></o:p></spa=
n></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
../../../src/common/.libs/libconsumer.a(consumer.o): In function `write_rel=
ayd_metadata_id':<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
/root/lttng2.1/lttng-tools-2.1.1/src/common/consumer.c:1290: undefined refe=
rence to `htobe64'<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
/root/lttng2.1/lttng-tools-2.1.1/src/common/consumer.c:1291: undefined refe=
rence to `htobe32'<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Regards,<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Hari<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> Hari Pra=
sad Kalavakunta
<br>
<b>Sent:</b> Friday, April 19, 2013 9:18 PM<br>
<b>To:</b> lttng-dev@lists.lttng.org<br>
<b>Subject:</b> lttng-tools-2.1.1 for linux-3.4.3<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hello lttng-dev,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">When cross compiling lttng-tools-2.1.1 for PowerPC-3=
2 bit, I am running into few issues. Could you please let me know what is w=
rong here.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">First, there was a problem using EPOLL feature.<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">$ CFLAGS=3D&quot;-m32 -g =
-O2&quot; ./configure --prefix=3D/home/xxx/linux-3.4.3/ --host=3Dpowerpc-li=
nux<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">$ make<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:1.0in"><span style=3D"font-fami=
ly:&quot;Courier New&quot;">make[3]: Entering directory `/home/xxx/lttng2.1=
/lttng-tools-2.1.1/src/common/compat'<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:1.0in"><span style=3D"font-fami=
ly:&quot;Courier New&quot;">&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp; compat-epoll.=
lo<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:1.0in"><span style=3D"font-fami=
ly:&quot;Courier New&quot;">In file included from compat-epoll.c:31:<o:p></=
o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:1.0in"><span style=3D"font-fami=
ly:&quot;Courier New&quot;">poll.h:76: error: 'EPOLL_CLOEXEC' undeclared he=
re (not in a function)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">To go past this problem, I have chosen not to use EP=
OLL through ax_have_epoll_cppflags flag<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">$ export ax_<span style=
=3D"color:#1F497D">cv</span>_<span style=3D"color:#1F497D">have_</span>epol=
l =3Dno<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">$ CFLAGS=3D&quot;-m32 -g =
-O2&quot; ./configure --prefix=3D/home/xxx/linux-3.4.3/ --host=3Dpowerpc-li=
nux<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">$ make<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:1.0in"><span style=3D"font-fami=
ly:&quot;Courier New&quot;">YACC&nbsp;&nbsp; filter-parser.c<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal" style=3D"margin-left:1.0in"><span style=3D"font-fami=
ly:&quot;Courier New&quot;">/home/xxx/lttng2.1/lttng-tools-2.1.1/src/lib/lt=
tng-ctl/filter/filter-parser.y:299.9-16: syntax error, unexpected identifie=
r, expecting string<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:1.0in"><span style=3D"font-fami=
ly:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">This time parser appears have some kind of issue. Al=
so, there are few warnings as shown below that indicates to me that configu=
re is not done in the correct way.<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Courier New&quot;">consumer.c: In function 'write_relayd_stream_hea=
der':<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Courier New&quot;">consumer.c:749: warning: implicit declaration of=
 function 'htobe64'<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Courier New&quot;">consumer.c:750: warning: implicit declaration of=
 function 'htobe32'<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Could you please let me know what could be wrong her=
e. Your help is appreciated. Except of lttng-tools, all other components ha=
ve be successfully build and installed.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Hari<o:p></o:p></p>
</div>
</body>
</html>

--_000_05E83BDD0E1F054FA73F00F6970F05C606310BCH1PRD0810MB394na_--


--===============2024156475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2024156475==--
