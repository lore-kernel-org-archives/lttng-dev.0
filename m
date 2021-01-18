Return-Path: <SRS0=oCXi=GV=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A1DC433E0
	for <lttng-dev@archiver.kernel.org>; Mon, 18 Jan 2021 18:18:52 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD1722CA1
	for <lttng-dev@archiver.kernel.org>; Mon, 18 Jan 2021 18:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD1722CA1
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DKKmT46LczSb7;
	Mon, 18 Jan 2021 13:18:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1610993930;
	bh=w1WGZTqvTk6b4ghXzgbCHrQm8FJiIiengxSknTVuJxA=;
	h=To:Cc:References:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ZcCVx5u1Iz/Z7dArFeLgo88FQ2+ZhTFw4fQjMSR7OmFs39t/7ntcZwYXeJ2msNhv1
	 3wlExGMEupLQhbJhPARaJfJZ8HbMwJnsDNJqOCQcyA6O/rX+xY1m/Y2t3Y/fVAdk+h
	 ro/gzssPE9dIn6CYAP+kVH/pVzzncOlYsqap8cNPb8YeVNyU1S2kQeyPD+CZZFUikM
	 I6lNBykyflW1BczO3pvi7H9yyXGr1VbTlv9DcWGAxY9xR8cCz2L6e1C0HBWfjera0I
	 dTmZhoFvBkm1QC4kek6UeYoAnC8dk413A1t9xn2bf4MwbJnwrX/PcUKwnhCOwplBxb
	 SYCYB7ruUkUNg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4DKKmR2KX0zSb2
 for <lttng-dev@lists.lttng.org>; Mon, 18 Jan 2021 13:18:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 06184302F0E
 for <lttng-dev@lists.lttng.org>; Mon, 18 Jan 2021 13:18:42 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id DhHww1N4EgPp; Mon, 18 Jan 2021 13:18:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BD274302DC4;
 Mon, 18 Jan 2021 13:18:41 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BD274302DC4
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id UGbacrzdIXWW; Mon, 18 Jan 2021 13:18:41 -0500 (EST)
Received: from [10.10.0.241] (96-127-212-112.qc.cable.ebox.net
 [96.127.212.112])
 by mail.efficios.com (Postfix) with ESMTPSA id 8E44C302F0D;
 Mon, 18 Jan 2021 13:18:41 -0500 (EST)
To: Mohammad Kavousi <kavousi@u.northwestern.edu>
Cc: lttng-dev@lists.lttng.org, Yan Chen <ychen@northwestern.edu>,
 Xutong Chen <XutongChen2021@u.northwestern.edu>
References: <CAK7B4KePHyJFCwAczqcqz+05Ts8AVm0Xh9f4hwSBKaVhQLz8cw@mail.gmail.com>
 <977d5fa1-ff33-f99e-5be9-7c53ff6adfc4@efficios.com>
 <CAK7B4KfwwC6UbuBTzJSqTHiyuDxgjAPRryYYq7vLRJSWs=2W0g@mail.gmail.com>
 <f13d262c-560a-849e-c3f2-0c0d6e67e27b@efficios.com>
 <CAK7B4Kc9bED7q9_6HsCqLT1dhJEjjNY93cspZ7Nb_Ztpn+=ERg@mail.gmail.com>
 <869ac606-375e-b15c-9eec-6501865b5c52@efficios.com>
 <CAK7B4KfTzaK8ysqoEnWAbsF2fm_E8cMgPx2e0jV9tuASXM=vyQ@mail.gmail.com>
Message-ID: <8a51f342-99e8-d4b3-f164-4a55d7ef6254@efficios.com>
Date: Mon, 18 Jan 2021 13:18:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAK7B4KfTzaK8ysqoEnWAbsF2fm_E8cMgPx2e0jV9tuASXM=vyQ@mail.gmail.com>
Content-Language: en-US
Subject: Re: [lttng-dev] LTTng Support for Mount Namespace
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2021-01-12 15 h 30, Mohammad Kavousi wrote:
> Before, I was installing using the ppa repository. Based on your 
> instructions, I made lttng using the source code in a totally new 
> environment, having the mount.h under '/lib/modules/$(uname -r)/build/fs'.
> 
> I removed the "ifneq" and "endif" statements for 'Makefile' and 
> 'Kbuild.common' which were surrounding "mnt_ns_dep". lttng was installed 
> successfully and the kernel trace session started, but I'm still getting 
> the same error.

Make sure you delete 'ccflags-y += -DLTTNG_MNT_NS_MISSING_HEADER' from 
Kbuild.common, this is what disables the mount namespace support when 
the modules are built.

> 
> As a hint, in the build process for lttng-modules, I found messages such 
> as "./fs/ext4/*.h not found". Is that part of the problem? Meaning, is 
> enabling the mnt context filesystem-specific?

No this is related to the probe that enables ext4 specific tracepoints.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
