Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48348C433F5
	for <lttng-dev@archiver.kernel.org>; Wed,  5 Jan 2022 21:27:34 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JTjHm5Z9wzB50;
	Wed,  5 Jan 2022 16:27:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1641418053;
	bh=5sZjhc9cyh+OTcIC6w688eTc0Hc4fqN4uFVnJhk3EFE=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=0zQXOpVTLUy/C/bnn+veQmApeN42Fu73TrYtPJAiTM+zfglSTTLM/XhYxtQt20/Wh
	 eXey2RO/HtsKCog3n100jh5qqpI0UI2R80+MyzNVmlLPsJIYWyU0QToz990MTm6VDx
	 xSsenJIBgOZS7JWOCrxAmt0sXxt8sk4diwxOwCDgNG3Jd1f3V114m1NePeo9EhJjMl
	 pxRClfONnUTPD83XnK+9Yj/xik+BqF0rB4Avh6KySza6FapuRiYahwZ8QTYptU4cex
	 u6zVtaBGa6jQyuTj1Lr9uo1H/FTEpJ8AVGQJLQhlm0JEFEYU4cyHx7JGR6xOVcBQWA
	 YG88Na+gLLeew==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JTjHl0ftwzBKR
 for <lttng-dev@lists.lttng.org>; Wed,  5 Jan 2022 16:27:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7F6E33C987B
 for <lttng-dev@lists.lttng.org>; Wed,  5 Jan 2022 16:27:24 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id t0zTNLx1n0NY; Wed,  5 Jan 2022 16:27:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DC4203C9C13;
 Wed,  5 Jan 2022 16:27:23 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DC4203C9C13
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id BXcFK0AJJdKM; Wed,  5 Jan 2022 16:27:23 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id CFBE53C9C12;
 Wed,  5 Jan 2022 16:27:23 -0500 (EST)
Date: Wed, 5 Jan 2022 16:27:23 -0500 (EST)
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org, 
 linux-trace-users@vger.kernel.org
Message-ID: <697935027.5550.1641418043715.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF95 (Linux)/8.8.15_GA_4177)
Thread-Index: m7GiKJygw0akYxq/Mbpwf/qNqXu0iQ==
Thread-Topic: LTTng-UST 2.12.3 and 2.11.5 (Linux user-space tracer)
Subject: [lttng-dev] [RELEASE] LTTng-UST 2.12.3 and 2.11.5 (Linux user-space
 tracer)
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
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

This is a release announcement for the LTTng-UST 2.12.3 and 2.11.5
tracer. Those are bug fix releases.

The 2.11.5 release marks the end of life (EOL) of the stable-2.11 branch.
Users experiencing issues with the 2.11 branch are expected to upgrade to
either 2.12.3 or 2.13.1.

Note that the latest stable branch is 2.13 (its most recent release
is 2.13.1, released on December 10, 2021).

* Notable changes in 2.12.3:

Two notable fixes are "Fix: nestable pthread cancelstate" and
"Fix: abort on decrement_sem_count during concurrent tracing start and teardown",
which fix a rare deadlock scenario at application exit.

Another notable fix is "fix: liblttng-ust-fd async-signal-safe close()", which
ensures that the implementation of the symbol interposition for "close" is
async-signal safe, as it should be.

Please refer to the change logs below for the fixes contained in those
two releases.

Feedback is welcome,

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download


2022-01-05 (National Bird Day) lttng-ust 2.12.3
        * Fix: ust-cancelstate: include string.h for strerror
        * Fix: lttng-ust-fd: remove lttng_ust_common_ctor call
        * Fix: nestable pthread cancelstate
        * Fix: abort on decrement_sem_count during concurrent tracing start and teardown
        * fix: liblttng-ust-fd async-signal-safe close()
        * Set git-review branch to stable-2.12
        * fix: link benchmark with pthread
        * Fix: liblttng-ust-ctl have dependencies on liburcu
        * Fix: add extern "C" to two header files

2022-01-05 (National Bird Day) lttng-ust 2.11.5
        * Set git-review branch to stable-2.11
        * fix: allow building with userspace-rcu 0.13

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
