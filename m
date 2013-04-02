From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: add-context perf counters support in userspace
Date: Tue, 2 Apr 2013 09:30:54 -0400
Message-ID: <20130402133054.GC12063__29073.2247442522$1364909503$gmane$org@Krystal>
References: <515ADC34.9060304@nsn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UN1Id-0005O7-4Y
	for lttng-dev@lists.lttng.org; Tue, 02 Apr 2013 09:30:55 -0400
Content-Disposition: inline
In-Reply-To: <515ADC34.9060304@nsn.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Markus Weinfurtner <markus.weinfurtner.ext@nsn.com>
Cc: dominique.toupin@ericsson.com, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Markus Weinfurtner (markus.weinfurtner.ext@nsn.com) wrote:
> Hi,
>
> will perf counters in add-context for userspace be supported in the future?
> Does anybody currently work on this?

Hi,

This is something we are contemplating, but we are expecting a Perf ABI
that will expose those counters to user-space through vDSO. I know some
work has been done in perf to expose those counters through system
calls, but I don't know the current completion status.

Short story: as soon as we have a user-space interface available to read
those counters from UST, we plan to support it.

Thanks,

Mathieu

>
> Br,
> Markus
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
