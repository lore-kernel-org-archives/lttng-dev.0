From: Jan Glauber <jan.glauber@gmail.com>
Subject: Re: [Patch lttng-modules v2] ARM: Resolve sys_unknown
	system calls
Date: Tue, 15 Apr 2014 14:31:43 +0200
Message-ID: <20140415123142.GA27630__27535.0185497247$1397565235$gmane$org@hal>
References: <1397218426-782-1-git-send-email-jan.glauber@gmail.com>
 <348156896.34.1397230762859.JavaMail.zimbra@efficios.com>
 <20140414085656.GA32190@hal>
 <169220169.996.1397479301759.JavaMail.zimbra@efficios.com>
 <20140414133155.GA2531@hal>
 <1832763224.1125.1397483627230.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1Wa2Xz-0000y2-5C
 for lttng-dev@lists.lttng.org; Tue, 15 Apr 2014 08:33:09 -0400
Received: by mail-ee0-f53.google.com with SMTP id b57so7608662eek.26
 for <lttng-dev@lists.lttng.org>; Tue, 15 Apr 2014 05:33:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1832763224.1125.1397483627230.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Mon, Apr 14, 2014 at 01:53:47PM +0000, Mathieu Desnoyers wrote:
> ----- Original Message -----
> > From: "Jan Glauber" <jan.glauber@gmail.com>
> > To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> > Cc: lttng-dev@lists.lttng.org
> > Sent: Monday, April 14, 2014 9:31:58 AM
> > Subject: Re: [Patch lttng-modules v2] ARM: Resolve sys_unknown system calls
> > 
> > No. I'm currently stuck with that kernel version and I doubt the system call
> > extractor wont find a system call like sys_recv on a newer kernel.
> 
> Indeed, sys_recv, sys_sigreturn, sys_rt_sigreturn are still not defined with
> SYSCALL_DEFINE. However, on a current 3.15-rc1 kernel, we find:
> 
> fs/read_write.c:SYSCALL_DEFINE4(pread64, ....
> fs/read_write.c:SYSCALL_DEFINE4(pwrite64, ...
> kernel/fork.c:SYSCALL_DEFINE0(vfork)
> fs/open.c:SYSCALL_DEFINE2(ftruncate64, unsigned int, fd, loff_t, length)
> fs/statfs.c:SYSCALL_DEFINE3(fstatfs64, unsigned int, fd, size_t, sz, struct statfs64 __user *, buf)
> fs/open.c:SYSCALL_DEFINE4(fallocate, int, fd, int, mode, loff_t, offset, loff_t, len)

Found the reason why pread64 and the above system calls were not available.
The culprit is SYSCALL_DEFINE which in contrast to SYSCALL_DEFINEx define
(notice the x at the end) never had the meta data included.

This was fixed accidently by Al Viro during 3.10 by killing SYSCALL_DEFINE
in favor for the SYSCALL_DEFINEx variant (which adds the meta data).

x86_64 knows these system calls, because the list was extracted after
the upstream change.

That leaves sys_recv and the sigreturns, I'll follow that up on lkml.
 
> The overrides should be limited to the system calls unavailable in the
> current kernel version. Please run the system call extractor on a newer
> kernel, so we can get some of the missing definitions, and then only
> provide overrides for the missing ones. Each override we add means
> an extra maintenance burden for each architecture, which we want to
> keep minimal.

I don't want to go through this cumbersome extractor script madness
again and I cannot run a newer kernel anyway. If you don't want to
take the patch I'll leave it for now.

Regards, Jan
 
> Thanks,
> 
> Mathieu
> 
