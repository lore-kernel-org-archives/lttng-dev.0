From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Compat syscall instrumentation and return from execve issue
Date: Tue, 10 Nov 2015 01:39:01 +0000 (UTC)
Message-ID: <1800505568.71478.1447119541972.JavaMail.zimbra@efficios.com>
References: <2095400880.57684.1447011457513.JavaMail.zimbra@efficios.com> <20151109110536.7bce67e8@gandalf.local.home> <5640F406.3020207@kernel.org> <20151109144309.361ab4e5@gandalf.local.home> <CALCETrU1O48_AHJW_+LHNSvvu5bYP1yJLOF4DVxhkiKQTj1oAQ@mail.gmail.com> <20151109161216.2af12ffd@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151109161216.2af12ffd@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: rostedt <rostedt@goodmis.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, lttng-dev <lttng-dev@lists.lttng.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

----- On Nov 9, 2015, at 4:12 PM, rostedt rostedt@goodmis.org wrote:

> On Mon, 9 Nov 2015 12:57:06 -0800
> Andy Lutomirski <luto@amacapital.net> wrote:
> 
>> > The solution I suggested wouldn't touch any asm code. The only change
>> > would be to reserve the TS_EXECVE flag. Actually, come to think of it,
>> > we could have Mathieu's TS_ORIG_COMPAT flag, and still only have the
>> > tracepoint syscall set it, such that the matching tracepoint syscall
>> > exit would know that the initial call was COMPAT or not.
>> 
>> Someone needs to clear TS_EXECVE, though.
> 
> Well, it gets set and cleared by the syscall enter (same for
> TS_ORIG_COMPAT), and exit for that matter.
> 
> It's trivial to have a tracepoint hook added when either system call
> enter or exit tracepoints are enabled. Thus, the setting and clearing of
> the flag can be done by another callback at those tracepoints.

There is one issue with relying on the tracepoint hook on system call
enter to set the status flag (whichever of TS_EXECVE or TS_ORIG_COMPAT):
let's suppose a thread is preempted for a rather long time between
syscall enter and syscall exit, within an execve system call. At that
point, we enable syscall tracing. This means we may have missed setting
or clearing TS_ORIG_COMPAT, and we then hit the syscall exit tracepoint
with the flag uninitialized.

So if we go for this kind of flag solution, we have two choices:

1) We always set/clear the TS_ORIG_COMPAT flag on system call entry, not
   just within a tracepoint which can be dynamically wired up at arbitrary
   point in time.

2) We set/clear the TS_ORIG_COMPAT flag within the syscall entry tracepoint,
   but whenever we wire up that tracepoint, we iterate on all existing threads
   to figure out if a thread is currently running or preempted within an
   execve system call.

Option 2 seems rather more complicated, but has the upside of not setting
the flag when tracing is inactive. I'm really not sure that the tiny overhead
of setting a flag non-atomically is worth the trouble of doing option 2
though.

> 
>> 
>> >
>> > The goal is only to make sure that the system call exit tracepoint
>> > matches the system call enter tracepoint.
>> >
>> > The system call enter would set or clear the TS_ORIG_COMPAT if the
>> > TS_COMPAT is set when entering the system call, and it would check that
>> > flag when exiting the system call.
>> 
>> This seems a bit odd, though, since we aren't very good about
>> preserving the syscall nr or the args through syscall processing.  In
>> any event, in the new improved x86 syscall code, we know what arch we
>> are just by following the control flow, so no flags should be needed.
>> Hence my suggestion of just adding an "unsigned int arch" to the
>> return slowpath.
> 
> I guess I don't understand this "unsigned int arch".
> 
> When the execve system call is called, it's running in x86_64 mode, and
> then the execve changes the state to ia32 bit mode. Then on return, the
> tracepoint system call exit, has the x86_64 system call number, but if
> it checks to see what state the task is in, it will see ia32 state, and
> then report the number for ia32 instead.
> 
> For example, in x86_64, execve is 59, and that number is passed to the
> system call enter tracepoint. Now on return of the system call, the
> system call exit tracepoint gets called with 59 as the system call as
> well, but if that tracepoint checks the state, it will think its
> returning the "olduname" system call (that's 59 for ia32).
> 
> What change are you making to solve this?

I share your concern that Andy's proposal does not appear to address the
issue at hand. But I may be missing something too. Our issue is not about
knowing the current architecture when returning from execve system call;
we very well know that with is_compat_arch(). The issue is the mismatch
between the system call number that led us there and the current arch
when returning from execve to userspace.

Thanks,

Mathieu

> 
> -- Steve

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
