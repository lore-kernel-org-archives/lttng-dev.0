Return-Path: <SRS0=Ztta=BC=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4001C433E8
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Jul 2020 14:45:25 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8686620674
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Jul 2020 14:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="dcR9MXWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8686620674
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BCFVr1JPdz1fkm;
	Thu, 23 Jul 2020 10:45:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1595515524;
	bh=kxICqcy/945EO7FwPniLN7lF+/rERWBQWAJdzjqw0FI=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=dcR9MXWOh3HCBKU6zPPB1dvP5tvBge5ZGZGrEX3RwoKJFp9I42T+jU8TUWDvjm0cJ
	 4bBqYTx+DpbUM2LzP/U4Dk/D8tYdKW3NtX+MCBJCHyd2tPgFiMTe7JrXXCiGT99OVs
	 0r4Fo07S4893wODq+RFRuligTCOygQPXpf4Dbmg1O4yvOwVAJ8hBR5Py7JFWGt7sIF
	 MA40xwKRgfC9VrQSLP4nUXDn9jewXW1FNXNr2g31txgjKlNGMLm2e/lPCnX2nSh0pX
	 dF+K8uq793i1BLlBw2HPqMCbHjoEqPSlqPQqvzNbh+sUOytSRHalriRxqj3SIipNDo
	 VE3J9fz5iotyg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4BCFVp3XpPz1g1v
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2020 10:45:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0523D2E6586;
 Thu, 23 Jul 2020 10:45:16 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id c4AGPMCo7scf; Thu, 23 Jul 2020 10:45:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C17FD2E6339;
 Thu, 23 Jul 2020 10:45:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C17FD2E6339
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id cb29xt4SOG3H; Thu, 23 Jul 2020 10:45:15 -0400 (EDT)
Received: from thinkos.etherlink (unknown [192.222.236.144])
 by mail.efficios.com (Postfix) with ESMTPSA id 8690E2E6250;
 Thu, 23 Jul 2020 10:45:15 -0400 (EDT)
To: diamon-discuss@lists.linuxfoundation.org
Date: Thu, 23 Jul 2020 10:45:03 -0400
Message-ID: <20200723144503.5477-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Subject: [lttng-dev] [RFC PATCH CTF] Clarify signedness of clock offset_s
 and offset fields
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
Cc: Jeremie Galarneau <jgalar@efficios.com>, lttng-dev@lists.lttng.org,
 Philippe Proulx <pproulx@efficios.com>,
 Genevieve Bastien <gbastien+lttng@versatic.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200723144503.qhs5mPKS6X-bQSTvRJ76awZxDfbFnX1Cd86RYEfzQ8Y@z>

Clarify that both offset_s and offset fields of clock may have
negative values.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 common-trace-format-specification.md | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/common-trace-format-specification.md b/common-trace-format-specification.md
index b40082c..d4c69ad 100644
--- a/common-trace-format-specification.md
+++ b/common-trace-format-specification.md
@@ -1545,11 +1545,11 @@ The `offset_s` and `offset` fields indicate the offset from
 POSIX.1 Epoch, 1970-01-01 00:00:00 +0000 (UTC), to the zero of value
 of the clock. The `offset_s` field is in seconds. The `offset` field is
 in (1/freq) units. If any of the `offset_s` or `offset` field is not
-present, it is assigned the 0 value. The field `absolute` is `TRUE` if
-the clock is a global reference across different clock UUID
-(e.g. NTP time). Otherwise, `absolute` is `FALSE`, and the clock can
-be considered as synchronized only with other clocks that have the same
-UUID.
+present, it is assigned the 0 value. Both `offset_s` and `offset`
+fields are signed integers. The field `absolute` is `TRUE` if the clock
+is a global reference across different clock UUID (e.g. NTP time).
+Otherwise, `absolute` is `FALSE`, and the clock can be considered as
+synchronized only with other clocks that have the same UUID.
 
 Secondly, a reference to this clock should be added within an integer
 type:
-- 
2.11.0

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
