Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483C5C4345F
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Apr 2024 15:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1713972318;
	bh=QKZtHYDxTDgy3ZxHatZp1We6a+SyDk3x8Xl3L/jamew=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=LhBvxRfG1BUz6BL6rxiO/WqIO+qfnrXTPeePIIAfp310FY8sGIs4/0ZegXekWVcAH
	 804wzCropacvqWMm7tl6HkS4AzN4UVTsiPdUALfRwODwwL7B/4pSzjS9TvzjhnOWUH
	 Gxp0m6ACdmKLcTXNoE7TERFVh5Zcki67lU8oiKzbhrIVwYs/cxtGsR1ztAJq/KtuRr
	 oztBpqlFAA+PuTwG1ui+Axwx4QDw4sPZdRflehMbfQunW0N2os18OvKK+bxe8o7EgM
	 pLDmQ5zNSVerrdZdgLxVZe0Z7CVCl8BHo6XjBkgt1u+7nueTxB3Qj0EsuWKpqFcs+J
	 Td1NUYeyTrywQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VPjV53XK7z2jf4;
	Wed, 24 Apr 2024 11:25:17 -0400 (EDT)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 by lists.lttng.org (Postfix) with ESMTPS id 4VPjV40ppyz2jTp
 for <lttng-dev@lists.lttng.org>; Wed, 24 Apr 2024 11:25:15 -0400 (EDT)
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-ddda842c399so6914107276.3
 for <lttng-dev@lists.lttng.org>; Wed, 24 Apr 2024 08:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713972315; x=1714577115;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nkZm1k5Z94WGIyKW0kd8mI1/A55QU99rdQG5aUyr3ZA=;
 b=Z9NVJ97YzIqhWUcgDm0/yB/wpYUvdEDBGG5KlHWIBymwuXwcN7GQ4STEfNZyYybySY
 xzFCCi9sW7wAerCpubi3/Dy1TNSv173X/pJ7XnHMYK0phR7VVv9ngz+nqH5OKdes/cyV
 pWSIJxr2uSXdNr1WMoHGAwYBU4v/X5vWwrx/RODSf2uffDcXTsndK6CW+jD/zQFFQCfW
 n/O8HVBMUsx4hTzvoNpI4bYdvuew1SvPFlsvoUBrBWdrAtjcvO4LsUqOF2+NSin/gnkt
 UgZcVdT4jEKj7zdtxMOnzTCFYyvIhM90I6xrMYlvZQARjdKItx1udA0C2Kahz2LXKAIh
 0A4A==
X-Gm-Message-State: AOJu0YzoGslELEETMcIEXv/HngRaReuXe/3KTCnmS3dxef+QO0mtNEoD
 bM4f1qSonlp2nteVDeWq7Wcud6Yflf4iMjVaUbqfB13U6MME8y9on2yorz6jRmISYMYf29aAkVr
 FcU9b8qzQIo74+PsFkRLhSxS+3xvWJopFxVQ=
X-Google-Smtp-Source: AGHT+IGcLNsIv6TgpzUAAB0XBdjl125qOGQXtg6IIAQqIQZS0N49gUI718kimHKbXV3HRnty6Zg8o5vdrPfKBqlvy4Y=
X-Received: by 2002:a05:6902:2604:b0:dc6:d87c:fc73 with SMTP id
 dw4-20020a056902260400b00dc6d87cfc73mr3875857ybb.35.1713972314539; Wed, 24
 Apr 2024 08:25:14 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 24 Apr 2024 20:55:04 +0530
Message-ID: <CAFV=bvmbx3_k=f13R=NTEADbiVdaT0q8Z9cMwixcs76vuBg_Jw@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] LTTng UST Benchmarks
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
From: Aditya Kurdunkar via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Aditya Kurdunkar <adityakurdunkar2@gmail.com>
Content-Type: multipart/mixed; boundary="===============8657467504285525076=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8657467504285525076==
Content-Type: multipart/alternative; boundary="000000000000f696d90616d94615"

--000000000000f696d90616d94615
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone, I was working on a use case where I am working on enabling
LTTng on an embedded ARM device running the OpenBMC linux distribution. I
have enabled the lttng yocto recipe and I am able to trace my code. The one
thing I am concerned about is the performance overhead. Although the
documentation mentions that LTTng has the lowest overhead amongst all the
available solutions, I am concerned about the overhead of the LTTng UST in
comparison to other available tracers/profilers. I have used the
benchmarking setup from lttng-ust/tests/benchmark at master =C2=B7
lttng/lttng-ust (github.com)
<https://github.com/lttng/lttng-ust/tree/master/tests/benchmark> to
benchmark the overhead of the tracepoints (on the device). The benchmark,
please correct me if I am wrong, gives the overhead of a single tracepoint
in your code. Although this might be fine for now, I was just wondering if
there are any published benchmarks comparing LTTng with the available
tracing/profiling solutions. If not, how can I go about benchmarking the
overhead of the applications?

I have come across the lttng/lttng-ust-benchmarks (github.com)
<https://github.com/lttng/lttng-ust-benchmarks> repository which has no
documentation on how to run it, apart from one commit message on how to run
the benchmark script.

Any help is really appreciated. Thank you.

Regards,
Aditya

--000000000000f696d90616d94615
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hello everyone, I was wo=
rking on a use case where I am working on enabling LTTng on an embedded ARM=
 device running the OpenBMC linux distribution. I have enabled the lttng yo=
cto recipe and I am able to trace my code. The one thing I am concerned abo=
ut is the=C2=A0performance overhead. Although the documentation mentions th=
at LTTng has the lowest overhead amongst all the available solutions, I am =
concerned about the overhead of the LTTng UST in comparison to other=C2=A0a=
vailable=C2=A0tracers/profilers. I have used the benchmarking setup from=C2=
=A0<a href=3D"https://github.com/lttng/lttng-ust/tree/master/tests/benchmar=
k">lttng-ust/tests/benchmark at master =C2=B7 lttng/lttng-ust (github.com)<=
/a>=C2=A0to benchmark the overhead of the tracepoints (on the device). The =
benchmark, please correct me if I am wrong, gives the overhead of a single =
tracepoint in your code. Although this might be fine for now, I was just wo=
ndering if there are any published benchmarks comparing LTTng with the avai=
lable tracing/profiling solutions. If not, how can I go about=C2=A0benchmar=
king the overhead of the applications?=C2=A0<br><br>I have come across=C2=
=A0the=C2=A0<a href=3D"https://github.com/lttng/lttng-ust-benchmarks">lttng=
/lttng-ust-benchmarks (github.com)</a>=C2=A0repository which has no documen=
tation=C2=A0on how to run it, apart from one commit message on how to run t=
he benchmark script.=C2=A0<br><br>Any help is really appreciated. Thank you=
.=C2=A0<br><br>Regards,=C2=A0<br>Aditya</div></div></div>

--000000000000f696d90616d94615--

--===============8657467504285525076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8657467504285525076==--
