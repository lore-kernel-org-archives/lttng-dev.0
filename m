Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFAAC83F37
	for <lttng-dev@archiver.kernel.org>; Thu, 31 Aug 2023 20:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1693513687;
	bh=ycj0BRV13b/61iu1uMckA1O2dGFbEf0rizz51cEjH5c=;
	h=To:In-Reply-To:References:Date:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Z7f3a+fG0VhhnIa14sBBfiYY+MmviucUPmt7zaCXx6cWlZ+qab54JsyI22hxrMMee
	 dNec0eVFWbZ//dHst+FUWoMOJ1yrcx9Y6E1W5BbTqhP+zTRQGT3C530R6iBB+1UiX3
	 sqeK2VaBVz9RUVUs97PnFYhcVy5jt6OGB+OraiNmmEyGbpLxxDMWd8JBuLXltOJ0IQ
	 1DoDFFAzO675yap3twd+DZ9gA8H6BWMowlwjyOsdOi3yFvnfwjrF6Xg5gRYrz6pOjx
	 cFlIkHQdMUrnbEpSsL21oJTLNX6DrJxnaslyf+81e3hmlHyEZm61fY7goqslm2RK2d
	 D4lysnygLytag==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RcCQt22NGz2TQv;
	Thu, 31 Aug 2023 16:28:06 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4RcCQr32Vbz2TSp
 for <lttng-dev@lists.lttng.org>; Thu, 31 Aug 2023 16:28:04 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4RcCQq4jPSz1MnV;
 Thu, 31 Aug 2023 16:28:03 -0400 (EDT)
To: Alexei Sholomitskiy <asholomitskiy84@gmail.com>, lttng-dev@lists.lttng.org
In-Reply-To: <43c25c75-3e34-9e24-e466-f6bd1d7a1c4e@gmail.com>
Organization: EfficiOS
References: <43c25c75-3e34-9e24-e466-f6bd1d7a1c4e@gmail.com>
Date: Thu, 31 Aug 2023 16:28:03 -0400
Message-ID: <87bkenare4.fsf@laura>
MIME-Version: 1.0
Subject: Re: [lttng-dev] userspace-rcu-0.14.0 - make check bug
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
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Alexei,

On Wed, 30 Aug 2023, Alexei Sholomitskiy via lttng-dev <lttng-dev@lists.lttng.org> wrote:

[...]

> ./configure --prefix=/libs/librcu-0.14.0 --enable-rcu-debug 
> --enable-cds-lfht-iter-debug --disable-static
>
> make

Can you provide the log for the configure and make commands?

> alexei@Aspire:~/build/liburcu-0.14.0$ make check

[...]

> ERROR: test_urcu_multiflavor - too few tests run (expected 5, got 0)
> ERROR: test_urcu_multiflavor - exited with status 134 (terminated by 
> signal 6?)

The multiflavor tests seem to be running since we can see the expected
count.  However, ERROR probably means that the test crashes.  Since the
`got count' is zero, I think it might have crashed in test_mf_memb().

[...]

> PASS: test_urcu_multiflavor_single_unit 1 - !test_mf_mb()
> PASS: test_urcu_multiflavor_single_unit 2 - !test_mf_bp()
> ERROR: test_urcu_multiflavor_single_unit - too few tests run (expected 
> 5, got 2)
> ERROR: test_urcu_multiflavor_single_unit - exited with status 134

Here this time, we got two PASSes then an ERROR on the third test, which
is again on test_mf_memb().  So everything is pointing toward
test_mf_memb().  If this is the case, I suspect that if you run the
regression tests with `make regtest' you will have PASS on everything
except test_*_membarrier_* which will have ERROR.

[...]

Thanks,

Olivier
-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
