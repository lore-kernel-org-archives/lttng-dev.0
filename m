Return-Path: <SRS0=91P6=I5=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05973C433B4
	for <lttng-dev@archiver.kernel.org>; Wed, 31 Mar 2021 18:54:47 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4249961006
	for <lttng-dev@archiver.kernel.org>; Wed, 31 Mar 2021 18:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4249961006
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F9b8h5z0DzSM3;
	Wed, 31 Mar 2021 14:54:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617216885;
	bh=7SzErX2uFLPNE9jjxTtEAibjVOr/GJvgNpuCGP/OnCk=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=jK281mfOAZUcG4fQ72hZk7lKgywVolLzYw7w4rbNhWhgbUuU1USy1bCcnEhGWr9kg
	 F1yyWjG7w5aDkBGE1q4o9NNfnlhvhYKHwgWWs1407weR4maGfjpwR+Be5bbhb+ADgO
	 i9hjIsOxBYrCqyVx+hRkPpT6QTqmUaXdS16YvIs1J/fcRi+TyswLktYCivvBGs/yzs
	 Ddr8BIb55Lz84KmDnuB/jD23PMcugsxvCrL63VjMRuGcHbcwiXqdYzyAcVA/Ztav0s
	 6CC2gWKw25yYIEJjFHPrmYmEzFIDlOoJ1A8nlT7mqtq29E7E0ONN/UNdH+gdnHD518
	 c9efVvnOMZN7g==
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by lists.lttng.org (Postfix) with ESMTPS id 4F9b8g1CQFzSCy
 for <lttng-dev@lists.lttng.org>; Wed, 31 Mar 2021 14:54:42 -0400 (EDT)
Received: by mail-lf1-x134.google.com with SMTP id v15so30622981lfq.5
 for <lttng-dev@lists.lttng.org>; Wed, 31 Mar 2021 11:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5G0Jjf599Wxjud9N5JY4ZFI5isgSuIZfF7/ZS0qZC9g=;
 b=UKP9q9FPFkiTJ3IQUQ/8vCi5Ck18tjMBlgdDPy/g4YPOIQJpeiXQRSjgtIwgG8EXsP
 Mvi4/EQdUhSsK6J6TKy1fpL7v6kaaeA0LbgvQrrgEdjtThORkv/i0RkfwnClPjAUVcHp
 3DaaBPUDrSAd1cdEYsspqJhq/h4KQo8gkY7bWXP9acpFDjCSgR4ByO2rmnCkEz8m0hnT
 f86NsoH2twGAOUiTGp9tiO9eB/wlnXNeQsbM9Lr1r4PSWYvTCk4CS+hiRKdYe3Fblfae
 tSrfI0fS5zdEN75pddtaLlwtk6ge472+wfcuS55kTLI7+V5O9lNapQ3ZCH7nHnHFvYjV
 T6Sw==
X-Gm-Message-State: AOAM530letjHHMoiT5fbbiLx65RpTWkyxP8vilxzYzZwb46PCrFvy2Pq
 +wDEIifCXm+h/1rD9Licn2ZPHrqgvkrAYQ==
X-Google-Smtp-Source: ABdhPJxZkZDfJKT8GN4Y3+4l8k2czCcXUP0dGXOuKCB53ADfC/Ou8qEy7PqkVkc9OSb6uS1bJ7Ed+A==
X-Received: by 2002:ac2:4c1c:: with SMTP id t28mr2975328lfq.45.1617216880938; 
 Wed, 31 Mar 2021 11:54:40 -0700 (PDT)
Received: from arn-awallin-linux-l5.corp.ad.wrs.com
 (h-82-196-111-243.NA.cust.bahnhof.se. [82.196.111.243])
 by smtp.gmail.com with ESMTPSA id d8sm306154lfa.49.2021.03.31.11.54.39
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Mar 2021 11:54:40 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Wed, 31 Mar 2021 20:54:39 +0200
Message-Id: <20210331185439.406791-1-wallinux@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH lttng-tools] Fix: added missing test_channel and
 removed double defined test_syscall
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Anders Wallin via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Anders Wallin <wallinux@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Signed-off-by: Anders Wallin <wallinux@gmail.com>
---
 tests/regression/kernel/Makefile.am | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/regression/kernel/Makefile.am b/tests/regression/kernel/Makefile.am
index f06f5152..040b7642 100644
--- a/tests/regression/kernel/Makefile.am
+++ b/tests/regression/kernel/Makefile.am
@@ -1,7 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-EXTRA_DIST = test_all_events test_syscall \
+
+EXTRA_DIST = test_all_events \
 						 test_callstack \
+						 test_channel \
 						 test_clock_override \
 						 test_event_basic \
 						 test_kernel_function \
-- 
2.31.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
