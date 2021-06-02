Return-Path: <SRS0=vCtj=K4=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D1EC47092
	for <lttng-dev@archiver.kernel.org>; Wed,  2 Jun 2021 16:32:04 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CFA261958
	for <lttng-dev@archiver.kernel.org>; Wed,  2 Jun 2021 16:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFA261958
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FwF0w68QHz5qN;
	Wed,  2 Jun 2021 12:32:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1622651522;
	bh=KisvZi4A2w0PIVpn51exhUnuDLg/ZRYJ2sKTWQbc5tU=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=kaW1aXZJiNgmkcI8KLtfHU9fawFlSuLShc3i0tcXYkpSxr8cAQKZxR0KPBGlLyM71
	 /+5J+sbpIcRQ9/qsIcrtPST1IpcTWVlfoUjdvoBTxo2TdWda1JMdxPeaHkw4VPSFaK
	 WrGCC+NUlvgxPHWG2e4gl/LwB6NxiidDtehiCcSFGJJh42u07ygSWCZJM5VylpnnP1
	 aUBcEs0XVU9zrjqSmXlDR+dUE0fB4sLVtMCDoMEK2cqk6aApMxfMTknomHDve+QBBl
	 nxU+Vz0ZA40qabHETiGX30unYVubp9PUGLA72oVNt7TNmvy+TcI2qIOpU4be45MTQi
	 +yfxyTNmZnqkQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FwF0v3J3wz5dV
 for <lttng-dev@lists.lttng.org>; Wed,  2 Jun 2021 12:31:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id ED9B6303CB3
 for <lttng-dev@lists.lttng.org>; Wed,  2 Jun 2021 12:31:52 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 3nxGm2u54Wgj; Wed,  2 Jun 2021 12:31:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6403F303CB0;
 Wed,  2 Jun 2021 12:31:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6403F303CB0
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id JgzXYtqatz0l; Wed,  2 Jun 2021 12:31:52 -0400 (EDT)
Received: from joraj-alpa (unknown [107.159.43.215])
 by mail.efficios.com (Postfix) with ESMTPSA id 3AE46303DAA;
 Wed,  2 Jun 2021 12:31:52 -0400 (EDT)
Date: Wed, 2 Jun 2021 12:31:51 -0400
To: paul@triplanets.com
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <20210602163151.GB388028@joraj-alpa>
References: <00e701d7567f$cd20c070$67624150$@triplanets.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <00e701d7567f$cd20c070$67624150$@triplanets.com>
Subject: Re: [lttng-dev] Syntax error running lttng
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
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

Side note: not sure what is wrong with my email setup or the mailing list but I
cannot see the reply you sent in my email folder, but it is available here: 

https://lists.lttng.org/pipermail/lttng-dev/2021-June/030021.html

In any case, this look strangely like the problem seen in [1][2]. Considering
your cross compilation setup I would take a deeper look at the generated
executable both locally and when on the device.
The `file` command is a must here I think.

[1] https://unix.stackexchange.com/questions/336436/syntax-error-unexpected-when-execute-a-compiled-c-program
[2] https://unix.stackexchange.com/questions/499641/syntax-error-unexpected-when-execute-a-cross-compiled-pjsip-binary-in-arm

Not sure if this is exactly your problem. `strace` might give a bit more info
on what is going on and at least see if the problem is lttng or anything else. 

Cheers

On Tue, Jun 01, 2021 at 10:48:13AM +1000, Merlin via lttng-dev wrote:
> Hi,
> 
>  
> 
> I have compiled LTTNG for ARM but when I try to run the executable, I get
> this error:
> 
>  
> 
> lttng: line 1: syntax error: unexpected "("
> 
>  
> 
> E.G.        lttng create my-kernel-session
> --output=/mnt/sd1/nfs/temp/Innotech/lttng/my-kernel-trace
> 
> lttng list --kernel
> 
> lttng-sessiond
> 
>   all produce the same error.
> 
>  
> 
> There were no compiler errors.  I am at a loss to understand what it is
> complaining about from the message.
> 
>  
> 
> Modules seem to load fine.
> 
>  
> 
> ~ # lsmod
> 
> Module                  Size  Used by    Tainted: G
> 
> lttng_ring_buffer_client_discard    20480  0
> 
> lttng_ring_buffer_client_mmap_discard    20480  0
> 
> lttng_ring_buffer_metadata_mmap_client    16384  0
> 
> lttng_ring_buffer_metadata_client    16384  0
> 
> lttng_ring_buffer_event_notifier_client    16384  0
> 
> lttng_ring_buffer_client_overwrite    20480  0
> 
> lttng_tracer         1167360  6
> lttng_ring_buffer_client_discard,lttng_ring_buffer_client_mmap_discard,lttng
> _ring_buffer_metadata_mmap_client,lttng_ring_buffer_metadata_client,lttng_ri
> ng_buffer_event_notifier_client,lttng_ring_buffer_client_overwrite
> 
> lttng_kprobes          16384  1 lttng_tracer
> 
> lttng_lib_ring_buffer    57344  7
> lttng_ring_buffer_client_discard,lttng_ring_buffer_client_mmap_discard,lttng
> _ring_buffer_metadata_mmap_client,lttng_ring_buffer_metadata_client,lttng_ri
> ng_buffer_event_notifier_client,lttng_ring_buffer_client_overwrite,lttng_tra
> cer
> 
> lttng_kretprobes       16384  1 lttng_tracer
> 
> lttng_statedump        20480  1 lttng_tracer
> 
> lttng_wrapper          16384  2 lttng_tracer,lttng_statedump
> 
> lttng_clock            16384  4
> lttng_ring_buffer_client_discard,lttng_ring_buffer_client_mmap_discard,lttng
> _ring_buffer_client_overwrite,lttng_tracer
> 
>  
> 
> Any suggestions appreciated.
> 
>  
> 
> Thank you.
> 
>  
> 
> Merlin
> 

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
