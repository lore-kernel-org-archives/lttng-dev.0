Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93782C4707B
	for <lttng-dev@archiver.kernel.org>; Mon, 15 Jan 2024 14:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1705330053;
	bh=VnPXfxryza04ZM/UXb4OurybWwb1sIHqgRb45M3keiM=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=MOYz+gzAG0sKWERrvA0JJa3pCtgBdLpwd/omID75uMlOSRyHf0Y8mHH/xd8a48kRj
	 QwPz2jWA8RlZGZGLPkz1Xiwho17WHPpUFYwQs75qk7+AZgvhvxvbiLgmAM9kELym9V
	 x6GA/F5GrG4a718lLjZn+r7nHcFTp5fuCkMW6k1f+Zze/VPqr97GyYoWSpPs5hmcJc
	 idoUlCJR1cTYup81bZ8WAvlps00SsHQohlYOro5EoPiQYjvtzEhbuAy+AfdW/E3wHI
	 Wrlmwf4B3hOLRDNnSliDappTJuySD2M5TWKZTQjrZoM2SL1ckRzh9GOrkzDQ5kFs8j
	 4MMBKCo+Np7yA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TDFNj1Fjzz1NTV;
	Mon, 15 Jan 2024 09:47:33 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4TDFNf6Nmlz1NTS
 for <lttng-dev@lists.lttng.org>; Mon, 15 Jan 2024 09:47:30 -0500 (EST)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-O8XbokHNMO6Vcc4_nyWeeA-1; Mon, 15 Jan 2024 09:47:28 -0500
X-MC-Unique: O8XbokHNMO6Vcc4_nyWeeA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-429ca123301so54959351cf.1
 for <lttng-dev@lists.lttng.org>; Mon, 15 Jan 2024 06:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705330048; x=1705934848;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Ya9lXLo4h44JSDIJLdFmt580+9pxuH9EI1M7cn3P7U=;
 b=cvk7+hopF5LOrwsEMhJ1mSeg3zNmv8TtJNcob+fcrIGi0zo6M3IEuzRd4CXUBST657
 T0QR+ob2tOxo2zwft4u3mUJK9TigJCrBU9gzCwJRrfV6wvrzbdKnS/VUTkujCKhuhmHU
 6+hvdH+NVLhKBHqKJ0jWjEIgngvFrZr02QO1N487liEn+1MmI7SEnd3BuaZn4sGpZPMM
 ObKV4tIQenqQUifaiQ8XF6dUvRzeX6zgspPFND7fS9c2XEqtfjf/hABhy7QSazmYUrAI
 bw7Joh2P6Xs878w2c8uI79ad+zHRTo/Kf9FiZtmIaC5TYv9/CRfXRvuHhcpZMsnyXNGF
 3XYw==
X-Gm-Message-State: AOJu0Yy1k3x2Ef75b7H3uPnLYUbTHuW5NoxJIIPubhW3Hy6OYWpQ7ybq
 puvrs2X6utBx7nBV69qt+S3SVhPVPoi7xlm8PX5O+5tIWRuyjOZlfA9m4iGtwqE98Q8j2MU6eDl
 9A/whG7IFzUXofAHrmMRwqQ4A56tM
X-Received: by 2002:a05:622a:208:b0:429:74cd:6c1d with SMTP id
 b8-20020a05622a020800b0042974cd6c1dmr7235334qtx.62.1705330048134; 
 Mon, 15 Jan 2024 06:47:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGavBCTG2VqrcyvMFGqI6U9WNk2anHnAs5y9RqtvpsVrd8bnVSP81YtlUs8LRBBptpOC5ZaOA==
X-Received: by 2002:a05:622a:208:b0:429:74cd:6c1d with SMTP id
 b8-20020a05622a020800b0042974cd6c1dmr7235326qtx.62.1705330047854; 
 Mon, 15 Jan 2024 06:47:27 -0800 (PST)
Received: from [192.168.0.241] ([198.48.244.52])
 by smtp.gmail.com with ESMTPSA id
 gc9-20020a05622a59c900b004181138e0c0sm3988448qtb.31.2024.01.15.06.47.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 06:47:27 -0800 (PST)
Message-ID: <81279c5d-0b60-0e37-abe9-0936688b14fa@redhat.com>
Date: Mon, 15 Jan 2024 09:47:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Szabolcs Nagy <szabolcs.nagy@arm.com>, Florian Weimer <fweimer@redhat.com>,
 gcc@gcc.gnu.org, libc-alpha@sourceware.org
Cc: Iain Sandoe <iain@sandoe.co.uk>, aburgess@redhat.com,
 lttng-dev@lists.lttng.org
References: <8734v1ieke.fsf@oldenburg.str.redhat.com>
 <ZaUpDRmDTt8/apMh@arm.com> <da18db08-23e4-45de-91b6-6c49effdeeaa@linaro.org>
Organization: Red Hat
In-Reply-To: <da18db08-23e4-45de-91b6-6c49effdeeaa@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
From: Carlos O'Donell via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Carlos O'Donell <carlos@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 1/15/24 08:55, Adhemerval Zanella Netto wrote:
> 
> 
> On 15/01/24 09:46, Szabolcs Nagy wrote:
>> The 01/13/2024 13:49, Florian Weimer wrote:
>>> This commit
>>>
>>> commit 8abddb187b33480d8827f44ec655f45734a1749d
>>> Author: Andrew Burgess <andrew.burgess@embecosm.com>
>>> Date:   Sat Aug 5 14:31:06 2023 +0200
>>>
>>>     libgcc: support heap-based trampolines
>>>     
>>>     Add support for heap-based trampolines on x86_64-linux, aarch64-linux,
>>>     and x86_64-darwin. Implement the __builtin_nested_func_ptr_created and
>>>     __builtin_nested_func_ptr_deleted functions for these targets.
>>>     
>>>     Co-Authored-By: Maxim Blinov <maxim.blinov@embecosm.com>
>>>     Co-Authored-By: Iain Sandoe <iain@sandoe.co.uk>
>>>     Co-Authored-By: Francois-Xavier Coudert <fxcoudert@gcc.gnu.org>
>>>
>>> added TLS usage to libgcc_s.so.1.  The way that libgcc_s is currently
>>> built, it ends up using a dynamic TLS variant on the Linux targets.
>>> This means that there is no up-front TLS allocation with glibc (but
>>> there would be one with musl).
>>>
>>> There is still a compatibility impact because glibc assigns a TLS module
>>> ID upfront.  This seems to be what causes the
>>> ust/libc-wrapper/test_libc-wrapper test in lttng-tools to fail.  We end
>>> up with an infinite regress during process termination because
>>> libgcc_s.so.1 has been loaded, resulting in a DTV update.  When this
>>> happens, the bottom of the stack looks like this:
>>>
>>> #4447 0x00007ffff7f288f0 in free () from /lib64/liblttng-ust-libc-wrapper.so.1
>>> #4448 0x00007ffff7fdb142 in free (ptr=<optimized out>)
>>>     at ../include/rtld-malloc.h:50
>>> #4449 _dl_update_slotinfo (req_modid=3, new_gen=2) at ../elf/dl-tls.c:822
>>> #4450 0x00007ffff7fdb214 in update_get_addr (ti=0x7ffff7f2bfc0, 
>>>     gen=<optimized out>) at ../elf/dl-tls.c:916
>>> #4451 0x00007ffff7fddccc in __tls_get_addr ()
>>>     at ../sysdeps/x86_64/tls_get_addr.S:55
>>> #4452 0x00007ffff7f288f0 in free () from /lib64/liblttng-ust-libc-wrapper.so.1
>>> #4453 0x00007ffff7fdb142 in free (ptr=<optimized out>)
>>>     at ../include/rtld-malloc.h:50
>>> #4454 _dl_update_slotinfo (req_modid=2, new_gen=2) at ../elf/dl-tls.c:822
>>> #4455 0x00007ffff7fdb214 in update_get_addr (ti=0x7ffff7f39fa0, 
>>>     gen=<optimized out>) at ../elf/dl-tls.c:916
>>> #4456 0x00007ffff7fddccc in __tls_get_addr ()
>>>     at ../sysdeps/x86_64/tls_get_addr.S:55
>>> #4457 0x00007ffff7f36113 in lttng_ust_cancelstate_disable_push ()
>>>    from /lib64/liblttng-ust-common.so.1
>>> #4458 0x00007ffff7f4c2e8 in ust_lock_nocheck () from /lib64/liblttng-ust.so.1
>>> #4459 0x00007ffff7f5175a in lttng_ust_cleanup () from /lib64/liblttng-ust.so.1
>>> #4460 0x00007ffff7fca0f2 in _dl_call_fini (
>>>     closure_map=closure_map@entry=0x7ffff7fbe000) at dl-call_fini.c:43
>>> #4461 0x00007ffff7fce06e in _dl_fini () at dl-fini.c:114
>>> #4462 0x00007ffff7d82fe6 in __run_exit_handlers () from /lib64/libc.so.6
>>>
>>> Cc:ing <lttng-dev@lists.lttng.org> for awareness.
>>>
>>> The issue also requires a recent glibc with changes to DTV management:
>>> commit d2123d68275acc0f061e73d5f86ca504e0d5a344 ("elf: Fix slow tls
>>> access after dlopen [BZ #19924]").  If I understand things correctly,
>>> before this glibc change, we didn't deallocate the old DTV, so there was
>>> no call to the free function.
>>
>> with 19924 fixed, after a dlopen or dlclose every thread updates
>> its dtv on the next dynamic tls access.
>>
>> before that, dtv was only updated up to the generation of the
>> module being accessed for a particular tls access.
>>
>> so hitting the free in the dtv update path is now more likely
>> but the free is not new, it was there before.
>>
>> also note that this is unlikely to happen on aarch64 since
>> tlsdesc only does dynamic tls access after a 512byte static
>> tls reservation runs out.
>>
>>>
>>> On the glibc side, we should recommend that intercepting mallocs and its
>>> dependencies use initial-exec TLS because that kind of TLS does not use
>>> malloc.  If intercepting mallocs using dynamic TLS work at all, that's
>>> totally by accident, and was in the past helped by glibc bug 19924.  (I
>>
>> right.
>>
>>> don't think there is anything special about libgcc_s.so.1 that triggers
>>> the test failure above, it is just an object with dynamic TLS that is
>>> implicitly loaded via dlopen at the right stage of the test.)  In this
>>> particular case, we can also paper over the test failure in glibc by not
>>> call free at all because the argument is a null pointer:
>>>
>>> diff --git a/elf/dl-tls.c b/elf/dl-tls.c
>>> index 7b3dd9ab60..14c71cbd06 100644
>>> --- a/elf/dl-tls.c
>>> +++ b/elf/dl-tls.c
>>> @@ -819,7 +819,8 @@ _dl_update_slotinfo (unsigned long int req_modid, size_t new_gen)
>>>  		 dtv entry free it.  Note: this is not AS-safe.  */
>>>  	      /* XXX Ideally we will at some point create a memory
>>>  		 pool.  */
>>> -	      free (dtv[modid].pointer.to_free);
>>> +	      if (dtv[modid].pointer.to_free != NULL)
>>> +		free (dtv[modid].pointer.to_free);
>>>  	      dtv[modid].pointer.val = TLS_DTV_UNALLOCATED;
>>>  	      dtv[modid].pointer.to_free = NULL;
>>
>> can be done, but !=NULL is more likely since we do modid reuse
>> after dlclose.
>>
>> there is also a realloc in dtv resizing which happens when more
>> than 16 modules with tls are loaded after thread creation
>> (DTV_SURPLUS).
>>
>> i'm not sure if it's worth supporting malloc interposers that
>> only work sometimes.
>>
> 
> Maybe one option would to try reinstate the async-signal-safe TLS
> code to avoid malloc/free in dynamic TLS altogether.  We revert it on
> 2.14 release cause it broke ASAN/LSAN [1], but I think we might try 
> to reinstate on 2.40 and work with sanitizer project to get this sort 
> out.

I agree. TLS should be seen more like .bss/.data rather than something that is allocated
with malloc().

If we leak memory via TLS that is a glibc bug that we can deal with, but making it easier
to find glibc bugs is also a  benefit to the community, but not as valuable a benefit as
making TLS correctly async-signal safe.

Likewise we need to discuss when the memory is allocated, regardless of which allocator is
used, including allocation up-front at dlopen() time. 
> [1] https://sourceware.org/pipermail/libc-alpha/2014-January/047931.html
> 

-- 
Cheers,
Carlos.

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
