Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C30EC19F29
	for <lttng-dev@archiver.kernel.org>; Tue,  2 Aug 2022 18:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1659464395;
	bh=B13H0Mt3oI19LvuCRB9Auxg4yJijvs2AyFxe7kmUoIs=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=aL9C44i73zJDSpB5rc/+DI0kdYYKOO8Odzm5DU8AZo+DeYxM3Cmjh+Pk1jiBGpRc7
	 yt6CT0XU64rYBkAggTo2gjAiBlc7JdEFc/aBEVXDwWO+E+HhdRRjmcRy+k2aPIcBoZ
	 T6h1/4GdGubIA0mXu45pbPDeXnGcG4yDq0zGl0PHesPQOeR07Z5h9C2T0AHNYBuh1c
	 bj/1Kx2qc89i0fk9Smc1n1vpzRppy8qV+Dkw+hbkpSetmS4OI5hS6VyGreI4JWtRqI
	 ZeugOQMAmpgkvX/8MEbElAEam5mHmGJMsJdLABBirSqaqgm+NkBmwenFPHLcjPlt0N
	 itbvQLGNND3pQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Ly3Dp2VzWz11Wk;
	Tue,  2 Aug 2022 14:19:54 -0400 (EDT)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by lists.lttng.org (Postfix) with ESMTPS id 4Ly2RV3wtQz11t3
 for <lttng-dev@lists.lttng.org>; Tue,  2 Aug 2022 13:44:06 -0400 (EDT)
Received: by mail-pj1-x1033.google.com with SMTP id
 t2-20020a17090a4e4200b001f21572f3a4so16166977pjl.0
 for <lttng-dev@lists.lttng.org>; Tue, 02 Aug 2022 10:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=E1xbc7rjwXrxP/bL3Ekr6pkBzTiF3jkHSqKwXkYfu1U=;
 b=73FmO6QdCa9t9WcZVdQ0WcQkTHaZk2RZprL6kpAOX4gQ4iiO69MIEyg0W13ZhW3KZX
 lcQo647PWa1m4arASdOam5T4+8WCO71vGEAYRYPYu3ye7w3/TuTBL6XwBu610/+XaTzJ
 SUcgp9kzPIVlyS2GNeCVuvBQqwE4XFkdVAX6dKfJjLKXt8ypG6qeSPAXzjzqybuT/WTO
 2QaSgf3uicoObnoSEfuyTtX2smxyod16iHtKnJsenJ6gGZVLPdtZCr266ASt8PE9lIF6
 Zc+8z2SbjGUQNBnxaJZRAzSa1tZhFbtwrMMQ+1tkjxkCHhrK7MXGY6zos3OUdF+3WXVQ
 EUnA==
X-Gm-Message-State: ACgBeo3xSYx7D36evqBNiIEmkP6rFYPI9x6jqjUGlwqwVwplVs7vIPHd
 zdEIs375KL646afWUlKXMroRf5ytvwxfOKCr
X-Google-Smtp-Source: AA6agR5NTBUMCwCqzD4maT35fcM0h2LBJ7SBVgjtWktQzO3oKIY49GwCh2fMgOKZKi1TQRQZ/Xxh0Q==
X-Received: by 2002:a17:903:40c9:b0:16f:68b:fff7 with SMTP id
 t9-20020a17090340c900b0016f068bfff7mr3877433pld.29.1659462244850; 
 Tue, 02 Aug 2022 10:44:04 -0700 (PDT)
Received: from ccs100203-Sabre-15.home
 (2001-b011-7006-16b6-a063-3fef-d931-3755.dynamic-ip6.hinet.net.
 [2001:b011:7006:16b6:a063:3fef:d931:3755])
 by smtp.gmail.com with ESMTPSA id
 r2-20020a17090a1bc200b001f31468f2f4sm12662133pjr.46.2022.08.02.10.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Aug 2022 10:44:04 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Cc: Shao-Tse Hung <ccs100203@gmail.com>
Date: Wed,  3 Aug 2022 01:44:00 +0800
Message-Id: <20220802174400.219630-1-ccs100203@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 02 Aug 2022 14:19:53 -0400
Subject: [lttng-dev] [PATCH] Fix: revise obsolete command in README.md
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Shao-Tse Hung via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Shao-Tse Hung <ccs100203@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

The obsolete command `make bench` was replaced by `make short_bench` and `make long_bench` in 2015.
However, this command wasn't revised in README, so I follow the previous commit and rewrite it.

Signed-off-by: Shao-Tse Hung <ccs100203@gmail.com>
---
 README.md | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/README.md b/README.md
index a8318c8..1e75589 100644
--- a/README.md
+++ b/README.md
@@ -426,14 +426,15 @@ Make targets
 ------------
 
 In addition to the usual `make check` target, Userspace RCU features
-`make regtest` and `make bench` targets:
+`make regtest`, `make short_bench` and `make long_bench` targets:
 
   - `make check`: short tests, meant to be run when rebuilding or
     porting Userspace RCU.
   - `make regtest`: long (many hours) test, meant to be run when
     modifying Userspace RCU or porting it to a new architecture or
     operating system.
-  - `make bench`: long (many hours) benchmarks.
+  - `make short_bench`: short benchmarks, 3 seconds per test.
+  - `make long_bench`: long (many hours) benchmarks, 30 seconds per test.
 
 
 Known issues
-- 
2.25.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
