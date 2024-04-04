Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85331CD1288
	for <lttng-dev@archiver.kernel.org>; Thu,  4 Apr 2024 20:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1712261350;
	bh=TW7Ugy5YAlFim0/IhkBXpCUHtE7aTXyKpUosUcumRrU=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=F8xHgtDJckHQzcxArVpwwF76iDs/cEt8/+l5tsIzU5o1hT5YziQZHiyVHYUR2HYzm
	 /FCq2Nm39nLSKPMmxmm4HEt6pBqBbLG6borvQY2RSy+EEtTlQJGI3pwrBAc+Zz+6Cr
	 Mqzs/TmBAVk0SIi2a43AYBzOf8iR4m1tTZO4829peDvjG3gyI7FyuNb2IUnR1rsCyB
	 jjpnCxTRdVFbZn5K3iP3VoA3X0+SMQ9rKx0dOWm707ri4if5jfW4IHi1LVrhK8EXL/
	 t0qbZ7h8nv1jbKlt+nPCXicKOXnWVtqAH3LCZSmCY1Uv0/ie1H/n5VH6DtgaW1sDOF
	 BbRAzMsGHc4aw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4V9Xks4Mvkz2b4Z;
	Thu,  4 Apr 2024 16:09:09 -0400 (EDT)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 by lists.lttng.org (Postfix) with ESMTPS id 4V9Xkr42lYz2b7J
 for <lttng-dev@lists.lttng.org>; Thu,  4 Apr 2024 16:09:08 -0400 (EDT)
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-516d0161e13so1061351e87.3
 for <lttng-dev@lists.lttng.org>; Thu, 04 Apr 2024 13:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712261346; x=1712866146;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pPp61jJFMLmOJxuxcP+/tI9kakiNtbaA13iXRHx/Y1E=;
 b=jOpqoSXHsT6/BrblOc6Ttu1CAODW3eDgq8C2niS+qLoQ8WcPCLxAHupvjNtLsGmPzE
 2jqvBdYNm90CpS7Hd0uzRgUqSHIg3XbIDva7eHvAUB74usiiAtS1HuT14fO/gq5w/psm
 CROMq/YEf5KM1K0PtEBbafVG3Wou0X35H/VoRMYC+9i17JucClV6nrMpHewF4/K2KwfF
 qzk1XXWfWe/vJhV0kCMNbvPRyF8qc1W0+1Fu40UkbIC2mSrdLSHEwZOqsHFu1gbe5/wJ
 8UawH2Yf6vlNGgzRRL+ATKOVlv41N4gb40SziSSud+8BaRRi6f5+8ZeDh+7ZC0Xr9vZ+
 4v4A==
X-Gm-Message-State: AOJu0Yzos8V6mwVW7rHr0AHWFQnCaT7ZbRIqhbBB75cC9FdgiMzv458u
 KaYxFu6CsVnDz6WV/2hB2ubVlnB8DwODafnp+ldcKUsoFgrakwpAb5HukAvmlBeAzVaYJPzCEfm
 vC2uCde5voiQ9gz06iFjbI7rLbCsDrPxbCSs=
X-Google-Smtp-Source: AGHT+IFFAbtTGRsrhCMKdkiVuOuuYF0xWt0oAwaCfQUnwtXWifcP/i2DjrQRQwB9MuPqhu97IgS8hcacK4HpX9/Ra38=
X-Received: by 2002:a05:6512:202c:b0:515:c8da:c96d with SMTP id
 s12-20020a056512202c00b00515c8dac96dmr2374521lfs.19.1712261346312; Thu, 04
 Apr 2024 13:09:06 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 4 Apr 2024 23:08:54 +0300
Message-ID: <CABRndgyg2U-N9s5HtM1V=t89sBsr5Jt1LXbE3M+6e1=tNy3y9A@mail.gmail.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] babeltrace2 on windows
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
Content-Type: multipart/mixed; boundary="===============8151854354298027890=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8151854354298027890==
Content-Type: multipart/alternative; boundary="0000000000004f47cd06154ae9e2"

--0000000000004f47cd06154ae9e2
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm required to analyze an lttng trace with Babeltrace2 python API.
The host is running windows 10.
But according to :  https://babeltrace.org/#bt2-get
Windows is not mentioned at all.

I prefer python but I can also consider using the C library for windows.

Thank you,
Zvika

--0000000000004f47cd06154ae9e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><div><br></div><div>I&#39;m required to analyze =
an lttng trace with Babeltrace2 python API.</div><div>The host is running w=
indows 10.</div><div>But according to :=C2=A0=C2=A0<a href=3D"https://babel=
trace.org/#bt2-get">https://babeltrace.org/#bt2-get</a></div><div>Windows i=
s not mentioned at all.=C2=A0</div><div><br></div><div>I prefer python but =
I can also consider=C2=A0using the C library=C2=A0for=C2=A0windows.=C2=A0</=
div><div><br></div><div>Thank you,</div><div>Zvika=C2=A0</div><div><br></di=
v></div>

--0000000000004f47cd06154ae9e2--

--===============8151854354298027890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8151854354298027890==--
