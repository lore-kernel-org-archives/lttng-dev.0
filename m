Return-Path: <SRS0=jjTb=6Z=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B9AC54E4A
	for <lttng-dev@archiver.kernel.org>; Mon, 11 May 2020 21:10:21 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C783720836
	for <lttng-dev@archiver.kernel.org>; Mon, 11 May 2020 21:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="DlPeO/sJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C783720836
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49LYVg21XVz20Qx;
	Mon, 11 May 2020 17:10:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1589231419;
	bh=rnmtX/PTFXD8fHVJfGQOdFhJGKV/bq28SYM5oILL4nA=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=DlPeO/sJERSIRb49kApi3n2fktvVFcOOSvr4gKSGiIEpEOqEFy2tvc6yK7SERkfJY
	 8cTsn6nJ1mK7y2lYE66EtIDGATCh9ysZjF1etR/wcs52womUF6bv0RZ3Q02nX/DRnE
	 0i0nvMx7V3X7ILukRLgj2ZSKeyK8Z6QU6uiHY1+ym8HhhWR2yKNqUV/ndDHD/VXcNr
	 GKh1IoTvRh7oURqK7/NRnSSf/r6qqcdtmisv0FZxriW64xVOmxxd0NLnR7IDjdWiWe
	 e97WzCWJdlGNtAaeGX5MrSomFfCDlV22UiHWpfdbGNm559ubFRxURLM2gxpZX6HtKe
	 pY1U9TSQPNeIw==
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by lists.lttng.org (Postfix) with ESMTPS id 49LYVd6llXz20cb
 for <lttng-dev@lists.lttng.org>; Mon, 11 May 2020 17:10:17 -0400 (EDT)
Received: by mail-ej1-x635.google.com with SMTP id se13so2491897ejb.9
 for <lttng-dev@lists.lttng.org>; Mon, 11 May 2020 14:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=+KHUD+I/c/519S1NP7Cc11KxdQ3ZhLIvDSm81MJAMQs=;
 b=d76Z+Amd4S/pvB3Yu4UJmemH6msDgRRfXKfoWDed30DhxN0narrbhkMLBpdzDP91Vz
 9ZVhIsEcy5D4YwwXwXqNvAtnmQLmCfja8tulSedOz6aa22oPo9hQKI9eQUfWMUdB2k95
 JubPWbO3LiZqmiPSBJVFJPaGLIfLJKvM4oR/sUhEDBOJuzc0dvXEhFR09FFs1rabg1e1
 4IXDDQDOPuKeR+/lTm193q2t8g/LoqKmDllu9kzwjBPHonNb/3gHbupQy5qoYdstRv1N
 Yw94YoUoHQ6moG5SbQP3aJDIM+MIgPNAOW+pLLg/UDHTDINljknjHfV38kYOOsDCYdQj
 VFNA==
X-Gm-Message-State: AGi0PuabQEQj0uYZMJCZ7Lk0RDoOJqB3k7sWdZHm3ypRGQsZvm53TRG2
 DqdOC22ruwfdJnu18JOUuNMtdU7qQYM8Cks8FlwrGrJJd1U=
X-Google-Smtp-Source: APiQypKo6Cci9y2t8hEK89VDh66MeRle1mlPstmSVIMEfcufwlrw9O72I5BuHg1Nn03PMeF7yCAsnZvPCg36qUMnG6A=
X-Received: by 2002:a17:906:bb07:: with SMTP id
 jz7mr14444288ejb.317.1589231416211; 
 Mon, 11 May 2020 14:10:16 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 11 May 2020 17:09:40 -0400
Message-ID: <CAAS9doY1Ez7N=_H6e-w9eWg0LBJp+MMasuOEmzbO0DGyLSzViA@mail.gmail.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] Correctly using callstack-user context
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
Content-Type: multipart/mixed; boundary="===============4328271482442741472=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200511210940.guXxCIlWd2FSb7uJkLLtaTC26Z6QkQz5IuGqOSer5fA@z>

--===============4328271482442741472==
Content-Type: multipart/alternative; boundary="000000000000077bb905a565c63c"

--000000000000077bb905a565c63c
Content-Type: text/plain; charset="UTF-8"

Hi,

As part of a big software safety certification effort, we are looking into
making sure that some functions of our API do not allocate memory and do
not use any blocking syscalls.

This part is done and is working (using kmem_mm_page_{alloc,free} for
memory allocations for now). However, if we do get memory allocations, we
want to know where they're from. To do this, I've been looking at using the
callstack-user context. However, I have a hard time getting more than 1
callstack-user address.

I'm on 5.3.0-46-generic, i.e. CONFIG_ARCH_STACKWALK-compatible, from what I
could find. I tried creating a minimal version using
-fno-omit-frame-pointer & without any optimization, but I still get only
one address in the callstack_user context when I know there should be at
least a few.

Note that this is running inside a Docker container, but lttng-modules is
installed on the host, and a root session-daemon is running inside the
Docker container. Also, I installed LTTng using the stable-2.11 Ubuntu PPA.

Is there something I might be doing wrong? Am I supposed to compile
lttng-modules from source in order to use the callstack-* contexts? I
couldn't find much documentation about this, other than the brief mention
in the 2.11 docs.

Regards,


Christophe

--000000000000077bb905a565c63c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>As part of a big software safety ce=
rtification effort, we are looking into making sure that some functions of =
our API do not allocate memory and do not use any blocking syscalls.</div><=
div><br></div><div>This part is done and is working (using kmem_mm_page_{al=
loc,free} for memory allocations for now). However, if we do get memory all=
ocations, we want to know where they&#39;re from. To do this, I&#39;ve been=
 looking at using the callstack-user=C2=A0context. However, I have a hard t=
ime getting more than 1 callstack-user=C2=A0address.</div><div><br></div><d=
iv>I&#39;m on 5.3.0-46-generic, i.e. CONFIG_ARCH_STACKWALK-compatible, from=
 what I could find. I tried creating a minimal version using -fno-omit-fram=
e-pointer &amp; without any optimization, but I still get only one address =
in the callstack_user context when I know there should be at least a few.</=
div><div><br></div><div>Note that this is running inside a Docker container=
, but lttng-modules is installed on the host, and a root session-daemon is =
running inside the Docker container. Also, I installed LTTng using the stab=
le-2.11 Ubuntu PPA.</div><div><br></div><div>Is there something I might be =
doing wrong? Am I supposed to compile lttng-modules from source in order to=
 use the callstack-* contexts? I couldn&#39;t find much=C2=A0documentation =
about this,=C2=A0other than the brief mention in the 2.11 docs.</div><div><=
br></div><div>Regards,</div><div><br></div><div><br></div><div>Christophe</=
div></div>

--000000000000077bb905a565c63c--

--===============4328271482442741472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4328271482442741472==--
