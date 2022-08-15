Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D56C00140
	for <lttng-dev@archiver.kernel.org>; Mon, 15 Aug 2022 17:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1660585162;
	bh=KurqCQ4HjxrZ7CaRaTCosSc/A48NKmjNHutXOpyV8ig=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=NrdLBiNJPGaCOXfN6+RV0x4/GPfVhS1KlZcp0B+t7hYcaLXMHVOAlx6CGdDiKRBww
	 grljWrt2XvGJOe+njUdfBzDf/wgmlP542slbOAAVgj2rsJxC61LQg+Qub26Y4UYJLN
	 5vFLvCeSz7Y0TFqJ0bp5XKoyBncQpw7Jf0nD3hzJqnwqU3ryYYR5DeS6nHdWUuArA8
	 T6YIbp9ZahHwO1MVMi3oDP4ge8980PvVhf+92N0Twk60GH4CB19JY4CfWmSgRiMIyX
	 NspFO81oEWlh5Bg6G0RCBkinn3yh3SCtxbXYmLV+j5wi+3Z4+7rOncc9ovBm4n76qF
	 V304/siAjUAZw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M61k21bFCz1Gf0;
	Mon, 15 Aug 2022 13:39:22 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4M61k10qmsz1Gkr
 for <lttng-dev@lists.lttng.org>; Mon, 15 Aug 2022 13:39:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B038E327AD5
 for <lttng-dev@lists.lttng.org>; Mon, 15 Aug 2022 13:39:20 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id oH81_aF3u2Tw; Mon, 15 Aug 2022 13:39:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 30C59327AD3;
 Mon, 15 Aug 2022 13:39:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 30C59327AD3
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id b_w6h_JN82AT; Mon, 15 Aug 2022 13:39:20 -0400 (EDT)
Received: from [10.10.0.55] (unknown [38.141.136.237])
 by mail.efficios.com (Postfix) with ESMTPSA id 0A85C327AD1;
 Mon, 15 Aug 2022 13:39:20 -0400 (EDT)
Message-ID: <a5f31003-9cc9-33e3-5c23-e4360fe7edbf@efficios.com>
Date: Mon, 15 Aug 2022 13:39:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To: Elad Lahav <e2lahav@gmail.com>
Cc: lttng-dev@lists.lttng.org
References: <CAJbg=FUXDnq0cSLCzhOAO4W44+monQF4s73t_sT4dAPGWt8fPg@mail.gmail.com>
 <dd0df1d0-12ed-a568-839e-7d2ff1fbcff7@efficios.com>
 <CAJbg=FWjjBT1RbGxvCcx1+6qgJfhqtF3h3WpLB11cGSb1Efzqw@mail.gmail.com>
 <7e3f4047-101e-d8d4-93ed-370c8eaf7494@efficios.com>
 <CAJbg=FVMKPrZ+s2UdMN57R_rwDMF6ZH7BkpfMZ-Waf_AQXh9Dw@mail.gmail.com>
In-Reply-To: <CAJbg=FVMKPrZ+s2UdMN57R_rwDMF6ZH7BkpfMZ-Waf_AQXh9Dw@mail.gmail.com>
Subject: Re: [lttng-dev] Change to CPU number detection breaks QNX
 compilation
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2022-08-15 12 h 56, Elad Lahav wrote:
> That fixes the build, thanks.
> 
> I see some errors coming out of "make check", though:
> 
> ERROR: test_get_cpu_mask_from_sysfs - missing test plan
> ERROR: test_get_cpu_mask_from_sysfs - exited with status 1
> 
> --Elad

I tested on Freebsd (as a non-linux target) and I get the expected :

SKIP: test_get_cpu_mask_from_sysfs - Skip Linux specific tests.

I wonder what might differ here, it might have to do with the version of 
bash on QNX, I'm not familiar with this platform.

Michael
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
