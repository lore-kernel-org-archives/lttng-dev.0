From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: More LTTng problems
Date: Fri, 17 Aug 2012 11:08:06 -0400
Message-ID: <20120817150806.GA15919__24843.4848887429$1345216117$gmane$org@Krystal>
References: <CAGya9MmuQi2U6sneqEPwWUrF=1rNNA-zE9yrfneGZ6QBZhBeTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T2O9f-0005S6-FK
	for lttng-dev@lists.lttng.org; Fri, 17 Aug 2012 11:08:07 -0400
Content-Disposition: inline
In-Reply-To: <CAGya9MmuQi2U6sneqEPwWUrF=1rNNA-zE9yrfneGZ6QBZhBeTg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Henrik Hautakoski <henrik@fiktivkod.org>
Cc: Daniel =?iso-8859-1?Q?Flemstr=F6m?= <daniel.flemstrom@mdh.se>, lttng-dev@lists.lttng.org, Stefan Karlsson S12 <skn07007@student.mdh.se>, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

It looks like you did not build a 32-bit consumer. I'm ccing David
Goulet, maintainer of lttng-tools.

Thanks,

Mathieu

* Henrik Hautakoski (henrik@fiktivkod.org) wrote:
> Hi. got lttng working now. but when given the following command, we
> get an error.
> 
> $ lttng enable-event -a -u
> Error: Events: 32-bit UST consumer start failed (channel channel0,
> session mysession)
> 
> Could not find any information about this error massage. do you have any ideas?
> 
> -- 
> Henrik Hautakoski
> henrik@fiktivkod.org

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
