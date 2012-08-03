From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Getting 64bit int from babeltrace library
Date: Fri, 3 Aug 2012 08:35:07 -0400
Message-ID: <20120803123507.GA16463__38408.2487704747$1343997340$gmane$org@Krystal>
References: <138eaa0642b.-2681066139298325110.3245307989283453259@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SxH5x-0004Pb-VX
	for lttng-dev@lists.lttng.org; Fri, 03 Aug 2012 08:35:09 -0400
Content-Disposition: inline
In-Reply-To: <138eaa0642b.-2681066139298325110.3245307989283453259@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "eikosaedron@gmail.com" <eikosaedron@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Jon,

Do you have a test trace and small test program you can provide that
would allow us to reproduce your issue ? Please provide information
about the build setup too (32-bit or 64-bit userspace ?)

Thanks,

Mathieu

* eikosaedron@gmail.com (eikosaedron@gmail.com) wrote:
> 
> Hi all,
> 
> I hope you can help me with a problem I've encountered using the babeltrace C libraries to write a trace parsing tool.
> 
> I have fields which contain 64 bit integers. However, when I call bt_ctf_get_uint64 from the event callback on that field, it only returns the lower 32 bits. The upper bits are all 0's. I've called get_int_len to confirm they are 64 bits and tried accessing the values directly but I'm still facing the same problem.
> 
> Running babeltrace on the same trace files prints out the full 64 bits in base 16. The top 32 bits should not be all 0's.
> 
> Could there be something wrong with my build setup or anything else I've overlooked in getting the the full 64 bit integers into the babeltrace structures?
> 
> Thanks,
> Jon
> 
> 
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
