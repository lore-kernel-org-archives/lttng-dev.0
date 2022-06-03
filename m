Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BFAC43334
	for <lttng-dev@archiver.kernel.org>; Fri,  3 Jun 2022 20:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1654286953;
	bh=ixQ0BxaYqD4Q9XKDTFYj/2xPrVdrzUTDEF+kiILDkJc=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=leNa+wpNVNlNn75ac167N28NzCYonPdqVF1z1P9TjUl4SH9kTLxoCWKw2C55xLB22
	 wMIucJI9y8vNWkiu8R3Vm1/E6RXlTjmVhhSMBoWInjpoh078FAZeB3FLwDW1cmp6xT
	 9UV/ZYutUOFwO3AYKrxAQa7/6X97rdb8GjUiqHAJ6sSqkMrmqnurpF8btJramAzJb6
	 fPu1Nx8MxEuIkOhBZNSzAgjXSmDSUdYxHSDvdQDEyUbaxKskwbMnMagnLvO/LUyf+B
	 5h84N3yfwXrkFeQscIuAHknwJ4O1mCPu1+pf2SIP+k5BITNoX9NBMHKf5eg3ccQo3g
	 v2m+3TjdAlTRw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LFDVc143gz53b;
	Fri,  3 Jun 2022 16:09:12 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LFDVZ6nprz4SD
 for <lttng-dev@lists.lttng.org>; Fri,  3 Jun 2022 16:09:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 651AB3FDD4E
 for <lttng-dev@lists.lttng.org>; Fri,  3 Jun 2022 16:09:10 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id IXGYnuZSSVoF; Fri,  3 Jun 2022 16:09:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 29FD23FDD4C;
 Fri,  3 Jun 2022 16:09:09 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 29FD23FDD4C
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id ONeGqzd6vEo1; Fri,  3 Jun 2022 16:09:09 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 1CE6C3FDD4B;
 Fri,  3 Jun 2022 16:09:09 -0400 (EDT)
Date: Fri, 3 Jun 2022 16:09:08 -0400 (EDT)
To: Diamon discuss <diamon-discuss@lists.linuxfoundation.org>, 
 lttng-dev <lttng-dev@lists.lttng.org>, 
 linux-trace-users <linux-trace-users@vger.kernel.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2013849140.21031.1654286948952.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4272 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4257)
Thread-Index: GvhBkQpsvyTv3F9IyFg96OTAu3APcA==
Thread-Topic: LTTng-UST 2.13.3 and 2.12.5 (Linux user-space tracer)
Subject: [lttng-dev] [RELEASE] LTTng-UST 2.13.3 and 2.12.5 (Linux user-space
 tracer)
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

This is a stable release announcement for the LTTng-UST project. LTTng-UST
is a tracer for Linux user-space applications. The respective versions are
2.13.3 and 2.12.5.

Those are bug fix releases correcting a few issues in both stable branches,
namely by removing use of non-async-signal-safe functions in the ERR()
error-printing macros, and fixing a use-after-free memory read in a list
traversal within the statedump code.

Specifically in 2.13.3, the bytecode interpreter in LTTng-UST left the
context fields byte order uninitialized, thus leading to bogus context field
values in the event notification capture feature. Fix this by initializing
the byte order.

Also specifically in 2.13.3, a too-strict validation of array/sequence field
types is relaxed to allow pointer types to be used as integer values. This
was allowed prior to 2.13, and this too-strict validation was therefore an
instrumentation API regression.

Detailed Changelog:

2022-06-03 (National Repeat Day) (National Repeat Day) lttng-ust 2.13.3
        * Document ust lock async-signal-safety
        * Fix: don't use strerror() from ust lock nocheck
        * Fix: remove non-async-signal-safe fflush from ERR()
        * Fix: Pointers are rejected by integer element compile time assertion for array and sequence
        * Fix: statedump: invalid read during iter_end
        * Fix: bytecode interpreter context_get_index() leaves byte order uninitialized

2022-06-03 (National Repeat Day) (National Repeat Day) lttng-ust 2.12.5
        * Document ust lock async-signal-safety
        * Fix: don't use strerror() from ust lock nocheck
        * Fix: remove non-async-signal-safe fflush from ERR()
        * Fix: statedump: invalid read during iter_end
        * Fix: bytecode interpreter context_get_index() leaves byte order uninitialized

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
