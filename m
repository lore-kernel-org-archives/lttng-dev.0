Return-Path: <SRS0=+4ah=JF=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D42C433ED
	for <lttng-dev@archiver.kernel.org>; Thu,  8 Apr 2021 12:48:27 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 783E461132
	for <lttng-dev@archiver.kernel.org>; Thu,  8 Apr 2021 12:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783E461132
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FGLfJ4R0Qz14k6;
	Thu,  8 Apr 2021 08:48:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617886105;
	bh=7bmxIsmlDWf1MjE0rnXt7mtFOS9yv79lLYV4TbdhcCw=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=N3fr2tqkVniwMCMdEarqufLixkKwZTKKdMI+TOZW0fPTjsfNiRe4+tcU1VK1oFfE9
	 9xbA4QGUtr2IIjKEfWqG1Kp6sDgVE+ZKF8hsll6kUFMa12Hm4pRnL1XWUXVXlVq3xl
	 fxuSfg04flusD7pe8ljADEwGvjcApQ7R0MVQk0Dorcgz23Z1wHuK86A45IV029hDKl
	 3TTnFFsZVTUB7wQsmICZjixC2JRZTk0SjiwJu5WyGGk8/RuIfkzeMEE0KvplxDq08M
	 mu7u8+p8lcc/p8ZJfk7RP2GHXzpz5Bc/XO0EVtq8Vr0WhXWjioz1AvRu06OUzLhPWg
	 f55+Nv6VY+wnw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FGLfG3p1yz14k4
 for <lttng-dev@lists.lttng.org>; Thu,  8 Apr 2021 08:48:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4A47432D8DE
 for <lttng-dev@lists.lttng.org>; Thu,  8 Apr 2021 08:48:16 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ipa8aiTPV6hz; Thu,  8 Apr 2021 08:48:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5111332DC81;
 Thu,  8 Apr 2021 08:48:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5111332DC81
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 2de0a70iW0qP; Thu,  8 Apr 2021 08:48:15 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 4012D32DC80;
 Thu,  8 Apr 2021 08:48:15 -0400 (EDT)
Date: Thu, 8 Apr 2021 08:48:15 -0400 (EDT)
To: Anders Wallin <wallinux@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <621616245.61369.1617886095197.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAF2baFcBgU+GH_yh5khVki1KHT8on90vNvPgnQxiWM6pwTbsLQ@mail.gmail.com>
References: <20210401163710.839365-1-wallinux@gmail.com>
 <667805472.60438.1617809506670.JavaMail.zimbra@efficios.com>
 <CAF2baFcBgU+GH_yh5khVki1KHT8on90vNvPgnQxiWM6pwTbsLQ@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: test code assumes that child process is schedule to run before
 parent
Thread-Index: dfBVxN7iDhIy+/4Lu4kG9/STAcjUjw==
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
Content-Type: multipart/mixed; boundary="===============2221346521783231108=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2221346521783231108==
Content-Type: multipart/alternative; 
	boundary="=_a04325ae-febc-4889-bf9e-34de629ba8bc"

--=_a04325ae-febc-4889-bf9e-34de629ba8bc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Apr 8, 2021, at 5:22 AM, Anders Wallin <wallinux@gmail.com> wrote: 

> OK,

> I tried this and for
> - test_event_vpid_track_untrack ust 0 "${EVENT_NAME}"
> - test_event_pid_track_untrack ust 0 "${EVENT_NAME}"
> it works well.

> For
> - test_event_vpid_tracker ust 0 "${EVENT_NAME}"
> - test_event_pid_tracker ust 0 "${EVENT_NAME}"
> validate_trace_empty fails since there is no data at all in the trace_path

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
> not ok 10 - Failed to parse trace
> # Failed test 'Failed to parse trace'
> # in ./regression/tools/tracker//../../../utils/tap/tap.sh:fail() at line 159.
> # Killing (signal SIGTERM) lttng-sessiond and lt-lttng-sessiond pids: 11808
> 11809 11830
> ok 11 - Wait after kill session daemon
> # Looks like you planned 747 tests but only ran 11.
> # Looks like you failed 1 test of 11.

> # find /tmp/tmp.lu5aeCJhQ3
> /tmp/tmp.lu5aeCJhQ3
> /tmp/tmp.lu5aeCJhQ3/ust

> Do you want me to add a special version of "validate_trace_empty" not returning
> "Failed to parse trace" for this? If so should it be added in
> "test_event_tracker" or in "utils.sh"

Actually, this helper already exists in utils.sh: validate_trace_session_ust_empty (), which 
internally uses validate_directory_empty (). As you point out, we should use 
validate_trace_session_ust_empty for the validation of those test cases which populate no 
trace whatsoever. 

Thanks, 

Mathieu 

> Anders Wallin

> On Wed, Apr 7, 2021 at 5:31 PM Mathieu Desnoyers < [
> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
> wrote:

>> ----- On Apr 1, 2021, at 12:37 PM, lttng-dev [ mailto:lttng-dev@lists.lttng.org
>> | lttng-dev@lists.lttng.org ] wrote:

>> > the following tests fails
>> > - test_event_vpid_tracker ust 0 "${EVENT_NAME}"
>> > - test_event_vpid_track_untrack ust 0 "${EVENT_NAME}"
>> > - test_event_pid_tracker ust 0 "${EVENT_NAME}"
>> > - test_event_pid_track_untrack ust 0 "${EVENT_NAME}"

>> There is indeed an issue with these tests: there is a missing "untrack all pids"
>> which should be done at the very beginning of each test to have the expected
>> behavior. AFAIU this explains why there is a small window where traced
>> applications
>> can generate events when none are expected.

>> Fixing this should solve the issues without requiring any addition to the test
>> program.

>> Thanks,

>> Mathieu


>>> Signed-off-by: Anders Wallin < [ mailto:wallinux@gmail.com | wallinux@gmail.com
>> > ] >
>> > ---
>> > tests/regression/tools/tracker/test_event_tracker | 15 ++++++---------
>> > 1 file changed, 6 insertions(+), 9 deletions(-)

>> > diff --git a/tests/regression/tools/tracker/test_event_tracker
>> > b/tests/regression/tools/tracker/test_event_tracker
>> > index 711690af..78e9310b 100755
>> > --- a/tests/regression/tools/tracker/test_event_tracker
>> > +++ b/tests/regression/tools/tracker/test_event_tracker
>> > @@ -5,7 +5,7 @@
>> > #
>> > # SPDX-License-Identifier: GPL-2.0-only

>> > -TEST_DESC="LTTng - Event traker test"
>> > +TEST_DESC="LTTng - Event tracker test"

>> > CURDIR=$(dirname "$0")/
>> > TESTDIR="$CURDIR/../../.."
>> > @@ -30,27 +30,24 @@ SCRIPT_GROUPNAME="$(id -gn)"

>> > CHILD_PID=-1
>> > WAIT_PATH=
>> > -AFTER_FIRST_PATH=
>> > -BEFORE_LAST_PATH=
>> > +BEFORE_FIRST_PATH=

>> > source $TESTDIR/utils/utils.sh

>> > function prepare_ust_app
>> > {
>> > - AFTER_FIRST_PATH=$(mktemp -u)
>> > - BEFORE_LAST_PATH=$(mktemp -u)
>> > + BEFORE_FIRST_PATH=$(mktemp -u)

>> > - $TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT -a "$AFTER_FIRST_PATH" -b
>> > "$BEFORE_LAST_PATH" &
>> > + $TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT --sync-before-first-event
>> > "$BEFORE_FIRST_PATH" &
>> > CHILD_PID=$!
>> > }

>> > function trace_ust_app
>> > {
>> > - touch "$BEFORE_LAST_PATH"
>> > + touch "$BEFORE_FIRST_PATH"
>> > wait
>> > ok $? "Traced application stopped."
>> > - rm "$BEFORE_LAST_PATH"
>> > - rm "$AFTER_FIRST_PATH"
>> > + rm "$BEFORE_FIRST_PATH"
>> > }

>> > function prepare_kernel_app
>> > --
>> > 2.31.1

>> > _______________________________________________
>> > lttng-dev mailing list
>> > [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> [ http://www.efficios.com/ | http://www.efficios.com ]

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_a04325ae-febc-4889-bf9e-34de629ba8bc
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><div><span id=3D"z=
wchr" data-marker=3D"__DIVIDER__">----- On Apr 8, 2021, at 5:22 AM, Anders =
Wallin &lt;wallinux@gmail.com&gt; wrote:<br></span></div><div data-marker=
=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;mar=
gin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:norm=
al;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12=
pt;"><div dir=3D"ltr">OK,&nbsp;<br><br>I tried this and for&nbsp;<br>- test=
_event_vpid_track_untrack ust 0 "${EVENT_NAME}"<br>- test_event_pid_track_u=
ntrack ust 0 "${EVENT_NAME}"<div>it works well.<br><br>For&nbsp;<br>- test_=
event_vpid_tracker ust 0 "${EVENT_NAME}"<br>- test_event_pid_tracker ust 0 =
"${EVENT_NAME}"<br>validate_trace_empty fails since there is no data at all=
 in the trace_path<br><br>This run is just calling copy of test_event_track=
er running only&nbsp; "test_event_vpid_tracker ust 0 ..."</div><div>1..747<=
br># LTTng - Event tracker test<br>ok 1 - Start session daemon<br># Test US=
T tracker<br>ok 2 - Create session tracker in -o /tmp/tmp.lu5aeCJhQ3<br>ok =
3 - Enable ust event tp:tptest for session tracker<br>ok 4 - Untrack comman=
d with opts: -u --all --vpid<br>ok 5 - Start tracing for session <br>ok 6 -=
 Track command with opts: -u --vpid 11842<br>ok 7 - Traced application stop=
ped.<br>ok 8 - Stop lttng tracing for session <br>ok 9 - Destroy session tr=
acker<br><b>not ok 10 - Failed to parse trace<br># &nbsp; Failed test 'Fail=
ed to parse trace'<br></b># &nbsp; in ./regression/tools/tracker//../../../=
utils/tap/tap.sh:fail() at line 159.<br># Killing (signal SIGTERM) lttng-se=
ssiond and lt-lttng-sessiond pids: 11808 11809 11830 <br>ok 11 - Wait after=
 kill session daemon<br># Looks like you planned 747 tests but only ran 11.=
<br># Looks like you failed 1 test of 11.<br><br># find /tmp/tmp.lu5aeCJhQ3=
<br>/tmp/tmp.lu5aeCJhQ3<br>/tmp/tmp.lu5aeCJhQ3/ust<br><br>Do you want me to=
 add a special version of "validate_trace_empty" not returning&nbsp;<br>"Fa=
iled to parse trace" for this? If so should it be added in "test_event_trac=
ker" or in "utils.sh"</div></div></blockquote><div>Actually, this helper al=
ready exists in utils.sh: validate_trace_session_ust_empty (), which<br></d=
iv><div>internally uses validate_directory_empty (). As you point out, we s=
hould use</div><div>validate_trace_session_ust_empty for the validation of =
those test cases which populate no</div><div>trace whatsoever.<br data-mce-=
bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-=
mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br d=
ata-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote s=
tyle=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;colo=
r:#000;font-weight:normal;font-style:normal;text-decoration:none;font-famil=
y:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div><br><di=
v><div dir=3D"ltr" class=3D"gmail_signature">Anders Wallin</div></div><br><=
/div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Wed, Apr 7, 2021 at 5:31 PM Mathieu Desnoyers &lt;<a href=3D"mailto=
:mathieu.desnoyers@efficios.com" target=3D"_blank" rel=3D"nofollow noopener=
 noreferrer">mathieu.desnoyers@efficios.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb( 204 , 204 , 204 );padding-left:1ex">----- On Apr 1, 2021, at 1=
2:37 PM, lttng-dev <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_=
blank" rel=3D"nofollow noopener noreferrer">lttng-dev@lists.lttng.org</a> w=
rote:<br>
<br>
&gt; the following tests fails<br>
&gt; - test_event_vpid_tracker ust 0 "${EVENT_NAME}"<br>
&gt; - test_event_vpid_track_untrack ust 0 "${EVENT_NAME}"<br>
&gt; - test_event_pid_tracker ust 0 "${EVENT_NAME}"<br>
&gt; - test_event_pid_track_untrack ust 0 "${EVENT_NAME}"<br>
<br>
There is indeed an issue with these tests: there is a missing "untrack all =
pids"<br>
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
 target=3D"_blank" rel=3D"nofollow noopener noreferrer">wallinux@gmail.com<=
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
&gt; -TEST_DESC=3D"LTTng - Event traker test"<br>
&gt; +TEST_DESC=3D"LTTng - Event tracker test"<br>
&gt; <br>
&gt; CURDIR=3D$(dirname "$0")/<br>
&gt; TESTDIR=3D"$CURDIR/../../.."<br>
&gt; @@ -30,27 +30,24 @@ SCRIPT_GROUPNAME=3D"$(id -gn)"<br>
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
&gt; -&nbsp; &nbsp; &nbsp;AFTER_FIRST_PATH=3D$(mktemp -u)<br>
&gt; -&nbsp; &nbsp; &nbsp;BEFORE_LAST_PATH=3D$(mktemp -u)<br>
&gt; +&nbsp; &nbsp; &nbsp;BEFORE_FIRST_PATH=3D$(mktemp -u)<br>
&gt; <br>
&gt; -&nbsp; &nbsp; &nbsp;$TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT -a "$AF=
TER_FIRST_PATH" -b<br>
&gt; "$BEFORE_LAST_PATH" &amp;<br>
&gt; +&nbsp; &nbsp; &nbsp;$TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT --sync-=
before-first-event<br>
&gt; "$BEFORE_FIRST_PATH" &amp;<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp;CHILD_PID=3D$!<br>
&gt; }<br>
&gt; <br>
&gt; function trace_ust_app<br>
&gt; {<br>
&gt; -&nbsp; &nbsp; &nbsp;touch "$BEFORE_LAST_PATH"<br>
&gt; +&nbsp; &nbsp; &nbsp;touch "$BEFORE_FIRST_PATH"<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp;wait<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp;ok $? "Traced application stopped."<br>
&gt; -&nbsp; &nbsp; &nbsp;rm "$BEFORE_LAST_PATH"<br>
&gt; -&nbsp; &nbsp; &nbsp;rm "$AFTER_FIRST_PATH"<br>
&gt; +&nbsp; &nbsp; &nbsp;rm "$BEFORE_FIRST_PATH"<br>
&gt; }<br>
&gt; <br>
&gt; function prepare_kernel_app<br>
&gt; --<br>
&gt; 2.31.1<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank" rel=3D"=
nofollow noopener noreferrer">lttng-dev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer nofollow noopener noreferrer" target=3D"_blank">https://=
lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer nofollow noopener nor=
eferrer" target=3D"_blank">http://www.efficios.com</a><br>
</blockquote></div><br></blockquote></div><div><br></div><div data-marker=
=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>h=
ttp://www.efficios.com</div></div></body></html>
--=_a04325ae-febc-4889-bf9e-34de629ba8bc--

--===============2221346521783231108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2221346521783231108==--
