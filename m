From: Marko Vucak <vucakmarko@gmail.com>
Subject: Arch arm cross-complie lttng-modules
Date: Thu, 5 May 2016 15:15:50 +0200
Message-ID: <CAEmDgcqm=0ovvUZds48cCihNh7oCGfr5x_erkm9Z73Zu_CC7cg__11966.4036356427$1462454174$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1470068413064262413=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com
 [209.85.213.52])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id F02D8A09C9
 for <lttng-dev@lists.lttng.org>; Thu,  5 May 2016 13:15:51 +0000 (UTC)
Received: by mail-vk0-f52.google.com with SMTP id r16so24708631vkf.3
 for <lttng-dev@lists.lttng.org>; Thu, 05 May 2016 06:15:51 -0700 (PDT)
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

--===============1470068413064262413==
Content-Type: multipart/alternative; boundary=94eb2c0b726a2876b70532182434

--94eb2c0b726a2876b70532182434
Content-Type: text/plain; charset=UTF-8

Hi

When trying to cross-complie lttng-modules with Linux 3.14 ARCH ARM build
using this command:
make KERNELDIR=/home/muser/Projects/st-linux-mainline/

I get this errors:


In file included from include/linux/fs.h:8:0,
                 from include/linux/ftrace.h:18,
                 from include/linux/kprobes.h:42,
                 from
/home/muser/LTTngArch/lttng-modules-2.7.1/lttng-events.h:28,
                 from
/home/muser/LTTngArch/lttng-modules-2.7.1/lttng-tracer.h:40,
                 from
/home/muser/LTTngArch/lttng-modules-2.7.1/lttng-ring-buffer-client-discard.c:24:
include/linux/dcache.h:163:1: error: requested alignment is not an integer
constant
 } ____cacheline_aligned;
 ^
In file included from include/linux/ftrace.h:18:0,
                 from include/linux/kprobes.h:42,
                 from
/home/muser/LTTngArch/lttng-modules-2.7.1/lttng-events.h:28,
                 from
/home/muser/LTTngArch/lttng-modules-2.7.1/lttng-tracer.h:40,
                 from
/home/muser/LTTngArch/lttng-modules-2.7.1/lttng-ring-buffer-client-discard.c:24:
include/linux/fs.h:1588:1: error: requested alignment is not an integer
constant
 } ____cacheline_aligned;
 ^
make[2]: ***
[/home/muser/LTTngArch/lttng-modules-2.7.1/lttng-ring-buffer-client-discard.o]
Error 1
make[1]: *** [_module_/home/muser/LTTngArch/lttng-modules-2.7.1] Error 2
make[1]: Leaving directory `/home/muser/Projects/st-linux-mainline'
make: *** [default] Error 2

Additional info:

Linux is 3.14 build with:
make ARCH=arm CROSS_COMPILE=arm-v5te-linux-gnueabi-

LTTng modules used are downloaded from here:
http://lttng.org/files/lttng-modules/lttng-modules-2.7.1.tar.bz2
I tried clone it from https://aur.archlinux.org/lttng-modules.git but
doesn't exists anymore.

--94eb2c0b726a2876b70532182434
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><div><br></div><div>When trying to cross-comp=
lie lttng-modules with Linux 3.14 ARCH ARM build using this command:</div><=
div>make KERNELDIR=3D/home/muser/Projects/st-linux-mainline/</div><div><br>=
</div><div>I get this errors:</div><div><br></div><div><br></div><div>In fi=
le included from include/linux/fs.h:8:0,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from include/linux/ftrace.h:18,</div>=
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from inc=
lude/linux/kprobes.h:42,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0from /home/muser/LTTngArch/lttng-modules-2.7.1/lttn=
g-events.h:28,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from /home/muser/LTTngArch/lttng-modules-2.7.1/lttng-tracer.h:=
40,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from /home/muser/LTTngArch/lttng-modules-2.7.1/lttng-ring-buffer-client-=
discard.c:24:</div><div>include/linux/dcache.h:163:1: error: requested alig=
nment is not an integer constant</div><div>=C2=A0} ____cacheline_aligned;</=
div><div>=C2=A0^</div><div>In file included from include/linux/ftrace.h:18:=
0,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
from include/linux/kprobes.h:42,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /home/muser/LTTngArch/lttng-modules-2.7=
.1/lttng-events.h:28,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0from /home/muser/LTTngArch/lttng-modules-2.7.1/lttng-tr=
acer.h:40,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0from /home/muser/LTTngArch/lttng-modules-2.7.1/lttng-ring-buffer-=
client-discard.c:24:</div><div>include/linux/fs.h:1588:1: error: requested =
alignment is not an integer constant</div><div>=C2=A0} ____cacheline_aligne=
d;</div><div>=C2=A0^</div><div>make[2]: *** [/home/muser/LTTngArch/lttng-mo=
dules-2.7.1/lttng-ring-buffer-client-discard.o] Error 1</div><div>make[1]: =
*** [_module_/home/muser/LTTngArch/lttng-modules-2.7.1] Error 2</div><div>m=
ake[1]: Leaving directory `/home/muser/Projects/st-linux-mainline&#39;</div=
><div>make: *** [default] Error 2</div><div><br></div><div>Additional info:=
</div><div><br></div><div>Linux is 3.14 build with:</div><div>make ARCH=3Da=
rm CROSS_COMPILE=3Darm-v5te-linux-gnueabi-</div><div><br></div><div>LTTng m=
odules used are downloaded from here:</div><div><a href=3D"http://lttng.org=
/files/lttng-modules/lttng-modules-2.7.1.tar.bz2">http://lttng.org/files/lt=
tng-modules/lttng-modules-2.7.1.tar.bz2</a></div><div>I tried clone it from=
 <a href=3D"https://aur.archlinux.org/lttng-modules.git">https://aur.archli=
nux.org/lttng-modules.git</a> but doesn&#39;t exists anymore.</div><div><di=
v class=3D"gmail_signature"><div dir=3D"ltr"><div style=3D"font-size:12.8px=
"><br></div></div></div></div>
</div>

--94eb2c0b726a2876b70532182434--

--===============1470068413064262413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1470068413064262413==--
