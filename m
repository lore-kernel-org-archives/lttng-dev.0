Return-Path: <SRS0=ew+5=7S=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC476C433DF
	for <lttng-dev@archiver.kernel.org>; Fri,  5 Jun 2020 16:09:19 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC31206DB
	for <lttng-dev@archiver.kernel.org>; Fri,  5 Jun 2020 16:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="h03hVngI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC31206DB
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49dndn0JHCz1N6M;
	Fri,  5 Jun 2020 12:09:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1591373358;
	bh=EfxjTa2dwhTLVj1sfiVY1Hh/cC/n0VXjE8o+dbynB5I=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=h03hVngI1IfDL5vlD9CdkdfKZbX957sz2pSh6xWzvO5AJuCzJplaOnuj9CAGkUWsL
	 /pgYhqmcMXW6IZtBAwjNCoxtr2fhk/YpY1NNHISfS7TG5YgI7ukfmWPCMsrRgSpsNd
	 aPdsSjv+rwbg7Q8pNZj7gmBdDQ44tQlkH09uZs3iYJSwK8OsXD4bhZrWlEZr2+djHm
	 4mFSYJsZVki+udfSUaYdIuFybw2LxVNDWD3o9J6hAS36HjBYBWqHXElFrvZKdtr5cK
	 41RVo36cNsBd2KimKsWi55snoe5Owt3e5AjiAPrabSoehSZtLguPr2dZKP4QGqNsiO
	 Qhjs89yXWwmMg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49dndl0Jchz1MgV
 for <lttng-dev@lists.lttng.org>; Fri,  5 Jun 2020 12:09:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 743AE2CF203
 for <lttng-dev@lists.lttng.org>; Fri,  5 Jun 2020 12:09:08 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ZFB2KO0e_Kw2; Fri,  5 Jun 2020 12:09:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 258CD2CEE76;
 Fri,  5 Jun 2020 12:09:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 258CD2CEE76
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id CwxzPOo308cd; Fri,  5 Jun 2020 12:09:08 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 1C5B12CEFD9;
 Fri,  5 Jun 2020 12:09:08 -0400 (EDT)
Date: Fri, 5 Jun 2020 12:09:08 -0400 (EDT)
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <168357390.56518.1591373348015.JavaMail.zimbra@efficios.com>
In-Reply-To: <5352eebd-dbb7-70f9-a354-91522170efdf@yandex.ru>
References: <5352eebd-dbb7-70f9-a354-91522170efdf@yandex.ru>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: Userspace RCU data alignment
Thread-Index: f2gUCnwYSZEC5AZDxG3Vv1pAUcr4LQ==
Subject: Re: [lttng-dev] Userspace RCU data alignment
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200605160908.SiID8Q859QAiVLCdF_5bEZmgxFvXCBieLwYgO1HmZcQ@z>

----- On Jun 3, 2020, at 8:36 AM, lttng-dev lttng-dev@lists.lttng.org wrote:

> I've compiled userspace-rcu with:
> 
> CC=gcc CFLAGS='-O0 -g3 -fsanitize=undefined' LIBS='-lubsan' ./configure [xxx]
> 
> and see a lot of 'misaligned address' runtime errors like:
> 
>  ./doc/examples/urcu-flavors/bp ==>
> 
> ../include/urcu/static/urcu-bp.h:185:6: runtime error: member access within
> misaligned address 0x7fcac376a020 for type 'struct urcu_bp_reader', which
> requires 128 byte alignment
> 0x7fcac376a020: note: pointer points here
>  ca 7f 00 00  01 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00
>  00 00  00 00 00 00
>               ^
>     #0 0x7fcac372a880 in _urcu_bp_read_unlock ../include/urcu/static/urcu-bp.h:185
>     #1 0x7fcac372b0d9 in urcu_bp_read_unlock
>     /home/antipov/userspace-rcu/src/urcu-bp.c:363
>     #2 0x4017d5 in main
>     /home/antipov/userspace-rcu/doc/examples/urcu-flavors/bp.c:92
>     #3 0x7fcac2bc2041 in __libc_start_main ../csu/libc-start.c:308
>     #4 0x40111d in _start
>     (/home/antipov/userspace-rcu/doc/examples/urcu-flavors/bp+0x40111d)
> 
> ../include/urcu/static/urcu-bp.h:189:2: runtime error: member access within
> misaligned address 0x7fcac376a020 for type 'struct urcu_bp_reader', which
> requires 128 byte alignment
> 0x7fcac376a020: note: pointer points here
>  ca 7f 00 00  01 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00
>  00 00  00 00 00 00
>               ^
>     #0 0x7fcac372a8c1 in _urcu_bp_read_unlock ../include/urcu/static/urcu-bp.h:189
>     #1 0x7fcac372b0d9 in urcu_bp_read_unlock
>     /home/antipov/userspace-rcu/src/urcu-bp.c:363
>     #2 0x4017d5 in main
>     /home/antipov/userspace-rcu/doc/examples/urcu-flavors/bp.c:92
>     #3 0x7fcac2bc2041 in __libc_start_main ../csu/libc-start.c:308
>     #4 0x40111d in _start
>     (/home/antipov/userspace-rcu/doc/examples/urcu-flavors/bp+0x40111d)
> 
> Is it critical for correctness, or speed, or whatever else?

As I remember this is mainly for speed, so it's not a show-stopper.

> To whom it may be interesting, some of (probably not all) alignment issues may
> be fixed
> with attached patch.

I agree on fixing this, but I recommend a different approach:

Change:

struct registry_chunk {
        size_t data_len;                /* data length */
        size_t used;                    /* amount of data used */
        struct cds_list_head node;      /* chunk_list node */
        char data[];
};

for:

struct registry_chunk {
        size_t nr_readers;              /* number of readers */
        size_t used;                    /* amount of data used */
        struct cds_list_head node;      /* chunk_list node */
        struct urcu_bp_reader readers[];
};

And adapt all the readers allocation scheme within urcu-bp to work on
"readers" elements rather than bytes.

By doing so, struct registry_chunk will adapt to have the proper alignment.

Thanks,

Mathieu

> 
> Dmitry
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
