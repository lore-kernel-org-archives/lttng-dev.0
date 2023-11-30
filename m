Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAD6C4167B
	for <lttng-dev@archiver.kernel.org>; Thu, 30 Nov 2023 01:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1701309105;
	bh=UEBAO1K+vPJeg3cbB3m9NRfX07BYFC+QSKNZ7HDCFhc=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=YUEoSp10cFZn96ZoAi5QHRqjayEU6xM50QlS+cUPFet/xjqsQnIYp/+LlxanBVjzs
	 YCLeG1ijf/ZZGkN+9L1nDY82S2oCOH2tQj8P6WbT5U8b/ab4AUrrYvSjbypmQ9yfSa
	 2RdE3qFHUes19dkqunGw2+0l8tqg2jqjSMNANyf7nIcXcJYcucPoXJxy/YP5iCtc3W
	 JbPIIDYoPAdqazpup3z+02eKRloMJtmug0pqbyIy7vUc/uJwAV0QDiVlaFFsk+RaNC
	 h5C28Y+W5BJno1PTqu1T3qw0wHeH+oWcftVynfnpBFBmpV1NK3bKjRCyO1+iCt+LrM
	 bPjzf2LNMAggw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SgfLl51QLzP1G;
	Wed, 29 Nov 2023 20:51:43 -0500 (EST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by lists.lttng.org (Postfix) with ESMTPS id 4SgfLk0mnlzNgn
 for <lttng-dev@lists.lttng.org>; Wed, 29 Nov 2023 20:51:41 -0500 (EST)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a0029289b1bso49751566b.1
 for <lttng-dev@lists.lttng.org>; Wed, 29 Nov 2023 17:51:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701309101; x=1701913901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jLDVbyo5OueLI88FzbNe/29EjYrPDMkA0j4DplIY7Vo=;
 b=o+YSEKEBCxCkiYo6LiTZp9bAfH3pyoEjh/SABOwHsBA3I2KPXVch1e+a6knBnMFPlU
 zj3Wz6vItEDqMe7VMpbKjC4lzEZ1ra1+/x06C0wx8ZJ4GrMDLJcwuTAq2iyweX0M6Qev
 djWf5vEL4vIueDvdZ7+ROC4jMS54Bse7bGilV3J10kAJzprH51iy6PeaEx9gSrBp5TaK
 4SDB2cUgGKZPxzzuZRuAN1+euFAS+B3P5W/Zv5W+RaISeTR7mliJFSxm/uaP3z/d0CBt
 H4dPrZko6Ypoylt4KjpXgvfOS5QkpH3M3xObsdsmG2cKeW6mVodtCaWLAPUNEzaGhBay
 qGvQ==
X-Gm-Message-State: AOJu0YwXH3IRgV62rE5UpjUfYjoR60DYyN3VgvG6K2uS/xTIBGreAwOL
 PyouXF2ufapQ18F/I7NIWSZWp1iuZb8yvph3YULr5Zev
X-Google-Smtp-Source: AGHT+IE80GfMcodB8w8KYceQ/0JaVb+9HBfrsLekI+Sd0GAYPs2ABn2AS0rTbLAycZghl1Uni/3RvZo3kShD/uR0eyA=
X-Received: by 2002:a17:906:10d:b0:a00:2686:6b40 with SMTP id
 13-20020a170906010d00b00a0026866b40mr12063963eje.14.1701309100480; Wed, 29
 Nov 2023 17:51:40 -0800 (PST)
MIME-Version: 1.0
References: <CACJEY877LAEbOY92+vFy2AdYdctw-Z7dVozTm_LF-u-Fzy4c0w@mail.gmail.com>
 <c1d6a91f-f30f-4494-8b31-91deb2aa5ca7@efficios.com>
In-Reply-To: <c1d6a91f-f30f-4494-8b31-91deb2aa5ca7@efficios.com>
Date: Wed, 29 Nov 2023 20:51:29 -0500
Message-ID: <CACJEY851bpw4rWODzQwa=WWz6sNTnN3C6iR+npikBikjPAVDUg@mail.gmail.com>
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] Any particular reason that the
 LTTNG_UST_TRACEPOINT_EVENT args and fields are limited to max 10?
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
From: Yonghong Yan via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Yonghong Yan <yanyh15@gmail.com>
Content-Type: multipart/mixed; boundary="===============0408751637798179146=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============0408751637798179146==
Content-Type: multipart/alternative; boundary="000000000000965c4d060b54e4ee"

--000000000000965c4d060b54e4ee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kienan,

Thank you very much for the information and solution.

Best,
Yonghong



On Tue, Nov 28, 2023 at 10:20=E2=80=AFAM Kienan Stewart <kstewart@efficios.=
com>
wrote:

> Hi Yonghong,
>
> My understanding is that the limit of 10 trac epoint arguments was
> initially chosen because it matched with the argumente limit in SDT
> probe points and there is optional integration between LTTng trace
> points and SDT. More recent versions of SDT, as of 1.7+, support up to
> 12 arguments for probe points.
>
> Beyond that, there may be standards/compiler-specific limits for the
> number of parameters to macros and/or function calls, but I don't think
> we're close to hitting any of those.
>
> Note that the LTTNG_UST_TRACEPOINT_FIELDS macro doesn't share the same
> 10 field limit.
>
> Therefore, one work-around that is possible to to pack the values into a
> custom structure to reduce the number of arguments that need to be set
> in the lTTNG_UST_TRACEPOINT_ARGS macro.
>
> eg.
>
> ```
> LTTNG_UST_TRACEPOINT_EVENT(
>     tp,
>     many,
>     LTTNG_UST_TP_ARGS(
>        const struct Sample*, mystruct
>     ),
>     LTTNG_UST_TP_FIELDS(
>        lttng_ust_field_integer(int, a, mystruct->a)
>        lttng_ust_field_integer(int, b, mystruct->b)
>        lttng_ust_field_integer(int, c, mystruct->c)
>        lttng_ust_field_integer(int, e, mystruct->d)
>        lttng_ust_field_integer(int, f, mystruct->e)
>        lttng_ust_field_float(double, g, mystruct->g)
>        lttng_ust_field_float(double, h, mystruct->h)
>        lttng_ust_field_float(double, i, mystruct->i)
>        lttng_ust_field_float(double, j, mystruct->j)
>        lttng_ust_field_float(double, k, mystruct->k)
>        lttng_ust_field_string(string_field, mystruct->thing)
>        lttng_ust_field_string(string_field2, mystruct->thing2)
>     )
> )
>
> ```
>
> Hope this helps!
>
> thanks,
> kienan
>
> On 2023-11-27 22:26, Yonghong Yan via lttng-dev wrote:
> > I have a situation where I need to record more than 10 fields. If you
> > can extend it to support more, but not introduce overhead of handling
> > such rare cases, that will be great.
> >
> > Thanks
> > Yonghong
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--000000000000965c4d060b54e4ee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smart=
mail=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"=
><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Kienan,=C2=A0</=
div><div><br></div><div>Thank you very much for the information and solutio=
n.=C2=A0</div><div><br></div><div>Best,</div><div>Yonghong</div><div><br></=
div><div dir=3D"ltr"><div dir=3D"ltr"><p style=3D"font-size:12.8px"></p></d=
iv><div dir=3D"ltr"></div></div></div></div></div></div></div></div></div><=
/div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr">On Tue, Nov 28, 2023 at 10:20=E2=80=AFAM Kienan Stewart &lt;<a hre=
f=3D"mailto:kstewart@efficios.com">kstewart@efficios.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Yonghong,<br>
<br>
My understanding is that the limit of 10 trac epoint arguments was <br>
initially chosen because it matched with the argumente limit in SDT <br>
probe points and there is optional integration between LTTng trace <br>
points and SDT. More recent versions of SDT, as of 1.7+, support up to <br>
12 arguments for probe points.<br>
<br>
Beyond that, there may be standards/compiler-specific limits for the <br>
number of parameters to macros and/or function calls, but I don&#39;t think=
 <br>
we&#39;re close to hitting any of those.<br>
<br>
Note that the LTTNG_UST_TRACEPOINT_FIELDS macro doesn&#39;t share the same =
<br>
10 field limit.<br>
<br>
Therefore, one work-around that is possible to to pack the values into a <b=
r>
custom structure to reduce the number of arguments that need to be set <br>
in the lTTNG_UST_TRACEPOINT_ARGS macro.<br>
<br>
eg.<br>
<br>
```<br>
LTTNG_UST_TRACEPOINT_EVENT(<br>
=C2=A0 =C2=A0 tp,<br>
=C2=A0 =C2=A0 many,<br>
=C2=A0 =C2=A0 LTTNG_UST_TP_ARGS(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct Sample*, mystruct<br>
=C2=A0 =C2=A0 ),<br>
=C2=A0 =C2=A0 LTTNG_UST_TP_FIELDS(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0lttng_ust_field_integer(int, a, mystruct-&gt;a)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0lttng_ust_field_integer(int, b, mystruct-&gt;b)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0lttng_ust_field_integer(int, c, mystruct-&gt;c)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0lttng_ust_field_integer(int, e, mystruct-&gt;d)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0lttng_ust_field_integer(int, f, mystruct-&gt;e)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0lttng_ust_field_float(double, g, mystruct-&gt;g)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0lttng_ust_field_float(double, h, mystruct-&gt;h)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0lttng_ust_field_float(double, i, mystruct-&gt;i)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0lttng_ust_field_float(double, j, mystruct-&gt;j)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0lttng_ust_field_float(double, k, mystruct-&gt;k)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0lttng_ust_field_string(string_field, mystruct-&g=
t;thing)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0lttng_ust_field_string(string_field2, mystruct-&=
gt;thing2)<br>
=C2=A0 =C2=A0 )<br>
)<br>
<br>
```<br>
<br>
Hope this helps!<br>
<br>
thanks,<br>
kienan<br>
<br>
On 2023-11-27 22:26, Yonghong Yan via lttng-dev wrote:<br>
&gt; I have a situation where I need to record more than 10 fields. If you =
<br>
&gt; can extend it to support more, but not introduce overhead of handling =
<br>
&gt; such rare cases, that will be great.<br>
&gt; <br>
&gt; Thanks<br>
&gt; Yonghong<br>
&gt; <br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
</blockquote></div>

--000000000000965c4d060b54e4ee--

--===============0408751637798179146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0408751637798179146==--
