Return-Path: <SRS0=PeGe=JD=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AC9C433ED
	for <lttng-dev@archiver.kernel.org>; Tue,  6 Apr 2021 20:06:06 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC9E613C4
	for <lttng-dev@archiver.kernel.org>; Tue,  6 Apr 2021 20:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC9E613C4
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FFJSC4kbFz13cg;
	Tue,  6 Apr 2021 16:06:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617739564;
	bh=afBnopMUOuWOikxMmDn8CmMy7VMzVwUKspbICTilVi0=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=zuaoetBmFCpj2ldLWLyHCsz+7hOGXKkXjWQQBf9d1ec8WAcoPUZ8Ur4CST+9YjRR8
	 Bks6W4Pdp2hBXu+wnQw1+VqX63g4h904l5n/NYX6RTXv1CdE13u+IkNfC4FypvYe6s
	 IE1s/3PUaxtHXUpOy18Smi+5WmA05t3yQz1+jnyUk6KemcrFsRB/J+jF7PKiKWBPt1
	 o142fUFNhYw2SabjLWDIOF1iLasd/+G5aOeYLRd0baDfOFGkqKE+9sJNhqw5WBUoVT
	 5sspz93qgDWGU7x5uOt+ksHcORKyKmWSx58KbZiZZvBq9YE4+4tqOjGUiTacFbBJIN
	 0kW1rYIMM80jg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FFJS964y5z13JJ
 for <lttng-dev@lists.lttng.org>; Tue,  6 Apr 2021 16:06:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9CA7031EE77
 for <lttng-dev@lists.lttng.org>; Tue,  6 Apr 2021 16:05:55 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 7dCC4uMVVgaP; Tue,  6 Apr 2021 16:05:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9D57231F0EB;
 Tue,  6 Apr 2021 16:05:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9D57231F0EB
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id gU-VACLFgjNN; Tue,  6 Apr 2021 16:05:54 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 910F331F0E6;
 Tue,  6 Apr 2021 16:05:54 -0400 (EDT)
Date: Tue, 6 Apr 2021 16:05:54 -0400 (EDT)
To: lbj <lbj137@yahoo.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>
Message-ID: <1546175211.59087.1617739554450.JavaMail.zimbra@efficios.com>
In-Reply-To: <13D87E55-7D1B-49B0-9555-656A837ADEB3@yahoo.com>
References: <13D87E55-7D1B-49B0-9555-656A837ADEB3.ref@yahoo.com>
 <13D87E55-7D1B-49B0-9555-656A837ADEB3@yahoo.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: QSBR urcu question
Thread-Index: nlQbUNznhof7VXdQmDACGF+iWOgu2g==
Subject: Re: [lttng-dev] QSBR urcu question
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

----- On Apr 5, 2021, at 1:43 PM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Hello all,
> 
> I am using the QSBR flavor of URCU and I have a question: is it ok to call
> rcu_register_thread more than once per thread?

Yes, but you should unregister before registering again.

> Similarly, is it ok to call
> rcu_unregister_thread more than once per thread?

Likewise: you should not have 2 unregistrations back-to-back without a
registration in between.

Note however that frequent registration/unregistration of a thread can lead to
significant performance overhead and lock contention on the rcu_registry_lock,
which is likely something you will want to avoid.

> I am using a library that uses
> a threadpool I have no control over. A thread from its threadpool invokes a
> callback function of mine. Threads may be reused. I would like to call
> rcu_register_thread at the beginning of my callback and rcu_unregister_thread
> at the end. The thread in question may exit or may be reused at some later
> point, I have no control over that. So I want to make sure that periodically
> registering and unregistering the same thread is ok. Thanks for any
> information.

You may want to use the "urcu-bp" flavor instead. It has a slightly higher
overhead than qsbr, but won't require as much fine-tuned integration with the
threadpool runtime.

But if you really want to do an efficient integration of urcu-qsbr with the threadpool
without changing any of the threadpool, here are a few ideas though:

- you could keep a "qsbr_registered" state in a TLS variable owned by your application,
- lazily perform qsbr registration if needed, based on the "qsbr_registered" state,
- put thread "offline" before returning control to the threadpool,
- put thread "online" when entering your code again,
- if the threadpool can call your application before the thread exits, then use that
  to unregister qsbr. Else, you could always use a dummy pthread key to have an application
  destructor called on thread exit, and unregister qsbr that way,

Hoping this help!

Best regards,

Mathieu

> 
> Jeff
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
