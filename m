From: Rocky Dunlap via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Babeltrace2 - compilation error with intel18
Date: Fri, 20 Mar 2020 15:55:16 -0600
Message-ID: <CADtyBo7Qjjb_f=45oTaSw4d=dQd5YVt6A2r7z7R5WYrxZ4eVTg@mail.gmail.com>
References: <CADtyBo7jFiv-E-DCp4kYfY7WRSLsN3Oos6iRr35Sy9o=iNZKOg@mail.gmail.com>
 <b2e4fcfb-eb65-5205-1de3-0e0dbfb7fb48@simark.ca>
Reply-To: Rocky Dunlap <dunlap@ucar.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3994419471579982128=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by lists.lttng.org (Postfix) with ESMTPS id 48kcys3TBtz1Nxw
 for <lttng-dev@lists.lttng.org>; Fri, 20 Mar 2020 17:55:33 -0400 (EDT)
Received: by mail-ot1-x333.google.com with SMTP id k26so7569757otr.2
 for <lttng-dev@lists.lttng.org>; Fri, 20 Mar 2020 14:55:33 -0700 (PDT)
In-Reply-To: <b2e4fcfb-eb65-5205-1de3-0e0dbfb7fb48@simark.ca>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Simon Marchi <simark@simark.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============3994419471579982128==
Content-Type: multipart/alternative; boundary="00000000000029aef705a1505829"

--00000000000029aef705a1505829
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Simon,

I was able to get past the issue by passing "--enable-compile-warnings=3Dye=
s"
to configure.

It get a lot further, then fails here:

gcc -pthread -shared -L/apps/intel/intelpython3/lib
-Wl,-rpath=3D/apps/intel/intelpython3/lib,--no-as-needed
-Wl,-z,noexecstack,-z,relro,-z,now -L../../../../src/lib/.libs -pthread
-lgmodule-2.0 -lglib-2.0 -pthread -lgmodule-2.0 -lglib-2.0 -pthread
-I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -pthread -pthread
-I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -fno-strict-aliasing
-Wnested-externs -Wmissing-prototypes -Wstrict-prototypes
-Wdeclaration-after-statement -Wimplicit-function-declaration
-Wold-style-definition -Wjump-misses-init -Wall -Wextra -Wundef
-Wwrite-strings -Wpointer-arith -Wmissing-declarations -Wredundant-decls
-Wno-unused-parameter -Wno-missing-field-initializers -Wformat=3D2
-Wcast-align -Wformat-nonliteral -Wformat-security -Wsign-compare
-Wstrict-aliasing -Wshadow -Winline -Wpacked -Wmissing-format-attribute
-Wmissing-noreturn -Winit-self -Wmissing-include-dirs
-Wunused-but-set-variable -Warray-bounds -Wreturn-type -Wswitch-enum
-Wswitch-default -Wduplicated-cond -Wduplicated-branches -Wlogical-op
-Wrestrict -Wnull-dereference -Wdouble-promotion -Wno-sign-compare
-Wno-inline -Wno-declaration-after-statement -Wno-switch-enum
-Wno-switch-default -Wno-packed -Wno-pointer-arith -Wno-format-nonliteral
-Wno-double-promotion -Wno-cast-align -Wno-cast-function-type
-Wno-error=3Dunused-parameter -Wno-error=3Dmissing-field-initializers
-Wno-error=3Dsign-compare -Wno-error=3Dinline
-Wno-error=3Ddeclaration-after-statement -Wno-error=3Dswitch-enum
-Wno-error=3Dswitch-default -Wno-error=3Dpacked -Wno-error=3Dpointer-arith
-Wno-error=3Dformat-nonliteral -Wno-error=3Ddouble-promotion
-Wno-error=3Dcast-align -Wno-error=3Dcast-function-type -Wold-style-definit=
ion
-Werror=3Dimplicit-function-declaration -g -O2 -Wno-shadow
-Wno-null-dereference -I../../../../include -I../../../../src
-I../../../../src -include common/config.h -I./bt2
build/temp.linux-x86_64-3.6/bt2/native_bt.o
build/temp.linux-x86_64-3.6/./bt2/logging.o
../../../../src/autodisc/.libs/libbabeltrace2-autodisc.a
../../../../src/logging/.libs/libbabeltrace2-logging.a
../../../../src/common/.libs/libbabeltrace2-common.a
../../../../src/py-common/.libs/libbabeltrace2-py-common.a
../../../../src/string-format/.libs/libbabeltrace2-string-format.a
-L/apps/intel/intelpython3/lib -lbabeltrace2 -lglib-2.0 -lpython3.6m -o
build/build_lib/bt2/_native_bt.cpython-36m-x86_64-linux-gnu.so
gcc: error: unrecognized command line option =E2=80=98-Wduplicated-cond=E2=
=80=99
gcc: error: unrecognized command line option =E2=80=98-Wduplicated-branches=
=E2=80=99
gcc: error: unrecognized command line option =E2=80=98-Wrestrict=E2=80=99
gcc: error: unrecognized command line option =E2=80=98-Wnull-dereference=E2=
=80=99
error: command 'gcc' failed with exit status 1
make[4]: *** [build-python-bindings.stamp] Error 1

I am surprised that this is using "gcc" here, shouldn't it be using "icc"
since I have CC=3Dicc?

Or maybe it is supposed to be using gcc?  I think if I update the GCC
compiler version then it will get past this issue as well, but I just
wanted confirmation that this indeed should be using a combination of gcc
and icc?

If it should be icc, can you point me to where in the configure/make system
I can make this change to force it to use what's sets as CC instead of
defaulting to GCC?

Rocky

On Fri, Mar 20, 2020 at 3:47 PM Simon Marchi <simark@simark.ca> wrote:

> On 2020-03-20 5:10 p.m., Rocky Dunlap via lttng-dev wrote:
> > I am trying to compile BT2 with Python bindings using Intel18.  I
> receive the following error during the build:
> Hi Rocky,
>
> I don't think we claim to support the Intel compiler, so you might be a b=
it
> on your own here.  Although if you want to send patches to fix the build
> using
> that compiler, I don't have anything against that.
>
> >
> > In file included from py-common.c(31):
> > /apps/intel/intelpython3/include/python3.6m/Python.h(149): error #193:
> zero used for undefined preprocessing identifier "_MSC_VER"
> >   #if _MSC_VER
> >       ^
> >
> > In file included from py-common.c(31):
> > /apps/intel/intelpython3/include/python3.6m/Python.h(151): error #193:
> zero used for undefined preprocessing identifier "__clang__"
> >   #elif __clang__ || __GNUC__
> >         ^
>
> It took me a bit of time to understand that this is Intel's Python 3
> distribution, not CPython.
>
> I think it's technically valid to use an undefined macro in a preprocesso=
r
> condition like that, in which case it gets replaced with 0 (as the error
> message mentions).  The compiler is trying to be helpful and warns you,
> because
> relying on that behavior is a bit fragile, and often a sign of a mistake
> somewhere.  But since this happens in a library you are using, I think
> your best
> bet is just to disable this warning.
>
> > py-common.c(187): error #3179: deprecated conversion of string literal
> to char* (should be const char*)
> >   format_exc_func_name =3D py_exc_tb ? "format_exception" :
>
> I really don't understand this one, as format_exc_func_name is a const
> char *
> in our code.
>
> Simon
>
>

--00000000000029aef705a1505829
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Simon,<div><br></div><div>I was able to get past the issue=
 by passing &quot;--enable-compile-warnings=3Dyes&quot; to configure.</div>=
<div><br></div><div>It get a lot further, then fails here:</div><div><br></=
div><div>gcc -pthread -shared -L/apps/intel/intelpython3/lib -Wl,-rpath=3D/=
apps/intel/intelpython3/lib,--no-as-needed -Wl,-z,noexecstack,-z,relro,-z,n=
ow -L../../../../src/lib/.libs -pthread -lgmodule-2.0 -lglib-2.0 -pthread -=
lgmodule-2.0 -lglib-2.0 -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-=
2.0/include -pthread -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0=
/include -fno-strict-aliasing -Wnested-externs -Wmissing-prototypes -Wstric=
t-prototypes -Wdeclaration-after-statement -Wimplicit-function-declaration =
-Wold-style-definition -Wjump-misses-init -Wall -Wextra -Wundef -Wwrite-str=
ings -Wpointer-arith -Wmissing-declarations -Wredundant-decls -Wno-unused-p=
arameter -Wno-missing-field-initializers -Wformat=3D2 -Wcast-align -Wformat=
-nonliteral -Wformat-security -Wsign-compare -Wstrict-aliasing -Wshadow -Wi=
nline -Wpacked -Wmissing-format-attribute -Wmissing-noreturn -Winit-self -W=
missing-include-dirs -Wunused-but-set-variable -Warray-bounds -Wreturn-type=
 -Wswitch-enum -Wswitch-default -Wduplicated-cond -Wduplicated-branches -Wl=
ogical-op -Wrestrict -Wnull-dereference -Wdouble-promotion -Wno-sign-compar=
e -Wno-inline -Wno-declaration-after-statement -Wno-switch-enum -Wno-switch=
-default -Wno-packed -Wno-pointer-arith -Wno-format-nonliteral -Wno-double-=
promotion -Wno-cast-align -Wno-cast-function-type -Wno-error=3Dunused-param=
eter -Wno-error=3Dmissing-field-initializers -Wno-error=3Dsign-compare -Wno=
-error=3Dinline -Wno-error=3Ddeclaration-after-statement -Wno-error=3Dswitc=
h-enum -Wno-error=3Dswitch-default -Wno-error=3Dpacked -Wno-error=3Dpointer=
-arith -Wno-error=3Dformat-nonliteral -Wno-error=3Ddouble-promotion -Wno-er=
ror=3Dcast-align -Wno-error=3Dcast-function-type -Wold-style-definition -We=
rror=3Dimplicit-function-declaration -g -O2 -Wno-shadow -Wno-null-dereferen=
ce -I../../../../include -I../../../../src -I../../../../src -include commo=
n/config.h -I./bt2 build/temp.linux-x86_64-3.6/bt2/native_bt.o build/temp.l=
inux-x86_64-3.6/./bt2/logging.o ../../../../src/autodisc/.libs/libbabeltrac=
e2-autodisc.a ../../../../src/logging/.libs/libbabeltrace2-logging.a ../../=
../../src/common/.libs/libbabeltrace2-common.a ../../../../src/py-common/.l=
ibs/libbabeltrace2-py-common.a ../../../../src/string-format/.libs/libbabel=
trace2-string-format.a -L/apps/intel/intelpython3/lib -lbabeltrace2 -lglib-=
2.0 -lpython3.6m -o build/build_lib/bt2/_<a href=3D"http://native_bt.cpytho=
n-36m-x86_64-linux-gnu.so">native_bt.cpython-36m-x86_64-linux-gnu.so</a><br=
>gcc: error: unrecognized command line option =E2=80=98-Wduplicated-cond=E2=
=80=99<br>gcc: error: unrecognized command line option =E2=80=98-Wduplicate=
d-branches=E2=80=99<br>gcc: error: unrecognized command line option =E2=80=
=98-Wrestrict=E2=80=99<br>gcc: error: unrecognized command line option =E2=
=80=98-Wnull-dereference=E2=80=99<br>error: command &#39;gcc&#39; failed wi=
th exit status 1<br>make[4]: *** [build-python-bindings.stamp] Error 1<br><=
/div><div><br></div><div>I am surprised that this is using &quot;gcc&quot; =
here, shouldn&#39;t it be using &quot;icc&quot; since I have CC=3Dicc?<br><=
/div><div><br></div><div>Or maybe it is supposed to be using gcc?=C2=A0 I t=
hink if I update the GCC compiler version then it will get past this issue =
as well, but I just wanted confirmation that this indeed should be using a =
combination of gcc and icc?</div><div><br></div><div>If it should be icc, c=
an you point me to where in the configure/make system I can make this chang=
e to force it to use what&#39;s sets as CC instead of defaulting to GCC?</d=
iv><div><br></div><div>Rocky</div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 20, 2020 at 3:47 PM Simon Mar=
chi &lt;<a href=3D"mailto:simark@simark.ca">simark@simark.ca</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 2020-03-20 5=
:10 p.m., Rocky Dunlap via lttng-dev wrote:<br>
&gt; I am trying to compile BT2 with Python bindings using Intel18.=C2=A0 I=
 receive the following error during the build:<br>
Hi Rocky,<br>
<br>
I don&#39;t think we claim to support the Intel compiler, so you might be a=
 bit<br>
on your own here.=C2=A0 Although if you want to send patches to fix the bui=
ld using<br>
that compiler, I don&#39;t have anything against that.<br>
<br>
&gt; <br>
&gt; In file included from py-common.c(31):<br>
&gt; /apps/intel/intelpython3/include/python3.6m/Python.h(149): error #193:=
 zero used for undefined preprocessing identifier &quot;_MSC_VER&quot;<br>
&gt; =C2=A0 #if _MSC_VER<br>
&gt; =C2=A0 =C2=A0 =C2=A0 ^<br>
&gt; <br>
&gt; In file included from py-common.c(31):<br>
&gt; /apps/intel/intelpython3/include/python3.6m/Python.h(151): error #193:=
 zero used for undefined preprocessing identifier &quot;__clang__&quot;<br>
&gt; =C2=A0 #elif __clang__ || __GNUC__<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>
<br>
It took me a bit of time to understand that this is Intel&#39;s Python 3<br=
>
distribution, not CPython.<br>
<br>
I think it&#39;s technically valid to use an undefined macro in a preproces=
sor<br>
condition like that, in which case it gets replaced with 0 (as the error<br=
>
message mentions).=C2=A0 The compiler is trying to be helpful and warns you=
, because<br>
relying on that behavior is a bit fragile, and often a sign of a mistake<br=
>
somewhere.=C2=A0 But since this happens in a library you are using, I think=
 your best<br>
bet is just to disable this warning.<br>
<br>
&gt; py-common.c(187): error #3179: deprecated conversion of string literal=
 to char* (should be const char*)<br>
&gt; =C2=A0 format_exc_func_name =3D py_exc_tb ? &quot;format_exception&quo=
t; :<br>
<br>
I really don&#39;t understand this one, as format_exc_func_name is a const =
char *<br>
in our code.<br>
<br>
Simon<br>
<br>
</blockquote></div>

--00000000000029aef705a1505829--

--===============3994419471579982128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3994419471579982128==--
