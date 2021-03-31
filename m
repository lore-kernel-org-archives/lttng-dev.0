Return-Path: <SRS0=91P6=I5=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9035AC433B4
	for <lttng-dev@archiver.kernel.org>; Wed, 31 Mar 2021 21:09:58 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CF461056
	for <lttng-dev@archiver.kernel.org>; Wed, 31 Mar 2021 21:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CF461056
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F9f8h2H7jzS2R;
	Wed, 31 Mar 2021 17:09:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617224996;
	bh=k31TO0xWGa/5YfeblW+YdhSxK4JL+RIAaxWO6cJ3AJk=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=VDkNh1RunB5Pqws6qmKN1RE+hoWEKtpcfIsm/6h3pDEmgS6VfY9LSCOU+Y7s/Qne0
	 FG2gRvFOPEhNMX9JnDAh4ReTbDi4nwTVDiiCqnFxFfLWhgfC0xNnjlzDri9inQFHs/
	 +BhOMCb3/sO+L6o4xpcQnvLLogfmUCASsQRCY2eQb+lYEvj1eOocMXnky5oMguzw2p
	 nWKjB9G8BEgkBisy5ki985XV4wYGBy/Mc2MCmBfHgjcHWSbBVkPpCjf4H3GUgMFdxE
	 r1CjmnJb83ExYHEapCm+aE68pMkLCWATcWK7ovKUEBpBWIAWc48l+UDd6Ie43ZfOcE
	 19UiPLZmy9qRQ==
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 by lists.lttng.org (Postfix) with ESMTPS id 4F9f8f4TrmzSVf
 for <lttng-dev@lists.lttng.org>; Wed, 31 Mar 2021 17:09:54 -0400 (EDT)
Received: by mail-io1-xd35.google.com with SMTP id x17so29862iog.2
 for <lttng-dev@lists.lttng.org>; Wed, 31 Mar 2021 14:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YmpiAgI+TPQq7G07LHQG2Xw6HTTqy0p1KhTCATmjjcc=;
 b=R3zeH+jRZZkSZQ/khbTiUR24utNCWfz6vtC0jATi4MpJJ5xxZSEuF4BZh2yTKH+m6i
 WK6Ud3V01s+ibcSrTW3jCoHQsmK7MqKbuqV/IjP9/f9XJt3xVgfEsYj9eHzA2DHcVrBP
 Ai9rmG35lMQpE/eNN+ymRDVb9nre0ZLw0m9MxZyfykfueM/q91e2xZpoLEMZK7JxoeMn
 EIZNyPwnJqSB8dzBXQ51sP3pfPvZYmWB2RQT1dTKL+OLoZURXWSWW1JESNYpNQwJMjxi
 J3hFID69ksSmDaXzEagpZeVYONgNqAVH9oZ1qMmmWKNHuacrl7RlzCTH2D4m2YghoHKm
 ppYQ==
X-Gm-Message-State: AOAM531fXXWzrmrv3XpvHdJTFpat4dhnIQtt4j/QEkhxiIGj1fM8zPqz
 8tawD2ho0tHCm+U6cJf6j6wi1umzsh0cOLOLNXc=
X-Google-Smtp-Source: ABdhPJwO8oVRympS2jXVvjig06dspCVGzMtPwXBpWRSUAAVwFeawdndYQG9kIZg7VslUaPumVrsIxz2Ennq9dM5FoKc=
X-Received: by 2002:a05:6602:1649:: with SMTP id
 y9mr3770526iow.209.1617224993728; 
 Wed, 31 Mar 2021 14:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210331185624.406960-1-wallinux@gmail.com>
 <592114658.48857.1617218709305.JavaMail.zimbra@efficios.com>
In-Reply-To: <592114658.48857.1617218709305.JavaMail.zimbra@efficios.com>
Date: Wed, 31 Mar 2021 23:09:42 +0200
Message-ID: <CAF2baFdV51rF5jAU5Ru4Y3OuTOJFMCuA=AZrBBDxkHRH_3JPSQ@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============3019637437881028589=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3019637437881028589==
Content-Type: multipart/alternative; boundary="00000000000045f89805bedb89e3"

--00000000000045f89805bedb89e3
Content-Type: text/plain; charset="UTF-8"

Hi Julian,

Neither mine "sleep 0.1" or your version with "while [! -f ............"
are race condition free.
I suggest that we add an option to gen-ust-events to wait before the first
event is generated.
gen_kernel_test_events already have this functionality to wait before the
first event.

Something like this
static struct option long_options[] =
{
/* These options set a flag. */
{"iter", required_argument, 0, 'i'},
{"wait", required_argument, 0, 'w'},
{"sync-after-first-event", required_argument, 0, 'a'},
{"sync-before-last-event", required_argument, 0, 'b'},
{"sync-before-last-event-touch", required_argument, 0, 'c'},
{"sync-before-exit", required_argument, 0, 'd'},
{"sync-before-exit-touch", required_argument, 0, 'e'},
*+ {"sync-before-first-event", required_argument, 0, 'f'},*

{0, 0, 0, 0}
};
....

I will create one or more patches for this tomorrow

Anders Wallin


On Wed, Mar 31, 2021 at 9:25 PM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> > #
> > # SPDX-License-Identifier: GPL-2.0-only
> >
> > -TEST_DESC="LTTng - Event traker test"
> > +TEST_DESC="LTTng - Event tracker test"
> >
> > CURDIR=$(dirname "$0")/
> > TESTDIR="$CURDIR/../../.."
> > @@ -42,6 +42,8 @@ function prepare_ust_app
> >
> >       $TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT -a "$AFTER_FIRST_PATH" -b
> >       "$BEFORE_LAST_PATH" &
> >       CHILD_PID=$!
> > +     # voluntary context switch to start $TESTAPP_BIN
> > +     sleep 0.1
>
> A wait on the $AFTER_FIRST_PATH file would be probably more deterministic
> than a sleep here.
>
>   while [ ! -f "${AFTER_FIRST_PATH}" ]; do
>           sleep 0.1
>   done
>
> I would also expect something similar for the `prepare_kernel_app`
> function considering the same race is most probably present and simply not
> triggered by a chance of luck.
> Seems like gen-kernel-test-events does not expose the same sync
> capabilities here, please use gen-ust-events as an example of how it is
> done.
>
> Let us know how your testing goes.
>
> Thanks
>

--00000000000045f89805bedb89e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Julian,<div><br></div><div>Neither min=
e &quot;sleep 0.1&quot; or your version with &quot;while [! -f ............=
&quot; are race condition free.</div><div>I suggest that we add an option t=
o gen-ust-events to wait before the first event is generated.<br>gen_kernel=
_test_events already have this functionality=C2=A0to wait before the first =
event.<br><br></div><div>Something like this</div><div><font face=3D"monosp=
ace">static struct option long_options[] =3D<br>{<br>	/* These options set =
a flag. */<br>	{&quot;iter&quot;, required_argument, 0, &#39;i&#39;},<br>	{=
&quot;wait&quot;, required_argument, 0, &#39;w&#39;},<br>	{&quot;sync-after=
-first-event&quot;, required_argument, 0, &#39;a&#39;},<br>	{&quot;sync-bef=
ore-last-event&quot;, required_argument, 0, &#39;b&#39;},<br>	{&quot;sync-b=
efore-last-event-touch&quot;, required_argument, 0, &#39;c&#39;},<br>	{&quo=
t;sync-before-exit&quot;, required_argument, 0, &#39;d&#39;},<br>	{&quot;sy=
nc-before-exit-touch&quot;, required_argument, 0, &#39;e&#39;},</font></div=
><div><b><font face=3D"monospace">+ {&quot;sync-before-first-event&quot;, r=
equired_argument, 0, &#39;f&#39;},</font></b></div><div></div><div><font fa=
ce=3D"monospace">=C2=A0<br>	{0, 0, 0, 0}<br>};</font></div><div><font face=
=3D"monospace">....<br></font><br></div><div>I will create one or more patc=
hes for this tomorrow</div><div>=C2=A0</div><div><div><div dir=3D"ltr" clas=
s=3D"gmail_signature" data-smartmail=3D"gmail_signature">Anders Wallin</div=
></div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Wed, Mar 31, 2021 at 9:25 PM Jonathan Rajotte-Julien &l=
t;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com">jonathan.rajotte-=
julien@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">&gt; #<br>
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
A wait on the $AFTER_FIRST_PATH file would be probably more deterministic t=
han a sleep here.<br>
<br>
=C2=A0 while [ ! -f &quot;${AFTER_FIRST_PATH}&quot; ]; do<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep 0.1<br>
=C2=A0 done<br>
<br>
I would also expect something similar for the `prepare_kernel_app` function=
 considering the same race is most probably present and simply not triggere=
d by a chance of luck.<br>
Seems like gen-kernel-test-events does not expose the same sync capabilitie=
s here, please use gen-ust-events as an example of how it is done.<br>
<br>
Let us know how your testing goes.<br>
<br>
Thanks<br>
</blockquote></div></div>

--00000000000045f89805bedb89e3--

--===============3019637437881028589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3019637437881028589==--
