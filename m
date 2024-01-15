Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3CBC3DA79
	for <lttng-dev@archiver.kernel.org>; Mon, 15 Jan 2024 15:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1705333905;
	bh=5WbkhOCDt6hsNecTC59WXsZ8YxH35J8EU0RhOokakG0=;
	h=In-Reply-To:Date:Cc:References:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=GB0qmng8C7GcPCxEFEgvKGjkZNmvN4UvHVeuv9f9mWZeDFi9Cf6gigek4xjTHOb1b
	 9lPqM6TQJ+BZ+hu6H8ciI4+bw82zJm/n65Gvy/HmCthErVOuVAQemWT34xQSFx67j6
	 5xmcveIH6J4+6cqNu2dFrxGktHz8cc137kMe0vIrVtx34bnS24JM8VjqNviZhd3F+N
	 Onfrn7EgyXGIqWuMEIWU9LsJI+E+wf2enmbxdVkYHc2z4S5X0ZFa97sB/lPdGoW6+z
	 FmeD3TmR/kacoEcQqOfAZnaq7FOMKDKV5aNjvfoZeTP8oNxtdYDnflzxuYp+2PlPOD
	 ubU+yPCi/onng==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TDGpn3vWbz1P45;
	Mon, 15 Jan 2024 10:51:45 -0500 (EST)
Received: from smtp001-out.apm-internet.net (smtp001-out.apm-internet.net
 [85.119.248.222])
 by lists.lttng.org (Postfix) with ESMTPS id 4TDGW46jhrz1PZ3
 for <lttng-dev@lists.lttng.org>; Mon, 15 Jan 2024 10:38:08 -0500 (EST)
Received: (qmail 93612 invoked from network); 15 Jan 2024 15:38:06 -0000
X-APM-Out-ID: 17053330869361
X-APM-Authkey: 257869/1(257869/1) 10
Received: from unknown (HELO smtpclient.apple) (81.138.1.83)
 by smtp001.apm-internet.net with SMTP; 15 Jan 2024 15:38:06 -0000
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
In-Reply-To: <87jzoa6249.fsf@oldenburg.str.redhat.com>
Date: Mon, 15 Jan 2024 15:38:06 +0000
Cc: Carlos O'Donell <carlos@redhat.com>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Szabolcs Nagy <szabolcs.nagy@arm.com>, GCC Development <gcc@gcc.gnu.org>,
 libc-alpha@sourceware.org, aburgess@redhat.com, lttng-dev@lists.lttng.org
Message-Id: <4F19001F-1F46-49EC-8A69-11F7CF5017B2@sandoe.co.uk>
References: <8734v1ieke.fsf@oldenburg.str.redhat.com>
 <ZaUpDRmDTt8/apMh@arm.com> <da18db08-23e4-45de-91b6-6c49effdeeaa@linaro.org>
 <81279c5d-0b60-0e37-abe9-0936688b14fa@redhat.com>
 <87jzoa6249.fsf@oldenburg.str.redhat.com>
To: Florian Weimer <fweimer@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-Mailman-Approved-At: Mon, 15 Jan 2024 10:51:39 -0500
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
From: Iain Sandoe via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Iain Sandoe <iain@sandoe.co.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>



> On 15 Jan 2024, at 15:35, Florian Weimer <fweimer@redhat.com> wrote:
> 
> * Carlos O'Donell:
> 
>> I agree. TLS should be seen more like .bss/.data rather than something
>> that is allocated with malloc().
> 
> There wasn't consensus regarding this in 2014.  See below.
> 
>> If we leak memory via TLS that is a glibc bug that we can deal with,
> 
> This is something that libgcc_s.so.1 does in GCC 14 if the heap
> trampolines are used.

Is there a GCC BZ for this?
(if there is something we should address in GCC, it would be better sooner)

Iain


>> but making it easier to find glibc bugs is also a benefit to the
>> community, but not as valuable a benefit as making TLS correctly
>> async-signal safe.
>> 
>> Likewise we need to discuss when the memory is allocated, regardless
>> of which allocator is used, including allocation up-front at dlopen()
>> time.
>>> [1] https://sourceware.org/pipermail/libc-alpha/2014-January/047931.html
> 
> The change conflated multiple issues: sanitizer support,
> async-signal-safe TLS access, and eager allocation of all TLS-related
> memory, so that subsequent accesses cannot fail.  My impression was the
> main point of contention was eager allocation because it was perceived
> as a breaking semantic change.  Nowadays, as long as we are willing to
> maintain both allocator variants, we could offer a choice between them
> controlled by a tunable.  For sanitizer compatibility, we could perform
> eager allocation using malloc.  It's probably a good idea to do it this
> way anyway because a separate mmap-based allocator would increase TLB
> pressure.
> 
> Thanks,
> Florian
> 

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
