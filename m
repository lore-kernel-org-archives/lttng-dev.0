Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1D3C3DA79
	for <lttng-dev@archiver.kernel.org>; Mon, 15 Jan 2024 19:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1705347794;
	bh=dc3Ax/xQ/Ag/eGBLurQPu9WCEx34jFX97vk2tRLAcsg=;
	h=To:Cc:References:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QMseKT5E1B0GNaqILYqvAHmYWAdRpM3L0KDYQzZW3CpDxlRSAaCi4JMllRGGJ3195
	 GK+9hZ9gcs/rDtDogUuNDXelco26GhFv4lRkVvzCP7PyrMafq3aFURxYmIxN8G7EWo
	 pfoKJ53XFwieh4BL+MuaOA93LeqGhn9PgYvOtK7J3i2qsNAdhPB8v+cHTFMchGrca1
	 /+diB0YhxDwybEJFi62YqxUc1iPHVL55dcDAi5DHyOsbSfTvmchdOwy9AGHpEBsl55
	 b0UjI9eUVX0eLqP/0HgmPrcM0JFiHDaWtzAgHWwk+m7IkFYtTDkEKEvlQ4srZN248x
	 dCrPapbXxUmyg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TDMxs5kt3z1PNf;
	Mon, 15 Jan 2024 14:43:13 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4TDMxr3l2wz1PQl
 for <lttng-dev@lists.lttng.org>; Mon, 15 Jan 2024 14:43:12 -0500 (EST)
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-NAbXtYFKM8ad0nKKLBxnFA-1; Mon,
 15 Jan 2024 14:43:05 -0500
X-MC-Unique: NAbXtYFKM8ad0nKKLBxnFA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9B54280A9B2;
 Mon, 15 Jan 2024 19:43:01 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3D14C15E6C;
 Mon, 15 Jan 2024 19:42:59 +0000 (UTC)
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: gcc@gcc.gnu.org,  libc-alpha@sourceware.org,  Iain Sandoe
 <iain@sandoe.co.uk>,  aburgess@redhat.com,  lttng-dev@lists.lttng.org,
 Szabolcs Nagy <szabolcs.nagy@arm.com>
References: <8734v1ieke.fsf@oldenburg.str.redhat.com>
 <1c32a469-9bef-4b04-9696-0f875bb3727f@efficios.com>
Date: Mon, 15 Jan 2024 20:42:58 +0100
In-Reply-To: <1c32a469-9bef-4b04-9696-0f875bb3727f@efficios.com> (Mathieu
 Desnoyers's message of "Mon, 15 Jan 2024 14:05:32 -0500")
Message-ID: <87ply24c3h.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
From: Florian Weimer via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

* Mathieu Desnoyers:

> On 2024-01-13 07:49, Florian Weimer via lttng-dev wrote:
>> This commit
>> commit 8abddb187b33480d8827f44ec655f45734a1749d
>> Author: Andrew Burgess <andrew.burgess@embecosm.com>
>> Date:   Sat Aug 5 14:31:06 2023 +0200
>>      libgcc: support heap-based trampolines
>>           Add support for heap-based trampolines on x86_64-linux,
>> aarch64-linux,
>>      and x86_64-darwin. Implement the __builtin_nested_func_ptr_created and
>>      __builtin_nested_func_ptr_deleted functions for these targets.
>>           Co-Authored-By: Maxim Blinov <maxim.blinov@embecosm.com>
>>      Co-Authored-By: Iain Sandoe <iain@sandoe.co.uk>
>>      Co-Authored-By: Francois-Xavier Coudert <fxcoudert@gcc.gnu.org>
>> added TLS usage to libgcc_s.so.1.  The way that libgcc_s is
>> currently
>> built, it ends up using a dynamic TLS variant on the Linux targets.
>> This means that there is no up-front TLS allocation with glibc (but
>> there would be one with musl).
>
> Trying to wrap my head around this:
>
> If I get this right, the previous behavior was that glibc did allocate
> global-dynamic variables from libraries which are preloaded and loaded
> on c startup as if they were initial-exec, but now that libgcc_s.so.1
> has a dynamic TLS variable, all those libraries loaded on c startup that
> have global-dynamic TLS do not get the initial allocation special
> treatment anymore. Is that more or less correct ?

Ahh.  I had forgotten about this aspect.  The allocation from the static
TLS area still happens as before.

> I've prepared a change for lttng-ust to move the lttng-ust libc wrapper
> "malloc nesting" guard variable from global-dynamic to initial-exec:
>
> https://review.lttng.org/c/lttng-ust/+/11677 Fix: libc wrapper: use initial-exec for malloc_nesting TLS

I don't know if this is completely sufficient if there are other TLS
variables in the lttng stack.

> This should help for the infinite recursion issue, but if my understanding
> is correct about the impact of effectively changing the behavior used
> for global-dynamic variables in preloaded and on-startup-loaded libraries
> introduced by this libgcc change, I suspect we have other new issues here,
> such as problems with async-signal safety of other global-dynamic variables
> within LTTng-UST.

This didn't change, and the allocation is not done lazily (contrary to
what I might have written before).  But even on the __tls_get_addr fast
path, we check the TLS generation counter, and if that has changed, we
do extra bookkeeping work.  TLS usage in libgcc_s.so.1 means that in the
now-failing test, the generation counter changed.  Before bug 19924

  TLS performance degradation after dlopen 
  <https://sourceware.org/bugzilla/show_bug.cgi?id=19924>

was fixed, we did not do this bookkeeping work, which is why the problem
didn't occur.

General use of lttng should be fine, I think, only the malloc wrapper
has this problem.

> But moving all TLS variables used by lttng-ust from global-dynamic to
> initial-exec is tricky, because a prior attempt to do so introduced
> regressions in use-cases where lttng-ust was dlopen'd by Java or
> Python, AFAIU situations where the runtimes were already using most of
> the extra memory pool for dlopen'd libraries initial-exec variables,
> causing dlopen of lttng-ust to fail.

Oh, right, that makes it quite difficult.  Could you link a private copy
of the libraries into the wrapper that uses initial-exec TLS?

Thanks,
Florian

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
