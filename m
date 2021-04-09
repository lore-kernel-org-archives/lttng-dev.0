Return-Path: <SRS0=RQNq=JG=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B189DC43460
	for <lttng-dev@archiver.kernel.org>; Fri,  9 Apr 2021 19:12:33 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12E361028
	for <lttng-dev@archiver.kernel.org>; Fri,  9 Apr 2021 19:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12E361028
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FH7725bF5z15Wh;
	Fri,  9 Apr 2021 15:12:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617995551;
	bh=wvSF/FckbB25MyOopmOH/HZgY4wTtklhsI/yW8/F8mE=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=cJkcCS0s+e098p8mpPmYRupN8rhuVoKsaHT2l2LKnq9hYE1iSBFeDKFh5mPsgbvLR
	 UVcHJtLMkdAcByj9tw4OakMx37BBJiJu380jw/4f4UXODxy9LVlUgHWy0TKhBB7KBQ
	 7OCVE+bjC5sVvguXR8fZqITo71SltBhSdCjp2CyjiUCA90YbMXoIAHtGHkDdYuvz+D
	 FOw7Tkkh/Z6lXDsMZdMzsFmyt81xeP1jD4JSJ+iipxGWaviRWEnRXWUa1RuadmBVAd
	 lS7sGzd4qauzfhMGupgq8gvBI1yB3oXqCjCuKm228dGrEwcMkNIHEDSv7M9UV5fATw
	 Tq01iOhr96s/g==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FH7711Qstz15tS
 for <lttng-dev@lists.lttng.org>; Fri,  9 Apr 2021 15:12:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E21C131A528;
 Fri,  9 Apr 2021 15:12:23 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id AsvgOkR8lF_k; Fri,  9 Apr 2021 15:12:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B3E7431A60E;
 Fri,  9 Apr 2021 15:12:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B3E7431A60E
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Kuf6gttNaJYC; Fri,  9 Apr 2021 15:12:22 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id AA18C31A17A;
 Fri,  9 Apr 2021 15:12:22 -0400 (EDT)
Date: Fri, 9 Apr 2021 15:12:22 -0400 (EDT)
To: Anders Wallin <wallinux@gmail.com>, Jeremie Galarneau <jgalar@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <832494431.66821.1617995542659.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210409144130.701522-1-wallinux@gmail.com>
References: <20210409144130.701522-1-wallinux@gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: test code assumes that child process is schedule to run before
 parent
Thread-Index: lykpZ0c5XI6UIkDq0me1MDZZ3rvlCg==
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

----- On Apr 9, 2021, at 10:41 AM, lttng-dev lttng-dev@lists.lttng.org wrote:

> the following tests fails on arm64
> - test_event_vpid_tracker ust 0 "${EVENT_NAME}"
> - test_event_vpid_track_untrack ust 0 "${EVENT_NAME}"
> - test_event_pid_tracker ust 0 "${EVENT_NAME}"
> - test_event_pid_track_untrack ust 0 "${EVENT_NAME}"

The approach looks good to me, thanks!

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> Signed-off-by: Anders Wallin <wallinux@gmail.com>
> ---
> .../tools/tracker/test_event_tracker           | 18 +++++++++++++-----
> 1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/regression/tools/tracker/test_event_tracker
> b/tests/regression/tools/tracker/test_event_tracker
> index 711690af..7f7d68da 100755
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
> @@ -17,8 +17,8 @@
> TESTAPP_KERNEL_BIN="$TESTAPP_PATH/$TESTAPP_KERNEL_NAME/$TESTAPP_KERNEL_NAME"
> SESSION_NAME="tracker"
> NR_ITER=100
> NUM_GLOBAL_TESTS=2
> -NUM_UST_TESTS=283
> -NUM_KERNEL_TESTS=462
> +NUM_UST_TESTS=289
> +NUM_KERNEL_TESTS=468
> NUM_TESTS=$((NUM_UST_TESTS+NUM_KERNEL_TESTS+NUM_GLOBAL_TESTS))
> 
> NR_USEC_WAIT=0	#for UST gen events
> @@ -130,6 +130,8 @@ function test_event_vpid_tracker()
> 
> 	prepare_"$domain"_app
> 
> +	lttng_untrack_"$domain"_ok "--all --vpid"
> +
> 	start_lttng_tracing_ok
> 
> 	if [ "$expect_event" -eq 1 ]; then
> @@ -146,7 +148,7 @@ function test_event_vpid_tracker()
> 	if [ "$expect_event" -eq 1 ]; then
> 		validate_trace "$EVENT_NAME" "$trace_path"
> 	else
> -		validate_trace_empty "$trace_path"
> +		validate_trace_session_"$domain"_empty "$trace_path"
> 	fi
> 
> 	rm -rf "$trace_path"
> @@ -173,6 +175,8 @@ function test_event_pid_tracker()
> 
> 	prepare_"$domain"_app
> 
> +	lttng_untrack_"$domain"_ok "--all --pid"
> +
> 	start_lttng_tracing_ok
> 
> 	if [ "$expect_event" -eq 1 ]; then
> @@ -189,7 +193,7 @@ function test_event_pid_tracker()
> 	if [ "$expect_event" -eq 1 ]; then
> 		validate_trace "$EVENT_NAME" "$trace_path"
> 	else
> -		validate_trace_empty "$trace_path"
> +	    	validate_trace_session_"$domain"_empty "$trace_path"
> 	fi
> 
> 	rm -rf "$trace_path"
> @@ -275,6 +279,8 @@ function test_event_vpid_track_untrack()
> 
> 	prepare_"$domain"_app
> 
> +	lttng_untrack_"$domain"_ok "--all --vpid"
> +
> 	start_lttng_tracing_ok
> 
> 	lttng_track_"$domain"_ok "--vpid ${CHILD_PID}"
> @@ -315,6 +321,8 @@ function test_event_pid_track_untrack()
> 
> 	prepare_"$domain"_app
> 
> +	lttng_untrack_"$domain"_ok "--all --pid"
> +
> 	start_lttng_tracing_ok
> 
> 	lttng_track_"$domain"_ok "--pid ${CHILD_PID}"
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
