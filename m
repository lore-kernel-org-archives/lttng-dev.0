Return-Path: <SRS0=9aER=A3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3B1C433E1
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Jul 2020 16:07:31 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F47920739
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Jul 2020 16:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="ePhmuOfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F47920739
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B6zfn4b0Lz1YVR;
	Thu, 16 Jul 2020 12:07:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594915650;
	bh=rpLd+HeSaUAy2uuEkFT282KzBGXxrQpKEzcWCSb+To8=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ePhmuOfxoovK5KN4KS2kDTRcG3qm3gS3UTKbBqqGkIxKLcW4KLQnjzx3WeUcVerGW
	 Tmm+t86/+sZVMkLk6h9We/tW5xOjKbx73apCDX+RHSzXGByJqK7cjCHEd6lYyiDJSN
	 P8HtvhnfXczILAy3DT1SFlGiuqRQPvhK5X3dDphk/FPTimRUjOsv9EgJG+rscZvoFK
	 MoIdHga0J17veIs8iMhkFlzG27nCZK/LmnvrmC8M7oWlGR+DIi/Y7XRssSynTwJWsx
	 HbF+TatxbFHHrfSvOg2rJ8kvw/SKsvk2DWNC3M4UvMZBZESuD883DnmPPxXwNcdgk/
	 mUQGvBbq0m7yQ==
Received: from mail.ut.ac.ir (mail.ut.ac.ir [80.66.177.10])
 by lists.lttng.org (Postfix) with ESMTPS id 4B6zfl0cgxz1YPS
 for <lttng-dev@lists.lttng.org>; Thu, 16 Jul 2020 12:07:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.ut.ac.ir (Postfix) with ESMTP id A07871DAF3E;
 Thu, 16 Jul 2020 20:37:14 +0430 (+0430)
Received: from mail.ut.ac.ir ([127.0.0.1])
 by localhost (mail.ut.ac.ir [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id Pafo_kF1Sg0J; Thu, 16 Jul 2020 20:37:13 +0430 (+0430)
Received: from mail.ut.ac.ir (mail.ut.ac.ir [194.225.0.10])
 by mail.ut.ac.ir (Postfix) with ESMTP id 737211DAF1D;
 Thu, 16 Jul 2020 20:37:13 +0430 (+0430)
MIME-Version: 1.0
Date: Thu, 16 Jul 2020 20:37:13 +0430
To: Namhyung Kim <namhyung@kernel.org>
In-Reply-To: <CAM9d7chE3WQm2e4EA4i09Q1hOaGt2hrPHoF2d0tjqhciPceB9g@mail.gmail.com>
References: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir>
 <20200715142849.0bfe909a@oasis.local.home>
 <CAM9d7chE3WQm2e4EA4i09Q1hOaGt2hrPHoF2d0tjqhciPceB9g@mail.gmail.com>
Message-ID: <42d8f4d107d2117fb246b8ff1890e301@ut.ac.ir>
X-Sender: ahmadkhorrami@ut.ac.ir
User-Agent: Roundcube Webmail/1.3.6
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
From: ahmadkhorrami via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: ahmadkhorrami <ahmadkhorrami@ut.ac.ir>
Cc: linux-trace-users-owner@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>,
 Linux-trace Users <linux-trace-users@vger.kernel.org>,
 lttng-dev@lists.lttng.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200716160713.yqLeAHNpyw1Bx3Dll5F9L3OeAKGoMQGIeJPND86RyIE@z>

Hi Namhyung,
This seems really interesting and is what I am looking for. Can it 
capture all function entries/exits? I mean does it fully handle variable 
instruction sizes in dynamic mode?
In any case, thanks! and I hope that it becomes stable as soon as 
possible, so that everyone can use it.
Regards.

On 2020-07-16 05:34, Namhyung Kim wrote:

> Hi all,
> 
> On Thu, Jul 16, 2020 at 3:28 AM Steven Rostedt <rostedt@goodmis.org> 
> wrote:
> On Wed, 15 Jul 2020 20:37:16 +0430
> ahmadkhorrami <ahmadkhorrami@ut.ac.ir> wrote:
> 
> Hi,
> What is the most efficient way to capture occurrence of a function
> call/return of a binary program in userspace?
> It seems the answer is Uprobes. 1) Am I right?
> But Uprobes use "int" instruction which leads to a switch into kernel
> mode. 2) Wouldn't it be better to avoid this transition?
> I'm looking forward to your reply and will be happy to read your
> opinions.
> Regards.
> 
> Hi, I believe LTTng has utilities that can help you trace user space
> programs.
> 
> I think there's also a users ftrace like utility that Namhyung was
> working on. But I don't know where in the development that is.

It's in https://github.com/namhyung/uftrace

Basically it also requires recompilation to add mcount calls for each 
function.
But it now also supports dynamic tracing without any recompilation.. :)
It's still experimental and has some limitation, but the idea is to copy
first 5 bytes (on x86_64) somewhere and replace it to a call 
instruction.

Thanks
Namhyung
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
