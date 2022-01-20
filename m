Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E701C433EF
	for <lttng-dev@archiver.kernel.org>; Thu, 20 Jan 2022 15:24:12 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JfmWZ53tZzKcf;
	Thu, 20 Jan 2022 10:24:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642692251;
	bh=TzO6uG3AhZe4OYNR99f8P2QtxuDMm2TFT8nTUFSgGWk=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=T8xxqZB4lCPUhq2mTEG2qLunyjvaBU4ur7YstgMsRRMhElzw1xcyieGXAgw+NJPL3
	 AvA8L3GYzOPmZesRLuPwEi04nvfP39eHbcRAHNxMLYvUF7C4RUJEXfMUbYgkUANaKD
	 TxMUjZxCEO9mgfNhC09bF+ySA1ASWJSEaHX1oUByGp/4Fa1b+63ynWwoEbBXpHcrbc
	 laMXo2S/7jAFzu8a6m+fXvTl1DSMvcS0K6j4A0p/w0HZ3+djyp7yYTa0Fm6LKaErAv
	 slXyzbYejIXNh3XvmtRV2qCI+zdlNSILkQwBvic52AboYPxoGt4iTvMcdvb+0m78tY
	 FWjYGQb8Yjpxw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JfmWY1fqtzKrS
 for <lttng-dev@lists.lttng.org>; Thu, 20 Jan 2022 10:24:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DD5E7322BAC;
 Thu, 20 Jan 2022 10:24:03 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 5i3iN3XogOSv; Thu, 20 Jan 2022 10:24:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 83EAF322BAB;
 Thu, 20 Jan 2022 10:24:03 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 83EAF322BAB
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id jQBm4JJhSSig; Thu, 20 Jan 2022 10:24:03 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 7A199322BA7;
 Thu, 20 Jan 2022 10:24:03 -0500 (EST)
Date: Thu, 20 Jan 2022 10:24:03 -0500 (EST)
To: Jonathan Rajotte-Julien <joraj@efficios.com>
Cc: jonathan r julien <jonathan.r.julien@gmail.com>, 
 Jeremie Galarneau <jgalar@efficios.com>, 
 lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1245543732.61838.1642692243480.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Index: 5xfAjecjKPFE2k+xr0i9HcsY4siaYw==
Thread-Topic: Transfer of LTTng copyright ownership: Jonathan Rajotte-Julien
Subject: [lttng-dev] Transfer of LTTng copyright ownership: Jonathan
 Rajotte-Julien
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

Hi Jonathan,

In order to facilitate maintenance of the LTTng project, would you agree to
transfer your copyright ownership for code authored outside of your employment
at EfficiOS to EfficiOS Inc. ?

This particularly affects the lttng-tools files with copyright:

  Copyright (C) 201N Jonathan Rajotte <jonathan.r.julien@gmail.com>

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
