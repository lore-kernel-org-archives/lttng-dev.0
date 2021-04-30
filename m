Return-Path: <SRS0=FVAl=J3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4808C433ED
	for <lttng-dev@archiver.kernel.org>; Fri, 30 Apr 2021 18:41:56 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E44613E7
	for <lttng-dev@archiver.kernel.org>; Fri, 30 Apr 2021 18:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E44613E7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FX1S063qpz1fcb;
	Fri, 30 Apr 2021 14:41:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1619808113;
	bh=JAV1mteI252K7vGn5iLd0d/oeJB+I7liQVxv06PQSVY=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=oI2T6DP5o8mQAvithbOS5+DR62/AkvIxeoZbg9YzZAyGgtmoQ2Zy++g+YA/3nrwCI
	 id/fJz0v5fabe0EjXSy8J2GpFclIBps43nUANWsw0WlEvdjdREZgew14BRKLIeuVHL
	 BisGOM92vn8gjMJHagq+Um4yNmG4YmHwN8Px8455ypruRp0RueBSpXega2xHKsxPE+
	 Ki9F7cR6da3aG9nwJTLjVKO3GwRTBEOQAFbMaE8t7QhTA2bpp4wCPX2yi9YQ/77DzP
	 hPdLcfCRdnsSaQ19h8ceGJh/bxP1xSJ2gMguHauFD0VYsuVzt/AYJbqmivW9WbFP9y
	 drsr/8BLCUMew==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FX1Rz5zxnz1fVC
 for <lttng-dev@lists.lttng.org>; Fri, 30 Apr 2021 14:41:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2D4B632A7AC
 for <lttng-dev@lists.lttng.org>; Fri, 30 Apr 2021 14:41:45 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id wXprenq9h42U; Fri, 30 Apr 2021 14:41:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 057CD32A754;
 Fri, 30 Apr 2021 14:41:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 057CD32A754
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Ccka3uMurfKx; Fri, 30 Apr 2021 14:41:43 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id ED0B332A74F;
 Fri, 30 Apr 2021 14:41:43 -0400 (EDT)
Date: Fri, 30 Apr 2021 14:41:43 -0400 (EDT)
To: Martin Wilck <mwilck@suse.com>, paulmck <paulmck@kernel.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <580855125.21864.1619808103861.JavaMail.zimbra@efficios.com>
In-Reply-To: <ebac01302ecae6cc2dd0ace8fcfffa6ab593e0fe.camel@suse.com>
References: <ebac01302ecae6cc2dd0ace8fcfffa6ab593e0fe.camel@suse.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4007)
Thread-Topic: User-space RCU: call rcu_barrier() before dissociating helper
 thread?
Thread-Index: QFwRMkYlpO8s9MILkSrvRbf0LEotog==
Subject: Re: [lttng-dev] User-space RCU: call rcu_barrier() before
 dissociating helper thread?
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

----- On Apr 29, 2021, at 9:49 AM, lttng-dev lttng-dev@lists.lttng.org wrote:

> In multipath-tools, we are using a custom RCU helper thread, which is cleaned
> out
> on exit:
> 
> https://github.com/opensvc/multipath-tools/blob/23a01fa679481ff1144139222fbd2c4c863b78f8/multipathd/main.c#L3058
> 
> I put a call to rcu_barrier() there in order to make sure all callbacks had
> finished
> before detaching the helper thread.
> 
> Now we got a report that rcu_barrier() isn't available before user-space RCU 0.8
> (https://github.com/opensvc/multipath-tools/issues/5) (and RHEL7 / Centos7
> still has 0.7.16).
> 
> Question: was it over-cautious or otherwise wrong to call rcu_barrier() before
> set_thread_call_rcu_data(NULL)? Can we maybe just skip this call? If no, what
> would be the recommended way for liburcu < 0.8 to dissociate a helper thread?
> 
> (Note: I'm not currently subscribed to lttng-dev).

First of all, there is a significant reason why liburcu does not free the "default"
call_rcu worker thread data structures at process exit. This is caused by the fact that
a call_rcu callback may very well invoke call_rcu() to re-enqueue more work.

AFAIU this is somewhat similar to what happens to the Linux kernel RCU implementation
when the machine needs to be shutdown or rebooted: there may indeed never be any point
in time where it is safe to free the call_rcu worker thread data structures without leaks,
due to the fact that a call_rcu callback may re-enqueue further work indefinitely.

So my understanding is that you implement your own call rcu worker thread because the
one provided by liburcu leaks data structure on process exit, and you expect that
call rcu_barrier once will suffice to ensure quiescence of the call rcu worker thread
data structures. Unfortunately, this does not cover the scenario where a call_rcu
callback re-enqueues additional work.

So without knowing more details on the reasons why you wish to clean up memory at
process exit, and why it would be valid to do so in your particular use-case, it's
rather difficult for me to elaborate a complete answer.

I can see that maybe we could change liburcu to make it so that we free all
call_rcu data structures _if_ they happen to be empty of callbacks at process exit,
after invoking one rcu_barrier. That should take care of not leaking data structures
in the common case where call_rcu does not enqueue further callbacks.

Thoughts ?

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
