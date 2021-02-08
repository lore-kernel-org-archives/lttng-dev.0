Return-Path: <SRS0=zN6S=HK=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3F4C43381
	for <lttng-dev@archiver.kernel.org>; Mon,  8 Feb 2021 19:38:51 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC0CC60238
	for <lttng-dev@archiver.kernel.org>; Mon,  8 Feb 2021 19:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0CC60238
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DZGY45Mhcz19Qt;
	Mon,  8 Feb 2021 14:38:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1612813129;
	bh=jMwiev0uG5EowEbHIuXF+vdYT01zuKY7FW1Bqbrfc9E=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QA81bZjkePZ8+gbCtDSctOZT9ZDFyg1+6xm94o1p/VQ68Njizi6opC8rh7Skopdsb
	 oY1Q3CBqKHrFnDiuT+bzovwQ+J536BML49U3jOiZR/3dNcaJTNNeSNzLPvDTRwOrwf
	 JoP/WKzPjKsazN0puu7MMmnhKIZO1X/lsuqIDINvWNuo5f4GKU9mDuDTPHnpuk63bS
	 N8/SUVPa0U2HvHm4U5AijkUBH9NDEJ+TNKVU2QMlwsNWor+ey3h+NtS0BiYJiMpsvs
	 XWAMA40LqXCHmuEJgPlBfmZfyZXoNLRguPzuJn0CwD4G6BdBP4sx17ilzHabv0kcng
	 x4BIRKqAb1XOQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4DZGY31nCPz19Qr
 for <lttng-dev@lists.lttng.org>; Mon,  8 Feb 2021 14:38:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id AADBA2D864C
 for <lttng-dev@lists.lttng.org>; Mon,  8 Feb 2021 14:38:46 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id TS00JE35_rDa; Mon,  8 Feb 2021 14:38:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 716BC2D8BC1;
 Mon,  8 Feb 2021 14:38:46 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 716BC2D8BC1
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id b0oMdpj7MPuG; Mon,  8 Feb 2021 14:38:46 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 65C2B2D8CC1;
 Mon,  8 Feb 2021 14:38:46 -0500 (EST)
Date: Mon, 8 Feb 2021 14:38:46 -0500 (EST)
To: Mohammad Kavousi <kavousi@u.northwestern.edu>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Yan Chen <ychen@northwestern.edu>, 
 Xutong Chen <XutongChen2021@u.northwestern.edu>
Message-ID: <108657053.9981.1612813126291.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAK7B4KcwnAK_u5t-F_ujjeG=mnEXBAtr4PfdcHuhqccrRmbo_Q@mail.gmail.com>
References: <CAK7B4KcwnAK_u5t-F_ujjeG=mnEXBAtr4PfdcHuhqccrRmbo_Q@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF85 (Linux)/8.8.15_GA_3996)
Thread-Topic: LTTng Support for Network Namespace
Thread-Index: m0FwcdkepQ52k4U0RyyCZdAeW1f6xQ==
Subject: Re: [lttng-dev] LTTng Support for Network Namespace
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

----- On Feb 8, 2021, at 1:04 PM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Dear LTTng developers,
> I was wondering if LTTng currently (or in the future) supports network
> namespaces. For instance, an ambiguity in the logs would make problems for
> future system analysis.

Did you try the "net_ns" context ? 

> Taking the "bind" system call, that would help us distinguish between different
> local IP addresses when two or more container instances are running on the
> host, given that the "umyaddr" field is an address inside the memory, how would
> we recover the local addresses after the trace has been collected?

> syscall_entry_bind: { cpu_id = 1 }, { mnt_ns = 4026532553, pid = 532, tid = 532,
> vtid = 532, vpid = 532 }, { fd = 14, umyaddr = 93827759199256, addrlen = 12 }

In lttng-modules, we'd need to implement a system call override for the bind system
call which fetches the umyaddr content from user-space. You can see the x86-64 override
code for the "connect" system call which fetches the uservaddr from user-space as an
inspiration.

Thanks,

Mathieu


> Thanks, we appreciate the help beforehand!

> Mohammad

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
