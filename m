From: =?utf-8?Q?D=C3=A1vid_Beck?= <david.beck.priv@gmail.com>
Subject: Patch for lttng tools to build on Mac OSX 10.11.6
Date: Sun, 21 May 2017 16:30:45 +0100
Message-ID: <A82E93B1-509F-424C-B36F-7011D685BDC9__21845.635775435$1495380656$gmane$org@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/mixed; boundary="===============6773555965466972361=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-x235.google.com (mail-wm0-x235.google.com
 [IPv6:2a00:1450:400c:c09::235])
 by lists.lttng.org (Postfix) with ESMTPS id 3wW5Nw1Fzdz10C4
 for <lttng-dev@lists.lttng.org>; Sun, 21 May 2017 15:31:27 +0000 (UTC)
Received: by mail-wm0-x235.google.com with SMTP id 7so38236659wmo.1
 for <lttng-dev@lists.lttng.org>; Sun, 21 May 2017 08:30:47 -0700 (PDT)
Received: from [192.168.0.14]
 (cpc108967-cmbg20-2-0-cust174.5-4.cable.virginm.net. [81.101.6.175])
 by smtp.gmail.com with ESMTPSA id x126sm18825164wme.12.2017.05.21.08.30.44
 for <lttng-dev@lists.lttng.org>
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 21 May 2017 08:30:44 -0700 (PDT)
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


--===============6773555965466972361==
Content-Type: multipart/alternative; boundary="Apple-Mail=_56FC087A-ADB0-4AF1-B238-556407B77BBF"


--Apple-Mail=_56FC087A-ADB0-4AF1-B238-556407B77BBF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hello Lttng Devs,

Please find a patch attached for building lttng tools with these =
configure flags (on Max OSX):

./configure --without-lttng-ust --disable-man-pages =
--disable-bin-lttng-consumerd --disable-bin-lttng-sessiond =
--disable-bin-lttng-crash --disable-kmod --disable-extras


Best, David



--Apple-Mail=_56FC087A-ADB0-4AF1-B238-556407B77BBF
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_CDD5D47E-B07E-4B3D-9572-636293F1250B"


--Apple-Mail=_CDD5D47E-B07E-4B3D-9572-636293F1250B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">Hello Lttng Devs,<div class=3D""><br class=3D""></div><div =
class=3D"">Please find a patch attached for building lttng tools with =
these configure flags (on Max OSX):</div><div class=3D""><br =
class=3D""></div><div class=3D""><div style=3D"margin: 0px; font-size: =
11px; line-height: normal; font-family: Menlo;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">./configure --without-lttng-ust --disable-man-pages =
--disable-bin-lttng-consumerd --disable-bin-lttng-sessiond =
--disable-bin-lttng-crash --disable-kmod =
--disable-extras</span></div></div><div class=3D""><br =
class=3D""></div><div class=3D""><br class=3D""></div><div =
class=3D"">Best, David</div><div class=3D""><br class=3D""></div><div =
class=3D""><br class=3D""></div><div class=3D""><div style=3D"margin: =
0px; font-size: 11px; line-height: normal; font-family: Menlo;" =
class=3D""></div></div></body></html>=

--Apple-Mail=_CDD5D47E-B07E-4B3D-9572-636293F1250B
Content-Disposition: attachment;
	filename=0001-Fix-build-on-Mac-OSX-10.11.6.patch
Content-Type: application/octet-stream;
	name="0001-Fix-build-on-Mac-OSX-10.11.6.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20b0050fde3ff3e9e81aba8491b00489515e7fd64b=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20David=20Beck=20<david.beck.priv@gmail.com>=0A=
Date:=20Sun,=2021=20May=202017=2016:18:49=20+0100=0ASubject:=20[PATCH=20=
lttng-tools]=20Fix=20build=20on=20Mac=20OSX=2010.11.6=0A=0A=
Signed-off-by:=20David=20Beck=20<david.beck.priv@gmail.com>=0A---=0A=20=
src/bin/lttng/commands/view.c=20|=209=20+++++++++=0A=20=
src/common/compat/time.h=20=20=20=20=20=20|=201=20+=0A=202=20files=20=
changed,=2010=20insertions(+)=0A=0Adiff=20--git=20=
a/src/bin/lttng/commands/view.c=20b/src/bin/lttng/commands/view.c=0A=
index=20c9a5fdc..d57f223=20100644=0A---=20=
a/src/bin/lttng/commands/view.c=0A+++=20b/src/bin/lttng/commands/view.c=0A=
@@=20-24,6=20+24,15=20@@=0A=20#include=20<sys/types.h>=0A=20#include=20=
<unistd.h>=0A=20=0A+#ifdef=20__APPLE__=0A+#include=20<limits.h>=0A=
+#ifndef=20HOST_NAME_MAX=0A+#ifdef=20_POSIX_HOST_NAME_MAX=0A+#define=20=
HOST_NAME_MAX=20_POSIX_HOST_NAME_MAX=0A+#endif=20/*HOST_NAME_MAX*/=0A=
+#endif=20/*_POSIX_HOST_NAME_MAX*/=0A+#endif=20/*__APPLE__*/=0A+=0A=20=
#include=20"../command.h"=0A=20=0A=20static=20char=20*opt_session_name;=0A=
diff=20--git=20a/src/common/compat/time.h=20b/src/common/compat/time.h=0A=
index=2017447b3..cf4eb88=20100644=0A---=20a/src/common/compat/time.h=0A=
+++=20b/src/common/compat/time.h=0A@@=20-29,6=20+29,7=20@@=0A=20=0A=20=
typedef=20uint64_t=20timer_t;=0A=20=0A+#include=20<errno.h>=0A=20=
#include=20<mach/mach.h>=0A=20#include=20<mach/clock.h>=0A=20=0A--=20=0A=
2.8.4=20(Apple=20Git-73)=0A=0A=

--Apple-Mail=_CDD5D47E-B07E-4B3D-9572-636293F1250B
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv="Content-Type" content="text/html charset=us-ascii"></head><body style="word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" class=""><div class=""><div style="margin: 0px; font-size: 11px; line-height: normal; font-family: Menlo;" class=""></div></div></body></html>
--Apple-Mail=_CDD5D47E-B07E-4B3D-9572-636293F1250B--

--Apple-Mail=_56FC087A-ADB0-4AF1-B238-556407B77BBF--

--===============6773555965466972361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6773555965466972361==--
