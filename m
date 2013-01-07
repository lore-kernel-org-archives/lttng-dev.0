From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Reading cache misses in Userspace?
Date: Mon, 7 Jan 2013 08:47:44 -0500
Message-ID: <20130107134744.GB30165__2617.87322019718$1357566522$gmane$org@Krystal>
References: <50E8834D.1010802@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TsD3J-0007ua-Nm
	for lttng-dev@lists.lttng.org; Mon, 07 Jan 2013 08:47:45 -0500
Content-Disposition: inline
In-Reply-To: <50E8834D.1010802@gmx.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexander Kampmann <alexander.kampmann@gmx.de>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Alexander Kampmann (alexander.kampmann@gmx.de) wrote:
> hey,
>
> I would like to find out which part of my application causes most cache  
> misses. So I tried to add userspace events to my application. I hoped  
> LTTng would give me some mean of determining between which tracepoints  
> the most cache misses occur.
>
> I started a session like that:
>
> sudo lttng create session
> sudo lttng enable-event -a -u
> sudo lttng add-context -u -t perf:LLC-load-misses -t  
> perf:LLC-store-misses -t perf:LLC-prefetch-misses
>
> I get:
>
> Error: perf:LLC-prefetch-misses: UST invalid context
> Error: perf:LLC-store-misses: UST invalid context
> Error: perf:LLC-load-misses: UST invalid context
>
> Does this mean I can not add perf:LLC-* context to my userspace events?  
> Is there any way to figure out which part of my application causes cache  
> misses?

Currently, perf counters are only for kernel tracing (-k domain). We
envision using those counters from user-space when Linux kernel support
will be there.

>
> If I use
>
> sudo lttng add-context -k -t perf:LLC-load-misses -t  
> perf:LLC-store-misses -t perf:LLC-prefetch-misses
>
> instead, I don't get an error, but the babeltrace output does not  
> contain any cache miss counts as well.

Does it contain _any_ performance counters at all ?

Did you ensure that you issue add-context before you start tracing ?

How many performance counters does your machine have ? Shown by dmesg,
e.g.:

dmesg |grep "generic reg"

Thanks,

Mathieu

>
> I would appreciate any help,
>
> Alex
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
