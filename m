Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m43-10.mailgun.net (m43-10.mailgun.net [69.72.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F427CCA470
	for <lttng-dev@archiver.kernel.org>; Mon,  6 Oct 2025 17:23:19 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1759771398; x=1759778598;
 h=Sender: Sender: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: Content-Type: Cc: To: To: Subject: Subject: Message-ID: Date: In-Reply-To: References: MIME-Version;
 bh=Z8zO7IF42bUMeQXqbW4fxPlVHBbqOZwWqo6Fhw2fH2I=;
 b=kA1aq5rsSa467Yze7QOFKt+OAtJYvD8fh7DW1sADfLbyBS5GYe3E83iGuAS39KWc8bkbkjXdp06zVcKs+z/F9y6j8xSOdF5KrOjy+2z7TInNKl0ls13N9Vn8xz3saBtPo/E4Nv1RjHO1gJSwTjSeD/HJQipbYahKVPbrovQ323/inOjG+yNgsrOtpI2jAWi8bNuwYHqV6IMqGp49oV2Q6452Card2K1kvBEizRCaHCspHMmrGRKusV7XsX52Vx/z5AbUHUr6sIGvTopaxVAowjgJ34uxCkOD345E+EtJ3VevKFlZbwG5VNXZMvaMVlWA3d8R37SlcaDvuxPLEfImEA==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 cabc82aa332b72b872e27f9c308aacff10a15e5cb781069d1a356b511e047218 with SMTP id
 68e3fb068bd926232c5c6f1b (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Mon, 06 Oct 2025 17:23:18 GMT
X-Mailgun-Sending-Ip: 69.72.43.10
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cgR1c5SkWz27SM
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1759771397;
	b=NUrHYk+UgSwY1NqRkXH0N7E4XsxhChPCWEVJ/P4Gh49GOU+zIJCy/pJMExGOBKI8p7rb
	 yLya7R7dbTKMcEc11Ogs38R6DpSMifvS31C8PSzzaqNq7sI/C9aQqp+Z8WooS/ZDmyBkF
	 IFDHHBXBnJ3pYeylQSTRtxmWq4/E+odU0Zzjisq5b9OmiL1I2cIYteqfjm4zFSk6I9tY5
	 NnX6wBQk/k7pJwPL8NpLObUNwkdc5eeGw+byMe8yREmTR61rYwEnvfyvTy3N5hHa1+PEV
	 JbGcwAi4E8LhbjUBKea61DQIsHaN6zOFoDlND8j0gFQn1W2Xa59b3cg8z4GURbHuAJA==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1759771397;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=Z8zO7IF42bUMeQXqbW4fxPlVHBbqOZwWqo6Fhw2fH2I=;
	b=pmYigcePwmsF1O/YKzUhikyBIyVKjnu8RHrBJhuYb3D6Kotb64QoKlAr5weZgasminqY
	 kb7XmYwVo0ZsSfR6PZXP0aICfhcbS7e7AE+JmtDI72OQI6UblS3srbSYrXbhJYkMgiB+s
	 b9k3JHaLNB5Sdn47G97kYXongzwAORCNZ8ia2SMuYReW45kJJxqLUqSnjeQvaCYWKJkn5
	 CteJ7cUS07/ObRq8QlFyUt/tB6dfhCFrs9ryFQ9llbhh98SZeZdL04R8SqjP/p0ewcCAa
	 1VtpxQO4fesix3wP02eq49idaxfWrdLwLxmcC4whwg4PNb7pvU4ZC/EYhM3RGBkbMMg==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cgR1c5SkWz27SM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1759771397;
	bh=Z8zO7IF42bUMeQXqbW4fxPlVHBbqOZwWqo6Fhw2fH2I=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=mRGiSpjVmwAWYtBm6k4d8I2afthJ013rTLguT7j7pZObSQkBGb0tb+H5GYzfeOGJR
	 b+1mthnXvDJA6NSY87sAL7W69sPCs2NbP1ggqmBqn1bYwIpeGCLa42E4Q/G1bVDy/f
	 S+djlHyHyROBn9w8yeqdEFHlqInKyIrOtfL1EkEFHIrhM0n+QdhZ7tDp5KZbA5IDJF
	 ZfKhhWx63gcRdQWacAKNXogbnfyahicgVSL7dkIe8sHhbp0AHKQlwIN3O0Dh7FIXc7
	 GDKRG8hh+m/26o6f2e/+k6EpHkz6MMxzBYsGXNVUZg8QSinb7QfVqem1UviSGrjxQd
	 3bEZy+6oTUscw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4cgR1c5SkWz27SM;
	Mon,  6 Oct 2025 13:23:16 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cgR1Z1bKmz27h9
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cgR1Z1bKmz27h9
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by lists.lttng.org (Postfix) with ESMTPS id 4cgR1Z1bKmz27h9
 for <lttng-dev@lists.lttng.org>; Mon,  6 Oct 2025 13:23:13 -0400 (EDT)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-32eb45ab7a0so5679166a91.0
 for <lttng-dev@lists.lttng.org>; Mon, 06 Oct 2025 10:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759771391; x=1760376191;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z8zO7IF42bUMeQXqbW4fxPlVHBbqOZwWqo6Fhw2fH2I=;
 b=MjAiYJV98/dOqP1T98fOtC2HfoI3xkPda/Re2itPfvOw3HUSHFxeb5PWwPc0266P/W
 UtQ9NnGq1sYcU7Jo67sUAndSIm7JMww+67n9oLCYCDy4OUIE0vPjETiFh22OyRyh/Q64
 3V3LOmyY+a0Su7i38vNalfV5vsst3/3WPugknND16nYy6Z2BLDpPenO3OoggY6FM8Vlj
 LYmMcvK49SvvVRvRV2N+2A7ZHw/prvJNbQeiPXVxlfLMzFyZN/x+6e4lp+RfQrMGuBBe
 5pn/BlaOdosBOquKr8mhSdQ0sj4oyd7k6Nq9YT2kCg6/X5ei+rlgYgFoNaZB0oe8iRwY
 +8DA==
X-Gm-Message-State: AOJu0YxaAimDiyOlZuaq1JOxQmYxg+2sN0s2xrwBfncU4a5g9jLlfDSF
 +Q7A60ocZUIYfMLHJ+sv/hzM2Ag5Cv1aqde/O8TXFXTGfMLOZkbVLZVJjBW/ozr5QBCRZdd2lBP
 NrzWjUg70RpPTMmvLvn+4S6ijLVF/pvs=
X-Gm-Gg: ASbGnctxLTb7QYMoNWnGaVpUMAuRFJkF1my7Ja3qJ1PgCdRT4Mie8KEbGyAYZAx26+j
 hmX8CmfdkM3G+biQGEYuBODtiHI6E0wAK7It1SaV3QbCafI66s4XySGpDApndLNCMMHFoSyTRi/
 NfSCcoHvZ7ibq5BHwhTuYupsFhNuQ+kjxatFuFQ67YYSug8Xg37rZaqU0gjRTNxbsqcKcz6hivx
 zkjRBHsHtT1kGI91wQgbn06ORkejAxkn1fg/w==
X-Google-Smtp-Source: AGHT+IFhub4dEA2E2vTq4hrlA64jdnW3pI12rm0vBFJSqJBJ+F2Lnauh7JIjQFCOhUalZNoP9Bnjm+JVs0v8yH0rES0=
X-Received: by 2002:a17:90b:4f4e:b0:32e:e5:a90a with SMTP id
 98e67ed59e1d1-339c26e495cmr17950707a91.8.1759771391071; Mon, 06 Oct 2025
 10:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <870C2018-7321-4478-9609-9A75F99468A7@amazon.com>
In-Reply-To: <870C2018-7321-4478-9609-9A75F99468A7@amazon.com>
Date: Mon, 6 Oct 2025 10:22:34 -0700
X-Gm-Features: AS18NWDsNAVHhFjeDn9UPcSm-_KHAg55WLRtcEHYG9re4y_hOsJyOhYpRCxWb2s
Message-ID: <CAAS9doZSjHghJAUechOyNxhwA0DnMJX+Rm=YdbqMPfsSn-u7VQ@mail.gmail.com>
Subject: Re: Call stack context for user space trace points
To: "Sunku, Sai" <sunkusa@amazon.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Content-Type: multipart/alternative; boundary="000000000000a69871064080b4d0"
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
From: =?utf-8?q?Christophe_B=C3=A9dard_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?UTF-8?Q?Christophe_B=C3=A9dard?= <bedard.christophe@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--000000000000a69871064080b4d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

The userspace callstack context is only available for the kernel domain.

There are potential workarounds and solutions; take a look at the
discussion in this mailing list thread from last year (hit "Next message"):
https://lists.lttng.org/pipermail/lttng-dev/2024-December/030881.html

Regards,

Christophe

On Mon, Oct 6, 2025 at 5:37=E2=80=AFAM Sunku, Sai via lttng-dev <
lttng-dev@lists.lttng.org> wrote:

> Hello,
>
>
>
> I have a complex, multithreaded benchmark that emits LTTng trace points a=
t
> various stages. I am trying to trace all malloc calls made by this
> benchmark. I'm specifically trying to get malloc trace points also throug=
h
> LTTng so that I can identify when the malloc call was made relative to
> other trace points from the benchmark. I also want to see the stack trace
> for each malloc call so that I can identify where in the benchmark the
> malloc call is coming from.
>
>
>
> If I preload the lttng libc wrapper with
> `LD_PRELOAD=3Dliblttng-ust-libc-wrapper.so`, I'm able to see the trace po=
ints
> from malloc calls.
>
>
>
> But when I try to add the callstack-user context with this command `lttng
> add-context --userspace --channel 1 --type callstack-user`, I get an erro=
r
> saying "Error: callstack-user: UST invalid context"
>
>
>
> I've successfully added user space stack traces for kernel trace points
> with a similar command `lttng add-context --kernel --type callstack-user`
>
>
>
> Is the callstack-user context only available for kernel trace points? Is
> there another way to get the call stack for malloc calls?
>
>
>
> Thank you,
>
> Sai Sunku
>
>
>

--000000000000a69871064080b4d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>The userspace callstack=C2=A0contex=
t is only available for the kernel domain.</div><div><br></div><div>There a=
re potential workarounds and solutions; take a look at the discussion in th=
is mailing list thread from last year (hit &quot;Next message&quot;):=C2=A0=
<a href=3D"https://lists.lttng.org/pipermail/lttng-dev/2024-December/030881=
.html">https://lists.lttng.org/pipermail/lttng-dev/2024-December/030881.htm=
l</a></div><div><br></div><div>Regards,</div><div><br></div><div>Christophe=
</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Oct 6, 2025 at 5:37=E2=80=AFAM Sunku,=
 Sai via lttng-dev &lt;<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-d=
ev@lists.lttng.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><div class=3D"msg6488481305085553015">





<div lang=3D"EN-US" style=3D"overflow-wrap: break-word;">
<div class=3D"m_6488481305085553015WordSection1">
<p class=3D"MsoNormal">Hello,<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">I have a complex, multithreaded benchmark that emits=
 LTTng trace points at various stages. I am trying to trace all malloc call=
s made by this benchmark. I&#39;m specifically trying to get malloc trace p=
oints also through LTTng so that I can
 identify when the malloc call was made relative to other trace points from=
 the benchmark. I also want to see the stack trace for each malloc call so =
that I can identify where in the benchmark the malloc call is coming from.<=
u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">If I preload the lttng libc wrapper with `LD_PRELOAD=
=3Dliblttng-ust-libc-wrapper.so`, I&#39;m able to see the trace points from=
 malloc calls.<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">But when I try to add the callstack-user context wit=
h this command `lttng add-context --userspace --channel 1 --type callstack-=
user`, I get an error saying &quot;Error: callstack-user: UST invalid conte=
xt&quot;<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">I&#39;ve successfully added user space stack traces =
for kernel trace points with a similar command `lttng add-context --kernel =
--type callstack-user`<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Is the callstack-user context only available for ker=
nel trace points? Is there another way to get the call stack for malloc cal=
ls?<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Thank you,<u></u><u></u></p>
<p class=3D"MsoNormal">Sai Sunku<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
</div>

</div></blockquote></div>

--000000000000a69871064080b4d0--
