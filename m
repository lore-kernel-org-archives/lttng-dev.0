From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Alternative to signals/sys_membarrier() in liburcu
Date: Thu, 12 Mar 2015 14:58:18 +0000 (UTC)
Message-ID: <2081130973.285930.1426172298272.JavaMail.zimbra__36300.7352607839$1426172428$gmane$org@efficios.com>
References: <CANW5cDmTCM9ZmhN7-2eWUEYvD+Y=sGt2i7mecdPTTLHMcT8fPg@mail.gmail.com>
 <54DCB15F.80505@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YW4Z6-0003ZI-Nq
 for lttng-dev@lists.lttng.org; Thu, 12 Mar 2015 10:58:30 -0400
In-Reply-To: <54DCB15F.80505@free.fr>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Duncan Sands <baldrick@free.fr>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Duncan Sands" <baldrick@free.fr>
> To: lttng-dev@lists.lttng.org
> Sent: Thursday, February 12, 2015 8:57:51 AM
> Subject: Re: [lttng-dev] Alternative to signals/sys_membarrier() in liburcu
> 
> Hi Michael,
> 
> On 11/02/15 01:03, Michael Sullivan wrote:
> > I've been looking at the RCU library (as part of gathering examples for my
> > research on weak memory models) and was thinking about ways to force other
> > threads to issue barriers. Since it seems like sys_membarrier() never made
> > it
> > into the kernel, I was pondering whether there was some other way to more
> > or
> > less get its effect; as it turns out, there is, but it is a hack:
> > mprotect(2).
> 
> is it clear that sys_membarrier is really dead?

There were no technical objections to sys_membarrier. The only objection
left was that only liburcu was needing it, and kernel maintainers were
concerned to introduce a kernel API for only a single user.

It would be good if we can come up with other uses of sys_membarrier.

Thoughts ?

Thanks,

Mathieu


> 
> Ciao, Duncan.
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
