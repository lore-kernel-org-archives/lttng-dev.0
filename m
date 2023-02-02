Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06E7C64EC3
	for <lttng-dev@archiver.kernel.org>; Thu,  2 Feb 2023 16:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1675355164;
	bh=XuaCxgiMHte7XpN1+PFkEDT7rwegr+aQJMOz/937Otw=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=WwHEr8XEUAAJEvE8AEk3gSKpz+74zbDkKmS9/BkH8TINRjuSLNvljljUhvobh+DoF
	 9OqSsOO1SupzW5EJGC1WDDooOuFV2EJ8rn67bhtFric/tmguV4/CyYZKtDvs2u5515
	 TQhvIug97uRJrCvIZY0hPFC4EhRt0X0mflBAT2T2t8g7r4lPDvdmXRiLe9fO6JKm7x
	 3T+XmrPS/P/wcOtUqG4HiLm/Xw0e2jS3xFA5YnwQxJyEur08oVu2dyUpnFEk7MwHIh
	 5AznISdyTHCcc2IDx2+SfZmFhkh1CPlIf8zgvpSxQ216k5X8B0k5Vt/sQy93JvR2mw
	 HK1R6/1SoYdTA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4P740X2kqZz1Xdt;
	Thu,  2 Feb 2023 11:26:04 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4P740T298Lz1Xxp
 for <lttng-dev@lists.lttng.org>; Thu,  2 Feb 2023 11:25:51 -0500 (EST)
Received: from [172.16.0.188] (192-222-180-24.qc.cable.ebox.net
 [192.222.180.24])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4P740949dlzklk;
 Thu,  2 Feb 2023 11:25:45 -0500 (EST)
Message-ID: <ea3518a5-e539-1616-432c-b7fe7fcada2f@efficios.com>
Date: Thu, 2 Feb 2023 11:26:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To: "Beckius, Mikael" <mikael.beckius@windriver.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <PH0PR11MB490408B49130B7C9CB661E1A92D39@PH0PR11MB4904.namprd11.prod.outlook.com>
 <46f36a1a-c748-773b-8f6d-d481c9c8ad1b@efficios.com>
 <e525c864-a2ee-ef34-b7fd-1c114e70b081@efficios.com>
 <d1eb23d9-269f-85ea-0b7a-a3b779ffa843@efficios.com>
In-Reply-To: <d1eb23d9-269f-85ea-0b7a-a3b779ffa843@efficios.com>
Subject: Re: [lttng-dev] lttng-consumerd crash on aarch64 due to x86 arch
 specific optimization
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi  Mikael,

I just tried another approach to fix this issue, see:

https://review.lttng.org/c/lttng-ust/+/9413 Fix: use unaligned pointer accesses for lttng_inline_memcpy

It is less intrusive than other approaches, and does not change the generated code on the
most relevant architectures.

Feedback is welcome,

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
