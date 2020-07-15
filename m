Return-Path: <SRS0=9aER=A3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E612EC433E2
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Jul 2020 13:07:05 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6AE20760
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Jul 2020 13:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="GiC5Lw7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6AE20760
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B6vfb3W6kz1Y76;
	Thu, 16 Jul 2020 09:07:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594904824;
	bh=5TtlUqZCjQW2Jp42e8LSh22skgmilNwiqADFwmRCC88=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=GiC5Lw7sbqdhN7FH95EpkUEmonbu6Ctf34Y9xPBrEVUfx0OcV2e1YTKmg63VqsiLo
	 9g4E+VdF9ZRe9nnxnBNyMVxSTQpii+vVbS3GHSNMXVNYGPlKwvpr4bW4njMkwVfrwK
	 NRzcTAOXBK1imdIBU1YgxMmr78n2311c2j4zOs36LStjC9lq/klqBtxmOJut8LufMA
	 ODT3sh1att0uQny5OrGV8iKQVXgqOzZ5tgHAxwbQIwuHvIxSuP+dK5mnpNP66t5YLv
	 +NSAGBr+oSYmnii9VFHdy/rTpKlwH+sdqQcAtWulWTML/4TJ5nQ2ZZsCPV0CZoBcfb
	 TFbwR9Rq/wK0w==
Received: from mail.ut.ac.ir (mail.ut.ac.ir [80.66.177.10])
 by lists.lttng.org (Postfix) with ESMTPS id 4B6W501myBz1XX7
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jul 2020 17:40:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.ut.ac.ir (Postfix) with ESMTP id 814E31DAD81;
 Thu, 16 Jul 2020 02:09:53 +0430 (+0430)
Received: from mail.ut.ac.ir ([127.0.0.1])
 by localhost (mail.ut.ac.ir [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id MxHneGvrB7LC; Thu, 16 Jul 2020 02:09:51 +0430 (+0430)
Received: from mail.ut.ac.ir (mail.ut.ac.ir [194.225.0.10])
 by mail.ut.ac.ir (Postfix) with ESMTP id EEC091DADA4;
 Thu, 16 Jul 2020 02:09:50 +0430 (+0430)
MIME-Version: 1.0
Date: Thu, 16 Jul 2020 02:09:50 +0430
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <83963025.14828.1594838718290.JavaMail.zimbra@efficios.com>
References: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir>
 <20200715142849.0bfe909a@oasis.local.home>
 <83963025.14828.1594838718290.JavaMail.zimbra@efficios.com>
Message-ID: <98de6fe15a816d8f06ba3d5df0f10540@ut.ac.ir>
X-Sender: ahmadkhorrami@ut.ac.ir
User-Agent: Roundcube Webmail/1.3.6
X-Mailman-Approved-At: Thu, 16 Jul 2020 09:07:01 -0400
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
Cc: linux-trace-users-owner@vger.kernel.org, rostedt <rostedt@goodmis.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>,
 lttng-dev <lttng-dev@lists.lttng.org>, Namhyung Kim <namhyung@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200715213950.oi7cHdDZXgsVkxjLFi7kX7nzhPYVouV8Sdmd-mAL7fE@z>

Hi Steven and Mathieu,
Firstly, many thanks! This method seems to be the most efficient method. 
But, IIUC, what you suggest requires source code compilation. I need an 
efficient dynamic method that, given the function address, captures its 
occurrence and stores some information from the execution context. Is 
there anything better than Uprobes perhaps with no trap into the kernel? 
Why do we need traps?
Regards.

On 2020-07-15 23:15, Mathieu Desnoyers wrote:

> ----- On Jul 15, 2020, at 2:28 PM, rostedt rostedt@goodmis.org wrote:
> 
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

Indeed, it is documented here:

https://lttng.org/docs/#doc-liblttng-ust-cyg-profile

If your program is generating function entry/exit at a very
high rate (which goes beyond your available I/O throughput and
lasts longer than the memory you have available for ring buffers),
you will also probably want to use the "blocking-timeout" option
documented at:

https://lttng.org/docs/#doc-enabling-disabling-channels

Thanks,

Mathieu

> I think there's also a users ftrace like utility that Namhyung was
> working on. But I don't know where in the development that is.
> 
> -- Steve
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
