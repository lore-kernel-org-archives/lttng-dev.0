Return-Path: <SRS0=VMqU=I6=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C8EC433ED
	for <lttng-dev@archiver.kernel.org>; Thu,  1 Apr 2021 01:21:27 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1110760FED
	for <lttng-dev@archiver.kernel.org>; Thu,  1 Apr 2021 01:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1110760FED
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F9lkr16GQzSKq;
	Wed, 31 Mar 2021 21:21:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617240085;
	bh=cq9dXTC6ExBZlPDRLGMMaN6K0+TCTl49yq7mVlrmTX8=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=AtLowNVgves51e1aHs/LtT6YTn3pGGAfWya3gqa45rJMBTbxkxmC5TmoKC/beKwLU
	 KZ/07BXdFonW3PYyWmR96u2wNNpg4jX26eYbR3epI3A/pTna1c53KlJFbQA4iPSlCO
	 MgYq7gu8OdLPaSsnwPv5LJi2Y8OLyGRQdWLzpU3oFsyXQcpIBwaWHxIapQJfIsxWYQ
	 +6uPFOGoOtwZyxKM5rfxHO+Y8H5nundFpRqPl6kO58CBYJSqA7lwolz9S0RzxkqqAz
	 Hs/bbV6btPg494nGQSx75Pxes1tPH6P/Pwsm8qcShE1LOreXIpgD9golFCpn2Howcq
	 kv9Rp4YYv4rDg==
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 by lists.lttng.org (Postfix) with ESMTPS id 4F9lkp5GT7zSb1
 for <lttng-dev@lists.lttng.org>; Wed, 31 Mar 2021 21:21:22 -0400 (EDT)
Received: by mail-io1-xd30.google.com with SMTP id k8so500416iop.12
 for <lttng-dev@lists.lttng.org>; Wed, 31 Mar 2021 18:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qD8n59Ivhe7yx3kGtem+1KPfwhxZo1v6HswKc3URs8A=;
 b=GMtcsqJ80msYZ+ApxN0Yl0Y4huOLwcw7RkCqscEQsVwZPyOQP5KD9MdQaZN0oDfUYy
 bO7rq6/qUHxR5PCmJMGqfnmI1ExKvsswKwGuGOTNRzRdoYMr9sfwWDvanyPvf+mwE6mv
 bg16TvU3L1PLltuADJ03jVPL3Jh9SDHcKhxyYzoH1DOoLmVk+WGzN4BX1LMpxtY47FMm
 Ik0k56svecqLZd4Ln2kV3jywTgRdefInAXRAwcGYzLWMxSUOqcU+ClH/ahJ7f/BnDghO
 jhUo5SZYMuB9t8VacOSgfo6No9sgO8ZdmyKvIiCjgMP+a52/nxKW+O+zVRPYPWJozviC
 Lw0A==
X-Gm-Message-State: AOAM530lzsSs5ytwYOhPZPjaIKtmNcmCWZJRrzdADrJznDUVy/KFxdfs
 OLumv+2MWDD+6iWtACfrrjASikCQMXfLqtQW1og=
X-Google-Smtp-Source: ABdhPJwjMHj1GEOJNnKM5EF6i4UM4D0dwrpt3ZD0wGf0rXa82gUWdrRr2dOfUsHeWYF6AqSEZHtFc3IPyvKjcTX3mKU=
X-Received: by 2002:a05:6602:2e82:: with SMTP id
 m2mr4480200iow.70.1617240081897; 
 Wed, 31 Mar 2021 18:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210331185624.406960-1-wallinux@gmail.com>
 <592114658.48857.1617218709305.JavaMail.zimbra@efficios.com>
 <CAF2baFdV51rF5jAU5Ru4Y3OuTOJFMCuA=AZrBBDxkHRH_3JPSQ@mail.gmail.com>
 <20210331213313.GD28307@joraj-alpa>
In-Reply-To: <20210331213313.GD28307@joraj-alpa>
Date: Thu, 1 Apr 2021 03:21:10 +0200
Message-ID: <CAF2baFdzoD-wmoO84A83DXdTzBr1WZ7ifoQtah493xH7WE3KhQ@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============4113572608032867662=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============4113572608032867662==
Content-Type: multipart/alternative; boundary="000000000000991d3605bedf0c27"

--000000000000991d3605bedf0c27
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan :)

It's very unlikely that the race could occur, BUT it can happen.

OK run
1. test_event_tracker starts gen-ust-events
2. test_event_tracker waits for gen-ust-events to create AFTER_FIRST_PATH
3. gen-ust-event create first event and create AFTER_FIRST_PATH
4. gen-ust-event continue and create 99 events
5. gen-ust-event wait for  BEFORE_LAST_PATH
6. test_event_track start collecting events (lttng start .....)
7. test_event_tracker calls "lttng track ... -pid "Faulty PID"
8. test_event_tracker touches BEFORE_LAST_PATH
9. gen-ust-events creates the last event
10. test_event finishes and since it tracks the faulty pid the result will
be 0 events == OK

Faulty run
1. test_event_tracker starts gen-ust-events
2. test_event_tracker waits for gen-ust-events to create AFTER_FIRST_PATH
3. gen-ust-event create first event and create AFTER_FIRST_PATH
4. gen-ust-event gets rescheduled before it has created 99 events, e.g
after 9 events
5. test_event_track start collecting events (lttng start .....)
6. gen-ust-event is rescheduled and starts generating the remaining events.
90 events
7. lttng collects these 90 events since we have not setup "tracking" of PID
yet
8. test_event_tracker calls "lttng track ... -pid "Faulty PID"
9. test_event_tracker touches BEFORE_LAST_PATH
10. gen-ust-events creates the last event
11. test_event finishes and since it tracks the faulty pid the result
should  be 0 events, but we got 90 == FAULTY

We can solve this by;
A: using NR_ITER=2
or
B: by adding a flag to gen-ust-events to wait before sending the first event
1. test_event_tracker starts gen-ust-events
2. test_event_tracker waits for gen-ust-events waits for BEFORE_FIRST_PATH
3. test_event_track start collecting events (lttng start .....)
4. test_event_tracker calls "lttng track ... -pid "Faulty PID"
5. test_event_track creates BEFORE_FIRST_PATH
6. gen_ust_event creates 100 events
7. test_event_tracker waits for gen_event_ust to end
8. test_event finishes and since it tracked the faulty pid the result will
be 0 events == OK

This is in principle how gen-kernel-test-events works (but with different
arguments)
I would suggest to use B since that will be bulletproof

Anders Wallin


On Wed, Mar 31, 2021 at 11:33 PM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi,
>
> On Wed, Mar 31, 2021 at 11:09:42PM +0200, Anders Wallin wrote:
> > Hi Julian,
>
> You can use Jonathan. ;)
>
> >
> > Neither mine "sleep 0.1" or your version with "while [! -f ............"
> > are race condition free.
>
> I might be missing something here but as far as I understand the race you
> are
> trying to mitigate is that the test script execute/continue before the
> `backgrounded`
> command (background test app) had time to execute, right?
>
> If so at least waiting for the app to create a file is necessary. Now
> gen_kernel_test_events does not have this functionality. The
> PATH_WAIT_FILE is
> used to control when the testapp can continue. Hence the script still
> cannot
> know if the app have been scheduled.
>
> Now based on the test case you might need more synchronization for the test
> cases.
>
> Note that in the ust cases, the trace_ust_app uses `touch
> "$BEFORE_LAST_PATH"`
> that effectively unblock the app and allows it to perform the last
> tracepoint
> hit and the we `wait` on the background process.
>
> Note: some tests case are a bit clever and uses "trace_"$domain"_app"
> instead of
> calling trace_ust_app directly.
>
> For these tests case it seems that we are only expecting at least a single
> event
> matching the event name under test. Here the last tracepoint hit should
> satisfy
> this criteria.
>
> Am I missing a race?
>
> Cheers
>
>
> > I suggest that we add an option to gen-ust-events to wait before the
> first
> > event is generated.
> > gen_kernel_test_events already have this functionality to wait before the
> > first event.
> >
> > Something like this
> > static struct option long_options[] =
> > {
> > /* These options set a flag. */
> > {"iter", required_argument, 0, 'i'},
> > {"wait", required_argument, 0, 'w'},
> > {"sync-after-first-event", required_argument, 0, 'a'},
> > {"sync-before-last-event", required_argument, 0, 'b'},
> > {"sync-before-last-event-touch", required_argument, 0, 'c'},
> > {"sync-before-exit", required_argument, 0, 'd'},
> > {"sync-before-exit-touch", required_argument, 0, 'e'},
> > *+ {"sync-before-first-event", required_argument, 0, 'f'},*
> >
> > {0, 0, 0, 0}
> > };
> > ....
> >
> > I will create one or more patches for this tomorrow
> >
> > Anders Wallin
> >
> >
> > On Wed, Mar 31, 2021 at 9:25 PM Jonathan Rajotte-Julien <
> > jonathan.rajotte-julien@efficios.com> wrote:
> >
> > > > #
> > > > # SPDX-License-Identifier: GPL-2.0-only
> > > >
> > > > -TEST_DESC="LTTng - Event traker test"
> > > > +TEST_DESC="LTTng - Event tracker test"
> > > >
> > > > CURDIR=$(dirname "$0")/
> > > > TESTDIR="$CURDIR/../../.."
> > > > @@ -42,6 +42,8 @@ function prepare_ust_app
> > > >
> > > >       $TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT -a
> "$AFTER_FIRST_PATH" -b
> > > >       "$BEFORE_LAST_PATH" &
> > > >       CHILD_PID=$!
> > > > +     # voluntary context switch to start $TESTAPP_BIN
> > > > +     sleep 0.1
> > >
> > > A wait on the $AFTER_FIRST_PATH file would be probably more
> deterministic
> > > than a sleep here.
> > >
> > >   while [ ! -f "${AFTER_FIRST_PATH}" ]; do
> > >           sleep 0.1
> > >   done
> > >
> > > I would also expect something similar for the `prepare_kernel_app`
> > > function considering the same race is most probably present and simply
> not
> > > triggered by a chance of luck.
> > > Seems like gen-kernel-test-events does not expose the same sync
> > > capabilities here, please use gen-ust-events as an example of how it is
> > > done.
> > >
> > > Let us know how your testing goes.
> > >
> > > Thanks
> > >
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--000000000000991d3605bedf0c27
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Jonathan :)<br><br>It&#39;s very unlik=
ely that the race could occur, BUT it can happen.<br><div dir=3D"ltr"><br><=
/div><div>OK run<br></div></div><div dir=3D"ltr"><div dir=3D"ltr">1. test_e=
vent_tracker starts gen-ust-events</div><div>2. test_event_tracker waits fo=
r gen-ust-events to create=C2=A0AFTER_FIRST_PATH</div><div>3. gen-ust-event=
 create first event and create AFTER_FIRST_PATH</div><div>4. gen-ust-event =
continue and create 99 events</div><div>5. gen-ust-event wait for=C2=A0=C2=
=A0BEFORE_LAST_PATH</div><div>6. test_event_track start collecting events (=
lttng start .....)</div><div>7. test_event_tracker calls &quot;lttng track =
... -pid &quot;Faulty PID&quot;<br></div><div>8. test_event_tracker touches=
=C2=A0BEFORE_LAST_PATH</div><div>9. gen-ust-events creates the last event</=
div><div>10. test_event finishes and since it tracks the faulty pid the res=
ult will be 0 events =3D=3D OK</div><div><br></div><div></div></div><div>Fa=
ulty run</div><div dir=3D"ltr">1. test_event_tracker starts gen-ust-events<=
br></div><div>2. test_event_tracker waits for gen-ust-events to create=C2=
=A0AFTER_FIRST_PATH</div><div>3. gen-ust-event create first event and creat=
e AFTER_FIRST_PATH</div><div>4. gen-ust-event gets rescheduled before it ha=
s created 99 events, e.g after 9 events</div><div>5. test_event_track start=
 collecting events (lttng start .....)</div><div>6. gen-ust-event is resche=
duled and starts=C2=A0generating the remaining events. 90 events<br>7. lttn=
g collects these 90 events since we have not setup &quot;tracking&quot; of =
PID yet</div><div>8. test_event_tracker calls &quot;lttng track ... -pid &q=
uot;Faulty PID&quot;</div><div>9. test_event_tracker touches=C2=A0BEFORE_LA=
ST_PATH</div><div>10. gen-ust-events creates the last event</div><div>11.=
=C2=A0test_event finishes and since it tracks the faulty pid the result sho=
uld=C2=A0 be 0 events, but we got 90 =3D=3D FAULTY</div><div><br></div><div=
>We can solve this by;</div><div>A: using NR_ITER=3D2</div><div>or</div><di=
v>B: by adding a flag to gen-ust-events to wait before sending the first ev=
ent<br></div><div><div dir=3D"ltr">1. test_event_tracker starts gen-ust-eve=
nts</div><div>2. test_event_tracker waits for gen-ust-events waits for BEFO=
RE_FIRST_PATH</div><div>3. test_event_track start collecting events (lttng =
start .....)<br></div><div>4. test_event_tracker calls &quot;lttng track ..=
. -pid &quot;Faulty PID&quot;<br></div><div>5. test_event_track creates BEF=
ORE_FIRST_PATH</div><div></div><div>6. gen_ust_event creates 100 events</di=
v><div>7. test_event_tracker waits for gen_event_ust to end</div><div>8. te=
st_event finishes and since it tracked the faulty pid the result will be 0 =
events =3D=3D OK</div><div></div></div><div dir=3D"ltr"><br></div><div>This=
 is in principle how gen-kernel-test-events works (but with different argum=
ents)</div><div>I would suggest to use B since that will be bulletproof</di=
v><div dir=3D"ltr"><br>Anders Wallin<br></div><div dir=3D"ltr"><br></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, =
Mar 31, 2021 at 11:33 PM Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jona=
than.rajotte-julien@efficios.com">jonathan.rajotte-julien@efficios.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<b=
r>
<br>
On Wed, Mar 31, 2021 at 11:09:42PM +0200, Anders Wallin wrote:<br>
&gt; Hi Julian,<br>
<br>
You can use Jonathan. ;)<br>
<br>
&gt; <br>
&gt; Neither mine &quot;sleep 0.1&quot; or your version with &quot;while [!=
 -f ............&quot;<br>
&gt; are race condition free.<br>
<br>
I might be missing something here but as far as I understand the race you a=
re<br>
trying to mitigate is that the test script execute/continue before the `bac=
kgrounded`<br>
command (background test app) had time to execute, right?<br>
<br>
If so at least waiting for the app to create a file is necessary. Now<br>
gen_kernel_test_events does not have this functionality. The PATH_WAIT_FILE=
 is<br>
used to control when the testapp can continue. Hence the script still canno=
t<br>
know if the app have been scheduled.<br>
<br>
Now based on the test case you might need more synchronization for the test=
<br>
cases.<br>
<br>
Note that in the ust cases, the trace_ust_app uses `touch &quot;$BEFORE_LAS=
T_PATH&quot;`<br>
that effectively unblock the app and allows it to perform the last tracepoi=
nt<br>
hit and the we `wait` on the background process.<br>
<br>
Note: some tests case are a bit clever and uses &quot;trace_&quot;$domain&q=
uot;_app&quot; instead of<br>
calling trace_ust_app directly.<br>
<br>
For these tests case it seems that we are only expecting at least a single =
event<br>
matching the event name under test. Here the last tracepoint hit should sat=
isfy<br>
this criteria.<br>
<br>
Am I missing a race?<br>
<br>
Cheers<br>
<br>
<br>
&gt; I suggest that we add an option to gen-ust-events to wait before the f=
irst<br>
&gt; event is generated.<br>
&gt; gen_kernel_test_events already have this functionality to wait before =
the<br>
&gt; first event.<br>
&gt; <br>
&gt; Something like this<br>
&gt; static struct option long_options[] =3D<br>
&gt; {<br>
&gt; /* These options set a flag. */<br>
&gt; {&quot;iter&quot;, required_argument, 0, &#39;i&#39;},<br>
&gt; {&quot;wait&quot;, required_argument, 0, &#39;w&#39;},<br>
&gt; {&quot;sync-after-first-event&quot;, required_argument, 0, &#39;a&#39;=
},<br>
&gt; {&quot;sync-before-last-event&quot;, required_argument, 0, &#39;b&#39;=
},<br>
&gt; {&quot;sync-before-last-event-touch&quot;, required_argument, 0, &#39;=
c&#39;},<br>
&gt; {&quot;sync-before-exit&quot;, required_argument, 0, &#39;d&#39;},<br>
&gt; {&quot;sync-before-exit-touch&quot;, required_argument, 0, &#39;e&#39;=
},<br>
&gt; *+ {&quot;sync-before-first-event&quot;, required_argument, 0, &#39;f&=
#39;},*<br>
&gt; <br>
&gt; {0, 0, 0, 0}<br>
&gt; };<br>
&gt; ....<br>
&gt; <br>
&gt; I will create one or more patches for this tomorrow<br>
&gt; <br>
&gt; Anders Wallin<br>
&gt; <br>
&gt; <br>
&gt; On Wed, Mar 31, 2021 at 9:25 PM Jonathan Rajotte-Julien &lt;<br>
&gt; <a href=3D"mailto:jonathan.rajotte-julien@efficios.com" target=3D"_bla=
nk">jonathan.rajotte-julien@efficios.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; &gt; #<br>
&gt; &gt; &gt; # SPDX-License-Identifier: GPL-2.0-only<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -TEST_DESC=3D&quot;LTTng - Event traker test&quot;<br>
&gt; &gt; &gt; +TEST_DESC=3D&quot;LTTng - Event tracker test&quot;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; CURDIR=3D$(dirname &quot;$0&quot;)/<br>
&gt; &gt; &gt; TESTDIR=3D&quot;$CURDIR/../../..&quot;<br>
&gt; &gt; &gt; @@ -42,6 +42,8 @@ function prepare_ust_app<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTAPP_BIN -i $NR_ITER -w $NR_US=
EC_WAIT -a &quot;$AFTER_FIRST_PATH&quot; -b<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;$BEFORE_LAST_PATH&quot; &amp=
;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CHILD_PID=3D$!<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0# voluntary context switch to start $TE=
STAPP_BIN<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0sleep 0.1<br>
&gt; &gt;<br>
&gt; &gt; A wait on the $AFTER_FIRST_PATH file would be probably more deter=
ministic<br>
&gt; &gt; than a sleep here.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0while [ ! -f &quot;${AFTER_FIRST_PATH}&quot; ]; do<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sleep 0.1<br>
&gt; &gt;=C2=A0 =C2=A0done<br>
&gt; &gt;<br>
&gt; &gt; I would also expect something similar for the `prepare_kernel_app=
`<br>
&gt; &gt; function considering the same race is most probably present and s=
imply not<br>
&gt; &gt; triggered by a chance of luck.<br>
&gt; &gt; Seems like gen-kernel-test-events does not expose the same sync<b=
r>
&gt; &gt; capabilities here, please use gen-ust-events as an example of how=
 it is<br>
&gt; &gt; done.<br>
&gt; &gt;<br>
&gt; &gt; Let us know how your testing goes.<br>
&gt; &gt;<br>
&gt; &gt; Thanks<br>
&gt; &gt;<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div></div>

--000000000000991d3605bedf0c27--

--===============4113572608032867662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4113572608032867662==--
