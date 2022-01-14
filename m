Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F086CC433F5
	for <lttng-dev@archiver.kernel.org>; Fri, 14 Jan 2022 20:51:00 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JbD3R6x34zFYB;
	Fri, 14 Jan 2022 15:50:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642193460;
	bh=WVKYKYcIA56WJW9a7YzQN+x8RYRGW5BmY4aqRZvmYS0=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=ZoOkAQQQpVo3g5XpWaecezQZpsCXU8VnmI8FstN74XuWg2B/57XF8gRBk56yI6BCK
	 b8YeeDZvG1O5tD0MU3MbbXUk6hvo5urdijydf4hafBzi/hKRi6Evr2XdEdxFF8sW/5
	 NYoP+pulhkZ6gbmkpCaIjmMD8rjRFtXK/tfafM8rBCJrm2xr62wRylabRQ7+GoRatT
	 nxZaKw8LrT+0J8ZPtuqwNuRouWyZcJkc95YXYZZaeZ5pUGiVGhKapnTLSTNRUdkXoV
	 bPW0JbCAsjV5xcD/Ch0bp0EaZIj0VmAtOCfd4W1b67dJzoObsUhnr+z0T4p7YdCdA4
	 ve8UTtrfCH6kw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JbD3Q5xpSzFm8
 for <lttng-dev@lists.lttng.org>; Fri, 14 Jan 2022 15:50:58 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 676102D6056;
 Fri, 14 Jan 2022 15:50:52 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id CodU9ZW052sW; Fri, 14 Jan 2022 15:50:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 060352D6133;
 Fri, 14 Jan 2022 15:50:52 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 060352D6133
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id lCS8DDU0_GNZ; Fri, 14 Jan 2022 15:50:51 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id EECAE2D6131;
 Fri, 14 Jan 2022 15:50:51 -0500 (EST)
Date: Fri, 14 Jan 2022 15:50:51 -0500 (EST)
To: Jesper Derehag <jderehag@hotmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, 
 Jeremie Galarneau <jgalar@efficios.com>
Message-ID: <2023865153.34173.1642193451936.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Index: qlthIN068Y9G8oCF3gODd9j77VMBFg==
Thread-Topic: Transfer of LTTng copyright ownership: Jesper Derehag
Subject: [lttng-dev] Transfer of LTTng copyright ownership: Jesper Derehag
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

Hi Jesper,

In order to facilitate maintenance of the LTTng project, would you agree to
transfer your copyright ownership for code authored in your own time to
EfficiOS Inc. ?

Even though most of those changes are somewhat trivial, I would prefer that
we keep a public record of this for the future.

Those changes are authored with this email:

Jesper Derehag <jderehag@hotmail.com>

This affects the lttng-tools and lttng-ust projects.

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
