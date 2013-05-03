From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: getting a notification from 'lttng start|stop'
Date: Fri, 3 May 2013 11:21:18 -0400
Message-ID: <20130503152118.GB1513__27462.4611404308$1367594510$gmane$org@Krystal>
References: <7F632A9222059A42AF70FCB7965774AA208660DB@ALA-MBB.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UYHnU-0007DK-BD
	for lttng-dev@lists.lttng.org; Fri, 03 May 2013 11:21:20 -0400
Content-Disposition: inline
In-Reply-To: <7F632A9222059A42AF70FCB7965774AA208660DB@ALA-MBB.corp.ad.wrs.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "McDermott, Andrew" <Andrew.McDermott@windriver.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* McDermott, Andrew (Andrew.McDermott@windriver.com) wrote:
> 
> Is it possible to see when tracing has actually started (i.e., when
> `lttng start' is invoked)?
> 
> I can observe that the tracepoint is enabled/disabled by looking at the
> 'state' field in a 'struct tracepoint'.  Is there an equivalent variable
> to monitor for `lttng start|stop'?  I was trying to dump some additional
> process state (via calls to tracepoint) whenever an external
> start/stop/start/stop/start sequence occurs.

statedump for UST. This is a feature we don't have at this point. It
would need to be designed within UST. I don't this a simple "hack" would
do.

> 
> Also, when I run 'lttng enable-event -u -a' I see that the 'state' value
> changes from '0' to '1', but if I run 'lttng disable-event -u -a' it
> stays at '1'.  Is this expected?  If I subsequently run 'lttng destroy'
> then it does go to '0'.  Shouldn't the disable set it to '0' too?

I think it's been fixed, but if you still experience this issue, please
file a bug report on bugs.lttng.org.

Thanks,

Mathieu

> 
> -- 
> andy
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
