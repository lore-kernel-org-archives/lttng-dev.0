From: abhishekk@uurmi.com
Subject: Error while building lttng-tools-2.9 from source for
	raspberry pi platform.
Date: Mon, 03 Apr 2017 11:58:51 +0530
Message-ID: <ebb9ca90e9e5a099e960dea7ff399119103d4c8e__7223.53087408027$1491200946$gmane$org@mail.uurmi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5735775452373485116=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpout.netcore.co.in (sm23714.nsmailserv.com [202.162.237.14])
 by lists.lttng.org (Postfix) with ESMTPS id 3vxMdW5j1JzvHg
 for <lttng-dev@lists.lttng.org>; Mon,  3 Apr 2017 06:29:18 +0000 (UTC)
Received: from localhost (localdomain [127.0.0.1])
 by pop6.netcore.co.in (Postfix) with ESMTP id F2B686367823F
 for <lttng-dev@lists.lttng.org>; Mon,  3 Apr 2017 11:58:51 +0530 (IST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============5735775452373485116==
Content-Type: multipart/alternative;
 boundary="=_4e170bafd29c03d799f86f07b4d152c7"

--=_4e170bafd29c03d799f86f07b4d152c7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi, =0A=C2=A0=C2=A0=C2=A0 I am trying to build lttng tools version 2.9=
=C2=A0 form source for=0Amy raspberry pi 3 B board, But i am ended up wi=
th some following=0Aassembler error message while doing make.=0A=0A/tmp/=
ccegcSiA.s: Assembler messages:=0A/tmp/ccegcSiA.s:1314: Error: selected=
 processor does not support ARM=0Amode `dmb ish'=0A/tmp/ccegcSiA.s:1333:=
 Error: selected processor does not support ARM=0Amode `dmb ish'=0A/tmp/=
ccegcSiA.s:1344: Error: selected processor does not support ARM=0Amode `=
dmb ish'=0A/tmp/ccegcSiA.s:1721: Error: selected processor does not supp=
ort ARM=0Amode `dmb ish'=0A/tmp/ccegcSiA.s:1740: Error: selected process=
or does not support ARM=0Amode `dmb ish'=0A/tmp/ccegcSiA.s:1751: Error:=
 selected processor does not support ARM=0Amode `dmb ish'=0A/tmp/ccegcSi=
A.s:2108: Error: selected processor does not support ARM=0Amode `dmb ish=
'=0A/tmp/ccegcSiA.s:2127: Error: selected processor does not support ARM=
=0Amode `dmb ish'=0A/tmp/ccegcSiA.s:2138: Error: selected processor does=
 not support ARM=0Amode `dmb ish'=0A/tmp/ccegcSiA.s:2494: Error: selecte=
d processor does not support ARM=0Amode `dmb ish'=0A/tmp/ccegcSiA.s:2513=
: Error: selected processor does not support ARM=0Amode `dmb ish'=0A/tmp=
/ccegcSiA.s:2524: Error: selected processor does not support ARM=0Amode=
 `dmb ish'=0AI there any way to solve this issue, =0Acat /proc/cpuinfo s=
hows following result.=0A=0Aprocessor=C2=A0=C2=A0=C2=A0 : 1=0Amodel name=
=C2=A0=C2=A0=C2=A0 : ARMv7 Processor rev 4 (v7l)=0ABogoMIPS=C2=A0=C2=A0=
=C2=A0 : 38.40=0AFeatures=C2=A0=C2=A0=C2=A0 : half thumb fastmult vfp ed=
sp neon vfpv3 tls vfpv4=0Aidiva idivt vfpd32 lpae evtstrm crc32 =0ACPU i=
mplementer=C2=A0=C2=A0=C2=A0 : 0x41=0ACPU architecture: 7=0ACPU variant=
=C2=A0=C2=A0=C2=A0 : 0x0=0ACPU part=C2=A0=C2=A0=C2=A0 : 0xd03=0ACPU revi=
sion=C2=A0=C2=A0=C2=A0 : 4=0A=0AThanks & Regards=0AAbhishek Kumar=0A7801=
078513 =0A=0A-------------------------=0AEmail sent using E-interact Web=
mail

--=_4e170bafd29c03d799f86f07b4d152c7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-=
serif; font-size: 12px;">Hi, <br />=C2=A0=C2=A0=C2=A0 I am trying to bui=
ld lttng tools version 2.9=C2=A0 form source for my raspberry pi 3 B boa=
rd, But i am ended up with some following assembler error message while=
 doing make.<br /><br />/tmp/ccegcSiA.s: Assembler messages:<br />/tmp/c=
cegcSiA.s:1314: Error: selected processor does not support ARM mode `dmb=
 ish'<br />/tmp/ccegcSiA.s:1333: Error: selected processor does not supp=
ort ARM mode `dmb ish'<br />/tmp/ccegcSiA.s:1344: Error: selected proces=
sor does not support ARM mode `dmb ish'<br />/tmp/ccegcSiA.s:1721: Error=
: selected processor does not support ARM mode `dmb ish'<br />/tmp/ccegc=
SiA.s:1740: Error: selected processor does not support ARM mode `dmb ish=
'<br />/tmp/ccegcSiA.s:1751: Error: selected processor does not support=
 ARM mode `dmb ish'<br />/tmp/ccegcSiA.s:2108: Error: selected processor=
 does not support ARM mode `dmb ish'<br />/tmp/ccegcSiA.s:2127: Error: s=
elected processor does not support ARM mode `dmb ish'<br />/tmp/ccegcSiA=
s:2138: Error: selected processor does not support ARM mode `dmb ish'<b=
r />/tmp/ccegcSiA.s:2494: Error: selected processor does not support ARM=
 mode `dmb ish'<br />/tmp/ccegcSiA.s:2513: Error: selected processor doe=
s not support ARM mode `dmb ish'<br />/tmp/ccegcSiA.s:2524: Error: selec=
ted processor does not support ARM mode `dmb ish'<br />I there any way t=
o solve this issue, <br />cat /proc/cpuinfo shows following result.<br /=
><br />processor=C2=A0=C2=A0=C2=A0 : 1<br />model name=C2=A0=C2=A0=C2=A0=
 : ARMv7 Processor rev 4 (v7l)<br />BogoMIPS=C2=A0=C2=A0=C2=A0 : 38.40<b=
r />Features=C2=A0=C2=A0=C2=A0 : half thumb fastmult vfp edsp neon vfpv3=
 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32 <br />CPU implementer=
=C2=A0=C2=A0=C2=A0 : 0x41<br />CPU architecture: 7<br />CPU variant=C2=
=A0=C2=A0=C2=A0 : 0x0<br />CPU part=C2=A0=C2=A0=C2=A0 : 0xd03<br />CPU r=
evision=C2=A0=C2=A0=C2=A0 : 4<br /><br /><br /><br />Thanks &amp; Regard=
s<br />Abhishek Kumar<br />7801078513 <br /><br /><hr>Email sent using E=
-interact Webmail</body></html>

--=_4e170bafd29c03d799f86f07b4d152c7--


--===============5735775452373485116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5735775452373485116==--
