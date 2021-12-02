Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA30C433EF
	for <lttng-dev@archiver.kernel.org>; Thu,  2 Dec 2021 20:54:39 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4J4p9V0VZQz1pwV;
	Thu,  2 Dec 2021 15:54:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1638478478;
	bh=3YlT9t0bek+B4y//OEg9o4TLt52bYThcgQZE43bISy8=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=K2iJFzPBkzPGXdmoBdhVecUfbyqeajoq6gRghyjAH4B0QpZ6fZi2zw16jhjMbWFvQ
	 5bYEUInFgAaa4dkgFZnbaKgjWdkeeKAA14FifEweD36IMu23dbQvhHOaZPW8UD2Ax6
	 gbmzKRjM515B/7b3qUSMLwEzi7xC0cdGRnUrBG+G9yPWXnYSpLAp0WNzlqFiw3JjqX
	 a6E51yse9ZCKf5KFggdW1vCkaQZ14xEpxQ6q3EIcXm9Cvou+1k6qVWhwXnkO5L+MF/
	 pl/2yE5Em8Ymth1ibdEU8QJO7GDx0vfYu/E3HbsuNSWvfWDeE8ONkx42DASY6GAWjS
	 UU6f0esA4YCrg==
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by lists.lttng.org (Postfix) with ESMTPS id 4J4nBp4g6Cz1pgH
 for <lttng-dev@lists.lttng.org>; Thu,  2 Dec 2021 15:10:41 -0500 (EST)
To: lttng-dev@lists.lttng.org, francis.deslauriers@efficios.com,
 jonathan.rajotte-julien@efficios.com
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Thu,  2 Dec 2021 21:04:12 +0100
Message-Id: <20211202200412.146288-1-alex@linutronix.de>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 02 Dec 2021 15:54:35 -0500
Subject: [lttng-dev] [PATCH] lttng-ust-common: link with liburcu explicitly
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
From: Alexander Kanavin via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Otherwise linking errors are seen on x86-32.
---
 src/lib/lttng-ust-common/Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/lib/lttng-ust-common/Makefile.am b/src/lib/lttng-ust-common/Makefile.am
index caeea2be..0130628c 100644
--- a/src/lib/lttng-ust-common/Makefile.am
+++ b/src/lib/lttng-ust-common/Makefile.am
@@ -15,6 +15,7 @@ liblttng_ust_common_la_SOURCES = \
 
 liblttng_ust_common_la_LIBADD = \
 	$(top_builddir)/src/common/libcommon.la \
+	$(URCU_LIBS) \
 	$(DL_LIBS)
 
 liblttng_ust_common_la_LDFLAGS = -no-undefined -version-info $(LTTNG_UST_LIBRARY_VERSION)
-- 
2.20.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
