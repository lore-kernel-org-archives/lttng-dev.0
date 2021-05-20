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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEABFC43460
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 12:18:17 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2111B611AD
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 12:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2111B611AD
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fm8073lSpz1rhg;
	Thu, 20 May 2021 08:18:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621513096;
	bh=fR9wl3OqrVIWvuC/qZaEhgGoMrnxFGWY2vt9gGUGz6A=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=vrw6OlhVhjknD2kT32k0zOgHWLfCtnvGiCLRX6E2FWFG1C653jhaeQXsR/4aCCG0B
	 A9VL+LXdVe3Gbkaqeplvzer5XNiG04vdfKELez/0o44c1Br4vcTu0HqxB2C+tZ4p74
	 kMV8kUdIpyNkNpSkgoEUpSsF4OFioeTfOsrCFkCyRO8Rgurr9Q8uzV6r6Krvry/4AV
	 xc3fKVMT547vVMiLegC1bYHTdft3XoDoXIC+RAVxMm5uxPMakzrNDeW2ui0Cj0TI6w
	 4uJDFN3OoLrqKyYNHJuCOI0fAG0Yj2zv250q6XfTe3rrSc5pmCVGPsGdD4xcjkT70r
	 LoXPAfc/zMaGg==
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fm8062kk6z1rhd
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 08:18:14 -0400 (EDT)
Received: by mail-ej1-x62f.google.com with SMTP id p24so23684175ejb.1
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 05:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eR/8xH1TaNdomWLy/XJpn8sA/L1Rs2/O//6Gaz3pGL0=;
 b=NzlYp6tv7HLgkj9BnDeedjI7AXd1W+WQTwqjOvenEkAYDZ88a7k1UxFrgud0Pt0EWw
 xxhdMLpgLIi39rQLETGCqUCTRfZZkB1YljrGg9uOwhbW3oGMdR7rlNeYDVCM6jdXY52I
 JDmd1is9ygJMqrCuDlXaaOIWRtSnt93K5dLwhe4SRUueE3Vr9yQxrO78+rlq2xxajrVs
 63bT9xv9bufbtr26WlVpSJXzMMkQm4ewvJMlnct5PPzI9/voGRuwIWDYFVEQUboVpFHi
 kEYtYEo0RWsSnJmlH5uFmHntqBTNDf51TG7yRbumKKg3iF9F6BBRJKUUxRE6Xx5tQHCB
 Bogg==
X-Gm-Message-State: AOAM532vn6yej6uNaP16dLUDi/fz5F4rOlwIhOX8YtDYY9CSLt+Hc8Ru
 4y6RxqFlU/siswKbJo77JnaDRoGMS7CEYQ==
X-Google-Smtp-Source: ABdhPJwLPn9RcRvyittl/6fDheGrBdrY6VPByi/33IjKuj0V+S8iNdacmvsDBM3dHqy85EGX+weeVw==
X-Received: by 2002:a17:907:1b1e:: with SMTP id
 mp30mr4514270ejc.532.1621513093014; 
 Thu, 20 May 2021 05:18:13 -0700 (PDT)
Received: from debian-noppl.. (84-114-45-16.cable.dynamic.surfer.at.
 [84.114.45.16])
 by smtp.gmail.com with ESMTPSA id kx3sm1286319ejc.44.2021.05.20.05.18.12
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:18:12 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Thu, 20 May 2021 14:18:06 +0200
Message-Id: <20210520121807.55428-1-nolange79@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH lttng-ust] Improve tracelog handling,
 reduce exported functions
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

Instead of creating functions for each loglevel, simply pass the
callback as argument.

Further pack all preprocessor information into a struct that
the compiler already can prepare.

Signed-off-by: Norbert Lange <nolange79@gmail.com>
---
 include/lttng/tracelog.h     |  49 +++++--------
 src/lib/lttng-ust/tracelog.c | 130 +++++++++++++++--------------------
 2 files changed, 75 insertions(+), 104 deletions(-)

diff --git a/include/lttng/tracelog.h b/include/lttng/tracelog.h
index e97c8275..cd5032e3 100644
--- a/include/lttng/tracelog.h
+++ b/include/lttng/tracelog.h
@@ -14,51 +14,40 @@
 extern "C" {
 #endif
 
-#define LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(level)					\
-	extern void lttng_ust__tracelog_##level(const char *file,	\
-		int line, const char *func, const char *fmt, ...)	\
-		__attribute__ ((format(printf, 4, 5)));			\
-									\
-	extern void lttng_ust__vtracelog_##level(const char *file,	\
-		int line, const char *func, const char *fmt,		\
-		va_list ap)						\
-		__attribute__ ((format(printf, 4, 0)));
-
-LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_EMERG);
-LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_ALERT);
-LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_CRIT);
-LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_ERR);
-LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_WARNING);
-LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_NOTICE);
-LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_INFO);
-LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_SYSTEM);
-LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_PROGRAM);
-LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_PROCESS);
-LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_MODULE);
-LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_UNIT);
-LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_FUNCTION);
-LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_LINE);
-LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG);
-
-#undef LTTNG_UST_TP_TRACELOG_CB_TEMPLATE
+struct lttng_ust__tracelog_sourceinfo {
+	const char *file;
+	const char *func;
+	int line;
+};
+
+extern void lttng_ust__tracelog_printf(
+	__typeof__(lttng_ust_tracepoint_cb_lttng_ust_tracelog___LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG) *callback,
+	const struct lttng_ust__tracelog_sourceinfo *source, const char *fmt, ...)
+	__attribute__ ((format(printf, 3, 4)));
+
+extern void lttng_ust__tracelog_vprintf(
+	__typeof__(lttng_ust_tracepoint_cb_lttng_ust_tracelog___LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG) *callback,
+	const struct lttng_ust__tracelog_sourceinfo *source, const char *fmt, va_list ap)
+	__attribute__ ((format(printf, 3, 0)));
 
 #define lttng_ust_tracelog(level, fmt, ...)					\
 	do {								\
+		static const struct lttng_ust__tracelog_sourceinfo src = { __FILE__, __func__, __LINE__ }; \
 		LTTNG_UST_STAP_PROBEV(tracepoint_lttng_ust_tracelog, level, ## __VA_ARGS__); \
 		if (caa_unlikely(lttng_ust_tracepoint_lttng_ust_tracelog___##level.state)) \
-			lttng_ust__tracelog_##level(__FILE__, __LINE__, __func__, \
+			lttng_ust__tracelog_printf(&lttng_ust_tracepoint_cb_lttng_ust_tracelog___##level, &src, \
 				fmt, ## __VA_ARGS__);			\
 	} while (0)
 
 #define lttng_ust_vtracelog(level, fmt, ap)					\
 	do {								\
+		static const struct lttng_ust__tracelog_sourceinfo src = { __FILE__, __func__, __LINE__ }; \
 		if (caa_unlikely(lttng_ust_tracepoint_lttng_ust_tracelog___##level.state)) \
-			lttng_ust__vtracelog_##level(__FILE__, __LINE__, __func__, \
+			lttng_ust__tracelog_vprintf(&lttng_ust_tracepoint_cb_lttng_ust_tracelog___##level, &src, \
 				fmt, ap);				\
 	} while (0)
 
 #if LTTNG_UST_COMPAT_API(0)
-#define TP_TRACELOG_CB_TEMPLATE LTTNG_UST_TP_TRACELOG_CB_TEMPLATE
 #define tracelog	lttng_ust_tracelog
 #define vtracelog	lttng_ust_vtracelog
 #endif
diff --git a/src/lib/lttng-ust/tracelog.c b/src/lib/lttng-ust/tracelog.c
index 8147d7a3..b28c6c78 100644
--- a/src/lib/lttng-ust/tracelog.c
+++ b/src/lib/lttng-ust/tracelog.c
@@ -15,78 +15,60 @@
 #define LTTNG_UST_TRACEPOINT_DEFINE
 #include "lttng-ust-tracelog-provider.h"
 
-#define LTTNG_UST_TRACELOG_CB(level) \
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
-	void lttng_ust__vtracelog_##level(const char *file, \
-			int line, const char *func, \
-			const char *fmt, va_list ap) \
-		__attribute__ ((format(printf, 4, 0))); \
-	\
-	void lttng_ust__vtracelog_##level(const char *file, \
-			int line, const char *func, \
-			const char *fmt, va_list ap); \
-	void lttng_ust__vtracelog_##level(const char *file, \
-			int line, const char *func, \
-			const char *fmt, va_list ap) \
-	{ \
-		lttng_ust___vtracelog_##level(file, line, func, fmt, ap); \
-	} \
-	\
-	void lttng_ust__tracelog_##level(const char *file, \
-			int line, const char *func, \
-			const char *fmt, ...) \
-		__attribute__ ((format(printf, 4, 5))); \
-	\
-	void lttng_ust__tracelog_##level(const char *file, \
-			int line, const char *func, \
-			const char *fmt, ...); \
-	void lttng_ust__tracelog_##level(const char *file, \
-			int line, const char *func, \
-			const char *fmt, ...) \
-	{ \
-		va_list ap; \
-		\
-		va_start(ap, fmt); \
-		lttng_ust___vtracelog_##level(file, line, func, fmt, ap); \
-		va_end(ap); \
-	}
+struct lttng_ust__tracelog_sourceinfo {
+	const char *file;
+	const char *func;
+	int line;
+};
 
-LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_EMERG)
-LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_ALERT)
-LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_CRIT)
-LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_ERR)
-LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_WARNING)
-LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_NOTICE)
-LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_INFO)
-LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_SYSTEM)
-LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_PROGRAM)
-LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_PROCESS)
-LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_MODULE)
-LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_UNIT)
-LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_FUNCTION)
-LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_LINE)
-LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG)
+typedef __typeof__(lttng_ust_tracepoint_cb_lttng_ust_tracelog___LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG) tpcallback_t;
+
+extern void lttng_ust__tracelog_printf(tpcallback_t *callback,
+	const struct lttng_ust__tracelog_sourceinfo *source, const char *fmt, ...)
+	__attribute__ ((format(printf, 3, 4)));
+
+extern void lttng_ust__tracelog_vprintf(tpcallback_t *callback,
+	const struct lttng_ust__tracelog_sourceinfo *source, const char *fmt, va_list ap)
+	__attribute__ ((format(printf, 3, 0)));
+
+static inline
+void lttng_ust___tracelog_vprintf(tpcallback_t *callback,
+	const struct lttng_ust__tracelog_sourceinfo *source,
+	const char *fmt, va_list ap)
+	__attribute__((always_inline, format(printf, 3, 0)));
+
+
+static inline
+void lttng_ust___tracelog_vprintf(tpcallback_t *callback,
+	const struct lttng_ust__tracelog_sourceinfo *source,
+	const char *fmt, va_list ap)
+{
+	char *msg;
+	const int len = vasprintf(&msg, fmt, ap);
+
+	/* len does not include the final \0 */
+	if (len >= 0)
+		goto end;
+	(*callback)(source->file, source->line, source->func, msg, len,
+		LTTNG_UST_CALLER_IP());
+	free(msg);
+end:
+	return;
+}
+
+
+void lttng_ust__tracelog_printf(tpcallback_t *callback,
+	const struct lttng_ust__tracelog_sourceinfo *source, const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	lttng_ust___tracelog_vprintf(callback, source, fmt, ap);
+	va_end(ap);
+}
+
+void lttng_ust__tracelog_vprintf(tpcallback_t *callback,
+	const struct lttng_ust__tracelog_sourceinfo *source, const char *fmt, va_list ap)
+{
+	lttng_ust___tracelog_vprintf(callback, source, fmt, ap);
+}
-- 
2.30.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
