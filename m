From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: registering user-defined properties on tracepoints
Date: Fri, 3 May 2013 11:19:07 -0400
Message-ID: <20130503151907.GA1513__26811.88299689$1367594381$gmane$org@Krystal>
References: <7F632A9222059A42AF70FCB7965774AA2086527B@ALA-MBB.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UYHlM-0007Bd-Ri
	for lttng-dev@lists.lttng.org; Fri, 03 May 2013 11:19:08 -0400
Content-Disposition: inline
In-Reply-To: <7F632A9222059A42AF70FCB7965774AA2086527B@ALA-MBB.corp.ad.wrs.com>
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
> Is it possible to add /other/ user-defined attributes to an event
> definition.  What I'm trying to do is associate other related
> properties/attributes to the event itself and on each field in the
> event.
> 
> In this example I'm choosing to encode my attributes using a JSON-like
> syntax, but the point is that this is really user-defined.
> 
>   TRACEPOINT_EVENT(foo, some_event,
> 	TP_ARGS(int, value),
>         TP_ATTRIBUTES("{ icon:some_event.png, helpIndex:docs/help/0001.html ... }")
> 	TP_FIELDS(ctf_integer(int, foo, foo, "{java_formatter:com.windriver.SomeEventFormatter, leftAdjust:1, mask:64, ... }"))
>   )
> 
> I could create an associated event:
> 
>   TRACEPOINT_EVENT(foo, some_event_metadata,
> 	TP_ARGS(char *, str),
> 	TP_FIELDS(ctf_string(char *, str))
>   )
> 
> and have some rules based on the event names to bind the two together
> but it seems "nicer" to keep them together.  My motivation is keeping
> this kind of auxiliary information available with the trace itself as
> opposed to some side-files which have the tendency to get out of sync.
> 
> Or perhaps this is another way of achieving this.  Any hints gratefully
> received...

I would advise adding this info similarly to what we do for EMF modeling
info, and loglevels, in UST tracepoints: adding a separate
TRACEPOINT_ATTRIBUTES(provider, name, ....), outside of
TRACEPOINT_EVENT. It's a much easier way to add new stuff without
breaking backward compatibility.

Thanks,

Mathieu

> 
> Thanks,
> Andy.
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
