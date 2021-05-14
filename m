Return-Path: <SRS0=8fC+=KJ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248F4C433B4
	for <lttng-dev@archiver.kernel.org>; Fri, 14 May 2021 19:52:58 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1AEA61444
	for <lttng-dev@archiver.kernel.org>; Fri, 14 May 2021 19:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AEA61444
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FhfMX2YnRz1p32;
	Fri, 14 May 2021 15:52:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621021976;
	bh=1fwy/CPmtUUGmr5a5MWb0mnAemFe3Lg+T3Cxpe0ooSU=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=SVCYQIN9iZ9SAB7/pRYqpzEA34FxZgCr/+06UHxTf6evrUM20NQqS75YruJLUz0BJ
	 Th9+V5Msk2ksqd+fBJv2eIBkUUEjG7Bbq3MrMdp9Kyj4k9EeYCGCwiNpsg6E43cfv8
	 +ArAD8XmkH3qzg96sM8iZt35s6ffNZMgeiISEVpBERVpW+2kl43ksy++XakvIpVl5q
	 lGXB5GPFu1rkJ2DHtbbs//eeJnbZlY1rHVbHKP/VI/e0a7LCVtVFATr+itwYp7Djrc
	 WBT8/pGYtYU/vDOq4JzY4DV8SoKE9CFkLlHfpDYix8XthnQOmegkOua1Y93clNyJPO
	 p79nJlS1LdW5A==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FhfMV5rFqz1nm1
 for <lttng-dev@lists.lttng.org>; Fri, 14 May 2021 15:52:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4E1952B81CF
 for <lttng-dev@lists.lttng.org>; Fri, 14 May 2021 15:52:48 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id S2ANtn8JU_DC; Fri, 14 May 2021 15:52:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D27E02B81CD;
 Fri, 14 May 2021 15:52:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D27E02B81CD
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id YQ5j_0FY7UXp; Fri, 14 May 2021 15:52:47 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id C52D22B81CC;
 Fri, 14 May 2021 15:52:47 -0400 (EDT)
Date: Fri, 14 May 2021 15:52:47 -0400 (EDT)
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org, 
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1336422991.46023.1621021967687.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4007)
Thread-Index: 7GWFwXFXkLY7KtGgWu1JPUyXPl1Bvg==
Thread-Topic: LTTng-modules 2.11.9 and 2.12.6 (Linux kernel tracer)
Subject: [lttng-dev] [RELEASE] LTTng-modules 2.11.9 and 2.12.6 (Linux kernel
 tracer)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

The 2.11.9 and 2.12.6 releases of the LTTng kernel tracer are the latest bug fix releases
of the 2.11 and 2.12 stable branches of the LTTng modules project.

There are a few minor bug fixes, but those are the noteworthy changes:

- Support for 5.12 Linux kernels,
- Support recent stable kernel branches 4.14, 4.19, 5.4,
- Support for newer Ubuntu 4.15, 5.4 and RHEL 8.2/8.3 kernels,
- Fix: increment buffer offset when failing to copy from user-space:

    Upon failure to copy from user-space due to failing access ok check, the
    ring buffer offset is not incremented, which could generate unreadable
    traces because we don't account for the padding we write into the ring
    buffer.
    
    Note that this typically won't affect a common use-case of copying
    strings from user-space, because unless mprotect is invoked within a
    narrow race window (between user strlen and user strcpy), the strlen
    will fail on access ok when calculating the space to reserve, which will
    match what happens on strcpy.

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
