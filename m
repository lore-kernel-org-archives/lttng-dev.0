From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: cases that kernel module uses lttng to trace
	its	own code
Date: Mon, 6 May 2013 23:21:23 -0400
Message-ID: <20130507032123.GG24603__47805.0129757777$1367896913$gmane$org@Krystal>
References: <CAKPZSeAKPCBTAH+zphCfv5JwQLjTuPwogFaDEbLXjF1RgQfxFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UZYSy-0004pc-BW
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 23:21:24 -0400
Content-Disposition: inline
In-Reply-To: <CAKPZSeAKPCBTAH+zphCfv5JwQLjTuPwogFaDEbLXjF1RgQfxFQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: yin sun <sunyin51@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* yin sun (sunyin51@gmail.com) wrote:
> Hello,
> 
> Is there any example that a loadable kernel module utilize lttng
> tracepoint to trace its own code. Not those ready made probes.
> 
> In this case, what minimal lttng modules do I have to load?

I guess you'll want to go by trial and error, and also the lsmod
dependency information can help out.

Good luck!

Mathieu

> 
> Thanks,
> /Yin
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
