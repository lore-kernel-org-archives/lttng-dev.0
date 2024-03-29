Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E62CD1283
	for <lttng-dev@archiver.kernel.org>; Fri, 29 Mar 2024 05:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1711688728;
	bh=hF1nzL0dAZiUZdPBXt/iPIqaq0mLpTQUHVgClPETRuY=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=w/vkiTQiZfG5DZamzH84gKQqYE/hYn9r6JyuyjWJEKyY5rU4lUDjy8Fypkb+nU9u3
	 0hzmgy3ZdEGIosaLeeXKExakU4APEyLc/6JZGdPGkrx3g6PWCusmwyELHoSQejZwp3
	 XvP9gbHdYgEiOBXzmxc4XNZVcofklMC2sF8oTkCtxeuu4R/uWTe9GK4RERyokW9gKn
	 uiJ+PnY0YAPI2d8y997D4xwkoe1Wef6BgmXPG1FJqdrBI2FTEBpWFl4sWl//oXoltM
	 f/Zhucu9FY55OlFLTdxrucEJEo2shJm0nUCoDgLLGPUfwnvoLfVfilgtck5/hovren
	 eBpQc1ZGiyo9Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4V5Syv5DQJz2XcW;
	Fri, 29 Mar 2024 01:05:27 -0400 (EDT)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by lists.lttng.org (Postfix) with ESMTPS id 4V5Syt0FDcz2XL6
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2024 01:05:25 -0400 (EDT)
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d718efedb2so2053421fa.0
 for <lttng-dev@lists.lttng.org>; Thu, 28 Mar 2024 22:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711688724; x=1712293524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mYsF/hsnSiCyGou3H33khtbUmxGKepP7s4+iFOvZnLg=;
 b=oJPIECIUOEuILgkkB8mBRgqxo7NRWJfoAk1Pi/JfFEshk9NbYq7jUHZlS5Q7sr+uk7
 6XYSajU7LWsXO9Z8+WDdA1eiztG0DQvysKgLd9V+M4gu5prh41aC5Guz7b6DDPZMWTq5
 fr4FcN2VbRu7V4UywYEL+wS18G4dzNscIfqgBqnl2iVtJx+imbiK/55ej7fnBCwW+ij0
 05e8aDn/MpLLrX+d5FUKHHT4RCak0RAl8/yJ5yruInC3j/Q3ZGjtP80f7x6kcT2/c/5W
 2YEKPhKNad9dfJ931XLqjPy/lgHpBebHpocP38R7g33CtOLxLcGkyDKXECg5W0+6wEtO
 xGTQ==
X-Gm-Message-State: AOJu0YyCNMTQz3XJKzJD5Gxjlaqpr2m+zyDWBMIKTqjcPMZCW8WuX3D4
 wqpH2XHiTibdZK46TZotbvSVAjcnRBINBv0lTQ2P6IyEcsIiCMDymkn0A94KECzd03UaDoTcgUv
 75NHL3H3GpgpuMV55ER5ocgIxisc=
X-Google-Smtp-Source: AGHT+IHzG+LmYPmrVOwyIvLJFtqrbz0nN1vjUnKEkR7wXQyIe8wJUAkHuZt2VcFkShk++OtOrwKMx97dlQQWyvC0KKQ=
X-Received: by 2002:a2e:a40e:0:b0:2d7:b5c:5b55 with SMTP id
 p14-20020a2ea40e000000b002d70b5c5b55mr883495ljn.5.1711688724126; Thu, 28 Mar
 2024 22:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <CABRndgz2BHX9LubVXoaJxLH+KoYfgzQ0XzY=xHG60+HoO-Tm7A@mail.gmail.com>
 <a128a334-b2d8-4cec-ae40-91e1384a228d@app.fastmail.com>
In-Reply-To: <a128a334-b2d8-4cec-ae40-91e1384a228d@app.fastmail.com>
Date: Fri, 29 Mar 2024 08:09:16 +0300
Message-ID: <CABRndgy8RJ-rkszYGpvnqJ6oth35ajJhWgF8T4aWFEFjZiBz0g@mail.gmail.com>
To: Christopher Harvey <chris@cwharvey.ca>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Lttng: display active threads in multiple cores.
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
From: Zvi Vered via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Zvi Vered <veredz72@gmail.com>
Content-Type: multipart/mixed; boundary="===============6046270152871084865=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6046270152871084865==
Content-Type: multipart/alternative; boundary="0000000000005e271c0614c59680"

--0000000000005e271c0614c59680
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

Thank you very much for your reply.
Can you please explain what do you mean by ftrace-enabled kernel ?

Best regards,
Zvika

On Wed, Mar 27, 2024 at 7:32=E2=80=AFPM Christopher Harvey via lttng-dev <
lttng-dev@lists.lttng.org> wrote:

> you can use an ftrace-enabled kernel with lttng (maybe even just
> tracecompass) or perfetto to get that kind of trace
>
>
> https://archive.eclipse.org/tracecompass.incubator/doc/org.eclipse.tracec=
ompass.incubator.ftrace.doc.user/User-Guide.html
>
> or
>
> https://ui.perfetto.dev/
>
> On Wed, Mar 27, 2024, at 5:26 AM, Zvi Vered via lttng-dev wrote:
> > Hello,
> >
> > I have an application with 4 threads.
> > I'm required to display on the graph when thread starts working till it
> > blocks for the next semaphore.
> >
> > But without using the lttng userspace library.
> >
> > Is it possible ?
> >
> > Thank you,
> > Zvika
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--0000000000005e271c0614c59680
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Christopher,<div><br></div><div>Thank you very much for=
 your reply.</div><div>Can you please explain what do you mean by ftrace-en=
abled kernel ?</div><div><br></div><div>Best=C2=A0regards,</div><div>Zvika=
=C2=A0</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Wed, Mar 27, 2024 at 7:32=E2=80=AFPM Christopher Harvey via =
lttng-dev &lt;<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.=
lttng.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">you can use an ftrace-enabled kernel with lttng (maybe even just=
 tracecompass) or perfetto to get that kind of trace<br>
<br>
<a href=3D"https://archive.eclipse.org/tracecompass.incubator/doc/org.eclip=
se.tracecompass.incubator.ftrace.doc.user/User-Guide.html" rel=3D"noreferre=
r" target=3D"_blank">https://archive.eclipse.org/tracecompass.incubator/doc=
/org.eclipse.tracecompass.incubator.ftrace.doc.user/User-Guide.html</a><br>
<br>
or<br>
<br>
<a href=3D"https://ui.perfetto.dev/" rel=3D"noreferrer" target=3D"_blank">h=
ttps://ui.perfetto.dev/</a><br>
<br>
On Wed, Mar 27, 2024, at 5:26 AM, Zvi Vered via lttng-dev wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I have an application with 4 threads. <br>
&gt; I&#39;m required to display on the graph when thread starts working ti=
ll it <br>
&gt; blocks for the next semaphore. <br>
&gt;<br>
&gt; But without using the lttng userspace library.<br>
&gt;<br>
&gt; Is it possible ?<br>
&gt;<br>
&gt; Thank you,<br>
&gt; Zvika<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</a><br>
</blockquote></div>

--0000000000005e271c0614c59680--

--===============6046270152871084865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6046270152871084865==--
