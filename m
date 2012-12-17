From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng: How to enable larger buffers?
Date: Mon, 17 Dec 2012 13:26:13 -0500
Message-ID: <20121217182613.GA9866__15188.2902290255$1355768821$gmane$org@Krystal>
References: <80B89753B40C5141A3E2D53FE7A2A8A930031959@NTXBOIMBX02.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TkfOJ-0000wV-1j
	for lttng-dev@lists.lttng.org; Mon, 17 Dec 2012 13:26:15 -0500
Content-Disposition: inline
In-Reply-To: <80B89753B40C5141A3E2D53FE7A2A8A930031959@NTXBOIMBX02.micron.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Sam Bradshaw (sbradshaw)" <sbradshaw@micron.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

You'll want to look at:

lttng enable-channel --help

(specifically --subbuf-size and --num-subbuf options).

and you'll need to specify a channel name for the events you enable (see
lttng enable-event --help).

Thanks,

Mathieu

* Sam Bradshaw (sbradshaw) (sbradshaw@micron.com) wrote:
> Hello,
> 
> I'm trying to use lttng tools to identify some block stack latencies.  I'm tracing
> syscall, softirq_*, and block_* kernel entry points using the latest 2.0 lttng on
> RHEL 6.3 with a 3.6.6 kernel.
> 
> When I 'lttng view' the trace, I get all sorts of messages like:
> 
> "[warning] Tracer discarded XXXX events between <timestamp1> and <timestamp2>.  You
> should consider recording a new trace with larger buffers or with fewer events 
> enabled."
> 
> How/where do I modify the code to enable larger buffers?  Its not obvious from any
> of the documentation I could find or a superficial code inspection.
> 
> Thanks,
> -Sam
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
