Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240FAC433FE
	for <lttng-dev@archiver.kernel.org>; Fri, 25 Mar 2022 18:37:43 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KQ9nL2LPPzJwf;
	Fri, 25 Mar 2022 14:37:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1648233463;
	bh=I3eROd9gyA6EL5w9/cffKLh3szrR9Zm8+rzQS9wLuhs=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=LxLPoL+QfPrKsaoWhL+pU+Fvjq1vSCux6ib/brJPt2+peBrL+1tVt7hqndk804q8j
	 KxVz6OBj+jNjc5eHQIPdEfeO9N0MYaxkov7Ck1rtLcYNM8jlwRJk9jMsAAEZ77S3wh
	 LLJ8K9dPpf3Pvksrt/lmAMkjnc4CwzxvjeGFNQE+9VoY/yTF9kIf54ELs63vPOHkPU
	 ypEhkXAd8xQniGZAmuBtzJGViKfa/cTqx2lEqOfqAu+RxY7h2biWvV213We91cdDSq
	 gepVWQKQz+aEkIBNAI8jxZq3J+l/RY1NX46maAT4QZRBjQfKZfBk13FnpT+fONuZQv
	 YvF38mSz905xg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KQ9nJ0fv6zJhk
 for <lttng-dev@lists.lttng.org>; Fri, 25 Mar 2022 14:37:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A1F8C3F8FCF
 for <lttng-dev@lists.lttng.org>; Fri, 25 Mar 2022 14:37:33 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id o23C3DmGDikb; Fri, 25 Mar 2022 14:37:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1AAED3F928C;
 Fri, 25 Mar 2022 14:37:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1AAED3F928C
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Rmp3GDtL7f2D; Fri, 25 Mar 2022 14:37:33 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 0CDB93F8FCC;
 Fri, 25 Mar 2022 14:37:33 -0400 (EDT)
Date: Fri, 25 Mar 2022 14:37:32 -0400 (EDT)
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org, 
 linux-trace-users@vger.kernel.org, 
 linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1722467374.194740.1648233452935.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF98 (Linux)/8.8.15_GA_4232)
Thread-Index: FdzCaxNCbhjFfBx2k4zpzfddPUUTBg==
Thread-Topic: LTTng-modules 2.13.3 and 2.12.8 (Linux kernel tracer)
Subject: [lttng-dev] [RELEASE] LTTng-modules 2.13.3 and 2.12.8 (Linux kernel
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

This is a stable release announcement for the LTTng kernel tracer for the
stable 2.12 and 2.13 branches. The releases are respectively 2.12.8 and 2.13.3.

In the 2.13.3 release, two fixes are worth mentioning:

* Fix: lttng ABI: lttng_counter_ioctl() tainted scalar

    The counter aggregate, clear and read functions (used for error reporting of
    the event notification feature) use a userspace-controlled "number_dimensions"
    argument as loop boundary.

    This ABI is only accessible from the root user, which limits the practical impact
    of this bug.

* Fix: sample discarded events count before reserve

    Sampling the discarded events count in the buffer_end callback is done
    out of order, and may therefore include increments performed by following
    events (in following packets) if the thread doing the end-of-packet
    event write is interrupted for a long time.
    
    Sampling the event discarded counts before reserving space for the last
    event in a packet, and keeping this as part of the private ring buffer
    context, should fix this race.
    
    In lttng-modules, this scenario would only happen if an interrupt
    handler produces many events, when nested over an event between its
    reserve and commit. Note that if lttng-modules supports faultable
    tracepoints in the future, this may become more easy to trigger due to
    preemption.

    This fix is only part of the 2.13 stable branch and not backported to
    2.12 because the lib ring buffer code used to implement this fix did not
    exist in 2.12. Given that the impact of this bug is only imprecision of
    discarded event reporting in corner-case scenarios (small impact, rare
    occurrence), the complexity of implementing this fix in 2.12 is not justified.
    The effect of this issue is that the lttng-tools
    tests/regression/tools/streaming/test_high_throughput_limits test is flaky.

In the 2.12.8 release, a series of commits introduce support for the 5.17 Linux kernel.
The 2.13 stable branch already supported that kernel in the prior releases.

Feedback is welcome!

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
