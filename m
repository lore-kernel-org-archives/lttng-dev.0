Return-Path: <SRS0=1TmG=JM=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F53C433ED
	for <lttng-dev@archiver.kernel.org>; Thu, 15 Apr 2021 19:26:15 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FBA610E8
	for <lttng-dev@archiver.kernel.org>; Thu, 15 Apr 2021 19:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FBA610E8
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FLq831TpXz1BHM;
	Thu, 15 Apr 2021 15:26:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1618514771;
	bh=sxbk32q2Lk70sw2do9nlOqVeoQ7hElSvvHCMJtfnMZw=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=zUsaEq/m2er3/zm9/+IICZL9axCC8Aa/1D3+VdsURJ7mSOXsXrbJhCnZmxAVc342B
	 U0iPn6s6/gULjaaQdOWfECa6SE/WWXE3KbKlRauRViVvbKq0YUZfb3cKRgOQ5GZfLR
	 FCm8syu1S5HWbO8RGK21VugKLIjaIDpMel7ApUdkrbIkaKWbUvm8y+ikEAEgKvv7JD
	 t51wpU1M8IPnGSxJughj0uRvES0G1J3W/dQAyeeiRYAnyWo0fVIPzMjOpseLF9+Ot+
	 G3MQDM3yMbxp0zG5Iv2buZt+b9sovT7rECz9Z9sSWo2pueKWt0GybDhxyTN3Dgf7r9
	 oV2j5Ww2R5lqg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FLq814NZ0z1BKZ
 for <lttng-dev@lists.lttng.org>; Thu, 15 Apr 2021 15:26:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4795E32FD1C
 for <lttng-dev@lists.lttng.org>; Thu, 15 Apr 2021 15:26:03 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id QotttKHqR27J; Thu, 15 Apr 2021 15:26:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 16DFE32FD15;
 Thu, 15 Apr 2021 15:26:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 16DFE32FD15
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Po4uVHv3zFcq; Thu, 15 Apr 2021 15:26:01 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 0B6AE32FD0C;
 Thu, 15 Apr 2021 15:26:01 -0400 (EDT)
Date: Thu, 15 Apr 2021 15:26:00 -0400 (EDT)
To: lbj <lbj137@yahoo.com>
Cc: paulmck <paulmck@kernel.org>, lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <981542164.79155.1618514760912.JavaMail.zimbra@efficios.com>
In-Reply-To: <D6D81B40-920B-46C8-ABBB-9AD856F0D949@yahoo.com>
References: <219280299.78204.1618502428396.JavaMail.zimbra@efficios.com>
 <D6D81B40-920B-46C8-ABBB-9AD856F0D949@yahoo.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: QSBR urcu read lock question
Thread-Index: V+qQwZL7SvqGRpcCKGbEmmqqoZ/2RQ==
Subject: Re: [lttng-dev] QSBR urcu read lock question
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

----- On Apr 15, 2021, at 2:11 PM, lbj lbj137@yahoo.com wrote:

> Thanks Mathieu. Is it safe to assume that if call_rcu is called twice then the
> callbacks are executed in the order that call_rcu was invoked? I think there is
> a queue and only one thread that QSBR uses to handle callbacks, i just wanted
> to make sure that the queue was a guaranteed fifo.

It may very well depend on your configuration. For instance, if an application
invokes create_all_cpu_call_rcu_data(), it will create per-cpu worker threads
on each possible CPU. In that configuration, a given thread invoking call_rcu()
twice (back to back) may be migrated from one CPU to another in between, hence
different call-rcu worker threads will be responsible for executing the callbacks,
and they can be executed in any order.

So even though by careful analysis of your specific application configuration you
may presume that the callbacks will be executed in the same order they were invoked,
this is not guaranteed by the API, so I would not recommend relying on FIFO order
assumptions.

And given that the call_rcu API does not guarantee FIFO order, we could eventually
decide to change the order of callback execution from FIFO to LIFO if it leads to
performance improvements due to better cache locality.

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
