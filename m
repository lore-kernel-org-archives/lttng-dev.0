Return-Path: <SRS0=Ue3n=A2=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657F0C433E3
	for <lttng-dev@archiver.kernel.org>; Wed, 15 Jul 2020 18:35:28 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022802064B
	for <lttng-dev@archiver.kernel.org>; Wed, 15 Jul 2020 18:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="X3YvsPeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022802064B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B6Qzy0x3Tz1XWc;
	Wed, 15 Jul 2020 14:35:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594838126;
	bh=gV0keUe2GcDIR2rDMfzojiER1yxKzaOWw+JUlNAUGww=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=X3YvsPeBNwnMG5MS2QDxmvDPeKxZ+JXoPoNEhlM2WABJaYy+66g0VxD/P5h6Im6l1
	 X27x7x66/FbK0LGJsc6fFyNTGBDjOzGm3QQT4JLjKzddwEY1i2A0Es/X5uLWRl0qCK
	 PPayaLn7j/eAtvcmdCOe1Q0FhmvtSYO53uzOEt4tRIb708n5e8HxzAEh1Z3sK65f8W
	 dsBP6v87jLQIAD9cLTVUIj0KmKkJFf52TmGoWcKoiEW6tIO3WUXONEL2MV9bnnwlEy
	 k4ITdKg/WoVf8McCN59iEkCCas5uIAEouiMjF/kxZOGnT6IHmT7YsnddwW+94MoBQU
	 8V/ehx5BOrMTw==
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by lists.lttng.org (Postfix) with ESMTPS id 4B6Qzw52byz1XLD
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jul 2020 14:35:24 -0400 (EDT)
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E88F72065F;
 Wed, 15 Jul 2020 18:28:50 +0000 (UTC)
Date: Wed, 15 Jul 2020 14:28:49 -0400
To: ahmadkhorrami <ahmadkhorrami@ut.ac.ir>
Message-ID: <20200715142849.0bfe909a@oasis.local.home>
In-Reply-To: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir>
References: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir>
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
Cc: Linux-trace Users <linux-trace-users@vger.kernel.org>,
 lttng-dev@lists.lttng.org, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200715182849.PnMhe-_CPv4Ee6WP9stRjl1bT1nJ95ovx_Hz3xDjycs@z>

On Wed, 15 Jul 2020 20:37:16 +0430
ahmadkhorrami <ahmadkhorrami@ut.ac.ir> wrote:

> Hi,
> What is the most efficient way to capture occurrence of a function 
> call/return of a binary program in userspace?
> It seems the answer is Uprobes. 1) Am I right?
> But Uprobes use "int" instruction which leads to a switch into kernel 
> mode. 2) Wouldn't it be better to avoid this transition?
> I'm looking forward to your reply and will be happy to read your 
> opinions.
> Regards.


Hi, I believe LTTng has utilities that can help you trace user space
programs.

I think there's also a users ftrace like utility that Namhyung was
working on. But I don't know where in the development that is.

-- Steve
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
