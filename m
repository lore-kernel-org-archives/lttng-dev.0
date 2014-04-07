From: Jan Glauber <jan.glauber@gmail.com>
Subject: Re: lttng-ust cross compile broken for demo-tracef
Date: Mon, 7 Apr 2014 16:10:38 +0200
Message-ID: <CAEiAFz2ugQhoA6RO7NbxAPNcii6tvc-qQoM9CaqDDW5LPSNT7w__25604.9600932331$1396879890$gmane$org@mail.gmail.com>
References: <20140407114320.GA25948@hal>
 <CA+jJMxuPEipdetRy4ETyJ=LPARUOZq8a+dTKzP_esDS8zuonKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1635628528=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1WXAG4-0008Ao-3K
 for lttng-dev@lists.lttng.org; Mon, 07 Apr 2014 10:10:47 -0400
Received: by mail-qg0-f44.google.com with SMTP id a108so6189034qge.17
 for <lttng-dev@lists.lttng.org>; Mon, 07 Apr 2014 07:10:38 -0700 (PDT)
In-Reply-To: <CA+jJMxuPEipdetRy4ETyJ=LPARUOZq8a+dTKzP_esDS8zuonKQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1635628528==
Content-Type: multipart/alternative; boundary=001a11c2d1c290dbd904f6746efe

--001a11c2d1c290dbd904f6746efe
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sure, it looks like there is a problem with python in lttng-get-tp:

| make[4]: Entering directory
`/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/work/armv7ahf-vfp-neo=
n-elina-linux-gnueabi/lttng-ust-2.4-r0/git/doc/examples/gen-tp'
| ../../../tools/lttng-gen-tp -o sample_tracepoint.c sample_tracepoint.tp
|
CPPFLAGS=3D"-isystem/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain=
//arm-linux-gnueabihf/include
-isystem/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//arm-linux-=
gnueabihf/include
-I../../../include/ -I../../../include/" \
|       CFLAGS=3D"-Wall
-isystem/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//arm-linux-=
gnueabihf/include
-O2 -pipe -g -feliminate-unused-debug-types -fno-omit-frame-pointer -Wall
-isystem/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//arm-linux-=
gnueabihf/include
-O2 -pipe -g -feliminate-unused-debug-types -fno-omit-frame-pointer" \
|
LDFLAGS=3D"-L/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//arm-l=
inux-gnueabihf/lib
-Wl,-rpath-link,/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//ar=
m-linux-gnueabihf/lib
-Wl,-O1 -Wl,--hash-style=3Dgnu
-L/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//arm-linux-gnueab=
ihf/lib
-Wl,-rpath-link,/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//ar=
m-linux-gnueabihf/lib
-Wl,-O1 -Wl,--hash-style=3Dgnu -L../../../liblttng-ust/.libs/
-Wl,-rpath=3D"/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/work/arm=
v7ahf-vfp-neon-elina-linux-gnueabi/lttng-ust-2.4-r0/git/doc/examples/../../=
liblttng-ust/.libs/""
\
|       CC=3D"arm-linux-gnueabihf-gcc  -march=3Darmv7-a     -mthumb-interwo=
rk
-mfloat-abi=3Dhard -mfpu=3Dneon -mtune=3Dcortex-a15
--sysroot=3D/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/sysroots/o=
map5"
\
|       ../../../tools/lttng-gen-tp -o sample_tracepoint.o
sample_tracepoint.tp
| Invalid CC environment variable
| Traceback (most recent call last):
|   File "../../../tools/lttng-gen-tp", line 315, in <module>
|     sys.exit(main())
|   File "../../../tools/lttng-gen-tp", line 309, in main
|     dotobj.write()
|   File "../../../tools/lttng-gen-tp", line 132, in write
|     raise RuntimeError("No C Compiler detected")
| RuntimeError: No C Compiler detected
| make[4]: *** [sample_tracepoint.o] Error 1
| rm sample_tracepoint.c
| make[4]: Leaving directory
`/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/work/armv7ahf-vfp-neo=
n-elina-linux-gnueabi/lttng-ust-2.4-r0/git/doc/examples/gen-tp'
| make[3]: *** [all-local] Error 1

--Jan


2014-04-07 15:57 GMT+02:00 J=E9r=E9mie Galarneau <jeremie.galarneau@efficio=
s.com
>:

> Hi Jan,
>
> Can you post the errors you get if you set the "CC=3Dgcc" line in
> demo-tracef/Makefile by
>
> ifdef AM_CC
>     CC =3D $(AM_CC)
> endif
>
> Regards,
> J=E9r=E9mie
>
> On Mon, Apr 7, 2014 at 7:43 AM, Jan Glauber <jan.glauber@gmail.com> wrote=
:
> > Hi list,
> >
> > I get a compile error with current git head of lttng-ust if I
> cross-compile (bitbake):
> >
> > | make[4]: Entering directory
> `/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/work/armv7ahf-vfp-n=
eon-elina-linux-gnueabi/lttng-ust-2.4-r0/git/doc/examples/demo-tracef'
> > | arm-linux-gnueabihf-gcc  -march=3Darmv7-a     -mthumb-interwork
> -mfloat-abi=3Dhard -mfpu=3Dneon -mtune=3Dcortex-a15
> --sysroot=3D/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/sysroots=
/omap5
> -L/home/jang/te
> > |               -o demo-tracef demo-tracef.o -ldl -llttng-ust
> > | demo-tracef.o: file not recognized: File format not recognized
> > | collect2: error: ld returned 1 exit status
> > | make[4]: *** [demo-tracef] Error 1
> >
> > Looks like the demo-tracef Makefile sets CC hard to gcc. But if I fix
> this I get more
> > errors which I don't undertand. Am I the only one running into this?
> >
> > thx, Jan
> > ---
> > Harman Becker Automotive GmbH
> > System Profiling & Optimizing Team
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
> --
> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>

--001a11c2d1c290dbd904f6746efe
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Sure, it looks like there is a problem with python in=
 lttng-get-tp:<br><br>| make[4]: Entering directory `/home/jang/temp/p4/JGl=
auber_hal_share/poky/build/tmp/work/armv7ahf-vfp-neon-elina-linux-gnueabi/l=
ttng-ust-2.4-r0/git/doc/examples/gen-tp&#39;<br>
| ../../../tools/lttng-gen-tp -o sample_tracepoint.c <a href=3D"http://samp=
le_tracepoint.tp">sample_tracepoint.tp</a><br>| CPPFLAGS=3D&quot;-isystem/h=
ome/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//arm-linux-gnueabihf/=
include -isystem/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//ar=
m-linux-gnueabihf/include -I../../../include/ -I../../../include/&quot; \<b=
r>
|=A0=A0=A0=A0=A0=A0 CFLAGS=3D&quot;-Wall -isystem/home/jang/temp/p4/JGlaube=
r_hal_share/poky/../toolchain//arm-linux-gnueabihf/include=A0 -O2 -pipe -g =
-feliminate-unused-debug-types -fno-omit-frame-pointer -Wall -isystem/home/=
jang/temp/p4/JGlauber_hal_share/poky/../toolchain//arm-linux-gnueabihf/incl=
ude=A0 -O2 -pipe -g -feliminate-unused-debug-types -fno-omit-frame-pointer&=
quot; \<br>
|=A0=A0=A0=A0=A0=A0 LDFLAGS=3D&quot;-L/home/jang/temp/p4/JGlauber_hal_share=
/poky/../toolchain//arm-linux-gnueabihf/lib -Wl,-rpath-link,/home/jang/temp=
/p4/JGlauber_hal_share/poky/../toolchain//arm-linux-gnueabihf/lib -Wl,-O1 -=
Wl,--hash-style=3Dgnu -L/home/jang/temp/p4/JGlauber_hal_share/poky/../toolc=
hain//arm-linux-gnueabihf/lib -Wl,-rpath-link,/home/jang/temp/p4/JGlauber_h=
al_share/poky/../toolchain//arm-linux-gnueabihf/lib -Wl,-O1 -Wl,--hash-styl=
e=3Dgnu -L../../../liblttng-ust/.libs/ -Wl,-rpath=3D&quot;/home/jang/temp/p=
4/JGlauber_hal_share/poky/build/tmp/work/armv7ahf-vfp-neon-elina-linux-gnue=
abi/lttng-ust-2.4-r0/git/doc/examples/../../liblttng-ust/.libs/&quot;&quot;=
 \<br>
|=A0=A0=A0=A0=A0=A0 CC=3D&quot;arm-linux-gnueabihf-gcc=A0 -march=3Darmv7-a=
=A0=A0=A0=A0 -mthumb-interwork -mfloat-abi=3Dhard -mfpu=3Dneon -mtune=3Dcor=
tex-a15 --sysroot=3D/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/sy=
sroots/omap5&quot; \<br>|=A0=A0=A0=A0=A0=A0 ../../../tools/lttng-gen-tp -o =
sample_tracepoint.o <a href=3D"http://sample_tracepoint.tp">sample_tracepoi=
nt.tp</a><br>
| Invalid CC environment variable<br>| Traceback (most recent call last):<b=
r>|=A0=A0 File &quot;../../../tools/lttng-gen-tp&quot;, line 315, in &lt;mo=
dule&gt;<br>|=A0=A0=A0=A0 sys.exit(main())<br>|=A0=A0 File &quot;../../../t=
ools/lttng-gen-tp&quot;, line 309, in main<br>
|=A0=A0=A0=A0 dotobj.write()<br>|=A0=A0 File &quot;../../../tools/lttng-gen=
-tp&quot;, line 132, in write<br>|=A0=A0=A0=A0 raise RuntimeError(&quot;No =
C Compiler detected&quot;)<br>| RuntimeError: No C Compiler detected<br>| m=
ake[4]: *** [sample_tracepoint.o] Error 1<br>
| rm sample_tracepoint.c<br>| make[4]: Leaving directory `/home/jang/temp/p=
4/JGlauber_hal_share/poky/build/tmp/work/armv7ahf-vfp-neon-elina-linux-gnue=
abi/lttng-ust-2.4-r0/git/doc/examples/gen-tp&#39;<br>| make[3]: *** [all-lo=
cal] Error 1<br>
<br></div>--Jan<br></div><div class=3D"gmail_extra"><br><br><div class=3D"g=
mail_quote">2014-04-07 15:57 GMT+02:00 J=E9r=E9mie Galarneau <span dir=3D"l=
tr">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank"=
>jeremie.galarneau@efficios.com</a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Jan,<br>
<br>
Can you post the errors you get if you set the &quot;CC=3Dgcc&quot; line in=
<br>
demo-tracef/Makefile by<br>
<br>
ifdef AM_CC<br>
=A0 =A0 CC =3D $(AM_CC)<br>
endif<br>
<br>
Regards,<br>
J=E9r=E9mie<br>
<div><div class=3D"h5"><br>
On Mon, Apr 7, 2014 at 7:43 AM, Jan Glauber &lt;<a href=3D"mailto:jan.glaub=
er@gmail.com">jan.glauber@gmail.com</a>&gt; wrote:<br>
&gt; Hi list,<br>
&gt;<br>
&gt; I get a compile error with current git head of lttng-ust if I cross-co=
mpile (bitbake):<br>
&gt;<br>
&gt; | make[4]: Entering directory `/home/jang/temp/p4/JGlauber_hal_share/p=
oky/build/tmp/work/armv7ahf-vfp-neon-elina-linux-gnueabi/lttng-ust-2.4-r0/g=
it/doc/examples/demo-tracef&#39;<br>
&gt; | arm-linux-gnueabihf-gcc =A0-march=3Darmv7-a =A0 =A0 -mthumb-interwor=
k -mfloat-abi=3Dhard -mfpu=3Dneon -mtune=3Dcortex-a15 --sysroot=3D/home/jan=
g/temp/p4/JGlauber_hal_share/poky/build/tmp/sysroots/omap5 -L/home/jang/te<=
br>
&gt; | =A0 =A0 =A0 =A0 =A0 =A0 =A0 -o demo-tracef demo-tracef.o -ldl -llttn=
g-ust<br>
&gt; | demo-tracef.o: file not recognized: File format not recognized<br>
&gt; | collect2: error: ld returned 1 exit status<br>
&gt; | make[4]: *** [demo-tracef] Error 1<br>
&gt;<br>
&gt; Looks like the demo-tracef Makefile sets CC hard to gcc. But if I fix =
this I get more<br>
&gt; errors which I don&#39;t undertand. Am I the only one running into thi=
s?<br>
&gt;<br>
&gt; thx, Jan<br>
&gt; ---<br>
&gt; Harman Becker Automotive GmbH<br>
&gt; System Profiling &amp; Optimizing Team<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
<br>
--<br>
J=E9r=E9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</font></span></blockquote></div><br></div>

--001a11c2d1c290dbd904f6746efe--


--===============1635628528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1635628528==--
