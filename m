Return-Path: <SRS0=5oIU=KO=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9291C433B4
	for <lttng-dev@archiver.kernel.org>; Wed, 19 May 2021 19:00:51 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1980461007
	for <lttng-dev@archiver.kernel.org>; Wed, 19 May 2021 19:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1980461007
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Flhz556KFz1r3k;
	Wed, 19 May 2021 15:00:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621450850;
	bh=zHS0UQhGHYXE++gVxjgwKGChMwXgCV5UR28jhoE+yyk=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=gaxhCy41UUJfxN1dFjxElztvO6nUFsJmNxCDyY70Tpr45xATlXkznz6cW26Y7jkFd
	 zdvneB5K95qiYxJvLWgofzib+fCM3h5RNvN66RqS1/FgZk0iFBNkirMAZERuK/sfpw
	 rvmBNVbS6qjWGs9ZZ2NbLphT+c795+Lzuc5NB5YK4IMGog5XeFQiwCuJ5din2Mt+vw
	 fbpXtIx8xeWXSit3h1EwErdHKgg5aaYvL0Fr2vXxqFR81KLaFuYGjAyU4udOEQnqPF
	 Voxmg2D/j3zdctp/fAE0YNlfAE0e0VOUTuvhqAaqpOoM0+i2XG1QGe/rKyGgjrHb/y
	 2HFRqEfq47Skw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Flhz46gkpz1r3c
 for <lttng-dev@lists.lttng.org>; Wed, 19 May 2021 15:00:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 76D2632E0BF
 for <lttng-dev@lists.lttng.org>; Wed, 19 May 2021 15:00:42 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id HcJob3woM-N1; Wed, 19 May 2021 15:00:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E921E32DEF7;
 Wed, 19 May 2021 15:00:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E921E32DEF7
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id lxlKi08RziKs; Wed, 19 May 2021 15:00:41 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id DBC7F32D6AC;
 Wed, 19 May 2021 15:00:41 -0400 (EDT)
Date: Wed, 19 May 2021 15:00:41 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1498635684.51674.1621450841774.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210519165648.792939-1-nolange79@gmail.com>
References: <20210519165648.792939-1-nolange79@gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4007)
Thread-Topic: Avoid using the heap for small strings with tracef/tracelog
Thread-Index: uklPRro3gOBsskrkRDK0uRwknZGwpQ==
Subject: Re: [lttng-dev] [PATCH] Avoid using the heap for small strings with
 tracef/tracelog
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
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

----- On May 19, 2021, at 12:56 PM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Try to use vsnprintf with a 512 Byte buffer on the Stack,
> if that fails allocate a larger one.

I agree with the approach.

Can we move the hardcoded "512" to a #define within src/common/tracer.h ?

Thanks,

Mathieu

> 
> Signed-off-by: Norbert Lange <nolange79@gmail.com>
> ---
> liblttng-ust/tracef.c   | 13 ++++++++++---
> liblttng-ust/tracelog.c | 12 +++++++++---
> 2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/liblttng-ust/tracef.c b/liblttng-ust/tracef.c
> index ea98e43e..18c29e25 100644
> --- a/liblttng-ust/tracef.c
> +++ b/liblttng-ust/tracef.c
> @@ -32,17 +32,24 @@
> void _lttng_ust_tracef(const char *fmt, ...)
> {
> 	va_list ap;
> -	char *msg;
> +	char local_buf[512];
> +	char *msg = local_buf;
> 	int len;
> 
> 	va_start(ap, fmt);
> -	len = vasprintf(&msg, fmt, ap);
> +	len = vsnprintf(local_buf, sizeof(local_buf), fmt, ap);
> +	if (len >= sizeof(local_buf)) {
> +		msg = (char *)malloc(len + 1);
> +		len = msg ? vsnprintf(msg, len + 1, fmt, ap) : -1;
> +	}
> +
> 	/* len does not include the final \0 */
> 	if (len < 0)
> 		goto end;
> 	__tracepoint_cb_lttng_ust_tracef___event(msg, len,
> 		LTTNG_UST_CALLER_IP());
> -	free(msg);
> end:
> +	if (msg != local_buf)
> +		free(msg);
> 	va_end(ap);
> }
> diff --git a/liblttng-ust/tracelog.c b/liblttng-ust/tracelog.c
> index 65fc87ed..a5d110fa 100644
> --- a/liblttng-ust/tracelog.c
> +++ b/liblttng-ust/tracelog.c
> @@ -35,19 +35,25 @@
> 			const char *fmt, ...) \
> 	{ \
> 		va_list ap; \
> -		char *msg; \
> +		char local_buf[512]; \
> +		char *msg = local_buf; \
> 		int len; \
> 		\
> 		va_start(ap, fmt); \
> -		len = vasprintf(&msg, fmt, ap); \
> +		len = vsnprintf(local_buf, sizeof(local_buf), fmt, ap); \
> +		if (len >= sizeof(local_buf)) { \
> +			msg = (char *)malloc(len + 1); \
> +			len = msg ? vsnprintf(msg, len + 1, fmt, ap) : -1; \
> +		} \
> 		/* len does not include the final \0 */ \
> 		if (len < 0) \
> 			goto end; \
> 		__tracepoint_cb_lttng_ust_tracelog___##level(file, \
> 			line, func, msg, len, \
> 			LTTNG_UST_CALLER_IP()); \
> -		free(msg); \
> 	end: \
> +		if (msg != local_buf) \
> +			free(msg); \
> 		va_end(ap); \
> 	}
> 
> --
> 2.30.2
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
