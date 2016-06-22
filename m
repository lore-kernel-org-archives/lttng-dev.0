From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: urcu configure/build failures on Darwin
Date: Wed, 22 Jun 2016 19:29:58 +0000 (UTC)
Message-ID: <1341714632.45564.1466623798434.JavaMail.zimbra__18899.6007702828$1466623827$gmane$org@efficios.com>
References: <BBA3E68F-E5CB-4031-903F-2838E0274D41@indiana.edu>
 <969693309.44561.1466609828052.JavaMail.zimbra@efficios.com>
 <4DDF550A-41B1-4917-8A17-15CE9F4B03D8@indiana.edu>
 <432896973.45030.1466613549689.JavaMail.zimbra@efficios.com>
 <8B0C0676-0FBD-4108-92DB-6CA0BCBD102C@indiana.edu>
 <1218231396.45288.1466622972254.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4417579074072187726=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 13634A36AB
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jun 2016 19:30:03 +0000 (UTC)
In-Reply-To: <1218231396.45288.1466622972254.JavaMail.zimbra@efficios.com>
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

--===============4417579074072187726==
Content-Type: multipart/alternative;
	boundary="----=_Part_45563_592045499.1466623798434"

------=_Part_45563_592045499.1466623798434
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Jun 22, 2016, at 3:16 PM, Mathieu Desnoyers <mathieu.desnoyers@eff=
icios.com> wrote:=20

> ----- On Jun 22, 2016, at 2:17 PM, Luke K D'Alessandro <ldalessa@indiana.=
edu>
> wrote:

>>> On Jun 22, 2016, at 12:39 PM, Mathieu Desnoyers < mathieu.desnoyers@eff=
icios.com
>>> > wrote:

>>> ----- On Jun 22, 2016, at 11:56 AM, Luke K D'Alessandro < ldalessa@indi=
ana.edu >
>>> wrote:

>>>>> On Jun 22, 2016, at 11:37 AM, Mathieu Desnoyers < mathieu.desnoyers@e=
fficios.com
>>>>> > wrote:

>>>>> ----- On Jun 14, 2016, at 12:31 PM, Luke K D'Alessandro < ldalessa@in=
diana.edu >
>>>>> wrote:

>>>>>> I tried following the Darwin instructions on the website (basically =
`
>>>>>> ./configure --build=3Dx86_64-apple-darwin11` but the `clock_gettime`=
 and `-lrt`
>>>>>> dependencies don=E2=80=99t exist on Darwin).

>>>>>> Just for fun I removed this dependency and added a custom version of
>>>>>> `clock_gettime` (
>>>>>> https://github.com/lorrden/darwin-posix-rt/blob/master/clock_gettime=
.c ) but
>>>>>> the build still fails in `systcall-compat.h`.

>>>>>> ```
>>>>>> $ make V=3D1
>>>>>> /Applications/Xcode.app/Contents/Developer/usr/bin/make all-recursiv=
e
>>>>>> Making all in .
>>>>>> /bin/sh ./libtool --tag=3DCC --mode=3Dcompile gcc -DHAVE_CONFIG_H -I=
. -I./urcu
>>>>>> -I./urcu -Wall -g -O2 -D_THREAD_SAFE -pthread -MT wfqueue.lo -MD -MP=
 -MF
>>>>>> .deps/wfqueue.Tpo -c -o wfqueue.lo wfqueue.c
>>>>>> libtool: compile: gcc -DHAVE_CONFIG_H -I. -I./urcu -I./urcu -Wall -g=
 -O2
>>>>>> -D_THREAD_SAFE -pthread -MT wfqueue.lo -MD -MP -MF .deps/wfqueue.Tpo=
 -c
>>>>>> wfqueue.c -fno-common -DPIC -o .libs/wfqueue.o
>>>>>> In file included from wfqueue.c:28:
>>>>>> In file included from ./urcu/static/wfqueue.h:33:
>>>>>> In file included from ./urcu/uatomic.h:24:
>>>>>> In file included from ./urcu/system.h:23:
>>>>>> In file included from ./urcu/arch.h:27:
>>>>>> ./urcu/syscall-compat.h:39:2: error: "Add platform support to
>>>>>> urcu/syscall-compat.h"
>>>>>> #error "Add platform support to urcu/syscall-compat.h"
>>>>>> ^
>>>>>> 1 error generated.
>>>>>> make[2]: *** [wfqueue.lo] Error 1
>>>>>> make[1]: *** [all-recursive] Error 1
>>>>>> make: *** [all] Error 2
>>>>>> ```

>>>>>> Is Darwin still a supported platform for the library?

>>>>> It should, yes, but we don't test it in our CI yet.

>>>>> I just took care of the syscall-compat.h error (pushed into master
>>>>> and stable-0.9). For clock_gettime, we would need to implement
>>>>> a LGPLv2.1 wrapper within liburcu for MacOSX.

>>>>> Is this something you could look into ?

>>>> Hmm. This isn=E2=80=99t really something I know much about.

>>>> The github link I sent seems to be either GPLv2 or LGPLv3=E2=80=A6 don=
=E2=80=99t really know
>>>> what LGPLv2.1 means. Based on the actually code that I=E2=80=99m seein=
g, there is
>>>> really not much going on here and thus it might be difficult to do any=
thing
>>>> differently. It might be easier to have urcu use some configuration ti=
me
>>>> behavior to have its own arch-specific timing functionality if necessa=
ry.

>>> The only place where we need clock_gettime is urcu/arch/generic.h
>>> caa_get_cycles.

>>> I just pushed the implementation of the fix in master and stable-0.9.
>>> Tested on my own macos mini machine. Can you try them out ?

>> Looks good on my system as well (bootstrapping with current autotools fr=
om
>> brew).

>> I do get a warning at

>> ```
>> ../../tests/common/thread-id.h:62:3: warning: "use pid as thread ID"
>> [-W#warnings]
>> ```

> This is just because we don't have a gettid() system call available. This=
 just
> leads
> to less precise debug printout in the test programs, nothing to worry abo=
ut.

>> however `make check` passes. Should Darwin have its own preprocessor bra=
nch in
>> this file?

> how about make regtest ?

> It appears we don't have the "nproc" program available. Is there a brew p=
ackage
> for it,
> or something similar ?

This commit now in master and 0.9 should fix it:=20

commit 2350bf7b3f3c4581493b187988a92b8d871471ba=20
Author: Michael Jeanson <mjeanson@efficios.com>=20
Date: Wed Jun 22 15:16:18 2016 -0400=20

Fix: Add failover for platforms without nproc=20

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>=20
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>=20

> Thanks,

> Mathieu

>> Thanks for doing this,
>> Luke

>>> Thanks,

>>> Mathieu

>>>> Luke

>>>>> Thanks,

>>>>> Mathieu

>>>>>> Thanks,
>>>>>> Luke

>>>>>> _______________________________________________
>>>>>> lttng-dev mailing list
>>>>>> lttng-dev@lists.lttng.org
>>>>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

>>>>> --
>>>>> Mathieu Desnoyers
>>>>> EfficiOS Inc.
>>>>> http://www.efficios.com

>>> --
>>> Mathieu Desnoyers
>>> EfficiOS Inc.
>>> http://www.efficios.com

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_45563_592045499.1466623798434
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><span id=3D"zwchr"=
 data-marker=3D"__DIVIDER__">----- On Jun 22, 2016, at 3:16 PM, Mathieu Des=
noyers &lt;mathieu.desnoyers@efficios.com&gt; wrote:<br></span><div data-ma=
rker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF=
;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:=
normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-siz=
e:12pt;"><div style=3D"font-family: arial, helvetica, sans-serif; font-size=
: 12pt; color: #000000"><br><br><span id=3D"zwchr">----- On Jun 22, 2016, a=
t 2:17 PM, Luke K D'Alessandro &lt;ldalessa@indiana.edu&gt; wrote:<br></spa=
n><div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;p=
adding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decora=
tion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><br class=
=3D""><div><blockquote class=3D""><div class=3D"">On Jun 22, 2016, at 12:39=
 PM, Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com=
" class=3D"" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt; wrote=
:</div><br class=3D"Apple-interchange-newline"><div class=3D""><div style=
=3D"font-family: arial, helvetica, sans-serif; font-size: 16px; font-style:=
 normal; font-variant-caps: normal; font-weight: normal; letter-spacing: no=
rmal; orphans: auto; text-align: start; text-indent: 0px; text-transform: n=
one; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-str=
oke-width: 0px;" class=3D""><br class=3D"Apple-interchange-newline"><br cla=
ss=3D""></div><span id=3D"zwchr" style=3D"font-family: arial, helvetica, sa=
ns-serif; font-size: 16px; font-style: normal; font-variant-caps: normal; f=
ont-weight: normal; letter-spacing: normal; orphans: auto; text-align: star=
t; text-indent: 0px; text-transform: none; white-space: normal; widows: aut=
o; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D"">----- On =
Jun 22, 2016, at 11:56 AM, Luke K D'Alessandro &lt;<a href=3D"mailto:ldales=
sa@indiana.edu" class=3D"" target=3D"_blank">ldalessa@indiana.edu</a>&gt; w=
rote:<br class=3D""></span><div style=3D"font-family: arial, helvetica, san=
s-serif; font-size: 16px; font-style: normal; font-variant-caps: normal; fo=
nt-weight: normal; letter-spacing: normal; orphans: auto; text-align: start=
; text-indent: 0px; text-transform: none; white-space: normal; widows: auto=
; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><blockquot=
e style=3D"border-left-width: 2px; border-left-style: solid; border-left-co=
lor: rgb(16, 16, 255); margin-left: 5px; padding-left: 5px; font-weight: no=
rmal; font-style: normal; text-decoration: none; font-family: Helvetica, Ar=
ial, sans-serif; font-size: 12pt;" class=3D""><br class=3D""><div class=3D"=
"><blockquote class=3D""><div class=3D"">On Jun 22, 2016, at 11:37 AM, Math=
ieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" class=
=3D"" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt; wrote:</div>=
<br class=3D"Apple-interchange-newline"><div class=3D""><div class=3D""><di=
v class=3D"" style=3D"font-family: arial, helvetica, sans-serif; font-size:=
 12pt;"><div class=3D""><span id=3D"zwchr" class=3D"">----- On Jun 14, 2016=
, at 12:31 PM, Luke K D'Alessandro &lt;<a href=3D"mailto:ldalessa@indiana.e=
du" class=3D"" target=3D"_blank">ldalessa@indiana.edu</a>&gt; wrote:<br cla=
ss=3D""></span></div><div class=3D""><blockquote class=3D"" style=3D"border=
-left-width: 2px; border-left-style: solid; border-left-color: rgb(16, 16, =
255); margin-left: 5px; padding-left: 5px; font-weight: normal; font-style:=
 normal; text-decoration: none; font-family: Helvetica, Arial, sans-serif; =
font-size: 12pt;"><span class=3D"">I tried following the Darwin instruction=
s on the website (basically `</span><span class=3D"">./configure --build=3D=
x86_64-apple-darwin11` but the `clock_gettime` and `-lrt` dependencies don=
=E2=80=99t&nbsp;exist on Darwin).</span><div class=3D""><span class=3D""><b=
r class=3D""></span></div><div class=3D""><span class=3D"">Just for fun I r=
emoved this dependency and added a custom version of `clock_gettime` (</spa=
n><a href=3D"https://github.com/lorrden/darwin-posix-rt/blob/master/clock_g=
ettime.c" class=3D"" target=3D"_blank">https://github.com/lorrden/darwin-po=
six-rt/blob/master/clock_gettime.c</a>) but the build still fails in `systc=
all-compat.h`.</div><span class=3D""><div class=3D""><span class=3D""><br c=
lass=3D""></span></div>```<br class=3D""></span><span class=3D"">$ make V=
=3D1<br class=3D"">/Applications/Xcode.app/Contents/Developer/usr/bin/make&=
nbsp;&nbsp;all-recursive<br class=3D"">Making all in .<br class=3D"">/bin/s=
h ./libtool&nbsp;&nbsp;--tag=3DCC&nbsp;&nbsp;&nbsp;--mode=3Dcompile gcc -DH=
AVE_CONFIG_H -I. -I./urcu&nbsp;&nbsp;-I./urcu&nbsp;&nbsp;-Wall -g -O2 -D_TH=
READ_SAFE -pthread -MT wfqueue.lo -MD -MP -MF&nbsp;.deps/wfqueue.Tpo -c -o =
wfqueue.lo wfqueue.c<br class=3D"">libtool: compile:&nbsp;&nbsp;gcc -DHAVE_=
CONFIG_H -I. -I./urcu -I./urcu -Wall -g -O2 -D_THREAD_SAFE -pthread -MT wfq=
ueue.lo -MD -MP -MF .deps/wfqueue.Tpo -c wfqueue.c&nbsp;&nbsp;-fno-common -=
DPIC -o .libs/wfqueue.o<br class=3D"">In file included from wfqueue.c:28:<b=
r class=3D"">In file included from ./urcu/static/wfqueue.h:33:<br class=3D"=
">In file included from ./urcu/uatomic.h:24:<br class=3D"">In file included=
 from ./urcu/system.h:23:<br class=3D"">In file included from ./urcu/arch.h=
:27:<br class=3D"">./urcu/syscall-compat.h:39:2:&nbsp;error:&nbsp;"Add plat=
form support to urcu/syscall-compat.h"<br class=3D"">#error "Add platform s=
upport to urcu/syscall-compat.h"<br class=3D"">&nbsp;^<br class=3D"">1 erro=
r generated.<br class=3D"">make[2]: *** [wfqueue.lo] Error 1<br class=3D"">=
make[1]: *** [all-recursive] Error 1<br class=3D"">make: *** [all] Error 2<=
br class=3D""></span><span class=3D"">```</span><div class=3D""><span class=
=3D""><br class=3D""></span></div><div class=3D""><span class=3D"">Is&nbsp;=
Darwin still a supported platform for the library?</span></div></blockquote=
><div class=3D""><br class=3D""></div><div class=3D"">It should, yes, but w=
e don't test it in our CI yet.<br class=3D""></div><div class=3D""><br clas=
s=3D""></div><div class=3D"">I just took care of the syscall-compat.h error=
 (pushed into master</div><div class=3D"">and stable-0.9). For clock_gettim=
e, we would need to implement</div><div class=3D"">a LGPLv2.1 wrapper withi=
n liburcu for MacOSX.<br class=3D""></div><div class=3D""><br class=3D""></=
div><div class=3D"">Is this something you could look into ?<br class=3D""><=
/div></div></div></div></div></blockquote><div class=3D""><br class=3D""></=
div><div class=3D"">Hmm. This isn=E2=80=99t really something I know much ab=
out.&nbsp;</div><div class=3D""><br class=3D""></div><div class=3D"">The gi=
thub link I sent seems to be either GPLv2 or LGPLv3=E2=80=A6 don=E2=80=99t =
really know what LGPLv2.1 means. Based on the actually code that I=E2=80=99=
m seeing, there is really not much going on here and thus it might be diffi=
cult to do anything differently. It might be easier to have urcu use some c=
onfiguration time behavior to have its own arch-specific timing functionali=
ty if necessary.</div></div></blockquote><div class=3D""><br class=3D""></d=
iv><div class=3D"">The only place where we need clock_gettime is urcu/arch/=
generic.h<br class=3D""></div><div class=3D"">caa_get_cycles.<br class=3D""=
></div><div class=3D""><br class=3D""></div><div class=3D"">I just pushed t=
he implementation of the fix in master and stable-0.9.<br class=3D""></div>=
<div class=3D"">Tested on my own macos mini machine. Can you try them out ?=
<br class=3D""></div></div></div></blockquote><div><br class=3D""></div><di=
v>Looks good on my system as well (bootstrapping with current autotools fro=
m brew).</div><div><br class=3D""></div><div>I do get a warning at&nbsp;</d=
iv><div><br class=3D""></div><div>```</div><span class=3D"">&nbsp; ../../te=
sts/common/thread-id.h:62:3:&nbsp;warning:&nbsp;"use pid as thread ID" [-W#=
warnings]</span></div><div><span class=3D"">```</span></div></blockquote><b=
r><div>This is just because we don't have a gettid() system call available.=
 This just leads<br></div><div>to less precise debug printout in the test p=
rograms, nothing to worry about.<br></div><br><blockquote style=3D"border-l=
eft:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weig=
ht:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Aria=
l,sans-serif;font-size:12pt;"><div><span class=3D""><br class=3D""></span><=
/div><div><span class=3D"">however `make check` passes. Should Darwin have =
its own preprocessor branch in this file?</span></div></blockquote><br><div=
>how about make regtest ?<br></div><br><div>It appears we don't have the "n=
proc" program available. Is there a brew package for it,<br></div><div>or s=
omething similar ?</div></div></div></blockquote><div><br></div><div>This c=
ommit now in master and 0.9 should fix it:<br data-mce-bogus=3D"1"></div><d=
iv><br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>=
commit 2350bf7b3f3c4581493b187988a92b8d871471ba<br>Author: Michael Jeanson =
&lt;mjeanson@efficios.com&gt;<br>Date: Wed Jun 22 15:16:18 2016 -0400<br><b=
r> Fix: Add failover for platforms without nproc<br> <br> Signed-off-by: Mi=
chael Jeanson &lt;mjeanson@efficios.com&gt;<br> Signed-off-by: Mathieu Desn=
oyers &lt;mathieu.desnoyers@efficios.com&gt;<br></div><blockquote style=3D"=
border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;f=
ont-weight:normal;font-style:normal;text-decoration:none;font-family:Helvet=
ica,Arial,sans-serif;font-size:12pt;"><div style=3D"font-family: arial, hel=
vetica, sans-serif; font-size: 12pt; color: #000000"><div><div><br></div><b=
r><div>Thanks,<br></div><br><div>Mathieu<br></div><br><blockquote style=3D"=
border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;f=
ont-weight:normal;font-style:normal;text-decoration:none;font-family:Helvet=
ica,Arial,sans-serif;font-size:12pt;"><div><span class=3D""><br class=3D"">=
</span><div>Thanks for doing this,</div><div>Luke</div><br class=3D""><bloc=
kquote class=3D""><div class=3D""><div style=3D"font-family: arial, helveti=
ca, sans-serif; font-size: 16px; font-style: normal; font-variant-caps: nor=
mal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align=
: start; text-indent: 0px; text-transform: none; white-space: normal; widow=
s: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><di=
v class=3D""><br class=3D""></div><div class=3D"">Thanks,<br class=3D""></d=
iv><div class=3D""><br class=3D""></div><div class=3D"">Mathieu<br class=3D=
""></div><div class=3D""><br class=3D""></div><blockquote style=3D"border-l=
eft-width: 2px; border-left-style: solid; border-left-color: rgb(16, 16, 25=
5); margin-left: 5px; padding-left: 5px; font-weight: normal; font-style: n=
ormal; text-decoration: none; font-family: Helvetica, Arial, sans-serif; fo=
nt-size: 12pt;" class=3D""><div class=3D""><div class=3D""><br class=3D""><=
/div><div class=3D"">Luke</div><br class=3D""><blockquote class=3D""><div c=
lass=3D""><div class=3D""><div class=3D"" style=3D"font-family: arial, helv=
etica, sans-serif; font-size: 12pt;"><div class=3D""><div class=3D""><br cl=
ass=3D""></div><div class=3D"">Thanks,<br class=3D""></div><div class=3D"">=
<br class=3D""></div><div class=3D"">Mathieu<br class=3D""></div><div class=
=3D""><br class=3D""></div><div class=3D""><br class=3D""></div><blockquote=
 class=3D"" style=3D"border-left-width: 2px; border-left-style: solid; bord=
er-left-color: rgb(16, 16, 255); margin-left: 5px; padding-left: 5px; font-=
weight: normal; font-style: normal; text-decoration: none; font-family: Hel=
vetica, Arial, sans-serif; font-size: 12pt;"><div class=3D""><span class=3D=
""><br class=3D""></span></div><div class=3D""><span class=3D"">Thanks,</sp=
an></div><div class=3D""><span class=3D"">Luke</span></div><br class=3D"">_=
______________________________________________<br class=3D"">lttng-dev mail=
ing list<br class=3D""><a href=3D"mailto:lttng-dev@lists.lttng.org" class=
=3D"" target=3D"_blank">lttng-dev@lists.lttng.org</a><br class=3D""><a href=
=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" class=3D"" =
target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-de=
v</a><br class=3D""></blockquote></div><div class=3D""><br class=3D""></div=
><div class=3D"">--<span class=3D"Apple-converted-space">&nbsp;</span><br c=
lass=3D""></div><div class=3D"">Mathieu Desnoyers<br class=3D"">EfficiOS In=
c.<br class=3D""><a href=3D"http://www.efficios.com/" class=3D"" target=3D"=
_blank">http://www.efficios.com</a><br class=3D""></div></div></div></div><=
/blockquote></div><br class=3D""><br class=3D""></blockquote></div><br styl=
e=3D"font-family: arial, helvetica, sans-serif; font-size: 16px; font-style=
: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: n=
ormal; orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-st=
roke-width: 0px;" class=3D""><div style=3D"font-family: arial, helvetica, s=
ans-serif; font-size: 16px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: sta=
rt; text-indent: 0px; text-transform: none; white-space: normal; widows: au=
to; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D"">--<span =
class=3D"Apple-converted-space">&nbsp;</span><br class=3D""></div><div styl=
e=3D"font-family: arial, helvetica, sans-serif; font-size: 16px; font-style=
: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: n=
ormal; orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-st=
roke-width: 0px;" class=3D"">Mathieu Desnoyers<br class=3D"">EfficiOS Inc.<=
br class=3D""><a href=3D"http://www.efficios.com/" class=3D"" target=3D"_bl=
ank">http://www.efficios.com</a><br></div></div></blockquote></div><br clas=
s=3D""><br></blockquote></div><br><div>-- <br></div><div>Mathieu Desnoyers<=
br>EfficiOS Inc.<br>http://www.efficios.com</div></div><br></blockquote></d=
iv><br><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyer=
s<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
------=_Part_45563_592045499.1466623798434--

--===============4417579074072187726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4417579074072187726==--
