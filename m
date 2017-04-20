From: Eric Dong <eric.dongxx@gmail.com>
Subject: Regarding the liblttng:armhf installation
Date: Fri, 21 Apr 2017 00:16:47 +0800
Message-ID: <CA+JNVMxOZbe9j1f7Dm7HWd4YHeorBcfz_JwNWNw1s5PLHv7VtA__29358.3781960935$1492705059$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4101514255528981838=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-x22a.google.com (mail-io0-x22a.google.com
 [IPv6:2607:f8b0:4001:c06::22a])
 by lists.lttng.org (Postfix) with ESMTPS id 3w83v02bb5zCtM
 for <lttng-dev@lists.lttng.org>; Thu, 20 Apr 2017 16:18:04 +0000 (UTC)
Received: by mail-io0-x22a.google.com with SMTP id o22so83667824iod.3
 for <lttng-dev@lists.lttng.org>; Thu, 20 Apr 2017 09:17:28 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============4101514255528981838==
Content-Type: multipart/alternative; boundary=94eb2c05e7b4c47318054d9b7726

--94eb2c05e7b4c47318054d9b7726
Content-Type: text/plain; charset=UTF-8

Hello everyone,

I am new to LTTNG and now trying to integrate into arm-linux-gnueabihf-
toolchain to cross compile an application with LTTNG tracing capabilities.
My host machine is Ubuntu 16.04. However, when I tried to install
liblttng-ust-dev:armhf, the apt manager came across a few dependency
errors, like libuuid1-dev. And somehow, I cannot resolve to install the
libuuid-dev with apt install or dpkg install
(libuuid1_2.27.1-6ubuntu3_armhf.deb).  Looking forward to the kind help
with the method to integrate the LTTNG into a cross compiled application.
Thank you.

Regards,
Eric

--94eb2c05e7b4c47318054d9b7726
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif">Hello everyone,<br><br></div><div class=3D"gmail_default" style=
=3D"font-family:verdana,sans-serif">I am new to LTTNG and now trying to int=
egrate into arm-linux-gnueabihf- toolchain to cross compile an application =
with LTTNG tracing capabilities. My host machine is Ubuntu 16.04. However, =
when I tried to install liblttng-ust-dev:armhf, the apt manager came across=
 a few dependency errors, like libuuid1-dev. And somehow, I cannot resolve =
to install the libuuid-dev with apt install or dpkg install (libuuid1_2.27.=
1-6ubuntu3_armhf.deb).=C2=A0 Looking forward to the kind help with the meth=
od to integrate the LTTNG into a cross compiled application. Thank you.<br>=
<br></div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-se=
rif">Regards,<br></div><div class=3D"gmail_default" style=3D"font-family:ve=
rdana,sans-serif">Eric<br></div></div>

--94eb2c05e7b4c47318054d9b7726--

--===============4101514255528981838==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4101514255528981838==--
