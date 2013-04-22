From: SIDDHARTH VERMA <SIDDHARTH.VERMA@radisys.com>
Subject: FW: LTTNG-Tools-2.1.1 Support for PPC-32Bit/64bit;
 Unable to Resolve the Dependencies
Date: Mon, 22 Apr 2013 05:20:15 +0000
Message-ID: <A492A571B9D6304983C4106E4956338D04C3A87D__37153.2496567399$1366608062$gmane$org@BLUPRD0811MB426.namprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0534716184=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from co1ehsobe002.messaging.microsoft.com ([216.32.180.185]
	helo=co1outboundpool.messaging.microsoft.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <SIDDHARTH.VERMA@radisys.com>) id 1UU9Ay-0002wB-RA
	for lttng-dev@lists.lttng.org; Mon, 22 Apr 2013 01:20:29 -0400
Received: from mail152-co1 (localhost [127.0.0.1])	by
	mail152-co1-R.bigfish.com (Postfix) with ESMTP id 0F8E2A00274	for
	<lttng-dev@lists.lttng.org>; Mon, 22 Apr 2013 05:20:21 +0000 (UTC)
Received: from CO1EHSMHS032.bigfish.com (unknown [10.243.78.241])	by
	mail152-co1.bigfish.com (Postfix) with ESMTP id D7D8E74004D	for
	<lttng-dev@lists.lttng.org>; Mon, 22 Apr 2013 05:20:17 +0000 (UTC)
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

--===============0534716184==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_A492A571B9D6304983C4106E4956338D04C3A87DBLUPRD0811MB426_"

--_000_A492A571B9D6304983C4106E4956338D04C3A87DBLUPRD0811MB426_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Lttng-Support,



I used following commands to compile and install the LTTng on PPC Board::



1. ./configure --host=3Dpowerpc-linux CC=3D/usr/bin/ppc-linux-gcc CFLAGS=3D=
"-m32 -g -O2"

2. make

3. make install

4. ldconfig



------------------------

Error Logs for LTTng-Tools-2.1.1 && lttng-ust-2.2.0-rc1 && userspace-rcu-0.=
7.2::

------------------------

liburcu & lttng-ust installed but getting below error while trying to make =
LTTng-Tools

------------------------

------------------------

[root@172.27.4.128]# make

Making all in src

make[1]: Entering directory `/root/siverma/2.1.1/lttng-tools-2.2.0-rc1/src'

Making all in common

make[2]: Entering directory `/root/siverma/2.1.1/lttng-tools-2.2.0-rc1/src/=
common'

Making all in compat

make[3]: Entering directory `/root/siverma/2.1.1/lttng-tools-2.2.0-rc1/src/=
common/compat'

  CC     compat-fcntl.lo

  CC     compat-epoll.lo

In file included from compat-epoll.c:31:

poll.h:72: error: 'EPOLLRDHUP' undeclared here (not in a function)

poll.h:74: error: 'EPOLL_CLOEXEC' undeclared here (not in a function)

compat-epoll.c: In function 'compat_epoll_create':

compat-epoll.c:77: warning: implicit declaration of function 'epoll_create1=
'

make[3]: *** [compat-epoll.lo] Error 1

make[3]: Leaving directory `/root/siverma/2.1.1/lttng-tools-2.2.0-rc1/src/c=
ommon/compat'

make[2]: *** [all-recursive] Error 1

make[2]: Leaving directory `/root/siverma/2.1.1/lttng-tools-2.2.0-rc1/src/c=
ommon'

make[1]: *** [all-recursive] Error 1

make[1]: Leaving directory `/root/siverma/2.1.1/lttng-tools-2.2.0-rc1/src'

make: *** [all-recursive] Error 1



------------------------------------

I also tried with the previous version of the tool

liburcu installed but getting below dependencies while trying to configure =
for lttng-ust

------------------------------------



Error Logs lttng-ust-1.9.2 && lttng-tools-2.0.0-rc1 && userspace-rcu-0.6.6 =
::

------------------------------------

------------------------------------

checking for GNU libc compatible malloc... yes

checking for gettimeofday... yes

checking for munmap... yes

checking for socket... yes

checking for strerror... yes

checking for strtol... yes

checking for makeinfo... no

configure: error: Please install the 'texinfo' program and make sure 'makei=
nfo' is in the PATH.



--------------------------------------------------------

--------------------------------------------------------



It seems there are many dependencies involved in the installation of the LT=
Tng, some of them are as follows;



Texinfo

Makeinfo

kernel image to 2.6.38 or higher

librc

libpotp > 1.13

tcltk

libasprintf

gettext

gc++

glib 2.34.0 and some more packages.



Do we have to download and cross compile them all for ppc or we can get som=
e help from standard package managers for the same?

As of now the kernel used in machine is "3.4.3-rt13"



[root@172.27.4.128]# uname -a

Linux 172.27.4.128 3.4.3-rt13 #1 SMP PREEMPT RT Sat Feb 23 09:46:06 CST 201=
3 ppc ppc ppc GNU/Linux



As per my observations it may take a lot of time to resolve them all as we =
have to decide all the correct supporting packages

with the correct releases in order to make them work for a particular Linux=
 image, though its easy to resolve it by using

standard package managers in latest Linux e.g. UBUNTU.



Please suggest on the same.

Regards
Siddharth Verma
Mobile: +91-9880621252
siddharth.verma@radisys.com<mailto:siddharth.verma@radisys.com>

--_000_A492A571B9D6304983C4106E4956338D04C3A87DBLUPRD0811MB426_
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
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";
	mso-fareast-language:EN-US;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri","sans-serif";}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
span.EmailStyle21
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle22
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.EmailStyle23
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
<body lang=3D"EN-IN" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoPlainText">Hi <span style=3D"color:black">Lttng-Support,</sp=
an><o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">I used following commands to compile and install =
the LTTng on PPC Board::<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><b>1. ./configure --host=3Dpowerpc-linux CC=3D/us=
r/bin/ppc-linux-gcc CFLAGS=3D&quot;-m32 -g -O2&quot;<o:p></o:p></b></p>
<p class=3D"MsoPlainText"><b>2. make<o:p></o:p></b></p>
<p class=3D"MsoPlainText"><b>3. make install<o:p></o:p></b></p>
<p class=3D"MsoPlainText"><b>4. ldconfig<o:p></o:p></b></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">------------------------<o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"background:red;mso-highlight:red">=
Error Logs for
<b>LTTng-Tools-2.1.1 &amp;&amp; lttng-ust-2.2.0-rc1 &amp;&amp; userspace-rc=
u-0.7.2</b>::</span><o:p></o:p></p>
<p class=3D"MsoPlainText">------------------------<o:p></o:p></p>
<p class=3D"MsoPlainText"><b>liburcu &amp; lttng-ust installed</b> but gett=
ing below error while trying to
<b>make LTTng-Tools</b><o:p></o:p></p>
<p class=3D"MsoPlainText">------------------------<o:p></o:p></p>
<p class=3D"MsoPlainText">------------------------<o:p></o:p></p>
<p class=3D"MsoPlainText">[root@172.27.4.128]# make<o:p></o:p></p>
<p class=3D"MsoPlainText">Making all in src<o:p></o:p></p>
<p class=3D"MsoPlainText">make[1]: Entering directory `/root/siverma/2.1.1/=
lttng-tools-2.2.0-rc1/src'<o:p></o:p></p>
<p class=3D"MsoPlainText">Making all in common<o:p></o:p></p>
<p class=3D"MsoPlainText">make[2]: Entering directory `/root/siverma/2.1.1/=
lttng-tools-2.2.0-rc1/src/common'<o:p></o:p></p>
<p class=3D"MsoPlainText">Making all in compat<o:p></o:p></p>
<p class=3D"MsoPlainText">make[3]: Entering directory `/root/siverma/2.1.1/=
lttng-tools-2.2.0-rc1/src/common/compat'<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp; compat-fcntl.lo=
<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp; compat-epoll.lo=
<o:p></o:p></p>
<p class=3D"MsoPlainText">In file included from compat-epoll.c:31:<o:p></o:=
p></p>
<p class=3D"MsoPlainText">poll.h:72: error: 'EPOLLRDHUP' undeclared here (n=
ot in a function)<o:p></o:p></p>
<p class=3D"MsoPlainText">poll.h:74: error: 'EPOLL_CLOEXEC' undeclared here=
 (not in a function)<o:p></o:p></p>
<p class=3D"MsoPlainText">compat-epoll.c: In function 'compat_epoll_create'=
:<o:p></o:p></p>
<p class=3D"MsoPlainText">compat-epoll.c:77: warning: implicit declaration =
of function 'epoll_create1'<o:p></o:p></p>
<p class=3D"MsoPlainText">make[3]: *** [compat-epoll.lo] Error 1<o:p></o:p>=
</p>
<p class=3D"MsoPlainText">make[3]: Leaving directory `/root/siverma/2.1.1/l=
ttng-tools-2.2.0-rc1/src/common/compat'<o:p></o:p></p>
<p class=3D"MsoPlainText">make[2]: *** [all-recursive] Error 1<o:p></o:p></=
p>
<p class=3D"MsoPlainText">make[2]: Leaving directory `/root/siverma/2.1.1/l=
ttng-tools-2.2.0-rc1/src/common'<o:p></o:p></p>
<p class=3D"MsoPlainText">make[1]: *** [all-recursive] Error 1<o:p></o:p></=
p>
<p class=3D"MsoPlainText">make[1]: Leaving directory `/root/siverma/2.1.1/l=
ttng-tools-2.2.0-rc1/src'<o:p></o:p></p>
<p class=3D"MsoPlainText">make: *** [all-recursive] Error 1<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">------------------------------------<o:p></o:p></=
p>
<p class=3D"MsoPlainText"><span style=3D"background:red;mso-highlight:red">=
I also tried with the previous version of the tool<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><b><span style=3D"background:red;mso-highlight:re=
d">liburcu installed</span></b><span style=3D"background:red;mso-highlight:=
red"> but
<b>getting below dependencies</b> while trying to configure for lttng-ust</=
span><o:p></o:p></p>
<p class=3D"MsoPlainText">------------------------------------<o:p></o:p></=
p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><span style=3D"background:red;mso-highlight:red">=
Error Logs lttng-ust-1.9.2 &amp;&amp; lttng-tools-2.0.0-rc1 &amp;&amp; user=
space-rcu-0.6.6 ::</span><o:p></o:p></p>
<p class=3D"MsoPlainText">------------------------------------<o:p></o:p></=
p>
<p class=3D"MsoPlainText">------------------------------------<o:p></o:p></=
p>
<p class=3D"MsoPlainText">checking for GNU libc compatible malloc... yes<o:=
p></o:p></p>
<p class=3D"MsoPlainText">checking for gettimeofday... yes<o:p></o:p></p>
<p class=3D"MsoPlainText">checking for munmap... yes<o:p></o:p></p>
<p class=3D"MsoPlainText">checking for socket... yes<o:p></o:p></p>
<p class=3D"MsoPlainText">checking for strerror... yes<o:p></o:p></p>
<p class=3D"MsoPlainText">checking for strtol... yes<o:p></o:p></p>
<p class=3D"MsoPlainText">checking for makeinfo... no<o:p></o:p></p>
<p class=3D"MsoPlainText">configure: error: <b>Please install the 'texinfo'=
 program and make sure 'makeinfo' is in the PATH</b>.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-------------------------------------------------=
-------<o:p></o:p></p>
<p class=3D"MsoPlainText">-------------------------------------------------=
-------<span style=3D"color:#1F497D"><o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"color:#1F497D;background:yellow;ms=
o-highlight:yellow"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"color:#1F497D;background:yellow;ms=
o-highlight:yellow">I</span><span style=3D"background:yellow;mso-highlight:=
yellow">t seems there are many dependencies involved in the installation of=
 the LTTng, some of them are as follows;</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Texinfo<o:p></o:p></p>
<p class=3D"MsoPlainText">Makeinfo<o:p></o:p></p>
<p class=3D"MsoPlainText">kernel image to 2.6.38 or higher<o:p></o:p></p>
<p class=3D"MsoPlainText">librc<o:p></o:p></p>
<p class=3D"MsoPlainText">libpotp &gt; 1.13<o:p></o:p></p>
<p class=3D"MsoPlainText">tcltk<o:p></o:p></p>
<p class=3D"MsoPlainText">libasprintf<o:p></o:p></p>
<p class=3D"MsoPlainText">gettext<o:p></o:p></p>
<p class=3D"MsoPlainText">gc&#43;&#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">glib 2.34.0 and some more packages.<o:p></o:p></p=
>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><span style=3D"background:yellow;mso-highlight:ye=
llow">Do we have to download and cross compile them all for ppc or we can g=
et some help from
<span style=3D"color:#1F497D">standard package managers for</span> the same=
?</span><o:p></o:p></p>
<p class=3D"MsoPlainText">As of now the kernel used in <span style=3D"color=
:#1F497D">
machine</span> is &#8220;3.4.3-rt13&#8221;<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><b>[root@172.27.4.128]# uname -a <o:p></o:p></b><=
/p>
<p class=3D"MsoPlainText"><b>Linux 172.27.4.128 3.4.3-rt13 #1 SMP PREEMPT R=
T Sat Feb 23 09:46:06 CST 2013 ppc ppc ppc GNU/Linux<o:p></o:p></b></p>
<p class=3D"MsoPlainText"><b><o:p>&nbsp;</o:p></b></p>
<p class=3D"MsoPlainText"><span style=3D"background:yellow;mso-highlight:ye=
llow">As per my observations it may take a lot of time to resolve them all =
as we have to decide all the correct supporting packages
<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"background:yellow;mso-highlight:ye=
llow">with the correct releases in order to make them work for a particular=
 Linux image, though its easy to resolve it by using
<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"background:yellow;mso-highlight:ye=
llow">standard package managers in latest Linux e.g. UBUNTU.</span><o:p></o=
:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Please suggest on the same.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:#222222;mso-fareast-language:EN-IN">=
Regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:#222222;mso-fareast-language:EN-IN">=
Siddharth Verma<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:#222222;mso-fareast-language:EN-IN">=
Mobile: &#43;91-9880621252<o:p></o:p></span></p>
<p class=3D"MsoNormal"><u><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,&quot;sans-serif&quot;;color:#1155CC;mso-fareast-language:EN-I=
N"><a href=3D"mailto:siddharth.verma@radisys.com">siddharth.verma@radisys.c=
om</a><o:p></o:p></span></u></p>
</div>
</body>
</html>

--_000_A492A571B9D6304983C4106E4956338D04C3A87DBLUPRD0811MB426_--


--===============0534716184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0534716184==--
