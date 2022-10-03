Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31458C433F5
	for <lttng-dev@archiver.kernel.org>; Mon,  3 Oct 2022 14:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1664808040;
	bh=mKr4CTc4oAsEAlBVruO/VQnBnKIaqjrP6v3CS98xMXg=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=EPi4BiA53pn527b7GjHSwiQ5hKqj8qMK4KYM8BFdgyDVmkzA/OmJGRlj/L/IPMcAR
	 pjjYI28GzlOCMRiq3AWMRnf/aHCBSqgGkQsEYvoWVwsbmF2U1GiuktDul5fetDLtEz
	 6DGCqVpetNT+lxC2amsYrflZTAUtZTTQu7XeV3kHq2esrImNrQTxzZPh2TfIyDB/mD
	 UQv/YkDjbwFn6U8lujdIEV+Zs8i7rUHkUOQoHkBzzDkPPNWG99s/C4OA1V4SkowWCk
	 bR93rdeahltFmdZ4dCVFMrH1EzorfTpJ+cE79ngzNYplB4zrJPntte8tKg8EGXaa12
	 2H1Z6V1CDn9Pw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Mh3RD0rM2z28fg;
	Mon,  3 Oct 2022 10:40:40 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com
 [IPv6:2607:5300:203:5aae::31e5])
 by lists.lttng.org (Postfix) with ESMTPS id 4Mh3RB6LlRz28R9
 for <lttng-dev@lists.lttng.org>; Mon,  3 Oct 2022 10:40:38 -0400 (EDT)
Received: from [10.1.0.219] (192-222-188-69.qc.cable.ebox.net [192.222.188.69])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4Mh3R96GtqzPBG;
 Mon,  3 Oct 2022 10:40:37 -0400 (EDT)
Message-ID: <f2f8bc4a-c788-bab2-433a-546ca5459d4d@efficios.com>
Date: Mon, 3 Oct 2022 10:41:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To: Eric Wong <normalperson@yhbt.net>, lttng-dev@lists.lttng.org
References: <20221002161343.854582-1-normalperson@yhbt.net>
In-Reply-To: <20221002161343.854582-1-normalperson@yhbt.net>
Subject: Re: [lttng-dev] [PATCH] always check pthread_create for failures
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2022-10-02 12:13, Eric Wong via lttng-dev wrote:
> pthread_create may fail with EAGAIN (which is no fault of the
> programmer), so don't allow the check to be compiled out.

Merged into master, stable-0.13, stable-0.12, thanks!

Mathieu

> 
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>   src/urcu-defer-impl.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/urcu-defer-impl.h b/src/urcu-defer-impl.h
> index 1c96287..cbb0ca8 100644
> --- a/src/urcu-defer-impl.h
> +++ b/src/urcu-defer-impl.h
> @@ -417,7 +417,8 @@ static void start_defer_thread(void)
>   	urcu_posix_assert(!ret);
>   
>   	ret = pthread_create(&tid_defer, NULL, thr_defer, NULL);
> -	urcu_posix_assert(!ret);
> +	if (ret)
> +		urcu_die(ret);
>   
>   	ret = pthread_sigmask(SIG_SETMASK, &oldmask, NULL);
>   	urcu_posix_assert(!ret);
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
