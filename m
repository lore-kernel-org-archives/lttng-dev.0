Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DBBC4345F
	for <lttng-dev@archiver.kernel.org>; Thu,  2 May 2024 13:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1714658085;
	bh=GbDIU7dY+dFl8uRqZbe3g/FJa6Sgbk4HQhlucPq5KK0=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=lVu5TcVGFnWcB5GtkC7D0xprvgAuqIbuFCG/FjoVa5F49iIa72CqPzmxiCtHxenZ2
	 1u/MhhKYu3GYS5AsJ9UXchVk8j6PKdxHuPz9frOAY0AqebhNgMQEQ62+lJveQb1x93
	 rTU5M/+PPH6n7EqbqVjQ+PWr9tYbFEjqpTn8oT9R/WZq3qxkRvhy/L4swbXV99aNOG
	 xKUrKFbAqeLjoJQYYtyDHPoXNg8kG5fXU3xTvU+m/3QMAUa20o0mGAWE1UHfAUL0lS
	 9OggDI5Cht/Ja0Q2J1/cyszmUQt1xvPikzhqY4GY5ZKZbzLkdvuZZnvGKB6i5XAdkg
	 Kc0hdAAYB+uBQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VVb5w3xNTz2l2V;
	Thu,  2 May 2024 09:54:44 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4VVb5v2cwYz2l2S
 for <lttng-dev@lists.lttng.org>; Thu,  2 May 2024 09:54:43 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4VVb5r2DPxzy0T;
 Thu,  2 May 2024 09:54:40 -0400 (EDT)
Message-ID: <2a7f6659-4332-47ed-adbf-45e88915ac6b@efficios.com>
Date: Thu, 2 May 2024 09:54:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Benjamin Marzinski <bmarzins@redhat.com>, lttng-dev@lists.lttng.org,
 Michael Jeanson <mjeanson@efficios.com>
References: <20240501234242.2395659-1-bmarzins@redhat.com>
Content-Language: en-US
In-Reply-To: <20240501234242.2395659-1-bmarzins@redhat.com>
Subject: Re: [lttng-dev] [PATCH urcu] fix: handle EINTR correctly in
 get_cpu_mask_from_sysfs
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

On 2024-05-01 19:42, Benjamin Marzinski via lttng-dev wrote:
> If the read() in get_cpu_mask_from_sysfs() fails with EINTR, the code is
> supposed to retry, but the while loop condition has (bytes_read > 0),
> which is false when read() fails with EINTR. The result is that the code
> exits the loop, having only read part of the string.
> 
> Use (bytes_read != 0) in the while loop condition instead, since the
> (bytes_read < 0) case is already handled in the loop.

Thanks for the fix ! It is indeed the right thing to do.

I would like to integrate this fix into the librseq and libside
projects as well though, but I notice the the copy in liburcu
is LGPLv2.1 whereas the copy in librseq and libside are
MIT.

Michael, should we first relicense the liburcu src/compat-smp.h
implementation to MIT so it matches the license of the copies
in librseq and libside ?

Thanks,

Mathieu

> 
> Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
> ---
>   src/compat-smp.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/compat-smp.h b/src/compat-smp.h
> index 31fa979..075a332 100644
> --- a/src/compat-smp.h
> +++ b/src/compat-smp.h
> @@ -164,7 +164,7 @@ static inline int get_cpu_mask_from_sysfs(char *buf, size_t max_bytes, const cha
>   
>   		total_bytes_read += bytes_read;
>   		assert(total_bytes_read <= max_bytes);
> -	} while (max_bytes > total_bytes_read && bytes_read > 0);
> +	} while (max_bytes > total_bytes_read && bytes_read != 0);
>   
>   	/*
>   	 * Make sure the mask read is a null terminated string.

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
