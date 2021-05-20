Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AE0C433ED
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 14:57:54 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4124561059
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 14:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4124561059
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FmCXH4djbz1rpr;
	Thu, 20 May 2021 10:57:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621522672;
	bh=wpN7pYcQZ9+QbzD1nwTjlYkvkwd+fOCzVZm0+7xez80=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=V1aIOv+f9Vb/l677DYsvkqCXZwv15SIrsezYbWrUtXbj0/bYfrSMX0TRSoTG7YE4N
	 839dK6TxcEQhuRRAVtB6Bo1akJoOPz6gaJs8eRxmEe531tGU+iFcoFMVjC9iRNkk1+
	 oIjKrZEi3t5vxBQWWVMDUVtewoiCT4zR2/ksi+5O3haws5nbKsuraIIdDvso3zCDRt
	 nNtsi3gCYxAnQ4oKg+G+wrCCI9+xXzQIvvB6txzf1LiVI1ZwRb6Wmzglzo1l3+Okr0
	 9na7E/IOOHLbAq0Q7IUUMfJjC3KYw/CVJyO5mJ/4eDLnQfp+2IYPCQQAhAVl6RnkQM
	 ihYwXWPKqTrlg==
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by lists.lttng.org (Postfix) with ESMTPS id 4FmCXF6898z1rRs
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 10:57:49 -0400 (EDT)
Received: by mail-oi1-x235.google.com with SMTP id t24so1150381oiw.3
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 07:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZZ4muay611VG0uVKYyp/5ND7zY1Cdj5DRw807RST8+E=;
 b=h1J/3zdNSE4AC1GOdy/l74BYSXy+ePfZZa4IUuxBs+wMTo4nVua7YFZKJi0wl4LWDa
 mmb/dweGnqpaR0YgHxtkdlciqhduWQSHf51ZMSyvH2HHl8FWkPJMYCsfCr4ekKQSwEYw
 YOEPB9PjptKgbVrsA2Q6Xz8lp/Qza+ItQzbxRSSyx2YSiA43S2fbns8BfH9WJrHqEfxT
 rBn7LVZYmWd2PkWVh207p2+lkTPc9Wmfyez9PTZpnM1x353gvOK9kEdDJIY2Q1GYeWcW
 m+SmriI+epirsnMi75A0wHnYVnLMNf7+hB5jbCat05rWh2GtjSOSB/wWf9DTnHAnwImC
 Hb7Q==
X-Gm-Message-State: AOAM5313mxZy8SRvtVMyHFFcCU9tFv6UTMQU4wgK09s7wfv/7nv4rI2J
 p+BEwMFrl6C8wrgXNOme/xFiwRN8Jm7HSPkxFp8=
X-Google-Smtp-Source: ABdhPJz2pKI9iL7qlWaNR3NGm43ZCSfP8WKlcT/Vv5i7RDmMbMFZudWAH7awxsjssUkd7zR7pT3J77Dd1bZLzR36JYU=
X-Received: by 2002:aca:acc7:: with SMTP id v190mr3629965oie.28.1621522669029; 
 Thu, 20 May 2021 07:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210520121807.55428-1-nolange79@gmail.com>
 <1600729511.52338.1621520352970.JavaMail.zimbra@efficios.com>
In-Reply-To: <1600729511.52338.1621520352970.JavaMail.zimbra@efficios.com>
Date: Thu, 20 May 2021 16:57:38 +0200
Message-ID: <CADYdroN3FF3Qs_B55s_Un2qOGz3sP=JMpV=QWRFcO7KVzL-8_A@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] [PATCH lttng-ust] Improve tracelog handling,
 reduce exported functions
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
From: Norbert Lange via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Norbert Lange <nolange79@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Am Do., 20. Mai 2021 um 16:19 Uhr schrieb Mathieu Desnoyers
<mathieu.desnoyers@efficios.com>:
>
> ----- On May 20, 2021, at 8:18 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
>
> > Instead of creating functions for each loglevel, simply pass the
> > callback as argument.
> >
> > Further pack all preprocessor information into a struct that
> > the compiler already can prepare.
>
> This introduces an ABI break too late in the cycle.

So 2.14 would be the next chance I guess

> Also, I'm not so keen on adding an indirect call on the fast-path
> when it's not absolutely needed.

Code seems pretty similar: https://godbolt.org/z/oK1WhWqGT

> What is wrong with having one symbol per loglevel ?

Macro-magic is cumbersome to edit, more code, more relocations.

Easier to adapt aswell, could roll my own tracelog functions while
using lttng_ust__tracelog_printf (started soind that as I don't want
to link to lttng-ust.so)

Norbert
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
