From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Use of sub-buffers - more subbuffers but smaller,
	or less but bigger?
Date: Tue, 6 Aug 2013 21:13:27 -0400
Message-ID: <20130807011327.GC19407__822.077380917285$1375838061$gmane$org@Krystal>
References: <OF47254F23.1A4EBFF6-ONC2257BB9.003393B9-C2257BB9.0033D3A6@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V6sJe-0003C3-KX
	for lttng-dev@lists.lttng.org; Tue, 06 Aug 2013 21:13:34 -0400
Content-Disposition: inline
In-Reply-To: <OF47254F23.1A4EBFF6-ONC2257BB9.003393B9-C2257BB9.0033D3A6@il.ibm.com>
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

* Amit Margalit (AMITM@il.ibm.com) wrote:
> Hello,
> 
> I'm trying to understand the trade-offs involved in choosing sub-buffer 
> number and size.
> 
> So the question is what are the benefits and the disadvantages of 
> choosing, say, 32 subbuffers of 1MB versus 8 subbuffers of 4MB, or maybe 4 
> subbuffers of 8MB?

Boundaries of subbuffers are synchronization points, so you add slightly
more overhead with smaller sub-buffers. This is an argument for having
few large sub-buffers.

Also, with periodical timer flush (useful for upcoming streaming
feature), you might want more than two sub-buffers per buffer, because
otherwise, you might run into situations where the buffer appears to be
full (and therefore events are discarded) just because the timer flush
flushes a sub-buffer before it is filled. This is an argument for not
making the number of sub-buffers _too_ small if you use switch timer.

Hoping this helps,

Mathieu

> 
> Thanks,
> 
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
