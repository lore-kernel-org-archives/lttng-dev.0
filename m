Return-Path: <SRS0=+4ah=JF=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86578C433ED
	for <lttng-dev@archiver.kernel.org>; Thu,  8 Apr 2021 09:22:34 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 635A261155
	for <lttng-dev@archiver.kernel.org>; Thu,  8 Apr 2021 09:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635A261155
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FGG4l5Fqbz14mL;
	Thu,  8 Apr 2021 05:22:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617873752;
	bh=hhmpsuOiYRKR7XLU384l1N1z/yrzh/LUoiNdZTR2AsY=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=W7ZXil2bYhTrpe2UHknhoYYcrl3wcPndRnklJ70i3tZ56wmt6wNE93BxFvCuLP5Ug
	 0mWeBPpk1wX8bMYjFTaVvJrV8fvEUWGUPQ1uUkJ6MkjON2RYjKp2dhXSrHi9MoK5sh
	 DOaUJW1LgbeTK4Lp56m1vO8vRmhYCH2n40rrWSeEnfLSpk9ox46rfEID21Yxmrod8N
	 1CMAYJiHGM0L98RYr/Ma1CJxsaXwG7WIy66lDu0I8qjVapBpI4s3m5tZTe6M/uclZ6
	 DFo20BgwTIbw7r/rqFPqkSbGjqTHZBifYJvwFoyuruCdrXyTk0fVSyAWykQLK6uSJT
	 W4ciRgTWM0TVg==
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 by lists.lttng.org (Postfix) with ESMTPS id 4FGG4k4gqMz1531
 for <lttng-dev@lists.lttng.org>; Thu,  8 Apr 2021 05:22:30 -0400 (EDT)
Received: by mail-io1-xd29.google.com with SMTP id x17so1507855iog.2
 for <lttng-dev@lists.lttng.org>; Thu, 08 Apr 2021 02:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oOgXMbKcIAprmyuXxn4V8fRlrfZ+8GYdyJnCyoISnHw=;
 b=TuvCCupj3Y+WgGPIkJqbxJEmSgKi8TGgTpObXF42tW1eS95pMSz4XEgKpD8N3Y4YO6
 aT8tZMzfbGlS+SvgCjw60XQEQUpqluj+G0pI8+gswHhePgyuOmDn8IAHFAPqQAbaq6gb
 E5teq4ifaqymLoDNR2xzMgDBHVjl4LUHTM/WKQYDF57M1Fe1Q05bE3k63Nr81KlgFILs
 OwH7mqvVthk0QITqhAzdIWS8k9xqmF/Q5kuLkRT2PNZfqm46V/fVmqHsXPDvU2zyR3pQ
 RnDW2M44FIv+mSHfkN7pdndFUhxxtWvfrKSXlQxR8vtWknemWawNJBRjMThKoQohZ1mG
 +zBA==
X-Gm-Message-State: AOAM532KKq6d9OKAIc+OBLUwnWM4GpRLF+Vh/jGh1AqHk/oJDP19WILz
 Wt8n7lGg2SBiwxdTjAqxQoHRFYvl6qkHXHq4edk=
X-Google-Smtp-Source: ABdhPJzx2BRpJGCtiMKCqMsSGFyF/5TBgyHAqTVq/GyNfZVCn+U5fGKmhg6ziCzJsH1i+crfIYlO6XMBQ9Cy9C+otAg=
X-Received: by 2002:a02:a506:: with SMTP id e6mr7875002jam.56.1617873749651;
 Thu, 08 Apr 2021 02:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210401163710.839365-1-wallinux@gmail.com>
 <667805472.60438.1617809506670.JavaMail.zimbra@efficios.com>
In-Reply-To: <667805472.60438.1617809506670.JavaMail.zimbra@efficios.com>
Date: Thu, 8 Apr 2021 11:22:18 +0200
Message-ID: <CAF2baFcBgU+GH_yh5khVki1KHT8on90vNvPgnQxiWM6pwTbsLQ@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Content-Type: multipart/mixed; boundary="===============5988245791924115098=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============5988245791924115098==
Content-Type: multipart/alternative; boundary="00000000000023b5a105bf7296ea"

--00000000000023b5a105bf7296ea
Content-Type: text/plain; charset="UTF-8"

OK,

I tried this and for
- test_event_vpid_track_untrack ust 0 "${EVENT_NAME}"
- test_event_pid_track_untrack ust 0 "${EVENT_NAME}"
it works well.

For
- test_event_vpid_tracker ust 0 "${EVENT_NAME}"
- test_event_pid_tracker ust 0 "${EVENT_NAME}"
validate_trace_empty fails since there is no data at all in the trace_path

This run is just calling copy of test_event_tracker running only
"test_event_vpid_tracker ust 0 ..."
1..747
# LTTng - Event tracker test
ok 1 - Start session daemon
# Test UST tracker
ok 2 - Create session tracker in -o /tmp/tmp.lu5aeCJhQ3
ok 3 - Enable ust event tp:tptest for session tracker
ok 4 - Untrack command with opts: -u --all --vpid
ok 5 - Start tracing for session
ok 6 - Track command with opts: -u --vpid 11842
ok 7 - Traced application stopped.
ok 8 - Stop lttng tracing for session
ok 9 - Destroy session tracker


*not ok 10 - Failed to parse trace#   Failed test 'Failed to parse trace'*#
  in ./regression/tools/tracker//../../../utils/tap/tap.sh:fail() at line
159.
# Killing (signal SIGTERM) lttng-sessiond and lt-lttng-sessiond pids: 11808
11809 11830
ok 11 - Wait after kill session daemon
# Looks like you planned 747 tests but only ran 11.
# Looks like you failed 1 test of 11.

# find /tmp/tmp.lu5aeCJhQ3
/tmp/tmp.lu5aeCJhQ3
/tmp/tmp.lu5aeCJhQ3/ust

Do you want me to add a special version of "validate_trace_empty" not
returning
"Failed to parse trace" for this? If so should it be added in
"test_event_tracker" or in "utils.sh"

Anders Wallin


On Wed, Apr 7, 2021 at 5:31 PM Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ----- On Apr 1, 2021, at 12:37 PM, lttng-dev lttng-dev@lists.lttng.org
> wrote:
>
> > the following tests fails
> > - test_event_vpid_tracker ust 0 "${EVENT_NAME}"
> > - test_event_vpid_track_untrack ust 0 "${EVENT_NAME}"
> > - test_event_pid_tracker ust 0 "${EVENT_NAME}"
> > - test_event_pid_track_untrack ust 0 "${EVENT_NAME}"
>
> There is indeed an issue with these tests: there is a missing "untrack all
> pids"
> which should be done at the very beginning of each test to have the
> expected
> behavior. AFAIU this explains why there is a small window where traced
> applications
> can generate events when none are expected.
>
> Fixing this should solve the issues without requiring any addition to the
> test
> program.
>
> Thanks,
>
> Mathieu
>
> >
> > Signed-off-by: Anders Wallin <wallinux@gmail.com>
> > ---
> > tests/regression/tools/tracker/test_event_tracker | 15 ++++++---------
> > 1 file changed, 6 insertions(+), 9 deletions(-)
> >
> > diff --git a/tests/regression/tools/tracker/test_event_tracker
> > b/tests/regression/tools/tracker/test_event_tracker
> > index 711690af..78e9310b 100755
> > --- a/tests/regression/tools/tracker/test_event_tracker
> > +++ b/tests/regression/tools/tracker/test_event_tracker
> > @@ -5,7 +5,7 @@
> > #
> > # SPDX-License-Identifier: GPL-2.0-only
> >
> > -TEST_DESC="LTTng - Event traker test"
> > +TEST_DESC="LTTng - Event tracker test"
> >
> > CURDIR=$(dirname "$0")/
> > TESTDIR="$CURDIR/../../.."
> > @@ -30,27 +30,24 @@ SCRIPT_GROUPNAME="$(id -gn)"
> >
> > CHILD_PID=-1
> > WAIT_PATH=
> > -AFTER_FIRST_PATH=
> > -BEFORE_LAST_PATH=
> > +BEFORE_FIRST_PATH=
> >
> > source $TESTDIR/utils/utils.sh
> >
> > function prepare_ust_app
> > {
> > -     AFTER_FIRST_PATH=$(mktemp -u)
> > -     BEFORE_LAST_PATH=$(mktemp -u)
> > +     BEFORE_FIRST_PATH=$(mktemp -u)
> >
> > -     $TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT -a "$AFTER_FIRST_PATH" -b
> > "$BEFORE_LAST_PATH" &
> > +     $TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT --sync-before-first-event
> > "$BEFORE_FIRST_PATH" &
> >       CHILD_PID=$!
> > }
> >
> > function trace_ust_app
> > {
> > -     touch "$BEFORE_LAST_PATH"
> > +     touch "$BEFORE_FIRST_PATH"
> >       wait
> >       ok $? "Traced application stopped."
> > -     rm "$BEFORE_LAST_PATH"
> > -     rm "$AFTER_FIRST_PATH"
> > +     rm "$BEFORE_FIRST_PATH"
> > }
> >
> > function prepare_kernel_app
> > --
> > 2.31.1
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--00000000000023b5a105bf7296ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">OK,=C2=A0<br><br>I tried this and for=C2=A0<br>- test_even=
t_vpid_track_untrack ust 0 &quot;${EVENT_NAME}&quot;<br>- test_event_pid_tr=
ack_untrack ust 0 &quot;${EVENT_NAME}&quot;<div>it works well.<br><br>For=
=C2=A0<br>- test_event_vpid_tracker ust 0 &quot;${EVENT_NAME}&quot;<br>- te=
st_event_pid_tracker ust 0 &quot;${EVENT_NAME}&quot;<br>validate_trace_empt=
y fails since there is no data at all in the trace_path<br><br>This run is =
just calling copy of test_event_tracker running only=C2=A0 &quot;test_event=
_vpid_tracker ust 0 ...&quot;</div><div>1..747<br># LTTng - Event tracker t=
est<br>ok 1 - Start session daemon<br># Test UST tracker<br>ok 2 - Create s=
ession tracker in -o /tmp/tmp.lu5aeCJhQ3<br>ok 3 - Enable ust event tp:tpte=
st for session tracker<br>ok 4 - Untrack command with opts: -u --all --vpid=
<br>ok 5 - Start tracing for session <br>ok 6 - Track command with opts: -u=
 --vpid 11842<br>ok 7 - Traced application stopped.<br>ok 8 - Stop lttng tr=
acing for session <br>ok 9 - Destroy session tracker<br><b>not ok 10 - Fail=
ed to parse trace<br># =C2=A0 Failed test &#39;Failed to parse trace&#39;<b=
r></b># =C2=A0 in ./regression/tools/tracker//../../../utils/tap/tap.sh:fai=
l() at line 159.<br># Killing (signal SIGTERM) lttng-sessiond and lt-lttng-=
sessiond pids: 11808 11809 11830 <br>ok 11 - Wait after kill session daemon=
<br># Looks like you planned 747 tests but only ran 11.<br># Looks like you=
 failed 1 test of 11.<br><br># find /tmp/tmp.lu5aeCJhQ3<br>/tmp/tmp.lu5aeCJ=
hQ3<br>/tmp/tmp.lu5aeCJhQ3/ust<br><br>Do you want me to add a special versi=
on of &quot;validate_trace_empty&quot; not returning=C2=A0<br>&quot;Failed =
to parse trace&quot; for this? If so should it be added in &quot;test_event=
_tracker&quot; or in &quot;utils.sh&quot;</div><div><br><div><div dir=3D"lt=
r" class=3D"gmail_signature" data-smartmail=3D"gmail_signature">Anders Wall=
in</div></div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Apr 7, 2021 at 5:31 PM Mathieu Desnoyers &l=
t;<a href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@effic=
ios.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">----- On Apr 1, 2021, at 12:37 PM, lttng-dev <a href=3D"mailto:lttng=
-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a> wrote=
:<br>
<br>
&gt; the following tests fails<br>
&gt; - test_event_vpid_tracker ust 0 &quot;${EVENT_NAME}&quot;<br>
&gt; - test_event_vpid_track_untrack ust 0 &quot;${EVENT_NAME}&quot;<br>
&gt; - test_event_pid_tracker ust 0 &quot;${EVENT_NAME}&quot;<br>
&gt; - test_event_pid_track_untrack ust 0 &quot;${EVENT_NAME}&quot;<br>
<br>
There is indeed an issue with these tests: there is a missing &quot;untrack=
 all pids&quot;<br>
which should be done at the very beginning of each test to have the expecte=
d<br>
behavior. AFAIU this explains why there is a small window where traced appl=
ications<br>
can generate events when none are expected.<br>
<br>
Fixing this should solve the issues without requiring any addition to the t=
est<br>
program.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
&gt; <br>
&gt; Signed-off-by: Anders Wallin &lt;<a href=3D"mailto:wallinux@gmail.com"=
 target=3D"_blank">wallinux@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; tests/regression/tools/tracker/test_event_tracker | 15 ++++++---------=
<br>
&gt; 1 file changed, 6 insertions(+), 9 deletions(-)<br>
&gt; <br>
&gt; diff --git a/tests/regression/tools/tracker/test_event_tracker<br>
&gt; b/tests/regression/tools/tracker/test_event_tracker<br>
&gt; index 711690af..78e9310b 100755<br>
&gt; --- a/tests/regression/tools/tracker/test_event_tracker<br>
&gt; +++ b/tests/regression/tools/tracker/test_event_tracker<br>
&gt; @@ -5,7 +5,7 @@<br>
&gt; #<br>
&gt; # SPDX-License-Identifier: GPL-2.0-only<br>
&gt; <br>
&gt; -TEST_DESC=3D&quot;LTTng - Event traker test&quot;<br>
&gt; +TEST_DESC=3D&quot;LTTng - Event tracker test&quot;<br>
&gt; <br>
&gt; CURDIR=3D$(dirname &quot;$0&quot;)/<br>
&gt; TESTDIR=3D&quot;$CURDIR/../../..&quot;<br>
&gt; @@ -30,27 +30,24 @@ SCRIPT_GROUPNAME=3D&quot;$(id -gn)&quot;<br>
&gt; <br>
&gt; CHILD_PID=3D-1<br>
&gt; WAIT_PATH=3D<br>
&gt; -AFTER_FIRST_PATH=3D<br>
&gt; -BEFORE_LAST_PATH=3D<br>
&gt; +BEFORE_FIRST_PATH=3D<br>
&gt; <br>
&gt; source $TESTDIR/utils/utils.sh<br>
&gt; <br>
&gt; function prepare_ust_app<br>
&gt; {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0AFTER_FIRST_PATH=3D$(mktemp -u)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0BEFORE_LAST_PATH=3D$(mktemp -u)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0BEFORE_FIRST_PATH=3D$(mktemp -u)<br>
&gt; <br>
&gt; -=C2=A0 =C2=A0 =C2=A0$TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT -a &quo=
t;$AFTER_FIRST_PATH&quot; -b<br>
&gt; &quot;$BEFORE_LAST_PATH&quot; &amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0$TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT --sync-=
before-first-event<br>
&gt; &quot;$BEFORE_FIRST_PATH&quot; &amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CHILD_PID=3D$!<br>
&gt; }<br>
&gt; <br>
&gt; function trace_ust_app<br>
&gt; {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0touch &quot;$BEFORE_LAST_PATH&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0touch &quot;$BEFORE_FIRST_PATH&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0wait<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ok $? &quot;Traced application stopped.&quot=
;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0rm &quot;$BEFORE_LAST_PATH&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0rm &quot;$AFTER_FIRST_PATH&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rm &quot;$BEFORE_FIRST_PATH&quot;<br>
&gt; }<br>
&gt; <br>
&gt; function prepare_kernel_app<br>
&gt; --<br>
&gt; 2.31.1<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
</blockquote></div>

--00000000000023b5a105bf7296ea--

--===============5988245791924115098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5988245791924115098==--
