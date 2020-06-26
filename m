Return-Path: <SRS0=HL3W=AH=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177B8C433E0
	for <lttng-dev@archiver.kernel.org>; Fri, 26 Jun 2020 21:02:06 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E6852070A
	for <lttng-dev@archiver.kernel.org>; Fri, 26 Jun 2020 21:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="By65o4ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6852070A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49tq7v6P7mz15Hp;
	Fri, 26 Jun 2020 17:02:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1593205324;
	bh=b7wHSEhHp5TsqM9sdCde/DZf2+Gv+bQ7276TD2itw74=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=By65o4yem1w9ZRlzhshaPAUl3d8mYH1/n2SH4Zf854CnVa4s3GTmNq+SQ785fJwFT
	 VozNJAQzHY4DpN2xF/fwdjVXlZ7H7K+tZkd3Ik6mnync9NT/LHtbN3iFvprMNYwPTc
	 aCe6aQwiatd9OUl1F5UGSI8QDIlOEW4TwI2N0t/123URmc0OH0ybvvfDDcQy3+WaYH
	 VH6Ls0v5d0BkdZkRCUzIO7Z7eK7FXmz4HcDV1O8p0Hj922AL8WefiO4Wuzd7TFN/d3
	 5zH7l+0/W/sjW+Y4EGLgVTbO/EJAJpNdl0BQsAWdXfNP8tJWKQm+Q5g8xuBrNA57WZ
	 6WIxW3NPPvAuQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49tq7t2PxTz15Hm
 for <lttng-dev@lists.lttng.org>; Fri, 26 Jun 2020 17:02:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5545A2D637D
 for <lttng-dev@lists.lttng.org>; Fri, 26 Jun 2020 17:02:01 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id IoYNn3M-Ln86; Fri, 26 Jun 2020 17:02:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D72402D637C;
 Fri, 26 Jun 2020 17:02:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D72402D637C
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id sTPuGKuwRDQP; Fri, 26 Jun 2020 17:02:00 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id CC9042D637A;
 Fri, 26 Jun 2020 17:02:00 -0400 (EDT)
Date: Fri, 26 Jun 2020 17:02:00 -0400 (EDT)
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1673641132.14590.1593205320791.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200624160934.205881-1-stefanha@redhat.com>
References: <20200624160934.205881-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - GC81 (Linux)/8.8.15_GA_3928)
Thread-Topic: tracepoint.h: define SDT_USE_VARIADIC in pkg-config CFLAGS
Thread-Index: sUPIskpo+8XACXFyooZfZkrNAVNr3Q==
Subject: Re: [lttng-dev] [PATCH] Fix: tracepoint.h: define SDT_USE_VARIADIC
 in pkg-config CFLAGS
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200626210200.QCwWpEjZaj-e6rfWf66giDo3k7mYuvkVx7do0wxAXlE@z>

Hi Stefan,

I proposed a patch here[1] that addresses this problem in a generic way by
duplicating the macro and namespacing it under LTTNG_. Honestly this is more
of an sdt bug, the STAP_PROBEV should be in it's own include guard outside
of _SYS_SDT_H or in it's own header file but we have to work with what's there.

Can you have a look at the patch and confirm that it fixes your problem?

Cheers,

Michael

[1] https://review.lttng.org/c/lttng-ust/+/3685 


----- On 24 Jun, 2020, at 12:09, lttng-dev lttng-dev@lists.lttng.org wrote:

> LTTng Userspace Tracer 2.11 with sdt enabled can break builds of
> applications that include <sys/sdt.h> themselves. QEMU
> (https://qemu.org/) is one example.
> 
> When applications include <sys/sdt.h> themselves before LTTng Userspace
> Tracer header files and the SDT_USE_VARIADIC macro is not defined,
> compilation fails due to the absense of STAP_PROBEV() macro that LTTng
> Userspace Tracer requires.
> 
> Define SDT_USE_VARIADIC in the pkg-config file so that all compilation
> units that use LTTng Userspace Tracer are guaranteed to have the macro
> defined even if <sys/sdt.h> is included elsewhere before LTTng Userspace
> Tracer header files.
> 
> In other words, define SDT_USE_VARIADIC on the compiler command-line
> instead of in <lttng/tracepoint.h>. This way it will always been defined
> when <sys/sdt.h> is included.
> 
> Make sure to define SDT_USE_VARIADIC when <lttng/tracepoint.h> is
> included without it. This happens when applications do not use
> pkg-config.
> 
> Fixes: b2f60c7986bb69f81b79b68f1bfe83aafa3278a7 ("Add sdt.h integration")
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Warning: this patch doesn't work yet. SDT_CFLAGS also needs to be passed
> into LTTng Userspace Tracer's own CFLAGS so that compilation can
> succeed. I don't know the autoconf/automake syntax to do this and wanted
> to see what you think of this solution before investing more time.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
