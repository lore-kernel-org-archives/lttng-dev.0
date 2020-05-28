Return-Path: <SRS0=ghd8=7K=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62889C433E0
	for <lttng-dev@archiver.kernel.org>; Thu, 28 May 2020 11:51:31 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C1D2075F
	for <lttng-dev@archiver.kernel.org>; Thu, 28 May 2020 11:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="UZt0Xe7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C1D2075F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49XmHy6LMcz1FrM;
	Thu, 28 May 2020 07:51:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1590666687;
	bh=RqfCiTYE2s5Z/f9CQgFwN574F8fvD/PBJYOjzNriCVo=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=UZt0Xe7/fCww8zfKAahg4OCcflzZmez7gpHQ7qoEkJX8bPWgqiCb9kr+NQ9pLgQ6e
	 TOQbOJLnZIfEeWrtmjQS8yNNEU60kHPinNRYRcpCFMsl1eLqT6SEIlYJTs7noPx684
	 SxEDsKv7i+a8Ak5CMYsND3odBAwo0etQJlo+dTxH68GPtdQ0fcQK1kR9IELz5DQAvy
	 tuRWLKsvLTj57BbGYV1S/L8p7s6NNHHffoe3MLWmvTHXHFqhXQeP5SOIYf8Ca9+//a
	 U9jNzxK/7BFaZwKNQS3p4xQ3TMKFCR13Im4qlya4pQMrEOegLiWQeZd5AN3OmFyuxS
	 9h2bZPJMqoRjQ==
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by lists.lttng.org (Postfix) with ESMTPS id 49XmHx1zn2z1FrL
 for <lttng-dev@lists.lttng.org>; Thu, 28 May 2020 07:51:24 -0400 (EDT)
Received: by mail-ej1-x62a.google.com with SMTP id gl26so3392853ejb.11
 for <lttng-dev@lists.lttng.org>; Thu, 28 May 2020 04:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=CAJXBFPvXKW/Xyg8grrU4BIsKI7TAhg4cnXXKroMrW4=;
 b=UtexH3lNcWpSvj7VBcUXwbcpqDMkdzkcLgJImwymvUEWLczD/EgiyM1hOnGbrv529g
 bfM+C2DUt7/ZaypkrzhAi6t3XfMd92VhckYgI8Xj3GdVJjoCBZ3+EZNzXeJ5CGZIByBB
 eQ9m5vwPU2jc67Q328QWqajE/1zW5BJa6KjiQykntXtjgS74bWyPFdP7VYUQFzE40s0u
 /3O0kXaFUzqlr/R5jdBgrzt86lePfug1G8HvXnp7B5XYxy1odTaKUh6vQGtMTnWv8Cjb
 ujia8xPwFAcj7TUSYG9T7y3dUSHhRV+HiRJ/SpK0ghVhoIJQBldgJCCii2son0dUDVjM
 592Q==
X-Gm-Message-State: AOAM531hJkodP5kg+OzuBsYQklQgr1X/mbqtHqap6y3C/M3NntTLNDpr
 G2KM3brTQEXuShfV3hnVvgM1EmetqwF1SSF0EDz/Bmgtb/GW1g==
X-Google-Smtp-Source: ABdhPJzSVYJTEsLcLdECS9RddZsqUmRQPRMlr4hkpwfT9Gz5ot6cyI9rhlpHyaEJW6dyq0m7xNJ5ddG5vlZZfZUsYPE=
X-Received: by 2002:a17:906:5795:: with SMTP id
 k21mr2733934ejq.374.1590666683491; 
 Thu, 28 May 2020 04:51:23 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 28 May 2020 13:51:12 +0200
Message-ID: <CAGK+5gW_7Lo3O4oYW8jVJqDiUby6xoRyL3-JJQDQ8VYLG7WPAg@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] lttng_lib_ring_buffer: section 24 reloc 0 sym '':
 relocation 42 out of range
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
From: Lukasz Domowy via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Lukasz Domowy <lukasz.odw39@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200528115112.rs2w-3IcngK11uZEORE4Cc2gFQ1fDOciAMgx9K86tgE@z>

Hello,

First - of all: thank you very much for efforts to develop and
maintain LTTng. It's very useful tool!
I used it so far on PowerPC targets and now I try to run it on ARM:
Cyclone5 ARMv7 CPU.

When trying to run LTTng I get:

# lttng list --kernel
[ 2012.822578] lttng_lib_ring_buffer: section 24 reloc 0 sym '':
relocation 42 out of range (0x7f05827c -> 0xc0cd7358)
Error: Unable to list kernel events: Kernel tracer not available
Error: Command error

Do you have any hints how to fix it?

I found https://bugs.lttng.org/issues/1173 but enabling
CONFIG_ARM_MODULE_PLTS did not help.

I use LTTng from Yocto 3.0.2 with custom kernel 4.14.134-rt63-rt:

# lttng -V
lttng (LTTng Trace Control) 2.10.7 - KeKriek

All options recommended from documentation are enabled:
root@cyclone5:~# zcat /proc/config.gz | grep -i modules
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_MODULES=y
CONFIG_MODULES_TREE_LOOKUP=y
# Xtables combined modules
# User Modules And Translation Layers
root@cyclone5:~# zcat /proc/config.gz | grep -i kallsyms
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
root@cyclone5:~# zcat /proc/config.gz | grep -i high_res_timers
CONFIG_HIGH_RES_TIMERS=y
root@cyclone5:~# zcat /proc/config.gz | grep -i tracepoints
CONFIG_TRACEPOINTS=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y

Thank you in advance!

Best regards,
Lukasz
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
