Return-Path: <SRS0=0zlt=6M=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5374CC83004
	for <lttng-dev@archiver.kernel.org>; Tue, 28 Apr 2020 19:12:54 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 113F7206A1
	for <lttng-dev@archiver.kernel.org>; Tue, 28 Apr 2020 19:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="gf4/GEkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113F7206A1
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49BWW75sCgz1mxc;
	Tue, 28 Apr 2020 15:12:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1588101172;
	bh=Oy9MlWnPnygbmMYzmkLPV854cFbyxEnBs7qKIwanyE0=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=gf4/GEkLLyeX/dP6E1DYjJ4cfFQ+zMeub7Qi2S8PUphavtZenDiPYqgW3b8dsECtg
	 2If1hnQNSJSmnE9kgZ89Bqmk/MbCCK6hg7KaZZ6o0JLrNal9qLkqSkHzpzGrI1xDTw
	 vJite/aQ7Qcht7kDW5JwL8jA8jyZHTZynV135sJ01o01cnWv96J9cjjt/WIw1LNe6D
	 3foLUBTWfPcRmBeVKgF1iNjccWMHeXvmgeTNjvqwx2ymQWD+M+myzPUdWHKp43VqKe
	 pDxNEiuCbHKT1ejc+OP1CKw9ZpvUh38l4SGiuIu+/aNe2giUFkeK9n3mEXKQDKl7WC
	 5FmUIfahfDJOg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49BWW20wg1z1mrF
 for <lttng-dev@lists.lttng.org>; Tue, 28 Apr 2020 15:12:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 170BF27FB07;
 Tue, 28 Apr 2020 15:12:40 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id qIV1x_UHacAG; Tue, 28 Apr 2020 15:12:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D900027FA96;
 Tue, 28 Apr 2020 15:12:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D900027FA96
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id nmZzfGA4Fjnl; Tue, 28 Apr 2020 15:12:39 -0400 (EDT)
Received: from thinkos.etherlink (192-222-181-218.qc.cable.ebox.net
 [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id 681EF27F93E;
 Tue, 28 Apr 2020 15:12:39 -0400 (EDT)
To: diamon-discuss@lists.linuxfoundation.org
Date: Tue, 28 Apr 2020 15:12:27 -0400
Message-ID: <20200428191227.16560-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200428191227.16560-1-mathieu.desnoyers@efficios.com>
References: <20200428191227.16560-1-mathieu.desnoyers@efficios.com>
Subject: [lttng-dev] [RFC PATCH CTF 4/4] Use the formulation "less than or
 equal to" rather than "below or equal"
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
Message-ID: <20200428191227.q9jfTqiyn-rKMMLb__-5PaVaq-SFRKKNf9WIGfyXs14@z>

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 common-trace-format-specification.md | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common-trace-format-specification.md b/common-trace-format-specification.md
index 5732e92..8a3a745 100644
--- a/common-trace-format-specification.md
+++ b/common-trace-format-specification.md
@@ -835,9 +835,9 @@ TSDL metadata):
     while (or after) writing the last event in the packet. The inclusive
     range between these timestamps should include all event timestamps
     assigned to events contained within the packet. The timestamp at the
-    beginning of an event packet is guaranteed to be below or equal the
-    timestamp at the end of that event packet. The timestamp at the
-    beginning of an event packet is guaranteed to be grater than or
+    beginning of an event packet is guaranteed to be less than or equal
+    to the timestamp at the end of that event packet. The timestamp at
+    the beginning of an event packet is guaranteed to be grater than or
     equal to timestamps at the beginning of any prior packet within the
     same stream. The timestamp at the end of an event packet is
     guaranteed to be less than or equal to the timestamps at the end of
-- 
2.11.0

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
