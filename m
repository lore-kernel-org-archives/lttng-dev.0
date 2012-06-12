From: "Burton, Michael" <mburton@ciena.com>
Subject: Re: UST Hanging at Tracepoint
Date: Tue, 12 Jun 2012 14:24:37 -0400
Message-ID: <3F56B905CF2083408E8482044F20428AEF7A0CE0__18516.7490192272$1339525577$gmane$org@ONWVEXCHMB01.ciena.com>
References: <3F56B905CF2083408E8482044F20428AEF604D22@ONWVEXCHMB01.ciena.com>
	<3F56B905CF2083408E8482044F20428AEF78BC79@ONWVEXCHMB01.ciena.com>
	<20120612140925.GB13917@Krystal> <20120612141344.GC13917@Krystal>
	<3F56B905CF2083408E8482044F20428AEF7A0AFE@ONWVEXCHMB01.ciena.com>
	<3F56B905CF2083408E8482044F20428AEF7A0B4C@ONWVEXCHMB01.ciena.com>
	<20120612162526.GB16098@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_3F56B905CF2083408E8482044F20428AEF7A0CE0ONWVEXCHMB01cie_"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0a-00103a01.pphosted.com ([67.231.144.234])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=15104ec490=mburton@ciena.com>)
	id 1SeVmm-0003cK-QV
	for lttng-dev@lists.lttng.org; Tue, 12 Jun 2012 14:25:49 -0400
In-Reply-To: <20120612162526.GB16098@Krystal>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "dgoulet@efficios.com" <dgoulet@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--_002_3F56B905CF2083408E8482044F20428AEF7A0CE0ONWVEXCHMB01cie_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I've attached the full bt.

Michael

-----Original Message-----
From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]
Sent: Tuesday, June 12, 2012 12:25 PM
To: Burton, Michael
Cc: dgoulet@efficios.com; lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] UST Hanging at Tracepoint

Please build you app and lttng-ust with:

make CFLAGS=3D-g   (so with -O0 optimisation, and debug info)

then, under gdb, please provide the full backtrace of each thread when
stucked with:

thread apply all bt full

Thanks,

Mathieu


* Burton, Michael (mburton@ciena.com) wrote:
> Also, I stepped through the code with gdb and things hang within the UST =
constructors and the main function of my application is never reached.
>
> -----Original Message-----
> From: Burton, Michael [mailto:mburton@ciena.com]
> Sent: Tuesday, June 12, 2012 11:45 AM
> To: Mathieu Desnoyers; dgoulet@efficios.com
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] UST Hanging at Tracepoint
>
> I put a fprintf at the beginning of main() and it never prints.
>
> -----Original Message-----
> From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]
> Sent: Tuesday, June 12, 2012 10:14 AM
> To: Burton, Michael; dgoulet@efficios.com
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] UST Hanging at Tracepoint
>
> * Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> > Hi Michael,
> >
> > Please note that you should be able to run UST with either (or both) of=
:
> >
> > - root lttng-sessiond, for system-wide tracing
> > - per-user lttng-sessiond, for per-user tracing.
> >
> > It is entirely normal that one of the two UST threads within the
> > application can't find an active sessiond if, for instance, you have
> > just a root (and no per-user) sessiond running.
> >
> > So although I'm glad that you got things working, I fail to understand
> > your explanation: it should have worked fine with the root sessiond,
> > even if no ~/.lttng exists.
> >
> > David, can you look into this ?
>
> hrm, further insight: is your program _really_ hang ? Try to make sure
> you put a fprintf(stderr, ".....") at the beginning of your main().
> Looking once more at your detailed UST output indicates that the
> per-user UST thread tells you that it cannot see any running sessiond.
> So yes, this thread blocks, but the thread talking to the root sessiond
> can very well be working fine, and your application might also be
> running fine. This should be double-checked.
>
> Thanks,
>
> Mathieu
>
> >
> > Thanks,
> >
> > Mathieu
> >
> > * Burton, Michael (mburton@ciena.com) wrote:
> > > Mathieu,
> > >
> > > I figured out the problem.  When we start sessiond on our system as r=
oot, the /.lttng/ folder is not created, along with its contents.  UST time=
d out since there was no sock_path.  I was able to get UST working once I g=
ot sessiond running.
> > >
> > > Thanks.
> > > Michael
> > >
> > > ________________________________________
> > > From: Mathieu Desnoyers [mathieu.desnoyers@efficios.com]
> > > Sent: 08 June 2012 21:38
> > > To: Burton, Michael
> > > Cc: lttng-dev@lists.lttng.org
> > > Subject: Re: [lttng-dev] UST Hanging at Tracepoint
> > >
> > > * Burton, Michael (mburton@ciena.com) wrote:
> > > > For further insight, I've attached the strace from the hanging
> > > > program.  I also upgraded LTTng-UST to 2.0.3 and userspace-rcu to
> > > > 0.7.3.
> > >
> > > Haven't had time to look at it yet, but could you also provide the
> > > output of:
> > >
> > > LTTNG_UST_DEBUG=3D1 youprogname
> > >
> > > (starting your UST instrumented program with LTTNG_UST_DEBUG=3D1 env.=
 var.
> > > set)
> > >
> > > Thanks!
> > >
> > > Mathieu
> > >
> > > >
> > > > Michael
> > > >
> > > > From: Burton, Michael [mailto:mburton@ciena.com]
> > > > Sent: Thursday, June 07, 2012 2:16 PM
> > > > To: lttng-dev@lists.lttng.org
> > > > Subject: [lttng-dev] UST Hanging at Tracepoint
> > > >
> > > > I am working on getting LTTng 2.0 working in our 2.6.35 kernel.  I =
have kernel tracing working but I'm having problems with UST.
> > > >
> > > > I have a program with a dynamic UST tracepoint.  When I run the pro=
gram with all UST events enabled (lttng enable-event -a -u) the program han=
gs on the tracepoint.  The last line from the UST debug is:
> > > >
> > > > libust[6184/6185]: Info: sessiond not accepting connections to loca=
l apps socket (in ust_listener_thread() at lttng-ust-comm.c:699)
> > > >
> > > > Any insight into why this is happening?  I've attached the UST and =
lttng-sessiond debug generated by the program.
> > > >
> > > > I am running the following:
> > > > lttng-modules-2.6.32 (found through this mailing list)
> > > > lttng-tools-2.0.1
> > > > lttng-ust-2.0.2
> > > > userspace-rcu-0.7.0
> > > >
> > > > Thanks,
> > > > Michael
> > >
> > > Content-Description: strace_debug.txt
> > > > execve("/ciena/bin/idp", ["idp", "help"], [/* 11 vars */]) =3D 0
> > > > brk(0)                                  =3D 0x804e000
> > > > mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, =
-1, 0) =3D 0xb783c000
> > > > access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file=
 or directory)
> > > > open("/etc/ld.so.cache", O_RDONLY)      =3D 3
> > > > fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D17420, ...}) =3D 0
> > > > mmap2(NULL, 17420, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0xb7837000
> > > > close(3)                                =3D 0
> > > > open("/usr/lib/liblttng-ust.so.0", O_RDONLY) =3D 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220A\0\000=
4\0\0\0$"..., 512) =3D 512
> > > > fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D209876, ...}) =3D 0
> > > > mmap2(NULL, 212940, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,=
 3, 0) =3D 0xb7803000
> > > > mmap2(0xb7832000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXE=
D|MAP_DENYWRITE, 3, 0x2e) =3D 0xb7832000
> > > > close(3)                                =3D 0
> > > > open("/usr/lib/liblttng-ust-ctl.so.0", O_RDONLY) =3D 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200-\0\000=
4\0\0\0\274"..., 512) =3D 512
> > > > fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D140020, ...}) =3D 0
> > > > mmap2(NULL, 142828, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,=
 3, 0) =3D 0xb77e0000
> > > > mmap2(0xb7802000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED=
|MAP_DENYWRITE, 3, 0x21) =3D 0xb7802000
> > > > close(3)                                =3D 0
> > > > open("/usr/lib/liblttng-ust-fork.so.0", O_RDONLY) =3D 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\5\0\0004=
\0\0\0X"..., 512) =3D 512
> > > > fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D3864, ...}) =3D 0
> > > > mmap2(NULL, 6820, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3=
, 0) =3D 0xb77de000
> > > > mmap2(0xb77df000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED=
|MAP_DENYWRITE, 3, 0) =3D 0xb77df000
> > > > close(3)                                =3D 0
> > > > open("/usr/lib/liblttng-ust-tracepoint.so.0", O_RDONLY) =3D 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\v\0\00=
04\0\0\0008"..., 512) =3D 512
> > > > fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D16632, ...}) =3D 0
> > > > mmap2(NULL, 19944, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, =
3, 0) =3D 0xb77d9000
> > > > mmap2(0xb77dd000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED=
|MAP_DENYWRITE, 3, 0x3) =3D 0xb77dd000
> > > > close(3)                                =3D 0
> > > > open("/usr/lib/liblttng-ust-libc-wrapper.so.0", O_RDONLY) =3D 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\t\0\00=
04\0\0\0\364"..., 512) =3D 512
> > > > fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D9300, ...}) =3D 0
> > > > mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, =
-1, 0) =3D 0xb77d8000
> > > > mmap2(NULL, 12104, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, =
3, 0) =3D 0xb77d5000
> > > > mmap2(0xb77d7000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED=
|MAP_DENYWRITE, 3, 0x1) =3D 0xb77d7000
> > > > close(3)                                =3D 0
> > > > open("/usr/lib/liburcu.so.1", O_RDONLY) =3D 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\22\0\0004=
\0\0\0\374"..., 512) =3D 512
> > > > fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D18188, ...}) =3D 0
> > > > mmap2(NULL, 17080, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, =
3, 0) =3D 0xb77d0000
> > > > mmap2(0xb77d4000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED=
|MAP_DENYWRITE, 3, 0x4) =3D 0xb77d4000
> > > > close(3)                                =3D 0
> > > > open("/usr/lib/liburcu-common.so.1", O_RDONLY) =3D 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\5\0\00=
04\0\0\0\34"..., 512) =3D 512
> > > > fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D5084, ...}) =3D 0
> > > > mmap2(NULL, 8032, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3=
, 0) =3D 0xb77ce000
> > > > mmap2(0xb77cf000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED=
|MAP_DENYWRITE, 3, 0) =3D 0xb77cf000
> > > > close(3)                                =3D 0
> > > > open("/usr/lib/liburcu-qsbr.so.1", O_RDONLY) =3D 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\22\0\0=
004\0\0\0\374"..., 512) =3D 512
> > > > fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D18188, ...}) =3D 0
> > > > mmap2(NULL, 17080, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, =
3, 0) =3D 0xb77c9000
> > > > mmap2(0xb77cd000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED=
|MAP_DENYWRITE, 3, 0x4) =3D 0xb77cd000
> > > > close(3)                                =3D 0
> > > > open("/usr/lib/liburcu-mb.so.1", O_RDONLY) =3D 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\22\0\0004=
\0\0\0\374"..., 512) =3D 512
> > > > fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D18188, ...}) =3D 0
> > > > mmap2(NULL, 17080, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, =
3, 0) =3D 0xb77c4000
> > > > mmap2(0xb77c8000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED=
|MAP_DENYWRITE, 3, 0x4) =3D 0xb77c8000
> > > > close(3)                                =3D 0
> > > > open("/usr/lib/liburcu-signal.so.1", O_RDONLY) =3D 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\23\0\0004=
\0\0\0\10"..., 512) =3D 512
> > > > fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D18712, ...}) =3D 0
> > > > mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, =
-1, 0) =3D 0xb77c3000
> > > > mmap2(NULL, 21704, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, =
3, 0) =3D 0xb77bd000
> > > > mmap2(0xb77c2000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED=
|MAP_DENYWRITE, 3, 0x4) =3D 0xb77c2000
> > > > close(3)                                =3D 0
> > > > open("/usr/lib/liburcu-cds.so.1", O_RDONLY) =3D 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\f\0\00=
04\0\0\0t"..., 512) =3D 512
> > > > fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D26204, ...}) =3D 0
> > > > mmap2(NULL, 25004, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, =
3, 0) =3D 0xb77b6000
> > > > mmap2(0xb77bc000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED=
|MAP_DENYWRITE, 3, 0x6) =3D 0xb77bc000
> > > > close(3)                                =3D 0
> > > > open("/usr/lib/liburcu-bp.so.1", O_RDONLY) =3D 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320\24\0\0=
004\0\0\0\360"..., 512) =3D 512
> > > > fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D19968, ...}) =3D 0
> > > > mmap2(NULL, 23128, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, =
3, 0) =3D 0xb77b0000
> > > > mmap2(0xb77b5000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED=
|MAP_DENYWRITE, 3, 0x4) =3D 0xb77b5000
> > > > close(3)                                =3D 0
> > > > open("/lib/libdl.so.2", O_RDONLY)       =3D 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \n\0\0004\=
0\0\0<"..., 512) =3D 512
> > > > fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D9668, ...}) =3D 0
> > > > mmap2(NULL, 12408, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, =
3, 0) =3D 0xb77ac000
> > > > mmap2(0xb77ae000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED=
|MAP_DENYWRITE, 3, 0x1) =3D 0xb77ae000
> > > > close(3)                                =3D 0
> > > > open("/lib/libuuid.so.1", O_RDONLY)     =3D 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\r\0\0004\=
0\0\0\350"..., 512) =3D 512
> > > > fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D12872, ...}) =3D 0
> > > > mmap2(NULL, 15632, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, =
3, 0) =3D 0xb77a8000
> > > > mmap2(0xb77ab000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED=
|MAP_DENYWRITE, 3, 0x2) =3D 0xb77ab000
> > > > close(3)                                =3D 0
> > > > open("/lib/libc.so.6", O_RDONLY)        =3D 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220n\1\000=
4\0\0\0L"..., 512) =3D 512
> > > > fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D1347780, ...}) =3D 0
> > > > mmap2(NULL, 1358120, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE=
, 3, 0) =3D 0xb765c000
> > > > mprotect(0xb77a1000, 4096, PROT_NONE)   =3D 0
> > > > mmap2(0xb77a2000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXE=
D|MAP_DENYWRITE, 3, 0x145) =3D 0xb77a2000
> > > > mmap2(0xb77a5000, 10536, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS, -1, 0) =3D 0xb77a5000
> > > > close(3)                                =3D 0
> > > > open("/lib/librt.so.1", O_RDONLY)       =3D 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\30\0\0004=
\0\0\0\230"..., 512) =3D 512
> > > > mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, =
-1, 0) =3D 0xb765b000
> > > > fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D30616, ...}) =3D 0
> > > > mmap2(NULL, 33364, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, =
3, 0) =3D 0xb7652000
> > > > mmap2(0xb7659000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED=
|MAP_DENYWRITE, 3, 0x6) =3D 0xb7659000
> > > > close(3)                                =3D 0
> > > > open("/lib/libpthread.so.0", O_RDONLY)  =3D 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360J\0\000=
4\0\0\0\354"..., 512) =3D 512
> > > > fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D88420, ...}) =3D 0
> > > > mmap2(NULL, 98828, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, =
3, 0) =3D 0xb7639000
> > > > mmap2(0xb764e000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED=
|MAP_DENYWRITE, 3, 0x14) =3D 0xb764e000
> > > > mmap2(0xb7650000, 4620, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED=
|MAP_ANONYMOUS, -1, 0) =3D 0xb7650000
> > > > close(3)                                =3D 0
> > > > mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, =
-1, 0) =3D 0xb7638000
> > > > mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, =
-1, 0) =3D 0xb7636000
> > > > set_thread_area({entry_number:-1 -> 6, base_addr:0xb7636d80, limit:=
1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_n=
ot_present:0, useable:1}) =3D 0
> > > > mprotect(0xb764e000, 4096, PROT_READ)   =3D 0
> > > > mprotect(0xb7659000, 4096, PROT_READ)   =3D 0
> > > > mprotect(0xb77a2000, 8192, PROT_READ)   =3D 0
> > > > mprotect(0xb77ae000, 4096, PROT_READ)   =3D 0
> > > > mprotect(0xb785a000, 4096, PROT_READ)   =3D 0
> > > > munmap(0xb7837000, 17420)               =3D 0
> > > > set_tid_address(0xb7636de8)             =3D 3050
> > > > set_robust_list(0xb7636df0, 0xc)        =3D 0
> > > > futex(0xbfaaf560, FUTEX_WAKE_PRIVATE, 1) =3D 0
> > > > futex(0xbfaaf560, 0x189 /* FUTEX_??? */, 1, NULL, bfaaf570) =3D -1 =
EAGAIN (Resource temporarily unavailable)
> > > > rt_sigaction(SIGRTMIN, {0xb763d4f0, [], SA_SIGINFO}, NULL, 8) =3D 0
> > > > rt_sigaction(SIGRT_1, {0xb763d9c0, [], SA_RESTART|SA_SIGINFO}, NULL=
, 8) =3D 0
> > > > rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) =3D 0
> > > > getrlimit(RLIMIT_STACK, {rlim_cur=3D8192*1024, rlim_max=3DRLIM_INFI=
NITY}) =3D 0
> > > > uname({sys=3D"Linux", node=3D"5410", ...})  =3D 0
> > > > rt_sigaction(SIGUSR1, {0xb77bec0a, [], SA_RESTART|SA_SIGINFO}, NULL=
, 8) =3D 0
> > > > futex(0xb77af06c, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0
> > > > brk(0)                                  =3D 0x804e000
> > > > brk(0x806f000)                          =3D 0x806f000
> > > > gettimeofday({1339187216, 880428}, NULL) =3D 0
> > > > open("/dev/urandom", O_RDONLY|O_LARGEFILE) =3D 3
> > > > fcntl64(3, F_GETFD)                     =3D 0
> > > > fcntl64(3, F_SETFD, FD_CLOEXEC)         =3D 0
> > > > getuid32()                              =3D 0
> > > > gettimeofday({1339187216, 889603}, NULL) =3D 0
> > > > gettimeofday({1339187216, 894471}, NULL) =3D 0
> > > > read(3, "\275\0051F\215\373\371\202\377kfb/\362\303N"..., 16) =3D 1=
6
> > > > clock_gettime(CLOCK_REALTIME, {1339187216, 902329405}) =3D 0
> > > > getuid32()                              =3D 0
> > > > geteuid32()                             =3D 0
> > > > rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) =3D 0
> > > > mmap2(NULL, 8388608, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOU=
S|MAP_STACK, -1, 0) =3D 0xb6e36000
> > > > mprotect(0xb6e36000, 4096, PROT_NONE)   =3D 0
> > > > clone(child_stack=3D0xb7634d64, flags=3DCLONE_VM|CLONE_FS|CLONE_FIL=
ES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTI=
D|CLONE_CHILD_CLEARTID|CLONE_DETACHED, parent_tidptr=3D0xb7635bd8, {entry_n=
umber:6, base_addr:0xb7635b70, limit:1048575, seg_32bit:1, contents:0, read=
_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}, child_tidptr=
=3D0xb7635bd8) =3D 3051
> > > > mmap2(NULL, 8388608, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOU=
S|MAP_STACK, -1, 0) =3D 0xb6636000
> > > > mprotect(0xb6636000, 4096, PROT_NONE)   =3D 0
> > > > clone(child_stack=3D0xb6e34d64, flags=3DCLONE_VM|CLONE_FS|CLONE_FIL=
ES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTI=
D|CLONE_CHILD_CLEARTID|CLONE_DETACHED, parent_tidptr=3D0xb6e35bd8, {entry_n=
umber:6, base_addr:0xb6e35b70, limit:1048575, seg_32bit:1, contents:0, read=
_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}, child_tidptr=
=3D0xb6e35bd8) =3D 3052
> > > > rt_sigprocmask(SIG_SETMASK, [], NULL, 8) =3D 0
> > > > gettimeofday({1339187216, 974869}, NULL) =3D 0
> > > > futex(0xb7836e30, FUTEX_WAIT_PRIVATE, 0, {2, 927460405}) =3D -1 ETI=
MEDOUT (Connection timed out)
> > > > gettid()                                =3D 3050
> > > > write(2, "libust[3050/3050]: Error: Timed o"..., 107libust[3050/305=
0]: Error: Timed out waiting for ltt-sessiond (in lttng_ust_init() at lttng=
-ust-comm.c:912)
> > > > ) =3D 107
> > > > futex(0xb7836e80, FUTEX_WAIT_PRIVATE, 2, NULL
> > > > _______________________________________________
> > > > lttng-dev mailing list
> > > > lttng-dev@lists.lttng.org
> > > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > >
> > >
> > > --
> > > Mathieu Desnoyers
> > > Operating System Efficiency R&D Consultant
> > > EfficiOS Inc.
> > > http://www.efficios.com
> >
> > --
> > Mathieu Desnoyers
> > Operating System Efficiency R&D Consultant
> > EfficiOS Inc.
> > http://www.efficios.com
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com

--_002_3F56B905CF2083408E8482044F20428AEF7A0CE0ONWVEXCHMB01cie_
Content-Type: text/plain; name="full_bt.txt"
Content-Description: full_bt.txt
Content-Disposition: attachment; filename="full_bt.txt"; size=8370;
	creation-date="Tue, 12 Jun 2012 18:24:02 GMT";
	modification-date="Tue, 12 Jun 2012 18:24:02 GMT"
Content-Transfer-Encoding: base64

KGdkYikgdGhyZWFkIGFwcGx5IGFsbCBidCBmdWxsDQpbTmV3IFRocmVhZCA4MDI5XQ0KW05ldyBU
aHJlYWQgODA1MF0NCg0KVGhyZWFkIDMgKFRocmVhZCA4MDUwKToNCiMwICBfX2xsbF9sb2NrX3dh
aXQgKCkgYXQgLi4vbnB0bC9zeXNkZXBzL3VuaXgvc3lzdi9saW51eC9pMzg2L2k0ODYvbG93bGV2
ZWxsb2NrLlM6MTQ0DQpObyBsb2NhbHMuDQojMSAgMHhiNzYyZDJlOCBpbiBfTF9sb2NrXzg1MCAo
KSBmcm9tIC9sb2NhbGRhdGEvbWJ1cnRvbi1jbjU0MTAtbWFpbi9idWlsZC9zYW9zLXNpbTU0MTAv
ZnMvcmVsZWFzZWZzL2RlYnVnL2N0bTEwL2k0ODYtc2ltL3Jvb3Rmcy9saWIvbGlicHRocmVhZC5z
by4wDQpObyBzeW1ib2wgdGFibGUgaW5mbyBhdmFpbGFibGUuDQojMiAgMHhiNzYyZDEyYiBpbiBf
X3B0aHJlYWRfbXV0ZXhfbG9jayAobXV0ZXg9MHhiNzgyMmU4MCkgYXQgcHRocmVhZF9tdXRleF9s
b2NrLmM6NjENCiAgICAgICAgaWdub3JlMyA9IDANCiAgICAgICAgaWdub3JlMSA9IC01MTINCiAg
ICAgICAgaWdub3JlMiA9IDEyOA0KICAgICAgICB0eXBlID0gPHZhbHVlIG9wdGltaXplZCBvdXQ+
DQogICAgICAgIF9fUFJFVFRZX0ZVTkNUSU9OX18gPSAgICAgICAgICAgIl9fcHRocmVhZF9tdXRl
eF9sb2NrIg0KIzMgIDB4Yjc3MjgzYjYgaW4gcHRocmVhZF9tdXRleF9sb2NrIChtdXRleD0weGI3
ODIyZTgwKSBhdCBmb3J3YXJkLmM6MTgyDQogICAgICAgIF9fcCA9IDB4ZmZmZmZlMDANCiM0ICAw
eGI3N2ZmYjM4IGluIHVzdF9sb2NrICgpIGF0IGx0dC1ldmVudHMuYzo3MA0KTm8gbG9jYWxzLg0K
IzUgIDB4Yjc3ZmEwNWQgaW4gdXN0X2xpc3RlbmVyX3RocmVhZCAoYXJnPTB4Yjc4MWU5YTApIGF0
IGx0dG5nLXVzdC1jb21tLmM6NjgxDQogICAgICAgIHNvY2tfaW5mbyA9IDB4Yjc4MWU5YTANCiAg
ICAgICAgc29jayA9IDANCiAgICAgICAgcmV0ID0gMA0KICAgICAgICBwcmV2X2Nvbm5lY3RfZmFp
bGVkID0gMA0KICAgICAgICBoYXNfd2FpdGVkID0gMA0KICAgICAgICBfX2Z1bmNfXyA9ICAgICAg
ICAgICAidXN0X2xpc3RlbmVyX3RocmVhZCINCiAgICAgICAgX19QUkVUVFlfRlVOQ1RJT05fXyA9
ICAgICAgICAgICAidXN0X2xpc3RlbmVyX3RocmVhZCINCiM2ICAweGI3NjJiNzIzIGluIHN0YXJ0
X3RocmVhZCAoYXJnPTB4YjZlMjFiNzApIGF0IHB0aHJlYWRfY3JlYXRlLmM6MzA0DQogICAgICAg
IF9fcmVzID0gPHZhbHVlIG9wdGltaXplZCBvdXQ+DQogICAgICAgIF9faWdub3JlMSA9IDx2YWx1
ZSBvcHRpbWl6ZWQgb3V0Pg0KICAgICAgICBfX2lnbm9yZTIgPSA8dmFsdWUgb3B0aW1pemVkIG91
dD4NCiAgICAgICAgcGQgPSAweGI2ZTIxYjcwDQogICAgICAgIHVud2luZF9idWYgPSB7DQogICAg
ICAgICAgY2FuY2VsX2ptcF9idWYgPSAgICAgICAgICAgICB7ew0KICAgICAgICAgICAgICBqbXBf
YnVmID0gICAgICAgICAgICAgICAgIHstMTIxODIwMzY2MCwNCiAgICAgICAgICAgICAgICAwLA0K
ICAgICAgICAgICAgICAgIDgxOTU4NDAsDQogICAgICAgICAgICAgICAgLTEyMjY2OTk0MTYsDQog
ICAgICAgICAgICAgICAgMTE5NTcyODM4LA0KICAgICAgICAgICAgICAgIDEwNjE5NTMwMX0sIA0K
ICAgICAgICAgICAgICBtYXNrX3dhc19zYXZlZCA9IDANCiAgICAgICAgICAgIH19LCANCiAgICAg
ICAgICBwcml2ID0gew0KICAgICAgICAgICAgcGFkID0gICAgICAgICAgICAgICB7MHgwLA0KICAg
ICAgICAgICAgICAweDAsDQogICAgICAgICAgICAgIDB4MCwNCiAgICAgICAgICAgICAgMHgwfSwg
DQogICAgICAgICAgICBkYXRhID0gew0KICAgICAgICAgICAgICBwcmV2ID0gMHgwLCANCiAgICAg
ICAgICAgICAgY2xlYW51cCA9IDB4MCwgDQogICAgICAgICAgICAgIGNhbmNlbHR5cGUgPSAwDQog
ICAgICAgICAgICB9DQogICAgICAgICAgfQ0KICAgICAgICB9DQogICAgICAgIG5vdF9maXJzdF9j
YWxsID0gMA0KICAgICAgICByb2J1c3QgPSA8dmFsdWUgb3B0aW1pemVkIG91dD4NCi0tLVR5cGUg
PHJldHVybj4gdG8gY29udGludWUsIG9yIHEgPHJldHVybj4gdG8gcXVpdC0tLQ0KICAgICAgICBm
cmVlc2l6ZSA9IDx2YWx1ZSBvcHRpbWl6ZWQgb3V0Pg0KICAgICAgICBfX1BSRVRUWV9GVU5DVElP
Tl9fID0gICAgICAgICAgICJzdGFydF90aHJlYWQiDQojNyAgMHhiNzcxYWFkZSBpbiBjbG9uZSAo
KSBhdCAuLi9zeXNkZXBzL3VuaXgvc3lzdi9saW51eC9pMzg2L2Nsb25lLlM6MTMzDQpObyBsb2Nh
bHMuDQoNClRocmVhZCAyIChUaHJlYWQgODAyOSk6DQojMCAgX19sbGxfbG9ja193YWl0ICgpIGF0
IC4uL25wdGwvc3lzZGVwcy91bml4L3N5c3YvbGludXgvaTM4Ni9pNDg2L2xvd2xldmVsbG9jay5T
OjE0NA0KTm8gbG9jYWxzLg0KIzEgIDB4Yjc2MmQyZTggaW4gX0xfbG9ja184NTAgKCkgZnJvbSAv
bG9jYWxkYXRhL21idXJ0b24tY241NDEwLW1haW4vYnVpbGQvc2Fvcy1zaW01NDEwL2ZzL3JlbGVh
c2Vmcy9kZWJ1Zy9jdG0xMC9pNDg2LXNpbS9yb290ZnMvbGliL2xpYnB0aHJlYWQuc28uMA0KTm8g
c3ltYm9sIHRhYmxlIGluZm8gYXZhaWxhYmxlLg0KIzIgIDB4Yjc2MmQxMmIgaW4gX19wdGhyZWFk
X211dGV4X2xvY2sgKG11dGV4PTB4Yjc4MjJlODApIGF0IHB0aHJlYWRfbXV0ZXhfbG9jay5jOjYx
DQogICAgICAgIGlnbm9yZTMgPSA1DQogICAgICAgIGlnbm9yZTEgPSAtNTEyDQogICAgICAgIGln
bm9yZTIgPSAxMjgNCiAgICAgICAgdHlwZSA9IDx2YWx1ZSBvcHRpbWl6ZWQgb3V0Pg0KICAgICAg
ICBfX1BSRVRUWV9GVU5DVElPTl9fID0gICAgICAgICAgICJfX3B0aHJlYWRfbXV0ZXhfbG9jayIN
CiMzICAweGI3NzI4M2I2IGluIHB0aHJlYWRfbXV0ZXhfbG9jayAobXV0ZXg9MHhiNzgyMmU4MCkg
YXQgZm9yd2FyZC5jOjE4Mg0KICAgICAgICBfX3AgPSAweGZmZmZmZTAwDQojNCAgMHhiNzdmZmIz
OCBpbiB1c3RfbG9jayAoKSBhdCBsdHQtZXZlbnRzLmM6NzANCk5vIGxvY2Fscy4NCiM1ICAweGI3
N2ZiNWFhIGluIHVzdF9iZWZvcmVfZm9yayAoc2F2ZV9zaWdzZXQ9MHhiNzYxZmE2MCkgYXQgbHR0
bmctdXN0LWNvbW0uYzoxMDIxDQogICAgICAgIGFsbF9zaWdzID0gew0KICAgICAgICAgIF9fdmFs
ID0gICAgICAgICAgICAgezIxNDc0ODM2NDcsDQogICAgICAgICAgICA0Mjk0OTY3Mjk0LA0KICAg
ICAgICAgICAgNDI5NDk2NzI5NSA8cmVwZWF0cyAzMCB0aW1lcz59DQogICAgICAgIH0NCiAgICAg
ICAgcmV0ID0gMA0KICAgICAgICBfX2Z1bmNfXyA9ICAgICAgICAgICAidXN0X2JlZm9yZV9mb3Jr
Ig0KIzYgIDB4Yjc3Y2E2NDcgaW4gZm9yayAoKSBhdCB1c3Rmb3JrLmM6NDcNCiAgICAgICAgc2ln
c2V0ID0gew0KICAgICAgICAgIF9fdmFsID0gICAgICAgICAgICAgezIxNDcyMjEyMzEsDQogICAg
ICAgICAgICA0Mjk0OTY3Mjk0LA0KICAgICAgICAgICAgMzA3NjY1MTY5MywNCiAgICAgICAgICAg
IDMwNzY2NTE3MzYsDQogICAgICAgICAgICAzMDc4ODcxMTA0LA0KICAgICAgICAgICAgMzA3ODM5
ODQyOCwNCiAgICAgICAgICAgIDMwNzg3ODUzNzYsDQogICAgICAgICAgICA0Mjk0OTY3Mjk1LA0K
ICAgICAgICAgICAgNDQ4MTM5LA0KICAgICAgICAgICAgMzA3ODkwOTk0MCwNCiAgICAgICAgICAg
IDMwNzg3ODM5NjgsDQogICAgICAgICAgICAzMDc4Nzg0NDA4LA0KICAgICAgICAgICAgMzA3NjY1
MTcyOCwNCiAgICAgICAgICAgIDMwNzg4NDcyODgsDQogICAgICAgICAgICAzMDc4Nzg0NDA4LA0K
ICAgICAgICAgICAgMzA3NjgxNTMyOCwNCiAgICAgICAgICAgIDEsDQogICAgICAgICAgICA1LA0K
ICAgICAgICAgICAgMCwNCiAgICAgICAgICAgIDUsDQogICAgICAgICAgICAzMDc4NTU2ODYxLA0K
ICAgICAgICAgICAgMTg5LA0KICAgICAgICAgICAgMzA3ODU0OTUwNCwNCi0tLVR5cGUgPHJldHVy
bj4gdG8gY29udGludWUsIG9yIHEgPHJldHVybj4gdG8gcXVpdC0tLQ0KICAgICAgICAgICAgMTk0
NTMyLA0KICAgICAgICAgICAgMzA3ODM5ODQyOCwNCiAgICAgICAgICAgIDMwNzg3NDM0MTIsDQog
ICAgICAgICAgICA4MDI5LA0KICAgICAgICAgICAgMzA3ODcxNTY4MywNCiAgICAgICAgICAgIDMw
NzY2NTMxMjgsDQogICAgICAgICAgICAzMDc4ODcxMTA0LA0KICAgICAgICAgICAgMiwNCiAgICAg
ICAgICAgIDMwNzgzOTk0MzZ9DQogICAgICAgIH0NCiAgICAgICAgcmV0dmFsID0gMg0KICAgICAg
ICBwbGliY19mdW5jID0gMHhiNzZlMzJmMCA8X19saWJjX2Zvcms+DQojNyAgMHhiNzdmOTFjZCBp
biBnZXRfd2FpdF9zaG0gKHNvY2tfaW5mbz0weGI3ODIwOWMwLCBtbWFwX3NpemU9NDA5NikgYXQg
bHR0bmctdXN0LWNvbW0uYzo0NzINCiAgICAgICAgd2FpdF9zaG1fZmQgPSAtMQ0KICAgICAgICBy
ZXQgPSAtMTIxNjQxNzc5Mg0KICAgICAgICBwaWQgPSAxOTM5ODgNCiAgICAgICAgX19mdW5jX18g
PSAgICAgICAgICAgImdldF93YWl0X3NobSINCiM4ICAweGI3N2Y5OWExIGluIGdldF9tYXBfc2ht
IChzb2NrX2luZm89MHhiNzgyMDljMCkgYXQgbHR0bmctdXN0LWNvbW0uYzo1ODENCiAgICAgICAg
bW1hcF9zaXplID0gNDA5Ng0KICAgICAgICB3YWl0X3NobV9mZCA9IC0xMjE4MzEzMzg0DQogICAg
ICAgIHJldCA9IC0xMjE3MjMxOTQ2DQogICAgICAgIHdhaXRfc2htX21tYXAgPSAweGI3ODIyZTgw
ICJcMDAyIg0KICAgICAgICBfX2Z1bmNfXyA9ICAgICAgICAgICAiZ2V0X21hcF9zaG0iDQojOSAg
MHhiNzdmOWM4NyBpbiB3YWl0X2Zvcl9zZXNzaW9uZCAoc29ja19pbmZvPTB4Yjc4MjA5YzApIGF0
IGx0dG5nLXVzdC1jb21tLmM6NjE1DQogICAgICAgIHJldCA9IC0xMjE3MjMxODY2DQogICAgICAg
IF9fZnVuY19fID0gICAgICAgICAgICJ3YWl0X2Zvcl9zZXNzaW9uZCINCiMxMCAweGI3N2ZhMDJk
IGluIHVzdF9saXN0ZW5lcl90aHJlYWQgKGFyZz0weGI3ODIwOWMwKSBhdCBsdHRuZy11c3QtY29t
bS5jOjY2OA0KICAgICAgICBzb2NrX2luZm8gPSAweGI3ODIwOWMwDQogICAgICAgIHNvY2sgPSAx
DQogICAgICAgIHJldCA9IDANCiAgICAgICAgcHJldl9jb25uZWN0X2ZhaWxlZCA9IDENCiAgICAg
ICAgaGFzX3dhaXRlZCA9IDANCiAgICAgICAgX19mdW5jX18gPSAgICAgICAgICAgInVzdF9saXN0
ZW5lcl90aHJlYWQiDQogICAgICAgIF9fUFJFVFRZX0ZVTkNUSU9OX18gPSAgICAgICAgICAgInVz
dF9saXN0ZW5lcl90aHJlYWQiDQojMTEgMHhiNzYyYjcyMyBpbiBzdGFydF90aHJlYWQgKGFyZz0w
eGI3NjIxYjcwKSBhdCBwdGhyZWFkX2NyZWF0ZS5jOjMwNA0KICAgICAgICBfX3JlcyA9IDx2YWx1
ZSBvcHRpbWl6ZWQgb3V0Pg0KICAgICAgICBfX2lnbm9yZTEgPSA8dmFsdWUgb3B0aW1pemVkIG91
dD4NCiAgICAgICAgX19pZ25vcmUyID0gPHZhbHVlIG9wdGltaXplZCBvdXQ+DQogICAgICAgIHBk
ID0gMHhiNzYyMWI3MA0KICAgICAgICB1bndpbmRfYnVmID0gew0KICAgICAgICAgIGNhbmNlbF9q
bXBfYnVmID0gICAgICAgICAgICAge3sNCiAgICAgICAgICAgICAgam1wX2J1ZiA9ICAgICAgICAg
ICAgICAgICB7LTEyMTgyMDM2NjAsDQogICAgICAgICAgICAgICAgMCwNCiAgICAgICAgICAgICAg
ICA4MTk1ODQwLA0KICAgICAgICAgICAgICAgIC0xMjE4MzEwODA4LA0KICAgICAgICAgICAgICAg
IDExOTU3MjgzNywNCiAgICAgICAgICAgICAgICAxMDYxOTUzMDF9LCANCiAgICAgICAgICAgICAg
bWFza193YXNfc2F2ZWQgPSAwDQogICAgICAgICAgICB9fSwgDQogICAgICAgICAgcHJpdiA9IHsN
CiAgICAgICAgICAgIHBhZCA9ICAgICAgICAgICAgICAgezB4MCwNCiAgICAgICAgICAgICAgMHgw
LA0KICAgICAgICAgICAgICAweDAsDQotLS1UeXBlIDxyZXR1cm4+IHRvIGNvbnRpbnVlLCBvciBx
IDxyZXR1cm4+IHRvIHF1aXQtLS0NCiAgICAgICAgICAgICAgMHgwfSwgDQogICAgICAgICAgICBk
YXRhID0gew0KICAgICAgICAgICAgICBwcmV2ID0gMHgwLCANCiAgICAgICAgICAgICAgY2xlYW51
cCA9IDB4MCwgDQogICAgICAgICAgICAgIGNhbmNlbHR5cGUgPSAwDQogICAgICAgICAgICB9DQog
ICAgICAgICAgfQ0KICAgICAgICB9DQogICAgICAgIG5vdF9maXJzdF9jYWxsID0gMA0KICAgICAg
ICByb2J1c3QgPSA8dmFsdWUgb3B0aW1pemVkIG91dD4NCiAgICAgICAgZnJlZXNpemUgPSA8dmFs
dWUgb3B0aW1pemVkIG91dD4NCiAgICAgICAgX19QUkVUVFlfRlVOQ1RJT05fXyA9ICAgICAgICAg
ICAic3RhcnRfdGhyZWFkIg0KIzEyIDB4Yjc3MWFhZGUgaW4gY2xvbmUgKCkgYXQgLi4vc3lzZGVw
cy91bml4L3N5c3YvbGludXgvaTM4Ni9jbG9uZS5TOjEzMw0KTm8gbG9jYWxzLg0KDQpUaHJlYWQg
MSAoVGhyZWFkIDQyMzgpOg0KIzAgIF9fbGxsX2xvY2tfd2FpdCAoKSBhdCAuLi9ucHRsL3N5c2Rl
cHMvdW5peC9zeXN2L2xpbnV4L2kzODYvaTQ4Ni9sb3dsZXZlbGxvY2suUzoxNDQNCk5vIGxvY2Fs
cy4NCiMxICAweGI3NjJkMmU4IGluIF9MX2xvY2tfODUwICgpIGZyb20gL2xvY2FsZGF0YS9tYnVy
dG9uLWNuNTQxMC1tYWluL2J1aWxkL3Nhb3Mtc2ltNTQxMC9mcy9yZWxlYXNlZnMvZGVidWcvY3Rt
MTAvaTQ4Ni1zaW0vcm9vdGZzL2xpYi9saWJwdGhyZWFkLnNvLjANCk5vIHN5bWJvbCB0YWJsZSBp
bmZvIGF2YWlsYWJsZS4NCiMyICAweGI3NjJkMTJiIGluIF9fcHRocmVhZF9tdXRleF9sb2NrICht
dXRleD0weGI3ODIyZTgwKSBhdCBwdGhyZWFkX211dGV4X2xvY2suYzo2MQ0KICAgICAgICBpZ25v
cmUzID0gLTEyMTgxNTE1MDQNCiAgICAgICAgaWdub3JlMSA9IC01MTINCiAgICAgICAgaWdub3Jl
MiA9IDEyOA0KICAgICAgICB0eXBlID0gPHZhbHVlIG9wdGltaXplZCBvdXQ+DQogICAgICAgIF9f
UFJFVFRZX0ZVTkNUSU9OX18gPSAgICAgICAgICAgIl9fcHRocmVhZF9tdXRleF9sb2NrIg0KIzMg
IDB4Yjc3MjgzYjYgaW4gcHRocmVhZF9tdXRleF9sb2NrIChtdXRleD0weGI3ODIyZTgwKSBhdCBm
b3J3YXJkLmM6MTgyDQogICAgICAgIF9fcCA9IDB4ZmZmZmZlMDANCiM0ICAweGI3N2ZmYjM4IGlu
IHVzdF9sb2NrICgpIGF0IGx0dC1ldmVudHMuYzo3MA0KTm8gbG9jYWxzLg0KIzUgIDB4Yjc3ZmQ4
Y2MgaW4gbHR0X3Byb2JlX3JlZ2lzdGVyIChkZXNjPTB4Yjc3YzNlNDApIGF0IGx0dC1wcm9iZXMu
Yzo3Nw0KICAgICAgICBpdGVyID0gMHhiNzdmMDAxYw0KICAgICAgICByZXQgPSAwDQogICAgICAg
IGkgPSAtMTIxNjU5NTg4MA0KICAgICAgICBfX2Z1bmNfXyA9ICAgICAgICAgICAibHR0X3Byb2Jl
X3JlZ2lzdGVyIg0KICAgICAgICBfX1BSRVRUWV9GVU5DVElPTl9fID0gICAgICAgICAgICJsdHRf
cHJvYmVfcmVnaXN0ZXIiDQojNiAgMHhiNzdjMjEwZiBpbiBfX2x0dG5nX2V2ZW50c19pbml0X191
c3RfbGliYyAoKSBhdCAuLi9pbmNsdWRlL2x0dG5nL3VzdC10cmFjZXBvaW50LWV2ZW50Lmg6NTUw
DQogICAgICAgIHJldCA9IC0xMjE2MjI1MDgwDQogICAgICAgIF9fUFJFVFRZX0ZVTkNUSU9OX18g
PSAgICAgICAgICAgIl9fbHR0bmdfZXZlbnRzX2luaXRfX3VzdF9saWJjIg0KIzcgIDB4Yjc3YzI0
MTIgaW4gX19kb19nbG9iYWxfY3RvcnNfYXV4ICgpIGZyb20gL2xvY2FsZGF0YS9tYnVydG9uLWNu
NTQxMC1tYWluL2J1aWxkL3Nhb3Mtc2ltNTQxMC9mcy9yZWxlYXNlZnMvZGVidWcvY3RtMTAvaTQ4
Ni1zaW0vcm9vdGZzL3Vzci9saWIvbGlibHR0bmctdXN0LWxpYmMtd3JhcHBlci5zby4wDQpObyBs
b2NhbHMuDQojOCAgMHhiNzdjMTkzMCBpbiBfaW5pdCAoKSBmcm9tIC9sb2NhbGRhdGEvbWJ1cnRv
bi1jbjU0MTAtbWFpbi9idWlsZC9zYW9zLXNpbTU0MTAvZnMvcmVsZWFzZWZzL2RlYnVnL2N0bTEw
L2k0ODYtc2ltL3Jvb3Rmcy91c3IvbGliL2xpYmx0dG5nLXVzdC1saWJjLXdyYXBwZXIuc28uMA0K
Tm8gbG9jYWxzLg0KIzkgIDB4Yjc4MzgxMjggaW4gY2FsbF9pbml0IChsPTB4Yjc3YzQwMDAsIGFy
Z2M9MSwgYXJndj0weGJmYTMxODE0LCBlbnY9MHhiZmEzMTgxYykgYXQgZGwtaW5pdC5jOjcwDQog
ICAgICAgIGluaXRfYXJyYXkgPSA8dmFsdWUgb3B0aW1pemVkIG91dD4NCiMxMCAweGI3ODM4MjNm
IGluIF9kbF9pbml0IChtYWluX21hcD0weGI3ODQ3OTA4LCBhcmdjPTEsIGFyZ3Y9MHhiZmEzMTgx
NCwgZW52PTB4YmZhMzE4MWMpIGF0IGRsLWluaXQuYzoxMzQNCiAgICAgICAgcHJlaW5pdF9hcnJh
eSA9IDx2YWx1ZSBvcHRpbWl6ZWQgb3V0Pg0KICAgICAgICBwcmVpbml0X2FycmF5X3NpemUgPSA8
dmFsdWUgb3B0aW1pemVkIG91dD4NCiAgICAgICAgaSA9IDMNCiMxMSAweGI3ODI5ODRmIGluIF9k
bF9zdGFydF91c2VyICgpIGZyb20gL2xvY2FsZGF0YS9tYnVydG9uLWNuNTQxMC1tYWluL2J1aWxk
L3Nhb3Mtc2ltNTQxMC9mcy9yZWxlYXNlZnMvZGVidWcvY3RtMTAvaTQ4Ni1zaW0vcm9vdGZzL2xp
Yi9sZC1saW51eC5zby4yDQpObyBzeW1ib2wgdGFibGUgaW5mbyBhdmFpbGFibGUu

--_002_3F56B905CF2083408E8482044F20428AEF7A0CE0ONWVEXCHMB01cie_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--_002_3F56B905CF2083408E8482044F20428AEF7A0CE0ONWVEXCHMB01cie_--
