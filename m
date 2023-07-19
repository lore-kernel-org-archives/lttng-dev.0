Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE4CEB64DA
	for <lttng-dev@archiver.kernel.org>; Wed, 19 Jul 2023 14:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1689775726;
	bh=Cl1WHrkB+PN0NYGAvcqOIcpLblN7/+GtCYVHPyTZj3U=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=AuIteXNhOsWZw48Efe7hDQRpujs7HqhMDyWaiwkmpDv+LhhOsp2JU7oN3uxbs6aD7
	 5KjO6WWf7jCt3U9pjwQpogPSrHSCYiJrAuhoq0JEL4/ZhMmU/zBU64IngNDDeWjzz0
	 BuF71wU/a2bMAc5zNu6E+Xsqpc95S46qyUyIcoF7aFjqexyC3uY5XUJy6InfbBGTBO
	 ciUQr+dYLnzjsNaXESjJZ2+jbF4HdrUnjtrTxVQa0pW4tbknyAJAGrlKmrGvA7FqfC
	 QuykmMfyH4MimMjmVYsRVDCLWicgKuzYxuz+4+/aKFcERiVp6EqJXqgTmneSLQB5eW
	 5DR4EuU8LRBDg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4R5d314pHLz2CTF;
	Wed, 19 Jul 2023 10:08:45 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4R5d2y0qp5z2CTC
 for <lttng-dev@lists.lttng.org>; Wed, 19 Jul 2023 10:08:41 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4R5d2k0yLvz1JGT;
 Wed, 19 Jul 2023 10:08:30 -0400 (EDT)
Message-ID: <a750cc37-76de-d717-3cce-d26974ca52ea@efficios.com>
Date: Wed, 19 Jul 2023 10:09:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: "Cook, Layne" <Layne.Cook@ballaerospace.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <BN0P110MB0967334AFD6A7CF8DDD3BFBC9238A@BN0P110MB0967.NAMP110.PROD.OUTLOOK.COM>
In-Reply-To: <BN0P110MB0967334AFD6A7CF8DDD3BFBC9238A@BN0P110MB0967.NAMP110.PROD.OUTLOOK.COM>
Subject: Re: [lttng-dev] Status of LTTng-scope and Lttng-analyses
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

On 7/18/23 15:27, Cook, Layne via lttng-dev wrote:
> Can you tell me the status of the beta projects listed on the web site?
> 
> LTTng scope
> LTTng analyses
> 
> The github projects haven't had an activity for quite a while. Have 
> these projects been abandoned, or superceded by something else?

Hi Layne,

Thanks for your interest in those projects!

The LTTng scope beta project was an attempt at doing a significant UX
redesign of Trace Compass, starting from a use-cases/user workflow
perspective. We currently don't have the resources/funding/staff to
work on this project further, so it has not progressed for a while.

You should look at the Trace Compass and VSCode trace extension
projects instead, which have a lot more activity:

https://tracecompass.org
https://github.com/eclipse-cdt-cloud/vscode-trace-extension

The LTTng analyses beta project is a set of python scripts to analyze
LTTng traces. Our original intent with that project was that EfficiOS
would fund the work to create those analyses as prototypes in Python,
and eventually customers would fund the rather large amount of work
required to go from a prototype (slow scripts) to a production quality
project (faster C++ implementation, generic state tracking module).
Unfortunately, this never materialized, so this beta project has been
on the back burner as well.

In the recent years we have focused our efforts on the Babeltrace 2
project and on CTF2 (Common Trace Format version 2).

Feel free to have a look at Trace Compass and VSCode trace extension, and
please let us know if LTTng scope and LTTng analyses fill a gap that is
not covered by those other tools.

Thanks,

Mathieu

> 
> Thanks,
> 
> LC
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
