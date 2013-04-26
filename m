From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Changed scheduling when using lttng
Date: Fri, 26 Apr 2013 11:14:45 -0400
Message-ID: <20130426151444.GA2260__19140.6942940832$1366989313$gmane$org@Krystal>
References: <CA+xJJ18hL16P3gvowveWVfg+ZNh=cjEFOoPisznU0y28YfCdbw@mail.gmail.com>
	<20130425151213.GC7970@Krystal>
	<CA+xJJ1-U_Y0DuLNJ+xwBLPLF+5LyS=mO4f7onpquEHSrbyOUAQ@mail.gmail.com>
	<20130426132639.GA1468@Krystal>
	<CA+xJJ19OE=nrfpEoOEib-7=GrP9hD-RV7bc=aY7nqDwB59auXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UVkMK-0003vV-Ik
	for lttng-dev@lists.lttng.org; Fri, 26 Apr 2013 11:14:48 -0400
Content-Disposition: inline
In-Reply-To: <CA+xJJ19OE=nrfpEoOEib-7=GrP9hD-RV7bc=aY7nqDwB59auXQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mats Liljegren <liljegren.mats2@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Mats Liljegren (liljegren.mats2@gmail.com) wrote:
> On Fri, Apr 26, 2013 at 3:26 PM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> > * Mats Liljegren (liljegren.mats2@gmail.com) wrote:
> >> On Thu, Apr 25, 2013 at 5:12 PM, Mathieu Desnoyers
> >> <mathieu.desnoyers@efficios.com> wrote:
> >> > Hi Mats,
> >> >
> >> > The ring buffer uses the standard "timers" in the kernel to flush the
> >> > buffers periodically, which prevents your kernel from going into nohz.
> >> > Originally, when implemented as a patch on the Linux kernel, the ring
> >> > buffer design had hooks in the nohz kernel events to disable this timer
> >> > when going to nohz. Now, given LTTng is a kernel module, it cannot
> >> > modify the kernel code, and no callback mechanism exists for nohz.
> >> >
> >> > There are two ways to work around this issue that does not require
> >> > modifying the Linux kernel:
> >> >
> >> > 1) Implement RING_BUFFER_WAKEUP_BY_WRITER within lttng-modules ring
> >> >    buffer.
> >> >
> >> >   it should become used by default if the following is specified at
> >> >   channel creation:
> >> >
> >> >   lttng enable-channel mychan -k --read-timer 0
> >> >
> >> >   It can be an issue if you want to trace page fault, and instrument
> >> >   code sensitive to lock usage (when using WAKEUP_BY_WRITER, the tracer
> >> >   is not lock-free anymore). It's the main reason why I have not
> >> >   implemented this mode yet: making sure the tracer never breaks the
> >> >   kernel in this mode is trickier.
> >> >
> >> > 2) use deferrable timers. It's a hack, but it should allow our timers to
> >> >    be inhibited when the cpus go in nohz.
> >> >
> >> > Sorry, low-impact on nohz has not really been on our sponsor's priority
> >> > lists so far.
> >> >
> >> > Thanks,
> >> >
> >> > Mathieu
> >>
> >> I tried number 1 using --read-timer 0, but "lttng stop" hanged at
> >> "Waiting for data availability", producing lots of dots...
> >
> > As I said, we'd need to implement RING_BUFFER_WAKEUP_BY_WRITER when
> > read-timer is set to 0. It's not implemented currently.
> >
> >>
> >> Would it be possible to let some other (not using nohz mode) CPU to
> >> flush the buffers?
> >
> > I guess that would be option 3) :
> >
> > Another option would be to let a single thread in the consumer handle
> > the read-timer for all streams of the channel, like we do for UST.
> 
> Ehm, well, you did say something about implement... Sorry for missing that.
> 
> I guess now the question is which option that gives best
> characteristics for least amount of work... Without knowing the design
> of lttng-module, I'd believe that simply having the timer on another
> CPU should be a good candidate. Is there anything to watch out for
> with this solution?
> 
> Are there any documents describing lttng-module design, or is it "join
> the force, use the source"? I've seen some high-level description
> showing how tools/libs/modules fit together, but I haven't found
> anything that describes how lttng-modules is designed.

Papers on the ring buffer design exist, but not on lttng-modules per se.

I think the best solution in the shortest amount of time would be (2):
using deferrable timers. It's just flags to pass to timer creation.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
