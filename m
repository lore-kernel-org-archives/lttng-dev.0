Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57833C25B07
	for <lttng-dev@archiver.kernel.org>; Wed, 10 Aug 2022 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1660144835;
	bh=seI2/i77flf8ju6XoYx5dOiQFlORbPP1YvSWxirBosM=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=O9UEeB/+3YQt+DuOSXjRSWDEBW4fcRCEukzr6kXrgCBj3VfPf0Z+SJ3YaM3FOsfHa
	 5ULHqnZJdqKRChzfrHZZR9ufEl9z4rS859N3A+KlRvBES2Qnfcqh5lW2eAMhOibHVA
	 7xV/lCzD9hLoau7NbGCfh6P6g8PRqGN06MdxbKqp4AjgoXsbGZhSq+8jmpuVxYynXf
	 VvjahIrmMr/3fK7ZYj1wU/VBNGR9HtAD6ilHld+zQ7iMr2n5p/K5H5biGwr/RVTBhz
	 InuE9gdYhwUvXOvvRQiJT0pk+e184lPGSzD6fDBW4Eqv355BgtpMZZZ//AHad4r74k
	 ewzklKBh6VPMQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M2ttB3xl2z1D3B;
	Wed, 10 Aug 2022 11:20:34 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4M2tt93hMjz1DB1
 for <lttng-dev@lists.lttng.org>; Wed, 10 Aug 2022 11:20:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B5D4E3A8637
 for <lttng-dev@lists.lttng.org>; Wed, 10 Aug 2022 11:20:27 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ZkmeCYpV_IA2; Wed, 10 Aug 2022 11:20:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E58D63A83D8;
 Wed, 10 Aug 2022 11:20:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E58D63A83D8
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 3ajORD39RFDT; Wed, 10 Aug 2022 11:20:25 -0400 (EDT)
Received: from [10.10.0.55] (unknown [38.141.136.237])
 by mail.efficios.com (Postfix) with ESMTPSA id C4B4D3A835B;
 Wed, 10 Aug 2022 11:20:25 -0400 (EDT)
Message-ID: <65c3cadc-9053-ba31-67b3-30bb9294642d@efficios.com>
Date: Wed, 10 Aug 2022 11:20:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To: bruce.ashfield@gmail.com, lttng-dev@lists.lttng.org
References: <20220803192327.3726094-1-bruce.ashfield@gmail.com>
In-Reply-To: <20220803192327.3726094-1-bruce.ashfield@gmail.com>
Subject: Re: [lttng-dev] [PATCH] compaction: make tracepoints condtional on
 CONFIG_COMPACTION
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2022-08-03 15 h 23, Bruce Ashfield via lttng-dev wrote:
> Hi all,
> 
> This was found during the update of the yocto project reference
> kernel to 5.19. Out of all the supported architectures, only
> mips failed during the build of lttng-modules.
> 
> Specifically, it seems like the lack of CONFIG_COMPACTION being
> enabled in the kernel was the significant issue. Only one of the
> tracepoints blew up, but I can't see how any of them would be
> valid in this scenario, or why it would be limited to mips.
> 
> While I don't think this is the right fix, this is what got me
> up and passing sanity testing, so I wanted to send the change
> and see what the actual, correct fix would be :)
> 
> Cheers,
> 
> Bruce

Hi Bruce,

Thanks for reporting this issue, I propose a simpler fix [1] of just 
disabling the build of the compaction probe module when 
CONFIG_COMPACTION is disabled in the kernel configuration.

Can you confirm this patch fixes the issue on your side?

Thanks,

Michael

[1] https://review.lttng.org/c/lttng-modules/+/8660
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
