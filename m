Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211E9CD129D
	for <lttng-dev@archiver.kernel.org>; Sat,  6 Apr 2024 04:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1712377244;
	bh=La5L3GH71F6RU/HBp3aB9Csu4k6O5mVzq/tKhvnFk9g=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=zto85RPK5TdMyTNnKFaHTr2xPK7lqZz9xlfn3srm2bfQJ0T7Ri9AkOcsBqqdMUTgv
	 lxBx2wwylyeXnzEIbbzrXeot3G9NcJ7cbM16k13v/g93PKNbqLCO5Oh/NCuc3lIQSu
	 Aa9iH/Tkj6sKftYkv3ywhb/gA7EqHriGrUWqW4a0GRD2udPVAmFuXLnH4yBkOYqsUF
	 rQzq0JQ6UUDBC80r+OJQmuUqaf5v542gqK4eWYda2NKMC4TASsm1g3fQ3qf89fR3KY
	 W3KQqBN/p3bz5yQ9duMyqeYlgLq8ywtmPiCiwOpdiEun84qUsqtxcF8iD03pDH4mZN
	 qAiBslGPrsGkg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VBMbc0x69z2bdq;
	Sat,  6 Apr 2024 00:20:44 -0400 (EDT)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by lists.lttng.org (Postfix) with ESMTPS id 4VBMbY5Cdlz2bN5
 for <lttng-dev@lists.lttng.org>; Sat,  6 Apr 2024 00:20:41 -0400 (EDT)
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-516dc51bb72so160621e87.1
 for <lttng-dev@lists.lttng.org>; Fri, 05 Apr 2024 21:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712377239; x=1712982039;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XXk6zI68uq73fKsoE5CdiVhpL+jdU10kdjiey1Rt3Tg=;
 b=OJcwI+tj0Uh6mcrh3+oxkQ19O94cP02Z/4gI2nRuqJm9t+CS9UY3hxbgHinPQEgdKO
 AEb6lqkHoDyojWGkOn43YG3jzyrlOW+SjrGJTYrN350tmg4lZJ66TmaP5oHfrcoUBofO
 j5LUZhRLDnggBqkag3WeoEUFf14dwZd7TqvuuvXKqZmi484UV31whBvNIGjBB0tI2bGe
 jbTbEMNN1Xo4uwm0xHEvlrZ3jj3zU3yCFa2tSXYkq4k6JXCAhKYpn/L2ldI20zIqqyoU
 b6jBPAZYaqnJEERko2kdG3rxo56g5lYIbI0Tu6cfMx9879459B4ve9+orIPZvDjh3eyl
 lk0A==
X-Gm-Message-State: AOJu0Yw6vWmrptR4+vPx2FFKBjoS26ARY9zC8P+ACAVQeTmU8zGn4LMP
 xTyKtGcHIZaLj592O9s3G/ro9/AynVgJhz+6+Z/xLJ/IJqvqqPHKm8rJsWkLppQ70UCPRpWLTRT
 cNDdn6GaFjv1wXMopCmpMB1Pe4sm5IbYmC/Angg==
X-Google-Smtp-Source: AGHT+IFJWZrUCnEpDBeNLELWC24eRwPBIbPAsZt191cVjQcwPy3sccI7lbZimr8JMC6q2kuzuFRa5K+YeFIAQenxs7E=
X-Received: by 2002:a19:ca07:0:b0:516:d25c:ed9e with SMTP id
 a7-20020a19ca07000000b00516d25ced9emr2248835lfg.13.1712377239276; Fri, 05 Apr
 2024 21:20:39 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 6 Apr 2024 07:20:28 +0300
Message-ID: <CABRndgyC1hMY5vkJjBpPc_GSaSwCaDBc0KhmykOF4Sjthk_FLA@mail.gmail.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] Monitor user space threads without user events
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
Content-Type: multipart/mixed; boundary="===============3035680157342520955=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3035680157342520955==
Content-Type: multipart/alternative; boundary="00000000000011989d061565e5d8"

--00000000000011989d061565e5d8
Content-Type: text/plain; charset="UTF-8"

Hello,

My user space process contains 2 threads:

First thread is blocked upon a kernel event created by a hardware interrupt
handled by the kernel.
The  thread is sending ioctl which is blocked till this interrupt occurs.

Second thread has just a 5msec sleep. It does something and then sleeps for
5msec. Forever.

Is it possible to see when each thread is running (and not blocked or
sleeps) ?
I know how to do it with user events. I wonder if it's possible without any
extra code.

Thank you,
Zvika

--00000000000011989d061565e5d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><div><br></div><div>My user space process contai=
ns 2 threads:</div><div><br></div><div>First thread is blocked upon a kerne=
l event created by a hardware interrupt handled by the kernel.</div><div>Th=
e=C2=A0 thread is sending ioctl which is blocked till this interrupt occurs=
.=C2=A0=C2=A0</div><div><br></div><div>Second thread has just a 5msec=C2=A0=
sleep. It does something and then sleeps for 5msec. Forever.=C2=A0</div><di=
v><br></div><div>Is it possible to see when each thread is running (and not=
 blocked or sleeps) ?</div><div>I know how to do it with user events. I won=
der if it&#39;s possible without any extra code.=C2=A0</div><div><br></div>=
<div>Thank you,</div><div>Zvika=C2=A0</div></div>

--00000000000011989d061565e5d8--

--===============3035680157342520955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3035680157342520955==--
