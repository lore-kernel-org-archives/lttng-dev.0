Return-Path: <SRS0=8fC+=KJ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF5DC433ED
	for <lttng-dev@archiver.kernel.org>; Fri, 14 May 2021 20:16:55 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E049611CC
	for <lttng-dev@archiver.kernel.org>; Fri, 14 May 2021 20:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E049611CC
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fhfv90YrNz1nxC;
	Fri, 14 May 2021 16:16:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621023413;
	bh=Qgo9/isosyQkx0DEdSMSYB27iEdLDYkwh8axrD9Q69c=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qh24GipamcplnrwHD6aEA2qc1h/ianOCAzWusLXmoQ3IFiwDEcZ5P/o/+qxhnQ8Ys
	 tduT2cpG2hB377MHf26eXSePsA1TV4tDuyTi6jCC0zancQZgj9zUQBnsWIa+43Z0NU
	 UJ/bhW9ccIRYocE/NodqD0klaIT3Y+AAoRTNAI1gROn4b8XFNfhyVDCalcENaxmQ5o
	 OqQ/HLknLporVteGY/7wJFqySBimF+OnX/GhuadlltLRkck4yl5I2H7aV6AVwoOEzr
	 6nGQyScMp2Z4+rDCVP4UZHbYNIOSe7hlR7I6kzIOCBUzaq1Mvna1X6twbnnT5xwuvy
	 mt/Zfilbmt+Cg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fhfv65DSvz1p3B
 for <lttng-dev@lists.lttng.org>; Fri, 14 May 2021 16:16:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 264CD2B8754
 for <lttng-dev@lists.lttng.org>; Fri, 14 May 2021 16:16:44 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id EH_EZa7z_b1E; Fri, 14 May 2021 16:16:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2A0EF2B86DC;
 Fri, 14 May 2021 16:16:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2A0EF2B86DC
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id fz-5Jf-HqOng; Fri, 14 May 2021 16:16:43 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 1CDE52B8835;
 Fri, 14 May 2021 16:16:43 -0400 (EDT)
Date: Fri, 14 May 2021 16:16:43 -0400 (EDT)
To: lttng-dev <lttng-dev@lists.lttng.org>, 
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>, 
 linux-trace-users <linux-trace-users@vger.kernel.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>
Cc: Genevieve Bastien <gbastien+lttng@versatic.net>
Message-ID: <1811223777.46126.1621023403092.JavaMail.zimbra@efficios.com>
In-Reply-To: <1336422991.46023.1621021967687.JavaMail.zimbra@efficios.com>
References: <1336422991.46023.1621021967687.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4007)
Thread-Topic: LTTng-modules 2.11.9 and 2.12.6 (Linux kernel tracer)
Thread-Index: 7GWFwXFXkLY7KtGgWu1JPUyXPl1BvkX71erz
Subject: Re: [lttng-dev] [RELEASE] LTTng-modules 2.11.9 and 2.12.6 (Linux
 kernel tracer)
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

----- On May 14, 2021, at 3:52 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Hi,
> 
> The 2.11.9 and 2.12.6 releases of the LTTng kernel tracer are the latest bug fix
> releases
> of the 2.11 and 2.12 stable branches of the LTTng modules project.
> 
> There are a few minor bug fixes, but those are the noteworthy changes:
> 
> - Support for 5.12 Linux kernels,
> - Support recent stable kernel branches 4.14, 4.19, 5.4,
> - Support for newer Ubuntu 4.15, 5.4 and RHEL 8.2/8.3 kernels,
> - Fix: increment buffer offset when failing to copy from user-space:
> 
>    Upon failure to copy from user-space due to failing access ok check, the
>    ring buffer offset is not incremented, which could generate unreadable
>    traces because we don't account for the padding we write into the ring
>    buffer.
>    
>    Note that this typically won't affect a common use-case of copying
>    strings from user-space, because unless mprotect is invoked within a
>    narrow race window (between user strlen and user strcpy), the strlen
>    will fail on access ok when calculating the space to reserve, which will
>    match what happens on strcpy.

There is one additional noteworthy set of changes in lttng-modules 2.12.6:

        * Disable block rwbs bitwise enum in default build
        * Disable sched_switch bitwise enum in default build
        * Add experimental bitwise enum config option

The block rwbs bitwise enum and sched switch bitwise enum were introduced late
in the 2.12 rc cycle, and ended up producing traces which were not strictly
conformant with the CTF 1.8 specifications: they were producing enumerations
with values associated with no known labels.

This causes Babeltrace 1 and 2, with default options, to generate warnings when
viewing kernel traces.

So those commits introduce a new build-time option which can optionally enable
those bitwise enumerations, e.g.:

 make CONFIG_LTTNG_EXPERIMENTAL_BITWISE_ENUM=y

So until we finalize the CTF2 specification and its implementation in the tracers
and trace viewers, this provides a way for experimental users of LTTng-modules to
keep generating those bitwise enumerations without producing warnings in the
default use-case.

Without this option, a simple integer field is emitted in the trace rather than a
bitwise enumeration.

Thanks,

Mathieu


> 
> Thanks,
> 
> Mathieu
> 
> Project website: https://lttng.org
> Documentation: https://lttng.org/docs
> Download link: https://lttng.org/download
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
