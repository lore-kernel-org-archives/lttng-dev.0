Return-Path: <SRS0=A40Q=63=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8916C433E0
	for <lttng-dev@archiver.kernel.org>; Wed, 13 May 2020 15:33:23 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCFFA20671
	for <lttng-dev@archiver.kernel.org>; Wed, 13 May 2020 15:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="Cv5QaSsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFFA20671
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49Mdwx6vWMz22CD;
	Wed, 13 May 2020 11:33:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1589384002;
	bh=OV9XUCXaaAWdr4Zowaw5kv+U6VHQto9rpmKzrY2r+SQ=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Cv5QaSsh55v5VRVnB9E9XPNeNLbpmF9hUh7XPZFnbZ5nw5sm48kzyKIU6t9Y+3NIs
	 jX2Fn7PREDjhtohJ9tKytzSRSyn+Zi/E/RapXWQ0nGIdQPPaIEAj+abm/YPq55beWt
	 TjZT/gLs1WPkWMvAyd9HKGEqF3hEOxoXqDDTcjwb7kq4ccdweUZH9qHTd4F8UfU6fo
	 ehvwbj4jffjqa1SkrteStEH75Fo0s/g6nOdKSPRvB7sAr9hEAhLZGPLdly5S3LvpM7
	 ptKrLwTUDxCjZKQDtyxUSxZnLAqZ++fk1a4+fz8wrOQN/pNMnz3eDdZ1M+uqnh0bUo
	 sG7IAaUMKrH3g==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49Mdww62x1z21tq
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 11:33:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 38C672BA064
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 11:33:14 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id wcLa9L8LRUa0; Wed, 13 May 2020 11:33:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D91A32BA4AC;
 Wed, 13 May 2020 11:33:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D91A32BA4AC
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Mjq7H-lVkDrl; Wed, 13 May 2020 11:33:13 -0400 (EDT)
Received: from joraj-alpa (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id 7A9752BA587;
 Wed, 13 May 2020 11:33:13 -0400 (EDT)
Date: Wed, 13 May 2020 11:33:12 -0400
To: Abhinav Ranjan <abhi.abhinav240@gmail.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <20200513153312.GA2381108@joraj-alpa>
References: <CAPC3ern8bkAJDnOwoYh2Om44Q2GWAPsh140FW_aPGVkdUmCwkw@mail.gmail.com>
 <CAPC3erkxTh9dSgahym7xsCjJXOV3D+kto-=UB-ApjSUOWYZVeA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPC3erkxTh9dSgahym7xsCjJXOV3D+kto-=UB-ApjSUOWYZVeA@mail.gmail.com>
Subject: Re: [lttng-dev] Need Help In trace generation for malloc(),
 free() calls etc
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
Message-ID: <20200513153312.A_aLo16tZpovLe6hYgVamYNBAZm7SmPCJWBB5TQ2vh4@z>

Hi Abhinav,

Please refrain from using screenshots when pastebin could be used (code,
commands, etc).

On Wed, May 13, 2020 at 10:29:22AM +0530, Abhinav Ranjan via lttng-dev wrote:
>   Hello Sir,
> I am Abhinav from India.
> *Kindly Ignore the previous email.*
> Actually I am very new to the Embedded System Engineering profession. In
> fact I have been asked to do an independent project to instrumenting a c
> application using  LLTng concept to find/trace calls to malloc(), free()
> calls. In fact i tried capturing the same as below steps but didn't
> understand why after using LD_PRELOAD also malloc() and free() calls were
> not traced. I am not sure whether my app was correct!!
> 
>  I followed the steps provided to create executable using -lltng-ust -ldl
> 2.I executed it as: LD_PRELOAD=liblttng-ust-libc-wrapper.so ./executable
> (initially as ./exe arg))
> 3. Then I followed commands to create , capture the events. and destroyed
> it.

Based on the screenshot "creation_trace.PNG", it seems that you enable only the
event you defined (malloc_trace_investigation). Keep in mind that the libc
wrapper defines its own tracepoints and tracepoint providers.

It the case of the libc wrapper the tracepoint providers available are:
lttng_ust_libc and lttng_ust_pthread

Both have multiple tracepoints defined under them.

Hence what you want for you experiment is something like this:

    lttng enable-event -u malloc_trace:investigation
    lttng enable-event -u 'lttng_ust_libc:*'

Keep in mind that you can list the events available for a currently running app
using:

   lttng list -u


The app must be running for the listing work.

Cheers.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
