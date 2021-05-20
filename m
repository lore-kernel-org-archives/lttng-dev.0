Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03190C433ED
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 12:18:22 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C023611AD
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 12:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C023611AD
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fm80D4F1Nz1rfn;
	Thu, 20 May 2021 08:18:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621513100;
	bh=1e+HgdzvFD7BvpQuYtftFGJ++rI2X2QAB5YTem2R+Ss=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Ck9glm1x1bpT2tDjPTuLmTcFAwf6PmYv9d+l4ydKbOAMVAEBbtzUjFokJ9ahKNrsN
	 YSwPJz269QIOV6hxGpca+RBLESkYIowEXS/9SrNnv/TcImS1COueLQTE9CPp0/VYIB
	 NDSJcwt0G8XBgrR82UqJjHGLyhdExrbdUh/MxjmXIQFqu2K946Qbe4gTgZM6YZkvko
	 H2X/5GfLvJqVE86xZjpi3aGQnwlFaz/nhzmOP6xGwkHV25cUxbMjTKf0FU3fq6mEEY
	 feUomkIp5/k2Mo3bhNccpQBJ3gNzNm0O/mduKgJJPFFBuFmWxvHco1z210pxuXR8Dh
	 32neNBBNkLBsw==
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fm8075lZTz1rfl
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 08:18:14 -0400 (EDT)
Received: by mail-ej1-x62b.google.com with SMTP id k14so21468036eji.2
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 05:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nAJW5skH9Wsik4fjT1rsjikfd7pJ+Ke/F35+E0Z/Uc4=;
 b=I8eRHraIhJjXbpMmM9jdaaZIVtht30Bjcz9EC4Bn1NhIzn1YNjdkujq1v+8kULd1Ex
 pUpfa6zDGYnnQhHr4D1aYycQqMW9QUWod6+xRmYpcxbZxXjHVmouizY7IlGk3sKwqDjI
 cK/t80558kOvYSKuC9W4umATo8roIrxZvPPCLjtaC9HhAxRNbJxra7ltQwDnH4O8A4/E
 sDRvEHfgrsXuTW3PfzkMwZVFLmfh9O9MGYMiKvMYUOqluXXlfLWmOIpgNdIbHnAvpvfS
 vKcyeIjCgCbcuEJjCsInAmhCmZlDcqDDbQekUSZOvMDi+EY46lDafpV8jFqh6XgIJFgc
 QYOQ==
X-Gm-Message-State: AOAM532lva7dKGEE+8TS7GBk2WT4jZMO3nzyc8RGCkQdjjocXx2oo4H7
 DIwy47F4tohqViQWFv9A74eZtoq+5/dKhg==
X-Google-Smtp-Source: ABdhPJxMN1z1R+ZyUVS6J3f77izmcCF1BbgO6Sq0dS8gKHsynrcpf4Ics5JtoV/k4J2zfgwz8f/KoA==
X-Received: by 2002:a17:906:3c1a:: with SMTP id
 h26mr4412508ejg.22.1621513093754; 
 Thu, 20 May 2021 05:18:13 -0700 (PDT)
Received: from debian-noppl.. (84-114-45-16.cable.dynamic.surfer.at.
 [84.114.45.16])
 by smtp.gmail.com with ESMTPSA id kx3sm1286319ejc.44.2021.05.20.05.18.13
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:18:13 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Thu, 20 May 2021 14:18:07 +0200
Message-Id: <20210520121807.55428-2-nolange79@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520121807.55428-1-nolange79@gmail.com>
References: <20210520121807.55428-1-nolange79@gmail.com>
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
This will result in the function never becoming inlined,
thus the helper function was manually "inlined".

Signed-off-by: Norbert Lange <nolange79@gmail.com>
---
 src/common/tracer.h          |  2 +
 src/lib/lttng-ust/tracef.c   | 83 ++++++++++++++++++++++++---------
 src/lib/lttng-ust/tracelog.c | 90 ++++++++++++++++++++++++------------
 3 files changed, 122 insertions(+), 53 deletions(-)

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
index c05c7811..21af5b9e 100644
--- a/src/lib/lttng-ust/tracef.c
+++ b/src/lib/lttng-ust/tracef.c
@@ -7,6 +7,7 @@
 #define _LGPL_SOURCE
 #include <stdio.h>
 #include "common/macros.h"
+#include "common/tracer.h"
 
 /* The tracepoint definition is public, but the provider definition is hidden. */
 #define LTTNG_UST_TRACEPOINT_PROVIDER_HIDDEN_DEFINITION
@@ -15,30 +16,40 @@
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
-
 void lttng_ust__vtracef(const char *fmt, va_list ap)
 	__attribute__((format(printf, 1, 0)));
 void lttng_ust__vtracef(const char *fmt, va_list ap)
 {
-	lttng_ust___vtracef(fmt, ap);
+	char local_buf[LTTNG_TRACE_PRINTF_BUFSIZE];
+	char *alloc_buff = NULL;
+	char *msg = local_buf;
+	size_t buflen = sizeof(local_buf);
+	int len = -1;
+
+	if (caa_unlikely(fmt[0] == '%' && fmt[1] == 's' && fmt[2] == '\0')) {
+		msg = va_arg(ap, char *);
+		len = strlen(msg);
+	} else
+		do {
+			va_list ap2;
+
+			if (caa_unlikely(len >= sizeof(local_buf))) {
+				buflen = (size_t)(len) + 1U;
+				alloc_buff = (char *)malloc(buflen);
+				msg = alloc_buff;
+				if (!alloc_buff)
+					return;
+			}
+			va_copy(ap2, ap);
+			len = vsnprintf(msg, buflen, fmt, ap2);
+			va_end(ap2);
+		} while (caa_unlikely(len >= sizeof(local_buf) && !alloc_buff));
+
+	/* len does not include the final \0 */
+	if (caa_likely(len >= 0))
+		lttng_ust_tracepoint_cb_lttng_ust_tracef___event(msg, len,
+			LTTNG_UST_CALLER_IP());
+	free(alloc_buff);
 }
 
 void lttng_ust__tracef(const char *fmt, ...)
@@ -46,8 +57,34 @@ void lttng_ust__tracef(const char *fmt, ...)
 void lttng_ust__tracef(const char *fmt, ...)
 {
 	va_list ap;
+	char local_buf[LTTNG_TRACE_PRINTF_BUFSIZE];
+	char *alloc_buff = NULL;
+	char *msg = local_buf;
+	size_t buflen = sizeof(local_buf);
+	int len = -1;
 
-	va_start(ap, fmt);
-	lttng_ust___vtracef(fmt, ap);
-	va_end(ap);
+	if (caa_unlikely(fmt[0] == '%' && fmt[1] == 's' && fmt[2] == '\0')) {
+		va_start(ap, fmt);
+		msg = va_arg(ap, char *);
+		va_end(ap);
+		len = strlen(msg);
+	} else
+		do {
+			if (caa_unlikely(len >= sizeof(local_buf))) {
+				buflen = (size_t)(len) + 1U;
+				alloc_buff = (char *)malloc(buflen);
+				msg = alloc_buff;
+				if (!alloc_buff)
+					return;
+			}
+			va_start(ap, fmt);
+			len = vsnprintf(msg, buflen, fmt, ap);
+			va_end(ap);
+		} while (caa_unlikely(len >= sizeof(local_buf) && !alloc_buff));
+
+	/* len does not include the final \0 */
+	if (caa_likely(len >= 0))
+		lttng_ust_tracepoint_cb_lttng_ust_tracef___event(msg, len,
+			LTTNG_UST_CALLER_IP());
+	free(alloc_buff);
 }
diff --git a/src/lib/lttng-ust/tracelog.c b/src/lib/lttng-ust/tracelog.c
index b28c6c78..6889869c 100644
--- a/src/lib/lttng-ust/tracelog.c
+++ b/src/lib/lttng-ust/tracelog.c
@@ -7,6 +7,7 @@
 #define _LGPL_SOURCE
 #include <stdio.h>
 #include "common/macros.h"
+#include "common/tracer.h"
 
 /* The tracepoint definition is public, but the provider definition is hidden. */
 #define LTTNG_UST_TRACEPOINT_PROVIDER_HIDDEN_DEFINITION
@@ -31,44 +32,73 @@ extern void lttng_ust__tracelog_vprintf(tpcallback_t *callback,
 	const struct lttng_ust__tracelog_sourceinfo *source, const char *fmt, va_list ap)
 	__attribute__ ((format(printf, 3, 0)));
 
-static inline
-void lttng_ust___tracelog_vprintf(tpcallback_t *callback,
-	const struct lttng_ust__tracelog_sourceinfo *source,
-	const char *fmt, va_list ap)
-	__attribute__((always_inline, format(printf, 3, 0)));
-
-
-static inline
-void lttng_ust___tracelog_vprintf(tpcallback_t *callback,
-	const struct lttng_ust__tracelog_sourceinfo *source,
-	const char *fmt, va_list ap)
-{
-	char *msg;
-	const int len = vasprintf(&msg, fmt, ap);
-
-	/* len does not include the final \0 */
-	if (len >= 0)
-		goto end;
-	(*callback)(source->file, source->line, source->func, msg, len,
-		LTTNG_UST_CALLER_IP());
-	free(msg);
-end:
-	return;
-}
-
-
 void lttng_ust__tracelog_printf(tpcallback_t *callback,
 	const struct lttng_ust__tracelog_sourceinfo *source, const char *fmt, ...)
 {
 	va_list ap;
+	char local_buf[LTTNG_TRACE_PRINTF_BUFSIZE];
+	char *alloc_buff = NULL;
+	char *msg = local_buf;
+	size_t buflen = sizeof(local_buf);
+	int len = -1;
+
+	if (caa_unlikely(fmt[0] == '%' && fmt[1] == 's' && fmt[2] == '\0')) {
+		va_start(ap, fmt);
+		msg = va_arg(ap, char *);
+		va_end(ap);
+		len = strlen(msg);
+	} else
+		do {
+			if (caa_unlikely(len >= sizeof(local_buf))) {
+				buflen = (size_t)(len) + 1U;
+				alloc_buff = (char *)malloc(buflen);
+				msg = alloc_buff;
+				if (!alloc_buff)
+					return;
+			}
+			va_start(ap, fmt);
+			len = vsnprintf(msg, buflen, fmt, ap);
+			va_end(ap);
+		} while (caa_unlikely(len >= sizeof(local_buf) && !alloc_buff));
 
-	va_start(ap, fmt);
-	lttng_ust___tracelog_vprintf(callback, source, fmt, ap);
-	va_end(ap);
+	/* len does not include the final \0 */
+	if (caa_likely(len >= 0))
+		(*callback)(source->file, source->line, source->func, msg, len,
+			LTTNG_UST_CALLER_IP());
+	free(alloc_buff);
 }
 
 void lttng_ust__tracelog_vprintf(tpcallback_t *callback,
 	const struct lttng_ust__tracelog_sourceinfo *source, const char *fmt, va_list ap)
 {
-	lttng_ust___tracelog_vprintf(callback, source, fmt, ap);
+	char local_buf[LTTNG_TRACE_PRINTF_BUFSIZE];
+	char *alloc_buff = NULL;
+	char *msg = local_buf;
+	size_t buflen = sizeof(local_buf);
+	int len = -1;
+
+	if (caa_unlikely(fmt[0] == '%' && fmt[1] == 's' && fmt[2] == '\0')) {
+		msg = va_arg(ap, char *);
+		len = strlen(msg);
+	} else
+		do {
+			va_list ap2;
+
+			if (caa_unlikely(len >= sizeof(local_buf))) {
+				buflen = (size_t)(len) + 1U;
+				alloc_buff = (char *)malloc(buflen);
+				msg = alloc_buff;
+				if (!alloc_buff)
+					return;
+			}
+			va_copy(ap2, ap);
+			len = vsnprintf(msg, buflen, fmt, ap2);
+			va_end(ap2);
+		} while (caa_unlikely(len >= sizeof(local_buf) && !alloc_buff));
+
+	/* len does not include the final \0 */
+	if (caa_likely(len >= 0))
+		(*callback)(source->file, source->line, source->func, msg, len,
+			LTTNG_UST_CALLER_IP());
+	free(alloc_buff);
 }
-- 
2.30.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
