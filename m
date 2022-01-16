Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6B2C433EF
	for <lttng-dev@archiver.kernel.org>; Mon, 17 Jan 2022 14:30:45 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JcvTJ1GtnzHwQ;
	Mon, 17 Jan 2022 09:30:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642429844;
	bh=uxcPWq7cE/XVRvLU1gxERZ7wD7uF8umN7qdKRQ3Eb/E=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=mQyOj7V9VML0huWC5j2l9vPteHJItM61AIuIjFSB0tBuia5JiTYBu3PKd7tgbeloM
	 cOJZHshDkrJjwUmomznsA2PPzKxlK0erY/BwzCB9e3F62KJwdNJTLDL78/z4R5b3F3
	 vfTENGUHb1QsKnmx0pg4S8mkQ/Lu/WSQKLB4E7/X+xgH2n9jb3E9C9mSP/2mR2Wzhj
	 gQ8gqiU/lKyZQALQ1gcBKmhvEX5OjNuXQIUB/Qrx0+Hajad17tBBAqhxn2RvhvoDQ2
	 e/K4M2d1t/Hga4GvlM1etTY7jBGvSJSr10350xlISX5k/xqohMlSbaMH2gsT1PFdJK
	 DtXBk9idn8Z3w==
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by lists.lttng.org (Postfix) with ESMTPS id 4JcCWn5ljrzGb1
 for <lttng-dev@lists.lttng.org>; Sun, 16 Jan 2022 06:30:29 -0500 (EST)
Received: by mail-lf1-x134.google.com with SMTP id e3so43858816lfc.9
 for <lttng-dev@lists.lttng.org>; Sun, 16 Jan 2022 03:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=t3L6ZKELZI56LpygdtPawD6F+AL0FRtHognSmtKzTYU=;
 b=QO/vXo/cYJs9CAZ/mNzCwR814RLRIjO65xWTCHzZ7Opl9vYVgwLRD0GI1ZTxYafHir
 k80X/wVf3v5iZJ5lTBa59pc/dbOh2YmSfxILQN8VEwftFBefEMTbiwCwbiXGfByNIScb
 F8hpfq/LkEW+uRiqf0dUZIvN5TILPlffhDU25FlY4JjckQ/YcngowejwUleSyRtNtbuo
 yhOxFyGHSgK9Yl6TuxHtukTS9Z1lict+iXgOuT5fauCGvd8Pp+ozbWN7lz74xnUuShPd
 nNbyxzDHpAx0qQyKqCKM1YOHsJomC/OE4ZAlAC8e5ab8VfnO6v0RBPfSblAt6GQdVqwY
 vfcg==
X-Gm-Message-State: AOAM533NGXTSw7eoz8lkQKgnGNudu+QHx9fpWCl/rtDV/9LUXeNOD+gr
 nBRE347lCbbWmJuAtaEk2fW/sDG39DaLKg4f8YNAzGdLNipxLw==
X-Google-Smtp-Source: ABdhPJxiCc9QibPTPEqzzxU2T86kXvIWLUS0eIj4QFkYOBPKOBumwdEGo6nRvy3W3ovW0E14Q1xEVSrP4JkHO4YWRkg=
X-Received: by 2002:a2e:6f15:: with SMTP id k21mr12247503ljc.504.1642332627770; 
 Sun, 16 Jan 2022 03:30:27 -0800 (PST)
MIME-Version: 1.0
Date: Sun, 16 Jan 2022 16:59:27 +0530
Message-ID: <CABAcCUO1b5fPHKTY=9tHerojSGuJ3PpFrmqVWtrJQO3eqWn-VQ@mail.gmail.com>
To: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Mon, 17 Jan 2022 09:30:42 -0500
Subject: [lttng-dev] date in lttng trace logs
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Subrata Paul via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Subrata Paul <subrata.turs@gmail.com>
Content-Type: multipart/mixed; boundary="===============3448018341565845798=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3448018341565845798==
Content-Type: multipart/alternative; boundary="000000000000e1a17a05d5b15c8e"

--000000000000e1a17a05d5b15c8e
Content-Type: text/plain; charset="UTF-8"

Hi,
Is it possible to have date in lttng trace logs like below?

[Sat-Jan-15 06:03:53.725525515] (+2.019614411) localhost:....

--------------------------------------------------------------
Regards,
Subrata Paul

--000000000000e1a17a05d5b15c8e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi,<div>Is it possible t=
o have date in lttng trace logs like below?</div><div><br></div><div>[Sat-J=
an-15=C2=A006:03:53.725525515] (+2.019614411) localhost:....<br></div><div>=
<br clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div><table style=3D"max-width:600px;direction:ltr">
			<tbody><tr><td>=20
			 <table style=3D"max-width:440px;padding-bottom:10px;margin-bottom:8px" =
border=3D"0" cellpadding=3D"0" cellspacing=3D"0"> <tbody><tr> <td> <table b=
order=3D"0" cellpadding=3D"0" cellspacing=3D"0" style=3D"display:inline-fle=
x"> <tbody><tr> <td valign=3D"top" style=3D"vertical-align:top"><font face=
=3D"tahoma, sans-serif">---------------------------------------------------=
-----------<br>Regards,<br>Subrata Paul</font></td><td valign=3D"top" style=
=3D"vertical-align:top;padding-left:12px"></td></tr></tbody></table></td></=
tr></tbody></table></td></tr></tbody></table>
	</div></div></div></div></div></div></div></div>

--000000000000e1a17a05d5b15c8e--

--===============3448018341565845798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3448018341565845798==--
