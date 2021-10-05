Return-Path: <SRS0=2BMF=OZ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC42C433F5
	for <lttng-dev@archiver.kernel.org>; Tue,  5 Oct 2021 18:28:33 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518916117A
	for <lttng-dev@archiver.kernel.org>; Tue,  5 Oct 2021 18:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 518916117A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4HP5gf4XWvz1K7m;
	Tue,  5 Oct 2021 14:28:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1633458511;
	bh=vHjAR8n91p9I1Udiac8lleNtzkq8yCmyl5Ajm5/UXOQ=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=U3bUs2Mq/1kyHArLPGda0obFvQQkku/Q4HPG4d+HVnGhleiQbvvEEXmJeBcuRGnTl
	 NFJIlO/8FICSeVvPwyftZUSg+ef0XNpSPWmBjoJXVG/D59rgjNV/NyEfEVP/Z7Y1wi
	 /QvTobgsP8yyKRlUhYVO8Fav99pXNl5LahiXVUSznxkInOyq33JRBHg+JwdDhaPpjD
	 FRZWXOrEteVIPD5OymlMOb5z4NQkAYvPTZ2DBli4X/KJkrfGUgG+1br1K+AtgA90to
	 WvT8y6L/porZ+C2trmQS9tMe9/YlFQRk7BjIEqfJ08Zi39+eQTVoqtETsFxi/hpmfX
	 EFH+UMZekTrEw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4HP5gd0Vy4z1K7k
 for <lttng-dev@lists.lttng.org>; Tue,  5 Oct 2021 14:28:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5A44138F165
 for <lttng-dev@lists.lttng.org>; Tue,  5 Oct 2021 14:28:22 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id jDmqDM00jj3K; Tue,  5 Oct 2021 14:28:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 36FB638F1C6;
 Tue,  5 Oct 2021 14:28:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 36FB638F1C6
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Hk8z81SEo_3A; Tue,  5 Oct 2021 14:28:21 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 2B02C38F1C5;
 Tue,  5 Oct 2021 14:28:21 -0400 (EDT)
Date: Tue, 5 Oct 2021 14:28:21 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <294104910.2889.1633458501063.JavaMail.zimbra@efficios.com>
In-Reply-To: <CADYdroMJgt=bMGWmxFV8YAKWouBJeL5244_RM1S-D0SDF+tkzg@mail.gmail.com>
References: <CADYdroMJgt=bMGWmxFV8YAKWouBJeL5244_RM1S-D0SDF+tkzg@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4156 (ZimbraWebClient - FF92 (Linux)/8.8.15_GA_4156)
Thread-Topic: Feature request: dynamically load from prefix
Thread-Index: 8Gs5m12Gm2mDfecIz6X95xKf9GRHaA==
Subject: Re: [lttng-dev] Feature request: dynamically load from prefix
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Jul 15, 2021, at 7:21 AM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Hello,
> 
> The production rootfs should be untouched, ideally read-only,
> for development/tests a subdirectory can be mounted (eg. /usr/local).
> Idea is that the contents of that directory alone (and at most some
> env variables)
> should allow enabling development features.
> 
> For lttng I would have wanted to add a library
> '/usr/local/lib/libmyservice-tracepoints.so' with runpath
> '/usr/local/lib' that would activate lttng tracing,
> pulling in lttng libraries (ust, ust-tracepoint) from /usr/local/lib.
> 
> There is a caveat though, unless 'libmyservice-tracepoints.so'' is
> preloaded, the code in lttng/tracepoint.h will run constructor functions
> to register the tracepoint probes, trying to dlopen the lttng-ust-tracepoint
> library and fail at that because this is not in the library search paths.
> 
> At a later time,  'libmyservice-tracepoints.so'' will be loaded, and
> lttng-ust-tracepoint (along with lttng-ust) can be resolved. but the
> tracepoints are not registered.
> 
> So I guess what I would need is to either retrigger the registration
> of tracepoints
> (likely complicated with static and weak symbols potentially causing a mess), or
> redirect the dlopen function.
> Useful would be either try to find the library in /usr/local/lib or
> use '/usr/local/lib/libmyservice-tracepoints.so''
> instead of  lttng-ust-tracepoint (both have (dis)advantages).
> 
> At any rate, I would welcome some customization macro.

I'm currently working on improvements to the reporting of such scenario.

See:

https://review.lttng.org/c/lttng-ust/+/6480 tracepoints: print debug message when lttng-ust-tracepoint.so is not found 
https://review.lttng.org/c/lttng-ust/+/6484 tracepoints: increase dlopen failure message level from debug to critical

With this in place, it should be easier for a lttng end-user to figure out that
liblttng-ust-tracepoint.so cannot be found by dlopen() because it is not in the
system's library search path.

From that point, what is wrong with requesting the user to add the path towards
liblttng-ust-tracepoint.so to the environment variable LD_LIBRARY_PATH when running
the application ?

Thanks,

Mathieu

> 
> For illustration the current hack-around is following
> 
> Norbert Lange
> 
> #define TRACEPOINT_DEFINE
> #define TRACEPOINT_PROBE_DYNAMIC_LINKAGE
> 
> #include <dlfcn.h>
> 
> static inline void *s_remap_dlopen(const char *localfilename, int
> flags, unsigned prelen) {
>    void *md = (dlopen)(localfilename + prelen, flags);
>    return md ? md : (dlopen)(localfilename, flags);
> }
> 
> # ideally this would be LTTNG_TRACEPOINT_PROBE_DLOPEN instead of the dlopen mess
> #define dlopen(x, y) s_remap_dlopen("/usr/local/lib/" x, y,
> (unsigned)sizeof("/usr/local/lib/") - 1U)
> 
> #include "trace_mytracepoints.h"
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
