Return-Path: <SRS0=+4ah=JF=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92797C433ED
	for <lttng-dev@archiver.kernel.org>; Thu,  8 Apr 2021 15:48:17 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91DD761107
	for <lttng-dev@archiver.kernel.org>; Thu,  8 Apr 2021 15:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DD761107
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FGQdp5WV4z159F;
	Thu,  8 Apr 2021 11:48:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617896895;
	bh=ciWFLzfs2mF0OlRiAnLQanlXbf4+qNDDHt6DHxwNG1E=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=L5SjbKLGchcrYiNNTcM3uYklCUkqZwI5BGx9gSvyHiDxNpZ3pwHFJCJsBy80+wV9k
	 iTvUey9WcrBAwkIS9S7/W7kFRZjf7ZStt+GgVqeamLXiJRmRx9OJyBgIGeRdzO5z2U
	 Td6uazJy3JajZGB6rI8BzQyetqu1G3jckMwPlwiabZRfktGbDOw8JJMDseothQxs7P
	 c5Jn/721oT3HvRrikO2QI3U+tMwQUB65PbL754Q38apI0ioQgLdkwykSkT5kyF+e7n
	 t8cIh0/xHh4H0xm3hlxkpPkcviWNwgSQ4Jbz0qFp3i3J1seKpMfadguuI0rrCTyyKH
	 wBXHbCNsEZZDA==
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 by lists.lttng.org (Postfix) with ESMTPS id 4FGQdm5KLMz14pq
 for <lttng-dev@lists.lttng.org>; Thu,  8 Apr 2021 11:48:12 -0400 (EDT)
Received: by mail-il1-x12c.google.com with SMTP id c3so2197614ils.2
 for <lttng-dev@lists.lttng.org>; Thu, 08 Apr 2021 08:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oelIagvCt1TDQ/lqySo0oajNHziyn/GB0GzRZntqX9w=;
 b=LYs/joidgFvRTZuCacG57EP18fa6fFc6eFWTbcE3vR0yoW+FhIAX3Cjmi4PPnfWBvg
 VouEMgD1swzGDrdebNwEGyQ91x0Mx5O9QW3ormryWiEBRxLFBLkCxlNaDWxFTji3/OWi
 ooaukCFtAKfO3w2rlp3bMH1VjrgX4ALaXVjbL1R5qR7Y9ZSLHyhGMYCEqHQ/HRgMII8k
 AwrIsoqqAjiwchiB54/q/CZupmsKxenH9Qj2tgpeW0tk7OnVTidy7yH5uaVM1NDtWJeK
 AhKQLgZ2DdqrLBh+bFYQmg8JuH+3uAaMA66t79kbI3cvZr4g5qAvifHRGQTrT7yF09h4
 Q6hw==
X-Gm-Message-State: AOAM5316UnZ+95oofp3jexwKl0GAdPb7SK7/pK7W2/HaJbFnzBektqSj
 aWBqETP3cxCD5lh32zNcwnY+WW1YEKtdzHrOKOI=
X-Google-Smtp-Source: ABdhPJzDfk9G35wYYHeJ/C4UeXTxh/cPUPzElKI/NiC4pPAKlW0Wn6eHgPqZt/ipZG0mRn/1WlSTqWQQjODykheUyoI=
X-Received: by 2002:a05:6e02:1584:: with SMTP id
 m4mr7607173ilu.108.1617896891923; 
 Thu, 08 Apr 2021 08:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210401163710.839365-1-wallinux@gmail.com>
 <667805472.60438.1617809506670.JavaMail.zimbra@efficios.com>
 <CAF2baFcBgU+GH_yh5khVki1KHT8on90vNvPgnQxiWM6pwTbsLQ@mail.gmail.com>
 <621616245.61369.1617886095197.JavaMail.zimbra@efficios.com>
In-Reply-To: <621616245.61369.1617886095197.JavaMail.zimbra@efficios.com>
Date: Thu, 8 Apr 2021 17:47:59 +0200
Message-ID: <CAF2baFfb3K7KXsOjGA=B0EVmNga5LcJxdvAh_vhN9wKSpsZn8g@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============7679738367301868487=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============7679738367301868487==
Content-Type: multipart/alternative; boundary="00000000000086cef405bf77f990"

--00000000000086cef405bf77f990
Content-Type: text/plain; charset="UTF-8"

Is it OK that validate_trace_session_ust_empty
and validate_trace_session_kernel_empty calls different functions?
Or is it cp/paste error?

function validate_trace_session_ust_empty()
{
validate_directory_empty "$1"/ust
}

function validate_trace_session_kernel_empty()
{
* validate_trace_empty "$1"/kernel*
}

Anders Wallin


On Thu, Apr 8, 2021 at 2:48 PM Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

>
>
> ----- On Apr 8, 2021, at 5:22 AM, Anders Wallin <wallinux@gmail.com>
> wrote:
>
> OK,
>
> I tried this and for
> - test_event_vpid_track_untrack ust 0 "${EVENT_NAME}"
> - test_event_pid_track_untrack ust 0 "${EVENT_NAME}"
> it works well.
>
> For
> - test_event_vpid_tracker ust 0 "${EVENT_NAME}"
> - test_event_pid_tracker ust 0 "${EVENT_NAME}"
> validate_trace_empty fails since there is no data at all in the trace_path
>
> This run is just calling copy of test_event_tracker running only
> "test_event_vpid_tracker ust 0 ..."
> 1..747
> # LTTng - Event tracker test
> ok 1 - Start session daemon
> # Test UST tracker
> ok 2 - Create session tracker in -o /tmp/tmp.lu5aeCJhQ3
> ok 3 - Enable ust event tp:tptest for session tracker
> ok 4 - Untrack command with opts: -u --all --vpid
> ok 5 - Start tracing for session
> ok 6 - Track command with opts: -u --vpid 11842
> ok 7 - Traced application stopped.
> ok 8 - Stop lttng tracing for session
> ok 9 - Destroy session tracker
>
>
> *not ok 10 - Failed to parse trace#   Failed test 'Failed to parse trace'*#
>   in ./regression/tools/tracker//../../../utils/tap/tap.sh:fail() at line
> 159.
> # Killing (signal SIGTERM) lttng-sessiond and lt-lttng-sessiond pids:
> 11808 11809 11830
> ok 11 - Wait after kill session daemon
> # Looks like you planned 747 tests but only ran 11.
> # Looks like you failed 1 test of 11.
>
> # find /tmp/tmp.lu5aeCJhQ3
> /tmp/tmp.lu5aeCJhQ3
> /tmp/tmp.lu5aeCJhQ3/ust
>
> Do you want me to add a special version of "validate_trace_empty" not
> returning
> "Failed to parse trace" for this? If so should it be added in
> "test_event_tracker" or in "utils.sh"
>
> Actually, this helper already exists in utils.sh:
> validate_trace_session_ust_empty (), which
> internally uses validate_directory_empty (). As you point out, we should
> use
> validate_trace_session_ust_empty for the validation of those test cases
> which populate no
> trace whatsoever.
>
> Thanks,
>
> Mathieu
>
>
> Anders Wallin
>
>
> On Wed, Apr 7, 2021 at 5:31 PM Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
>
>> ----- On Apr 1, 2021, at 12:37 PM, lttng-dev lttng-dev@lists.lttng.org
>> wrote:
>>
>> > the following tests fails
>> > - test_event_vpid_tracker ust 0 "${EVENT_NAME}"
>> > - test_event_vpid_track_untrack ust 0 "${EVENT_NAME}"
>> > - test_event_pid_tracker ust 0 "${EVENT_NAME}"
>> > - test_event_pid_track_untrack ust 0 "${EVENT_NAME}"
>>
>> There is indeed an issue with these tests: there is a missing "untrack
>> all pids"
>> which should be done at the very beginning of each test to have the
>> expected
>> behavior. AFAIU this explains why there is a small window where traced
>> applications
>> can generate events when none are expected.
>>
>> Fixing this should solve the issues without requiring any addition to the
>> test
>> program.
>>
>> Thanks,
>>
>> Mathieu
>>
>> >
>> > Signed-off-by: Anders Wallin <wallinux@gmail.com>
>> > ---
>> > tests/regression/tools/tracker/test_event_tracker | 15 ++++++---------
>> > 1 file changed, 6 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/tests/regression/tools/tracker/test_event_tracker
>> > b/tests/regression/tools/tracker/test_event_tracker
>> > index 711690af..78e9310b 100755
>> > --- a/tests/regression/tools/tracker/test_event_tracker
>> > +++ b/tests/regression/tools/tracker/test_event_tracker
>> > @@ -5,7 +5,7 @@
>> > #
>> > # SPDX-License-Identifier: GPL-2.0-only
>> >
>> > -TEST_DESC="LTTng - Event traker test"
>> > +TEST_DESC="LTTng - Event tracker test"
>> >
>> > CURDIR=$(dirname "$0")/
>> > TESTDIR="$CURDIR/../../.."
>> > @@ -30,27 +30,24 @@ SCRIPT_GROUPNAME="$(id -gn)"
>> >
>> > CHILD_PID=-1
>> > WAIT_PATH=
>> > -AFTER_FIRST_PATH=
>> > -BEFORE_LAST_PATH=
>> > +BEFORE_FIRST_PATH=
>> >
>> > source $TESTDIR/utils/utils.sh
>> >
>> > function prepare_ust_app
>> > {
>> > -     AFTER_FIRST_PATH=$(mktemp -u)
>> > -     BEFORE_LAST_PATH=$(mktemp -u)
>> > +     BEFORE_FIRST_PATH=$(mktemp -u)
>> >
>> > -     $TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT -a "$AFTER_FIRST_PATH"
>> -b
>> > "$BEFORE_LAST_PATH" &
>> > +     $TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT
>> --sync-before-first-event
>> > "$BEFORE_FIRST_PATH" &
>> >       CHILD_PID=$!
>> > }
>> >
>> > function trace_ust_app
>> > {
>> > -     touch "$BEFORE_LAST_PATH"
>> > +     touch "$BEFORE_FIRST_PATH"
>> >       wait
>> >       ok $? "Traced application stopped."
>> > -     rm "$BEFORE_LAST_PATH"
>> > -     rm "$AFTER_FIRST_PATH"
>> > +     rm "$BEFORE_FIRST_PATH"
>> > }
>> >
>> > function prepare_kernel_app
>> > --
>> > 2.31.1
>> >
>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
>> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--00000000000086cef405bf77f990
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Is it OK that=C2=A0validate_trace_session_ust_empty and=C2=
=A0validate_trace_session_kernel_empty calls different functions?<br>Or is =
it cp/paste error?<br><div><br><div>function validate_trace_session_ust_emp=
ty()<br>{<br>	validate_directory_empty &quot;$1&quot;/ust<br>}<br><br>funct=
ion validate_trace_session_kernel_empty()<br>{<br><b>	validate_trace_empty =
&quot;$1&quot;/kernel</b><br>}<br></div><div><br clear=3D"all"><div><div di=
r=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature">Ande=
rs Wallin</div></div><br></div></div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 8, 2021 at 2:48 PM Mathieu=
 Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.de=
snoyers@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div><div style=3D"font-family:arial,helvetica,sans-ser=
if;font-size:12pt;color:rgb(0,0,0)"><div><br></div><div><br></div><div><spa=
n id=3D"gmail-m_7824559687202563702zwchr">----- On Apr 8, 2021, at 5:22 AM,=
 Anders Wallin &lt;<a href=3D"mailto:wallinux@gmail.com" target=3D"_blank">=
wallinux@gmail.com</a>&gt; wrote:<br></span></div><div><blockquote style=3D=
"border-left:2px solid rgb(16,16,255);margin-left:5px;padding-left:5px;colo=
r:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr">OK,=C2=
=A0<br><br>I tried this and for=C2=A0<br>- test_event_vpid_track_untrack us=
t 0 &quot;${EVENT_NAME}&quot;<br>- test_event_pid_track_untrack ust 0 &quot=
;${EVENT_NAME}&quot;<div>it works well.<br><br>For=C2=A0<br>- test_event_vp=
id_tracker ust 0 &quot;${EVENT_NAME}&quot;<br>- test_event_pid_tracker ust =
0 &quot;${EVENT_NAME}&quot;<br>validate_trace_empty fails since there is no=
 data at all in the trace_path<br><br>This run is just calling copy of test=
_event_tracker running only=C2=A0 &quot;test_event_vpid_tracker ust 0 ...&q=
uot;</div><div>1..747<br># LTTng - Event tracker test<br>ok 1 - Start sessi=
on daemon<br># Test UST tracker<br>ok 2 - Create session tracker in -o /tmp=
/tmp.lu5aeCJhQ3<br>ok 3 - Enable ust event tp:tptest for session tracker<br=
>ok 4 - Untrack command with opts: -u --all --vpid<br>ok 5 - Start tracing =
for session <br>ok 6 - Track command with opts: -u --vpid 11842<br>ok 7 - T=
raced application stopped.<br>ok 8 - Stop lttng tracing for session <br>ok =
9 - Destroy session tracker<br><b>not ok 10 - Failed to parse trace<br># =
=C2=A0 Failed test &#39;Failed to parse trace&#39;<br></b># =C2=A0 in ./reg=
ression/tools/tracker//../../../utils/tap/tap.sh:fail() at line 159.<br># K=
illing (signal SIGTERM) lttng-sessiond and lt-lttng-sessiond pids: 11808 11=
809 11830 <br>ok 11 - Wait after kill session daemon<br># Looks like you pl=
anned 747 tests but only ran 11.<br># Looks like you failed 1 test of 11.<b=
r><br># find /tmp/tmp.lu5aeCJhQ3<br>/tmp/tmp.lu5aeCJhQ3<br>/tmp/tmp.lu5aeCJ=
hQ3/ust<br><br>Do you want me to add a special version of &quot;validate_tr=
ace_empty&quot; not returning=C2=A0<br>&quot;Failed to parse trace&quot; fo=
r this? If so should it be added in &quot;test_event_tracker&quot; or in &q=
uot;utils.sh&quot;</div></div></blockquote><div>Actually, this helper alrea=
dy exists in utils.sh: validate_trace_session_ust_empty (), which<br></div>=
<div>internally uses validate_directory_empty (). As you point out, we shou=
ld use</div><div>validate_trace_session_ust_empty for the validation of tho=
se test cases which populate no</div><div>trace whatsoever.<br></div><div><=
br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div><b=
r></div><blockquote style=3D"border-left:2px solid rgb(16,16,255);margin-le=
ft:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:norm=
al;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12=
pt"><div dir=3D"ltr"><div><br><div><div dir=3D"ltr">Anders Wallin</div></di=
v><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Wed, Apr 7, 2021 at 5:31 PM Mathieu Desnoyers &lt;<a href=3D=
"mailto:mathieu.desnoyers@efficios.com" rel=3D"nofollow noopener noreferrer=
" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">----- On Apr 1, 2021, at =
12:37 PM, lttng-dev <a href=3D"mailto:lttng-dev@lists.lttng.org" rel=3D"nof=
ollow noopener noreferrer" target=3D"_blank">lttng-dev@lists.lttng.org</a> =
wrote:<br>
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
 rel=3D"nofollow noopener noreferrer" target=3D"_blank">wallinux@gmail.com<=
/a>&gt;<br>
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
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" rel=3D"nofollow noopener =
noreferrer" target=3D"_blank">lttng-dev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer nofollow noopener noreferrer" target=3D"_blank">https://=
lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer nofollow noopener nor=
eferrer" target=3D"_blank">http://www.efficios.com</a><br>
</blockquote></div><br></blockquote></div><div><br></div><div>-- <br></div>=
<div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.c=
om" target=3D"_blank">http://www.efficios.com</a></div></div></div></blockq=
uote></div>

--00000000000086cef405bf77f990--

--===============7679738367301868487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7679738367301868487==--
