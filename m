Return-Path: <SRS0=91P6=I5=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238E7C433ED
	for <lttng-dev@archiver.kernel.org>; Wed, 31 Mar 2021 17:42:13 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC1D60FE5
	for <lttng-dev@archiver.kernel.org>; Wed, 31 Mar 2021 17:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC1D60FE5
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F9YXy4MCyzSJt;
	Wed, 31 Mar 2021 13:42:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617212531;
	bh=xKi5S422ge+AnG/Zcnpskxev6f0SoDXHejfXNMfxHVI=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=vvpBir7SibeuDAOyVaiazcPwnzIYpUPGFljn5Wc7+4BEG50xgEyw0Refw0fHtcn0L
	 R7IgtseQeeXqVhZaIEn7OYgrNAtRJCuAVQrYHw9rl+wcaSdT6TEvA+kONsUCAcSFpL
	 Ubi7oCjsXOcq0kyoe0PApA1dVjrmRZaBJAF8lkYqtyA9Cbi6aIYk3nCBnldZq3WqSe
	 ot4MvsfswX/Hpcr4JVKX5aWqhVvu8S7qqWtG4mIqoa2KuV6aAL4HSPJqBVAaT8KzEV
	 JZ2WmADJSv89W+ExFbMo9yjhZev5lt/g831e7FDSqOtWjdn21TofGN76x0P0xf9KI8
	 c0EgzbEMHx14w==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4F9YXx39CMzSLl
 for <lttng-dev@lists.lttng.org>; Wed, 31 Mar 2021 13:42:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id EA7BF2F7A3C
 for <lttng-dev@lists.lttng.org>; Wed, 31 Mar 2021 13:42:03 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Y8FEfWW7l7lK; Wed, 31 Mar 2021 13:42:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C32932F7C84;
 Wed, 31 Mar 2021 13:42:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C32932F7C84
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id iw_Mvdbg3zZQ; Wed, 31 Mar 2021 13:42:02 -0400 (EDT)
Received: from joraj-alpa (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id 6D64D2F7333;
 Wed, 31 Mar 2021 13:42:02 -0400 (EDT)
Date: Wed, 31 Mar 2021 13:42:01 -0400
To: Ramesh Errabolu <ramesh.errabolu@gmail.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <20210331174201.GB28307@joraj-alpa>
References: <CAFGSPrw1Ev1c+Ok7tvyzEJOQNDze6fbpzNKFzmH=9hSVYGF69A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFGSPrw1Ev1c+Ok7tvyzEJOQNDze6fbpzNKFzmH=9hSVYGF69A@mail.gmail.com>
Subject: Re: [lttng-dev] Can't trace function calls
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
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

On Wed, Mar 31, 2021 at 10:51:03AM -0500, Ramesh Errabolu via lttng-dev wrote:
> I am trying to capture the list of functions being called by an app. The
> app relies on a couple of shared libraries (libhsa-runtime64.so and
> libhsakmt.so).

ok.

> 
> My experiments all *FAIL *i.e. there are no log files of the output.

Not sure what you mean here. But let's continue first. 

> The
> link on lttng-ust-cyg-profile does not tell me where I can get them.

Could you share the "link" in question?

> Instrument the build files for the two libraries to allow function tracing
> by the gcc/clang flags -finstrument-functions and run workload as follows
> 
>    - Instrument the build files for the two libraries to allow function
>    tracing by the gcc/clang flags *-finstrument-functions* and run workload
>    as follows

Okai. I expect that you have read this:
https://lttng.org/docs/v2.12/#doc-liblttng-ust-cyg-profile 

and this
https://lttng.org/man/3/lttng-ust-cyg-profile/v2.12/

> I am using LTTng version Ubuntu: LTTng Stable 2.12 PPA
> 
>    - apt-get install lttng-tools
>    - apt-get install lttng-modules-dkms
>    - apt-get install liblttng-ust-dev
> 

Looks good.

> I noticed no kernel modules with substring "ltt" in it.

Okai so this is where we need much more information. 

First of all, what are the lttng commands used for your experiments? (lttng create, lttng enable-channel, lttng enable-event...) 
Please provide a sample script of your experiments. 

Second, you are mostly performing userspace tracing here, lttng-modules ( the
kernel tracer) might not even be needed here unless you also want to do kernel
tracing. 

What do you mean by "there are no log files of the output."? LTTng produces
traces encoded in CTF (Common Trace Format) that must be read by a reader
(Babeltrace most of the time).

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
