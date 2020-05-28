Return-Path: <SRS0=ghd8=7K=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0F1C433DF
	for <lttng-dev@archiver.kernel.org>; Thu, 28 May 2020 13:31:46 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E874A20721
	for <lttng-dev@archiver.kernel.org>; Thu, 28 May 2020 13:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="AfxcQe3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E874A20721
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49XpWj1B8Cz1Fb0;
	Thu, 28 May 2020 09:31:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1590672705;
	bh=G23sZH5o8VlyZfNIGz3Pow/Ydl799H7pDbyEBFLRPr8=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=AfxcQe3ql/IGNNejc+j982xJmPGX7Gs2Oqu3Xa97Zsynpz5/VnMZxKRJ2OCCu0RgC
	 aevG0voz0UHjxts/st9j5sTMs3/BgE23V9ivGCUlMPEPVqOobYI590lMYwNJOzw5tR
	 HUXdl8ldMTowPVmh4z1zQ3HgdIVIVTsSi8Z9w6Eh0/Hv6UmWBpz+Jxp7GDs269S208
	 j/lpQcRb6UXqEWhLzLz3f/DjKLAi/5CSyyrfxq1QUgGnIqtuQfv3VI4dVFV028GWgk
	 msnUc0Qfk0/o8lkuy/qjiavS32jRs+3DdaVuLYIOiciSvnedhrxF5dhfP4tF4r/Rlb
	 JMXHZ+42UzrEA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49XpWb25bKz1G0T
 for <lttng-dev@lists.lttng.org>; Thu, 28 May 2020 09:31:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8F56A28238C
 for <lttng-dev@lists.lttng.org>; Thu, 28 May 2020 09:31:33 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id YyLuhQywZtom; Thu, 28 May 2020 09:31:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3C87D28238A;
 Thu, 28 May 2020 09:31:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3C87D28238A
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id mWpaYIfGWonp; Thu, 28 May 2020 09:31:33 -0400 (EDT)
Received: from joraj-alpa (unknown [107.159.43.215])
 by mail.efficios.com (Postfix) with ESMTPSA id 1D382282389;
 Thu, 28 May 2020 09:31:33 -0400 (EDT)
Date: Thu, 28 May 2020 09:31:32 -0400
To: Lukasz Domowy <lukasz.odw39@gmail.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <20200528133132.GB6269@joraj-alpa>
References: <CAGK+5gW_7Lo3O4oYW8jVJqDiUby6xoRyL3-JJQDQ8VYLG7WPAg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGK+5gW_7Lo3O4oYW8jVJqDiUby6xoRyL3-JJQDQ8VYLG7WPAg@mail.gmail.com>
Subject: Re: [lttng-dev] lttng_lib_ring_buffer: section 24 reloc 0 sym '':
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
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200528133132.A8ATxOL0njDviUkyxdf9-aFRaSA58v_oxKkFXvzBgWA@z>

Hi Lukasz,

Is the problem reproducible on the qemu arm target (yocto) ?

On Thu, May 28, 2020 at 01:51:12PM +0200, Lukasz Domowy via lttng-dev wrote:
> Hello,
> 
> First - of all: thank you very much for efforts to develop and
> maintain LTTng. It's very useful tool!
> I used it so far on PowerPC targets and now I try to run it on ARM:
> Cyclone5 ARMv7 CPU.
> 
> When trying to run LTTng I get:
> 
> # lttng list --kernel
> [ 2012.822578] lttng_lib_ring_buffer: section 24 reloc 0 sym '':
> relocation 42 out of range (0x7f05827c -> 0xc0cd7358)
> Error: Unable to list kernel events: Kernel tracer not available
> Error: Command error
> 
> Do you have any hints how to fix it?
> 
> I found https://bugs.lttng.org/issues/1173 but enabling
> CONFIG_ARM_MODULE_PLTS did not help.
> 
> I use LTTng from Yocto 3.0.2 with custom kernel 4.14.134-rt63-rt:
> 
> # lttng -V
> lttng (LTTng Trace Control) 2.10.7 - KeKriek
> 
> All options recommended from documentation are enabled:
> root@cyclone5:~# zcat /proc/config.gz | grep -i modules
> CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
> CONFIG_MODULES_USE_ELF_REL=y
> CONFIG_MODULES=y
> CONFIG_MODULES_TREE_LOOKUP=y
> # Xtables combined modules
> # User Modules And Translation Layers
> root@cyclone5:~# zcat /proc/config.gz | grep -i kallsyms
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> root@cyclone5:~# zcat /proc/config.gz | grep -i high_res_timers
> CONFIG_HIGH_RES_TIMERS=y
> root@cyclone5:~# zcat /proc/config.gz | grep -i tracepoints
> CONFIG_TRACEPOINTS=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> 
> Thank you in advance!
> 
> Best regards,
> Lukasz
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
