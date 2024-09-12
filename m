Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82ADEED617
	for <lttng-dev@archiver.kernel.org>; Thu, 12 Sep 2024 16:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1726157672;
	bh=rsPb1kKWgY+VCyO0LZER8/HFC7nrOVEDcnHwKDmSKzw=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=eoj2k4DRFVn+gh48Z9QEiW6435jpMTDWUsrkmLNsOtsPO/E769oQtJrwBQDkLxF/p
	 wqaxfY6uNxNz+ymztme63FQXzOwfgNIpBXcD24Es/bBaowNPtLFX2mPkFZzz73Tv6V
	 h40sk+R1isx2/5I2mhpdshySxXFX+FMfYT37ys+ThyEDGQ9tc/72qptvHDr20pr9tS
	 ksJ199WO76LadR7hczhBXyDUdxPw7Iktq9rvA7FJg8g7mhIcAC4/5cLGLL3a1FKO3l
	 sm4pNZBN4ZCJTys93aCjFoHIJFVYyx3OXAQJ7c8Bnvc6y4C+fZydPq0HrkOWm8eJmW
	 /r1LrUY5foFeA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4X4Mvq6khqz1Gly;
	Thu, 12 Sep 2024 12:14:31 -0400 (EDT)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by lists.lttng.org (Postfix) with ESMTPS id 4X4Mvp6pRnz1Gfq
 for <lttng-dev@lists.lttng.org>; Thu, 12 Sep 2024 12:14:30 -0400 (EDT)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6d3c10af2efso9807257b3.0
 for <lttng-dev@lists.lttng.org>; Thu, 12 Sep 2024 09:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726157670; x=1726762470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sXb085zECfXQgydoZsPx9lUbE7ZKzbfBVyTsWIVx7lo=;
 b=OrBDm4jh8WyLdkHGqUOXHTPxXN2/uHD4ncAcivlZEQnIKw5GfADquoy6JDzmRyPYxH
 2K9UWrIGzzp+RwQgpsXMG3jtsXwF8niaoFxJz3vKKcJ/rr6+EL+YYfXAVByZjQTHt/CL
 T8GtVI+YD0BeJo6lpFZfd5F17IJRpd49DRu118jsU3VbOi+XNpz076BKdfmIqLLe/O8d
 UMEiYf9Xoqaq/XpN27lLKsKHb0RkDFOqowj8/PlFwTtsA3zc6cVaTUW7yaofRt+YNzSU
 OCw/rNM5EWvL0oUvsUf1oht4f2s5B9M4sPqzklixApSVfo2YgpK9FopHPhp/bSd7UhjP
 kr4w==
X-Gm-Message-State: AOJu0YwPFb6pj/Le9mh6S6EqqwGf3amVS3LMJTniipUs6zLitU8bQFN0
 8myArfDZeu9S8iFxWTN07KRXRZdxjSB3GXTTWpitDJfv5g7rkBgqVLgYFFL3Uo9TQwp4RHP6gZs
 /7hd2qBIjiLA6jbb3I5k/wqOTOjlfWfaLq69csA==
X-Google-Smtp-Source: AGHT+IH/qxp+sQgsE/RJ8AKgm8O1+qggBjKwAjq8CrSQOmcZmNs/4xAUsMlJk8Etu9G/Ps+tvlLa42gHSg/MJOofaUE=
X-Received: by 2002:a05:690c:c9b:b0:6ae:e4b8:6a46 with SMTP id
 00721157ae682-6dbb6ba1112mr36774057b3.44.1726157669775; Thu, 12 Sep 2024
 09:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAA1MA5f3JY7WCZbgKaC2gjagDY-eVdssg_iWEiWtop3zZM7WJQ@mail.gmail.com>
 <39b62cc1-66e1-4962-a3a8-0d3ad6e151ef@efficios.com>
In-Reply-To: <39b62cc1-66e1-4962-a3a8-0d3ad6e151ef@efficios.com>
Date: Thu, 12 Sep 2024 09:14:17 -0700
Message-ID: <CAA1MA5eTdaSt_fxuEFK1dbGZXZSFHwLRO22YiXU1hgsCDQKRLA@mail.gmail.com>
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Trigger snapshots on a watchdog
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Damien Berget via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Damien Berget <damien.berget@flyzipline.com>
Content-Type: multipart/mixed; boundary="===============5701111791593864571=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============5701111791593864571==
Content-Type: multipart/alternative; boundary="000000000000bbd1a40621ee6610"

--000000000000bbd1a40621ee6610
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the quick response Kienan,
Your proposal is exactly how we were thinking the monitor application could
work, so we'll go with that for now.
Reacting to absence of an event (watch dog) would really be a good
complement to the existing trigger types.
It's a really useful feature for a flight recorder in embedded medium
real-time applications, is the team open to feature requests?
Cheers
Damien

On Thu, Sep 12, 2024 at 12:57=E2=80=AFAM Kienan Stewart <kstewart@efficios.=
com>
wrote:

> Hi Damien,
>
> On 2024-09-11 18:38, Damien Berget via lttng-dev wrote:
> > Good day,
> > We are trying to see what it the best way to monitor some applications
> > not hitting a deadline. Ideally something like a watchdog that needs
> > to be pat regularly and if timeout is reached triggers the snapshot.
> >
> > Before we reinvent the wheel and code some userland applications, is
> > there a canonical way in LTTng to do it? I found this
> > <https://review.lttng.org/c/lttng-tools/+/9657/9> that is suspiciously
> > close maybe?
> >
> I don't think the the proposed changes you linked to are useful or
> related to what you hope to achieve. The patch series is a concept about
> how some types of UST ring buffer stalls might be addressed by the
> session daemon. After a quick glance, the monitoring seems to be more
> closely related to the 'monitor timer', which is used to sample
> statistical information channels[1].
>
>
> There is a concept of triggers[2]; however triggers react to the
> presence of events rather than the absence thereof.
>
>
> I think a small user space application that monitors the state of other
> applications is more the direction to head in. There's at least of
> couple of ways that a snapshot on unhealthy state could be achieved:
>
>
> * Use liblttng-ctl to trigger a snapshot from your watchdog
> application[3][4].
>
> * Have the watchdog application exec `lttng snapshot record`[5].
>
> * Have the watchdog application emit some sort of "health state" events
> with some data (e.g. health_okay, health_bad, ...) per your usage
> requirements, and configure a trigger[2] to take a snapshot on the
> "health state" events that have the non-okay state.
>
>
> Depending on your tracing configuration - channel overwrite/discard
> mode[6], buffer sizes, blocking mode, and number of events it is
> possible that events may not be recorded. I would privilege using
> liblttng-ctl or exec'ing `lttng snapshort record` if you want a stronger
> guarantee that your watchdog will cause a snapshot to be taken.
>
>
> I would love to hear if there are other ideas. Regardless, hope this help=
s!
>
>
> thanks,
>
> kienan
>
>
> [1]: https://lttng.org/docs/v2.13/#doc-channel-timers
>
> [2]:  https://lttng.org/docs/v2.13/#doc-trigger
>
> [3]:  https://lttng.org/docs/v2.13/#doc-liblttng-ctl-lttng
>
> [4]: https://github.com/lttng/lttng-tools/tree/master/src/lib/lttng-ctl
>
> [5]: https://lttng.org/man/1/lttng-snapshot/v2.13/
>
> [6]:
> https://lttng.org/docs/v2.13/#doc-channel-overwrite-mode-vs-discard-mode
>
>
> > Thanks,
> > Cheers
> >
> > --
> > *Damien Berget*
> > Embedded Platform Lead
> > damien.berget@flyzipline.com
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>


--=20
*Damien Berget*

--000000000000bbd1a40621ee6610
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the quick=C2=A0response Kienan,<div>Your propos=
al is exactly how we were thinking the monitor application could work, so w=
e&#39;ll go with that for now.</div><div>Reacting to absence=C2=A0of an eve=
nt (watch dog) would really be a good complement to the existing trigger ty=
pes.</div><div>It&#39;s a really useful feature for a flight recorder in em=
bedded medium real-time applications, is the team open to feature requests?=
</div><div>Cheers</div><div>Damien</div></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 12, 2024 at 12:57=E2=80=
=AFAM Kienan Stewart &lt;<a href=3D"mailto:kstewart@efficios.com">kstewart@=
efficios.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">Hi Damien,<br>
<br>
On 2024-09-11 18:38, Damien Berget via lttng-dev wrote:<br>
&gt; Good day,<br>
&gt; We are trying to see what it the best way to monitor some applications=
 <br>
&gt; not hitting a deadline. Ideally something like a watchdog that needs <=
br>
&gt; to be pat regularly and if timeout is reached triggers the snapshot.<b=
r>
&gt;<br>
&gt; Before we reinvent the wheel and code some userland applications, is <=
br>
&gt; there a canonical way in LTTng to do it? I found this <br>
&gt; &lt;<a href=3D"https://review.lttng.org/c/lttng-tools/+/9657/9" rel=3D=
"noreferrer" target=3D"_blank">https://review.lttng.org/c/lttng-tools/+/965=
7/9</a>&gt;=C2=A0that is suspiciously <br>
&gt; close maybe?<br>
&gt;<br>
I don&#39;t think the the proposed changes you linked to are useful or <br>
related to what you hope to achieve. The patch series is a concept about <b=
r>
how some types of UST ring buffer stalls might be addressed by the <br>
session daemon. After a quick glance, the monitoring seems to be more <br>
closely related to the &#39;monitor timer&#39;, which is used to sample <br=
>
statistical information channels[1].<br>
<br>
<br>
There is a concept of triggers[2]; however triggers react to the <br>
presence of events rather than the absence thereof.<br>
<br>
<br>
I think a small user space application that monitors the state of other <br=
>
applications is more the direction to head in. There&#39;s at least of <br>
couple of ways that a snapshot on unhealthy state could be achieved:<br>
<br>
<br>
* Use liblttng-ctl to trigger a snapshot from your watchdog <br>
application[3][4].<br>
<br>
* Have the watchdog application exec `lttng snapshot record`[5].<br>
<br>
* Have the watchdog application emit some sort of &quot;health state&quot; =
events <br>
with some data (e.g. health_okay, health_bad, ...) per your usage <br>
requirements, and configure a trigger[2] to take a snapshot on the <br>
&quot;health state&quot; events that have the non-okay state.<br>
<br>
<br>
Depending on your tracing configuration - channel overwrite/discard <br>
mode[6], buffer sizes, blocking mode, and number of events it is <br>
possible that events may not be recorded. I would privilege using <br>
liblttng-ctl or exec&#39;ing `lttng snapshort record` if you want a stronge=
r <br>
guarantee that your watchdog will cause a snapshot to be taken.<br>
<br>
<br>
I would love to hear if there are other ideas. Regardless, hope this helps!=
<br>
<br>
<br>
thanks,<br>
<br>
kienan<br>
<br>
<br>
[1]: <a href=3D"https://lttng.org/docs/v2.13/#doc-channel-timers" rel=3D"no=
referrer" target=3D"_blank">https://lttng.org/docs/v2.13/#doc-channel-timer=
s</a><br>
<br>
[2]:=C2=A0 <a href=3D"https://lttng.org/docs/v2.13/#doc-trigger" rel=3D"nor=
eferrer" target=3D"_blank">https://lttng.org/docs/v2.13/#doc-trigger</a><br=
>
<br>
[3]:=C2=A0 <a href=3D"https://lttng.org/docs/v2.13/#doc-liblttng-ctl-lttng"=
 rel=3D"noreferrer" target=3D"_blank">https://lttng.org/docs/v2.13/#doc-lib=
lttng-ctl-lttng</a><br>
<br>
[4]: <a href=3D"https://github.com/lttng/lttng-tools/tree/master/src/lib/lt=
tng-ctl" rel=3D"noreferrer" target=3D"_blank">https://github.com/lttng/lttn=
g-tools/tree/master/src/lib/lttng-ctl</a><br>
<br>
[5]: <a href=3D"https://lttng.org/man/1/lttng-snapshot/v2.13/" rel=3D"noref=
errer" target=3D"_blank">https://lttng.org/man/1/lttng-snapshot/v2.13/</a><=
br>
<br>
[6]: <br>
<a href=3D"https://lttng.org/docs/v2.13/#doc-channel-overwrite-mode-vs-disc=
ard-mode" rel=3D"noreferrer" target=3D"_blank">https://lttng.org/docs/v2.13=
/#doc-channel-overwrite-mode-vs-discard-mode</a><br>
<br>
<br>
&gt; Thanks,<br>
&gt; Cheers<br>
&gt;<br>
&gt; -- <br>
&gt; *Damien Berget*<br>
&gt; Embedded Platform Lead<br>
&gt; <a href=3D"mailto:damien.berget@flyzipline.com" target=3D"_blank">dami=
en.berget@flyzipline.com</a><br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><b>Damien Berget</b></div></div>

--000000000000bbd1a40621ee6610--

--===============5701111791593864571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5701111791593864571==--
