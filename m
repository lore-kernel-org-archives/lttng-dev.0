Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4F5C433EF
	for <lttng-dev@archiver.kernel.org>; Thu, 20 Jan 2022 15:31:17 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Jfmgm06fWzKtY;
	Thu, 20 Jan 2022 10:31:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642692676;
	bh=VWICJ0m26krmLUoowlObvPU8bvH132ypcecR5H3VOwA=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rNTn+NEC5q1OxHW6wv/v8WdvplHAuVswB/tS9Pr/dEeRHK+9v2yMXxqSV67hOMjAQ
	 Iwwq8C65jlzgCBmDuHs7/jJX3pZOoQg5ix+quaFWlFYOlBeXKALJF5iMhAHcLkIxbe
	 TMafV5AVaB+VnvHOK6L6lFpLA84Jb2eerM6HZ3kJT4BfouASYV+LWuEaOUxYJSNTp0
	 UXiQqSMupk2h72qmNnM/1S0ybCXguByabeMarbP051V8pmuWXsRXSAY2trlsfvdksO
	 tMAXIQ/fQTF1toiIvGaaK2gh+k2cY5K7UlvWf/in37OZUHGoS5qM+lSiB3huPDsltB
	 R8/jrQey1i1fw==
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by lists.lttng.org (Postfix) with ESMTPS id 4JfmbF3ltGzKg4
 for <lttng-dev@lists.lttng.org>; Thu, 20 Jan 2022 10:27:21 -0500 (EST)
Received: by mail-oi1-x22e.google.com with SMTP id x193so9464084oix.0
 for <lttng-dev@lists.lttng.org>; Thu, 20 Jan 2022 07:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QBuiNKfKfAuwqbNfgV0uQwvTGnVo2quKLDwQ9fIeilE=;
 b=1XqxQwZbKD5ijGRH3IFu+I6Hu1gx8knf3hGAWWCHn49hDLycP8/AAqFXQvFIBL3y6s
 72EWvnOnPQ4IQ2L6f6bKv5PPTXMKm/bqsBucfIZdX6nUirQ9k7sJ1wV7KOXhukXg5dNX
 nlBLbesYYTEChxPAF9ox5IvvtPtDuJVNx2fFldsxmHM+AJv1sDV874sPZJnyiNhoQqdG
 dSds1p5QOcPIOgQTEreaPAQgIaORGPougsbq1dUgzzZXtGm0luKRwfTRmlrhCIGXm21f
 RSfkN8HS5S842Jf91OdY+nlPIje1XAsbDhW+ix1laVtyc2K6rduNaRuWFHqbvjs1BMaX
 cYVQ==
X-Gm-Message-State: AOAM533TwJxduq2bqEVC517DO3qp6kGHVRsL+9MSygFXCpj105tyYWsg
 gnmxe2HhEBUUJGXDqT7FEnZqPo7uT2pclw6/InsnCYSf
X-Google-Smtp-Source: ABdhPJwrVL+ouutfmL7JLT636VbsuPXv7xQCFLlfcpq2h+vITiLyy27tkErAVCgs1ACo2bwaLKAKFBUjzx9PGdxoSHM=
X-Received: by 2002:a54:4002:: with SMTP id x2mr7825480oie.42.1642692440584;
 Thu, 20 Jan 2022 07:27:20 -0800 (PST)
MIME-Version: 1.0
References: <1245543732.61838.1642692243480.JavaMail.zimbra@efficios.com>
In-Reply-To: <1245543732.61838.1642692243480.JavaMail.zimbra@efficios.com>
Date: Thu, 20 Jan 2022 10:27:09 -0500
Message-ID: <CAF4oYfHpbscApq7SxhNAy5MXN9h9=HP9rkgpWTmXH-+8ktbm2g@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jonathan Rajotte-Julien <joraj@efficios.com>,
 Jeremie Galarneau <jgalar@efficios.com>, 
 lttng-dev <lttng-dev@lists.lttng.org>
X-Mailman-Approved-At: Thu, 20 Jan 2022 10:31:13 -0500
Subject: Re: [lttng-dev] Transfer of LTTng copyright ownership: Jonathan
 Rajotte-Julien
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Jonathan Rajotte via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Content-Type: multipart/mixed; boundary="===============2865864916797653781=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2865864916797653781==
Content-Type: multipart/alternative; boundary="00000000000065750a05d6052354"

--00000000000065750a05d6052354
Content-Type: text/plain; charset="UTF-8"

Yes. I agree.



On Thu, Jan 20, 2022 at 10:24 AM Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Hi Jonathan,
>
> In order to facilitate maintenance of the LTTng project, would you agree to
> transfer your copyright ownership for code authored outside of your
> employment
> at EfficiOS to EfficiOS Inc. ?
>
> This particularly affects the lttng-tools files with copyright:
>
>   Copyright (C) 201N Jonathan Rajotte <jonathan.r.julien@gmail.com>
>
> Thanks!
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>


-- 
Jonathan Rajotte Julien

--00000000000065750a05d6052354
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Yes. I agree.<br></div><div><br></div><div><br></div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Thu, Jan 20, 2022 at 10:24 AM Mathieu Desnoyers &lt;<a href=3D"mailto:ma=
thieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Jonathan,<br=
>
<br>
In order to facilitate maintenance of the LTTng project, would you agree to=
<br>
transfer your copyright ownership for code authored outside of your employm=
ent<br>
at EfficiOS to EfficiOS Inc. ?<br>
<br>
This particularly affects the lttng-tools files with copyright:<br>
<br>
=C2=A0 Copyright (C) 201N Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.r=
.julien@gmail.com" target=3D"_blank">jonathan.r.julien@gmail.com</a>&gt;<br=
>
<br>
Thanks!<br>
<br>
Mathieu<br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Jonathan Rajotte Jul=
ien<div><br></div></div></div></div></div>

--00000000000065750a05d6052354--

--===============2865864916797653781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2865864916797653781==--
