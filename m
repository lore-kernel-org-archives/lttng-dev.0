From: Duncan Sands <baldrick@free.fr>
Subject: Re: Alternative to signals/sys_membarrier() in liburcu
Date: Thu, 12 Feb 2015 14:57:51 +0100
Message-ID: <54DCB15F.80505__1822.22169028154$1423749528$gmane$org@free.fr>
References: <CANW5cDmTCM9ZmhN7-2eWUEYvD+Y=sGt2i7mecdPTTLHMcT8fPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp1-g21.free.fr ([212.27.42.1])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <baldrick@free.fr>) id 1YLuHA-0003vd-J2
 for lttng-dev@lists.lttng.org; Thu, 12 Feb 2015 08:57:53 -0500
Received: from [IPv6:2a01:e35:2e83:a840:91b1:1f80:ec6:ecb8] (unknown
 [IPv6:2a01:e35:2e83:a840:91b1:1f80:ec6:ecb8])
 by smtp1-g21.free.fr (Postfix) with ESMTP id 50DB29400B1
 for <lttng-dev@lists.lttng.org>; Thu, 12 Feb 2015 14:57:49 +0100 (CET)
In-Reply-To: <CANW5cDmTCM9ZmhN7-2eWUEYvD+Y=sGt2i7mecdPTTLHMcT8fPg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Michael,

On 11/02/15 01:03, Michael Sullivan wrote:
> I've been looking at the RCU library (as part of gathering examples for my
> research on weak memory models) and was thinking about ways to force other
> threads to issue barriers. Since it seems like sys_membarrier() never made it
> into the kernel, I was pondering whether there was some other way to more or
> less get its effect; as it turns out, there is, but it is a hack: mprotect(2).

is it clear that sys_membarrier is really dead?

Ciao, Duncan.
