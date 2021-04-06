Return-Path: <SRS0=PeGe=JD=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5759C433ED
	for <lttng-dev@archiver.kernel.org>; Tue,  6 Apr 2021 23:57:20 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57EAC61246
	for <lttng-dev@archiver.kernel.org>; Tue,  6 Apr 2021 23:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57EAC61246
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FFPb305Y9z13p6;
	Tue,  6 Apr 2021 19:57:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617753439;
	bh=Tu4TcseLd/Ifofs/phvrYuoc2ypUkOcrXrKbeItQEjo=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=TdzES+ZlmyNoGwFtVYpWnLNPrD0aHUWH8WtClOglWZvz09G4JGRJshzoHxbyYS/FH
	 RROniF+4Tp9oCAkbTZk50gXrjU5MRyUQVS2APkVJKn9NnDxrImwfBJTB99whAibyqu
	 6mE2l3q64AAdw91B2tGovKkm0nZ0DqUdPv1p06XxkL0uoh95N2ws1eH/cXrpR5AWmu
	 tldM6o75Y/5Hx76jKPA54hWCLVyQ3//PGnptq6c9UCN8B9LCmeCFhRjezK8e85oX46
	 c++YhSLTUVSOJ7AfOwW90EztQ7xXvGGnWWkbmvOhU82/EdP1NmxRizX9siffgpqdbF
	 t7HS8SUp3xFhw==
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by lists.lttng.org (Postfix) with ESMTPS id 4FFPb20FWxz13tD
 for <lttng-dev@lists.lttng.org>; Tue,  6 Apr 2021 19:57:17 -0400 (EDT)
Received: by mail-lj1-x229.google.com with SMTP id r20so18497236ljk.4
 for <lttng-dev@lists.lttng.org>; Tue, 06 Apr 2021 16:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VAZUkXJQV5Rsw6EFwJPGDDvpzjNFYVxBX4ebcCV4kQE=;
 b=DYrc1gXYBIr9WMzESx1wTgr1V2tV3Vo1AEQvDKW9Vidr7HrQiUASwmgOS5qH/JLIef
 55RS5JKBppQiA3TmzFa8dhz7idWy60JMCgi23g3ig35NMYc0FZ71FhzOSt3P2CEvLj75
 rowSQkZOz3vO0ff3obI+uVg9ekV08KeMXfMNCXN+0eZfAEmhTwVi6FrHRnt+RG/C8DEL
 0hcVFRWTs1qmQG08+UjfiR9AAoP2cduId9do5qgG/nzk3kBN07qGRv84a6ucTZnwJuh1
 4RdyiBIIpOHhR/37eYGVBqFzCpHI3AZhIbcz3OvbOmgKnUQPHNZ8CnHVH1E4i4flKQD3
 ZcSQ==
X-Gm-Message-State: AOAM531KIPRwAleQmhUM+odqHWnAge4jep8HEUfM0RiWwJ9DoxLZ0CBu
 x/OD+GykPG53RnN+UNm8LYsaQ/8cJoRA4TkRTu4=
X-Google-Smtp-Source: ABdhPJxhhzIKgE7MlLpz7W4tZI/QuEzXAQUXywK0KkDi/P209lL2hOD3cGiG8D4fAhSzK+OR0fF0uWjn5oqH4FVMvzc=
X-Received: by 2002:a2e:7d03:: with SMTP id y3mr365115ljc.0.1617753436241;
 Tue, 06 Apr 2021 16:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <mailman.1.1617379201.29396.lttng-dev@lists.lttng.org>
 <CAFGSPryoOne68L4APnOvEgmw=q3WcgVujY1RYbEiO0FwqJnDyw@mail.gmail.com>
 <20210406131139.GC79283@joraj-alpa>
 <CAFGSPrzx05pqvjC7UzxHZWuk38_zhUfBEiq0oUc21-yxggp5tQ@mail.gmail.com>
 <20210406234621.GA913141@joraj-alpa>
In-Reply-To: <20210406234621.GA913141@joraj-alpa>
Date: Tue, 6 Apr 2021 18:56:39 -0500
Message-ID: <CAFGSPrwnihLeY_CQm8jYb9B0R2RT52U2SaPeVLVSDsqCyxYKSQ@mail.gmail.com>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] lttng-dev Digest, Vol 156, Issue 3
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
From: Ramesh Errabolu via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Ramesh Errabolu <ramesh.errabolu@gmail.com>
Content-Type: multipart/mixed; boundary="===============1441265547090580428=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1441265547090580428==
Content-Type: multipart/alternative; boundary="000000000000e6c25c05bf569233"

--000000000000e6c25c05bf569233
Content-Type: text/plain; charset="UTF-8"

Will try the dummy app to check if the basic setup is good. Wondering if
being able to trace shared libraries is something not supported.

Regards,
Ramesh


On Tue, Apr 6, 2021 at 6:46 PM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> > I followed your command sequence and noticed a bunch of files being
> > created. However when I tried to run babeltrace on these outputs I don't
> > see any of the functions that should have been called.  Including below
> the
> > search for symbols.
>
> At least userspace tracing seems to work.
>
> I would recommended, again, that you first try tracing on a dummy
> application, a
> really simple one. Then move to the usage of cyg_profile on that dummy app
> then
> to your application.
>
> The cyg profile events are the following:
>
>   lttng_ust_cyg_profile_fast:func_entry
>   lttng_ust_cyg_profile_fast:func_exit
>
> and, when using liblttng-ust-cyg-profile.so:
>
>   lttng_ust_cyg_profile:func_entry
>   lttng_ust_cyg_profile:func_exit
>
> I would recommend that you first start grep-ing (lttng_ust_cyg) for this
> in the
> trace to see if any is getting hit and recorded. If it is not the case,
> take a
> step back try with a dummy app and if nothing works with the dummy app we
> can at
> least try to help you from there and remove all other variable since you
> will be
> able to share the dummy app with us.
>
> Cheers
>

--000000000000e6c25c05bf569233
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif">Will try the dummy app to check if the basic setup is good. Won=
dering if being able to trace shared libraries is something not supported.<=
/div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif">=
<br></div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D=
"gmail_signature">Regards,<div>Ramesh</div></div></div><br></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 6, 2=
021 at 6:46 PM Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jonathan.rajot=
te-julien@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; I followed=
 your command sequence and noticed a bunch of files being<br>
&gt; created. However when I tried to run babeltrace on these outputs I don=
&#39;t<br>
&gt; see any of the functions that should have been called.=C2=A0 Including=
 below the<br>
&gt; search for symbols.<br>
<br>
At least userspace tracing seems to work.<br>
<br>
I would recommended, again, that you first try tracing on a dummy applicati=
on, a<br>
really simple one. Then move to the usage of cyg_profile on that dummy app =
then<br>
to your application.<br>
<br>
The cyg profile events are the following:<br>
<br>
=C2=A0 lttng_ust_cyg_profile_fast:func_entry<br>
=C2=A0 lttng_ust_cyg_profile_fast:func_exit<br>
<br>
and, when using liblttng-ust-cyg-profile.so:<br>
<br>
=C2=A0 lttng_ust_cyg_profile:func_entry<br>
=C2=A0 lttng_ust_cyg_profile:func_exit<br>
<br>
I would recommend that you first start grep-ing (lttng_ust_cyg) for this in=
 the<br>
trace to see if any is getting hit and recorded. If it is not the case, tak=
e a<br>
step back try with a dummy app and if nothing works with the dummy app we c=
an at<br>
least try to help you from there and remove all other variable since you wi=
ll be<br>
able to share the dummy app with us.<br>
<br>
Cheers<br>
</blockquote></div>

--000000000000e6c25c05bf569233--

--===============1441265547090580428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1441265547090580428==--
