Return-Path: <SRS0=1TmG=JM=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E41C433ED
	for <lttng-dev@archiver.kernel.org>; Thu, 15 Apr 2021 16:00:39 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3B5611AB
	for <lttng-dev@archiver.kernel.org>; Thu, 15 Apr 2021 16:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3B5611AB
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FLkZr3xqPz1BS9;
	Thu, 15 Apr 2021 12:00:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1618502437;
	bh=VKmRhQhFBXNqQhHJPO7JaCVmw36dZPxXe/E6RcVFwVA=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=wU2beIqcwnawCqjg6sJZq+4a7I7Kz2YMP6801Gqd1gjH+yQmMAdevowmyT2AEn4fT
	 GKJjRBgOvIVSzML2jOkyNRhf4tGAfQbNYNigbne7QNOJSbbET2Ay0JOH1Iyz/tZXCK
	 11Vil8lc1foVE8Arcx1YUuTfly5xRjvqIn6GnEmmsZ/2y07+7pytkNrbRd1Hlr+AQf
	 CxafChWuHrP/pIDFNSUBkPpE67wB+KmxIlYwifouqmAclRJwyHF+r/SCKvs4Rdw0Le
	 pZbSqaxVVYyIoZ5nRbBbIQEPaw9AqGwLx0qmsfm1LJfwXCv6Wmx3ZW+xb95kncZPLH
	 TKcal9c4o8iJg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FLkZq3JjZz1BS7
 for <lttng-dev@lists.lttng.org>; Thu, 15 Apr 2021 12:00:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 04BDE32DBCE
 for <lttng-dev@lists.lttng.org>; Thu, 15 Apr 2021 12:00:29 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id rdHoBcQsgJxC; Thu, 15 Apr 2021 12:00:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9071132DBCD;
 Thu, 15 Apr 2021 12:00:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9071132DBCD
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Ndf9cx-mfVEB; Thu, 15 Apr 2021 12:00:28 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 7B8F232D86D;
 Thu, 15 Apr 2021 12:00:28 -0400 (EDT)
Date: Thu, 15 Apr 2021 12:00:28 -0400 (EDT)
To: lbj <lbj137@yahoo.com>
Cc: paulmck <paulmck@kernel.org>, lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <219280299.78204.1618502428396.JavaMail.zimbra@efficios.com>
In-Reply-To: <7E67A2E3-2ABD-430D-8F06-A09A6E69FD8C@yahoo.com>
References: <412098958.77686.1618491853089.JavaMail.zimbra@efficios.com>
 <7E67A2E3-2ABD-430D-8F06-A09A6E69FD8C@yahoo.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: QSBR urcu read lock question
Thread-Index: nLQzDa0ilDyo/mKTGWaTlW8XQn2Zvg==
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

----- On Apr 15, 2021, at 10:54 AM, lbj lbj137@yahoo.com wrote:

> Mathieu,
> Thanks so much for your wealth if information and timely responses, they are
> greatly appreciated. Final question: is there any harm in explicitly calling
> rcu_thread_online/rcu_thread_offline from within my call_rcu callback function?
> From what you described it sounds like it would be redundant, but presumably
> would be harmless. Correct? Thanks again.

You could indeed invoke pairs of:

  rcu_thread_offline();   <--- emphasis on _offline_ here.
  [ long wait ... ]
  rcu_thread_online();

in that specific order within the call-rcu worker thread. Note that the qsbr state
of the call-rcu worker thread is "online" when it invokes the callbacks, so each callback
should make sure that state is back to "online" before it returns control back
to its caller.

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
