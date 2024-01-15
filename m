Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39720C3DA79
	for <lttng-dev@archiver.kernel.org>; Mon, 15 Jan 2024 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1705332945;
	bh=IAUMLoVBDjI/J30yzPkRZjUCFkVwo0aFTnNt3QIoPRM=;
	h=To:Cc:References:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=imD7wnHk3e9sGFPdb7adpZ46y7gZg59MqMhWOb5lnNvYPKZdHhiiz/OpyPZzRA8VF
	 XphnEC0NqJMCi3mSFRL0lhlDWvKPch75P+40xYrmKsacjT5x+2DAt6so8bQPggygUl
	 KCYzmbpYL9NOXdP180DJXVIBbH5PDhtf3XpRDTQNs7E0kNluqR4srNex6wSBdEuhGn
	 fu7KieOkXykWxnYXuvWO1bBfkrXCc7l9BwTLXpljDXgXMZXHMJdTHGQsdhmjJrOqdP
	 3Z/fezQJiElLsO2mHccDAFagoWI7jcc3+kyk6AZfewMJQyI7yR/ObH01Rw/bIY7JQs
	 dyChX8vbjWNuw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TDGSJ5ZG5z1PLs;
	Mon, 15 Jan 2024 10:35:44 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4TDGSH6HkSz1PQX
 for <lttng-dev@lists.lttng.org>; Mon, 15 Jan 2024 10:35:43 -0500 (EST)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-v76JVHYNOlaqJUcJsX8siw-1; Mon, 15 Jan 2024 10:35:38 -0500
X-MC-Unique: v76JVHYNOlaqJUcJsX8siw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 782A188F561;
 Mon, 15 Jan 2024 15:35:38 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FAE6492BC6;
 Mon, 15 Jan 2024 15:35:36 +0000 (UTC)
To: Carlos O'Donell <carlos@redhat.com>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,  Szabolcs Nagy
 <szabolcs.nagy@arm.com>,  gcc@gcc.gnu.org,  libc-alpha@sourceware.org,
 Iain Sandoe <iain@sandoe.co.uk>,  aburgess@redhat.com,
 lttng-dev@lists.lttng.org
References: <8734v1ieke.fsf@oldenburg.str.redhat.com>
 <ZaUpDRmDTt8/apMh@arm.com>
 <da18db08-23e4-45de-91b6-6c49effdeeaa@linaro.org>
 <81279c5d-0b60-0e37-abe9-0936688b14fa@redhat.com>
Date: Mon, 15 Jan 2024 16:35:34 +0100
In-Reply-To: <81279c5d-0b60-0e37-abe9-0936688b14fa@redhat.com> (Carlos
 O'Donell's message of "Mon, 15 Jan 2024 09:47:26 -0500")
Message-ID: <87jzoa6249.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

* Carlos O'Donell:

> I agree. TLS should be seen more like .bss/.data rather than something
> that is allocated with malloc().

There wasn't consensus regarding this in 2014.  See below.

> If we leak memory via TLS that is a glibc bug that we can deal with,

This is something that libgcc_s.so.1 does in GCC 14 if the heap
trampolines are used.

> but making it easier to find glibc bugs is also a benefit to the
> community, but not as valuable a benefit as making TLS correctly
> async-signal safe.
>
> Likewise we need to discuss when the memory is allocated, regardless
> of which allocator is used, including allocation up-front at dlopen()
> time.
>> [1] https://sourceware.org/pipermail/libc-alpha/2014-January/047931.html

The change conflated multiple issues: sanitizer support,
async-signal-safe TLS access, and eager allocation of all TLS-related
memory, so that subsequent accesses cannot fail.  My impression was the
main point of contention was eager allocation because it was perceived
as a breaking semantic change.  Nowadays, as long as we are willing to
maintain both allocator variants, we could offer a choice between them
controlled by a tunable.  For sanitizer compatibility, we could perform
eager allocation using malloc.  It's probably a good idea to do it this
way anyway because a separate mmap-based allocator would increase TLB
pressure.

Thanks,
Florian

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
