Return-Path: <SRS0=ImaU=FB=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8EEC5519F
	for <lttng-dev@archiver.kernel.org>; Fri, 27 Nov 2020 17:11:54 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8509B21D46
	for <lttng-dev@archiver.kernel.org>; Fri, 27 Nov 2020 17:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="i8TAYdIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8509B21D46
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CjLl25sB5z1PlK;
	Fri, 27 Nov 2020 12:11:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1606497103;
	bh=9n4wlY3qjxmaNDzAlAcaQjPmtuGOghQa2VtMfRp6vcI=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=i8TAYdICaU5keQyA0wYTCIIrzyQrzZJeW8QnPzmGMxS8MF1onlnhEMbvq2aCI9h8j
	 G+5UsMUyZlKlgteNgS5TL513ilbnBowxtRbvJT6EMBYQeocrGMO2j1FmFrb/qIejT3
	 p0Fj7kRdaWvcsbINmzgYWLkjXQzl4FMJH0rFF05HmaPC0KqFbRC2DLSa9DPEzytaYj
	 Pyz6tUz1A+ZsGdEtxNt2qTTJ/WoZEerhGpYct2ragnya1nM3k4Y264FqbYWpunMY9R
	 4zjgWecMf/Yy7DB8Hphe1y+8RC4e/y/wyoHur+vvI9Wqu+vBabE91nC1hYkhFACZPt
	 IQkumhSEfF03Q==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CjLl12ZcSz1PlH
 for <lttng-dev@lists.lttng.org>; Fri, 27 Nov 2020 12:11:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 117F127CC7A;
 Fri, 27 Nov 2020 12:11:35 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id x9JyqKDhH6VJ; Fri, 27 Nov 2020 12:11:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C5A3A27CA7D;
 Fri, 27 Nov 2020 12:11:34 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C5A3A27CA7D
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id I763VJz7A2YX; Fri, 27 Nov 2020 12:11:34 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id BBDF427CA7B;
 Fri, 27 Nov 2020 12:11:34 -0500 (EST)
Date: Fri, 27 Nov 2020 12:11:34 -0500 (EST)
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: =?utf-8?B?54aK5q+T5Y2O?= <xiongyuhua@zju.edu.cn>, 
 lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <556721467.65922.1606497094670.JavaMail.zimbra@efficios.com>
In-Reply-To: <828264314.65604.1606493063962.JavaMail.zimbra@efficios.com>
References: <40a80cf.2b99.176086d97b1.Coremail.xiongyuhua@zju.edu.cn>
 <20201127140548.GB3947@joraj-alpa>
 <25e54ac4.4261.1760a553e88.Coremail.xiongyuhua@zju.edu.cn>
 <828264314.65604.1606493063962.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3975 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3975)
Thread-Topic: Some confusion about cpu usage of the lttng-consumerd process
Thread-Index: yp5QYAUpKnzdSMpykx0c2/cDegrSAvEkMCgI
Subject: Re: [lttng-dev] Some confusion about cpu usage of the
 lttng-consumerd process
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

----- On Nov 27, 2020, at 11:04 AM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Well we also want to know why! You will understand that albeit we develop lttng
> we do not always have a quick and easy answer to all problems. Performance
> related problem are always tricky.
> And we also have to keep in mind that we do not necessarily optimize for low-cpu
> usage on the lttng-consumerd side.

That being said, we did optimize for low-cpu usage of lttng-consumerd for use-cases
streaming to disk or to the network. However, the "live" mode was originally created
for use-cases where only a few events per second would be emitted, and no such
requirements were placed on performance. We can see today that its use has grown
much beyond the few events per seconds, but then in those use-cases the live mode
may not be the appropriate tool for the job then. We have introduced the "session
rotation" feature as a more efficient alternative to the live mode.

> We have to take a look at what "work" scale with the number of CPU on the
> lttng-consumerd side. One such thing is the live timer which is fired on an
> interval (default is 1s (1000000us)).

> You could test this hypothesis by streaming the trace instead of using the live
> feature.

> lttng create --set-url ....

Yes, I agree with Jonathan's recommendation: you should compare this cpu usage with
that of the streaming mode of lttng by *not* using the "--live" option when creating
the trace session. It will at least help identify whether consumerd also exhibits this
cpu usage increase with number of cores in streaming mode, or if it is an expected
additional overhead of periodically flushing more cpu buffers (because there are more
cores) caused by the live timer.

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
