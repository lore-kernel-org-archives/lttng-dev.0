Return-Path: <SRS0=VMqU=I6=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25ADC433ED
	for <lttng-dev@archiver.kernel.org>; Thu,  1 Apr 2021 13:45:41 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A5961263
	for <lttng-dev@archiver.kernel.org>; Thu,  1 Apr 2021 13:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A5961263
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FB4FZ6ldjzT5C;
	Thu,  1 Apr 2021 09:45:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617284739;
	bh=QuBnf46u20I4C9wSws3ca9hvJJHSOTZlKhfN0S82rjs=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=kwWziPJys8y1u/VNU3gyFSCTCfSBcd0EyqGf4NkJF6Eosn6J2NtOmhBRdkZpVj747
	 ad84wz55KLvXqKNu2VAGVosYq+1YJ7T+ekoTEZZz283xr8p8gP4mvUpn8Iy4ZhIE+m
	 M9dDcN7pLJYqbWp0Tu483E15bwT2nUqaa4HhGzFQTGauC4nwXbgEw5okuTPfm8Zftj
	 csknOt0DOdqkfeKKbXDR6UZTceAQPZOC2jJFTNp4P8UaOHB0ztvVr2PVxuEyaqhcp7
	 IWDQLmC+0uSOenH2C2vlDysCleVcWiB5qJfNhGVzWinVUneOer3LAiXId3XQm1WOAQ
	 ox8LM9XjjiteQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FB4FN4fKZzSZS
 for <lttng-dev@lists.lttng.org>; Thu,  1 Apr 2021 09:45:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 793522B1349
 for <lttng-dev@lists.lttng.org>; Thu,  1 Apr 2021 09:45:28 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id dnUkLxQpGHKD; Thu,  1 Apr 2021 09:45:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6A3E72B1348;
 Thu,  1 Apr 2021 09:45:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6A3E72B1348
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id dTsp_saK-toZ; Thu,  1 Apr 2021 09:45:27 -0400 (EDT)
Received: from joraj-alpa (unknown [107.159.43.215])
 by mail.efficios.com (Postfix) with ESMTPSA id 48F372B1768;
 Thu,  1 Apr 2021 09:45:27 -0400 (EDT)
Date: Thu, 1 Apr 2021 09:45:27 -0400
To: Anders Wallin <wallinux@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <20210401134527.GA79283@joraj-alpa>
References: <20210331185624.406960-1-wallinux@gmail.com>
 <592114658.48857.1617218709305.JavaMail.zimbra@efficios.com>
 <CAF2baFdV51rF5jAU5Ru4Y3OuTOJFMCuA=AZrBBDxkHRH_3JPSQ@mail.gmail.com>
 <20210331213313.GD28307@joraj-alpa>
 <CAF2baFdzoD-wmoO84A83DXdTzBr1WZ7ifoQtah493xH7WE3KhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF2baFdzoD-wmoO84A83DXdTzBr1WZ7ifoQtah493xH7WE3KhQ@mail.gmail.com>
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

On Thu, Apr 01, 2021 at 03:21:10AM +0200, Anders Wallin wrote:
> Hi Jonathan :)
> 
> It's very unlikely that the race could occur, BUT it can happen.
> 
> OK run
> 1. test_event_tracker starts gen-ust-events
> 2. test_event_tracker waits for gen-ust-events to create AFTER_FIRST_PATH
> 3. gen-ust-event create first event and create AFTER_FIRST_PATH
> 4. gen-ust-event continue and create 99 events
> 5. gen-ust-event wait for  BEFORE_LAST_PATH
> 6. test_event_track start collecting events (lttng start .....)

> 7. test_event_tracker calls "lttng track ... -pid "Faulty PID"
> 8. test_event_tracker touches BEFORE_LAST_PATH
> 9. gen-ust-events creates the last event
> 10. test_event finishes and since it tracks the faulty pid the result will
> be 0 events == OK

The sequence of event for the `test_event_tracker` function is (as of master):

create
enable event
start
track

launch app
wait for app return
stop
destroy


The sequence you are describing here is:

lauch app
start
track
...

I'm pretty sure we are not talking about the same things. Please specify the
test case and all functions involved and make sure to use the proper name for
each of them.

I suspect you are talking about test_event_pid_tracker. Still let's make sure of
it. If it is, I do agree that it seems to have a window where we can gather
event for.

You might want to look if there is a real reason for this sequence instead of
mimicking test_event_tracker

Current code:
 enable_"$domain"_lttng_event_ok $SESSION_NAME "$wildcard" "$channel"
 prepare_"$domain"_app
 start_lttng_tracing_ok

 if [ "$expect_event" -eq 1 ]; then
         lttng_track_"$domain"_ok "--vpid ${CHILD_PID}"
 else
         lttng_track_"$domain"_ok "--vpid $((CHILD_PID+1))"
 fi
 trace_"$domain"_app
 stop_lttng_tracing_ok
 destroy_lttng_session_ok $SESSION_NAME


We might simply want to move the track command before the start considering have
all the information to do so.

 enable_"$domain"_lttng_event_ok $SESSION_NAME "$wildcard" "$channel"

 prepare_"$domain"_app

 if [ "$expect_event" -eq 1 ]; then
         lttng_track_"$domain"_ok "--vpid ${CHILD_PID}"
 else
         lttng_track_"$domain"_ok "--vpid $((CHILD_PID+1))"
 fi

 start_lttng_tracing_ok
 trace_"$domain"_app

 stop_lttng_tracing_ok
 destroy_lttng_session_ok $SESSION_NAME

After testing this, seems like the validate_trace_empty does not handle the
case were simply stream allocation did not take place since no application was
'valid' at the moment of the trace start.

Well we got a good one here. We will wait for your updated patch and go from
there.

Cheers

> 
> Faulty run
> 1. test_event_tracker starts gen-ust-events
> 2. test_event_tracker waits for gen-ust-events to create AFTER_FIRST_PATH
> 3. gen-ust-event create first event and create AFTER_FIRST_PATH
> 4. gen-ust-event gets rescheduled before it has created 99 events, e.g
> after 9 events
> 5. test_event_track start collecting events (lttng start .....)
> 6. gen-ust-event is rescheduled and starts generating the remaining events.
> 90 events
> 7. lttng collects these 90 events since we have not setup "tracking" of PID
> yet
> 8. test_event_tracker calls "lttng track ... -pid "Faulty PID"
> 9. test_event_tracker touches BEFORE_LAST_PATH
> 10. gen-ust-events creates the last event
> 11. test_event finishes and since it tracks the faulty pid the result
> should  be 0 events, but we got 90 == FAULTY
> 
> We can solve this by;
> A: using NR_ITER=2
> or
> B: by adding a flag to gen-ust-events to wait before sending the first event
> 1. test_event_tracker starts gen-ust-events
> 2. test_event_tracker waits for gen-ust-events waits for BEFORE_FIRST_PATH
> 3. test_event_track start collecting events (lttng start .....)
> 4. test_event_tracker calls "lttng track ... -pid "Faulty PID"
> 5. test_event_track creates BEFORE_FIRST_PATH
> 6. gen_ust_event creates 100 events
> 7. test_event_tracker waits for gen_event_ust to end
> 8. test_event finishes and since it tracked the faulty pid the result will
> be 0 events == OK
> 
> This is in principle how gen-kernel-test-events works (but with different
> arguments)
> I would suggest to use B since that will be bulletproof
> 
> Anders Wallin
> 
> 
> On Wed, Mar 31, 2021 at 11:33 PM Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@efficios.com> wrote:
> 
> > Hi,
> >
> > On Wed, Mar 31, 2021 at 11:09:42PM +0200, Anders Wallin wrote:
> > > Hi Julian,
> >
> > You can use Jonathan. ;)
> >
> > >
> > > Neither mine "sleep 0.1" or your version with "while [! -f ............"
> > > are race condition free.
> >
> > I might be missing something here but as far as I understand the race you
> > are
> > trying to mitigate is that the test script execute/continue before the
> > `backgrounded`
> > command (background test app) had time to execute, right?
> >
> > If so at least waiting for the app to create a file is necessary. Now
> > gen_kernel_test_events does not have this functionality. The
> > PATH_WAIT_FILE is
> > used to control when the testapp can continue. Hence the script still
> > cannot
> > know if the app have been scheduled.
> >
> > Now based on the test case you might need more synchronization for the test
> > cases.
> >
> > Note that in the ust cases, the trace_ust_app uses `touch
> > "$BEFORE_LAST_PATH"`
> > that effectively unblock the app and allows it to perform the last
> > tracepoint
> > hit and the we `wait` on the background process.
> >
> > Note: some tests case are a bit clever and uses "trace_"$domain"_app"
> > instead of
> > calling trace_ust_app directly.
> >
> > For these tests case it seems that we are only expecting at least a single
> > event
> > matching the event name under test. Here the last tracepoint hit should
> > satisfy
> > this criteria.
> >
> > Am I missing a race?
> >
> > Cheers
> >
> >
> > > I suggest that we add an option to gen-ust-events to wait before the
> > first
> > > event is generated.
> > > gen_kernel_test_events already have this functionality to wait before the
> > > first event.
> > >
> > > Something like this
> > > static struct option long_options[] =
> > > {
> > > /* These options set a flag. */
> > > {"iter", required_argument, 0, 'i'},
> > > {"wait", required_argument, 0, 'w'},
> > > {"sync-after-first-event", required_argument, 0, 'a'},
> > > {"sync-before-last-event", required_argument, 0, 'b'},
> > > {"sync-before-last-event-touch", required_argument, 0, 'c'},
> > > {"sync-before-exit", required_argument, 0, 'd'},
> > > {"sync-before-exit-touch", required_argument, 0, 'e'},
> > > *+ {"sync-before-first-event", required_argument, 0, 'f'},*
> > >
> > > {0, 0, 0, 0}
> > > };
> > > ....
> > >
> > > I will create one or more patches for this tomorrow
> > >
> > > Anders Wallin
> > >
> > >
> > > On Wed, Mar 31, 2021 at 9:25 PM Jonathan Rajotte-Julien <
> > > jonathan.rajotte-julien@efficios.com> wrote:
> > >
> > > > > #
> > > > > # SPDX-License-Identifier: GPL-2.0-only
> > > > >
> > > > > -TEST_DESC="LTTng - Event traker test"
> > > > > +TEST_DESC="LTTng - Event tracker test"
> > > > >
> > > > > CURDIR=$(dirname "$0")/
> > > > > TESTDIR="$CURDIR/../../.."
> > > > > @@ -42,6 +42,8 @@ function prepare_ust_app
> > > > >
> > > > >       $TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT -a
> > "$AFTER_FIRST_PATH" -b
> > > > >       "$BEFORE_LAST_PATH" &
> > > > >       CHILD_PID=$!
> > > > > +     # voluntary context switch to start $TESTAPP_BIN
> > > > > +     sleep 0.1
> > > >
> > > > A wait on the $AFTER_FIRST_PATH file would be probably more
> > deterministic
> > > > than a sleep here.
> > > >
> > > >   while [ ! -f "${AFTER_FIRST_PATH}" ]; do
> > > >           sleep 0.1
> > > >   done
> > > >
> > > > I would also expect something similar for the `prepare_kernel_app`
> > > > function considering the same race is most probably present and simply
> > not
> > > > triggered by a chance of luck.
> > > > Seems like gen-kernel-test-events does not expose the same sync
> > > > capabilities here, please use gen-ust-events as an example of how it is
> > > > done.
> > > >
> > > > Let us know how your testing goes.
> > > >
> > > > Thanks
> > > >
> >
> > --
> > Jonathan Rajotte-Julien
> > EfficiOS
> >

-- 
Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
