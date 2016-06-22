From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: urcu configure/build failures on Darwin
Date: Wed, 22 Jun 2016 19:16:12 +0000 (UTC)
Message-ID: <1218231396.45288.1466622972254.JavaMail.zimbra__8247.82088534466$1466623016$gmane$org@efficios.com>
References: <BBA3E68F-E5CB-4031-903F-2838E0274D41@indiana.edu>
 <969693309.44561.1466609828052.JavaMail.zimbra@efficios.com>
 <4DDF550A-41B1-4917-8A17-15CE9F4B03D8@indiana.edu>
 <432896973.45030.1466613549689.JavaMail.zimbra@efficios.com>
 <8B0C0676-0FBD-4108-92DB-6CA0BCBD102C@indiana.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6714477510656938737=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id A7030A38CE
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jun 2016 19:16:14 +0000 (UTC)
In-Reply-To: <8B0C0676-0FBD-4108-92DB-6CA0BCBD102C@indiana.edu>
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

--===============6714477510656938737==
Content-Type: multipart/alternative;
	boundary="----=_Part_45287_1469639955.1466622972253"

------=_Part_45287_1469639955.1466622972253
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Jun 22, 2016, at 2:17 PM, Luke K D'Alessandro <ldalessa@indiana.ed=
u> wrote:=20

>> On Jun 22, 2016, at 12:39 PM, Mathieu Desnoyers < mathieu.desnoyers@effi=
cios.com
>> > wrote:

>> ----- On Jun 22, 2016, at 11:56 AM, Luke K D'Alessandro < ldalessa@india=
na.edu >
>> wrote:

>>>> On Jun 22, 2016, at 11:37 AM, Mathieu Desnoyers < mathieu.desnoyers@ef=
ficios.com
>>>> > wrote:

>>>> ----- On Jun 14, 2016, at 12:31 PM, Luke K D'Alessandro < ldalessa@ind=
iana.edu >
>>>> wrote:

>>>>> I tried following the Darwin instructions on the website (basically `
>>>>> ./configure --build=3Dx86_64-apple-darwin11` but the `clock_gettime` =
and `-lrt`
>>>>> dependencies don=E2=80=99t exist on Darwin).

>>>>> Just for fun I removed this dependency and added a custom version of
>>>>> `clock_gettime` (
>>>>> https://github.com/lorrden/darwin-posix-rt/blob/master/clock_gettime.=
c ) but
>>>>> the build still fails in `systcall-compat.h`.

>>>>> ```
>>>>> $ make V=3D1
>>>>> /Applications/Xcode.app/Contents/Developer/usr/bin/make all-recursive
>>>>> Making all in .
>>>>> /bin/sh ./libtool --tag=3DCC --mode=3Dcompile gcc -DHAVE_CONFIG_H -I.=
 -I./urcu
>>>>> -I./urcu -Wall -g -O2 -D_THREAD_SAFE -pthread -MT wfqueue.lo -MD -MP =
-MF
>>>>> .deps/wfqueue.Tpo -c -o wfqueue.lo wfqueue.c
>>>>> libtool: compile: gcc -DHAVE_CONFIG_H -I. -I./urcu -I./urcu -Wall -g =
-O2
>>>>> -D_THREAD_SAFE -pthread -MT wfqueue.lo -MD -MP -MF .deps/wfqueue.Tpo =
-c
>>>>> wfqueue.c -fno-common -DPIC -o .libs/wfqueue.o
>>>>> In file included from wfqueue.c:28:
>>>>> In file included from ./urcu/static/wfqueue.h:33:
>>>>> In file included from ./urcu/uatomic.h:24:
>>>>> In file included from ./urcu/system.h:23:
>>>>> In file included from ./urcu/arch.h:27:
>>>>> ./urcu/syscall-compat.h:39:2: error: "Add platform support to
>>>>> urcu/syscall-compat.h"
>>>>> #error "Add platform support to urcu/syscall-compat.h"
>>>>> ^
>>>>> 1 error generated.
>>>>> make[2]: *** [wfqueue.lo] Error 1
>>>>> make[1]: *** [all-recursive] Error 1
>>>>> make: *** [all] Error 2
>>>>> ```

>>>>> Is Darwin still a supported platform for the library?

>>>> It should, yes, but we don't test it in our CI yet.

>>>> I just took care of the syscall-compat.h error (pushed into master
>>>> and stable-0.9). For clock_gettime, we would need to implement
>>>> a LGPLv2.1 wrapper within liburcu for MacOSX.

>>>> Is this something you could look into ?

>>> Hmm. This isn=E2=80=99t really something I know much about.

>>> The github link I sent seems to be either GPLv2 or LGPLv3=E2=80=A6 don=
=E2=80=99t really know
>>> what LGPLv2.1 means. Based on the actually code that I=E2=80=99m seeing=
, there is
>>> really not much going on here and thus it might be difficult to do anyt=
hing
>>> differently. It might be easier to have urcu use some configuration tim=
e
>>> behavior to have its own arch-specific timing functionality if necessar=
y.

>> The only place where we need clock_gettime is urcu/arch/generic.h
>> caa_get_cycles.

>> I just pushed the implementation of the fix in master and stable-0.9.
>> Tested on my own macos mini machine. Can you try them out ?

> Looks good on my system as well (bootstrapping with current autotools fro=
m
> brew).

> I do get a warning at

> ```
> ../../tests/common/thread-id.h:62:3: warning: "use pid as thread ID"
> [-W#warnings]
> ```

This is just because we don't have a gettid() system call available. This j=
ust leads=20
to less precise debug printout in the test programs, nothing to worry about=
.=20

> however `make check` passes. Should Darwin have its own preprocessor bran=
ch in
> this file?

how about make regtest ?=20

It appears we don't have the "nproc" program available. Is there a brew pac=
kage for it,=20
or something similar ?=20

Thanks,=20

Mathieu=20

> Thanks for doing this,
> Luke

>> Thanks,

>> Mathieu

>>> Luke

>>>> Thanks,

>>>> Mathieu

>>>>> Thanks,
>>>>> Luke

>>>>> _______________________________________________
>>>>> lttng-dev mailing list
>>>>> lttng-dev@lists.lttng.org
>>>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

>>>> --
>>>> Mathieu Desnoyers
>>>> EfficiOS Inc.
>>>> http://www.efficios.com

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_45287_1469639955.1466622972253
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><span id=3D"zwchr"=
 data-marker=3D"__DIVIDER__">----- On Jun 22, 2016, at 2:17 PM, Luke K D'Al=
essandro &lt;ldalessa@indiana.edu&gt; wrote:<br></span><div data-marker=3D"=
__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-=
left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;t=
ext-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"=
><br class=3D""><div><blockquote class=3D""><div class=3D"">On Jun 22, 2016=
, at 12:39 PM, Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@ef=
ficios.com" class=3D"" target=3D"_blank">mathieu.desnoyers@efficios.com</a>=
&gt; wrote:</div><br class=3D"Apple-interchange-newline"><div class=3D""><d=
iv style=3D"font-family: arial, helvetica, sans-serif; font-size: 16px; fon=
t-style: normal; font-variant-caps: normal; font-weight: normal; letter-spa=
cing: normal; orphans: auto; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-=
text-stroke-width: 0px;" class=3D""><br class=3D"Apple-interchange-newline"=
><br class=3D""></div><span id=3D"zwchr" style=3D"font-family: arial, helve=
tica, sans-serif; font-size: 16px; font-style: normal; font-variant-caps: n=
ormal; font-weight: normal; letter-spacing: normal; orphans: auto; text-ali=
gn: start; text-indent: 0px; text-transform: none; white-space: normal; wid=
ows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D"">-=
---- On Jun 22, 2016, at 11:56 AM, Luke K D'Alessandro &lt;<a href=3D"mailt=
o:ldalessa@indiana.edu" class=3D"" target=3D"_blank">ldalessa@indiana.edu</=
a>&gt; wrote:<br class=3D""></span><div style=3D"font-family: arial, helvet=
ica, sans-serif; font-size: 16px; font-style: normal; font-variant-caps: no=
rmal; font-weight: normal; letter-spacing: normal; orphans: auto; text-alig=
n: start; text-indent: 0px; text-transform: none; white-space: normal; wido=
ws: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><b=
lockquote style=3D"border-left-width: 2px; border-left-style: solid; border=
-left-color: rgb(16, 16, 255); margin-left: 5px; padding-left: 5px; font-we=
ight: normal; font-style: normal; text-decoration: none; font-family: Helve=
tica, Arial, sans-serif; font-size: 12pt;" class=3D""><br class=3D""><div c=
lass=3D""><blockquote class=3D""><div class=3D"">On Jun 22, 2016, at 11:37 =
AM, Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com"=
 class=3D"" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt; wrote:=
</div><br class=3D"Apple-interchange-newline"><div class=3D""><div class=3D=
""><div class=3D"" style=3D"font-family: arial, helvetica, sans-serif; font=
-size: 12pt;"><div class=3D""><span id=3D"zwchr" class=3D"">----- On Jun 14=
, 2016, at 12:31 PM, Luke K D'Alessandro &lt;<a href=3D"mailto:ldalessa@ind=
iana.edu" class=3D"" target=3D"_blank">ldalessa@indiana.edu</a>&gt; wrote:<=
br class=3D""></span></div><div class=3D""><blockquote class=3D"" style=3D"=
border-left-width: 2px; border-left-style: solid; border-left-color: rgb(16=
, 16, 255); margin-left: 5px; padding-left: 5px; font-weight: normal; font-=
style: normal; text-decoration: none; font-family: Helvetica, Arial, sans-s=
erif; font-size: 12pt;"><span class=3D"">I tried following the Darwin instr=
uctions on the website (basically `</span><span class=3D"">./configure --bu=
ild=3Dx86_64-apple-darwin11` but the `clock_gettime` and `-lrt` dependencie=
s don=E2=80=99t&nbsp;exist on Darwin).</span><div class=3D""><span class=3D=
""><br class=3D""></span></div><div class=3D""><span class=3D"">Just for fu=
n I removed this dependency and added a custom version of `clock_gettime` (=
</span><a href=3D"https://github.com/lorrden/darwin-posix-rt/blob/master/cl=
ock_gettime.c" class=3D"" target=3D"_blank">https://github.com/lorrden/darw=
in-posix-rt/blob/master/clock_gettime.c</a>) but the build still fails in `=
systcall-compat.h`.</div><span class=3D""><div class=3D""><span class=3D"">=
<br class=3D""></span></div>```<br class=3D""></span><span class=3D"">$ mak=
e V=3D1<br class=3D"">/Applications/Xcode.app/Contents/Developer/usr/bin/ma=
ke&nbsp;&nbsp;all-recursive<br class=3D"">Making all in .<br class=3D"">/bi=
n/sh ./libtool&nbsp;&nbsp;--tag=3DCC&nbsp;&nbsp;&nbsp;--mode=3Dcompile gcc =
-DHAVE_CONFIG_H -I. -I./urcu&nbsp;&nbsp;-I./urcu&nbsp;&nbsp;-Wall -g -O2 -D=
_THREAD_SAFE -pthread -MT wfqueue.lo -MD -MP -MF&nbsp;.deps/wfqueue.Tpo -c =
-o wfqueue.lo wfqueue.c<br class=3D"">libtool: compile:&nbsp;&nbsp;gcc -DHA=
VE_CONFIG_H -I. -I./urcu -I./urcu -Wall -g -O2 -D_THREAD_SAFE -pthread -MT =
wfqueue.lo -MD -MP -MF .deps/wfqueue.Tpo -c wfqueue.c&nbsp;&nbsp;-fno-commo=
n -DPIC -o .libs/wfqueue.o<br class=3D"">In file included from wfqueue.c:28=
:<br class=3D"">In file included from ./urcu/static/wfqueue.h:33:<br class=
=3D"">In file included from ./urcu/uatomic.h:24:<br class=3D"">In file incl=
uded from ./urcu/system.h:23:<br class=3D"">In file included from ./urcu/ar=
ch.h:27:<br class=3D"">./urcu/syscall-compat.h:39:2:&nbsp;error:&nbsp;"Add =
platform support to urcu/syscall-compat.h"<br class=3D"">#error "Add platfo=
rm support to urcu/syscall-compat.h"<br class=3D"">&nbsp;^<br class=3D"">1 =
error generated.<br class=3D"">make[2]: *** [wfqueue.lo] Error 1<br class=
=3D"">make[1]: *** [all-recursive] Error 1<br class=3D"">make: *** [all] Er=
ror 2<br class=3D""></span><span class=3D"">```</span><div class=3D""><span=
 class=3D""><br class=3D""></span></div><div class=3D""><span class=3D"">Is=
&nbsp;Darwin still a supported platform for the library?</span></div></bloc=
kquote><div class=3D""><br class=3D""></div><div class=3D"">It should, yes,=
 but we don't test it in our CI yet.<br class=3D""></div><div class=3D""><b=
r class=3D""></div><div class=3D"">I just took care of the syscall-compat.h=
 error (pushed into master</div><div class=3D"">and stable-0.9). For clock_=
gettime, we would need to implement</div><div class=3D"">a LGPLv2.1 wrapper=
 within liburcu for MacOSX.<br class=3D""></div><div class=3D""><br class=
=3D""></div><div class=3D"">Is this something you could look into ?<br clas=
s=3D""></div></div></div></div></div></blockquote><div class=3D""><br class=
=3D""></div><div class=3D"">Hmm. This isn=E2=80=99t really something I know=
 much about.&nbsp;</div><div class=3D""><br class=3D""></div><div class=3D"=
">The github link I sent seems to be either GPLv2 or LGPLv3=E2=80=A6 don=E2=
=80=99t really know what LGPLv2.1 means. Based on the actually code that I=
=E2=80=99m seeing, there is really not much going on here and thus it might=
 be difficult to do anything differently. It might be easier to have urcu u=
se some configuration time behavior to have its own arch-specific timing fu=
nctionality if necessary.</div></div></blockquote><div class=3D""><br class=
=3D""></div><div class=3D"">The only place where we need clock_gettime is u=
rcu/arch/generic.h<br class=3D""></div><div class=3D"">caa_get_cycles.<br c=
lass=3D""></div><div class=3D""><br class=3D""></div><div class=3D"">I just=
 pushed the implementation of the fix in master and stable-0.9.<br class=3D=
""></div><div class=3D"">Tested on my own macos mini machine. Can you try t=
hem out ?<br class=3D""></div></div></div></blockquote><div><br class=3D"">=
</div><div>Looks good on my system as well (bootstrapping with current auto=
tools from brew).</div><div><br class=3D""></div><div>I do get a warning at=
&nbsp;</div><div><br class=3D""></div><div>```</div><span class=3D"">&nbsp;=
 ../../tests/common/thread-id.h:62:3:&nbsp;warning:&nbsp;"use pid as thread=
 ID" [-W#warnings]</span></div><div><span class=3D"">```</span></div></bloc=
kquote><div><br></div><div>This is just because we don't have a gettid() sy=
stem call available. This just leads<br data-mce-bogus=3D"1"></div><div>to =
less precise debug printout in the test programs, nothing to worry about.<b=
r data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquot=
e style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;c=
olor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fa=
mily:Helvetica,Arial,sans-serif;font-size:12pt;"><div><span class=3D""><br =
class=3D""></span></div><div><span class=3D"">however `make check` passes. =
Should Darwin have its own preprocessor branch in this file?</span></div></=
blockquote><div><br></div><div>how about make regtest ?<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>It appears we don't h=
ave the "nproc" program available. Is there a brew package for it,<br data-=
mce-bogus=3D"1"></div><div>or something similar ?<br data-mce-bogus=3D"1"><=
/div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"=
1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"borde=
r-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-w=
eight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,A=
rial,sans-serif;font-size:12pt;"><div><span class=3D""><br class=3D""></spa=
n><div>Thanks for doing this,</div><div>Luke</div><br class=3D""><blockquot=
e class=3D""><div class=3D""><div style=3D"font-family: arial, helvetica, s=
ans-serif; font-size: 16px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: sta=
rt; text-indent: 0px; text-transform: none; white-space: normal; widows: au=
to; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><div cla=
ss=3D""><br class=3D""></div><div class=3D"">Thanks,<br class=3D""></div><d=
iv class=3D""><br class=3D""></div><div class=3D"">Mathieu<br class=3D""></=
div><div class=3D""><br class=3D""></div><blockquote style=3D"border-left-w=
idth: 2px; border-left-style: solid; border-left-color: rgb(16, 16, 255); m=
argin-left: 5px; padding-left: 5px; font-weight: normal; font-style: normal=
; text-decoration: none; font-family: Helvetica, Arial, sans-serif; font-si=
ze: 12pt;" class=3D""><div class=3D""><div class=3D""><br class=3D""></div>=
<div class=3D"">Luke</div><br class=3D""><blockquote class=3D""><div class=
=3D""><div class=3D""><div class=3D"" style=3D"font-family: arial, helvetic=
a, sans-serif; font-size: 12pt;"><div class=3D""><div class=3D""><br class=
=3D""></div><div class=3D"">Thanks,<br class=3D""></div><div class=3D""><br=
 class=3D""></div><div class=3D"">Mathieu<br class=3D""></div><div class=3D=
""><br class=3D""></div><div class=3D""><br class=3D""></div><blockquote cl=
ass=3D"" style=3D"border-left-width: 2px; border-left-style: solid; border-=
left-color: rgb(16, 16, 255); margin-left: 5px; padding-left: 5px; font-wei=
ght: normal; font-style: normal; text-decoration: none; font-family: Helvet=
ica, Arial, sans-serif; font-size: 12pt;"><div class=3D""><span class=3D"">=
<br class=3D""></span></div><div class=3D""><span class=3D"">Thanks,</span>=
</div><div class=3D""><span class=3D"">Luke</span></div><br class=3D"">____=
___________________________________________<br class=3D"">lttng-dev mailing=
 list<br class=3D""><a href=3D"mailto:lttng-dev@lists.lttng.org" class=3D""=
 target=3D"_blank">lttng-dev@lists.lttng.org</a><br class=3D""><a href=3D"h=
ttps://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" class=3D"" targe=
t=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>=
<br class=3D""></blockquote></div><div class=3D""><br class=3D""></div><div=
 class=3D"">--<span class=3D"Apple-converted-space">&nbsp;</span><br class=
=3D""></div><div class=3D"">Mathieu Desnoyers<br class=3D"">EfficiOS Inc.<b=
r class=3D""><a href=3D"http://www.efficios.com/" class=3D"" target=3D"_bla=
nk">http://www.efficios.com</a><br class=3D""></div></div></div></div></blo=
ckquote></div><br class=3D""><br class=3D""></blockquote></div><br style=3D=
"font-family: arial, helvetica, sans-serif; font-size: 16px; font-style: no=
rmal; font-variant-caps: normal; font-weight: normal; letter-spacing: norma=
l; orphans: auto; text-align: start; text-indent: 0px; text-transform: none=
; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke=
-width: 0px;" class=3D""><div style=3D"font-family: arial, helvetica, sans-=
serif; font-size: 16px; font-style: normal; font-variant-caps: normal; font=
-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D"">--<span clas=
s=3D"Apple-converted-space">&nbsp;</span><br class=3D""></div><div style=3D=
"font-family: arial, helvetica, sans-serif; font-size: 16px; font-style: no=
rmal; font-variant-caps: normal; font-weight: normal; letter-spacing: norma=
l; orphans: auto; text-align: start; text-indent: 0px; text-transform: none=
; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke=
-width: 0px;" class=3D"">Mathieu Desnoyers<br class=3D"">EfficiOS Inc.<br c=
lass=3D""><a href=3D"http://www.efficios.com/" class=3D"" target=3D"_blank"=
>http://www.efficios.com</a><br data-mce-bogus=3D"1"></div></div></blockquo=
te></div><br class=3D""><br></blockquote></div><br><div data-marker=3D"__SI=
G_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://ww=
w.efficios.com</div></div></body></html>
------=_Part_45287_1469639955.1466622972253--

--===============6714477510656938737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6714477510656938737==--
