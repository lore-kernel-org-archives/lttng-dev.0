Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47391C433EF
	for <lttng-dev@archiver.kernel.org>; Fri, 14 Jan 2022 19:49:13 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JbBh80DY5zFZ0;
	Fri, 14 Jan 2022 14:49:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642189752;
	bh=odrxM9PnnPhi6npUCbfWgakbrLZIhavNQTqlFwcCJq0=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=FG2bEMB85ipJqr6EFypCZ4SCi230LsPUqtmDFVYyUGZAIUL+3FxHUMClWV9u5jd85
	 3FTL2LXJNGnHYEAl++WaqvZGxbV6SZBxWT6PEUb3Lrmjdo/7RsIQ3vOpRxOVuG3Jkv
	 qhx0kzr10rVKD/mG1cvyBfOz4ISi6bmYVIWza7mIglysGA49bm1XH2m33aGzLJQo3s
	 yt9/vN+i6am4itCSFQuxCELXHgiWYbkeHa0REqkqQj3Fgq1VvlFMxBSdnfhFL1UZuu
	 tonknmNElpJhwY9aOQZB8u02prnqx74IApE7E1E4gi85WKAAORsF5YOrH3Uktn+1xB
	 rrDYmZ6fjGA3w==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JbBh63fdWzFRx
 for <lttng-dev@lists.lttng.org>; Fri, 14 Jan 2022 14:49:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 496582D5368;
 Fri, 14 Jan 2022 14:49:04 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id dR4ilVvnnLVl; Fri, 14 Jan 2022 14:49:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0CB142D5367;
 Fri, 14 Jan 2022 14:49:04 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0CB142D5367
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id xVPzSH2hPYEG; Fri, 14 Jan 2022 14:49:04 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 007692D5890;
 Fri, 14 Jan 2022 14:49:03 -0500 (EST)
Date: Fri, 14 Jan 2022 14:49:03 -0500 (EST)
To: Julien Desfossez <ju@klipix.org>
Cc: Jeremie Galarneau <jgalar@efficios.com>, 
 lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <212959050.34078.1642189743892.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Index: Fvk9Aa6bRoTmShuS1YfrvlnjCBsfqw==
Thread-Topic: Transfer of LTTng copyright ownership: Julien Desfossez
Subject: [lttng-dev] Transfer of LTTng copyright ownership: Julien Desfossez
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
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

Hi Julien,

In order to facilitate maintenance of the LTTng project, would you agree to
transfer your copyright ownership for code authored outside of your employment
at EfficiOS to EfficiOS Inc. ?

This particularly affects the lttng-tools, lttng-ust and lttng-modules files
with copyright:

Copyright (C) 201N Julien Desfossez <julien.desfossez@polymtl.ca>

Thanks for all your contributions to LTTng !

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
