Return-Path: <SRS0=1TmG=JM=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFDBC433ED
	for <lttng-dev@archiver.kernel.org>; Thu, 15 Apr 2021 12:20:53 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E9C61222
	for <lttng-dev@archiver.kernel.org>; Thu, 15 Apr 2021 12:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E9C61222
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FLdjG3JRPz1BCK;
	Thu, 15 Apr 2021 08:20:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1618489251;
	bh=uFCufTGxcDxtbMuHtBpAj/JCqW/lYvVHGEJSXxjMLok=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Efk2YDzX2p75vFUNpQzTGsgx3bt3H/IgcIf7q7FjJbALripqZ7NsOWBNfgto4OJTi
	 XUI7En4HVTLxV5xGkd7eEsDI7AZoX2b/K4PR2XWN09NLLaGlXPDVGLILk/sOuN7I48
	 yTQJhmkiV4iJHFqbV/ZYYB0KlkK21AX/WkWwFKAXYntsCWwJGUh/g3DAYCR50q0EJZ
	 xINuzQA2dohr0k4j4xqdgAOJ5KDm9OAaalulDcIEK3au6c/qRzNKk9OWPst7VU+DHN
	 xMUffiuy3xbJPafKJ4D3ko1KLB4avahvaVO9pUsF3dGZqGefGLutHlosogKvHqNE9I
	 Fw32YL/qQTt6Q==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FLdjF3N3Hz19ns
 for <lttng-dev@lists.lttng.org>; Thu, 15 Apr 2021 08:20:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 332C232BFD1
 for <lttng-dev@lists.lttng.org>; Thu, 15 Apr 2021 08:20:43 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id q1Y5FoI3HEGT; Thu, 15 Apr 2021 08:20:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A890D32C04F;
 Thu, 15 Apr 2021 08:20:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A890D32C04F
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 3oCNqJVegseD; Thu, 15 Apr 2021 08:20:42 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 8970F32C04A;
 Thu, 15 Apr 2021 08:20:42 -0400 (EDT)
Date: Thu, 15 Apr 2021 08:20:42 -0400 (EDT)
To: lbj <lbj137@yahoo.com>, paulmck <paulmck@kernel.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1791312961.77601.1618489242390.JavaMail.zimbra@efficios.com>
In-Reply-To: <793BB53F-CE1B-4A8A-8D6D-850C7A144DBB@yahoo.com>
References: <1546175211.59087.1617739554450.JavaMail.zimbra@efficios.com>
 <793BB53F-CE1B-4A8A-8D6D-850C7A144DBB@yahoo.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: QSBR urcu read lock question
Thread-Index: jJYF+3USoCaGg2NPW31xy2ZIDoGpHA==
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

----- On Apr 13, 2021, at 11:19 PM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Hello all,
> 
> I have two different entities that are both protected by QSBR rcu: a policy and
> a hashtable. In the reclamation thread for the policy I would like to take a
> read lock so that I can safely iterate through the hashtable. I dont see
> anything wrong with this, but I just wanted to make sure it was ok since taking
> an rcu read lock in an rcu reclamation thread seems like it may be a bit
> suspect. Thanks for any insights, let me know if clarification is needed!

When you say "the reclamation thread for the policy", do you refer to a call-rcu
worker thread ?

Also, you are aware that RCU read-side lock/unlock are effectively no-ops for
QSBR rcu, right ?

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
