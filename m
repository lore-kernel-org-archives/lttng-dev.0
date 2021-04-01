Return-Path: <SRS0=VMqU=I6=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261B9C433B4
	for <lttng-dev@archiver.kernel.org>; Thu,  1 Apr 2021 16:33:55 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71ADE61379
	for <lttng-dev@archiver.kernel.org>; Thu,  1 Apr 2021 16:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71ADE61379
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FB7zj1XySzSgj;
	Thu,  1 Apr 2021 12:33:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617294833;
	bh=f/EQsBHmsDz+sFymaRHsuKxi2cLsdPNZS2yC6tcWzTs=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=LycYW1+9EmtgcvpVR42wG1ZK0JjC8K6Rv5Foy99kKhvcII1pBr/iN0hSbTfoGw9Tc
	 5reLwVUJmMCxGG62oBc3Y4oZB6bWXZ8RGqA6QdjSiiWWY6x7ugKn4+vh1nYOkqRdeI
	 v4igz8vB2CGOGHHQZaNXS3ptxbkXWky3QANmrKkTZy6bAFlhIwxHaNmCsItVp4Z7JL
	 X5+v9mRLRsgllX1LNCz/Q+ffmMQXLbb6uI0GHn9PIRqW7/zWlIoSIKSgojKVAPagJ9
	 8fybrsSnQKS5CY5g1hf4awqB4hqiUh5YWKEdk4QsCzXS1qyl5AdYZt16ULLoIFiDCl
	 O0UvuMLG0O/eA==
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 by lists.lttng.org (Postfix) with ESMTPS id 4FB7zg6zVmzSgg
 for <lttng-dev@lists.lttng.org>; Thu,  1 Apr 2021 12:33:51 -0400 (EDT)
Received: by mail-il1-x12d.google.com with SMTP id y17so2535147ila.6
 for <lttng-dev@lists.lttng.org>; Thu, 01 Apr 2021 09:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O/PYBukDRW9UPoHUHoMrgGxv8OOdpBqANwhOvjCfcjc=;
 b=TQhPoN/bTNKkl4zLy9pSZE7qFKTC7by8FMT8IxNLhNSGkJuj0gN2rzjGIaItvyAtaK
 VzjDvFUdoXGq86VQL7wruc/Ux14pf1T8KhSfwfxiFEkchaVLl/oYWmrN5UJeKukFxhwF
 U0JJU/q9vL4kphEKM1Vi/rSNkMHwvFXK8IudKv0H/+TquUAyXkHrxIyHa14WOmnRzo5z
 gF1DqNBKtNjvKgYV5YH5Bh3h1qZ6cYGaSP7QVoK1kTitsz1t8LYk6X7Y8y579bVlMhl0
 4LMr1Fqjpq/AwuZ6GenH1uoIe/4lSsp+PADugXIGZutfwm49GTnvFTyjIKm1J1E5QJHo
 meIg==
X-Gm-Message-State: AOAM530D7W2hylpIy6JaoCq/W7WPm4R5bQ8FThIYA+vBdFohLJ6TiJFQ
 6t38XAsbw1zHAxTQnMQhAgGGpiwWCZOPQF0hj6o=
X-Google-Smtp-Source: ABdhPJxMyVgsgghavJS0+WrHTuJ//AVWEikuRSCQv/ZPBJ+NNCLd0TKxNxOP8eCAL7FRrgSvaHJgoRJu4BLcQ7CYzMk=
X-Received: by 2002:a92:c50c:: with SMTP id r12mr7484444ilg.52.1617294831075; 
 Thu, 01 Apr 2021 09:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210331185624.406960-1-wallinux@gmail.com>
 <1708925974.51224.1617293982339.JavaMail.zimbra@efficios.com>
In-Reply-To: <1708925974.51224.1617293982339.JavaMail.zimbra@efficios.com>
Date: Thu, 1 Apr 2021 18:33:39 +0200
Message-ID: <CAF2baFeqo=55EKV8D0CKiboQjqq8FH+7hSaqYwOomQrhN7u2dw@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>,
 Jeremie Galarneau <jgalar@efficios.com>
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
Content-Type: multipart/mixed; boundary="===============1450711451293562556=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1450711451293562556==
Content-Type: multipart/alternative; boundary="000000000000e745c505beebcb83"

--000000000000e745c505beebcb83
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I agree, new version on the way w/o sleep!
Anders Wallin


On Thu, Apr 1, 2021 at 6:19 PM Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ----- On Mar 31, 2021, at 2:56 PM, lttng-dev lttng-dev@lists.lttng.org
> wrote:
>
> > the following tests fails on arm64
> > - test_event_vpid_tracker ust 0 "${EVENT_NAME}"
> > - test_event_vpid_track_untrack ust 0 "${EVENT_NAME}"
> > - test_event_pid_tracker ust 0 "${EVENT_NAME}"
> > - test_event_pid_track_untrack ust 0 "${EVENT_NAME}"
> >
> > Signed-off-by: Anders Wallin <wallinux@gmail.com>
> > ---
> > tests/regression/tools/tracker/test_event_tracker | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/regression/tools/tracker/test_event_tracker
> > b/tests/regression/tools/tracker/test_event_tracker
> > index 711690af..649c7e61 100755
> > --- a/tests/regression/tools/tracker/test_event_tracker
> > +++ b/tests/regression/tools/tracker/test_event_tracker
> > @@ -5,7 +5,7 @@
> > #
> > # SPDX-License-Identifier: GPL-2.0-only
> >
> > -TEST_DESC=3D"LTTng - Event traker test"
> > +TEST_DESC=3D"LTTng - Event tracker test"
> >
> > CURDIR=3D$(dirname "$0")/
> > TESTDIR=3D"$CURDIR/../../.."
> > @@ -42,6 +42,8 @@ function prepare_ust_app
> >
> >       $TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT -a "$AFTER_FIRST_PATH" =
-b
> >       "$BEFORE_LAST_PATH" &
> >       CHILD_PID=3D$!
> > +     # voluntary context switch to start $TESTAPP_BIN
> > +     sleep 0.1
>
> No, we have been bitten again and again by test issues hidden by sleeps i=
n
> the
> test code. Using sleeps for synchronization is flaky.
>
> I don't know if we documented it, but we as maintainers are strongly
> against
> anything that looks like a delay-based approach to fixing a race in the
> tests.
> This typically just bury the race under the carpet and it shows up only i=
n
> specific conditions on the CI workers.
>
> We need to add proper rendez-vous based synchronization to the test if so=
me
> is missing.
>
> Adding J=C3=A9r=C3=A9mie in CC.
>
> Thanks,
>
> Mathieu
>
>
> > }
> >
> > function trace_ust_app
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

--000000000000e745c505beebcb83
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I agree, new version on the way w/o sleep!=C2=A0<br clear=
=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"=
gmail_signature">Anders Wallin</div></div><br></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 1, 2021 at 6:19 P=
M Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com">m=
athieu.desnoyers@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">----- On Mar 31, 2021, at 2:56 PM, lttng-dev <=
a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lis=
ts.lttng.org</a> wrote:<br>
<br>
&gt; the following tests fails on arm64<br>
&gt; - test_event_vpid_tracker ust 0 &quot;${EVENT_NAME}&quot;<br>
&gt; - test_event_vpid_track_untrack ust 0 &quot;${EVENT_NAME}&quot;<br>
&gt; - test_event_pid_tracker ust 0 &quot;${EVENT_NAME}&quot;<br>
&gt; - test_event_pid_track_untrack ust 0 &quot;${EVENT_NAME}&quot;<br>
&gt; <br>
&gt; Signed-off-by: Anders Wallin &lt;<a href=3D"mailto:wallinux@gmail.com"=
 target=3D"_blank">wallinux@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; tests/regression/tools/tracker/test_event_tracker | 4 +++-<br>
&gt; 1 file changed, 3 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/tests/regression/tools/tracker/test_event_tracker<br>
&gt; b/tests/regression/tools/tracker/test_event_tracker<br>
&gt; index 711690af..649c7e61 100755<br>
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
&gt; @@ -42,6 +42,8 @@ function prepare_ust_app<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT -a=
 &quot;$AFTER_FIRST_PATH&quot; -b<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;$BEFORE_LAST_PATH&quot; &amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CHILD_PID=3D$!<br>
&gt; +=C2=A0 =C2=A0 =C2=A0# voluntary context switch to start $TESTAPP_BIN<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0sleep 0.1<br>
<br>
No, we have been bitten again and again by test issues hidden by sleeps in =
the<br>
test code. Using sleeps for synchronization is flaky.<br>
<br>
I don&#39;t know if we documented it, but we as maintainers are strongly ag=
ainst<br>
anything that looks like a delay-based approach to fixing a race in the tes=
ts.<br>
This typically just bury the race under the carpet and it shows up only in<=
br>
specific conditions on the CI workers.<br>
<br>
We need to add proper rendez-vous based synchronization to the test if some=
<br>
is missing.<br>
<br>
Adding J=C3=A9r=C3=A9mie in CC.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
<br>
&gt; }<br>
&gt; <br>
&gt; function trace_ust_app<br>
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

--000000000000e745c505beebcb83--

--===============1450711451293562556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1450711451293562556==--
