From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Add trace support for calloc
	and	realloc.
Date: Wed, 7 Aug 2013 09:57:57 -0400
Message-ID: <20130807135757.GA32387__24536.2450638369$1375883930$gmane$org@Krystal>
References: <alpine.LNX.2.00.1308012013380.9574@monopod.intra.ispras.ru>
	<51FA8DAE.3070409@mentor.com>
	<alpine.LNX.2.00.1308012045570.9574@monopod.intra.ispras.ru>
	<alpine.LNX.2.00.1308012115300.9574@monopod.intra.ispras.ru>
	<51FA9AD8.4010502@mentor.com>
	<CABtfrpDg_NOi+yP5GABmjBv6G9Zj+rvTwc1OdQ1s_9DM7uzeZg@mail.gmail.com>
	<20130803011841.GE9033@Krystal> <51FFBD46.5030105@mentor.com>
	<20130807014241.GH19407@Krystal> <52024D88.8090409@seefeld.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V74FT-0000vs-2S
	for lttng-dev@lists.lttng.org; Wed, 07 Aug 2013 09:58:03 -0400
Content-Disposition: inline
In-Reply-To: <52024D88.8090409@seefeld.name>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stefan Seefeld <stefan@seefeld.name>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Stefan Seefeld (stefan@seefeld.name) wrote:
> On 08/06/2013 09:42 PM, Mathieu Desnoyers wrote:
> > * Stefan Seefeld (stefan_seefeld@mentor.com) wrote:
> >> Yes, with the adjusted free() implementation as per this patch, I think
> >> this is a robust solution. Do you think we need any form of multi-thread
> >> protection ? Or can we assume that library initialization will have
> >> completed by the time multiple threads could possibly call calloc() ?
> > Well, considering that lttng-ust spawns thread in its constructor, it
> > might indeed be a good thing to be thread-safe. Fixed by:
> >
> > commit d9e6d9a57fda6d3ad73016b2b3137997aac9c7ba
> > Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Date:   Tue Aug 6 21:41:15 2013 -0400
> >
> >     Fix: static_calloc should be thread-safe
> >     
> >     Reported-by: Stefan Seefeld <stefan_seefeld@mentor.com>
> >     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >
> > Thoughts ?
> 
> Sorry, I'm confused. Where can I find this commit, i.e. what repo, what
> branch ? I can't see it anywhere ?

See

https://github.com/efficios/memleak-finder/commits/master

Thanks,

Mathieu

> 
> Thanks,
>         Stefan
> 
> -- 
> 
>       ...ich hab' noch einen Koffer in Berlin...
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
