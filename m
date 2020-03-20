From: Rocky Dunlap via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Babeltrace2 - compilation error with intel18
Date: Fri, 20 Mar 2020 16:32:04 -0600
Message-ID: <CADtyBo44MW0=jBnrhh-aqfnrS8RtLAk9zbBZp3ktEhKACWPXdg@mail.gmail.com>
References: <CADtyBo7jFiv-E-DCp4kYfY7WRSLsN3Oos6iRr35Sy9o=iNZKOg@mail.gmail.com>
 <b2e4fcfb-eb65-5205-1de3-0e0dbfb7fb48@simark.ca>
 <CADtyBo7Qjjb_f=45oTaSw4d=dQd5YVt6A2r7z7R5WYrxZ4eVTg@mail.gmail.com>
 <60fcd0f0-e89c-5e04-8185-8cf34a92fe04@simark.ca>
Reply-To: Rocky Dunlap <dunlap@ucar.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8169731497274000465=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by lists.lttng.org (Postfix) with ESMTPS id 48kdnL1Lnjz1PCc
 for <lttng-dev@lists.lttng.org>; Fri, 20 Mar 2020 18:32:21 -0400 (EDT)
Received: by mail-oi1-x235.google.com with SMTP id y71so8244680oia.7
 for <lttng-dev@lists.lttng.org>; Fri, 20 Mar 2020 15:32:21 -0700 (PDT)
In-Reply-To: <60fcd0f0-e89c-5e04-8185-8cf34a92fe04@simark.ca>
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

--===============8169731497274000465==
Content-Type: multipart/alternative; boundary="000000000000cff05105a150dbdb"

--000000000000cff05105a150dbdb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Simon,

Thanks for this - so after I updated to gcc 9.2, the shared libraries
command ran correctly and the build finished. All the tests pass and I was
able to read in a CTF trace from a python script.

The issue was that the system gcc was gcc 4.X.X, so too old.  So, I had to
manually add the newer gcc to the path alongside the intel compiler.  I can
try to option of setting LDSHARED, but at this point that seems even more
confusing than just using the system gcc, which apparently has no trouble
linking intel object files into a shared library.  Maybe there are good
reasons why this is the case and this is why distutils does not use the
right compiler?

Ideally the build would just "work" with ./configure, make, make install
since these kinds of compilation issues can quickly get over people's heads
and cause them to abandon the library altogether.  I wonder if there is a
way for the configure/make to set the LDSHARED automatically so that is is
transparent to the user.  Certainly we are not the first to run into this
issue with distutils.

Rocky

On Fri, Mar 20, 2020 at 4:20 PM Simon Marchi <simark@simark.ca> wrote:

> On 2020-03-20 5:55 p.m., Rocky Dunlap wrote:
> > Simon,
> >
> > I was able to get past the issue by passing
> "--enable-compile-warnings=3Dyes" to configure.
> >
> > It get a lot further, then fails here:
> >
> > gcc -pthread -shared -L/apps/intel/intelpython3/lib
> -Wl,-rpath=3D/apps/intel/intelpython3/lib,--no-as-needed
> -Wl,-z,noexecstack,-z,relro,-z,now -L../../../../src/lib/.libs -pthread
> -lgmodule-2.0 -lglib-2.0 -pthread -lgmodule-2.0 -lglib-2.0 -pthread
> -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -pthread -pthread
> -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -fno-strict-aliasin=
g
> -Wnested-externs -Wmissing-prototypes -Wstrict-prototypes
> -Wdeclaration-after-statement -Wimplicit-function-declaration
> -Wold-style-definition -Wjump-misses-init -Wall -Wextra -Wundef
> -Wwrite-strings -Wpointer-arith -Wmissing-declarations -Wredundant-decls
> -Wno-unused-parameter -Wno-missing-field-initializers -Wformat=3D2
> -Wcast-align -Wformat-nonliteral -Wformat-security -Wsign-compare
> -Wstrict-aliasing -Wshadow -Winline -Wpacked -Wmissing-format-attribute
> -Wmissing-noreturn -Winit-self -Wmissing-include-dirs
> -Wunused-but-set-variable -Warray-bounds -Wreturn-type -Wswitch-enum
> > -Wswitch-default -Wduplicated-cond -Wduplicated-branches -Wlogical-op
> -Wrestrict -Wnull-dereference -Wdouble-promotion -Wno-sign-compare
> -Wno-inline -Wno-declaration-after-statement -Wno-switch-enum
> -Wno-switch-default -Wno-packed -Wno-pointer-arith -Wno-format-nonliteral
> -Wno-double-promotion -Wno-cast-align -Wno-cast-function-type
> -Wno-error=3Dunused-parameter -Wno-error=3Dmissing-field-initializers
> -Wno-error=3Dsign-compare -Wno-error=3Dinline
> -Wno-error=3Ddeclaration-after-statement -Wno-error=3Dswitch-enum
> -Wno-error=3Dswitch-default -Wno-error=3Dpacked -Wno-error=3Dpointer-arit=
h
> -Wno-error=3Dformat-nonliteral -Wno-error=3Ddouble-promotion
> -Wno-error=3Dcast-align -Wno-error=3Dcast-function-type -Wold-style-defin=
ition
> -Werror=3Dimplicit-function-declaration -g -O2 -Wno-shadow
> -Wno-null-dereference -I../../../../include -I../../../../src
> -I../../../../src -include common/config.h -I./bt2
> build/temp.linux-x86_64-3.6/bt2/native_bt.o
> build/temp.linux-x86_64-3.6/./bt2/logging.o
> > ../../../../src/autodisc/.libs/libbabeltrace2-autodisc.a
> ../../../../src/logging/.libs/libbabeltrace2-logging.a
> ../../../../src/common/.libs/libbabeltrace2-common.a
> ../../../../src/py-common/.libs/libbabeltrace2-py-common.a
> ../../../../src/string-format/.libs/libbabeltrace2-string-format.a
> -L/apps/intel/intelpython3/lib -lbabeltrace2 -lglib-2.0 -lpython3.6m -o
> build/build_lib/bt2/_native_bt.cpython-36m-x86_64-linux-gnu.so <
> http://native_bt.cpython-36m-x86_64-linux-gnu.so>
> > gcc: error: unrecognized command line option =E2=80=98-Wduplicated-cond=
=E2=80=99
> > gcc: error: unrecognized command line option =E2=80=98-Wduplicated-bran=
ches=E2=80=99
> > gcc: error: unrecognized command line option =E2=80=98-Wrestrict=E2=80=
=99
> > gcc: error: unrecognized command line option =E2=80=98-Wnull-dereferenc=
e=E2=80=99
> > error: command 'gcc' failed with exit status 1
> > make[4]: *** [build-python-bindings.stamp] Error 1
> >
> > I am surprised that this is using "gcc" here, shouldn't it be using
> "icc" since I have CC=3Dicc?
> >
> > Or maybe it is supposed to be using gcc?  I think if I update the GCC
> compiler version then it will get past this issue as well, but I just
> wanted confirmation that this indeed should be using a combination of gcc
> and icc?
> >
> > If it should be icc, can you point me to where in the configure/make
> system I can make this change to force it to use what's sets as CC instea=
d
> of defaulting to GCC?
> >
> > Rocky
>
> I've hit this exact issue by trying to compile with CC=3Dclang.  This is =
due
> to an
> oddity of distutils when it builds the native module, I don't really know
> what to
> do about it.
>
> When it compiles native_bt.o, distutils uses the compiler specified in CC=
,
> which is
> what we want.  But when it links the shared object, it:
>
>   - uses the default system compiler (often gcc), and
>   - passes the flags specified in CFLAGS
>
> However, CFLAGS contains the warning flags that our configure script
> determined
> $CC accepts (note, that detection might not work well with icc, we haven'=
t
> tested).
>
> So we end up passing warning flags recognized by $CC (e.g. clang) to gcc,
> which makes
> gcc error out.
>
> distutils allows to override the command used to link shared libraries by
> setting the
> LDSHARED variable.  So you could try to set LDSHARED to "icc" plus the
> right flags
> required to link a shared lib.  For reference, the default LDSHARED value
> for your Python
> installation can be checked with:
>
>     $ python3 -c 'import sysconfig;
> print(sysconfig.get_config_var("LDSHARED"))'
>     x86_64-linux-gnu-gcc -pthread -shared -Wl,-O1 -Wl,-Bsymbolic-function=
s
> -Wl,-Bsymbolic-functions -Wl,-z,relro
>
> But even worse, when building with CC=3Dclang on Arch Linux, I noticed th=
at
> distutils
> passes some gcc-specific flags (which don't come from us) when compiling.
> I'm not
> sure what we're going to do about that.
>
> Simon
>

--000000000000cff05105a150dbdb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Simon,<div><br></div><div>Thanks for this - so after I upd=
ated to gcc 9.2, the shared libraries command ran correctly and the build f=
inished. All the tests pass and I was able to read in a CTF trace from a py=
thon script.=C2=A0=C2=A0</div><div><br></div><div>The issue was that the sy=
stem gcc was gcc 4.X.X, so too old.=C2=A0 So, I had to manually add the new=
er gcc to the path alongside the intel compiler.=C2=A0 I can try to option =
of setting LDSHARED, but at this point that seems even more confusing=C2=A0=
than just using the system gcc, which apparently has no trouble linking int=
el object files into a shared library.=C2=A0 Maybe there are good reasons w=
hy this is the case and this is why distutils does not use the right compil=
er?</div><div><br></div><div>Ideally the build would just &quot;work&quot; =
with ./configure, make, make install since these kinds of compilation issue=
s can quickly get over people&#39;s heads and cause them to abandon the lib=
rary altogether.=C2=A0 I wonder if there is a way for the configure/make to=
 set the LDSHARED automatically=C2=A0so that is is transparent to the user.=
=C2=A0 Certainly we are not the first to run into this issue with distutils=
.</div><div><br></div><div>Rocky</div></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 20, 2020 at 4:20 PM Simon=
 Marchi &lt;<a href=3D"mailto:simark@simark.ca">simark@simark.ca</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 2020-03-=
20 5:55 p.m., Rocky Dunlap wrote:<br>
&gt; Simon,<br>
&gt; <br>
&gt; I was able to get past the issue by passing &quot;--enable-compile-war=
nings=3Dyes&quot; to configure.<br>
&gt; <br>
&gt; It get a lot further, then fails here:<br>
&gt; <br>
&gt; gcc -pthread -shared -L/apps/intel/intelpython3/lib -Wl,-rpath=3D/apps=
/intel/intelpython3/lib,--no-as-needed -Wl,-z,noexecstack,-z,relro,-z,now -=
L../../../../src/lib/.libs -pthread -lgmodule-2.0 -lglib-2.0 -pthread -lgmo=
dule-2.0 -lglib-2.0 -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/=
include -pthread -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/inc=
lude -fno-strict-aliasing -Wnested-externs -Wmissing-prototypes -Wstrict-pr=
ototypes -Wdeclaration-after-statement -Wimplicit-function-declaration -Wol=
d-style-definition -Wjump-misses-init -Wall -Wextra -Wundef -Wwrite-strings=
 -Wpointer-arith -Wmissing-declarations -Wredundant-decls -Wno-unused-param=
eter -Wno-missing-field-initializers -Wformat=3D2 -Wcast-align -Wformat-non=
literal -Wformat-security -Wsign-compare -Wstrict-aliasing -Wshadow -Winlin=
e -Wpacked -Wmissing-format-attribute -Wmissing-noreturn -Winit-self -Wmiss=
ing-include-dirs -Wunused-but-set-variable -Warray-bounds -Wreturn-type -Ws=
witch-enum<br>
&gt; -Wswitch-default -Wduplicated-cond -Wduplicated-branches -Wlogical-op =
-Wrestrict -Wnull-dereference -Wdouble-promotion -Wno-sign-compare -Wno-inl=
ine -Wno-declaration-after-statement -Wno-switch-enum -Wno-switch-default -=
Wno-packed -Wno-pointer-arith -Wno-format-nonliteral -Wno-double-promotion =
-Wno-cast-align -Wno-cast-function-type -Wno-error=3Dunused-parameter -Wno-=
error=3Dmissing-field-initializers -Wno-error=3Dsign-compare -Wno-error=3Di=
nline -Wno-error=3Ddeclaration-after-statement -Wno-error=3Dswitch-enum -Wn=
o-error=3Dswitch-default -Wno-error=3Dpacked -Wno-error=3Dpointer-arith -Wn=
o-error=3Dformat-nonliteral -Wno-error=3Ddouble-promotion -Wno-error=3Dcast=
-align -Wno-error=3Dcast-function-type -Wold-style-definition -Werror=3Dimp=
licit-function-declaration -g -O2 -Wno-shadow -Wno-null-dereference -I../..=
/../../include -I../../../../src -I../../../../src -include common/config.h=
 -I./bt2 build/temp.linux-x86_64-3.6/bt2/native_bt.o build/temp.linux-x86_6=
4-3.6/./bt2/logging.o<br>
&gt; ../../../../src/autodisc/.libs/libbabeltrace2-autodisc.a ../../../../s=
rc/logging/.libs/libbabeltrace2-logging.a ../../../../src/common/.libs/libb=
abeltrace2-common.a ../../../../src/py-common/.libs/libbabeltrace2-py-commo=
n.a ../../../../src/string-format/.libs/libbabeltrace2-string-format.a -L/a=
pps/intel/intelpython3/lib -lbabeltrace2 -lglib-2.0 -lpython3.6m -o build/b=
uild_lib/bt2/_<a href=3D"http://native_bt.cpython-36m-x86_64-linux-gnu.so" =
rel=3D"noreferrer" target=3D"_blank">native_bt.cpython-36m-x86_64-linux-gnu=
.so</a> &lt;<a href=3D"http://native_bt.cpython-36m-x86_64-linux-gnu.so" re=
l=3D"noreferrer" target=3D"_blank">http://native_bt.cpython-36m-x86_64-linu=
x-gnu.so</a>&gt;<br>
&gt; gcc: error: unrecognized command line option =E2=80=98-Wduplicated-con=
d=E2=80=99<br>
&gt; gcc: error: unrecognized command line option =E2=80=98-Wduplicated-bra=
nches=E2=80=99<br>
&gt; gcc: error: unrecognized command line option =E2=80=98-Wrestrict=E2=80=
=99<br>
&gt; gcc: error: unrecognized command line option =E2=80=98-Wnull-dereferen=
ce=E2=80=99<br>
&gt; error: command &#39;gcc&#39; failed with exit status 1<br>
&gt; make[4]: *** [build-python-bindings.stamp] Error 1<br>
&gt; <br>
&gt; I am surprised that this is using &quot;gcc&quot; here, shouldn&#39;t =
it be using &quot;icc&quot; since I have CC=3Dicc?<br>
&gt; <br>
&gt; Or maybe it is supposed to be using gcc?=C2=A0 I think if I update the=
 GCC compiler version then it will get past this issue as well, but I just =
wanted confirmation that this indeed should be using a combination of gcc a=
nd icc?<br>
&gt; <br>
&gt; If it should be icc, can you point me to where in the configure/make s=
ystem I can make this change to force it to use what&#39;s sets as CC inste=
ad of defaulting to GCC?<br>
&gt; <br>
&gt; Rocky<br>
<br>
I&#39;ve hit this exact issue by trying to compile with CC=3Dclang.=C2=A0 T=
his is due to an<br>
oddity of distutils when it builds the native module, I don&#39;t really kn=
ow what to<br>
do about it.<br>
<br>
When it compiles native_bt.o, distutils uses the compiler specified in CC, =
which is<br>
what we want.=C2=A0 But when it links the shared object, it:<br>
<br>
=C2=A0 - uses the default system compiler (often gcc), and<br>
=C2=A0 - passes the flags specified in CFLAGS<br>
<br>
However, CFLAGS contains the warning flags that our configure script determ=
ined<br>
$CC accepts (note, that detection might not work well with icc, we haven&#3=
9;t tested).<br>
<br>
So we end up passing warning flags recognized by $CC (e.g. clang) to gcc, w=
hich makes<br>
gcc error out.<br>
<br>
distutils allows to override the command used to link shared libraries by s=
etting the<br>
LDSHARED variable.=C2=A0 So you could try to set LDSHARED to &quot;icc&quot=
; plus the right flags<br>
required to link a shared lib.=C2=A0 For reference, the default LDSHARED va=
lue for your Python<br>
installation can be checked with:<br>
<br>
=C2=A0 =C2=A0 $ python3 -c &#39;import sysconfig; print(sysconfig.get_confi=
g_var(&quot;LDSHARED&quot;))&#39;<br>
=C2=A0 =C2=A0 x86_64-linux-gnu-gcc -pthread -shared -Wl,-O1 -Wl,-Bsymbolic-=
functions -Wl,-Bsymbolic-functions -Wl,-z,relro<br>
<br>
But even worse, when building with CC=3Dclang on Arch Linux, I noticed that=
 distutils<br>
passes some gcc-specific flags (which don&#39;t come from us) when compilin=
g.=C2=A0 I&#39;m not<br>
sure what we&#39;re going to do about that.<br>
<br>
Simon<br>
</blockquote></div>

--000000000000cff05105a150dbdb--

--===============8169731497274000465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8169731497274000465==--
