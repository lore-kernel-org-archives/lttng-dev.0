Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850FDC6FD1C
	for <lttng-dev@archiver.kernel.org>; Mon, 20 Mar 2023 19:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679341678;
	bh=pxyy13WyQCZepZ1uNTe+URjtQOAVtFz+0ZUIDvLHMr4=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=sgzRtTt5/chL7aIGL5jVhYBIIUErPlUxF5kTU/5DqtobCO+NfOvKGtSjJgs/74wXT
	 TQR/upcWWbB5tQtjDrLnh2UfcKNupRiFoukAGtyjPoT6P7nsL6PEt/Nq7wUxH3vNzf
	 V81HwtL2llvhAnDFVqsQeOm/YAYYjSpa6cfPTbixLPu7cNjIB8KYAmguyJjYkUyqhy
	 ByaBsC9SazgYTQk/1tORf6dct+7FE8152irHAs//ut9V/+Gu5XoEtCC0eKS4rkuPOg
	 VDkK0Q1ER88+L+URETvz6BjPtb8DIsQDFd8QBmUrFg8EEyunZIRiLKuf9rurJM6Yav
	 fuMQle1JLh7zA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PgQJF658jz2Dkg;
	Mon, 20 Mar 2023 15:47:57 -0400 (EDT)
Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
 by lists.lttng.org (Postfix) with ESMTP id 4PgQJC20sSz2DbF
 for <lttng-dev@lists.lttng.org>; Mon, 20 Mar 2023 15:47:54 -0400 (EDT)
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
 by smtpfb1-g21.free.fr (Postfix) with ESMTP id 52B64DF8EE5
 for <lttng-dev@lists.lttng.org>; Mon, 20 Mar 2023 20:39:37 +0100 (CET)
Received: from [IPV6:2a01:e0a:255:1000:d6dc:f705:ee77:618b] (unknown
 [IPv6:2a01:e0a:255:1000:d6dc:f705:ee77:618b])
 (Authenticated sender: duncan.sands@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 61F192003CE
 for <lttng-dev@lists.lttng.org>; Mon, 20 Mar 2023 20:38:59 +0100 (CET)
Message-ID: <dbe6e604-6ae9-1790-718f-bc69686442d1@free.fr>
Date: Mon, 20 Mar 2023 20:38:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: lttng-dev@lists.lttng.org
References: <20230317213755.455957-1-ondrej@sury.org>
 <20230317213755.455957-3-ondrej@sury.org>
 <6d73ed33-f3fc-2459-a7e9-142b8908ad4f@efficios.com>
In-Reply-To: <6d73ed33-f3fc-2459-a7e9-142b8908ad4f@efficios.com>
Subject: Re: [lttng-dev] [PATCH 2/7] Use gcc __atomic builtis for
 <urcu/uatomic.h> implementation
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
From: Duncan Sands via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Duncan Sands <baldrick@free.fr>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Mathieu,

> While OK for the general case, I would recommend that we immediately implement 
> something more efficient on x86 32/64 which takes into account that 
> __ATOMIC_ACQ_REL atomic operations are implemented with LOCK prefixed atomic 
> ops, which imply the barrier already, leaving the before/after_uatomic_*() as 
> no-ops.

maybe first check whether the GCC optimizers merge them.  I believe some 
optimizations of atomic primitives are allowed and implemented, but I couldn't 
say which ones.

Best wishes, Duncan.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
