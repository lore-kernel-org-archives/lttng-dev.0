From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Compat syscall instrumentation and return from execve issue
Date: Wed, 11 Nov 2015 17:08:27 -0800
Message-ID: <CALCETrVL2BqDEcmFpQ_jDp6C35qEMg1V2sVMHhuE3D9LA2Z1jg@mail.gmail.com>
References: <2095400880.57684.1447011457513.JavaMail.zimbra@efficios.com>
 <20151109110536.7bce67e8@gandalf.local.home> <5640F406.3020207@kernel.org>
 <20151109144309.361ab4e5@gandalf.local.home> <CALCETrU1O48_AHJW_+LHNSvvu5bYP1yJLOF4DVxhkiKQTj1oAQ@mail.gmail.com>
 <20151109161216.2af12ffd@gandalf.local.home> <CALCETrWstqEStWLFLvtridbc7CFzfv98QgZ44AiJpkU84yvVNw@mail.gmail.com>
 <20151109213109.639071d7@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151109213109.639071d7@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Lutomirski <luto@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>, "Anvin, H. Peter" <hpa@zytor.com>, lttng-dev <lttng-dev@lists.lttng.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

On Mon, Nov 9, 2015 at 6:31 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 9 Nov 2015 17:51:25 -0800
> Andy Lutomirski <luto@amacapital.net> wrote:
>
>
>> do_syscall_32_irqs_on would call syscall_return_slowpath(regs,
>> AUDIT_ARCH_I386).  do_syscall_64 (which doesn't exist yet) would call
>> syscall_return_slowpath(regs, AUDIT_ARCH_X86_64).
>>
>
> OK, so you are saying that a execve that switches the current state
> into ia32 will return from the do_syscall_64 regardless? Then we would
> have to add tracepoints that would be for both ia32 and x86_64. But
> that would solve the current issue at hand.
>

Indeed.  Unlike fork/clone, execve is only magical insofar as it does
magical things to task_struct and it enters in the 64-bit native case
through a nasty asm path.  The former has no effect on the entry code
(except most likely blocking opportunistic sysret because we're a bit
silly and it might break ABI to change that), and the latter barely
matters for this purpose.  In any event, I'm planning on getting rid
of the asm stub for 4.5 if I can get the code written and tested in
time.

--Andy




-- 
Andy Lutomirski
AMA Capital Management, LLC
