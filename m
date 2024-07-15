Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F736C3DA59
	for <lttng-dev@archiver.kernel.org>; Mon, 15 Jul 2024 22:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1721081449;
	bh=afyhdrpGavU4Y9GmR68MuL9+9z+MQ+V7XB7YGHjsGV8=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=qc4uWUfXUSaNYl6QP8wF3S1IrKgauW5JfxqJOmnOuztDxnjYjhxVi3Tm8uUon0X3B
	 hV0zoxkHy85i5O2dkkq9vUz/09Ovz2+CRHw3kwQ508ALtU9i27CnCPxBuAwLylbqcz
	 1xo6c/d9KsKku5MVG55Xt3v41ARGqCFKAD6BGt3/b66jPQ2u/vI0lmRCtNCD1tpX+4
	 uaIiP7OZ1YaR1zwXxh0kIj4zV2i+SYyDAqXCj9LntJn3QAh3uMXJg6q1WODp8kcJYU
	 8f2xaIEqlIkEYHRWuz0+IR8HuSoGMJtFYIBBbirBv5eODhLx6Td4hnJ80wFteX/7HR
	 DR00z4DetGCHw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WNGc84yQyz11l9;
	Mon, 15 Jul 2024 18:10:48 -0400 (EDT)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by lists.lttng.org (Postfix) with ESMTPS id 4WNGc74QSzz11s9
 for <lttng-dev@lists.lttng.org>; Mon, 15 Jul 2024 18:10:47 -0400 (EDT)
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fbda48631cso34282385ad.0
 for <lttng-dev@lists.lttng.org>; Mon, 15 Jul 2024 15:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721081446; x=1721686246;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ioo+FCcpQvQr545OXoQryRSDoP1hO1nPvzFxAjZWGeo=;
 b=D2OpX6Ts+rwF/ztI/h26DOUb3jqFzZQNAsG4BMLsDMGhszDVvsNX593FB8Tn1FVyPz
 L5rrR90iTEMK42DMcoVUc8ZyvocMReM0sx3mJNvkJ4sHjeNrWo47MpCZfehxYaI4uBhC
 3wFaSHraZq00eiq8YPxj3Mn1UsX6tmb3xvr83oRTM1Gx/7dC3EYMI0UaR6Q4i/NO4flf
 zFJd5vAh1Y8S2xjTK8xSLWUFpXdIlg10/uXpCVUTVrTMV3ga05b5UvD7be073Mdf+Z6u
 qVhfC7baDitMNPUcqAeJkn1y1xdgZn+yXbdy5uadKKcI5Zk/3SY1PNdU4VrYenLC9jVd
 jgEA==
X-Gm-Message-State: AOJu0Ywnb/qNw0wjawNCqNcEZ2RXEAN2EzU87C8Mk0yMpIy/fEieckZE
 lXKbtbHPboJ+M3lE0erIa9ScIyp3o64UsD/aUTw7oGz5sQ0SCFXOJnXpq+0ntAmt70Nr58Yyplx
 pIKDKfuULTq3Fbc/Zo+/lO1jm4GT2CkFj
X-Google-Smtp-Source: AGHT+IEFGNkRb1AJRrTg9VcpBUr8tRjCktGtYYX4PmRrdc7s4/Krtak/4BoBSO0jv9ZCTCCjTu8sS8NNgmePT+bbUfw=
X-Received: by 2002:a17:903:2441:b0:1fb:8a0e:771b with SMTP id
 d9443c01a7336-1fc3d84c783mr3664395ad.29.1721081444766; Mon, 15 Jul 2024
 15:10:44 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 15 Jul 2024 18:10:33 -0400
Message-ID: <CAHD10UjoaOjqZUH4j55Ra7zJ2HVRLOyk7xnjv+BjnJxs6rN6Aw@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] loading modules with modprobe
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
From: =?utf-8?q?Fran=C3=A7ois_Belias_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?UTF-8?Q?Fran=C3=A7ois_Belias?= <beliasossim@gmail.com>
Content-Type: multipart/mixed; boundary="===============3063704448153002757=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3063704448153002757==
Content-Type: multipart/alternative; boundary="000000000000251d29061d5080ea"

--000000000000251d29061d5080ea
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm currently running Linux kernel version 6.5.0-41-generic and attempting
to install LTTng from source. Here are the steps I followed:

 - I cloned the LTTng git repository to my computer from [
https://github.com/lttng/lttng-modules.git](https://github.com/lttng/lttng-modules.git)
.
- Downloaded the kernel source tree corresponding to my kernel version to
enable compilation.
- Executed `make KERNELDIR=/path/to/my/linux/source`, which was completed
successfully.
- Ran `make KERNELDIR=/path/to/my/linux/source modules_install`, also
without any issues.
- Finally, I executed `sudo depmod -a`, which was completed successfully.

However, when I attempt to load a module with commands like `sudo modprobe
lttng-ketprobes` or "sudo modprobe lttng-tracer", I encounter the following
errors:

- For `lttng-ketprobes`: `modprobe: FATAL: Module lttng-ketprobes not found
in directory /lib/modules/6.5.0-41-generic`.
- For `lttng-tracer`: `modprobe: ERROR: could not insert 'lttng_tracer':
Exec format error`.

I've confirmed that the modules exist but can't load them. I'm unsure how
to resolve these issues. Could someone please assist me?

Thank you.

--000000000000251d29061d5080ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>I&#39;m currently running Linux kernel versi=
on 6.5.0-41-generic and attempting to install LTTng from source. Here are t=
he steps I followed:<br><br>=C2=A0- I cloned the LTTng git repository to my=
 computer from [<a href=3D"https://github.com/lttng/lttng-modules.git](http=
s://github.com/lttng/lttng-modules.git)">https://github.com/lttng/lttng-mod=
ules.git](https://github.com/lttng/lttng-modules.git)</a>.<br>- Downloaded =
the kernel source tree corresponding to my kernel version to enable compila=
tion.<br>- Executed `make KERNELDIR=3D/path/to/my/linux/source`, which was =
completed successfully.<br>- Ran `make KERNELDIR=3D/path/to/my/linux/source=
 modules_install`, also without any issues.<br>- Finally, I executed `sudo =
depmod -a`, which was completed successfully.<br><br>However, when I attemp=
t to load a module with commands like `sudo modprobe lttng-ketprobes` or &q=
uot;sudo modprobe lttng-tracer&quot;, I encounter the following errors:<br>=
<br>- For `lttng-ketprobes`: `modprobe: FATAL: Module lttng-ketprobes not f=
ound in directory /lib/modules/6.5.0-41-generic`.<br>- For `lttng-tracer`: =
`modprobe: ERROR: could not insert &#39;lttng_tracer&#39;: Exec format erro=
r`.<br><br>I&#39;ve confirmed that the modules exist but can&#39;t load the=
m. I&#39;m unsure how to resolve these issues. Could someone please assist =
me?<br><br>Thank you.<br></div>

--000000000000251d29061d5080ea--

--===============3063704448153002757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3063704448153002757==--
