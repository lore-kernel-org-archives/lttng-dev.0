Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DC1C433EF
	for <lttng-dev@archiver.kernel.org>; Fri, 14 Jan 2022 20:14:20 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JbCF74ZPfzFXr;
	Fri, 14 Jan 2022 15:14:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642191260;
	bh=QsfALRXtjg0Bs1UeKyqwZ+8vDkvWjInbyYwwDwpsPJk=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=O5pEIa1gaq8PA9+L6a+qzLBg/7Nge53LIypsgterwwq+u0kqumIq2NWtWQhAv9NAJ
	 prbpG4LHVUUGctGrjAI3hakszkEXBC0NPTPwovaGja1AdCidcQjv9a1l4h6B8FcZ1t
	 qCcR4KlmHn09uF2kvMp0dKWIkyhzaHrHYvG/LX1uVhpDBnYORer3a5E70abQmqm6ot
	 Yix7zaHRN0UvpCCPZAnBgFZDUSIeCBBfAkSc6x6ZdFnWfq96Pd38pKFblzagsNgkkO
	 8jvcRHgUhJcX66QrV7dNBbOQ+872Ya9r3KEVbGhAhv3NttgbRdVyStlRMdGqKIYPVf
	 CrvdAyp6JJdNg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JbCF65XpMzFdL
 for <lttng-dev@lists.lttng.org>; Fri, 14 Jan 2022 15:14:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8985D2D5BC1;
 Fri, 14 Jan 2022 15:14:12 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 5qDsAryYz41H; Fri, 14 Jan 2022 15:14:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1E7B52D5BC0;
 Fri, 14 Jan 2022 15:14:12 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1E7B52D5BC0
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 49n25gdOYjXq; Fri, 14 Jan 2022 15:14:12 -0500 (EST)
Received: from thinkos.etherlink (192-222-188-69.qc.cable.ebox.net
 [192.222.188.69])
 by mail.efficios.com (Postfix) with ESMTPSA id EDC3A2D5E1A;
 Fri, 14 Jan 2022 15:14:11 -0500 (EST)
To: lttng-dev@lists.lttng.org
Date: Fri, 14 Jan 2022 15:14:09 -0500
Message-Id: <20220114201409.24705-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH lttng-ust] Copyright ownership transfer
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
Cc: Julien Desfossez <ju@klipix.org>, David Goulet <dgoulet@ev0ke.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Apply copyright ownership transfer from David Goulet and Julien Desfossez
to EfficiOS Inc.

Link: https://lists.lttng.org/pipermail/lttng-dev/2022-January/030087.html
Link: https://lists.lttng.org/pipermail/lttng-dev/2022-January/030092.html
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: David Goulet <dgoulet@ev0ke.net>
Cc: Julien Desfossez <ju@klipix.org>
Change-Id: Ibc6bb52296406e68466d44ae991a7ab70134dd76
---
 include/lttng/ust-ctl.h            | 2 +-
 include/lttng/ust-error.h          | 3 +--
 src/common/ustcomm.c               | 2 +-
 src/common/ustcomm.h               | 3 +--
 src/common/utils.c                 | 2 +-
 src/lib/lttng-ust-ctl/ustctl.c     | 2 +-
 src/lib/lttng-ust/lttng-ust-comm.c | 2 +-
 src/lib/lttng-ust/strerror.c       | 2 +-
 8 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/lttng/ust-ctl.h b/include/lttng/ust-ctl.h
index 360bb09a..25e588b3 100644
--- a/include/lttng/ust-ctl.h
+++ b/include/lttng/ust-ctl.h
@@ -1,7 +1,7 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-only
  *
- * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
+ * Copyright (C) 2011 EfficiOS Inc.
  * Copyright (C) 2011-2013 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
diff --git a/include/lttng/ust-error.h b/include/lttng/ust-error.h
index 543c894a..49045bab 100644
--- a/include/lttng/ust-error.h
+++ b/include/lttng/ust-error.h
@@ -1,8 +1,7 @@
 /*
  * SPDX-License-Identifier: LGPL-2.1-only
  *
- * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
- * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
+ * Copyright (C) 2011 EfficiOS Inc.
  * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
diff --git a/src/common/ustcomm.c b/src/common/ustcomm.c
index 6dfec5ea..252ed4f2 100644
--- a/src/common/ustcomm.c
+++ b/src/common/ustcomm.c
@@ -1,7 +1,7 @@
 /*
  * SPDX-License-Identifier: LGPL-2.1-only
  *
- * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
+ * Copyright (C) 2011 EfficiOS Inc.
  * Copyright (C) 2011-2013 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
diff --git a/src/common/ustcomm.h b/src/common/ustcomm.h
index 734757c3..d1e9af13 100644
--- a/src/common/ustcomm.h
+++ b/src/common/ustcomm.h
@@ -1,8 +1,7 @@
 /*
  * SPDX-License-Identifier: LGPL-2.1-only
  *
- * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
- * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
+ * Copyright (C) 2011 EfficiOS Inc.
  * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
diff --git a/src/common/utils.c b/src/common/utils.c
index 108f76db..0c95b06c 100644
--- a/src/common/utils.c
+++ b/src/common/utils.c
@@ -1,7 +1,7 @@
 /*
  * SPDX-License-Identifier: LGPL-2.1-only
  *
- * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
+ * Copyright (C) 2011 EfficiOS Inc.
  * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
diff --git a/src/lib/lttng-ust-ctl/ustctl.c b/src/lib/lttng-ust-ctl/ustctl.c
index 8c60bdb2..94d84843 100644
--- a/src/lib/lttng-ust-ctl/ustctl.c
+++ b/src/lib/lttng-ust-ctl/ustctl.c
@@ -1,7 +1,7 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-only
  *
- * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
+ * Copyright (C) 2011 EfficiOS Inc.
  * Copyright (C) 2011-2013 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
diff --git a/src/lib/lttng-ust/lttng-ust-comm.c b/src/lib/lttng-ust/lttng-ust-comm.c
index d6755079..caba7452 100644
--- a/src/lib/lttng-ust/lttng-ust-comm.c
+++ b/src/lib/lttng-ust/lttng-ust-comm.c
@@ -1,7 +1,7 @@
 /*
  * SPDX-License-Identifier: LGPL-2.1-only
  *
- * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
+ * Copyright (C) 2011 EfficiOS Inc.
  * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
diff --git a/src/lib/lttng-ust/strerror.c b/src/lib/lttng-ust/strerror.c
index 1fa7fc3a..5a671a07 100644
--- a/src/lib/lttng-ust/strerror.c
+++ b/src/lib/lttng-ust/strerror.c
@@ -1,7 +1,7 @@
 /*
  * SPDX-License-Identifier: LGPL-2.1-only
  *
- * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
+ * Copyright (C) 2011 EfficiOS Inc.
  * Copyright (C) 2011-2013 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
-- 
2.20.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
