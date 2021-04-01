Return-Path: <SRS0=VMqU=I6=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410B4C433B4
	for <lttng-dev@archiver.kernel.org>; Thu,  1 Apr 2021 16:36:40 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF13361379
	for <lttng-dev@archiver.kernel.org>; Thu,  1 Apr 2021 16:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF13361379
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FB82t5ZYHzT67;
	Thu,  1 Apr 2021 12:36:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617294998;
	bh=P0WYAN1rwUELznRN9uIXojcd6fXne3axUVkxkxMDB+g=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=IjHVsPDyf7mIYxbcOlVPvLUW5VCDOrROIxFnrQ0u/85ReOrdMYHWhL1VEdJHCgPVF
	 jBrOPXoIbbJBjg01BGRh48uKO5UeO/+4JdzIiKwUROz+j2Te+8JEgIQmX+8xeQHYmO
	 eIP2rfZ3q0U4bnnSCzzO4AUz9F2oT2i4TvAji5R/T+NABbGammitgGacadJNg8Pnp0
	 0WLRutAekiyHZ5HjG+PaxcaWY4vuPi82OHASFi62PX+BKDn1i+lUMhulJ3FT0sq0sU
	 Alwm7plJ1J1VIv2JAvtEOLbL5ef3yPNm9XB6Km4QQ6JkeDyUbU84M2ec8EPOivVqvu
	 4gyGY7JHK4RJA==
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by lists.lttng.org (Postfix) with ESMTPS id 4FB82r6M1QzT20
 for <lttng-dev@lists.lttng.org>; Thu,  1 Apr 2021 12:36:36 -0400 (EDT)
Received: by mail-lf1-x130.google.com with SMTP id b14so3731815lfv.8
 for <lttng-dev@lists.lttng.org>; Thu, 01 Apr 2021 09:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XK9J1bMfagj70UDo77tvn5Do1GAhjGvYxCZA9eM4/Ms=;
 b=NC8K2guvvcUFL/duxoYJOcWekJ7LnRc6MfROoUetL7c9FwXLFUzLKZs14BtHMNrV6M
 3C3pR1xLthgH7rbAcNsWeK9OxmV1YfVGTJQ7L60gpyJufcpix23cJXvvxPf9P5C6ZsfL
 djMhFFyJTO/HouuKNtiFKW244Jdv6aDJoq0uHVjgoIad4OywxunqIA5MuunjBEeKvYY3
 R/a05Q0nqUs5hnO/b2zWpi/RoPxtSYEap1jJTnLsof/VBHTh169mnqm2jMv52QkAREca
 NAUyTPqG0gSENDAlFfomN9fmzEXQrmM9pVyT6NPUri2plWSd/FlnG6NKLQDabyvHORY5
 gZhA==
X-Gm-Message-State: AOAM5329r1FlWfTIJ2mpg8/aN09yLk/z88eceaIWg1E6vItzYAA0Hb/v
 dSCKcNtKYt24w2WWyjM5HcyBRHxmS/4VPQ==
X-Google-Smtp-Source: ABdhPJyY+EXtTilSF5Llk0A87g1cG+hzXA5RdUDUGIgL+DFpywWWiaq5co1rcRED2z0h7vRihlcang==
X-Received: by 2002:ac2:4d95:: with SMTP id g21mr6278910lfe.29.1617294994681; 
 Thu, 01 Apr 2021 09:36:34 -0700 (PDT)
Received: from arn-awallin-linux-l5.corp.ad.wrs.com
 (h-82-196-111-243.NA.cust.bahnhof.se. [82.196.111.243])
 by smtp.gmail.com with ESMTPSA id v19sm592742lfi.39.2021.04.01.09.36.33
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Apr 2021 09:36:33 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Thu,  1 Apr 2021 18:36:33 +0200
Message-Id: <20210401163633.839259-1-wallinux@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH lttng-tools] testapp: gen-ust-events: added help
 and sync-before-first-event
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

- added verbose option to print traces
- added sync-before-first-event to wait on file before first event
- added help option
- added missing short option "-e"
- don't allow negative wait times

Signed-off-by: Anders Wallin <wallinux@gmail.com>
---
 .../testapp/gen-ust-events/gen-ust-events.c   | 95 ++++++++++++++++---
 1 file changed, 82 insertions(+), 13 deletions(-)

diff --git a/tests/utils/testapp/gen-ust-events/gen-ust-events.c b/tests/utils/testapp/gen-ust-events/gen-ust-events.c
index df1e58e4..5fefb2d8 100644
--- a/tests/utils/testapp/gen-ust-events/gen-ust-events.c
+++ b/tests/utils/testapp/gen-ust-events/gen-ust-events.c
@@ -28,6 +28,15 @@
 #define TRACEPOINT_DEFINE
 #include "tp.h"
 
+/* #define NDEBUG */
+
+#ifndef NDEBUG
+int verbose;
+#define TRACE(format, ...) { if (verbose) printf(" ---TRACE: " format, __VA_ARGS__); }
+#else
+#define TRACE(format, ...)
+#endif
+
 static struct option long_options[] =
 {
 	/* These options set a flag. */
@@ -38,9 +47,33 @@ static struct option long_options[] =
 	{"sync-before-last-event-touch", required_argument, 0, 'c'},
 	{"sync-before-exit", required_argument, 0, 'd'},
 	{"sync-before-exit-touch", required_argument, 0, 'e'},
+	{"sync-before-first-event", required_argument, 0, 'f'},
+	{"help", no_argument, 0, 'h'},
+#ifndef NDEBUG
+	{"verbose", no_argument, 0, 'v'},
+#endif
 	{0, 0, 0, 0}
 };
 
+const char *program_name;
+
+static void print_usage(void)
+{
+	printf("Usage:  %s options\n", program_name);
+	printf("  -h  --help                                    Display this usage information\n"
+#ifndef NDEBUG
+	       "  -v  --verbose                                 Print verbose messages\n"
+#endif
+	       "  -i  --iter [iterations]                       Number of iterations, default=100, forever=-1\n"
+	       "  -w  --wait [usec]                             Time in usec between events, default=0\n"
+	       "  -a  --sync-after-first-event [filename]       Create file after first event\n"
+	       "  -b  --sync-before-last-event [filename]       Wait for file before writing last event\n"
+	       "  -c  --sync-before-last-event-touch [filename] Create file after last event\n"
+	       "  -d  --sync-before-exit [filename]             Wait for file before exit\n"
+	       "  -e  --sync-before-exit-touch [filename]       Create file before exit\n"
+	       "  -f  --sync-before-first-event [filename]      Wait for file before creating the first event\n");
+}
+
 int main(int argc, char **argv)
 {
 	unsigned int i, netint;
@@ -54,7 +87,7 @@ int main(int argc, char **argv)
 	uint32_t net_values[] = { 1, 2, 3 };
 	int nr_iter = 100, ret = 0, first_event_file_created = 0;
 	useconds_t nr_usec = 0;
-	char *after_first_event_file_path = NULL;
+	char *after_first_event_file_path_touch = NULL;
 	char *before_last_event_file_path = NULL;
 	/*
 	 * Touch a file to indicate that all events except one were
@@ -65,16 +98,20 @@ int main(int argc, char **argv)
 	char *before_exit_file_path_touch = NULL;
 	/* Wait on file before exiting */
 	char *before_exit_file_path = NULL;
+	/* Wait on file before starting */
+	char *before_first_event_file_path = NULL;
+
+	program_name = argv[0];
 
 	for (i = 0; i < 3; i++) {
 		net_values[i] = htonl(net_values[i]);
 	}
 
-	while ((option = getopt_long(argc, argv, "i:w:a:b:c:d:",
+	while ((option = getopt_long(argc, argv, "i:w:a:b:c:d:e:f:hv",
 			long_options, &option_index)) != -1) {
 		switch (option) {
 		case 'a':
-			after_first_event_file_path = strdup(optarg);
+			after_first_event_file_path_touch = strdup(optarg);
 			break;
 		case 'b':
 			before_last_event_file_path = strdup(optarg);
@@ -88,22 +125,30 @@ int main(int argc, char **argv)
 		case 'e':
 			before_exit_file_path_touch = strdup(optarg);
 			break;
+		case 'f':
+			before_first_event_file_path = strdup(optarg);
+			break;
 		case 'i':
 			nr_iter = atoi(optarg);
 			break;
+#ifndef NDEBUG
+		case 'v':
+			verbose = 1;
+			break;
+#endif
 		case 'w':
-			nr_usec = atoi(optarg);
+			/* only postive values are valid */
+			nr_usec = (atoi(optarg) < 0) ? 0 : atoi(optarg);
 			break;
-		case '?':
-			/* getopt_long already printed an error message. */
+		case 'h':
 		default:
-			ret = -1;
+			print_usage();
 			goto end;
 		}
 	}
 
 	if (optind != argc) {
-		fprintf(stderr, "Error: takes long options only.\n");
+		fprintf(stderr, "Error: takes options only.\n");
 
 		/*
 		 * Aborting the test program for now because callers typically don't check
@@ -113,6 +158,7 @@ int main(int argc, char **argv)
 		 * we should eventually ensure that all scripts test and report the test
 		 * app return values.
 		 */
+		print_usage();
 		abort();
 
 		ret = -1;
@@ -125,9 +171,23 @@ int main(int argc, char **argv)
 		goto end;
 	}
 
+	TRACE("iter: %i\n", nr_iter);
+	TRACE("wait: %i (usec)\n", nr_usec);
+
+	if (before_first_event_file_path) {
+		TRACE("before_first_event_file_path(%i): %s\n",
+		      -1, before_first_event_file_path);
+		ret = wait_on_file(before_first_event_file_path);
+		if (ret != 0) {
+			goto end;
+		}
+	}
+
 	for (i = 0; nr_iter < 0 || i < nr_iter; i++) {
 		if (nr_iter >= 0 && i == nr_iter - 1) {
 			if (before_last_event_file_path_touch) {
+				TRACE("before_last_event_file_path_touch(%i): %s\n",
+				      i, before_last_event_file_path_touch);
 				ret = create_file(before_last_event_file_path_touch);
 				if (ret != 0) {
 					goto end;
@@ -139,6 +199,8 @@ int main(int argc, char **argv)
 			 * event.
 			 */
 			if (before_last_event_file_path) {
+				TRACE("before_last_event_file_path(%i): %s\n",
+				      i, before_last_event_file_path);
 				ret = wait_on_file(before_last_event_file_path);
 				if (ret != 0) {
 					goto end;
@@ -153,9 +215,10 @@ int main(int argc, char **argv)
 		 * First loop we create the file if asked to indicate
 		 * that at least one tracepoint has been hit.
 		 */
-		if (after_first_event_file_path && first_event_file_created == 0) {
-			ret = create_file(after_first_event_file_path);
-
+		if (after_first_event_file_path_touch && first_event_file_created == 0) {
+			TRACE("after_first_event_file_path_touch(%i): %s\n",
+			      i, after_first_event_file_path_touch);
+			ret = create_file(after_first_event_file_path_touch);
 			if (ret != 0) {
 				goto end;
 			} else {
@@ -164,7 +227,7 @@ int main(int argc, char **argv)
 		}
 
 		if (nr_usec) {
-		        if (usleep_safe(nr_usec)) {
+			if (usleep_safe(nr_usec)) {
 				ret = -1;
 				goto end;
 			}
@@ -175,22 +238,28 @@ int main(int argc, char **argv)
 	}
 
 	if (before_exit_file_path_touch) {
+		TRACE("before_exit_file_path_touch(%i): %s\n",
+		      i, before_exit_file_path_touch);
 		ret = create_file(before_exit_file_path_touch);
 		if (ret != 0) {
 			goto end;
 		}
 	}
 	if (before_exit_file_path) {
+		TRACE("before_exit_file_path(%i): %s\n",
+		      i, before_exit_file_path);
 		ret = wait_on_file(before_exit_file_path);
 		if (ret != 0) {
 			goto end;
 		}
 	}
 end:
-	free(after_first_event_file_path);
+	TRACE("end status: %i\n", ret);
+	free(after_first_event_file_path_touch);
 	free(before_last_event_file_path);
 	free(before_last_event_file_path_touch);
 	free(before_exit_file_path);
 	free(before_exit_file_path_touch);
+	free(before_first_event_file_path);
 	exit(!ret ? EXIT_SUCCESS : EXIT_FAILURE);
 }
-- 
2.31.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
