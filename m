From: "D'Alessandro, Luke K" <ldalessa@indiana.edu>
Subject: Re: urcu AC_FUNC_MALLOC fails for cross-compile
Date: Tue, 14 Jun 2016 17:22:29 +0000
Message-ID: <8EFDDA06-A378-4A83-9BB1-77A525D8F17E__535.533324773674$1465924987$gmane$org@indiana.edu>
References: <A96D5DC1-9242-4C88-ADE1-150DCAE62C54@indiana.edu>
 <418211441.35787.1465921264498.JavaMail.zimbra@efficios.com>
 <AB895F8E-7C42-43C6-AA36-CAE3B353E86A@indiana.edu>
 <389089988.35928.1465921999056.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8545337407949641988=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from hartman.uits.indiana.edu (belushi.uits.indiana.edu
 [129.79.1.188])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id D28E0A3823
 for <lttng-dev@lists.lttng.org>; Tue, 14 Jun 2016 17:22:31 +0000 (UTC)
In-Reply-To: <389089988.35928.1465921999056.JavaMail.zimbra@efficios.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8545337407949641988==
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_035C7101-4A11-4F83-B605-2F188B4C9553";
	protocol="application/pgp-signature"; micalg=pgp-sha512

--Apple-Mail=_035C7101-4A11-4F83-B605-2F188B4C9553
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_510706B2-DE34-431C-92E4-BDBD4568DEBC"


--Apple-Mail=_510706B2-DE34-431C-92E4-BDBD4568DEBC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Jun 14, 2016, at 12:33 PM, Mathieu Desnoyers =
<mathieu.desnoyers@efficios.com> wrote:
>=20
> ----- On Jun 14, 2016, at 12:26 PM, Luke K D'Alessandro =
ldalessa@indiana.edu <mailto:ldalessa@indiana.edu> wrote:
>=20
>>> On Jun 14, 2016, at 12:21 PM, Mathieu Desnoyers =
<mathieu.desnoyers@efficios.com>
>>> wrote:
>>>=20
>>> ----- On Jun 14, 2016, at 12:12 PM, Luke K D'Alessandro =
ldalessa@indiana.edu
>>> wrote:
>>>=20
>>>> The AC_FUNC_MALLOC depends on some runtime results which doesn't =
work when cross
>>>> compiling. Google has a bit to say about this and basically the fix =
is to stop
>>>> using the macro. Is there a specific purpose for this check, or =
could it just
>>>> be eliminated from configure.ac?
>>>=20
>>> If we remove this check, we need to ensure that URCU does not depend
>>> on malloc(0) returning non-NULL anywhere.
>>=20
>> Okay, I=E2=80=99m not sure what the implications are this for you. We =
have a test
>> infrastructure that tries to download, build, and link liburcu using =
a cross
>> compiler for 32-bit arm platforms, but it fails because of this =
check. I will
>> try and figure out how to get a binary version of liburcu installed =
permanently
>> somewhere that the cross compiler toolchain can find.
>=20
> Can you give us some details on how it fails ?
>=20
> configure output and config.log

Sure.

git version 5002434419b458f1de889b3ed1110b440d3bf5b0

Config log, configure output, and make output attached. I meant to =
reference this issue (https://github.com/LLNL/ior/issues/4 =
<https://github.com/LLNL/ior/issues/4>) which has the same symptoms I =
see here.

Thanks,
Luke


>=20
> Thanks,
>=20
> Mathieu
>=20
>=20
>>=20
>> Thanks,
>> Luke
>>=20
>>>=20
>>> Thanks,
>>>=20
>>> Mathieu
>>>=20
>>>>=20
>>>> Thanks,
>>>> Luke
>>>>=20
>>>> _______________________________________________
>>>> lttng-dev mailing list
>>>> lttng-dev@lists.lttng.org
>>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>=20
>>> --
>>> Mathieu Desnoyers
>>> EfficiOS Inc.
>>> http://www.efficios.com
>=20
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com <http://www.efficios.com/>

--Apple-Mail=_510706B2-DE34-431C-92E4-BDBD4568DEBC
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_7D76401C-2EC4-42BD-98EA-6EB9D5D93E99"


--Apple-Mail=_7D76401C-2EC4-42BD-98EA-6EB9D5D93E99
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On Jun 14, 2016, at 12:33 PM, Mathieu Desnoyers &lt;<a =
href=3D"mailto:mathieu.desnoyers@efficios.com" =
class=3D"">mathieu.desnoyers@efficios.com</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">----- On Jun 14, 2016, at 12:26 PM, Luke K =
D'Alessandro<span class=3D"Apple-converted-space">&nbsp;</span></span><a =
href=3D"mailto:ldalessa@indiana.edu" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D"">ldalessa@indiana.edu</a><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D""><span =
class=3D"Apple-converted-space">&nbsp;</span>wrote:</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><blockquote type=3D"cite" class=3D"">On Jun 14, 2016, =
at 12:21 PM, Mathieu Desnoyers &lt;<a =
href=3D"mailto:mathieu.desnoyers@efficios.com" =
class=3D"">mathieu.desnoyers@efficios.com</a>&gt;<br class=3D"">wrote:<br =
class=3D""><br class=3D"">----- On Jun 14, 2016, at 12:12 PM, Luke K =
D'Alessandro <a href=3D"mailto:ldalessa@indiana.edu" =
class=3D"">ldalessa@indiana.edu</a><br class=3D"">wrote:<br class=3D""><br=
 class=3D""><blockquote type=3D"cite" class=3D"">The AC_FUNC_MALLOC =
depends on some runtime results which doesn't work when cross<br =
class=3D"">compiling. Google has a bit to say about this and basically =
the fix is to stop<br class=3D"">using the macro. Is there a specific =
purpose for this check, or could it just<br class=3D"">be eliminated =
from configure.ac?<br class=3D""></blockquote><br class=3D"">If we =
remove this check, we need to ensure that URCU does not depend<br =
class=3D"">on malloc(0) returning non-NULL anywhere.<br =
class=3D""></blockquote><br class=3D"">Okay, I=E2=80=99m not sure what =
the implications are this for you. We have a test<br =
class=3D"">infrastructure that tries to download, build, and link =
liburcu using a cross<br class=3D"">compiler for 32-bit arm platforms, =
but it fails because of this check. I will<br class=3D"">try and figure =
out how to get a binary version of liburcu installed permanently<br =
class=3D"">somewhere that the cross compiler toolchain can find.<br =
class=3D""></blockquote><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">Can you give us some details on how it fails =
?</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">configure output =
and config.log</span><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote><div><br =
class=3D""></div><div>Sure.</div><div><br class=3D""></div><div>git =
version&nbsp;<span =
class=3D"">5002434419b458f1de889b3ed1110b440d3bf5b0</span></div><div><br =
class=3D""></div>Config log, configure output, and make output attached. =
I meant to reference this issue (<a =
href=3D"https://github.com/LLNL/ior/issues/4" =
class=3D"">https://github.com/LLNL/ior/issues/4</a>) which has the same =
symptoms I see here.</div><div><br =
class=3D""></div><div>Thanks,</div><div>Luke</div><div><br =
class=3D""></div><div></div></body></html>=

--Apple-Mail=_7D76401C-2EC4-42BD-98EA-6EB9D5D93E99
Content-Disposition: attachment;
	filename=config.log
Content-Type: application/octet-stream;
	name="config.log"
Content-Transfer-Encoding: quoted-printable

This=20file=20contains=20any=20messages=20produced=20by=20compilers=20=
while=0Arunning=20configure,=20to=20aid=20debugging=20if=20configure=20=
makes=20a=20mistake.=0A=0AIt=20was=20created=20by=20userspace-rcu=20=
configure=200.9.0,=20which=20was=0Agenerated=20by=20GNU=20Autoconf=20=
2.69.=20=20Invocation=20command=20line=20was=0A=0A=20=20$=20./configure=20=
--host=3Darm-linux-gnueabihf=20CC=3Darm-linux-gnueabihf-gcc=0A=0A##=20=
---------=20##=0A##=20Platform.=20##=0A##=20---------=20##=0A=0Ahostname=20=
=3D=20gin=0Auname=20-m=20=3D=20x86_64=0Auname=20-r=20=3D=203.2.0-4-amd64=0A=
uname=20-s=20=3D=20Linux=0Auname=20-v=20=3D=20#1=20SMP=20Debian=20=
3.2.41-2=0A=0A/usr/bin/uname=20-p=20=3D=20unknown=0A/bin/uname=20-X=20=20=
=20=20=20=3D=20unknown=0A=0A/bin/arch=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=3D=20unknown=0A/usr/bin/arch=20-k=20=20=20=20=20=20=20=3D=20=
unknown=0A/usr/convex/getsysinfo=20=3D=20unknown=0A/usr/bin/hostinfo=20=20=
=20=20=20=20=3D=20unknown=0A/bin/machine=20=20=20=20=20=20=20=20=20=20=20=
=3D=20unknown=0A/usr/bin/oslevel=20=20=20=20=20=20=20=3D=20unknown=0A=
/bin/universe=20=20=20=20=20=20=20=20=20=20=3D=20unknown=0A=0APATH:=20=
/usr/local/bin=0APATH:=20/usr/bin=0APATH:=20/bin=0APATH:=20=
/usr/local/games=0APATH:=20/usr/games=0A=0A=0A##=20-----------=20##=0A##=20=
Core=20tests.=20##=0A##=20-----------=20##=0A=0Aconfigure:2484:=20=
checking=20build=20system=20type=0Aconfigure:2498:=20result:=20=
x86_64-unknown-linux-gnu=0Aconfigure:2518:=20checking=20host=20system=20=
type=0Aconfigure:2531:=20result:=20arm-unknown-linux-gnueabihf=0A=
configure:2551:=20checking=20target=20system=20type=0Aconfigure:2564:=20=
result:=20arm-unknown-linux-gnueabihf=0Aconfigure:2608:=20checking=20for=20=
a=20BSD-compatible=20install=0Aconfigure:2676:=20result:=20=
/usr/bin/install=20-c=0Aconfigure:2687:=20checking=20whether=20build=20=
environment=20is=20sane=0Aconfigure:2742:=20result:=20yes=0A=
configure:2801:=20checking=20for=20arm-linux-gnueabihf-strip=0A=
configure:2817:=20found=20/usr/bin/arm-linux-gnueabihf-strip=0A=
configure:2828:=20result:=20arm-linux-gnueabihf-strip=0Aconfigure:2893:=20=
checking=20for=20a=20thread-safe=20mkdir=20-p=0Aconfigure:2932:=20=
result:=20/bin/mkdir=20-p=0Aconfigure:2939:=20checking=20for=20gawk=0A=
configure:2955:=20found=20/usr/bin/gawk=0Aconfigure:2966:=20result:=20=
gawk=0Aconfigure:2977:=20checking=20whether=20make=20sets=20$(MAKE)=0A=
configure:2999:=20result:=20yes=0Aconfigure:3028:=20checking=20whether=20=
make=20supports=20nested=20variables=0Aconfigure:3045:=20result:=20yes=0A=
configure:3172:=20checking=20whether=20to=20enable=20maintainer-specific=20=
portions=20of=20Makefiles=0Aconfigure:3181:=20result:=20yes=0A=
configure:3207:=20checking=20whether=20make=20supports=20nested=20=
variables=0Aconfigure:3224:=20result:=20yes=0Aconfigure:3265:=20checking=20=
for=20style=20of=20include=20used=20by=20make=0Aconfigure:3293:=20=
result:=20GNU=0Aconfigure:3324:=20checking=20for=20=
arm-linux-gnueabihf-gcc=0Aconfigure:3351:=20result:=20=
arm-linux-gnueabihf-gcc=0Aconfigure:3620:=20checking=20for=20C=20=
compiler=20version=0Aconfigure:3629:=20arm-linux-gnueabihf-gcc=20=
--version=20>&5=0Aarm-linux-gnueabihf-gcc=20(Debian=205.3.1-8)=205.3.1=20=
20160205=0ACopyright=20(C)=202015=20Free=20Software=20Foundation,=20Inc.=0A=
This=20is=20free=20software;=20see=20the=20source=20for=20copying=20=
conditions.=20=20There=20is=20NO=0Awarranty;=20not=20even=20for=20=
MERCHANTABILITY=20or=20FITNESS=20FOR=20A=20PARTICULAR=20PURPOSE.=0A=0A=
configure:3640:=20$?=20=3D=200=0Aconfigure:3629:=20=
arm-linux-gnueabihf-gcc=20-v=20>&5=0AUsing=20built-in=20specs.=0A=
COLLECT_GCC=3Darm-linux-gnueabihf-gcc=0A=
COLLECT_LTO_WRAPPER=3D/usr/lib/gcc-cross/arm-linux-gnueabihf/5/lto-wrapper=
=0ATarget:=20arm-linux-gnueabihf=0AConfigured=20with:=20../src/configure=20=
-v=20--with-pkgversion=3D'Debian=205.3.1-8'=20=
--with-bugurl=3Dfile:///usr/share/doc/gcc-5/README.Bugs=20=
--enable-languages=3Dc,ada,c++,java,go,d,fortran,objc,obj-c++=20=
--prefix=3D/usr=20--program-suffix=3D-5=20--enable-shared=20=
--enable-linker-build-id=20--libexecdir=3D/usr/lib=20=
--without-included-gettext=20--enable-threads=3Dposix=20=
--libdir=3D/usr/lib=20--enable-nls=20--with-sysroot=3D/=20=
--enable-clocale=3Dgnu=20--enable-libstdcxx-debug=20=
--enable-libstdcxx-time=3Dyes=20--with-default-libstdcxx-abi=3Dnew=20=
--enable-gnu-unique-object=20--disable-libitm=20--disable-libquadmath=20=
--enable-plugin=20--with-system-zlib=20--disable-browser-plugin=20=
--enable-java-awt=3Dgtk=20--enable-gtk-cairo=20=
--with-java-home=3D/usr/lib/jvm/java-1.5.0-gcj-5-armhf-cross/jre=20=
--enable-java-home=20=
--with-jvm-root-dir=3D/usr/lib/jvm/java-1.5.0-gcj-5-armhf-cross=20=
--with-jvm-jar-dir=3D/usr/lib/jvm-exports/java-1.5.0-gcj-5-armhf-cross=20=
--with-arch-directory=3Darm=20=
--with-ecj-jar=3D/usr/share/java/eclipse-ecj.jar=20--disable-libgcj=20=
--enable-objc-gc=20--enable-multiarch=20--disable-sjlj-exceptions=20=
--with-arch=3Darmv7-a=20--with-fpu=3Dvfpv3-d16=20--with-float=3Dhard=20=
--with-mode=3Dthumb=20--enable-checking=3Drelease=20=
--build=3Dx86_64-linux-gnu=20--host=3Dx86_64-linux-gnu=20=
--target=3Darm-linux-gnueabihf=20--program-prefix=3Darm-linux-gnueabihf-=20=
--includedir=3D/usr/arm-linux-gnueabihf/include=0AThread=20model:=20=
posix=0Agcc=20version=205.3.1=2020160205=20(Debian=205.3.1-8)=20=0A=
configure:3640:=20$?=20=3D=200=0Aconfigure:3629:=20=
arm-linux-gnueabihf-gcc=20-V=20>&5=0Aarm-linux-gnueabihf-gcc:=20error:=20=
unrecognized=20command=20line=20option=20'-V'=0Aarm-linux-gnueabihf-gcc:=20=
fatal=20error:=20no=20input=20files=0Acompilation=20terminated.=0A=
configure:3640:=20$?=20=3D=201=0Aconfigure:3629:=20=
arm-linux-gnueabihf-gcc=20-qversion=20>&5=0Aarm-linux-gnueabihf-gcc:=20=
error:=20unrecognized=20command=20line=20option=20'-qversion'=0A=
arm-linux-gnueabihf-gcc:=20fatal=20error:=20no=20input=20files=0A=
compilation=20terminated.=0Aconfigure:3640:=20$?=20=3D=201=0A=
configure:3660:=20checking=20whether=20the=20C=20compiler=20works=0A=
configure:3682:=20arm-linux-gnueabihf-gcc=20=20=20=20conftest.c=20=20>&5=0A=
configure:3686:=20$?=20=3D=200=0Aconfigure:3734:=20result:=20yes=0A=
configure:3737:=20checking=20for=20C=20compiler=20default=20output=20=
file=20name=0Aconfigure:3739:=20result:=20a.out=0Aconfigure:3745:=20=
checking=20for=20suffix=20of=20executables=0Aconfigure:3752:=20=
arm-linux-gnueabihf-gcc=20-o=20conftest=20=20=20=20conftest.c=20=20>&5=0A=
configure:3756:=20$?=20=3D=200=0Aconfigure:3778:=20result:=20=0A=
configure:3800:=20checking=20whether=20we=20are=20cross=20compiling=0A=
configure:3808:=20arm-linux-gnueabihf-gcc=20-o=20conftest=20=20=20=20=
conftest.c=20=20>&5=0Aconfigure:3812:=20$?=20=3D=200=0Aconfigure:3819:=20=
./conftest=0A/lib/ld-linux-armhf.so.3:=20No=20such=20file=20or=20=
directory=0Aconfigure:3823:=20$?=20=3D=20255=0Aconfigure:3838:=20result:=20=
yes=0Aconfigure:3843:=20checking=20for=20suffix=20of=20object=20files=0A=
configure:3865:=20arm-linux-gnueabihf-gcc=20-c=20=20=20conftest.c=20>&5=0A=
configure:3869:=20$?=20=3D=200=0Aconfigure:3890:=20result:=20o=0A=
configure:3894:=20checking=20whether=20we=20are=20using=20the=20GNU=20C=20=
compiler=0Aconfigure:3913:=20arm-linux-gnueabihf-gcc=20-c=20=20=20=
conftest.c=20>&5=0Aconfigure:3913:=20$?=20=3D=200=0Aconfigure:3922:=20=
result:=20yes=0Aconfigure:3931:=20checking=20whether=20=
arm-linux-gnueabihf-gcc=20accepts=20-g=0Aconfigure:3951:=20=
arm-linux-gnueabihf-gcc=20-c=20-g=20=20conftest.c=20>&5=0A=
configure:3951:=20$?=20=3D=200=0Aconfigure:3992:=20result:=20yes=0A=
configure:4009:=20checking=20for=20arm-linux-gnueabihf-gcc=20option=20to=20=
accept=20ISO=20C89=0Aconfigure:4072:=20arm-linux-gnueabihf-gcc=20=20-c=20=
-g=20-O2=20=20conftest.c=20>&5=0Aconfigure:4072:=20$?=20=3D=200=0A=
configure:4085:=20result:=20none=20needed=0Aconfigure:4110:=20checking=20=
whether=20arm-linux-gnueabihf-gcc=20understands=20-c=20and=20-o=20=
together=0Aconfigure:4132:=20arm-linux-gnueabihf-gcc=20-c=20conftest.c=20=
-o=20conftest2.o=0Aconfigure:4135:=20$?=20=3D=200=0Aconfigure:4132:=20=
arm-linux-gnueabihf-gcc=20-c=20conftest.c=20-o=20conftest2.o=0A=
configure:4135:=20$?=20=3D=200=0Aconfigure:4147:=20result:=20yes=0A=
configure:4166:=20checking=20dependency=20style=20of=20=
arm-linux-gnueabihf-gcc=0Aconfigure:4277:=20result:=20gcc3=0A=
configure:4295:=20checking=20for=20thread=20local=20storage=20(TLS)=20=
class=0Aconfigure:4318:=20arm-linux-gnueabihf-gcc=20-o=20conftest=20-g=20=
-O2=20=20=20conftest.c=20=20>&5=0Aconfigure:4318:=20$?=20=3D=200=0A=
configure:4331:=20result:=20__thread=0Aconfigure:4365:=20checking=20how=20=
to=20run=20the=20C=20preprocessor=0Aconfigure:4396:=20=
arm-linux-gnueabihf-gcc=20-E=20=20conftest.c=0Aconfigure:4396:=20$?=20=3D=20=
0=0Aconfigure:4410:=20arm-linux-gnueabihf-gcc=20-E=20=20conftest.c=0A=
conftest.c:13:28:=20fatal=20error:=20ac_nonexistent.h:=20No=20such=20=
file=20or=20directory=0Acompilation=20terminated.=0Aconfigure:4410:=20$?=20=
=3D=201=0Aconfigure:=20failed=20program=20was:=0A|=20/*=20confdefs.h=20=
*/=0A|=20#define=20PACKAGE_NAME=20"userspace-rcu"=0A|=20#define=20=
PACKAGE_TARNAME=20"userspace-rcu"=0A|=20#define=20PACKAGE_VERSION=20=
"0.9.0"=0A|=20#define=20PACKAGE_STRING=20"userspace-rcu=200.9.0"=0A|=20=
#define=20PACKAGE_BUGREPORT=20"mathieu=20dot=20desnoyers=20at=20efficios=20=
dot=20com"=0A|=20#define=20PACKAGE_URL=20"http://liburcu.org/"=0A|=20=
#define=20PACKAGE=20"userspace-rcu"=0A|=20#define=20VERSION=20"0.9.0"=0A=
|=20#define=20TLS=20__thread=0A|=20#define=20CONFIG_RCU_TLS=20__thread=0A=
|=20/*=20end=20confdefs.h.=20=20*/=0A|=20#include=20<ac_nonexistent.h>=0A=
configure:4435:=20result:=20arm-linux-gnueabihf-gcc=20-E=0A=
configure:4455:=20arm-linux-gnueabihf-gcc=20-E=20=20conftest.c=0A=
configure:4455:=20$?=20=3D=200=0Aconfigure:4469:=20=
arm-linux-gnueabihf-gcc=20-E=20=20conftest.c=0Aconftest.c:13:28:=20fatal=20=
error:=20ac_nonexistent.h:=20No=20such=20file=20or=20directory=0A=
compilation=20terminated.=0Aconfigure:4469:=20$?=20=3D=201=0Aconfigure:=20=
failed=20program=20was:=0A|=20/*=20confdefs.h=20*/=0A|=20#define=20=
PACKAGE_NAME=20"userspace-rcu"=0A|=20#define=20PACKAGE_TARNAME=20=
"userspace-rcu"=0A|=20#define=20PACKAGE_VERSION=20"0.9.0"=0A|=20#define=20=
PACKAGE_STRING=20"userspace-rcu=200.9.0"=0A|=20#define=20=
PACKAGE_BUGREPORT=20"mathieu=20dot=20desnoyers=20at=20efficios=20dot=20=
com"=0A|=20#define=20PACKAGE_URL=20"http://liburcu.org/"=0A|=20#define=20=
PACKAGE=20"userspace-rcu"=0A|=20#define=20VERSION=20"0.9.0"=0A|=20=
#define=20TLS=20__thread=0A|=20#define=20CONFIG_RCU_TLS=20__thread=0A|=20=
/*=20end=20confdefs.h.=20=20*/=0A|=20#include=20<ac_nonexistent.h>=0A=
configure:4498:=20checking=20for=20grep=20that=20handles=20long=20lines=20=
and=20-e=0Aconfigure:4556:=20result:=20/bin/grep=0Aconfigure:4561:=20=
checking=20for=20egrep=0Aconfigure:4623:=20result:=20/bin/grep=20-E=0A=
configure:4628:=20checking=20for=20ANSI=20C=20header=20files=0A=
configure:4648:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20=
conftest.c=20>&5=0Aconfigure:4648:=20$?=20=3D=200=0Aconfigure:4732:=20=
result:=20yes=0Aconfigure:4745:=20checking=20for=20sys/types.h=0A=
configure:4745:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20=
conftest.c=20>&5=0Aconfigure:4745:=20$?=20=3D=200=0Aconfigure:4745:=20=
result:=20yes=0Aconfigure:4745:=20checking=20for=20sys/stat.h=0A=
configure:4745:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20=
conftest.c=20>&5=0Aconfigure:4745:=20$?=20=3D=200=0Aconfigure:4745:=20=
result:=20yes=0Aconfigure:4745:=20checking=20for=20stdlib.h=0A=
configure:4745:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20=
conftest.c=20>&5=0Aconfigure:4745:=20$?=20=3D=200=0Aconfigure:4745:=20=
result:=20yes=0Aconfigure:4745:=20checking=20for=20string.h=0A=
configure:4745:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20=
conftest.c=20>&5=0Aconfigure:4745:=20$?=20=3D=200=0Aconfigure:4745:=20=
result:=20yes=0Aconfigure:4745:=20checking=20for=20memory.h=0A=
configure:4745:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20=
conftest.c=20>&5=0Aconfigure:4745:=20$?=20=3D=200=0Aconfigure:4745:=20=
result:=20yes=0Aconfigure:4745:=20checking=20for=20strings.h=0A=
configure:4745:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20=
conftest.c=20>&5=0Aconfigure:4745:=20$?=20=3D=200=0Aconfigure:4745:=20=
result:=20yes=0Aconfigure:4745:=20checking=20for=20inttypes.h=0A=
configure:4745:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20=
conftest.c=20>&5=0Aconfigure:4745:=20$?=20=3D=200=0Aconfigure:4745:=20=
result:=20yes=0Aconfigure:4745:=20checking=20for=20stdint.h=0A=
configure:4745:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20=
conftest.c=20>&5=0Aconfigure:4745:=20$?=20=3D=200=0Aconfigure:4745:=20=
result:=20yes=0Aconfigure:4745:=20checking=20for=20unistd.h=0A=
configure:4745:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20=
conftest.c=20>&5=0Aconfigure:4745:=20$?=20=3D=200=0Aconfigure:4745:=20=
result:=20yes=0Aconfigure:4758:=20checking=20minix/config.h=20usability=0A=
configure:4758:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20=
conftest.c=20>&5=0Aconftest.c:56:26:=20fatal=20error:=20minix/config.h:=20=
No=20such=20file=20or=20directory=0Acompilation=20terminated.=0A=
configure:4758:=20$?=20=3D=201=0Aconfigure:=20failed=20program=20was:=0A=
|=20/*=20confdefs.h=20*/=0A|=20#define=20PACKAGE_NAME=20"userspace-rcu"=0A=
|=20#define=20PACKAGE_TARNAME=20"userspace-rcu"=0A|=20#define=20=
PACKAGE_VERSION=20"0.9.0"=0A|=20#define=20PACKAGE_STRING=20=
"userspace-rcu=200.9.0"=0A|=20#define=20PACKAGE_BUGREPORT=20"mathieu=20=
dot=20desnoyers=20at=20efficios=20dot=20com"=0A|=20#define=20PACKAGE_URL=20=
"http://liburcu.org/"=0A|=20#define=20PACKAGE=20"userspace-rcu"=0A|=20=
#define=20VERSION=20"0.9.0"=0A|=20#define=20TLS=20__thread=0A|=20#define=20=
CONFIG_RCU_TLS=20__thread=0A|=20#define=20STDC_HEADERS=201=0A|=20#define=20=
HAVE_SYS_TYPES_H=201=0A|=20#define=20HAVE_SYS_STAT_H=201=0A|=20#define=20=
HAVE_STDLIB_H=201=0A|=20#define=20HAVE_STRING_H=201=0A|=20#define=20=
HAVE_MEMORY_H=201=0A|=20#define=20HAVE_STRINGS_H=201=0A|=20#define=20=
HAVE_INTTYPES_H=201=0A|=20#define=20HAVE_STDINT_H=201=0A|=20#define=20=
HAVE_UNISTD_H=201=0A|=20/*=20end=20confdefs.h.=20=20*/=0A|=20#include=20=
<stdio.h>=0A|=20#ifdef=20HAVE_SYS_TYPES_H=0A|=20#=20include=20=
<sys/types.h>=0A|=20#endif=0A|=20#ifdef=20HAVE_SYS_STAT_H=0A|=20#=20=
include=20<sys/stat.h>=0A|=20#endif=0A|=20#ifdef=20STDC_HEADERS=0A|=20#=20=
include=20<stdlib.h>=0A|=20#=20include=20<stddef.h>=0A|=20#else=0A|=20#=20=
ifdef=20HAVE_STDLIB_H=0A|=20#=20=20include=20<stdlib.h>=0A|=20#=20endif=0A=
|=20#endif=0A|=20#ifdef=20HAVE_STRING_H=0A|=20#=20if=20!defined=20=
STDC_HEADERS=20&&=20defined=20HAVE_MEMORY_H=0A|=20#=20=20include=20=
<memory.h>=0A|=20#=20endif=0A|=20#=20include=20<string.h>=0A|=20#endif=0A=
|=20#ifdef=20HAVE_STRINGS_H=0A|=20#=20include=20<strings.h>=0A|=20#endif=0A=
|=20#ifdef=20HAVE_INTTYPES_H=0A|=20#=20include=20<inttypes.h>=0A|=20=
#endif=0A|=20#ifdef=20HAVE_STDINT_H=0A|=20#=20include=20<stdint.h>=0A|=20=
#endif=0A|=20#ifdef=20HAVE_UNISTD_H=0A|=20#=20include=20<unistd.h>=0A|=20=
#endif=0A|=20#include=20<minix/config.h>=0Aconfigure:4758:=20result:=20=
no=0Aconfigure:4758:=20checking=20minix/config.h=20presence=0A=
configure:4758:=20arm-linux-gnueabihf-gcc=20-E=20=20conftest.c=0A=
conftest.c:23:26:=20fatal=20error:=20minix/config.h:=20No=20such=20file=20=
or=20directory=0Acompilation=20terminated.=0Aconfigure:4758:=20$?=20=3D=20=
1=0Aconfigure:=20failed=20program=20was:=0A|=20/*=20confdefs.h=20*/=0A|=20=
#define=20PACKAGE_NAME=20"userspace-rcu"=0A|=20#define=20PACKAGE_TARNAME=20=
"userspace-rcu"=0A|=20#define=20PACKAGE_VERSION=20"0.9.0"=0A|=20#define=20=
PACKAGE_STRING=20"userspace-rcu=200.9.0"=0A|=20#define=20=
PACKAGE_BUGREPORT=20"mathieu=20dot=20desnoyers=20at=20efficios=20dot=20=
com"=0A|=20#define=20PACKAGE_URL=20"http://liburcu.org/"=0A|=20#define=20=
PACKAGE=20"userspace-rcu"=0A|=20#define=20VERSION=20"0.9.0"=0A|=20=
#define=20TLS=20__thread=0A|=20#define=20CONFIG_RCU_TLS=20__thread=0A|=20=
#define=20STDC_HEADERS=201=0A|=20#define=20HAVE_SYS_TYPES_H=201=0A|=20=
#define=20HAVE_SYS_STAT_H=201=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20=
#define=20HAVE_STRING_H=201=0A|=20#define=20HAVE_MEMORY_H=201=0A|=20=
#define=20HAVE_STRINGS_H=201=0A|=20#define=20HAVE_INTTYPES_H=201=0A|=20=
#define=20HAVE_STDINT_H=201=0A|=20#define=20HAVE_UNISTD_H=201=0A|=20/*=20=
end=20confdefs.h.=20=20*/=0A|=20#include=20<minix/config.h>=0A=
configure:4758:=20result:=20no=0Aconfigure:4758:=20checking=20for=20=
minix/config.h=0Aconfigure:4758:=20result:=20no=0Aconfigure:4779:=20=
checking=20whether=20it=20is=20safe=20to=20define=20__EXTENSIONS__=0A=
configure:4797:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20=
conftest.c=20>&5=0Aconfigure:4797:=20$?=20=3D=200=0Aconfigure:4804:=20=
result:=20yes=0Aconfigure:4826:=20checking=20for=20=
arm-linux-gnueabihf-gcc=0Aconfigure:4853:=20result:=20=
arm-linux-gnueabihf-gcc=0Aconfigure:5122:=20checking=20for=20C=20=
compiler=20version=0Aconfigure:5131:=20arm-linux-gnueabihf-gcc=20=
--version=20>&5=0Aarm-linux-gnueabihf-gcc=20(Debian=205.3.1-8)=205.3.1=20=
20160205=0ACopyright=20(C)=202015=20Free=20Software=20Foundation,=20Inc.=0A=
This=20is=20free=20software;=20see=20the=20source=20for=20copying=20=
conditions.=20=20There=20is=20NO=0Awarranty;=20not=20even=20for=20=
MERCHANTABILITY=20or=20FITNESS=20FOR=20A=20PARTICULAR=20PURPOSE.=0A=0A=
configure:5142:=20$?=20=3D=200=0Aconfigure:5131:=20=
arm-linux-gnueabihf-gcc=20-v=20>&5=0AUsing=20built-in=20specs.=0A=
COLLECT_GCC=3Darm-linux-gnueabihf-gcc=0A=
COLLECT_LTO_WRAPPER=3D/usr/lib/gcc-cross/arm-linux-gnueabihf/5/lto-wrapper=
=0ATarget:=20arm-linux-gnueabihf=0AConfigured=20with:=20../src/configure=20=
-v=20--with-pkgversion=3D'Debian=205.3.1-8'=20=
--with-bugurl=3Dfile:///usr/share/doc/gcc-5/README.Bugs=20=
--enable-languages=3Dc,ada,c++,java,go,d,fortran,objc,obj-c++=20=
--prefix=3D/usr=20--program-suffix=3D-5=20--enable-shared=20=
--enable-linker-build-id=20--libexecdir=3D/usr/lib=20=
--without-included-gettext=20--enable-threads=3Dposix=20=
--libdir=3D/usr/lib=20--enable-nls=20--with-sysroot=3D/=20=
--enable-clocale=3Dgnu=20--enable-libstdcxx-debug=20=
--enable-libstdcxx-time=3Dyes=20--with-default-libstdcxx-abi=3Dnew=20=
--enable-gnu-unique-object=20--disable-libitm=20--disable-libquadmath=20=
--enable-plugin=20--with-system-zlib=20--disable-browser-plugin=20=
--enable-java-awt=3Dgtk=20--enable-gtk-cairo=20=
--with-java-home=3D/usr/lib/jvm/java-1.5.0-gcj-5-armhf-cross/jre=20=
--enable-java-home=20=
--with-jvm-root-dir=3D/usr/lib/jvm/java-1.5.0-gcj-5-armhf-cross=20=
--with-jvm-jar-dir=3D/usr/lib/jvm-exports/java-1.5.0-gcj-5-armhf-cross=20=
--with-arch-directory=3Darm=20=
--with-ecj-jar=3D/usr/share/java/eclipse-ecj.jar=20--disable-libgcj=20=
--enable-objc-gc=20--enable-multiarch=20--disable-sjlj-exceptions=20=
--with-arch=3Darmv7-a=20--with-fpu=3Dvfpv3-d16=20--with-float=3Dhard=20=
--with-mode=3Dthumb=20--enable-checking=3Drelease=20=
--build=3Dx86_64-linux-gnu=20--host=3Dx86_64-linux-gnu=20=
--target=3Darm-linux-gnueabihf=20--program-prefix=3Darm-linux-gnueabihf-=20=
--includedir=3D/usr/arm-linux-gnueabihf/include=0AThread=20model:=20=
posix=0Agcc=20version=205.3.1=2020160205=20(Debian=205.3.1-8)=20=0A=
configure:5142:=20$?=20=3D=200=0Aconfigure:5131:=20=
arm-linux-gnueabihf-gcc=20-V=20>&5=0Aarm-linux-gnueabihf-gcc:=20error:=20=
unrecognized=20command=20line=20option=20'-V'=0Aarm-linux-gnueabihf-gcc:=20=
fatal=20error:=20no=20input=20files=0Acompilation=20terminated.=0A=
configure:5142:=20$?=20=3D=201=0Aconfigure:5131:=20=
arm-linux-gnueabihf-gcc=20-qversion=20>&5=0Aarm-linux-gnueabihf-gcc:=20=
error:=20unrecognized=20command=20line=20option=20'-qversion'=0A=
arm-linux-gnueabihf-gcc:=20fatal=20error:=20no=20input=20files=0A=
compilation=20terminated.=0Aconfigure:5142:=20$?=20=3D=201=0A=
configure:5146:=20checking=20whether=20we=20are=20using=20the=20GNU=20C=20=
compiler=0Aconfigure:5174:=20result:=20yes=0Aconfigure:5183:=20checking=20=
whether=20arm-linux-gnueabihf-gcc=20accepts=20-g=0Aconfigure:5244:=20=
result:=20yes=0Aconfigure:5261:=20checking=20for=20=
arm-linux-gnueabihf-gcc=20option=20to=20accept=20ISO=20C89=0A=
configure:5337:=20result:=20none=20needed=0Aconfigure:5362:=20checking=20=
whether=20arm-linux-gnueabihf-gcc=20understands=20-c=20and=20-o=20=
together=0Aconfigure:5399:=20result:=20yes=0Aconfigure:5418:=20checking=20=
dependency=20style=20of=20arm-linux-gnueabihf-gcc=0Aconfigure:5529:=20=
result:=20gcc3=0Aconfigure:5548:=20checking=20for=20=
arm-linux-gnueabihf-gcc=20option=20to=20accept=20ISO=20C99=0A=
configure:5697:=20arm-linux-gnueabihf-gcc=20=20-c=20-g=20-O2=20=20=
conftest.c=20>&5=0Aconfigure:5697:=20$?=20=3D=200=0Aconfigure:5710:=20=
result:=20none=20needed=0Aconfigure:5818:=20checking=20for=20=
arm-linux-gnueabihf-gcc=20option=20to=20accept=20ISO=20Standard=20C=0A=
configure:5829:=20result:=20none=20needed=0Aconfigure:5842:=20checking=20=
for=20gawk=0Aconfigure:5869:=20result:=20gawk=0Aconfigure:5880:=20=
checking=20whether=20make=20sets=20$(MAKE)=0Aconfigure:5902:=20result:=20=
yes=0Aconfigure:5915:=20checking=20for=20nproc=0Aconfigure:5931:=20found=20=
/usr/bin/nproc=0Aconfigure:5942:=20result:=20nproc=0Aconfigure:5999:=20=
checking=20how=20to=20print=20strings=0Aconfigure:6026:=20result:=20=
printf=0Aconfigure:6047:=20checking=20for=20a=20sed=20that=20does=20not=20=
truncate=20output=0Aconfigure:6111:=20result:=20/bin/sed=0A=
configure:6129:=20checking=20for=20fgrep=0Aconfigure:6191:=20result:=20=
/bin/grep=20-F=0Aconfigure:6226:=20checking=20for=20ld=20used=20by=20=
arm-linux-gnueabihf-gcc=0Aconfigure:6293:=20result:=20=
/usr/arm-linux-gnueabihf/bin/ld=0Aconfigure:6300:=20checking=20if=20the=20=
linker=20(/usr/arm-linux-gnueabihf/bin/ld)=20is=20GNU=20ld=0A=
configure:6315:=20result:=20yes=0Aconfigure:6327:=20checking=20for=20=
BSD-=20or=20MS-compatible=20name=20lister=20(nm)=0Aconfigure:6381:=20=
result:=20/usr/bin/arm-linux-gnueabihf-nm=20-B=0Aconfigure:6511:=20=
checking=20the=20name=20lister=20(/usr/bin/arm-linux-gnueabihf-nm=20-B)=20=
interface=0Aconfigure:6518:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20=
conftest.c=20>&5=0Aconfigure:6521:=20/usr/bin/arm-linux-gnueabihf-nm=20=
-B=20"conftest.o"=0Aconfigure:6524:=20output=0A00000000=20B=20=
some_variable=0Aconfigure:6531:=20result:=20BSD=20nm=0Aconfigure:6534:=20=
checking=20whether=20ln=20-s=20works=0Aconfigure:6538:=20result:=20yes=0A=
configure:6546:=20checking=20the=20maximum=20length=20of=20command=20=
line=20arguments=0Aconfigure:6677:=20result:=201572864=0Aconfigure:6725:=20=
checking=20how=20to=20convert=20x86_64-unknown-linux-gnu=20file=20names=20=
to=20arm-unknown-linux-gnueabihf=20format=0Aconfigure:6765:=20result:=20=
func_convert_file_noop=0Aconfigure:6772:=20checking=20how=20to=20convert=20=
x86_64-unknown-linux-gnu=20file=20names=20to=20toolchain=20format=0A=
configure:6792:=20result:=20func_convert_file_noop=0Aconfigure:6799:=20=
checking=20for=20/usr/arm-linux-gnueabihf/bin/ld=20option=20to=20reload=20=
object=20files=0Aconfigure:6806:=20result:=20-r=0Aconfigure:6840:=20=
checking=20for=20arm-linux-gnueabihf-objdump=0Aconfigure:6856:=20found=20=
/usr/bin/arm-linux-gnueabihf-objdump=0Aconfigure:6867:=20result:=20=
arm-linux-gnueabihf-objdump=0Aconfigure:6939:=20checking=20how=20to=20=
recognize=20dependent=20libraries=0Aconfigure:7139:=20result:=20pass_all=0A=
configure:7184:=20checking=20for=20arm-linux-gnueabihf-dlltool=0A=
configure:7214:=20result:=20no=0Aconfigure:7224:=20checking=20for=20=
dlltool=0Aconfigure:7254:=20result:=20no=0Aconfigure:7284:=20checking=20=
how=20to=20associate=20runtime=20and=20link=20libraries=0A=
configure:7311:=20result:=20printf=20%s\n=0Aconfigure:7327:=20checking=20=
for=20arm-linux-gnueabihf-ar=0Aconfigure:7343:=20found=20=
/usr/bin/arm-linux-gnueabihf-ar=0Aconfigure:7354:=20result:=20=
arm-linux-gnueabihf-ar=0Aconfigure:7435:=20checking=20for=20archiver=20=
@FILE=20support=0Aconfigure:7452:=20arm-linux-gnueabihf-gcc=20-c=20-g=20=
-O2=20=20conftest.c=20>&5=0Aconfigure:7452:=20$?=20=3D=200=0A=
configure:7455:=20arm-linux-gnueabihf-ar=20cru=20libconftest.a=20=
@conftest.lst=20>&5=0Aarm-linux-gnueabihf-ar:=20`u'=20modifier=20ignored=20=
since=20`D'=20is=20the=20default=20(see=20`U')=0Aconfigure:7458:=20$?=20=
=3D=200=0Aconfigure:7463:=20arm-linux-gnueabihf-ar=20cru=20libconftest.a=20=
@conftest.lst=20>&5=0Aarm-linux-gnueabihf-ar:=20`u'=20modifier=20ignored=20=
since=20`D'=20is=20the=20default=20(see=20`U')=0Aarm-linux-gnueabihf-ar:=20=
conftest.o:=20No=20such=20file=20or=20directory=0Aconfigure:7466:=20$?=20=
=3D=201=0Aconfigure:7478:=20result:=20@=0Aconfigure:7496:=20checking=20=
for=20arm-linux-gnueabihf-strip=0Aconfigure:7523:=20result:=20=
arm-linux-gnueabihf-strip=0Aconfigure:7595:=20checking=20for=20=
arm-linux-gnueabihf-ranlib=0Aconfigure:7611:=20found=20=
/usr/bin/arm-linux-gnueabihf-ranlib=0Aconfigure:7622:=20result:=20=
arm-linux-gnueabihf-ranlib=0Aconfigure:7764:=20checking=20command=20to=20=
parse=20/usr/bin/arm-linux-gnueabihf-nm=20-B=20output=20from=20=
arm-linux-gnueabihf-gcc=20object=0Aconfigure:7917:=20=
arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20conftest.c=20>&5=0A=
configure:7920:=20$?=20=3D=200=0Aconfigure:7924:=20=
/usr/bin/arm-linux-gnueabihf-nm=20-B=20conftest.o=20\|=20sed=20-n=20-e=20=
's/^.*[=20]\([ABCDGIRSTW][ABCDGIRSTW]*\)[=20][=20=
]*\([_A-Za-z][_A-Za-z0-9]*\)$/\1=20\2=20\2/p'=20|=20sed=20'/=20=
__gnu_lto/d'=20\>=20conftest.nm=0Aconfigure:7927:=20$?=20=3D=200=0A=
configure:7993:=20arm-linux-gnueabihf-gcc=20-o=20conftest=20-g=20-O2=20=20=
=20conftest.c=20conftstm.o=20>&5=0Aconfigure:7996:=20$?=20=3D=200=0A=
configure:8034:=20result:=20ok=0Aconfigure:8081:=20checking=20for=20=
sysroot=0Aconfigure:8111:=20result:=20no=0Aconfigure:8118:=20checking=20=
for=20a=20working=20dd=0Aconfigure:8156:=20result:=20/bin/dd=0A=
configure:8160:=20checking=20how=20to=20truncate=20binary=20pipes=0A=
configure:8175:=20result:=20/bin/dd=20bs=3D4096=20count=3D1=0A=
configure:8464:=20checking=20for=20arm-linux-gnueabihf-mt=0A=
configure:8494:=20result:=20no=0Aconfigure:8504:=20checking=20for=20mt=0A=
configure:8520:=20found=20/bin/mt=0Aconfigure:8531:=20result:=20mt=0A=
configure:8543:=20WARNING:=20using=20cross=20tools=20not=20prefixed=20=
with=20host=20triplet=0Aconfigure:8554:=20checking=20if=20mt=20is=20a=20=
manifest=20tool=0Aconfigure:8560:=20mt=20'-?'=0Aconfigure:8568:=20=
result:=20no=0Aconfigure:9242:=20checking=20for=20dlfcn.h=0A=
configure:9242:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20=
conftest.c=20>&5=0Aconfigure:9242:=20$?=20=3D=200=0Aconfigure:9242:=20=
result:=20yes=0Aconfigure:9498:=20checking=20for=20objdir=0A=
configure:9513:=20result:=20.libs=0Aconfigure:9777:=20checking=20if=20=
arm-linux-gnueabihf-gcc=20supports=20-fno-rtti=20-fno-exceptions=0A=
configure:9795:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20-fno-rtti=20=
-fno-exceptions=20conftest.c=20>&5=0Acc1:=20warning:=20command=20line=20=
option=20'-fno-rtti'=20is=20valid=20for=20C++/ObjC++=20but=20not=20for=20=
C=0Aconfigure:9799:=20$?=20=3D=200=0Aconfigure:9812:=20result:=20no=0A=
configure:10170:=20checking=20for=20arm-linux-gnueabihf-gcc=20option=20=
to=20produce=20PIC=0Aconfigure:10177:=20result:=20-fPIC=20-DPIC=0A=
configure:10185:=20checking=20if=20arm-linux-gnueabihf-gcc=20PIC=20flag=20=
-fPIC=20-DPIC=20works=0Aconfigure:10203:=20arm-linux-gnueabihf-gcc=20-c=20=
-g=20-O2=20=20-fPIC=20-DPIC=20-DPIC=20conftest.c=20>&5=0A=
configure:10207:=20$?=20=3D=200=0Aconfigure:10220:=20result:=20yes=0A=
configure:10249:=20checking=20if=20arm-linux-gnueabihf-gcc=20static=20=
flag=20-static=20works=0Aconfigure:10277:=20result:=20yes=0A=
configure:10292:=20checking=20if=20arm-linux-gnueabihf-gcc=20supports=20=
-c=20-o=20file.o=0Aconfigure:10313:=20arm-linux-gnueabihf-gcc=20-c=20-g=20=
-O2=20=20-o=20out/conftest2.o=20conftest.c=20>&5=0Aconfigure:10317:=20$?=20=
=3D=200=0Aconfigure:10339:=20result:=20yes=0Aconfigure:10347:=20checking=20=
if=20arm-linux-gnueabihf-gcc=20supports=20-c=20-o=20file.o=0A=
configure:10394:=20result:=20yes=0Aconfigure:10427:=20checking=20whether=20=
the=20arm-linux-gnueabihf-gcc=20linker=20=
(/usr/arm-linux-gnueabihf/bin/ld)=20supports=20shared=20libraries=0A=
configure:11686:=20result:=20yes=0Aconfigure:11723:=20checking=20whether=20=
-lc=20should=20be=20explicitly=20linked=20in=0Aconfigure:11731:=20=
arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20conftest.c=20>&5=0A=
configure:11734:=20$?=20=3D=200=0Aconfigure:11749:=20=
arm-linux-gnueabihf-gcc=20-shared=20=20-fPIC=20-DPIC=20conftest.o=20=20=
-v=20-Wl,-soname=20-Wl,conftest=20-o=20conftest=202\>\&1=20\|=20=
/bin/grep=20=20-lc=20=20\>/dev/null=202\>\&1=0Aconfigure:11752:=20$?=20=3D=
=200=0Aconfigure:11766:=20result:=20no=0Aconfigure:11926:=20checking=20=
dynamic=20linker=20characteristics=0Aconfigure:12507:=20=
arm-linux-gnueabihf-gcc=20-o=20conftest=20-g=20-O2=20=20=20-Wl,-rpath=20=
-Wl,/foo=20conftest.c=20=20>&5=0Aconfigure:12507:=20$?=20=3D=200=0A=
configure:12744:=20result:=20GNU/Linux=20ld.so=0Aconfigure:12866:=20=
checking=20how=20to=20hardcode=20library=20paths=20into=20programs=0A=
configure:12891:=20result:=20immediate=0Aconfigure:13439:=20checking=20=
whether=20stripping=20libraries=20is=20possible=0Aconfigure:13444:=20=
result:=20yes=0Aconfigure:13479:=20checking=20if=20libtool=20supports=20=
shared=20libraries=0Aconfigure:13481:=20result:=20yes=0Aconfigure:13484:=20=
checking=20whether=20to=20build=20shared=20libraries=0Aconfigure:13509:=20=
result:=20yes=0Aconfigure:13512:=20checking=20whether=20to=20build=20=
static=20libraries=0Aconfigure:13516:=20result:=20yes=0Aconfigure:13555:=20=
checking=20for=20inline=0Aconfigure:13571:=20arm-linux-gnueabihf-gcc=20=
-c=20-g=20-O2=20=20conftest.c=20>&5=0Aconfigure:13571:=20$?=20=3D=200=0A=
configure:13579:=20result:=20inline=0Aconfigure:13597:=20checking=20for=20=
pid_t=0Aconfigure:13597:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20=
conftest.c=20>&5=0Aconfigure:13597:=20$?=20=3D=200=0Aconfigure:13597:=20=
arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20conftest.c=20>&5=0A=
conftest.c:=20In=20function=20'main':=0Aconftest.c:66:20:=20error:=20=
expected=20expression=20before=20')'=20token=0A=20if=20(sizeof=20=
((pid_t)))=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
^=0Aconfigure:13597:=20$?=20=3D=201=0Aconfigure:=20failed=20program=20=
was:=0A|=20/*=20confdefs.h=20*/=0A|=20#define=20PACKAGE_NAME=20=
"userspace-rcu"=0A|=20#define=20PACKAGE_TARNAME=20"userspace-rcu"=0A|=20=
#define=20PACKAGE_VERSION=20"0.9.0"=0A|=20#define=20PACKAGE_STRING=20=
"userspace-rcu=200.9.0"=0A|=20#define=20PACKAGE_BUGREPORT=20"mathieu=20=
dot=20desnoyers=20at=20efficios=20dot=20com"=0A|=20#define=20PACKAGE_URL=20=
"http://liburcu.org/"=0A|=20#define=20PACKAGE=20"userspace-rcu"=0A|=20=
#define=20VERSION=20"0.9.0"=0A|=20#define=20TLS=20__thread=0A|=20#define=20=
CONFIG_RCU_TLS=20__thread=0A|=20#define=20STDC_HEADERS=201=0A|=20#define=20=
HAVE_SYS_TYPES_H=201=0A|=20#define=20HAVE_SYS_STAT_H=201=0A|=20#define=20=
HAVE_STDLIB_H=201=0A|=20#define=20HAVE_STRING_H=201=0A|=20#define=20=
HAVE_MEMORY_H=201=0A|=20#define=20HAVE_STRINGS_H=201=0A|=20#define=20=
HAVE_INTTYPES_H=201=0A|=20#define=20HAVE_STDINT_H=201=0A|=20#define=20=
HAVE_UNISTD_H=201=0A|=20#define=20__EXTENSIONS__=201=0A|=20#define=20=
_ALL_SOURCE=201=0A|=20#define=20_GNU_SOURCE=201=0A|=20#define=20=
_POSIX_PTHREAD_SEMANTICS=201=0A|=20#define=20_TANDEM_SOURCE=201=0A|=20=
#define=20HAVE_DLFCN_H=201=0A|=20#define=20LT_OBJDIR=20".libs/"=0A|=20/*=20=
end=20confdefs.h.=20=20*/=0A|=20#include=20<stdio.h>=0A|=20#ifdef=20=
HAVE_SYS_TYPES_H=0A|=20#=20include=20<sys/types.h>=0A|=20#endif=0A|=20=
#ifdef=20HAVE_SYS_STAT_H=0A|=20#=20include=20<sys/stat.h>=0A|=20#endif=0A=
|=20#ifdef=20STDC_HEADERS=0A|=20#=20include=20<stdlib.h>=0A|=20#=20=
include=20<stddef.h>=0A|=20#else=0A|=20#=20ifdef=20HAVE_STDLIB_H=0A|=20#=20=
=20include=20<stdlib.h>=0A|=20#=20endif=0A|=20#endif=0A|=20#ifdef=20=
HAVE_STRING_H=0A|=20#=20if=20!defined=20STDC_HEADERS=20&&=20defined=20=
HAVE_MEMORY_H=0A|=20#=20=20include=20<memory.h>=0A|=20#=20endif=0A|=20#=20=
include=20<string.h>=0A|=20#endif=0A|=20#ifdef=20HAVE_STRINGS_H=0A|=20#=20=
include=20<strings.h>=0A|=20#endif=0A|=20#ifdef=20HAVE_INTTYPES_H=0A|=20=
#=20include=20<inttypes.h>=0A|=20#endif=0A|=20#ifdef=20HAVE_STDINT_H=0A|=20=
#=20include=20<stdint.h>=0A|=20#endif=0A|=20#ifdef=20HAVE_UNISTD_H=0A|=20=
#=20include=20<unistd.h>=0A|=20#endif=0A|=20int=0A|=20main=20()=0A|=20{=0A=
|=20if=20(sizeof=20((pid_t)))=0A|=20=09=20=20=20=20return=200;=0A|=20=20=20=
;=0A|=20=20=20return=200;=0A|=20}=0Aconfigure:13597:=20result:=20yes=0A=
configure:13608:=20checking=20for=20size_t=0Aconfigure:13608:=20=
arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20conftest.c=20>&5=0A=
configure:13608:=20$?=20=3D=200=0Aconfigure:13608:=20=
arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20conftest.c=20>&5=0A=
conftest.c:=20In=20function=20'main':=0Aconftest.c:66:21:=20error:=20=
expected=20expression=20before=20')'=20token=0A=20if=20(sizeof=20=
((size_t)))=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20^=0Aconfigure:13608:=20$?=20=3D=201=0Aconfigure:=20failed=20program=20=
was:=0A|=20/*=20confdefs.h=20*/=0A|=20#define=20PACKAGE_NAME=20=
"userspace-rcu"=0A|=20#define=20PACKAGE_TARNAME=20"userspace-rcu"=0A|=20=
#define=20PACKAGE_VERSION=20"0.9.0"=0A|=20#define=20PACKAGE_STRING=20=
"userspace-rcu=200.9.0"=0A|=20#define=20PACKAGE_BUGREPORT=20"mathieu=20=
dot=20desnoyers=20at=20efficios=20dot=20com"=0A|=20#define=20PACKAGE_URL=20=
"http://liburcu.org/"=0A|=20#define=20PACKAGE=20"userspace-rcu"=0A|=20=
#define=20VERSION=20"0.9.0"=0A|=20#define=20TLS=20__thread=0A|=20#define=20=
CONFIG_RCU_TLS=20__thread=0A|=20#define=20STDC_HEADERS=201=0A|=20#define=20=
HAVE_SYS_TYPES_H=201=0A|=20#define=20HAVE_SYS_STAT_H=201=0A|=20#define=20=
HAVE_STDLIB_H=201=0A|=20#define=20HAVE_STRING_H=201=0A|=20#define=20=
HAVE_MEMORY_H=201=0A|=20#define=20HAVE_STRINGS_H=201=0A|=20#define=20=
HAVE_INTTYPES_H=201=0A|=20#define=20HAVE_STDINT_H=201=0A|=20#define=20=
HAVE_UNISTD_H=201=0A|=20#define=20__EXTENSIONS__=201=0A|=20#define=20=
_ALL_SOURCE=201=0A|=20#define=20_GNU_SOURCE=201=0A|=20#define=20=
_POSIX_PTHREAD_SEMANTICS=201=0A|=20#define=20_TANDEM_SOURCE=201=0A|=20=
#define=20HAVE_DLFCN_H=201=0A|=20#define=20LT_OBJDIR=20".libs/"=0A|=20/*=20=
end=20confdefs.h.=20=20*/=0A|=20#include=20<stdio.h>=0A|=20#ifdef=20=
HAVE_SYS_TYPES_H=0A|=20#=20include=20<sys/types.h>=0A|=20#endif=0A|=20=
#ifdef=20HAVE_SYS_STAT_H=0A|=20#=20include=20<sys/stat.h>=0A|=20#endif=0A=
|=20#ifdef=20STDC_HEADERS=0A|=20#=20include=20<stdlib.h>=0A|=20#=20=
include=20<stddef.h>=0A|=20#else=0A|=20#=20ifdef=20HAVE_STDLIB_H=0A|=20#=20=
=20include=20<stdlib.h>=0A|=20#=20endif=0A|=20#endif=0A|=20#ifdef=20=
HAVE_STRING_H=0A|=20#=20if=20!defined=20STDC_HEADERS=20&&=20defined=20=
HAVE_MEMORY_H=0A|=20#=20=20include=20<memory.h>=0A|=20#=20endif=0A|=20#=20=
include=20<string.h>=0A|=20#endif=0A|=20#ifdef=20HAVE_STRINGS_H=0A|=20#=20=
include=20<strings.h>=0A|=20#endif=0A|=20#ifdef=20HAVE_INTTYPES_H=0A|=20=
#=20include=20<inttypes.h>=0A|=20#endif=0A|=20#ifdef=20HAVE_STDINT_H=0A|=20=
#=20include=20<stdint.h>=0A|=20#endif=0A|=20#ifdef=20HAVE_UNISTD_H=0A|=20=
#=20include=20<unistd.h>=0A|=20#endif=0A|=20int=0A|=20main=20()=0A|=20{=0A=
|=20if=20(sizeof=20((size_t)))=0A|=20=09=20=20=20=20return=200;=0A|=20=20=
=20;=0A|=20=20=20return=200;=0A|=20}=0Aconfigure:13608:=20result:=20yes=0A=
configure:13619:=20checking=20for=20ssize_t=0Aconfigure:13619:=20=
arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20conftest.c=20>&5=0A=
configure:13619:=20$?=20=3D=200=0Aconfigure:13619:=20=
arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20conftest.c=20>&5=0A=
conftest.c:=20In=20function=20'main':=0Aconftest.c:66:22:=20error:=20=
expected=20expression=20before=20')'=20token=0A=20if=20(sizeof=20=
((ssize_t)))=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20^=0Aconfigure:13619:=20$?=20=3D=201=0Aconfigure:=20failed=20=
program=20was:=0A|=20/*=20confdefs.h=20*/=0A|=20#define=20PACKAGE_NAME=20=
"userspace-rcu"=0A|=20#define=20PACKAGE_TARNAME=20"userspace-rcu"=0A|=20=
#define=20PACKAGE_VERSION=20"0.9.0"=0A|=20#define=20PACKAGE_STRING=20=
"userspace-rcu=200.9.0"=0A|=20#define=20PACKAGE_BUGREPORT=20"mathieu=20=
dot=20desnoyers=20at=20efficios=20dot=20com"=0A|=20#define=20PACKAGE_URL=20=
"http://liburcu.org/"=0A|=20#define=20PACKAGE=20"userspace-rcu"=0A|=20=
#define=20VERSION=20"0.9.0"=0A|=20#define=20TLS=20__thread=0A|=20#define=20=
CONFIG_RCU_TLS=20__thread=0A|=20#define=20STDC_HEADERS=201=0A|=20#define=20=
HAVE_SYS_TYPES_H=201=0A|=20#define=20HAVE_SYS_STAT_H=201=0A|=20#define=20=
HAVE_STDLIB_H=201=0A|=20#define=20HAVE_STRING_H=201=0A|=20#define=20=
HAVE_MEMORY_H=201=0A|=20#define=20HAVE_STRINGS_H=201=0A|=20#define=20=
HAVE_INTTYPES_H=201=0A|=20#define=20HAVE_STDINT_H=201=0A|=20#define=20=
HAVE_UNISTD_H=201=0A|=20#define=20__EXTENSIONS__=201=0A|=20#define=20=
_ALL_SOURCE=201=0A|=20#define=20_GNU_SOURCE=201=0A|=20#define=20=
_POSIX_PTHREAD_SEMANTICS=201=0A|=20#define=20_TANDEM_SOURCE=201=0A|=20=
#define=20HAVE_DLFCN_H=201=0A|=20#define=20LT_OBJDIR=20".libs/"=0A|=20/*=20=
end=20confdefs.h.=20=20*/=0A|=20#include=20<stdio.h>=0A|=20#ifdef=20=
HAVE_SYS_TYPES_H=0A|=20#=20include=20<sys/types.h>=0A|=20#endif=0A|=20=
#ifdef=20HAVE_SYS_STAT_H=0A|=20#=20include=20<sys/stat.h>=0A|=20#endif=0A=
|=20#ifdef=20STDC_HEADERS=0A|=20#=20include=20<stdlib.h>=0A|=20#=20=
include=20<stddef.h>=0A|=20#else=0A|=20#=20ifdef=20HAVE_STDLIB_H=0A|=20#=20=
=20include=20<stdlib.h>=0A|=20#=20endif=0A|=20#endif=0A|=20#ifdef=20=
HAVE_STRING_H=0A|=20#=20if=20!defined=20STDC_HEADERS=20&&=20defined=20=
HAVE_MEMORY_H=0A|=20#=20=20include=20<memory.h>=0A|=20#=20endif=0A|=20#=20=
include=20<string.h>=0A|=20#endif=0A|=20#ifdef=20HAVE_STRINGS_H=0A|=20#=20=
include=20<strings.h>=0A|=20#endif=0A|=20#ifdef=20HAVE_INTTYPES_H=0A|=20=
#=20include=20<inttypes.h>=0A|=20#endif=0A|=20#ifdef=20HAVE_STDINT_H=0A|=20=
#=20include=20<stdint.h>=0A|=20#endif=0A|=20#ifdef=20HAVE_UNISTD_H=0A|=20=
#=20include=20<unistd.h>=0A|=20#endif=0A|=20int=0A|=20main=20()=0A|=20{=0A=
|=20if=20(sizeof=20((ssize_t)))=0A|=20=09=20=20=20=20return=200;=0A|=20=20=
=20;=0A|=20=20=20return=200;=0A|=20}=0Aconfigure:13619:=20result:=20yes=0A=
configure:13630:=20checking=20for=20uint16_t=0Aconfigure:13630:=20=
arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20conftest.c=20>&5=0A=
configure:13630:=20$?=20=3D=200=0Aconfigure:13630:=20result:=20yes=0A=
configure:13642:=20checking=20for=20int32_t=0Aconfigure:13642:=20=
arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20conftest.c=20>&5=0A=
configure:13642:=20$?=20=3D=200=0Aconfigure:13642:=20=
arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20conftest.c=20>&5=0A=
conftest.c:=20In=20function=20'main':=0Aconftest.c:68:53:=20warning:=20=
integer=20overflow=20in=20expression=20[-Woverflow]=0A=20=20=20=20<=20=
(int32_t)=20(((((int32_t)=201=20<<=20N)=20<<=20N)=20-=201)=20*=202=20+=20=
2))];=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20^=0Aconftest.c:67:12:=20error:=20storage=20size=20of=20=
'test_array'=20isn't=20constant=0A=20static=20int=20test_array=20[1=20-=20=
2=20*=20!((int32_t)=20(((((int32_t)=201=20<<=20N)=20<<=20N)=20-=201)=20*=20=
2=20+=201)=0A=20=20=20=20=20=20=20=20=20=20=20=20^=0Aconfigure:13642:=20=
$?=20=3D=201=0Aconfigure:=20failed=20program=20was:=0A|=20/*=20=
confdefs.h=20*/=0A|=20#define=20PACKAGE_NAME=20"userspace-rcu"=0A|=20=
#define=20PACKAGE_TARNAME=20"userspace-rcu"=0A|=20#define=20=
PACKAGE_VERSION=20"0.9.0"=0A|=20#define=20PACKAGE_STRING=20=
"userspace-rcu=200.9.0"=0A|=20#define=20PACKAGE_BUGREPORT=20"mathieu=20=
dot=20desnoyers=20at=20efficios=20dot=20com"=0A|=20#define=20PACKAGE_URL=20=
"http://liburcu.org/"=0A|=20#define=20PACKAGE=20"userspace-rcu"=0A|=20=
#define=20VERSION=20"0.9.0"=0A|=20#define=20TLS=20__thread=0A|=20#define=20=
CONFIG_RCU_TLS=20__thread=0A|=20#define=20STDC_HEADERS=201=0A|=20#define=20=
HAVE_SYS_TYPES_H=201=0A|=20#define=20HAVE_SYS_STAT_H=201=0A|=20#define=20=
HAVE_STDLIB_H=201=0A|=20#define=20HAVE_STRING_H=201=0A|=20#define=20=
HAVE_MEMORY_H=201=0A|=20#define=20HAVE_STRINGS_H=201=0A|=20#define=20=
HAVE_INTTYPES_H=201=0A|=20#define=20HAVE_STDINT_H=201=0A|=20#define=20=
HAVE_UNISTD_H=201=0A|=20#define=20__EXTENSIONS__=201=0A|=20#define=20=
_ALL_SOURCE=201=0A|=20#define=20_GNU_SOURCE=201=0A|=20#define=20=
_POSIX_PTHREAD_SEMANTICS=201=0A|=20#define=20_TANDEM_SOURCE=201=0A|=20=
#define=20HAVE_DLFCN_H=201=0A|=20#define=20LT_OBJDIR=20".libs/"=0A|=20/*=20=
end=20confdefs.h.=20=20*/=0A|=20#include=20<stdio.h>=0A|=20#ifdef=20=
HAVE_SYS_TYPES_H=0A|=20#=20include=20<sys/types.h>=0A|=20#endif=0A|=20=
#ifdef=20HAVE_SYS_STAT_H=0A|=20#=20include=20<sys/stat.h>=0A|=20#endif=0A=
|=20#ifdef=20STDC_HEADERS=0A|=20#=20include=20<stdlib.h>=0A|=20#=20=
include=20<stddef.h>=0A|=20#else=0A|=20#=20ifdef=20HAVE_STDLIB_H=0A|=20#=20=
=20include=20<stdlib.h>=0A|=20#=20endif=0A|=20#endif=0A|=20#ifdef=20=
HAVE_STRING_H=0A|=20#=20if=20!defined=20STDC_HEADERS=20&&=20defined=20=
HAVE_MEMORY_H=0A|=20#=20=20include=20<memory.h>=0A|=20#=20endif=0A|=20#=20=
include=20<string.h>=0A|=20#endif=0A|=20#ifdef=20HAVE_STRINGS_H=0A|=20#=20=
include=20<strings.h>=0A|=20#endif=0A|=20#ifdef=20HAVE_INTTYPES_H=0A|=20=
#=20include=20<inttypes.h>=0A|=20#endif=0A|=20#ifdef=20HAVE_STDINT_H=0A|=20=
#=20include=20<stdint.h>=0A|=20#endif=0A|=20#ifdef=20HAVE_UNISTD_H=0A|=20=
#=20include=20<unistd.h>=0A|=20#endif=0A|=20=09=20=20=20=20=20=20=20=20=
enum=20{=20N=20=3D=2032=20/=202=20-=201=20};=0A|=20int=0A|=20main=20()=0A=
|=20{=0A|=20static=20int=20test_array=20[1=20-=202=20*=20!((int32_t)=20=
(((((int32_t)=201=20<<=20N)=20<<=20N)=20-=201)=20*=202=20+=201)=0A|=20=09=
=09=20<=20(int32_t)=20(((((int32_t)=201=20<<=20N)=20<<=20N)=20-=201)=20*=20=
2=20+=202))];=0A|=20test_array=20[0]=20=3D=200;=0A|=20return=20=
test_array=20[0];=0A|=20=0A|=20=20=20;=0A|=20=20=20return=200;=0A|=20}=0A=
configure:13642:=20result:=20yes=0Aconfigure:13653:=20checking=20for=20=
uint32_t=0Aconfigure:13653:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20=
conftest.c=20>&5=0Aconfigure:13653:=20$?=20=3D=200=0Aconfigure:13653:=20=
result:=20yes=0Aconfigure:13667:=20checking=20for=20uint64_t=0A=
configure:13667:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20=
conftest.c=20>&5=0Aconfigure:13667:=20$?=20=3D=200=0Aconfigure:13667:=20=
result:=20yes=0Aconfigure:13681:=20checking=20for=20uint8_t=0A=
configure:13681:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20=
conftest.c=20>&5=0Aconfigure:13681:=20$?=20=3D=200=0Aconfigure:13681:=20=
result:=20yes=0Aconfigure:13697:=20checking=20for=20__attribute__=0A=
configure:13719:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=20=
conftest.c=20>&5=0Aconfigure:13719:=20$?=20=3D=200=0Aconfigure:13728:=20=
result:=20yes=0Aconfigure:13854:=20checking=20if=20compiler=20needs=20=
-Werror=20to=20reject=20unknown=20flags=0Aconfigure:13870:=20=
arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20-Werror=20=
-Wunknown-warning-option=20-Wsizeof-array-argument=20=20conftest.c=20>&5=0A=
arm-linux-gnueabihf-gcc:=20error:=20unrecognized=20command=20line=20=
option=20'-Wunknown-warning-option'=0Aconfigure:13870:=20$?=20=3D=201=0A=
configure:=20failed=20program=20was:=0A|=20/*=20confdefs.h=20*/=0A|=20=
#define=20PACKAGE_NAME=20"userspace-rcu"=0A|=20#define=20PACKAGE_TARNAME=20=
"userspace-rcu"=0A|=20#define=20PACKAGE_VERSION=20"0.9.0"=0A|=20#define=20=
PACKAGE_STRING=20"userspace-rcu=200.9.0"=0A|=20#define=20=
PACKAGE_BUGREPORT=20"mathieu=20dot=20desnoyers=20at=20efficios=20dot=20=
com"=0A|=20#define=20PACKAGE_URL=20"http://liburcu.org/"=0A|=20#define=20=
PACKAGE=20"userspace-rcu"=0A|=20#define=20VERSION=20"0.9.0"=0A|=20=
#define=20TLS=20__thread=0A|=20#define=20CONFIG_RCU_TLS=20__thread=0A|=20=
#define=20STDC_HEADERS=201=0A|=20#define=20HAVE_SYS_TYPES_H=201=0A|=20=
#define=20HAVE_SYS_STAT_H=201=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20=
#define=20HAVE_STRING_H=201=0A|=20#define=20HAVE_MEMORY_H=201=0A|=20=
#define=20HAVE_STRINGS_H=201=0A|=20#define=20HAVE_INTTYPES_H=201=0A|=20=
#define=20HAVE_STDINT_H=201=0A|=20#define=20HAVE_UNISTD_H=201=0A|=20=
#define=20__EXTENSIONS__=201=0A|=20#define=20_ALL_SOURCE=201=0A|=20=
#define=20_GNU_SOURCE=201=0A|=20#define=20_POSIX_PTHREAD_SEMANTICS=201=0A=
|=20#define=20_TANDEM_SOURCE=201=0A|=20#define=20HAVE_DLFCN_H=201=0A|=20=
#define=20LT_OBJDIR=20".libs/"=0A|=20#define=20HAVE___ATTRIBUTE__=201=0A=
|=20/*=20end=20confdefs.h.=20=20*/=0A|=20int=20foo(void);=0A|=20int=0A|=20=
main=20()=0A|=20{=0A|=20foo()=0A|=20=20=20;=0A|=20=20=20return=200;=0A|=20=
}=0Aconfigure:13875:=20result:=20no=0Aconfigure:13941:=20checking=20for=20=
the=20pthreads=20library=20-lpthreads=0Aconfigure:13979:=20=
arm-linux-gnueabihf-gcc=20-o=20conftest=20-g=20-O2=20=20=20=20=20=
conftest.c=20-lpthreads=20=20>&5=0A=
/usr/lib/gcc-cross/arm-linux-gnueabihf/5/../../../../arm-linux-gnueabihf/b=
in/ld:=20cannot=20find=20-lpthreads=0Acollect2:=20error:=20ld=20returned=20=
1=20exit=20status=0Aconfigure:13979:=20$?=20=3D=201=0Aconfigure:=20=
failed=20program=20was:=0A|=20/*=20confdefs.h=20*/=0A|=20#define=20=
PACKAGE_NAME=20"userspace-rcu"=0A|=20#define=20PACKAGE_TARNAME=20=
"userspace-rcu"=0A|=20#define=20PACKAGE_VERSION=20"0.9.0"=0A|=20#define=20=
PACKAGE_STRING=20"userspace-rcu=200.9.0"=0A|=20#define=20=
PACKAGE_BUGREPORT=20"mathieu=20dot=20desnoyers=20at=20efficios=20dot=20=
com"=0A|=20#define=20PACKAGE_URL=20"http://liburcu.org/"=0A|=20#define=20=
PACKAGE=20"userspace-rcu"=0A|=20#define=20VERSION=20"0.9.0"=0A|=20=
#define=20TLS=20__thread=0A|=20#define=20CONFIG_RCU_TLS=20__thread=0A|=20=
#define=20STDC_HEADERS=201=0A|=20#define=20HAVE_SYS_TYPES_H=201=0A|=20=
#define=20HAVE_SYS_STAT_H=201=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20=
#define=20HAVE_STRING_H=201=0A|=20#define=20HAVE_MEMORY_H=201=0A|=20=
#define=20HAVE_STRINGS_H=201=0A|=20#define=20HAVE_INTTYPES_H=201=0A|=20=
#define=20HAVE_STDINT_H=201=0A|=20#define=20HAVE_UNISTD_H=201=0A|=20=
#define=20__EXTENSIONS__=201=0A|=20#define=20_ALL_SOURCE=201=0A|=20=
#define=20_GNU_SOURCE=201=0A|=20#define=20_POSIX_PTHREAD_SEMANTICS=201=0A=
|=20#define=20_TANDEM_SOURCE=201=0A|=20#define=20HAVE_DLFCN_H=201=0A|=20=
#define=20LT_OBJDIR=20".libs/"=0A|=20#define=20HAVE___ATTRIBUTE__=201=0A=
|=20/*=20end=20confdefs.h.=20=20*/=0A|=20#include=20<pthread.h>=0A|=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
static=20void=20routine(void=20*a)=20{=20a=20=3D=200;=20}=0A|=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20static=20=
void=20*start_routine(void=20*a)=20{=20return=20a;=20}=0A|=20int=0A|=20=
main=20()=0A|=20{=0A|=20pthread_t=20th;=20pthread_attr_t=20attr;=0A|=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
pthread_create(&th,=200,=20start_routine,=200);=0A|=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20pthread_join(th,=20=
0);=0A|=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20pthread_attr_init(&attr);=0A|=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20pthread_cleanup_push(routine,=20=
0);=0A|=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20pthread_cleanup_pop(0)=20/*=20;=20*/=0A|=20=20=20;=0A|=20=20=20=
return=200;=0A|=20}=0Aconfigure:13988:=20result:=20no=0Aconfigure:13886:=20=
checking=20whether=20pthreads=20work=20without=20any=20flags=0A=
configure:13979:=20arm-linux-gnueabihf-gcc=20-o=20conftest=20-g=20-O2=20=20=
=20=20=20conftest.c=20=20=20>&5=0A/tmp/cc7NbOLu.o:=20In=20function=20=
`main':=0A/u/ldalessa/userspace-rcu/conftest.c:38:=20undefined=20=
reference=20to=20`pthread_create'=0A=
/u/ldalessa/userspace-rcu/conftest.c:39:=20undefined=20reference=20to=20=
`pthread_join'=0A/u/ldalessa/userspace-rcu/conftest.c:41:=20undefined=20=
reference=20to=20`__pthread_register_cancel'=0A=
/u/ldalessa/userspace-rcu/conftest.c:42:=20undefined=20reference=20to=20=
`__pthread_unregister_cancel'=0Acollect2:=20error:=20ld=20returned=201=20=
exit=20status=0Aconfigure:13979:=20$?=20=3D=201=0Aconfigure:=20failed=20=
program=20was:=0A|=20/*=20confdefs.h=20*/=0A|=20#define=20PACKAGE_NAME=20=
"userspace-rcu"=0A|=20#define=20PACKAGE_TARNAME=20"userspace-rcu"=0A|=20=
#define=20PACKAGE_VERSION=20"0.9.0"=0A|=20#define=20PACKAGE_STRING=20=
"userspace-rcu=200.9.0"=0A|=20#define=20PACKAGE_BUGREPORT=20"mathieu=20=
dot=20desnoyers=20at=20efficios=20dot=20com"=0A|=20#define=20PACKAGE_URL=20=
"http://liburcu.org/"=0A|=20#define=20PACKAGE=20"userspace-rcu"=0A|=20=
#define=20VERSION=20"0.9.0"=0A|=20#define=20TLS=20__thread=0A|=20#define=20=
CONFIG_RCU_TLS=20__thread=0A|=20#define=20STDC_HEADERS=201=0A|=20#define=20=
HAVE_SYS_TYPES_H=201=0A|=20#define=20HAVE_SYS_STAT_H=201=0A|=20#define=20=
HAVE_STDLIB_H=201=0A|=20#define=20HAVE_STRING_H=201=0A|=20#define=20=
HAVE_MEMORY_H=201=0A|=20#define=20HAVE_STRINGS_H=201=0A|=20#define=20=
HAVE_INTTYPES_H=201=0A|=20#define=20HAVE_STDINT_H=201=0A|=20#define=20=
HAVE_UNISTD_H=201=0A|=20#define=20__EXTENSIONS__=201=0A|=20#define=20=
_ALL_SOURCE=201=0A|=20#define=20_GNU_SOURCE=201=0A|=20#define=20=
_POSIX_PTHREAD_SEMANTICS=201=0A|=20#define=20_TANDEM_SOURCE=201=0A|=20=
#define=20HAVE_DLFCN_H=201=0A|=20#define=20LT_OBJDIR=20".libs/"=0A|=20=
#define=20HAVE___ATTRIBUTE__=201=0A|=20/*=20end=20confdefs.h.=20=20*/=0A=
|=20#include=20<pthread.h>=0A|=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20static=20void=20routine(void=20*a)=20{=20a=20=
=3D=200;=20}=0A|=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20static=20void=20*start_routine(void=20*a)=20{=20return=20=
a;=20}=0A|=20int=0A|=20main=20()=0A|=20{=0A|=20pthread_t=20th;=20=
pthread_attr_t=20attr;=0A|=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20pthread_create(&th,=200,=20start_routine,=20=
0);=0A|=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20pthread_join(th,=200);=0A|=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20pthread_attr_init(&attr);=0A|=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
pthread_cleanup_push(routine,=200);=0A|=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20pthread_cleanup_pop(0)=20/*=20;=20=
*/=0A|=20=20=20;=0A|=20=20=20return=200;=0A|=20}=0Aconfigure:13988:=20=
result:=20no=0Aconfigure:13891:=20checking=20whether=20pthreads=20work=20=
with=20-Kthread=0Aconfigure:13979:=20arm-linux-gnueabihf-gcc=20-o=20=
conftest=20-g=20-O2=20-Kthread=20=20=20=20conftest.c=20=20=20>&5=0A=
arm-linux-gnueabihf-gcc:=20error:=20unrecognized=20command=20line=20=
option=20'-Kthread'=0Aconfigure:13979:=20$?=20=3D=201=0Aconfigure:=20=
failed=20program=20was:=0A|=20/*=20confdefs.h=20*/=0A|=20#define=20=
PACKAGE_NAME=20"userspace-rcu"=0A|=20#define=20PACKAGE_TARNAME=20=
"userspace-rcu"=0A|=20#define=20PACKAGE_VERSION=20"0.9.0"=0A|=20#define=20=
PACKAGE_STRING=20"userspace-rcu=200.9.0"=0A|=20#define=20=
PACKAGE_BUGREPORT=20"mathieu=20dot=20desnoyers=20at=20efficios=20dot=20=
com"=0A|=20#define=20PACKAGE_URL=20"http://liburcu.org/"=0A|=20#define=20=
PACKAGE=20"userspace-rcu"=0A|=20#define=20VERSION=20"0.9.0"=0A|=20=
#define=20TLS=20__thread=0A|=20#define=20CONFIG_RCU_TLS=20__thread=0A|=20=
#define=20STDC_HEADERS=201=0A|=20#define=20HAVE_SYS_TYPES_H=201=0A|=20=
#define=20HAVE_SYS_STAT_H=201=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20=
#define=20HAVE_STRING_H=201=0A|=20#define=20HAVE_MEMORY_H=201=0A|=20=
#define=20HAVE_STRINGS_H=201=0A|=20#define=20HAVE_INTTYPES_H=201=0A|=20=
#define=20HAVE_STDINT_H=201=0A|=20#define=20HAVE_UNISTD_H=201=0A|=20=
#define=20__EXTENSIONS__=201=0A|=20#define=20_ALL_SOURCE=201=0A|=20=
#define=20_GNU_SOURCE=201=0A|=20#define=20_POSIX_PTHREAD_SEMANTICS=201=0A=
|=20#define=20_TANDEM_SOURCE=201=0A|=20#define=20HAVE_DLFCN_H=201=0A|=20=
#define=20LT_OBJDIR=20".libs/"=0A|=20#define=20HAVE___ATTRIBUTE__=201=0A=
|=20/*=20end=20confdefs.h.=20=20*/=0A|=20#include=20<pthread.h>=0A|=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
static=20void=20routine(void=20*a)=20{=20a=20=3D=200;=20}=0A|=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20static=20=
void=20*start_routine(void=20*a)=20{=20return=20a;=20}=0A|=20int=0A|=20=
main=20()=0A|=20{=0A|=20pthread_t=20th;=20pthread_attr_t=20attr;=0A|=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
pthread_create(&th,=200,=20start_routine,=200);=0A|=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20pthread_join(th,=20=
0);=0A|=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20pthread_attr_init(&attr);=0A|=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20pthread_cleanup_push(routine,=20=
0);=0A|=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20pthread_cleanup_pop(0)=20/*=20;=20*/=0A|=20=20=20;=0A|=20=20=20=
return=200;=0A|=20}=0Aconfigure:13988:=20result:=20no=0Aconfigure:13891:=20=
checking=20whether=20pthreads=20work=20with=20-kthread=0A=
configure:13979:=20arm-linux-gnueabihf-gcc=20-o=20conftest=20-g=20-O2=20=
-kthread=20=20=20=20conftest.c=20=20=20>&5=0Aarm-linux-gnueabihf-gcc:=20=
error:=20unrecognized=20command=20line=20option=20'-kthread'=0A=
configure:13979:=20$?=20=3D=201=0Aconfigure:=20failed=20program=20was:=0A=
|=20/*=20confdefs.h=20*/=0A|=20#define=20PACKAGE_NAME=20"userspace-rcu"=0A=
|=20#define=20PACKAGE_TARNAME=20"userspace-rcu"=0A|=20#define=20=
PACKAGE_VERSION=20"0.9.0"=0A|=20#define=20PACKAGE_STRING=20=
"userspace-rcu=200.9.0"=0A|=20#define=20PACKAGE_BUGREPORT=20"mathieu=20=
dot=20desnoyers=20at=20efficios=20dot=20com"=0A|=20#define=20PACKAGE_URL=20=
"http://liburcu.org/"=0A|=20#define=20PACKAGE=20"userspace-rcu"=0A|=20=
#define=20VERSION=20"0.9.0"=0A|=20#define=20TLS=20__thread=0A|=20#define=20=
CONFIG_RCU_TLS=20__thread=0A|=20#define=20STDC_HEADERS=201=0A|=20#define=20=
HAVE_SYS_TYPES_H=201=0A|=20#define=20HAVE_SYS_STAT_H=201=0A|=20#define=20=
HAVE_STDLIB_H=201=0A|=20#define=20HAVE_STRING_H=201=0A|=20#define=20=
HAVE_MEMORY_H=201=0A|=20#define=20HAVE_STRINGS_H=201=0A|=20#define=20=
HAVE_INTTYPES_H=201=0A|=20#define=20HAVE_STDINT_H=201=0A|=20#define=20=
HAVE_UNISTD_H=201=0A|=20#define=20__EXTENSIONS__=201=0A|=20#define=20=
_ALL_SOURCE=201=0A|=20#define=20_GNU_SOURCE=201=0A|=20#define=20=
_POSIX_PTHREAD_SEMANTICS=201=0A|=20#define=20_TANDEM_SOURCE=201=0A|=20=
#define=20HAVE_DLFCN_H=201=0A|=20#define=20LT_OBJDIR=20".libs/"=0A|=20=
#define=20HAVE___ATTRIBUTE__=201=0A|=20/*=20end=20confdefs.h.=20=20*/=0A=
|=20#include=20<pthread.h>=0A|=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20static=20void=20routine(void=20*a)=20{=20a=20=
=3D=200;=20}=0A|=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20static=20void=20*start_routine(void=20*a)=20{=20return=20=
a;=20}=0A|=20int=0A|=20main=20()=0A|=20{=0A|=20pthread_t=20th;=20=
pthread_attr_t=20attr;=0A|=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20pthread_create(&th,=200,=20start_routine,=20=
0);=0A|=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20pthread_join(th,=200);=0A|=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20pthread_attr_init(&attr);=0A|=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
pthread_cleanup_push(routine,=200);=0A|=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20pthread_cleanup_pop(0)=20/*=20;=20=
*/=0A|=20=20=20;=0A|=20=20=20return=200;=0A|=20}=0Aconfigure:13988:=20=
result:=20no=0Aconfigure:13941:=20checking=20for=20the=20pthreads=20=
library=20-llthread=0Aconfigure:13979:=20arm-linux-gnueabihf-gcc=20-o=20=
conftest=20-g=20-O2=20=20=20=20=20conftest.c=20-llthread=20=20>&5=0A=
/usr/lib/gcc-cross/arm-linux-gnueabihf/5/../../../../arm-linux-gnueabihf/b=
in/ld:=20cannot=20find=20-llthread=0Acollect2:=20error:=20ld=20returned=20=
1=20exit=20status=0Aconfigure:13979:=20$?=20=3D=201=0Aconfigure:=20=
failed=20program=20was:=0A|=20/*=20confdefs.h=20*/=0A|=20#define=20=
PACKAGE_NAME=20"userspace-rcu"=0A|=20#define=20PACKAGE_TARNAME=20=
"userspace-rcu"=0A|=20#define=20PACKAGE_VERSION=20"0.9.0"=0A|=20#define=20=
PACKAGE_STRING=20"userspace-rcu=200.9.0"=0A|=20#define=20=
PACKAGE_BUGREPORT=20"mathieu=20dot=20desnoyers=20at=20efficios=20dot=20=
com"=0A|=20#define=20PACKAGE_URL=20"http://liburcu.org/"=0A|=20#define=20=
PACKAGE=20"userspace-rcu"=0A|=20#define=20VERSION=20"0.9.0"=0A|=20=
#define=20TLS=20__thread=0A|=20#define=20CONFIG_RCU_TLS=20__thread=0A|=20=
#define=20STDC_HEADERS=201=0A|=20#define=20HAVE_SYS_TYPES_H=201=0A|=20=
#define=20HAVE_SYS_STAT_H=201=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20=
#define=20HAVE_STRING_H=201=0A|=20#define=20HAVE_MEMORY_H=201=0A|=20=
#define=20HAVE_STRINGS_H=201=0A|=20#define=20HAVE_INTTYPES_H=201=0A|=20=
#define=20HAVE_STDINT_H=201=0A|=20#define=20HAVE_UNISTD_H=201=0A|=20=
#define=20__EXTENSIONS__=201=0A|=20#define=20_ALL_SOURCE=201=0A|=20=
#define=20_GNU_SOURCE=201=0A|=20#define=20_POSIX_PTHREAD_SEMANTICS=201=0A=
|=20#define=20_TANDEM_SOURCE=201=0A|=20#define=20HAVE_DLFCN_H=201=0A|=20=
#define=20LT_OBJDIR=20".libs/"=0A|=20#define=20HAVE___ATTRIBUTE__=201=0A=
|=20/*=20end=20confdefs.h.=20=20*/=0A|=20#include=20<pthread.h>=0A|=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
static=20void=20routine(void=20*a)=20{=20a=20=3D=200;=20}=0A|=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20static=20=
void=20*start_routine(void=20*a)=20{=20return=20a;=20}=0A|=20int=0A|=20=
main=20()=0A|=20{=0A|=20pthread_t=20th;=20pthread_attr_t=20attr;=0A|=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
pthread_create(&th,=200,=20start_routine,=200);=0A|=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20pthread_join(th,=20=
0);=0A|=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20pthread_attr_init(&attr);=0A|=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20pthread_cleanup_push(routine,=20=
0);=0A|=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20pthread_cleanup_pop(0)=20/*=20;=20*/=0A|=20=20=20;=0A|=20=20=20=
return=200;=0A|=20}=0Aconfigure:13988:=20result:=20no=0Aconfigure:13891:=20=
checking=20whether=20pthreads=20work=20with=20-pthread=0A=
configure:13979:=20arm-linux-gnueabihf-gcc=20-o=20conftest=20-g=20-O2=20=
-pthread=20=20=20=20conftest.c=20=20=20>&5=0Aconfigure:13979:=20$?=20=3D=20=
0=0Aconfigure:13988:=20result:=20yes=0Aconfigure:14007:=20checking=20for=20=
joinable=20pthread=20attribute=0Aconfigure:14022:=20=
arm-linux-gnueabihf-gcc=20-o=20conftest=20-g=20-O2=20-pthread=20=20=20=
conftest.c=20=20=20>&5=0Aconfigure:14022:=20$?=20=3D=200=0A=
configure:14028:=20result:=20PTHREAD_CREATE_JOINABLE=0Aconfigure:14038:=20=
checking=20if=20more=20special=20flags=20are=20required=20for=20pthreads=0A=
configure:14053:=20result:=20no=0Aconfigure:14059:=20checking=20for=20=
PTHREAD_PRIO_INHERIT=0Aconfigure:14076:=20arm-linux-gnueabihf-gcc=20-o=20=
conftest=20-g=20-O2=20-pthread=20=20=20conftest.c=20=20=20>&5=0A=
configure:14076:=20$?=20=3D=200=0Aconfigure:14085:=20result:=20yes=0A=
configure:14191:=20checking=20for=20stdlib.h=0Aconfigure:14191:=20=
result:=20yes=0Aconfigure:14201:=20checking=20for=20GNU=20libc=20=
compatible=20malloc=0Aconfigure:14235:=20result:=20no=0Aconfigure:14262:=20=
checking=20for=20stdlib.h=0Aconfigure:14262:=20result:=20yes=0A=
configure:14262:=20checking=20for=20unistd.h=0Aconfigure:14262:=20=
result:=20yes=0Aconfigure:14262:=20checking=20for=20sys/param.h=0A=
configure:14262:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20-pthread=20=20=
conftest.c=20>&5=0Aconfigure:14262:=20$?=20=3D=200=0Aconfigure:14262:=20=
result:=20yes=0Aconfigure:14282:=20checking=20for=20getpagesize=0A=
configure:14282:=20arm-linux-gnueabihf-gcc=20-o=20conftest=20-g=20-O2=20=
-pthread=20=20=20conftest.c=20=20=20>&5=0Aconfigure:14282:=20$?=20=3D=20=
0=0Aconfigure:14282:=20result:=20yes=0Aconfigure:14291:=20checking=20for=20=
working=20mmap=0Aconfigure:14448:=20result:=20no=0Aconfigure:14459:=20=
checking=20vfork.h=20usability=0Aconfigure:14459:=20=
arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20-pthread=20=20conftest.c=20>&5=0A=
conftest.c:73:19:=20fatal=20error:=20vfork.h:=20No=20such=20file=20or=20=
directory=0Acompilation=20terminated.=0Aconfigure:14459:=20$?=20=3D=201=0A=
configure:=20failed=20program=20was:=0A|=20/*=20confdefs.h=20*/=0A|=20=
#define=20PACKAGE_NAME=20"userspace-rcu"=0A|=20#define=20PACKAGE_TARNAME=20=
"userspace-rcu"=0A|=20#define=20PACKAGE_VERSION=20"0.9.0"=0A|=20#define=20=
PACKAGE_STRING=20"userspace-rcu=200.9.0"=0A|=20#define=20=
PACKAGE_BUGREPORT=20"mathieu=20dot=20desnoyers=20at=20efficios=20dot=20=
com"=0A|=20#define=20PACKAGE_URL=20"http://liburcu.org/"=0A|=20#define=20=
PACKAGE=20"userspace-rcu"=0A|=20#define=20VERSION=20"0.9.0"=0A|=20=
#define=20TLS=20__thread=0A|=20#define=20CONFIG_RCU_TLS=20__thread=0A|=20=
#define=20STDC_HEADERS=201=0A|=20#define=20HAVE_SYS_TYPES_H=201=0A|=20=
#define=20HAVE_SYS_STAT_H=201=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20=
#define=20HAVE_STRING_H=201=0A|=20#define=20HAVE_MEMORY_H=201=0A|=20=
#define=20HAVE_STRINGS_H=201=0A|=20#define=20HAVE_INTTYPES_H=201=0A|=20=
#define=20HAVE_STDINT_H=201=0A|=20#define=20HAVE_UNISTD_H=201=0A|=20=
#define=20__EXTENSIONS__=201=0A|=20#define=20_ALL_SOURCE=201=0A|=20=
#define=20_GNU_SOURCE=201=0A|=20#define=20_POSIX_PTHREAD_SEMANTICS=201=0A=
|=20#define=20_TANDEM_SOURCE=201=0A|=20#define=20HAVE_DLFCN_H=201=0A|=20=
#define=20LT_OBJDIR=20".libs/"=0A|=20#define=20HAVE___ATTRIBUTE__=201=0A=
|=20#define=20HAVE_PTHREAD_PRIO_INHERIT=201=0A|=20#define=20HAVE_PTHREAD=20=
1=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20#define=20HAVE_MALLOC=200=0A|=20=
#define=20malloc=20rpl_malloc=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20=
#define=20HAVE_UNISTD_H=201=0A|=20#define=20HAVE_SYS_PARAM_H=201=0A|=20=
#define=20HAVE_GETPAGESIZE=201=0A|=20/*=20end=20confdefs.h.=20=20*/=0A|=20=
#include=20<stdio.h>=0A|=20#ifdef=20HAVE_SYS_TYPES_H=0A|=20#=20include=20=
<sys/types.h>=0A|=20#endif=0A|=20#ifdef=20HAVE_SYS_STAT_H=0A|=20#=20=
include=20<sys/stat.h>=0A|=20#endif=0A|=20#ifdef=20STDC_HEADERS=0A|=20#=20=
include=20<stdlib.h>=0A|=20#=20include=20<stddef.h>=0A|=20#else=0A|=20#=20=
ifdef=20HAVE_STDLIB_H=0A|=20#=20=20include=20<stdlib.h>=0A|=20#=20endif=0A=
|=20#endif=0A|=20#ifdef=20HAVE_STRING_H=0A|=20#=20if=20!defined=20=
STDC_HEADERS=20&&=20defined=20HAVE_MEMORY_H=0A|=20#=20=20include=20=
<memory.h>=0A|=20#=20endif=0A|=20#=20include=20<string.h>=0A|=20#endif=0A=
|=20#ifdef=20HAVE_STRINGS_H=0A|=20#=20include=20<strings.h>=0A|=20#endif=0A=
|=20#ifdef=20HAVE_INTTYPES_H=0A|=20#=20include=20<inttypes.h>=0A|=20=
#endif=0A|=20#ifdef=20HAVE_STDINT_H=0A|=20#=20include=20<stdint.h>=0A|=20=
#endif=0A|=20#ifdef=20HAVE_UNISTD_H=0A|=20#=20include=20<unistd.h>=0A|=20=
#endif=0A|=20#include=20<vfork.h>=0Aconfigure:14459:=20result:=20no=0A=
configure:14459:=20checking=20vfork.h=20presence=0Aconfigure:14459:=20=
arm-linux-gnueabihf-gcc=20-E=20=20conftest.c=0Aconftest.c:40:19:=20fatal=20=
error:=20vfork.h:=20No=20such=20file=20or=20directory=0Acompilation=20=
terminated.=0Aconfigure:14459:=20$?=20=3D=201=0Aconfigure:=20failed=20=
program=20was:=0A|=20/*=20confdefs.h=20*/=0A|=20#define=20PACKAGE_NAME=20=
"userspace-rcu"=0A|=20#define=20PACKAGE_TARNAME=20"userspace-rcu"=0A|=20=
#define=20PACKAGE_VERSION=20"0.9.0"=0A|=20#define=20PACKAGE_STRING=20=
"userspace-rcu=200.9.0"=0A|=20#define=20PACKAGE_BUGREPORT=20"mathieu=20=
dot=20desnoyers=20at=20efficios=20dot=20com"=0A|=20#define=20PACKAGE_URL=20=
"http://liburcu.org/"=0A|=20#define=20PACKAGE=20"userspace-rcu"=0A|=20=
#define=20VERSION=20"0.9.0"=0A|=20#define=20TLS=20__thread=0A|=20#define=20=
CONFIG_RCU_TLS=20__thread=0A|=20#define=20STDC_HEADERS=201=0A|=20#define=20=
HAVE_SYS_TYPES_H=201=0A|=20#define=20HAVE_SYS_STAT_H=201=0A|=20#define=20=
HAVE_STDLIB_H=201=0A|=20#define=20HAVE_STRING_H=201=0A|=20#define=20=
HAVE_MEMORY_H=201=0A|=20#define=20HAVE_STRINGS_H=201=0A|=20#define=20=
HAVE_INTTYPES_H=201=0A|=20#define=20HAVE_STDINT_H=201=0A|=20#define=20=
HAVE_UNISTD_H=201=0A|=20#define=20__EXTENSIONS__=201=0A|=20#define=20=
_ALL_SOURCE=201=0A|=20#define=20_GNU_SOURCE=201=0A|=20#define=20=
_POSIX_PTHREAD_SEMANTICS=201=0A|=20#define=20_TANDEM_SOURCE=201=0A|=20=
#define=20HAVE_DLFCN_H=201=0A|=20#define=20LT_OBJDIR=20".libs/"=0A|=20=
#define=20HAVE___ATTRIBUTE__=201=0A|=20#define=20=
HAVE_PTHREAD_PRIO_INHERIT=201=0A|=20#define=20HAVE_PTHREAD=201=0A|=20=
#define=20HAVE_STDLIB_H=201=0A|=20#define=20HAVE_MALLOC=200=0A|=20=
#define=20malloc=20rpl_malloc=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20=
#define=20HAVE_UNISTD_H=201=0A|=20#define=20HAVE_SYS_PARAM_H=201=0A|=20=
#define=20HAVE_GETPAGESIZE=201=0A|=20/*=20end=20confdefs.h.=20=20*/=0A|=20=
#include=20<vfork.h>=0Aconfigure:14459:=20result:=20no=0A=
configure:14459:=20checking=20for=20vfork.h=0Aconfigure:14459:=20result:=20=
no=0Aconfigure:14472:=20checking=20for=20fork=0Aconfigure:14472:=20=
arm-linux-gnueabihf-gcc=20-o=20conftest=20-g=20-O2=20-pthread=20=20=20=
conftest.c=20=20=20>&5=0Aconftest.c:63:6:=20warning:=20conflicting=20=
types=20for=20built-in=20function=20'fork'=0A=20char=20fork=20();=0A=20=20=
=20=20=20=20^=0Aconfigure:14472:=20$?=20=3D=200=0Aconfigure:14472:=20=
result:=20yes=0Aconfigure:14472:=20checking=20for=20vfork=0A=
configure:14472:=20arm-linux-gnueabihf-gcc=20-o=20conftest=20-g=20-O2=20=
-pthread=20=20=20conftest.c=20=20=20>&5=0Aconfigure:14472:=20$?=20=3D=20=
0=0Aconfigure:14472:=20result:=20yes=0Aconfigure:14482:=20checking=20for=20=
working=20fork=0Aconfigure:14514:=20result:=20cross=0Aconfigure:14530:=20=
WARNING:=20result=20yes=20guessed=20because=20of=20cross=20compilation=0A=
configure:14535:=20checking=20for=20working=20vfork=0Aconfigure:14645:=20=
result:=20yes=0Aconfigure:14685:=20checking=20for=20atexit=0A=
configure:14685:=20arm-linux-gnueabihf-gcc=20-o=20conftest=20-g=20-O2=20=
-pthread=20=20=20conftest.c=20=20=20>&5=0Aconfigure:14685:=20$?=20=3D=20=
0=0Aconfigure:14685:=20result:=20yes=0Aconfigure:14685:=20checking=20for=20=
getcpuid=0Aconfigure:14685:=20arm-linux-gnueabihf-gcc=20-o=20conftest=20=
-g=20-O2=20-pthread=20=20=20conftest.c=20=20=20>&5=0A/tmp/ccfu1rIP.o:=20=
In=20function=20`main':=0A/u/ldalessa/userspace-rcu/conftest.c:79:=20=
undefined=20reference=20to=20`getcpuid'=0Acollect2:=20error:=20ld=20=
returned=201=20exit=20status=0Aconfigure:14685:=20$?=20=3D=201=0A=
configure:=20failed=20program=20was:=0A|=20/*=20confdefs.h=20*/=0A|=20=
#define=20PACKAGE_NAME=20"userspace-rcu"=0A|=20#define=20PACKAGE_TARNAME=20=
"userspace-rcu"=0A|=20#define=20PACKAGE_VERSION=20"0.9.0"=0A|=20#define=20=
PACKAGE_STRING=20"userspace-rcu=200.9.0"=0A|=20#define=20=
PACKAGE_BUGREPORT=20"mathieu=20dot=20desnoyers=20at=20efficios=20dot=20=
com"=0A|=20#define=20PACKAGE_URL=20"http://liburcu.org/"=0A|=20#define=20=
PACKAGE=20"userspace-rcu"=0A|=20#define=20VERSION=20"0.9.0"=0A|=20=
#define=20TLS=20__thread=0A|=20#define=20CONFIG_RCU_TLS=20__thread=0A|=20=
#define=20STDC_HEADERS=201=0A|=20#define=20HAVE_SYS_TYPES_H=201=0A|=20=
#define=20HAVE_SYS_STAT_H=201=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20=
#define=20HAVE_STRING_H=201=0A|=20#define=20HAVE_MEMORY_H=201=0A|=20=
#define=20HAVE_STRINGS_H=201=0A|=20#define=20HAVE_INTTYPES_H=201=0A|=20=
#define=20HAVE_STDINT_H=201=0A|=20#define=20HAVE_UNISTD_H=201=0A|=20=
#define=20__EXTENSIONS__=201=0A|=20#define=20_ALL_SOURCE=201=0A|=20=
#define=20_GNU_SOURCE=201=0A|=20#define=20_POSIX_PTHREAD_SEMANTICS=201=0A=
|=20#define=20_TANDEM_SOURCE=201=0A|=20#define=20HAVE_DLFCN_H=201=0A|=20=
#define=20LT_OBJDIR=20".libs/"=0A|=20#define=20HAVE___ATTRIBUTE__=201=0A=
|=20#define=20HAVE_PTHREAD_PRIO_INHERIT=201=0A|=20#define=20HAVE_PTHREAD=20=
1=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20#define=20HAVE_MALLOC=200=0A|=20=
#define=20malloc=20rpl_malloc=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20=
#define=20HAVE_UNISTD_H=201=0A|=20#define=20HAVE_SYS_PARAM_H=201=0A|=20=
#define=20HAVE_GETPAGESIZE=201=0A|=20#define=20HAVE_FORK=201=0A|=20=
#define=20HAVE_VFORK=201=0A|=20#define=20HAVE_WORKING_VFORK=201=0A|=20=
#define=20HAVE_WORKING_FORK=201=0A|=20#define=20HAVE_ATEXIT=201=0A|=20/*=20=
end=20confdefs.h.=20=20*/=0A|=20/*=20Define=20getcpuid=20to=20an=20=
innocuous=20variant,=20in=20case=20<limits.h>=20declares=20getcpuid.=0A|=20=
=20=20=20For=20example,=20HP-UX=2011i=20<limits.h>=20declares=20=
gettimeofday.=20=20*/=0A|=20#define=20getcpuid=20innocuous_getcpuid=0A|=20=
=0A|=20/*=20System=20header=20to=20define=20__stub=20macros=20and=20=
hopefully=20few=20prototypes,=0A|=20=20=20=20=20which=20can=20conflict=20=
with=20char=20getcpuid=20();=20below.=0A|=20=20=20=20=20Prefer=20=
<limits.h>=20to=20<assert.h>=20if=20__STDC__=20is=20defined,=20since=0A|=20=
=20=20=20=20<limits.h>=20exists=20even=20on=20freestanding=20compilers.=20=
=20*/=0A|=20=0A|=20#ifdef=20__STDC__=0A|=20#=20include=20<limits.h>=0A|=20=
#else=0A|=20#=20include=20<assert.h>=0A|=20#endif=0A|=20=0A|=20#undef=20=
getcpuid=0A|=20=0A|=20/*=20Override=20any=20GCC=20internal=20prototype=20=
to=20avoid=20an=20error.=0A|=20=20=20=20Use=20char=20because=20int=20=
might=20match=20the=20return=20type=20of=20a=20GCC=0A|=20=20=20=20=
builtin=20and=20then=20its=20argument=20prototype=20would=20still=20=
apply.=20=20*/=0A|=20#ifdef=20__cplusplus=0A|=20extern=20"C"=0A|=20=
#endif=0A|=20char=20getcpuid=20();=0A|=20/*=20The=20GNU=20C=20library=20=
defines=20this=20for=20functions=20which=20it=20implements=0A|=20=20=20=20=
=20to=20always=20fail=20with=20ENOSYS.=20=20Some=20functions=20are=20=
actually=20named=0A|=20=20=20=20=20something=20starting=20with=20__=20=
and=20the=20normal=20name=20is=20an=20alias.=20=20*/=0A|=20#if=20defined=20=
__stub_getcpuid=20||=20defined=20__stub___getcpuid=0A|=20choke=20me=0A|=20=
#endif=0A|=20=0A|=20int=0A|=20main=20()=0A|=20{=0A|=20return=20getcpuid=20=
();=0A|=20=20=20;=0A|=20=20=20return=200;=0A|=20}=0Aconfigure:14685:=20=
result:=20no=0Aconfigure:14685:=20checking=20for=20gettid=0A=
configure:14685:=20arm-linux-gnueabihf-gcc=20-o=20conftest=20-g=20-O2=20=
-pthread=20=20=20conftest.c=20=20=20>&5=0A/tmp/cc887Y9W.o:=20In=20=
function=20`main':=0A/u/ldalessa/userspace-rcu/conftest.c:79:=20=
undefined=20reference=20to=20`gettid'=0Acollect2:=20error:=20ld=20=
returned=201=20exit=20status=0Aconfigure:14685:=20$?=20=3D=201=0A=
configure:=20failed=20program=20was:=0A|=20/*=20confdefs.h=20*/=0A|=20=
#define=20PACKAGE_NAME=20"userspace-rcu"=0A|=20#define=20PACKAGE_TARNAME=20=
"userspace-rcu"=0A|=20#define=20PACKAGE_VERSION=20"0.9.0"=0A|=20#define=20=
PACKAGE_STRING=20"userspace-rcu=200.9.0"=0A|=20#define=20=
PACKAGE_BUGREPORT=20"mathieu=20dot=20desnoyers=20at=20efficios=20dot=20=
com"=0A|=20#define=20PACKAGE_URL=20"http://liburcu.org/"=0A|=20#define=20=
PACKAGE=20"userspace-rcu"=0A|=20#define=20VERSION=20"0.9.0"=0A|=20=
#define=20TLS=20__thread=0A|=20#define=20CONFIG_RCU_TLS=20__thread=0A|=20=
#define=20STDC_HEADERS=201=0A|=20#define=20HAVE_SYS_TYPES_H=201=0A|=20=
#define=20HAVE_SYS_STAT_H=201=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20=
#define=20HAVE_STRING_H=201=0A|=20#define=20HAVE_MEMORY_H=201=0A|=20=
#define=20HAVE_STRINGS_H=201=0A|=20#define=20HAVE_INTTYPES_H=201=0A|=20=
#define=20HAVE_STDINT_H=201=0A|=20#define=20HAVE_UNISTD_H=201=0A|=20=
#define=20__EXTENSIONS__=201=0A|=20#define=20_ALL_SOURCE=201=0A|=20=
#define=20_GNU_SOURCE=201=0A|=20#define=20_POSIX_PTHREAD_SEMANTICS=201=0A=
|=20#define=20_TANDEM_SOURCE=201=0A|=20#define=20HAVE_DLFCN_H=201=0A|=20=
#define=20LT_OBJDIR=20".libs/"=0A|=20#define=20HAVE___ATTRIBUTE__=201=0A=
|=20#define=20HAVE_PTHREAD_PRIO_INHERIT=201=0A|=20#define=20HAVE_PTHREAD=20=
1=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20#define=20HAVE_MALLOC=200=0A|=20=
#define=20malloc=20rpl_malloc=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20=
#define=20HAVE_UNISTD_H=201=0A|=20#define=20HAVE_SYS_PARAM_H=201=0A|=20=
#define=20HAVE_GETPAGESIZE=201=0A|=20#define=20HAVE_FORK=201=0A|=20=
#define=20HAVE_VFORK=201=0A|=20#define=20HAVE_WORKING_VFORK=201=0A|=20=
#define=20HAVE_WORKING_FORK=201=0A|=20#define=20HAVE_ATEXIT=201=0A|=20/*=20=
end=20confdefs.h.=20=20*/=0A|=20/*=20Define=20gettid=20to=20an=20=
innocuous=20variant,=20in=20case=20<limits.h>=20declares=20gettid.=0A|=20=
=20=20=20For=20example,=20HP-UX=2011i=20<limits.h>=20declares=20=
gettimeofday.=20=20*/=0A|=20#define=20gettid=20innocuous_gettid=0A|=20=0A=
|=20/*=20System=20header=20to=20define=20__stub=20macros=20and=20=
hopefully=20few=20prototypes,=0A|=20=20=20=20=20which=20can=20conflict=20=
with=20char=20gettid=20();=20below.=0A|=20=20=20=20=20Prefer=20=
<limits.h>=20to=20<assert.h>=20if=20__STDC__=20is=20defined,=20since=0A|=20=
=20=20=20=20<limits.h>=20exists=20even=20on=20freestanding=20compilers.=20=
=20*/=0A|=20=0A|=20#ifdef=20__STDC__=0A|=20#=20include=20<limits.h>=0A|=20=
#else=0A|=20#=20include=20<assert.h>=0A|=20#endif=0A|=20=0A|=20#undef=20=
gettid=0A|=20=0A|=20/*=20Override=20any=20GCC=20internal=20prototype=20=
to=20avoid=20an=20error.=0A|=20=20=20=20Use=20char=20because=20int=20=
might=20match=20the=20return=20type=20of=20a=20GCC=0A|=20=20=20=20=
builtin=20and=20then=20its=20argument=20prototype=20would=20still=20=
apply.=20=20*/=0A|=20#ifdef=20__cplusplus=0A|=20extern=20"C"=0A|=20=
#endif=0A|=20char=20gettid=20();=0A|=20/*=20The=20GNU=20C=20library=20=
defines=20this=20for=20functions=20which=20it=20implements=0A|=20=20=20=20=
=20to=20always=20fail=20with=20ENOSYS.=20=20Some=20functions=20are=20=
actually=20named=0A|=20=20=20=20=20something=20starting=20with=20__=20=
and=20the=20normal=20name=20is=20an=20alias.=20=20*/=0A|=20#if=20defined=20=
__stub_gettid=20||=20defined=20__stub___gettid=0A|=20choke=20me=0A|=20=
#endif=0A|=20=0A|=20int=0A|=20main=20()=0A|=20{=0A|=20return=20gettid=20=
();=0A|=20=20=20;=0A|=20=20=20return=200;=0A|=20}=0Aconfigure:14685:=20=
result:=20no=0Aconfigure:14685:=20checking=20for=20gettimeofday=0A=
configure:14685:=20arm-linux-gnueabihf-gcc=20-o=20conftest=20-g=20-O2=20=
-pthread=20=20=20conftest.c=20=20=20>&5=0Aconfigure:14685:=20$?=20=3D=20=
0=0Aconfigure:14685:=20result:=20yes=0Aconfigure:14685:=20checking=20for=20=
memeset=0Aconfigure:14685:=20arm-linux-gnueabihf-gcc=20-o=20conftest=20=
-g=20-O2=20-pthread=20=20=20conftest.c=20=20=20>&5=0A/tmp/ccraRGB7.o:=20=
In=20function=20`main':=0A/u/ldalessa/userspace-rcu/conftest.c:80:=20=
undefined=20reference=20to=20`memeset'=0Acollect2:=20error:=20ld=20=
returned=201=20exit=20status=0Aconfigure:14685:=20$?=20=3D=201=0A=
configure:=20failed=20program=20was:=0A|=20/*=20confdefs.h=20*/=0A|=20=
#define=20PACKAGE_NAME=20"userspace-rcu"=0A|=20#define=20PACKAGE_TARNAME=20=
"userspace-rcu"=0A|=20#define=20PACKAGE_VERSION=20"0.9.0"=0A|=20#define=20=
PACKAGE_STRING=20"userspace-rcu=200.9.0"=0A|=20#define=20=
PACKAGE_BUGREPORT=20"mathieu=20dot=20desnoyers=20at=20efficios=20dot=20=
com"=0A|=20#define=20PACKAGE_URL=20"http://liburcu.org/"=0A|=20#define=20=
PACKAGE=20"userspace-rcu"=0A|=20#define=20VERSION=20"0.9.0"=0A|=20=
#define=20TLS=20__thread=0A|=20#define=20CONFIG_RCU_TLS=20__thread=0A|=20=
#define=20STDC_HEADERS=201=0A|=20#define=20HAVE_SYS_TYPES_H=201=0A|=20=
#define=20HAVE_SYS_STAT_H=201=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20=
#define=20HAVE_STRING_H=201=0A|=20#define=20HAVE_MEMORY_H=201=0A|=20=
#define=20HAVE_STRINGS_H=201=0A|=20#define=20HAVE_INTTYPES_H=201=0A|=20=
#define=20HAVE_STDINT_H=201=0A|=20#define=20HAVE_UNISTD_H=201=0A|=20=
#define=20__EXTENSIONS__=201=0A|=20#define=20_ALL_SOURCE=201=0A|=20=
#define=20_GNU_SOURCE=201=0A|=20#define=20_POSIX_PTHREAD_SEMANTICS=201=0A=
|=20#define=20_TANDEM_SOURCE=201=0A|=20#define=20HAVE_DLFCN_H=201=0A|=20=
#define=20LT_OBJDIR=20".libs/"=0A|=20#define=20HAVE___ATTRIBUTE__=201=0A=
|=20#define=20HAVE_PTHREAD_PRIO_INHERIT=201=0A|=20#define=20HAVE_PTHREAD=20=
1=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20#define=20HAVE_MALLOC=200=0A|=20=
#define=20malloc=20rpl_malloc=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20=
#define=20HAVE_UNISTD_H=201=0A|=20#define=20HAVE_SYS_PARAM_H=201=0A|=20=
#define=20HAVE_GETPAGESIZE=201=0A|=20#define=20HAVE_FORK=201=0A|=20=
#define=20HAVE_VFORK=201=0A|=20#define=20HAVE_WORKING_VFORK=201=0A|=20=
#define=20HAVE_WORKING_FORK=201=0A|=20#define=20HAVE_ATEXIT=201=0A|=20=
#define=20HAVE_GETTIMEOFDAY=201=0A|=20/*=20end=20confdefs.h.=20=20*/=0A|=20=
/*=20Define=20memeset=20to=20an=20innocuous=20variant,=20in=20case=20=
<limits.h>=20declares=20memeset.=0A|=20=20=20=20For=20example,=20HP-UX=20=
11i=20<limits.h>=20declares=20gettimeofday.=20=20*/=0A|=20#define=20=
memeset=20innocuous_memeset=0A|=20=0A|=20/*=20System=20header=20to=20=
define=20__stub=20macros=20and=20hopefully=20few=20prototypes,=0A|=20=20=20=
=20=20which=20can=20conflict=20with=20char=20memeset=20();=20below.=0A|=20=
=20=20=20=20Prefer=20<limits.h>=20to=20<assert.h>=20if=20__STDC__=20is=20=
defined,=20since=0A|=20=20=20=20=20<limits.h>=20exists=20even=20on=20=
freestanding=20compilers.=20=20*/=0A|=20=0A|=20#ifdef=20__STDC__=0A|=20#=20=
include=20<limits.h>=0A|=20#else=0A|=20#=20include=20<assert.h>=0A|=20=
#endif=0A|=20=0A|=20#undef=20memeset=0A|=20=0A|=20/*=20Override=20any=20=
GCC=20internal=20prototype=20to=20avoid=20an=20error.=0A|=20=20=20=20Use=20=
char=20because=20int=20might=20match=20the=20return=20type=20of=20a=20=
GCC=0A|=20=20=20=20builtin=20and=20then=20its=20argument=20prototype=20=
would=20still=20apply.=20=20*/=0A|=20#ifdef=20__cplusplus=0A|=20extern=20=
"C"=0A|=20#endif=0A|=20char=20memeset=20();=0A|=20/*=20The=20GNU=20C=20=
library=20defines=20this=20for=20functions=20which=20it=20implements=0A|=20=
=20=20=20=20to=20always=20fail=20with=20ENOSYS.=20=20Some=20functions=20=
are=20actually=20named=0A|=20=20=20=20=20something=20starting=20with=20=
__=20and=20the=20normal=20name=20is=20an=20alias.=20=20*/=0A|=20#if=20=
defined=20__stub_memeset=20||=20defined=20__stub___memeset=0A|=20choke=20=
me=0A|=20#endif=0A|=20=0A|=20int=0A|=20main=20()=0A|=20{=0A|=20return=20=
memeset=20();=0A|=20=20=20;=0A|=20=20=20return=200;=0A|=20}=0A=
configure:14685:=20result:=20no=0Aconfigure:14685:=20checking=20for=20=
memset=0Aconfigure:14685:=20arm-linux-gnueabihf-gcc=20-o=20conftest=20-g=20=
-O2=20-pthread=20=20=20conftest.c=20=20=20>&5=0Aconftest.c:69:6:=20=
warning:=20conflicting=20types=20for=20built-in=20function=20'memset'=0A=20=
char=20memset=20();=0A=20=20=20=20=20=20^=0Aconfigure:14685:=20$?=20=3D=20=
0=0Aconfigure:14685:=20result:=20yes=0Aconfigure:14685:=20checking=20for=20=
munmap=0Aconfigure:14685:=20arm-linux-gnueabihf-gcc=20-o=20conftest=20-g=20=
-O2=20-pthread=20=20=20conftest.c=20=20=20>&5=0Aconfigure:14685:=20$?=20=
=3D=200=0Aconfigure:14685:=20result:=20yes=0Aconfigure:14685:=20checking=20=
for=20sched_getcpu=0Aconfigure:14685:=20arm-linux-gnueabihf-gcc=20-o=20=
conftest=20-g=20-O2=20-pthread=20=20=20conftest.c=20=20=20>&5=0A=
configure:14685:=20$?=20=3D=200=0Aconfigure:14685:=20result:=20yes=0A=
configure:14685:=20checking=20for=20strerror=0Aconfigure:14685:=20=
arm-linux-gnueabihf-gcc=20-o=20conftest=20-g=20-O2=20-pthread=20=20=20=
conftest.c=20=20=20>&5=0Aconfigure:14685:=20$?=20=3D=200=0A=
configure:14685:=20result:=20yes=0Aconfigure:14685:=20checking=20for=20=
strtoul=0Aconfigure:14685:=20arm-linux-gnueabihf-gcc=20-o=20conftest=20=
-g=20-O2=20-pthread=20=20=20conftest.c=20=20=20>&5=0Aconfigure:14685:=20=
$?=20=3D=200=0Aconfigure:14685:=20result:=20yes=0Aconfigure:14685:=20=
checking=20for=20sysconf=0Aconfigure:14685:=20arm-linux-gnueabihf-gcc=20=
-o=20conftest=20-g=20-O2=20-pthread=20=20=20conftest.c=20=20=20>&5=0A=
configure:14685:=20$?=20=3D=200=0Aconfigure:14685:=20result:=20yes=0A=
configure:14696:=20checking=20for=20stdbool.h=20that=20conforms=20to=20=
C99=0Aconfigure:14763:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=
-pthread=20=20conftest.c=20>&5=0Aconfigure:14763:=20$?=20=3D=200=0A=
configure:14770:=20result:=20yes=0Aconfigure:14772:=20checking=20for=20=
_Bool=0Aconfigure:14772:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=
-pthread=20=20conftest.c=20>&5=0Aconfigure:14772:=20$?=20=3D=200=0A=
configure:14772:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20-pthread=20=20=
conftest.c=20>&5=0Aconftest.c:=20In=20function=20'main':=0A=
conftest.c:88:20:=20error:=20expected=20expression=20before=20')'=20=
token=0A=20if=20(sizeof=20((_Bool)))=0A=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20^=0Aconfigure:14772:=20$?=20=3D=201=0Aconfigure:=20=
failed=20program=20was:=0A|=20/*=20confdefs.h=20*/=0A|=20#define=20=
PACKAGE_NAME=20"userspace-rcu"=0A|=20#define=20PACKAGE_TARNAME=20=
"userspace-rcu"=0A|=20#define=20PACKAGE_VERSION=20"0.9.0"=0A|=20#define=20=
PACKAGE_STRING=20"userspace-rcu=200.9.0"=0A|=20#define=20=
PACKAGE_BUGREPORT=20"mathieu=20dot=20desnoyers=20at=20efficios=20dot=20=
com"=0A|=20#define=20PACKAGE_URL=20"http://liburcu.org/"=0A|=20#define=20=
PACKAGE=20"userspace-rcu"=0A|=20#define=20VERSION=20"0.9.0"=0A|=20=
#define=20TLS=20__thread=0A|=20#define=20CONFIG_RCU_TLS=20__thread=0A|=20=
#define=20STDC_HEADERS=201=0A|=20#define=20HAVE_SYS_TYPES_H=201=0A|=20=
#define=20HAVE_SYS_STAT_H=201=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20=
#define=20HAVE_STRING_H=201=0A|=20#define=20HAVE_MEMORY_H=201=0A|=20=
#define=20HAVE_STRINGS_H=201=0A|=20#define=20HAVE_INTTYPES_H=201=0A|=20=
#define=20HAVE_STDINT_H=201=0A|=20#define=20HAVE_UNISTD_H=201=0A|=20=
#define=20__EXTENSIONS__=201=0A|=20#define=20_ALL_SOURCE=201=0A|=20=
#define=20_GNU_SOURCE=201=0A|=20#define=20_POSIX_PTHREAD_SEMANTICS=201=0A=
|=20#define=20_TANDEM_SOURCE=201=0A|=20#define=20HAVE_DLFCN_H=201=0A|=20=
#define=20LT_OBJDIR=20".libs/"=0A|=20#define=20HAVE___ATTRIBUTE__=201=0A=
|=20#define=20HAVE_PTHREAD_PRIO_INHERIT=201=0A|=20#define=20HAVE_PTHREAD=20=
1=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20#define=20HAVE_MALLOC=200=0A|=20=
#define=20malloc=20rpl_malloc=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20=
#define=20HAVE_UNISTD_H=201=0A|=20#define=20HAVE_SYS_PARAM_H=201=0A|=20=
#define=20HAVE_GETPAGESIZE=201=0A|=20#define=20HAVE_FORK=201=0A|=20=
#define=20HAVE_VFORK=201=0A|=20#define=20HAVE_WORKING_VFORK=201=0A|=20=
#define=20HAVE_WORKING_FORK=201=0A|=20#define=20HAVE_ATEXIT=201=0A|=20=
#define=20HAVE_GETTIMEOFDAY=201=0A|=20#define=20HAVE_MEMSET=201=0A|=20=
#define=20HAVE_MUNMAP=201=0A|=20#define=20HAVE_SCHED_GETCPU=201=0A|=20=
#define=20HAVE_STRERROR=201=0A|=20#define=20HAVE_STRTOUL=201=0A|=20=
#define=20HAVE_SYSCONF=201=0A|=20/*=20end=20confdefs.h.=20=20*/=0A|=20=
#include=20<stdio.h>=0A|=20#ifdef=20HAVE_SYS_TYPES_H=0A|=20#=20include=20=
<sys/types.h>=0A|=20#endif=0A|=20#ifdef=20HAVE_SYS_STAT_H=0A|=20#=20=
include=20<sys/stat.h>=0A|=20#endif=0A|=20#ifdef=20STDC_HEADERS=0A|=20#=20=
include=20<stdlib.h>=0A|=20#=20include=20<stddef.h>=0A|=20#else=0A|=20#=20=
ifdef=20HAVE_STDLIB_H=0A|=20#=20=20include=20<stdlib.h>=0A|=20#=20endif=0A=
|=20#endif=0A|=20#ifdef=20HAVE_STRING_H=0A|=20#=20if=20!defined=20=
STDC_HEADERS=20&&=20defined=20HAVE_MEMORY_H=0A|=20#=20=20include=20=
<memory.h>=0A|=20#=20endif=0A|=20#=20include=20<string.h>=0A|=20#endif=0A=
|=20#ifdef=20HAVE_STRINGS_H=0A|=20#=20include=20<strings.h>=0A|=20#endif=0A=
|=20#ifdef=20HAVE_INTTYPES_H=0A|=20#=20include=20<inttypes.h>=0A|=20=
#endif=0A|=20#ifdef=20HAVE_STDINT_H=0A|=20#=20include=20<stdint.h>=0A|=20=
#endif=0A|=20#ifdef=20HAVE_UNISTD_H=0A|=20#=20include=20<unistd.h>=0A|=20=
#endif=0A|=20int=0A|=20main=20()=0A|=20{=0A|=20if=20(sizeof=20((_Bool)))=0A=
|=20=09=20=20=20=20return=200;=0A|=20=20=20;=0A|=20=20=20return=200;=0A|=20=
}=0Aconfigure:14772:=20result:=20yes=0Aconfigure:14797:=20checking=20=
limits.h=20usability=0Aconfigure:14797:=20arm-linux-gnueabihf-gcc=20-c=20=
-g=20-O2=20-pthread=20=20conftest.c=20>&5=0Aconfigure:14797:=20$?=20=3D=20=
0=0Aconfigure:14797:=20result:=20yes=0Aconfigure:14797:=20checking=20=
limits.h=20presence=0Aconfigure:14797:=20arm-linux-gnueabihf-gcc=20-E=20=20=
conftest.c=0Aconfigure:14797:=20$?=20=3D=200=0Aconfigure:14797:=20=
result:=20yes=0Aconfigure:14797:=20checking=20for=20limits.h=0A=
configure:14797:=20result:=20yes=0Aconfigure:14797:=20checking=20=
stddef.h=20usability=0Aconfigure:14797:=20arm-linux-gnueabihf-gcc=20-c=20=
-g=20-O2=20-pthread=20=20conftest.c=20>&5=0Aconfigure:14797:=20$?=20=3D=20=
0=0Aconfigure:14797:=20result:=20yes=0Aconfigure:14797:=20checking=20=
stddef.h=20presence=0Aconfigure:14797:=20arm-linux-gnueabihf-gcc=20-E=20=20=
conftest.c=0Aconfigure:14797:=20$?=20=3D=200=0Aconfigure:14797:=20=
result:=20yes=0Aconfigure:14797:=20checking=20for=20stddef.h=0A=
configure:14797:=20result:=20yes=0Aconfigure:14797:=20checking=20for=20=
sys/param.h=0Aconfigure:14797:=20result:=20yes=0Aconfigure:14797:=20=
checking=20sys/time.h=20usability=0Aconfigure:14797:=20=
arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20-pthread=20=20conftest.c=20>&5=0A=
configure:14797:=20$?=20=3D=200=0Aconfigure:14797:=20result:=20yes=0A=
configure:14797:=20checking=20sys/time.h=20presence=0Aconfigure:14797:=20=
arm-linux-gnueabihf-gcc=20-E=20=20conftest.c=0Aconfigure:14797:=20$?=20=3D=
=200=0Aconfigure:14797:=20result:=20yes=0Aconfigure:14797:=20checking=20=
for=20sys/time.h=0Aconfigure:14797:=20result:=20yes=0Aconfigure:14929:=20=
checking=20for=20dmb=20instruction=0Aconfigure:14942:=20=
arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20-pthread=20=20conftest.c=20>&5=0A=
configure:14942:=20$?=20=3D=200=0Aconfigure:14944:=20result:=20yes=0A=
configure:15025:=20checking=20for=20sys_futex()=0Aconfigure:15037:=20=
arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20-pthread=20=20conftest.c=20>&5=0A=
configure:15037:=20$?=20=3D=200=0Aconfigure:15039:=20result:=20yes=0A=
configure:15055:=20checking=20for=20library=20containing=20clock_gettime=0A=
configure:15086:=20arm-linux-gnueabihf-gcc=20-o=20conftest=20-g=20-O2=20=
-pthread=20=20=20conftest.c=20=20=20>&5=0Aconfigure:15086:=20$?=20=3D=20=
0=0Aconfigure:15103:=20result:=20none=20required=0Aconfigure:15116:=20=
checking=20for=20pthread_create=20in=20-lpthread=0Aconfigure:15141:=20=
arm-linux-gnueabihf-gcc=20-o=20conftest=20-g=20-O2=20-pthread=20=20=20=
conftest.c=20-lpthread=20=20=20=20>&5=0Aconfigure:15141:=20$?=20=3D=200=0A=
configure:15150:=20result:=20yes=0Aconfigure:15287:=20checking=20for=20=
cpu_set_t=0Aconfigure:15287:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=
-pthread=20-D_GNU_SOURCE=20=20conftest.c=20>&5=0Aconfigure:15287:=20$?=20=
=3D=200=0Aconfigure:15287:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20=
-pthread=20-D_GNU_SOURCE=20=20conftest.c=20>&5=0Aconftest.c:=20In=20=
function=20'main':=0Aconftest.c:66:24:=20error:=20expected=20expression=20=
before=20')'=20token=0A=20if=20(sizeof=20((cpu_set_t)))=0A=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20^=0A=
configure:15287:=20$?=20=3D=201=0Aconfigure:=20failed=20program=20was:=0A=
|=20/*=20confdefs.h=20*/=0A|=20#define=20PACKAGE_NAME=20"userspace-rcu"=0A=
|=20#define=20PACKAGE_TARNAME=20"userspace-rcu"=0A|=20#define=20=
PACKAGE_VERSION=20"0.9.0"=0A|=20#define=20PACKAGE_STRING=20=
"userspace-rcu=200.9.0"=0A|=20#define=20PACKAGE_BUGREPORT=20"mathieu=20=
dot=20desnoyers=20at=20efficios=20dot=20com"=0A|=20#define=20PACKAGE_URL=20=
"http://liburcu.org/"=0A|=20#define=20PACKAGE=20"userspace-rcu"=0A|=20=
#define=20VERSION=20"0.9.0"=0A|=20#define=20TLS=20__thread=0A|=20#define=20=
CONFIG_RCU_TLS=20__thread=0A|=20#define=20STDC_HEADERS=201=0A|=20#define=20=
HAVE_SYS_TYPES_H=201=0A|=20#define=20HAVE_SYS_STAT_H=201=0A|=20#define=20=
HAVE_STDLIB_H=201=0A|=20#define=20HAVE_STRING_H=201=0A|=20#define=20=
HAVE_MEMORY_H=201=0A|=20#define=20HAVE_STRINGS_H=201=0A|=20#define=20=
HAVE_INTTYPES_H=201=0A|=20#define=20HAVE_STDINT_H=201=0A|=20#define=20=
HAVE_UNISTD_H=201=0A|=20#define=20__EXTENSIONS__=201=0A|=20#define=20=
_ALL_SOURCE=201=0A|=20#define=20_GNU_SOURCE=201=0A|=20#define=20=
_POSIX_PTHREAD_SEMANTICS=201=0A|=20#define=20_TANDEM_SOURCE=201=0A|=20=
#define=20HAVE_DLFCN_H=201=0A|=20#define=20LT_OBJDIR=20".libs/"=0A|=20=
#define=20HAVE___ATTRIBUTE__=201=0A|=20#define=20=
HAVE_PTHREAD_PRIO_INHERIT=201=0A|=20#define=20HAVE_PTHREAD=201=0A|=20=
#define=20HAVE_STDLIB_H=201=0A|=20#define=20HAVE_MALLOC=200=0A|=20=
#define=20malloc=20rpl_malloc=0A|=20#define=20HAVE_STDLIB_H=201=0A|=20=
#define=20HAVE_UNISTD_H=201=0A|=20#define=20HAVE_SYS_PARAM_H=201=0A|=20=
#define=20HAVE_GETPAGESIZE=201=0A|=20#define=20HAVE_FORK=201=0A|=20=
#define=20HAVE_VFORK=201=0A|=20#define=20HAVE_WORKING_VFORK=201=0A|=20=
#define=20HAVE_WORKING_FORK=201=0A|=20#define=20HAVE_ATEXIT=201=0A|=20=
#define=20HAVE_GETTIMEOFDAY=201=0A|=20#define=20HAVE_MEMSET=201=0A|=20=
#define=20HAVE_MUNMAP=201=0A|=20#define=20HAVE_SCHED_GETCPU=201=0A|=20=
#define=20HAVE_STRERROR=201=0A|=20#define=20HAVE_STRTOUL=201=0A|=20=
#define=20HAVE_SYSCONF=201=0A|=20#define=20HAVE__BOOL=201=0A|=20#define=20=
HAVE_STDBOOL_H=201=0A|=20#define=20HAVE_LIMITS_H=201=0A|=20#define=20=
HAVE_STDDEF_H=201=0A|=20#define=20HAVE_SYS_PARAM_H=201=0A|=20#define=20=
HAVE_SYS_TIME_H=201=0A|=20#define=20CONFIG_RCU_ARM_HAVE_DMB=201=0A|=20=
#define=20CONFIG_RCU_HAVE_FUTEX=201=0A|=20#define=20CONFIG_RCU_SMP=201=0A=
|=20/*=20end=20confdefs.h.=20=20*/=0A|=20#include=20<sched.h>=0A|=20=0A|=20=
int=0A|=20main=20()=0A|=20{=0A|=20if=20(sizeof=20((cpu_set_t)))=0A|=20=09=
=20=20=20=20return=200;=0A|=20=20=20;=0A|=20=20=20return=200;=0A|=20}=0A=
configure:15287:=20result:=20yes=0Aconfigure:15302:=20checking=20whether=20=
CPU_ZERO=20works=0Aconfigure:15318:=20arm-linux-gnueabihf-gcc=20-c=20-g=20=
-O2=20-pthread=20-D_GNU_SOURCE=20=20conftest.c=20>&5=0Aconftest.c:63:0:=20=
warning:=20"_GNU_SOURCE"=20redefined=0A=20=20=20#define=20_GNU_SOURCE=0A=20=
^=0Aconftest.c:24:0:=20note:=20this=20is=20the=20location=20of=20the=20=
previous=20definition=0A=20#define=20_GNU_SOURCE=201=0A=20^=0A=
configure:15318:=20$?=20=3D=200=0Aconfigure:15322:=20result:=20yes=0A=
configure:15334:=20checking=20whether=20CPU_SET=20works=0A=
configure:15350:=20arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20-pthread=20=
-D_GNU_SOURCE=20=20conftest.c=20>&5=0Aconftest.c:64:0:=20warning:=20=
"_GNU_SOURCE"=20redefined=0A=20=20=20#define=20_GNU_SOURCE=0A=20^=0A=
conftest.c:24:0:=20note:=20this=20is=20the=20location=20of=20the=20=
previous=20definition=0A=20#define=20_GNU_SOURCE=201=0A=20^=0A=
configure:15350:=20$?=20=3D=200=0Aconfigure:15354:=20result:=20yes=0A=
configure:15368:=20checking=20for=20sched_setaffinity=0Aconfigure:15368:=20=
arm-linux-gnueabihf-gcc=20-o=20conftest=20-g=20-O2=20-pthread=20=
-D_GNU_SOURCE=20=20=20conftest.c=20=20=20>&5=0Aconfigure:15368:=20$?=20=3D=
=200=0Aconfigure:15368:=20result:=20yes=0Aconfigure:15385:=20checking=20=
how=20many=20arguments=20sched_setaffinity=20takes=0Aconfigure:15400:=20=
arm-linux-gnueabihf-gcc=20-c=20-g=20-O2=20-pthread=20-D_GNU_SOURCE=20=20=
conftest.c=20>&5=0Aconfigure:15400:=20$?=20=3D=200=0Aconfigure:15411:=20=
result:=203=0Aconfigure:15541:=20checking=20that=20generated=20files=20=
are=20newer=20than=20configure=0Aconfigure:15547:=20result:=20done=0A=
configure:15614:=20creating=20./config.status=0A=0A##=20=
----------------------=20##=0A##=20Running=20config.status.=20##=0A##=20=
----------------------=20##=0A=0AThis=20file=20was=20extended=20by=20=
userspace-rcu=20config.status=200.9.0,=20which=20was=0Agenerated=20by=20=
GNU=20Autoconf=202.69.=20=20Invocation=20command=20line=20was=0A=0A=20=20=
CONFIG_FILES=20=20=20=20=3D=20=0A=20=20CONFIG_HEADERS=20=20=3D=20=0A=20=20=
CONFIG_LINKS=20=20=20=20=3D=20=0A=20=20CONFIG_COMMANDS=20=3D=20=0A=20=20=
$=20./config.status=20=0A=0Aon=20gin=0A=0Aconfig.status:1177:=20creating=20=
Makefile=0Aconfig.status:1177:=20creating=20doc/Makefile=0A=
config.status:1177:=20creating=20doc/examples/Makefile=0A=
config.status:1177:=20creating=20tests/Makefile=0Aconfig.status:1177:=20=
creating=20tests/common/Makefile=0Aconfig.status:1177:=20creating=20=
tests/unit/Makefile=0Aconfig.status:1177:=20creating=20=
tests/benchmark/Makefile=0Aconfig.status:1177:=20creating=20=
tests/regression/Makefile=0Aconfig.status:1177:=20creating=20=
tests/regression/regression_tests=0Aconfig.status:1177:=20creating=20=
tests/utils/Makefile=0Aconfig.status:1177:=20creating=20liburcu.pc=0A=
config.status:1177:=20creating=20liburcu-bp.pc=0Aconfig.status:1177:=20=
creating=20liburcu-cds.pc=0Aconfig.status:1177:=20creating=20=
liburcu-qsbr.pc=0Aconfig.status:1177:=20creating=20liburcu-mb.pc=0A=
config.status:1177:=20creating=20liburcu-signal.pc=0Aconfig.status:1177:=20=
creating=20config.h=0Aconfig.status:1358:=20config.h=20is=20unchanged=0A=
config.status:1177:=20creating=20urcu/config.h=0Aconfig.status:1358:=20=
urcu/config.h=20is=20unchanged=0Aconfig.status:1418:=20linking=20=
urcu/arch/arm.h=20to=20urcu/arch.h=0Aconfig.status:1418:=20linking=20=
urcu/uatomic/arm.h=20to=20urcu/uatomic.h=0Aconfig.status:1437:=20=
executing=20depfiles=20commands=0Aconfig.status:1437:=20executing=20=
libtool=20commands=0A=0A##=20----------------=20##=0A##=20Cache=20=
variables.=20##=0A##=20----------------=20##=0A=0A=
ac_cv_build=3Dx86_64-unknown-linux-gnu=0Aac_cv_c_compiler_gnu=3Dyes=0A=
ac_cv_c_inline=3Dinline=0Aac_cv_c_int32_t=3Dyes=0Aac_cv_c_uint16_t=3Dyes=0A=
ac_cv_c_uint32_t=3Dyes=0Aac_cv_c_uint64_t=3Dyes=0Aac_cv_c_uint8_t=3Dyes=0A=
ac_cv_env_CC_set=3Dset=0Aac_cv_env_CC_value=3Darm-linux-gnueabihf-gcc=0A=
ac_cv_env_CFLAGS_set=3D=0Aac_cv_env_CFLAGS_value=3D=0A=
ac_cv_env_CPPFLAGS_set=3D=0Aac_cv_env_CPPFLAGS_value=3D=0A=
ac_cv_env_CPP_set=3D=0Aac_cv_env_CPP_value=3D=0Aac_cv_env_LDFLAGS_set=3D=0A=
ac_cv_env_LDFLAGS_value=3D=0Aac_cv_env_LIBS_set=3D=0A=
ac_cv_env_LIBS_value=3D=0Aac_cv_env_LT_SYS_LIBRARY_PATH_set=3D=0A=
ac_cv_env_LT_SYS_LIBRARY_PATH_value=3D=0Aac_cv_env_build_alias_set=3D=0A=
ac_cv_env_build_alias_value=3D=0Aac_cv_env_host_alias_set=3Dset=0A=
ac_cv_env_host_alias_value=3Darm-linux-gnueabihf=0A=
ac_cv_env_target_alias_set=3D=0Aac_cv_env_target_alias_value=3D=0A=
ac_cv_func_atexit=3Dyes=0Aac_cv_func_fork=3Dyes=0A=
ac_cv_func_fork_works=3Dyes=0Aac_cv_func_getcpuid=3Dno=0A=
ac_cv_func_getpagesize=3Dyes=0Aac_cv_func_gettid=3Dno=0A=
ac_cv_func_gettimeofday=3Dyes=0Aac_cv_func_malloc_0_nonnull=3Dno=0A=
ac_cv_func_memeset=3Dno=0Aac_cv_func_memset=3Dyes=0A=
ac_cv_func_mmap_fixed_mapped=3Dno=0Aac_cv_func_munmap=3Dyes=0A=
ac_cv_func_sched_getcpu=3Dyes=0Aac_cv_func_sched_setaffinity=3Dyes=0A=
ac_cv_func_strerror=3Dyes=0Aac_cv_func_strtoul=3Dyes=0A=
ac_cv_func_sysconf=3Dyes=0Aac_cv_func_vfork=3Dyes=0A=
ac_cv_func_vfork_works=3Dyes=0Aac_cv_header_dlfcn_h=3Dyes=0A=
ac_cv_header_inttypes_h=3Dyes=0Aac_cv_header_limits_h=3Dyes=0A=
ac_cv_header_memory_h=3Dyes=0Aac_cv_header_minix_config_h=3Dno=0A=
ac_cv_header_stdbool_h=3Dyes=0Aac_cv_header_stdc=3Dyes=0A=
ac_cv_header_stddef_h=3Dyes=0Aac_cv_header_stdint_h=3Dyes=0A=
ac_cv_header_stdlib_h=3Dyes=0Aac_cv_header_string_h=3Dyes=0A=
ac_cv_header_strings_h=3Dyes=0Aac_cv_header_sys_param_h=3Dyes=0A=
ac_cv_header_sys_stat_h=3Dyes=0Aac_cv_header_sys_time_h=3Dyes=0A=
ac_cv_header_sys_types_h=3Dyes=0Aac_cv_header_unistd_h=3Dyes=0A=
ac_cv_header_vfork_h=3Dno=0Aac_cv_host=3Darm-unknown-linux-gnueabihf=0A=
ac_cv_lib_pthread_pthread_create=3Dyes=0Aac_cv_objext=3Do=0A=
ac_cv_path_EGREP=3D'/bin/grep=20-E'=0Aac_cv_path_FGREP=3D'/bin/grep=20=
-F'=0Aac_cv_path_GREP=3D/bin/grep=0Aac_cv_path_SED=3D/bin/sed=0A=
ac_cv_path_install=3D'/usr/bin/install=20-c'=0Aac_cv_path_lt_DD=3D/bin/dd=0A=
ac_cv_path_mkdir=3D/bin/mkdir=0Aac_cv_prog_AR=3Darm-linux-gnueabihf-ar=0A=
ac_cv_prog_AWK=3Dgawk=0Aac_cv_prog_CC=3Darm-linux-gnueabihf-gcc=0A=
ac_cv_prog_CPP=3D'arm-linux-gnueabihf-gcc=20-E'=0Aac_cv_prog_NPROC=3Dnproc=
=0Aac_cv_prog_OBJDUMP=3Darm-linux-gnueabihf-objdump=0A=
ac_cv_prog_RANLIB=3Darm-linux-gnueabihf-ranlib=0A=
ac_cv_prog_STRIP=3Darm-linux-gnueabihf-strip=0A=
ac_cv_prog_ac_ct_MANIFEST_TOOL=3Dmt=0Aac_cv_prog_cc_c89=3D=0A=
ac_cv_prog_cc_c99=3D=0Aac_cv_prog_cc_g=3Dyes=0Aac_cv_prog_cc_stdc=3D=0A=
ac_cv_prog_make_make_set=3Dyes=0Aac_cv_safe_to_define___extensions__=3Dyes=
=0Aac_cv_search_clock_gettime=3D'none=20required'=0A=
ac_cv_target=3Darm-unknown-linux-gnueabihf=0Aac_cv_tls=3D__thread=0A=
ac_cv_type__Bool=3Dyes=0Aac_cv_type_cpu_set_t=3Dyes=0A=
ac_cv_type_pid_t=3Dyes=0Aac_cv_type_size_t=3Dyes=0A=
ac_cv_type_ssize_t=3Dyes=0Aam_cv_CC_dependencies_compiler_type=3Dgcc3=0A=
am_cv_make_support_nested_variables=3Dyes=0Aam_cv_prog_cc_c_o=3Dyes=0A=
ax_cv_PTHREAD_PRIO_INHERIT=3Dyes=0Aax_cv___attribute__=3Dyes=0A=
lt_cv_ar_at_file=3D@=0Alt_cv_archive_cmds_need_lc=3Dno=0A=
lt_cv_deplibs_check_method=3Dpass_all=0A=
lt_cv_file_magic_cmd=3D'$MAGIC_CMD'=0Alt_cv_file_magic_test_file=3D=0A=
lt_cv_ld_reload_flag=3D-r=0Alt_cv_nm_interface=3D'BSD=20nm'=0A=
lt_cv_objdir=3D.libs=0Alt_cv_path_LD=3D/usr/arm-linux-gnueabihf/bin/ld=0A=
lt_cv_path_NM=3D'/usr/bin/arm-linux-gnueabihf-nm=20-B'=0A=
lt_cv_path_mainfest_tool=3Dno=0Alt_cv_prog_compiler_c_o=3Dyes=0A=
lt_cv_prog_compiler_pic=3D'-fPIC=20-DPIC'=0A=
lt_cv_prog_compiler_pic_works=3Dyes=0A=
lt_cv_prog_compiler_rtti_exceptions=3Dno=0A=
lt_cv_prog_compiler_static_works=3Dyes=0Alt_cv_prog_gnu_ld=3Dyes=0A=
lt_cv_sharedlib_from_linklib_cmd=3D'printf=20%s\n'=0A=
lt_cv_shlibpath_overrides_runpath=3Dno=0A=
lt_cv_sys_global_symbol_pipe=3D'sed=20-n=20-e=20'\''s/^.*[=09=20=
]\([ABCDGIRSTW][ABCDGIRSTW]*\)[=09=20][=09=20=
]*\([_A-Za-z][_A-Za-z0-9]*\)$/\1=20\2=20\2/p'\''=20|=20sed=20'\''/=20=
__gnu_lto/d'\'''=0Alt_cv_sys_global_symbol_to_c_name_address=3D'sed=20-n=20=
-e=20'\''s/^:=20\(.*\)=20.*$/=20=20{"\1",=20(void=20*)=200},/p'\''=20-e=20=
'\''s/^[ABCDGIRSTW][ABCDGIRSTW]*=20.*=20\(.*\)$/=20=20{"\1",=20(void=20=
*)=20\&\1},/p'\'''=0A=
lt_cv_sys_global_symbol_to_c_name_address_lib_prefix=3D'sed=20-n=20-e=20=
'\''s/^:=20\(.*\)=20.*$/=20=20{"\1",=20(void=20*)=200},/p'\''=20-e=20=
'\''s/^[ABCDGIRSTW][ABCDGIRSTW]*=20.*=20\(lib.*\)$/=20=20{"\1",=20(void=20=
*)=20\&\1},/p'\''=20-e=20'\''s/^[ABCDGIRSTW][ABCDGIRSTW]*=20.*=20=
\(.*\)$/=20=20{"lib\1",=20(void=20*)=20\&\1},/p'\'''=0A=
lt_cv_sys_global_symbol_to_cdecl=3D'sed=20-n=20-e=20'\''s/^T=20.*=20=
\(.*\)$/extern=20int=20\1();/p'\''=20-e=20=
'\''s/^[ABCDGIRSTW][ABCDGIRSTW]*=20.*=20\(.*\)$/extern=20char=20=
\1;/p'\'''=0Alt_cv_sys_global_symbol_to_import=3D=0A=
lt_cv_sys_max_cmd_len=3D1572864=0A=
lt_cv_to_host_file_cmd=3Dfunc_convert_file_noop=0A=
lt_cv_to_tool_file_cmd=3Dfunc_convert_file_noop=0A=
lt_cv_truncate_bin=3D'/bin/dd=20bs=3D4096=20count=3D1'=0A=0A##=20=
-----------------=20##=0A##=20Output=20variables.=20##=0A##=20=
-----------------=20##=0A=0AACLOCAL=3D'${SHELL}=20=
/u/ldalessa/userspace-rcu/config/missing=20aclocal-1.15'=0A=
AMDEPBACKSLASH=3D'\'=0AAMDEP_FALSE=3D'#'=0AAMDEP_TRUE=3D''=0A=
AMTAR=3D'$${TAR-tar}'=0AAM_BACKSLASH=3D'\'=0A=
AM_DEFAULT_V=3D'$(AM_DEFAULT_VERBOSITY)'=0AAM_DEFAULT_VERBOSITY=3D'0'=0A=
AM_V=3D'$(V)'=0AAR=3D'arm-linux-gnueabihf-ar'=0AARCHTYPE=3D'arm'=0A=
AUTOCONF=3D'${SHELL}=20/u/ldalessa/userspace-rcu/config/missing=20=
autoconf'=0AAUTOHEADER=3D'${SHELL}=20=
/u/ldalessa/userspace-rcu/config/missing=20autoheader'=0A=
AUTOMAKE=3D'${SHELL}=20/u/ldalessa/userspace-rcu/config/missing=20=
automake-1.15'=0AAWK=3D'gawk'=0ACC=3D'arm-linux-gnueabihf-gcc'=0A=
CCDEPMODE=3D'depmode=3Dgcc3'=0ACFLAGS=3D'-g=20-O2=20-pthread'=0A=
COMPAT_ARCH_FALSE=3D''=0ACOMPAT_ARCH_TRUE=3D'#'=0ACOMPAT_FUTEX_FALSE=3D''=0A=
COMPAT_FUTEX_TRUE=3D'#'=0ACPP=3D'arm-linux-gnueabihf-gcc=20-E'=0A=
CPPFLAGS=3D''=0ACYGPATH_W=3D'echo'=0ADEFS=3D'-DHAVE_CONFIG_H'=0A=
DEPDIR=3D'.deps'=0ADLLTOOL=3D'false'=0ADSYMUTIL=3D''=0ADUMPBIN=3D''=0A=
ECHO_C=3D''=0AECHO_N=3D'-n'=0AECHO_T=3D''=0AEGREP=3D'/bin/grep=20-E'=0A=
EXEEXT=3D''=0AFGREP=3D'/bin/grep=20-F'=0AGREP=3D'/bin/grep'=0A=
INSTALL_DATA=3D'${INSTALL}=20-m=20644'=0AINSTALL_PROGRAM=3D'${INSTALL}'=0A=
INSTALL_SCRIPT=3D'${INSTALL}'=0AINSTALL_STRIP_PROGRAM=3D'$(install_sh)=20=
-c=20-s'=0ALD=3D'/usr/arm-linux-gnueabihf/bin/ld'=0ALDFLAGS=3D''=0A=
LIBC_INCLUDES_PTHREAD_FALSE=3D''=0ALIBC_INCLUDES_PTHREAD_TRUE=3D'#'=0A=
LIBOBJS=3D'=20${LIBOBJDIR}malloc$U.o'=0ALIBS=3D'=20'=0ALIBTOOL=3D'$(SHELL)=
=20$(top_builddir)/libtool'=0ALIPO=3D''=0ALN_S=3D'ln=20-s'=0ALTLIBOBJS=3D'=
=20${LIBOBJDIR}malloc$U.lo'=0ALT_SYS_LIBRARY_PATH=3D''=0AMAINT=3D''=0A=
MAINTAINER_MODE_FALSE=3D'#'=0AMAINTAINER_MODE_TRUE=3D''=0A=
MAKEINFO=3D'${SHELL}=20/u/ldalessa/userspace-rcu/config/missing=20=
makeinfo'=0AMANIFEST_TOOL=3D':'=0AMKDIR_P=3D'/bin/mkdir=20-p'=0A=
NM=3D'/usr/bin/arm-linux-gnueabihf-nm=20-B'=0ANMEDIT=3D''=0A=
NO_SHARED_FALSE=3D''=0ANO_SHARED_TRUE=3D'#'=0ANPROC=3D'nproc'=0A=
OBJDUMP=3D'arm-linux-gnueabihf-objdump'=0AOBJEXT=3D'o'=0AOTOOL64=3D''=0A=
OTOOL=3D''=0APACKAGE=3D'userspace-rcu'=0APACKAGE_BUGREPORT=3D'mathieu=20=
dot=20desnoyers=20at=20efficios=20dot=20com'=0A=
PACKAGE_NAME=3D'userspace-rcu'=0APACKAGE_STRING=3D'userspace-rcu=20=
0.9.0'=0APACKAGE_TARNAME=3D'userspace-rcu'=0A=
PACKAGE_URL=3D'http://liburcu.org/'=0APACKAGE_VERSION=3D'0.9.0'=0A=
PATH_SEPARATOR=3D':'=0APTHREAD_CC=3D'arm-linux-gnueabihf-gcc'=0A=
PTHREAD_CFLAGS=3D'-pthread'=0APTHREAD_LIBS=3D''=0A=
RANLIB=3D'arm-linux-gnueabihf-ranlib'=0ASED=3D'/bin/sed'=0ASET_MAKE=3D''=0A=
SHELL=3D'/bin/bash'=0ASTRIP=3D'arm-linux-gnueabihf-strip'=0A=
SUBARCHTYPE=3D''=0ATARGET_IS_ANDROID_FALSE=3D''=0A=
TARGET_IS_ANDROID_TRUE=3D'#'=0AURCU_LIBRARY_VERSION=3D'4:0:0'=0A=
USE_CYGWIN_FALSE=3D''=0AUSE_CYGWIN_TRUE=3D'#'=0AVERSION=3D'0.9.0'=0A=
ac_ct_AR=3D''=0Aac_ct_CC=3D''=0Aac_ct_DUMPBIN=3D''=0Aam__EXEEXT_FALSE=3D''=
=0Aam__EXEEXT_TRUE=3D'#'=0Aam__fastdepCC_FALSE=3D'#'=0A=
am__fastdepCC_TRUE=3D''=0Aam__include=3D'include'=0Aam__isrc=3D''=0A=
am__leading_dot=3D'.'=0Aam__nodep=3D'_no'=0Aam__quote=3D''=0A=
am__tar=3D'$${TAR-tar}=20chof=20-=20"$$tardir"'=0Aam__untar=3D'$${TAR-tar}=
=20xf=20-'=0Aax_pthread_config=3D''=0Abindir=3D'${exec_prefix}/bin'=0A=
build=3D'x86_64-unknown-linux-gnu'=0Abuild_alias=3D''=0A=
build_cpu=3D'x86_64'=0Abuild_os=3D'linux-gnu'=0Abuild_vendor=3D'unknown'=0A=
datadir=3D'${datarootdir}'=0Adatarootdir=3D'${prefix}/share'=0A=
docdir=3D'${datarootdir}/doc/${PACKAGE_TARNAME}'=0Advidir=3D'${docdir}'=0A=
exec_prefix=3D'${prefix}'=0Ahost=3D'arm-unknown-linux-gnueabihf'=0A=
host_alias=3D'arm-linux-gnueabihf'=0Ahost_cpu=3D'arm'=0A=
host_os=3D'linux-gnueabihf'=0Ahost_vendor=3D'unknown'=0A=
htmldir=3D'${docdir}'=0Aincludedir=3D'${prefix}/include'=0A=
infodir=3D'${datarootdir}/info'=0Ainstall_sh=3D'${SHELL}=20=
/u/ldalessa/userspace-rcu/config/install-sh'=0A=
libdir=3D'${exec_prefix}/lib'=0Alibexecdir=3D'${exec_prefix}/libexec'=0A=
localedir=3D'${datarootdir}/locale'=0Alocalstatedir=3D'${prefix}/var'=0A=
mandir=3D'${datarootdir}/man'=0Amkdir_p=3D'$(MKDIR_P)'=0A=
oldincludedir=3D'/usr/include'=0Apdfdir=3D'${docdir}'=0A=
prefix=3D'/usr/local'=0Aprogram_transform_name=3D's,x,x,'=0A=
psdir=3D'${docdir}'=0Asbindir=3D'${exec_prefix}/sbin'=0A=
sharedstatedir=3D'${prefix}/com'=0Asysconfdir=3D'${prefix}/etc'=0A=
target=3D'arm-unknown-linux-gnueabihf'=0Atarget_alias=3D''=0A=
target_cpu=3D'arm'=0Atarget_os=3D'linux-gnueabihf'=0A=
target_vendor=3D'unknown'=0A=0A##=20-----------=20##=0A##=20confdefs.h.=20=
##=0A##=20-----------=20##=0A=0A/*=20confdefs.h=20*/=0A#define=20=
PACKAGE_NAME=20"userspace-rcu"=0A#define=20PACKAGE_TARNAME=20=
"userspace-rcu"=0A#define=20PACKAGE_VERSION=20"0.9.0"=0A#define=20=
PACKAGE_STRING=20"userspace-rcu=200.9.0"=0A#define=20PACKAGE_BUGREPORT=20=
"mathieu=20dot=20desnoyers=20at=20efficios=20dot=20com"=0A#define=20=
PACKAGE_URL=20"http://liburcu.org/"=0A#define=20PACKAGE=20=
"userspace-rcu"=0A#define=20VERSION=20"0.9.0"=0A#define=20TLS=20__thread=0A=
#define=20CONFIG_RCU_TLS=20__thread=0A#define=20STDC_HEADERS=201=0A=
#define=20HAVE_SYS_TYPES_H=201=0A#define=20HAVE_SYS_STAT_H=201=0A#define=20=
HAVE_STDLIB_H=201=0A#define=20HAVE_STRING_H=201=0A#define=20=
HAVE_MEMORY_H=201=0A#define=20HAVE_STRINGS_H=201=0A#define=20=
HAVE_INTTYPES_H=201=0A#define=20HAVE_STDINT_H=201=0A#define=20=
HAVE_UNISTD_H=201=0A#define=20__EXTENSIONS__=201=0A#define=20_ALL_SOURCE=20=
1=0A#define=20_GNU_SOURCE=201=0A#define=20_POSIX_PTHREAD_SEMANTICS=201=0A=
#define=20_TANDEM_SOURCE=201=0A#define=20HAVE_DLFCN_H=201=0A#define=20=
LT_OBJDIR=20".libs/"=0A#define=20HAVE___ATTRIBUTE__=201=0A#define=20=
HAVE_PTHREAD_PRIO_INHERIT=201=0A#define=20HAVE_PTHREAD=201=0A#define=20=
HAVE_STDLIB_H=201=0A#define=20HAVE_MALLOC=200=0A#define=20malloc=20=
rpl_malloc=0A#define=20HAVE_STDLIB_H=201=0A#define=20HAVE_UNISTD_H=201=0A=
#define=20HAVE_SYS_PARAM_H=201=0A#define=20HAVE_GETPAGESIZE=201=0A=
#define=20HAVE_FORK=201=0A#define=20HAVE_VFORK=201=0A#define=20=
HAVE_WORKING_VFORK=201=0A#define=20HAVE_WORKING_FORK=201=0A#define=20=
HAVE_ATEXIT=201=0A#define=20HAVE_GETTIMEOFDAY=201=0A#define=20=
HAVE_MEMSET=201=0A#define=20HAVE_MUNMAP=201=0A#define=20=
HAVE_SCHED_GETCPU=201=0A#define=20HAVE_STRERROR=201=0A#define=20=
HAVE_STRTOUL=201=0A#define=20HAVE_SYSCONF=201=0A#define=20HAVE__BOOL=201=0A=
#define=20HAVE_STDBOOL_H=201=0A#define=20HAVE_LIMITS_H=201=0A#define=20=
HAVE_STDDEF_H=201=0A#define=20HAVE_SYS_PARAM_H=201=0A#define=20=
HAVE_SYS_TIME_H=201=0A#define=20CONFIG_RCU_ARM_HAVE_DMB=201=0A#define=20=
CONFIG_RCU_HAVE_FUTEX=201=0A#define=20CONFIG_RCU_SMP=201=0A#define=20=
HAVE_CPU_SET_T=201=0A#define=20HAVE_CPU_ZERO=201=0A#define=20=
HAVE_CPU_SET=201=0A#define=20HAVE_SCHED_SETAFFINITY=201=0A#define=20=
SCHED_SETAFFINITY_ARGS=203=0A=0Aconfigure:=20exit=200=0A=

--Apple-Mail=_7D76401C-2EC4-42BD-98EA-6EB9D5D93E99
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset=us-ascii

<html><body style="word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;"><head><meta http-equiv="Content-Type" content="text/html charset=us-ascii"></head><div class="AppleOriginalContents"></div></body></html>
--Apple-Mail=_7D76401C-2EC4-42BD-98EA-6EB9D5D93E99
Content-Disposition: attachment;
	filename=config.out
Content-Type: application/octet-stream;
	name="config.out"
Content-Transfer-Encoding: 7bit

checking build system type... x86_64-unknown-linux-gnu
checking host system type... arm-unknown-linux-gnueabihf
checking target system type... arm-unknown-linux-gnueabihf
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for arm-linux-gnueabihf-strip... arm-linux-gnueabihf-strip
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking whether make supports nested variables... yes
checking whether to enable maintainer-specific portions of Makefiles... yes
checking whether make supports nested variables... (cached) yes
checking for style of include used by make... GNU
checking for arm-linux-gnueabihf-gcc... arm-linux-gnueabihf-gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables... 
checking whether we are cross compiling... yes
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether arm-linux-gnueabihf-gcc accepts -g... yes
checking for arm-linux-gnueabihf-gcc option to accept ISO C89... none needed
checking whether arm-linux-gnueabihf-gcc understands -c and -o together... yes
checking dependency style of arm-linux-gnueabihf-gcc... gcc3
checking for thread local storage (TLS) class... __thread
checking how to run the C preprocessor... arm-linux-gnueabihf-gcc -E
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking minix/config.h usability... no
checking minix/config.h presence... no
checking for minix/config.h... no
checking whether it is safe to define __EXTENSIONS__... yes
checking for arm-linux-gnueabihf-gcc... (cached) arm-linux-gnueabihf-gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether arm-linux-gnueabihf-gcc accepts -g... (cached) yes
checking for arm-linux-gnueabihf-gcc option to accept ISO C89... (cached) none needed
checking whether arm-linux-gnueabihf-gcc understands -c and -o together... (cached) yes
checking dependency style of arm-linux-gnueabihf-gcc... (cached) gcc3
checking for arm-linux-gnueabihf-gcc option to accept ISO C99... none needed
checking for arm-linux-gnueabihf-gcc option to accept ISO Standard C... (cached) none needed
checking for gawk... (cached) gawk
checking whether make sets $(MAKE)... (cached) yes
checking for nproc... nproc
checking how to print strings... printf
checking for a sed that does not truncate output... /bin/sed
checking for fgrep... /bin/grep -F
checking for ld used by arm-linux-gnueabihf-gcc... /usr/arm-linux-gnueabihf/bin/ld
checking if the linker (/usr/arm-linux-gnueabihf/bin/ld) is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)... /usr/bin/arm-linux-gnueabihf-nm -B
checking the name lister (/usr/bin/arm-linux-gnueabihf-nm -B) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 1572864
checking how to convert x86_64-unknown-linux-gnu file names to arm-unknown-linux-gnueabihf format... func_convert_file_noop
checking how to convert x86_64-unknown-linux-gnu file names to toolchain format... func_convert_file_noop
checking for /usr/arm-linux-gnueabihf/bin/ld option to reload object files... -r
checking for arm-linux-gnueabihf-objdump... arm-linux-gnueabihf-objdump
checking how to recognize dependent libraries... pass_all
checking for arm-linux-gnueabihf-dlltool... no
checking for dlltool... no
checking how to associate runtime and link libraries... printf %s\n
checking for arm-linux-gnueabihf-ar... arm-linux-gnueabihf-ar
checking for archiver @FILE support... @
checking for arm-linux-gnueabihf-strip... (cached) arm-linux-gnueabihf-strip
checking for arm-linux-gnueabihf-ranlib... arm-linux-gnueabihf-ranlib
checking command to parse /usr/bin/arm-linux-gnueabihf-nm -B output from arm-linux-gnueabihf-gcc object... ok
checking for sysroot... no
checking for a working dd... /bin/dd
checking how to truncate binary pipes... /bin/dd bs=4096 count=1
checking for arm-linux-gnueabihf-mt... no
checking for mt... mt
configure: WARNING: using cross tools not prefixed with host triplet
checking if mt is a manifest tool... no
checking for dlfcn.h... yes
checking for objdir... .libs
checking if arm-linux-gnueabihf-gcc supports -fno-rtti -fno-exceptions... no
checking for arm-linux-gnueabihf-gcc option to produce PIC... -fPIC -DPIC
checking if arm-linux-gnueabihf-gcc PIC flag -fPIC -DPIC works... yes
checking if arm-linux-gnueabihf-gcc static flag -static works... yes
checking if arm-linux-gnueabihf-gcc supports -c -o file.o... yes
checking if arm-linux-gnueabihf-gcc supports -c -o file.o... (cached) yes
checking whether the arm-linux-gnueabihf-gcc linker (/usr/arm-linux-gnueabihf/bin/ld) supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
checking for inline... inline
checking for pid_t... yes
checking for size_t... yes
checking for ssize_t... yes
checking for uint16_t... yes
checking for int32_t... yes
checking for uint32_t... yes
checking for uint64_t... yes
checking for uint8_t... yes
checking for __attribute__... yes
checking if compiler needs -Werror to reject unknown flags... no
checking for the pthreads library -lpthreads... no
checking whether pthreads work without any flags... no
checking whether pthreads work with -Kthread... no
checking whether pthreads work with -kthread... no
checking for the pthreads library -llthread... no
checking whether pthreads work with -pthread... yes
checking for joinable pthread attribute... PTHREAD_CREATE_JOINABLE
checking if more special flags are required for pthreads... no
checking for PTHREAD_PRIO_INHERIT... yes
checking for stdlib.h... (cached) yes
checking for GNU libc compatible malloc... no
checking for stdlib.h... (cached) yes
checking for unistd.h... (cached) yes
checking for sys/param.h... yes
checking for getpagesize... yes
checking for working mmap... no
checking vfork.h usability... no
checking vfork.h presence... no
checking for vfork.h... no
checking for fork... yes
checking for vfork... yes
checking for working fork... cross
configure: WARNING: result yes guessed because of cross compilation
checking for working vfork... (cached) yes
checking for atexit... yes
checking for getcpuid... no
checking for gettid... no
checking for gettimeofday... yes
checking for memeset... no
checking for memset... yes
checking for munmap... yes
checking for sched_getcpu... yes
checking for strerror... yes
checking for strtoul... yes
checking for sysconf... yes
checking for stdbool.h that conforms to C99... yes
checking for _Bool... yes
checking limits.h usability... yes
checking limits.h presence... yes
checking for limits.h... yes
checking stddef.h usability... yes
checking stddef.h presence... yes
checking for stddef.h... yes
checking for sys/param.h... (cached) yes
checking sys/time.h usability... yes
checking sys/time.h presence... yes
checking for sys/time.h... yes
checking for dmb instruction... yes
checking for sys_futex()... yes
checking for library containing clock_gettime... none required
checking for pthread_create in -lpthread... yes
checking for cpu_set_t... yes
checking whether CPU_ZERO works... yes
checking whether CPU_SET works... yes
checking for sched_setaffinity... yes
checking how many arguments sched_setaffinity takes... 3
checking that generated files are newer than configure... done
configure: creating ./config.status
config.status: creating Makefile
config.status: creating doc/Makefile
config.status: creating doc/examples/Makefile
config.status: creating tests/Makefile
config.status: creating tests/common/Makefile
config.status: creating tests/unit/Makefile
config.status: creating tests/benchmark/Makefile
config.status: creating tests/regression/Makefile
config.status: creating tests/regression/regression_tests
config.status: creating tests/utils/Makefile
config.status: creating liburcu.pc
config.status: creating liburcu-bp.pc
config.status: creating liburcu-cds.pc
config.status: creating liburcu-qsbr.pc
config.status: creating liburcu-mb.pc
config.status: creating liburcu-signal.pc
config.status: creating config.h
config.status: config.h is unchanged
config.status: creating urcu/config.h
config.status: urcu/config.h is unchanged
config.status: linking urcu/arch/arm.h to urcu/arch.h
config.status: linking urcu/uatomic/arm.h to urcu/uatomic.h
config.status: executing depfiles commands
config.status: executing libtool commands
SMP support enabled.
Thread Local Storage (TLS): __thread.

--Apple-Mail=_7D76401C-2EC4-42BD-98EA-6EB9D5D93E99
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset=us-ascii

<html><body style="word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;"><head><meta http-equiv="Content-Type" content="text/html charset=us-ascii"></head><div class="AppleOriginalContents"></div></body></html>
--Apple-Mail=_7D76401C-2EC4-42BD-98EA-6EB9D5D93E99
Content-Disposition: attachment;
	filename=make.out
Content-Type: application/octet-stream;
	name="make.out"
Content-Transfer-Encoding: quoted-printable

make=20=20all-recursive=0Amake[1]:=20Entering=20directory=20=
'/home/ldalessa/userspace-rcu'=0AMaking=20all=20in=20.=0Amake[2]:=20=
Entering=20directory=20'/home/ldalessa/userspace-rcu'=0A/bin/bash=20=
./libtool=20=20--tag=3DCC=20=20=20--mode=3Dcompile=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=20-I./urcu=20=
=20-Wall=20-g=20-O2=20-pthread=20-MT=20wfqueue.lo=20-MD=20-MP=20-MF=20=
.deps/wfqueue.Tpo=20-c=20-o=20wfqueue.lo=20wfqueue.c=0Alibtool:=20=
compile:=20=20arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=
-I./urcu=20-Wall=20-g=20-O2=20-pthread=20-MT=20wfqueue.lo=20-MD=20-MP=20=
-MF=20.deps/wfqueue.Tpo=20-c=20wfqueue.c=20=20-fPIC=20-DPIC=20-o=20=
.libs/wfqueue.o=0Alibtool:=20compile:=20=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20-Wall=20-g=20-O2=20=
-pthread=20-MT=20wfqueue.lo=20-MD=20-MP=20-MF=20.deps/wfqueue.Tpo=20-c=20=
wfqueue.c=20-o=20wfqueue.o=20>/dev/null=202>&1=0Amv=20-f=20=
.deps/wfqueue.Tpo=20.deps/wfqueue.Plo=0A/bin/bash=20./libtool=20=20=
--tag=3DCC=20=20=20--mode=3Dcompile=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=20-I./urcu=20=20-Wall=20-g=20-O2=20=
-pthread=20-MT=20wfcqueue.lo=20-MD=20-MP=20-MF=20.deps/wfcqueue.Tpo=20-c=20=
-o=20wfcqueue.lo=20wfcqueue.c=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-Wall=20-g=20-O2=20-pthread=20-MT=20wfcqueue.lo=20-MD=20-MP=20-MF=20=
.deps/wfcqueue.Tpo=20-c=20wfcqueue.c=20=20-fPIC=20-DPIC=20-o=20=
.libs/wfcqueue.o=0Alibtool:=20compile:=20=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20-Wall=20-g=20-O2=20=
-pthread=20-MT=20wfcqueue.lo=20-MD=20-MP=20-MF=20.deps/wfcqueue.Tpo=20-c=20=
wfcqueue.c=20-o=20wfcqueue.o=20>/dev/null=202>&1=0Amv=20-f=20=
.deps/wfcqueue.Tpo=20.deps/wfcqueue.Plo=0A/bin/bash=20./libtool=20=20=
--tag=3DCC=20=20=20--mode=3Dcompile=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=20-I./urcu=20=20-Wall=20-g=20-O2=20=
-pthread=20-MT=20wfstack.lo=20-MD=20-MP=20-MF=20.deps/wfstack.Tpo=20-c=20=
-o=20wfstack.lo=20wfstack.c=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-Wall=20-g=20-O2=20-pthread=20-MT=20wfstack.lo=20-MD=20-MP=20-MF=20=
.deps/wfstack.Tpo=20-c=20wfstack.c=20=20-fPIC=20-DPIC=20-o=20=
.libs/wfstack.o=0Alibtool:=20compile:=20=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20-Wall=20-g=20-O2=20=
-pthread=20-MT=20wfstack.lo=20-MD=20-MP=20-MF=20.deps/wfstack.Tpo=20-c=20=
wfstack.c=20-o=20wfstack.o=20>/dev/null=202>&1=0Amv=20-f=20=
.deps/wfstack.Tpo=20.deps/wfstack.Plo=0A/bin/bash=20./libtool=20=20=
--tag=3DCC=20=20=20--mode=3Dcompile=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=20-I./urcu=20=20-Wall=20-g=20-O2=20=
-pthread=20-MT=20compat_futex.lo=20-MD=20-MP=20-MF=20=
.deps/compat_futex.Tpo=20-c=20-o=20compat_futex.lo=20compat_futex.c=0A=
libtool:=20compile:=20=20arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20=
-I./urcu=20-I./urcu=20-Wall=20-g=20-O2=20-pthread=20-MT=20=
compat_futex.lo=20-MD=20-MP=20-MF=20.deps/compat_futex.Tpo=20-c=20=
compat_futex.c=20=20-fPIC=20-DPIC=20-o=20.libs/compat_futex.o=0Alibtool:=20=
compile:=20=20arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=
-I./urcu=20-Wall=20-g=20-O2=20-pthread=20-MT=20compat_futex.lo=20-MD=20=
-MP=20-MF=20.deps/compat_futex.Tpo=20-c=20compat_futex.c=20-o=20=
compat_futex.o=20>/dev/null=202>&1=0Amv=20-f=20.deps/compat_futex.Tpo=20=
.deps/compat_futex.Plo=0A/bin/bash=20./libtool=20=20--tag=3DCC=20=20=20=
--mode=3Dlink=20arm-linux-gnueabihf-gcc=20-Wall=20-g=20-O2=20-pthread=20=
-version-info=204:0:0=20-lpthread=20=20=20-o=20liburcu-common.la=20=
-rpath=20/usr/local/lib=20wfqueue.lo=20wfcqueue.lo=20wfstack.lo=20=
compat_futex.lo=20=20=0Alibtool:=20link:=20arm-linux-gnueabihf-gcc=20=
-shared=20=20-fPIC=20-DPIC=20=20.libs/wfqueue.o=20.libs/wfcqueue.o=20=
.libs/wfstack.o=20.libs/compat_futex.o=20=20=20-lpthread=20=20-g=20-O2=20=
-pthread=20=20=20-pthread=20-Wl,-soname=20-Wl,liburcu-common.so.4=20-o=20=
.libs/liburcu-common.so.4.0.0=0Alibtool:=20link:=20(cd=20".libs"=20&&=20=
rm=20-f=20"liburcu-common.so.4"=20&&=20ln=20-s=20=
"liburcu-common.so.4.0.0"=20"liburcu-common.so.4")=0Alibtool:=20link:=20=
(cd=20".libs"=20&&=20rm=20-f=20"liburcu-common.so"=20&&=20ln=20-s=20=
"liburcu-common.so.4.0.0"=20"liburcu-common.so")=0Alibtool:=20link:=20=
arm-linux-gnueabihf-ar=20cru=20.libs/liburcu-common.a=20=20wfqueue.o=20=
wfcqueue.o=20wfstack.o=20compat_futex.o=0Aarm-linux-gnueabihf-ar:=20`u'=20=
modifier=20ignored=20since=20`D'=20is=20the=20default=20(see=20`U')=0A=
libtool:=20link:=20arm-linux-gnueabihf-ranlib=20.libs/liburcu-common.a=0A=
libtool:=20link:=20(=20cd=20".libs"=20&&=20rm=20-f=20"liburcu-common.la"=20=
&&=20ln=20-s=20"../liburcu-common.la"=20"liburcu-common.la"=20)=0A=
/bin/bash=20./libtool=20=20--tag=3DCC=20=20=20--mode=3Dcompile=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=20-I./urcu=20=
=20-Wall=20-g=20-O2=20-pthread=20-MT=20urcu.lo=20-MD=20-MP=20-MF=20=
.deps/urcu.Tpo=20-c=20-o=20urcu.lo=20urcu.c=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-Wall=20-g=20-O2=20-pthread=20-MT=20urcu.lo=20-MD=20-MP=20-MF=20=
.deps/urcu.Tpo=20-c=20urcu.c=20=20-fPIC=20-DPIC=20-o=20.libs/urcu.o=0AIn=20=
file=20included=20from=20compat-getcpu.h:24:0,=0A=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20from=20urcu-call-rcu-impl.h:39,=0A=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20from=20urcu.c:604:=0A=
urcu-call-rcu-impl.h:=20In=20function=20=E2=80=98alloc_cpu_call_rcu_data=E2=
=80=99:=0A./config.h:249:16:=20warning:=20implicit=20declaration=20of=20=
function=20=E2=80=98rpl_malloc=E2=80=99=20=
[-Wimplicit-function-declaration]=0A=20#define=20malloc=20rpl_malloc=0A=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20^=0A=
urcu-call-rcu-impl.h:141:6:=20note:=20in=20expansion=20of=20macro=20=
=E2=80=98malloc=E2=80=99=0A=20=20p=20=3D=20malloc(maxcpus=20*=20=
sizeof(*per_cpu_call_rcu_data));=0A=20=20=20=20=20=20^=0AIn=20file=20=
included=20from=20urcu.c:604:0:=0Aurcu-call-rcu-impl.h:141:4:=20warning:=20=
assignment=20makes=20pointer=20from=20integer=20without=20a=20cast=20=
[-Wint-conversion]=0A=20=20p=20=3D=20malloc(maxcpus=20*=20=
sizeof(*per_cpu_call_rcu_data));=0A=20=20=20=20^=0Aurcu-call-rcu-impl.h:=20=
In=20function=20=E2=80=98call_rcu_data_init=E2=80=99:=0A=
urcu-call-rcu-impl.h:422:7:=20warning:=20assignment=20makes=20pointer=20=
from=20integer=20without=20a=20cast=20[-Wint-conversion]=0A=20=20crdp=20=
=3D=20malloc(sizeof(*crdp));=0A=20=20=20=20=20=20=20^=0A=
urcu-call-rcu-impl.h:=20In=20function=20=
=E2=80=98free_all_cpu_call_rcu_data_memb=E2=80=99:=0A=
urcu-call-rcu-impl.h:784:7:=20warning:=20assignment=20makes=20pointer=20=
from=20integer=20without=20a=20cast=20[-Wint-conversion]=0A=20=20crdp=20=
=3D=20malloc(sizeof(*crdp)=20*=20maxcpus);=0A=20=20=20=20=20=20=20^=0AIn=20=
file=20included=20from=20urcu.c:605:0:=0Aurcu-defer-impl.h:=20In=20=
function=20=E2=80=98rcu_defer_register_thread_memb=E2=80=99:=0A=
urcu-defer-impl.h:432:26:=20warning:=20assignment=20makes=20pointer=20=
from=20integer=20without=20a=20cast=20[-Wint-conversion]=0A=20=20=
URCU_TLS(defer_queue).q=20=3D=20malloc(sizeof(void=20*)=20*=20=
DEFER_QUEUE_SIZE);=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20^=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-Wall=20-g=20-O2=20-pthread=20-MT=20urcu.lo=20-MD=20-MP=20-MF=20=
.deps/urcu.Tpo=20-c=20urcu.c=20-o=20urcu.o=20>/dev/null=202>&1=0Amv=20-f=20=
.deps/urcu.Tpo=20.deps/urcu.Plo=0A/bin/bash=20./libtool=20=20--tag=3DCC=20=
=20=20--mode=3Dcompile=20arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20=
-I./urcu=20=20-I./urcu=20=20-Wall=20-g=20-O2=20-pthread=20-MT=20=
urcu-pointer.lo=20-MD=20-MP=20-MF=20.deps/urcu-pointer.Tpo=20-c=20-o=20=
urcu-pointer.lo=20urcu-pointer.c=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-Wall=20-g=20-O2=20-pthread=20-MT=20urcu-pointer.lo=20-MD=20-MP=20-MF=20=
.deps/urcu-pointer.Tpo=20-c=20urcu-pointer.c=20=20-fPIC=20-DPIC=20-o=20=
.libs/urcu-pointer.o=0Alibtool:=20compile:=20=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20-Wall=20-g=20-O2=20=
-pthread=20-MT=20urcu-pointer.lo=20-MD=20-MP=20-MF=20=
.deps/urcu-pointer.Tpo=20-c=20urcu-pointer.c=20-o=20urcu-pointer.o=20=
>/dev/null=202>&1=0Amv=20-f=20.deps/urcu-pointer.Tpo=20=
.deps/urcu-pointer.Plo=0A/bin/bash=20./libtool=20=20--tag=3DCC=20=20=20=
--mode=3Dlink=20arm-linux-gnueabihf-gcc=20-Wall=20-g=20-O2=20-pthread=20=
-version-info=204:0:0=20-lpthread=20=20=20-o=20liburcu.la=20-rpath=20=
/usr/local/lib=20urcu.lo=20urcu-pointer.lo=20compat_futex.lo=20=
liburcu-common.la=20=0Alibtool:=20link:=20arm-linux-gnueabihf-gcc=20=
-shared=20=20-fPIC=20-DPIC=20=20.libs/urcu.o=20.libs/urcu-pointer.o=20=
.libs/compat_futex.o=20=20=20-Wl,-rpath=20=
-Wl,/u/ldalessa/userspace-rcu/.libs=20./.libs/liburcu-common.so=20=
-lpthread=20=20-g=20-O2=20-pthread=20=20=20-pthread=20-Wl,-soname=20=
-Wl,liburcu.so.4=20-o=20.libs/liburcu.so.4.0.0=0Alibtool:=20link:=20(cd=20=
".libs"=20&&=20rm=20-f=20"liburcu.so.4"=20&&=20ln=20-s=20=
"liburcu.so.4.0.0"=20"liburcu.so.4")=0Alibtool:=20link:=20(cd=20".libs"=20=
&&=20rm=20-f=20"liburcu.so"=20&&=20ln=20-s=20"liburcu.so.4.0.0"=20=
"liburcu.so")=0Alibtool:=20link:=20arm-linux-gnueabihf-ar=20cru=20=
.libs/liburcu.a=20=20urcu.o=20urcu-pointer.o=20compat_futex.o=0A=
arm-linux-gnueabihf-ar:=20`u'=20modifier=20ignored=20since=20`D'=20is=20=
the=20default=20(see=20`U')=0Alibtool:=20link:=20=
arm-linux-gnueabihf-ranlib=20.libs/liburcu.a=0Alibtool:=20link:=20(=20cd=20=
".libs"=20&&=20rm=20-f=20"liburcu.la"=20&&=20ln=20-s=20"../liburcu.la"=20=
"liburcu.la"=20)=0A/bin/bash=20./libtool=20=20--tag=3DCC=20=20=20=
--mode=3Dcompile=20arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20=
-I./urcu=20=20-I./urcu=20=20-Wall=20-g=20-O2=20-pthread=20-MT=20=
urcu-qsbr.lo=20-MD=20-MP=20-MF=20.deps/urcu-qsbr.Tpo=20-c=20-o=20=
urcu-qsbr.lo=20urcu-qsbr.c=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-Wall=20-g=20-O2=20-pthread=20-MT=20urcu-qsbr.lo=20-MD=20-MP=20-MF=20=
.deps/urcu-qsbr.Tpo=20-c=20urcu-qsbr.c=20=20-fPIC=20-DPIC=20-o=20=
.libs/urcu-qsbr.o=0AIn=20file=20included=20from=20compat-getcpu.h:24:0,=0A=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20from=20=
urcu-call-rcu-impl.h:39,=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20from=20urcu-qsbr.c:503:=0Aurcu-call-rcu-impl.h:=20In=20function=20=
=E2=80=98alloc_cpu_call_rcu_data=E2=80=99:=0A./config.h:249:16:=20=
warning:=20implicit=20declaration=20of=20function=20=E2=80=98rpl_malloc=E2=
=80=99=20[-Wimplicit-function-declaration]=0A=20#define=20malloc=20=
rpl_malloc=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20^=0A=
urcu-call-rcu-impl.h:141:6:=20note:=20in=20expansion=20of=20macro=20=
=E2=80=98malloc=E2=80=99=0A=20=20p=20=3D=20malloc(maxcpus=20*=20=
sizeof(*per_cpu_call_rcu_data));=0A=20=20=20=20=20=20^=0AIn=20file=20=
included=20from=20urcu-qsbr.c:503:0:=0Aurcu-call-rcu-impl.h:141:4:=20=
warning:=20assignment=20makes=20pointer=20from=20integer=20without=20a=20=
cast=20[-Wint-conversion]=0A=20=20p=20=3D=20malloc(maxcpus=20*=20=
sizeof(*per_cpu_call_rcu_data));=0A=20=20=20=20^=0Aurcu-call-rcu-impl.h:=20=
In=20function=20=E2=80=98call_rcu_data_init=E2=80=99:=0A=
urcu-call-rcu-impl.h:422:7:=20warning:=20assignment=20makes=20pointer=20=
from=20integer=20without=20a=20cast=20[-Wint-conversion]=0A=20=20crdp=20=
=3D=20malloc(sizeof(*crdp));=0A=20=20=20=20=20=20=20^=0A=
urcu-call-rcu-impl.h:=20In=20function=20=
=E2=80=98free_all_cpu_call_rcu_data=E2=80=99:=0A=
urcu-call-rcu-impl.h:784:7:=20warning:=20assignment=20makes=20pointer=20=
from=20integer=20without=20a=20cast=20[-Wint-conversion]=0A=20=20crdp=20=
=3D=20malloc(sizeof(*crdp)=20*=20maxcpus);=0A=20=20=20=20=20=20=20^=0AIn=20=
file=20included=20from=20urcu-qsbr.c:504:0:=0Aurcu-defer-impl.h:=20In=20=
function=20=E2=80=98rcu_defer_register_thread_qsbr=E2=80=99:=0A=
urcu-defer-impl.h:432:26:=20warning:=20assignment=20makes=20pointer=20=
from=20integer=20without=20a=20cast=20[-Wint-conversion]=0A=20=20=
URCU_TLS(defer_queue).q=20=3D=20malloc(sizeof(void=20*)=20*=20=
DEFER_QUEUE_SIZE);=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20^=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-Wall=20-g=20-O2=20-pthread=20-MT=20urcu-qsbr.lo=20-MD=20-MP=20-MF=20=
.deps/urcu-qsbr.Tpo=20-c=20urcu-qsbr.c=20-o=20urcu-qsbr.o=20>/dev/null=20=
2>&1=0Amv=20-f=20.deps/urcu-qsbr.Tpo=20.deps/urcu-qsbr.Plo=0A/bin/bash=20=
./libtool=20=20--tag=3DCC=20=20=20--mode=3Dlink=20=
arm-linux-gnueabihf-gcc=20-Wall=20-g=20-O2=20-pthread=20-version-info=20=
4:0:0=20-lpthread=20=20=20-o=20liburcu-qsbr.la=20-rpath=20/usr/local/lib=20=
urcu-qsbr.lo=20urcu-pointer.lo=20compat_futex.lo=20liburcu-common.la=20=0A=
libtool:=20link:=20arm-linux-gnueabihf-gcc=20-shared=20=20-fPIC=20-DPIC=20=
=20.libs/urcu-qsbr.o=20.libs/urcu-pointer.o=20.libs/compat_futex.o=20=20=20=
-Wl,-rpath=20-Wl,/u/ldalessa/userspace-rcu/.libs=20=
./.libs/liburcu-common.so=20-lpthread=20=20-g=20-O2=20-pthread=20=20=20=
-pthread=20-Wl,-soname=20-Wl,liburcu-qsbr.so.4=20-o=20=
.libs/liburcu-qsbr.so.4.0.0=0Alibtool:=20link:=20(cd=20".libs"=20&&=20rm=20=
-f=20"liburcu-qsbr.so.4"=20&&=20ln=20-s=20"liburcu-qsbr.so.4.0.0"=20=
"liburcu-qsbr.so.4")=0Alibtool:=20link:=20(cd=20".libs"=20&&=20rm=20-f=20=
"liburcu-qsbr.so"=20&&=20ln=20-s=20"liburcu-qsbr.so.4.0.0"=20=
"liburcu-qsbr.so")=0Alibtool:=20link:=20arm-linux-gnueabihf-ar=20cru=20=
.libs/liburcu-qsbr.a=20=20urcu-qsbr.o=20urcu-pointer.o=20compat_futex.o=0A=
arm-linux-gnueabihf-ar:=20`u'=20modifier=20ignored=20since=20`D'=20is=20=
the=20default=20(see=20`U')=0Alibtool:=20link:=20=
arm-linux-gnueabihf-ranlib=20.libs/liburcu-qsbr.a=0Alibtool:=20link:=20(=20=
cd=20".libs"=20&&=20rm=20-f=20"liburcu-qsbr.la"=20&&=20ln=20-s=20=
"../liburcu-qsbr.la"=20"liburcu-qsbr.la"=20)=0A/bin/bash=20./libtool=20=20=
--tag=3DCC=20=20=20--mode=3Dcompile=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=20-I./urcu=20=20-DRCU_MB=20-g=20-O2=20=
-pthread=20-MT=20liburcu_mb_la-urcu.lo=20-MD=20-MP=20-MF=20=
.deps/liburcu_mb_la-urcu.Tpo=20-c=20-o=20liburcu_mb_la-urcu.lo=20`test=20=
-f=20'urcu.c'=20||=20echo=20'./'`urcu.c=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-DRCU_MB=20-g=20-O2=20-pthread=20-MT=20liburcu_mb_la-urcu.lo=20-MD=20-MP=20=
-MF=20.deps/liburcu_mb_la-urcu.Tpo=20-c=20urcu.c=20=20-fPIC=20-DPIC=20-o=20=
.libs/liburcu_mb_la-urcu.o=0AIn=20file=20included=20from=20=
compat-getcpu.h:24:0,=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
from=20urcu-call-rcu-impl.h:39,=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20from=20urcu.c:604:=0Aurcu-call-rcu-impl.h:=20In=20function=20=
=E2=80=98alloc_cpu_call_rcu_data=E2=80=99:=0A./config.h:249:16:=20=
warning:=20implicit=20declaration=20of=20function=20=E2=80=98rpl_malloc=E2=
=80=99=20[-Wimplicit-function-declaration]=0A=20#define=20malloc=20=
rpl_malloc=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20^=0A=
urcu-call-rcu-impl.h:141:6:=20note:=20in=20expansion=20of=20macro=20=
=E2=80=98malloc=E2=80=99=0A=20=20p=20=3D=20malloc(maxcpus=20*=20=
sizeof(*per_cpu_call_rcu_data));=0A=20=20=20=20=20=20^=0AIn=20file=20=
included=20from=20urcu.c:604:0:=0Aurcu-call-rcu-impl.h:141:4:=20warning:=20=
assignment=20makes=20pointer=20from=20integer=20without=20a=20cast=20=
[-Wint-conversion]=0A=20=20p=20=3D=20malloc(maxcpus=20*=20=
sizeof(*per_cpu_call_rcu_data));=0A=20=20=20=20^=0Aurcu-call-rcu-impl.h:=20=
In=20function=20=E2=80=98call_rcu_data_init=E2=80=99:=0A=
urcu-call-rcu-impl.h:422:7:=20warning:=20assignment=20makes=20pointer=20=
from=20integer=20without=20a=20cast=20[-Wint-conversion]=0A=20=20crdp=20=
=3D=20malloc(sizeof(*crdp));=0A=20=20=20=20=20=20=20^=0A=
urcu-call-rcu-impl.h:=20In=20function=20=
=E2=80=98free_all_cpu_call_rcu_data_mb=E2=80=99:=0A=
urcu-call-rcu-impl.h:784:7:=20warning:=20assignment=20makes=20pointer=20=
from=20integer=20without=20a=20cast=20[-Wint-conversion]=0A=20=20crdp=20=
=3D=20malloc(sizeof(*crdp)=20*=20maxcpus);=0A=20=20=20=20=20=20=20^=0AIn=20=
file=20included=20from=20urcu.c:605:0:=0Aurcu-defer-impl.h:=20In=20=
function=20=E2=80=98rcu_defer_register_thread_mb=E2=80=99:=0A=
urcu-defer-impl.h:432:26:=20warning:=20assignment=20makes=20pointer=20=
from=20integer=20without=20a=20cast=20[-Wint-conversion]=0A=20=20=
URCU_TLS(defer_queue).q=20=3D=20malloc(sizeof(void=20*)=20*=20=
DEFER_QUEUE_SIZE);=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20^=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-DRCU_MB=20-g=20-O2=20-pthread=20-MT=20liburcu_mb_la-urcu.lo=20-MD=20-MP=20=
-MF=20.deps/liburcu_mb_la-urcu.Tpo=20-c=20urcu.c=20-o=20=
liburcu_mb_la-urcu.o=20>/dev/null=202>&1=0Amv=20-f=20=
.deps/liburcu_mb_la-urcu.Tpo=20.deps/liburcu_mb_la-urcu.Plo=0A/bin/bash=20=
./libtool=20=20--tag=3DCC=20=20=20--mode=3Dcompile=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=20-I./urcu=20=
=20-DRCU_MB=20-g=20-O2=20-pthread=20-MT=20liburcu_mb_la-urcu-pointer.lo=20=
-MD=20-MP=20-MF=20.deps/liburcu_mb_la-urcu-pointer.Tpo=20-c=20-o=20=
liburcu_mb_la-urcu-pointer.lo=20`test=20-f=20'urcu-pointer.c'=20||=20=
echo=20'./'`urcu-pointer.c=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-DRCU_MB=20-g=20-O2=20-pthread=20-MT=20liburcu_mb_la-urcu-pointer.lo=20=
-MD=20-MP=20-MF=20.deps/liburcu_mb_la-urcu-pointer.Tpo=20-c=20=
urcu-pointer.c=20=20-fPIC=20-DPIC=20-o=20=
.libs/liburcu_mb_la-urcu-pointer.o=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-DRCU_MB=20-g=20-O2=20-pthread=20-MT=20liburcu_mb_la-urcu-pointer.lo=20=
-MD=20-MP=20-MF=20.deps/liburcu_mb_la-urcu-pointer.Tpo=20-c=20=
urcu-pointer.c=20-o=20liburcu_mb_la-urcu-pointer.o=20>/dev/null=202>&1=0A=
mv=20-f=20.deps/liburcu_mb_la-urcu-pointer.Tpo=20=
.deps/liburcu_mb_la-urcu-pointer.Plo=0A/bin/bash=20./libtool=20=20=
--tag=3DCC=20=20=20--mode=3Dcompile=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=20-I./urcu=20=20-DRCU_MB=20-g=20-O2=20=
-pthread=20-MT=20liburcu_mb_la-compat_futex.lo=20-MD=20-MP=20-MF=20=
.deps/liburcu_mb_la-compat_futex.Tpo=20-c=20-o=20=
liburcu_mb_la-compat_futex.lo=20`test=20-f=20'compat_futex.c'=20||=20=
echo=20'./'`compat_futex.c=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-DRCU_MB=20-g=20-O2=20-pthread=20-MT=20liburcu_mb_la-compat_futex.lo=20=
-MD=20-MP=20-MF=20.deps/liburcu_mb_la-compat_futex.Tpo=20-c=20=
compat_futex.c=20=20-fPIC=20-DPIC=20-o=20=
.libs/liburcu_mb_la-compat_futex.o=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-DRCU_MB=20-g=20-O2=20-pthread=20-MT=20liburcu_mb_la-compat_futex.lo=20=
-MD=20-MP=20-MF=20.deps/liburcu_mb_la-compat_futex.Tpo=20-c=20=
compat_futex.c=20-o=20liburcu_mb_la-compat_futex.o=20>/dev/null=202>&1=0A=
mv=20-f=20.deps/liburcu_mb_la-compat_futex.Tpo=20=
.deps/liburcu_mb_la-compat_futex.Plo=0A/bin/bash=20./libtool=20=20=
--tag=3DCC=20=20=20--mode=3Dlink=20arm-linux-gnueabihf-gcc=20-DRCU_MB=20=
-g=20-O2=20-pthread=20-version-info=204:0:0=20-lpthread=20=20=20-o=20=
liburcu-mb.la=20-rpath=20/usr/local/lib=20liburcu_mb_la-urcu.lo=20=
liburcu_mb_la-urcu-pointer.lo=20liburcu_mb_la-compat_futex.lo=20=
liburcu-common.la=20=0Alibtool:=20link:=20arm-linux-gnueabihf-gcc=20=
-shared=20=20-fPIC=20-DPIC=20=20.libs/liburcu_mb_la-urcu.o=20=
.libs/liburcu_mb_la-urcu-pointer.o=20.libs/liburcu_mb_la-compat_futex.o=20=
=20=20-Wl,-rpath=20-Wl,/u/ldalessa/userspace-rcu/.libs=20=
./.libs/liburcu-common.so=20-lpthread=20=20-g=20-O2=20-pthread=20=20=20=
-pthread=20-Wl,-soname=20-Wl,liburcu-mb.so.4=20-o=20=
.libs/liburcu-mb.so.4.0.0=0Alibtool:=20link:=20(cd=20".libs"=20&&=20rm=20=
-f=20"liburcu-mb.so.4"=20&&=20ln=20-s=20"liburcu-mb.so.4.0.0"=20=
"liburcu-mb.so.4")=0Alibtool:=20link:=20(cd=20".libs"=20&&=20rm=20-f=20=
"liburcu-mb.so"=20&&=20ln=20-s=20"liburcu-mb.so.4.0.0"=20=
"liburcu-mb.so")=0Alibtool:=20link:=20arm-linux-gnueabihf-ar=20cru=20=
.libs/liburcu-mb.a=20=20liburcu_mb_la-urcu.o=20=
liburcu_mb_la-urcu-pointer.o=20liburcu_mb_la-compat_futex.o=0A=
arm-linux-gnueabihf-ar:=20`u'=20modifier=20ignored=20since=20`D'=20is=20=
the=20default=20(see=20`U')=0Alibtool:=20link:=20=
arm-linux-gnueabihf-ranlib=20.libs/liburcu-mb.a=0Alibtool:=20link:=20(=20=
cd=20".libs"=20&&=20rm=20-f=20"liburcu-mb.la"=20&&=20ln=20-s=20=
"../liburcu-mb.la"=20"liburcu-mb.la"=20)=0A/bin/bash=20./libtool=20=20=
--tag=3DCC=20=20=20--mode=3Dcompile=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=20-I./urcu=20=20-DRCU_SIGNAL=20-g=20=
-O2=20-pthread=20-MT=20liburcu_signal_la-urcu.lo=20-MD=20-MP=20-MF=20=
.deps/liburcu_signal_la-urcu.Tpo=20-c=20-o=20liburcu_signal_la-urcu.lo=20=
`test=20-f=20'urcu.c'=20||=20echo=20'./'`urcu.c=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-DRCU_SIGNAL=20-g=20-O2=20-pthread=20-MT=20liburcu_signal_la-urcu.lo=20=
-MD=20-MP=20-MF=20.deps/liburcu_signal_la-urcu.Tpo=20-c=20urcu.c=20=20=
-fPIC=20-DPIC=20-o=20.libs/liburcu_signal_la-urcu.o=0AIn=20file=20=
included=20from=20compat-getcpu.h:24:0,=0A=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20from=20urcu-call-rcu-impl.h:39,=0A=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20from=20urcu.c:604:=0Aurcu-call-rcu-impl.h:=20=
In=20function=20=E2=80=98alloc_cpu_call_rcu_data=E2=80=99:=0A=
./config.h:249:16:=20warning:=20implicit=20declaration=20of=20function=20=
=E2=80=98rpl_malloc=E2=80=99=20[-Wimplicit-function-declaration]=0A=20=
#define=20malloc=20rpl_malloc=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20^=0Aurcu-call-rcu-impl.h:141:6:=20note:=20in=20expansion=20of=20=
macro=20=E2=80=98malloc=E2=80=99=0A=20=20p=20=3D=20malloc(maxcpus=20*=20=
sizeof(*per_cpu_call_rcu_data));=0A=20=20=20=20=20=20^=0AIn=20file=20=
included=20from=20urcu.c:604:0:=0Aurcu-call-rcu-impl.h:141:4:=20warning:=20=
assignment=20makes=20pointer=20from=20integer=20without=20a=20cast=20=
[-Wint-conversion]=0A=20=20p=20=3D=20malloc(maxcpus=20*=20=
sizeof(*per_cpu_call_rcu_data));=0A=20=20=20=20^=0Aurcu-call-rcu-impl.h:=20=
In=20function=20=E2=80=98call_rcu_data_init=E2=80=99:=0A=
urcu-call-rcu-impl.h:422:7:=20warning:=20assignment=20makes=20pointer=20=
from=20integer=20without=20a=20cast=20[-Wint-conversion]=0A=20=20crdp=20=
=3D=20malloc(sizeof(*crdp));=0A=20=20=20=20=20=20=20^=0A=
urcu-call-rcu-impl.h:=20In=20function=20=
=E2=80=98free_all_cpu_call_rcu_data_sig=E2=80=99:=0A=
urcu-call-rcu-impl.h:784:7:=20warning:=20assignment=20makes=20pointer=20=
from=20integer=20without=20a=20cast=20[-Wint-conversion]=0A=20=20crdp=20=
=3D=20malloc(sizeof(*crdp)=20*=20maxcpus);=0A=20=20=20=20=20=20=20^=0AIn=20=
file=20included=20from=20urcu.c:605:0:=0Aurcu-defer-impl.h:=20In=20=
function=20=E2=80=98rcu_defer_register_thread_sig=E2=80=99:=0A=
urcu-defer-impl.h:432:26:=20warning:=20assignment=20makes=20pointer=20=
from=20integer=20without=20a=20cast=20[-Wint-conversion]=0A=20=20=
URCU_TLS(defer_queue).q=20=3D=20malloc(sizeof(void=20*)=20*=20=
DEFER_QUEUE_SIZE);=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20^=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-DRCU_SIGNAL=20-g=20-O2=20-pthread=20-MT=20liburcu_signal_la-urcu.lo=20=
-MD=20-MP=20-MF=20.deps/liburcu_signal_la-urcu.Tpo=20-c=20urcu.c=20-o=20=
liburcu_signal_la-urcu.o=20>/dev/null=202>&1=0Amv=20-f=20=
.deps/liburcu_signal_la-urcu.Tpo=20.deps/liburcu_signal_la-urcu.Plo=0A=
/bin/bash=20./libtool=20=20--tag=3DCC=20=20=20--mode=3Dcompile=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=20-I./urcu=20=
=20-DRCU_SIGNAL=20-g=20-O2=20-pthread=20-MT=20=
liburcu_signal_la-urcu-pointer.lo=20-MD=20-MP=20-MF=20=
.deps/liburcu_signal_la-urcu-pointer.Tpo=20-c=20-o=20=
liburcu_signal_la-urcu-pointer.lo=20`test=20-f=20'urcu-pointer.c'=20||=20=
echo=20'./'`urcu-pointer.c=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-DRCU_SIGNAL=20-g=20-O2=20-pthread=20-MT=20=
liburcu_signal_la-urcu-pointer.lo=20-MD=20-MP=20-MF=20=
.deps/liburcu_signal_la-urcu-pointer.Tpo=20-c=20urcu-pointer.c=20=20=
-fPIC=20-DPIC=20-o=20.libs/liburcu_signal_la-urcu-pointer.o=0Alibtool:=20=
compile:=20=20arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=
-I./urcu=20-DRCU_SIGNAL=20-g=20-O2=20-pthread=20-MT=20=
liburcu_signal_la-urcu-pointer.lo=20-MD=20-MP=20-MF=20=
.deps/liburcu_signal_la-urcu-pointer.Tpo=20-c=20urcu-pointer.c=20-o=20=
liburcu_signal_la-urcu-pointer.o=20>/dev/null=202>&1=0Amv=20-f=20=
.deps/liburcu_signal_la-urcu-pointer.Tpo=20=
.deps/liburcu_signal_la-urcu-pointer.Plo=0A/bin/bash=20./libtool=20=20=
--tag=3DCC=20=20=20--mode=3Dcompile=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=20-I./urcu=20=20-DRCU_SIGNAL=20-g=20=
-O2=20-pthread=20-MT=20liburcu_signal_la-compat_futex.lo=20-MD=20-MP=20=
-MF=20.deps/liburcu_signal_la-compat_futex.Tpo=20-c=20-o=20=
liburcu_signal_la-compat_futex.lo=20`test=20-f=20'compat_futex.c'=20||=20=
echo=20'./'`compat_futex.c=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-DRCU_SIGNAL=20-g=20-O2=20-pthread=20-MT=20=
liburcu_signal_la-compat_futex.lo=20-MD=20-MP=20-MF=20=
.deps/liburcu_signal_la-compat_futex.Tpo=20-c=20compat_futex.c=20=20=
-fPIC=20-DPIC=20-o=20.libs/liburcu_signal_la-compat_futex.o=0Alibtool:=20=
compile:=20=20arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=
-I./urcu=20-DRCU_SIGNAL=20-g=20-O2=20-pthread=20-MT=20=
liburcu_signal_la-compat_futex.lo=20-MD=20-MP=20-MF=20=
.deps/liburcu_signal_la-compat_futex.Tpo=20-c=20compat_futex.c=20-o=20=
liburcu_signal_la-compat_futex.o=20>/dev/null=202>&1=0Amv=20-f=20=
.deps/liburcu_signal_la-compat_futex.Tpo=20=
.deps/liburcu_signal_la-compat_futex.Plo=0A/bin/bash=20./libtool=20=20=
--tag=3DCC=20=20=20--mode=3Dlink=20arm-linux-gnueabihf-gcc=20=
-DRCU_SIGNAL=20-g=20-O2=20-pthread=20-version-info=204:0:0=20-lpthread=20=
=20=20-o=20liburcu-signal.la=20-rpath=20/usr/local/lib=20=
liburcu_signal_la-urcu.lo=20liburcu_signal_la-urcu-pointer.lo=20=
liburcu_signal_la-compat_futex.lo=20liburcu-common.la=20=0Alibtool:=20=
link:=20arm-linux-gnueabihf-gcc=20-shared=20=20-fPIC=20-DPIC=20=20=
.libs/liburcu_signal_la-urcu.o=20.libs/liburcu_signal_la-urcu-pointer.o=20=
.libs/liburcu_signal_la-compat_futex.o=20=20=20-Wl,-rpath=20=
-Wl,/u/ldalessa/userspace-rcu/.libs=20./.libs/liburcu-common.so=20=
-lpthread=20=20-g=20-O2=20-pthread=20=20=20-pthread=20-Wl,-soname=20=
-Wl,liburcu-signal.so.4=20-o=20.libs/liburcu-signal.so.4.0.0=0Alibtool:=20=
link:=20(cd=20".libs"=20&&=20rm=20-f=20"liburcu-signal.so.4"=20&&=20ln=20=
-s=20"liburcu-signal.so.4.0.0"=20"liburcu-signal.so.4")=0Alibtool:=20=
link:=20(cd=20".libs"=20&&=20rm=20-f=20"liburcu-signal.so"=20&&=20ln=20=
-s=20"liburcu-signal.so.4.0.0"=20"liburcu-signal.so")=0Alibtool:=20link:=20=
arm-linux-gnueabihf-ar=20cru=20.libs/liburcu-signal.a=20=20=
liburcu_signal_la-urcu.o=20liburcu_signal_la-urcu-pointer.o=20=
liburcu_signal_la-compat_futex.o=0Aarm-linux-gnueabihf-ar:=20`u'=20=
modifier=20ignored=20since=20`D'=20is=20the=20default=20(see=20`U')=0A=
libtool:=20link:=20arm-linux-gnueabihf-ranlib=20.libs/liburcu-signal.a=0A=
libtool:=20link:=20(=20cd=20".libs"=20&&=20rm=20-f=20"liburcu-signal.la"=20=
&&=20ln=20-s=20"../liburcu-signal.la"=20"liburcu-signal.la"=20)=0A=
/bin/bash=20./libtool=20=20--tag=3DCC=20=20=20--mode=3Dcompile=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=20-I./urcu=20=
=20-Wall=20-g=20-O2=20-pthread=20-MT=20urcu-bp.lo=20-MD=20-MP=20-MF=20=
.deps/urcu-bp.Tpo=20-c=20-o=20urcu-bp.lo=20urcu-bp.c=0Alibtool:=20=
compile:=20=20arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=
-I./urcu=20-Wall=20-g=20-O2=20-pthread=20-MT=20urcu-bp.lo=20-MD=20-MP=20=
-MF=20.deps/urcu-bp.Tpo=20-c=20urcu-bp.c=20=20-fPIC=20-DPIC=20-o=20=
.libs/urcu-bp.o=0AIn=20file=20included=20from=20compat-getcpu.h:24:0,=0A=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20from=20=
urcu-call-rcu-impl.h:39,=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20from=20urcu-bp.c:717:=0Aurcu-call-rcu-impl.h:=20In=20function=20=
=E2=80=98alloc_cpu_call_rcu_data=E2=80=99:=0A./config.h:249:16:=20=
warning:=20implicit=20declaration=20of=20function=20=E2=80=98rpl_malloc=E2=
=80=99=20[-Wimplicit-function-declaration]=0A=20#define=20malloc=20=
rpl_malloc=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20^=0A=
urcu-call-rcu-impl.h:141:6:=20note:=20in=20expansion=20of=20macro=20=
=E2=80=98malloc=E2=80=99=0A=20=20p=20=3D=20malloc(maxcpus=20*=20=
sizeof(*per_cpu_call_rcu_data));=0A=20=20=20=20=20=20^=0AIn=20file=20=
included=20from=20urcu-bp.c:717:0:=0Aurcu-call-rcu-impl.h:141:4:=20=
warning:=20assignment=20makes=20pointer=20from=20integer=20without=20a=20=
cast=20[-Wint-conversion]=0A=20=20p=20=3D=20malloc(maxcpus=20*=20=
sizeof(*per_cpu_call_rcu_data));=0A=20=20=20=20^=0Aurcu-call-rcu-impl.h:=20=
In=20function=20=E2=80=98call_rcu_data_init=E2=80=99:=0A=
urcu-call-rcu-impl.h:422:7:=20warning:=20assignment=20makes=20pointer=20=
from=20integer=20without=20a=20cast=20[-Wint-conversion]=0A=20=20crdp=20=
=3D=20malloc(sizeof(*crdp));=0A=20=20=20=20=20=20=20^=0A=
urcu-call-rcu-impl.h:=20In=20function=20=
=E2=80=98free_all_cpu_call_rcu_data_bp=E2=80=99:=0A=
urcu-call-rcu-impl.h:784:7:=20warning:=20assignment=20makes=20pointer=20=
from=20integer=20without=20a=20cast=20[-Wint-conversion]=0A=20=20crdp=20=
=3D=20malloc(sizeof(*crdp)=20*=20maxcpus);=0A=20=20=20=20=20=20=20^=0AIn=20=
file=20included=20from=20urcu-bp.c:718:0:=0Aurcu-defer-impl.h:=20In=20=
function=20=E2=80=98rcu_defer_register_thread_bp=E2=80=99:=0A=
urcu-defer-impl.h:432:26:=20warning:=20assignment=20makes=20pointer=20=
from=20integer=20without=20a=20cast=20[-Wint-conversion]=0A=20=20=
URCU_TLS(defer_queue).q=20=3D=20malloc(sizeof(void=20*)=20*=20=
DEFER_QUEUE_SIZE);=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20^=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-Wall=20-g=20-O2=20-pthread=20-MT=20urcu-bp.lo=20-MD=20-MP=20-MF=20=
.deps/urcu-bp.Tpo=20-c=20urcu-bp.c=20-o=20urcu-bp.o=20>/dev/null=202>&1=0A=
mv=20-f=20.deps/urcu-bp.Tpo=20.deps/urcu-bp.Plo=0A/bin/bash=20./libtool=20=
=20--tag=3DCC=20=20=20--mode=3Dlink=20arm-linux-gnueabihf-gcc=20-Wall=20=
-g=20-O2=20-pthread=20-version-info=204:0:0=20-lpthread=20=20=20-o=20=
liburcu-bp.la=20-rpath=20/usr/local/lib=20urcu-bp.lo=20urcu-pointer.lo=20=
compat_futex.lo=20liburcu-common.la=20=0Alibtool:=20link:=20=
arm-linux-gnueabihf-gcc=20-shared=20=20-fPIC=20-DPIC=20=20=
.libs/urcu-bp.o=20.libs/urcu-pointer.o=20.libs/compat_futex.o=20=20=20=
-Wl,-rpath=20-Wl,/u/ldalessa/userspace-rcu/.libs=20=
./.libs/liburcu-common.so=20-lpthread=20=20-g=20-O2=20-pthread=20=20=20=
-pthread=20-Wl,-soname=20-Wl,liburcu-bp.so.4=20-o=20=
.libs/liburcu-bp.so.4.0.0=0Alibtool:=20link:=20(cd=20".libs"=20&&=20rm=20=
-f=20"liburcu-bp.so.4"=20&&=20ln=20-s=20"liburcu-bp.so.4.0.0"=20=
"liburcu-bp.so.4")=0Alibtool:=20link:=20(cd=20".libs"=20&&=20rm=20-f=20=
"liburcu-bp.so"=20&&=20ln=20-s=20"liburcu-bp.so.4.0.0"=20=
"liburcu-bp.so")=0Alibtool:=20link:=20arm-linux-gnueabihf-ar=20cru=20=
.libs/liburcu-bp.a=20=20urcu-bp.o=20urcu-pointer.o=20compat_futex.o=0A=
arm-linux-gnueabihf-ar:=20`u'=20modifier=20ignored=20since=20`D'=20is=20=
the=20default=20(see=20`U')=0Alibtool:=20link:=20=
arm-linux-gnueabihf-ranlib=20.libs/liburcu-bp.a=0Alibtool:=20link:=20(=20=
cd=20".libs"=20&&=20rm=20-f=20"liburcu-bp.la"=20&&=20ln=20-s=20=
"../liburcu-bp.la"=20"liburcu-bp.la"=20)=0A/bin/bash=20./libtool=20=20=
--tag=3DCC=20=20=20--mode=3Dcompile=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=20-I./urcu=20=20-Wall=20-g=20-O2=20=
-pthread=20-MT=20rculfqueue.lo=20-MD=20-MP=20-MF=20.deps/rculfqueue.Tpo=20=
-c=20-o=20rculfqueue.lo=20rculfqueue.c=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-Wall=20-g=20-O2=20-pthread=20-MT=20rculfqueue.lo=20-MD=20-MP=20-MF=20=
.deps/rculfqueue.Tpo=20-c=20rculfqueue.c=20=20-fPIC=20-DPIC=20-o=20=
.libs/rculfqueue.o=0Alibtool:=20compile:=20=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20-Wall=20-g=20-O2=20=
-pthread=20-MT=20rculfqueue.lo=20-MD=20-MP=20-MF=20.deps/rculfqueue.Tpo=20=
-c=20rculfqueue.c=20-o=20rculfqueue.o=20>/dev/null=202>&1=0Amv=20-f=20=
.deps/rculfqueue.Tpo=20.deps/rculfqueue.Plo=0A/bin/bash=20./libtool=20=20=
--tag=3DCC=20=20=20--mode=3Dcompile=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=20-I./urcu=20=20-Wall=20-g=20-O2=20=
-pthread=20-MT=20rculfstack.lo=20-MD=20-MP=20-MF=20.deps/rculfstack.Tpo=20=
-c=20-o=20rculfstack.lo=20rculfstack.c=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-Wall=20-g=20-O2=20-pthread=20-MT=20rculfstack.lo=20-MD=20-MP=20-MF=20=
.deps/rculfstack.Tpo=20-c=20rculfstack.c=20=20-fPIC=20-DPIC=20-o=20=
.libs/rculfstack.o=0Alibtool:=20compile:=20=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20-Wall=20-g=20-O2=20=
-pthread=20-MT=20rculfstack.lo=20-MD=20-MP=20-MF=20.deps/rculfstack.Tpo=20=
-c=20rculfstack.c=20-o=20rculfstack.o=20>/dev/null=202>&1=0Amv=20-f=20=
.deps/rculfstack.Tpo=20.deps/rculfstack.Plo=0A/bin/bash=20./libtool=20=20=
--tag=3DCC=20=20=20--mode=3Dcompile=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=20-I./urcu=20=20-Wall=20-g=20-O2=20=
-pthread=20-MT=20lfstack.lo=20-MD=20-MP=20-MF=20.deps/lfstack.Tpo=20-c=20=
-o=20lfstack.lo=20lfstack.c=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-Wall=20-g=20-O2=20-pthread=20-MT=20lfstack.lo=20-MD=20-MP=20-MF=20=
.deps/lfstack.Tpo=20-c=20lfstack.c=20=20-fPIC=20-DPIC=20-o=20=
.libs/lfstack.o=0Alibtool:=20compile:=20=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20-Wall=20-g=20-O2=20=
-pthread=20-MT=20lfstack.lo=20-MD=20-MP=20-MF=20.deps/lfstack.Tpo=20-c=20=
lfstack.c=20-o=20lfstack.o=20>/dev/null=202>&1=0Amv=20-f=20=
.deps/lfstack.Tpo=20.deps/lfstack.Plo=0A/bin/bash=20./libtool=20=20=
--tag=3DCC=20=20=20--mode=3Dcompile=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=20-I./urcu=20=20-Wall=20-g=20-O2=20=
-pthread=20-MT=20rculfhash.lo=20-MD=20-MP=20-MF=20.deps/rculfhash.Tpo=20=
-c=20-o=20rculfhash.lo=20rculfhash.c=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-Wall=20-g=20-O2=20-pthread=20-MT=20rculfhash.lo=20-MD=20-MP=20-MF=20=
.deps/rculfhash.Tpo=20-c=20rculfhash.c=20=20-fPIC=20-DPIC=20-o=20=
.libs/rculfhash.o=0AIn=20file=20included=20from=20compat-getcpu.h:24:0,=0A=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20from=20=
rculfhash.c:270:=0Arculfhash.c:=20In=20function=20=
=E2=80=98__cds_lfht_resize_lazy_launch=E2=80=99:=0A./config.h:249:16:=20=
warning:=20implicit=20declaration=20of=20function=20=E2=80=98rpl_malloc=E2=
=80=99=20[-Wimplicit-function-declaration]=0A=20#define=20malloc=20=
rpl_malloc=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20^=0A=
rculfhash.c:1989:10:=20note:=20in=20expansion=20of=20macro=20=
=E2=80=98malloc=E2=80=99=0A=20=20=20work=20=3D=20malloc(sizeof(*work));=0A=
=20=20=20=20=20=20=20=20=20=20^=0Arculfhash.c:1989:8:=20warning:=20=
assignment=20makes=20pointer=20from=20integer=20without=20a=20cast=20=
[-Wint-conversion]=0A=20=20=20work=20=3D=20malloc(sizeof(*work));=0A=20=20=
=20=20=20=20=20=20^=0Alibtool:=20compile:=20=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20-Wall=20-g=20-O2=20=
-pthread=20-MT=20rculfhash.lo=20-MD=20-MP=20-MF=20.deps/rculfhash.Tpo=20=
-c=20rculfhash.c=20-o=20rculfhash.o=20>/dev/null=202>&1=0Amv=20-f=20=
.deps/rculfhash.Tpo=20.deps/rculfhash.Plo=0A/bin/bash=20./libtool=20=20=
--tag=3DCC=20=20=20--mode=3Dcompile=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=20-I./urcu=20=20-Wall=20-g=20-O2=20=
-pthread=20-MT=20rculfhash-mm-order.lo=20-MD=20-MP=20-MF=20=
.deps/rculfhash-mm-order.Tpo=20-c=20-o=20rculfhash-mm-order.lo=20=
rculfhash-mm-order.c=0Alibtool:=20compile:=20=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20-Wall=20-g=20-O2=20=
-pthread=20-MT=20rculfhash-mm-order.lo=20-MD=20-MP=20-MF=20=
.deps/rculfhash-mm-order.Tpo=20-c=20rculfhash-mm-order.c=20=20-fPIC=20=
-DPIC=20-o=20.libs/rculfhash-mm-order.o=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-Wall=20-g=20-O2=20-pthread=20-MT=20rculfhash-mm-order.lo=20-MD=20-MP=20=
-MF=20.deps/rculfhash-mm-order.Tpo=20-c=20rculfhash-mm-order.c=20-o=20=
rculfhash-mm-order.o=20>/dev/null=202>&1=0Amv=20-f=20=
.deps/rculfhash-mm-order.Tpo=20.deps/rculfhash-mm-order.Plo=0A/bin/bash=20=
./libtool=20=20--tag=3DCC=20=20=20--mode=3Dcompile=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=20-I./urcu=20=
=20-Wall=20-g=20-O2=20-pthread=20-MT=20rculfhash-mm-chunk.lo=20-MD=20-MP=20=
-MF=20.deps/rculfhash-mm-chunk.Tpo=20-c=20-o=20rculfhash-mm-chunk.lo=20=
rculfhash-mm-chunk.c=0Alibtool:=20compile:=20=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20-Wall=20-g=20-O2=20=
-pthread=20-MT=20rculfhash-mm-chunk.lo=20-MD=20-MP=20-MF=20=
.deps/rculfhash-mm-chunk.Tpo=20-c=20rculfhash-mm-chunk.c=20=20-fPIC=20=
-DPIC=20-o=20.libs/rculfhash-mm-chunk.o=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-Wall=20-g=20-O2=20-pthread=20-MT=20rculfhash-mm-chunk.lo=20-MD=20-MP=20=
-MF=20.deps/rculfhash-mm-chunk.Tpo=20-c=20rculfhash-mm-chunk.c=20-o=20=
rculfhash-mm-chunk.o=20>/dev/null=202>&1=0Amv=20-f=20=
.deps/rculfhash-mm-chunk.Tpo=20.deps/rculfhash-mm-chunk.Plo=0A/bin/bash=20=
./libtool=20=20--tag=3DCC=20=20=20--mode=3Dcompile=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20=20-I./urcu=20=
=20-Wall=20-g=20-O2=20-pthread=20-MT=20rculfhash-mm-mmap.lo=20-MD=20-MP=20=
-MF=20.deps/rculfhash-mm-mmap.Tpo=20-c=20-o=20rculfhash-mm-mmap.lo=20=
rculfhash-mm-mmap.c=0Alibtool:=20compile:=20=20arm-linux-gnueabihf-gcc=20=
-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20-Wall=20-g=20-O2=20=
-pthread=20-MT=20rculfhash-mm-mmap.lo=20-MD=20-MP=20-MF=20=
.deps/rculfhash-mm-mmap.Tpo=20-c=20rculfhash-mm-mmap.c=20=20-fPIC=20=
-DPIC=20-o=20.libs/rculfhash-mm-mmap.o=0Alibtool:=20compile:=20=20=
arm-linux-gnueabihf-gcc=20-DHAVE_CONFIG_H=20-I.=20-I./urcu=20-I./urcu=20=
-Wall=20-g=20-O2=20-pthread=20-MT=20rculfhash-mm-mmap.lo=20-MD=20-MP=20=
-MF=20.deps/rculfhash-mm-mmap.Tpo=20-c=20rculfhash-mm-mmap.c=20-o=20=
rculfhash-mm-mmap.o=20>/dev/null=202>&1=0Amv=20-f=20=
.deps/rculfhash-mm-mmap.Tpo=20.deps/rculfhash-mm-mmap.Plo=0A/bin/bash=20=
./libtool=20=20--tag=3DCC=20=20=20--mode=3Dlink=20=
arm-linux-gnueabihf-gcc=20-Wall=20-g=20-O2=20-pthread=20-version-info=20=
4:0:0=20-lpthread=20=20=20-o=20liburcu-cds.la=20-rpath=20/usr/local/lib=20=
rculfqueue.lo=20rculfstack.lo=20lfstack.lo=20rculfhash.lo=20=
rculfhash-mm-order.lo=20rculfhash-mm-chunk.lo=20rculfhash-mm-mmap.lo=20=
compat_futex.lo=20liburcu-common.la=20=0Alibtool:=20link:=20=
arm-linux-gnueabihf-gcc=20-shared=20=20-fPIC=20-DPIC=20=20=
.libs/rculfqueue.o=20.libs/rculfstack.o=20.libs/lfstack.o=20=
.libs/rculfhash.o=20.libs/rculfhash-mm-order.o=20=
.libs/rculfhash-mm-chunk.o=20.libs/rculfhash-mm-mmap.o=20=
.libs/compat_futex.o=20=20=20-Wl,-rpath=20=
-Wl,/u/ldalessa/userspace-rcu/.libs=20./.libs/liburcu-common.so=20=
-lpthread=20=20-g=20-O2=20-pthread=20=20=20-pthread=20-Wl,-soname=20=
-Wl,liburcu-cds.so.4=20-o=20.libs/liburcu-cds.so.4.0.0=0Alibtool:=20=
link:=20(cd=20".libs"=20&&=20rm=20-f=20"liburcu-cds.so.4"=20&&=20ln=20-s=20=
"liburcu-cds.so.4.0.0"=20"liburcu-cds.so.4")=0Alibtool:=20link:=20(cd=20=
".libs"=20&&=20rm=20-f=20"liburcu-cds.so"=20&&=20ln=20-s=20=
"liburcu-cds.so.4.0.0"=20"liburcu-cds.so")=0Alibtool:=20link:=20=
arm-linux-gnueabihf-ar=20cru=20.libs/liburcu-cds.a=20=20rculfqueue.o=20=
rculfstack.o=20lfstack.o=20rculfhash.o=20rculfhash-mm-order.o=20=
rculfhash-mm-chunk.o=20rculfhash-mm-mmap.o=20compat_futex.o=0A=
arm-linux-gnueabihf-ar:=20`u'=20modifier=20ignored=20since=20`D'=20is=20=
the=20default=20(see=20`U')=0Alibtool:=20link:=20=
arm-linux-gnueabihf-ranlib=20.libs/liburcu-cds.a=0Alibtool:=20link:=20(=20=
cd=20".libs"=20&&=20rm=20-f=20"liburcu-cds.la"=20&&=20ln=20-s=20=
"../liburcu-cds.la"=20"liburcu-cds.la"=20)=0Amake[2]:=20Leaving=20=
directory=20'/home/ldalessa/userspace-rcu'=0AMaking=20all=20in=20doc=0A=
make[2]:=20Entering=20directory=20'/home/ldalessa/userspace-rcu/doc'=0A=
Making=20all=20in=20examples=0Amake[3]:=20Entering=20directory=20=
'/home/ldalessa/userspace-rcu/doc/examples'=0AExamples:=20relative=20=
top_srcdir=20path=20../..=0AExamples:=20relative=20top_builddir=20path=20=
../..=0Amake[4]:=20Entering=20directory=20=
'/home/ldalessa/userspace-rcu/doc/examples'=0Amake=20-C=20hlist=0A=
make[5]:=20Entering=20directory=20=
'/home/ldalessa/userspace-rcu/doc/examples/hlist'=0Amake=20-f=20=
Makefile.cds_hlist_add_head_rcu=0Amake[6]:=20Entering=20directory=20=
'/home/ldalessa/userspace-rcu/doc/examples/hlist'=0A=
arm-linux-gnueabihf-gcc=20=20-g=20-O2=20-Wall=20-I..//../../=20=
-I../../../=20-g=20-O2=20-pthread=20\=0A=09-c=20-o=20=
cds_hlist_add_head_rcu.o=20cds_hlist_add_head_rcu.c=0A=
arm-linux-gnueabihf-gcc=20-g=20-O2=20-Wall=20=20-g=20-O2=20-pthread=20=
-L../../../.libs/=20-Wl,-rpath=20=
"/u/ldalessa/userspace-rcu/doc/examples/../../.libs/"=20\=0A=09-o=20=
cds_hlist_add_head_rcu=20cds_hlist_add_head_rcu.o=20-lurcu=0A=
../../../.libs//liburcu.so:=20undefined=20reference=20to=20`rpl_malloc'=0A=
collect2:=20error:=20ld=20returned=201=20exit=20status=0A=
../Makefile.examples.template:22:=20recipe=20for=20target=20=
'cds_hlist_add_head_rcu'=20failed=0Amake[6]:=20***=20=
[cds_hlist_add_head_rcu]=20Error=201=0Amake[6]:=20Leaving=20directory=20=
'/home/ldalessa/userspace-rcu/doc/examples/hlist'=0AMakefile:15:=20=
recipe=20for=20target=20'all'=20failed=0Amake[5]:=20***=20[all]=20Error=20=
2=0Amake[5]:=20Leaving=20directory=20=
'/home/ldalessa/userspace-rcu/doc/examples/hlist'=0A=
dist-files/Makefile:15:=20recipe=20for=20target=20'all'=20failed=0A=
make[4]:=20***=20[all]=20Error=202=0Amake[4]:=20Leaving=20directory=20=
'/home/ldalessa/userspace-rcu/doc/examples'=0AMakefile:839:=20recipe=20=
for=20target=20'all-local'=20failed=0Amake[3]:=20***=20[all-local]=20=
Error=202=0Amake[3]:=20Leaving=20directory=20=
'/home/ldalessa/userspace-rcu/doc/examples'=0AMakefile:415:=20recipe=20=
for=20target=20'all-recursive'=20failed=0Amake[2]:=20***=20=
[all-recursive]=20Error=201=0Amake[2]:=20Leaving=20directory=20=
'/home/ldalessa/userspace-rcu/doc'=0AMakefile:921:=20recipe=20for=20=
target=20'all-recursive'=20failed=0Amake[1]:=20***=20[all-recursive]=20=
Error=201=0Amake[1]:=20Leaving=20directory=20=
'/home/ldalessa/userspace-rcu'=0AMakefile:557:=20recipe=20for=20target=20=
'all'=20failed=0Amake:=20***=20[all]=20Error=202=0A=

--Apple-Mail=_7D76401C-2EC4-42BD-98EA-6EB9D5D93E99
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D""><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">Thanks,</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">Mathieu</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br class=3D"">Thanks,<br =
class=3D"">Luke<br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D""><br class=3D"">Thanks,<br class=3D""><br class=3D"">Mathieu<br =
class=3D""><br class=3D""><blockquote type=3D"cite" class=3D""><br =
class=3D"">Thanks,<br class=3D"">Luke<br class=3D""><br =
class=3D"">_______________________________________________<br =
class=3D"">lttng-dev mailing list<br class=3D""><a =
href=3D"mailto:lttng-dev@lists.lttng.org" =
class=3D"">lttng-dev@lists.lttng.org</a><br =
class=3D"">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br =
class=3D""></blockquote><br class=3D"">--<br class=3D"">Mathieu =
Desnoyers<br class=3D"">EfficiOS Inc.<br class=3D""><a =
href=3D"http://www.efficios.com" class=3D"">http://www.efficios.com</a><br=
 class=3D""></blockquote></blockquote><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">--<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">Mathieu =
Desnoyers</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">EfficiOS Inc.</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><a href=3D"http://www.efficios.com/" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" =
class=3D"">http://www.efficios.com</a></div></blockquote></div><br =
class=3D""></body></html>=

--Apple-Mail=_7D76401C-2EC4-42BD-98EA-6EB9D5D93E99--

--Apple-Mail=_510706B2-DE34-431C-92E4-BDBD4568DEBC--

--Apple-Mail=_035C7101-4A11-4F83-B605-2F188B4C9553
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJXYD1VAAoJEJ9t5ApCTtG0fPkQAKu5XADcJBXQIAj9U4osW8Dr
ipQYFR4C0atN0hA1QpFwQ5pQTL70i4+ON2qBNsL4cbGUwJXUXoGx0ofkVU8UItJ+
2AKEt5/YMURi6+eL3qpMdNVLCEoy6guhbQUP/MbLIukEjWO8CgkkvfoqE34Ffj7E
swM4vMzBMvabKLGL2oYfePAldqVuiTI9YoUwi9ANi6KBEfUarBJyEdEILYROIVe1
PEHuGVNZkk2xzAGOLylUkObIH2YY3BCvk5ifyHkLv64OUCa2qPkvJkoTxywfv9iD
dKDmhLIou1xx3zfozJ+kG6oacedJXI4BbdnGOdFXRAx3ZAC64Lc0EtQof4SxpcTO
CcaSV7aQxm1zqHl6qPR69PUXI4joxBNcVyZjqE3QHN9JBDWEoG2wP0Vj7waV9Bmx
tGsZelt3EnbIoH3Iyj6a9ZPKGVpISkuQ2g3E2niL++1QwYLTGD6g/CCAsTJylGeD
PLUV8O4zR+Enq01zTBxzrU8xiPZRUjy0w/B8odTeRaeA/g63XODbj4/OgemYIao1
2L7oa86x4LKscaMjvmQj0cOs1fG6y2naKBvzK+zSi7J402CEZZI1ewExBG492Vh6
cBNQUoJm9D6lbk6uLTwXLAHfI0GzDaEyelFNbTiTx1g7tZa6RNdS0z+q85gp06sj
8F3jMJetqSkquVpbcl85
=q41G
-----END PGP SIGNATURE-----

--Apple-Mail=_035C7101-4A11-4F83-B605-2F188B4C9553--

--===============8545337407949641988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8545337407949641988==--
