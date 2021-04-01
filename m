Return-Path: <SRS0=VMqU=I6=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87234C433B4
	for <lttng-dev@archiver.kernel.org>; Thu,  1 Apr 2021 15:02:27 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8674D61364
	for <lttng-dev@archiver.kernel.org>; Thu,  1 Apr 2021 15:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8674D61364
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FB5y83zvkzSvj;
	Thu,  1 Apr 2021 11:02:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617289345;
	bh=ZHIi/WlnEwKszHj7audL6BWzWsdzXfXx1M5hZZb2sfs=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=YFEeqrOrygnNXA2MTkFGVjX6UJ/HWAxgy24S3/qdCU8xg7I5GkgqIiG8ZNyhgckgC
	 aPXaWbCEOf5AJ0uyPzxVlTiuM/xUCRJsF7J/YSL5YuMkcojrxLDCOugD0C24kVPUAk
	 SygKbQuHiR7v/T+bCAndFyoUAEd2f/u7taxbWtb2K4BIH+HVH080NEp0hc0U0Yj7li
	 P+50Uf3g2Oq1dGQmYfbkpWDxf8EHif9QGFhMmPfL155XXdEs4p1OTgPSovUF+sE0Bl
	 1izv93Miz9fRBxZBQyBh/Q0WDVTc/KAHZXUKsJWxXOiqi66CqqFTuaX5je+QxbFuC0
	 K3R+/1Ydrs8QA==
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 by lists.lttng.org (Postfix) with ESMTPS id 4FB5y62WgJzT1Y
 for <lttng-dev@lists.lttng.org>; Thu,  1 Apr 2021 11:02:22 -0400 (EDT)
Received: by mail-io1-xd36.google.com with SMTP id x17so2521866iog.2
 for <lttng-dev@lists.lttng.org>; Thu, 01 Apr 2021 08:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3WDF7NfmD/rbghHsKgADt9NoGhSeBRKOc8zDs48F5Is=;
 b=gIMZTKZMZmAKxsB+C7kteLqLisoa71ZK1r4ke2foxWEN7eXG2Eu3XofZuxXR7edb1g
 M6BOgdZ8Eng/awoq4aH6DTZ+fgiSV1j3DClhAzRHVlhZYemDV0eHgzbup9oX7fVjnLjT
 iS+OrRJ2XjjZOUIz8SihGgjKT9o4kyIjVhLOUc0gB51OSFZB6EEpnsBiYjOHVwX/U4SE
 HpJ7a1eCR/auW+YCA/3ra5bUSzySFnyXUlwi4FVjMg9rbvR/8gINueKI1rUD1pgY6Ass
 o5EvRYQVC73jccILmo8XsCbmoLUHVkVXETiLho2NBOdQwZOgMdtL9n6loaMTzDLcz6WE
 n6sA==
X-Gm-Message-State: AOAM5323UnpJyzL40SimI8J9ikInZgJnE8Xf7J6ZR0f8TuOatlQEAAyR
 DWI1y68OnOoubAEElCczbElI+1V3q7rBWkgD4Ow=
X-Google-Smtp-Source: ABdhPJygE/tv8vMaQCzlEhZBtrNRgvSC0SJL/KOZcPVRhM3vcl9ch5N7OuaodgwpDF0RAP127fj4PqbjugtamObV5ok=
X-Received: by 2002:a02:a809:: with SMTP id f9mr8312271jaj.63.1617289341549;
 Thu, 01 Apr 2021 08:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210331185624.406960-1-wallinux@gmail.com>
 <592114658.48857.1617218709305.JavaMail.zimbra@efficios.com>
 <CAF2baFdV51rF5jAU5Ru4Y3OuTOJFMCuA=AZrBBDxkHRH_3JPSQ@mail.gmail.com>
 <20210331213313.GD28307@joraj-alpa>
 <CAF2baFdzoD-wmoO84A83DXdTzBr1WZ7ifoQtah493xH7WE3KhQ@mail.gmail.com>
 <20210401134527.GA79283@joraj-alpa>
In-Reply-To: <20210401134527.GA79283@joraj-alpa>
Date: Thu, 1 Apr 2021 17:02:09 +0200
Message-ID: <CAF2baFe_5XbMcFSmrNpFas5PA+AxAy_gU3k0yfFUi89qoFMRAw@mail.gmail.com>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
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
From: Anders Wallin via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Anders Wallin <wallinux@gmail.com>
Content-Type: multipart/mixed; boundary="===============4962648184078771564=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============4962648184078771564==
Content-Type: multipart/alternative; boundary="000000000000b3bfeb05beea84b1"

--000000000000b3bfeb05beea84b1
Content-Type: text/plain; charset="UTF-8"

Hi,

I think you understood what I meant. The issue I have is for this 4 test
cases in ./regression/tools/tracker/test_event_tracker
- test_event_vpid_tracker ust 0 "${EVENT_NAME}"
- test_event_vpid_track_untrack ust 0 "${EVENT_NAME}"
- test_event_pid_tracker ust 0 "${EVENT_NAME}"
- test_event_pid_track_untrack ust 0 "${EVENT_NAME}"

I have 2 patches ready, but I want to run some more tests first before
posting them

Anders Wallin


On Thu, Apr 1, 2021 at 3:45 PM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> On Thu, Apr 01, 2021 at 03:21:10AM +0200, Anders Wallin wrote:
> > Hi Jonathan :)
> >
> > It's very unlikely that the race could occur, BUT it can happen.
> >
> > OK run
> > 1. test_event_tracker starts gen-ust-events
> > 2. test_event_tracker waits for gen-ust-events to create AFTER_FIRST_PATH
> > 3. gen-ust-event create first event and create AFTER_FIRST_PATH
> > 4. gen-ust-event continue and create 99 events
> > 5. gen-ust-event wait for  BEFORE_LAST_PATH
> > 6. test_event_track start collecting events (lttng start .....)
>
> > 7. test_event_tracker calls "lttng track ... -pid "Faulty PID"
> > 8. test_event_tracker touches BEFORE_LAST_PATH
> > 9. gen-ust-events creates the last event
> > 10. test_event finishes and since it tracks the faulty pid the result
> will
> > be 0 events == OK
>
> The sequence of event for the `test_event_tracker` function is (as of
> master):
>
> create
> enable event
> start
> track
>
> launch app
> wait for app return
> stop
> destroy
>
>
> The sequence you are describing here is:
>
> lauch app
> start
> track
> ...
>
> I'm pretty sure we are not talking about the same things. Please specify
> the
> test case and all functions involved and make sure to use the proper name
> for
> each of them.
>
> I suspect you are talking about test_event_pid_tracker. Still let's make
> sure of
> it. If it is, I do agree that it seems to have a window where we can gather
> event for.
>
> You might want to look if there is a real reason for this sequence instead
> of
> mimicking test_event_tracker
>
> Current code:
>  enable_"$domain"_lttng_event_ok $SESSION_NAME "$wildcard" "$channel"
>  prepare_"$domain"_app
>  start_lttng_tracing_ok
>
>  if [ "$expect_event" -eq 1 ]; then
>          lttng_track_"$domain"_ok "--vpid ${CHILD_PID}"
>  else
>          lttng_track_"$domain"_ok "--vpid $((CHILD_PID+1))"
>  fi
>  trace_"$domain"_app
>  stop_lttng_tracing_ok
>  destroy_lttng_session_ok $SESSION_NAME
>
>
> We might simply want to move the track command before the start
> considering have
> all the information to do so.
>
>  enable_"$domain"_lttng_event_ok $SESSION_NAME "$wildcard" "$channel"
>
>  prepare_"$domain"_app
>
>  if [ "$expect_event" -eq 1 ]; then
>          lttng_track_"$domain"_ok "--vpid ${CHILD_PID}"
>  else
>          lttng_track_"$domain"_ok "--vpid $((CHILD_PID+1))"
>  fi
>
>  start_lttng_tracing_ok
>  trace_"$domain"_app
>
>  stop_lttng_tracing_ok
>  destroy_lttng_session_ok $SESSION_NAME
>
> After testing this, seems like the validate_trace_empty does not handle the
> case were simply stream allocation did not take place since no application
> was
> 'valid' at the moment of the trace start.
>
> Well we got a good one here. We will wait for your updated patch and go
> from
> there.
>
> Cheers
>
> >
> > Faulty run
> > 1. test_event_tracker starts gen-ust-events
> > 2. test_event_tracker waits for gen-ust-events to create AFTER_FIRST_PATH
> > 3. gen-ust-event create first event and create AFTER_FIRST_PATH
> > 4. gen-ust-event gets rescheduled before it has created 99 events, e.g
> > after 9 events
> > 5. test_event_track start collecting events (lttng start .....)
> > 6. gen-ust-event is rescheduled and starts generating the remaining
> events.
> > 90 events
> > 7. lttng collects these 90 events since we have not setup "tracking" of
> PID
> > yet
> > 8. test_event_tracker calls "lttng track ... -pid "Faulty PID"
> > 9. test_event_tracker touches BEFORE_LAST_PATH
> > 10. gen-ust-events creates the last event
> > 11. test_event finishes and since it tracks the faulty pid the result
> > should  be 0 events, but we got 90 == FAULTY
> >
> > We can solve this by;
> > A: using NR_ITER=2
> > or
> > B: by adding a flag to gen-ust-events to wait before sending the first
> event
> > 1. test_event_tracker starts gen-ust-events
> > 2. test_event_tracker waits for gen-ust-events waits for
> BEFORE_FIRST_PATH
> > 3. test_event_track start collecting events (lttng start .....)
> > 4. test_event_tracker calls "lttng track ... -pid "Faulty PID"
> > 5. test_event_track creates BEFORE_FIRST_PATH
> > 6. gen_ust_event creates 100 events
> > 7. test_event_tracker waits for gen_event_ust to end
> > 8. test_event finishes and since it tracked the faulty pid the result
> will
> > be 0 events == OK
> >
> > This is in principle how gen-kernel-test-events works (but with different
> > arguments)
> > I would suggest to use B since that will be bulletproof
> >
> > Anders Wallin
> >
> >
> > On Wed, Mar 31, 2021 at 11:33 PM Jonathan Rajotte-Julien <
> > jonathan.rajotte-julien@efficios.com> wrote:
> >
> > > Hi,
> > >
> > > On Wed, Mar 31, 2021 at 11:09:42PM +0200, Anders Wallin wrote:
> > > > Hi Julian,
> > >
> > > You can use Jonathan. ;)
> > >
> > > >
> > > > Neither mine "sleep 0.1" or your version with "while [! -f
> ............"
> > > > are race condition free.
> > >
> > > I might be missing something here but as far as I understand the race
> you
> > > are
> > > trying to mitigate is that the test script execute/continue before the
> > > `backgrounded`
> > > command (background test app) had time to execute, right?
> > >
> > > If so at least waiting for the app to create a file is necessary. Now
> > > gen_kernel_test_events does not have this functionality. The
> > > PATH_WAIT_FILE is
> > > used to control when the testapp can continue. Hence the script still
> > > cannot
> > > know if the app have been scheduled.
> > >
> > > Now based on the test case you might need more synchronization for the
> test
> > > cases.
> > >
> > > Note that in the ust cases, the trace_ust_app uses `touch
> > > "$BEFORE_LAST_PATH"`
> > > that effectively unblock the app and allows it to perform the last
> > > tracepoint
> > > hit and the we `wait` on the background process.
> > >
> > > Note: some tests case are a bit clever and uses "trace_"$domain"_app"
> > > instead of
> > > calling trace_ust_app directly.
> > >
> > > For these tests case it seems that we are only expecting at least a
> single
> > > event
> > > matching the event name under test. Here the last tracepoint hit should
> > > satisfy
> > > this criteria.
> > >
> > > Am I missing a race?
> > >
> > > Cheers
> > >
> > >
> > > > I suggest that we add an option to gen-ust-events to wait before the
> > > first
> > > > event is generated.
> > > > gen_kernel_test_events already have this functionality to wait
> before the
> > > > first event.
> > > >
> > > > Something like this
> > > > static struct option long_options[] =
> > > > {
> > > > /* These options set a flag. */
> > > > {"iter", required_argument, 0, 'i'},
> > > > {"wait", required_argument, 0, 'w'},
> > > > {"sync-after-first-event", required_argument, 0, 'a'},
> > > > {"sync-before-last-event", required_argument, 0, 'b'},
> > > > {"sync-before-last-event-touch", required_argument, 0, 'c'},
> > > > {"sync-before-exit", required_argument, 0, 'd'},
> > > > {"sync-before-exit-touch", required_argument, 0, 'e'},
> > > > *+ {"sync-before-first-event", required_argument, 0, 'f'},*
> > > >
> > > > {0, 0, 0, 0}
> > > > };
> > > > ....
> > > >
> > > > I will create one or more patches for this tomorrow
> > > >
> > > > Anders Wallin
> > > >
> > > >
> > > > On Wed, Mar 31, 2021 at 9:25 PM Jonathan Rajotte-Julien <
> > > > jonathan.rajotte-julien@efficios.com> wrote:
> > > >
> > > > > > #
> > > > > > # SPDX-License-Identifier: GPL-2.0-only
> > > > > >
> > > > > > -TEST_DESC="LTTng - Event traker test"
> > > > > > +TEST_DESC="LTTng - Event tracker test"
> > > > > >
> > > > > > CURDIR=$(dirname "$0")/
> > > > > > TESTDIR="$CURDIR/../../.."
> > > > > > @@ -42,6 +42,8 @@ function prepare_ust_app
> > > > > >
> > > > > >       $TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT -a
> > > "$AFTER_FIRST_PATH" -b
> > > > > >       "$BEFORE_LAST_PATH" &
> > > > > >       CHILD_PID=$!
> > > > > > +     # voluntary context switch to start $TESTAPP_BIN
> > > > > > +     sleep 0.1
> > > > >
> > > > > A wait on the $AFTER_FIRST_PATH file would be probably more
> > > deterministic
> > > > > than a sleep here.
> > > > >
> > > > >   while [ ! -f "${AFTER_FIRST_PATH}" ]; do
> > > > >           sleep 0.1
> > > > >   done
> > > > >
> > > > > I would also expect something similar for the `prepare_kernel_app`
> > > > > function considering the same race is most probably present and
> simply
> > > not
> > > > > triggered by a chance of luck.
> > > > > Seems like gen-kernel-test-events does not expose the same sync
> > > > > capabilities here, please use gen-ust-events as an example of how
> it is
> > > > > done.
> > > > >
> > > > > Let us know how your testing goes.
> > > > >
> > > > > Thanks
> > > > >
> > >
> > > --
> > > Jonathan Rajotte-Julien
> > > EfficiOS
> > >
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--000000000000b3bfeb05beea84b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>I think you unders=
tood what I meant. The issue I have is for this 4 test cases in=C2=A0./regr=
ession/tools/tracker/test_event_tracker</div><div>- test_event_vpid_tracker=
 ust 0 &quot;${EVENT_NAME}&quot;<br>- test_event_vpid_track_untrack ust 0 &=
quot;${EVENT_NAME}&quot;<br>- test_event_pid_tracker ust 0 &quot;${EVENT_NA=
ME}&quot;<br>- test_event_pid_track_untrack ust 0 &quot;${EVENT_NAME}&quot;=
<br><br></div><div>I have 2 patches ready, but I want to run some more test=
s first before posting them</div><div>=C2=A0<br></div><div><div><div dir=3D=
"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature">Anders W=
allin</div></div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Thu, Apr 1, 2021 at 3:45 PM Jonathan Rajotte-=
Julien &lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com">jonathan=
.rajotte-julien@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">On Thu, Apr 01, 2021 at 03:21:10AM +0200, Ander=
s Wallin wrote:<br>
&gt; Hi Jonathan :)<br>
&gt; <br>
&gt; It&#39;s very unlikely that the race could occur, BUT it can happen.<b=
r>
&gt; <br>
&gt; OK run<br>
&gt; 1. test_event_tracker starts gen-ust-events<br>
&gt; 2. test_event_tracker waits for gen-ust-events to create AFTER_FIRST_P=
ATH<br>
&gt; 3. gen-ust-event create first event and create AFTER_FIRST_PATH<br>
&gt; 4. gen-ust-event continue and create 99 events<br>
&gt; 5. gen-ust-event wait for=C2=A0 BEFORE_LAST_PATH<br>
&gt; 6. test_event_track start collecting events (lttng start .....)<br>
<br>
&gt; 7. test_event_tracker calls &quot;lttng track ... -pid &quot;Faulty PI=
D&quot;<br>
&gt; 8. test_event_tracker touches BEFORE_LAST_PATH<br>
&gt; 9. gen-ust-events creates the last event<br>
&gt; 10. test_event finishes and since it tracks the faulty pid the result =
will<br>
&gt; be 0 events =3D=3D OK<br>
<br>
The sequence of event for the `test_event_tracker` function is (as of maste=
r):<br>
<br>
create<br>
enable event<br>
start<br>
track<br>
<br>
launch app<br>
wait for app return<br>
stop<br>
destroy<br>
<br>
<br>
The sequence you are describing here is:<br>
<br>
lauch app<br>
start<br>
track<br>
...<br>
<br>
I&#39;m pretty sure we are not talking about the same things. Please specif=
y the<br>
test case and all functions involved and make sure to use the proper name f=
or<br>
each of them.<br>
<br>
I suspect you are talking about test_event_pid_tracker. Still let&#39;s mak=
e sure of<br>
it. If it is, I do agree that it seems to have a window where we can gather=
<br>
event for.<br>
<br>
You might want to look if there is a real reason for this sequence instead =
of<br>
mimicking test_event_tracker<br>
<br>
Current code:<br>
=C2=A0enable_&quot;$domain&quot;_lttng_event_ok $SESSION_NAME &quot;$wildca=
rd&quot; &quot;$channel&quot;<br>
=C2=A0prepare_&quot;$domain&quot;_app<br>
=C2=A0start_lttng_tracing_ok<br>
<br>
=C2=A0if [ &quot;$expect_event&quot; -eq 1 ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lttng_track_&quot;$domain&quot;_ok &quot;=
--vpid ${CHILD_PID}&quot;<br>
=C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lttng_track_&quot;$domain&quot;_ok &quot;=
--vpid $((CHILD_PID+1))&quot;<br>
=C2=A0fi<br>
=C2=A0trace_&quot;$domain&quot;_app<br>
=C2=A0stop_lttng_tracing_ok<br>
=C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
<br>
<br>
We might simply want to move the track command before the start considering=
 have<br>
all the information to do so.<br>
<br>
=C2=A0enable_&quot;$domain&quot;_lttng_event_ok $SESSION_NAME &quot;$wildca=
rd&quot; &quot;$channel&quot;<br>
<br>
=C2=A0prepare_&quot;$domain&quot;_app<br>
<br>
=C2=A0if [ &quot;$expect_event&quot; -eq 1 ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lttng_track_&quot;$domain&quot;_ok &quot;=
--vpid ${CHILD_PID}&quot;<br>
=C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lttng_track_&quot;$domain&quot;_ok &quot;=
--vpid $((CHILD_PID+1))&quot;<br>
=C2=A0fi<br>
<br>
=C2=A0start_lttng_tracing_ok<br>
=C2=A0trace_&quot;$domain&quot;_app<br>
<br>
=C2=A0stop_lttng_tracing_ok<br>
=C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
<br>
After testing this, seems like the validate_trace_empty does not handle the=
<br>
case were simply stream allocation did not take place since no application =
was<br>
&#39;valid&#39; at the moment of the trace start.<br>
<br>
Well we got a good one here. We will wait for your updated patch and go fro=
m<br>
there.<br>
<br>
Cheers<br>
<br>
&gt; <br>
&gt; Faulty run<br>
&gt; 1. test_event_tracker starts gen-ust-events<br>
&gt; 2. test_event_tracker waits for gen-ust-events to create AFTER_FIRST_P=
ATH<br>
&gt; 3. gen-ust-event create first event and create AFTER_FIRST_PATH<br>
&gt; 4. gen-ust-event gets rescheduled before it has created 99 events, e.g=
<br>
&gt; after 9 events<br>
&gt; 5. test_event_track start collecting events (lttng start .....)<br>
&gt; 6. gen-ust-event is rescheduled and starts generating the remaining ev=
ents.<br>
&gt; 90 events<br>
&gt; 7. lttng collects these 90 events since we have not setup &quot;tracki=
ng&quot; of PID<br>
&gt; yet<br>
&gt; 8. test_event_tracker calls &quot;lttng track ... -pid &quot;Faulty PI=
D&quot;<br>
&gt; 9. test_event_tracker touches BEFORE_LAST_PATH<br>
&gt; 10. gen-ust-events creates the last event<br>
&gt; 11. test_event finishes and since it tracks the faulty pid the result<=
br>
&gt; should=C2=A0 be 0 events, but we got 90 =3D=3D FAULTY<br>
&gt; <br>
&gt; We can solve this by;<br>
&gt; A: using NR_ITER=3D2<br>
&gt; or<br>
&gt; B: by adding a flag to gen-ust-events to wait before sending the first=
 event<br>
&gt; 1. test_event_tracker starts gen-ust-events<br>
&gt; 2. test_event_tracker waits for gen-ust-events waits for BEFORE_FIRST_=
PATH<br>
&gt; 3. test_event_track start collecting events (lttng start .....)<br>
&gt; 4. test_event_tracker calls &quot;lttng track ... -pid &quot;Faulty PI=
D&quot;<br>
&gt; 5. test_event_track creates BEFORE_FIRST_PATH<br>
&gt; 6. gen_ust_event creates 100 events<br>
&gt; 7. test_event_tracker waits for gen_event_ust to end<br>
&gt; 8. test_event finishes and since it tracked the faulty pid the result =
will<br>
&gt; be 0 events =3D=3D OK<br>
&gt; <br>
&gt; This is in principle how gen-kernel-test-events works (but with differ=
ent<br>
&gt; arguments)<br>
&gt; I would suggest to use B since that will be bulletproof<br>
&gt; <br>
&gt; Anders Wallin<br>
&gt; <br>
&gt; <br>
&gt; On Wed, Mar 31, 2021 at 11:33 PM Jonathan Rajotte-Julien &lt;<br>
&gt; <a href=3D"mailto:jonathan.rajotte-julien@efficios.com" target=3D"_bla=
nk">jonathan.rajotte-julien@efficios.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; On Wed, Mar 31, 2021 at 11:09:42PM +0200, Anders Wallin wrote:<br=
>
&gt; &gt; &gt; Hi Julian,<br>
&gt; &gt;<br>
&gt; &gt; You can use Jonathan. ;)<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Neither mine &quot;sleep 0.1&quot; or your version with &quo=
t;while [! -f ............&quot;<br>
&gt; &gt; &gt; are race condition free.<br>
&gt; &gt;<br>
&gt; &gt; I might be missing something here but as far as I understand the =
race you<br>
&gt; &gt; are<br>
&gt; &gt; trying to mitigate is that the test script execute/continue befor=
e the<br>
&gt; &gt; `backgrounded`<br>
&gt; &gt; command (background test app) had time to execute, right?<br>
&gt; &gt;<br>
&gt; &gt; If so at least waiting for the app to create a file is necessary.=
 Now<br>
&gt; &gt; gen_kernel_test_events does not have this functionality. The<br>
&gt; &gt; PATH_WAIT_FILE is<br>
&gt; &gt; used to control when the testapp can continue. Hence the script s=
till<br>
&gt; &gt; cannot<br>
&gt; &gt; know if the app have been scheduled.<br>
&gt; &gt;<br>
&gt; &gt; Now based on the test case you might need more synchronization fo=
r the test<br>
&gt; &gt; cases.<br>
&gt; &gt;<br>
&gt; &gt; Note that in the ust cases, the trace_ust_app uses `touch<br>
&gt; &gt; &quot;$BEFORE_LAST_PATH&quot;`<br>
&gt; &gt; that effectively unblock the app and allows it to perform the las=
t<br>
&gt; &gt; tracepoint<br>
&gt; &gt; hit and the we `wait` on the background process.<br>
&gt; &gt;<br>
&gt; &gt; Note: some tests case are a bit clever and uses &quot;trace_&quot=
;$domain&quot;_app&quot;<br>
&gt; &gt; instead of<br>
&gt; &gt; calling trace_ust_app directly.<br>
&gt; &gt;<br>
&gt; &gt; For these tests case it seems that we are only expecting at least=
 a single<br>
&gt; &gt; event<br>
&gt; &gt; matching the event name under test. Here the last tracepoint hit =
should<br>
&gt; &gt; satisfy<br>
&gt; &gt; this criteria.<br>
&gt; &gt;<br>
&gt; &gt; Am I missing a race?<br>
&gt; &gt;<br>
&gt; &gt; Cheers<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; I suggest that we add an option to gen-ust-events to wait be=
fore the<br>
&gt; &gt; first<br>
&gt; &gt; &gt; event is generated.<br>
&gt; &gt; &gt; gen_kernel_test_events already have this functionality to wa=
it before the<br>
&gt; &gt; &gt; first event.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Something like this<br>
&gt; &gt; &gt; static struct option long_options[] =3D<br>
&gt; &gt; &gt; {<br>
&gt; &gt; &gt; /* These options set a flag. */<br>
&gt; &gt; &gt; {&quot;iter&quot;, required_argument, 0, &#39;i&#39;},<br>
&gt; &gt; &gt; {&quot;wait&quot;, required_argument, 0, &#39;w&#39;},<br>
&gt; &gt; &gt; {&quot;sync-after-first-event&quot;, required_argument, 0, &=
#39;a&#39;},<br>
&gt; &gt; &gt; {&quot;sync-before-last-event&quot;, required_argument, 0, &=
#39;b&#39;},<br>
&gt; &gt; &gt; {&quot;sync-before-last-event-touch&quot;, required_argument=
, 0, &#39;c&#39;},<br>
&gt; &gt; &gt; {&quot;sync-before-exit&quot;, required_argument, 0, &#39;d&=
#39;},<br>
&gt; &gt; &gt; {&quot;sync-before-exit-touch&quot;, required_argument, 0, &=
#39;e&#39;},<br>
&gt; &gt; &gt; *+ {&quot;sync-before-first-event&quot;, required_argument, =
0, &#39;f&#39;},*<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; {0, 0, 0, 0}<br>
&gt; &gt; &gt; };<br>
&gt; &gt; &gt; ....<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I will create one or more patches for this tomorrow<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Anders Wallin<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Wed, Mar 31, 2021 at 9:25 PM Jonathan Rajotte-Julien &lt;=
<br>
&gt; &gt; &gt; <a href=3D"mailto:jonathan.rajotte-julien@efficios.com" targ=
et=3D"_blank">jonathan.rajotte-julien@efficios.com</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; #<br>
&gt; &gt; &gt; &gt; &gt; # SPDX-License-Identifier: GPL-2.0-only<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; -TEST_DESC=3D&quot;LTTng - Event traker test&quot;=
<br>
&gt; &gt; &gt; &gt; &gt; +TEST_DESC=3D&quot;LTTng - Event tracker test&quot=
;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; CURDIR=3D$(dirname &quot;$0&quot;)/<br>
&gt; &gt; &gt; &gt; &gt; TESTDIR=3D&quot;$CURDIR/../../..&quot;<br>
&gt; &gt; &gt; &gt; &gt; @@ -42,6 +42,8 @@ function prepare_ust_app<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTAPP_BIN -i $NR_ITER=
 -w $NR_USEC_WAIT -a<br>
&gt; &gt; &quot;$AFTER_FIRST_PATH&quot; -b<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;$BEFORE_LAST_PATH&=
quot; &amp;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CHILD_PID=3D$!<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0# voluntary context switch to=
 start $TESTAPP_BIN<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0sleep 0.1<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; A wait on the $AFTER_FIRST_PATH file would be probably =
more<br>
&gt; &gt; deterministic<br>
&gt; &gt; &gt; &gt; than a sleep here.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0while [ ! -f &quot;${AFTER_FIRST_PATH}&quot=
; ]; do<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sleep 0.1<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0done<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; I would also expect something similar for the `prepare_=
kernel_app`<br>
&gt; &gt; &gt; &gt; function considering the same race is most probably pre=
sent and simply<br>
&gt; &gt; not<br>
&gt; &gt; &gt; &gt; triggered by a chance of luck.<br>
&gt; &gt; &gt; &gt; Seems like gen-kernel-test-events does not expose the s=
ame sync<br>
&gt; &gt; &gt; &gt; capabilities here, please use gen-ust-events as an exam=
ple of how it is<br>
&gt; &gt; &gt; &gt; done.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Let us know how your testing goes.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Thanks<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; Jonathan Rajotte-Julien<br>
&gt; &gt; EfficiOS<br>
&gt; &gt;<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div></div>

--000000000000b3bfeb05beea84b1--

--===============4962648184078771564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4962648184078771564==--
