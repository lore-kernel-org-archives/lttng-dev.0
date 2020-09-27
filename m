Return-Path: <SRS0=mi93=DE=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1168C4346E
	for <lttng-dev@archiver.kernel.org>; Sun, 27 Sep 2020 13:54:56 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77607221E5
	for <lttng-dev@archiver.kernel.org>; Sun, 27 Sep 2020 13:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="A5z+fBYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77607221E5
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BznG541fKzMDK;
	Sun, 27 Sep 2020 09:54:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1601214894;
	bh=xbB3Lak38NdNEnb5FpOpIB0rNkXdEiZcxWlUN8p6VhY=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=A5z+fBYudcZ4Q96meE+eNlsHw/nGU9hbtD6jcSuEVkh8BDcaKhZ6fCK9A5lBs3S6J
	 Wh7e/PhyxKGS6F28tIlN64Qr/nDEKbEJjdzTO0Wcr2fwbiqaz+9stIH15lSTxQR4d8
	 4tHqYgovZiUDdVMtY5qLA+ldkfSsVaLnwbaQzLAwbycJ/A/GSUt3XtnyUXqbi1SAYD
	 f4+jNUPy3Z8M0hczozsAnFGHC5MCGdmwdJS+Lc4sI8DC0J/rs3JVEXnZ953W41Zgro
	 px0t2T3oGKTNppiisr4eHBO2cL+L2bh0fvIManfxNrve60Nub0d6VRR5j10kTivvTv
	 yY4feNSZb+OhA==
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by lists.lttng.org (Postfix) with ESMTPS id 4BznG40SHrzLd9
 for <lttng-dev@lists.lttng.org>; Sun, 27 Sep 2020 09:54:51 -0400 (EDT)
Received: by mail-ot1-x32e.google.com with SMTP id n61so6969195ota.10
 for <lttng-dev@lists.lttng.org>; Sun, 27 Sep 2020 06:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=A8iEfGohMBDf7GzYOQEsl6E90o5Vmk2F9zRKDujPpT4=;
 b=W2YtW88kiOVj5TbL4e15IEv15tiXrfSSQNDJo3z5rOkWF/nLvWO+bSSDR6K6qSCAuW
 X/Nk4aYy3de0Kh/jSmRzUKyM6wA2Z8x7IK7TgIxvoBUc3z2Oah3l5j4elsv6ApBPMtin
 1yV8JTpZj9fPyv/ai2sVSL2DpSQpJpC84YMeQATNPCl4xg8VVO8uMhRaBzsn8WaAdfJ2
 ibFsJRHCrPlElUrnX097ifwAAqobWUQ2DsshgvO9n9vY0LHPgo72ke9WdT/ECEsRDg5M
 tk822PYAu0VuJ40SoudAU5c5SjicLF5pPQiEzx78tRoh6VZ5yXO13uQ7sDXHbiwTq/nY
 e1QA==
X-Gm-Message-State: AOAM532ZBZ/o6qhKVCpbQ2BLaIcUV5fMGfx4B0EcTIgJy03DSdiOzFgM
 5xWQDkXfC1dkAS0UeRoN1lPGPvMfMxlZp/pKNG3JAabaLrxCqA==
X-Google-Smtp-Source: ABdhPJwagT4TfG/FrF14UTfYO3qQ8n8el/QG2YXQXrZ6tTWbjhWye6I1RoCMrrVWslMizOFDtWlnedwFDRFm+g3glN4=
X-Received: by 2002:a9d:4c01:: with SMTP id l1mr6188304otf.341.1601214890783; 
 Sun, 27 Sep 2020 06:54:50 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 27 Sep 2020 16:54:35 +0300
Message-ID: <CABhb4uvWv1ewuK0Eq_UMBq2qY4kS-AUHqytYa_jMN2xvfF21dQ@mail.gmail.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] LTTng packages
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
From: Valentin Grigorev via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Valentin Grigorev <valentin.grigorev@jetbrains.com>
Content-Type: multipart/mixed; boundary="===============4090765330173369270=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============4090765330173369270==
Content-Type: multipart/alternative; boundary="000000000000c6662c05b04be40b"

--000000000000c6662c05b04be40b
Content-Type: text/plain; charset="UTF-8"

Hello!

Is it planned to publish LTTng 2.12 packages for Linux distributives except
Ubuntu and Debian. Packages for RedHat / CentOS, Fedora, Arch, etc are
available for previous versions.

Best regards,
Valentin Grigorev

--000000000000c6662c05b04be40b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello!<div><br></div><div>Is it planned to publish=C2=A0LT=
Tng 2.12 packages for Linux distributives except Ubuntu and Debian. Package=
s for RedHat / CentOS, Fedora, Arch, etc are available for previous version=
s.</div><div><br></div><div>Best regards,</div><div>Valentin Grigorev</div>=
</div>

--000000000000c6662c05b04be40b--

--===============4090765330173369270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4090765330173369270==--
