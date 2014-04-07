From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: lttng-ust cross compile broken for demo-tracef
Date: Mon, 7 Apr 2014 12:32:18 -0400
Message-ID: <CA+jJMxuaxABSCf7iWJNS2==B8nQAB8VSPhRSojMeSEesWzx0xA__26078.7377287217$1396888400$gmane$org@mail.gmail.com>
References: <20140407114320.GA25948@hal>
 <CA+jJMxuPEipdetRy4ETyJ=LPARUOZq8a+dTKzP_esDS8zuonKQ@mail.gmail.com>
 <CAEiAFz2ugQhoA6RO7NbxAPNcii6tvc-qQoM9CaqDDW5LPSNT7w@mail.gmail.com>
 <CA+jJMxtjWp-a1smz_hwZEVL70HQ6pKj2JXKXnUgxzg3QVR0HKA@mail.gmail.com>
 <CAEiAFz3WC7tp4PRdOXE991reuNDm+qc86ughb8JrOw8R=whoKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WXCT9-0000vT-MI
 for lttng-dev@lists.lttng.org; Mon, 07 Apr 2014 12:32:29 -0400
Received: by mail-qg0-f46.google.com with SMTP id j107so1624824qga.5
 for <lttng-dev@lists.lttng.org>; Mon, 07 Apr 2014 09:32:18 -0700 (PDT)
In-Reply-To: <CAEiAFz3WC7tp4PRdOXE991reuNDm+qc86ughb8JrOw8R=whoKA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jan Glauber <jan.glauber@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Mon, Apr 7, 2014 at 10:29 AM, Jan Glauber <jan.glauber@gmail.com> wrote:
> Yes:
> $ which arm-linux-gnueabihf-gcc
> /usr/bin/arm-linux-gnueabihf-gcc
>
> IIRC the examples have not been build by default in the past, right?

They have been for around a year. I think I found the issue:
lttng-gen-tp doesn't expect the CC variable to contain command line
arguments.

Can you apply and test the following diff?

diff --git a/tools/lttng-gen-tp b/tools/lttng-gen-tp
index a3a01f2..b62cd99 100755
--- a/tools/lttng-gen-tp
+++ b/tools/lttng-gen-tp
@@ -94,7 +94,7 @@ class ObjFile:
         if 'CC' in os.environ:
             cc =3D os.environ['CC']
             try:
-                subprocess.call(cc,
+                subprocess.call(cc.split(),
                                 stdout=3Dsubprocess.PIPE,
                                 stderr=3Dsubprocess.PIPE)
             except OSError as msg:


Thanks,
J=E9r=E9mie

>
>
> 2014-04-07 16:20 GMT+02:00 J=E9r=E9mie Galarneau
> <jeremie.galarneau@efficios.com>:
>
>> On Mon, Apr 7, 2014 at 10:10 AM, Jan Glauber <jan.glauber@gmail.com>
>> wrote:
>> > Sure, it looks like there is a problem with python in lttng-get-tp:
>> >
>> > | make[4]: Entering directory
>> >
>> > `/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/work/armv7ahf-vf=
p-neon-elina-linux-gnueabi/lttng-ust-2.4-r0/git/doc/examples/gen-tp'
>> > | ../../../tools/lttng-gen-tp -o sample_tracepoint.c
>> > sample_tracepoint.tp
>> > |
>> >
>> > CPPFLAGS=3D"-isystem/home/jang/temp/p4/JGlauber_hal_share/poky/../tool=
chain//arm-linux-gnueabihf/include
>> >
>> > -isystem/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//arm-l=
inux-gnueabihf/include
>> > -I../../../include/ -I../../../include/" \
>> > |       CFLAGS=3D"-Wall
>> >
>> > -isystem/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//arm-l=
inux-gnueabihf/include
>> > -O2 -pipe -g -feliminate-unused-debug-types -fno-omit-frame-pointer
>> > -Wall
>> >
>> > -isystem/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//arm-l=
inux-gnueabihf/include
>> > -O2 -pipe -g -feliminate-unused-debug-types -fno-omit-frame-pointer" \
>> > |
>> >
>> > LDFLAGS=3D"-L/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//=
arm-linux-gnueabihf/lib
>> >
>> > -Wl,-rpath-link,/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchai=
n//arm-linux-gnueabihf/lib
>> > -Wl,-O1 -Wl,--hash-style=3Dgnu
>> >
>> > -L/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchain//arm-linux-g=
nueabihf/lib
>> >
>> > -Wl,-rpath-link,/home/jang/temp/p4/JGlauber_hal_share/poky/../toolchai=
n//arm-linux-gnueabihf/lib
>> > -Wl,-O1 -Wl,--hash-style=3Dgnu -L../../../liblttng-ust/.libs/
>> >
>> > -Wl,-rpath=3D"/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/wor=
k/armv7ahf-vfp-neon-elina-linux-gnueabi/lttng-ust-2.4-r0/git/doc/examples/.=
./../liblttng-ust/.libs/""
>> > \
>> > |       CC=3D"arm-linux-gnueabihf-gcc  -march=3Darmv7-a
>> > -mthumb-interwork
>> > -mfloat-abi=3Dhard -mfpu=3Dneon -mtune=3Dcortex-a15
>> >
>> > --sysroot=3D/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/sysro=
ots/omap5"
>> > \
>> > |       ../../../tools/lttng-gen-tp -o sample_tracepoint.o
>> > sample_tracepoint.tp
>> > | Invalid CC environment variable
>>
>> Okay, this means that subprocess.call(cc, ...) (lttng-gen-tp:108)
>> fails while trying to run your CC variable. Is arm-linux-gnueabihf-gcc
>> in your PATH?
>>
>> J=E9r=E9mie
>>
>> > | Traceback (most recent call last):
>> > |   File "../../../tools/lttng-gen-tp", line 315, in <module>
>> > |     sys.exit(main())
>> > |   File "../../../tools/lttng-gen-tp", line 309, in main
>> > |     dotobj.write()
>> > |   File "../../../tools/lttng-gen-tp", line 132, in write
>> > |     raise RuntimeError("No C Compiler detected")
>> > | RuntimeError: No C Compiler detected
>> > | make[4]: *** [sample_tracepoint.o] Error 1
>> > | rm sample_tracepoint.c
>> > | make[4]: Leaving directory
>> >
>> > `/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/work/armv7ahf-vf=
p-neon-elina-linux-gnueabi/lttng-ust-2.4-r0/git/doc/examples/gen-tp'
>> > | make[3]: *** [all-local] Error 1
>> >
>> > --Jan
>> >
>> >
>> > 2014-04-07 15:57 GMT+02:00 J=E9r=E9mie Galarneau
>> > <jeremie.galarneau@efficios.com>:
>> >
>> >> Hi Jan,
>> >>
>> >> Can you post the errors you get if you set the "CC=3Dgcc" line in
>> >> demo-tracef/Makefile by
>> >>
>> >> ifdef AM_CC
>> >>     CC =3D $(AM_CC)
>> >> endif
>> >>
>> >> Regards,
>> >> J=E9r=E9mie
>> >>
>> >> On Mon, Apr 7, 2014 at 7:43 AM, Jan Glauber <jan.glauber@gmail.com>
>> >> wrote:
>> >> > Hi list,
>> >> >
>> >> > I get a compile error with current git head of lttng-ust if I
>> >> > cross-compile (bitbake):
>> >> >
>> >> > | make[4]: Entering directory
>> >> >
>> >> > `/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/work/armv7ahf=
-vfp-neon-elina-linux-gnueabi/lttng-ust-2.4-r0/git/doc/examples/demo-tracef'
>> >> > | arm-linux-gnueabihf-gcc  -march=3Darmv7-a     -mthumb-interwork
>> >> > -mfloat-abi=3Dhard -mfpu=3Dneon -mtune=3Dcortex-a15
>> >> >
>> >> > --sysroot=3D/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/sy=
sroots/omap5
>> >> > -L/home/jang/te
>> >> > |               -o demo-tracef demo-tracef.o -ldl -llttng-ust
>> >> > | demo-tracef.o: file not recognized: File format not recognized
>> >> > | collect2: error: ld returned 1 exit status
>> >> > | make[4]: *** [demo-tracef] Error 1
>> >> >
>> >> > Looks like the demo-tracef Makefile sets CC hard to gcc. But if I f=
ix
>> >> > this I get more
>> >> > errors which I don't undertand. Am I the only one running into this?
>> >> >
>> >> > thx, Jan
>> >> > ---
>> >> > Harman Becker Automotive GmbH
>> >> > System Profiling & Optimizing Team
>> >> >
>> >> > _______________________________________________
>> >> > lttng-dev mailing list
>> >> > lttng-dev@lists.lttng.org
>> >> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> >>
>> >>
>> >>
>> >> --
>> >> J=E9r=E9mie Galarneau
>> >> EfficiOS Inc.
>> >> http://www.efficios.com
>> >
>> >
>>
>>
>>
>> --
>> J=E9r=E9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
