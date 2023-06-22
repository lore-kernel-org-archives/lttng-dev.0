Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17B5EB64D7
	for <lttng-dev@archiver.kernel.org>; Thu, 22 Jun 2023 01:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687398473;
	bh=JKCj3lSfIvvZVK8+JavgIsMtqfg4fI2GAggGmD51N8Q=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=yoadD6KvAD48t2fUP+Nd8oeBropeHEZOFJi5r+TtTPbuZBw6tuiCdIMqg8F+SxHke
	 hSNkKV4FE2pUuU9nzLJEB3KrCVN0XaX9db55ownsmKz1G3g4BPR/p6VZYQ2XViTg1d
	 lDGZgg/9Ge1FRh0QiwBdLEUF0PGsH/pCGneLaj9PRqtlCl3A5xpFtN9jyzWZBvXHsH
	 ogGtTLbKpAXctE6kRT6bhz20TUzb4VzKlK09VQTQnnh9nDSKkOJJZq6mqMmaspkEW4
	 6u+OCGl7a7cTesJuQSgsf2CM3wQtIYd+xtI1GISMpFA7n7vtLJldrRxtA2UaWV46Rw
	 ZPCP5jVkCQhGQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Qmjtc3hvQz20Br;
	Wed, 21 Jun 2023 21:47:52 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QmjtY0yRxz2067
 for <lttng-dev@lists.lttng.org>; Wed, 21 Jun 2023 21:47:48 -0400 (EDT)
Received: from [192.168.18.28] (unknown [198.16.185.171])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QmjtX1prlz18rm;
 Wed, 21 Jun 2023 21:47:48 -0400 (EDT)
Message-ID: <9ca1c2ca-a027-7178-f552-e0f8fa8f2d2f@efficios.com>
Date: Wed, 21 Jun 2023 21:48:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Olivier Dion <odion@efficios.com>, paulmck@kernel.org
Cc: lttng-dev@lists.lttng.org
References: <20230515201718.9809-1-odion@efficios.com>
 <20230515201718.9809-5-odion@efficios.com>
 <bc031f8e-8380-4a1d-bfe2-9e8204e06283@paulmck-laptop> <877crwmi54.fsf@laura>
In-Reply-To: <877crwmi54.fsf@laura>
Subject: Re: [lttng-dev] [PATCH 04/11] urcu/arch/generic: Use atomic
 builtins if configured
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

On 6/21/23 20:53, Olivier Dion wrote:
> On Wed, 21 Jun 2023, "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> On Mon, May 15, 2023 at 04:17:11PM -0400, Olivier Dion wrote:
>>>   #ifndef cmm_mb
>>>   #define cmm_mb()    __sync_synchronize()
>>
>> Just out of curiosity, why not also implement cmm_mb() in terms of
>> __atomic_thread_fence(__ATOMIC_SEQ_CST)?  (Or is that a later patch?)
> 
> IIRC, Mathieu and I agree that the definition of a thread fence -- acts
> as a synchronization fence between threads -- is too weak for what we
> want here.  For example, with I/O devices.
> 
> Although __sync_synchronize() is probably an alias for a SEQ_CST thread
> fence, its definition -- issues a full memory barrier -- is stronger.
> 
> We do not want to rely on this assumption (alias) and prefer to rely on
> the documented definition instead.
> 

We should document this rationale with a new comment near the #define,
in case anyone mistakenly decides to use a thread fence there to make it
similar to the rest of the code in the future.

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
