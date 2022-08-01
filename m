Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546B2C00144
	for <lttng-dev@archiver.kernel.org>; Mon,  1 Aug 2022 15:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1659366682;
	bh=n9Mi2w5FpTTlt4FoIoqY+IE0PHGowgJoxmS/8IwSZmw=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=sdyHErDdEAenfT5MxrgOkl4WKM2cRrigvDCJWKPANLPlsIdKYTipISso8DBwfW467
	 9UB1JVnAXnXLO6dK4JeX8XEfZP0EfyO0q4oHCzER3egCIjs/4pK4YB5rbIVefiCRPS
	 qrgd/zC+i+SJc3+sES0lP/QE/dyoPhEptgRXodTWSBmTlLacPSXZUctpzYbe78C7nQ
	 1uP8FFDPK0u2FCFgGa9fPsE1ERgIKluyS8p+aM2rqE3H1Pt8LWxegDZu3FnAIdbiJY
	 hkJNs82ZmJqj3g9MAXVYDjlIi1TCw5x1zr4n3UdRUP8RRkBRreqEbro3G3UlI+TglN
	 +wHadBl/pwrvw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LxM5j55TGz1150;
	Mon,  1 Aug 2022 11:11:21 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LxM5h1D4Kz11GZ
 for <lttng-dev@lists.lttng.org>; Mon,  1 Aug 2022 11:11:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A52FB35535D
 for <lttng-dev@lists.lttng.org>; Mon,  1 Aug 2022 11:11:19 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id fVqDpgJWmYGk; Mon,  1 Aug 2022 11:11:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3281835568E;
 Mon,  1 Aug 2022 11:11:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3281835568E
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id WNBcMSZ_Fffe; Mon,  1 Aug 2022 11:11:19 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 2A75A35568D;
 Mon,  1 Aug 2022 11:11:19 -0400 (EDT)
Date: Mon, 1 Aug 2022 11:11:19 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <275925552.93582.1659366679082.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220801143700.160380-1-norbert.lange@andritz.com>
References: <20220801143700.160380-1-norbert.lange@andritz.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4304)
Thread-Topic: lttng_ust_init_thread: initialise cached context values
Thread-Index: EmAtzBjl5T839NfDUytQuT+1QDGnRQ==
Subject: Re: [lttng-dev] [PATCH v2 1/2] lttng_ust_init_thread: initialise
 cached context values
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

----- On Aug 1, 2022, at 10:36 AM, Norbert Lange via lttng-dev lttng-dev@lists.lttng.org wrote:

> #else /* #ifdef HAVE_LINUX_PERF_EVENT_H */
> static inline
> -void lttng_ust_perf_counter_alloc_tls(void)
> +void lttng_ust_perf_counter_init_thread(int flags)

Using 

void lttng_ust_perf_counter_init_thread(int flags __attribute__((unused)))

instead.

> {
> +	(void)flags;
> }

Will fixup locally and merge.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
