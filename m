From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Could I enable a particular system call tracing
	in	LTTng 2.0
Date: Thu, 12 Jul 2012 13:10:21 -0400
Message-ID: <20120712171021.GA4937__14284.0571156286$1342113060$gmane$org@Krystal>
References: <CABy43G-toVGrA4s5AkMWk8f_F-q_V+3A+VQYxqTTV+hfYf-RmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SpMuG-0006gr-Ls
	for lttng-dev@lists.lttng.org; Thu, 12 Jul 2012 13:10:24 -0400
Content-Disposition: inline
In-Reply-To: <CABy43G-toVGrA4s5AkMWk8f_F-q_V+3A+VQYxqTTV+hfYf-RmQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Rui Han <r.han@umiami.edu>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Rui Han (r.han@umiami.edu) wrote:
> Hi,
> 
> I just start using LTTng for my project. I found the system call tracing is
> verbose. What if I only want have one or several particular syscalls
> logged, how could I do that? Is there an easy way to do this like for
> kernel events by "lttng enable-event sched_switch -k."?

No at this point, sorry.

Eventually, this could be done once the filter bytecode gets ported from
LTTng-UST to LTTng-modules, but we have no ETA on this at this point.

Thanks,

Mathieu

> 
> Thank you very much.
> 
> Regards,
> Rui

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
