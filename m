Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96792C52D71
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Aug 2024 14:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1723039406;
	bh=8DdGnbV6suP4k1p5BzA4EjVWDfJbBNeEIsp6XwvDvyU=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=mXn6Dvu9BiGuRo9+OtaRoWdnJj/rITzGJP1laxbStmui0fqK5kxQm4dcAMHIk7nSr
	 6WvKO0w9f98BiwhYstlJ1eEXxXvmrLqE+D2CQwR8aHVPgSc8BpKfHqffYRgRzvcrrq
	 9jzI0PY6ivOodEqLRAwKhuX9A+hcV0Xc6GibbgAXikDLxhW5fuTVEYpsiNcr4N7eOw
	 yeQ0kxC3wMbnf9ZT14dUkMoOWyU6OU499t+ceSpjnMEO7o9MSkq+ccOxhQodICZ4Oo
	 qa4bcoUEPuMdx3Cuxnfj2aUI/WmJ5zBn279Dusgone3oobtcTDVS85uSfpMADmNgX/
	 ZERWqaEb4PXXQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WfBj95hh9z17fW;
	Wed,  7 Aug 2024 10:03:25 -0400 (EDT)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 by lists.lttng.org (Postfix) with ESMTPS id 4WfBj80yxPz178W
 for <lttng-dev@lists.lttng.org>; Wed,  7 Aug 2024 10:03:24 -0400 (EDT)
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e0bf9b821e8so1662687276.3
 for <lttng-dev@lists.lttng.org>; Wed, 07 Aug 2024 07:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723039403; x=1723644203;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BYGjBCJnTEZ6hyWZMtlcRhhLt6lTRo0QPSPp2r3k5fY=;
 b=cLVdQMPNEAalEjeou0A4JVtHCyPIO9UPP5I0O+V3Q/uZnu1wub6W7K1Cb8l0i7ja1w
 YtIurK+p2kQqcvII0GuZzSonAB7HL/N4k08zQhK30pguqfcfGBIj/wdY6O9w1a6BBsmP
 1Ruv6RaYu6tfK2BlpiHvEpzc4O2XRsfH4PWJF/zgHhz+LZMk6L54kZ+csh4YlYf6MVhD
 86bXQ0l6AL390gDxggSQ3tCYyUF4k7YlmUazDQ/fk3zrVBP90Ukr6LIJAnP4PFP0uNyH
 7gZOjDk8ko+Mxke6KL8r0aOUNdCi8Msbin8iHJh1VzwT45sToZrsrqsGkXNmGTxi8A+U
 sLTg==
X-Gm-Message-State: AOJu0YwC/uWu8lM2Cd7K+yl0rNZ/eaCcbnqOZDr++zL9riZPkEJQnwk9
 2yn40B5kbrY8OBX0lEsBQ8C5Ca+XIxnXjiKA3xwDFV2AzZ5AdHSzHpTQUc2U4SHQ9fzvvTvBl4k
 h9yIYXElrz++w2hMaBd61WEDQDzETiVUtkqS//n028llsFaHM7g==
X-Google-Smtp-Source: AGHT+IGHZ1bsnHQs0LJL7h71ZO1ICHC0YU9NJ+oUsnF6X53d8PUMNmLVdCQ79yqmhST4TE3UNeeq2R+8CXiChntjwgU=
X-Received: by 2002:a05:6902:2b0c:b0:e0b:c18c:ebf9 with SMTP id
 3f1490d57ef6-e0bde2ee486mr24341062276.13.1723039402931; Wed, 07 Aug 2024
 07:03:22 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 7 Aug 2024 17:03:12 +0300
Message-ID: <CADoB5d61PHip7Rp2SyzooXg_EUC6x__OYXrndRmOy8Pb-2OBjw@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] Limit on the number of arguments in TP_ARGS
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
From: Shahar Hochma via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Shahar Hochma <shaharhoch@google.com>
Content-Type: multipart/mixed; boundary="===============3561553135469305068=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3561553135469305068==
Content-Type: multipart/alternative; boundary="0000000000008c938c061f185faf"

--0000000000008c938c061f185faf
Content-Type: text/plain; charset="UTF-8"

Hi,
I've been using LTTNG traces and I was trying to create events with more
than 10 arguments. But, I'm having an issue where this seems to fail in
compilation with a cryptic error when I define more than 10 arguments in
TP_ARGS.

I assume the issue is that there are some macros that are only defined up
to 10 arguments. I didn't see any documentation of this limit or any
mention of this anywhere, and I wanted to know if there is maybe a way to
get around this.

Of course I can combine arguments to struts or define 2 events instead of
one. But I wanted to know if there is a native way to resolve this.

Thanks.

--0000000000008c938c061f185faf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,=C2=A0<div>I&#39;ve been using LTTNG traces and I was t=
rying to create events with more than 10 arguments. But, I&#39;m having an =
issue where this seems to fail in compilation with a cryptic error when I d=
efine more than 10 arguments in TP_ARGS.=C2=A0</div><div><br></div><div>I a=
ssume the issue is that there are some macros that are only defined up to 1=
0 arguments. I didn&#39;t see any documentation of this limit or any mentio=
n of this anywhere, and I wanted to know if there is maybe a way to get aro=
und this.</div><div><br></div><div>Of course I can combine arguments to str=
uts=C2=A0or define 2 events instead of one. But I wanted to know if there i=
s a native way to resolve this.=C2=A0</div><div><br></div><div>Thanks.=C2=
=A0</div><div><br></div><div><br></div></div>

--0000000000008c938c061f185faf--

--===============3561553135469305068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3561553135469305068==--
