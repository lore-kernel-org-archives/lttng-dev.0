From: Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: introduction  & usage of LTTNG in machinekit
Date: Mon, 27 Apr 2015 08:30:15 -0400 (EDT)
Message-ID: <1024078202.13732013.1430137815501.JavaMail.zimbra__10206.0517682277$1430137878$gmane$org@polymtl.ca>
References: <887B7027-5FE6-4D13-B35A-7DCBD785DC57@mah.priv.at>
 <711173584.2718642.1427481342189.JavaMail.zimbra@polymtl.ca>
 <8187A8CE-F16D-4CDE-B969-380DE308A8D5@mah.priv.at>
 <826926538.3126946.1427639461728.JavaMail.zimbra@polymtl.ca>
 <76BAB974-2B32-469C-82AD-4D5630AFA28E@mah.priv.at>
 <381678352.13569741.1430055111345.JavaMail.zimbra@polymtl.ca>
 <A0DF7795-1940-45E4-A12B-ED0D340883D4@mah.priv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <michel.dagenais@polymtl.ca>) id 1YmiB0-0002Wz-1F
 for lttng-dev@lists.lttng.org; Mon, 27 Apr 2015 08:30:18 -0400
In-Reply-To: <A0DF7795-1940-45E4-A12B-ED0D340883D4@mah.priv.at>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Haberler <mail17@mah.priv.at>
Cc: =?utf-8?Q?Rafa=C3=ABl?= Blanchet-Lecomte <rafael.blanchet-lecomte@polymtl.ca>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


> That said, the folks which have timing problems have not caught on yet.. it
> looks some more guidance, examples and a bit of a machinekit-specific
> writeup is needed, competing with the other 247 priority projects on my desk
> ;)

If we can reproduce easily the problems, bad latency on Linux Prempt-RT in a specific configuration, we can take care of tracing and diagnosing the problems. Otherwise, the users will have to activate the tracing themselves on their setup and we can guide them for the diagnosis.

> Let me add a question out of the blue: I've read the literature on observing
> time and distributed systems and am aware of the theoretical issues, as well
> as clock synchronisation. Still - has any thought been given to merge traces
> of several systems based on synchronisation points (known causality),
> well-synchronized  clocks, or other forms of hardware synchronisation?

I suppose that you mean something like this which we offer in TraceCompass:

http://archive.eclipse.org/tracecompass/doc/org.eclipse.tracecompass.doc.user/Trace-synchronization.html

We have two use cases supported already, distributed systems exchanging packets through TCP and physical / virtual machines communicating through vmenter / exit and tracepoints on both sides of those transitions. This framework can easily be extended to other cases. We could in the future make it available declaratively (define event types and unique identifiers that should be used to match causality-related events).
