Return-Path: <SRS0=PKKo=64=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBD7C433E0
	for <lttng-dev@archiver.kernel.org>; Thu, 14 May 2020 14:04:07 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A00205CB
	for <lttng-dev@archiver.kernel.org>; Thu, 14 May 2020 14:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="Rz1iuqxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A00205CB
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49NCvT3ypyz22ks;
	Thu, 14 May 2020 10:04:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1589465046;
	bh=CLlWu5+uhwWxQ0au0+ImglD7phOBrtPgd+z5sRRv2/4=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Rz1iuqxWAY2T6LaBQMcXq4r2GbNl9LRIddtTANCr0i+L5E+GHSfEQfR/O26nn1JeO
	 +EXKxLXXyiN18knT7QHY2Ll6994+RRrdqDzRw80rUaIMjEzB/n3b+z1/jnNNjQgXGj
	 DZkACt89AgzfBNR0MEh3TnGVTDjDMRyrhRWJY6uLweWYgqBk68vxq8zArgQn3prQBL
	 ZtwGlIMCJn6kYQkt5FicyGO16XjXlzCrTsOvHVz6kgWDcx0I5j0DWKIKbJHedTlbfy
	 kadC3sc0oBaQeTfQchHpnpTn1f5zoXYWd8L2qwhae0MmgZclY9UqT9tsAWHbNPqhKM
	 eaClHQV5eHFdg==
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 by lists.lttng.org (Postfix) with ESMTPS id 49N0PN64s1z22gX
 for <lttng-dev@lists.lttng.org>; Thu, 14 May 2020 01:25:44 -0400 (EDT)
Received: by mail-io1-xd33.google.com with SMTP id f4so1516626iov.11
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 22:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rLkhzA/xtI9Mmq9ojZhuecSKkf2qkNrCzBCb1QS6KqI=;
 b=kDaVQsoD3hGyWOf7+u6C3HCb5Z7gF+I3XEKf0upO4R0TaPRE9rQnfoOlJyjTHilVIc
 eA7S4JR1T96wF2CJL9Pvo4b4JKI1IaXgk5YZGZKHBXcIyY2jrAv9Jg/WlLrXkX7WGk2u
 LTLMNZhRuwX7U8wZQuafrtRyXLkLQ2FfsR4Rtz9GaYFJM5DQGWgAp7S0441B8xqj5JW2
 TdrVU9tINeR77F4OG1KHK74+XQZ//SJRnFFjoGRQrVq0ZSkQNXhPZlNwppqFnxuahD8c
 WgYjlRq6HK24fs4AghBzXfmFxuO9K2Qm8agAKZckHb8BHyOoV/OP30uwnINvU3UpCQs3
 sLyA==
X-Gm-Message-State: AGi0PuYMq7vCs2OyIoqNUpJFZsAHqgMqVX7vHUlnczQpmNYmDUd92IUj
 gAodiWYFaVPJxAWug3uE1IM6idfAycQWs0zGduU=
X-Google-Smtp-Source: ABdhPJwG9g2bs4FmgW1PowazF0SKSLoE1hp7XXITNIBaDsspPwWJhe6T4DxKxmGw8rDSD/liSFjPUefRsiCspzPEJgc=
X-Received: by 2002:a02:cb59:: with SMTP id k25mr2777129jap.41.1589433943724; 
 Wed, 13 May 2020 22:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAPC3ern8bkAJDnOwoYh2Om44Q2GWAPsh140FW_aPGVkdUmCwkw@mail.gmail.com>
 <CAPC3erkxTh9dSgahym7xsCjJXOV3D+kto-=UB-ApjSUOWYZVeA@mail.gmail.com>
 <20200513153312.GA2381108@joraj-alpa>
 <CAPC3erkfapoZu_WM=znEyj0ch1YiKeX7-JBiauoLh+Seee0TZA@mail.gmail.com>
 <20200513180404.GB2381108@joraj-alpa>
In-Reply-To: <20200513180404.GB2381108@joraj-alpa>
Date: Thu, 14 May 2020 10:55:32 +0530
Message-ID: <CAPC3er=7+wOR8CdtdU+PGGOgWLWMBy55jAR5jZzyzZr67mQuCA@mail.gmail.com>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Thu, 14 May 2020 10:04:04 -0400
Subject: Re: [lttng-dev] Need Help In trace generation for malloc(),
 free() calls etc
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Abhinav Ranjan via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Abhinav Ranjan <abhi.abhinav240@gmail.com>
Content-Type: multipart/mixed; boundary="===============8772839595592032461=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200514052532.PmyKzMsKrhHsOIuNq43tQrRodUoP_BMafBTYmNLvAe4@z>

--===============8772839595592032461==
Content-Type: multipart/alternative; boundary="0000000000009c1ac205a594ed2b"

--0000000000009c1ac205a594ed2b
Content-Type: text/plain; charset="UTF-8"

Thank You Sir,
I am sorry for the inconvenience caused to you!
Surely I'll take care of every suggestion you passed on to me.

Once again I thank you for your wonderful help!

Stay Safe and Happy!!!



On Wed, 13 May 2020 at 23:34, Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi Abhinav,
>
> Please keep the mailing list in CC for all communication:
> lttng-dev@lists.lttng.org
>
> If not, I am not interested in helping you further.
>
> On Wed, May 13, 2020 at 09:26:52PM +0530, Abhinav Ranjan wrote:
> > Hi! Jonathan thank you so much for your help and reply! Sure I'll not use
> > snapshot from next time and follow your advice.
> > In fact I figured out the issue, but Jonathan I have one specific doubt I
> > wanted to trace malloc , free call from my app only  but after using
> lttng
> > enable-event --userspace lttng_ust_libc:malloc I am seeing several
> malloc (
> > in Trace Compass)   probably from different tracepoints from
> lttng_ust_libc.
>
> You will see all malloc that the app does for its lifetime since you
> LD_PRELOAD
> the wrapper including any allocation lttng-ust does. Keep in mind that
> lttng-ust
> is not magic, lttng-ust spun threads and do some allocations to do its job.
>
> What outcome do you expect? We might be able to at least get you on the
> right
> path. In other word, what is your end goal?
>
> Cheers
>
>

-- 
Thanking You!

Regards,
Abhinav

--0000000000009c1ac205a594ed2b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Thank You Sir,<div>I am sorry for the inc=
onvenience caused to you!=C2=A0</div><div>Surely I&#39;ll take care of ever=
y suggestion you passed on to me.</div><div><br></div><div>Once again I tha=
nk you for your wonderful help!</div><div><br></div><div>Stay Safe and=C2=
=A0Happy!!!</div><div><br></div><div><br></div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 13 May 2020 at 23:34=
, Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jonathan.rajotte-julien@eff=
icios.com">jonathan.rajotte-julien@efficios.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Hi Abhinav,<br>
<br>
Please keep the mailing list in CC for all communication: <a href=3D"mailto=
:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>=
<br>
<br>
If not, I am not interested in helping you further.<br>
<br>
On Wed, May 13, 2020 at 09:26:52PM +0530, Abhinav Ranjan wrote:<br>
&gt; Hi! Jonathan thank you so much for your help and reply! Sure I&#39;ll =
not use<br>
&gt; snapshot from next time and follow your advice.<br>
&gt; In fact I figured out the issue, but Jonathan I have one specific doub=
t I<br>
&gt; wanted to trace malloc , free call from my app only=C2=A0 but after us=
ing lttng<br>
&gt; enable-event --userspace lttng_ust_libc:malloc I am seeing several mal=
loc (<br>
&gt; in Trace Compass)=C2=A0 =C2=A0probably from different tracepoints from=
 lttng_ust_libc.<br>
<br>
You will see all malloc that the app does for its lifetime since you LD_PRE=
LOAD<br>
the wrapper including any allocation lttng-ust does. Keep in mind that lttn=
g-ust<br>
is not magic, lttng-ust spun threads and do some allocations to do its job.=
<br>
<br>
What outcome do you expect? We might be able to at least get you on the rig=
ht<br>
path. In other word, what is your end goal?<br>
<br>
Cheers<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div=
 dir=3D"ltr"><div>Thanking You!</div><div><br></div><div>Regards,<br></div>=
<div>Abhinav<br></div><div><br></div></div></div></div></div></div></div></=
div>

--0000000000009c1ac205a594ed2b--

--===============8772839595592032461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8772839595592032461==--
