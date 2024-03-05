Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07987C54E41
	for <lttng-dev@archiver.kernel.org>; Tue,  5 Mar 2024 19:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1709665893;
	bh=3E8kisMO+HpZi+XeEoaCLrt36uKbufuJGHjt2reWs7k=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=CdjLI3Z7pWv1SVMwWXXQ0x83W+wy7g8VIPIjLd3wfKb4drr3u0iXFRhDrauWTvjoF
	 rq2Wg8zzAdHC4p1GtAA4hBWjBdX9FbtshNOkwnrfQUYhSj4jngmh6kMJXHEHc9Bula
	 Q+IaH4ctz+QkqSJEoERsIDuFlftev22NxpoiVrY1P1YmLeDhc/lXGBaTRHV79U5WI2
	 DcEjaR4MNY99sf7tVn8IZyAYECwLccOog6GCdHGy3AHhMSlJUbLWvQ3u/56Ve4L3v1
	 zyp2bzMwdAhCTCDY1wvbLj0KzrE8Nr96Q0sTINtNIDnn1WiA3OrulvBBQJgVvTU52H
	 FhTM03+sZIbYQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Tq4tF0QnMz2FrD;
	Tue,  5 Mar 2024 14:11:33 -0500 (EST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by lists.lttng.org (Postfix) with ESMTPS id 4Tq4tC5sk2z2FZ2
 for <lttng-dev@lists.lttng.org>; Tue,  5 Mar 2024 14:11:31 -0500 (EST)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d220e39907so91262601fa.1
 for <lttng-dev@lists.lttng.org>; Tue, 05 Mar 2024 11:11:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709665890; x=1710270690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i9txF3e1agaEjrXzfkV+FqnrHpK+mDCSVRogviT0u5o=;
 b=GYd+vvXpTxd3JFWT3rv8f9n7mPjWpAh1nsGakVZaz09mXWk2oEczi7QdhFQ3OtI35E
 mrHbZ0b+yIGXrmVvrV/U1/m62US/1hAXkK70V7u8g/3OH03IYBJhwOhaQ98Il1sRK9HX
 QBORV3P70Z0c9RMAyx6G5Fi8+KA0Kg7T/5KG+ezPdGRjebC96zPHb3jSMmUle8XVsjNU
 ab1u8yccRf4s13MfaRo47tbQGxWwO6z/EnpKfXZoe4DVBkHV6mpYSRd1HOLak1j+b5EQ
 Aq8Qu7cy+8OVB/Ez1N7+3hD3vYuUdBGqIqkXBzaq7XhAO2g3zGcuFGUv1ZWugBPBnF79
 gOzw==
X-Gm-Message-State: AOJu0Yy5YKompM+mXIC36MHp2071tVHqV9l/6sjiMWBcugR7nc8pgpEh
 wh4LPZXpZbT2G8A/CgOq0m0ooE+n1FXSqttNmJBXY6p8NrdHI0nP5RvepdQTvdhBnDCliNI4C0k
 Ca2Wifdq3/bmOeGwuKy4LN4NlfReRWl4W
X-Google-Smtp-Source: AGHT+IG6A4tGphq3o8bxGCsVui8TJa8D5nqytrKlMmMaGBV2rStAawhrFmrW4uhiVgadxMUR3YdbFyKT8jUM5FdEPjY=
X-Received: by 2002:a2e:86d3:0:b0:2d3:1ce6:1f5e with SMTP id
 n19-20020a2e86d3000000b002d31ce61f5emr2181851ljj.18.1709665889668; Tue, 05
 Mar 2024 11:11:29 -0800 (PST)
MIME-Version: 1.0
References: <CABRndgwfhU-e1a7f8dFSwV5Pny4cuEeqbhA_4GCkKK=574bVBA@mail.gmail.com>
 <8a7e39ec-f8d8-4f75-b345-81154fffc1ee@efficios.com>
In-Reply-To: <8a7e39ec-f8d8-4f75-b345-81154fffc1ee@efficios.com>
Date: Tue, 5 Mar 2024 21:14:47 +0200
Message-ID: <CABRndgzfxHsGaq2sSk=ZhWehqHu9RoFMNDTbcCyQw8JxNECUNQ@mail.gmail.com>
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] tracing user event from multiple dockers
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
Content-Type: multipart/mixed; boundary="===============7367401856458516125=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============7367401856458516125==
Content-Type: multipart/alternative; boundary="00000000000009d6700612ee9cfc"

--00000000000009d6700612ee9cfc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kienan,

Thank you very much !

Best regards,
Zvika

On Mon, Mar 4, 2024 at 5:11=E2=80=AFPM Kienan Stewart <kstewart@efficios.co=
m> wrote:

> Hi Zvika,
>
> To share a sessiond the LTTng home and run directories, and the shared
> memory should be shared between the containers.
>
> Eg.
> https://github.com/mjeanson/gcloud-lttng/blob/master/pods/demo1.yaml.in
>
> In a scenario with multiple sessionds (eg. one per container), the
> traces could be combined in post using babeltrace.
>
> thanks,
> kienan
>
>
> On 3/2/24 12:31 AM, Zvi Vered via lttng-dev wrote:
> > Hello,
> >
> > I have an application working with multiple dockers.
> > Each docker is a fedora O.S running an application.
> > The host is centos 8.5. This host will be upgraded to RHEL 9.2 in the
> > near future.
> > Is it possible that all traces from multiple dockers will all be writte=
n
> > to one metadata ?
> >
> > versions:
> > lttng-tools-latest-2.13.tar.bz2
> > lttng-ust-latest-2.13.tar.bz2
> > userspace-rcu-latest-0.14.tar.bz2
> >
> > Thank you,
> > Zvika
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--00000000000009d6700612ee9cfc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Kienan,<div><br></div><div>Thank you very much !</div><=
div><br></div><div>Best regards,</div><div>Zvika=C2=A0</div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 4, =
2024 at 5:11=E2=80=AFPM Kienan Stewart &lt;<a href=3D"mailto:kstewart@effic=
ios.com">kstewart@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Hi Zvika,<br>
<br>
To share a sessiond the LTTng home and run directories, and the shared <br>
memory should be shared between the containers.<br>
<br>
Eg. <a href=3D"https://github.com/mjeanson/gcloud-lttng/blob/master/pods/de=
mo1.yaml.in" rel=3D"noreferrer" target=3D"_blank">https://github.com/mjeans=
on/gcloud-lttng/blob/master/pods/demo1.yaml.in</a><br>
<br>
In a scenario with multiple sessionds (eg. one per container), the <br>
traces could be combined in post using babeltrace.<br>
<br>
thanks,<br>
kienan<br>
<br>
<br>
On 3/2/24 12:31 AM, Zvi Vered via lttng-dev wrote:<br>
&gt; Hello,<br>
&gt; <br>
&gt; I have an application working with multiple dockers.<br>
&gt; Each docker is a fedora O.S running an application.<br>
&gt; The host is centos 8.5. This host will be upgraded to RHEL 9.2 in the =
<br>
&gt; near future.<br>
&gt; Is it possible that all traces from multiple dockers will all be writt=
en <br>
&gt; to one metadata ?<br>
&gt; <br>
&gt; versions:<br>
&gt; lttng-tools-latest-2.13.tar.bz2<br>
&gt; lttng-ust-latest-2.13.tar.bz2<br>
&gt; userspace-rcu-latest-0.14.tar.bz2<br>
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

--00000000000009d6700612ee9cfc--

--===============7367401856458516125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7367401856458516125==--
