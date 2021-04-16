Return-Path: <SRS0=Ki2T=JN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C74C433B4
	for <lttng-dev@archiver.kernel.org>; Fri, 16 Apr 2021 14:52:30 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19E361166
	for <lttng-dev@archiver.kernel.org>; Fri, 16 Apr 2021 14:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19E361166
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FMK1k6YtLz1BjR;
	Fri, 16 Apr 2021 10:52:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1618584747;
	bh=BNMrjrldKbGx/KlfR8ygXMSBjXF+nVFnsxj9jn4xbJc=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=OW+h9sSsEqajZToqMFbwAgr7xlIVNQAOaxrcz/EH0V0qMbvpnuoXZ8BxeHKVezFKG
	 JKyJn+Dzn88iEWTSb/Y7z7FzPKSTpH9PoHvqdlTe+VPyCP7n8xJiM5l6yMXzBeH+9E
	 wHaM8Lda5gpALYTbkhQivE3HxO48C/f7I2r6WkFaPp6N1YWkWZ2a/J8LcldVn6HiLG
	 DOQEh/ZdLrGQclOlEpCRkfSwSLZfcCz9YtUGiPoSEx2hGcJ+DgYy/9EwiIG8oF1DMM
	 jmVBwoLKsDXTNTcSKt3kXjfv6XDyIv9Ig3UGnXayyzvCzvs/FuHbNZP84yxHny6o4j
	 MYp/WaPeIfLzw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FMK1j221Sz1Bv1
 for <lttng-dev@lists.lttng.org>; Fri, 16 Apr 2021 10:52:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E30C1337A72
 for <lttng-dev@lists.lttng.org>; Fri, 16 Apr 2021 10:52:17 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id UbIckL3755HT; Fri, 16 Apr 2021 10:52:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D6B0C337D2E;
 Fri, 16 Apr 2021 10:52:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D6B0C337D2E
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id XPTxFdlzpXms; Fri, 16 Apr 2021 10:52:16 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id C6F9B337AF7;
 Fri, 16 Apr 2021 10:52:16 -0400 (EDT)
Date: Fri, 16 Apr 2021 10:52:16 -0400 (EDT)
To: paulmck <paulmck@kernel.org>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
 lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Index: WQ3F/UwlNJdCRe7pLcscx5UrzpNaiw==
Thread-Topic: liburcu: LTO breaking rcu_dereference on arm64 and possibly
 other architectures ?
Subject: [lttng-dev] liburcu: LTO breaking rcu_dereference on arm64 and
 possibly other architectures ?
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

Hi Paul, Will, Peter,

I noticed in this discussion https://lkml.org/lkml/2021/4/16/118 that LTO
is able to break rcu_dereference. This seems to be taken care of by
arch/arm64/include/asm/rwonce.h on arm64 in the Linux kernel tree.

In the liburcu user-space library, we have this comment near rcu_dereference() in
include/urcu/static/pointer.h:

 * The compiler memory barrier in CMM_LOAD_SHARED() ensures that value-speculative
 * optimizations (e.g. VSS: Value Speculation Scheduling) does not perform the
 * data read before the pointer read by speculating the value of the pointer.
 * Correct ordering is ensured because the pointer is read as a volatile access.
 * This acts as a global side-effect operation, which forbids reordering of
 * dependent memory operations. Note that such concern about dependency-breaking
 * optimizations will eventually be taken care of by the "memory_order_consume"
 * addition to forthcoming C++ standard.

(note: CMM_LOAD_SHARED() is the equivalent of READ_ONCE(), but was introduced in
liburcu as a public API before READ_ONCE() existed in the Linux kernel)

Peter tells me the "memory_order_consume" is not something which can be used today.
Any information on its status at C/C++ standard levels and implementation-wise ?

Pragmatically speaking, what should we change in liburcu to ensure we don't generate
broken code when LTO is enabled ? I suspect there are a few options here:

1) Fail to build if LTO is enabled,
2) Generate slower code for rcu_dereference, either on all architectures or only
   on weakly-ordered architectures,
3) Generate different code depending on whether LTO is enabled or not. AFAIU this would only
   work if every compile unit is aware that it will end up being optimized with LTO. Not sure
   how this could be done in the context of user-space.
4) [ Insert better idea here. ]

Thoughts ?

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
