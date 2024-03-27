Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EFDC47DD9
	for <lttng-dev@archiver.kernel.org>; Wed, 27 Mar 2024 09:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1711531611;
	bh=f3NjY7GL2dO66uWlkjPSZUXz+VK00Ta/MRBlrscEm5U=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=EiCIL6wa7CRg9quPF9J7ZETDAcFck2CcgdIo+pCAXYyorYUnzs4+eRepAFxH4LAnK
	 QRYrKKuyIhp9ugwnZF/6NY2hxKRG1VhijtAlp94N8M+k7tOV3XpakByff5c90e02C7
	 xddkZbOjus0spKN5CYQ8T9e5QMxim2LzUCkOMzR4HsZ7fhzeAHbWdIf0YnzKmcHUY8
	 OlAjHLyn3iEwAvtVhobAOvcPnzHvs5baRH6SJ3DyxnF1PiGpcGzDeivFRxmp37thVf
	 mr+bFf5trZcLA9AqGq1FGEbYe6KvuvM8DOzQGHXDjW0Wla+7Tjo85QpDR0tF65Rtsl
	 HdaP8skA4aFig==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4V4LsQ2kvDz2Wvk;
	Wed, 27 Mar 2024 05:26:50 -0400 (EDT)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by lists.lttng.org (Postfix) with ESMTPS id 4V4LsP2btmz2WhM
 for <lttng-dev@lists.lttng.org>; Wed, 27 Mar 2024 05:26:49 -0400 (EDT)
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-515a86daf09so4777712e87.3
 for <lttng-dev@lists.lttng.org>; Wed, 27 Mar 2024 02:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711531607; x=1712136407;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gE3HSgOW2vis9X419p/VKNreFgDR0LlJPnVTmpg+pW0=;
 b=DUBwO4xiXR8tdWgJ1U9PauaH05sC8av1kvsmhcjMCJN1qPno/nglB1NIRjnX65hScF
 bVdEQiksVdsaZBEOl6aT4MbM9MdnluyKLPeSSlXBJqFCL/62/HboMjmb+1Xk1WiFF+oQ
 /XKjiIsSBAnpLG/4MP27MHM23bYxVAuslfFSdbRgcXkO5QIbVz/3r2laZMBFRk8auD4O
 NW48CJ0ACMTTBbDHnyx4D5vLgIs+jM8CZvUGtbVs09Dc6Ww8ben21/mdcq67uSfKF9c3
 Kp/mh8o8HTUOP2ycaMYLOKNqnOR/O+ne4nO+/SKP1e4kcQPt8CZMTyW3g78JYTI/Eg2W
 WprA==
X-Gm-Message-State: AOJu0Yz/68z54V52Fq3xYYM8AbohP0dBADRkd0PTGAtbF08KYlZjwuaV
 sW8CbVMjBGQ3UsVpMV5iPVeNM0jar8sUPVsCPlqzN285V/kWud0xM9Wk0Vg23kyTl3bLonQi42H
 kzR5pby88hCgK2JZKNsjfjWG3sWRmpQgG
X-Google-Smtp-Source: AGHT+IG7JCJShOg1zsk/T1VTM5RPj0IfW7UT/s8zPkcOjHjrW0t1jGhWYbvs8RrHoLjzPtsbaXH6CXjpkGsXR0VXzfI=
X-Received: by 2002:ac2:4ac5:0:b0:515:8bde:56c3 with SMTP id
 m5-20020ac24ac5000000b005158bde56c3mr611431lfp.26.1711531606994; Wed, 27 Mar
 2024 02:26:46 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 27 Mar 2024 11:26:35 +0200
Message-ID: <CABRndgz2BHX9LubVXoaJxLH+KoYfgzQ0XzY=xHG60+HoO-Tm7A@mail.gmail.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] Lttng: display active threads in multiple cores.
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
Content-Type: multipart/mixed; boundary="===============2776628521694407268=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2776628521694407268==
Content-Type: multipart/alternative; boundary="00000000000074f7a30614a1013d"

--00000000000074f7a30614a1013d
Content-Type: text/plain; charset="UTF-8"

Hello,

I have an application with 4 threads.
I'm required to display on the graph when thread starts working till it
blocks for the next semaphore.

But without using the lttng userspace library.

Is it possible ?

Thank you,
Zvika

--00000000000074f7a30614a1013d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hello,<div dir=3D"auto"><br></div><div dir=3D"auto">I hav=
e an application with 4 threads.=C2=A0</div><div dir=3D"auto">I&#39;m requi=
red to display on the graph when thread starts working till it blocks for t=
he next semaphore.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>But without using the lttng userspace library.</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Is it possible ?</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Thank you,</div><div dir=3D"auto">Zvika</div></div>

--00000000000074f7a30614a1013d--

--===============2776628521694407268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2776628521694407268==--
