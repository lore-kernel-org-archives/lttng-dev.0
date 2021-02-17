Return-Path: <SRS0=umfz=HT=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B50C433DB
	for <lttng-dev@archiver.kernel.org>; Wed, 17 Feb 2021 21:31:26 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBCDB6186A
	for <lttng-dev@archiver.kernel.org>; Wed, 17 Feb 2021 21:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCDB6186A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Dgrcr2bY7z28n;
	Wed, 17 Feb 2021 16:31:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1613597484;
	bh=NOy+K4tVjwIY8ZPEydci0HvCvW+2uOkQsc1vlLE5dqc=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=MnKMGjyMT5bg4geZqBk/PGKs1FnMo2R98ED53AzxjePUKcy+X24TQsrh2UxO7K3vZ
	 o3LGYq7SaOUy5ilaVCNvRHBM92wQhky9rQaRD2OiMp6kcKli8/qNcIZak4mlLTV5+1
	 zXd5jE7T0an64E+ZByzDIM6cfpAiQc75/Yhj6eU0Kav0B9ZpB/YEEpVuYTEY4EMu8z
	 bHlvhHfJePqdoMcs64hWGeuWLbNrjt3UJAMORwGFe1YvWmBaIx+TjfzILltcZ2+kz0
	 DMZ0aPiNiOf/wrYmbxb3UbkDXEhqr4WAjTGAEE1sJAMoWsMKg0zujscpWQj+Vz8dOG
	 ZgVxrulFoHhqQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Dgrcp5zRSz26B
 for <lttng-dev@lists.lttng.org>; Wed, 17 Feb 2021 16:31:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 567503247FD
 for <lttng-dev@lists.lttng.org>; Wed, 17 Feb 2021 16:31:16 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id jDVzzbGFUpv3; Wed, 17 Feb 2021 16:31:16 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 17A82324A9D;
 Wed, 17 Feb 2021 16:31:16 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 17A82324A9D
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id SVC0oEEzfjxs; Wed, 17 Feb 2021 16:31:16 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 08276324B30;
 Wed, 17 Feb 2021 16:31:16 -0500 (EST)
Date: Wed, 17 Feb 2021 16:31:15 -0500 (EST)
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org, 
 linux-trace-users@vger.kernel.org, lwn@lwn.net, 
 linux-kernel@vger.kernel.org
Message-ID: <2047339870.25949.1613597475930.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF85 (Linux)/8.8.15_GA_3996)
Thread-Index: ddylPrE4mnqbB+Gwtqxi1jBzmDJ0lA==
Thread-Topic: LTTng-modules 2.11.8 and 2.12.5 (Linux kernel tracer)
Subject: [lttng-dev] [RELEASE] LTTng-modules 2.11.8 and 2.12.5 (Linux kernel
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

This is a release announcement for the 2.11.8 and 2.12.5 releases of the
LTTng kernel tracer.

New and noteworthy in these releases:

* Support for Linux kernel 5.11,
* Deal with stable kernel version overflow (sublevel >= 256),
* Prepare for Ubuntu, SLES, RHEL, and RT release version overflows (which should come sooner
  or later),
* Writeback instrumentation: fix out-of-bound read of block device name beyond terminating
  '\0' character,
* Writeback instrumentation: fix a crash in wb_workfn when a device disappears when memcg
  is in use,
* aarch64: blacklist gcc compiler prior to version 5.1, because they perform unsafe access
  to deallocated stack.

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
