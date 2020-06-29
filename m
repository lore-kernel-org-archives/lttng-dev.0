Return-Path: <SRS0=jUQg=AK=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABB3C433E0
	for <lttng-dev@archiver.kernel.org>; Mon, 29 Jun 2020 16:37:07 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6973325596
	for <lttng-dev@archiver.kernel.org>; Mon, 29 Jun 2020 16:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="Dbma19OK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6973325596
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49wY6n6kkJz16xK;
	Mon, 29 Jun 2020 12:37:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1593448626;
	bh=cYe1EBoHSRyXX9/eh70NSF1cB0IvMVTQWSJOQdjwNgM=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Dbma19OK4NQIo8Pma24s27Izg3/ACUCdWQ/5TveeGZjhyTBk+BxCr0JUc7MaYB0aq
	 v6i+lWDZwqLQwdGY9cYXmbzl3idZjvGQ2qcDly/WDdACBMgpxh3N90laWA5OAGRuV1
	 txTbz+lbdIYCQYSYQ0LuhZzRYoVGrbEqfIvURj0ENqf+o2UDJ0ZVRTAEBLKqFq9EC0
	 k/40MKJ5QEU4RwPiXfJP32KZpB2H4GVzDBR9BQCKG1UDt3p3p8bxFfzvDhLP1QfULo
	 Gh8Yo9vwhK0QzpFpwWgUQAluyqn17p5HDjMIJFdDN6xiMkEwqRbchZQ8ndiUEJMAEv
	 hgIloXK9yeOdQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49wY6m1LQMz17Fv
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jun 2020 12:37:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A774C26A583
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jun 2020 12:36:57 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id iHpiSjvwPH4p; Mon, 29 Jun 2020 12:36:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4A0F726A07D;
 Mon, 29 Jun 2020 12:36:57 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4A0F726A07D
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id WhK8uVy2hzyp; Mon, 29 Jun 2020 12:36:57 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 3CC4226A07C;
 Mon, 29 Jun 2020 12:36:57 -0400 (EDT)
Date: Mon, 29 Jun 2020 12:36:57 -0400 (EDT)
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1076462414.15458.1593448617213.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200629162600.GA54368@stefanha-x1.localdomain>
References: <20200624160934.205881-1-stefanha@redhat.com>
 <1673641132.14590.1593205320791.JavaMail.zimbra@efficios.com>
 <20200629162600.GA54368@stefanha-x1.localdomain>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - GC81 (Linux)/8.8.15_GA_3928)
Thread-Topic: tracepoint.h: define SDT_USE_VARIADIC in pkg-config CFLAGS
Thread-Index: SdqbhySbXOcRm0FZeWq9xAEdaEqEsg==
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
Message-ID: <20200629163657.quyta8bpIBoTlkFpJlbLCetHN2ysbq6zbrsXOrT00Po@z>

----- On 29 Jun, 2020, at 12:26, Stefan Hajnoczi stefanha@redhat.com wrote:

> On Fri, Jun 26, 2020 at 05:02:00PM -0400, Michael Jeanson wrote:
>> I proposed a patch here[1] that addresses this problem in a generic way by
>> duplicating the macro and namespacing it under LTTNG_. Honestly this is more
>> of an sdt bug, the STAP_PROBEV should be in it's own include guard outside
>> of _SYS_SDT_H or in it's own header file but we have to work with what's there.
>> 
>> Can you have a look at the patch and confirm that it fixes your problem?
> 
> Great, glad there is already a fix under review.
> 
> When I try out the patch the application does not compile. The error
> messages are the same as without the patch because _LTTNG_SDT_PROBE() is
> not defined. Was that supposed to be _SDT_PROBE() instead?
> 
> The application compiles successfully after replacing _LTTNG_SDT_PROBE()
> with _SDT_PROBE().
> 
> Stefan

Yes indeed, I reworked the patch after testing it and didn't catch this, I've
just pushed an updated patch. Thanks for testing it and catching this.

Cheers,

Michael
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
