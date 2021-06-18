Return-Path: <SRS0=VPNp=LM=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9CEC48BE8
	for <lttng-dev@archiver.kernel.org>; Fri, 18 Jun 2021 17:11:59 +0000 (UTC)
Received: from lists.lttng.org (unknown [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AAC61004
	for <lttng-dev@archiver.kernel.org>; Fri, 18 Jun 2021 17:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AAC61004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4G657T2f6PzJSy;
	Fri, 18 Jun 2021 13:11:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1624036310;
	bh=CKmAK0AdUFBmKGPuIs2EZE+RE6hPLkMtKS+A2dSBmP0=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=X1F1cSPrIbXaFbJHcOXppZIJoVDfCeSf84cfAAYShYe0osaRL7e/qJEePaQwunVeG
	 jyq1076ONyBxq5sSlQtJfx7U2Gmv6M39bIrVN8f+UADSLTwBGE9oqXixRSHE85mRNS
	 EKpXYYduP9S9BbMV5vVvmZmVtgUT4eqqyE/z17q51kAmn7BcwtCNFVG/Y5JDOh3VDP
	 rGEWeYEHvdHnBHVg5YsLUf61YT8Qgvh4tr06Yq4R9Gl/czh5kAqV9OygSYDEmgBQVm
	 jTQQjB8s+gsSQImKnJd8gh9NTfUSvmU9byGB/4vG4grI2DQQ/EB0sr+kwQXdxhfGeI
	 2/55E+sVa8LkA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4G657R5LNgzJSw
 for <lttng-dev@lists.lttng.org>; Fri, 18 Jun 2021 13:11:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 73649345F05;
 Fri, 18 Jun 2021 13:11:41 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Y8lnZ78Fy1sc; Fri, 18 Jun 2021 13:11:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0B9D2345F04;
 Fri, 18 Jun 2021 13:11:37 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0B9D2345F04
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id haVpbEZVXE3U; Fri, 18 Jun 2021 13:11:37 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id F143B345D37;
 Fri, 18 Jun 2021 13:11:36 -0400 (EDT)
Date: Fri, 18 Jun 2021 13:11:36 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Message-ID: <424774796.12773.1624036296954.JavaMail.zimbra@efficios.com>
In-Reply-To: <CADYdroPw9Xnwqx97xQSyiFLR1s-Sb2RvtcbdRGu-VmG0Tfydgg@mail.gmail.com>
References: <CADYdroPw9Xnwqx97xQSyiFLR1s-Sb2RvtcbdRGu-VmG0Tfydgg@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF89 (Linux)/8.8.15_GA_4026)
Thread-Topic: Disabling sys_membarrier in lttng urcu
Thread-Index: fTkCbu8ZNTvPu1TjWhQtg44hRtSm7w==
Subject: Re: [lttng-dev] Disabling sys_membarrier in lttng urcu
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Jun 17, 2021, at 6:13 PM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Hello,
> 
> Some old topic, see
> https://lists.lttng.org/pipermail/lttng-dev/2019-November/029411.html.
> (I actually thought this was solved meanwhile).
> 
> With lttng 2.13 liburcu is replicated in lttng-ust so my old custom
> hack aint helping.
> 
> Aside from another crude hack, I thought about doing this:
> 
> extern int lttng_ust_urcu_has_sys_membarrier;
> int setup() {
>  lttng_ust_urcu_has_sys_membarrier = 0;
> }
> 
> this is obvious possible in my own program, but I don't know if some
> lttng daemon would need to update RCU structures in shared memory that
> should sync to other processes (and wont do that with sys_membarrier
> in case of Xenomai threads)?
> 
> Seems safer to me to hack it out once more...

We currently don't have any RCU synchronization across shared memory,
and the implementation we have in lttng-ust only tracks threads within
the same process, so it would be safe to tweak the lttng-ust-urcu behavior
to use membarrier or not based on an environment variable.

So I think we could expose a new "--disable-sys-membarrier" configure option
to lttng-ust, and maybe add a LTTNG_UST_MEMBARRIER environment variable.
This would likely be 2.14 material though.

I also notice that lttng-ust 2.13's implementation of RCU still refers to
CONFIG_RCU_FORCE_SYS_MEMBARRIER which belongs to liburcu. This is
probably something we'll want to fix right away before we release 2.13
final.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
