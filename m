Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F17C4707B
	for <lttng-dev@archiver.kernel.org>; Mon, 15 Jan 2024 13:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1705326915;
	bh=rTNF2yaFXkLk8iFO4teMMpwqoI+1a7Xa/tDN8DnYPAE=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=na55rR1JRpbYejVeIUEd4X/7pMQ3fs42+7+h5NOvcNQnDl6tQTCohMapa+w7ZedG5
	 /Xn4Rs4WXvZ4JfeozL1KEEQD0buTcGo5lWVlfXOq+Fx3xpEm3WoRYrYQU6zEgnDtFQ
	 sNa5vhdVNs6BhBxEHMxpWUJ8JUWKAooMYhAVp57eryRIfISXvJAkcz7loANHbh0l7X
	 Bm4B7OeOP0CAWSMtDMp/4O785WnGVwhT6mmFOuZY88CrBrRjF4JNlb+mKJclaPEGaw
	 FkZmwH+ereex1OFcB9hCsRfesX/Cf18111NJ70RgSnyKuxams2A/gH7TJhGM8iZ59O
	 l7VNI1MXcuf6w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TDDDL3Z4dz1Nyk;
	Mon, 15 Jan 2024 08:55:14 -0500 (EST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by lists.lttng.org (Postfix) with ESMTPS id 4TDDDK0zrwz1PN2
 for <lttng-dev@lists.lttng.org>; Mon, 15 Jan 2024 08:55:12 -0500 (EST)
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d3f3ee00a2so40376245ad.3
 for <lttng-dev@lists.lttng.org>; Mon, 15 Jan 2024 05:55:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705326911; x=1705931711;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2KFcPV7PoxoUdfV29AVpBoNXVzKLhiNl2DX8t0nocwY=;
 b=BzFKi/qIOc+kdnpZc61FxCUpR3hqyU9KfMKLoqvaNyAM5ev1tcVVXgbUxyDfoNGjHf
 IrB7K26Tm+LTG72ys5rmlZp+T2owWzwID7EFo9f0sJRkpjp+s/gIfQGlUO8nAxp6H1Zr
 O9P8Edz5iuSRSIiTAzZUtkVIhv940/fIw1Bj7uQwa8xhSmD3kFq2DOJx72D7NxCwKz2o
 ajsvKSZvybvN0lcKyF59ZLIljMcSxRzjMZmN3QwHPfNORKsY1T5otf/wUEE/YxNsgaaZ
 zeBfLGEWVu26aivF+SkWzS+aXbjb0VwFIvoRHi3g4DpSPR8HeLrW8K3vCxNctzhTxwx9
 q02g==
X-Gm-Message-State: AOJu0YyAhvKsifDcA8l4NQS57YEt6O3cDFk+nszgng43qEIxk9uQMrou
 XAcytATSwr+1U/68et2n6iuazP8BRGpo0Q==
X-Google-Smtp-Source: AGHT+IFGOjQQW68H+aWN+rzlOPDzc6NWHdtb1xQzifAtwvtaJSKaH5BpY5PDq6j3uKiBQC/uLo7Puw==
X-Received: by 2002:a17:902:6509:b0:1d4:94f6:56cb with SMTP id
 b9-20020a170902650900b001d494f656cbmr2547229plk.117.1705326911339; 
 Mon, 15 Jan 2024 05:55:11 -0800 (PST)
Received: from ?IPV6:2804:1b3:a7c2:2787:1d58:abc7:72ea:8c9c?
 ([2804:1b3:a7c2:2787:1d58:abc7:72ea:8c9c])
 by smtp.gmail.com with ESMTPSA id
 m3-20020a1709026bc300b001d4a49b30f4sm7577079plt.61.2024.01.15.05.55.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 05:55:10 -0800 (PST)
Message-ID: <da18db08-23e4-45de-91b6-6c49effdeeaa@linaro.org>
Date: Mon, 15 Jan 2024 10:55:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Szabolcs Nagy <szabolcs.nagy@arm.com>, Florian Weimer
 <fweimer@redhat.com>, gcc@gcc.gnu.org, libc-alpha@sourceware.org
Cc: Iain Sandoe <iain@sandoe.co.uk>, aburgess@redhat.com,
 lttng-dev@lists.lttng.org
References: <8734v1ieke.fsf@oldenburg.str.redhat.com>
 <ZaUpDRmDTt8/apMh@arm.com>
Organization: Linaro
In-Reply-To: <ZaUpDRmDTt8/apMh@arm.com>
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
From: Adhemerval Zanella Netto via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>



On 15/01/24 09:46, Szabolcs Nagy wrote:
> The 01/13/2024 13:49, Florian Weimer wrote:
>> This commit
>>
>> commit 8abddb187b33480d8827f44ec655f45734a1749d
>> Author: Andrew Burgess <andrew.burgess@embecosm.com>
>> Date:   Sat Aug 5 14:31:06 2023 +0200
>>
>>     libgcc: support heap-based trampolines
>>     
>>     Add support for heap-based trampolines on x86_64-linux, aarch64-linux,
>>     and x86_64-darwin. Implement the __builtin_nested_func_ptr_created and
>>     __builtin_nested_func_ptr_deleted functions for these targets.
>>     
>>     Co-Authored-By: Maxim Blinov <maxim.blinov@embecosm.com>
>>     Co-Authored-By: Iain Sandoe <iain@sandoe.co.uk>
>>     Co-Authored-By: Francois-Xavier Coudert <fxcoudert@gcc.gnu.org>
>>
>> added TLS usage to libgcc_s.so.1.  The way that libgcc_s is currently
>> built, it ends up using a dynamic TLS variant on the Linux targets.
>> This means that there is no up-front TLS allocation with glibc (but
>> there would be one with musl).
>>
>> There is still a compatibility impact because glibc assigns a TLS module
>> ID upfront.  This seems to be what causes the
>> ust/libc-wrapper/test_libc-wrapper test in lttng-tools to fail.  We end
>> up with an infinite regress during process termination because
>> libgcc_s.so.1 has been loaded, resulting in a DTV update.  When this
>> happens, the bottom of the stack looks like this:
>>
>> #4447 0x00007ffff7f288f0 in free () from /lib64/liblttng-ust-libc-wrapper.so.1
>> #4448 0x00007ffff7fdb142 in free (ptr=<optimized out>)
>>     at ../include/rtld-malloc.h:50
>> #4449 _dl_update_slotinfo (req_modid=3, new_gen=2) at ../elf/dl-tls.c:822
>> #4450 0x00007ffff7fdb214 in update_get_addr (ti=0x7ffff7f2bfc0, 
>>     gen=<optimized out>) at ../elf/dl-tls.c:916
>> #4451 0x00007ffff7fddccc in __tls_get_addr ()
>>     at ../sysdeps/x86_64/tls_get_addr.S:55
>> #4452 0x00007ffff7f288f0 in free () from /lib64/liblttng-ust-libc-wrapper.so.1
>> #4453 0x00007ffff7fdb142 in free (ptr=<optimized out>)
>>     at ../include/rtld-malloc.h:50
>> #4454 _dl_update_slotinfo (req_modid=2, new_gen=2) at ../elf/dl-tls.c:822
>> #4455 0x00007ffff7fdb214 in update_get_addr (ti=0x7ffff7f39fa0, 
>>     gen=<optimized out>) at ../elf/dl-tls.c:916
>> #4456 0x00007ffff7fddccc in __tls_get_addr ()
>>     at ../sysdeps/x86_64/tls_get_addr.S:55
>> #4457 0x00007ffff7f36113 in lttng_ust_cancelstate_disable_push ()
>>    from /lib64/liblttng-ust-common.so.1
>> #4458 0x00007ffff7f4c2e8 in ust_lock_nocheck () from /lib64/liblttng-ust.so.1
>> #4459 0x00007ffff7f5175a in lttng_ust_cleanup () from /lib64/liblttng-ust.so.1
>> #4460 0x00007ffff7fca0f2 in _dl_call_fini (
>>     closure_map=closure_map@entry=0x7ffff7fbe000) at dl-call_fini.c:43
>> #4461 0x00007ffff7fce06e in _dl_fini () at dl-fini.c:114
>> #4462 0x00007ffff7d82fe6 in __run_exit_handlers () from /lib64/libc.so.6
>>
>> Cc:ing <lttng-dev@lists.lttng.org> for awareness.
>>
>> The issue also requires a recent glibc with changes to DTV management:
>> commit d2123d68275acc0f061e73d5f86ca504e0d5a344 ("elf: Fix slow tls
>> access after dlopen [BZ #19924]").  If I understand things correctly,
>> before this glibc change, we didn't deallocate the old DTV, so there was
>> no call to the free function.
> 
> with 19924 fixed, after a dlopen or dlclose every thread updates
> its dtv on the next dynamic tls access.
> 
> before that, dtv was only updated up to the generation of the
> module being accessed for a particular tls access.
> 
> so hitting the free in the dtv update path is now more likely
> but the free is not new, it was there before.
> 
> also note that this is unlikely to happen on aarch64 since
> tlsdesc only does dynamic tls access after a 512byte static
> tls reservation runs out.
> 
>>
>> On the glibc side, we should recommend that intercepting mallocs and its
>> dependencies use initial-exec TLS because that kind of TLS does not use
>> malloc.  If intercepting mallocs using dynamic TLS work at all, that's
>> totally by accident, and was in the past helped by glibc bug 19924.  (I
> 
> right.
> 
>> don't think there is anything special about libgcc_s.so.1 that triggers
>> the test failure above, it is just an object with dynamic TLS that is
>> implicitly loaded via dlopen at the right stage of the test.)  In this
>> particular case, we can also paper over the test failure in glibc by not
>> call free at all because the argument is a null pointer:
>>
>> diff --git a/elf/dl-tls.c b/elf/dl-tls.c
>> index 7b3dd9ab60..14c71cbd06 100644
>> --- a/elf/dl-tls.c
>> +++ b/elf/dl-tls.c
>> @@ -819,7 +819,8 @@ _dl_update_slotinfo (unsigned long int req_modid, size_t new_gen)
>>  		 dtv entry free it.  Note: this is not AS-safe.  */
>>  	      /* XXX Ideally we will at some point create a memory
>>  		 pool.  */
>> -	      free (dtv[modid].pointer.to_free);
>> +	      if (dtv[modid].pointer.to_free != NULL)
>> +		free (dtv[modid].pointer.to_free);
>>  	      dtv[modid].pointer.val = TLS_DTV_UNALLOCATED;
>>  	      dtv[modid].pointer.to_free = NULL;
> 
> can be done, but !=NULL is more likely since we do modid reuse
> after dlclose.
> 
> there is also a realloc in dtv resizing which happens when more
> than 16 modules with tls are loaded after thread creation
> (DTV_SURPLUS).
> 
> i'm not sure if it's worth supporting malloc interposers that
> only work sometimes.
> 

Maybe one option would to try reinstate the async-signal-safe TLS
code to avoid malloc/free in dynamic TLS altogether.  We revert it on
2.14 release cause it broke ASAN/LSAN [1], but I think we might try 
to reinstate on 2.40 and work with sanitizer project to get this sort 
out.

[1] https://sourceware.org/pipermail/libc-alpha/2014-January/047931.html
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
