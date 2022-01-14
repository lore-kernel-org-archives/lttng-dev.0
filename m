Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE60FC433EF
	for <lttng-dev@archiver.kernel.org>; Fri, 14 Jan 2022 20:42:16 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JbCsM2Th7zFZN;
	Fri, 14 Jan 2022 15:42:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642192935;
	bh=ENt1iHTg9RqV/4mRj7uFiqu5KArgCoM0+qsoW7st5SI=;
	h=To:References:Date:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=wyn7tjp4ZYzO6kN5mIJOJsw7rNUSnM+smoIpbUAylHefWRCy2mrQe7VfktyA2X8Sf
	 ThBD37ezOadFqmBElzoWGz/7U+ZXsgOo3HRNvlDjjhanMPYRS4htBM+ceJKYd3Oru6
	 e98/v9YlIQdOVJex/W+HyeqU8GXgZS5n4PdlytfAsgMyWPsr7+JpJvgUHA9HJSZ2Cr
	 OeMZR+1ULRvFGZgnmh7nvInCGg2V1h0+AhM2TVPGcpmhg4q1gO676TRwtnumIwMP8O
	 v6q/7JqY23dHVi3R7NF7SgEqhvIFfwe2sbUEH+1EStBtcoFlnsgjauKqUgbdN7HxDN
	 n2L0BdmRpGLzQ==
Received: from fukushima.klipix.org (fukushima.klipix.org [85.12.144.25])
 by lists.lttng.org (Postfix) with ESMTPS id 4JbCsJ65qBzFm0
 for <lttng-dev@lists.lttng.org>; Fri, 14 Jan 2022 15:42:12 -0500 (EST)
Received: from [192.168.1.124] (unknown [192.222.196.137])
 by fukushima.klipix.org (Postfix) with ESMTPSA id 1133C4602C5;
 Fri, 14 Jan 2022 21:42:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.9.1 fukushima.klipix.org 1133C4602C5
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 lttng-dev@lists.lttng.org
References: <20220114201309.24548-1-mathieu.desnoyers@efficios.com>
Message-ID: <1dc93d79-2a1f-b573-7980-19cee5238633@klipix.org>
Date: Fri, 14 Jan 2022 15:42:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220114201309.24548-1-mathieu.desnoyers@efficios.com>
Content-Language: en-US
Subject: Re: [lttng-dev] [PATCH lttng-modules] Copyright ownership transfer
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Julien Desfossez via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Julien Desfossez <ju@klipix.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2022-01-14 3:13 p.m., Mathieu Desnoyers wrote:
> Apply copyright ownership transfer from Julien Desfossez to EfficiOS Inc.
> 
> Link: https://lists.lttng.org/pipermail/lttng-dev/2022-January/030092.html
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Julien Desfossez <ju@klipix.org>
> Change-Id: Ida168b1fbe6589cb371a549ef14d9b4b28b221b3
> ---
>   .../lttng-syscalls-extractor/lttng-syscalls-extractor.c         | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/instrumentation/syscalls/lttng-syscalls-extractor/lttng-syscalls-extractor.c b/include/instrumentation/syscalls/lttng-syscalls-extractor/lttng-syscalls-extractor.c
> index 0f683750..8670d25f 100644
> --- a/include/instrumentation/syscalls/lttng-syscalls-extractor/lttng-syscalls-extractor.c
> +++ b/include/instrumentation/syscalls/lttng-syscalls-extractor/lttng-syscalls-extractor.c
> @@ -5,7 +5,7 @@
>    * Dump syscall metadata to console.
>    *
>    * Copyright 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> - * Copyright 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright 2011 EfficiOS Inc.
>    */
>   
>   #include <linux/module.h>
> 

Signed-off-by: Julien Desfossez <ju@klipix.org>
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
