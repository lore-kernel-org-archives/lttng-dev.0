Return-Path: <SRS0=0zlt=6M=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E1EC83007
	for <lttng-dev@archiver.kernel.org>; Tue, 28 Apr 2020 18:42:11 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB132076A
	for <lttng-dev@archiver.kernel.org>; Tue, 28 Apr 2020 18:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="tlNnw5Si"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB132076A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49BVqk1Dgwz1mwk;
	Tue, 28 Apr 2020 14:42:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1588099330;
	bh=L0H4tPu8Zv3AJJdvPMmeofmx/kCf+AZBQCmKhPWgNAU=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=tlNnw5SizJdIGsGXsrn8rskAjyaR3SfgAd7K6CPhYLUJ82yKiYDo9KUchw8eWOPiK
	 7I4IsfvBYNb6oqlk9N0UxMhS+SQo+Q4xHwdewlxdD3CrQRHhZrfU5U3OSRY6JvfV8T
	 eS5932z2PwfzzFo5oLRvIlhHxl7BFEpdC1TB36VBLuJl9QTUjP1g+OnQQz2I2IG6uF
	 a1x1V0XJ6PGsuKmQ7lv7t+KuFjfIMFTzKpsSbYb7SYk9pjIVWRDoI8Enx3xyMP75el
	 Sc0ztAPIobfXOInH8N6RXtaI92n6J1wexap8DrOKthI0oHY7QchIb+rE21SDXcOEgN
	 SnHqa0M3l28yg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49BVqh4tVTz1mtV
 for <lttng-dev@lists.lttng.org>; Tue, 28 Apr 2020 14:42:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 23AA627F44D;
 Tue, 28 Apr 2020 14:42:02 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id RxnK749gI3x9; Tue, 28 Apr 2020 14:42:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D12AB27F52B;
 Tue, 28 Apr 2020 14:42:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D12AB27F52B
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id KaAR2JvPJue5; Tue, 28 Apr 2020 14:42:01 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id C5F5627F3B7;
 Tue, 28 Apr 2020 14:42:01 -0400 (EDT)
Date: Tue, 28 Apr 2020 14:42:01 -0400 (EDT)
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Message-ID: <1480394831.72907.1588099321783.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200423205226.496-3-mathieu.desnoyers@efficios.com>
References: <20200423205226.496-1-mathieu.desnoyers@efficios.com>
 <20200423205226.496-3-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - GC79 (Linux)/8.8.15_GA_3895)
Thread-Topic: Clarify monotonicity requirement on timestamp begin
Thread-Index: N6AKTdmIChPLgLNAHcYNiDvUTQN2wA==
Subject: Re: [lttng-dev] [RFC PATCH CTF 2/3] Clarify monotonicity
 requirement on timestamp begin
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <pproulx@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>,
 Jeremie Galarneau <jgalar@efficios.com>,
 gbastien+lttng <gbastien+lttng@versatic.net>,
 diamon-discuss@linuxfoundation.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200428184201.G6wKZ8TuMEljDlcPOLNqAhYX8hXIDzrnAaW5AT6H74w@z>

----- Original Message -----
> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> To: "gbastien+lttng" <gbastien+lttng@versatic.net>, "Matthew Khouzam" <matthew.khouzam@ericsson.com>,
> diamon-discuss@linuxfoundation.org, pproulx@efficios.com, "Jeremie Galarneau" <jgalar@efficios.com>
> Cc: "lttng-dev" <lttng-dev@lists.lttng.org>, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Sent: Thursday, 23 April, 2020 16:52:25
> Subject: [RFC PATCH CTF 2/3] Clarify monotonicity requirement on timestamp begin

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> common-trace-format-specification.md | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/common-trace-format-specification.md
> b/common-trace-format-specification.md
> index f5fea51..53b70f4 100644
> --- a/common-trace-format-specification.md
> +++ b/common-trace-format-specification.md
> @@ -836,10 +836,12 @@ TSDL metadata):
>     range between these timestamps should include all event timestamps
>     assigned to events contained within the packet. The timestamp at the
>     beginning of an event packet is guaranteed to be below or equal the
> -    timestamp at the end of that event packet. The timestamp at the end
> -    of an event packet is guaranteed to be below or equal the
> -    timestamps at the end of any following packet within the same stream.
> -    See [Clocks](#spec8) for more detail.
> +    timestamp at the end of that event packet. The timestamp at the
> +    beginning of an event packet is guaranteed to be above or equal the

"greater than or equal to"

> +    timestamps at the beginning of any prior packet within the same
> +    stream. The timestamp at the end of an event packet is guaranteed to
> +    be below or equal the timestamps at the end of any following packet

"less than or equal to"

Phil

> +    within the same stream. See [Clocks](#spec8) for more detail.
>   * **Events discarded count**. Snapshot of a per-stream
>     free-running counter, counting the number of events discarded that
>     were supposed to be written in the stream after the last event in
> --
> 2.11.0
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
