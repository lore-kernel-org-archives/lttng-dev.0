From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: UST Hanging at Tracepoint
Date: Tue, 12 Jun 2012 12:25:26 -0400
Message-ID: <20120612162526.GB16098__34378.8376929753$1339518361$gmane$org@Krystal>
References: <3F56B905CF2083408E8482044F20428AEF604D22@ONWVEXCHMB01.ciena.com>
	<3F56B905CF2083408E8482044F20428AEF78BC79@ONWVEXCHMB01.ciena.com>
	<20120612140925.GB13917@Krystal> <20120612141344.GC13917@Krystal>
	<3F56B905CF2083408E8482044F20428AEF7A0AFE@ONWVEXCHMB01.ciena.com>
	<3F56B905CF2083408E8482044F20428AEF7A0B4C@ONWVEXCHMB01.ciena.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SeTuK-0002lK-TD
	for lttng-dev@lists.lttng.org; Tue, 12 Jun 2012 12:25:28 -0400
Content-Disposition: inline
In-Reply-To: <3F56B905CF2083408E8482044F20428AEF7A0B4C@ONWVEXCHMB01.ciena.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Burton, Michael" <mburton@ciena.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "dgoulet@efficios.com" <dgoulet@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Please build you app and lttng-ust with:

make CFLAGS=-g   (so with -O0 optimisation, and debug info)

then, under gdb, please provide the full backtrace of each thread when
stucked with:

thread apply all bt full

Thanks,

Mathieu


* Burton, Michael (mburton@ciena.com) wrote:
> Also, I stepped through the code with gdb and things hang within the UST constructors and the main function of my application is never reached.
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
> > Please note that you should be able to run UST with either (or both) of:
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
> > > I figured out the problem.  When we start sessiond on our system as root, the /.lttng/ folder is not created, along with its contents.  UST timed out since there was no sock_path.  I was able to get UST working once I got sessiond running.
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
> > > LTTNG_UST_DEBUG=1 youprogname
> > >
> > > (starting your UST instrumented program with LTTNG_UST_DEBUG=1 env. var.
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
> > > > I am working on getting LTTng 2.0 working in our 2.6.35 kernel.  I have kernel tracing working but I'm having problems with UST.
> > > >
> > > > I have a program with a dynamic UST tracepoint.  When I run the program with all UST events enabled (lttng enable-event -a -u) the program hangs on the tracepoint.  The last line from the UST debug is:
> > > >
> > > > libust[6184/6185]: Info: sessiond not accepting connections to local apps socket (in ust_listener_thread() at lttng-ust-comm.c:699)
> > > >
> > > > Any insight into why this is happening?  I've attached the UST and lttng-sessiond debug generated by the program.
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
> > > > execve("/ciena/bin/idp", ["idp", "help"], [/* 11 vars */]) = 0
> > > > brk(0)                                  = 0x804e000
> > > > mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb783c000
> > > > access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
> > > > open("/etc/ld.so.cache", O_RDONLY)      = 3
> > > > fstat64(3, {st_mode=S_IFREG|0644, st_size=17420, ...}) = 0
> > > > mmap2(NULL, 17420, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7837000
> > > > close(3)                                = 0
> > > > open("/usr/lib/liblttng-ust.so.0", O_RDONLY) = 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220A\0\0004\0\0\0$"..., 512) = 512
> > > > fstat64(3, {st_mode=S_IFREG|0755, st_size=209876, ...}) = 0
> > > > mmap2(NULL, 212940, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7803000
> > > > mmap2(0xb7832000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2e) = 0xb7832000
> > > > close(3)                                = 0
> > > > open("/usr/lib/liblttng-ust-ctl.so.0", O_RDONLY) = 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200-\0\0004\0\0\0\274"..., 512) = 512
> > > > fstat64(3, {st_mode=S_IFREG|0755, st_size=140020, ...}) = 0
> > > > mmap2(NULL, 142828, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb77e0000
> > > > mmap2(0xb7802000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x21) = 0xb7802000
> > > > close(3)                                = 0
> > > > open("/usr/lib/liblttng-ust-fork.so.0", O_RDONLY) = 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\5\0\0004\0\0\0X"..., 512) = 512
> > > > fstat64(3, {st_mode=S_IFREG|0755, st_size=3864, ...}) = 0
> > > > mmap2(NULL, 6820, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb77de000
> > > > mmap2(0xb77df000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0) = 0xb77df000
> > > > close(3)                                = 0
> > > > open("/usr/lib/liblttng-ust-tracepoint.so.0", O_RDONLY) = 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\v\0\0004\0\0\0008"..., 512) = 512
> > > > fstat64(3, {st_mode=S_IFREG|0755, st_size=16632, ...}) = 0
> > > > mmap2(NULL, 19944, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb77d9000
> > > > mmap2(0xb77dd000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3) = 0xb77dd000
> > > > close(3)                                = 0
> > > > open("/usr/lib/liblttng-ust-libc-wrapper.so.0", O_RDONLY) = 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\t\0\0004\0\0\0\364"..., 512) = 512
> > > > fstat64(3, {st_mode=S_IFREG|0755, st_size=9300, ...}) = 0
> > > > mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb77d8000
> > > > mmap2(NULL, 12104, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb77d5000
> > > > mmap2(0xb77d7000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0xb77d7000
> > > > close(3)                                = 0
> > > > open("/usr/lib/liburcu.so.1", O_RDONLY) = 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\22\0\0004\0\0\0\374"..., 512) = 512
> > > > fstat64(3, {st_mode=S_IFREG|0755, st_size=18188, ...}) = 0
> > > > mmap2(NULL, 17080, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb77d0000
> > > > mmap2(0xb77d4000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4) = 0xb77d4000
> > > > close(3)                                = 0
> > > > open("/usr/lib/liburcu-common.so.1", O_RDONLY) = 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\5\0\0004\0\0\0\34"..., 512) = 512
> > > > fstat64(3, {st_mode=S_IFREG|0755, st_size=5084, ...}) = 0
> > > > mmap2(NULL, 8032, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb77ce000
> > > > mmap2(0xb77cf000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0) = 0xb77cf000
> > > > close(3)                                = 0
> > > > open("/usr/lib/liburcu-qsbr.so.1", O_RDONLY) = 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\22\0\0004\0\0\0\374"..., 512) = 512
> > > > fstat64(3, {st_mode=S_IFREG|0755, st_size=18188, ...}) = 0
> > > > mmap2(NULL, 17080, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb77c9000
> > > > mmap2(0xb77cd000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4) = 0xb77cd000
> > > > close(3)                                = 0
> > > > open("/usr/lib/liburcu-mb.so.1", O_RDONLY) = 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\22\0\0004\0\0\0\374"..., 512) = 512
> > > > fstat64(3, {st_mode=S_IFREG|0755, st_size=18188, ...}) = 0
> > > > mmap2(NULL, 17080, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb77c4000
> > > > mmap2(0xb77c8000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4) = 0xb77c8000
> > > > close(3)                                = 0
> > > > open("/usr/lib/liburcu-signal.so.1", O_RDONLY) = 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\23\0\0004\0\0\0\10"..., 512) = 512
> > > > fstat64(3, {st_mode=S_IFREG|0755, st_size=18712, ...}) = 0
> > > > mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb77c3000
> > > > mmap2(NULL, 21704, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb77bd000
> > > > mmap2(0xb77c2000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4) = 0xb77c2000
> > > > close(3)                                = 0
> > > > open("/usr/lib/liburcu-cds.so.1", O_RDONLY) = 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\f\0\0004\0\0\0t"..., 512) = 512
> > > > fstat64(3, {st_mode=S_IFREG|0755, st_size=26204, ...}) = 0
> > > > mmap2(NULL, 25004, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb77b6000
> > > > mmap2(0xb77bc000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6) = 0xb77bc000
> > > > close(3)                                = 0
> > > > open("/usr/lib/liburcu-bp.so.1", O_RDONLY) = 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320\24\0\0004\0\0\0\360"..., 512) = 512
> > > > fstat64(3, {st_mode=S_IFREG|0755, st_size=19968, ...}) = 0
> > > > mmap2(NULL, 23128, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb77b0000
> > > > mmap2(0xb77b5000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4) = 0xb77b5000
> > > > close(3)                                = 0
> > > > open("/lib/libdl.so.2", O_RDONLY)       = 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \n\0\0004\0\0\0<"..., 512) = 512
> > > > fstat64(3, {st_mode=S_IFREG|0755, st_size=9668, ...}) = 0
> > > > mmap2(NULL, 12408, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb77ac000
> > > > mmap2(0xb77ae000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0xb77ae000
> > > > close(3)                                = 0
> > > > open("/lib/libuuid.so.1", O_RDONLY)     = 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\r\0\0004\0\0\0\350"..., 512) = 512
> > > > fstat64(3, {st_mode=S_IFREG|0755, st_size=12872, ...}) = 0
> > > > mmap2(NULL, 15632, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb77a8000
> > > > mmap2(0xb77ab000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2) = 0xb77ab000
> > > > close(3)                                = 0
> > > > open("/lib/libc.so.6", O_RDONLY)        = 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220n\1\0004\0\0\0L"..., 512) = 512
> > > > fstat64(3, {st_mode=S_IFREG|0755, st_size=1347780, ...}) = 0
> > > > mmap2(NULL, 1358120, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb765c000
> > > > mprotect(0xb77a1000, 4096, PROT_NONE)   = 0
> > > > mmap2(0xb77a2000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x145) = 0xb77a2000
> > > > mmap2(0xb77a5000, 10536, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb77a5000
> > > > close(3)                                = 0
> > > > open("/lib/librt.so.1", O_RDONLY)       = 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\30\0\0004\0\0\0\230"..., 512) = 512
> > > > mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb765b000
> > > > fstat64(3, {st_mode=S_IFREG|0755, st_size=30616, ...}) = 0
> > > > mmap2(NULL, 33364, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7652000
> > > > mmap2(0xb7659000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6) = 0xb7659000
> > > > close(3)                                = 0
> > > > open("/lib/libpthread.so.0", O_RDONLY)  = 3
> > > > read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360J\0\0004\0\0\0\354"..., 512) = 512
> > > > fstat64(3, {st_mode=S_IFREG|0755, st_size=88420, ...}) = 0
> > > > mmap2(NULL, 98828, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7639000
> > > > mmap2(0xb764e000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14) = 0xb764e000
> > > > mmap2(0xb7650000, 4620, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7650000
> > > > close(3)                                = 0
> > > > mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7638000
> > > > mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7636000
> > > > set_thread_area({entry_number:-1 -> 6, base_addr:0xb7636d80, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
> > > > mprotect(0xb764e000, 4096, PROT_READ)   = 0
> > > > mprotect(0xb7659000, 4096, PROT_READ)   = 0
> > > > mprotect(0xb77a2000, 8192, PROT_READ)   = 0
> > > > mprotect(0xb77ae000, 4096, PROT_READ)   = 0
> > > > mprotect(0xb785a000, 4096, PROT_READ)   = 0
> > > > munmap(0xb7837000, 17420)               = 0
> > > > set_tid_address(0xb7636de8)             = 3050
> > > > set_robust_list(0xb7636df0, 0xc)        = 0
> > > > futex(0xbfaaf560, FUTEX_WAKE_PRIVATE, 1) = 0
> > > > futex(0xbfaaf560, 0x189 /* FUTEX_??? */, 1, NULL, bfaaf570) = -1 EAGAIN (Resource temporarily unavailable)
> > > > rt_sigaction(SIGRTMIN, {0xb763d4f0, [], SA_SIGINFO}, NULL, 8) = 0
> > > > rt_sigaction(SIGRT_1, {0xb763d9c0, [], SA_RESTART|SA_SIGINFO}, NULL, 8) = 0
> > > > rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
> > > > getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
> > > > uname({sys="Linux", node="5410", ...})  = 0
> > > > rt_sigaction(SIGUSR1, {0xb77bec0a, [], SA_RESTART|SA_SIGINFO}, NULL, 8) = 0
> > > > futex(0xb77af06c, FUTEX_WAKE_PRIVATE, 2147483647) = 0
> > > > brk(0)                                  = 0x804e000
> > > > brk(0x806f000)                          = 0x806f000
> > > > gettimeofday({1339187216, 880428}, NULL) = 0
> > > > open("/dev/urandom", O_RDONLY|O_LARGEFILE) = 3
> > > > fcntl64(3, F_GETFD)                     = 0
> > > > fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
> > > > getuid32()                              = 0
> > > > gettimeofday({1339187216, 889603}, NULL) = 0
> > > > gettimeofday({1339187216, 894471}, NULL) = 0
> > > > read(3, "\275\0051F\215\373\371\202\377kfb/\362\303N"..., 16) = 16
> > > > clock_gettime(CLOCK_REALTIME, {1339187216, 902329405}) = 0
> > > > getuid32()                              = 0
> > > > geteuid32()                             = 0
> > > > rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
> > > > mmap2(NULL, 8388608, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) = 0xb6e36000
> > > > mprotect(0xb6e36000, 4096, PROT_NONE)   = 0
> > > > clone(child_stack=0xb7634d64, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, parent_tidptr=0xb7635bd8, {entry_number:6, base_addr:0xb7635b70, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}, child_tidptr=0xb7635bd8) = 3051
> > > > mmap2(NULL, 8388608, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) = 0xb6636000
> > > > mprotect(0xb6636000, 4096, PROT_NONE)   = 0
> > > > clone(child_stack=0xb6e34d64, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, parent_tidptr=0xb6e35bd8, {entry_number:6, base_addr:0xb6e35b70, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}, child_tidptr=0xb6e35bd8) = 3052
> > > > rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> > > > gettimeofday({1339187216, 974869}, NULL) = 0
> > > > futex(0xb7836e30, FUTEX_WAIT_PRIVATE, 0, {2, 927460405}) = -1 ETIMEDOUT (Connection timed out)
> > > > gettid()                                = 3050
> > > > write(2, "libust[3050/3050]: Error: Timed o"..., 107libust[3050/3050]: Error: Timed out waiting for ltt-sessiond (in lttng_ust_init() at lttng-ust-comm.c:912)
> > > > ) = 107
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
