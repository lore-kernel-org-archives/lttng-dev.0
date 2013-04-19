From: Hari Prasad Kalavakunta <Hari.Prasad@radisys.com>
Subject: lttng-tools-2.1.1 for linux-3.4.3
Date: Fri, 19 Apr 2013 15:47:59 +0000
Message-ID: <05E83BDD0E1F054FA73F00F6970F05C6062F72__24386.325319256$1366386529$gmane$org@CH1PRD0810MB394.namprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0772274462=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]
	helo=co9outboundpool.messaging.microsoft.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Hari.Prasad@radisys.com>) id 1UTDXs-0007t5-88
	for lttng-dev@lists.lttng.org; Fri, 19 Apr 2013 11:48:16 -0400
Received: from mail147-co9 (localhost [127.0.0.1])	by
	mail147-co9-R.bigfish.com (Postfix) with ESMTP id 4659454035D	for
	<lttng-dev@lists.lttng.org>; Fri, 19 Apr 2013 15:48:10 +0000 (UTC)
Received: from CO9EHSMHS016.bigfish.com (unknown [10.236.132.240])	by
	mail147-co9.bigfish.com (Postfix) with ESMTP id 61012C4005E	for
	<lttng-dev@lists.lttng.org>; Fri, 19 Apr 2013 15:48:08 +0000 (UTC)
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

--===============0772274462==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_05E83BDD0E1F054FA73F00F6970F05C6062F72CH1PRD0810MB394na_"

--_000_05E83BDD0E1F054FA73F00F6970F05C6062F72CH1PRD0810MB394na_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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

$ export ax_have_epoll_cppflags=3Dno
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

--_000_05E83BDD0E1F054FA73F00F6970F05C6062F72CH1PRD0810MB394na_
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
<p class=3D"MsoNormal" style=3D"margin-left:.5in">$ export ax_have_epoll_cp=
pflags=3Dno<o:p></o:p></p>
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

--_000_05E83BDD0E1F054FA73F00F6970F05C6062F72CH1PRD0810MB394na_--


--===============0772274462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0772274462==--
