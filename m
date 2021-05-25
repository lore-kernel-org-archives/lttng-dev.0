Return-Path: <SRS0=Lz2h=KU=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D957DC2B9F8
	for <lttng-dev@archiver.kernel.org>; Tue, 25 May 2021 13:44:34 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 371E86141B
	for <lttng-dev@archiver.kernel.org>; Tue, 25 May 2021 13:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371E86141B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FqFgM3qzYz1w4g;
	Tue, 25 May 2021 09:44:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621950272;
	bh=Yl07QymrvPGbK+TY3nac1U3QZGAYzEUfzn6MlBIGOic=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=k18ud/ySfGyW1cl66BrzThNi0R+CU6+TOs/1411zCP59WDfvTkMcBacPTLlrMyFTj
	 XXwXfA54aMl7HpucwMePjLiTj+c4IchASRNBRngmfXFYhHUzMVi8TNHS/8j5b7peyf
	 BqllrwSRkzhOquzDwFtn7E/gdFdrqfQQuiewCFSq2uim74vWGCJSGtnVFwue/Nrx9A
	 8+5Dj4dZLH7vTMUycMpQn0UOkG9EgzfyrWcOUm8WOLK3yEXG6NNy58/iZ0S7IV0Zl1
	 54anI9MA2pqgPs7m0JF5ABOOI3yPjZCmzSO06lYcetLz4EMeMT2EKe59Vo2cnnonRf
	 TbHm3fpALnQUA==
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by lists.lttng.org (Postfix) with ESMTPS id 4FqFgK6XNSz1wB2
 for <lttng-dev@lists.lttng.org>; Tue, 25 May 2021 09:44:29 -0400 (EDT)
Received: by mail-ed1-x531.google.com with SMTP id b17so36314957ede.0
 for <lttng-dev@lists.lttng.org>; Tue, 25 May 2021 06:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8kDHnmNgXiQU5RZ//6vs6Kg+LUSmBylDzJvjrG3c40U=;
 b=N81ilUnaTsGacbwi/medF9mIr9ksoo/A90z10IoowGVCNUgep3Zh8Jq7+wXZPSZ3K+
 QAooTS2RuIaR5R/1AcebaXF9yGr7sTOKNpqJvC/DrZPhdgiGHujTzF1NYNCb5/8zRLHL
 x5snHjFNNG2yIPzWz8wD5kZYb5dfDCt3xyEmtlz5E6v+mZaz2QiDTO/XmEH8QGt1N7b/
 CueA6IN8oSXzVN88T8gvdMCSggK4qGThwahXbn9CU0s9PrjM/OfzIVP/wrB9FZvWSBOV
 eAbO62ctG9p5vnccOiegRhnrR+3vyuUEZmUW4wFw07hYv2cf/UoI+7PoxcmAq29ZiSYv
 LYuQ==
X-Gm-Message-State: AOAM533K2whLl8NjJv3uu0NCTvMkqjtKcTFJ5RQ4sm9f0+8Uyw/fqBd4
 685X+C/tWyk30Phu7eGszqKeHmUjbIg0pg==
X-Google-Smtp-Source: ABdhPJxVYOPLHQbpDzGyP7WirABuwG3dY0p16Kz0KYfXqcGEhDlLlI51Bt5nLUEGcqXT0p2u/ENZlQ==
X-Received: by 2002:a05:6402:34c8:: with SMTP id
 w8mr31981107edc.243.1621950268414; 
 Tue, 25 May 2021 06:44:28 -0700 (PDT)
Received: from debian-noppl.. (84-114-45-16.cable.dynamic.surfer.at.
 [84.114.45.16])
 by smtp.gmail.com with ESMTPSA id c6sm5026252eje.9.2021.05.25.06.44.27
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 May 2021 06:44:27 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Tue, 25 May 2021 15:44:22 +0200
Message-Id: <20210525134422.620425-1-nolange79@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH lttng-ust] Improve tracef/tracelog to use the
 stack for small strings
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

Support two common cases, one being that the resulting message is
small enough to fit into a on-stack buffer.
The seconds being the common 'printf("%s", "Message")' scheme.

Unfortunately, iterating a va_list is destructive,
so it has to be copied before calling vprintf.

The implementation was moved to a separate file,
used by both tracef.c and tracelog.c.

Signed-off-by: Norbert Lange <nolange79@gmail.com>
---
 src/common/tracer.h                           |  2 +
 src/lib/lttng-ust-tracepoint/tracef.c         | 32 ++-----
 .../lttng-ust-tracepoint/tracelog-internal.h  | 83 +++++++++++++++++++
 src/lib/lttng-ust-tracepoint/tracelog.c       | 40 ++-------
 4 files changed, 102 insertions(+), 55 deletions(-)
 create mode 100644 src/lib/lttng-ust-tracepoint/tracelog-internal.h

diff --git a/src/common/tracer.h b/src/common/tracer.h
index 2affd6ab..8e18c9b5 100644
--- a/src/common/tracer.h
+++ b/src/common/tracer.h
@@ -26,6 +26,8 @@
 #define LTTNG_RFLAG_EXTENDED		RING_BUFFER_RFLAG_END
 #define LTTNG_RFLAG_END			(LTTNG_RFLAG_EXTENDED << 1)
 
+#define LTTNG_TRACE_PRINTF_BUFSIZE	512
+
 /*
  * LTTng client type enumeration. Used by the consumer to map the
  * callbacks from its own address space.
diff --git a/src/lib/lttng-ust-tracepoint/tracef.c b/src/lib/lttng-ust-tracepoint/tracef.c
index c05c7811..92911e1d 100644
--- a/src/lib/lttng-ust-tracepoint/tracef.c
+++ b/src/lib/lttng-ust-tracepoint/tracef.c
@@ -7,6 +7,7 @@
 #define _LGPL_SOURCE
 #include <stdio.h>
 #include "common/macros.h"
+#include "common/tracer.h"
 
 /* The tracepoint definition is public, but the provider definition is hidden. */
 #define LTTNG_UST_TRACEPOINT_PROVIDER_HIDDEN_DEFINITION
@@ -15,39 +16,22 @@
 #define LTTNG_UST_TRACEPOINT_DEFINE
 #include "lttng-ust-tracef-provider.h"
 
-static inline
-void lttng_ust___vtracef(const char *fmt, va_list ap)
-	__attribute__((always_inline, format(printf, 1, 0)));
-static inline
-void lttng_ust___vtracef(const char *fmt, va_list ap)
-{
-	char *msg;
-	const int len = vasprintf(&msg, fmt, ap);
-
-	/* len does not include the final \0 */
-	if (len < 0)
-		goto end;
-	lttng_ust_tracepoint_cb_lttng_ust_tracef___event(msg, len,
-		LTTNG_UST_CALLER_IP());
-	free(msg);
-end:
-	return;
-}
+#include "tracelog-internal.h"
 
 void lttng_ust__vtracef(const char *fmt, va_list ap)
 	__attribute__((format(printf, 1, 0)));
 void lttng_ust__vtracef(const char *fmt, va_list ap)
 {
-	lttng_ust___vtracef(fmt, ap);
+	LTTNG_UST_TRACELOG_VALIST(fmt, ap,
+		lttng_ust_tracepoint_cb_lttng_ust_tracef___event,
+		msg, len, LTTNG_UST_CALLER_IP());
 }
 
 void lttng_ust__tracef(const char *fmt, ...)
 	__attribute__((format(printf, 1, 2)));
 void lttng_ust__tracef(const char *fmt, ...)
 {
-	va_list ap;
-
-	va_start(ap, fmt);
-	lttng_ust___vtracef(fmt, ap);
-	va_end(ap);
+	LTTNG_UST_TRACELOG_VARARG(fmt,
+		lttng_ust_tracepoint_cb_lttng_ust_tracef___event,
+		msg, len, LTTNG_UST_CALLER_IP());
 }
diff --git a/src/lib/lttng-ust-tracepoint/tracelog-internal.h b/src/lib/lttng-ust-tracepoint/tracelog-internal.h
new file mode 100644
index 00000000..291ff27c
--- /dev/null
+++ b/src/lib/lttng-ust-tracepoint/tracelog-internal.h
@@ -0,0 +1,83 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (C) 2013-2014 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright (C) 2021 Norbert Lange <nolange79@gmail.com>
+ *
+ * Shared helper macro for tracelog and tracef
+ */
+
+#define LTTNG_UST_TRACELOG_VARARG(fmt, callback, ...) \
+	va_list ap; \
+	char local_buf[LTTNG_TRACE_PRINTF_BUFSIZE]; \
+	int len; \
+	char *msg = local_buf; \
+	size_t buflen = sizeof(local_buf); \
+	char *alloc_buff = NULL; \
+\
+	if (caa_unlikely(fmt[0] == '%' && fmt[1] == 's' && fmt[2] == '\0')) { \
+		va_start(ap, fmt); \
+		msg = va_arg(ap, char *); \
+		va_end(ap); \
+		len = strlen(msg); \
+	} else \
+		for(;;) { \
+			va_start(ap, fmt); \
+			len = vsnprintf(msg, buflen, fmt, ap); \
+			va_end(ap); \
+\
+			if (caa_unlikely(len >= (int)sizeof(local_buf) && !alloc_buff)) { \
+				buflen = (size_t)len + 1U; \
+				len = -1; \
+				alloc_buff = (char *)malloc(buflen); \
+				msg = alloc_buff; \
+				if (!alloc_buff) \
+					break; \
+			} else \
+				break; \
+		} \
+\
+	/* len does not include the final \0 */ \
+	if (caa_likely(len >= 0)) { \
+		callback(__VA_ARGS__); \
+	} \
+	/* Dont call a potentially instrumented forbidden free needlessly. */ \
+	if (caa_unlikely(alloc_buff)) \
+		free(alloc_buff);
+
+#define LTTNG_UST_TRACELOG_VALIST(fmt, ap, callback, ...) \
+	char local_buf[LTTNG_TRACE_PRINTF_BUFSIZE]; \
+	int len; \
+	char *msg = local_buf; \
+	size_t buflen = sizeof(local_buf); \
+	char *alloc_buff = NULL; \
+\
+	if (caa_unlikely(fmt[0] == '%' && fmt[1] == 's' && fmt[2] == '\0')) { \
+		msg = va_arg(ap, char *); \
+		len = strlen(msg); \
+	} else \
+		for(;;) { \
+			va_list ap2; \
+\
+			va_copy(ap2, ap); \
+			len = vsnprintf(msg, buflen, fmt, ap2); \
+			va_end(ap2); \
+\
+			if (caa_unlikely(len >= (int)sizeof(local_buf) && !alloc_buff)) { \
+				buflen = (size_t)len + 1U; \
+				len = -1; \
+				alloc_buff = (char *)malloc(buflen); \
+				msg = alloc_buff; \
+				if (!alloc_buff) \
+					break; \
+			} else \
+				break; \
+		} \
+\
+	/* len does not include the final \0 */ \
+	if (caa_likely(len >= 0)) { \
+		callback(__VA_ARGS__); \
+	} \
+	/* Dont call a potentially instrumented forbidden free needlessly. */ \
+	if (caa_unlikely(alloc_buff)) \
+		free(alloc_buff);
diff --git a/src/lib/lttng-ust-tracepoint/tracelog.c b/src/lib/lttng-ust-tracepoint/tracelog.c
index 8147d7a3..bd38032c 100644
--- a/src/lib/lttng-ust-tracepoint/tracelog.c
+++ b/src/lib/lttng-ust-tracepoint/tracelog.c
@@ -7,6 +7,7 @@
 #define _LGPL_SOURCE
 #include <stdio.h>
 #include "common/macros.h"
+#include "common/tracer.h"
 
 /* The tracepoint definition is public, but the provider definition is hidden. */
 #define LTTNG_UST_TRACEPOINT_PROVIDER_HIDDEN_DEFINITION
@@ -15,32 +16,9 @@
 #define LTTNG_UST_TRACEPOINT_DEFINE
 #include "lttng-ust-tracelog-provider.h"
 
+#include "tracelog-internal.h"
+
 #define LTTNG_UST_TRACELOG_CB(level) \
-	static inline \
-	void lttng_ust___vtracelog_##level(const char *file, \
-			int line, const char *func, \
-			const char *fmt, va_list ap) \
-		__attribute__((always_inline, format(printf, 4, 0))); \
-	\
-	static inline \
-	void lttng_ust___vtracelog_##level(const char *file, \
-			int line, const char *func, \
-			const char *fmt, va_list ap) \
-	{ \
-		char *msg; \
-		const int len = vasprintf(&msg, fmt, ap); \
-		\
-		/* len does not include the final \0 */ \
-		if (len < 0) \
-			goto end; \
-		lttng_ust_tracepoint_cb_lttng_ust_tracelog___##level(file, \
-			line, func, msg, len, \
-			LTTNG_UST_CALLER_IP()); \
-		free(msg); \
-	end: \
-		return; \
-	} \
-	\
 	void lttng_ust__vtracelog_##level(const char *file, \
 			int line, const char *func, \
 			const char *fmt, va_list ap) \
@@ -53,7 +31,9 @@
 			int line, const char *func, \
 			const char *fmt, va_list ap) \
 	{ \
-		lttng_ust___vtracelog_##level(file, line, func, fmt, ap); \
+		LTTNG_UST_TRACELOG_VALIST(fmt, ap, \
+			lttng_ust_tracepoint_cb_lttng_ust_tracelog___##level, \
+			file, line, func, msg, len, LTTNG_UST_CALLER_IP()); \
 	} \
 	\
 	void lttng_ust__tracelog_##level(const char *file, \
@@ -68,11 +48,9 @@
 			int line, const char *func, \
 			const char *fmt, ...) \
 	{ \
-		va_list ap; \
-		\
-		va_start(ap, fmt); \
-		lttng_ust___vtracelog_##level(file, line, func, fmt, ap); \
-		va_end(ap); \
+		LTTNG_UST_TRACELOG_VARARG(fmt, \
+			lttng_ust_tracepoint_cb_lttng_ust_tracelog___##level, \
+			file, line, func, msg, len, LTTNG_UST_CALLER_IP()); \
 	}
 
 LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_EMERG)
-- 
2.30.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
