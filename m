Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F07EE57D7
	for <lttng-dev@archiver.kernel.org>; Wed, 11 Sep 2024 22:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1726094318;
	bh=ce9BjCBcvZzSoh3hXSll1xcAljic3K3Ij/skTKDwYYA=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Yfy63QRbVu2qJ1dgk0bW56GasMkZ8xyWU9ZbuIUzO8WbU+IhcYhGIzbWRMplS1SUr
	 mtYGzCjWyEW6Kc4GVzgjN75DWfMsasJIuhRMkNPXF/Q4879rucgxpgiNQh5U6VQYZd
	 YGrJekqKCu/G2ZNeowtFectbSuKOfgr8QM7uA+wIx0wmrW+n8G6MS851Fd6b2a6K8L
	 tyqU7gkm723+gXCK/pDddJgf4Yz/0DSB4kLYbjGjt+P4c1SvMxVj8BVdQWlgEF0BJf
	 KApGVll3ySaKhswMKVTRBcFdA4RNHhNHAuSifb1nMs+7Z7ewJbfRqzmB34Y+xuSTmf
	 ahtGhCII1/1UQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4X3wTT27Kfz1GqW;
	Wed, 11 Sep 2024 18:38:37 -0400 (EDT)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 by lists.lttng.org (Postfix) with ESMTPS id 4X3wTR3mdRz1GqT
 for <lttng-dev@lists.lttng.org>; Wed, 11 Sep 2024 18:38:35 -0400 (EDT)
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6db4b602e38so2868697b3.1
 for <lttng-dev@lists.lttng.org>; Wed, 11 Sep 2024 15:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726094315; x=1726699115;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PKMXwY7KYv5nX2l9EB/lvE0LgA6Vk7uB59w3lLI11G0=;
 b=ElaovLxUyE0xA34uzqJugRTmHzJU8+6SXuXs81SVO3sFQn3CqxRrA3Abv1glkGIWNL
 su0SRuakrinN7LOPbrUOHqvtXoLacqkHVHsa5K5wbYiCJkhpC1DK7fnCowz//67Qp0ln
 iqUKdwQ5WR6Zf+0Tt+rkv+zc4YmHOBwGojoDR2z5iMJS4bsciPB/stCFQ+RX3T9mTX8d
 Im4qKx6Zom9+mYbFNm+pR6O7BQ7Pe4SHa4WkCGfpBB7XlGPU9yBPDZEZNo/GPZ/7Cfbj
 g0VHn+dWi+jbqVAr0CkfRGiYcWXMjG1qI92ZddFgwNuZTZxPLrJ54L1M9Z4/xW7uFVOL
 J4Uw==
X-Gm-Message-State: AOJu0YzjBfM986SO+o9epgTnE2GDizoQhWWwv1PmOOSezh7Y2ph11MvR
 U8uyxECN8rLrseKgY/jOBGnuir3TeTlws4/PfJoWgNNnBtLHVvmCxzolHU3CYTm6h3AtxtUcZiR
 yJVf10RqKeDZgOx5CChKskgRWeTpsRQ0R5FMQ6iW1QUj1pJsZxyU=
X-Google-Smtp-Source: AGHT+IEwnPadPQYjFV8D/3X4y/G7kEGU2MED568+eGw8a6W014WiLhjrSx46eDhS6r4LWHSC31MgfMnwOI42QtWThUE=
X-Received: by 2002:a05:690c:23c2:b0:6d6:7c9a:bf5a with SMTP id
 00721157ae682-6dbb6b0d89cmr11914227b3.13.1726094314467; Wed, 11 Sep 2024
 15:38:34 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 11 Sep 2024 15:38:23 -0700
Message-ID: <CAA1MA5f3JY7WCZbgKaC2gjagDY-eVdssg_iWEiWtop3zZM7WJQ@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] Trigger snapshots on a watchdog
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
From: Damien Berget via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Damien Berget <damien.berget@flyzipline.com>
Content-Type: multipart/mixed; boundary="===============8699902008842354463=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8699902008842354463==
Content-Type: multipart/alternative; boundary="000000000000768aed0621dfa647"

--000000000000768aed0621dfa647
Content-Type: text/plain; charset="UTF-8"

Good day,
We are trying to see what it the best way to monitor some applications not
hitting a deadline. Ideally something like a watchdog that needs to be pat
regularly and if timeout is reached triggers the snapshot.

Before we reinvent the wheel and code some userland applications, is there
a canonical way in LTTng to do it? I found this
<https://review.lttng.org/c/lttng-tools/+/9657/9> that is suspiciously
close maybe?

Thanks,
Cheers

-- 
*Damien Berget*
Embedded Platform Lead
damien.berget@flyzipline.com

--000000000000768aed0621dfa647
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Good day,<div>We are trying to see what it the best way to=
 monitor some applications not hitting a deadline. Ideally something like a=
 watchdog that needs to be pat regularly and if timeout is reached triggers=
 the snapshot.<br><br>Before we reinvent the wheel and code some userland a=
pplications, is there a canonical way in LTTng to do it? I found <a href=3D=
"https://review.lttng.org/c/lttng-tools/+/9657/9">this</a>=C2=A0that is sus=
piciously close maybe?<br><br>Thanks,<br>Cheers<br><div><br></div><span cla=
ss=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail=
_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><b style=3D=
"color:rgb(34,34,34)">Damien Berget</b><div style=3D"color:rgb(34,34,34)">E=
mbedded Platform Lead<br></div><div style=3D"color:rgb(34,34,34)"><a href=
=3D"mailto:damien.berget@flyzipline.com" style=3D"color:rgb(17,85,204)" tar=
get=3D"_blank">damien.berget@flyzipline.com</a></div><div style=3D"color:rg=
b(34,34,34)"><img src=3D"https://firebasestorage.googleapis.com/v0/b/standa=
rds-site-beta.appspot.com/o/documents%2F8ftfgpz8uuw%2F2jdhsym7pmr%2Fhorizon=
tal_black_1680025855220_2500x2500.png?alt=3Dmedia&amp;token=3Drb8o0zcdlb0" =
width=3D"96" height=3D"54"></div></div></div></div></div>

--000000000000768aed0621dfa647--

--===============8699902008842354463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8699902008842354463==--
