From: David Goulet <dgoulet@efficios.com>
Subject: Re: Problem with adding vpid and vtid context to UST
Date: Mon, 17 Jun 2013 16:01:48 -0400
Message-ID: <51BF6B2C.1060509__29306.846849113$1371499355$gmane$org@efficios.com>
References: <OFA2B17967.FDD790B6-ONC2257B8C.002C000A-C2257B8C.002C70E3@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Uofcj-00043f-FV
	for lttng-dev@lists.lttng.org; Mon, 17 Jun 2013 16:01:57 -0400
In-Reply-To: <OFA2B17967.FDD790B6-ONC2257B8C.002C000A-C2257B8C.002C70E3@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Amit,

Amit Margalit:
> Hi,
> 
> Every time I try this, I get the following error:
> 
> Error: Error starting tracing for app pid: 5663 (ret: -1027)
> 
> Here's my sequence:
> 
> lttng create foo -o /store/
> lttng enable-channel -u
> lttng add-context -u -t vpid -t vtid -t procname
> lttng enable-event -u -a
> lttng start foo
> 
> At this point I start my application and get that error. When the application
> exits, I stop the tracing, and run lttng view.
> 
> The trace session seems to have worked just fine, and "procname" was indeed
> added to the context, but vtid and vpid were not.

What's going on here is that you enable a channel then add contexts. This is
perfectly OK (although your example is missing a channel name). So, the
following "lttng enable-event" creates a default channel "channel0" since no
"-c" was specified.

So basically, the contexts are available on the first channel and not the second
one.

This sequence should work:

lttng create foo -o /store/
lttng enable-event -u -a
lttng add-context -u -t vpid -t vtid -t procname
lttng start foo

We should detail that a bit better in the documentation that an add-context
needs to be done *after* a channel is enabled. This allows you to create
multiple channel with different contexts.

Now, an other issue here in terms of usability is that the enable-event *after*
an enable-channel should be apply to this channel. I think there is been a
discussion at some point on lttng-dev on in the bug tracker.

> 
> And BTW, the documentation doesn't clearly state that pid and tid are
> kernel-only contexts, and that one should use vtid and vpid.

Yes! The list of contexts accepted per domain would be quite useful and I do
agree with you that it's missing in the doc.

We would be *happy* to welcome a contribution for that :).

Cheers!
David

> 
> Any help is appreciated.
> 
> Thanks,
> 
> Amit Margalit
> IBM XIV - /Storage Reinvented/
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> 
> 
> This body part will be downloaded on demand.
