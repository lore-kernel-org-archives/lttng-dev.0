From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Some questions about Lttng
Date: Wed, 20 Jun 2012 09:03:38 -0400
Message-ID: <20120620130338.GA25746__8285.39019353247$1340197772$gmane$org@Krystal>
References: <20120619163655.GC6743@Krystal>
	<6539770C71C3814BB0BFC2DBEBD105087FC418@CORPUSMX30B.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1ShKZQ-0004Gd-OU
	for lttng-dev@lists.lttng.org; Wed, 20 Jun 2012 09:03:40 -0400
Content-Disposition: inline
In-Reply-To: <6539770C71C3814BB0BFC2DBEBD105087FC418@CORPUSMX30B.corp.emc.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zheng.Chang@emc.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Zheng.Chang@emc.com (Zheng.Chang@emc.com) wrote:
> =

> > -----Original Message-----
> > From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com] =

> > Sent: Wednesday, June 20, 2012 0:37 AM
> > To: Francis Giraldeau
> > Cc: lttng-dev@lists.lttng.org
> > Subject: Re: [lttng-dev] Some questions about Lttng
> =

> > * Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> > > Le 2012-06-19 05:50, Zheng.Chang@emc.com a =E9crit :
> > > >
> > > > Hi folks,
> > > >
> > > >  =

> > > >
> > > > I'm studying how to use Lttng now. I built a kernel which version is
> > > > 2.6.38 and ran with lttng 2.0.
> > > >
> > > > I got some confused when I started to use it. Here are my questions:
> > > >
> > > >  =

> > > >
> > > > 1. I didn't see kernel patches for kernel 3.x. Does it mean kernel =
3.x
> > > > support it already?
> > > >
> > > =

> > > You don't need a kernel patch with lttng 2.0, only modules are requir=
ed.
> > > It uses the tracepoints already present in the kernel, and trace syst=
em
> > > calls, and uses perf performance counters and kprobes.
> > > =

> > > > 2. I tried to do something like, dump the arguments of system call,=
 or
> > > > dump a backtrace in a specified function. But the output of lttng is
> > > > very limited. Is there a way to do that with lttng?
> > > >
> > > =

> > > If system calls are enabled, arguments are supposed to be dumped (opt=
ion
> > > --syscall to lttng enable-event). If it's not the case, then are you
> > > sure you are using lttng 2.0 and not 0.12? ;) Because the older versi=
on
> > > has a different behavior. One additional note: few system calls do not
> > > have all their arguments decoded in lttng 2, but there are only a few.
> =

> > There is no backtrace dump feature in lttng 2.0.
> =

> > Arguments of system calls are almost all there on x86 32/64 and ARM.
> > What architecture are you using ?
> =

> =

> My tsetbed is x86 32bit and lttng's version is 2.0.1. You're right. I can=
 see the arguments now.
> =

> =

> > > =

> > > > 3. I looked into some UST examples and found here are three header
> > > > files:  tracepoint.h, tracepoint-event.h and ust-tracepoint-event.h.
> > > > They have some duplicated macro definitions like TRACEPOINT_EVENT.
> > > >
> > > =

> > > The macros are quite complicated. Some includes files are included mo=
re
> > > than once to generate various portion of the tracepoint code. So, my
> > > advice here is to take a working example and adapt it to your needs.
> =

> > Good advice.
> =

> > > =

> > > > And the examples includes all of these three header files despite no
> > > > conflict here. Could someone help to explain the intention?
> > > >
> > > > 4. Once I defined a tracepoint in my code, seems some initializatio=
ns
> > > > would register default probe into the hook point.  How to disable t=
he
> > > > default probe and  register my self-defined probes?
> > > >
> > > =

> > > You mean, call a custom function when tracepoint is executed? Maybe
> > > somebody else has an answer, but AFAIK this is not possible. But you
> > > could make a wrapper to your tracepoint and then call your additional
> > > function there.
> =

> > Yep, not possible. You'd have to wrap the tracepoint.
> =

> > > =

> > > > 5. Does lttng-ust support dynamic traceing like kprobe?
> > > >
> > > =

> > > AFAIK, the kernel tracer supports kprobe, but not UST. Maybe somebody
> > > else can confirm/infirm the dynamic tracepoint feature in user-space?
> =

> > This is correct.
> =

> > Thanks,
> =

> > Mathieu
> =

> > > =

> > > You can use a feature of GCC to regiter callback on function entry and
> > > exit, but since it executes for all functions, then the overhead is v=
ery
> > > high. You can have a look here:
> > > =

> > > https://github.com/giraldeau/workload-kit/blob/master/ust/cyg.c
> > > =

> > > Cheers,
> > > =

> > > Francis
> =

> =

> And here are some subsequent questions about lttng:
> =

> 6. Does lttng-ust support marker? Marker is easier to be compatible
> with the APIs like printf if we don't care its performance issue.

Not currently. We plan to implement a "tracepoint_printf" (or
trace_printf, not sure yet) that will behave similarly to the Linux
Kernel Markers (back in the early lttng 0.x days). This will definitely
fulfill your use-case, but it's just not there yet.

> 7. What's supposed to show with 'lttng list -u'? It's empty now. Is
> that possible to show the events defined in an application?

List of tracepoints in _currently running_ _registered_ applications
only. An application registers when linked with liblttng-ust.

> 8. What does disable-event command of lttng do? With the
> example(hello) provided by lttng-ust, I enabled all events with '-a
> -u' and then disabled them again.  I launched the example with gdb and
> dumped the tracepoint's structure and then found its state was active.
> It's supposed to be inactive here, right?

Can you provide the detail of commands you launched, and the result of
gdb printout ? Please run "hello" with LTTNG_UST_DEBUG=3D1 env. var set.

> BTW: I didn't see any trace generated here with view command.

That is after the disable, right ?

Also, did you do a lttng start at some point in your test ?

Thanks,

Mathieu

> =

> Thanks all for your useful info!
> =

> Best regards
> Zheng
> =

> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =

> =

> > -- =

> > Mathieu Desnoyers
> > Operating System Efficiency R&D Consultant
> > EfficiOS Inc.
> > http://www.efficios.com
> =

> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =


-- =

Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
