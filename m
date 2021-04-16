Return-Path: <SRS0=Ki2T=JN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B77C433ED
	for <lttng-dev@archiver.kernel.org>; Fri, 16 Apr 2021 19:31:03 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD24960FF1
	for <lttng-dev@archiver.kernel.org>; Fri, 16 Apr 2021 19:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD24960FF1
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FMRC93yqlz1BwC;
	Fri, 16 Apr 2021 15:31:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1618601461;
	bh=/0QKFijVyQpMJYZaXoEMepa/3gqFV/lkCyBgUcJHa8I=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=S+ekU51KWqCccLWpEGpo3qFvH3eWx8b4/IV1JIpZxNHGNAIqA2hhkXHrzMoEwC4XE
	 HRw1qwh9O+w6N8Rv2MRkFwTwV4iJkmCGSJ9FNPGhczHezyxKq02QuyBNiwRC52PrwD
	 DMpx+UKqep0GFW1oekhbekvnUTWuCL7vQPziJ001mEu0qQap9D4sc4ATNs9sYUZz/Y
	 kb8YnqH3QLOTGoZh1Xf0CagAqeaSbnDYG2WCgIs1tJlSazsBaJdsoS3aT8d5DD8lT/
	 H6ViI+PHq7efoQ/rpd9S0QR/nwLzlFubVn8W3rZKW0YkUTdKuzoFAwMORDUJw0x7Of
	 Yby+EW4LzOQeQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FMRC84PWMz1Bk1
 for <lttng-dev@lists.lttng.org>; Fri, 16 Apr 2021 15:31:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4CA6C33A763
 for <lttng-dev@lists.lttng.org>; Fri, 16 Apr 2021 15:30:54 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id gcgjM8I8umO1; Fri, 16 Apr 2021 15:30:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B7B4133A951;
 Fri, 16 Apr 2021 15:30:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B7B4133A951
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 79Qiehg1WzRj; Fri, 16 Apr 2021 15:30:53 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id AA81133A761;
 Fri, 16 Apr 2021 15:30:53 -0400 (EDT)
Date: Fri, 16 Apr 2021 15:30:53 -0400 (EDT)
To: paulmck <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>, 
 lttng-dev <lttng-dev@lists.lttng.org>, Carlos O'Donell <carlos@redhat.com>
Message-ID: <2056094038.84390.1618601453585.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210416190244.GJ4212@paulmck-ThinkPad-P17-Gen-1>
References: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com>
 <YHmqd3BHwVmaUZHX@hirez.programming.kicks-ass.net>
 <20210416160139.GF4212@paulmck-ThinkPad-P17-Gen-1>
 <2089952450.84139.1618598408015.JavaMail.zimbra@efficios.com>
 <20210416190244.GJ4212@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: liburcu: LTO breaking rcu_dereference on arm64 and possibly
 other architectures ?
Thread-Index: U+jByog9nw+xnur8wetlu9vzLfobNQ==
Subject: Re: [lttng-dev] liburcu: LTO breaking rcu_dereference on arm64 and
 possibly other architectures ?
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

----- On Apr 16, 2021, at 3:02 PM, paulmck paulmck@kernel.org wrote:
[...]
> 
> If it can be done reasonably, I suggest also having some way for the
> person building userspace RCU to say "I know what I am doing, so do
> it with volatile rather than memory_order_consume."

Like so ?

#define CMM_ACCESS_ONCE(x) (*(__volatile__  __typeof__(x) *)&(x))
#define CMM_LOAD_SHARED(p) CMM_ACCESS_ONCE(p)

/*
 * By defining URCU_DEREFERENCE_USE_VOLATILE, the user requires use of
 * volatile access to implement rcu_dereference rather than
 * memory_order_consume load from the C11/C++11 standards.
 *
 * This may improve performance on weakly-ordered architectures where
 * the compiler implements memory_order_consume as a
 * memory_order_acquire, which is stricter than required by the
 * standard.
 *
 * Note that using volatile accesses for rcu_dereference may cause
 * LTO to generate incorrectly ordered code starting from C11/C++11.
 */

#ifdef URCU_DEREFERENCE_USE_VOLATILE
# define rcu_dereference(x)     CMM_LOAD_SHARED(x)
#else
# if defined (__cplusplus)
#  if __cplusplus >= 201103L
#   include <atomic>
#   define rcu_dereference(x)   ((std::atomic<__typeof__(x)>)(x)).load(std::memory_order_consume)
#  else
#   define rcu_dereference(x)   CMM_LOAD_SHARED(x)
#  endif
# else
#  if (defined(__STDC_VERSION__) && __STDC_VERSION__ >= 201112L)
#   include <stdatomic.h>
#   define rcu_dereference(x)   atomic_load_explicit(&(x), memory_order_consume)
#  else
#   define rcu_dereference(x)   CMM_LOAD_SHARED(x)
#  endif
# endif
#endif

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
