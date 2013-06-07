From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Compiliing LTTng-modules 2.1 with a 3.9.4 kernel
Date: Fri, 7 Jun 2013 14:44:10 -0400
Message-ID: <20130607184410.GA32616__15138.8369071812$1370630689$gmane$org@Krystal>
References: <51B220F3.70901@gmail.com> <20130607181235.GA32244@Krystal>
	<51B224D8.6070102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Ul1dz-0004YX-HM
	for lttng-dev@lists.lttng.org; Fri, 07 Jun 2013 14:44:11 -0400
Content-Disposition: inline
In-Reply-To: <51B224D8.6070102@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
> On 2013-06-07 14:12, Mathieu Desnoyers wrote:
> > Please let me know if anything is missing,
> The biggest issues about the commits on block.h is this one:
> 
> 7c68b363332170e4db100327ecc9e09b8a79cf29    Update kernel probes to more
> detailed match to kernel versions
> 
> it modifies a lot of other files, but all the next commit on block.h
> depends on it.
> we could get it in full into the stable branch, or just extract the
> change on block.h
>

I just pulled the block-layer-related changes. Should work fine now.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
