Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9D6C43334
	for <lttng-dev@archiver.kernel.org>; Tue, 19 Jul 2022 19:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1658259624;
	bh=gu/x+ZU6YpHj5grSjYQsAEenYMw9C5bnij2QFj+5ue4=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=NGLKFm8gyqIe0ksstiy81eZKzjQrf2trlh4P7c5BTSzSHgWEDV6F1sT8GY2bA6R0V
	 00IQyrNg52tfnfRc2OQD15oCr2Ru4pgCYAEs3UheaTtB/iKXAu/0ZyS2ZajPRD7oy5
	 gZh4uwUkICHqNzHtfHUYXZpoz9STjhTmp9M0qbW/rmpi/f1qhzdPJ73rEtZdmxPjyG
	 /DpOmI39W1GMq0TWRRI6PoovMUvXtU+62XthStz0fkotpq/G/+1WIVBH5ds9Y1nC0Q
	 qaINefDoQjV/nrDFnGhQQCU4Q4tSuzqjif4or0ZsmZyapusvZi9LkBghsJzS9M08Ym
	 4sZOrABcOiYng==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LnTh81tT9zPjQ;
	Tue, 19 Jul 2022 15:40:24 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LnTh66QsqzPlY
 for <lttng-dev@lists.lttng.org>; Tue, 19 Jul 2022 15:40:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D70CE43138F
 for <lttng-dev@lists.lttng.org>; Tue, 19 Jul 2022 15:40:22 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id XJK6VFUUge8w; Tue, 19 Jul 2022 15:40:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 78E25430FDA;
 Tue, 19 Jul 2022 15:40:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 78E25430FDA
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id TL6yr2qzXmY9; Tue, 19 Jul 2022 15:40:22 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 6FEEE431400;
 Tue, 19 Jul 2022 15:40:22 -0400 (EDT)
Date: Tue, 19 Jul 2022 15:40:22 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1308824469.74177.1658259622444.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220718215955.124991-2-nolange79@gmail.com>
References: <20220718215955.124991-1-nolange79@gmail.com>
 <20220718215955.124991-2-nolange79@gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4304)
Thread-Topic: lttng_ust_init_thread: call urcu_register_thread
Thread-Index: wJ/Oo57altjncr6y343E0vAP0mLtaA==
Subject: Re: [lttng-dev] [PATCH 2/2] lttng_ust_init_thread: call
 urcu_register_thread
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

----- On Jul 18, 2022, at 5:59 PM, Norbert Lange via lttng-dev lttng-dev@lists.lttng.org wrote:

> Eagerly register the thread, and avoid taking mutex during the
> first tracepoint.

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Please resubmit with the next round with my acked-by tag.

Mathieu

> 
> Signed-off-by: Norbert Lange <nolange79@gmail.com>
> ---
> src/lib/lttng-ust/lttng-ust-comm.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/src/lib/lttng-ust/lttng-ust-comm.c
> b/src/lib/lttng-ust/lttng-ust-comm.c
> index ba0bd985..3ff6b086 100644
> --- a/src/lib/lttng-ust/lttng-ust-comm.c
> +++ b/src/lib/lttng-ust/lttng-ust-comm.c
> @@ -447,6 +447,8 @@ void lttng_ust_init_thread(void)
> 	 * this thread attempts to use them.
> 	 */
> 	lttng_ust_alloc_tls(true);
> +
> +	lttng_ust_urcu_register_thread();
> }
> 
> int lttng_get_notify_socket(void *owner)
> --
> 2.35.1
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
