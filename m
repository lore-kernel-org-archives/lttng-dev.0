From: abhishekk@uurmi.com
Subject: Re: Error while building lttng-tools-2.9 from source
	for raspberry pi platform.
Date: Tue, 04 Apr 2017 09:56:41 +0530
Message-ID: <0d97600af6374bbb560381d7be14adc30e288a1e__5065.76835546202$1491280020$gmane$org@mail.uurmi.com>
References: <20170403153858.GB9081@psrcode-TP-X230>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0441346172641734483=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpout.netcore.co.in (sm23714.nsmailserv.com [202.162.237.14])
 by lists.lttng.org (Postfix) with ESMTPS id 3vxwt51vyRznS
 for <lttng-dev@lists.lttng.org>; Tue,  4 Apr 2017 04:27:08 +0000 (UTC)
in-reply-to: <20170403153858.GB9081@psrcode-TP-X230>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>, abhishekk@uurmi.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0441346172641734483==
Content-Type: multipart/alternative;
 boundary="=_2d210d54de671ff4c7d723a74b918d92"

--=_2d210d54de671ff4c7d723a74b918d92
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

HI, =0A> Are you cross-compiling?=0AI am doing native compilation on ras=
pberry pi=C2=A0 platform. =0A=0A >Did you have any problems building use=
rspace-rcu, lttng-ust,=0Ababeltrace?=0A >Are you only observing these er=
rors on building of the lttng-tools=0Aproject?=0AYes i am facing same pr=
oblem in building lttng-ust. But i am able to=0Abuild successfully babel=
trace and userspace-rcu.=0A=0A >Could you give us more information on th=
e kernel currently used?=0A >The version of gcc?=0A >The distribution in=
formation?=0A=0API@RASPBERRYPI-BKE28DDGW7:~ $ GCC -V=0AUsing built-in sp=
ecs.=0ACOLLECT_GCC=3Dgcc=0ACOLLECT_LTO_WRAPPER=3D/usr/lib/gcc/arm-linux-=
gnueabihf/4.9/lto-wrapper=0ATarget: arm-linux-gnueabihf=0AConfigured wit=
h: ../src/configure -v --with-pkgversion=3D'Raspbian=0A4.9.2-10' --with-=
bugurl=3Dfile:///usr/share/doc/gcc-4.9/README.Bugs=0A--enable-languages=
=3Dc,c++,java,go,d,fortran,objc,obj-c++ --prefix=3D/usr=0A--program-suff=
ix=3D-4.9 --enable-shared --enable-linker-build-id=0A--libexecdir=3D/usr=
/lib --without-included-gettext=0A--enable-threads=3Dposix --with-gxx-in=
clude-dir=3D/usr/include/c++/4.9=0A--libdir=3D/usr/lib --enable-nls --wi=
th-sysroot=3D/ --enable-clocale=3Dgnu=0A--enable-libstdcxx-debug --enabl=
e-libstdcxx-time=3Dyes=0A--enable-gnu-unique-object --disable-libitm --d=
isable-libquadmath=0A--enable-plugin --with-system-zlib --disable-browse=
r-plugin=0A--enable-java-awt=3Dgtk --enable-gtk-cairo=0A--with-java-home=
=3D/usr/lib/jvm/java-1.5.0-gcj-4.9-armhf/jre=0A--enable-java-home=0A--wi=
th-jvm-root-dir=3D/usr/lib/jvm/java-1.5.0-gcj-4.9-armhf=0A--with-jvm-jar=
-dir=3D/usr/lib/jvm-exports/java-1.5.0-gcj-4.9-armhf=0A--with-arch-direc=
tory=3Darm=0A--with-ecj-jar=3D/usr/share/java/eclipse-ecj.jar --enable-o=
bjc-gc=0A--enable-multiarch --disable-sjlj-exceptions --with-arch=3Darmv=
6=0A--with-fpu=3Dvfp --with-float=3Dhard --enable-checking=3Drelease=0A-=
-build=3Darm-linux-gnueabihf --host=3Darm-linux-gnueabihf=0A--target=3Da=
rm-linux-gnueabihf=0AThread model: posix=0Agcc version 4.9.2 (Raspbian 4=
9.2-10)=0A=C2=A0=0API@RASPBERRYPI-BKE28DDGW7:~ $ UNAME -R =0A4.4.44-v7+=
=0A=0API@RASPBERRYPI-BKE28DDGW7:~ $ LSB_RELEASE -A=0ANo LSB modules are=
 available.=0ADistributor ID:=C2=A0=C2=A0=C2=A0 Raspbian=0ADescription:=
=C2=A0=C2=A0=C2=A0 Raspbian GNU/Linux 8.0 (jessie)=0ARelease:=C2=A0=C2=
=A0=C2=A0 8.0=0ACodename:=C2=A0=C2=A0=C2=A0 jessie=0A=0AThanks & Regards=
=0AAbhishek Kumar=0A7801078513 =0A=0A----- Original Message -----=0AFrom=
: "Jonathan Rajotte-Julien" =0ATo:=0ACc:=0ASent:Mon, 3 Apr 2017 11:38:58=
 -0400=0ASubject:Re: [lttng-dev] Error while building lttng-tools-2.9 fr=
om=0Asource for raspberry pi platform.=0A=0A On Mon, Apr 03, 2017 at 11:=
58:51AM +0530, abhishekk@uurmi.com wrote:=0A=0A Hi,=0A=0A > Hi, =0A >=
 =C2=A0=C2=A0=C2=A0 I am trying to build lttng tools version 2.9=C2=A0 f=
orm source=0Afor=0A > my raspberry pi 3 B board, But i am ended up with=
 some following=0A > assembler error message while doing make.=0A=0A Are=
 you cross-compiling?=0A Did you have any problems building userspace-rc=
u, lttng-ust,=0Ababeltrace?=0A Are you only observing these errors on bu=
ilding of the lttng-tools=0Aproject?=0A=0A Could you give us more inform=
ation on the kernel currently used?=0A The version of gcc?=0A The distri=
bution information?=0A=0A > =0A > /tmp/ccegcSiA.s: Assembler messages:=
=0A > /tmp/ccegcSiA.s:1314: Error: selected processor does not support=
=0AARM=0A > mode `dmb ish'=0A > /tmp/ccegcSiA.s:1333: Error: selected pr=
ocessor does not support=0AARM=0A > mode `dmb ish'=0A > /tmp/ccegcSiA.s:=
1344: Error: selected processor does not support=0AARM=0A > mode `dmb is=
h'=0A > /tmp/ccegcSiA.s:1721: Error: selected processor does not support=
=0AARM=0A > mode `dmb ish'=0A > /tmp/ccegcSiA.s:1740: Error: selected pr=
ocessor does not support=0AARM=0A > mode `dmb ish'=0A > /tmp/ccegcSiA.s:=
1751: Error: selected processor does not support=0AARM=0A > mode `dmb is=
h'=0A > /tmp/ccegcSiA.s:2108: Error: selected processor does not support=
=0AARM=0A > mode `dmb ish'=0A > /tmp/ccegcSiA.s:2127: Error: selected pr=
ocessor does not support=0AARM=0A > mode `dmb ish'=0A > /tmp/ccegcSiA.s:=
2138: Error: selected processor does not support=0AARM=0A > mode `dmb is=
h'=0A > /tmp/ccegcSiA.s:2494: Error: selected processor does not support=
=0AARM=0A > mode `dmb ish'=0A > /tmp/ccegcSiA.s:2513: Error: selected pr=
ocessor does not support=0AARM=0A > mode `dmb ish'=0A > /tmp/ccegcSiA.s:=
2524: Error: selected processor does not support=0AARM=0A > mode `dmb is=
h'=0A > I there any way to solve this issue,=0A=0A More information from=
 your end mostly. See the bug reporting=0Aguidelines [1].=0A=0A Cheers=
=0A=0A [1] http://lttng.org/community/#bug-reporting-guidelines=0A=0A >=
 cat /proc/cpuinfo shows following result.=0A > =0A > processor=C2=A0=C2=
=A0=C2=A0 : 1=0A > model name=C2=A0=C2=A0=C2=A0 : ARMv7 Processor rev 4=
 (v7l)=0A > BogoMIPS=C2=A0=C2=A0=C2=A0 : 38.40=0A > Features=C2=A0=C2=A0=
=C2=A0 : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4=0A > idiva id=
ivt vfpd32 lpae evtstrm crc32 =0A > CPU implementer=C2=A0=C2=A0=C2=A0 :=
 0x41=0A > CPU architecture: 7=0A > CPU variant=C2=A0=C2=A0=C2=A0 : 0x0=
=0A > CPU part=C2=A0=C2=A0=C2=A0 : 0xd03=0A > CPU revision=C2=A0=C2=A0=
=C2=A0 : 4=0A > =0A > Thanks & Regards=0A > Abhishek Kumar=0A > 78010785=
13 =0A > =0A > -------------------------=0A > Email sent using E-interac=
t Webmail=0A=0A > _______________________________________________=0A > l=
ttng-dev mailing list=0A > lttng-dev@lists.lttng.org=0A > https://lists.=
lttng.org/cgi-bin/mailman/listinfo/lttng-dev=0A=0A -- =0A Jonathan Rajot=
te-Julien=0A EfficiOS=0A=0A-------------------------=0AEmail sent using=
 E-interact Webmail

--=_2d210d54de671ff4c7d723a74b918d92
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-=
serif; font-size: 12px;">HI, <br />&gt; Are you cross-compiling?<br />I=
 am doing native compilation on raspberry pi=C2=A0 platform. <br /><br /=
>=0A&gt;Did you have any problems building userspace-rcu, lttng-ust, bab=
eltrace?<br />=0A&gt;Are you only observing these errors on building of=
 the lttng-tools project?<br />Yes i am facing same problem in building=
 lttng-ust. But i am able to build successfully babeltrace and userspace=
-rcu.<br /><br />=0A&gt;Could you give us more information on the kernel=
 currently used?<br />=0A&gt;The version of gcc?<br />=0A&gt;The distrib=
ution information?<br /><br /><b>pi@raspberrypi-BKe28DDGW7:~ $ gcc -v</b=
><br />Using built-in specs.<br />COLLECT_GCC=3Dgcc<br />COLLECT_LTO_WRA=
PPER=3D/usr/lib/gcc/arm-linux-gnueabihf/4.9/lto-wrapper<br />Target: arm=
-linux-gnueabihf<br />Configured with: ../src/configure -v --with-pkgver=
sion=3D'Raspbian 4.9.2-10' --with-bugurl=3Dfile:///usr/share/doc/gcc-4.9=
/README.Bugs --enable-languages=3Dc,c++,java,go,d,fortran,objc,obj-c++ -=
-prefix=3D/usr --program-suffix=3D-4.9 --enable-shared --enable-linker-b=
uild-id --libexecdir=3D/usr/lib --without-included-gettext --enable-thre=
ads=3Dposix --with-gxx-include-dir=3D/usr/include/c++/4.9 --libdir=3D/us=
r/lib --enable-nls --with-sysroot=3D/ --enable-clocale=3Dgnu --enable-li=
bstdcxx-debug --enable-libstdcxx-time=3Dyes --enable-gnu-unique-object -=
-disable-libitm --disable-libquadmath --enable-plugin --with-system-zlib=
 --disable-browser-plugin --enable-java-awt=3Dgtk --enable-gtk-cairo --w=
ith-java-home=3D/usr/lib/jvm/java-1.5.0-gcj-4.9-armhf/jre --enable-java-=
home --with-jvm-root-dir=3D/usr/lib/jvm/java-1.5.0-gcj-4.9-armhf --with-=
jvm-jar-dir=3D/usr/lib/jvm-exports/java-1.5.0-gcj-4.9-armhf --with-arch-=
directory=3Darm --with-ecj-jar=3D/usr/share/java/eclipse-ecj.jar --enabl=
e-objc-gc --enable-multiarch --disable-sjlj-exceptions --with-arch=3Darm=
v6 --with-fpu=3Dvfp --with-float=3Dhard --enable-checking=3Drelease --bu=
ild=3Darm-linux-gnueabihf --host=3Darm-linux-gnueabihf --target=3Darm-li=
nux-gnueabihf<br />Thread model: posix<br />gcc version 4.9.2 (Raspbian=
 4.9.2-10)<br />=C2=A0<br /><b>pi@raspberrypi-BKe28DDGW7:~ $ uname -r</b=
> <br />4.4.44-v7+<br /><br /><b>pi@raspberrypi-BKe28DDGW7:~ $ lsb_relea=
se -a</b><br />No LSB modules are available.<br />Distributor ID:=C2=A0=
=C2=A0=C2=A0 Raspbian<br />Description:=C2=A0=C2=A0=C2=A0 Raspbian GNU/L=
inux 8.0 (jessie)<br />Release:=C2=A0=C2=A0=C2=A0 8.0<br />Codename:=C2=
=A0=C2=A0=C2=A0 jessie<br /><br /><br /><br />Thanks &amp; Regards<br />=
Abhishek Kumar<br />7801078513 <br /><br /><blockquote><br />----- Origi=
nal Message -----<br /><div style=3D"width:100%;background:rgb(228,228,2=
28);"><div style=3D"font-weight:bold;">From:</div> "Jonathan Rajotte-Jul=
ien" &lt;jonathan.rajotte-julien@efficios.com&gt;</div><br /><div style=
=3D"font-weight:bold;">To:</div>&lt;abhishekk@uurmi.com&gt;<br /><div st=
yle=3D"font-weight:bold;">Cc:</div>&lt;lttng-dev@lists.lttng.org&gt;<br=
 /><div style=3D"font-weight:bold;">Sent:</div>Mon, 3 Apr 2017 11:38:58=
 -0400<br /><div style=3D"font-weight:bold;">Subject:</div>Re: [lttng-de=
v] Error while building lttng-tools-2.9 from source for raspberry pi pla=
tform.<br /><br /><br />=0AOn Mon, Apr 03, 2017 at 11:58:51AM +0530, abh=
ishekk@uurmi.com wrote:<br /><br />=0AHi,<br /><br />=0A&gt; Hi, <br />=
=0A&gt; =C2=A0=C2=A0=C2=A0 I am trying to build lttng tools version 2.9=
=C2=A0 form source for<br />=0A&gt; my raspberry pi 3 B board, But i am=
 ended up with some following<br />=0A&gt; assembler error message while=
 doing make.<br /><br />=0AAre you cross-compiling?<br />=0ADid you have=
 any problems building userspace-rcu, lttng-ust, babeltrace?<br />=0AAre=
 you only observing these errors on building of the lttng-tools project?=
<br /><br />=0ACould you give us more information on the kernel currentl=
y used?<br />=0AThe version of gcc?<br />=0AThe distribution information=
?<br /><br />=0A&gt; <br />=0A&gt; /tmp/ccegcSiA.s: Assembler messages:<=
br />=0A&gt; /tmp/ccegcSiA.s:1314: Error: selected processor does not su=
pport ARM<br />=0A&gt; mode `dmb ish'<br />=0A&gt; /tmp/ccegcSiA.s:1333:=
 Error: selected processor does not support ARM<br />=0A&gt; mode `dmb i=
sh'<br />=0A&gt; /tmp/ccegcSiA.s:1344: Error: selected processor does no=
t support ARM<br />=0A&gt; mode `dmb ish'<br />=0A&gt; /tmp/ccegcSiA.s:1=
721: Error: selected processor does not support ARM<br />=0A&gt; mode `d=
mb ish'<br />=0A&gt; /tmp/ccegcSiA.s:1740: Error: selected processor doe=
s not support ARM<br />=0A&gt; mode `dmb ish'<br />=0A&gt; /tmp/ccegcSiA=
s:1751: Error: selected processor does not support ARM<br />=0A&gt; mod=
e `dmb ish'<br />=0A&gt; /tmp/ccegcSiA.s:2108: Error: selected processor=
 does not support ARM<br />=0A&gt; mode `dmb ish'<br />=0A&gt; /tmp/cceg=
cSiA.s:2127: Error: selected processor does not support ARM<br />=0A&gt;=
 mode `dmb ish'<br />=0A&gt; /tmp/ccegcSiA.s:2138: Error: selected proce=
ssor does not support ARM<br />=0A&gt; mode `dmb ish'<br />=0A&gt; /tmp/=
ccegcSiA.s:2494: Error: selected processor does not support ARM<br />=0A=
&gt; mode `dmb ish'<br />=0A&gt; /tmp/ccegcSiA.s:2513: Error: selected p=
rocessor does not support ARM<br />=0A&gt; mode `dmb ish'<br />=0A&gt; /=
tmp/ccegcSiA.s:2524: Error: selected processor does not support ARM<br /=
>=0A&gt; mode `dmb ish'<br />=0A&gt; I there any way to solve this issue=
,<br /><br />=0AMore information from your end mostly. See the bug repor=
ting guidelines [1].<br /><br />=0ACheers<br /><br />=0A[1] http://lttng=
org/community/#bug-reporting-guidelines<br /><br />=0A&gt; cat /proc/cp=
uinfo shows following result.<br />=0A&gt; <br />=0A&gt; processor=C2=A0=
=C2=A0=C2=A0 : 1<br />=0A&gt; model name=C2=A0=C2=A0=C2=A0 : ARMv7 Proce=
ssor rev 4 (v7l)<br />=0A&gt; BogoMIPS=C2=A0=C2=A0=C2=A0 : 38.40<br />=
=0A&gt; Features=C2=A0=C2=A0=C2=A0 : half thumb fastmult vfp edsp neon v=
fpv3 tls vfpv4<br />=0A&gt; idiva idivt vfpd32 lpae evtstrm crc32 <br />=
=0A&gt; CPU implementer=C2=A0=C2=A0=C2=A0 : 0x41<br />=0A&gt; CPU archit=
ecture: 7<br />=0A&gt; CPU variant=C2=A0=C2=A0=C2=A0 : 0x0<br />=0A&gt;=
 CPU part=C2=A0=C2=A0=C2=A0 : 0xd03<br />=0A&gt; CPU revision=C2=A0=C2=
=A0=C2=A0 : 4<br />=0A&gt; <br />=0A&gt; Thanks &amp; Regards<br />=0A&g=
t; Abhishek Kumar<br />=0A&gt; 7801078513 <br />=0A&gt; <br />=0A&gt; --=
-----------------------<br />=0A&gt; Email sent using E-interact Webmail=
<br /><br />=0A&gt; _______________________________________________<br /=
>=0A&gt; lttng-dev mailing list<br />=0A&gt; lttng-dev@lists.lttng.org<b=
r />=0A&gt; https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<b=
r /><br /><br />=0A-- <br />=0AJonathan Rajotte-Julien<br />=0AEfficiOS<=
br /></blockquote><hr>Email sent using E-interact Webmail</body></html>

--=_2d210d54de671ff4c7d723a74b918d92--


--===============0441346172641734483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0441346172641734483==--
