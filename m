Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254BAC3DA79
	for <lttng-dev@archiver.kernel.org>; Mon, 15 Jan 2024 20:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1705349318;
	bh=Wwu1Kwj0OAc4Mfp4LRYvO2xWMttpyJ4R+QL50WQXvyA=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=xygMrzGEwp/rd4uX2FifMJ6g1vo1Ex/+E7FFvgWBYdkE5OZ1bdczryF9i8r/QrDPj
	 ALrEUlX+sei7oPl3VybBetjL2mZjTF41XS26uR3d9yTwxfQSwKV390+prcxIQNpyOq
	 I4cIsTVFX1IKtuhhdBIF//NUdlyNOfZEtzq6rR2IPT6ieTToEoigYS776P3ka3o3Q/
	 331ZuaCTmX3ehzIrwTPfbTXuT20gWfRNT7Rc5BqiYXnFoRHRPtcDDzryomodP5slkB
	 qbEvXeh3TqASpgZjYGEwLoNYen6EHAMd563UXpCF+Sim2SG5VpC8Fp4cmP7KVBH2WU
	 93zxOZ9H6d4kA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TDNW95Mzmz1PZY;
	Mon, 15 Jan 2024 15:08:37 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4TDNW81sMhz1PmR
 for <lttng-dev@lists.lttng.org>; Mon, 15 Jan 2024 15:08:35 -0500 (EST)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4TDNW55T3LzKsL;
 Mon, 15 Jan 2024 15:08:33 -0500 (EST)
Message-ID: <7e0e21b4-94f8-4ca5-8caf-31d8864a4ace@efficios.com>
Date: Mon, 15 Jan 2024 15:08:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Florian Weimer <fweimer@redhat.com>
Cc: gcc@gcc.gnu.org, libc-alpha@sourceware.org,
 Iain Sandoe <iain@sandoe.co.uk>, aburgess@redhat.com,
 lttng-dev@lists.lttng.org, Szabolcs Nagy <szabolcs.nagy@arm.com>
References: <8734v1ieke.fsf@oldenburg.str.redhat.com>
 <1c32a469-9bef-4b04-9696-0f875bb3727f@efficios.com>
 <87ply24c3h.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87ply24c3h.fsf@oldenburg.str.redhat.com>
Subject: Re: [lttng-dev] New TLS usage in libgcc_s.so.1, compatibility impact
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2024-01-15 14:42, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
[...]
> 
> General use of lttng should be fine, I think, only the malloc wrapper
> has this problem.

The purpose of the nesting counter TLS variable in the malloc wrapper
is to catch situations like this where a global-dynamic TLS access
(or any unexpected memory access done as a side-effect from calling
libc) from within LTTng-UST instrumentation would internally attempt to
call recursively into the malloc wrapper. In that nested case, we skip
the instrumentation and call the libc function directly.

I agree with your conclusion that only this nesting counter gating variable
actually needs to be initial-exec.

> 
>> But moving all TLS variables used by lttng-ust from global-dynamic to
>> initial-exec is tricky, because a prior attempt to do so introduced
>> regressions in use-cases where lttng-ust was dlopen'd by Java or
>> Python, AFAIU situations where the runtimes were already using most of
>> the extra memory pool for dlopen'd libraries initial-exec variables,
>> causing dlopen of lttng-ust to fail.
> 
> Oh, right, that makes it quite difficult.  Could you link a private copy
> of the libraries into the wrapper that uses initial-exec TLS?

Unfortunately not easily, because by design LTTng-UST is meant to be a
singleton per-process. Changing this would have far-reaching impacts on
interactions with the LTTng-UST tracepoint instrumentation, as well as
impacts on synchronization between the LTTng-UST agent thread and
application calling fork/clone. Also AFAIR, the LTTng session daemon
(at least until recently) does not expect multiple concurrent
registrations from a given process.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
