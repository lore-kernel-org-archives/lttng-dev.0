Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2A5C4345F
	for <lttng-dev@archiver.kernel.org>; Mon, 15 Apr 2024 18:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1713206309;
	bh=2mSUoX+w7DWRaHZnspypMIQwxyimf6JXHSB2hgp8oMw=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=NuJ2quXP8hz+zh0jQUec3Xedv1ljUdnNFPNH0Hd5Fo0uicJPY+cM2FcQWVZugJPcA
	 VEVCQZi/DfkB0GUJhEjVaAx4OAMT7P1BtZiA+3VD+7+6HLTXzlbU5x+xWeJECGCxya
	 OxwnOuNU9TtReLVpGVu6lMTEE90eljGSnkHBpOwCo/KnLncvmTE41MNClMu0+amiA6
	 Vh9eb5fTeK0/teqQeJ+uSK0/2MMZT+fS5AjzX2vQ6qhPxE28r13+uCpzp5tfqECIy1
	 0nWIFZSTVjrQkFTBvq2y7g9sqW3w1141R+xUbQuF8hnedCrgdM4BSZ8IM+YosBK92S
	 GV4WObS9LNHuA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VJGC90w2Pz2gvP;
	Mon, 15 Apr 2024 14:38:29 -0400 (EDT)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by lists.lttng.org (Postfix) with ESMTPS id 4VJGC82TpJz2h34
 for <lttng-dev@lists.lttng.org>; Mon, 15 Apr 2024 14:38:28 -0400 (EDT)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d82713f473so61534021fa.3
 for <lttng-dev@lists.lttng.org>; Mon, 15 Apr 2024 11:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713206307; x=1713811107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SVYhyQtRgJI1mvwwe8TwL5huOmCwzMlHIpoCpKOhquI=;
 b=sp3XVXA85EVdKv+eSLULOjF4g1R+bUtK76vN3md/JiRPClC3n/QT1Tj/kLZjNs5GKe
 7E+JeAMND/4rbDzV1Bu/LMtCl5fOWMj0PiLIKfWHN+Ex7lUjB5WCDGXsDYsbquRh0Vg8
 cvX9PziwOl4Ei4aUKILfAhKXXGTlErM9vbivBZzerGBfKpFGH+K4EgGGmRAtVsIdluAv
 /L2LdniLbQJTbejlzgauvLuQITa0QDuDJ5A/DRXW4KUGewfa1HWHvNWfATUngldKiYhL
 MZ9IgctWvs9HdLshLZYXfP4bj8Bx6LQJQtkDS/K+Wsf1pae/L2pF35URaUpaK3++NwyR
 zngg==
X-Gm-Message-State: AOJu0Yz6sIe33xjGidsTylf5NHl+7W2wyJ9EFdhOP3MnI8SLEoRKTYLi
 1w7VOJfAOlG8M8+7qqJgWnn9zg/6KZyiCS+0R623gRKsfmo1YlV13LV6RZGwV2KVotU/nN6d8Hg
 K2FKmDbpRMIbQhkhrePnM4qjqmEU=
X-Google-Smtp-Source: AGHT+IF/OyJZb+U4uHlJoR7a6UwAfO8B+e0W2+OLW9D8uQ3tw0ZBSjf0LMa833OCcU1clT2wdnrv5ovQJ3MFGLJpeGg=
X-Received: by 2002:a2e:9b8e:0:b0:2d4:676b:f591 with SMTP id
 z14-20020a2e9b8e000000b002d4676bf591mr8045917lji.45.1713206306344; Mon, 15
 Apr 2024 11:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <CABRndgyC1hMY5vkJjBpPc_GSaSwCaDBc0KhmykOF4Sjthk_FLA@mail.gmail.com>
 <6e1feec7-7b25-4654-af4b-7ed942e4accb@efficios.com>
In-Reply-To: <6e1feec7-7b25-4654-af4b-7ed942e4accb@efficios.com>
Date: Mon, 15 Apr 2024 21:42:45 +0300
Message-ID: <CABRndgwjUxyj0Qzxynd=c8KET1zS744F678er8m7qY_LE1DJVA@mail.gmail.com>
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Monitor user space threads without user events
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
Content-Type: multipart/mixed; boundary="===============2203989287665634391=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2203989287665634391==
Content-Type: multipart/alternative; boundary="0000000000005118a2061626ed4e"

--0000000000005118a2061626ed4e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kienan,

Thank you very much !
Zvika

On Mon, Apr 15, 2024 at 9:25=E2=80=AFPM Kienan Stewart via lttng-dev <
lttng-dev@lists.lttng.org> wrote:

> Hi Zvika,
>
> with a session that has kernel events enabled, I think you could use the
> sched_switch event.
>
> thanks,
> kienan
>
> On 4/6/24 12:20 AM, Zvi Vered via lttng-dev wrote:
> > Hello,
> >
> > My user space process contains 2 threads:
> >
> > First thread is blocked upon a kernel event created by a hardware
> > interrupt handled by the kernel.
> > The  thread is sending ioctl which is blocked till this interrupt occur=
s.
> >
> > Second thread has just a 5msec sleep. It does something and then sleeps
> > for 5msec. Forever.
> >
> > Is it possible to see when each thread is running (and not blocked or
> > sleeps) ?
> > I know how to do it with user events. I wonder if it's possible without
> > any extra code.
> >
> > Thank you,
> > Zvika
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

--0000000000005118a2061626ed4e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Kienan,<div><br><div>Thank you very much !</div></div><=
div>Zvika=C2=A0</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Apr 15, 2024 at 9:25=E2=80=AFPM Kienan Stewart=
 via lttng-dev &lt;<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@l=
ists.lttng.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Hi Zvika,<br>
<br>
with a session that has kernel events enabled, I think you could use the <b=
r>
sched_switch event.<br>
<br>
thanks,<br>
kienan<br>
<br>
On 4/6/24 12:20 AM, Zvi Vered via lttng-dev wrote:<br>
&gt; Hello,<br>
&gt; <br>
&gt; My user space process contains 2 threads:<br>
&gt; <br>
&gt; First thread is blocked upon a kernel event created by a hardware <br>
&gt; interrupt handled by the kernel.<br>
&gt; The=C2=A0 thread is sending ioctl which is blocked till this interrupt=
 occurs.<br>
&gt; <br>
&gt; Second thread has just a 5msec=C2=A0sleep. It does something and then =
sleeps <br>
&gt; for 5msec. Forever.<br>
&gt; <br>
&gt; Is it possible to see when each thread is running (and not blocked or =
<br>
&gt; sleeps) ?<br>
&gt; I know how to do it with user events. I wonder if it&#39;s possible wi=
thout <br>
&gt; any extra code.<br>
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
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</a><br>
</blockquote></div>

--0000000000005118a2061626ed4e--

--===============2203989287665634391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2203989287665634391==--
