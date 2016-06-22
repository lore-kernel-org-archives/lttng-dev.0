From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: urcu configure/build failures on Darwin
Date: Wed, 22 Jun 2016 16:39:09 +0000 (UTC)
Message-ID: <432896973.45030.1466613549689.JavaMail.zimbra__12150.9851342582$1466613583$gmane$org@efficios.com>
References: <BBA3E68F-E5CB-4031-903F-2838E0274D41@indiana.edu>
 <969693309.44561.1466609828052.JavaMail.zimbra@efficios.com>
 <4DDF550A-41B1-4917-8A17-15CE9F4B03D8@indiana.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7498214128613281827=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id A5D6BA3852
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jun 2016 16:39:14 +0000 (UTC)
In-Reply-To: <4DDF550A-41B1-4917-8A17-15CE9F4B03D8@indiana.edu>
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

--===============7498214128613281827==
Content-Type: multipart/alternative;
	boundary="----=_Part_45029_1952855895.1466613549688"

------=_Part_45029_1952855895.1466613549688
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Jun 22, 2016, at 11:56 AM, Luke K D'Alessandro <ldalessa@indiana.e=
du> wrote:=20

>> On Jun 22, 2016, at 11:37 AM, Mathieu Desnoyers < mathieu.desnoyers@effi=
cios.com
>> > wrote:

>> ----- On Jun 14, 2016, at 12:31 PM, Luke K D'Alessandro < ldalessa@india=
na.edu >
>> wrote:

>>> I tried following the Darwin instructions on the website (basically `
>>> ./configure --build=3Dx86_64-apple-darwin11` but the `clock_gettime` an=
d `-lrt`
>>> dependencies don=E2=80=99t exist on Darwin).

>>> Just for fun I removed this dependency and added a custom version of
>>> `clock_gettime` (
>>> https://github.com/lorrden/darwin-posix-rt/blob/master/clock_gettime.c =
) but
>>> the build still fails in `systcall-compat.h`.

>>> ```
>>> $ make V=3D1
>>> /Applications/Xcode.app/Contents/Developer/usr/bin/make all-recursive
>>> Making all in .
>>> /bin/sh ./libtool --tag=3DCC --mode=3Dcompile gcc -DHAVE_CONFIG_H -I. -=
I./urcu
>>> -I./urcu -Wall -g -O2 -D_THREAD_SAFE -pthread -MT wfqueue.lo -MD -MP -M=
F
>>> .deps/wfqueue.Tpo -c -o wfqueue.lo wfqueue.c
>>> libtool: compile: gcc -DHAVE_CONFIG_H -I. -I./urcu -I./urcu -Wall -g -O=
2
>>> -D_THREAD_SAFE -pthread -MT wfqueue.lo -MD -MP -MF .deps/wfqueue.Tpo -c
>>> wfqueue.c -fno-common -DPIC -o .libs/wfqueue.o
>>> In file included from wfqueue.c:28:
>>> In file included from ./urcu/static/wfqueue.h:33:
>>> In file included from ./urcu/uatomic.h:24:
>>> In file included from ./urcu/system.h:23:
>>> In file included from ./urcu/arch.h:27:
>>> ./urcu/syscall-compat.h:39:2: error: "Add platform support to
>>> urcu/syscall-compat.h"
>>> #error "Add platform support to urcu/syscall-compat.h"
>>> ^
>>> 1 error generated.
>>> make[2]: *** [wfqueue.lo] Error 1
>>> make[1]: *** [all-recursive] Error 1
>>> make: *** [all] Error 2
>>> ```

>>> Is Darwin still a supported platform for the library?

>> It should, yes, but we don't test it in our CI yet.

>> I just took care of the syscall-compat.h error (pushed into master
>> and stable-0.9). For clock_gettime, we would need to implement
>> a LGPLv2.1 wrapper within liburcu for MacOSX.

>> Is this something you could look into ?

> Hmm. This isn=E2=80=99t really something I know much about.

> The github link I sent seems to be either GPLv2 or LGPLv3=E2=80=A6 don=E2=
=80=99t really know
> what LGPLv2.1 means. Based on the actually code that I=E2=80=99m seeing, =
there is
> really not much going on here and thus it might be difficult to do anythi=
ng
> differently. It might be easier to have urcu use some configuration time
> behavior to have its own arch-specific timing functionality if necessary.

The only place where we need clock_gettime is urcu/arch/generic.h=20
caa_get_cycles.=20

I just pushed the implementation of the fix in master and stable-0.9.=20
Tested on my own macos mini machine. Can you try them out ?=20

Thanks,=20

Mathieu=20

> Luke

>> Thanks,

>> Mathieu

>>> Thanks,
>>> Luke

>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_45029_1952855895.1466613549688
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><span id=3D"zwchr"=
 data-marker=3D"__DIVIDER__">----- On Jun 22, 2016, at 11:56 AM, Luke K D'A=
lessandro &lt;ldalessa@indiana.edu&gt; wrote:<br></span><div data-marker=3D=
"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin=
-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;=
text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;=
"><br class=3D""><div><blockquote class=3D""><div class=3D"">On Jun 22, 201=
6, at 11:37 AM, Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@e=
fficios.com" class=3D"" target=3D"_blank">mathieu.desnoyers@efficios.com</a=
>&gt; wrote:</div><br class=3D"Apple-interchange-newline"><div class=3D""><=
div class=3D""><div style=3D"font-family: arial, helvetica, sans-serif; fon=
t-size: 12pt;" class=3D""><div class=3D""><span id=3D"zwchr" class=3D"">---=
-- On Jun 14, 2016, at 12:31 PM, Luke K D'Alessandro &lt;<a href=3D"mailto:=
ldalessa@indiana.edu" class=3D"" target=3D"_blank">ldalessa@indiana.edu</a>=
&gt; wrote:<br class=3D""></span></div><div class=3D""><blockquote style=3D=
"border-left-width: 2px; border-left-style: solid; border-left-color: rgb(1=
6, 16, 255); margin-left: 5px; padding-left: 5px; font-weight: normal; font=
-style: normal; text-decoration: none; font-family: Helvetica, Arial, sans-=
serif; font-size: 12pt;" class=3D""><span class=3D"">I tried following the =
Darwin instructions on the website (basically `</span><span class=3D"">./co=
nfigure --build=3Dx86_64-apple-darwin11` but the `clock_gettime` and `-lrt`=
 dependencies don=E2=80=99t&nbsp;exist on Darwin).</span><div class=3D""><s=
pan class=3D""><br class=3D""></span></div><div class=3D""><span class=3D""=
>Just for fun I removed this dependency and added a custom version of `cloc=
k_gettime` (</span><a href=3D"https://github.com/lorrden/darwin-posix-rt/bl=
ob/master/clock_gettime.c" class=3D"" target=3D"_blank">https://github.com/=
lorrden/darwin-posix-rt/blob/master/clock_gettime.c</a>) but the build stil=
l fails in `systcall-compat.h`.</div><span class=3D""><div class=3D""><span=
 class=3D""><br class=3D""></span></div>```<br class=3D""></span><span clas=
s=3D"">$ make V=3D1<br class=3D"">/Applications/Xcode.app/Contents/Develope=
r/usr/bin/make&nbsp;&nbsp;all-recursive<br class=3D"">Making all in .<br cl=
ass=3D"">/bin/sh ./libtool&nbsp;&nbsp;--tag=3DCC&nbsp;&nbsp;&nbsp;--mode=3D=
compile gcc -DHAVE_CONFIG_H -I. -I./urcu&nbsp;&nbsp;-I./urcu&nbsp;&nbsp;-Wa=
ll -g -O2 -D_THREAD_SAFE -pthread -MT wfqueue.lo -MD -MP -MF&nbsp;.deps/wfq=
ueue.Tpo -c -o wfqueue.lo wfqueue.c<br class=3D"">libtool: compile:&nbsp;&n=
bsp;gcc -DHAVE_CONFIG_H -I. -I./urcu -I./urcu -Wall -g -O2 -D_THREAD_SAFE -=
pthread -MT wfqueue.lo -MD -MP -MF .deps/wfqueue.Tpo -c wfqueue.c&nbsp;&nbs=
p;-fno-common -DPIC -o .libs/wfqueue.o<br class=3D"">In file included from =
wfqueue.c:28:<br class=3D"">In file included from ./urcu/static/wfqueue.h:3=
3:<br class=3D"">In file included from ./urcu/uatomic.h:24:<br class=3D"">I=
n file included from ./urcu/system.h:23:<br class=3D"">In file included fro=
m ./urcu/arch.h:27:<br class=3D"">./urcu/syscall-compat.h:39:2:&nbsp;error:=
&nbsp;"Add platform support to urcu/syscall-compat.h"<br class=3D"">#error =
"Add platform support to urcu/syscall-compat.h"<br class=3D"">&nbsp;^<br cl=
ass=3D"">1 error generated.<br class=3D"">make[2]: *** [wfqueue.lo] Error 1=
<br class=3D"">make[1]: *** [all-recursive] Error 1<br class=3D"">make: ***=
 [all] Error 2<br class=3D""></span><span class=3D"">```</span><div class=
=3D""><span class=3D""><br class=3D""></span></div><div class=3D""><span cl=
ass=3D"">Is&nbsp;Darwin still a supported platform for the library?</span><=
/div></blockquote><div class=3D""><br class=3D""></div><div class=3D"">It s=
hould, yes, but we don't test it in our CI yet.<br class=3D""></div><div cl=
ass=3D""><br class=3D""></div><div class=3D"">I just took care of the sysca=
ll-compat.h error (pushed into master</div><div class=3D"">and stable-0.9).=
 For clock_gettime, we would need to implement</div><div class=3D"">a LGPLv=
2.1 wrapper within liburcu for MacOSX.<br class=3D""></div><div class=3D"">=
<br class=3D""></div><div class=3D"">Is this something you could look into =
?<br class=3D""></div></div></div></div></div></blockquote><div><br class=
=3D""></div><div>Hmm. This isn=E2=80=99t really something I know much about=
.&nbsp;</div><div><br class=3D""></div><div>The github link I sent seems to=
 be either GPLv2 or LGPLv3=E2=80=A6 don=E2=80=99t really know what LGPLv2.1=
 means. Based on the actually code that I=E2=80=99m seeing, there is really=
 not much going on here and thus it might be difficult to do anything diffe=
rently. It might be easier to have urcu use some configuration time behavio=
r to have its own arch-specific timing functionality if necessary.</div></d=
iv></blockquote><div><br></div><div>The only place where we need clock_gett=
ime is urcu/arch/generic.h<br data-mce-bogus=3D"1"></div><div>caa_get_cycle=
s.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>I=
 just pushed the implementation of the fix in master and stable-0.9.<br></d=
iv><div>Tested on my own macos mini machine. Can you try them out ?<br data=
-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br =
data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu=
<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockqu=
ote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px=
;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-=
family:Helvetica,Arial,sans-serif;font-size:12pt;"><div><div><br class=3D""=
></div><div>Luke</div><br class=3D""><blockquote class=3D""><div class=3D""=
><div class=3D""><div style=3D"font-family: arial, helvetica, sans-serif; f=
ont-size: 12pt;" class=3D""><div class=3D""><div class=3D""><br class=3D"">=
</div><div class=3D"">Thanks,<br class=3D""></div><div class=3D""><br class=
=3D""></div><div class=3D"">Mathieu<br class=3D""></div><div class=3D""><br=
 class=3D""></div><div class=3D""><br class=3D""></div><blockquote style=3D=
"border-left-width: 2px; border-left-style: solid; border-left-color: rgb(1=
6, 16, 255); margin-left: 5px; padding-left: 5px; font-weight: normal; font=
-style: normal; text-decoration: none; font-family: Helvetica, Arial, sans-=
serif; font-size: 12pt;" class=3D""><div class=3D""><span class=3D""><br cl=
ass=3D""></span></div><div class=3D""><span class=3D"">Thanks,</span></div>=
<div class=3D""><span class=3D"">Luke</span></div><br class=3D"">__________=
_____________________________________<br class=3D"">lttng-dev mailing list<=
br class=3D""><a href=3D"mailto:lttng-dev@lists.lttng.org" class=3D"" targe=
t=3D"_blank">lttng-dev@lists.lttng.org</a><br class=3D"">https://lists.lttn=
g.org/cgi-bin/mailman/listinfo/lttng-dev<br class=3D""></blockquote></div><=
div class=3D""><br class=3D""></div><div class=3D"">-- <br class=3D""></div=
><div class=3D"">Mathieu Desnoyers<br class=3D"">EfficiOS Inc.<br class=3D"=
"><a href=3D"http://www.efficios.com" class=3D"" target=3D"_blank">http://w=
ww.efficios.com</a><br data-mce-bogus=3D"1"></div></div></div></div></block=
quote></div><br class=3D""><br></blockquote></div><br><div data-marker=3D"_=
_SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http:/=
/www.efficios.com</div></div></body></html>
------=_Part_45029_1952855895.1466613549688--

--===============7498214128613281827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7498214128613281827==--
