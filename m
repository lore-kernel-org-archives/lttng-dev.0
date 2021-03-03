Return-Path: <SRS0=0Acq=IB=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DE4C433DB
	for <lttng-dev@archiver.kernel.org>; Wed,  3 Mar 2021 08:38:10 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A4E64E20
	for <lttng-dev@archiver.kernel.org>; Wed,  3 Mar 2021 08:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A4E64E20
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Dr6p616TYz9mG;
	Wed,  3 Mar 2021 03:38:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1614760687;
	bh=PaJzOejfaWnZ7BI59W5RRvlbgFqNaTeSDWrHzwG3qcw=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=RkC02ziNXAAKRm4MOoHNtsoLJBVQZ2SqJMp20zUuH1f1RZPV3bWy72V6oTPKb4X52
	 FXfWw+zfAd2GxaQm/8Lzhf7w0tBZ9huMLw79OfmUE7xHcvLauzGBFCq7COSnh3Xjgk
	 kkzDp/3Q0lyoq48b2IuyCK1uHAyQlQL7/P6OFNelgLn8UpL6pd4EMVM3Fi0KksJ5Ug
	 mFDhi9FJIz4SZJSNjavjdNHrfqed+uYip8/Ma0sOt/tEqVzsxY9ek8cNE6PdmJEFhe
	 8Xg/lNroCwuI2bE2a9KzDAAQLg5PJjz1xUoyU0h+q+43XYtOm10E8FTpL5TNtWuPNT
	 cafn1EyEzfMSw==
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by lists.lttng.org (Postfix) with ESMTPS id 4Dr6p51Q5lz9yP
 for <lttng-dev@lists.lttng.org>; Wed,  3 Mar 2021 03:38:05 -0500 (EST)
Received: by mail-lf1-x132.google.com with SMTP id 18so27236309lff.6
 for <lttng-dev@lists.lttng.org>; Wed, 03 Mar 2021 00:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AEaS5JOoPaJt1YSfeW0nxHGk4KnA40mHUInL6wNA/m0=;
 b=HZ46BrAwWD76+jHTnA2KkuEaFURzlS73osXPtHu2hSE+lXHvUpkwZeTQ4EIMxJqHkX
 IA7y7qxJ+OQtLADOm20lQhkd5FYotn2yjHKL4xQYMUkcw6D+cUUuyMnAjgka/zB/C5xn
 4Vz6NPjaCDmOQABo3VnJDEg2ThiYC7v4M/Q8K+TjDZ0gAMWbOJBUwBIyACW8XsO9palz
 jVtMvOcSMvCc0/T9bDln69X47tj/J47NJ5kMyNQgl9+8ppK6cq2BAySWyrowipa2ak8/
 1pdJ0sZdooxviJqrcnFpWbyHGzGGxwU+I/wm+OIr8gssYKdn35tnlj4e17kS4HIrlqZL
 H2Rw==
X-Gm-Message-State: AOAM532Kg8bpsuSG+mUqMxKd5VW2TCjuxvmkI9shBy+3ejyeAMYv0iFK
 mjQi2YwJX/Y4Olel1F/rl+gM0JikI2BBcA==
X-Google-Smtp-Source: ABdhPJyIWMlSpXfUDhSC49EAJL5LbHYAHoZ7w+hcuyQdhgKDdA8W1wsiIKAsmzBRKMj4kH1v1XBapg==
X-Received: by 2002:a19:ae17:: with SMTP id f23mr14097281lfc.575.1614760683267; 
 Wed, 03 Mar 2021 00:38:03 -0800 (PST)
Received: from arn-awallin-linux-l5.corp.ad.wrs.com
 (h-82-196-111-243.NA.cust.bahnhof.se. [82.196.111.243])
 by smtp.gmail.com with ESMTPSA id b3sm3233083lji.36.2021.03.03.00.38.02
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 00:38:02 -0800 (PST)
To: lttng-dev@lists.lttng.org
Date: Wed,  3 Mar 2021 09:38:01 +0100
Message-Id: <20210303083801.1771117-1-wallinux@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH lttng-tools] fix: include lttng-list-trigger
 missing an 's'
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
 src/bin/lttng/commands/list_triggers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/bin/lttng/commands/list_triggers.c b/src/bin/lttng/commands/list_triggers.c
index ac6e1ba3..a6f02119 100644
--- a/src/bin/lttng/commands/list_triggers.c
+++ b/src/bin/lttng/commands/list_triggers.c
@@ -19,7 +19,7 @@
 
 #ifdef LTTNG_EMBED_HELP
 static const char help_msg[] =
-#include <lttng-list-trigger.1.h>
+#include <lttng-list-triggers.1.h>
 ;
 #endif
 
-- 
2.30.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
