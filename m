Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DA7C43334
	for <lttng-dev@archiver.kernel.org>; Wed, 20 Jul 2022 20:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1658350094;
	bh=559sJ8SMFpuqzW3Yfwj79GaCpgNU14BUBLeylpPm5gw=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=DTE5i1l6ZT/lWgOfVlXAX+B7BDpwdXpTd31FVtmrGbu8IdmgslUihfGm+dCR/gOhd
	 o44K9G1MpJoXsV6PUxm1atXLPGZGklzV+Cr2K0xQ+KYKW2fj7ClY2cEPVXApgKiOLe
	 YmDViZcI2fTXlcDVfP4mYMzs9scaUGghEjoFve8YaK3pXAxfbMIImWUfLgHd8j4oYE
	 JbS9daKdf7an1Pmry/ug2V0JYLWi0wvGOSfemHLX4yUKf/eyYT+qM0VZfPVfhSur4s
	 Ab2MPnUlcBnhAstBk3KcvNK5IVN5tVg78R9rMSAO9o6l6yfoy4efKcQlLTtY1syTsd
	 M7qrjfZQX6YmQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Lp77x5GSqzQCH;
	Wed, 20 Jul 2022 16:48:13 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Lp77w117czQ9L
 for <lttng-dev@lists.lttng.org>; Wed, 20 Jul 2022 16:48:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 20D593ABD34
 for <lttng-dev@lists.lttng.org>; Wed, 20 Jul 2022 16:48:05 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id U4KKFTox2txy; Wed, 20 Jul 2022 16:48:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A687B3ABD15;
 Wed, 20 Jul 2022 16:48:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A687B3ABD15
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id PCvMHC8SQ3ha; Wed, 20 Jul 2022 16:48:04 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 98B9E3ABC74;
 Wed, 20 Jul 2022 16:48:04 -0400 (EDT)
Date: Wed, 20 Jul 2022 16:48:04 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1505688139.75465.1658350084533.JavaMail.zimbra@efficios.com>
In-Reply-To: <CADYdroOM93P9HyxZQAuEhZZNFWXoDobh3XTwCdCO0j0BG5rANQ@mail.gmail.com>
References: <20220718215955.124991-1-nolange79@gmail.com>
 <1399876011.74159.1658259573115.JavaMail.zimbra@efficios.com>
 <CADYdroOM93P9HyxZQAuEhZZNFWXoDobh3XTwCdCO0j0BG5rANQ@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4304)
Thread-Topic: lttng_ust_init_thread: initialise cached context values
Thread-Index: xJcUs2dBqXIj6K4InYwHbw5Kff6HOA==
Subject: Re: [lttng-dev] [PATCH 1/2] lttng_ust_init_thread: initialise
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

----- On Jul 20, 2022, at 4:00 PM, Norbert Lange nolange79@gmail.com wrote:

> Am Di., 19. Juli 2022 um 21:39 Uhr schrieb Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com>:
>>
>> ----- On Jul 18, 2022, at 5:59 PM, Norbert Lange via lttng-dev
>> lttng-dev@lists.lttng.org wrote:
>>
>> > Modify all relevant *_alloc_tls functions so that they take an
>> > argument for 'init'. Setting this to 'true' will read
>> > the actual context value and store it into a thread local
>> > cache.
>> >
>> > The function 'lttng_ust_init_thread' will use this to
>> > precalculate context values. Tracepoints can then avoid
>> > systemcalls.
>>
>> Rather than integrating two unrelated things within "alloc_tls"
>> functions, I would prefer that we split things like this, e.g.:
>>
>> keep lttng_cgroup_ns_alloc_tls() as is.
>>
>> Introduce lttng_ust_cgroup_init_thread() which would
>> call (void)get_cgroup_ns().
>>
>> Likewise for all other contexts.
>>
>> Thoughts ?
> 
> is this just a matter of the function name? The "things" are
> related as they both prepare the same thread local cache.
> 
> ie.
> rename lttng_cgroup_ns_alloc_tls(bool init) to
> lttng_ust_cgroup_init_thread(bool initcache)?
> 
> Don't care much either way,I  just usually try to limit symbols.

So AFAIU when only alloc_tls is needed, you would just change that
for lttng_ust_cgroup_init_thread(false), correct ?

I would then prefer that we introduce flags rather than rely on a
boolean to make it immediately clear what is done from the callsite,
e.g.:

enum lttng_ust_init_thread_flags {
  LTTNG_UST_INIT_THREAD_TLS = (1 << 0),
  LTTNG_UST_INIT_THREAD_CONTEXT_CACHE = (1 << 1),
}

lttng_ust_cgroup_init_thread(int init_thread_flags)

And then call either:

lttng_ust_cgroup_init_thread(LTTNG_UST_INIT_THREAD_TLS)
to initialize the tls.

lttng_ust_cgroup_init_thread(LTTNG_UST_INIT_THREAD_CONTEXT_CACHE)
to initialize the thread context cache.

or
lttng_ust_cgroup_init_thread(LTTNG_UST_INIT_THREAD_TLS | LTTNG_UST_INIT_THREAD_CONTEXT_CACHE)
to initialize both.

Thoughts ?

Thanks,

Mathieu

> 
> Regards,
> Norbert

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
