Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB05C7EE22
	for <lttng-dev@archiver.kernel.org>; Thu, 11 May 2023 07:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1683788803;
	bh=/vEevNC5hCA/UoKFqAHIdjcZBvVfAOBQfo+9OqPhT+g=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=lkUWicr1Cz5qvNhDwVw6jGqRDR/J94XoUe9GnBxE7HuzCVKvtjbR55VvEB7347QKH
	 koyg4HhX+ecQBpbsO30BALwPoYdacodojyknKJJqD/+X/wA+dgVuHYgdFBkTYP4fwO
	 Gw2oVxtIxrTCqgVrzPJZKQuGXF018gXcGle+dTX9Qu76DKi9XrO6Q8bSieuBSKWX4b
	 zXbFv+vbArQUALU9o3k/bZ6aKVtZ+eGfu3fMS/my5EddJFK1UJlPN3E+plW3rBKDRb
	 m9o4chSG+9k3X+xCHVfuB5kOVX8JXXug4vAE1cjDDjCL7maumU9OQE3D4Ajxk6ADfC
	 mCuueusprAaqg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QH2xt53QvzSt8;
	Thu, 11 May 2023 03:06:42 -0400 (EDT)
Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
 by lists.lttng.org (Postfix) with ESMTP id 4QH2xr1CM5zSqd
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2023 03:06:39 -0400 (EDT)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by smtpfb1-g21.free.fr (Postfix) with ESMTP id 5DD08DF8761
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2023 08:57:49 +0200 (CEST)
Received: from [192.168.45.240] (unknown [37.166.238.118])
 (Authenticated sender: duncan.sands@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id EF5255FFC1
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2023 08:57:11 +0200 (CEST)
Message-ID: <59232ffe-de85-9c7c-d3b7-70def1437476@free.fr>
Date: Thu, 11 May 2023 08:57:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-GB
To: lttng-dev@lists.lttng.org
References: <87v8gzuc3g.fsf@laura>
In-Reply-To: <87v8gzuc3g.fsf@laura>
Subject: Re: [lttng-dev] [RFC] Deprecating RCU signal flavor
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Duncan Sands via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Duncan Sands <baldrick@free.fr>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Olivier, we (DeepBlueCapital) gave up on urcu-signal a long time ago, due to 
the annoying side effects signals can have.  Nowadays we use membarrier, so 
removing urcu-signal is fine as far as we are concerned.

Best wishes, Duncan.

On 10/05/2023 23:10, Olivier Dion via lttng-dev wrote:
> Hi all,
> 
> We have the intention of deprecating the urcu-signal flavor in the
> future.  We are asking users of URCU for _feedback_ on this before
> going any further.
> 
> Part of this decision is that we are adding support for TSAN in URCU and
> the signal flavor deadlocks with TSAN.  It is also my understanding that
> the urcu-signal flavor was historically made as a fallback for system
> lacking the membarrier(2) system call.  Nowadays, most systems have
> support for that system call, making the urcu-signal an artifact of the
> past.
> 
> The following is a proposed timeline of events:
> 
>    1. Asking for feedback from users of URCU (this message)
>    2. Disabling the signal flavor by default and adding --enable-flavor-signal
>    3. Removing the signal flavor
> 

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
