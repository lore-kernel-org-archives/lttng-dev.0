From: "Kumari, Shilpa (HPSD/VDU/Avatar)" <shilpakumari.pv@hp.com>
Subject: Need help on LTTNG
Date: Tue, 15 Apr 2014 05:27:47 +0000
Message-ID: <4506BB291C8828478C1C5CA492972AB01C129FB5__39181.070138193$1397573624$gmane$org@G6W2500.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0128027747=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from g6t1524.atlanta.hp.com ([15.193.200.67])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <shilpakumari.pv@hp.com>) id 1WZvvY-0006sN-3J
 for lttng-dev@lists.lttng.org; Tue, 15 Apr 2014 01:29:06 -0400
Received: from G6W4001.americas.hpqcorp.net (g6w4001.atlanta.hp.com
 [16.205.80.210]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by g6t1524.atlanta.hp.com (Postfix) with ESMTPS id C018F173
 for <lttng-dev@lists.lttng.org>; Tue, 15 Apr 2014 05:28:54 +0000 (UTC)
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "Kumari, Shilpa (HPSD/VDU/Avatar)" <shilpakumari.pv@hp.com>
List-Id: lttng-dev@lists.lttng.org

--===============0128027747==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_4506BB291C8828478C1C5CA492972AB01C129FB5G6W2500americas_"

--_000_4506BB291C8828478C1C5CA492972AB01C129FB5G6W2500americas_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I am trying to use LTTNG on centos (2.6.32). I have applied the given patch=
 and rebuilt a kernel.
Still I am unable to build the lltng-modules.

[root@million lttng-modules-2.4.0]# uname -r
2.6.32-431.5.1.el6.hpsp.centos.LTTNG.18852.x86_64

Below is the compiler error I am getting,

[root@million lttng-modules-2.4.0]# make
make -C /lib/modules/2.6.32-431.5.1.el6.hpsp.centos.LTTNG.18852.x86_64/buil=
d M=3D/root/LTTNG/lttng-modules-2.4.0 modules
make[1]: Entering directory `/usr/src/kernels/2.6.32-431.5.1.el6.hpsp.cento=
s.LTTNG.18852.x86_64'
  CC [M]  /root/LTTNG/lttng-modules-2.4.0/lttng-ring-buffer-client-discard.=
o
  CC [M]  /root/LTTNG/lttng-modules-2.4.0/lttng-ring-buffer-client-overwrit=
e.o
  CC [M]  /root/LTTNG/lttng-modules-2.4.0/lttng-ring-buffer-metadata-client=
.o
  CC [M]  /root/LTTNG/lttng-modules-2.4.0/lttng-ring-buffer-client-mmap-dis=
card.o
  CC [M]  /root/LTTNG/lttng-modules-2.4.0/lttng-ring-buffer-client-mmap-ove=
rwrite.o
  CC [M]  /root/LTTNG/lttng-modules-2.4.0/lttng-ring-buffer-metadata-mmap-c=
lient.o
  CC [M]  /root/LTTNG/lttng-modules-2.4.0/lttng-statedump-impl.o
In file included from /root/LTTNG/lttng-modules-2.4.0/lttng-statedump-impl.=
c:55:
/root/LTTNG/lttng-modules-2.4.0/wrapper/tracepoint.h: In function =E2wrappe=
r_lttng_fixup_sig=E2:
/root/LTTNG/lttng-modules-2.4.0/wrapper/tracepoint.h:76: error: =E2struct m=
odule=E2 has no member named =E2sig_ok=E2
make[2]: *** [/root/LTTNG/lttng-modules-2.4.0/lttng-statedump-impl.o] Error=
 1
make[1]: *** [_module_/root/LTTNG/lttng-modules-2.4.0] Error 2
make[1]: Leaving directory `/usr/src/kernels/2.6.32-431.5.1.el6.hpsp.centos=
.LTTNG.18852.x86_64'
make: *** [default] Error 2
[root@million lttng-modules-2.4.0]#

Patches provided In lttng-modules/linux-patches/
backport-kallsym-sym-2.6.32.patch               <-- got easily applied with=
 patch command
backport-splice-sym-2.6.32-34.patch             <-- got easily applied with=
 patch command
backport-tracepoint-data-2.6.32-33.patch     <--  Conflicts were found, and=
 I manually edited tracepoint.h file.

Kernel was built by disabling "CONFIG_MODULE_SIG".

Could you please kindly guide me on this issue. Appreciate your help very m=
uch.
Please do let me know, if I need to provide any more info on this.


Thanks and regards,
Shilpa Kumari.P.V


--_000_4506BB291C8828478C1C5CA492972AB01C129FB5G6W2500americas_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
	{mso-style-type:export-only;}
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
<p class=3D"MsoNormal">Hello,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am trying to use LTTNG on centos (2.6.32). I have =
applied the given patch and rebuilt a kernel.<o:p></o:p></p>
<p class=3D"MsoNormal">Still I am unable to build the lltng-modules.<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[root@million lttng-modules-2.4.0]# uname -r<o:p></o=
:p></p>
<p class=3D"MsoNormal"><b>2.6.32-431.5.1.el6.hpsp.centos.LTTNG.18852.x86_64=
<o:p></o:p></b></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Below is the compiler error I am getting,<o:p></o:p>=
</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[root@million lttng-modules-2.4.0]# make<o:p></o:p><=
/p>
<p class=3D"MsoNormal">make -C /lib/modules/2.6.32-431.5.1.el6.hpsp.centos.=
LTTNG.18852.x86_64/build M=3D/root/LTTNG/lttng-modules-2.4.0 modules<o:p></=
o:p></p>
<p class=3D"MsoNormal">make[1]: Entering directory `/usr/src/kernels/2.6.32=
-431.5.1.el6.hpsp.centos.LTTNG.18852.x86_64'<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /root/LTTNG/lttng-modules-2.4.0/=
lttng-ring-buffer-client-discard.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /root/LTTNG/lttng-modules-2.4.0/=
lttng-ring-buffer-client-overwrite.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /root/LTTNG/lttng-modules-2.4.0/=
lttng-ring-buffer-metadata-client.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /root/LTTNG/lttng-modules-2.4.0/=
lttng-ring-buffer-client-mmap-discard.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /root/LTTNG/lttng-modules-2.4.0/=
lttng-ring-buffer-client-mmap-overwrite.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /root/LTTNG/lttng-modules-2.4.0/=
lttng-ring-buffer-metadata-mmap-client.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /root/LTTNG/lttng-modules-2.4.0/=
lttng-statedump-impl.o<o:p></o:p></p>
<p class=3D"MsoNormal">In file included from /root/LTTNG/lttng-modules-2.4.=
0/lttng-statedump-impl.c:55:<o:p></o:p></p>
<p class=3D"MsoNormal">/root/LTTNG/lttng-modules-2.4.0/wrapper/tracepoint.h=
: In function =E2wrapper_lttng_fixup_sig=E2:<o:p></o:p></p>
<p class=3D"MsoNormal">/root/LTTNG/lttng-modules-2.4.0/wrapper/tracepoint.h=
:76: error:
<b>=E2struct module=E2 has no member named =E2sig_ok=E2</b><o:p></o:p></p>
<p class=3D"MsoNormal">make[2]: *** [/root/LTTNG/lttng-modules-2.4.0/lttng-=
statedump-impl.o] Error 1<o:p></o:p></p>
<p class=3D"MsoNormal">make[1]: *** [_module_/root/LTTNG/lttng-modules-2.4.=
0] Error 2<o:p></o:p></p>
<p class=3D"MsoNormal">make[1]: Leaving directory `/usr/src/kernels/2.6.32-=
431.5.1.el6.hpsp.centos.LTTNG.18852.x86_64'<o:p></o:p></p>
<p class=3D"MsoNormal">make: *** [default] Error 2<o:p></o:p></p>
<p class=3D"MsoNormal">[root@million lttng-modules-2.4.0]#<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Patches provided In lttng-modules/linux-patches/<o:p=
></o:p></p>
<p class=3D"MsoNormal">backport-kallsym-sym-2.6.32.patch &nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span sty=
le=3D"font-family:Wingdings">=DF</span> got easily applied with patch comma=
nd<o:p></o:p></p>
<p class=3D"MsoNormal">backport-splice-sym-2.6.32-34.patch &nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style=3D"font=
-family:Wingdings">=DF</span> got easily applied with patch command<o:p></o=
:p></p>
<p class=3D"MsoNormal">backport-tracepoint-data-2.6.32-33.patch&nbsp;&nbsp;=
&nbsp; &nbsp;<span style=3D"font-family:Wingdings">=DF</span> &nbsp;Conflic=
ts were found, and I manually edited tracepoint.h file.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Kernel was built by disabling &#8220;CONFIG_MODULE_S=
IG&#8221;. &nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Could you please kindly guide me on this issue. Appr=
eciate your help very much.<o:p></o:p></p>
<p class=3D"MsoNormal">Please do let me know, if I need to provide any more=
 info on this.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Shilpa Kumari.P.V<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_4506BB291C8828478C1C5CA492972AB01C129FB5G6W2500americas_--


--===============0128027747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0128027747==--
