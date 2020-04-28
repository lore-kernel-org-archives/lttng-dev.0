Return-Path: <SRS0=0zlt=6M=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1D1C83000
	for <lttng-dev@archiver.kernel.org>; Tue, 28 Apr 2020 19:12:50 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D94B6206A1
	for <lttng-dev@archiver.kernel.org>; Tue, 28 Apr 2020 19:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="ug588fnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94B6206A1
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49BWW50wqZz1nJV;
	Tue, 28 Apr 2020 15:12:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1588101169;
	bh=AMvEKLhkD2gT8XANkPVJ2j2CWAZUG0BCzDUSAHQQJx8=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=ug588fnG3fyeFeHVG7eETbUNjPlgXZyg4pr6SZtWFKG+fLXWuEHtSQVNHMQqo0hoz
	 Z2GueO6uR6hOTaiTjGYObgpWH+09Rj66+3SYh8pHEVrk+SZWquBi/9+cq4Ymge1CAe
	 /EkNi9otT4dvvu5yqrSihoPqFs3agvhyLTWJq9bjk+bu9vo2e80vXJXmmosSjXwsht
	 PpxZbNs0nSfIXu4igjXF29my2Y3x65nwlfFw5ImIJJAWPY9GX8ls11llP03qGdf6Yc
	 +SLD+z50i0wv4xaor5f8W6EbQ2Z5a2l/odFeB1Nns/wZMTtJdogY0se0w0Mgts3OTP
	 u3Fvd/U6ZtfOw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49BWW03Wjqz1n2V
 for <lttng-dev@lists.lttng.org>; Tue, 28 Apr 2020 15:12:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B47DB27F93D;
 Tue, 28 Apr 2020 15:12:38 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id KDN6HBHRJzB0; Tue, 28 Apr 2020 15:12:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2E95F27F84E;
 Tue, 28 Apr 2020 15:12:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2E95F27F84E
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Mb1UTtKY3CYu; Tue, 28 Apr 2020 15:12:38 -0400 (EDT)
Received: from thinkos.etherlink (192-222-181-218.qc.cable.ebox.net
 [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id ACC8227F93C;
 Tue, 28 Apr 2020 15:12:37 -0400 (EDT)
To: diamon-discuss@lists.linuxfoundation.org
Date: Tue, 28 Apr 2020 15:12:24 -0400
Message-ID: <20200428191227.16560-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Subject: [lttng-dev] [RFC PATCH CTF 1/4] Clarify that unlisted enumeration
 values are allowed
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.29
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
Message-ID: <20200428191224.IZ4SEnnTFt7m0_ZWHcFbauNzuStlPB9UAQAK-7ezyIo@z>

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 common-trace-format-specification.md | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common-trace-format-specification.md b/common-trace-format-specification.md
index fd49e59..d6d196c 100644
--- a/common-trace-format-specification.md
+++ b/common-trace-format-specification.md
@@ -464,6 +464,9 @@ enum {
 }
 ~~~
 
+An enumeration field can have an integral value which its type does not
+map to a string.
+
 ### 4.2 Compound types
 
 Compound are aggregation of type declarations. Compound types include
-- 
2.11.0

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
