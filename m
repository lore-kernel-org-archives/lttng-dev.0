Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9786DC6FD1F
	for <lttng-dev@archiver.kernel.org>; Sun, 31 Mar 2024 02:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1711853309;
	bh=qk1Vq2hgDIigosGI7Gjq72MIjFImUgsVJQQJIgt8V3w=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=LYAc7ZGr1a1Edn5TeikZe4E4SSV/n3Yr7F/Stbwr7GNOF8hx3/qBm7Gz0AepvgU/L
	 xszcbFH9Y7uqAMrCHvA7nRyk7Xn4z2Ejcg85be+mht34Qozh8F5xtsTlDeKGfmAS8o
	 H92jAppHolvh42Gun78a2IKYM1lgl4DRkAn+DFV4MjWw+r1dee76F3FiYauTpjKjZE
	 e+5T0qmB36X1UbcfbQ/IOR7FFQbuPAwmAEeL6g80LVVd16oMzqNgLFrMxO3EDjNFTy
	 sEeu2uUHVM6Oen+gUW3tLJWTicSom3NuoSaVIo0zBjy2MCGEnb1dQtoyXqaKMECtZV
	 pwEmaCA4njBzw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4V6dqw4cXzz2YjX;
	Sat, 30 Mar 2024 22:48:28 -0400 (EDT)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by lists.lttng.org (Postfix) with ESMTPS id 4V6dqt1Qdfz2YK5
 for <lttng-dev@lists.lttng.org>; Sat, 30 Mar 2024 22:48:26 -0400 (EDT)
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d4360ab3daso38387341fa.3
 for <lttng-dev@lists.lttng.org>; Sat, 30 Mar 2024 19:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711853304; x=1712458104;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=io8rA8Fd6RguoxJULIa5VPk9lktnArYkMx+33xAfUQw=;
 b=l3xT84FQGllZcQ+2WnPFocNwqpEzJcz13HXLOCH/KVRgulmDn6n6eMppVIp8Ib+O2s
 w5wIgzOksjGcct5Mo546UJ6IYkBtEbx9SdNYwW0zKTAtHYxk1spbJnCfFLHc6119KYgf
 27/Jftvd5LOD2SrPkl4fU1tS+CTIG4VgNkG4YvwsUir62JLehbkSSoWP3Cz6oACuawWy
 dE0Ekb0uQjDwAChvTwXBrZ3u9HvJPaRt5RUh8j8+bXfFyphYwAKjwiUGXmv5tTzOAMxp
 Wb/c4U2O6s5yvJJLSyICy9oPHZHhTElxAxuWQCODrm5fBpzXUof8+pprmAn4dbidvjLP
 VT8A==
X-Gm-Message-State: AOJu0Yw6fMuWJNPQMxt+vWsX545+zmduUbvTehLzQLDeiOt4OV2zG+1N
 T4bd5T1bQDRhF09oG/EWFfq0tadMko8UatQ5ANBSWAfaWNHGMDPqeTSbEmbhrYp+ldQkJENgIdj
 xbNxSBpNHNDbByxcDHeVl+YeCZMfVKQbH
X-Google-Smtp-Source: AGHT+IEjOHXjzIQXYHAcJRw/kQsrB3JCfDKTXO4JMM4u/wDNRBOoxD8/GJ43EhFORlRvrX/sOZ09Wh9yrnyNKQAoCWQ=
X-Received: by 2002:a05:651c:4c8:b0:2d4:376f:5b44 with SMTP id
 e8-20020a05651c04c800b002d4376f5b44mr4018727lji.34.1711853303878; Sat, 30 Mar
 2024 19:48:23 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 31 Mar 2024 05:52:19 +0300
Message-ID: <CABRndgyb_=9VrrgV-Z21YDe1w879kTuE9t6m8Hoa3h-4MpfcEQ@mail.gmail.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] lttng-modules(13.9) : insmod order
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
Content-Type: multipart/mixed; boundary="===============5362190196712975152=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============5362190196712975152==
Content-Type: multipart/alternative; boundary="00000000000015de4d0614ebe817"

--00000000000015de4d0614ebe817
Content-Type: text/plain; charset="UTF-8"

Hello,

For some reason, I failed to integrate v13.9 into buildroot 2023.02.2
But I compiled all modules with the my kernel source: 5.4.249

Can you please tell what is the right order of *insmod *for the kernel
modules ?

All I need is to record IRQ events and user space events.

Thank you,
Zvika

--00000000000015de4d0614ebe817
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><div><br></div><div>For some reason, I failed to=
 integrate v13.9 into buildroot 2023.02.2=C2=A0</div><div>But I compiled al=
l modules with the my kernel source: 5.4.249</div><div><br></div><div>Can y=
ou please tell what is the right order of <b>insmod </b>for the kernel modu=
les ?</div><div><br></div><div>All I need is to record IRQ events and user =
space events.=C2=A0=C2=A0</div><div><br></div><div>Thank you,</div><div>Zvi=
ka=C2=A0</div></div>

--00000000000015de4d0614ebe817--

--===============5362190196712975152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5362190196712975152==--
