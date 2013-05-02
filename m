From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Application freeze at startup with LTTng-UST
	and	Perl dlopen() - TRACEPOINT_PROBE_DYNAMIC_LINKAGE?
Date: Thu, 2 May 2013 09:47:49 -0400
Message-ID: <20130502134748.GG7035__36419.3366877318$1367502508$gmane$org@Krystal>
References: <20998D40D9A2B7499CA5A3A2666CB1EB19F97108@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UXtrT-0003Am-62
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 09:47:51 -0400
Content-Disposition: inline
In-Reply-To: <20998D40D9A2B7499CA5A3A2666CB1EB19F97108@ZURMSG1.QUANTUM.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David OShea <David.OShea@quantum.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi David,

Sorry for late reply,

* David OShea (David.OShea@quantum.com) wrote:
> Hi all,
> 
> I'm getting freezes at application startup with LTTng-UST which I
> assume are due to my lack of understanding of
> TRACEPOINT_PROBE_DYNAMIC_LINKAGE.
> 
> I'm running:
> - lttng-tools-2.0.4
> - lttng-ust-2.0.5 patched with 009745db "Cache the procname per-thread
> rather than per-process to take into account that prctl() can be used
> to set thread names." and e699eda "don't spawn per-user thread if HOME
> is not set".

please try to reproduce against lttng-ust/lttng-tools master branch.

> - liburcu0-0.7.4-0
> 
> This is being run on CentOS 5.4.
> 
> The lttng-ust man page says:
> 
> """
> BUILDING/LINKING THE TRACEPOINT PROVIDER
> [...]
>          1.1) Compile the Tracepoint provider with the application, either
>               directly or through a static library (.a):
> [...]
>          2) Compile the Tracepoint Provider separately from the application,
>             using dynamic linking:
>            - Into exactly one object of your application: define
>              "TRACEPOINT_DEFINE" _and_ also define
>              "TRACEPOINT_PROBE_DYNAMIC_LINKAGE", then include the tracepoint
>              provider header.	
> [...]
> """
> 
> I have a dynamic library that includes code with tracepoint() calls,
> plus the relevant tracepoint definitions and trace providers - it is
> sort of "self-contained".  My Perl script dlopen()s this dynamic
> library.  Am I correct in thinking that this falls into option 2)
> above, because whilst the trace provider is statically linked with the
> code that uses the tracepoints, the trace provider is being
> dynamically linked into the application, and that is the part that
> matters to LTTng? 

yes.

>  
> When I build this dynamic library without
> TRACEPOINT_PROBE_DYNAMIC_LINKAGE #defined in the tracepoint
> definitions,

Well, this is not the right approach for option 2).

> I get a freeze that looks like
> https://bugs.lttng.org/issues/142 from the strace output:
> 
> """
> open("/usr/lib64/liburcu-common.so.1", O_RDONLY) = 4
> read(4, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0p\7`\0310\0\0\0"..., 832) = 832
> fstat(4, {st_mode=S_IFREG|0755, st_size=9464, ...}) = 0
> mmap(0x3019600000, 2102552, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 4, 0) = 0x3019600000
> mprotect(0x3019602000, 2093056, PROT_NONE) = 0
> mmap(0x3019801000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 4, 0x1000) = 0x3019801000
> close(4)                                = 0
> mprotect(0x3fd3607000, 4096, PROT_READ) = 0
> munmap(0x2ae2a2766000, 49028)           = 0
> open("/dev/urandom", O_RDONLY)          = 4
> fcntl(4, F_GETFD)                       = 0
> fcntl(4, F_SETFD, FD_CLOEXEC)           = 0
> getuid()                                = 0
> getppid()                               = 8809
> read(4, "\266\310we\347u\31\336\33\266 \262C\3267\32", 16) = 16
> gettid()                                = 8810
> clock_gettime(CLOCK_REALTIME, {1361753274, 392351000}) = 0
> getuid()                                = 0
> geteuid()                               = 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
> mmap(NULL, 10489856, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_32BIT, -1, 0) = 0x4023d000
> mprotect(0x4023d000, 4096, PROT_NONE)   = 0
> clone(child_stack=0x40c3d250, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, parent_tidptr=0x40c3d9d0, tls=0x40c3d940, child_tidptr=0x40c3d9d0) = 8811
> mmap(NULL, 10489856, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_32BIT, -1, 0) = 0x41e43000
> mprotect(0x41e43000, 4096, PROT_NONE)   = 0
> clone(child_stack=0x42843250, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, parent_tidptr=0x428439d0, tls=0x42843940, child_tidptr=0x428439d0) = 8812
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> futex(0x2ae2a29a5a80, FUTEX_WAIT_PRIVATE, 0, {2, 999506000}) = -1 ETIMEDOUT (Connection timed out)
> gettid()                                = 8810
> write(2, "libust[8810/8810]: Error: Timed "..., 107libust[8810/8810]: Error: Timed out waiting for ltt-sessiond (in lttng_ust_init() at lttng-ust-comm.c:952)
> ) = 107
> futex(0x2ae2a29a5b00, FUTEX_WAIT_PRIVATE, 2, NULL
> """
> (freeze at this point)
> 
> I realise that bug 142 is fixed in the version of the code I'm running.
> 
> I also found that, even though the Perl script does not fork() (unless
> I'm very much mistaken),

I would not be surprised at all that perl would indeed use fork().

> if I 'export
> LD_PRELOAD=/usr/lib64/liblttng-ust-fork.so.0' and then run a shell
> script that invokes 'perl ...' to start the script, the problem goes
> away.

That would seem to confirm that perl itself indeed uses fork().

>  Is this because, when the shell fork()s to start Perl,
> liblttng-ust-fork.so.0 will cause LTTng to be initialised in the new
> process much earlier than is the case with just the dlopen()? 

it rather looks like perl is using fork() or clone().

> 
> I played around with another script and dynamic library combination
> and found a similar problem occurred on CentOS 5.4, but when I used
> the same LTTng-UST and related libraries on Fedora 16, I didn't get
> the freeze.
> 

trying with newer lttng-ust/lttng-tools version would be useful here.

> Finally, I noticed that commit ID
> b834deadbfa8a78ae1d00440fd91c41dfd351eba changed README to remove a
> note suggesting that dlopen() not be used.  It looks like the same
> change should be made to doc/man/lttng-ust.3, which still suggests
> that you not use dlopen().

Looking at lttng-ust master branch, it seems to be fixed now.

Thanks,

Mathieu

> 
> Thanks in advance,
> David
> 
> ----------------------------------------------------------------------
> The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
