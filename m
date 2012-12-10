From: "Gabbasov, Andrew" <Andrew_Gabbasov@mentor.com>
Subject: Re: [PATCH lttng-modules] Update kernel probes to
	more	detailed match to kernel versions
Date: Mon, 10 Dec 2012 19:04:50 +0000
Message-ID: <6C5EA58090A5ED459815C4D04C2B466F8C568729__47017.2590496533$1355166339$gmane$org@EU-MBX-01.mgc.mentorg.com>
References: <20121128155032.GA9266@Krystal>
	<6C5EA58090A5ED459815C4D04C2B466F8C566A47@EU-MBX-01.mgc.mentorg.com>,
	<20121203135513.GA3426@Krystal>,
	<6C5EA58090A5ED459815C4D04C2B466F8C567BBB@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Andrew_Gabbasov@mentor.com>) id 1Ti8ev-0002Zb-Jk
	for lttng-dev@lists.lttng.org; Mon, 10 Dec 2012 14:04:57 -0500
In-Reply-To: <6C5EA58090A5ED459815C4D04C2B466F8C567BBB@EU-MBX-01.mgc.mentorg.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu,

> > By the way, we're planning to go for a 2.1 release in a matter of days.
> > At that point, I'll have to decide if we keep the recent instrumentation
> > commits introduced after the start of the -rc cycle in this release (if
> > mature enough), or if we should branch before those for the 2.1 release
> > if they need more testing (and keep these instrumentation extensions for
> > 2.2). Any thoughts on this ?
>
> I believe, it would be desirable to make more thorough testing of new
> instrumentations. On our side the testing was not too extensive, and was
> done for ARM platform only. Although the probes are mostly replicating
> the kernel's tracepoints, it would be reasonable to keep the commits
> in a branch for some time so that more people in the community could
> make some testing.

The other team here at Mentor Graphics, that originally created this set of
tracepoints instrumentation, submitted them to the list quite long ago.
Also, they actually did an extensive testing (much more than I was aware of),
including other platforms (e.g. PowerPC).

May be it's not too late to still include at least the original implementation
of tracepoints (may be with some later fixes) to upcoming 2.1 release?
Having new supported fixed kernel tracepoints could be a good accomplishment
for the release.

Thanks.

Best regards,
Andrew Gabbasov
