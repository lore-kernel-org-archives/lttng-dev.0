From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Compat syscall instrumentation and return from execve issue
Date: Mon, 9 Nov 2015 16:12:16 -0500
Message-ID: <20151109161216.2af12ffd@gandalf.local.home>
References: <2095400880.57684.1447011457513.JavaMail.zimbra@efficios.com>
	<20151109110536.7bce67e8@gandalf.local.home>
	<5640F406.3020207@kernel.org>
	<20151109144309.361ab4e5@gandalf.local.home>
	<CALCETrU1O48_AHJW_+LHNSvvu5bYP1yJLOF4DVxhkiKQTj1oAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrU1O48_AHJW_+LHNSvvu5bYP1yJLOF4DVxhkiKQTj1oAQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>, "Anvin, H. Peter" <hpa@zytor.com>, lttng-dev <lttng-dev@lists.lttng.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

On Mon, 9 Nov 2015 12:57:06 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> > The solution I suggested wouldn't touch any asm code. The only change
> > would be to reserve the TS_EXECVE flag. Actually, come to think of it,
> > we could have Mathieu's TS_ORIG_COMPAT flag, and still only have the
> > tracepoint syscall set it, such that the matching tracepoint syscall
> > exit would know that the initial call was COMPAT or not.  
> 
> Someone needs to clear TS_EXECVE, though.

Well, it gets set and cleared by the syscall enter (same for
TS_ORIG_COMPAT), and exit for that matter.

It's trivial to have a tracepoint hook added when either system call
enter or exit tracepoints are enabled. Thus, the setting and clearing of
the flag can be done by another callback at those tracepoints.

> 
> >
> > The goal is only to make sure that the system call exit tracepoint
> > matches the system call enter tracepoint.
> >
> > The system call enter would set or clear the TS_ORIG_COMPAT if the
> > TS_COMPAT is set when entering the system call, and it would check that
> > flag when exiting the system call.  
> 
> This seems a bit odd, though, since we aren't very good about
> preserving the syscall nr or the args through syscall processing.  In
> any event, in the new improved x86 syscall code, we know what arch we
> are just by following the control flow, so no flags should be needed.
> Hence my suggestion of just adding an "unsigned int arch" to the
> return slowpath.

I guess I don't understand this "unsigned int arch".

When the execve system call is called, it's running in x86_64 mode, and
then the execve changes the state to ia32 bit mode. Then on return, the
tracepoint system call exit, has the x86_64 system call number, but if
it checks to see what state the task is in, it will see ia32 state, and
then report the number for ia32 instead.

For example, in x86_64, execve is 59, and that number is passed to the
system call enter tracepoint. Now on return of the system call, the
system call exit tracepoint gets called with 59 as the system call as
well, but if that tracepoint checks the state, it will think its
returning the "olduname" system call (that's 59 for ia32).

What change are you making to solve this?

-- Steve
