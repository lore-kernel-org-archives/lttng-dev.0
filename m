Return-Path: <SRS0=91P6=I5=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55CCC433B4
	for <lttng-dev@archiver.kernel.org>; Wed, 31 Mar 2021 18:56:31 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2367E61006
	for <lttng-dev@archiver.kernel.org>; Wed, 31 Mar 2021 18:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2367E61006
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F9bBj6lkYzS9f;
	Wed, 31 Mar 2021 14:56:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617216990;
	bh=JT+UsrREMxi7fP2pHFRFov9FxZDPzazTKOn5rmzeszA=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=sqTSh1k1C36DRJoA3HyPcRB1Aq01lDcL23GsLZPVtXPfP6dQtoPUamIEVEWdw/iTm
	 QruCxcAiaU8eEGa+/aGvlKDJ10rgQrUZtQCrZlWP43JGOX9dKWSMOQrnqm/cMpWy6r
	 vSxswrM6sjX2Fp8POg1oVU4Z9Jw5FhOWDhyiicBQcIxLnW4AuJfgZFhzdR4mYIQVoh
	 Rv3f/FQprBSzlbAfmOX7pwRhnghxNze98gDjvCtb6VDatyYv0iZKGFO+SUWwDeBcz3
	 diwaKINMmfko7Zxi2sHAigVVYtDKFmGCaFUk7fKM+46O1D5d/pMqpFU7norQ1lRasN
	 hyfYANf+1iXvQ==
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 by lists.lttng.org (Postfix) with ESMTPS id 4F9bBf71vrzS9R
 for <lttng-dev@lists.lttng.org>; Wed, 31 Mar 2021 14:56:26 -0400 (EDT)
Received: by mail-lf1-x133.google.com with SMTP id o10so30595678lfb.9
 for <lttng-dev@lists.lttng.org>; Wed, 31 Mar 2021 11:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b2p+czXNNSn1in6Uo+1c1INeyXhzig1DLb4THCZ8xxs=;
 b=FGew+HNClqgAwpp+Ms/UylJLkr7UFwB4UX6t+DF1V7+Q9JBLtxq1qkgqq/8Raq8lDk
 zkQlXg5l3gHhv04qs0n4HM4EKdynz8QRd4yiqKWxpXUxK6JjDNRDmmd0jm0n4dFgplqN
 ABu7ze89OTk5R0KEB6bnjQsz0KF+d8keCMnSn8KZGsb3uEEOwb44yTn+Yy6l+LELO8Jn
 aHjMGgrgAbvd1DYYV7GKQZmSQQK23dAs1MEAUkaYvGeDgtfaVi0i/XNTYt4eOeUBqHPS
 a05Wf3v0DT9s5B8QZiovRBe41YwvWM49Vdui67IoxJ5uevmOOx2HALeZ3VEfVuxu9+Wg
 Al7g==
X-Gm-Message-State: AOAM532/e+4Jm0Wl7ymJJxOuSs4jpDd/Mo8Fdlz0YQ/hRQxUJx7g3rb2
 ESJSIj39GTq/2Cadq2WkczVjSraLlk1fnQ==
X-Google-Smtp-Source: ABdhPJwR+OZWNcV93sb7wBq7BMkKvWr738endydrGP7f5S0s7fqA8vycw5y6oltBVooY+v8+VhsSFQ==
X-Received: by 2002:ac2:4826:: with SMTP id 6mr3041216lft.629.1617216985397;
 Wed, 31 Mar 2021 11:56:25 -0700 (PDT)
Received: from arn-awallin-linux-l5.corp.ad.wrs.com
 (h-82-196-111-243.NA.cust.bahnhof.se. [82.196.111.243])
 by smtp.gmail.com with ESMTPSA id h24sm328657ljg.77.2021.03.31.11.56.24
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Mar 2021 11:56:24 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Wed, 31 Mar 2021 20:56:24 +0200
Message-Id: <20210331185624.406960-1-wallinux@gmail.com>
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
 tests/regression/tools/tracker/test_event_tracker | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/regression/tools/tracker/test_event_tracker b/tests/regression/tools/tracker/test_event_tracker
index 711690af..649c7e61 100755
--- a/tests/regression/tools/tracker/test_event_tracker
+++ b/tests/regression/tools/tracker/test_event_tracker
@@ -5,7 +5,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 
-TEST_DESC="LTTng - Event traker test"
+TEST_DESC="LTTng - Event tracker test"
 
 CURDIR=$(dirname "$0")/
 TESTDIR="$CURDIR/../../.."
@@ -42,6 +42,8 @@ function prepare_ust_app
 
 	$TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT -a "$AFTER_FIRST_PATH" -b "$BEFORE_LAST_PATH" &
 	CHILD_PID=$!
+	# voluntary context switch to start $TESTAPP_BIN
+	sleep 0.1
 }
 
 function trace_ust_app
-- 
2.31.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
