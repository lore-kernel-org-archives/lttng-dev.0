From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: using --function/--probe
Date: Tue, 5 Jun 2012 11:49:50 -0400
Message-ID: <20120605154950.GA21955__13783.0902626321$1338911420$gmane$org@Krystal>
References: <3551.1338647739@cloud.rain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Sbw11-0001fM-Lf
	for lttng-dev@lists.lttng.org; Tue, 05 Jun 2012 11:49:51 -0400
Content-Disposition: inline
In-Reply-To: <3551.1338647739@cloud.rain.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Bill Trost <trost@cloud.rain.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Bill Trost (trost@cloud.rain.com) wrote:
> Hi,
> 
> I'm trying to investigate a problem under Linux 2.6.39.4 involving
> kworker threads and am pretty much stymied. I've tried enabling
> various events using --function and --probe and it's been
> very hit or miss. Very often, "lttng enable-event" comes back
> with nothing more specific than "bad ioctl", but every once
> in a while I'll find a symbol I can add a probe point for.
> 
> So: What does "--probe" mean?

--probe allows to put a kprobe (breakpoint) at a kernel text address or
symbol.

> What does "--function" mean,

--function allows to put a kretprobes at a function entry site (using
its symbol name), which will trigger events at function entry return.

> and how does
> it differ from "--probe"? How do I determine what symbols are valid for
> each of these options?

It entirely depends on which functions are blacklisted in the kernel
(this is an attribute added to the functions specifically for kprobes).
The keyword is "__kprobes".

> And, maybe as a worked example, how do I
> trace what work is being enqueued and run by the kworker threads?

For this level of details, I think kprobes/kretprobes will not currently
allow you to fetch it. The two options we have are:

- use static tracepoints. Is there a tracepoint that targets the
  information you are looking for ? Try "lttng list -k".
- or extend the dynamic probing to allow fetching variables from
  debug information,

Thanks,

Mathieu

> 
> Thanks,
> Bill
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
