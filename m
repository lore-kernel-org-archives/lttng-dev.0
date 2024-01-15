Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD19C47258
	for <lttng-dev@archiver.kernel.org>; Mon, 15 Jan 2024 16:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1705337170;
	bh=U/Pi2BOM5+QXLI6iDIjZH1dh/tWebbfX6T0YOdnLYKY=;
	h=To:Cc:References:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=uQloATwE90/7hQXNSYoGOaslAHfsGkvr3bbCnZAIWjL0oXMBF3tvUBS0en2r0diJX
	 x0iTzWJ8HcVDY0fe9+fLgN+uis1Bb2XSAquzW99GEz2pWWbUz6nKpV0Z1gunJZyQnK
	 fI8pjosxX7nIwi6yxZwzXDLZAqyYfho8J3OIE81eiwDgKVkXbhaa/kF/FxKv0elzfC
	 aATR3r1utzbFJ8atdvcWuRLiSgLLjf9TrHrePrNx5sJYJ2Y8KcfDZAaH739QwH7SFM
	 VceBkp9R2IoECR9yP4mPBC8eJvIlfpyzm3J/CYNMAfBn6LWUq6LAIFJJU8/tCKkHrF
	 Hauss5zs3kk0A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TDJ1Y6pJqz1PY9;
	Mon, 15 Jan 2024 11:46:09 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4TDJ1W5wLdz1PTK
 for <lttng-dev@lists.lttng.org>; Mon, 15 Jan 2024 11:46:07 -0500 (EST)
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-iqpS22TgOUSYKoZd98J9GQ-1; Mon,
 15 Jan 2024 11:44:48 -0500
X-MC-Unique: iqpS22TgOUSYKoZd98J9GQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F9AC3C0C117;
 Mon, 15 Jan 2024 16:44:48 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7CFE492BC6;
 Mon, 15 Jan 2024 16:44:46 +0000 (UTC)
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: Carlos O'Donell <carlos@redhat.com>,  Adhemerval Zanella Netto
 <adhemerval.zanella@linaro.org>,  Szabolcs Nagy <szabolcs.nagy@arm.com>,
 GCC Development <gcc@gcc.gnu.org>,  libc-alpha@sourceware.org,
 aburgess@redhat.com,  lttng-dev@lists.lttng.org
References: <8734v1ieke.fsf@oldenburg.str.redhat.com>
 <ZaUpDRmDTt8/apMh@arm.com>
 <da18db08-23e4-45de-91b6-6c49effdeeaa@linaro.org>
 <81279c5d-0b60-0e37-abe9-0936688b14fa@redhat.com>
 <87jzoa6249.fsf@oldenburg.str.redhat.com>
 <4F19001F-1F46-49EC-8A69-11F7CF5017B2@sandoe.co.uk>
Date: Mon, 15 Jan 2024 17:44:45 +0100
In-Reply-To: <4F19001F-1F46-49EC-8A69-11F7CF5017B2@sandoe.co.uk> (Iain
 Sandoe's message of "Mon, 15 Jan 2024 15:38:06 +0000")
Message-ID: <87bk9m5ywy.fsf@oldenburg.str.redhat.com>
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

* Iain Sandoe:

>> On 15 Jan 2024, at 15:35, Florian Weimer <fweimer@redhat.com> wrote:
>> 
>> * Carlos O'Donell:
>> 
>>> I agree. TLS should be seen more like .bss/.data rather than something
>>> that is allocated with malloc().
>> 
>> There wasn't consensus regarding this in 2014.  See below.
>> 
>>> If we leak memory via TLS that is a glibc bug that we can deal with,
>> 
>> This is something that libgcc_s.so.1 does in GCC 14 if the heap
>> trampolines are used.
>
> Is there a GCC BZ for this?
> (if there is something we should address in GCC, it would be better sooner)

Sorry, I wanted to write a reproducer first.  With it, I found two more
issue.

  Memory (resource) leak in -ftrampoline-impl=heap
  <https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113401>

  Incorrect symbol versions for __builtin_nested_func_ptr_created,
  __builtin_nested_func_ptr in libgcc_s.so.1
  <https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113402>

  __builtin_nested_func_ptr_created, __builtin_nested_func_ptr should be
  dynamically linked by default
  <https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113403>

Thanks,
Florian

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
