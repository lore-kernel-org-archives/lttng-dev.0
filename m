From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: LTTng UST vs Syslog, Printf...
Date: Wed, 21 Aug 2013 10:40:34 -0400
Message-ID: <20130821144034.GA15433__47384.9738635637$1377096089$gmane$org@Krystal>
References: <63008C666A72BB4F892767155D012B30114CD6F0@eusaamb105.ericsson.se>
	<20130821142457.GA15295@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VC9aN-0006AN-O4
	for lttng-dev@lists.lttng.org; Wed, 21 Aug 2013 10:40:41 -0400
Content-Disposition: inline
In-Reply-To: <20130821142457.GA15295@Krystal>
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

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * Jim Dumont (jim.dumont@ericsson.com) wrote:
> > Hi there,
> > 
> > Has anyone done a recent performance and characteristics comparison between lttngust with syslog and printf?   Things like memory & cpu footprint, tps, i/o, disk space...
> 
> Not that I am aware of.
> 
> > 
> > I found this Windriver comparison from 2011:
> > https://www.google.ca/url?sa=t&rct=j&q=&esrc=s&frm=1&source=web&cd=1&cad=rja&ved=0CCoQFjAA&url=https%3A%2F%2Fevents.linuxfoundation.org%2Fslides%2F2011%2Flinuxcon%2Flcna2011_wessel.pdf&ei=Y64TUu6qJqS62AXIqYCYCg&usg=AFQjCNF0Q05MytPYVNWBPnUjB9LEGJfQZA
> 
> This presentation uses UST 0.x. This is _old_: it predates LTTng 2.0.
> 
> > 
> > And if I recall correctly, LTTng UST team also did a printf comparison
> > a while back, but was wondering if someone has done more recent
> > prototyping?  Any comparisons with syslog?
> 
> Not at this point. It would be interesting to compare:
> 
> - lttng-ust, both in "discard" and "snapshot" modes,
> vs
> - printf with timestamp,
> vs
> - syslog
> 
> Especially on multi-core systems, with applications generating a _lot_
> of log/trace data.

Just to add to the reflexion, there are key differences between
lttng-ust and printf/syslog that makes comparison a bit difficult:

lttng-ust never blocks the application when buffers are full. It either
discards events or overwrites the oldest information (flight recorder
tracing).

printf and syslog will block the application if the disk I/O is not fast
enough.

How would you recommand comparing these ?

Moreover, in order to ensure we can compare those, the printf benchmark
would need to grab a time-stamp, and would need to be performed with one
call per event (no more), since it is only "atomic" from the point of
view of its buffer on a per-call basis. Moreover, printf is not
async-signal-safe (as per signal(7)), so it should be noted that it
cannot be used from a signal handler (whereas lttng-ust can be used from
signal handlers).

Thanks,

Mathieu


> 
> Thanks,
> 
> Mathieu
> 
> > 
> > Regards,
> > 
> > /Jim Dumont
> > 
> > 
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
