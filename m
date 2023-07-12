Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B27EB64DA
	for <lttng-dev@archiver.kernel.org>; Wed, 12 Jul 2023 16:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1689180396;
	bh=sdQd0afBtomOcc6IGfuTmFgp/YRxj1Z0fXFdWe+Y7L0=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=WUezXaK16FyxBDTETbkty2cgd2WgHMVDoPNEKOguvWIYXA7Gv70Uh3rY1jNMaLHaq
	 BkLV34OIPuobdCaQvHoEsaa4JHFygG5uyVAczffHSbLPDavJRCFu0gQKH88bYQvBWQ
	 ogFhjiiEUisgmJv0zxeUbyLh4wfvY7kkzodX2YV6R1EEunYe+anPPfeXjh53DNN/5n
	 JXDBIMTuNF6GuL0P8Bt6Jod0/3e2NK7bF/Cd+d8XoAymzyu1Mz01bT/CDnMWw8YhAO
	 CQHM/uFPz7xdEp+rdAYYkQiJeszEu+iufI6yKynp4RGQ0dit0ztK4cP/uNGro7x21m
	 uWXMo9v+l/Y5g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4R1NtM2jwNz28r6;
	Wed, 12 Jul 2023 12:46:35 -0400 (EDT)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by lists.lttng.org (Postfix) with ESMTPS id 4R1NtK41tPz28r4
 for <lttng-dev@lists.lttng.org>; Wed, 12 Jul 2023 12:46:33 -0400 (EDT)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-991fe70f21bso897108566b.3
 for <lttng-dev@lists.lttng.org>; Wed, 12 Jul 2023 09:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689180392; x=1691772392;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bj82++NCMc7CQus9ZcSzHIg/g0Fr8sijjrP82m7mhMQ=;
 b=ctNhMESZ9DIvRhWNBxleZddhNzq2k9X3cL1LJrx1YQwUL75FBbGAMuB0mevygq0gzx
 0f94DhiBNVzytmpCybg+suZkzYRtfT5K13cNboZw1i2Rv0fs3LRwKB5qSRhNziaeu0U1
 ceXxbZLv0jB8c4fvVoXrjTcAPayAQF/mf553S/02Ovk2dyyXdOoKJFv962SS2O5pbyYw
 7ak3+GK0FGJprNqY603RwPRkTdexsibqpjTvyLbiQZRbItASHIdDdCC7/SWZrLyGhSui
 kwpe6+S2T3iSdPfLzczLMpy8tlLaQyVCV3yxkJpnT1V1YVEyamhaa3vwyKYWMQyMKX0n
 0aDQ==
X-Gm-Message-State: ABy/qLbWJ/HFPrnu3l9YWPNml58+Wi3sarpU4wLlDrGmA5By0KIXEJRQ
 5q6Nmm6B/t1jDjAgLzVU80MxWJcX3RYtAcSnlQQEgx4zKPajYg==
X-Google-Smtp-Source: APBJJlGfY8WYPCiv9AAF6RwmdCS50KWF5gQX/I+fil4YhzNd7zrheX/y2izb7YvfEmrBZfE26kp86vSMccKm7l+GC9A=
X-Received: by 2002:a17:906:10a:b0:974:6de:8a5e with SMTP id
 10-20020a170906010a00b0097406de8a5emr24080259eje.40.1689180391606; Wed, 12
 Jul 2023 09:46:31 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 12 Jul 2023 12:44:31 -0400
Message-ID: <CAMxxxdN63wa8RuVwzQeEqBeumcpQag9PVky7bvVWvDLDoBrqBA@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] The option --enable-jni-interface
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
From: Adel Belkhiri via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Adel Belkhiri <adel.belkhiri@gmail.com>
Content-Type: multipart/mixed; boundary="===============7426864841822799567=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============7426864841822799567==
Content-Type: multipart/alternative; boundary="00000000000034114206004cf549"

--00000000000034114206004cf549
Content-Type: text/plain; charset="UTF-8"

Hello,

Can anyone plz help me understand the configuration
option --enable-jni-interface. As far as I know, we can trace Java programs
using loggers whether this option is enabled or not. Am I wrong?
I'm asking this question because I'm looking for a way to trace a Java
application without using Loggers as this method does not enable events
recording to be synchronous with the code execution.

Thank you.

--00000000000034114206004cf549
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>Can anyone plz help me understan=
d the configuration option=C2=A0--enable-jni-interface. As far as=C2=A0I kn=
ow, we can trace Java programs using loggers whether this option is enabled=
 or not. Am I wrong?</div><div>I&#39;m asking this question because I&#39;m=
 looking for a way to trace a Java application without using Loggers as thi=
s method does not enable events recording to be synchronous with the code=
=C2=A0execution.=C2=A0<br></div><div><br></div><div>Thank you.</div></div>

--00000000000034114206004cf549--

--===============7426864841822799567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7426864841822799567==--
