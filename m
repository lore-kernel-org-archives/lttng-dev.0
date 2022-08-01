Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDE7C19F2B
	for <lttng-dev@archiver.kernel.org>; Mon,  1 Aug 2022 14:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1659364541;
	bh=7cLGrMPelo0V51IF+rAsAS1sJ7gmos/tFs8HNO7+5hs=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=DgSp52XVQTCWQbsWnuVk9Hqmqa0BNPkI3nJ/tuZRUKlrCOGWvCY+4zQ+nO3mKdtR9
	 /VQ/Si/yePHE/MAhA6MO6tnkAyb9bzh+liuyuJvuF++hJ6WnsBTtAtfVeB1089blIK
	 M3nd7Q3JPkxcXNb7I6RrcRc9JGrZFoF1wqA5rBOVSDiQaDbyquR2mxcQcM3sC7l+rN
	 FIfxaiOX7Jit7ZFnwNKcGjiJNH7vXGken5V4RWvfsMbg8yPDa71FA3stBjn+djb9Wd
	 xh0n+RcmPimO/4kDZ9Vt1GfjChf2Ktk+Q13l4cxIVmAQvthd2by+pnQrEUeD9HuyEQ
	 piVd5b0kls1jQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LxLJX6Jktz117L;
	Mon,  1 Aug 2022 10:35:40 -0400 (EDT)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by lists.lttng.org (Postfix) with ESMTPS id 4LxLJV2wBVz11G8
 for <lttng-dev@lists.lttng.org>; Mon,  1 Aug 2022 10:35:38 -0400 (EDT)
Received: by mail-wr1-x430.google.com with SMTP id v3so13457515wrp.0
 for <lttng-dev@lists.lttng.org>; Mon, 01 Aug 2022 07:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tSwtoqD/RHGWVHZLMEPnvy9Fqx94VE99yDdIBdnQQho=;
 b=qNkGK3ytVvVyxPKNUwEfzRpdJ+zd7VTMwq2880sDtWf61fwiExP8WmANcEFoC7VNra
 D5jdym/MVtGKRd4BgLXcYTjk4oKlScJnzFkbdy9jRVaDTCVfHZ/9NdqmEsC0t9HUt0oq
 0a9uG+VY/EeO/JG43thG0W+UWX0afX0GCWq+3y3pZxHFc8n1wPLLMxFYhOTjH+YupRyC
 9v5OiZCYp/dSw3mOi9YTbA5ErZHWnQ7r/lE62CK4wU5Gh57gBuWM+jl/LWt6rL10G1zS
 FacuaEgnl8bESfDl2j9jR5AT3Vo1u7awp/4fsSUBqcIWE9SyDAWi8ddiZVC1r4FUHrow
 MoOA==
X-Gm-Message-State: ACgBeo3qZwLYYAgooVHB9hDrIlir732zcyV0xKamhRkzxD9+h5Wl/AP1
 xveArIi1FPYuSg5C5KV8LIsm286ZtUY=
X-Google-Smtp-Source: AA6agR7x+bWdYbaeC1XELVvmxi81WTn117ZeWZsyedUB0IlSGcJKUCJFbcBsc7RjIFxreqJKRYAYcw==
X-Received: by 2002:adf:e4c1:0:b0:21e:b883:1295 with SMTP id
 v1-20020adfe4c1000000b0021eb8831295mr9913877wrm.205.1659364536909; 
 Mon, 01 Aug 2022 07:35:36 -0700 (PDT)
Received: from lano-work.. ([80.120.136.76]) by smtp.gmail.com with ESMTPSA id
 o5-20020a05600c510500b003a2d6c623f3sm20861260wms.19.2022.08.01.07.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Aug 2022 07:35:36 -0700 (PDT)
X-Google-Original-From: Norbert Lange <norbert.lange@andritz.com>
To: lttng-dev@lists.lttng.org
Date: Mon,  1 Aug 2022 16:35:24 +0200
Message-Id: <20220801143524.160208-1-norbert.lange@andritz.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH v2] Improve tracef/tracelog to use the stack for
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

From: Norbert Lange <nolange79@gmail.com>

Support two common cases, one being that the resulting message is
small enough to fit into a on-stack buffer.
The seconds being the common 'printf("%s", "Message")' scheme.

Unfortunately, iterating a va_list is destructive,
so it has to be copied before calling vprintf.

The implementation was moved to a separate file,
used by both tracef.c and tracelog.c.

Signed-off-by: Norbert Lange <nolange79@gmail.com>
---
v2 -> v3:

*   Wrap macro in do/while
*   drop loop
*   other changes in response to feedback

v2:
-   move define into src/common/tracer.h
    see https://lists.lttng.org/pipermail/lttng-dev/2021-May/029977.html
-   moved macro magic into common tracelog-internal.h header
-   rebased onto master
---
 src/common/tracer.h                   |  2 +
 src/lib/lttng-ust/tracef.c            | 32 +++------
 src/lib/lttng-ust/tracelog-internal.h | 95 +++++++++++++++++++++++++++
 src/lib/lttng-ust/tracelog.c          | 40 +++--------
 4 files changed, 114 insertions(+), 55 deletions(-)
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
index 00000000..34537023
--- /dev/null
+++ b/src/lib/lttng-ust/tracelog-internal.h
@@ -0,0 +1,95 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (C) 2013-2014 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright (C) 2021 Norbert Lange <nolange79@gmail.com>
+ *
+ * Shared helper macro for tracelog and tracef.
+ */
+
+#define LTTNG_UST_TRACELOG_VARARG(fmt, callback, ...) \
+	do { \
+		va_list ap; \
+		char local_buf[LTTNG_TRACE_PRINTF_BUFSIZE]; \
+		size_t len = 0; \
+		char *msg = local_buf; \
+		char *alloc_buff = NULL; \
+\
+		if (caa_unlikely(fmt[0] == '%' && fmt[1] == 's' && fmt[2] == '\0')) { \
+			va_start(ap, fmt); \
+			msg = va_arg(ap, char *); \
+			va_end(ap); \
+			len = strlen(msg); \
+		} else { \
+			int ret; \
+			size_t buflen = sizeof(local_buf); \
+\
+			/* On-stack buffer attempt */ \
+			va_start(ap, fmt); \
+			ret = vsnprintf(msg, buflen, fmt, ap); \
+			va_end(ap); \
+			if (caa_unlikely(ret < 0)) \
+				break; \
+			len = (size_t)ret; \
+\
+			if (caa_unlikely(len >= sizeof(local_buf))) { \
+				buflen = len + 1; \
+				alloc_buff = (char *)malloc(buflen); \
+				if (!alloc_buff) \
+					goto end; \
+				msg = alloc_buff; \
+				va_start(ap, fmt); \
+				ret = vsnprintf(msg, buflen, fmt, ap); \
+				va_end(ap); \
+				lttng_ust_runtime_bug_on(ret < 0 || (size_t)ret != buflen - 1); \
+				len = (size_t)ret; \
+			} \
+		} \
+\
+		callback(__VA_ARGS__); \
+end: \
+		/* Don't call a potentially instrumented forbidden free needlessly. */ \
+		if (caa_unlikely(alloc_buff)) \
+			free(alloc_buff); \
+	} while(0)
+
+#define LTTNG_UST_TRACELOG_VALIST(fmt, ap, callback, ...) \
+	do { \
+		char local_buf[LTTNG_TRACE_PRINTF_BUFSIZE]; \
+		size_t len = 0; \
+		char *msg = local_buf; \
+		char *alloc_buff = NULL; \
+\
+		if (caa_unlikely(fmt[0] == '%' && fmt[1] == 's' && fmt[2] == '\0')) { \
+			msg = va_arg(ap, char *); \
+			len = strlen(msg); \
+		} else { \
+			va_list ap2; \
+			int ret; \
+			size_t buflen = sizeof(local_buf); \
+\
+			va_copy(ap2, ap); \
+			ret = vsnprintf(msg, buflen, fmt, ap2); \
+			va_end(ap2); \
+			if (caa_unlikely(ret < 0)) \
+				break; \
+			len = (size_t)ret; \
+\
+			if (caa_unlikely(len >= sizeof(local_buf))) { \
+				buflen = len + 1; \
+				alloc_buff = (char *)malloc(buflen); \
+				if (!alloc_buff) \
+					goto end; \
+				msg = alloc_buff; \
+				ret = vsnprintf(msg, buflen, fmt, ap); \
+				lttng_ust_runtime_bug_on(ret < 0 || (size_t)ret != buflen - 1); \
+				len = (size_t)ret; \
+			} \
+		} \
+\
+		callback(__VA_ARGS__); \
+end: \
+		/* Don't call a potentially instrumented forbidden free needlessly. */ \
+		if (caa_unlikely(alloc_buff)) \
+			free(alloc_buff); \
+	} while (0)
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
