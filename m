Return-Path: <SRS0=Ztta=BC=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59C3C433E0
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Jul 2020 14:03:44 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B120207BB
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Jul 2020 14:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="J/NUGWaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B120207BB
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BCDZk6n7Fz1fYK;
	Thu, 23 Jul 2020 10:03:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1595513023;
	bh=lXQRyQ3h8VkBulh7IVodugBx5hThAtwYipG3wMidY+U=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=J/NUGWaQmvdRF+cQZjH77nAsHMlnxvwdPKlxzUujOt6HxRDubfv940J9dp2U/YUtS
	 cEc/RavTY3ggFxJRgYROW677k7tOud3RZr3m8TRaWpMxdvxzcFlg8PFhar0Jg2VQw1
	 a2HtUfHDrihYIOyqdRL188LW1xunEc7PD09FcuHWk8Tt6DX2dVzS1NoOy2j/RUb+ax
	 lI2P66ErZHXsHpbQ9KRkFIa+x8D4aUWtTiAsc6kxsENeEmjg4UPLJGi9JRcituzEx0
	 rG+9spZmoDOhF/nW6Nib1x9DNydJlRc0/Yks73TiVUfG5ZULCaXxMJUUCQ0LBB3IRd
	 zCtvPEBUl2vQA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4BCDZj2WGgz1g8j
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2020 10:03:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 157D92E6099
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2020 10:03:35 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 59dNEIZJrS8D; Thu, 23 Jul 2020 10:03:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DA92E2E601B;
 Thu, 23 Jul 2020 10:03:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DA92E2E601B
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 9CzSXaTbhIZO; Thu, 23 Jul 2020 10:03:34 -0400 (EDT)
Received: from joraj-alpa (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id 42A582E5EAA;
 Thu, 23 Jul 2020 10:03:34 -0400 (EDT)
Date: Thu, 23 Jul 2020 10:03:22 -0400
To: Seongab.Kim@harman.com
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Message-ID: <20200723140322.GA362716@joraj-alpa>
References: <08013efdc19d412b8c1535498ee7b828@HIMDWSMB06.ad.harman.com>
 <CAB4xu_2-vTRj-yu__CCDY-FwTYCVD5dS4TB6bAERnROotek1rA@mail.gmail.com>
 <7cb6526a78a9468e969a0fe36f42c6d7@HIMDWSMB06.ad.harman.com>
 <CAB4xu_1p0AYHhb1GASzOM9e-pdWmSkeTfZq2tQoyacso1MCUNA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAB4xu_1p0AYHhb1GASzOM9e-pdWmSkeTfZq2tQoyacso1MCUNA@mail.gmail.com>
Subject: Re: [lttng-dev] [EXTERNAL] Re: babeltrace cannot open the trace but
 Trace Compass can open
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200723140322.ANGwgCKr08WAMfO3ctD7Zm_3NttIW_mfgzG4hiqmLCk@z>

> When your account gets activated, could you copy this into the new
> issue's description?

I manually activated it. You should be good to go.

> 
> This way you can receive notifications when the issue gets updated.
> 
> Thank you,
> 
> Phil
> 
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
