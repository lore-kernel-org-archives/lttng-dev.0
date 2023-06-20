Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41D6EB64D7
	for <lttng-dev@archiver.kernel.org>; Tue, 20 Jun 2023 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687270827;
	bh=j3sw+3Kwexmpp9ESacnanh55BPBewMMPEMmUDen+0RQ=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=BWi52TUnR/VcbC0uyYVJ7rkcFuOqzNBT1HJwoMbva8Lk8STIMjointifjILTijek0
	 wYJknkmfQUn+H3JHu5INdB+6sbtWD+gkAokYGKUC7Re1OPtbh1WIQC63jwrX2aK0TL
	 6YsCrND9ZdU/YIsRFEi8+7HicH1LDeoSiHQKCP05gZ1NFSXygE0E144PoaUbJW2fAp
	 1l+XAsP8NAa3u1LlmjZbffK5eFWDDB6zfUEEGVAOgPgVs+szdFExDzzDLtgPoia+kt
	 iooiBKQvxAI4YJxZNTtiTqmX4pedTGGAKc4TuuHDOsAMBO76YD18woGT/vcIpE3Pf0
	 AKvlBc4rpS3ug==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Qlpgt6qb1z1y3w;
	Tue, 20 Jun 2023 10:20:26 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4Qlpgs5Ghjz1yCC
 for <lttng-dev@lists.lttng.org>; Tue, 20 Jun 2023 10:20:25 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4Qlpgc6tGDz18kj;
 Tue, 20 Jun 2023 10:20:12 -0400 (EDT)
Message-ID: <63288a1f-59b4-80f9-2a26-bc252ce9cd1f@efficios.com>
Date: Tue, 20 Jun 2023 10:20:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: "Mousa, Anas" <anasmous@amazon.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <6e06b605ec9f446da5dc8948c8621518@amazon.com>
In-Reply-To: <6e06b605ec9f446da5dc8948c8621518@amazon.com>
Subject: Re: [lttng-dev] Profiling LTTng tracepoint latency on different arm
 platforms
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 6/20/23 06:27, Mousa, Anas via lttng-dev wrote:
> Hello,

> 
> Arethereanysuggestionstorootcausethehighlatencyandpotentiallyimproveiton*platform****1*?
> 
> Thanks and best regards,
> 
> Anas.
> 

I recommend using "perf" when tracing with the sample program in a loop 
to figure out the hot spots. With that information on the "fast" and 
"slow" system, we might be able to figure out what differs.

Also, comparing the kernel configurations of the two systems can help. 
Also comparing the glibc versions of the two systems would be relevant.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
