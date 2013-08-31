From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Tracepoints overhead in x86_64
Date: Sat, 31 Aug 2013 16:21:07 -0400
Message-ID: <20130831202107.GA21499__41651.8556456596$1377980524$gmane$org@Krystal>
References: <CAJWsiu=og9Xnt4m31e1KGqDnEaCq9QWe8HnW5RE4foh4KCo5XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VFrfT-0008HD-RE
	for lttng-dev@lists.lttng.org; Sat, 31 Aug 2013 16:21:17 -0400
Content-Disposition: inline
In-Reply-To: <CAJWsiu=og9Xnt4m31e1KGqDnEaCq9QWe8HnW5RE4foh4KCo5XA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Gianluca Borello <g.borello@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Gianluca Borello (g.borello@gmail.com) wrote:
> Hello,
> 
> This question is more focused on tracepoints rather than LTTng, so feel
> free to point me at LKML if I'm too off topic.
> 
> I am looking for a way to trace all the system call activity 24/7 (and do
> some very customized processing, so LTTng doesn't fit very well in the
> picture), and I have the specific requirement that the overhead must be
> extremely slow, even in the worst case.

extremely "low" I guess ;-)

> 
> Being a LTTng user myself, I figured tracepoints would be the first natural
> choice, so what I did was writing a small kernel module that does nothing
> but registering an empty probe for "sys_enter" and "sys_exit", and I am a
> bit concerned about the results that I obtained on my Intel Core i3 running
> linux 3.8.0.
> 
> Basically this is my worst case:
> 
> while(1)
> {
> close(5000);
> }
> 
> I let this run for 10 seconds, and these are the numbers that I get:
> 
> - without tracepoints: 13.1M close/s
> - with tracepoints: 4.1M close/s

First thing: this is really "system call tracepoints", and not the
tracepoint mechanism per se. (kernel option:
CONFIG_HAVE_SYSCALL_TRACEPOINTS if available on the architecture). We
cannot blame the tracepoints overall for the system call tracepoints,
since those are two very different instrumentation mechanisms.

> 
> The overhead is far from being negligible, and digging into the problem it
> seems like when the tracepoints are enabled, the system doesn't go through
> the "system_call_fastpath" (in arch/x86/kernel/entry_64.S), using IRET
> instead of SYSRET (A relevant commit seems this:
> https://github.com/torvalds/linux/commit/7bf36bbc5e0c09271f9efe22162f8cc3f8ebd3d2
> ).

indeed, I suspect this can have a big impact on performances.

> 
> This is the first time I look into these things so understanding the logic
> behind is pretty hard for me, but I managed to write a quick and dirty hack
> that just forces a call to "trace_sys_enter" and "trace_sys_exit" in the
> fast path (you can find the patch attached, I didn't have a lot of time to
> spend on this so it's pretty inefficient because I do a bunch of
> instructions even if the tracepoints are not enabled and there are obvious
> bugs if the ptrace code gets enabled, but it proves my point) and these are
> the results:
> 
> - without tracepoints (patched kernel): 11.5M close()/s
> - with tracepoints (patched kernel): 9.6M close()/s
> 
> Of course my benchmark is an extreme situation, but measuring in a more
> realistic scenario (using apache ab to stress a nginx server) I can still
> notice a difference:
> 
> - without tracepoints: 16K HTTP requests/s
> - with tracepoints: 15.1K HTTP requests/s
> - without tracepoints (patched kernel): 16K HTTP requests/s
> - with tracepoints (patched kernel): 15.8K HTTP requests/s
> 
> It's a real 6% vs 1% worst case overhead when using an intense server
> application, and that doesn't count the cost of executing the body of the
> probes themselves.
> 
> Has anyone ever faced this before? Am I just inexperienced with the topic
> and stating the obvious? Are there any suggestions or documentation I
> should look at?

A bit of history: you will notice that system call tracepoints are based
on the same function that is used when ptrace, system call audit,
seccomp are enabled for a given thread: these are all considered a slow
path, therefore, the utterly optimized case is when those features are
_not_ enabled, at the expense of extra overhead when they are enabled.

The basic mechanism is to test for a set of flags, and jump to a slow
path in entry*.S, which saves extra registers and calls an extra
function (syscall_trace_enter, syscall_trace_leave) at system call entry
and exit.

My recommendation would be to implement a dummy trace_sys_enter and
trace_sys_exit, and then benchmark the overhead of enabling system call
tracing (this will set TIF_SYSCALL_TRACEPOINT in every thread). So at
least it would help you pinpoint where most of the overhead comes from.

Indeed, if you come up with ways to shrink the overhead of this "slow
path", I'm sure the LTTng community would gladly welcome this. Of
course, these changes would have to be proposed to the Linux kernel
community. You will need to keep in mind that they will frown upon
pretty much _any_ slowdown of the fast path (common case, no tracing)
for improving the speed of the slow (uncommon) case.

> 
> Thank you for your help and for the amazing work on LTTng.

You're welcome! I'm glad you like it!

Mathieu


> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
