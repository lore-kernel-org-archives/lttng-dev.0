Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79897C25B08
	for <lttng-dev@archiver.kernel.org>; Sat, 20 Aug 2022 19:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1661022831;
	bh=Li8Lol3F3H0qfYbCPPukQeOuHu4koezoUFNIw8LFj4U=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=qWUAWRnuwNDBL//irtdurVnSP3GHz1SjYMtCENxSPurH2VOo7x50CFFGfvNv4P9g8
	 p0SLsjmiBkiqdY7zG+w2FTCc0lnMoPPm69CvKLgA4MfkyanAIG4V3/FGMmmAs2rNxo
	 b4Md9iB6EhJBZ6XKErMXrLo2TEa7oa+Hcv1GBeVOoiZ2nORvu8o0OBrcuViPqarfYT
	 ar1IJ+45zfQYuH/zyTyjlRx8ZDMGEohZv5pCxknMmEmWmtVt7t7XQqK5kKJC4qBo28
	 AQ4SXGqxoAILIHyfWR2qoo82NenOCxeFviel4UtaHVZj3Xpzy97E1BoIZ1DV3CWvnz
	 KEWEws6Kse+RQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M97Zk4F19z1KwF;
	Sat, 20 Aug 2022 15:13:50 -0400 (EDT)
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
 by lists.lttng.org (Postfix) with ESMTPS id 4M97Zj26YPz1KkW
 for <lttng-dev@lists.lttng.org>; Sat, 20 Aug 2022 15:13:49 -0400 (EDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
 by dcvr.yhbt.net (Postfix) with ESMTP id 4D2CA1F54E;
 Sat, 20 Aug 2022 19:13:48 +0000 (UTC)
Date: Sat, 20 Aug 2022 19:13:48 +0000
To: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <20220820191348.GC5248@dcvr>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] efficios MX problems? (was: urcu 7ca7fe9c03 +
 _LGPL_SOURCE regression?)
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
From: Eric Wong via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Eric Wong <normalperson@yhbt.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

I'm not sure why b.barracudacentral.org doesn't like my MTA.
I got something similar in my initial message to Simon but
brushed it off thinking it was a fluke, but I just got this
again with Mathieu in the recipient list, as well.

dcvr.yhbt.net was recently forced to get a new IP address,
but DKIM + SPF are set up and it manages to deliver fine to
at least one major email provider:

> Reporting-MTA: dns; dcvr.yhbt.net
> X-Postfix-Queue-ID: 343331F54E
> X-Postfix-Sender: rfc822; normalperson@yhbt.net
> Arrival-Date: Sat, 20 Aug 2022 18:51:43 +0000 (UTC)
> 
> Final-Recipient: rfc822; mathieu.desnoyers@efficios.com
> Original-Recipient: rfc822;mathieu.desnoyers@efficios.com
> Action: failed
> Status: 5.7.1
> Remote-MTA: dns; mail.efficios.com
> Diagnostic-Code: smtp; 550 5.7.1 Service unavailable; client [173.255.242.215]
>     blocked using b.barracudacentral.org
> 
> Final-Recipient: rfc822; simon.marchi@efficios.com
> Original-Recipient: rfc822;simon.marchi@efficios.com
> Action: failed
> Status: 5.7.1
> Remote-MTA: dns; mail.efficios.com
> Diagnostic-Code: smtp; 550 5.7.1 Service unavailable; client [173.255.242.215]
>     blocked using b.barracudacentral.org

I wonder if any other self-hosters are hitting this problem...
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
