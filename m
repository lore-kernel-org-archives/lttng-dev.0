Return-Path: <SRS0=91P6=I5=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F04CC433ED
	for <lttng-dev@archiver.kernel.org>; Wed, 31 Mar 2021 21:33:24 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E5760FDC
	for <lttng-dev@archiver.kernel.org>; Wed, 31 Mar 2021 21:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E5760FDC
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F9fgk1HG2zS63;
	Wed, 31 Mar 2021 17:33:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617226402;
	bh=ImimnRVl8ETrZ6AmUAoy6VmF3AR4HAYXRQy4b5eerFE=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qkpiqseiRRCogPtGgtH1GkpINtqkISQidM9XyEuFmTmCcMW3iEzAJmbeEJQ7rH/n2
	 nm9b/5dA37/s4OaSszXKKoutOlZdFIS65/lcFfk8iGPj5gJubS7jEQqj1fP4VVZy30
	 S0KF+pxFh0NHxGXT8qSBBMnFC9nNVFjhxQV3VojtO+nZ04b+KUAiFiZcJ+fo5vY1cq
	 FQs1X4aiOwFB2gLbDOhNPBLx2yNUSYKfFZE4S1YP/8a5ycYmaPiHu0vcesH/Bt0oD5
	 F/51dIzzf81/wxWV5jOHiHgj67pan9pgUQpHHEKr3iGn8d8h07+QYauTkjnpb5Nib5
	 jXsb5iYFTHeXA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4F9fgh4WB3zSKV
 for <lttng-dev@lists.lttng.org>; Wed, 31 Mar 2021 17:33:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3685C2FA45E
 for <lttng-dev@lists.lttng.org>; Wed, 31 Mar 2021 17:33:14 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 9_Ty68zrwA4Q; Wed, 31 Mar 2021 17:33:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id AFB6E2FA45C;
 Wed, 31 Mar 2021 17:33:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com AFB6E2FA45C
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id sExYbcmYMCRN; Wed, 31 Mar 2021 17:33:13 -0400 (EDT)
Received: from joraj-alpa (unknown [107.159.43.215])
 by mail.efficios.com (Postfix) with ESMTPSA id 9418A2FA4B4;
 Wed, 31 Mar 2021 17:33:13 -0400 (EDT)
Date: Wed, 31 Mar 2021 17:33:13 -0400
To: Anders Wallin <wallinux@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <20210331213313.GD28307@joraj-alpa>
References: <20210331185624.406960-1-wallinux@gmail.com>
 <592114658.48857.1617218709305.JavaMail.zimbra@efficios.com>
 <CAF2baFdV51rF5jAU5Ru4Y3OuTOJFMCuA=AZrBBDxkHRH_3JPSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF2baFdV51rF5jAU5Ru4Y3OuTOJFMCuA=AZrBBDxkHRH_3JPSQ@mail.gmail.com>
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
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

On Wed, Mar 31, 2021 at 11:09:42PM +0200, Anders Wallin wrote:
> Hi Julian,

You can use Jonathan. ;)

> 
> Neither mine "sleep 0.1" or your version with "while [! -f ............"
> are race condition free.

I might be missing something here but as far as I understand the race you are
trying to mitigate is that the test script execute/continue before the `backgrounded`
command (background test app) had time to execute, right?

If so at least waiting for the app to create a file is necessary. Now
gen_kernel_test_events does not have this functionality. The PATH_WAIT_FILE is
used to control when the testapp can continue. Hence the script still cannot
know if the app have been scheduled.

Now based on the test case you might need more synchronization for the test
cases.

Note that in the ust cases, the trace_ust_app uses `touch "$BEFORE_LAST_PATH"`
that effectively unblock the app and allows it to perform the last tracepoint
hit and the we `wait` on the background process.

Note: some tests case are a bit clever and uses "trace_"$domain"_app" instead of
calling trace_ust_app directly.

For these tests case it seems that we are only expecting at least a single event
matching the event name under test. Here the last tracepoint hit should satisfy
this criteria.

Am I missing a race?

Cheers


> I suggest that we add an option to gen-ust-events to wait before the first
> event is generated.
> gen_kernel_test_events already have this functionality to wait before the
> first event.
> 
> Something like this
> static struct option long_options[] =
> {
> /* These options set a flag. */
> {"iter", required_argument, 0, 'i'},
> {"wait", required_argument, 0, 'w'},
> {"sync-after-first-event", required_argument, 0, 'a'},
> {"sync-before-last-event", required_argument, 0, 'b'},
> {"sync-before-last-event-touch", required_argument, 0, 'c'},
> {"sync-before-exit", required_argument, 0, 'd'},
> {"sync-before-exit-touch", required_argument, 0, 'e'},
> *+ {"sync-before-first-event", required_argument, 0, 'f'},*
> 
> {0, 0, 0, 0}
> };
> ....
> 
> I will create one or more patches for this tomorrow
> 
> Anders Wallin
> 
> 
> On Wed, Mar 31, 2021 at 9:25 PM Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@efficios.com> wrote:
> 
> > > #
> > > # SPDX-License-Identifier: GPL-2.0-only
> > >
> > > -TEST_DESC="LTTng - Event traker test"
> > > +TEST_DESC="LTTng - Event tracker test"
> > >
> > > CURDIR=$(dirname "$0")/
> > > TESTDIR="$CURDIR/../../.."
> > > @@ -42,6 +42,8 @@ function prepare_ust_app
> > >
> > >       $TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT -a "$AFTER_FIRST_PATH" -b
> > >       "$BEFORE_LAST_PATH" &
> > >       CHILD_PID=$!
> > > +     # voluntary context switch to start $TESTAPP_BIN
> > > +     sleep 0.1
> >
> > A wait on the $AFTER_FIRST_PATH file would be probably more deterministic
> > than a sleep here.
> >
> >   while [ ! -f "${AFTER_FIRST_PATH}" ]; do
> >           sleep 0.1
> >   done
> >
> > I would also expect something similar for the `prepare_kernel_app`
> > function considering the same race is most probably present and simply not
> > triggered by a chance of luck.
> > Seems like gen-kernel-test-events does not expose the same sync
> > capabilities here, please use gen-ust-events as an example of how it is
> > done.
> >
> > Let us know how your testing goes.
> >
> > Thanks
> >

-- 
Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
