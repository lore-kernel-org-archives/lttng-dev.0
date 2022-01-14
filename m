Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A58C433EF
	for <lttng-dev@archiver.kernel.org>; Fri, 14 Jan 2022 19:31:16 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JbBHR01KbzFPD;
	Fri, 14 Jan 2022 14:31:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642188675;
	bh=vQWmYg4qS1xLE6rYtRapTY9crJnXgyX0ajSnR3MORB0=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=Q7MmMGNG5FrEYPuo1DBfO5QeeoJF8dgLvaqh9Pq/thNd2LLrfA1CsWoJVJjubuTeg
	 i5LDmiKF6LipqZbZ2762WtYvDCXXVmhMuduQVJfRBT09kT6tYZqlGxMl78lG4ehota
	 eQTuvhqbCWqzSHUVNkTOcRXc/IDgYk0GVYQCc98xx6BR64Pz9pDGNn/P/ThekQLFmi
	 bCEn2r0992AaQKc+iTPJ+B9ycPf3X6zpX27TIoBKGVbaYouZM/peRxQHR9cVKXko7J
	 UTWHPHX7XbPR/ZFcNOSZsEyYULWzANK+7ZgEI7+YFKbilUvRsnfH1ReuVP19L/OVV6
	 6tdBxw30uL1ug==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JbBHP1t4yzFV5
 for <lttng-dev@lists.lttng.org>; Fri, 14 Jan 2022 14:31:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DB8D12D54B4;
 Fri, 14 Jan 2022 14:31:07 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id mfLBz_bEY7IH; Fri, 14 Jan 2022 14:31:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 53A0F2D504A;
 Fri, 14 Jan 2022 14:31:02 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 53A0F2D504A
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 3A3T1LBhvwCv; Fri, 14 Jan 2022 14:31:02 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 47E172D5049;
 Fri, 14 Jan 2022 14:31:02 -0500 (EST)
Date: Fri, 14 Jan 2022 14:31:02 -0500 (EST)
To: David Goulet <dgoulet@ev0ke.net>
Cc: Jeremie Galarneau <jgalar@efficios.com>, 
 lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1116808546.33968.1642188662159.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Index: TcK5Z1ar3PeWnJzjmxECmHDNTYyLrw==
Thread-Topic: Transfer of LTTng copyright ownership: David Goulet
Subject: [lttng-dev] Transfer of LTTng copyright ownership: David Goulet
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

Hi David,

In order to facilitate maintenance of the LTTng project, would you agree to
transfer your copyright ownership for code authored outside of your employment
at EfficiOS to EfficiOS Inc. ?

This particularly affects the lttng-tools and lttng-ust files with copyright:

Copyright (C) 201N David Goulet <david.goulet@polymtl.ca>

Thanks again for all your contributions to LTTng !

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
