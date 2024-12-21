Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351A7E7718C
	for <lttng-dev@archiver.kernel.org>; Sat, 21 Dec 2024 16:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1734798169;
	bh=Bpwkr2Wfgs01fG18GpUX1asamx7mvLL5ExJt+5w0Eqw=;
	h=To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=PawqJiB0SoWCzwSE2D4DNNYHn0nOE8dwXlvkpn1q/XzyyPukAEWk01gkalDMVFzSv
	 ewpGYvMW4UvElssAe+opk72WmpL2MjX7Ks8u63Ts+3w9SkgGc9qwsMTH0/iXQbvgDO
	 uyJW3IWVBMfVky7/1X2yZSGgshEGJBROm8mmderTPAq7hxmPO38I4jvvnMCZrlow/u
	 0EtpTb7BNWqQmhQTsnK4QHteA2QWhACpOIFbBQNtkGekpGmCYeqKT/AVUrhqrqjXOx
	 1mli/3yKg/JhUYDPjElzH6hXw7qVzJbwrpWRuT9PowyPJ4HRFfyQTD/Eo96QGzkFeX
	 uiENpb4OwOvbg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4YFqMD3mJBzyvN;
	Sat, 21 Dec 2024 11:22:48 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
 by lists.lttng.org (Postfix) with ESMTPS id 4YFqMC49rYzyvL
 for <lttng-dev@lists.lttng.org>; Sat, 21 Dec 2024 11:22:47 -0500 (EST)
Received: from localhost (157-208-8-209.mc.derytele.com [157.208.8.209])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4YFqM45MKyz1Mlw;
 Sat, 21 Dec 2024 11:22:40 -0500 (EST)
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
Cc: =?utf-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@isc.org>, paulmck
 <paulmck@kernel.org>, Alan Stern
 <stern@rowland.harvard.edu>, Lai Jiangshan <jiangshanlai@gmail.com>, Brad
 Smith <brad@comstyle.com>, lwn@lwn.net
Subject: Re: [RELEASE] Userspace RCU 0.15.0
In-Reply-To: <51160e24-389a-41b6-871b-ba522d427220@efficios.com>
Organization: EfficiOS
References: <51160e24-389a-41b6-871b-ba522d427220@efficios.com>
Date: Sat, 21 Dec 2024 11:22:40 -0500
Message-ID: <87ed21hupb.fsf@laura>
MIME-Version: 1.0
Content-Type: text/plain
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
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Fri, 20 Dec 2024, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> Hi,
[...]
>    * Introduction of the CMM memory model with the following new primitives:
>      
>        - uatomic_load(addr, memory_order)
>      
>        - uatomic_store(addr, value, memory_order)
>        - uatomic_and_mo(addr, mask, memory_order)
>        - uatomic_or_mo(addr, mask, memory_order)
>        - uatomic_add_mo(addr, value, memory_order)
>        - uatomic_sub_mo(addr, value, memory_order)
>        - uatomic_inc_mo(addr, memory_order)
>        - uatomic_dec_mo(addr, memory_order)
>      
>        - uatomic_add_return_mo(addr, value, memory_order)
>        - uatomic_sub_return_mo(addr, value, memory_order)
>      
>        - uatomic_xchg_mo(addr, value, memory_order)
>      
>        - uatomic_cmpxchg_mo(addr, old, new,
>                             memory_order_success,
>                             memory_order_failure)
>
> The uatomic API was extended to support explicit memory ordering.
> For instance, the previous uatomic_cmpxchg() now has a
> uatomic_cmpxchg_mo() counterpart, which takes a memory ordering
> argument.

It is worth mentioning that the `*_mo' variants are not public API.
Instead, the current uatomic API is extended by adding an optional
memory odring parameter for the various atomic operation.

For example, uatomic_xchg(addr, value) is equivalent to
uatomic_xchg(addr, value, CMM_SEQ_CST_FENCE).  But user can choose a
different memory ordering.  For example: uatomix_xchg(addr, value,
CMM_RELEASE).

[...]

Thanks,
Olivier
-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
