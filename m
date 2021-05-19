Return-Path: <SRS0=5oIU=KO=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04A6C433B4
	for <lttng-dev@archiver.kernel.org>; Wed, 19 May 2021 12:11:19 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E1B66135B
	for <lttng-dev@archiver.kernel.org>; Wed, 19 May 2021 12:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1B66135B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FlWtX2bVjz1qsw;
	Wed, 19 May 2021 08:11:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621426278;
	bh=N9hKLmBL3Fd3lXcsfAbfCWXaOeDZ5Uoysr0GywVp6HU=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=SaOd7WenD5i7lxZ2qBGkFPGb0lv+MpzZ2N7BrtQPBGTEGrZZiAs8UfIWHcUdU01rq
	 CxVJ/AzS+3YLumdFunqd9ez3FIo+NzrzYShXS7kAkPkw0ac4EV2lClHc199AWtd+xH
	 lPAQ8cVKYWjDa0JqUNZ4ko+5D0M3Dj/pA9fWBwC8YN8d4CRiULnztDr24YP+0y5X4P
	 qoR0yIpjiQpP3Ooxoq3kfHl3zdWEPL2W6xc0krnP6goI+TJJcziGUAzBV9RIGQOXuP
	 4VmPIsK04PnRkIryydYotVqdLOZ7mTKOTjdOlsF5p5ZfkX7EKjkBFLFRXfTNObJKcZ
	 PPJB437m1pInA==
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by lists.lttng.org (Postfix) with ESMTPS id 4FlWtW0tDFz1qnd
 for <lttng-dev@lists.lttng.org>; Wed, 19 May 2021 08:11:14 -0400 (EDT)
Received: by mail-ot1-x335.google.com with SMTP id
 i14-20020a9d624e0000b029033683c71999so361907otk.5
 for <lttng-dev@lists.lttng.org>; Wed, 19 May 2021 05:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=qDHdOonpeQY18hBWUZrZHQa/VxxasAZxjSXiKMNLF5Q=;
 b=ctHTQ9nRnWFqDbpSlnLV40PGHq7qHUonOSDgio1VRfUgH4LEPNtoS86EOefxOWMh74
 lZdAWfrKoiQWzV0BZ7xZiyXMm5cWByJotAQvmZygUpB2wTX9RxU6YNcR9XZ+vgP15z9i
 QPWh6vL8465uN/3Rg0sN42Xxy7rZ0jUIAYno2bOopDsj6gbSJ2oYL7lOvX8v1NZSfcuc
 bJ4N7K8vKHs8tylRfwaxIS0FnVbDrZCz8bfTGEppS4HpDP2lPirOw1uRG29XKBpAOs69
 IHjzv1827q8+WxH6dp+P22ELM2qWdLmdZLcTMlruHHjSUnSatLeQlrqfy4FRJ5njChg8
 CVVQ==
X-Gm-Message-State: AOAM530dJIxuBt1BeD/2Jbr6KbfcjyTL1H6LWBwblJbphyofU3rhc82M
 SnH7EKiJ0oZCNWNZbe84IYSQa5UOks60KfQ+KTB+KVPUyHT3vA==
X-Google-Smtp-Source: ABdhPJynesghdSNYqYFN7SsCkj7k2vFxYPBICXyGGeOd2temx+Kw8W5GoEZCzNzehnkFDQx4g1wI48rezazwRZySi90=
X-Received: by 2002:a9d:7612:: with SMTP id k18mr8638934otl.178.1621426274092; 
 Wed, 19 May 2021 05:11:14 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 19 May 2021 14:11:03 +0200
Message-ID: <CADYdroN3=pAe66crtsVT9aHE4T+bT61-tvHFKCuwZYkHhuyFjw@mail.gmail.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] reading context fields causes syscalls
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

Hello,

Several context fields will cause a syscall atleast the first time a
tracepoint is
recorded. For example all of the following:

`lttng add-context -c chan --userspace --type=vpid --type=vtid --type=procname`

Each of them seems cached in TLS however, and most should never change
after startup.

As I am using Lttng over Xenomai, syscalls are strictly forbidden, I
would like to have some function that prepares all data, which I can
call on each thread before it switches to realtime work.

Kinda similar to urcu_bp_register_thread, I'd like to have some
`lttng_ust_warmup_thread` function that fetches the context values
that can be cached. (urcu_bp_register_thread should be called there
aswell)
I considered just doing a tracepoint, but AFAIK the channel can be
changed/configured after the process is running. So this is not robust
enough.

regards, Norbert
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
