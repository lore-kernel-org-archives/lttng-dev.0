Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0635CC35274
	for <lttng-dev@archiver.kernel.org>; Mon, 18 Dec 2023 16:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1702917072;
	bh=4jtYg/gQ5A0CwFm91dhB8FL+3u8CZ1QQXBaPAFBXNXg=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=a0ATb/YV757qSiiVU7AWwBv9i/XT6M4WNQcjjWgfQyBHExrJArn0GUzO0GgRdqDyr
	 eEhYgmn/yHZw9ZhnBbW95tHbHVCLCo0QYUQQZFFTNQAohOYocyuSMsne7IWTsDwcKj
	 sGpjMGVpxMtZS7bM9w6/a7FpKvWcF6XXH6vHu0ftQEUGr3zDkHTjYOTHN3br5UfViF
	 xGImfr2HaG9+f55okU1h6Wx8b/OeKqJy7Fk1+/WSyrThtZJWCHhBh2Gk20PIJ2oHI6
	 LEZptZkV1JZFO1XTq/WFts9eJaNy2/dWt5wKxxI5lk2Utk1UTRWQvRpky/BEfnuwjw
	 UHcWRXTAtHdFA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Sv51C71C4z188L;
	Mon, 18 Dec 2023 11:31:11 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4Sv51B2ZNPz188K
 for <lttng-dev@lists.lttng.org>; Mon, 18 Dec 2023 11:31:09 -0500 (EST)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4Sv5180BCgzHQQ;
 Mon, 18 Dec 2023 11:31:08 -0500 (EST)
Message-ID: <adc94b8a-b711-4da4-b90d-fd07fccddb58@efficios.com>
Date: Mon, 18 Dec 2023 11:31:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Lei wang <quic_leiwan@quicinc.com>, lttng-dev@lists.lttng.org
References: <20231218101633.4188511-1-quic_leiwan@quicinc.com>
In-Reply-To: <20231218101633.4188511-1-quic_leiwan@quicinc.com>
Subject: Re: [lttng-dev] [PATCH lttng-modules] Android: Import VFS namespace
 for android common kernel
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

On 2023-12-18 05:16, Lei wang via lttng-dev wrote:
> Android GKI kernel add limitation on fs interface usage.
> Need to import VFS namespace explicitly to make it workable
> for lttng-modules.
> 

Merged into lttng-modules master and 2.13 branches, thanks!

Mathieu

> Signed-off-by: Lei wang <quic_leiwan@quicinc.com>
> ---
>   src/wrapper/kallsyms.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/src/wrapper/kallsyms.c b/src/wrapper/kallsyms.c
> index 97897c4..9398c83 100644
> --- a/src/wrapper/kallsyms.c
> +++ b/src/wrapper/kallsyms.c
> @@ -113,3 +113,7 @@ unsigned long wrapper_kallsyms_lookup_name(const char *name)
>   EXPORT_SYMBOL_GPL(wrapper_kallsyms_lookup_name);
>   
>   #endif
> +
> +#ifdef CONFIG_ANDROID
> +MODULE_IMPORT_NS(VFS_internal_I_am_really_a_filesystem_and_am_NOT_a_driver);
> +#endif

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
