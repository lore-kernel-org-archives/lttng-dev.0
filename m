Return-Path: <SRS0=lJQ0=CZ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539FCC43461
	for <lttng-dev@archiver.kernel.org>; Wed, 16 Sep 2020 12:59:10 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF6E22251
	for <lttng-dev@archiver.kernel.org>; Wed, 16 Sep 2020 12:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="VAXWj4sV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF6E22251
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Bs0Xp655dzGfK;
	Wed, 16 Sep 2020 08:59:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1600261147;
	bh=uowh/iFhZAt/tMjMiX2QgQEkSxbfLjmSdQ1xh+YpUdo=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=VAXWj4sVaMuCLpvWvnmWuP5wiXRkSpymirxvvaBi2vWL7WVBHTH+yeBkvXvhhn1In
	 VJKo0GUoal9ZaanfMaB+RRoqs1FK5cwojqZJznaBi2GMwU2XwNZ9ebFYa8Cs480yP3
	 Y1I4l4ttMLaNp0gy0Jw0OYypEaKzOR373+oDGhsmDlxEfhDliQhS+voRitQK5KyyId
	 e5WbuGtKO3o19OaLJBZAasSX469R/MglWa5+EtfWcnXME52j6xIZxXFTK2u8gWUcgT
	 RXKxy3ZlNvPEi3zVHBHCCvQVRhOMtyODrKeLz/c8PlfU3NdNxYhXoK/lc/cSq7VbnR
	 LDH7amSHq+fIQ==
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 by lists.lttng.org (Postfix) with ESMTPS id 4BrsrV4bQSzGKy
 for <lttng-dev@lists.lttng.org>; Wed, 16 Sep 2020 03:57:14 -0400 (EDT)
Received: by mail-qv1-xf33.google.com with SMTP id cy2so3104967qvb.0
 for <lttng-dev@lists.lttng.org>; Wed, 16 Sep 2020 00:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=dl1DHdE0YIIskDUnCTUOxVyYZA7knQu2VgO4V9KTZuE=;
 b=WifrdxyAT6wjWpKZYAnXrBy8jwe4Z/HNOs5TLZLM32Xb45y7tzDpsZMtQ8nkhTRkAn
 u1AhRUOWJuyYanPGoRNffqFlFPfcHrMMGVojIDysb9d3zfMxIim1eUQJJ4rtJIbCCZkl
 /SGVrmj/bBK3hBRprzu5NRXL0v560j6iWkYkLRXSOtR9QExbtuSXJpeZvJ8ddx1IoD3P
 Ad8YOTwOpRGMXYmYkJRpuxs/oP3Vt/EWwWLTP/kWD0PP/vQjNnxmfshwMNhnCyqRptbi
 OY/fDq5EFgvFs+i2Wt6cOrMp/kOhFFsTV64EzrX5j17XfGi4rBuNMn/Z8qsvcqjQOkTd
 EEEA==
X-Gm-Message-State: AOAM5300rD/Vp1B0+/4YyCP0+k/lmjNGvgrXPmWOs9KAoUHV7cWbRdsJ
 NViBR5uoW8CjC8qAHnLCdUmW5I93juzghYiBSWFI+2ksxnw=
X-Google-Smtp-Source: ABdhPJyM0UQ4PH22YEVk5BKIyhlZMSIcop+zp3/93WbB5Mgbt/TZf3iXuprusQzJu+v68g6Enkkmegu7H7hbvtsV6SE=
X-Received: by 2002:a05:6214:a90:: with SMTP id
 ev16mr5759522qvb.50.1600243033604; 
 Wed, 16 Sep 2020 00:57:13 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 16 Sep 2020 09:57:01 +0200
Message-ID: <CA+weNbniCKiGV+cSz+A3rfzxO09a8DtF8O27LPxK8Oz-a9PbBA@mail.gmail.com>
To: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Wed, 16 Sep 2020 08:59:05 -0400
Subject: [lttng-dev] Lttng-UST requires shared libraries
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
From: Abdelrahman Saeed via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Abdelrahman Saeed <abdelrahman130@gmail.com>
Content-Type: multipart/mixed; boundary="===============0226763196434678624=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============0226763196434678624==
Content-Type: multipart/alternative; boundary="0000000000009284de05af699d2a"

--0000000000009284de05af699d2a
Content-Type: text/plain; charset="UTF-8"

Hello All,

I'm trying to configure Lttng-UST and disabling shared libraries using the
option --enable-shared=no.

I always get an Error that Lttng-UST requires shared libraries enabled.

Why is this option available if I can't use it ? Is there something I'm
missing

Regards,
Abdelrahman.

--0000000000009284de05af699d2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello All,<div><br></div><div>I&#39;m trying to configure =
Lttng-UST and disabling shared libraries using the option --enable-shared=
=3Dno.</div><div><br></div><div>I always get an Error that Lttng-UST requir=
es shared libraries enabled.</div><div><br></div><div>Why is this option av=
ailable if I can&#39;t use it ? Is there something I&#39;m missing</div><di=
v><br></div><div>Regards,</div><div>Abdelrahman.</div></div>

--0000000000009284de05af699d2a--

--===============0226763196434678624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0226763196434678624==--
