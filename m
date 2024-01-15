Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C455C3DA79
	for <lttng-dev@archiver.kernel.org>; Mon, 15 Jan 2024 19:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1705345538;
	bh=oRWVu6YwlQsrU6ZqzW8+rgJgBrrFuKIaCXchcwxd0KM=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=b3oFmTgrhs9HhLjgHe2pqf6tN/EPeGwG/Y/7msSx/JyWZgAdph3lF9g7n+Ov9DP82
	 4bgl/AR67iMSWpYYy/VFj/bKJNmWYGZRIFtNsONekT5IM4dLaA1OFXxwTGS0OpziD2
	 uzRY97V9YY+h8MKEUDV0FU510RmtoM/fU2sn6XsdFZdY1IPTmgZzvp6G80K8qqz7nu
	 kwRS5/XmDVB1eLC70conT/83WHre42oFbGInOqBa4hGpQF3x69bQ1Hp9WWN2l4VYGi
	 Jb1L7sEQYCwjpLFG23Qu0paAfgH/F9KNQOiHFBiYALvTJ72hBi/ukixoLshpTLzjPt
	 IWo0XbJBQj3Tg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TDM6T6QNdz1NmH;
	Mon, 15 Jan 2024 14:05:37 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4TDM6R754Bz1PMF
 for <lttng-dev@lists.lttng.org>; Mon, 15 Jan 2024 14:05:35 -0500 (EST)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4TDM6Q4PkzzKxP;
 Mon, 15 Jan 2024 14:05:34 -0500 (EST)
Message-ID: <1c32a469-9bef-4b04-9696-0f875bb3727f@efficios.com>
Date: Mon, 15 Jan 2024 14:05:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Florian Weimer <fweimer@redhat.com>, gcc@gcc.gnu.org,
 libc-alpha@sourceware.org
Cc: Iain Sandoe <iain@sandoe.co.uk>, aburgess@redhat.com,
 lttng-dev@lists.lttng.org, Szabolcs Nagy <szabolcs.nagy@arm.com>
References: <8734v1ieke.fsf@oldenburg.str.redhat.com>
In-Reply-To: <8734v1ieke.fsf@oldenburg.str.redhat.com>
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

On 2024-01-13 07:49, Florian Weimer via lttng-dev wrote:
> This commit
> 
> commit 8abddb187b33480d8827f44ec655f45734a1749d
> Author: Andrew Burgess <andrew.burgess@embecosm.com>
> Date:   Sat Aug 5 14:31:06 2023 +0200
> 
>      libgcc: support heap-based trampolines
>      
>      Add support for heap-based trampolines on x86_64-linux, aarch64-linux,
>      and x86_64-darwin. Implement the __builtin_nested_func_ptr_created and
>      __builtin_nested_func_ptr_deleted functions for these targets.
>      
>      Co-Authored-By: Maxim Blinov <maxim.blinov@embecosm.com>
>      Co-Authored-By: Iain Sandoe <iain@sandoe.co.uk>
>      Co-Authored-By: Francois-Xavier Coudert <fxcoudert@gcc.gnu.org>
> 
> added TLS usage to libgcc_s.so.1.  The way that libgcc_s is currently
> built, it ends up using a dynamic TLS variant on the Linux targets.
> This means that there is no up-front TLS allocation with glibc (but
> there would be one with musl).

Trying to wrap my head around this:

If I get this right, the previous behavior was that glibc did allocate
global-dynamic variables from libraries which are preloaded and loaded
on c startup as if they were initial-exec, but now that libgcc_s.so.1
has a dynamic TLS variable, all those libraries loaded on c startup that
have global-dynamic TLS do not get the initial allocation special
treatment anymore. Is that more or less correct ?

(note: it's entirely possible that my understanding is entirely wrong,
please correct me if it's the case)

> 
> There is still a compatibility impact because glibc assigns a TLS module
> ID upfront.  This seems to be what causes the
> ust/libc-wrapper/test_libc-wrapper test in lttng-tools to fail.  We end
> up with an infinite regress during process termination because
> libgcc_s.so.1 has been loaded, resulting in a DTV update.  When this
> happens, the bottom of the stack looks like this:
> 
> #4447 0x00007ffff7f288f0 in free () from /lib64/liblttng-ust-libc-wrapper.so.1
> #4448 0x00007ffff7fdb142 in free (ptr=<optimized out>)
>      at ../include/rtld-malloc.h:50
> #4449 _dl_update_slotinfo (req_modid=3, new_gen=2) at ../elf/dl-tls.c:822
> #4450 0x00007ffff7fdb214 in update_get_addr (ti=0x7ffff7f2bfc0,
>      gen=<optimized out>) at ../elf/dl-tls.c:916
> #4451 0x00007ffff7fddccc in __tls_get_addr ()
>      at ../sysdeps/x86_64/tls_get_addr.S:55
> #4452 0x00007ffff7f288f0 in free () from /lib64/liblttng-ust-libc-wrapper.so.1
> #4453 0x00007ffff7fdb142 in free (ptr=<optimized out>)
>      at ../include/rtld-malloc.h:50
> #4454 _dl_update_slotinfo (req_modid=2, new_gen=2) at ../elf/dl-tls.c:822
> #4455 0x00007ffff7fdb214 in update_get_addr (ti=0x7ffff7f39fa0,
>      gen=<optimized out>) at ../elf/dl-tls.c:916
> #4456 0x00007ffff7fddccc in __tls_get_addr ()
>      at ../sysdeps/x86_64/tls_get_addr.S:55
> #4457 0x00007ffff7f36113 in lttng_ust_cancelstate_disable_push ()
>     from /lib64/liblttng-ust-common.so.1
> #4458 0x00007ffff7f4c2e8 in ust_lock_nocheck () from /lib64/liblttng-ust.so.1
> #4459 0x00007ffff7f5175a in lttng_ust_cleanup () from /lib64/liblttng-ust.so.1
> #4460 0x00007ffff7fca0f2 in _dl_call_fini (
>      closure_map=closure_map@entry=0x7ffff7fbe000) at dl-call_fini.c:43
> #4461 0x00007ffff7fce06e in _dl_fini () at dl-fini.c:114
> #4462 0x00007ffff7d82fe6 in __run_exit_handlers () from /lib64/libc.so.6
> 
> Cc:ing <lttng-dev@lists.lttng.org> for awareness.

I've prepared a change for lttng-ust to move the lttng-ust libc wrapper
"malloc nesting" guard variable from global-dynamic to initial-exec:

https://review.lttng.org/c/lttng-ust/+/11677 Fix: libc wrapper: use initial-exec for malloc_nesting TLS

This should help for the infinite recursion issue, but if my understanding
is correct about the impact of effectively changing the behavior used
for global-dynamic variables in preloaded and on-startup-loaded libraries
introduced by this libgcc change, I suspect we have other new issues here,
such as problems with async-signal safety of other global-dynamic variables
within LTTng-UST.

But moving all TLS variables used by lttng-ust from global-dynamic to
initial-exec is tricky, because a prior attempt to do so introduced regressions
in use-cases where lttng-ust was dlopen'd by Java or Python, AFAIU situations
where the runtimes were already using most of the extra memory pool for
dlopen'd libraries initial-exec variables, causing dlopen of lttng-ust
to fail.

Thanks Florian for letting us know about this,

Mathieu

> 
> The issue also requires a recent glibc with changes to DTV management:
> commit d2123d68275acc0f061e73d5f86ca504e0d5a344 ("elf: Fix slow tls
> access after dlopen [BZ #19924]").  If I understand things correctly,
> before this glibc change, we didn't deallocate the old DTV, so there was
> no call to the free function.
> 
> On the glibc side, we should recommend that intercepting mallocs and its
> dependencies use initial-exec TLS because that kind of TLS does not use
> malloc.  If intercepting mallocs using dynamic TLS work at all, that's
> totally by accident, and was in the past helped by glibc bug 19924.  (I
> don't think there is anything special about libgcc_s.so.1 that triggers
> the test failure above, it is just an object with dynamic TLS that is
> implicitly loaded via dlopen at the right stage of the test.)  In this
> particular case, we can also paper over the test failure in glibc by not
> call free at all because the argument is a null pointer:
> 
> diff --git a/elf/dl-tls.c b/elf/dl-tls.c
> index 7b3dd9ab60..14c71cbd06 100644
> --- a/elf/dl-tls.c
> +++ b/elf/dl-tls.c
> @@ -819,7 +819,8 @@ _dl_update_slotinfo (unsigned long int req_modid, size_t new_gen)
>   		 dtv entry free it.  Note: this is not AS-safe.  */
>   	      /* XXX Ideally we will at some point create a memory
>   		 pool.  */
> -	      free (dtv[modid].pointer.to_free);
> +	      if (dtv[modid].pointer.to_free != NULL)
> +		free (dtv[modid].pointer.to_free);
>   	      dtv[modid].pointer.val = TLS_DTV_UNALLOCATED;
>   	      dtv[modid].pointer.to_free = NULL;
> 
> As the comment hints, we shouldn't be using malloc for TLS memory at all
> because it is not AS-safe, but that's a long-term change.  This change
> seems rather specific to this particular test case failure because it
> relies on libgcc_s.so.1 never using TLS before it gets unloaded.
> 
> Regarding the libgcc_s side, I'm not sure if the TLS usage there should
> be considered a real problem, although I'm a bit nervous about it.
> However, the current implementation caches one page of trampolines past
> the outermost nested function pointer deallocation (otherwise creating
> one function pointer per thread in a loop would be really expensive).
> It looks to me that is never freed, so if the thread exits even with
> proper unwinding (e.g., on glibc with code compiled with -fexceptions),
> there is a memory leak.  Integration with glibc could avoid this issue,
> and also help with the longjmp problem, and fix setcontext/swapcontext,
> too.
> 
> Thanks,
> Florian
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
