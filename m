Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC925C43334
	for <lttng-dev@archiver.kernel.org>; Mon, 13 Jun 2022 15:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1655133715;
	bh=KmSyjJBaQPp4M0sM/5CPVwuhNwWis8B8UjTfKta/Pzk=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=cn1K6U7OJX7Heublgb24AYKOA3wh80cEHoLPnmJLLEFs+B7Os5SQUykZcSLAA5S61
	 vBM4tBHwuixklvVkrbzmUP5/h/TuvoR0kA0EjdlE7jDG2JkzvO7zuexfyEP5qf4lZ9
	 URdNVG+ImcXCqRUpoCtGaT9AGu9ypYxqYVw06fpdUyVmcXhAhQEZNttuPwIFTR+cZ+
	 Xu4sT6wEr4y2oN1mO5B+5DaDxvTLo/iwSQr4RTwvOdewe6zh7tb43mG/uu4dFVPQzj
	 PeG2FUrAPwrK/hDlrPX35shsGVvH3SnXwpIjUB0iMIH0dbLjDbwNrOylGNGqULASW4
	 YtebRE6Rlh9CA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LMFfW0qJjz84f;
	Mon, 13 Jun 2022 11:21:55 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LMFfT5DbGz7bw
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jun 2022 11:21:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 223B93B278D
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jun 2022 11:21:52 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id QRMB1HwNVokm; Mon, 13 Jun 2022 11:21:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 85ACA3B278C;
 Mon, 13 Jun 2022 11:21:49 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 85ACA3B278C
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id TJy_eCly8pN2; Mon, 13 Jun 2022 11:21:49 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 79D533B24EF;
 Mon, 13 Jun 2022 11:21:49 -0400 (EDT)
Date: Mon, 13 Jun 2022 11:21:49 -0400 (EDT)
To: Marcel Hamer <marcel.hamer@windriver.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <2029776906.56294.1655133709430.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220613114939.GA276938@windriver.com>
References: <20220613114939.GA276938@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4272 (ZimbraWebClient - GC99 (Linux)/8.8.15_GA_4257)
Thread-Topic: Removal of root_regression tests
Thread-Index: 20AV+xCjVePaAkINJaE1BFRIFtEzHg==
Subject: Re: [lttng-dev] [lttng-tools] Removal of root_regression tests
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
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Marcel,

----- Original Message -----
> From: "Marcel Hamer via lttng-dev" <lttng-dev@lists.lttng.org>
> To: "lttng-dev" <lttng-dev@lists.lttng.org>
> Sent: Monday, 13 June, 2022 07:49:39
> Subject: [lttng-dev] [lttng-tools] Removal of root_regression tests

> Hello,
> 
> Since version v2.12.9 of lttng-tools the root_regression file has been emptied
> to make the tests part of the 'make check' sequence instead.
> 
> We were always actively using that test file as part of our regression testing.
> In our case we are working in a cross-compilation environment, where the run.sh
> script was used on target for testing and as such not at compile time. It is not
> easy to run a make check sequence on a target.

I would suggest that you take a look at how OpenEmbedded does it with ptest AFAIK it match your requirements:

https://github.com/openembedded/openembedded-core/blob/c7e2901eacf3dcbd0c5bb91d2cc1d467b4a9aaf7/meta/recipes-kernel/lttng/lttng-tools_2.13.7.bb#L75

> 
> It is now also a bit unclear which tests actually require root access and which
> tests do not. I understood this was the reason the file was called
> 'root_regression'?

Yes when the tests suites primarily used `prove` via run.sh.

We have been slowly moving away from it for a good time and now mostly use the Automake test harness as much as possible.

The worse that will happen if you run a test that required root as a non-root user is that `skip` tap output will be emitted.

> 
> Some questions that get raised because of this:
> 
> - Is there now an alternative way to run regressions on target in case of a
>  cross-compilation environment?

AFAIU, this is out of scope of the lttng project. Still, I would recommend that you see how yocto/oe do it with ptest.

> - Would there be a possibility to fill the 'root_regression' file again and
>  possibly revert this change?

Feel free to do it out-of-tree. I doubt that we are the only project that WindRiver handles that uses
the automake test harness and that do not provide a easy way to run on-target for cross-compilation testing.

A quick grep with "isroot" should get you 95% there.

> - How are tests now identified that require root access?

All tests that require root access test for it at runtime

Something along:

regression/tools/streaming/test_high_throughput_limits:

 if [ "$(id -u)" == "0" ]; then
 	isroot=1
 else
	 isroot=0
 fi

 skip $isroot "Root access is needed to set bandwidth limits. Skipping all tests." $NUM_TESTS ||
 {
 ...
    Tests are done here.
 }

Cheers
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
