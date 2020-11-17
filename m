Return-Path: <SRS0=YxZC=EX=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CB2C63798
	for <lttng-dev@archiver.kernel.org>; Tue, 17 Nov 2020 20:34:26 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1681C21D40
	for <lttng-dev@archiver.kernel.org>; Tue, 17 Nov 2020 20:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="fO7Nca0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1681C21D40
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CbHjW0VFGz1JhP;
	Tue, 17 Nov 2020 15:34:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1605645263;
	bh=32NaXSY6atJBG8Zh6qKoxOVRskAjiQyA7xzwl0pYxXU=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=fO7Nca0jBVOxnzO9A+kpSZi+DTK/GRn/z1szCiyZXlgF38CozEKUAEzpENeBFf4aj
	 dDTkFQ9gPfSWOA6Fb3EdT742aWUi/hf5agiZCLDlQFcs0NjV/rNhlLlWKBApUI81iE
	 Vnl4oOgvSg8RNabXU1H2HQvF5vj6q4j/mVSBPH0eYY2FQGQXlZ1db+72OpPf4iv2f0
	 NFU0PUJe/Z/4IX+fx2SbTvQelx901NgxDW6Vx0SQmU8rj0PUpEXmtsVdohND0a0Ysp
	 JDEslSKuLbAsGSQ1JP7mOMmuXNMb2/ny1Qj4Q40VQtcn7CosqU9e5L78TWM3xAxXhx
	 5B03TZSAsBjCw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CbHjT47v9z1JhJ
 for <lttng-dev@lists.lttng.org>; Tue, 17 Nov 2020 15:34:21 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id F06852E3CD7;
 Tue, 17 Nov 2020 15:34:15 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id YgX3NZytb8Es; Tue, 17 Nov 2020 15:34:15 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A13F02E3CD6;
 Tue, 17 Nov 2020 15:34:15 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A13F02E3CD6
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Z_UgTjlesAVS; Tue, 17 Nov 2020 15:34:15 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 97FB02E3CD3;
 Tue, 17 Nov 2020 15:34:15 -0500 (EST)
Date: Tue, 17 Nov 2020 15:34:15 -0500 (EST)
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1715318277.48429.1605645255528.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201117202224.83751-1-mjeanson@efficios.com>
References: <20201117202224.83751-1-mjeanson@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3975 (ZimbraWebClient - FF82 (Linux)/8.8.15_GA_3975)
Thread-Topic: explicitly include urcu/config.h in files using CONFIG_RCU_
 defines
Thread-Index: i0HSm4Q88bfvkPjkAPdQ2NzFpO0Gvg==
Subject: Re: [lttng-dev] [PATCH urcu] fix: explicitly include urcu/config.h
 in files using CONFIG_RCU_ defines
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

Merged into master, stable-0.11, stable-0.12, thanks!

Mathieu

----- On Nov 17, 2020, at 3:22 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> include/urcu/debug.h       | 2 ++
> include/urcu/uatomic/x86.h | 1 +
> include/urcu/urcu-qsbr.h   | 2 ++
> src/urcu-bp.c              | 1 +
> src/urcu-utils.h           | 2 ++
> src/urcu.c                 | 1 +
> 6 files changed, 9 insertions(+)
> 
> diff --git a/include/urcu/debug.h b/include/urcu/debug.h
> index 14b50b6..4a7eac9 100644
> --- a/include/urcu/debug.h
> +++ b/include/urcu/debug.h
> @@ -21,6 +21,8 @@
> 
> #include <assert.h>
> 
> +#include <urcu/config.h>
> +
> #if defined(DEBUG_RCU) || defined(CONFIG_RCU_DEBUG)
> #define urcu_assert(...)	assert(__VA_ARGS__)
> #else
> diff --git a/include/urcu/uatomic/x86.h b/include/urcu/uatomic/x86.h
> index 129a2f5..2a4ea1c 100644
> --- a/include/urcu/uatomic/x86.h
> +++ b/include/urcu/uatomic/x86.h
> @@ -20,6 +20,7 @@
>  * Boehm-Demers-Weiser conservative garbage collector.
>  */
> 
> +#include <urcu/config.h>
> #include <urcu/compiler.h>
> #include <urcu/system.h>
> 
> diff --git a/include/urcu/urcu-qsbr.h b/include/urcu/urcu-qsbr.h
> index 28e6065..fd6cbda 100644
> --- a/include/urcu/urcu-qsbr.h
> +++ b/include/urcu/urcu-qsbr.h
> @@ -31,6 +31,8 @@
> #include <stdlib.h>
> #include <pthread.h>
> 
> +#include <urcu/config.h>
> +
> /*
>  * See urcu/pointer.h and urcu/static/pointer.h for pointer
>  * publication headers.
> diff --git a/src/urcu-bp.c b/src/urcu-bp.c
> index 05efd97..c2ac792 100644
> --- a/src/urcu-bp.c
> +++ b/src/urcu-bp.c
> @@ -37,6 +37,7 @@
> #include <stdbool.h>
> #include <sys/mman.h>
> 
> +#include <urcu/config.h>
> #include <urcu/arch.h>
> #include <urcu/wfcqueue.h>
> #include <urcu/map/urcu-bp.h>
> diff --git a/src/urcu-utils.h b/src/urcu-utils.h
> index 407f42e..69e37bd 100644
> --- a/src/urcu-utils.h
> +++ b/src/urcu-utils.h
> @@ -23,6 +23,8 @@
>  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>  */
> 
> +#include <urcu/config.h>
> +
> #define urcu_stringify(a) _urcu_stringify(a)
> #define _urcu_stringify(a) #a
> 
> diff --git a/src/urcu.c b/src/urcu.c
> index f6ca5f8..2ebe993 100644
> --- a/src/urcu.c
> +++ b/src/urcu.c
> @@ -38,6 +38,7 @@
> #include <stdbool.h>
> #include <poll.h>
> 
> +#include <urcu/config.h>
> #include <urcu/arch.h>
> #include <urcu/wfcqueue.h>
> #include <urcu/map/urcu.h>
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
