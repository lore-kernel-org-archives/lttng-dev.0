Return-Path: <SRS0=5oIU=KO=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A57CC433B4
	for <lttng-dev@archiver.kernel.org>; Wed, 19 May 2021 16:57:10 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7BC60FDA
	for <lttng-dev@archiver.kernel.org>; Wed, 19 May 2021 16:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7BC60FDA
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FlfDM6pkBz1r66;
	Wed, 19 May 2021 12:57:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621443428;
	bh=+kpr7XgEbzJxlgDxtS/DGQiE+D0afUm/rC+uIlU60b0=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=iEz3eBj2K0jltIQ+QHsanyqAjEQbfabSD1hRUxTXIpyXIJjVkMG2hgYigfFHbOemf
	 VPyxBKfjs9fOfmZMqKyUBMv+tp8nPvMsQjjYHoh7L5L8aqJ2wBW3le5bnq2Rg/3BAq
	 59DgGiJ004NkTaXj8fHTD9a116DWqUvvXe0M7MmDpr8QQ/BjKwHKtyBy2HwUbQdNWa
	 REs7n0xNSocDaoTzOn1iPICwFJXjG+iyXu+dBLRaiQvNPAVuSYi4uPy9zOz7LUN+ax
	 iDi2nu3ahZ1Zf5oAVgC+Pg9YtOJ26AkaNImJtXdGz4dTUB1EUwDE4bVGeCi5+3ANSW
	 EaXz0QA1zny6g==
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by lists.lttng.org (Postfix) with ESMTPS id 4FlfDK73bXz1r5y
 for <lttng-dev@lists.lttng.org>; Wed, 19 May 2021 12:57:05 -0400 (EDT)
Received: by mail-ej1-x629.google.com with SMTP id p24so19730767ejb.1
 for <lttng-dev@lists.lttng.org>; Wed, 19 May 2021 09:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z5ae31+4ia6dQl/pNo3N/NmYHzveVLGBBbTE6TS8glc=;
 b=nYU/3yxxMuJO2Vou4IjoyMUv7FIVsZeLnMCzLnyRVJQq6JhLTHUllM/uG8eOG8nWPA
 zAEl2aQluvsbglYQAJDv2vG0jj3RLl24gyZuPDTdwl0fBsrRLeor710szV7Btpv3AXIX
 yKbfuketthhBEkkw86zVJM64IHdXYDwkFIElSAVdEoYV6a+ldIkB+a+1QCfc4zEqiJIN
 xgKhVZmdxxM8BJxiQ/DSSsba/3yljC0VJyg4mYocpN1LmKckIZFMgR3hcsz8yuRAwTrI
 tGr3XD1A8yPPuL6khKxzuJ8LtfzmK0xgVG6QLkck4R5aM57R0CSE80FpnWD9eMwxv4SB
 olxw==
X-Gm-Message-State: AOAM530n5LrhwI6+yqYyo2DV7LhDdMljqYk5TSCOw3sDcA/D2YU8zZpu
 Anf4g8m4eJMhOKo+4OKs041ufiD3tN/e4A==
X-Google-Smtp-Source: ABdhPJxGxcCADHZ7Qsvb8IR2/J3JC5q9V5MvmWZmkg5sYeZixMgXTEcbCwXwaJl/12IaEQ0lVaDwUg==
X-Received: by 2002:a17:906:3715:: with SMTP id
 d21mr171819ejc.34.1621443424578; 
 Wed, 19 May 2021 09:57:04 -0700 (PDT)
Received: from debian-noppl.. (84-114-45-16.cable.dynamic.surfer.at.
 [84.114.45.16])
 by smtp.gmail.com with ESMTPSA id p4sm149540ejr.81.2021.05.19.09.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 May 2021 09:57:04 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Wed, 19 May 2021 18:56:48 +0200
Message-Id: <20210519165648.792939-1-nolange79@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH] Avoid using the heap for small strings with
 tracef/tracelog
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
From: Norbert Lange via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Norbert Lange <nolange79@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Try to use vsnprintf with a 512 Byte buffer on the Stack,
if that fails allocate a larger one.

Signed-off-by: Norbert Lange <nolange79@gmail.com>
---
 liblttng-ust/tracef.c   | 13 ++++++++++---
 liblttng-ust/tracelog.c | 12 +++++++++---
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/liblttng-ust/tracef.c b/liblttng-ust/tracef.c
index ea98e43e..18c29e25 100644
--- a/liblttng-ust/tracef.c
+++ b/liblttng-ust/tracef.c
@@ -32,17 +32,24 @@
 void _lttng_ust_tracef(const char *fmt, ...)
 {
 	va_list ap;
-	char *msg;
+	char local_buf[512];
+	char *msg = local_buf;
 	int len;
 
 	va_start(ap, fmt);
-	len = vasprintf(&msg, fmt, ap);
+	len = vsnprintf(local_buf, sizeof(local_buf), fmt, ap);
+	if (len >= sizeof(local_buf)) {
+		msg = (char *)malloc(len + 1);
+		len = msg ? vsnprintf(msg, len + 1, fmt, ap) : -1;
+	}
+
 	/* len does not include the final \0 */
 	if (len < 0)
 		goto end;
 	__tracepoint_cb_lttng_ust_tracef___event(msg, len,
 		LTTNG_UST_CALLER_IP());
-	free(msg);
 end:
+	if (msg != local_buf)
+		free(msg);
 	va_end(ap);
 }
diff --git a/liblttng-ust/tracelog.c b/liblttng-ust/tracelog.c
index 65fc87ed..a5d110fa 100644
--- a/liblttng-ust/tracelog.c
+++ b/liblttng-ust/tracelog.c
@@ -35,19 +35,25 @@
 			const char *fmt, ...) \
 	{ \
 		va_list ap; \
-		char *msg; \
+		char local_buf[512]; \
+		char *msg = local_buf; \
 		int len; \
 		\
 		va_start(ap, fmt); \
-		len = vasprintf(&msg, fmt, ap); \
+		len = vsnprintf(local_buf, sizeof(local_buf), fmt, ap); \
+		if (len >= sizeof(local_buf)) { \
+			msg = (char *)malloc(len + 1); \
+			len = msg ? vsnprintf(msg, len + 1, fmt, ap) : -1; \
+		} \
 		/* len does not include the final \0 */ \
 		if (len < 0) \
 			goto end; \
 		__tracepoint_cb_lttng_ust_tracelog___##level(file, \
 			line, func, msg, len, \
 			LTTNG_UST_CALLER_IP()); \
-		free(msg); \
 	end: \
+		if (msg != local_buf) \
+			free(msg); \
 		va_end(ap); \
 	}
 
-- 
2.30.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
