From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: urcu configure/build failures on Darwin
Date: Wed, 22 Jun 2016 15:37:08 +0000 (UTC)
Message-ID: <969693309.44561.1466609828052.JavaMail.zimbra__30350.7676734172$1466609858$gmane$org@efficios.com>
References: <BBA3E68F-E5CB-4031-903F-2838E0274D41@indiana.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8108086580191341661=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id A814DA36C6
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jun 2016 15:37:12 +0000 (UTC)
In-Reply-To: <BBA3E68F-E5CB-4031-903F-2838E0274D41@indiana.edu>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Luke K D'Alessandro <ldalessa@indiana.edu>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8108086580191341661==
Content-Type: multipart/alternative;
	boundary="----=_Part_44560_2110958274.1466609828051"

------=_Part_44560_2110958274.1466609828051
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Jun 14, 2016, at 12:31 PM, Luke K D'Alessandro <ldalessa@indiana.e=
du> wrote:=20

> I tried following the Darwin instructions on the website (basically `
> ./configure --build=3Dx86_64-apple-darwin11` but the `clock_gettime` and =
`-lrt`
> dependencies don=E2=80=99t exist on Darwin).

> Just for fun I removed this dependency and added a custom version of
> `clock_gettime` (
> https://github.com/lorrden/darwin-posix-rt/blob/master/clock_gettime.c ) =
but
> the build still fails in `systcall-compat.h`.

> ```
> $ make V=3D1
> /Applications/Xcode.app/Contents/Developer/usr/bin/make all-recursive
> Making all in .
> /bin/sh ./libtool --tag=3DCC --mode=3Dcompile gcc -DHAVE_CONFIG_H -I. -I.=
/urcu
> -I./urcu -Wall -g -O2 -D_THREAD_SAFE -pthread -MT wfqueue.lo -MD -MP -MF
> .deps/wfqueue.Tpo -c -o wfqueue.lo wfqueue.c
> libtool: compile: gcc -DHAVE_CONFIG_H -I. -I./urcu -I./urcu -Wall -g -O2
> -D_THREAD_SAFE -pthread -MT wfqueue.lo -MD -MP -MF .deps/wfqueue.Tpo -c
> wfqueue.c -fno-common -DPIC -o .libs/wfqueue.o
> In file included from wfqueue.c:28:
> In file included from ./urcu/static/wfqueue.h:33:
> In file included from ./urcu/uatomic.h:24:
> In file included from ./urcu/system.h:23:
> In file included from ./urcu/arch.h:27:
> ./urcu/syscall-compat.h:39:2: error: "Add platform support to
> urcu/syscall-compat.h"
> #error "Add platform support to urcu/syscall-compat.h"
> ^
> 1 error generated.
> make[2]: *** [wfqueue.lo] Error 1
> make[1]: *** [all-recursive] Error 1
> make: *** [all] Error 2
> ```

> Is Darwin still a supported platform for the library?

It should, yes, but we don't test it in our CI yet.=20

I just took care of the syscall-compat.h error (pushed into master=20
and stable-0.9). For clock_gettime, we would need to implement=20
a LGPLv2.1 wrapper within liburcu for MacOSX.=20

Is this something you could look into ?=20

Thanks,=20

Mathieu=20

> Thanks,
> Luke

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_44560_2110958274.1466609828051
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Jun 14, 2016, at 12:31 PM, Luke K D'Alessandro &lt;ldalessa@in=
diana.edu&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><=
blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-l=
eft:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:non=
e;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><span class=3D"">=
I tried following the Darwin instructions on the website (basically `</span=
><span class=3D"">./configure --build=3Dx86_64-apple-darwin11` but the `clo=
ck_gettime` and `-lrt` dependencies don=E2=80=99t&nbsp;exist on Darwin).</s=
pan><div class=3D""><span class=3D""><br class=3D""></span></div><div class=
=3D""><span class=3D"">Just for fun I removed this dependency and added a c=
ustom version of `clock_gettime` (</span><a href=3D"https://github.com/lorr=
den/darwin-posix-rt/blob/master/clock_gettime.c" class=3D"" target=3D"_blan=
k">https://github.com/lorrden/darwin-posix-rt/blob/master/clock_gettime.c</=
a>) but the build still fails in `systcall-compat.h`.</div><span class=3D""=
><div class=3D""><span class=3D""><br class=3D""></span></div>```<br class=
=3D""></span><span class=3D"">$ make V=3D1<br class=3D"">/Applications/Xcod=
e.app/Contents/Developer/usr/bin/make&nbsp;&nbsp;all-recursive<br class=3D"=
">Making all in .<br class=3D"">/bin/sh ./libtool&nbsp;&nbsp;--tag=3DCC&nbs=
p;&nbsp;&nbsp;--mode=3Dcompile gcc -DHAVE_CONFIG_H -I. -I./urcu&nbsp;&nbsp;=
-I./urcu&nbsp;&nbsp;-Wall -g -O2 -D_THREAD_SAFE -pthread -MT wfqueue.lo -MD=
 -MP -MF&nbsp;.deps/wfqueue.Tpo -c -o wfqueue.lo wfqueue.c<br class=3D"">li=
btool: compile:&nbsp;&nbsp;gcc -DHAVE_CONFIG_H -I. -I./urcu -I./urcu -Wall =
-g -O2 -D_THREAD_SAFE -pthread -MT wfqueue.lo -MD -MP -MF .deps/wfqueue.Tpo=
 -c wfqueue.c&nbsp;&nbsp;-fno-common -DPIC -o .libs/wfqueue.o<br class=3D""=
>In file included from wfqueue.c:28:<br class=3D"">In file included from ./=
urcu/static/wfqueue.h:33:<br class=3D"">In file included from ./urcu/uatomi=
c.h:24:<br class=3D"">In file included from ./urcu/system.h:23:<br class=3D=
"">In file included from ./urcu/arch.h:27:<br class=3D"">./urcu/syscall-com=
pat.h:39:2:&nbsp;error:&nbsp;"Add platform support to urcu/syscall-compat.h=
"<br class=3D"">#error "Add platform support to urcu/syscall-compat.h"<br c=
lass=3D"">&nbsp;^<br class=3D"">1 error generated.<br class=3D"">make[2]: *=
** [wfqueue.lo] Error 1<br class=3D"">make[1]: *** [all-recursive] Error 1<=
br class=3D"">make: *** [all] Error 2<br class=3D""></span><span class=3D""=
>```</span><div class=3D""><span class=3D""><br class=3D""></span></div><di=
v class=3D""><span class=3D"">Is&nbsp;Darwin still a supported platform for=
 the library?</span></div></blockquote><div><br></div><div>It should, yes, =
but we don't test it in our CI yet.<br data-mce-bogus=3D"1"></div><div><br =
data-mce-bogus=3D"1"></div><div>I just took care of the syscall-compat.h er=
ror (pushed into master</div><div>and stable-0.9). For clock_gettime, we wo=
uld need to implement</div><div>a LGPLv2.1 wrapper within liburcu for MacOS=
X.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>I=
s this something you could look into ?<br data-mce-bogus=3D"1"></div><div><=
br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><d=
iv><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></di=
v><div><br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><=
blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-l=
eft:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:non=
e;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div class=3D""><=
span class=3D""><br class=3D""></span></div><div class=3D""><span class=3D"=
">Thanks,</span></div><div class=3D""><span class=3D"">Luke</span></div><br=
>_______________________________________________<br>lttng-dev mailing list<=
br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/lis=
tinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D"__=
SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://=
www.efficios.com</div></div></body></html>
------=_Part_44560_2110958274.1466609828051--

--===============8108086580191341661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8108086580191341661==--
