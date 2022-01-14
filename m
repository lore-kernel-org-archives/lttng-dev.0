Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F03C433EF
	for <lttng-dev@archiver.kernel.org>; Fri, 14 Jan 2022 20:13:22 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JbCD21CxLzFQ5;
	Fri, 14 Jan 2022 15:13:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642191202;
	bh=VpmkXZvb3HFKgiWxWVMXxCaAxL5Yh5NurMo6uCw1IAQ=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=JsMTtuG2nYgtehhOW98Qw0gg7FJFKfH6jjHdIeEuXqFzzgwZbfrWKjpAZfC4labt7
	 pnraAoyQbGPALGh7WeFbKL5Z0w5mR1CYzVKYjJ7dcp3EGD0lSclTnnzWu57HRbjLPw
	 T01c+Vj3gyn9MKxru303f3m7PoaU6b75oFFcJvkpX6IqRqn9hWkuzZS7X1cAojDpvd
	 OjaGEIt22+DFdux7exEZPk0RDfNi9RMiTyyCL6/dqp2GGB2Ac13TDs1apC4u6Rhb3Y
	 M4aYNysdYR0vQefea0RSy9gMOBsWGQxF6iPn6Kf3wtSerL0js9+tbjLTJ7uC9SwJ9K
	 7YT8YtOnSbmTg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JbCD14cWTzFZ8
 for <lttng-dev@lists.lttng.org>; Fri, 14 Jan 2022 15:13:21 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 980FD2D5A6E;
 Fri, 14 Jan 2022 15:13:21 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id qLEo5fPr7M42; Fri, 14 Jan 2022 15:13:21 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 134A12D5310;
 Fri, 14 Jan 2022 15:13:21 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 134A12D5310
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id u4Gu14QowIY2; Fri, 14 Jan 2022 15:13:21 -0500 (EST)
Received: from thinkos.etherlink (192-222-188-69.qc.cable.ebox.net
 [192.222.188.69])
 by mail.efficios.com (Postfix) with ESMTPSA id E1C462D530F;
 Fri, 14 Jan 2022 15:13:20 -0500 (EST)
To: lttng-dev@lists.lttng.org
Date: Fri, 14 Jan 2022 15:13:08 -0500
Message-Id: <20220114201309.24548-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH lttng-modules] Copyright ownership transfer
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
Cc: Julien Desfossez <ju@klipix.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Apply copyright ownership transfer from Julien Desfossez to EfficiOS Inc.

Link: https://lists.lttng.org/pipermail/lttng-dev/2022-January/030092.html
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Julien Desfossez <ju@klipix.org>
Change-Id: Ida168b1fbe6589cb371a549ef14d9b4b28b221b3
---
 .../lttng-syscalls-extractor/lttng-syscalls-extractor.c         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/instrumentation/syscalls/lttng-syscalls-extractor/lttng-syscalls-extractor.c b/include/instrumentation/syscalls/lttng-syscalls-extractor/lttng-syscalls-extractor.c
index 0f683750..8670d25f 100644
--- a/include/instrumentation/syscalls/lttng-syscalls-extractor/lttng-syscalls-extractor.c
+++ b/include/instrumentation/syscalls/lttng-syscalls-extractor/lttng-syscalls-extractor.c
@@ -5,7 +5,7 @@
  * Dump syscall metadata to console.
  *
  * Copyright 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
- * Copyright 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
+ * Copyright 2011 EfficiOS Inc.
  */
 
 #include <linux/module.h>
-- 
2.20.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
