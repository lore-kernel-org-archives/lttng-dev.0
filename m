Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05CEE69E96
	for <lttng-dev@archiver.kernel.org>; Mon,  2 Dec 2024 21:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1733174276;
	bh=eh1VQhncaDGESjOpQLGw2LeRR0nTt/UvixrZaVbgrEo=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=MTNpnIsnlIwmq08OlOvNh3EuxvGjiJY4QPKb/3urqq0Qe19GJT2JdOZQ2I9MZ8c3B
	 5nTv4aaqTJWPHYS9Oewmys3T/WH8JclSPZrR8zMBJG1zbRrdmnaVHo4a8OcGLuHs4w
	 SocU3HYQOuRQyxRhEmgrxUSqTak5pogpK2Ro401BSLzHZdSe8g3UphxOuG7ydYrX0P
	 Xj93CrrQSOQYrKJCoJI5Rr4GbCjYh6wPiPGdfLJqAbA4S2z2CpdI4htSzNp9CWTkGt
	 eJu/iQdKHVuOmZUCn6Jp8pv84hsrsetgVnr4Yvj39MktlrvVuqVHAroJP9I5l6oIb/
	 tOKsTng0AVEWQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Y2GpX33mCz1cQm;
	Mon,  2 Dec 2024 16:17:56 -0500 (EST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by lists.lttng.org (Postfix) with ESMTPS id 4Y2GpW35ggz1cQf
 for <lttng-dev@lists.lttng.org>; Mon,  2 Dec 2024 16:17:55 -0500 (EST)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2154e3af730so25101755ad.3
 for <lttng-dev@lists.lttng.org>; Mon, 02 Dec 2024 13:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733174274; x=1733779074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eh1VQhncaDGESjOpQLGw2LeRR0nTt/UvixrZaVbgrEo=;
 b=fYcPtitl8mWOwaB5rDXe0wpe+UU2k4aaADI8ddbfdrhXfBb42ds23DjG6ix5wPRe1O
 Y+LQAFxC1ff5ra4V5n77A6k9xswiue+ZeX5j7EfQbVhLlTM9Vuu2DNCsvfNUfP9Ripu1
 kzIDwgZgX6qsHmZ2d0HeKrygz53gWEI7ECNISC8DA9XksY+LCxSjK9NogDThVlryt4tu
 0+BPdNPIFKZQD6z2FjSo6YCkEH3nLlwf6Lac+Lf8JN85tn3M8ey783JAKKxKaeJF6Vb+
 ZgKuRxEu2fmSvpti1vzq1aKB+78HckusMBxiL2JiSyGB+82z71XFpO+maN67048RDkaN
 lFfg==
X-Gm-Message-State: AOJu0YxWwBjlElNF/NZ+/DRAmIHEi8I63UCfmpDC0Y/+N2mAjuDcHYvw
 hVoGrIvQGbRvaddXD3vtnEvKAWQk4SYC3boNeXzQJy2i3tqZoXy9bsfwLMcqIAHy5uWOT8MN4HR
 zM1qVB0xuAyYNsigum1x//GgfgiU=
X-Gm-Gg: ASbGncsPVsuup2najMVYgq8XXPBzuQ1PINxhf7WNIJ+upbk560aCk3j8+2TDxCcyt6n
 IQujzUNjA8qepNyyQQQzU83gA4Z4=
X-Google-Smtp-Source: AGHT+IGg7xAafKr2KaskVhKKaFDfAPrb7iceqykySJpdXCA19jUDPvbKzPHv666EmunwT5Ftb0vRtMt5myhsSurHnHM=
X-Received: by 2002:a17:903:192:b0:211:f6b7:9a5b with SMTP id
 d9443c01a7336-215bd11afc4mr534155ad.43.1733174274024; Mon, 02 Dec 2024
 13:17:54 -0800 (PST)
MIME-Version: 1.0
References: <VI1PR01MB6845D1C81221547CEC94B3A782352@VI1PR01MB6845.eurprd01.prod.exchangelabs.com>
In-Reply-To: <VI1PR01MB6845D1C81221547CEC94B3A782352@VI1PR01MB6845.eurprd01.prod.exchangelabs.com>
Date: Mon, 2 Dec 2024 13:17:17 -0800
Message-ID: <CAAS9dobC0wERGMQf9CLjhYY4ay_zSdAMAE9qxBezLtH-kL_1NQ@mail.gmail.com>
Subject: Re: [lttng-dev] Record stacktraces at userspace tracing domain
To: Alexander Krabler <Alexander.Krabler@kuka.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Content-Type: multipart/alternative; boundary="000000000000eff60906285014ac"
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

--000000000000eff60906285014ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I did the same thing a while ago, i.e., trigger tracepoints on
malloc/free/etc. using liblttng-ust-libc-wrapper and collect userspace
callstack information (so that the indirect calls to malloc/free can be
removed from an application).

There is a userspace callstack context implementation here for lttng-ust
2.10, see the last 3 commits:
https://github.com/tahini/lttng-ust-1/commits/ust-callstack-2.10/. Here's
the corresponding lttng-tools 2.10 branch needed to enable the userspace
callstack context:
https://github.com/tahini/lttng-tools/commits/ust-context-callstack/.

I've rebased it on 2.11 here:
https://github.com/ApexAI/lttng-ust/commits/ust-callstack-2.11/.
lttng-tools:
https://github.com/ApexAI/lttng-tools/commits/ust-callstack-2.11/. It
shouldn't be too hard to rebase it all on a newer version.

Hope that helps,

Christophe

On Mon, Dec 2, 2024 at 8:32=E2=80=AFAM Alexander Krabler via lttng-dev <
lttng-dev@lists.lttng.org> wrote:

> Hello,
>
> we want to record stacktraces at specific userspace events like e.g. call=
s
> to malloc and free using liblttng-ust-libc-wrapper.so.
> There is the callstack-user context to achieve this in general, however,
> it seems like tracing of userspace stacktraces is only available in the
> kernel tracing domain.
>
> Is there already a solution to achieve this goal?
> If not, what would need to be done to achieve this?
>
> Thanks,
> Alexander

--000000000000eff60906285014ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I did the same thing a while=C2=A0a=
go, i.e., trigger tracepoints on malloc/free/etc. using liblttng-ust-libc-w=
rapper and collect userspace callstack information (so that the indirect ca=
lls to malloc/free can be removed from an application).</div><div><br></div=
><div>There is a userspace callstack=C2=A0context implementation here for l=
ttng-ust 2.10, see the last 3 commits:=C2=A0<a href=3D"https://github.com/t=
ahini/lttng-ust-1/commits/ust-callstack-2.10/">https://github.com/tahini/lt=
tng-ust-1/commits/ust-callstack-2.10/</a>. Here&#39;s the corresponding ltt=
ng-tools 2.10 branch needed to enable the userspace callstack=C2=A0context:=
=C2=A0<a href=3D"https://github.com/tahini/lttng-tools/commits/ust-context-=
callstack/">https://github.com/tahini/lttng-tools/commits/ust-context-calls=
tack/</a>.</div><div><br></div><div>I&#39;ve rebased it on 2.11 here:=C2=A0=
<a href=3D"https://github.com/ApexAI/lttng-ust/commits/ust-callstack-2.11/"=
>https://github.com/ApexAI/lttng-ust/commits/ust-callstack-2.11/</a>. lttng=
-tools:=C2=A0<a href=3D"https://github.com/ApexAI/lttng-tools/commits/ust-c=
allstack-2.11/">https://github.com/ApexAI/lttng-tools/commits/ust-callstack=
-2.11/</a>. It shouldn&#39;t be too hard to rebase it all on a newer versio=
n.</div><div><br></div><div>Hope that helps,</div><div><br></div><div>Chris=
tophe</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div =
dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 2, 2024 at 8:32=E2=80=AFAM Ale=
xander Krabler via lttng-dev &lt;<a href=3D"mailto:lttng-dev@lists.lttng.or=
g">lttng-dev@lists.lttng.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Hello,<br>
<br>
we want to record stacktraces at specific userspace events like e.g. calls =
to malloc and free using liblttng-ust-libc-wrapper.so.<br>
There is the callstack-user context to achieve this in general, however, it=
 seems like tracing of userspace stacktraces is only available in the kerne=
l tracing domain.<br>
<br>
Is there already a solution to achieve this goal?<br>
If not, what would need to be done to achieve this?<br>
<br>
Thanks,<br>
Alexander</blockquote></div>

--000000000000eff60906285014ac--
