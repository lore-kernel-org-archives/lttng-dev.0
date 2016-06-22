From: "D'Alessandro, Luke K" <ldalessa@indiana.edu>
Subject: Re: urcu configure/build failures on Darwin
Date: Wed, 22 Jun 2016 18:17:47 +0000
Message-ID: <8B0C0676-0FBD-4108-92DB-6CA0BCBD102C__913.511441513215$1466619525$gmane$org@indiana.edu>
References: <BBA3E68F-E5CB-4031-903F-2838E0274D41@indiana.edu>
 <969693309.44561.1466609828052.JavaMail.zimbra@efficios.com>
 <4DDF550A-41B1-4917-8A17-15CE9F4B03D8@indiana.edu>
 <432896973.45030.1466613549689.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6607642795813160879=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from hartman.uits.indiana.edu (belushi.uits.indiana.edu
 [129.79.1.188])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 8C0E7A33C3
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jun 2016 18:18:08 +0000 (UTC)
In-Reply-To: <432896973.45030.1466613549689.JavaMail.zimbra@efficios.com>
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
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6607642795813160879==
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_1EBD50E7-0439-4292-95D9-AA11DCCE72CC";
	protocol="application/pgp-signature"; micalg=pgp-sha512

--Apple-Mail=_1EBD50E7-0439-4292-95D9-AA11DCCE72CC
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_2881E552-3D84-4D9B-A0F6-69C33F663327"


--Apple-Mail=_2881E552-3D84-4D9B-A0F6-69C33F663327
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Jun 22, 2016, at 12:39 PM, Mathieu Desnoyers =
<mathieu.desnoyers@efficios.com> wrote:
>=20
>=20
>=20
> ----- On Jun 22, 2016, at 11:56 AM, Luke K D'Alessandro =
<ldalessa@indiana.edu <mailto:ldalessa@indiana.edu>> wrote:
>=20
> On Jun 22, 2016, at 11:37 AM, Mathieu Desnoyers =
<mathieu.desnoyers@efficios.com <mailto:mathieu.desnoyers@efficios.com>> =
wrote:
>=20
> ----- On Jun 14, 2016, at 12:31 PM, Luke K D'Alessandro =
<ldalessa@indiana.edu <mailto:ldalessa@indiana.edu>> wrote:
> I tried following the Darwin instructions on the website (basically =
`./configure --build=3Dx86_64-apple-darwin11` but the `clock_gettime` =
and `-lrt` dependencies don=E2=80=99t exist on Darwin).
>=20
> Just for fun I removed this dependency and added a custom version of =
`clock_gettime` =
(https://github.com/lorrden/darwin-posix-rt/blob/master/clock_gettime.c =
<https://github.com/lorrden/darwin-posix-rt/blob/master/clock_gettime.c>) =
but the build still fails in `systcall-compat.h`.
>=20
> ```
> $ make V=3D1
> /Applications/Xcode.app/Contents/Developer/usr/bin/make  all-recursive
> Making all in .
> /bin/sh ./libtool  --tag=3DCC   --mode=3Dcompile gcc -DHAVE_CONFIG_H =
-I. -I./urcu  -I./urcu  -Wall -g -O2 -D_THREAD_SAFE -pthread -MT =
wfqueue.lo -MD -MP -MF .deps/wfqueue.Tpo -c -o wfqueue.lo wfqueue.c
> libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I./urcu -I./urcu -Wall -g =
-O2 -D_THREAD_SAFE -pthread -MT wfqueue.lo -MD -MP -MF .deps/wfqueue.Tpo =
-c wfqueue.c  -fno-common -DPIC -o .libs/wfqueue.o
> In file included from wfqueue.c:28:
> In file included from ./urcu/static/wfqueue.h:33:
> In file included from ./urcu/uatomic.h:24:
> In file included from ./urcu/system.h:23:
> In file included from ./urcu/arch.h:27:
> ./urcu/syscall-compat.h:39:2: error: "Add platform support to =
urcu/syscall-compat.h"
> #error "Add platform support to urcu/syscall-compat.h"
>  ^
> 1 error generated.
> make[2]: *** [wfqueue.lo] Error 1
> make[1]: *** [all-recursive] Error 1
> make: *** [all] Error 2
> ```
>=20
> Is Darwin still a supported platform for the library?
>=20
> It should, yes, but we don't test it in our CI yet.
>=20
> I just took care of the syscall-compat.h error (pushed into master
> and stable-0.9). For clock_gettime, we would need to implement
> a LGPLv2.1 wrapper within liburcu for MacOSX.
>=20
> Is this something you could look into ?
>=20
> Hmm. This isn=E2=80=99t really something I know much about.
>=20
> The github link I sent seems to be either GPLv2 or LGPLv3=E2=80=A6 =
don=E2=80=99t really know what LGPLv2.1 means. Based on the actually =
code that I=E2=80=99m seeing, there is really not much going on here and =
thus it might be difficult to do anything differently. It might be =
easier to have urcu use some configuration time behavior to have its own =
arch-specific timing functionality if necessary.
>=20
> The only place where we need clock_gettime is urcu/arch/generic.h
> caa_get_cycles.
>=20
> I just pushed the implementation of the fix in master and stable-0.9.
> Tested on my own macos mini machine. Can you try them out ?

Looks good on my system as well (bootstrapping with current autotools =
from brew).

I do get a warning at

```
  ../../tests/common/thread-id.h:62:3: warning: "use pid as thread ID" =
[-W#warnings]
```

however `make check` passes. Should Darwin have its own preprocessor =
branch in this file?

Thanks for doing this,
Luke

>=20
> Thanks,
>=20
> Mathieu
>=20
>=20
> Luke
>=20
>=20
> Thanks,
>=20
> Mathieu
>=20
>=20
>=20
> Thanks,
> Luke
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>=20
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com <http://www.efficios.com/>
>=20
>=20
>=20
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com <http://www.efficios.com/>

--Apple-Mail=_2881E552-3D84-4D9B-A0F6-69C33F663327
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On Jun 22, 2016, at 12:39 PM, Mathieu Desnoyers &lt;<a =
href=3D"mailto:mathieu.desnoyers@efficios.com" =
class=3D"">mathieu.desnoyers@efficios.com</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><div =
style=3D"font-family: arial, helvetica, sans-serif; font-size: 16px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
class=3D"Apple-interchange-newline"><br class=3D""></div><span =
id=3D"zwchr" data-marker=3D"__DIVIDER__" style=3D"font-family: arial, =
helvetica, sans-serif; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D"">----- On Jun 22, 2016, at =
11:56 AM, Luke K D'Alessandro &lt;<a href=3D"mailto:ldalessa@indiana.edu" =
class=3D"">ldalessa@indiana.edu</a>&gt; wrote:<br class=3D""></span><div =
data-marker=3D"__QUOTED_TEXT__" style=3D"font-family: arial, helvetica, =
sans-serif; font-size: 16px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><blockquote style=3D"border-left-width: 2px; =
border-left-style: solid; border-left-color: rgb(16, 16, 255); =
margin-left: 5px; padding-left: 5px; font-weight: normal; font-style: =
normal; text-decoration: none; font-family: Helvetica, Arial, =
sans-serif; font-size: 12pt;" class=3D""><br class=3D""><div =
class=3D""><blockquote class=3D""><div class=3D"">On Jun 22, 2016, at =
11:37 AM, Mathieu Desnoyers &lt;<a =
href=3D"mailto:mathieu.desnoyers@efficios.com" class=3D"" =
target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><div class=3D""><div =
class=3D"" style=3D"font-family: arial, helvetica, sans-serif; =
font-size: 12pt;"><div class=3D""><span id=3D"zwchr" class=3D"">----- On =
Jun 14, 2016, at 12:31 PM, Luke K D'Alessandro &lt;<a =
href=3D"mailto:ldalessa@indiana.edu" class=3D"" =
target=3D"_blank">ldalessa@indiana.edu</a>&gt; wrote:<br =
class=3D""></span></div><div class=3D""><blockquote class=3D"" =
style=3D"border-left-width: 2px; border-left-style: solid; =
border-left-color: rgb(16, 16, 255); margin-left: 5px; padding-left: =
5px; font-weight: normal; font-style: normal; text-decoration: none; =
font-family: Helvetica, Arial, sans-serif; font-size: 12pt;"><span =
class=3D"">I tried following the Darwin instructions on the website =
(basically `</span><span class=3D"">./configure =
--build=3Dx86_64-apple-darwin11` but the `clock_gettime` and `-lrt` =
dependencies don=E2=80=99t&nbsp;exist on Darwin).</span><div =
class=3D""><span class=3D""><br class=3D""></span></div><div =
class=3D""><span class=3D"">Just for fun I removed this dependency and =
added a custom version of `clock_gettime` (</span><a =
href=3D"https://github.com/lorrden/darwin-posix-rt/blob/master/clock_getti=
me.c" class=3D"" =
target=3D"_blank">https://github.com/lorrden/darwin-posix-rt/blob/master/c=
lock_gettime.c</a>) but the build still fails in =
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
for the library?</span></div></blockquote><div class=3D""><br =
class=3D""></div><div class=3D"">It should, yes, but we don't test it in =
our CI yet.<br class=3D""></div><div class=3D""><br class=3D""></div><div =
class=3D"">I just took care of the syscall-compat.h error (pushed into =
master</div><div class=3D"">and stable-0.9). For clock_gettime, we would =
need to implement</div><div class=3D"">a LGPLv2.1 wrapper within liburcu =
for MacOSX.<br class=3D""></div><div class=3D""><br class=3D""></div><div =
class=3D"">Is this something you could look into ?<br =
class=3D""></div></div></div></div></div></blockquote><div class=3D""><br =
class=3D""></div><div class=3D"">Hmm. This isn=E2=80=99t really =
something I know much about.&nbsp;</div><div class=3D""><br =
class=3D""></div><div class=3D"">The github link I sent seems to be =
either GPLv2 or LGPLv3=E2=80=A6 don=E2=80=99t really know what LGPLv2.1 =
means. Based on the actually code that I=E2=80=99m seeing, there is =
really not much going on here and thus it might be difficult to do =
anything differently. It might be easier to have urcu use some =
configuration time behavior to have its own arch-specific timing =
functionality if necessary.</div></div></blockquote><div class=3D""><br =
class=3D""></div><div class=3D"">The only place where we need =
clock_gettime is urcu/arch/generic.h<br data-mce-bogus=3D"1" =
class=3D""></div><div class=3D"">caa_get_cycles.<br data-mce-bogus=3D"1" =
class=3D""></div><div class=3D""><br data-mce-bogus=3D"1" =
class=3D""></div><div class=3D"">I just pushed the implementation of the =
fix in master and stable-0.9.<br class=3D""></div><div class=3D"">Tested =
on my own macos mini machine. Can you try them out ?<br =
data-mce-bogus=3D"1" class=3D""></div></div></div></blockquote><div><br =
class=3D""></div><div>Looks good on my system as well (bootstrapping =
with current autotools from brew).</div><div><br class=3D""></div><div>I =
do get a warning at&nbsp;</div><div><br =
class=3D""></div><div>```</div><span class=3D"">&nbsp; =
../../tests/common/thread-id.h:62:3:&nbsp;warning:&nbsp;"use pid as =
thread ID" [-W#warnings]</span></div><div><span =
class=3D"">```</span></div><div><span class=3D""><br =
class=3D""></span></div><div><span class=3D"">however `make check` =
passes. Should Darwin have its own preprocessor branch in this file?<br =
class=3D""></span><span class=3D""><br class=3D""></span><div>Thanks for =
doing this,</div><div>Luke</div><br class=3D""><blockquote type=3D"cite" =
class=3D""><div class=3D""><div data-marker=3D"__QUOTED_TEXT__" =
style=3D"font-family: arial, helvetica, sans-serif; font-size: 16px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><div =
class=3D""><br data-mce-bogus=3D"1" class=3D""></div><div =
class=3D"">Thanks,<br data-mce-bogus=3D"1" class=3D""></div><div =
class=3D""><br data-mce-bogus=3D"1" class=3D""></div><div =
class=3D"">Mathieu<br data-mce-bogus=3D"1" class=3D""></div><div =
class=3D""><br data-mce-bogus=3D"1" class=3D""></div><blockquote =
style=3D"border-left-width: 2px; border-left-style: solid; =
border-left-color: rgb(16, 16, 255); margin-left: 5px; padding-left: =
5px; font-weight: normal; font-style: normal; text-decoration: none; =
font-family: Helvetica, Arial, sans-serif; font-size: 12pt;" =
class=3D""><div class=3D""><div class=3D""><br class=3D""></div><div =
class=3D"">Luke</div><br class=3D""><blockquote class=3D""><div =
class=3D""><div class=3D""><div class=3D"" style=3D"font-family: arial, =
helvetica, sans-serif; font-size: 12pt;"><div class=3D""><div =
class=3D""><br class=3D""></div><div class=3D"">Thanks,<br =
class=3D""></div><div class=3D""><br class=3D""></div><div =
class=3D"">Mathieu<br class=3D""></div><div class=3D""><br =
class=3D""></div><div class=3D""><br class=3D""></div><blockquote =
class=3D"" style=3D"border-left-width: 2px; border-left-style: solid; =
border-left-color: rgb(16, 16, 255); margin-left: 5px; padding-left: =
5px; font-weight: normal; font-style: normal; text-decoration: none; =
font-family: Helvetica, Arial, sans-serif; font-size: 12pt;"><div =
class=3D""><span class=3D""><br class=3D""></span></div><div =
class=3D""><span class=3D"">Thanks,</span></div><div class=3D""><span =
class=3D"">Luke</span></div><br =
class=3D"">_______________________________________________<br =
class=3D"">lttng-dev mailing list<br class=3D""><a =
href=3D"mailto:lttng-dev@lists.lttng.org" class=3D"" =
target=3D"_blank">lttng-dev@lists.lttng.org</a><br class=3D""><a =
href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
class=3D"">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br class=3D""></blockquote></div><div class=3D""><br class=3D""></div><div=
 class=3D"">--<span class=3D"Apple-converted-space">&nbsp;</span><br =
class=3D""></div><div class=3D"">Mathieu Desnoyers<br class=3D"">EfficiOS =
Inc.<br class=3D""><a href=3D"http://www.efficios.com/" class=3D"" =
target=3D"_blank">http://www.efficios.com</a><br data-mce-bogus=3D"1" =
class=3D""></div></div></div></div></blockquote></div><br class=3D""><br =
class=3D""></blockquote></div><br style=3D"font-family: arial, =
helvetica, sans-serif; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><div =
data-marker=3D"__SIG_POST__" style=3D"font-family: arial, helvetica, =
sans-serif; font-size: 16px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D"">--<span class=3D"Apple-converted-space">&nbsp;</span><br =
class=3D""></div><div style=3D"font-family: arial, helvetica, =
sans-serif; font-size: 16px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D"">Mathieu Desnoyers<br class=3D"">EfficiOS Inc.<br =
class=3D""><a href=3D"http://www.efficios.com/" =
class=3D"">http://www.efficios.com</a></div></div></blockquote></div><br =
class=3D""></body></html>=

--Apple-Mail=_2881E552-3D84-4D9B-A0F6-69C33F663327--

--Apple-Mail=_1EBD50E7-0439-4292-95D9-AA11DCCE72CC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJXatZLAAoJEJ9t5ApCTtG0s84P/0F/MEHvAINLitLRuN4PEukm
8rxhcqSsDS3vEtAA2KHMJ3dt6SuDtc+3A2oN4ZRtlMUcLYE32+vCc/WiMbZ+56Ur
i1LXfHYVlQyjF2N7kia5LkSMkvf2vUg+hOIJebyQsNf96GkGSbD7KHrg7eJSu4sh
+yiIl3F9RnQsLxW8quK/Lygz+/12/CkTxyEL5NPXtaDaeMzE5JwdSaCmDgiLGx0U
QXMjcTL/7AIYfSM/TlekJJL7Z+OVZCVa5QyEZCjkenJ1QfK+8p4oYty8wkhk7yho
UZU6J6ebBszeGbCylH2lzX/mrEuVlS9s5GYmMarJi96QckXwi5RZkW8uufE0cwBy
rWnAq0GBOoz+ArCwkAD80HMmTdqw34WTncoaVvM3iZbrsRmVfEuyOVJMYUeG0woQ
c4dWOzELINFEcAnkS2Z3rAU00T3jMUWerdfaabhS5ZYk3I2GfF/VJNlKieczew8+
89MtiorFOHjf3h2gwHibVdtWonUKjuO//ZWObsHHDdLe3t8vOr1CUbFT8jRDSuYo
PZKpNKZGm9xoEAZqgO2ERPYJtWQ62Ex6E1aMCdMiQh8qEUxrhSJI7LDllvy4P+0B
vWGW4IV41t049iyn7ohA8bVnNaU292P1MjqMTwhLLw8eJNYpbfSHRCSdhWUxTlXn
CFXiw/hlztWDLqEyz5MB
=LhLg
-----END PGP SIGNATURE-----

--Apple-Mail=_1EBD50E7-0439-4292-95D9-AA11DCCE72CC--

--===============6607642795813160879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6607642795813160879==--
