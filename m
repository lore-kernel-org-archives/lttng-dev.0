From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Measure loop rate
Date: Thu, 23 Jan 2020 14:53:01 -0500
Message-ID: <20200123195301.GA8988@joraj-alpa>
References: <CAJYn_wgBrfB+nY8nSajyDUnj81sOr6Q9wb5MFhiW5ShC5n8Kvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 483Xxv2d4cz1sZH
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jan 2020 14:53:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B1D90243726
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jan 2020 14:53:06 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAJYn_wgBrfB+nY8nSajyDUnj81sOr6Q9wb5MFhiW5ShC5n8Kvw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: bhanu kiran chaluvadi <nthdimensionalreality@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

On Wed, Jan 22, 2020 at 06:28:14PM +0100, bhanu kiran chaluvadi wrote:
> Hi ,
> 
> I am trying to observer loop rate of a while loop.  Ideally it should take
> maximum of 2 ms to finish the cycle (500 Hz at least). And i would like to
> trace the loop rate using LTTng user space. whats the better way of doing
> it ..Just place one trace point at the start and one at the end ? or is
> there any library that i can take advantage of?

I'm not completely sure what you mean by "loop rate" but if you are looking for
the duration of a single iteration of your while loop then yes, one at the start
and one at the end. Keep in mind that tracing is *not* free and that you will
need to account for the tracing overhead here. I would suggest having no payload
at all if you can.

There is other ways of deducing the time taken by one iteration (time_for_n/n)
to reduce impact of tracing if you can have an upper bound (or know the number
of iterations that took place) for the number of iterations but it will only
give you the mean time for the loop execution. In that case, the tracepoints
would be outside the while loop.

You could also hit an event only each X loop iterations and deduce the
rate from there. Keep in mind that this will require accounting and
will add to the workload etc.

It all depends on the granularity you are looking for.

Cheers
-- 
Jonathan Rajotte-Julien
EfficiOS
