From: Jan Glauber <jan.glauber@gmail.com>
Subject: Re: lttng-ust cross compile broken for demo-tracef
Date: Mon, 7 Apr 2014 16:29:48 +0200
Message-ID: <CAEiAFz3WC7tp4PRdOXE991reuNDm+qc86ughb8JrOw8R=whoKA__27695.9892515608$1396881068$gmane$org@mail.gmail.com>
References: <20140407114320.GA25948@hal>
 <CA+jJMxuPEipdetRy4ETyJ=LPARUOZq8a+dTKzP_esDS8zuonKQ@mail.gmail.com>
 <CAEiAFz2ugQhoA6RO7NbxAPNcii6tvc-qQoM9CaqDDW5LPSNT7w@mail.gmail.com>
 <CA+jJMxtjWp-a1smz_hwZEVL70HQ6pKj2JXKXnUgxzg3QVR0HKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0511638764=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1WXAYc-0008NS-9K
 for lttng-dev@lists.lttng.org; Mon, 07 Apr 2014 10:30:00 -0400
Received: by mail-qg0-f48.google.com with SMTP id i50so808341qgf.35
 for <lttng-dev@lists.lttng.org>; Mon, 07 Apr 2014 07:29:49 -0700 (PDT)
In-Reply-To: <CA+jJMxtjWp-a1smz_hwZEVL70HQ6pKj2JXKXnUgxzg3QVR0HKA@mail.gmail.com>
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

--===============0511638764==
Content-Type: multipart/alternative; boundary=001a11c1241e22dcc104f674b3c2

--001a11c1241e22dcc104f674b3c2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Yes:
$ which arm-linux-gnueabihf-gcc
/usr/bin/arm-linux-gnueabihf-gcc

IIRC the examples have not been build by default in the past, right?


2014-04-07 16:20 GMT+02:00 J=E9r=E9mie Galarneau <jeremie.galarneau@efficio=
s.com
>:

> On Mon, Apr 7, 2014 at 10:10 AM, Jan Glauber <jan.glauber@gmail.com>
> wrote:
> > Sure, it looks like there is a problem with python in lttng-get-tp:
> >
> > | make[4]: Entering directory
> >
> `/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/work/armv7ahf-vfp-n=
eon-elina-linux-gnueabi/lttng-ust-2.4-r0/git/doc/examples/gen-tp'
> > | ../../../tools/lttng-gen-tp -o sample_tracepoint.c
> sample_tracepoint.tp
> > |
> >
> CPPFLAGS=3D"-isystem/home/jang/temp/p4/JGlauber_hal_share/poky/../toolcha=
in//arm-linux-gnueabihf/include
> >
> -isystem/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//arm-linu=
x-gnueabihf/include
> > -I../../../include/ -I../../../include/" \
> > |       CFLAGS=3D"-Wall
> >
> -isystem/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//arm-linu=
x-gnueabihf/include
> > -O2 -pipe -g -feliminate-unused-debug-types -fno-omit-frame-pointer -Wa=
ll
> >
> -isystem/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//arm-linu=
x-gnueabihf/include
> > -O2 -pipe -g -feliminate-unused-debug-types -fno-omit-frame-pointer" \
> > |
> >
> LDFLAGS=3D"-L/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//arm=
-linux-gnueabihf/lib
> >
> -Wl,-rpath-link,/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//=
arm-linux-gnueabihf/lib
> > -Wl,-O1 -Wl,--hash-style=3Dgnu
> >
> -L/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//arm-linux-gnue=
abihf/lib
> >
> -Wl,-rpath-link,/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//=
arm-linux-gnueabihf/lib
> > -Wl,-O1 -Wl,--hash-style=3Dgnu -L../../../liblttng-ust/.libs/
> >
> -Wl,-rpath=3D"/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/work/a=
rmv7ahf-vfp-neon-elina-linux-gnueabi/lttng-ust-2.4-r0/git/doc/examples/../.=
./liblttng-ust/.libs/""
> > \
> > |       CC=3D"arm-linux-gnueabihf-gcc  -march=3Darmv7-a     -mthumb-int=
erwork
> > -mfloat-abi=3Dhard -mfpu=3Dneon -mtune=3Dcortex-a15
> >
> --sysroot=3D/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/sysroots=
/omap5"
> > \
> > |       ../../../tools/lttng-gen-tp -o sample_tracepoint.o
> > sample_tracepoint.tp
> > | Invalid CC environment variable
>
> Okay, this means that subprocess.call(cc, ...) (lttng-gen-tp:108)
> fails while trying to run your CC variable. Is arm-linux-gnueabihf-gcc
> in your PATH?
>
> J=E9r=E9mie
>
> > | Traceback (most recent call last):
> > |   File "../../../tools/lttng-gen-tp", line 315, in <module>
> > |     sys.exit(main())
> > |   File "../../../tools/lttng-gen-tp", line 309, in main
> > |     dotobj.write()
> > |   File "../../../tools/lttng-gen-tp", line 132, in write
> > |     raise RuntimeError("No C Compiler detected")
> > | RuntimeError: No C Compiler detected
> > | make[4]: *** [sample_tracepoint.o] Error 1
> > | rm sample_tracepoint.c
> > | make[4]: Leaving directory
> >
> `/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/work/armv7ahf-vfp-n=
eon-elina-linux-gnueabi/lttng-ust-2.4-r0/git/doc/examples/gen-tp'
> > | make[3]: *** [all-local] Error 1
> >
> > --Jan
> >
> >
> > 2014-04-07 15:57 GMT+02:00 J=E9r=E9mie Galarneau
> > <jeremie.galarneau@efficios.com>:
> >
> >> Hi Jan,
> >>
> >> Can you post the errors you get if you set the "CC=3Dgcc" line in
> >> demo-tracef/Makefile by
> >>
> >> ifdef AM_CC
> >>     CC =3D $(AM_CC)
> >> endif
> >>
> >> Regards,
> >> J=E9r=E9mie
> >>
> >> On Mon, Apr 7, 2014 at 7:43 AM, Jan Glauber <jan.glauber@gmail.com>
> wrote:
> >> > Hi list,
> >> >
> >> > I get a compile error with current git head of lttng-ust if I
> >> > cross-compile (bitbake):
> >> >
> >> > | make[4]: Entering directory
> >> >
> `/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/work/armv7ahf-vfp-n=
eon-elina-linux-gnueabi/lttng-ust-2.4-r0/git/doc/examples/demo-tracef'
> >> > | arm-linux-gnueabihf-gcc  -march=3Darmv7-a     -mthumb-interwork
> >> > -mfloat-abi=3Dhard -mfpu=3Dneon -mtune=3Dcortex-a15
> >> >
> --sysroot=3D/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/sysroots=
/omap5
> >> > -L/home/jang/te
> >> > |               -o demo-tracef demo-tracef.o -ldl -llttng-ust
> >> > | demo-tracef.o: file not recognized: File format not recognized
> >> > | collect2: error: ld returned 1 exit status
> >> > | make[4]: *** [demo-tracef] Error 1
> >> >
> >> > Looks like the demo-tracef Makefile sets CC hard to gcc. But if I fi=
x
> >> > this I get more
> >> > errors which I don't undertand. Am I the only one running into this?
> >> >
> >> > thx, Jan
> >> > ---
> >> > Harman Becker Automotive GmbH
> >> > System Profiling & Optimizing Team
> >> >
> >> > _______________________________________________
> >> > lttng-dev mailing list
> >> > lttng-dev@lists.lttng.org
> >> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>
> >>
> >>
> >> --
> >> J=E9r=E9mie Galarneau
> >> EfficiOS Inc.
> >> http://www.efficios.com
> >
> >
>
>
>
> --
> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>

--001a11c1241e22dcc104f674b3c2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Yes:<br>$ which arm-linux-gnueabihf-gcc<br>/usr/=
bin/arm-linux-gnueabihf-gcc<br><br></div>IIRC the examples have not been bu=
ild by default in the past, right?<br></div></div><div class=3D"gmail_extra=
">
<br><br><div class=3D"gmail_quote">2014-04-07 16:20 GMT+02:00 J=E9r=E9mie G=
alarneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@efficios=
.com" target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;</span>:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">On Mon, Apr 7, 2014 at 10:10 AM, Ja=
n Glauber &lt;<a href=3D"mailto:jan.glauber@gmail.com">jan.glauber@gmail.co=
m</a>&gt; wrote:<br>
&gt; Sure, it looks like there is a problem with python in lttng-get-tp:<br=
>
&gt;<br>
&gt; | make[4]: Entering directory<br>
&gt; `/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/work/armv7ahf-vf=
p-neon-elina-linux-gnueabi/lttng-ust-2.4-r0/git/doc/examples/gen-tp&#39;<br=
>
&gt; | ../../../tools/lttng-gen-tp -o sample_tracepoint.c <a href=3D"http:/=
/sample_tracepoint.tp" target=3D"_blank">sample_tracepoint.tp</a><br>
&gt; |<br>
&gt; CPPFLAGS=3D&quot;-isystem/home/jang/temp/p4/JGlauber_hal_share/poky/..=
/toolchain//arm-linux-gnueabihf/include<br>
&gt; -isystem/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//arm-l=
inux-gnueabihf/include<br>
&gt; -I../../../include/ -I../../../include/&quot; \<br>
&gt; | =A0 =A0 =A0 CFLAGS=3D&quot;-Wall<br>
&gt; -isystem/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//arm-l=
inux-gnueabihf/include<br>
&gt; -O2 -pipe -g -feliminate-unused-debug-types -fno-omit-frame-pointer -W=
all<br>
&gt; -isystem/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//arm-l=
inux-gnueabihf/include<br>
&gt; -O2 -pipe -g -feliminate-unused-debug-types -fno-omit-frame-pointer&qu=
ot; \<br>
&gt; |<br>
&gt; LDFLAGS=3D&quot;-L/home/jang/temp/p4/JGlauber_hal_share/poky/../toolch=
ain//arm-linux-gnueabihf/lib<br>
&gt; -Wl,-rpath-link,/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchai=
n//arm-linux-gnueabihf/lib<br>
&gt; -Wl,-O1 -Wl,--hash-style=3Dgnu<br>
&gt; -L/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//arm-linux-g=
nueabihf/lib<br>
&gt; -Wl,-rpath-link,/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchai=
n//arm-linux-gnueabihf/lib<br>
&gt; -Wl,-O1 -Wl,--hash-style=3Dgnu -L../../../liblttng-ust/.libs/<br>
&gt; -Wl,-rpath=3D&quot;/home/jang/temp/p4/JGlauber_hal_share/poky/build/tm=
p/work/armv7ahf-vfp-neon-elina-linux-gnueabi/lttng-ust-2.4-r0/git/doc/examp=
les/../../liblttng-ust/.libs/&quot;&quot;<br>
&gt; \<br>
&gt; | =A0 =A0 =A0 CC=3D&quot;arm-linux-gnueabihf-gcc =A0-march=3Darmv7-a =
=A0 =A0 -mthumb-interwork<br>
&gt; -mfloat-abi=3Dhard -mfpu=3Dneon -mtune=3Dcortex-a15<br>
&gt; --sysroot=3D/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/sysro=
ots/omap5&quot;<br>
&gt; \<br>
&gt; | =A0 =A0 =A0 ../../../tools/lttng-gen-tp -o sample_tracepoint.o<br>
&gt; <a href=3D"http://sample_tracepoint.tp" target=3D"_blank">sample_trace=
point.tp</a><br>
&gt; | Invalid CC environment variable<br>
<br>
</div></div>Okay, this means that subprocess.call(cc, ...) (lttng-gen-tp:10=
8)<br>
fails while trying to run your CC variable. Is arm-linux-gnueabihf-gcc<br>
in your PATH?<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
J=E9r=E9mie<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; | Traceback (most recent call last):<br>
&gt; | =A0 File &quot;../../../tools/lttng-gen-tp&quot;, line 315, in &lt;m=
odule&gt;<br>
&gt; | =A0 =A0 sys.exit(main())<br>
&gt; | =A0 File &quot;../../../tools/lttng-gen-tp&quot;, line 309, in main<=
br>
&gt; | =A0 =A0 dotobj.write()<br>
&gt; | =A0 File &quot;../../../tools/lttng-gen-tp&quot;, line 132, in write=
<br>
&gt; | =A0 =A0 raise RuntimeError(&quot;No C Compiler detected&quot;)<br>
&gt; | RuntimeError: No C Compiler detected<br>
&gt; | make[4]: *** [sample_tracepoint.o] Error 1<br>
&gt; | rm sample_tracepoint.c<br>
&gt; | make[4]: Leaving directory<br>
&gt; `/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/work/armv7ahf-vf=
p-neon-elina-linux-gnueabi/lttng-ust-2.4-r0/git/doc/examples/gen-tp&#39;<br=
>
&gt; | make[3]: *** [all-local] Error 1<br>
&gt;<br>
&gt; --Jan<br>
&gt;<br>
&gt;<br>
&gt; 2014-04-07 15:57 GMT+02:00 J=E9r=E9mie Galarneau<br>
&gt; &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com">jeremie.galarnea=
u@efficios.com</a>&gt;:<br>
&gt;<br>
&gt;&gt; Hi Jan,<br>
&gt;&gt;<br>
&gt;&gt; Can you post the errors you get if you set the &quot;CC=3Dgcc&quot=
; line in<br>
&gt;&gt; demo-tracef/Makefile by<br>
&gt;&gt;<br>
&gt;&gt; ifdef AM_CC<br>
&gt;&gt; =A0 =A0 CC =3D $(AM_CC)<br>
&gt;&gt; endif<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; J=E9r=E9mie<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Apr 7, 2014 at 7:43 AM, Jan Glauber &lt;<a href=3D"mailto:=
jan.glauber@gmail.com">jan.glauber@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt; Hi list,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I get a compile error with current git head of lttng-ust if I=
<br>
&gt;&gt; &gt; cross-compile (bitbake):<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; | make[4]: Entering directory<br>
&gt;&gt; &gt; `/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/work/ar=
mv7ahf-vfp-neon-elina-linux-gnueabi/lttng-ust-2.4-r0/git/doc/examples/demo-=
tracef&#39;<br>
&gt;&gt; &gt; | arm-linux-gnueabihf-gcc =A0-march=3Darmv7-a =A0 =A0 -mthumb=
-interwork<br>
&gt;&gt; &gt; -mfloat-abi=3Dhard -mfpu=3Dneon -mtune=3Dcortex-a15<br>
&gt;&gt; &gt; --sysroot=3D/home/jang/temp/p4/JGlauber_hal_share/poky/build/=
tmp/sysroots/omap5<br>
&gt;&gt; &gt; -L/home/jang/te<br>
&gt;&gt; &gt; | =A0 =A0 =A0 =A0 =A0 =A0 =A0 -o demo-tracef demo-tracef.o -l=
dl -llttng-ust<br>
&gt;&gt; &gt; | demo-tracef.o: file not recognized: File format not recogni=
zed<br>
&gt;&gt; &gt; | collect2: error: ld returned 1 exit status<br>
&gt;&gt; &gt; | make[4]: *** [demo-tracef] Error 1<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Looks like the demo-tracef Makefile sets CC hard to gcc. But =
if I fix<br>
&gt;&gt; &gt; this I get more<br>
&gt;&gt; &gt; errors which I don&#39;t undertand. Am I the only one running=
 into this?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; thx, Jan<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt; Harman Becker Automotive GmbH<br>
&gt;&gt; &gt; System Profiling &amp; Optimizing Team<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; _______________________________________________<br>
&gt;&gt; &gt; lttng-dev mailing list<br>
&gt;&gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.=
lttng.org</a><br>
&gt;&gt; &gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lt=
tng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/=
lttng-dev</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; J=E9r=E9mie Galarneau<br>
&gt;&gt; EfficiOS Inc.<br>
&gt;&gt; <a href=3D"http://www.efficios.com" target=3D"_blank">http://www.e=
fficios.com</a><br>
&gt;<br>
&gt;<br>
<br>
<br>
<br>
--<br>
J=E9r=E9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</div></div></blockquote></div><br></div>

--001a11c1241e22dcc104f674b3c2--


--===============0511638764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0511638764==--
