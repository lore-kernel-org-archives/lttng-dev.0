Return-Path: <SRS0=RQNq=JG=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A46C433B4
	for <lttng-dev@archiver.kernel.org>; Fri,  9 Apr 2021 14:41:38 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC4761008
	for <lttng-dev@archiver.kernel.org>; Fri,  9 Apr 2021 14:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC4761008
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FH16R2rrTz15yb;
	Fri,  9 Apr 2021 10:41:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617979296;
	bh=OY55M2jehPa3OdGf9eVfVv582MlL9lXleVeT/VF1gFM=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Xyc9swzdj/IQeM5f/bBt+t6PZEFn4qRAKHYEDpscIFM6YUVHIZCc8GkAK0WKe1jGo
	 jcrad1PxK0X2Rjk8v3Zrwn6PGLcnxjISeeaA3HagGYhnXQbuaed6y/tV2VnZB/OVHr
	 46n2LQtMoBQZjXt2coQDQULk5hKymTOK181kTtIaJAvUNss6dt59EYVv0b/FihTMg3
	 ggK/jiZwdzI5olmZMwXW2SgsPa4cmWLsXBMnILL4vXobunizmvL8nLCCUoJQd/IjKC
	 bIJUmj0y8ptQ0T6JnCC5rVaYPkbjexcvuS5oBWLt+9SkRIQokRvwGag8Q2GRPD2G4k
	 0TS+aNVLhe9JQ==
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by lists.lttng.org (Postfix) with ESMTPS id 4FH16Q0Hkhz15yS
 for <lttng-dev@lists.lttng.org>; Fri,  9 Apr 2021 10:41:33 -0400 (EDT)
Received: by mail-lj1-x22f.google.com with SMTP id l14so3859095ljb.1
 for <lttng-dev@lists.lttng.org>; Fri, 09 Apr 2021 07:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b0MRqwsJuDPtqxdBrk++t2tyNOVvzsZIXkAH2/vYZ1A=;
 b=ogllOTcxA9P0xBtQYDMSDKaS9tA+LmURK2HxSxveuoyaS4jlQzzYzcYVfXHGeyNSau
 AfsOARsO0wGKpBXNtFnYBI/y1k2w6yXyN/2CmNMyX8KdQGiHm4o1kdDcMP1ZB5RarCf1
 vAwGgnsNhKOLI8ub3QRpztLrMInrmVFB3JAPbQURABWNtH9UQgo0lusEx020XVcLeXAF
 eD5Y5VdS3zlXb/mJvCHui3/Ii1PIVraYD4Kfl03/BAy0raQW8Z0gtU9tHL4KvXgbMWRo
 wu+J8vRZTHxs7XFMnetXXFpvvTXKY/KqEMX25LWvWbOHdAOh8rqdH3p9f2l+VU35TSL0
 TQxg==
X-Gm-Message-State: AOAM532HGOz6o3C95a1CV23lnAgNCgcZhT39JTBNbgBFOczv6eBVx1Ns
 oQktJKw7M9QDWFs7HKG0Fr8VpGWF/4TEhA==
X-Google-Smtp-Source: ABdhPJzt7HSOLorEDRVsGgTMHuQBpZgorPfCHcFmKsDF8j2ZME5a1YsAodlP3KqCInMPTyJT4F7zvA==
X-Received: by 2002:a2e:9a96:: with SMTP id p22mr9186457lji.167.1617979291737; 
 Fri, 09 Apr 2021 07:41:31 -0700 (PDT)
Received: from arn-awallin-linux-l5.corp.ad.wrs.com
 (h-82-196-111-243.NA.cust.bahnhof.se. [82.196.111.243])
 by smtp.gmail.com with ESMTPSA id f3sm289289ljm.5.2021.04.09.07.41.31
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Apr 2021 07:41:31 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Fri,  9 Apr 2021 16:41:30 +0200
Message-Id: <20210409144130.701522-1-wallinux@gmail.com>
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

the following tests fails on arm64
- test_event_vpid_tracker ust 0 "${EVENT_NAME}"
- test_event_vpid_track_untrack ust 0 "${EVENT_NAME}"
- test_event_pid_tracker ust 0 "${EVENT_NAME}"
- test_event_pid_track_untrack ust 0 "${EVENT_NAME}"

Signed-off-by: Anders Wallin <wallinux@gmail.com>
---
 .../tools/tracker/test_event_tracker           | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tests/regression/tools/tracker/test_event_tracker b/tests/regression/tools/tracker/test_event_tracker
index 711690af..7f7d68da 100755
--- a/tests/regression/tools/tracker/test_event_tracker
+++ b/tests/regression/tools/tracker/test_event_tracker
@@ -5,7 +5,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 
-TEST_DESC="LTTng - Event traker test"
+TEST_DESC="LTTng - Event tracker test"
 
 CURDIR=$(dirname "$0")/
 TESTDIR="$CURDIR/../../.."
@@ -17,8 +17,8 @@ TESTAPP_KERNEL_BIN="$TESTAPP_PATH/$TESTAPP_KERNEL_NAME/$TESTAPP_KERNEL_NAME"
 SESSION_NAME="tracker"
 NR_ITER=100
 NUM_GLOBAL_TESTS=2
-NUM_UST_TESTS=283
-NUM_KERNEL_TESTS=462
+NUM_UST_TESTS=289
+NUM_KERNEL_TESTS=468
 NUM_TESTS=$((NUM_UST_TESTS+NUM_KERNEL_TESTS+NUM_GLOBAL_TESTS))
 
 NR_USEC_WAIT=0	#for UST gen events
@@ -130,6 +130,8 @@ function test_event_vpid_tracker()
 
 	prepare_"$domain"_app
 
+	lttng_untrack_"$domain"_ok "--all --vpid"
+
 	start_lttng_tracing_ok
 
 	if [ "$expect_event" -eq 1 ]; then
@@ -146,7 +148,7 @@ function test_event_vpid_tracker()
 	if [ "$expect_event" -eq 1 ]; then
 		validate_trace "$EVENT_NAME" "$trace_path"
 	else
-		validate_trace_empty "$trace_path"
+		validate_trace_session_"$domain"_empty "$trace_path"
 	fi
 
 	rm -rf "$trace_path"
@@ -173,6 +175,8 @@ function test_event_pid_tracker()
 
 	prepare_"$domain"_app
 
+	lttng_untrack_"$domain"_ok "--all --pid"
+
 	start_lttng_tracing_ok
 
 	if [ "$expect_event" -eq 1 ]; then
@@ -189,7 +193,7 @@ function test_event_pid_tracker()
 	if [ "$expect_event" -eq 1 ]; then
 		validate_trace "$EVENT_NAME" "$trace_path"
 	else
-		validate_trace_empty "$trace_path"
+	    	validate_trace_session_"$domain"_empty "$trace_path"
 	fi
 
 	rm -rf "$trace_path"
@@ -275,6 +279,8 @@ function test_event_vpid_track_untrack()
 
 	prepare_"$domain"_app
 
+	lttng_untrack_"$domain"_ok "--all --vpid"
+
 	start_lttng_tracing_ok
 
 	lttng_track_"$domain"_ok "--vpid ${CHILD_PID}"
@@ -315,6 +321,8 @@ function test_event_pid_track_untrack()
 
 	prepare_"$domain"_app
 
+	lttng_untrack_"$domain"_ok "--all --pid"
+
 	start_lttng_tracing_ok
 
 	lttng_track_"$domain"_ok "--pid ${CHILD_PID}"
-- 
2.31.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
