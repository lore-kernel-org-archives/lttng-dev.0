Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3988CC433EF
	for <lttng-dev@archiver.kernel.org>; Mon, 18 Jul 2022 21:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1658180853;
	bh=lxyXdOhLGUmT5G7RAh1bzQAZHjYik3IWrE4aVgmD7mU=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Y4pxMlGFYjvBGt5CE4s03PLq+V3+MLp9f+Ngq7qc98a2zpFY484oeInmCcXYsct2A
	 KVs8BGv3HMdzYENZIga3uY4pOTCtiyGio0C1FRdvZf4QS21q05/Vworv8si3qbOL0m
	 uthhcPon+EEVoJbm00BySJcBDGzv34/1zATVij9bdt/ZpPoIIwxNbH2kYgcDYqH41o
	 Phn50q1dtv7TtqJGtAB7CQS/Qbx94/nLtfLc8J0dyFywQcOiacBIK7oI9vBRUiC6tG
	 fmftwEO2qRzcvlPpPvfsIaI/sVHl6FoDoArhQw8L66HFH4hl+7lKDSNmi4BkVnVJ8y
	 qdcBkVl96XvEQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LmwYJ1PQCzPMf;
	Mon, 18 Jul 2022 17:47:32 -0400 (EDT)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by lists.lttng.org (Postfix) with ESMTPS id 4LmwYG50gBzPdj
 for <lttng-dev@lists.lttng.org>; Mon, 18 Jul 2022 17:47:30 -0400 (EDT)
Received: by mail-ej1-x62c.google.com with SMTP id ez10so23712532ejc.13
 for <lttng-dev@lists.lttng.org>; Mon, 18 Jul 2022 14:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D32zjsn11O9LLqgaXHxRwX80oRXiqsl+51v7lDXo3LU=;
 b=VEm+vjpFMtuYybs/+LDFQR1qimuD2OoXnPlp8v2nCOTYp1DOlFnb3g6L5izRj60nhQ
 ON/57z4byKCHaBY5+AdEGC03ab2LV+ORHsNzENLMOuRAjEqI3w3od24qvWgamZ4EPmWp
 USVvY3ySek9M3M5EcU4BT0gLhKVfB769nMnvXVPOr/0gkFMyaT9pxYOvq3PytTHkyWdL
 0/xbwY+DdxRyFNEEFZfUVNdPDM5ICPpMNNR6hZwMqgdSI8Fb7KuFcjkylYGi8S+xFMVH
 q0mAjH31OqrjZS1vQgmLFfwGwLgboC5L0My5daIFZ0o6K42jndQtmTDIO40XzMpct0nR
 +DLQ==
X-Gm-Message-State: AJIora9ADYlDt32k4Tnt96rx2xIPv08INlkakn/RGDsBydYfzJijy6T8
 Hpfe4RpEEE6T1ZAw+tXimA0BBR0z3yyG+w==
X-Google-Smtp-Source: AGRyM1tSFNvh7rxsEFsx3W6V1EWTTVqzy5iFW/eiY7gSZVZ73afqPu9eGKVg7SBFYe7w/sc3hP0peg==
X-Received: by 2002:a17:907:728c:b0:72b:995f:78d with SMTP id
 dt12-20020a170907728c00b0072b995f078dmr27682514ejc.348.1658180849143; 
 Mon, 18 Jul 2022 14:47:29 -0700 (PDT)
Received: from debian-noppl.. (62-178-205-20.cable.dynamic.surfer.at.
 [62.178.205.20]) by smtp.gmail.com with ESMTPSA id
 h3-20020a056402094300b0043aba618bf6sm9448173edz.80.2022.07.18.14.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jul 2022 14:47:28 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Mon, 18 Jul 2022 23:47:24 +0200
Message-Id: <20220718214724.124127-1-nolange79@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH] Improve tracef/tracelog to use the stack for
 small strings
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

Support two common cases, one being that the resulting message is
small enough to fit into a on-stack buffer.
The seconds being the common 'printf("%s", "Message")' scheme.

Unfortunately, iterating a va_list is destructive,
so it has to be copied before calling vprintf.

The implementation was moved to a separate file,
used by both tracef.c and tracelog.c.

Signed-off-by: Norbert Lange <nolange79@gmail.com>
---
v2:
-   move define into src/common/tracer.h
    see https://lists.lttng.org/pipermail/lttng-dev/2021-May/029977.html
-   moved macro magic into common tracelog-internal.h header
-   rebased onto master
---
 src/common/tracer.h                   |  2 +
 src/lib/lttng-ust/tracef.c            | 32 +++--------
 src/lib/lttng-ust/tracelog-internal.h | 83 +++++++++++++++++++++++++++
 src/lib/lttng-ust/tracelog.c          | 40 +++----------
 4 files changed, 102 insertions(+), 55 deletions(-)
 create mode 100644 src/lib/lttng-ust/tracelog-internal.h

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
diff --git a/src/lib/lttng-ust/tracef.c b/src/lib/lttng-ust/tracef.c
index c05c7811..92911e1d 100644
--- a/src/lib/lttng-ust/tracef.c
+++ b/src/lib/lttng-ust/tracef.c
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
diff --git a/src/lib/lttng-ust/tracelog-internal.h b/src/lib/lttng-ust/tracelog-internal.h
new file mode 100644
index 00000000..291ff27c
--- /dev/null
+++ b/src/lib/lttng-ust/tracelog-internal.h
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
diff --git a/src/lib/lttng-ust/tracelog.c b/src/lib/lttng-ust/tracelog.c
index 8147d7a3..bd38032c 100644
--- a/src/lib/lttng-ust/tracelog.c
+++ b/src/lib/lttng-ust/tracelog.c
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
2.35.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
