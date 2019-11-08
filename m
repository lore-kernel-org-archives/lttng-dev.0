From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Workflow to view old and current trace data
Date: Fri, 8 Nov 2019 11:49:13 -0500 (EST)
Message-ID: <1837941094.5984.1573231753657.JavaMail.zimbra__34225.1604584575$1573231775$gmane$org@efficios.com>
References: <20191108084938.GA7492@f3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 478mSw6B6gzrG5
 for <lttng-dev@lists.lttng.org>; Fri,  8 Nov 2019 11:49:20 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 3B9A74176DE
 for <lttng-dev@lists.lttng.org>; Fri,  8 Nov 2019 11:49:14 -0500 (EST)
In-Reply-To: <20191108084938.GA7492@f3>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Nov 8, 2019, at 3:49 AM, Benjamin Poirier benjamin.poirier@gmail.com wrote:

> Hi, long time no see!
> 
> Consider a system that's recording trace data continuously from a
> userspace application. A problem is noticed and I'd like to investigate
> it. What workflow would allow me to view past trace data to analyze the
> cause of the problem and view current (live) trace data while working on
> fixing the problem, all the while keeping a continuous record of events
> (ie. not stopping the trace)?
> 
> I thought of the following approaches but both seem to have
> disadvantages:
> 1)
> Have one continuous tracing session in normal mode. When a problem is
> noticed, use lttng-rotate to be able to read old trace data. Start a
> second tracing session in live mode with the same event rules to view
> live trace data. IIUC, there's no option to prevent lttng-relayd from
> writing the traces to disk, so we end up writing two sets of identical
> traces to disk during the time we want to look at live trace data.
> 2)
> Have one tracing session running in live mode all the time. When a
> problem is noticed, use the viewer on whatever lttng-relayd has flushed
> to disk to access old trace data (session rotation is not available).
> Furthermore, this workflow has the disadvantage that the trace data is
> going through lttng-relayd all the time (which I guess is less efficient
> than writing it from lttng-consumerd) merely to support the rare case
> where data needs to be seen live while analyzing a problem.
> 
> Is there some better approach that I didn't think about? What's your
> recommendation to support this workflow?
> 
> I'm comparing lttng to the situation where the userspace application is
> writing its logs directly to a file. In that case, it's simple to read
> the file to access old and "live" data. Of course I realize that lttng
> shines in other areas where simple file writing does not ;)

Why do you need the "live" mode at all ? What do you intend to do with the
live stream that cannot be done through notifiers invoked on rotation
completion and use size-based or timer-based rotations ?

Thanks,

Mathieu


> 
> Thank you,
> -Benjamin
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
