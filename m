Return-Path: <SRS0=0zlt=6M=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DB4C83004
	for <lttng-dev@archiver.kernel.org>; Tue, 28 Apr 2020 19:12:52 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E30206A1
	for <lttng-dev@archiver.kernel.org>; Tue, 28 Apr 2020 19:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="aW7JQg3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E30206A1
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49BWW549J2z1n2g;
	Tue, 28 Apr 2020 15:12:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1588101169;
	bh=MnzivKeqlcyKCno4g0VdtRRnNUvfha25bXt/y718GLc=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=aW7JQg3esLah1eb5xwI5lhklGktCMWIdCGPdzhzKzbxMjrwziRLxU13g/lpM/De2W
	 tlqznnvMi43s8FVGYjKcENf0gYFi1vSWvOd3zwqWcHtyOY7iXKpIUZBHFpOP7e1+kN
	 jnpA2nav8rOuIpajOKFgZJFG03x4YVoNEFu9H3xr+ZoUU/xNeQtm3n6w5Yw3dFUNkh
	 h5hDHM6RrtMvljQHYoABx8gFc0BMvTlZ7hAH0iy9LA4g3ayrKgMRFMndq6Bl6ySij4
	 5J61h+secMCHCuzwLM577GD7mIMZnky/QV9cn7KwEanVAOoN5rOQ9uFIfUOAKVOI98
	 K39en2+al0M+w==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49BWW11KbSz1nM1
 for <lttng-dev@lists.lttng.org>; Tue, 28 Apr 2020 15:12:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A273427F93F;
 Tue, 28 Apr 2020 15:12:39 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id qmzVVvlf7_41; Tue, 28 Apr 2020 15:12:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5939027FB06;
 Tue, 28 Apr 2020 15:12:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5939027FB06
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id M8JmjEHQp-dV; Tue, 28 Apr 2020 15:12:39 -0400 (EDT)
Received: from thinkos.etherlink (192-222-181-218.qc.cable.ebox.net
 [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id DBA4D27FA88;
 Tue, 28 Apr 2020 15:12:38 -0400 (EDT)
To: diamon-discuss@lists.linuxfoundation.org
Date: Tue, 28 Apr 2020 15:12:26 -0400
Message-ID: <20200428191227.16560-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200428191227.16560-1-mathieu.desnoyers@efficios.com>
References: <20200428191227.16560-1-mathieu.desnoyers@efficios.com>
Subject: [lttng-dev] [RFC PATCH CTF 3/4] Clarify that timestamp begin/end
 need to be complete clock values
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
Message-ID: <20200428191226.VGyZMZbWq5pav8yffvxOzlvx1hW_etSAODG8eNx1Xdg@z>

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 common-trace-format-specification.md | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/common-trace-format-specification.md b/common-trace-format-specification.md
index 55d0601..5732e92 100644
--- a/common-trace-format-specification.md
+++ b/common-trace-format-specification.md
@@ -837,11 +837,12 @@ TSDL metadata):
     assigned to events contained within the packet. The timestamp at the
     beginning of an event packet is guaranteed to be below or equal the
     timestamp at the end of that event packet. The timestamp at the
-    beginning of an event packet is guaranteed to be above or equal the
-    timestamps at the beginning of any prior packet within the same
-    stream. The timestamp at the end of an event packet is guaranteed to
-    be below or equal the timestamps at the end of any following packet
-    within the same stream. See [Clocks](#spec8) for more detail.
+    beginning of an event packet is guaranteed to be grater than or
+    equal to timestamps at the beginning of any prior packet within the
+    same stream. The timestamp at the end of an event packet is
+    guaranteed to be less than or equal to the timestamps at the end of
+    any following packet within the same stream. See [Clocks](#spec8)
+    for more detail.
   * **Events discarded count**. Snapshot of a per-stream
     free-running counter, counting the number of events discarded that
     were supposed to be written in the stream after the last event in
@@ -1580,7 +1581,8 @@ stream {
 };
 ~~~
 
-For a N-bit integer type referring to a clock, if the integer overflows
+Within the stream event context, event context, and event payload,
+fields of N-bit integer type referring to a clock, if the integer overflows
 compared to the N low order bits of the clock prior value found in the
 same stream, then it is assumed that one, and only one, overflow
 occurred. It is therefore important that events encoding time on a small
@@ -1589,8 +1591,8 @@ N-bit overflow occurs.
 
 In a packet context, clock field names ending with `_begin` and `_end`
 have a special meaning: this refers to the timestamps at, respectively,
-the beginning and the end of each packet.
-
+the beginning and the end of each packet. Those are required to be
+complete representations of the clock value.
 
 ## A. Helper macros
 
-- 
2.11.0

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
