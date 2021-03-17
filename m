Return-Path: <SRS0=EUdU=IP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFB9C433DB
	for <lttng-dev@archiver.kernel.org>; Wed, 17 Mar 2021 15:11:43 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB7F64EE2
	for <lttng-dev@archiver.kernel.org>; Wed, 17 Mar 2021 15:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB7F64EE2
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F0tsn1NK9zJL0;
	Wed, 17 Mar 2021 11:11:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1615993901;
	bh=6sOf+o12oatJciztcojUS/gyLX7iu9aY8NvD88+I0k4=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Uw/jvprma3ZpEYGILN+eJzKgyWilmZyyhD0qIx3jaNF/65JNwQL+Vbm2BdbB/cui2
	 sCw44B0T3t5xNYDHWLbN4xsR5wo5jPK1o5sV/zRf0u93QUCxWnaWGJFcYS6tUPiPDP
	 14zPIhWJTXmIfl3gStMONI71ABlzhOJHkXb42caB1KQ9nxaTLWrYfJIuYQXMExU0vH
	 U9Y4IDD/grISOttkxHzs7AsWtaTdGgF5ZYkpShPYGdfWys4tq8Tdgo1oGyHmqmkaJi
	 K3gD+BVOo/pTCPyeZwQiNQCxocxAZ1gNG4il6x52U2rCY4p+UrwS/XMsYoI5W+qi50
	 mFKxG7m0kxHSQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4F0tsl1SJFzJ8w
 for <lttng-dev@lists.lttng.org>; Wed, 17 Mar 2021 11:11:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D17242B6864
 for <lttng-dev@lists.lttng.org>; Wed, 17 Mar 2021 11:11:32 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Med-pbX0PHdF; Wed, 17 Mar 2021 11:11:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C57202B657A;
 Wed, 17 Mar 2021 11:11:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C57202B657A
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id raCf3NlrRmdA; Wed, 17 Mar 2021 11:11:31 -0400 (EDT)
Received: from joraj-alpa (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id 67C112B63EA;
 Wed, 17 Mar 2021 11:11:31 -0400 (EDT)
Date: Wed, 17 Mar 2021 11:11:30 -0400
To: "Vadivel, Arulpandiyan" <Arulpandiyan_Vadivel@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>,
 "Krishnakar, Srikanth" <Srikanth_Krishnakar@mentor.com>
Message-ID: <20210317151130.GA1032094@joraj-alpa>
References: <1615988639233.71702@mentor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1615988639233.71702@mentor.com>
Subject: Re: [lttng-dev] Reg: LTTNG Support for arm64 based k3-am654 board
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

On Wed, Mar 17, 2021 at 01:43:59PM +0000, Vadivel, Arulpandiyan via lttng-dev wrote:
> Hi Team,
> 
>     We are working on the Texas Instrument's K3-am654 board(ARM64 based), on
>     4.19.165-cip41 RT and Non-RT kernel. We would like to have the lttng
>     support on the board. Hence I have added below configurations.  With these
>     configurations enabled I am not able to access the console itself and
>     kernel stuck at Starting kernel itself as below.  Further we have added
>     earlycon to debug the early console.  Bootargs given below. With these
>     earlycon option also we are still stuck at  Starting kernel  itself.
> 
> 
> Could you please help me to understand below queries,
> 
>   *    Do we have the support of lttng for TI's K3-am654 board?

EfficiOS inc. offers commercial support for such specific cases. Please
contact us at sales@efficios.com.

We do perform an overall effort for arm32/64 support but if you need support for
a specific board, commercial support is the way to go.

>   *    Or did we miss something in the kernel?

I would say that you might have bitten off more than you can chew.

First, remove lttng from the equation. Make sure you get back to a working
state (kernel is booting).

Then add the options that lttng-modules depends on but do not touch at lttng just
yet.

Based on your previous message that should look like this, please validate
against the README of the version you are trying to use [1]:
  CONFIG_KPROBES=y
  CONFIG_PERF_EVENTS=y
  CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
  CONFIG_EVENT_TRACING=y
  CONFIG_KRETPROBES=y
  CONFIG_KALLSYMS=y
  CONFIG_KALLSYMS_ALL=y
  CONFIG_HIGH_RES_TIMERS=y
  CONFIG_TRACEPOINTS=y
  CONFIG_FTRACE=y
  CONFIG_FUNCTION_TRACER=y

[1] For example for 2.12: https://github.com/lttng/lttng-modules/blob/stable-2.12/README.md

Then you make sure that you can boot your kernel. Let me reiterate that at this
point there is NO presence of lttng at any build steps of the process.

Then, when you have a booting kernel with the necessary dependency, you can
build lttng-modules, as modules, against your kernel tree [3], tarball them, and deploy them
on the target (under /lib/modules/$(uname -r)/....). Then you try to load them
using lttng-sessiond in verbose mode and even try to trace some kernel stuff. 

[2] Note that since you are probably in a cross compilation scenario this will
    be a bit more complex then simply following
    https://github.com/lttng/lttng-modules/blob/stable-2.12/README.md#building

When this works, you can stop there or if you want you can bake-in the modules
directly into the kernel compilation steps following this [3].

[3] Again for 2.12: https://github.com/lttng/lttng-modules/blob/stable-2.12/README.md#kernel-built-in-support

And as always if you succeed or fail (and that it is related to lttng...),
please come back and tell us what happened on the mailing list so that others in
a similar situation might find some piece of valuable information.

Cheers


-- 
Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
