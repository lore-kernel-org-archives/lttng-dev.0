Return-Path: <SRS0=8fC+=KJ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CD2C433B4
	for <lttng-dev@archiver.kernel.org>; Fri, 14 May 2021 19:43:32 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B4561446
	for <lttng-dev@archiver.kernel.org>; Fri, 14 May 2021 19:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B4561446
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fhf8f0tPNz1nry;
	Fri, 14 May 2021 15:43:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621021410;
	bh=rgBujzuSvlUfRVyhoiBYdLwWkE739AID7WHDQuoaiGQ=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=N9W1NnT8fPdXoO+RPV79ZGx4c/37bHMquaYtWCjVlrLrPrptgkEtTKfiNi/XKPZHu
	 cpEqnedqMDQzw9oJtkS0YWTDS8g41goKqDLqOIoP/IMUtg7ikyPotKPSpX2aUQzR6B
	 vrPMDmlFRFSe3bO5tERd84FgUGgrvfcooRPVaeLO/w6c2UyRw95gETrcOU/ohn1Uoy
	 hPjVmudnVnpLc1EF0FNUXCTlBm+T4RYgFZB/e60R8n809/aEWZoQaPNQlLUdfTNtrg
	 uIaSiE0froEtzT8tcNnRqMMuwfMfhj+nZnwTvm7pC+Geh83XjQGv9rOq43Ez4xyrUC
	 NKj8IlHwZq1Yg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fhf8c3pNbz1nx9
 for <lttng-dev@lists.lttng.org>; Fri, 14 May 2021 15:43:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3445D2B8145
 for <lttng-dev@lists.lttng.org>; Fri, 14 May 2021 15:43:22 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 1QqT508Wc5II; Fri, 14 May 2021 15:43:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B266A2B8144;
 Fri, 14 May 2021 15:43:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B266A2B8144
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id TZRCHk2-JUaA; Fri, 14 May 2021 15:43:21 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id A3E27347F54;
 Fri, 14 May 2021 15:43:21 -0400 (EDT)
Date: Fri, 14 May 2021 15:43:21 -0400 (EDT)
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org, 
 linux-trace-users@vger.kernel.org
Message-ID: <614865397.45958.1621021401586.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4007)
Thread-Index: kFZthwqSfcVZZuZbbWCEFO1VhIFCtg==
Thread-Topic: LTTng-UST 2.11.4 and 2.12.2
Subject: [lttng-dev] [RELEASE] LTTng-UST 2.11.4 and 2.12.2
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

LTTng-UST 2.11.4 and 2.12.2 are bug fix releases of the LTTng-UST user-space tracer for the
2.11 and 2.12 stable branches.

There are a few fixes, as well as a in-depth rework of the benchmark code which was sitting
in the tests of lttng-ust. This test code was contributed more than 10 years ago before I took
maintainership of the LTTng-UST project, and it was in a broken state (always returned
0 second on my test machine because it was truncating significant digits). So I reworked the
benchmark in the 2.11 and 2.12 stable branches to facilitate comparison of benchmarks between
branches, especially given the major rework done in the upcoming 2.13 version.

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
