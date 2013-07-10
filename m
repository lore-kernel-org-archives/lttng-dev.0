From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Question about performance and tracepoint structure
Date: Wed, 10 Jul 2013 13:25:54 -0400
Message-ID: <20130710172554.GA8938__35113.9691113078$1373477188$gmane$org@Krystal>
References: <OFA2CEA64A.AB33A759-ONC2257BA4.005E65A6-C2257BA4.005EDCF5@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Uwy9N-0005Mq-UK
	for lttng-dev@lists.lttng.org; Wed, 10 Jul 2013 13:25:58 -0400
Content-Disposition: inline
In-Reply-To: <OFA2CEA64A.AB33A759-ONC2257BA4.005E65A6-C2257BA4.005EDCF5@il.ibm.com>
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
> Hi,
> 
> This may be a bit of a noob question, and I think I read about this 
> somewhere but I can't find it now.
> 
> When I declare a tracepoint that's made up of a uint8_t, followed by a 
> uint16_t followed by a uint32_t, for example, there are 2 ways to handle 
> this - packed or unpacked.
> 
> If we're doing packed, then we have to include some code that does the 
> packing properly as alignment issues can creep up. This code causes us to 
> incur some CPU cycles at that point.

it's not code. it's just that cpus are slightly slower at doing
unaligned accesses than aligned accesses.

> If we're doing unpacked, then we incur some cycles on passing the event to 
> the sessiond, and sessiond suffers by having to write down some extra 
> bytes, which is less efficient.

yes

> 
> Either way, I think it means I can gain some minor performance 
> improvements if I reorder my tracepoint arguments to a more efficient 
> order - alignment-wise.

Well, yes. You will want to reorder the tracepoint "TP_FIELDS" so the
largest fields come first, followed by the smaller fields.

The order of arguments (TP_ARGS) does not matter.

Thanks,

Mathieu

> 
> Am I barking up the wrong tree here?
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
