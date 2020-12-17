Return-Path: <SRS0=Ppkc=FV=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FF3C4361B
	for <lttng-dev@archiver.kernel.org>; Thu, 17 Dec 2020 13:30:08 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8303622E02
	for <lttng-dev@archiver.kernel.org>; Thu, 17 Dec 2020 13:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8303622E02
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CxXt62qRbzFV9;
	Thu, 17 Dec 2020 08:30:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1608211806;
	bh=Qe+SNGG3BKSdB+/u/b4NNTO0a2tX3EKNAVBrPTThqcY=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0wFL9sOmaCBKZYxigo+GTw8wwI6Vg92lTtiRnGqv3BxDfzuzWIqANs318ouPXTCMU
	 lh4FjX0enSDk0v9Xugz7F9/waT+MD1nWxsb9r6Cv05NL4niMbhED1mmm8bsD1JI9Mz
	 e2q6KsmrdWQERPvGFhoCWZ4slnrscfp/JvQJ9XC8YprRsMuSNGAWd110cLATNpFm9c
	 yjWfVyKOPF6j7C+hiR/QWXlw5Qpozjb0stzfUy+jir4gjpSf0V/O59vj+AkRsmQMW6
	 de/R1gJ1rQGl3ak/jrG1AkXQjnu2qGz1j29+4rntU9DmRYIirsVr3lCoLXGlcapjPo
	 r4K1ij2cyeqBA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CxXt514WzzFdM
 for <lttng-dev@lists.lttng.org>; Thu, 17 Dec 2020 08:30:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 234552A2BC7;
 Thu, 17 Dec 2020 08:30:05 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id SQ8juFsaAoWl; Thu, 17 Dec 2020 08:30:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DA5462A2C27;
 Thu, 17 Dec 2020 08:30:04 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DA5462A2C27
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id yfWTK3o926ht; Thu, 17 Dec 2020 08:30:04 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id D213D2A293D;
 Thu, 17 Dec 2020 08:30:04 -0500 (EST)
Date: Thu, 17 Dec 2020 08:30:04 -0500 (EST)
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>
Message-ID: <2027090066.6546.1608211804845.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201215162850.78638-4-mjeanson@efficios.com>
References: <20201215162850.78638-1-mjeanson@efficios.com>
 <20201215162850.78638-4-mjeanson@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3980)
Thread-Topic: Don't force a target and optimization level on ARMv7
Thread-Index: 3avBtvIuwqZHd7YkA3sBzL15vRTMSA==
Subject: Re: [lttng-dev] [PATCH urcu 4/4] Don't force a target and
 optimization level on ARMv7
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Merged in liburcu master, thanks!

Mathieu

----- On Dec 15, 2020, at 11:28 AM, Michael Jeanson mjeanson@efficios.com wrote:

> We shouldn't force a specific target cpu for the compiler on ARMv7 but
> let the system or the user choose it. If some of our code depends on a
> specific target CPU features, it should be compile tested.
> 
> Also remove the default optimisation level of O1, it's potentially a
> workaround to an early armv7 compiler performance problem and anyway
> most builds will have an optimisation level flag set in the CFLAGS which
> will override this one.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Change-Id: I1d1bb5cc0fa0be8f8b1d6a9ad7bf063809be1aef
> ---
> configure.ac | 4 ----
> 1 file changed, 4 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index daa967a..f477425 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -119,10 +119,6 @@ AS_CASE([$host],[*-cygwin*],
> 	[AM_CONDITIONAL(USE_CYGWIN, false)]
> )
> 
> -AS_IF([test "$host_cpu" = "armv7l"],[
> -	AM_CFLAGS="$AM_CFLAGS -mcpu=cortex-a9 -mtune=cortex-a9 -O1"
> -])
> -
> # Search for clock_gettime
> AC_SEARCH_LIBS([clock_gettime], [rt], [
> 	AC_DEFINE([CONFIG_RCU_HAVE_CLOCK_GETTIME], [1])
> --
> 2.29.2

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
