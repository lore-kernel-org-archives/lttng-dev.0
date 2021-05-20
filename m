Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA5CC43460
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 13:33:48 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F467610A2
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 13:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F467610A2
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fm9gH0tzwz1rp1;
	Thu, 20 May 2021 09:33:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621517627;
	bh=6HA/oPM4sj7auEt3v5V/7ftYtvrBBTgVjwzBwLB8lEM=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=VmZ8rQWRV6QEmTiz2jYAaFYg3ZzqB5sdzyMbZ5BmabLGQcuDr9eQ71FBPjEtckrsf
	 IbFLOAueiHfN8mpA0MBTBLL13t5Wv6WkLok5Lh6+Onyajapd54NQ1XaYmkcTJ+fXTG
	 ackoLeMAMOP8feqC+esJTTjys8NBLYm0QCwpwwzmJoR2xRGZ9BizV1eQPsR9x06fhD
	 CTdCffuGkuqNzJ7aXwt4+qglKUVGsztSzrSBd6I/sQdJpUBFSSr0cifuwmPURcU2tK
	 xUIm4LsAD+psa+YgG7lx5B2VZ7ij5J1TbN14XvfmzkfM0evJutgV48IYYYe/ClU5t/
	 zM72SdPTEgdiA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fm9gF1T2Bz1rg5
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 09:33:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id F26B63356FF
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 09:33:38 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 9m0OXXIYWTnU; Thu, 20 May 2021 09:33:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A23E53356FD;
 Thu, 20 May 2021 09:33:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A23E53356FD
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Hm8T3VtJRI9n; Thu, 20 May 2021 09:33:38 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 979DB335931;
 Thu, 20 May 2021 09:33:38 -0400 (EDT)
Date: Thu, 20 May 2021 09:33:38 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1632491203.52217.1621517618464.JavaMail.zimbra@efficios.com>
In-Reply-To: <CADYdroMkj-tsaBBFqnDsRk2cX5DNxO-yYzLpARJzkNx6CRc5jg@mail.gmail.com>
References: <20210519165648.792939-1-nolange79@gmail.com>
 <1498635684.51674.1621450841774.JavaMail.zimbra@efficios.com>
 <CADYdroMkj-tsaBBFqnDsRk2cX5DNxO-yYzLpARJzkNx6CRc5jg@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4007)
Thread-Topic: Avoid using the heap for small strings with tracef/tracelog
Thread-Index: jLbz6ebOlgxv73ukM73VeNuFx/fdAQ==
Subject: Re: [lttng-dev] [PATCH] Avoid using the heap for small strings with
 tracef/tracelog
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

----- On May 20, 2021, at 8:20 AM, Norbert Lange nolange79@gmail.com wrote:

> This patch was intended for 2.12, no src/common/tracer.h there.

You should post feature patches against the master branch. Or if you just
want to send a RFC, and you work on an older branch, please state that the
patch is RFC and which branch the patch is against, but that work won't
be merged unless it's rebased against master.

> Also this patch is brocken, as a va_list cant be iterated twice.

Right. But you could easily do:

va_start() [ first use ] va_end()
then
va_start() [ second use ] va_end(), right ?

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
