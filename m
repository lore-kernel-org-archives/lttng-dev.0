Return-Path: <SRS0=Ue3n=A2=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D5CC433DF
	for <lttng-dev@archiver.kernel.org>; Wed, 15 Jul 2020 21:49:11 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5B12067D
	for <lttng-dev@archiver.kernel.org>; Wed, 15 Jul 2020 21:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="hekQo2/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5B12067D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B6WHT3Jr0z1XcH;
	Wed, 15 Jul 2020 17:49:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594849750;
	bh=+gkUH0Zav+dg93gm90YRCsM/Qr4Hmls+VApz02d+Jkg=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=hekQo2/qEjAkq8PLzb4BHZCAwizcGS11TvLvDnY8vKX8f0copgEODTTXAcnpf5YPP
	 vxz06h87mRIyZGyzfog/MaUXjSv8tKBETYlue3y3pskZQScPdYWzMHzQ5sdK+ezEKw
	 L8KeqqpdTDiWXma/NHaQApfjCQn+PobiftMZ8Na6QIpaoyoAHXhcdJWLfFvWGSOBFU
	 XR2drtNWnqfEvcm2/zrV11oHrCiYSZe8zvIdzvO3O0kO9jp1FdEo5CrDUle+3Ynmca
	 llDg3hf3G5y97wW2s3ICrU1oYPNSqcF+Xz1bnAGwA7EkVqyck4JEJ137KN0Kiu3sm5
	 aYfUOxzOkdTSg==
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by lists.lttng.org (Postfix) with ESMTPS id 4B6WHR63K8z1XLq
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jul 2020 17:49:07 -0400 (EDT)
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C57122065D;
 Wed, 15 Jul 2020 21:49:00 +0000 (UTC)
Date: Wed, 15 Jul 2020 17:48:58 -0400
To: ahmadkhorrami <ahmadkhorrami@ut.ac.ir>
Message-ID: <20200715174858.4698803c@oasis.local.home>
In-Reply-To: <98de6fe15a816d8f06ba3d5df0f10540@ut.ac.ir>
References: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir>
 <20200715142849.0bfe909a@oasis.local.home>
 <83963025.14828.1594838718290.JavaMail.zimbra@efficios.com>
 <98de6fe15a816d8f06ba3d5df0f10540@ut.ac.ir>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
From: Steven Rostedt via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-users-owner@vger.kernel.org,
 linux-trace-users <linux-trace-users@vger.kernel.org>,
 lttng-dev <lttng-dev@lists.lttng.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200715214858.qPS6JcVvC5IWKVk3p6P8n5um11OS3NmSTMUr69oJwCs@z>

On Thu, 16 Jul 2020 02:09:50 +0430
ahmadkhorrami <ahmadkhorrami@ut.ac.ir> wrote:

> Hi Steven and Mathieu,
> Firstly, many thanks! This method seems to be the most efficient method. 
> But, IIUC, what you suggest requires source code compilation. I need an 
> efficient dynamic method that, given the function address, captures its 
> occurrence and stores some information from the execution context. Is 
> there anything better than Uprobes perhaps with no trap into the kernel? 
> Why do we need traps?
> Regards.

Without recompiling, how would that be implemented?

You would need to insert a jump on top of code, and still be able to
preserve that code. What a trap does, is to insert a int3, that will
trap into the kernel, it would then emulate the code that the int3 was
on, and also call some code that can trace the current state.

To do it in user land, you would need to find way to replace the code
at the location you want to trace, with a jump to the tracing
infrastructure, that will also be able to emulate the code that the
jump was inserted on top of. As on x86, that jump will need to be 5
bytes long (covering 5 bytes of text to emulate), where as a int3 is a
single byte.

Thus, you either recompile and insert nops where you want to place your
jumps, or you trap using int3 that can do the work from within the
kernel.

-- Steve
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
