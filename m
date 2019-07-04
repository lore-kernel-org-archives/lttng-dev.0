From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: events injection / merging traces
Date: Thu, 4 Jul 2019 12:18:51 -0400
Message-ID: <20190704161130.GA17843__9236.06605954177$1562257151$gmane$org@joraj-alpa>
References: <ed6a7951-d2eb-71ff-be87-dcdb07be7881@gmail.com>
 <20190704145226.GB9334@joraj-alpa>
 <74d67aa2-a9ba-6882-a079-a23879443ef5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45fjpT22Vnz10RJ
 for <lttng-dev@lists.lttng.org>; Thu,  4 Jul 2019 12:18:56 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 8485B25864B
 for <lttng-dev@lists.lttng.org>; Thu,  4 Jul 2019 12:18:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <74d67aa2-a9ba-6882-a079-a23879443ef5@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Carlo Caione <carlo.caione@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Carlo,

> 
> > This leads to, as always, whats is the end goal here?
> 
> This is the context: I'm tracing a Linux kernel (using LTTng) while in
> parallel I'm tracing a process running in a bare-metal OS (running on the
> same machine but on different cores using a partitioning hypervisor).

Nice.

> 
> The binary trace data obtained from the bare-metal OS is converted to CTF
> using babeltrace in a format resembling LTTng (to be analyzed with
> TraceCompass).

In both case, babeltrace and tracecompass based analysis should leave the trace
merging to the parser/decoder/muxer. There should be no need to merge them in a
single CTF trace.

The thing that is important is to correlate the clock from both traces to allow
the tools to do a proper merge. Then you consume the events and build state etc.
How you correlate those clocks depends on the tracing scenario.

I would recommend you speak to the Tracecompass devs [1] on how they handle multiple
"kernel" traces (linux + converted baremeta) in "experiment" [2] and how clock
correlation works [3] on their side. This is if you plan to mostly use
Tracecompass for analysis. If you plan to use babeltrace, we can discuss this
more as needed.

[1] https://www.eclipse.org/tracecompass/#community
[2] https://archive.eclipse.org/tracecompass/doc/stable/org.eclipse.tracecompass.doc.user/Trace-Compass-Main-Features.html#Creating_an_Experiment
[3] https://archive.eclipse.org/tracecompass/doc/stable/org.eclipse.tracecompass.doc.user/Time-offsetting.html#Time_offsetting

-- 
Jonathan Rajotte-Julien
EfficiOS
