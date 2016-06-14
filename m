From: "D'Alessandro, Luke K" <ldalessa@indiana.edu>
Subject: urcu configure/build failures on Darwin
Date: Tue, 14 Jun 2016 16:31:21 +0000
Message-ID: <BBA3E68F-E5CB-4031-903F-2838E0274D41__4365.73599367893$1465922866$gmane$org@indiana.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7138942491211474056=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from hartman.uits.indiana.edu (belushi.uits.indiana.edu
 [129.79.1.188])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 04B46A3881
 for <lttng-dev@lists.lttng.org>; Tue, 14 Jun 2016 16:31:22 +0000 (UTC)
Received: from bl-cci-exch06.ads.iu.edu (bl-cci-exch06.ads.iu.edu
 [10.79.80.139])
 by mssg-relay.indiana.edu (8.14.7/8.14.4/IU Campus Communications Team) with
 ESMTP id u5EGVLdP027793
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Tue, 14 Jun 2016 12:31:21 -0400
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7138942491211474056==
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_BF08C594-00A1-4D76-90D2-8010D131364A";
	protocol="application/pgp-signature"; micalg=pgp-sha512

--Apple-Mail=_BF08C594-00A1-4D76-90D2-8010D131364A
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_E854DC01-9357-4794-9687-AF2F12CA6D47"


--Apple-Mail=_E854DC01-9357-4794-9687-AF2F12CA6D47
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

I tried following the Darwin instructions on the website (basically =
`./configure --build=3Dx86_64-apple-darwin11` but the `clock_gettime` =
and `-lrt` dependencies don=E2=80=99t exist on Darwin).

Just for fun I removed this dependency and added a custom version of =
`clock_gettime` =
(https://github.com/lorrden/darwin-posix-rt/blob/master/clock_gettime.c =
<https://github.com/lorrden/darwin-posix-rt/blob/master/clock_gettime.c>) =
but the build still fails in `systcall-compat.h`.

```
$ make V=3D1
/Applications/Xcode.app/Contents/Developer/usr/bin/make  all-recursive
Making all in .
/bin/sh ./libtool  --tag=3DCC   --mode=3Dcompile gcc -DHAVE_CONFIG_H -I. =
-I./urcu  -I./urcu  -Wall -g -O2 -D_THREAD_SAFE -pthread -MT wfqueue.lo =
-MD -MP -MF .deps/wfqueue.Tpo -c -o wfqueue.lo wfqueue.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I./urcu -I./urcu -Wall -g =
-O2 -D_THREAD_SAFE -pthread -MT wfqueue.lo -MD -MP -MF .deps/wfqueue.Tpo =
-c wfqueue.c  -fno-common -DPIC -o .libs/wfqueue.o
In file included from wfqueue.c:28:
In file included from ./urcu/static/wfqueue.h:33:
In file included from ./urcu/uatomic.h:24:
In file included from ./urcu/system.h:23:
In file included from ./urcu/arch.h:27:
./urcu/syscall-compat.h:39:2: error: "Add platform support to =
urcu/syscall-compat.h"
#error "Add platform support to urcu/syscall-compat.h"
 ^
1 error generated.
make[2]: *** [wfqueue.lo] Error 1
make[1]: *** [all-recursive] Error 1
make: *** [all] Error 2
```

Is Darwin still a supported platform for the library?

Thanks,
Luke

--Apple-Mail=_E854DC01-9357-4794-9687-AF2F12CA6D47
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space;" class=3D""><span =
class=3D""></span><span class=3D"">I tried following the Darwin =
instructions on the website (basically `</span><span =
class=3D"">./configure --build=3Dx86_64-apple-darwin11` but the =
`clock_gettime` and `-lrt` dependencies don=E2=80=99t&nbsp;exist on =
Darwin).</span><div class=3D""><span class=3D""><br =
class=3D""></span></div><div class=3D""><span class=3D"">Just for fun I =
removed this dependency and added a custom version of `clock_gettime` =
(</span><a =
href=3D"https://github.com/lorrden/darwin-posix-rt/blob/master/clock_getti=
me.c" =
class=3D"">https://github.com/lorrden/darwin-posix-rt/blob/master/clock_ge=
ttime.c</a>) but the build still fails in =
`systcall-compat.h`.</div><span class=3D""><div class=3D""><span =
class=3D""><br class=3D""></span></div>```<br class=3D""></span><span =
class=3D"">$ make V=3D1<br =
class=3D"">/Applications/Xcode.app/Contents/Developer/usr/bin/make&nbsp;&n=
bsp;all-recursive<br class=3D"">Making all in .<br class=3D"">/bin/sh =
./libtool&nbsp;&nbsp;--tag=3DCC&nbsp;&nbsp;&nbsp;--mode=3Dcompile gcc =
-DHAVE_CONFIG_H -I. -I./urcu&nbsp;&nbsp;-I./urcu&nbsp;&nbsp;-Wall -g -O2 =
-D_THREAD_SAFE -pthread -MT wfqueue.lo -MD -MP =
-MF&nbsp;.deps/wfqueue.Tpo -c -o wfqueue.lo wfqueue.c<br =
class=3D"">libtool: compile:&nbsp;&nbsp;gcc -DHAVE_CONFIG_H -I. -I./urcu =
-I./urcu -Wall -g -O2 -D_THREAD_SAFE -pthread -MT wfqueue.lo -MD -MP -MF =
.deps/wfqueue.Tpo -c wfqueue.c&nbsp;&nbsp;-fno-common -DPIC -o =
.libs/wfqueue.o<br class=3D"">In file included from wfqueue.c:28:<br =
class=3D"">In file included from ./urcu/static/wfqueue.h:33:<br =
class=3D"">In file included from ./urcu/uatomic.h:24:<br class=3D"">In =
file included from ./urcu/system.h:23:<br class=3D"">In file included =
from ./urcu/arch.h:27:<br =
class=3D"">./urcu/syscall-compat.h:39:2:&nbsp;error:&nbsp;"Add platform =
support to urcu/syscall-compat.h"<br class=3D"">#error "Add platform =
support to urcu/syscall-compat.h"<br class=3D"">&nbsp;^<br class=3D"">1 =
error generated.<br class=3D"">make[2]: *** [wfqueue.lo] Error 1<br =
class=3D"">make[1]: *** [all-recursive] Error 1<br class=3D"">make: *** =
[all] Error 2<br class=3D""></span><span class=3D"">```</span><div =
class=3D""><span class=3D""><br class=3D""></span></div><div =
class=3D""><span class=3D"">Is&nbsp;Darwin still a supported platform =
for the library?</span></div><div class=3D""><span class=3D""><br =
class=3D""></span></div><div class=3D""><span =
class=3D"">Thanks,</span></div><div class=3D""><span =
class=3D"">Luke</span></div></body></html>=

--Apple-Mail=_E854DC01-9357-4794-9687-AF2F12CA6D47--

--Apple-Mail=_BF08C594-00A1-4D76-90D2-8010D131364A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJXYDFZAAoJEJ9t5ApCTtG01IAP/RWhiXdUQ6Nm5LXtml6J3xVV
7aK2oLXB4MHGwsUMZgB540YRpb1xCHubYG5T/a3les7AeHm15kioBxG90IoPBUu+
8z90LJIgdfahGY16uyHbbd5EEJkaLWm+LV8OONbA0F7bQxBlgqDi1OFO5L2CqQdb
cVcG8EIGYE3N1WNx199aGlDFCggDUTjeuN6hPMGy7wZwafDv7QjOTJiwzgdSVZwG
JukPvZnk1anP0nr0FPJwFQxw5FfToy7iDD9BXzqo3VTfD5AZWa4L+5WLT1O8kkVU
6PxO9nnXUmMVVhdRAJZ/J/BdKf/pCsQVl2bJw6aMgFfMhixnCcGSOR23/vMhvqtZ
a26h7/TaT2oIZgybjwuNajqnxhhjzPvMTngGYagyK4DbVn3doHYIPk4+IYm1Rt7U
mzfLrFJ7qjkkxVX7mkkwmds8B6lw5f35jCsKCkIKETBixQ4vrnkkyqaaLu21UmlF
hL0SlaXe6eNcDwEO5GTwVlXU90qoYYSLkS1gTW0hW33Ijlfz+4Dy5g/LnqxoIJMQ
eeGOLR/+IwO6IslxCXTP52TaS9uc2RxyQWw1q/GYB+D5xSq5TyMocG5mh7rekUkJ
nBt6XA99UGf+Y7ARzUOWT+k0eoLEy83mwMwO3iDoK+CeMgi7t2FeNhonBLRP9shg
C0gRlvmY2KyZLUxErJBy
=J6lW
-----END PGP SIGNATURE-----

--Apple-Mail=_BF08C594-00A1-4D76-90D2-8010D131364A--

--===============7138942491211474056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7138942491211474056==--
