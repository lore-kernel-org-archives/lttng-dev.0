From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: LTTng UST vs Syslog, Printf...
Date: Wed, 21 Aug 2013 10:24:57 -0400
Message-ID: <20130821142457.GA15295__28722.9174901315$1377095159$gmane$org@Krystal>
References: <63008C666A72BB4F892767155D012B30114CD6F0@eusaamb105.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VC9LI-00053L-Ms
	for lttng-dev@lists.lttng.org; Wed, 21 Aug 2013 10:25:06 -0400
Content-Disposition: inline
In-Reply-To: <63008C666A72BB4F892767155D012B30114CD6F0@eusaamb105.ericsson.se>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jim Dumont <jim.dumont@ericsson.com>
Cc: "'lttng-dev@lists.lttng.org'" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Jim Dumont (jim.dumont@ericsson.com) wrote:
> Hi there,
> 
> Has anyone done a recent performance and characteristics comparison between lttngust with syslog and printf?   Things like memory & cpu footprint, tps, i/o, disk space...

Not that I am aware of.

> 
> I found this Windriver comparison from 2011:
> https://www.google.ca/url?sa=t&rct=j&q=&esrc=s&frm=1&source=web&cd=1&cad=rja&ved=0CCoQFjAA&url=https%3A%2F%2Fevents.linuxfoundation.org%2Fslides%2F2011%2Flinuxcon%2Flcna2011_wessel.pdf&ei=Y64TUu6qJqS62AXIqYCYCg&usg=AFQjCNF0Q05MytPYVNWBPnUjB9LEGJfQZA

This presentation uses UST 0.x. This is _old_: it predates LTTng 2.0.

> 
> And if I recall correctly, LTTng UST team also did a printf comparison
> a while back, but was wondering if someone has done more recent
> prototyping?  Any comparisons with syslog?

Not at this point. It would be interesting to compare:

- lttng-ust, both in "discard" and "snapshot" modes,
vs
- printf with timestamp,
vs
- syslog

Especially on multi-core systems, with applications generating a _lot_
of log/trace data.

Thanks,

Mathieu

> 
> Regards,
> 
> /Jim Dumont
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
