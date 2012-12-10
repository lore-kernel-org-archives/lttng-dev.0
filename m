From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Update kernel probes to
	more	detailed match to kernel versions
Date: Mon, 10 Dec 2012 14:53:20 -0500
Message-ID: <20121210195320.GA17801__33432.8756937341$1355169243$gmane$org@Krystal>
References: <20121128155032.GA9266@Krystal>
	<6C5EA58090A5ED459815C4D04C2B466F8C568729@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Ti9Pl-0002y4-VI
	for lttng-dev@lists.lttng.org; Mon, 10 Dec 2012 14:53:21 -0500
Content-Disposition: inline
In-Reply-To: <6C5EA58090A5ED459815C4D04C2B466F8C568729@EU-MBX-01.mgc.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Gabbasov, Andrew" <Andrew_Gabbasov@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Gabbasov, Andrew (Andrew_Gabbasov@mentor.com) wrote:
> Hi Mathieu,
> 
> > > By the way, we're planning to go for a 2.1 release in a matter of days.
> > > At that point, I'll have to decide if we keep the recent instrumentation
> > > commits introduced after the start of the -rc cycle in this release (if
> > > mature enough), or if we should branch before those for the 2.1 release
> > > if they need more testing (and keep these instrumentation extensions for
> > > 2.2). Any thoughts on this ?
> >
> > I believe, it would be desirable to make more thorough testing of new
> > instrumentations. On our side the testing was not too extensive, and was
> > done for ARM platform only. Although the probes are mostly replicating
> > the kernel's tracepoints, it would be reasonable to keep the commits
> > in a branch for some time so that more people in the community could
> > make some testing.
> 
> The other team here at Mentor Graphics, that originally created this set of
> tracepoints instrumentation, submitted them to the list quite long ago.
> Also, they actually did an extensive testing (much more than I was aware of),
> including other platforms (e.g. PowerPC).
> 
> May be it's not too late to still include at least the original implementation
> of tracepoints (may be with some later fixes) to upcoming 2.1 release?
> Having new supported fixed kernel tracepoints could be a good accomplishment
> for the release.

I understand, but since we want to release this week, and until recently
we still had to fix issues with compiling with older kernels, and
runtime issues when activating lockdep tracing, I think it would be
safer to let this extra instrumentation wait for 2.2.

Thanks,

Mathieu

> 
> Thanks.
> 
> Best regards,
> Andrew Gabbasov
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
