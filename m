From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Feedback on your ARM LTTng benchmarks
Date: Thu, 12 Sep 2013 20:45:22 -0400
Message-ID: <20130913004522.GA15154__43136.2893119969$1379033183$gmane$org@Krystal>
References: <20130912214457.GA7783@Krystal> <52323FE0.2050904@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VKHVl-0006ND-Tg
	for lttng-dev@lists.lttng.org; Thu, 12 Sep 2013 20:45:31 -0400
Content-Disposition: inline
In-Reply-To: <52323FE0.2050904@canonical.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Colin Ian King <colin.king@canonical.com>
Cc: lttng-dev@lists.lttng.org, kernel-team@lists.ubuntu.com
List-Id: lttng-dev@lists.lttng.org

* Colin Ian King (colin.king@canonical.com) wrote:
> Hi Mathieu,
> 
> On 12/09/13 22:44, Mathieu Desnoyers wrote:
> > Hi Colin,
> > 
> > I just read your post on:
> > 
> > https://lists.ubuntu.com/archives/kernel-team/2013-May/028450.html
> > 
> > and, although I'm very pleased to see that LTTng provides good
> > performances in your tests, there is a small detail on your benchmarking
> > approach I would like to bring to your attention. If you followed the
> > benchmarking procedure used by Romik Guha Anjoy and Soumya Kanti
> > Chakraborty's "Efficiency of Lttng as a Kernel and Userspace Tracer"
> > work, you only have part of the picture. I pointed this issue to them
> > when I stumbled on their work after it has been published.
> > 
> > You see, they only benchmark the equivalent of lttng-consumerd and
> > lttng-sessiond (in the lttng 0.x days, that was lttd). They entirely
> > miss the impact of the lttng-modules kernel tracer and lttng-ust
> > userspace tracer: the parts that write into the ring buffers.
> > 
> > This part is slightly harder to benchmark. This is why I relied on
> > system benchmarks with typical workloads to measure the overall system
> > slowdown in my thesis
> > (http://www.lttng.org/pub/thesis/desnoyers-dissertation-2009-12.pdf)
> > rather than use profiling.
> > 
> > If you only profile lttng-sessiond and lttng-consumerd, you will end up
> > noticing a very tiny impact indeed: while tracing is active,
> > lttng-sessiond is almost never active. lttng-consumerd needs to
> > transport the data, which indeed brings some overhead. However, if you
> > use lttng's flight recorder tracing (with snapshots) introduced in lttng
> > 2.3, the consumerd is entirely out of the picture: it's just writing
> > into memory buffers.  Even then, the lttng-modules and lttng-ust parts
> > of the tracer have _some_ impact when writing into the buffers from the
> > kernel and user-space application contexts.
> > 
> > So overall, there is a part of the lttng footprint not accounted for.
> > It's very small, but it exists.
> 
> That is very useful to know, many thanks for the clarification. Do you
> have any ARM based benchmarks that can give us an idea of the overhead
> that I failed to account for?

Yes, but they will only give a basic estimate I'm afraid. If we look at
my thesis dissertation, p. 87 Section 5.5.2 Probe CPU-cycles overhead,
we have the following figures:

Architecture      Cycles   Core freq.   Time
                              (GHz)     (ns)
Intel Pentium 4    545         3.0      182
AMD Athlon64 X2    628         2.0      314
Intel Core2 Xeon   238         2.0      119
ARMv7 OMAP3        507         0.5     1014

A couple of things to consider here:
- this is for a microbenchmark, where all the system is doing is writing
  events into the ring buffer, so it may fail to take into account
  instruction cache size, data cache size, TLB pollution and BPB
  pollution effects that come into play when the entire system is active,
- this is against lttng 0.x, not 2.x, and the ring buffer implementation
  has changed a lot between the two,

But on an ARMv7 OMAP3, we had a factor 8.5 slowdown of the probes
between Intel Core2 Xeon and ARMv7. I don't have numbers against OMAP4
for lttng 2.x, and I would be very interested to see them.

> 
> > 
> > I just want to make sure that nobody can say later than "lttng is fast"
> > claim is based on bogus benchmarks. It is very fast, yes, but I
> > recommend revisiting your benchmarking approach if you based it solely
> > on Romik Guha Anjoy and Soumya Kanti Chakraborty's work.
> 
> > 
> > On typical benchmarks, my own results were usually under 5% of overhead
> > system-side (see my thesis for details).
> 
> Is that specific to any particular architecture? I was concerned about
> the impact on processors with relatively small instruction and data
> caches such as ARM processors.

Yes, this was against Intel Core2 Xeon. I'd be interested to see those
numbers against ARM OMAP4. If you really care about getting precise
overhead numbers, I would recommend the following benchmarks, which I
used for my thesis:

- tbench: see how much tracing degrades network throughput,
- dbench: similar for disk throughput,
- lmbench to test the speed degradation of specific system calls when
  tracing,
- gcc benchmark, for CPU intensive workload which uses the scheduler
  very heavily and forks lots of processes (short-lived) if you compile
  e.g. the Linux kernel. Don't forget to use /proc/sys/vm/drop_caches to
  ensure your filesystem cache is in a pristine state prior to each run
  (or do a cache-priming run first),
- you might want to run those benchmarks both in flight recorder mode
  (lttng 2.3 new "snapshot" mode, very cool, try it out, it's amazingly
  fast!) ;-) as well as when tracing to disk, and while tracing to the
  network (streaming).

The basic idea is to have a repeatable benchmark, and see how fast it
completes (or what throughput it can reach) with and without tracing.

Thanks!

Mathieu


>
> > 
> > Thank you !
> > 
> > Mathieu
> > 
> Thanks again for taking the effort to enlighten me.
> 
> Regards,
> 
> Colin

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
