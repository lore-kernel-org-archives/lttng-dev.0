Return-Path: <SRS0=ctY1=KA=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26D1C433ED
	for <lttng-dev@archiver.kernel.org>; Wed,  5 May 2021 13:46:17 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A4E613BA
	for <lttng-dev@archiver.kernel.org>; Wed,  5 May 2021 13:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A4E613BA
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FZyfb12HHz1hfk;
	Wed,  5 May 2021 09:46:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1620222375;
	bh=ZhCrDaEgNV2ZZHRzK627L4Asi4xRE7x8zAfHgT5Ay7c=;
	h=To:References:Date:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=HbCtBagNg9V7Uv42PIrSsw+SD9Peiw6zfEraC2t3x12Z3Fh++7nyHVPF2IXDVFa4V
	 snOyATR7JJG7QFzir0gM4bR9BYtfcZcLdhqoMKAVqkiiyDRwM8rzvqncdLBxX/wGIO
	 4Gflh9zKvgkKEsQhweOV0E1v2k5v9sVEAvT2hmJQiQipQKuU4UsAC5sBqoUqIQi+yN
	 wlQEWKXJFfEt1Ac2ClvdgGrmfik8gIdbOF0MtoIutlCBmamsyrdWtgoiZGsmOHJLks
	 XJmJpG6laXzqwpOSLbBU3Fyu3lk9od10wKZMOjxQceO4cYq5r3qehoIsXlDd+CVkuN
	 ES1F1d2BYTSQQ==
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by lists.lttng.org (Postfix) with ESMTPS id 4FZyfY3F77z1hhf
 for <lttng-dev@lists.lttng.org>; Wed,  5 May 2021 09:46:13 -0400 (EDT)
Received: from simark.ca (simark.ca [158.69.221.121]) (authenticated bits=0)
 by smtp.polymtl.ca (8.14.7/8.14.7) with ESMTP id 145Djx3f006889
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT); 
 Wed, 5 May 2021 09:46:04 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.polymtl.ca 145Djx3f006889
Received: from [10.0.0.11] (192-222-157-6.qc.cable.ebox.net [192.222.157.6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by simark.ca (Postfix) with ESMTPSA id 594071E54D;
 Wed,  5 May 2021 09:45:59 -0400 (EDT)
To: Dimitri Scheftelowitsch <dimitri.scheftelowitsch@esrlabs.com>,
 lttng-dev@lists.lttng.org
References: <CANQXvtRR1HvzQkwmzH_HMGGJjx2PP_XAiOgLZxjMWbuyhzjH6g@mail.gmail.com>
 <69a2d37a-d60d-deba-02d2-c3084f62b84f@polymtl.ca>
Message-ID: <555b0ddc-fbad-82d0-c052-27006310a577@polymtl.ca>
Date: Wed, 5 May 2021 09:45:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <69a2d37a-d60d-deba-02d2-c3084f62b84f@polymtl.ca>
Content-Language: en-US
X-Poly-FromMTA: (simark.ca [158.69.221.121]) at Wed, 5 May 2021 13:45:59 +0000
Subject: Re: [lttng-dev] Babeltrace trimmer segfaults on custom trace
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Simon Marchi via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Simon Marchi <simon.marchi@polymtl.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2021-05-04 9:57 p.m., Simon Marchi via lttng-dev wrote:
> I tried to see if it would be possible for you
> to just not use packets, but unfortunately I stumbled on what looks like
> a bug in the CTF metadata parser, it hardcodes whether streams classes
> have packets to true:
> 
>   https://github.com/efficios/babeltrace/blob/534d93a8b2ba86f56dfdf6aa7a10911da5f6432c/src/plugins/ctf/common/metadata/ctf-meta-translate.c#L576

Hi Dimitri,

After talking with Philippe (Babeltrace 2's main contributor), this is
not a bug in the CTF metadata parser.  According to [1]:

    If the packet size field is missing, the whole stream only contains a single packet. 

So when if you don't have a packet header/context at all, the trace is
considered to have a single big packet.  That's why the metadata parser
always create streams with packets.

But the suggestion of adding timestamps to your packet is still valid.

Simon

[1] https://diamon.org/ctf/#spec5.2
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
