Return-Path: <SRS0=ItRG=GP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634EBC433E0
	for <lttng-dev@archiver.kernel.org>; Tue, 12 Jan 2021 15:06:10 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CBEF23131
	for <lttng-dev@archiver.kernel.org>; Tue, 12 Jan 2021 15:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBEF23131
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DFYmv0QxpzQTF;
	Tue, 12 Jan 2021 10:06:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1610463968;
	bh=s0aHavoN+TMuM+8g1mCk2TGo1Zwd+E0W2Iv54pfevJ8=;
	h=To:Cc:References:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Y8L8f+0kYqu2kET8JOkg5uJVyQv6660GPBqGJEMH2OGbeOycSB9JLRNJ8PJitAGet
	 tRSemE6BAtmZeiK9X8eItQW7f4cq2XKRhrbPGlfB2KAqZuaj0Cl3bMAqgIUJuJD0xw
	 JlaS92vts/8RoarwxSkKhuQy318MTGNo2TGLQYe8nrgwNYYYqBJZSsqW/+59r9Cdok
	 HlmMA+MMI212cjbxmWlS2GQMbq1SwqKNtCfB/pENlQe12PurWSkwrqXq2a/EAbgd/A
	 cnb12TTfPTbKVotdCF3+6lFune5wEX5frmuWhBYonqfcsardLom82UPGHuiYhtK/lt
	 71wGOaDkd6Nbg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4DFYms18NWzQCD
 for <lttng-dev@lists.lttng.org>; Tue, 12 Jan 2021 10:06:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C576927A16E
 for <lttng-dev@lists.lttng.org>; Tue, 12 Jan 2021 10:05:58 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 09iUb94GBLVH; Tue, 12 Jan 2021 10:05:58 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5E61E27A0FF;
 Tue, 12 Jan 2021 10:05:58 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5E61E27A0FF
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id tNIHCXUdcoGX; Tue, 12 Jan 2021 10:05:58 -0500 (EST)
Received: from [10.10.0.241] (96-127-212-112.qc.cable.ebox.net
 [96.127.212.112])
 by mail.efficios.com (Postfix) with ESMTPSA id 3764B27A05B;
 Tue, 12 Jan 2021 10:05:58 -0500 (EST)
To: Mohammad Kavousi <kavousi@u.northwestern.edu>
Cc: lttng-dev@lists.lttng.org, Yan Chen <ychen@northwestern.edu>,
 Xutong Chen <XutongChen2021@u.northwestern.edu>
References: <CAK7B4KePHyJFCwAczqcqz+05Ts8AVm0Xh9f4hwSBKaVhQLz8cw@mail.gmail.com>
 <977d5fa1-ff33-f99e-5be9-7c53ff6adfc4@efficios.com>
 <CAK7B4KfwwC6UbuBTzJSqTHiyuDxgjAPRryYYq7vLRJSWs=2W0g@mail.gmail.com>
Message-ID: <f13d262c-560a-849e-c3f2-0c0d6e67e27b@efficios.com>
Date: Tue, 12 Jan 2021 10:05:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK7B4KfwwC6UbuBTzJSqTHiyuDxgjAPRryYYq7vLRJSWs=2W0g@mail.gmail.com>
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

On 2021-01-09 09 h 03, Mohammad Kavousi wrote:
> Michael,
> 
> Thank you for your swift response. However, for the first part, I'm not 
> sure what it means by "using" the full kernel source. How would I use it 
> with lttng-modules?
> 
> As for the quick hack part, I grabbed the kernel source and copied the 
> mount.h onto the folder you mentioned, and it did not help. I don't 
> expect lttng to automatically find that file and use it; also there are 
> no other header files in the package build directory. Could you kindly 
> give us more instructions?
> 
> Thanks,
> Mohammad

The lttng modules are shipped in Ubuntu as a dkms package which means 
they are built directly on your machine for each kernel version you 
install. So after adding the required file in your headers you'll need 
to rebuild the modules with dkms and unload / reload them in your 
running kernel or just reboot the machine.

To rebuild all installed dkms modules for the current kernel:

   sudo dkms autoinstall
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
