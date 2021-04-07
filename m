Return-Path: <SRS0=QVU9=JE=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F22C433ED
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Apr 2021 15:31:56 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5EFA6138B
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Apr 2021 15:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5EFA6138B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FFpKQ4lMZz14fl;
	Wed,  7 Apr 2021 11:31:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617809515;
	bh=cq6iIWy1O/HIBHUVvaYJrX0zzaYPz9IM0FeS4Gs2hlM=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=mYCK7YS/THXDlArW+Oufk2j9knE1X4b5cji04XvNq6D0G3wMyWXsRUAFNlTZx2AnP
	 oRGPHo1r/YoI78k+S44WgeRH5F0GdjHJn67xS+unmGD+4/qenoZiA/b6Pa8zyXTc79
	 5A6ai/5XWHHFw07uXcOkoZATxBJkyW9Nn6bA0iYc4QfcKbEsaXMDCyGIhkLtm1QYBY
	 pkdkG4lwGv+MnxNM+HHbTSUE7PFV4zNT4LjvGwl3f7/z0JxhDLBCKHQVvPWGLLUZf6
	 LbtR7ZE6zFpsZeqxWIn6Uz64vGCvcqbRiJVbFK/zgNpkNU/VvTZs06VKgtREC2CDDJ
	 zeYGvtw9Gvd9w==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FFpKP324jz14VR
 for <lttng-dev@lists.lttng.org>; Wed,  7 Apr 2021 11:31:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 413D7326388
 for <lttng-dev@lists.lttng.org>; Wed,  7 Apr 2021 11:31:47 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id wgiLQYk0RtPg; Wed,  7 Apr 2021 11:31:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B09AD3260C7;
 Wed,  7 Apr 2021 11:31:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B09AD3260C7
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id UlH9EoeOqbAP; Wed,  7 Apr 2021 11:31:46 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id A95DA325E59;
 Wed,  7 Apr 2021 11:31:46 -0400 (EDT)
Date: Wed, 7 Apr 2021 11:31:46 -0400 (EDT)
To: Anders Wallin <wallinux@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <667805472.60438.1617809506670.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210401163710.839365-1-wallinux@gmail.com>
References: <20210401163710.839365-1-wallinux@gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: test code assumes that child process is schedule to run before
 parent
Thread-Index: J1OFnkXtZ2Euxhvb4aR230+Hp4swVw==
Subject: Re: [lttng-dev] [PATCH lttng-tools] Fix: test code assumes that
 child process is schedule to run before parent
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Apr 1, 2021, at 12:37 PM, lttng-dev lttng-dev@lists.lttng.org wrote:

> the following tests fails
> - test_event_vpid_tracker ust 0 "${EVENT_NAME}"
> - test_event_vpid_track_untrack ust 0 "${EVENT_NAME}"
> - test_event_pid_tracker ust 0 "${EVENT_NAME}"
> - test_event_pid_track_untrack ust 0 "${EVENT_NAME}"

There is indeed an issue with these tests: there is a missing "untrack all pids"
which should be done at the very beginning of each test to have the expected
behavior. AFAIU this explains why there is a small window where traced applications
can generate events when none are expected.

Fixing this should solve the issues without requiring any addition to the test
program.

Thanks,

Mathieu

> 
> Signed-off-by: Anders Wallin <wallinux@gmail.com>
> ---
> tests/regression/tools/tracker/test_event_tracker | 15 ++++++---------
> 1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/regression/tools/tracker/test_event_tracker
> b/tests/regression/tools/tracker/test_event_tracker
> index 711690af..78e9310b 100755
> --- a/tests/regression/tools/tracker/test_event_tracker
> +++ b/tests/regression/tools/tracker/test_event_tracker
> @@ -5,7 +5,7 @@
> #
> # SPDX-License-Identifier: GPL-2.0-only
> 
> -TEST_DESC="LTTng - Event traker test"
> +TEST_DESC="LTTng - Event tracker test"
> 
> CURDIR=$(dirname "$0")/
> TESTDIR="$CURDIR/../../.."
> @@ -30,27 +30,24 @@ SCRIPT_GROUPNAME="$(id -gn)"
> 
> CHILD_PID=-1
> WAIT_PATH=
> -AFTER_FIRST_PATH=
> -BEFORE_LAST_PATH=
> +BEFORE_FIRST_PATH=
> 
> source $TESTDIR/utils/utils.sh
> 
> function prepare_ust_app
> {
> -	AFTER_FIRST_PATH=$(mktemp -u)
> -	BEFORE_LAST_PATH=$(mktemp -u)
> +	BEFORE_FIRST_PATH=$(mktemp -u)
> 
> -	$TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT -a "$AFTER_FIRST_PATH" -b
> "$BEFORE_LAST_PATH" &
> +	$TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT --sync-before-first-event
> "$BEFORE_FIRST_PATH" &
> 	CHILD_PID=$!
> }
> 
> function trace_ust_app
> {
> -	touch "$BEFORE_LAST_PATH"
> +	touch "$BEFORE_FIRST_PATH"
> 	wait
> 	ok $? "Traced application stopped."
> -	rm "$BEFORE_LAST_PATH"
> -	rm "$AFTER_FIRST_PATH"
> +	rm "$BEFORE_FIRST_PATH"
> }
> 
> function prepare_kernel_app
> --
> 2.31.1
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
