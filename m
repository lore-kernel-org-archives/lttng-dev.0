Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9376FC00140
	for <lttng-dev@archiver.kernel.org>; Tue,  2 Aug 2022 20:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1659470714;
	bh=hE7ccrtfRbB7Pd+6OUCIxSHhlXvuEydi8HbNfOK9B1o=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=La1LYfjPiczjLLFZVi/qupeXzXYMoMN306CGLtweY9Xt0uBMEW2AzLKDVmpXRlIKs
	 VAktzelLub/VP6dzad8Rqmxwe8HOpHvuMw8b1och9+ztLy20Nvly2HBIGbaD4LTxmP
	 OKySibRSxUY6fmwy9JvUxNAwH/FPciG7FgM1UmQ1WSTws2HgbEHKni/12afspkrvSj
	 dwah06iIeJAKyHKI3rbGknbo0u+YLinO9dT/07QCJ6iGrWm/dpIIbL7Jsd+nkfMlPk
	 5VXCbW3yJRCGQt+7luGVxZVCgj6OzPJ/ZuepSzC9Qbj4afsg2HsCfsq7PavJuIT+Oh
	 YsvLOVAZWuc3w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Ly5ZK5977z11gH;
	Tue,  2 Aug 2022 16:05:13 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Ly5ZH5QWdz11TT
 for <lttng-dev@lists.lttng.org>; Tue,  2 Aug 2022 16:05:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 09B403BC897
 for <lttng-dev@lists.lttng.org>; Tue,  2 Aug 2022 16:05:11 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id foziRVw2U2xy; Tue,  2 Aug 2022 16:05:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 36D4A3BC649;
 Tue,  2 Aug 2022 16:05:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 36D4A3BC649
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id oX0OmLEDjF6q; Tue,  2 Aug 2022 16:05:10 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 268F93BC915;
 Tue,  2 Aug 2022 16:05:10 -0400 (EDT)
Date: Tue, 2 Aug 2022 16:05:10 -0400 (EDT)
To: Shao-Tse Hung <ccs100203@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <402030873.96651.1659470710067.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220802174400.219630-1-ccs100203@gmail.com>
References: <20220802174400.219630-1-ccs100203@gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4304)
Thread-Topic: revise obsolete command in README.md
Thread-Index: kq55bRucn+ET3dWQR/wjqXsCv+Zvpg==
Subject: Re: [lttng-dev] [PATCH] Fix: revise obsolete command in README.md
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Aug 2, 2022, at 1:44 PM, Shao-Tse Hung via lttng-dev lttng-dev@lists.lttng.org wrote:

> The obsolete command `make bench` was replaced by `make short_bench` and `make
> long_bench` in 2015.
> However, this command wasn't revised in README, so I follow the previous commit
> and rewrite it.

Merged into liburcu master, 0.13, 0.12 branches, thanks!

Mathieu

> 
> Signed-off-by: Shao-Tse Hung <ccs100203@gmail.com>
> ---
> README.md | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/README.md b/README.md
> index a8318c8..1e75589 100644
> --- a/README.md
> +++ b/README.md
> @@ -426,14 +426,15 @@ Make targets
> ------------
> 
> In addition to the usual `make check` target, Userspace RCU features
> -`make regtest` and `make bench` targets:
> +`make regtest`, `make short_bench` and `make long_bench` targets:
> 
>   - `make check`: short tests, meant to be run when rebuilding or
>     porting Userspace RCU.
>   - `make regtest`: long (many hours) test, meant to be run when
>     modifying Userspace RCU or porting it to a new architecture or
>     operating system.
> -  - `make bench`: long (many hours) benchmarks.
> +  - `make short_bench`: short benchmarks, 3 seconds per test.
> +  - `make long_bench`: long (many hours) benchmarks, 30 seconds per test.
> 
> 
> Known issues
> --
> 2.25.1
> 
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
