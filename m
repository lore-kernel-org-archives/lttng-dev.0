From: =?UTF-8?Q?Martin_=C3=9Cnsal?= <martinunsal@gmail.com>
Subject: Problem with UST related to dlload
Date: Wed, 30 Apr 2014 14:21:09 -0700
Message-ID: <CACsXv7BQ-T+6ggdM9+YPcu+hdy0Gxu6c_jxNj97AvzmDgXQ8Wg__16938.2456144833$1398892948$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1509935795=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <martinunsal@gmail.com>) id 1WfbwI-0006en-Qj
 for lttng-dev@lists.lttng.org; Wed, 30 Apr 2014 17:21:20 -0400
Received: by mail-ve0-f178.google.com with SMTP id jw12so2886157veb.23
 for <lttng-dev@lists.lttng.org>; Wed, 30 Apr 2014 14:21:09 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1509935795==
Content-Type: multipart/alternative; boundary=001a1133fd5c8d19af04f84920c0

--001a1133fd5c8d19af04f84920c0
Content-Type: text/plain; charset=UTF-8

Hi LTTng folks

I have a strange problem using LTTng-UST on an ARM based platform. I have
done some diagnosis but I am running low on ideas and was hoping for help
from the experts. I am using lttng-tools 2.2.0, lttng-ust 2.2.0, liburcu
0.8.1. I know these are old but upgrading is easier said than done
unfortunately. I didn't see anything related to this problem in relnotes,
mailing list traffic, or master branch, but I could have missed something.

The problem showed up when I switched from GCC 4.6.4 to 4.7.2.
Conceptually, the situation is that I have a single executable, call it
MyProgram, with two plugins loaded at runtime with dlopen(), lets call them
libPlugin1.so and libPlugin2.so. There are three different LTTng-UST
tracepoint providers, one each for the executable and the two plugins. With
GCC 4.7.2, tracepoints in libPlugin1 stopped working. The tracepoints in
MyProgram and in libPlugin2 continue to work correctly.

I have established without a doubt that the toolchain upgrade is the cause
of the regression.

In the debugger, I confirmed that the tracepoint for libPlugin1.so is being
executed, but __tracepoint_##provider##___##name.state is always 0 even
when I enable the tracepoint in lttng-tools. As a result the tracepoint
callback is not being invoked when it should be. In MyProgram and
libPlugin2.so, the .state variable correctly reflects whether the
tracepoint is enabled, and if the tracepoint is enabled, the tracepoint
callback is invoked.

Next I set a breakpoint in tracepoint_register_lib() and looked at
tracepoints_start parameter.

1) With GCC 4.6.4 everything is as expected:
   a) tracepoint_register_lib() for MyProgram called with
MyProgramProvider's __start___tracepoints_ptrs.
   b) tracepoint_register_lib() after libPlugin1 dlopen() called with
libPlugin1Provider's __start___tracepoints_ptrs
   c) tracepoint_register_lib() after libPlugin2 dlopen() called with
libPlugin2Provider's __start___tracepoint_ptrs

2) With GCC 4.7.2 there is a problem:
   a) tracepoint_register_lib() for MyProgram called with
MyProgramProvider's __start___tracepoints_ptrs.
   b) tracepoint_register_lib() after libPlugin1 dlopen() called with
MyProgramProvider's __start___tracepoints_ptrs (!!!! THIS IS WRONG !!!!)
   c) tracepoint_register_lib() after libPlugin2 dlopen() called with
libPlugin2Provider's __start___tracepoint_ptrs

I looked at the symbol table for libPlugin1.so to see if it would shed some
light on the problem.

1) With GCC 4.6.4:
# objdump -t /usr/lib/.debug/libPlugin1.so | grep __start___tracepoints_ptrs
00025bb0 l       *ABS* 00000000 __start___tracepoints_ptrs
# objdump -t /usr/lib/.debug/libPlugin2.so | grep __start___tracepoints_ptrs
00041eb4 l       *ABS* 00000000 __start___tracepoints_ptrs

2) With GCC 4.7.2:
# objdump -t /usr/lib/.debug/libPlugin1.so | grep __start___tracepoints_ptrs
00025a90 g       __tracepoints_ptrs 00000000 __start___tracepoints_ptrs
# objdump -t /usr/lib/.debug/libPlugin2.so | grep __start___tracepoints_ptrs
00041eb4 g       __tracepoints_ptrs 00000000 __start___tracepoints_ptrs

My hypothesis at this point is that since __start___tracepoints_ptrs
changed from a local to a global symbol, the dynamic loader no longer knows
how to select the correct weak symbol. I cannot explain why libPlugin2
still loads its provider correctly, perhaps it is just getting lucky.

A few questions come to mind...
1) Have you run into a problem like this? Is there a known fix/workaround?
2) __start____tracepoints_ptrs is declared as extern in tracepoint.h, but
it is not defined. This appears to be some sort of undocumented linker
magic. http://gcc.gnu.org/ml/gcc-help/2010-04/msg00120.html is the only
reference I could find. Do you know where this behavior is documented or
specified (if at all)?
3) Do you know why the symbol visibility for __start___tracepoints_ptrs
changed between 4.6.4 to 4.7.2?

Thanks for any help. This is a real puzzler for me.

Martin

--001a1133fd5c8d19af04f84920c0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi LTTng folks<div><br></div><div>I have a strange problem=
 using LTTng-UST on an ARM based platform. I have done some diagnosis but I=
 am running low on ideas and was hoping for help from the experts. I am usi=
ng lttng-tools 2.2.0, lttng-ust 2.2.0, liburcu 0.8.1. I know these are old =
but upgrading is easier said than done unfortunately. I didn&#39;t see anyt=
hing related to this problem in relnotes, mailing list traffic, or master b=
ranch, but I could have missed something.</div>
<div><br></div><div>The problem showed up when I switched from GCC 4.6.4 to=
 4.7.2. Conceptually, the situation is that I have a single executable, cal=
l it MyProgram, with two plugins loaded at runtime with dlopen(), lets call=
 them libPlugin1.so and libPlugin2.so. There are three different LTTng-UST =
tracepoint providers, one each for the executable and the two plugins. With=
 GCC 4.7.2, tracepoints in libPlugin1 stopped working. The tracepoints in M=
yProgram and in libPlugin2 continue to work correctly.</div>
<div><br></div><div>I have established without a doubt that the toolchain u=
pgrade is the cause of the regression.</div><div><br></div><div>In the debu=
gger, I confirmed that the tracepoint for libPlugin1.so is being executed, =
but __tracepoint_##provider##___##name.state is always 0 even when I enable=
 the tracepoint in lttng-tools. As a result the tracepoint callback is not =
being invoked when it should be. In MyProgram and libPlugin2.so, the .state=
 variable correctly reflects whether the tracepoint is enabled, and if the =
tracepoint is enabled, the tracepoint callback is invoked.</div>
<div><br></div><div>Next I set a breakpoint in tracepoint_register_lib() an=
d looked at tracepoints_start parameter.</div><div><br></div><div>1) With G=
CC 4.6.4 everything is as expected:</div><div>=C2=A0 =C2=A0a) tracepoint_re=
gister_lib() for MyProgram called with MyProgramProvider&#39;s __start___tr=
acepoints_ptrs.</div>
<div>=C2=A0 =C2=A0b) tracepoint_register_lib() after libPlugin1 dlopen() ca=
lled with libPlugin1Provider&#39;s __start___tracepoints_ptrs<br></div><div=
>=C2=A0 =C2=A0c) tracepoint_register_lib() after libPlugin2 dlopen() called=
 with libPlugin2Provider&#39;s __start___tracepoint_ptrs</div>
<div><br></div><div>2) With GCC 4.7.2 there is a problem:</div><div><div>=
=C2=A0 =C2=A0a) tracepoint_register_lib() for MyProgram called with MyProgr=
amProvider&#39;s __start___tracepoints_ptrs.</div><div>=C2=A0 =C2=A0b) trac=
epoint_register_lib() after libPlugin1 dlopen() called with MyProgramProvid=
er&#39;s __start___tracepoints_ptrs (!!!! THIS IS WRONG !!!!)<br>
</div><div><div>=C2=A0 =C2=A0c) tracepoint_register_lib() after libPlugin2 =
dlopen() called with libPlugin2Provider&#39;s __start___tracepoint_ptrs</di=
v></div></div><div><br></div><div>I looked at the symbol table for libPlugi=
n1.so to see if it would shed some light on the problem.</div>
<div><br></div><div>1) With GCC 4.6.4:</div><div># objdump -t /usr/lib/.deb=
ug/libPlugin1.so | grep __start___tracepoints_ptrs<br></div><div><div>00025=
bb0 l =C2=A0 =C2=A0 =C2=A0 *ABS*<span class=3D"" style=3D"white-space:pre">=
	</span>00000000 __start___tracepoints_ptrs<br>
</div></div><div><div># objdump -t /usr/lib/.debug/libPlugin2.so | grep __s=
tart___tracepoints_ptrs</div><div>00041eb4 l =C2=A0 =C2=A0 =C2=A0 *ABS*<spa=
n class=3D"" style=3D"white-space:pre">	</span>00000000 __start___tracepoin=
ts_ptrs</div></div>
<div><br></div><div>2) With GCC 4.7.2:</div><div><div># objdump -t /usr/lib=
/.debug/libPlugin1.so | grep __start___tracepoints_ptrs</div></div><div><di=
v>00025a90 g =C2=A0 =C2=A0 =C2=A0 __tracepoints_ptrs<span class=3D"" style=
=3D"white-space:pre">	</span>00000000 __start___tracepoints_ptrs<br>
</div></div><div><div># objdump -t /usr/lib/.debug/libPlugin2.so | grep __s=
tart___tracepoints_ptrs</div><div>00041eb4 g =C2=A0 =C2=A0 =C2=A0 __tracepo=
ints_ptrs<span class=3D"" style=3D"white-space:pre">	</span>00000000 __star=
t___tracepoints_ptrs</div>
</div><div><br></div><div>My hypothesis at this point is that since __start=
___tracepoints_ptrs changed from a local to a global symbol, the dynamic lo=
ader no longer knows how to select the correct weak symbol. I cannot explai=
n why libPlugin2 still loads its provider correctly, perhaps it is just get=
ting lucky.</div>
<div><br></div><div>A few questions come to mind...</div><div>1) Have you r=
un into a problem like this? Is there a known fix/workaround?</div><div>2) =
__start____tracepoints_ptrs is declared as extern in tracepoint.h, but it i=
s not defined. This appears to be some sort of undocumented linker magic.=
=C2=A0<a href=3D"http://gcc.gnu.org/ml/gcc-help/2010-04/msg00120.html">http=
://gcc.gnu.org/ml/gcc-help/2010-04/msg00120.html</a> is the only reference =
I could find. Do you know where this behavior is documented or specified (i=
f at all)?</div>
<div>3) Do you know why the symbol visibility for __start___tracepoints_ptr=
s changed between 4.6.4 to 4.7.2?</div><div><br></div><div>Thanks for any h=
elp. This is a real puzzler for me.</div><div><br></div><div>Martin</div>
<div><br></div></div>

--001a1133fd5c8d19af04f84920c0--


--===============1509935795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1509935795==--
