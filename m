Return-Path: <SRS0=Hq7A=FN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334D6C4361B
	for <lttng-dev@archiver.kernel.org>; Wed,  9 Dec 2020 18:29:52 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 771B023C8F
	for <lttng-dev@archiver.kernel.org>; Wed,  9 Dec 2020 18:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771B023C8F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Crlvd5LZdz1WHG;
	Wed,  9 Dec 2020 13:29:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1607538590;
	bh=KTGpDsGNuqEsgoiiD6wTHhbt2lMFN7IIi7ol6GBpr8A=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Gax3ZdJ7FuCJedPI7NUxyGfn/J4MALfiIBk/U9Ekt0AUoNP1vNYXnzSXdg47WUzfk
	 Arm2CwRwR0vlnPQp4vVH0qwQ1GvGSqGFkGNUGwcV0H2UmTM0Qy7qGSkKE7LZe5cqLW
	 g/U2HVxxadyOhT69wNKZjKRiPBdmuCufhtDhlgbo1fgkaHQgi4AV8gpo/o95uYOY07
	 YBiZ/lVFHlTsZnEIZARex7EuZybNtC+xjledH6RBLH10xEvpl5K20Ld7uP6uMW73GC
	 lnC4/ohPtMyRZKU081i//Qx7iUuFWl8YAYe1s+yD13BDX8d0Aud1SSh+l+5Qu3eG5p
	 UXMKMmOmAKp/A==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Crlvc0vLJz1WHD
 for <lttng-dev@lists.lttng.org>; Wed,  9 Dec 2020 13:29:48 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A0B422FE1BB;
 Wed,  9 Dec 2020 13:29:47 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id BznsuoCZcMIy; Wed,  9 Dec 2020 13:29:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 56CCE2FE287;
 Wed,  9 Dec 2020 13:29:47 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 56CCE2FE287
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id AUE_N9TBZQ-s; Wed,  9 Dec 2020 13:29:47 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 498782FE232;
 Wed,  9 Dec 2020 13:29:47 -0500 (EST)
Date: Wed, 9 Dec 2020 13:29:47 -0500 (EST)
To: paulmck <paulmck@kernel.org>
Message-ID: <1681186936.97276.1607538587190.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201209181537.444048-1-mjeanson@efficios.com>
References: <20201209181537.444048-1-mjeanson@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3980)
Thread-Topic: bump tests thread limit to 256
Thread-Index: 00UcESq6Kf2rE9fwpl025Y04w8xMTw==
Subject: Re: [lttng-dev] [PATCH urcu] fix: bump tests thread limit to 256
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Paul,

Should I merge this temporary fix for liburcu tests, or should we go
for dynamic allocation of the array right away instead ?

Thanks,

Mathieu

----- On Dec 9, 2020, at 1:15 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Machines with more than 128 CPUs are becomming more common, the proper
> fix here would be to dynamically allocate the array which we will do,
> but in the meantime bump the limit to 256 to fix the problem on a 160
> CPUs ppc64el system where this was reported.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Change-Id: Ib3cb5d8cb4515e6f626be33c2685fa38cb081782
> ---
> tests/common/api.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/common/api.h b/tests/common/api.h
> index 2b72ec5..b15e588 100644
> --- a/tests/common/api.h
> +++ b/tests/common/api.h
> @@ -108,7 +108,7 @@ static void spin_unlock(spinlock_t *sp)
> 
> typedef pthread_t thread_id_t;
> 
> -#define NR_THREADS 128
> +#define NR_THREADS 256
> 
> #define __THREAD_ID_MAP_EMPTY ((thread_id_t) 0)
> #define __THREAD_ID_MAP_WAITING ((thread_id_t) 1)
> --
> 2.29.2

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
