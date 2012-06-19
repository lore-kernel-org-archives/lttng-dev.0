From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Some questions about Lttng
Date: Tue, 19 Jun 2012 12:36:55 -0400
Message-ID: <20120619163655.GC6743__29772.060577716$1340123864$gmane$org@Krystal>
References: <6539770C71C3814BB0BFC2DBEBD105087948C2@CORPUSMX30B.corp.emc.com>
	<4FE04621.3070806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Sh1QG-00037G-Uo
	for lttng-dev@lists.lttng.org; Tue, 19 Jun 2012 12:36:56 -0400
Content-Disposition: inline
In-Reply-To: <4FE04621.3070806@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Giraldeau <francis.giraldeau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> Le 2012-06-19 05:50, Zheng.Chang@emc.com a =E9crit :
> >
> > Hi folks,
> >
> >  =

> >
> > I'm studying how to use Lttng now. I built a kernel which version is
> > 2.6.38 and ran with lttng 2.0.
> >
> > I got some confused when I started to use it. Here are my questions:
> >
> >  =

> >
> > 1. I didn't see kernel patches for kernel 3.x. Does it mean kernel 3.x
> > support it already?
> >
> =

> You don't need a kernel patch with lttng 2.0, only modules are required.
> It uses the tracepoints already present in the kernel, and trace system
> calls, and uses perf performance counters and kprobes.
> =

> > 2. I tried to do something like, dump the arguments of system call, or
> > dump a backtrace in a specified function. But the output of lttng is
> > very limited. Is there a way to do that with lttng?
> >
> =

> If system calls are enabled, arguments are supposed to be dumped (option
> --syscall to lttng enable-event). If it's not the case, then are you
> sure you are using lttng 2.0 and not 0.12? ;) Because the older version
> has a different behavior. One additional note: few system calls do not
> have all their arguments decoded in lttng 2, but there are only a few.

There is no backtrace dump feature in lttng 2.0.

Arguments of system calls are almost all there on x86 32/64 and ARM.
What architecture are you using ?

> =

> > 3. I looked into some UST examples and found here are three header
> > files:  tracepoint.h, tracepoint-event.h and ust-tracepoint-event.h.
> > They have some duplicated macro definitions like TRACEPOINT_EVENT.
> >
> =

> The macros are quite complicated. Some includes files are included more
> than once to generate various portion of the tracepoint code. So, my
> advice here is to take a working example and adapt it to your needs.

Good advice.

> =

> > And the examples includes all of these three header files despite no
> > conflict here. Could someone help to explain the intention?
> >
> > 4. Once I defined a tracepoint in my code, seems some initializations
> > would register default probe into the hook point.  How to disable the
> > default probe and  register my self-defined probes?
> >
> =

> You mean, call a custom function when tracepoint is executed? Maybe
> somebody else has an answer, but AFAIK this is not possible. But you
> could make a wrapper to your tracepoint and then call your additional
> function there.

Yep, not possible. You'd have to wrap the tracepoint.

> =

> > 5. Does lttng-ust support dynamic traceing like kprobe?
> >
> =

> AFAIK, the kernel tracer supports kprobe, but not UST. Maybe somebody
> else can confirm/infirm the dynamic tracepoint feature in user-space?

This is correct.

Thanks,

Mathieu

> =

> You can use a feature of GCC to regiter callback on function entry and
> exit, but since it executes for all functions, then the overhead is very
> high. You can have a look here:
> =

> https://github.com/giraldeau/workload-kit/blob/master/ust/cyg.c
> =

> Cheers,
> =

> Francis



> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- =

Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
