From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Compat syscall instrumentation and return from execve issue
Date: Mon, 9 Nov 2015 14:43:09 -0500
Message-ID: <20151109144309.361ab4e5@gandalf.local.home>
References: <2095400880.57684.1447011457513.JavaMail.zimbra@efficios.com>
	<20151109110536.7bce67e8@gandalf.local.home>
	<5640F406.3020207@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5640F406.3020207@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>, "Anvin, H. Peter" <hpa@zytor.com>, lttng-dev <lttng-dev@lists.lttng.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

On Mon, 9 Nov 2015 11:29:10 -0800
Andy Lutomirski <luto@kernel.org> wrote:

> > I'm thinking the TS_EXECVE flag would be the least intrusive. Add a
> > comment that it is used by tracepoints to map between compat and
> > non-compat syscalls when execve switches the flag. This would not need
> > to touch any of the logic of the hotpaths within the systemcalls
> > themselves.  
> 
> Let's make it really simple: add an 'unsigned int arch' to 
> syscall_return_slowpath.  As of last week, Linus' tree sends all compat 
> returns, without exception (except brand new children, depending on your 
> point of view), through that path, and the caller always knows the 
> architecture.
> 
> But keep in mind that any games you play here are going to get 
> completely and utterly screwed up if anyone is playing with ptrace to 
> change syscall numbers.  You'd also going to have problems with syscall 
> restart, sigreturn, etc, so it would be nice to have an argument that 
> the putative solution solves the problem for real instead of just adding 
> complexity to paper it over.
> 
> Meanwhile, I'm trying to remove all of the magic from the handling of 
> execve, and I'm half-way there.  Let's please not add more, especially 
> if that magic needs to touch asm code.

The solution I suggested wouldn't touch any asm code. The only change
would be to reserve the TS_EXECVE flag. Actually, come to think of it,
we could have Mathieu's TS_ORIG_COMPAT flag, and still only have the
tracepoint syscall set it, such that the matching tracepoint syscall
exit would know that the initial call was COMPAT or not.

The goal is only to make sure that the system call exit tracepoint
matches the system call enter tracepoint.

The system call enter would set or clear the TS_ORIG_COMPAT if the
TS_COMPAT is set when entering the system call, and it would check that
flag when exiting the system call.

-- Steve
