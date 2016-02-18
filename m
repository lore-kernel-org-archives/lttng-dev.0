From: Dragos Tarcatu <tarcatu_dragosh@yahoo.com>
Subject: lttng-modules build issues
Date: Thu, 18 Feb 2016 10:09:46 +0000 (UTC)
Message-ID: <1510306317.5846570.1455790186976.JavaMail.yahoo__11203.6322629594$1455820914$gmane$org@mail.yahoo.com>
References: <1510306317.5846570.1455790186976.JavaMail.yahoo.ref@mail.yahoo.com>
Reply-To: Dragos Tarcatu <tarcatu_dragosh@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0975683297=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm35-vm2.bullet.mail.gq1.yahoo.com ([98.136.216.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <tarcatu_dragosh@yahoo.com>) id 1aWLaS-0004JO-2K
 for lttng-dev@lists.lttng.org; Thu, 18 Feb 2016 05:13:30 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0975683297==
Content-Type: multipart/alternative;
	boundary="----=_Part_5846569_1792182833.1455790186970"
Content-Length: 13217

------=_Part_5846569_1792182833.1455790186970
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,
I'm encountering these compilation errors while trying to build the lttng-m=
odules on an nvidia tegra arm64 board:

lttng-modules/2.7.1-r1/git/lttng-syscalls.c:358:3: error: implicit declarat=
ion of function '__event_probe__compat_syscall_entry_unknown' [-Werror=3Dim=
plicit-function-declaration]| =C2=A0 =C2=A0__event_probe__compat_syscall_en=
try_unknown(event, id, args);
lttng-modules/2.7.1-r1/git/lttng-syscalls.c:360:3: error: implicit declarat=
ion of function '__event_probe__syscall_entry_unknown' [-Werror=3Dimplicit-=
function-declaration]| =C2=A0 =C2=A0__event_probe__syscall_entry_unknown(ev=
ent, id, args);
lttng-modules/2.7.1-r1/git/lttng-syscalls.c:509:3: error: implicit declarat=
ion of function '__event_probe__compat_syscall_exit_unknown' [-Werror=3Dimp=
licit-function-declaration]| =C2=A0 =C2=A0__event_probe__compat_syscall_exi=
t_unknown(event, id, ret,
lttng-modules/2.7.1-r1/git/lttng-syscalls.c:512:3: error: implicit declarat=
ion of function '__event_probe__syscall_exit_unknown' [-Werror=3Dimplicit-f=
unction-declaration]| =C2=A0 =C2=A0__event_probe__syscall_exit_unknown(even=
t, id, ret, args);
lttng-modules/2.7.1-r1/git/lttng-syscalls.c:740:2: error: implicit declarat=
ion of function 'wrapper_vmalloc_sync_all' [-Werror=3Dimplicit-function-dec=
laration]| =C2=A0 wrapper_vmalloc_sync_all();

lttng-modules/2.7.1-r1/git/lttng-syscalls.c:777:5: error: '__event_desc___s=
yscall_entry_unknown' undeclared (first use in this function)| =C2=A0 =C2=
=A0 &__event_desc___syscall_entry_unknown;
lttng-modules/2.7.1-r1/git/lttng-syscalls.c:794:5: error: '__event_desc___c=
ompat_syscall_entry_unknown' undeclared (first use in this function)| =C2=
=A0 =C2=A0 &__event_desc___compat_syscall_entry_unknown;
lttng-modules/2.7.1-r1/git/lttng-syscalls.c:811:5: error: '__event_desc___c=
ompat_syscall_exit_unknown' undeclared (first use in this function)| =C2=A0=
 =C2=A0 &__event_desc___compat_syscall_exit_unknown;
lttng-modules/2.7.1-r1/git/lttng-syscalls.c:828:5: error: '__event_desc___s=
yscall_exit_unknown' undeclared (first use in this function)| =C2=A0 =C2=A0=
 &__event_desc___syscall_exit_unknown;

If I disable the syscall tracing it builds just fine though. Any idea on wh=
y this may be happening?
Regards,=C2=A0 =C2=A0 =C2=A0Dragos
------=_Part_5846569_1792182833.1455790186970
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, =
sans-serif;font-size:13px"><div id=3D"yui_3_16_0_1_1455780758796_12303">Hel=
lo,</div><div id=3D"yui_3_16_0_1_1455780758796_12285"><br></div><div id=3D"=
yui_3_16_0_1_1455780758796_12311">I'm encountering these compilation errors=
 while trying to build the lttng-modules on an nvidia tegra arm64 board:</d=
iv><div id=3D"yui_3_16_0_1_1455780758796_12454"><br></div><blockquote style=
=3D"margin: 0 0 0 40px; border: none; padding: 0px;" id=3D"yui_3_16_0_1_145=
5780758796_12726"><div id=3D"yui_3_16_0_1_1455780758796_12441" class=3D""><=
span id=3D"yui_3_16_0_1_1455780758796_12443" class=3D"">lttng-modules/2.7.1=
-r1/git/lttng-syscalls.c:358:3: error: implicit declaration of function '__=
event_probe__compat_syscall_entry_unknown' [-Werror=3Dimplicit-function-dec=
laration]</span></div><div id=3D"yui_3_16_0_1_1455780758796_12445" class=3D=
""><span id=3D"yui_3_16_0_1_1455780758796_12447" class=3D"">| &nbsp; &nbsp;=
__event_probe__compat_syscall_entry_unknown(event, id, args);</span></div><=
div id=3D"yui_3_16_0_1_1455780758796_12352" class=3D""><br></div><div id=3D=
"yui_3_16_0_1_1455780758796_12352" class=3D"">lttng-modules/2.7.1-r1/git/lt=
tng-syscalls.c:360:3: error: implicit declaration of function '__event_prob=
e__syscall_entry_unknown' [-Werror=3Dimplicit-function-declaration]</div><d=
iv id=3D"yui_3_16_0_1_1455780758796_12354" class=3D"">| &nbsp; &nbsp;__even=
t_probe__syscall_entry_unknown(event, id, args);</div><div id=3D"yui_3_16_0=
_1_1455780758796_12354" class=3D""><br></div><div id=3D"yui_3_16_0_1_145578=
0758796_12354" class=3D"">lttng-modules/2.7.1-r1/git/lttng-syscalls.c:509:3=
: error: implicit declaration of function '__event_probe__compat_syscall_ex=
it_unknown' [-Werror=3Dimplicit-function-declaration]</div><div id=3D"yui_3=
_16_0_1_1455780758796_12354" class=3D"">| &nbsp; &nbsp;__event_probe__compa=
t_syscall_exit_unknown(event, id, ret,</div><div dir=3D"ltr" id=3D"yui_3_16=
_0_1_1455780758796_12492" class=3D""><br id=3D"yui_3_16_0_1_1455780758796_1=
2494" class=3D""></div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12=
492" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12492" cl=
ass=3D"">lttng-modules/2.7.1-r1/git/lttng-syscalls.c:512:3: error: implicit=
 declaration of function '__event_probe__syscall_exit_unknown' [-Werror=3Di=
mplicit-function-declaration]</div></div><div dir=3D"ltr" id=3D"yui_3_16_0_=
1_1455780758796_12492" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_14557=
80758796_12492" class=3D"">| &nbsp; &nbsp;__event_probe__syscall_exit_unkno=
wn(event, id, ret, args);</div></div><div dir=3D"ltr" id=3D"yui_3_16_0_1_14=
55780758796_12492" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_145578075=
8796_12492" class=3D""><br></div></div><div dir=3D"ltr" id=3D"yui_3_16_0_1_=
1455780758796_12492" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780=
758796_12521" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_=
12521" class=3D"">lttng-modules/2.7.1-r1/git/lttng-syscalls.c:740:2: error:=
 implicit declaration of function 'wrapper_vmalloc_sync_all' [-Werror=3Dimp=
licit-function-declaration]</div></div></div><div dir=3D"ltr" id=3D"yui_3_1=
6_0_1_1455780758796_12492" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1=
455780758796_12521" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_14557807=
58796_12521" class=3D"">| &nbsp; wrapper_vmalloc_sync_all();</div></div></d=
iv><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12492" class=3D""><div=
 dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12521" class=3D""><div dir=3D=
"ltr" id=3D"yui_3_16_0_1_1455780758796_12521" class=3D""><br></div></div></=
div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12492" class=3D""><di=
v dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12521" class=3D""><div dir=
=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12521" class=3D""><br></div></div=
></div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12492" class=3D"">=
<div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12521" class=3D""><div di=
r=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12548" class=3D""><div dir=3D"lt=
r" id=3D"yui_3_16_0_1_1455780758796_12548" class=3D"">lttng-modules/2.7.1-r=
1/git/lttng-syscalls.c:777:5: error: '__event_desc___syscall_entry_unknown'=
 undeclared (first use in this function)</div></div></div></div><div dir=3D=
"ltr" id=3D"yui_3_16_0_1_1455780758796_12492" class=3D""><div dir=3D"ltr" i=
d=3D"yui_3_16_0_1_1455780758796_12521" class=3D""><div dir=3D"ltr" id=3D"yu=
i_3_16_0_1_1455780758796_12548" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_=
0_1_1455780758796_12548" class=3D"">| &nbsp; &nbsp; &amp;__event_desc___sys=
call_entry_unknown;</div></div></div></div><div dir=3D"ltr" id=3D"yui_3_16_=
0_1_1455780758796_12492" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_145=
5780758796_12521" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758=
796_12548" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_125=
90" class=3D""><br id=3D"yui_3_16_0_1_1455780758796_12592" class=3D""></div=
></div></div></div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12492"=
 class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12521" class=
=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12548" class=3D""><=
div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12590" class=3D""><div dir=
=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12590" class=3D"">lttng-modules/2=
.7.1-r1/git/lttng-syscalls.c:794:5: error: '__event_desc___compat_syscall_e=
ntry_unknown' undeclared (first use in this function)</div></div></div></di=
v></div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12492" class=3D""=
><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12521" class=3D""><div d=
ir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12548" class=3D""><div dir=3D"l=
tr" id=3D"yui_3_16_0_1_1455780758796_12590" class=3D""><div dir=3D"ltr" id=
=3D"yui_3_16_0_1_1455780758796_12590" class=3D"">| &nbsp; &nbsp; &amp;__eve=
nt_desc___compat_syscall_entry_unknown;</div></div></div></div></div><div d=
ir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12492" class=3D""><div dir=3D"l=
tr" id=3D"yui_3_16_0_1_1455780758796_12521" class=3D""><div dir=3D"ltr" id=
=3D"yui_3_16_0_1_1455780758796_12548" class=3D""><div dir=3D"ltr" id=3D"yui=
_3_16_0_1_1455780758796_12590" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0=
_1_1455780758796_12619" class=3D""><br id=3D"yui_3_16_0_1_1455780758796_126=
21" class=3D""></div></div></div></div></div><div dir=3D"ltr" id=3D"yui_3_1=
6_0_1_1455780758796_12492" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1=
455780758796_12521" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_14557807=
58796_12548" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_1=
2590" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12619" c=
lass=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12619" class=3D=
"">lttng-modules/2.7.1-r1/git/lttng-syscalls.c:811:5: error: '__event_desc_=
__compat_syscall_exit_unknown' undeclared (first use in this function)</div=
></div></div></div></div></div><div dir=3D"ltr" id=3D"yui_3_16_0_1_14557807=
58796_12492" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_1=
2521" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12548" c=
lass=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12590" class=3D=
""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12619" class=3D""><div=
 dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12619" class=3D"">| &nbsp; &n=
bsp; &amp;__event_desc___compat_syscall_exit_unknown;</div></div></div></di=
v></div></div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12492" clas=
s=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12521" class=3D"">=
<div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12548" class=3D""><div di=
r=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12590" class=3D""><div dir=3D"lt=
r" id=3D"yui_3_16_0_1_1455780758796_12619" class=3D""><div dir=3D"ltr" id=
=3D"yui_3_16_0_1_1455780758796_12641" class=3D""><br id=3D"yui_3_16_0_1_145=
5780758796_12643" class=3D""></div></div></div></div></div></div><div dir=
=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12492" class=3D""><div dir=3D"ltr=
" id=3D"yui_3_16_0_1_1455780758796_12521" class=3D""><div dir=3D"ltr" id=3D=
"yui_3_16_0_1_1455780758796_12548" class=3D""><div dir=3D"ltr" id=3D"yui_3_=
16_0_1_1455780758796_12590" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_=
1455780758796_12619" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780=
758796_12641" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_=
12641" class=3D"">lttng-modules/2.7.1-r1/git/lttng-syscalls.c:828:5: error:=
 '__event_desc___syscall_exit_unknown' undeclared (first use in this functi=
on)</div></div></div></div></div></div></div><div dir=3D"ltr" id=3D"yui_3_1=
6_0_1_1455780758796_12492" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1=
455780758796_12521" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_14557807=
58796_12548" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_1=
2590" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12619" c=
lass=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12641" class=3D=
""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12641" class=3D"">| &n=
bsp; &nbsp; &amp;__event_desc___syscall_exit_unknown;</div></div></div></di=
v></div></div></div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12492=
" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12521" class=
=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12548" class=3D""><=
div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12590" class=3D""><div dir=
=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12619" class=3D""><div dir=3D"ltr=
" id=3D"yui_3_16_0_1_1455780758796_12641" class=3D""><div dir=3D"ltr" id=3D=
"yui_3_16_0_1_1455780758796_12672" class=3D""><br id=3D"yui_3_16_0_1_145578=
0758796_12674" class=3D""></div></div></div></div></div></div></div></block=
quote><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12356" class=3D""><=
div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12356" class=3D"">If I dis=
able the syscall tracing it builds just fine though. Any idea on why this m=
ay be happening?</div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_123=
56" class=3D""><br></div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_=
12356" class=3D"">Regards,</div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780=
758796_12356" class=3D"">&nbsp; &nbsp; &nbsp;Dragos</div></div></div></body=
></html>
------=_Part_5846569_1792182833.1455790186970--


--===============0975683297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0975683297==--
