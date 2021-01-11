Return-Path: <SRS0=bDS1=GO=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ACDC433E0
	for <lttng-dev@archiver.kernel.org>; Mon, 11 Jan 2021 19:11:01 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 558A522B30
	for <lttng-dev@archiver.kernel.org>; Mon, 11 Jan 2021 19:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558A522B30
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DF3Ft2jXPzPyW;
	Mon, 11 Jan 2021 14:10:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1610392259;
	bh=iicmhE0NlSmN+eCoWsiPCweDmutqX6mMxTHjsGbM2UQ=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=0apuJfEXbEtzx22VfvIfDvkhrCbgHLl7L6rpqvVkY07o5T2Hy2Di4bktGj7aWqp/w
	 fUc2QzzN+soSxgGa4T1VZHE3ydVeT9um4Z3khqjEDoYckVIK5N2sMLxC7lRxQyqX+Z
	 JHikKvq7d1bujlJ1NoBlHQhOUz4kn+0S20406QHgKDS63SMkzA3q0gtx7RtxdGgbMy
	 zDEE+irnyacNYm9moGta0YjoFIhGK9hoEdGyqfa6FpOZ/WhY+vX7c4nudWu3+GcVxY
	 tkqXveUgVZE5n8vtQL14ibsskqApmt3BU+RdlDbJEp+/i3jd+vKlflAm2BPUn8/muG
	 MmKbqM0A8B8Fw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4DF3Fs1VxGzQ88
 for <lttng-dev@lists.lttng.org>; Mon, 11 Jan 2021 14:10:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 94CB5241F31
 for <lttng-dev@lists.lttng.org>; Mon, 11 Jan 2021 14:10:50 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 5fIU6ltaWmJh; Mon, 11 Jan 2021 14:10:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6962A2424E3;
 Mon, 11 Jan 2021 14:10:50 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6962A2424E3
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 2IORqxS2zhVi; Mon, 11 Jan 2021 14:10:50 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 5E3BA2424E2;
 Mon, 11 Jan 2021 14:10:50 -0500 (EST)
Date: Mon, 11 Jan 2021 14:10:50 -0500 (EST)
To: lttng-dev <lttng-dev@lists.lttng.org>, 
 diamon-discuss@lists.linuxfoundation.org, 
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <897024476.10469.1610392250359.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3991 (ZimbraWebClient - FF84 (Linux)/8.8.15_GA_3980)
Thread-Index: 5m5q9JQ/0U77YrT12Q0xQhrp1t7WVA==
Thread-Topic: LTTng-modules 2.11.7 and 2.12.4 (Linux kernel tracer)
Subject: [lttng-dev] [RELEASE] LTTng-modules 2.11.7 and 2.12.4 (Linux kernel
 tracer)
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

Hi,

I just released versions 2.11.7 and 2.12.4 of the lttng-modules stable branches.
These add support for the 5.10 Linux kernel.

Please try them out, and, as usual, feedback is welcome!

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
