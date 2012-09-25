From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: CTF model.emf.uri precision
Date: Mon, 24 Sep 2012 22:25:30 -0400
Message-ID: <20120925022530.GA12625__39986.6727916107$1348539966$gmane$org@Krystal>
References: <5060C80C.4030600@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TGKq4-0007bv-Rb
	for lttng-dev@lists.lttng.org; Mon, 24 Sep 2012 22:25:32 -0400
Content-Disposition: inline
In-Reply-To: <5060C80C.4030600@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Matthew Khouzam (matthew.khouzam@ericsson.com) wrote:
> Hi tracing paladins,
> I was going over the most recent CTF specs. I am curious, at the line:
> 1176   "model.emf.uri = "string";" this looks like a reference to
> something from eclipse modeling framework.
> http://download.eclipse.org/modeling/emf/emf/javadoc/2.7.0/org/eclipse/emf/common/util/URI.html
> 
> Is this part of the CTF specification? Shouldn't this be called
> model.uri or model_uri to respect the naming convention?

if we only call it model.uri, and come up with other model URIs that we
want to encode in the future (not emf-related), then we would be
stucked, wouldn't we ?

What is the benefit of removing the "emf" part ?

Thanks,

Mathieu

> 
> I hope someone could clarify this.
> 
> Matthew
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
