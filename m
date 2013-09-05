From: Graham Perkins <GrahamPerkins@vocality.com>
Subject: Problem cross compiling Lttng tools
Date: Thu, 5 Sep 2013 15:09:04 +0000
Message-ID: <B9D011282E8E564BB9246623020985C034AF2FFE__13535.3005062372$1378434788$gmane$org@mbx500-u1-lo-3.exch500.msoutlookonline.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1150929339=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from hub500-lo-1.exch500.serverdata.net ([205.217.20.183])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <GrahamPerkins@vocality.com>) id 1VHbBU-00050q-P3
	for lttng-dev@lists.lttng.org; Thu, 05 Sep 2013 11:09:31 -0400
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

--===============1150929339==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_B9D011282E8E564BB9246623020985C034AF2FFEmbx500u1lo3exch_"

--_000_B9D011282E8E564BB9246623020985C034AF2FFEmbx500u1lo3exch_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
I am attempting to cross compile Lttng tools for my arm target. The build f=
ails with these errors:

Making all in lttng-consumerd
make[3]: Entering directory `/home/software/LTTng/lttng-tools-2.3.0/src/bin=
/lttng-consumerd'
  CC       lttng-consumerd.o
  CCLD     lttng-consumerd
/home/software/arago-project/linux-davinci/lib/liburcu-bp.a(urcu-bp.o): In =
function `update_counter_and_wait':
urcu-bp.c:(.text+0x5ec): multiple definition of `update_counter_and_wait'
/home/software/arago-project/linux-davinci/lib/liburcu.a(urcu.o):urcu.c:(.t=
ext+0x6f4): first defined here
/home/software/arago-project/linux-davinci/lib/liburcu-bp.a(urcu-bp.o):(.da=
ta+0xc): multiple definition of `call_rcu_data_list'
/home/software/arago-project/linux-davinci/lib/liburcu.a(urcu.o):(.data+0xc=
): first defined here
/home/software/arago-project/linux-davinci/lib/liburcu-bp.a(urcu-bp.o): In =
function `call_rcu_data_free':
urcu-bp.c:(.text+0x1fc8): multiple definition of `call_rcu_data_free'
/home/software/arago-project/linux-davinci/lib/liburcu.a(urcu.o):urcu.c:(.t=
ext+0x1a44): first defined here
/home/software/arago-project/linux-davinci/lib/liburcu-bp.a(urcu-bp.o): In =
function `call_rcu_before_fork':
urcu-bp.c:(.text+0x2340): multiple definition of `call_rcu_before_fork'
/home/software/arago-project/linux-davinci/lib/liburcu.a(urcu.o):urcu.c:(.t=
ext+0x1dbc): first defined here
/home/software/arago-project/linux-davinci/lib/liburcu-bp.a(urcu-bp.o): In =
function `call_rcu_after_fork_parent':
urcu-bp.c:(.text+0x2444): multiple definition of `call_rcu_after_fork_paren=
t'
/home/software/arago-project/linux-davinci/lib/liburcu.a(urcu.o):urcu.c:(.t=
ext+0x1ec0): first defined here
/home/software/arago-project/linux-davinci/lib/liburcu-bp.a(urcu-bp.o): In =
function `call_rcu_after_fork_child':
urcu-bp.c:(.text+0x24dc): multiple definition of `call_rcu_after_fork_child=
'
/home/software/arago-project/linux-davinci/lib/liburcu.a(urcu.o):urcu.c:(.t=
ext+0x1f58): first defined here
/home/software/arago-project/linux-davinci/lib/liburcu-bp.a(urcu-bp.o): In =
function `_defer_rcu':
urcu-bp.c:(.text+0x2bc8): multiple definition of `_defer_rcu'
/home/software/arago-project/linux-davinci/lib/liburcu.a(urcu.o):urcu.c:(.t=
ext+0x2644): first defined here
/home/software/arago-project/linux-davinci/lib/liburcu-bp.a(urcu-bp.o): In =
function `thr_defer':
urcu-bp.c:(.text+0x2ec4): multiple definition of `thr_defer'
/home/software/arago-project/linux-davinci/lib/liburcu.a(urcu.o):urcu.c:(.t=
ext+0x2940): first defined here
/home/software/arago-project/linux-davinci/lib/liburcu-bp.a(urcu-bp.o): In =
function `rcu_defer_exit':
urcu-bp.c:(.text+0x3260): multiple definition of `rcu_defer_exit'
/home/software/arago-project/linux-davinci/lib/liburcu.a(urcu.o):urcu.c:(.t=
ext+0x2cdc): first defined here
collect2: ld returned 1 exit status
make[3]: *** [lttng-consumerd] Error 1
make[3]: Leaving directory `/home/software/LTTng/lttng-tools-2.3.0/src/bin/=
lttng-consumerd'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/software/LTTng/lttng-tools-2.3.0/src/bin'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/software/LTTng/lttng-tools-2.3.0/src'
make: *** [all-recursive] Error 1

My configuration script is:

export HOST=3D"arm-none-linux-gnueabi"

# Make sure your cross-compiler can be found in your $PATH
export SYSROOT=3D"/home/software/arago-project/linux-davinci"

export CC=3D"arm-linux-gnueabi-gcc"
export CXX=3D"arm-linux-gnueabi-g++"
export LD=3D"arm-linux-gnueabi-gcc"
export CFLAGS=3D"--sysroot=3D$SYSROOT -march=3Darmv5 -marm -mlittle-endian"
export CPPFLAGS=3D"-I$SYSROOT/include"
export CXXFLAGS=3D$CFLAGS
export LDFLAGS=3D"--sysroot=3D$SYSROOT -L$SYSROOT/usr/lib -L$SYSROOT/lib"

# Fix RPL_MALLOC issue. See [Autoconf and RPL_MALLOC][3] for more details.
export ac_cv_func_malloc_0_nonnull=3Dyes

# Cross compile userspace-rcu. You can also use a source tarball.
cd userspace-rcu-0.7.7
./configure --prefix=3D$SYSROOT --host=3D$HOST --disable-static
make clean
make
make install
cd ..

# Cross compile lttng-ust. You can also use a source tarball.
cd lttng-ust-2.3.0
./configure --prefix=3D$SYSROOT --host=3D$HOST --disable-static
make clean
make
make install
cd ..

# Cross compile lttng-tools. You can also use a source tarball.
cd lttng-tools-2.3.0
./configure --prefix=3D$SYSROOT --host=3D$HOST --disable-static
make clean
make
#make install
cd ..

Both liburcu.a and liburcu-bp.a are being included by the linker. Am I corr=
ect in assuming only one of these should be included and how do I fix this?

Many thanks,
Graham Perkins.




--_000_B9D011282E8E564BB9246623020985C034AF2FFEmbx500u1lo3exch_
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
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
<body lang=3D"EN-GB" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal">I am attempting to cross compile Lttng tools for my =
arm target. The build fails with these errors:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Making all in lttng-consumerd<o:p></o:p></p>
<p class=3D"MsoNormal">make[3]: Entering directory `/home/software/LTTng/lt=
tng-tools-2.3.0/src/bin/lttng-consumerd'<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lttng-=
consumerd.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CCLD&nbsp;&nbsp;&nbsp;&nbsp; lttng-consumerd<=
o:p></o:p></p>
<p class=3D"MsoNormal">/home/software/arago-project/linux-davinci/lib/libur=
cu-bp.a(urcu-bp.o): In function `update_counter_and_wait':<o:p></o:p></p>
<p class=3D"MsoNormal">urcu-bp.c:(.text&#43;0x5ec): multiple definition of =
`update_counter_and_wait'<o:p></o:p></p>
<p class=3D"MsoNormal">/home/software/arago-project/linux-davinci/lib/libur=
cu.a(urcu.o):urcu.c:(.text&#43;0x6f4): first defined here<o:p></o:p></p>
<p class=3D"MsoNormal">/home/software/arago-project/linux-davinci/lib/libur=
cu-bp.a(urcu-bp.o):(.data&#43;0xc): multiple definition of `call_rcu_data_l=
ist'<o:p></o:p></p>
<p class=3D"MsoNormal">/home/software/arago-project/linux-davinci/lib/libur=
cu.a(urcu.o):(.data&#43;0xc): first defined here<o:p></o:p></p>
<p class=3D"MsoNormal">/home/software/arago-project/linux-davinci/lib/libur=
cu-bp.a(urcu-bp.o): In function `call_rcu_data_free':<o:p></o:p></p>
<p class=3D"MsoNormal">urcu-bp.c:(.text&#43;0x1fc8): multiple definition of=
 `call_rcu_data_free'<o:p></o:p></p>
<p class=3D"MsoNormal">/home/software/arago-project/linux-davinci/lib/libur=
cu.a(urcu.o):urcu.c:(.text&#43;0x1a44): first defined here<o:p></o:p></p>
<p class=3D"MsoNormal">/home/software/arago-project/linux-davinci/lib/libur=
cu-bp.a(urcu-bp.o): In function `call_rcu_before_fork':<o:p></o:p></p>
<p class=3D"MsoNormal">urcu-bp.c:(.text&#43;0x2340): multiple definition of=
 `call_rcu_before_fork'<o:p></o:p></p>
<p class=3D"MsoNormal">/home/software/arago-project/linux-davinci/lib/libur=
cu.a(urcu.o):urcu.c:(.text&#43;0x1dbc): first defined here<o:p></o:p></p>
<p class=3D"MsoNormal">/home/software/arago-project/linux-davinci/lib/libur=
cu-bp.a(urcu-bp.o): In function `call_rcu_after_fork_parent':<o:p></o:p></p=
>
<p class=3D"MsoNormal">urcu-bp.c:(.text&#43;0x2444): multiple definition of=
 `call_rcu_after_fork_parent'<o:p></o:p></p>
<p class=3D"MsoNormal">/home/software/arago-project/linux-davinci/lib/libur=
cu.a(urcu.o):urcu.c:(.text&#43;0x1ec0): first defined here<o:p></o:p></p>
<p class=3D"MsoNormal">/home/software/arago-project/linux-davinci/lib/libur=
cu-bp.a(urcu-bp.o): In function `call_rcu_after_fork_child':<o:p></o:p></p>
<p class=3D"MsoNormal">urcu-bp.c:(.text&#43;0x24dc): multiple definition of=
 `call_rcu_after_fork_child'<o:p></o:p></p>
<p class=3D"MsoNormal">/home/software/arago-project/linux-davinci/lib/libur=
cu.a(urcu.o):urcu.c:(.text&#43;0x1f58): first defined here<o:p></o:p></p>
<p class=3D"MsoNormal">/home/software/arago-project/linux-davinci/lib/libur=
cu-bp.a(urcu-bp.o): In function `_defer_rcu':<o:p></o:p></p>
<p class=3D"MsoNormal">urcu-bp.c:(.text&#43;0x2bc8): multiple definition of=
 `_defer_rcu'<o:p></o:p></p>
<p class=3D"MsoNormal">/home/software/arago-project/linux-davinci/lib/libur=
cu.a(urcu.o):urcu.c:(.text&#43;0x2644): first defined here<o:p></o:p></p>
<p class=3D"MsoNormal">/home/software/arago-project/linux-davinci/lib/libur=
cu-bp.a(urcu-bp.o): In function `thr_defer':<o:p></o:p></p>
<p class=3D"MsoNormal">urcu-bp.c:(.text&#43;0x2ec4): multiple definition of=
 `thr_defer'<o:p></o:p></p>
<p class=3D"MsoNormal">/home/software/arago-project/linux-davinci/lib/libur=
cu.a(urcu.o):urcu.c:(.text&#43;0x2940): first defined here<o:p></o:p></p>
<p class=3D"MsoNormal">/home/software/arago-project/linux-davinci/lib/libur=
cu-bp.a(urcu-bp.o): In function `rcu_defer_exit':<o:p></o:p></p>
<p class=3D"MsoNormal">urcu-bp.c:(.text&#43;0x3260): multiple definition of=
 `rcu_defer_exit'<o:p></o:p></p>
<p class=3D"MsoNormal">/home/software/arago-project/linux-davinci/lib/libur=
cu.a(urcu.o):urcu.c:(.text&#43;0x2cdc): first defined here<o:p></o:p></p>
<p class=3D"MsoNormal">collect2: ld returned 1 exit status<o:p></o:p></p>
<p class=3D"MsoNormal">make[3]: *** [lttng-consumerd] Error 1<o:p></o:p></p=
>
<p class=3D"MsoNormal">make[3]: Leaving directory `/home/software/LTTng/ltt=
ng-tools-2.3.0/src/bin/lttng-consumerd'<o:p></o:p></p>
<p class=3D"MsoNormal">make[2]: *** [all-recursive] Error 1<o:p></o:p></p>
<p class=3D"MsoNormal">make[2]: Leaving directory `/home/software/LTTng/ltt=
ng-tools-2.3.0/src/bin'<o:p></o:p></p>
<p class=3D"MsoNormal">make[1]: *** [all-recursive] Error 1<o:p></o:p></p>
<p class=3D"MsoNormal">make[1]: Leaving directory `/home/software/LTTng/ltt=
ng-tools-2.3.0/src'<o:p></o:p></p>
<p class=3D"MsoNormal">make: *** [all-recursive] Error 1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">My configuration script is:<br>
<br>
<o:p></o:p></p>
<p class=3D"MsoNormal">export HOST=3D&quot;arm-none-linux-gnueabi&quot;<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"># Make sure your cross-compiler can be found in your=
 $PATH<o:p></o:p></p>
<p class=3D"MsoNormal">export SYSROOT=3D&quot;/home/software/arago-project/=
linux-davinci&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">export CC=3D&quot;arm-linux-gnueabi-gcc&quot;<o:p></=
o:p></p>
<p class=3D"MsoNormal">export CXX=3D&quot;arm-linux-gnueabi-g&#43;&#43;&quo=
t;<o:p></o:p></p>
<p class=3D"MsoNormal">export LD=3D&quot;arm-linux-gnueabi-gcc&quot;<o:p></=
o:p></p>
<p class=3D"MsoNormal">export CFLAGS=3D&quot;--sysroot=3D$SYSROOT -march=3D=
armv5 -marm -mlittle-endian&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">export CPPFLAGS=3D&quot;-I$SYSROOT/include&quot;<o:p=
></o:p></p>
<p class=3D"MsoNormal">export CXXFLAGS=3D$CFLAGS<o:p></o:p></p>
<p class=3D"MsoNormal">export LDFLAGS=3D&quot;--sysroot=3D$SYSROOT -L$SYSRO=
OT/usr/lib -L$SYSROOT/lib&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"># Fix RPL_MALLOC issue. See [Autoconf and RPL_MALLOC=
][3] for more details.<o:p></o:p></p>
<p class=3D"MsoNormal">export ac_cv_func_malloc_0_nonnull=3Dyes<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"># Cross compile userspace-rcu. You can also use a so=
urce tarball.<o:p></o:p></p>
<p class=3D"MsoNormal">cd userspace-rcu-0.7.7<o:p></o:p></p>
<p class=3D"MsoNormal">./configure --prefix=3D$SYSROOT --host=3D$HOST --dis=
able-static<o:p></o:p></p>
<p class=3D"MsoNormal">make clean<o:p></o:p></p>
<p class=3D"MsoNormal">make<o:p></o:p></p>
<p class=3D"MsoNormal">make install<o:p></o:p></p>
<p class=3D"MsoNormal">cd ..<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"># Cross compile lttng-ust. You can also use a source=
 tarball.<o:p></o:p></p>
<p class=3D"MsoNormal">cd lttng-ust-2.3.0<o:p></o:p></p>
<p class=3D"MsoNormal">./configure --prefix=3D$SYSROOT --host=3D$HOST --dis=
able-static<o:p></o:p></p>
<p class=3D"MsoNormal">make clean<o:p></o:p></p>
<p class=3D"MsoNormal">make<o:p></o:p></p>
<p class=3D"MsoNormal">make install<o:p></o:p></p>
<p class=3D"MsoNormal">cd ..<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"># Cross compile lttng-tools. You can also use a sour=
ce tarball.<o:p></o:p></p>
<p class=3D"MsoNormal">cd lttng-tools-2.3.0<o:p></o:p></p>
<p class=3D"MsoNormal">./configure --prefix=3D$SYSROOT --host=3D$HOST --dis=
able-static<o:p></o:p></p>
<p class=3D"MsoNormal">make clean<o:p></o:p></p>
<p class=3D"MsoNormal">make<o:p></o:p></p>
<p class=3D"MsoNormal">#make install<o:p></o:p></p>
<p class=3D"MsoNormal">cd ..<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Both liburcu.a and liburcu-bp.a are being included b=
y the linker. Am I correct in assuming only one of these should be included=
 and how do I fix this?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Many thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Graham Perkins.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_B9D011282E8E564BB9246623020985C034AF2FFEmbx500u1lo3exch_--


--===============1150929339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1150929339==--
