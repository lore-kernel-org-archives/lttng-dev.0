Return-Path: <SRS0=xJir=AW=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5DDC433E2
	for <lttng-dev@archiver.kernel.org>; Sat, 11 Jul 2020 15:28:13 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEAC62075F
	for <lttng-dev@archiver.kernel.org>; Sat, 11 Jul 2020 15:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="h9FlusTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAC62075F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B3v1j02vyz1Cxn;
	Sat, 11 Jul 2020 11:28:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594481291;
	bh=1NH5qc43IidhylmZuG9ktE0Ck0mVvED9B+b9V7eDM3U=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=h9FlusTgirjA82HeTYLH2l2xo9OLzUYp1czAr+KZrjWe16ebBrgXMhtD07XHx3lkd
	 gF/nlFHTlta0WckRJ4vmYPmdjO32tHYGZK3gHkcELA5/cuEKn+jKgp7z4p+09H0vj/
	 dh5SdYKy+hRmBLHCtN+Ykym7UwS3z7LFQt4qO9ngHhWO2HlBq0wikIjGPKIhpBxpJO
	 ib4epg7dYIf//apW5SmKRq0E6jM5AoGapdGnmuYj0PyQ21OHRIp0/ivQlaCLr/lLkt
	 pxrFdutH61kRmoy77Y3ZTIqT84iKZ2hQ8ezLM9z0O6TCGwo0QBrAgMKdH4ejMXQRN8
	 /4mpJSRHygA1Q==
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by lists.lttng.org (Postfix) with ESMTPS id 4B3v1f3SZGz1Clm
 for <lttng-dev@lists.lttng.org>; Sat, 11 Jul 2020 11:28:06 -0400 (EDT)
Received: from clara.localdomain (modemcable059.101-200-24.mc.videotron.ca
 [24.200.101.59]) (authenticated bits=0)
 by smtp.polymtl.ca (8.14.7/8.14.7) with ESMTP id 06BFRpPR009494
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Sat, 11 Jul 2020 11:28:05 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.polymtl.ca 06BFRpPR009494
To: lttng-dev@lists.lttng.org
Date: Sat, 11 Jul 2020 11:29:07 -0400
Message-ID: <20200711152907.676582-1-olivier.dion@polymtl.ca>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Poly-FromMTA: (modemcable059.101-200-24.mc.videotron.ca [24.200.101.59]) at
 Sat, 11 Jul 2020 15:27:51 +0000
Subject: [lttng-dev] [PATCH lttng-ust] Add ctor/dtor priorities for
 tracepoints/events
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <olivier.dion@polymtl.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200711152907.JR5JNZq-v3KxlSvK7oe6JSLAI6qtSwTP9msY3VTuibU@z>

Some library might want to generate events in their ctor/dtor.  If
LTTng initialize/finalize its tracepoints/events at the wrong time,
events are lost.

Order of execution of the ctor/dtor is determined by priority.  When
some priorities are equal, the order of execution seems to be
determined by:

	   a) Order of appearance if in the same compilation unit

	   b) Order of link if in different compilation units

	   c) Order of load by ld-linux.so or dlopen(3) for
	      share objects

Also, using the constructor/destructor attributes without any priority
will default to the _lowest_ priority 65535, at least for GCC.

Thus, Providing the LTTNG_*_PRIO definitions allows users to set their
ctor/dtor priority like so:
----------------------------------------------------------------------
...
__attribute__((constructor(LTTNG_CTOR_PRIO + 1)))
...
__attribute__((destructor(LTTNG_DTOR_PRIO + 1)))
...
----------------------------------------------------------------------
or without any priority, that would also work.

Note that LTTNG_*_PRIO are set to 101 because it is the _highest_
priority and 0 to 100 are reserved.

Signed-off-by: Olivier Dion <olivier.dion@polymtl.ca>
---
 include/lttng/tracepoint.h           | 8 ++++----
 include/lttng/ust-compiler.h         | 7 +++++++
 include/lttng/ust-tracepoint-event.h | 4 ++--
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h
index d77a2fb2..70903757 100644
--- a/include/lttng/tracepoint.h
+++ b/include/lttng/tracepoint.h
@@ -318,7 +318,7 @@ __tracepoint__init_urcu_sym(void)
 }
 #endif
 
-static void lttng_ust_notrace __attribute__((constructor))
+static void lttng_ust_notrace __attribute__((constructor(LTTNG_CTOR_PRIO)))
 __tracepoints__init(void);
 static void
 __tracepoints__init(void)
@@ -340,7 +340,7 @@ __tracepoints__init(void)
 	__tracepoint__init_urcu_sym();
 }
 
-static void lttng_ust_notrace __attribute__((destructor))
+static void lttng_ust_notrace __attribute__((destructor(LTTNG_DTOR_PRIO)))
 __tracepoints__destroy(void);
 static void
 __tracepoints__destroy(void)
@@ -444,7 +444,7 @@ extern struct lttng_ust_tracepoint * const __stop___tracepoints_ptrs[]
 		__attribute__((used, section("__tracepoints_ptrs"))) =		\
 			&__tracepoint_##_provider##___##_name;
 
-static void lttng_ust_notrace __attribute__((constructor))
+static void lttng_ust_notrace __attribute__((constructor(LTTNG_CTOR_PRIO)))
 __tracepoints__ptrs_init(void);
 static void
 __tracepoints__ptrs_init(void)
@@ -488,7 +488,7 @@ __tracepoints__ptrs_init(void)
 	}
 }
 
-static void lttng_ust_notrace __attribute__((destructor))
+static void lttng_ust_notrace __attribute__((destructor(LTTNG_DTOR_PRIO)))
 __tracepoints__ptrs_destroy(void);
 static void
 __tracepoints__ptrs_destroy(void)
diff --git a/include/lttng/ust-compiler.h b/include/lttng/ust-compiler.h
index 1d04da1a..4f1b1a40 100644
--- a/include/lttng/ust-compiler.h
+++ b/include/lttng/ust-compiler.h
@@ -27,4 +27,11 @@
 #define lttng_ust_notrace __attribute__((no_instrument_function))
 #define LTTNG_PACKED	__attribute__((__packed__))
 
+/*
+ * Value in range [0, 100] are reserved.  Thus 101 is the higest
+ * priority that can be used.
+ */
+#define LTTNG_CTOR_PRIO 101
+#define LTTNG_DTOR_PRIO 101
+
 #endif /* _LTTNG_UST_COMPILER_H */
diff --git a/include/lttng/ust-tracepoint-event.h b/include/lttng/ust-tracepoint-event.h
index 7890c247..cd45ae08 100644
--- a/include/lttng/ust-tracepoint-event.h
+++ b/include/lttng/ust-tracepoint-event.h
@@ -1009,7 +1009,7 @@ static int _TP_COMBINE_TOKENS(__probe_register_refcount___, TRACEPOINT_PROVIDER)
 
 /* Reset all macros within TRACEPOINT_EVENT */
 #include <lttng/ust-tracepoint-event-reset.h>
-static void lttng_ust_notrace __attribute__((constructor))
+static void lttng_ust_notrace __attribute__((constructor(LTTNG_CTOR_PRIO)))
 _TP_COMBINE_TOKENS(__lttng_events_init__, TRACEPOINT_PROVIDER)(void);
 static void
 _TP_COMBINE_TOKENS(__lttng_events_init__, TRACEPOINT_PROVIDER)(void)
@@ -1036,7 +1036,7 @@ _TP_COMBINE_TOKENS(__lttng_events_init__, TRACEPOINT_PROVIDER)(void)
 	}
 }
 
-static void lttng_ust_notrace __attribute__((destructor))
+static void lttng_ust_notrace __attribute__((destructor(LTTNG_DTOR_PRIO)))
 _TP_COMBINE_TOKENS(__lttng_events_exit__, TRACEPOINT_PROVIDER)(void);
 static void
 _TP_COMBINE_TOKENS(__lttng_events_exit__, TRACEPOINT_PROVIDER)(void)
-- 
2.27.0

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
