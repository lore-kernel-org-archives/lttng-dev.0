Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C62C6FD20
	for <lttng-dev@archiver.kernel.org>; Fri, 24 Mar 2023 10:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679654717;
	bh=+ISEY2UMiwjHuTRIF9q/bgpwwN0Lint+FMZeKSG1X+M=;
	h=References:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=jeaxpWaBHsso+aXDdNgxic//lhORw+BP+TcFB7ncDPlYQdw54jV3v22lubYNY3P08
	 awIzQhK7A8Vb5r5CzUdLAoL4ZIvZ/dqjlj3MyHrSOmM+MspIUSpH3echCvvD+5+SXk
	 UnECPKBdHMgNA6K8rBhUR3gy8MHmumrAQL8GXQ/awhWyAax1fxNApWKYR8Qow+r2rm
	 PZxBRDyU4gGQmPkjo5dHyx31ImP7OFmF2RkGWDb0/pd9utMLId1055Uq/CaEcnRxTK
	 4IF/cJMyKYz8GNZR5N1vPv2YuIMKS/YgLJjRZF60iCOmNUEHwUHE0XomxiXchZR1CT
	 WtZO/+ocWsfSA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Pjf4D2tBWz2JNw;
	Fri, 24 Mar 2023 06:45:16 -0400 (EDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by lists.lttng.org (Postfix) with ESMTPS id 4Pjf4B5n3Xz2J9Q
 for <lttng-dev@lists.lttng.org>; Fri, 24 Mar 2023 06:45:13 -0400 (EDT)
Received: by mail-ed1-f48.google.com with SMTP id b20so6253759edd.1
 for <lttng-dev@lists.lttng.org>; Fri, 24 Mar 2023 03:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679654652;
 h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XaxWFENJFRSXlS+xR3LAd//IA2jP0L7waHBugwyZbxY=;
 b=USLfME4JKT+7y04YFraZtp+tYKTYZPTfJ6IC9NT0YO+/SvtKHS1cXFMNswFXnv8g4g
 16ev777ny/LFiql33jQ3t9b4BUnWUD+6Ryc4Fcki0cLKTjoGAzW/Zk+14d7VCxw3x0CH
 eQjSvQJAz2zOe7/jIc4BPZjIfY45/WG3etNxPAORSMFGrg01QgYQcQeRtArCly143X9/
 hkiPJnlE5XSj4VZpf8xJEXIM1n2p59155d0rKrCQXqF+7qNUXBmqeMuI4wo0+WL9fbG0
 eAGK70xjJj9kPlEJTHJHmaWZmCYxIGGeQMypDFFUKI1avCmEPbS/3CFHxYzaRdOvpD4p
 fpZw==
X-Gm-Message-State: AAQBX9eaPeL+b6l9F+xcGzVm2EkjFt2/Ja+xgsLNDsJzzhXzpsPMuqIg
 z1qwj/aMYSOHwBwphcgK++zOwpBt5Dx7sSw+X0ZdBWpns5c=
X-Google-Smtp-Source: AKy350Y1+B5PtF39Jmfu7DpK4LMrH8OHD5ONMezorF4/6/Lx7YpmNdNr+XGOgGnf2U7f0+mALt8u5jBiz8fkenZ7xcY=
X-Received: by 2002:a17:906:4f1a:b0:930:528b:91e5 with SMTP id
 t26-20020a1709064f1a00b00930528b91e5mr1164837eju.4.1679654651927; Fri, 24 Mar
 2023 03:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_9pdTicspLuNH8UJ6=sSXuhHKLQOcq7GQC-NA0nmqSYENDzA@mail.gmail.com>
 <CAL_9pdS6dGZ6idu1wAeWrcPrKWdErJ3Rmx5HhdCxNdyy23WAMQ@mail.gmail.com>
 <799cf4da-5f0b-f280-cf79-2b17e644e78d@efficios.com>
In-Reply-To: <799cf4da-5f0b-f280-cf79-2b17e644e78d@efficios.com>
Date: Fri, 24 Mar 2023 18:44:00 +0800
Message-ID: <CAL_9pdTYXaGOuB_nYRheAXV61+yGH5AYm9HVxMPGk3tD-K-gLg@mail.gmail.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Fwd: how to disable local file writing in relayd?
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
From: Yuan Bin via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Yuan Bin <elf.ggle@gmail.com>
Content-Type: multipart/mixed; boundary="===============6316493648593829195=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6316493648593829195==
Content-Type: multipart/alternative; boundary="000000000000dfa0be05f7a312f3"

--000000000000dfa0be05f7a312f3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yeah, i haven't received the  reply before.

Thanks for your answer !

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> =E4=BA=8E2023=E5=B9=B43=
=E6=9C=8822=E6=97=A5=E5=91=A8=E4=B8=89 21:25=E5=86=99=E9=81=93=EF=BC=9A

> On 2023-03-22 02:39, Yuan Bin via lttng-dev wrote:
> >
> >
> >   Can I disable local-file-writing in lttng-relayd to avoid the disk
> > space overhead, only using it as a live viewer?
> >
>
> I am not sure why you bump this email thread. I already answered here.
> Perhaps you did not receive my reply ?
>
> https://lists.lttng.org/pipermail/lttng-dev/2023-March/030358.html
>
> Thanks,
>
> Mathieu
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>
>

--000000000000dfa0be05f7a312f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yeah, i haven&#39;t received=C2=A0the=C2=A0 reply=C2=A0bef=
ore.<div><br>Thanks for your answer !=C2=A0</div></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Mathieu Desnoyers &lt;<a h=
ref=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.co=
m</a>&gt; =E4=BA=8E2023=E5=B9=B43=E6=9C=8822=E6=97=A5=E5=91=A8=E4=B8=89 21:=
25=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On 2023-03-22 02:39, Yuan Bin via lttng-dev wrote:<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0Can I disable local-file-writing in lttng-relayd to avoid =
the disk <br>
&gt; space overhead, only using it as a live viewer?<br>
&gt; <br>
<br>
I am not sure why you bump this email thread. I already answered here. <br>
Perhaps you did not receive my reply ?<br>
<br>
<a href=3D"https://lists.lttng.org/pipermail/lttng-dev/2023-March/030358.ht=
ml" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/pipermail/=
lttng-dev/2023-March/030358.html</a><br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"https://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.efficios.com</a><br>
<br>
</blockquote></div>

--000000000000dfa0be05f7a312f3--

--===============6316493648593829195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6316493648593829195==--
