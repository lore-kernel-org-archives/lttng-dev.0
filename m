Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7165CD1284
	for <lttng-dev@archiver.kernel.org>; Fri,  5 Apr 2024 02:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1712285813;
	bh=QZINdcaVIAkzXI2iqOXmA9/r7L/FfACcgizbVElQSC4=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Pd2fwMDuQ1RNfgsMhAZ4GjiRSCYnCR/82mKZkGBC8GOaT5tKXksncZPhCBajwsSjJ
	 AxEv2DN8BThT0JL+sc/FK1i7Xo/+cDpT5fPmf2FkjYWafTwdpNd+LZ2JQw3t43JlM6
	 J2G/ofOL4pw+CEJZfS2bRPQXPRvdtP7WMxyM2sZmuusBBWGil2SfZrK1VYt+LhHjk6
	 OnfFvrNTCBov0P15AUmsKGxvrg0OsmUt/Ax1pyzIt39Hq8o0F/r50ZTO65jjviGYw2
	 sIpeOjd2sc/0G+DgGq4jmNm1snClKZXXXMVXJRmafctwX1/z6vEMAvkiYv5zwjDVS+
	 /2Up0ihH9HIMw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4V9jnK27SMz2bRj;
	Thu,  4 Apr 2024 22:56:53 -0400 (EDT)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by lists.lttng.org (Postfix) with ESMTPS id 4V9jnJ0X13z2bRg
 for <lttng-dev@lists.lttng.org>; Thu,  4 Apr 2024 22:56:52 -0400 (EDT)
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-516d2600569so802400e87.0
 for <lttng-dev@lists.lttng.org>; Thu, 04 Apr 2024 19:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712285810; x=1712890610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vC9Lj8SIJAq7RxaugcboS60ZahNKsalqJQxRH2ddUqI=;
 b=q3nZH4DyPyzt/yeV25RZOSxwBFnRIX+jyC+w0PJ5R3HQ5Of+dbsPp0f8578Yld8FD0
 QEgDKmW/E1SCRnH/QnHy9FtmJvaUf9u48ot1QYVlvaqjHEHceO5pb3VnLur9aSHRVQ2r
 Gvs3u7dbjBYegy0Wvc3kCMAwlz4phn+3oV3uPEqRIWE0B2HJZE2tllWKbVnWDNfEQzt8
 zhyNJejv3L6g7Ll3o1MjRjcm1fIkRva5aU95SMDuyISUB25aiIfP1uFWO7A2SUkbQtTX
 Wn5eXgEn4h7SApPc1K+sWXcj2v3mtboaZgprKRHWCr4W6sRdhg9BHSsRFB1Xea8kgCUY
 mtJw==
X-Gm-Message-State: AOJu0YyCvHIXVRAUNNmPMmWIq8Z0lRkhlwAVJNITxu2GIfGkTklrJM78
 cGKux41YbHpMGkMhxWRuRPHDgq9ZIXR08E7Ll7N2b7htt8HrJSHfhQI/gRykKZWvxtSL7kdCmFY
 lv8ER/1NU5mYFq1l8KnplDrAoTLyxPoqU
X-Google-Smtp-Source: AGHT+IHvU/htu36bDl4x2UuucCi2uXljVZtCKWwVGCbSwjLiwEGHBdlEO3e2+lvLNfCtE80KI+auBw3kV/DYGgGrZbo=
X-Received: by 2002:a19:2d07:0:b0:512:cc50:c3e0 with SMTP id
 k7-20020a192d07000000b00512cc50c3e0mr116774lfj.52.1712285810056; Thu, 04 Apr
 2024 19:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <CABRndgyg2U-N9s5HtM1V=t89sBsr5Jt1LXbE3M+6e1=tNy3y9A@mail.gmail.com>
 <3fab293c-8714-4533-ab8d-942b81ec294d@efficios.com>
In-Reply-To: <3fab293c-8714-4533-ab8d-942b81ec294d@efficios.com>
Date: Fri, 5 Apr 2024 05:56:38 +0300
Message-ID: <CABRndgzwUOUyw0OYVF5dCjg1BhZO9bo_+ZyVrTRqRj-SYi2bUg@mail.gmail.com>
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] babeltrace2 on windows
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
Content-Type: multipart/mixed; boundary="===============6748174719572498377=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6748174719572498377==
Content-Type: multipart/alternative; boundary="0000000000007668110615509b40"

--0000000000007668110615509b40
Content-Type: text/plain; charset="UTF-8"

Thank you for your reply.
Zvika

On Thu, 4 Apr 2024, 23:30 Kienan Stewart via lttng-dev, <
lttng-dev@lists.lttng.org> wrote:

> Hi Zvika,
>
> babeltrace2 with the python bindings can be built on windows. Our CI
> does this in two environments: cygwin64 and msys2-ucrt64.
>
> thanks,
> kienan
>
>
> On 4/4/24 4:08 PM, Zvi Vered via lttng-dev wrote:
> > Hello,
> >
> > I'm required to analyze an lttng trace with Babeltrace2 python API.
> > The host is running windows 10.
> > But according to : https://babeltrace.org/#bt2-get
> > <https://babeltrace.org/#bt2-get>
> > Windows is not mentioned at all.
> >
> > I prefer python but I can also consider using the C library for windows.
> >
> > Thank you,
> > Zvika
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--0000000000007668110615509b40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thank=C2=A0you for your reply.<div dir=3D"auto">Zvika</di=
v></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Thu, 4 Apr 2024, 23:30 Kienan Stewart via lttng-dev, &lt;<a href=3D"ma=
ilto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">Hi Zvika,<br>
<br>
babeltrace2 with the python bindings can be built on windows. Our CI <br>
does this in two environments: cygwin64 and msys2-ucrt64.<br>
<br>
thanks,<br>
kienan<br>
<br>
<br>
On 4/4/24 4:08 PM, Zvi Vered via lttng-dev wrote:<br>
&gt; Hello,<br>
&gt; <br>
&gt; I&#39;m required to analyze an lttng trace with Babeltrace2 python API=
.<br>
&gt; The host is running windows 10.<br>
&gt; But according to : <a href=3D"https://babeltrace.org/#bt2-get" rel=3D"=
noreferrer noreferrer" target=3D"_blank">https://babeltrace.org/#bt2-get</a=
> <br>
&gt; &lt;<a href=3D"https://babeltrace.org/#bt2-get" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">https://babeltrace.org/#bt2-get</a>&gt;<br>
&gt; Windows is not mentioned at all.<br>
&gt; <br>
&gt; I prefer python but I can also consider=C2=A0using the C library=C2=A0=
for=C2=A0windows.<br>
&gt; <br>
&gt; Thank you,<br>
&gt; Zvika<br>
&gt; <br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank" rel=3D"=
noreferrer">lttng-dev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.lttng.org/cg=
i-bin/mailman/listinfo/lttng-dev</a><br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank" rel=3D"noref=
errer">lttng-dev@lists.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi=
n/mailman/listinfo/lttng-dev</a><br>
</blockquote></div>

--0000000000007668110615509b40--

--===============6748174719572498377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6748174719572498377==--
