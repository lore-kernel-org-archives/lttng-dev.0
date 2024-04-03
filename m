Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6B6C6FD1F
	for <lttng-dev@archiver.kernel.org>; Wed,  3 Apr 2024 03:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1712116118;
	bh=WcevrMO2Lw4s/LH8fAkHo4+DuY2y3s2ueBQfcvt6XPI=;
	h=References:In-Reply-To:Date:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=e0zxPYo4jge2sdcBIFckNi7O3FgiyubG6gqbeRmSyJHkeRnRFrPITtjj89yI//muv
	 EZq9wgQPMGMfE13o2A++PWouSSX72q8miK5XL2Kq/BDuIx9j3J2rI0TNLEztSmUJXd
	 H1dQRetpg8Z1IVRrtwiV+qnx9LSLPL2BJXplNLGxxK3McHcP6lErdl0cIkeU8kr5Ra
	 4+2/5+MQChRrATLUj7ApdLiQHkKyOHlYlJk56llEuWj6mHAmmxuRcBIUxX9YBU28xh
	 WXSb0uSrOrJZX96pen6x6M2K52VgRhFn2X5pzmwSstmJZYLlGoCBExFF7DXb3nqTQg
	 iK7y+wcGPrXEA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4V8W1y0BGsz2ZpR;
	Tue,  2 Apr 2024 23:48:38 -0400 (EDT)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 by lists.lttng.org (Postfix) with ESMTPS id 4V8W1v5bYkz2Zg5
 for <lttng-dev@lists.lttng.org>; Tue,  2 Apr 2024 23:48:35 -0400 (EDT)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d48f03a8bbso4602821fa.0
 for <lttng-dev@lists.lttng.org>; Tue, 02 Apr 2024 20:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712116114; x=1712720914;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3QM5RgD/yPYxpmgQZjP2CFSXOSewwExhWFj6N17tFRI=;
 b=vdg4aru6TWeV5QxnROhe2XSTTx+OpaJhHwZ+ncnAHOPDpfy/R/8KopMNwAAoaRlZUu
 CxJVx4xtdUFykOadcxeFXueQW0B+suseiOAgN/XPYcpsdDTgmKWihU9v8sDMQ0xccECa
 SDRXToyIwgzzWgYIKshf/omwfB+ckV0eO4wnQr+OgIW316xnRbZ79HvVY4cuPr2Wh9Zb
 bHDGGtUm8Mvv5NwAAacid1pzq5bp8DB1Hox/bSIX+XUWhkVtrXn/9xgscQE/ea3Hxeyi
 SVzc23r5Z5GB9f/tdRVP6TyCAqcYZw46p0OBba8uWMTSXeSBVI81MxyTKz52LN12NziM
 BGXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6CyHpQtgEQroC1XLeC8Fzgz/4vrBh6Y0YOvaosdJo6phlZ7kTkg0/H2N9sL2DtSHvek+4fxdMiEy8JeteMKvmU6jyUQbvw1jU
X-Gm-Message-State: AOJu0Yw/doF339dnQgIsRxR9rPD3EJ+QE6X+jbhR6yPyS4sWBNtune60
 vvuxJLQ+YcjJwtF9dKLpO/Ew1MfqzTAb/UqHP/Ab1QH/lW9vKe+00gdoe0o/xghFrOcWER7uAT0
 wNiyEjNZ9FItXlugLFBwN9/PwErJj+mQD
X-Google-Smtp-Source: AGHT+IFfISu283meOA7o+5YUPMJnfHjRKH7AWy+T5lvDkNRG+xlFoRS7CniknYHiRROIntVc3v1xx/Q8wLdukC/cpvc=
X-Received: by 2002:a05:651c:203:b0:2d8:3f1c:9978 with SMTP id
 y3-20020a05651c020300b002d83f1c9978mr99907ljn.17.1712116114106; Tue, 02 Apr
 2024 20:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <CABRndgz2BHX9LubVXoaJxLH+KoYfgzQ0XzY=xHG60+HoO-Tm7A@mail.gmail.com>
 <a128a334-b2d8-4cec-ae40-91e1384a228d@app.fastmail.com>
 <CABRndgy8RJ-rkszYGpvnqJ6oth35ajJhWgF8T4aWFEFjZiBz0g@mail.gmail.com>
 <5d588684-17f3-4b96-aafd-9ff6728b2ddd@efficios.com>
In-Reply-To: <5d588684-17f3-4b96-aafd-9ff6728b2ddd@efficios.com>
Date: Wed, 3 Apr 2024 06:52:33 +0300
Message-ID: <CABRndgzUxjE1=KmfxNV2gn7g43A91WV8s8-ncFK3ekQWWrQGoQ@mail.gmail.com>
To: Erica Bugden <ebugden@efficios.com>
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
Cc: lttng-dev@lists.lttng.org
Content-Type: multipart/mixed; boundary="===============8832932647651679548=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8832932647651679548==
Content-Type: multipart/alternative; boundary="000000000000cbb3c90615291854"

--000000000000cbb3c90615291854
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Erica,

Thank you very much for your answer.
Can you please tell what is the added value of ftrace (compared to using
only lttng) ?

Best regards,
Zvika


On Tue, Apr 2, 2024 at 5:11=E2=80=AFPM Erica Bugden <ebugden@efficios.com> =
wrote:

> Hello Zvika,
>
> On 2024-03-29 01:09, Zvi Vered via lttng-dev wrote:
> > Hi Christopher,
> >
> > Thank you very much for your reply.
> > Can you please explain what do you mean by ftrace-enabled kernel ?
>
> I believe what Christopher means by "ftrace-enabled" kernel is that the
> Linux kernel has been configured to include ftrace. Both the ftrace
> tracer and the LTTng tracer use the same kernel tracepoints to extract
> execution information and these tracepoints are included in the kernel
> if ftrace is included.
>
> Most Linux distributions will include ftrace by default. However, you
> can check whether this is the case by searching for `tracefs` in
> `/proc/filesystems` (assuming it's already mounted) or by trying to
> mount `tracefs`. `tracefs` is the filesystem ftrace uses to communicate
> with users.
>
> More details about how to check if ftrace is enabled and how to enable
> it if not:
> https://wiki.linuxfoundation.org/realtime/documentation/howto/tools/ftrac=
e
>
> The "More Information" section points to the primary sources (Linux
> kernel documentation), but I find this page to be a good starting point.
>
> Best,
> Erica
>
> >
> > Best regards,
> > Zvika
> >
> > On Wed, Mar 27, 2024 at 7:32=E2=80=AFPM Christopher Harvey via lttng-de=
v
> > <lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>> wrote:
> >
> >     you can use an ftrace-enabled kernel with lttng (maybe even just
> >     tracecompass) or perfetto to get that kind of trace
> >
> >
> https://archive.eclipse.org/tracecompass.incubator/doc/org.eclipse.tracec=
ompass.incubator.ftrace.doc.user/User-Guide.html
> <
> https://archive.eclipse.org/tracecompass.incubator/doc/org.eclipse.tracec=
ompass.incubator.ftrace.doc.user/User-Guide.html
> >
> >
> >     or
> >
> >     https://ui.perfetto.dev/ <https://ui.perfetto.dev/>
> >
> >     On Wed, Mar 27, 2024, at 5:26 AM, Zvi Vered via lttng-dev wrote:
> >      > Hello,
> >      >
> >      > I have an application with 4 threads.
> >      > I'm required to display on the graph when thread starts working
> >     till it
> >      > blocks for the next semaphore.
> >      >
> >      > But without using the lttng userspace library.
> >      >
> >      > Is it possible ?
> >      >
> >      > Thank you,
> >      > Zvika
> >      > _______________________________________________
> >      > lttng-dev mailing list
> >      > lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> >      > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >     <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>
> >     _______________________________________________
> >     lttng-dev mailing list
> >     lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> >     https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >     <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--000000000000cbb3c90615291854
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Erica,<div><br></div><div>Thank you very much for your =
answer.=C2=A0</div><div>Can you please tell what is the added value of ftra=
ce (compared to using only lttng) ?</div><div><br></div><div>Best=C2=A0rega=
rds,=C2=A0</div><div>Zvika=C2=A0</div><div><br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 2, 2024 =
at 5:11=E2=80=AFPM Erica Bugden &lt;<a href=3D"mailto:ebugden@efficios.com"=
>ebugden@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">Hello Zvika,<br>
<br>
On 2024-03-29 01:09, Zvi Vered via lttng-dev wrote:<br>
&gt; Hi Christopher,<br>
&gt; <br>
&gt; Thank you very much for your reply.<br>
&gt; Can you please explain what do you mean by ftrace-enabled kernel ?<br>
<br>
I believe what Christopher means by &quot;ftrace-enabled&quot; kernel is th=
at the <br>
Linux kernel has been configured to include ftrace. Both the ftrace <br>
tracer and the LTTng tracer use the same kernel tracepoints to extract <br>
execution information and these tracepoints are included in the kernel <br>
if ftrace is included.<br>
<br>
Most Linux distributions will include ftrace by default. However, you <br>
can check whether this is the case by searching for `tracefs` in <br>
`/proc/filesystems` (assuming it&#39;s already mounted) or by trying to <br=
>
mount `tracefs`. `tracefs` is the filesystem ftrace uses to communicate <br=
>
with users.<br>
<br>
More details about how to check if ftrace is enabled and how to enable <br>
it if not: <br>
<a href=3D"https://wiki.linuxfoundation.org/realtime/documentation/howto/to=
ols/ftrace" rel=3D"noreferrer" target=3D"_blank">https://wiki.linuxfoundati=
on.org/realtime/documentation/howto/tools/ftrace</a><br>
<br>
The &quot;More Information&quot; section points to the primary sources (Lin=
ux <br>
kernel documentation), but I find this page to be a good starting point.<br=
>
<br>
Best,<br>
Erica<br>
<br>
&gt; <br>
&gt; Best=C2=A0regards,<br>
&gt; Zvika<br>
&gt; <br>
&gt; On Wed, Mar 27, 2024 at 7:32=E2=80=AFPM Christopher Harvey via lttng-d=
ev <br>
&gt; &lt;<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">ltt=
ng-dev@lists.lttng.org</a> &lt;mailto:<a href=3D"mailto:lttng-dev@lists.ltt=
ng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0you can use an ftrace-enabled kernel with lttng (ma=
ybe even just<br>
&gt;=C2=A0 =C2=A0 =C2=A0tracecompass) or perfetto to get that kind of trace=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://archive.eclipse.org/tracecompass=
.incubator/doc/org.eclipse.tracecompass.incubator.ftrace.doc.user/User-Guid=
e.html" rel=3D"noreferrer" target=3D"_blank">https://archive.eclipse.org/tr=
acecompass.incubator/doc/org.eclipse.tracecompass.incubator.ftrace.doc.user=
/User-Guide.html</a> &lt;<a href=3D"https://archive.eclipse.org/tracecompas=
s.incubator/doc/org.eclipse.tracecompass.incubator.ftrace.doc.user/User-Gui=
de.html" rel=3D"noreferrer" target=3D"_blank">https://archive.eclipse.org/t=
racecompass.incubator/doc/org.eclipse.tracecompass.incubator.ftrace.doc.use=
r/User-Guide.html</a>&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0or<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://ui.perfetto.dev/" rel=3D"norefer=
rer" target=3D"_blank">https://ui.perfetto.dev/</a> &lt;<a href=3D"https://=
ui.perfetto.dev/" rel=3D"noreferrer" target=3D"_blank">https://ui.perfetto.=
dev/</a>&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Wed, Mar 27, 2024, at 5:26 AM, Zvi Vered via ltt=
ng-dev wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hello,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I have an application with 4 threads.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I&#39;m required to display on the graph when=
 thread starts working<br>
&gt;=C2=A0 =C2=A0 =C2=A0till it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; blocks for the next semaphore.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; But without using the lttng userspace library=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Is it possible ?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Thank you,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Zvika<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; _____________________________________________=
__<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; lttng-dev mailing list<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" =
target=3D"_blank">lttng-dev@lists.lttng.org</a> &lt;mailto:<a href=3D"mailt=
o:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a=
>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"https://lists.lttng.org/cgi-bin/ma=
ilman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://list=
s.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.=
lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0_______________________________________________<br>
&gt;=C2=A0 =C2=A0 =C2=A0lttng-dev mailing list<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:lttng-dev@lists.lttng.org" target=
=3D"_blank">lttng-dev@lists.lttng.org</a> &lt;mailto:<a href=3D"mailto:lttn=
g-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttn=
g.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.=
lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>&gt;<br>
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

--000000000000cbb3c90615291854--

--===============8832932647651679548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8832932647651679548==--
