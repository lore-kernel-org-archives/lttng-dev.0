Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE2EC00144
	for <lttng-dev@archiver.kernel.org>; Mon,  1 Aug 2022 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1659364640;
	bh=uDMk3hEyOh/xIiMCT2Sxcc0/tLf4Aqnfch9fZsL1B0A=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=s5x9v3xbhVZpOT7Kq4wYfgF9EWdRRVaL8Q5hj3hKQbyTHt9dZvUa1RviP+/lcccHM
	 uOxoM1I8bkLyhdNdYq63BvyPpTWY8hxC2A+0GUsRwqwx3+qSO/872fuWuP7fppqXDb
	 zJQvBNT5FWM4IE7OFb7o3VvBhwCRsMTMJx3DHaiG7X2n2Vi+R9uGPwBIj5lNMvboUS
	 8TW0bcJEQkvB3K+MNvNKyhJTxqaaOJPC7Bqiic16HlwiSbVmcP5Iw/rCITG/KoUvJD
	 qrGjddcCNNfqvzF7ohacDoR+5yTCl4UuCaOHCYBIrDFdYybt8bgQFLodc4JlUyl5iC
	 OSU5P0qHqdmtQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LxLLS1r5mz117M;
	Mon,  1 Aug 2022 10:37:20 -0400 (EDT)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by lists.lttng.org (Postfix) with ESMTPS id 4LxLLL1mrgz11J3
 for <lttng-dev@lists.lttng.org>; Mon,  1 Aug 2022 10:37:14 -0400 (EDT)
Received: by mail-wr1-x434.google.com with SMTP id q30so9964910wra.11
 for <lttng-dev@lists.lttng.org>; Mon, 01 Aug 2022 07:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=580lvZ3cmjnokZQw+sgBG8fUbZfTEpsNeWRApUlnZdQ=;
 b=FrQdnHWVvfKtfWdYYMqC024I77X9N9zOMLGlcOOtSWqOpGN1MNVQzyE6pqNT2P8hQl
 Y13ST9EY3SXbdUgezIMu4v25J1wzUnU6TNUpwwAMjta0qj9PHVBsRLja6UL/mMspge0c
 g72APqRHqVd2hITVzzKx+MAMcFJ9S2D72kHPBuo8eS7oC3KPmGHMJDmrRTurZ7ilC4Sm
 0/VRBRSHrkF1yoVQbWeddGBAzl0e+3Q46DNlbbqM+C1XtgwVUP8LL5jZgRIR7tXBHEBX
 Vbo/+sen15ZhlVbRGe2vYHlGIdSPEA6Oo2GMh7Knr/RLS9J2cHQSUXU2h7w/flUb8/nS
 EDfQ==
X-Gm-Message-State: ACgBeo1cQxcl2EbMB3yBBTi3tgrMRkBd0GV5u3knpPFvif6uFxeijE/1
 2p58qxJMl7T8IfUwH2s5gXEBc9/uaPI=
X-Google-Smtp-Source: AA6agR47peiaTr/pJggbvNN6yp9YMBIW2ysvkx/8r2NRXldQK9ZcRzJdOuvD7J9UyfneItGh6QyBaQ==
X-Received: by 2002:a5d:4344:0:b0:21e:cc0b:5e32 with SMTP id
 u4-20020a5d4344000000b0021ecc0b5e32mr10487368wrr.171.1659364633096; 
 Mon, 01 Aug 2022 07:37:13 -0700 (PDT)
Received: from lano-work.. ([80.120.136.76]) by smtp.gmail.com with ESMTPSA id
 p18-20020a5d4592000000b0021f73c66198sm7912500wrq.1.2022.08.01.07.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Aug 2022 07:37:12 -0700 (PDT)
X-Google-Original-From: Norbert Lange <norbert.lange@andritz.com>
To: lttng-dev@lists.lttng.org
Date: Mon,  1 Aug 2022 16:37:00 +0200
Message-Id: <20220801143700.160380-2-norbert.lange@andritz.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801143700.160380-1-norbert.lange@andritz.com>
References: <20220801143700.160380-1-norbert.lange@andritz.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH v2 2/2] lttng_ust_init_thread: call
 urcu_register_thread
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
From: Norbert Lange via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Norbert Lange <nolange79@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

From: Norbert Lange <nolange79@gmail.com>

Eagerly register the thread, and avoid taking mutex during the
first tracepoint.

Signed-off-by: Norbert Lange <nolange79@gmail.com>
Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/lib/lttng-ust/lttng-ust-comm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/lib/lttng-ust/lttng-ust-comm.c b/src/lib/lttng-ust/lttng-ust-comm.c
index 0a039fef..0fe2da46 100644
--- a/src/lib/lttng-ust/lttng-ust-comm.c
+++ b/src/lib/lttng-ust/lttng-ust-comm.c
@@ -447,6 +447,8 @@ void lttng_ust_init_thread(void)
 	 * this thread attempts to use them.
 	 */
 	lttng_ust_common_init_thread(LTTNG_UST_INIT_THREAD_MASK);
+
+	lttng_ust_urcu_register_thread();
 }
 
 int lttng_get_notify_socket(void *owner)
-- 
2.35.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
