From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Compat syscall instrumentation and return from execve issue
Date: Mon, 9 Nov 2015 11:05:36 -0500
Message-ID: <20151109110536.7bce67e8@gandalf.local.home>
References: <2095400880.57684.1447011457513.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2095400880.57684.1447011457513.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Anvin, H. Peter" <hpa@zytor.com>, lttng-dev <lttng-dev@lists.lttng.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

On Sun, 8 Nov 2015 19:37:37 +0000 (UTC)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> I have a few ideas on how to overcome this, and would like your
> feedback on the matter:
> 
> 1) One possible approach would be to reserve an extra status flag
>    in struct thread_info to get the TS_COMPAT status at syscall
>    entry. It would _not_ be updated when the executable is loaded,
>    so the state at return from execve would match the state when
>    entering execve. This is a simple approach, but requires kernel
>    changes.

Or add a flag TS_EXECVE that can be set by the tracepoint syscall
enter, and checked on exit. If set, we know that the exec happened.

> 
> 2) Keep the compat state at system call entry in a data structure
>    (e.g. hash table) indexed by thread number within each tracer.
>    This could work around this issue within each tracer.

This is of course what you can do now. As it doesn't touch the kernel.

> 
> 3) Change the syscall number in the struct pt_regs whenever we
>    change the compat mode of a process. A 64-bit execve system
>    call number would be mapped to a 32-bit compat execve number,
>    or the opposite. This requires a kernel change, and seems to be
>    rather intrusive.
> 

This is a definite no.


I'm thinking the TS_EXECVE flag would be the least intrusive. Add a
comment that it is used by tracepoints to map between compat and
non-compat syscalls when execve switches the flag. This would not need
to touch any of the logic of the hotpaths within the systemcalls
themselves.

-- Steve
