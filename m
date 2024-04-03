Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB95C6FD1F
	for <lttng-dev@archiver.kernel.org>; Wed,  3 Apr 2024 03:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1712116027;
	bh=4ITImxConXvjH81XXQs4JYisoXbFk3Ukm/FyOJT/Ngk=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QN+cQO51f5iJcPRWFyGYGE5wI8bEdHJU+nqqcu+YCo3L3sCbOoV/61LnPkDmPxZCk
	 RzgfbGCSZadoHUsQeFzYBscaX8QNEhU5MWTGbNGZoh8ngkO7Rhc7yO21i8ERcK86tG
	 49gGdmIbt4Rzj90SFvLuzGMZid+R+1RpAcghUsp4AULM8SomLmtGOs1JTsHKwKLj4P
	 Zcfz8H9GEiu6WNqUXpiUCALJWqPSSlxRYEhSSElcdlvErr7wCmIepi6jG1cHyQPj4l
	 icfdKr+0pbkvnOwKW6NMj57VOfu9A8/gL2y3zjfXG+NSi3ESHmlg70ex/YsuI9jvOw
	 7+oPflZLBqx2Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4V8W0B6g8pz2Zm0;
	Tue,  2 Apr 2024 23:47:06 -0400 (EDT)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by lists.lttng.org (Postfix) with ESMTPS id 4V8W090B0Qz2Zlx
 for <lttng-dev@lists.lttng.org>; Tue,  2 Apr 2024 23:47:04 -0400 (EDT)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d83dddcd65so2042061fa.1
 for <lttng-dev@lists.lttng.org>; Tue, 02 Apr 2024 20:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712116023; x=1712720823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VGZIyUV3uF1ulkt/lOlg69QGeqeJG/tRABoYJC48Vm4=;
 b=u3zstXBs8s1ZyP8ZsDkPA2PImQSH9XNRyUl9nHfKMJT0/AbNWq6d6v6G/LnwfFykuG
 7POZcOvLXxOCE1rLOHw41V2jYcfiV8qlvyKAg+JBRKkZ7R0yXVyEEeMZKONar2qAy41j
 qqOrZiJTb4G4yqJ+9w4OgQ385zouc0C/0bN3UbIAX7UzAXaAyt09dJ3zz8QlbQBYWJPP
 P9f04Vy0EHkd85fSq7smQ9rWxXxmwsYCJO6fgQWrG/13QvhWnVVJ1POCv2vIhEKIaHYf
 IDeL5eOTZ9Trmqr1UuZZlYz/H69Icbh/Q/bxqLkyoasU7+gUUIBp+UxBUlt5McJY++tf
 gH9w==
X-Gm-Message-State: AOJu0YzeLrTShHZkGw5MOSGfIOsBIlkqIMjFKXhT1q5H+cM/3lzda5Mw
 Kg9Yf2D/P3Uy3eRM16SImS+NEUuZ+dTfdo8jkc+dq40gxG6pew5pnoB+jBQkRsGElHrhn4fGIMq
 dutRHmob+v0hfnmE47v30Fzz9iYeseqOJ
X-Google-Smtp-Source: AGHT+IE0Q/pw7KmCu2JRTUcB4ubF5TLm23x3oyLShXVhwyD9LquF5zbmGJM78iMI8taWSDJJ3Aq8iDbYmHRpwQDRGyk=
X-Received: by 2002:a05:651c:2107:b0:2d8:3a02:9112 with SMTP id
 a7-20020a05651c210700b002d83a029112mr778763ljq.5.1712116022887; Tue, 02 Apr
 2024 20:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <CABRndgyb_=9VrrgV-Z21YDe1w879kTuE9t6m8Hoa3h-4MpfcEQ@mail.gmail.com>
 <7cc79ada-f8cb-49fc-aec8-4d0b5c9ba2bd@efficios.com>
In-Reply-To: <7cc79ada-f8cb-49fc-aec8-4d0b5c9ba2bd@efficios.com>
Date: Wed, 3 Apr 2024 06:51:02 +0300
Message-ID: <CABRndgzYjmfBYKsHsJ=fzi6c=24ey2gEdxpMn3e8Ly2EZJVA2Q@mail.gmail.com>
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] lttng-modules(13.9) : insmod order
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
Content-Type: multipart/mixed; boundary="===============1422018150117512984=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1422018150117512984==
Content-Type: multipart/alternative; boundary="0000000000005bcdb20615291377"

--0000000000005bcdb20615291377
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kienan,

Thank you for your help!

Best regards,
Zvika

On Tue, Apr 2, 2024 at 4:17=E2=80=AFPM Kienan Stewart <kstewart@efficios.co=
m> wrote:

> Hi Zvika,
>
> a sessiond launched as root will automatically try to load the
> appropriate kernel modules as mentioned here[1], using either modprobe
> or libkmod depending on how the build was configured.
>
> thanks,
> kienan
>
> [1]: https://lttng.org/docs/v2.13/#doc-lttng-modules
>
>
> On 3/30/24 10:52 PM, Zvi Vered via lttng-dev wrote:
> > Hello,
> >
> > For some reason, I failed to integrate v13.9 into buildroot 2023.02.2
> > But I compiled all modules with the my kernel source: 5.4.249
> >
> > Can you please tell what is the right order of *insmod *for the kernel
> > modules ?
> >
> > All I need is to record IRQ events and user space events.
> >
> > Thank you,
> > Zvika
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--0000000000005bcdb20615291377
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Kienan,</div><div><br></div>Thank you for your hel=
p!=C2=A0<br><div><br></div><div>Best regards,</div><div>Zvika=C2=A0</div></=
div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Tue, Apr 2, 2024 at 4:17=E2=80=AFPM Kienan Stewart &lt;<a href=3D"mailto:k=
stewart@efficios.com">kstewart@efficios.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Hi Zvika,<br>
<br>
a sessiond launched as root will automatically try to load the <br>
appropriate kernel modules as mentioned here[1], using either modprobe <br>
or libkmod depending on how the build was configured.<br>
<br>
thanks,<br>
kienan<br>
<br>
[1]: <a href=3D"https://lttng.org/docs/v2.13/#doc-lttng-modules" rel=3D"nor=
eferrer" target=3D"_blank">https://lttng.org/docs/v2.13/#doc-lttng-modules<=
/a><br>
<br>
<br>
On 3/30/24 10:52 PM, Zvi Vered via lttng-dev wrote:<br>
&gt; Hello,<br>
&gt; <br>
&gt; For some reason, I failed to integrate v13.9 into buildroot 2023.02.2<=
br>
&gt; But I compiled all modules with the my kernel source: 5.4.249<br>
&gt; <br>
&gt; Can you please tell what is the right order of *insmod *for the kernel=
 <br>
&gt; modules ?<br>
&gt; <br>
&gt; All I need is to record IRQ events and user space events.<br>
&gt; <br>
&gt; Thank you,<br>
&gt; Zvika<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
</blockquote></div>

--0000000000005bcdb20615291377--

--===============1422018150117512984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1422018150117512984==--
