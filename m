Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706EDC433F5
	for <lttng-dev@archiver.kernel.org>; Wed,  5 Jan 2022 21:31:15 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JTjN209cszBQ6;
	Wed,  5 Jan 2022 16:31:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1641418274;
	bh=+Y4ZWXLHnOOpFH/FDCL+CbeODj7oioQ1varKfADwn2A=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ExRpgM1Bk70yG5xc5/ESBMT5RTmwoxFTDhGpcrJrOZfzw2j0fL7Fyux3Uvmnd7mLm
	 MGolXTEafi10g87cDWrFUPlE1azpuN+/xN3X00RKFFMpuarGTNfXcDvy5c5gUdqYFU
	 /ZsAbT24y/Qwul4iIMn9TrDpBUzeRhV88UPRom6L0OOXJIOhdKkXy2e5beEUtWiw1g
	 UodNStz3WX5G3AuHgHoGCv1nHCcklq5DoSSMnqslKMw71wcNix9ajd1tO69Th80Qr2
	 5/xgtndXu4D8WrW+WmdkU8U1kyqsfBw37lsyRJgZOrMCHig7MASqbGEqHDI1RnEnX8
	 vylo7cbCSk9+w==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JTjMz6vFMz7gn
 for <lttng-dev@lists.lttng.org>; Wed,  5 Jan 2022 16:31:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 537A53C9B27
 for <lttng-dev@lists.lttng.org>; Wed,  5 Jan 2022 16:31:05 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id xC3aI1Eo1gbY; Wed,  5 Jan 2022 16:31:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 142573C9BB5;
 Wed,  5 Jan 2022 16:31:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 142573C9BB5
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id gT_DXEVSHCvQ; Wed,  5 Jan 2022 16:31:05 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 097843C9BB4;
 Wed,  5 Jan 2022 16:31:05 -0500 (EST)
Date: Wed, 5 Jan 2022 16:31:05 -0500 (EST)
To: lttng-dev <lttng-dev@lists.lttng.org>, 
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>, 
 linux-trace-users <linux-trace-users@vger.kernel.org>
Message-ID: <739463869.5555.1641418265020.JavaMail.zimbra@efficios.com>
In-Reply-To: <697935027.5550.1641418043715.JavaMail.zimbra@efficios.com>
References: <697935027.5550.1641418043715.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF95 (Linux)/8.8.15_GA_4177)
Thread-Topic: LTTng-UST 2.12.3 and 2.11.5 (Linux user-space tracer)
Thread-Index: m7GiKJygw0akYxq/Mbpwf/qNqXu0iQenq/5J
Subject: Re: [lttng-dev] [RELEASE] LTTng-UST 2.12.3 and 2.11.5 (Linux
 user-space tracer)
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
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

----- On Jan 5, 2022, at 4:27 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Hi,
> 
> This is a release announcement for the LTTng-UST 2.12.3 and 2.11.5
> tracer. Those are bug fix releases.
> 
> The 2.11.5 release marks the end of life (EOL) of the stable-2.11 branch.
> Users experiencing issues with the 2.11 branch are expected to upgrade to
> either 2.12.3 or 2.13.1.
> 
> Note that the latest stable branch is 2.13 (its most recent release
> is 2.13.1, released on December 10, 2021).
> 
> * Notable changes in 2.12.3:
> 
> Two notable fixes are "Fix: nestable pthread cancelstate" and
> "Fix: abort on decrement_sem_count during concurrent tracing start and
> teardown",
> which fix a rare deadlock scenario at application exit.

Just as a clarification, the second fix corrects a race scenario triggering an
assertion failure.

Thanks,

MAthieu

> 
> Another notable fix is "fix: liblttng-ust-fd async-signal-safe close()", which
> ensures that the implementation of the symbol interposition for "close" is
> async-signal safe, as it should be.
> 
> Please refer to the change logs below for the fixes contained in those
> two releases.
> 
> Feedback is welcome,
> 
> Thanks,
> 
> Mathieu
> 
> Project website: https://lttng.org
> Documentation: https://lttng.org/docs
> Download link: https://lttng.org/download
> 
> 
> 2022-01-05 (National Bird Day) lttng-ust 2.12.3
>        * Fix: ust-cancelstate: include string.h for strerror
>        * Fix: lttng-ust-fd: remove lttng_ust_common_ctor call
>        * Fix: nestable pthread cancelstate
>        * Fix: abort on decrement_sem_count during concurrent tracing start and teardown
>        * fix: liblttng-ust-fd async-signal-safe close()
>        * Set git-review branch to stable-2.12
>        * fix: link benchmark with pthread
>        * Fix: liblttng-ust-ctl have dependencies on liburcu
>        * Fix: add extern "C" to two header files
> 
> 2022-01-05 (National Bird Day) lttng-ust 2.11.5
>        * Set git-review branch to stable-2.11
>        * fix: allow building with userspace-rcu 0.13
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
