Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B308FC433EF
	for <lttng-dev@archiver.kernel.org>; Thu,  2 Dec 2021 20:20:39 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4J4nQF5Rvlz1pcw;
	Thu,  2 Dec 2021 15:20:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1638476438;
	bh=FwCEiaJhJEKSBFCkUqDYLbpKFvS3ofEIu1lZv5uvqrA=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Z4ruuF9h3m9+GhSU8+apom9vNIq27C0gMYM+w53LVNdwVK1MrFat+gI37oiEkzRxp
	 vabnktL5lG6CFKLQht7+KUqPMYmDX/3K7WshIXg4COx0je63TXaEizR405DTUbHmu0
	 9RFrolI5uVwKz/oXl+deIkl/wUsd+NW2hDND7XjP7TGhdzfZm97nMXzTtoAafifnIT
	 53iCIvFJMq5vsMQyC9D0FJ9qpQWRmt0HBSaBn7qRJkKl8uMda77XmsfdUoIngsAXYQ
	 3A/di6mCnGkOu7l9GJ2tKr8gmyZw7LDAMq9aATxJKWw+3TYThqM3I0BcQR0/w+Z9DK
	 aG874IPCV6MuA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4J4nQD4FW6z1ps5
 for <lttng-dev@lists.lttng.org>; Thu,  2 Dec 2021 15:20:36 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 424FC3798EF;
 Thu,  2 Dec 2021 15:20:30 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id dDFchHxpBudO; Thu,  2 Dec 2021 15:20:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 576DC379BBA;
 Thu,  2 Dec 2021 15:20:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 576DC379BBA
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id TjIO7GLuxyQ6; Thu,  2 Dec 2021 15:20:28 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 494D73799F4;
 Thu,  2 Dec 2021 15:20:28 -0500 (EST)
Date: Thu, 2 Dec 2021 15:20:28 -0500 (EST)
To: Alexander Kanavin <alex@linutronix.de>
Message-ID: <1348532811.12349.1638476428245.JavaMail.zimbra@efficios.com>
In-Reply-To: <20211202200412.146288-1-alex@linutronix.de>
References: <20211202200412.146288-1-alex@linutronix.de>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4173 (ZimbraWebClient - FF94 (Linux)/8.8.15_GA_4177)
Thread-Topic: lttng-ust-common: link with liburcu explicitly
Thread-Index: IPpdverKfU8/19raS7MrguoOKXR32Q==
Subject: Re: [lttng-dev] [PATCH] lttng-ust-common: link with liburcu
 explicitly
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
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Alexander,

Thanks for sending this patch. Could you provide more details regarding the linking errors?

lttng-ust must not depends on liburcu at runtime since commit 10544ee8af31afb239e3dfa71cb2fe09d3de3771

commit 10544ee8af31afb239e3dfa71cb2fe09d3de3771
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Wed Nov 11 17:28:06 2020 -0500

    Remove runtime dependency on liburcu shared objects
    
    Remove the runtime dependency on:
    
    - liblurcu-bp.so
    - liblurcu-cds.so
    - compat futex code.
    
    By integrating those into the lttng-ust project.
    
    For rculfhash, only the minimum pieces needed by lttng-ust are
    integrated (no auto-resize, no accounting).
    
    lttng-ust still requires liburcu at build time for header dependencies.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Change-Id: Idffb205b27b1bb0f972523c3ce3bdaf25bfe1710


Cheers 

----- Original Message -----
> From: "Alexander Kanavin" <alex@linutronix.de>
> To: "lttng-dev" <lttng-dev@lists.lttng.org>, "Francis Deslauriers" <francis.deslauriers@efficios.com>, "jonathan
> rajotte-julien" <jonathan.rajotte-julien@efficios.com>
> Cc: "Alexander Kanavin" <alex@linutronix.de>
> Sent: Thursday, December 2, 2021 3:04:12 PM
> Subject: [PATCH] lttng-ust-common: link with liburcu explicitly

> Otherwise linking errors are seen on x86-32.
> ---
> src/lib/lttng-ust-common/Makefile.am | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/src/lib/lttng-ust-common/Makefile.am
> b/src/lib/lttng-ust-common/Makefile.am
> index caeea2be..0130628c 100644
> --- a/src/lib/lttng-ust-common/Makefile.am
> +++ b/src/lib/lttng-ust-common/Makefile.am
> @@ -15,6 +15,7 @@ liblttng_ust_common_la_SOURCES = \
> 
> liblttng_ust_common_la_LIBADD = \
> 	$(top_builddir)/src/common/libcommon.la \
> +	$(URCU_LIBS) \
> 	$(DL_LIBS)
> 
> liblttng_ust_common_la_LDFLAGS = -no-undefined -version-info
> $(LTTNG_UST_LIBRARY_VERSION)
> --
> 2.20.1
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
