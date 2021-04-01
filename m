Return-Path: <SRS0=VMqU=I6=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF682C433ED
	for <lttng-dev@archiver.kernel.org>; Thu,  1 Apr 2021 16:37:15 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D20561385
	for <lttng-dev@archiver.kernel.org>; Thu,  1 Apr 2021 16:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D20561385
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FB83Z0HW7zSyJ;
	Thu,  1 Apr 2021 12:37:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617295034;
	bh=vYN84Z6p0Qx1TPpmN2lLKJ4AqASutmgCLtbojRM0YFQ=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=ErYXaIn90VtHhmlqhzhcygZFcfzx329e4FukxafE/T7CAsJTGUNiwaHIRWH2EeBRy
	 yokMCdn4vUSnsTKdZLEHyrm8qqaWC5cPZubQIEerJhtZqkZSkIqMvi1BXqzMFISdvd
	 iBFqb/10QspTnaU6anhMSFUhmUMsFE/O13smEPC6PSapvYbv86hzOYr3U1AQqS06HY
	 hxIBauiRE/T91k+7G6gQMO005N58IvTSe+sVXzfK0D2iKtbSYpVD19IQHrkU+EZTqx
	 njkaAJFVEgi1hcsU1vnM7mEV1gcKAHj/yDAhUcX50NQ3qG2Gt5gv3nxw/+edRLSvkM
	 FeOJD2V8cQ0nw==
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by lists.lttng.org (Postfix) with ESMTPS id 4FB83Y14WRzT69
 for <lttng-dev@lists.lttng.org>; Thu,  1 Apr 2021 12:37:13 -0400 (EDT)
Received: by mail-lj1-x235.google.com with SMTP id 15so2981138ljj.0
 for <lttng-dev@lists.lttng.org>; Thu, 01 Apr 2021 09:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=E3RapSFX41K5Rdqxo6AdSb9RJBHfGO0Pmc2pw9+Tm0M=;
 b=VJivQ2kvusRaRodGwVX3vZkV2d+gLdG5Ozn1ntyzn0nHeItEp+o3d7K2ayp2yGecU2
 r4Z+AZBKIfthb1mv7P4Sxe5e8sEaQUDVTmrvXUv4I0kLjcFR3J448+VYj/95K3DtvwaQ
 kex1EMQ4rPGJG7FMpcVgeRZtPBFPptPvH9VIACGWHn0N7VIEEwds8EJuH2nUwlUgQKUP
 YHm6fBJXFia2MWQmJfcn3wMMclzmZbaK6Nz1Hyus4f1beiLXma/HxmOrdm9mARxEPmmI
 0vWD0SeElB8tmCJpSIS8jUAr1LnaLCOegCof6HsEZ2AqCboIf+WAcHcandLpXCax5Ia5
 McTg==
X-Gm-Message-State: AOAM533FnLCm6qoD+gQnHRZ2UxFwWDIuw1Kc9vDAQanyDVR/JcYhKo8G
 M2V7bML8iLaHpsNneml+IzPqR+jta+2QbA==
X-Google-Smtp-Source: ABdhPJxC8192meNxTz4AXrPvHgtOfPCwp57rx1BfEW2qW0uuyauDqSXWd9Pu+Xzr6JDCeTd/EIJF4Q==
X-Received: by 2002:a05:651c:1249:: with SMTP id
 h9mr5961005ljh.214.1617295031239; 
 Thu, 01 Apr 2021 09:37:11 -0700 (PDT)
Received: from arn-awallin-linux-l5.corp.ad.wrs.com
 (h-82-196-111-243.NA.cust.bahnhof.se. [82.196.111.243])
 by smtp.gmail.com with ESMTPSA id z64sm589989lfa.92.2021.04.01.09.37.10
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Apr 2021 09:37:10 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Thu,  1 Apr 2021 18:37:10 +0200
Message-Id: <20210401163710.839365-1-wallinux@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH lttng-tools] Fix: test code assumes that child
 process is schedule to run before parent
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

the following tests fails
- test_event_vpid_tracker ust 0 "${EVENT_NAME}"
- test_event_vpid_track_untrack ust 0 "${EVENT_NAME}"
- test_event_pid_tracker ust 0 "${EVENT_NAME}"
- test_event_pid_track_untrack ust 0 "${EVENT_NAME}"

Signed-off-by: Anders Wallin <wallinux@gmail.com>
---
 tests/regression/tools/tracker/test_event_tracker | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tests/regression/tools/tracker/test_event_tracker b/tests/regression/tools/tracker/test_event_tracker
index 711690af..78e9310b 100755
--- a/tests/regression/tools/tracker/test_event_tracker
+++ b/tests/regression/tools/tracker/test_event_tracker
@@ -5,7 +5,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 
-TEST_DESC="LTTng - Event traker test"
+TEST_DESC="LTTng - Event tracker test"
 
 CURDIR=$(dirname "$0")/
 TESTDIR="$CURDIR/../../.."
@@ -30,27 +30,24 @@ SCRIPT_GROUPNAME="$(id -gn)"
 
 CHILD_PID=-1
 WAIT_PATH=
-AFTER_FIRST_PATH=
-BEFORE_LAST_PATH=
+BEFORE_FIRST_PATH=
 
 source $TESTDIR/utils/utils.sh
 
 function prepare_ust_app
 {
-	AFTER_FIRST_PATH=$(mktemp -u)
-	BEFORE_LAST_PATH=$(mktemp -u)
+	BEFORE_FIRST_PATH=$(mktemp -u)
 
-	$TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT -a "$AFTER_FIRST_PATH" -b "$BEFORE_LAST_PATH" &
+	$TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT --sync-before-first-event "$BEFORE_FIRST_PATH" &
 	CHILD_PID=$!
 }
 
 function trace_ust_app
 {
-	touch "$BEFORE_LAST_PATH"
+	touch "$BEFORE_FIRST_PATH"
 	wait
 	ok $? "Traced application stopped."
-	rm "$BEFORE_LAST_PATH"
-	rm "$AFTER_FIRST_PATH"
+	rm "$BEFORE_FIRST_PATH"
 }
 
 function prepare_kernel_app
-- 
2.31.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
