From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Timestamps in kernel tracing with LTTng
Date: Wed, 14 Nov 2012 10:21:12 -0500
Message-ID: <20121114152112.GA31776__3143.52853824875$1352906945$gmane$org@Krystal>
References: <CACXZPnwjnCYPXkxpx6vO2y_jnP42=hNFn1Arwi1NJWkr_kZy3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TYemB-0001ZM-Dt
	for lttng-dev@lists.lttng.org; Wed, 14 Nov 2012 10:21:15 -0500
Content-Disposition: inline
In-Reply-To: <CACXZPnwjnCYPXkxpx6vO2y_jnP42=hNFn1Arwi1NJWkr_kZy3A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Vince Do <blackhole37@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Vince Do (blackhole37@gmail.com) wrote:
> Hello,
> 
> I was wondering if you can give me more information on how LTTng the
> timestamps are taken for a kernel trace, I have read in this article
> (Combined Tracing of the Kernel and Applications with LTTng at Linux
> Symposium 2009) that TSC and the command rdtsc are used, but the article is
> old (2009) and I would like to know if there are been any changes.

lttng uses the Linux kernel CLOCK_MONOTONIC clock, read through
clock_gettime() in user-space, and from ktime_get() in the kernel.

On x86 systems where TSC are synchronized and constant, it uses rdtsc,
scales that value to nanoseconds, and adds an offset. The fall-back is
usually the HPET timer on x86.

Thanks,

Mathieu

> 
> Regards,
> 
> 
> 
> Vincenzo Do

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
