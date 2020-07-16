Return-Path: <SRS0=9aER=A3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE721C433E1
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Jul 2020 01:06:43 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306B420775
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Jul 2020 01:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="ZAxmJd/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306B420775
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B6bgP4DLjz1Xxk;
	Wed, 15 Jul 2020 21:06:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594861602;
	bh=05+twR9VwhOEVRGnAiThu/wN5s6wcm0kwHRxvQe9sgc=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ZAxmJd/4MCj5ZIW+85c6FaC7EuWDBEAWqSrzy7g8YOxnKBMQQhSBE3EgMc8XqFEFr
	 COKVGKRgLYDJiXTvCSb6vNBPfZqsXrsCo50D3BuI46qLEoUV1cjoMQ7CcXMHH3PTzR
	 /8x1snslrn+AXMlh3GE9my85h+FX7vbTS0wTGSd4QI/viRkMHkrMFF5D4/ZDfyWfuI
	 HYUbcJhyPJ6oUQHNsjyXy7mX5AYRzRIUx7FMToJVwgq8rwbv9J8/mMg0wY4nZzM7/3
	 kOvmBj1mRp4ayg7/8LzKnQkvA7Vb+qLsLvYm/Zi8pOLcIrVjF+hvGck0TiPARenb0a
	 ivrpFViDaqZuA==
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by lists.lttng.org (Postfix) with ESMTPS id 4B6bgM6Fbhz1Xxh
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jul 2020 21:06:39 -0400 (EDT)
Received: from zimbra-s1.polymtl.ca (zimbra-s1.polymtl.ca [132.207.23.203])
 by smtp.polymtl.ca (8.14.7/8.14.7) with ESMTP id 06G161gQ023443;
 Wed, 15 Jul 2020 21:06:02 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.polymtl.ca 06G161gQ023443
Date: Wed, 15 Jul 2020 21:06:01 -0400 (EDT)
To: Steven Rostedt <rostedt@goodmis.org>
Cc: ahmadkhorrami <ahmadkhorrami@ut.ac.ir>,
 linux-trace-users-owner@vger.kernel.org,
 linux-trace-users <linux-trace-users@vger.kernel.org>,
 lttng-dev <lttng-dev@lists.lttng.org>, Namhyung Kim <namhyung@kernel.org>
Message-ID: <489547987.230950.1594861561764.JavaMail.zimbra@polymtl.ca>
In-Reply-To: <20200715174858.4698803c@oasis.local.home>
References: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir>
 <20200715142849.0bfe909a@oasis.local.home>
 <83963025.14828.1594838718290.JavaMail.zimbra@efficios.com>
 <98de6fe15a816d8f06ba3d5df0f10540@ut.ac.ir>
 <20200715174858.4698803c@oasis.local.home>
MIME-Version: 1.0
X-Originating-IP: [173.178.82.11]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - GC83 (Linux)/8.8.15_GA_3928)
Thread-Topic: Capturing User-Level Function Calls/Returns
Thread-Index: yVWNHzuLFTcaJN3f/zLUD8IQ2UI7ZQ==
X-Poly-FromMTA: (zimbra-s1.polymtl.ca [132.207.23.203]) at Thu,
 16 Jul 2020 01:06:01 +0000
Subject: Re: [lttng-dev] Capturing User-Level Function Calls/Returns
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
From: Michel Dagenais via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michel Dagenais <michel.dagenais@polymtl.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200716010601.lV_wZOyYg_dk-JxBGFZgbszWls3xuqbLkHlqhGbu6qM@z>


> Without recompiling, how would that be implemented?

As you mentioned, this is possible when "jump patching" 5 bytes instructions. Fast tracepoints in GDB and in kprobe do it. Kprobe goes further and patches sequences of instructions (because the target instruction is less than 5 bytes) if there is no incoming branch into the middle of the sequence. You can go even further, for instance using 3 bytes jumps to a trampoline installed in alignment nops. If you combine different strategies like this, you can eventually reach almost 100% success rate for "jump patching" tracepoints. This gets quite hairy though. However, the short story is that there is currently no tool as far as I know that does that easily and reliably in user space.

https://onlinelibrary.wiley.com/doi/abs/10.1002/spe.2746
https://dl.acm.org/doi/pdf/10.1145/3062341.3062344

If you can afford a more invasive tool, that requires a lot of memory and stops your application for quite some time, you can look at approaches like dyninst that decompile the binary, insert instrumentation code and reassemble the code.

https://dyninst.org/

> You would need to insert a jump on top of code, and still be able to
> preserve that code. What a trap does, is to insert a int3, that will
> trap into the kernel, it would then emulate the code that the int3 was
> on, and also call some code that can trace the current state.
> 
> To do it in user land, you would need to find way to replace the code
> at the location you want to trace, with a jump to the tracing
> infrastructure, that will also be able to emulate the code that the
> jump was inserted on top of. As on x86, that jump will need to be 5
> bytes long (covering 5 bytes of text to emulate), where as a int3 is a
> single byte.
> 
> Thus, you either recompile and insert nops where you want to place your
> jumps, or you trap using int3 that can do the work from within the
> kernel.
> 
> -- Steve
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
