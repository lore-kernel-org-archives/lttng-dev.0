Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70179C00144
	for <lttng-dev@archiver.kernel.org>; Mon,  1 Aug 2022 15:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1659366806;
	bh=7tsw3dC92iWnRHJ8kmGpEwlMO5culcUNeVpOiGYS/t0=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=auj1m+/EcKUUu3MgSfgSCXjIsZFexR/Qd1ZrVFj/uMfWblTZu5QguarNDxV4kKzfA
	 l6Ji8a0Vjp2OQeC6y4OnThpcv5HkPFLPh/7/NELITRibgnmpVKlZ7C5Lg0ATHqtCz/
	 IRtmX96YfHgjrPJeJbfk4JtxgCC8V+XeQ/G9gblvkgn+N+o+fsf4aa1I93O9wUKZDd
	 I+y97d2MxQS+gwfxL5yZuw25W0SzDavZJmFsJidbN6oToYF2GVAGfsRpq3G+10T06L
	 eG4jRDx9CGUUfu0Jqu3o6U07+5bgQ6Y391rpjHlfC0OYkKzbRDtAEe+DJ8INOg89xN
	 nO9j04NJJ5Fzw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LxM862W2lz11Gf;
	Mon,  1 Aug 2022 11:13:26 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LxM852JxWz10r7
 for <lttng-dev@lists.lttng.org>; Mon,  1 Aug 2022 11:13:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4D4833553CE
 for <lttng-dev@lists.lttng.org>; Mon,  1 Aug 2022 11:13:25 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id T4f06LCaBnN5; Mon,  1 Aug 2022 11:13:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C641F35536D;
 Mon,  1 Aug 2022 11:13:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C641F35536D
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id WqJTXZFx3NVe; Mon,  1 Aug 2022 11:13:24 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id BE9D23556A8;
 Mon,  1 Aug 2022 11:13:24 -0400 (EDT)
Date: Mon, 1 Aug 2022 11:13:24 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <390803304.93584.1659366804771.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220801143700.160380-2-norbert.lange@andritz.com>
References: <20220801143700.160380-1-norbert.lange@andritz.com>
 <20220801143700.160380-2-norbert.lange@andritz.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4304)
Thread-Topic: lttng_ust_init_thread: call urcu_register_thread
Thread-Index: 4OKV1vgjTnrJKGanieGHRVf67/eefQ==
Subject: Re: [lttng-dev] [PATCH v2 2/2] lttng_ust_init_thread: call
 urcu_register_thread
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Aug 1, 2022, at 10:37 AM, Norbert Lange nolange79@gmail.com wrote:

> From: Norbert Lange <nolange79@gmail.com>
> 
> Eagerly register the thread, and avoid taking mutex during the
> first tracepoint.

Merged, thanks!

Mathieu

> 
> Signed-off-by: Norbert Lange <nolange79@gmail.com>
> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> src/lib/lttng-ust/lttng-ust-comm.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/src/lib/lttng-ust/lttng-ust-comm.c
> b/src/lib/lttng-ust/lttng-ust-comm.c
> index 0a039fef..0fe2da46 100644
> --- a/src/lib/lttng-ust/lttng-ust-comm.c
> +++ b/src/lib/lttng-ust/lttng-ust-comm.c
> @@ -447,6 +447,8 @@ void lttng_ust_init_thread(void)
> 	 * this thread attempts to use them.
> 	 */
> 	lttng_ust_common_init_thread(LTTNG_UST_INIT_THREAD_MASK);
> +
> +	lttng_ust_urcu_register_thread();
> }
> 
> int lttng_get_notify_socket(void *owner)
> --
> 2.35.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
