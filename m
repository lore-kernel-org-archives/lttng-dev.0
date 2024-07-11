Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57008C3DA4A
	for <lttng-dev@archiver.kernel.org>; Thu, 11 Jul 2024 20:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1720729551;
	bh=To/5sst92sSPrjoht/in9+7sZf/Qg6QhFVcFiUphkv0=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=OgdDMnkJWk4ui0v5RQfXKtptXxKRo1nStcbxoDSl9MScDKNaSzGaAacOpTaI5vJTg
	 jQIYu8HR0QHJ6A41IDRoCc93/p/yjrWaeGifT0PSzoF4OmGwSn5V8dcLdwOjpcZyuH
	 EJVC6rFD3FUfKE7wI2MvitsRQnHZ+ThuscSi4uviVdhVqeXr/W06z+bwOSuzSlAQFR
	 s91o+yAiMHKyJWHsL+g1+W3zxLNa6Cpog5Ic+D2p14ycHZyJ/zX9ryYoxSCTrIWG4A
	 pLnbvLmdRpbSljpKTvLoMT9zI+TZYLPz82wvNaqcQ3CDpJl/XWtvJCwIpvAkfQu+UR
	 xTITwx14w1J5Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WKmSt4bq7zBc8;
	Thu, 11 Jul 2024 16:25:50 -0400 (EDT)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 by lists.lttng.org (Postfix) with ESMTPS id 4WKm2w2R96zBLB
 for <lttng-dev@lists.lttng.org>; Thu, 11 Jul 2024 16:06:48 -0400 (EDT)
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70af4868d3dso1208473b3a.3
 for <lttng-dev@lists.lttng.org>; Thu, 11 Jul 2024 13:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720728407; x=1721333207;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SGs/9I62YLwPkhFt6S0o5udrLd7P5rh5YW92xft5cmc=;
 b=VN15bAQoYoHRtk5v2CkBwrx42vWG86KT0c4a0t1813SK937lFjpj4BF9yKIyfxo33i
 V36giT5XYZRYt9Fulgj3ks2R63fcXpGsaq6evmT927Ci0LGgsO6gGVntD16PeKNPe9my
 QShrAuCfUaovwPmCgGxSYUY4pvqFC71B8Vtrfl3SMslZtkG/WnLMpkz+QqLdImkdu2u3
 KxkZMqg9u27AkTX5uskbANkk5xhzgc4FdCnPHxW4gVsD3EkCVLXfZzYpVdavH51YolKF
 7rGwRcDla9YLFyDckpKJtHXgXM3wnrLBT/gq6fGDR9nTHov1Ud1wwCFnA0IoBP4BiAmS
 05JA==
X-Gm-Message-State: AOJu0Yx05iXCbp+VBwcUfeZPpTlgvT2vJSU2rAd16PcNReNjfK3sWxlB
 +Xbkp72N1yKn4ZWeQ/Vp3RT3Pz4IW5oXijeMa6DmHkuluOgl6eFv8w6IwL+4tuYjdm9sDAyMgnk
 BegQtYkRaEzFrUNf+hxUR98NEc0X7/5eg
X-Google-Smtp-Source: AGHT+IH8hZOWLyESJ37wyFlT320vIdtBi+ssRpaIdiXcj++jwPjgnIDag6zpzYbtdasa58H1GLcSXYcy6NelD0gIMV4=
X-Received: by 2002:a05:6a20:7489:b0:1c0:e3bb:83ba with SMTP id
 adf61e73a8af0-1c298214933mr10245096637.5.1720728405948; Thu, 11 Jul 2024
 13:06:45 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 11 Jul 2024 16:06:34 -0400
Message-ID: <CAHD10UjRBLgAWAAfgOLVgxv3zMYkedtWjquOdC60XTPDifEeJA@mail.gmail.com>
To: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Thu, 11 Jul 2024 16:25:49 -0400
Subject: [lttng-dev] Undefined symbol error fix
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
Content-Type: multipart/mixed; boundary="===============3988672187589066965=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3988672187589066965==
Content-Type: multipart/alternative; boundary="000000000000644166061cfe4d3e"

--000000000000644166061cfe4d3e
Content-Type: text/plain; charset="UTF-8"

Hello,

    I am trying to access tracepoints from this website
https://archive.eclipse.org/tracecompass.incubator/doc/org.eclipse.tracecompass.incubator.virtual.machine.analysis.doc.user/Virtual-Machine-Analysis-User-Documentation.html
(kmv_entry, kmv_exit) for my analysis. I added the "addons" folder from the
"addons_vm" branch of this repository:
https://github.com/tahini/lttng-modules to the current version of
lttng-module github repository. However, I am encountering these errors
when compiling
ERROR: modpost: "lttng_tracepoint_probe_register"
[lttng-modules/src/addons/lttng-vmsync-guest.ko] undefined!
ERROR: modpost: "lttng_tracepoint_probe_unregister"
[Desktop/lttng-modules/src/addons/lttng-vmsync-guest.ko] undefined!
ERROR: modpost: "lttng_tracepoint_probe_register"
[Desktop/lttng-modules/src/addons/lttng-vmsync-host.ko] undefined!
ERROR: modpost: "lttng_tracepoint_probe_unregister"
[Desktop/lttng-modules/src/addons/lttng-vmsync-host.ko] undefined!

I am not sure how to resolve this issue. Can someone please help me?

Thanks.

--000000000000644166061cfe4d3e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br>=C2=A0 =C2=A0<br>=C2=A0 =C2=A0 I am trying to ac=
cess tracepoints from this website <a href=3D"https://archive.eclipse.org/t=
racecompass.incubator/doc/org.eclipse.tracecompass.incubator.virtual.machin=
e.analysis.doc.user/Virtual-Machine-Analysis-User-Documentation.html">https=
://archive.eclipse.org/tracecompass.incubator/doc/org.eclipse.tracecompass.=
incubator.virtual.machine.analysis.doc.user/Virtual-Machine-Analysis-User-D=
ocumentation.html</a> (kmv_entry, kmv_exit) for my analysis. I added the &q=
uot;addons&quot; folder from the &quot;addons_vm&quot; branch of this repos=
itory: <a href=3D"https://github.com/tahini/lttng-modules">https://github.c=
om/tahini/lttng-modules</a> to the current version of lttng-module github r=
epository. However, I am encountering these errors when compiling=C2=A0<div=
>ERROR: modpost: &quot;lttng_tracepoint_probe_register&quot; [lttng-modules=
/src/addons/lttng-vmsync-guest.ko] undefined!<br>ERROR: modpost: &quot;lttn=
g_tracepoint_probe_unregister&quot; [Desktop/lttng-modules/src/addons/lttng=
-vmsync-guest.ko] undefined!<br>ERROR: modpost: &quot;lttng_tracepoint_prob=
e_register&quot; [Desktop/lttng-modules/src/addons/lttng-vmsync-host.ko] un=
defined!<br>ERROR: modpost: &quot;lttng_tracepoint_probe_unregister&quot; [=
Desktop/lttng-modules/src/addons/lttng-vmsync-host.ko] undefined!<br><br>I =
am not sure how to resolve this issue. Can someone please help me?=C2=A0<di=
v><br></div><div>Thanks.<br></div></div></div>

--000000000000644166061cfe4d3e--

--===============3988672187589066965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3988672187589066965==--
