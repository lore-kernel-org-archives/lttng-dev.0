Return-Path: <SRS0=A40Q=63=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2422C433DF
	for <lttng-dev@archiver.kernel.org>; Wed, 13 May 2020 15:35:37 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C327A204EF
	for <lttng-dev@archiver.kernel.org>; Wed, 13 May 2020 15:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="W6YAwpUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C327A204EF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49MdzX0gSgz220v;
	Wed, 13 May 2020 11:35:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1589384136;
	bh=YzVz5cXQZasOxQbx54M5no+KbINrvlgHIo5cQp9QzTA=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=W6YAwpUA4Nkt7FXC9cmKe1T5LoY2f4+/3y1jGcUQJMVdSlkzupIQscJeDTNVL9tGo
	 P7ivlbZmyk75n4b9l/aTXcqeYOsQy+Mfu8EWaxGIShRKZfHgHTN0AeUve4os8lrqSW
	 OsklsS8qMxE9/pt3k2rCeSJ3YIYvSHUgPcab9KIsE10xOMrqe+QAogFOUFAe2ePlJn
	 e/beJviDy4Q7ElmL5kac1S33V2sg7V1c7GQl0LxJh4o4phAqLv8GBHcPjaaOEEjLBO
	 YjyH/FilgXDy10NKuVWz8ObVg1E96O8zLQGi+Cnhbv7EXnGi6W0Y4jfsWxAMxnHtW9
	 Z7U36CPOdwiFw==
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by lists.lttng.org (Postfix) with ESMTPS id 49MdzT1XkDz223T
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 11:35:32 -0400 (EDT)
Received: by mail-ej1-x62c.google.com with SMTP id n17so14574590ejh.7
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 08:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jPZkcpFWe6BhI//tcMcuFE1NeG5WO1BAezj0QusI0Pc=;
 b=jTwsXbUKM5dpRsQwQKDEvMrA/sKAaSOMK3IYsWBfG4N2ZZUZn/ZRmX1U8jnk+l+OZF
 /vjXfJtV1ulPm7SNjkHlut4XUT4FZNttk9/GG98KEjxY7/RsfUUFpwTm5xKmgXXmqyGv
 Z971z96b6I6N8/NqL9xQAIjlwjkdlLrxTx88NLA8IvLgQsCe2u8QMUJ9UhHy91slKdXm
 AoaxZVKoaUEcm5c/ZIDidGKipd75hrwjT2ZHtR1NmP+Pu/dZGHfP6BY5XFtKhTwRCuAK
 aEPnB7rTf38kNAFbh6W5LYY7darfgrU/Ee5j6+snT7VFDM6kp2jZhg9zbEtyfKr7MiLk
 FXpw==
X-Gm-Message-State: AGi0PuYo9EkxN0yvTSXCv850vsljSim6MrqCyt9B9aAahKQy7gg9VWVo
 TU90LziHUOWf7upkwJq+y9wxMa9k0HV0sm8MhRru3Yfm
X-Google-Smtp-Source: APiQypLJMiaqGj+7qIAMhgVP+kbVxz+0opJdaEWy7Jr+MR71AWLY7FW/7bJJWrMqDo3pVZwGE3mOBPRm7zK+ge6fa8g=
X-Received: by 2002:a17:906:d8c1:: with SMTP id
 re1mr16655878ejb.184.1589384131852; 
 Wed, 13 May 2020 08:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAAS9doY1Ez7N=_H6e-w9eWg0LBJp+MMasuOEmzbO0DGyLSzViA@mail.gmail.com>
 <1486835767.11198.1589286441675.JavaMail.zimbra@efficios.com>
 <CAAS9dobxi52FyWn=9zVDkMMpmZztc1Q1msdiErMKhkDEYCtqCA@mail.gmail.com>
 <bdeb584b-7c42-9e26-ce10-a1b008212541@versatic.net>
In-Reply-To: <bdeb584b-7c42-9e26-ce10-a1b008212541@versatic.net>
Date: Wed, 13 May 2020 11:34:55 -0400
Message-ID: <CAAS9dobBZRWw3WkZQrn2UGkHC1+tuS0BLmZCJxpxSQvDjG7oxg@mail.gmail.com>
To: Genevieve Bastien <gbastien@versatic.net>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] Correctly using callstack-user context
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
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
Content-Type: multipart/mixed; boundary="===============3767090567196571696=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200513153455.QVzuGmn1nZf0NeHFlq2nMT3GhbS_xnKIadBxiBRALOg@z>

--===============3767090567196571696==
Content-Type: multipart/alternative; boundary="000000000000973f0b05a58954e7"

--000000000000973f0b05a58954e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 May 2020 at 10:18, Genevieve Bastien via lttng-dev <
lttng-dev@lists.lttng.org> wrote:

> We had a very very experimental branch with it, using backtrace first,
> then unwind. But it is not suggested, not performant. It's far from the
> correct desired implementation, for which Mathieu could give more details=
.
>
> It works, but not to be used in production. Students have used it in the
> lab for some specific use case prototyping. I won't share the branch here=
,
> but if you wish to try, let me know.
>
> Genevi=C3=A8ve
>
Sure, I'd be interested!

--000000000000973f0b05a58954e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Wed, 13 May 2020 at 10:18, Genevieve Bastien via l=
ttng-dev &lt;<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank"=
>lttng-dev@lists.lttng.org</a>&gt; wrote:</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><div><blockquote type=3D"cite"><div dir=3D"ltr"><div =
class=3D"gmail_quote">
        </div>
      </div>
    </blockquote>
    <p>We had a very very experimental branch with it, using backtrace
      first, then unwind. But it is not suggested, not performant. It&#39;s
      far from the correct desired implementation, for which Mathieu
      could give more details.</p>
    <p> It works, but not to be used in production. Students have used
      it in the lab for some specific use case prototyping. I won&#39;t
      share the branch here, but if you wish to try, let me know.</p>
    <p>Genevi=C3=A8ve</p></div></blockquote><div>Sure, I&#39;d be intereste=
d!<br></div></div></div>

--000000000000973f0b05a58954e7--

--===============3767090567196571696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3767090567196571696==--
