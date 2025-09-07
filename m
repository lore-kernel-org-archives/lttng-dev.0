Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21451CA101F
	for <lttng-dev@archiver.kernel.org>; Sun,  7 Sep 2025 19:19:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cKfyc13Dxz1fXL
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1757272746;
	b=O0nsPy+fq3gPBBenRXKDDtm8O/ERazUvOzaVbCYAALnsxilEDDif0kHFmAS4rQQ9xk7a
	 nB6W10CMjjlnh/VLiXoFOGplHKmGCEPDA8bHU13YVMvJqA5qjDJ478PEiXZhvRqZdvarv
	 FWk/JGc0eQtxVvoq0WH8slaFPXE2deGSrFkhctRJFah6/Z4Tr6XyvbXs5Tzq1h3LavPiu
	 RlFrEIsiyLId/8OvDEw59BsJgX9ker+UQNI7QAU5P9cLx78CoBG+guUmQ4PO4ii1P6vc+
	 V+qcjA/ZwudhkrxCxHO5t2PDhMV3ljQnOCTo4OuSbd5+KZbQESTHrhLwtgm4+nqzlCA==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1757272746;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=x2vPiAdHsnK6Afv431v+Wp2UdjvEB3fKnC9rai9j/oo=;
	b=Vt10WaNaPFNEa0NsuBtOi8XSJJt6twkFC3oBgRm2EscfHUzlJnjEcs7+kWILSKUzg8/L
	 T8j73rcWNw7MIKMJkwFElGH9FRHRsRtot8Vb1BhpSLg6vnDM6PV3Z4aXir496sGFhIn8l
	 EykogUDl+xlpvWAHU4kd5Ww93msoJrmyTD27FRkH1sZ0W/0cQmE1qKKc2upq1UrbmhjrI
	 uk2MaBKMP/YAWz1n7HwHslfSro/wuvwi021fITKOjgmexZCz+FXUePLixvlIvd33LPY6x
	 7IEXrVQzAZF6YIl+vqec+z0vjl27S8gGmnsng4BC+h4jQG2JNUJpHHLBIkoAm6mXBVw==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cKfyc13Dxz1fXL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1757272746;
	bh=x2vPiAdHsnK6Afv431v+Wp2UdjvEB3fKnC9rai9j/oo=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=bjmCt/SIptQJfWVvm1BcR2saa8IZYXdiTZhAS6mMhk8ss0IB7KdndwL6EkB5ZeQ+V
	 yoDLNmGDGUbiYX3u7+CRAvA/c/gplhlcRV8vNrL4u1ZrEcZcYzYbdoVsrCrqSxxt6c
	 zL+3vosnOv8VhOGUvddURXP4V2XUR/SkLzU7fVTsgRM4m0gRF1FZ4uCLzPRChjrm/7
	 /erL++E/aSVsNvszaZsFF/0ZRb232T+q60mD+0uYQ9SKTzz6Fjd0kUDkPxlTf0n80T
	 zLdsI8SiGZlgrFPtoigAeNHUCbGxYNtAf9QxvOKbcwXYOLAKCKhK3q4Tk6/IHuImQg
	 00IJTDClW6KGQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4cKfyc13Dxz1fXL;
	Sun,  7 Sep 2025 15:19:04 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cKfyZ1PSgz1fNk
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cKfyZ1PSgz1fNk
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by lists.lttng.org (Postfix) with ESMTPS id 4cKfyZ1PSgz1fNk
 for <lttng-dev@lists.lttng.org>; Sun,  7 Sep 2025 15:19:01 -0400 (EDT)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b0473327e70so605550766b.3
 for <lttng-dev@lists.lttng.org>; Sun, 07 Sep 2025 12:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757272739; x=1757877539;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o5fo9lI811FlGlxrBNWAKhB8plMB3WAMl7UBKdtjvps=;
 b=d6dV2oPyJZGAZIfsO/ZssOharUhzG9UZrmYEJxIDKN5k5nlpXLxdrtg0ckPIfPzUsy
 mX4WqJ7DmIC/Ifo9AcyIzrX+jOczhkdCSwVt5r3cRbJ1LRIbw/rMTHpGrQaZrsDABTDk
 Mzh2E0pXzweyq6RYgf8RGLqabnZgJl2L7+svSVYQbNg9WZXryy8z5DFzoZrom1J8DQz/
 L1lNBS8ZGGJxptfBgmfw9RW5Js+6iBU7K//xpXCjqxGnjpzAu/J6Rx4iPyzw+CZaDH6P
 nbsr3oJmfdx7eQEmL3/vNbQ3zfYjDz1gzR02oJihnpejvwkMbZov860ERlLdwQnfAsHS
 91Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcIcEwHUirI5fKOdurIz6DfaKnNfzN+hB9VFH9SOdBeM/G/QSlFix/iwA/8U2peTGokBb2IufSSW0=@lists.lttng.org
X-Gm-Message-State: AOJu0YzpGp8yPFRvSZu+hnYOZZ+nkuAybbSPy08E8f8VApNazRDN0Gw3
 ImZnNwqrf4A7cblrFfKJgAPKWqyAgNBoPTqyP4FTpzkH5evaD4R6RIXsQHIqu0lNvEc8O4ko/cc
 +b4jtPxIWRJsg3CRpyT5R3DyN5xXYjpc=
X-Gm-Gg: ASbGncuv6njKlpIm5x097TV59PHEQyCSpG6krHdT9XGAOXb7/Q0of4eIsVzR6lFOcrX
 srFnDS0mGsOEOjgRx1/oCpzfFDc5EgpWczWEiYQvGvGVhXKBkBN0D7AyZIJZCrrZvBVLHtQOK45
 net+EwimPxkcGQsGb/EU7Fs+wbCCGz2Lkrwfcsuk4w2xWNDcRTE5dIQ7f5+R+EmuGeCXm8nAxv4
 gtqXzoWjsLPDxE=
X-Google-Smtp-Source: AGHT+IFIXe2ZA2NrZjPsKUnOf61+58RUm6FmlLmu3wn6617nRf5dxUXdv8O24pjTf17jiSqtANkElFvPF/vBio3D2ps=
X-Received: by 2002:a17:906:d555:b0:afe:dbfb:b10e with SMTP id
 a640c23a62f3a-b04b16baf46mr473334166b.47.1757272737892; Sun, 07 Sep 2025
 12:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAKGpciq6Cb6+hqsfn+_zPk+MqCg+b0M_Gc3jVxVvnEGcE8rdLw@mail.gmail.com>
 <CAKGpciqHpGqGJChLa8p4P4Xv7EyUPMxULHxeknOTyie8kHH6hg@mail.gmail.com>
 <3c49eadb-f310-46b2-984d-58a0c193cde9@efficios.com>
 <CAKGpcipt=fWJi9Y497C3vq03CXmPY6rXQqs8ZP9nDoTGdRKnAA@mail.gmail.com>
 <CAKGpcipfyp3Ds4J0OH96Mu4zVhCLJg8g6tqEnfcRscZ1T8EmVA@mail.gmail.com>
 <2f0dc1b4-3fcb-453c-aa42-4a1f85623300@paulmck-laptop>
 <CAKGpciq+ixOVGN7TXYaF336ZEL_mOejzic5BvaKbexwwn_aqOQ@mail.gmail.com>
 <BD1A29BD-2AD2-4092-B1A2-DFEFAE77AAEE@sury.org>
 <CAKGpcip6w2nVQ+vbtfFH1296xTi5HYX+68J8okecChsihejDQA@mail.gmail.com>
 <87y0qwwc6j.fsf@laura>
 <CAKGpcioZbhyTUqLmNSnpuPw=jbi6eZV6ubbFQtvFD6VKn3wKxA@mail.gmail.com>
 <87h5xg7p3u.fsf@laura>
In-Reply-To: <87h5xg7p3u.fsf@laura>
Date: Sun, 7 Sep 2025 21:18:46 +0200
X-Gm-Features: AS18NWC_obJtcN6CgWf5gMqO_bGiiDTzo47VuiFBNmtHMd_wfJMuENjAifDmwPs
Message-ID: <CAKGpciqOVQRTP9kz7uwFFECGWMzFRFRsRujSDBrxFC24Y1A6NA@mail.gmail.com>
Subject: Re: URCU feature request?
To: Olivier Dion <odion@efficios.com>
Content-Type: multipart/alternative; boundary="00000000000050ccc4063e3af15b"
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
From: Thobias Knudsen via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Thobias Knudsen <thobknu@gmail.com>
Cc: lttng-dev@lists.lttng.org
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--00000000000050ccc4063e3af15b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> It looks like you want runtime verification for the usage of the API.
> Did you know that URCU can now be compiled against ThreadSanitizer
> (TSAN)?  If a user misuses the API or makes incorrect assumptions about
> the guarantees offered by RCU, TSAN will most likely detect those
> issues.  Coupled with the other debug features we already have, this
> makes it very hard to not trigger an error path when the API is used
> incorrectly.

Really?! I've used TSAN and got a bunch of false positives, I believe, but
maybe they're not false positives? How do you remove the false positives,
or know that they're not false positives?

> Note that certain kind of errors could actually be flag at compile time
> with the proper tooling.  For example, the Linux kernel uses a `__rcu'
> attribute that Sparse can understand to flag improper use of
> RCU=E2=80=91protected pointers.  I=E2=80=99d be very open to exposing som=
ething similar
> (an attribute) for static checkers.

wow thanks for the info! I knew compile time checks would be possible but
requiring compiler operability which is a higher hanging fruit for me. Is
'__rcu' compatible with custom concurrency? For example rcu_dereference a
pointer then locking a mutex inside the pointer then unlock read then
continue using the pointer? I cant come up with something usefull other
than a language rework. Is it much work making the __urcu attribute?

fre. 5. sep. 2025 kl. 20:04 skrev Olivier Dion <odion@efficios.com>:

> On Thu, 04 Sep 2025, Thobias Knudsen <thobknu@gmail.com> wrote:
> >> I am confuse about the overall discussion here.  Are we talking about
> >> static checking of RCU pointers usage or runtime checking?
> >>
> >> Is is possible to see the implementation you made so I can understand
> >> better?
> >
> > Sorry for being late to answer :/
> > The library overrides a subset of urcu and lfht functions with macros a=
nd
> > replaces them with other functions which checks in runtime if the
> functions
> > are called in the correct order.
> > here is the code: https://github.com/ThobiasKnudsen/urcu_lfht_safe
>
> It looks like you want runtime verification for the usage of the API.
> Did you know that URCU can now be compiled against ThreadSanitizer
> (TSAN)?  If a user misuses the API or makes incorrect assumptions about
> the guarantees offered by RCU, TSAN will most likely detect those
> issues.  Coupled with the other debug features we already have, this
> makes it very hard to not trigger an error path when the API is used
> incorrectly.
>
> Note that certain kind of errors could actually be flag at compile time
> with the proper tooling.  For example, the Linux kernel uses a `__rcu'
> attribute that Sparse can understand to flag improper use of
> RCU=E2=80=91protected pointers.  I=E2=80=99d be very open to exposing som=
ething similar
> (an attribute) for static checkers.
>
> [...]
>
> Thanks,
> Olivier
> --
> Olivier Dion
> EfficiOS Inc.
> https://www.efficios.com
>

--00000000000050ccc4063e3af15b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"ltr"><div dir=3D"ltr">&gt; It looks like you =
want runtime verification for the usage of the API.<br>&gt; Did you know th=
at URCU can now be compiled against ThreadSanitizer<br>&gt; (TSAN)?=C2=A0 I=
f a user misuses the API or makes incorrect assumptions about<br>&gt; the g=
uarantees offered by RCU, TSAN will most likely detect those<br>&gt; issues=
.=C2=A0 Coupled with the other debug features we already have, this<br>&gt;=
 makes it very hard to not trigger an error path when the API is used<br>&g=
t; incorrectly.<div><br></div><div>Really?! I&#39;ve used TSAN and got a bu=
nch of false positives, I believe, but maybe they&#39;re not false positive=
s? How do you remove the false positives, or know that they&#39;re not fals=
e positives?</div><div><br></div><div>&gt; Note that certain kind of errors=
 could actually be flag at compile time<br>&gt; with the proper tooling.=C2=
=A0 For example, the Linux kernel uses a `__rcu&#39;<br>&gt; attribute that=
 Sparse can understand to flag improper use of<br>&gt; RCU=E2=80=91protecte=
d pointers.=C2=A0 I=E2=80=99d be very open to exposing something similar<br=
>&gt; (an attribute) for static checkers.</div><div><br></div><div>wow than=
ks for the info! I knew compile time checks would be possible but requiring=
 compiler operability which is a higher=C2=A0hanging fruit for me. Is &#39;=
__rcu&#39; compatible with custom concurrency? For example rcu_dereference =
a pointer then locking a mutex inside the pointer then unlock read then con=
tinue using the pointer? I cant come up with something usefull other than a=
 language rework. Is it much work making the __urcu attribute?=C2=A0</div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">f=
re. 5. sep. 2025 kl. 20:04 skrev Olivier Dion &lt;<a href=3D"mailto:odion@e=
fficios.com" target=3D"_blank" rel=3D"noreferrer">odion@efficios.com</a>&gt=
;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, 04 Se=
p 2025, Thobias Knudsen &lt;<a href=3D"mailto:thobknu@gmail.com" target=3D"=
_blank" rel=3D"noreferrer">thobknu@gmail.com</a>&gt; wrote:<br>
&gt;&gt; I am confuse about the overall discussion here.=C2=A0 Are we talki=
ng about<br>
&gt;&gt; static checking of RCU pointers usage or runtime checking?<br>
&gt;&gt;<br>
&gt;&gt; Is is possible to see the implementation you made so I can underst=
and<br>
&gt;&gt; better?<br>
&gt;<br>
&gt; Sorry for being late to answer :/<br>
&gt; The library overrides a subset of urcu and lfht functions with macros =
and<br>
&gt; replaces them with other functions which checks in runtime if the func=
tions<br>
&gt; are called in the correct order.<br>
&gt; here is the code: <a href=3D"https://github.com/ThobiasKnudsen/urcu_lf=
ht_safe" rel=3D"noreferrer noreferrer" target=3D"_blank">https://github.com=
/ThobiasKnudsen/urcu_lfht_safe</a><br>
<br>
It looks like you want runtime verification for the usage of the API.<br>
Did you know that URCU can now be compiled against ThreadSanitizer<br>
(TSAN)?=C2=A0 If a user misuses the API or makes incorrect assumptions abou=
t<br>
the guarantees offered by RCU, TSAN will most likely detect those<br>
issues.=C2=A0 Coupled with the other debug features we already have, this<b=
r>
makes it very hard to not trigger an error path when the API is used<br>
incorrectly.<br>
<br>
Note that certain kind of errors could actually be flag at compile time<br>
with the proper tooling.=C2=A0 For example, the Linux kernel uses a `__rcu&=
#39;<br>
attribute that Sparse can understand to flag improper use of<br>
RCU=E2=80=91protected pointers.=C2=A0 I=E2=80=99d be very open to exposing =
something similar<br>
(an attribute) for static checkers.<br>
<br>
[...]<br>
<br>
Thanks,<br>
Olivier<br>
-- <br>
Olivier Dion<br>
EfficiOS Inc.<br>
<a href=3D"https://www.efficios.com" rel=3D"noreferrer noreferrer" target=
=3D"_blank">https://www.efficios.com</a><br>
</blockquote></div></div></div>

--00000000000050ccc4063e3af15b--
