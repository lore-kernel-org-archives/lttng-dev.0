From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng-modules build issues
Date: Thu, 18 Feb 2016 21:14:24 +0000 (UTC)
Message-ID: <602155853.2136.1455830064357.JavaMail.zimbra__47400.8407480598$1455830260$gmane$org@efficios.com>
References: <1510306317.5846570.1455790186976.JavaMail.yahoo.ref@mail.yahoo.com>
 <1510306317.5846570.1455790186976.JavaMail.yahoo@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0127259312=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aWVuE-0000EZ-Pd
 for lttng-dev@lists.lttng.org; Thu, 18 Feb 2016 16:14:41 -0500
In-Reply-To: <1510306317.5846570.1455790186976.JavaMail.yahoo@mail.yahoo.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Dragos Tarcatu <tarcatu_dragosh@yahoo.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0127259312==
Content-Type: multipart/alternative;
	boundary="----=_Part_2135_1041404745.1455830064356"

------=_Part_2135_1041404745.1455830064356
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Feb 18, 2016, at 5:09 AM, Dragos Tarcatu <tarcatu_dragosh@yahoo.com> wrote: 

> Hello,

> I'm encountering these compilation errors while trying to build the
> lttng-modules on an nvidia tegra arm64 board:

>> lttng-modules/2.7.1-r1/git/lttng-syscalls.c:358:3: error: implicit declaration
>> of function '__event_probe__compat_syscall_entry_unknown'
>> [-Werror=implicit-function-declaration]
>> | __event_probe__compat_syscall_entry_unknown(event, id, args);

>> lttng-modules/2.7.1-r1/git/lttng-syscalls.c:360:3: error: implicit declaration
>> of function '__event_probe__syscall_entry_unknown'
>> [-Werror=implicit-function-declaration]
>> | __event_probe__syscall_entry_unknown(event, id, args);

>> lttng-modules/2.7.1-r1/git/lttng-syscalls.c:509:3: error: implicit declaration
>> of function '__event_probe__compat_syscall_exit_unknown'
>> [-Werror=implicit-function-declaration]
>> | __event_probe__compat_syscall_exit_unknown(event, id, ret,

>> lttng-modules/2.7.1-r1/git/lttng-syscalls.c:512:3: error: implicit declaration
>> of function '__event_probe__syscall_exit_unknown'
>> [-Werror=implicit-function-declaration]
>> | __event_probe__syscall_exit_unknown(event, id, ret, args);

>> lttng-modules/2.7.1-r1/git/lttng-syscalls.c:740:2: error: implicit declaration
>> of function 'wrapper_vmalloc_sync_all' [-Werror=implicit-function-declaration]
>> | wrapper_vmalloc_sync_all();

>> lttng-modules/2.7.1-r1/git/lttng-syscalls.c:777:5: error:
>> '__event_desc___syscall_entry_unknown' undeclared (first use in this function)
>> | &__event_desc___syscall_entry_unknown;

>> lttng-modules/2.7.1-r1/git/lttng-syscalls.c:794:5: error:
>> '__event_desc___compat_syscall_entry_unknown' undeclared (first use in this
>> function)
>> | &__event_desc___compat_syscall_entry_unknown;

>> lttng-modules/2.7.1-r1/git/lttng-syscalls.c:811:5: error:
>> '__event_desc___compat_syscall_exit_unknown' undeclared (first use in this
>> function)
>> | &__event_desc___compat_syscall_exit_unknown;

>> lttng-modules/2.7.1-r1/git/lttng-syscalls.c:828:5: error:
>> '__event_desc___syscall_exit_unknown' undeclared (first use in this function)
>> | &__event_desc___syscall_exit_unknown;

> If I disable the syscall tracing it builds just fine though. Any idea on why
> this may be happening?

Hi, 

The ARM64 architecture support has only been added to LTTng in the 
master branch, in preparation for the upcoming LTTng 2.8. 

It's likely that commenting our lttng-syscall module compilation will 
work for lttng 2.7 (but without system call support). However, we 
recommend trying out lttng master branches, and eventually lttng 
2.8, for tracing on ARM64. 

Thanks, 

Mathieu 

> Regards,
> Dragos

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_2135_1041404745.1455830064356
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Feb 18, 2016, at 5:09 AM, Dragos Tarcatu &lt;tarcatu_dragosh@y=
ahoo.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><b=
lockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-le=
ft:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none=
;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div style=3D"colo=
r:#000; background-color:#fff; font-family:HelveticaNeue, Helvetica Neue, H=
elvetica, Arial, Lucida Grande, sans-serif;font-size:13px"><div id=3D"yui_3=
_16_0_1_1455780758796_12303">Hello,</div><div id=3D"yui_3_16_0_1_1455780758=
796_12285"><br></div><div id=3D"yui_3_16_0_1_1455780758796_12311">I'm encou=
ntering these compilation errors while trying to build the lttng-modules on=
 an nvidia tegra arm64 board:</div><div id=3D"yui_3_16_0_1_1455780758796_12=
454"><br></div><blockquote style=3D"margin: 0 0 0 40px; border: none; paddi=
ng: 0px;" id=3D"yui_3_16_0_1_1455780758796_12726"><div id=3D"yui_3_16_0_1_1=
455780758796_12441" class=3D""><span id=3D"yui_3_16_0_1_1455780758796_12443=
" class=3D"">lttng-modules/2.7.1-r1/git/lttng-syscalls.c:358:3: error: impl=
icit declaration of function '__event_probe__compat_syscall_entry_unknown' =
[-Werror=3Dimplicit-function-declaration]</span></div><div id=3D"yui_3_16_0=
_1_1455780758796_12445" class=3D""><span id=3D"yui_3_16_0_1_1455780758796_1=
2447" class=3D"">| &nbsp; &nbsp;__event_probe__compat_syscall_entry_unknown=
(event, id, args);</span></div><div id=3D"yui_3_16_0_1_1455780758796_12352"=
 class=3D""><br></div><div id=3D"yui_3_16_0_1_1455780758796_12352" class=3D=
"">lttng-modules/2.7.1-r1/git/lttng-syscalls.c:360:3: error: implicit decla=
ration of function '__event_probe__syscall_entry_unknown' [-Werror=3Dimplic=
it-function-declaration]</div><div id=3D"yui_3_16_0_1_1455780758796_12354" =
class=3D"">| &nbsp; &nbsp;__event_probe__syscall_entry_unknown(event, id, a=
rgs);</div><div id=3D"yui_3_16_0_1_1455780758796_12354" class=3D""><br></di=
v><div id=3D"yui_3_16_0_1_1455780758796_12354" class=3D"">lttng-modules/2.7=
.1-r1/git/lttng-syscalls.c:509:3: error: implicit declaration of function '=
__event_probe__compat_syscall_exit_unknown' [-Werror=3Dimplicit-function-de=
claration]</div><div id=3D"yui_3_16_0_1_1455780758796_12354" class=3D"">| &=
nbsp; &nbsp;__event_probe__compat_syscall_exit_unknown(event, id, ret,</div=
><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12492" class=3D""><br id=
=3D"yui_3_16_0_1_1455780758796_12494" class=3D""></div><div dir=3D"ltr" id=
=3D"yui_3_16_0_1_1455780758796_12492" class=3D""><div dir=3D"ltr" id=3D"yui=
_3_16_0_1_1455780758796_12492" class=3D"">lttng-modules/2.7.1-r1/git/lttng-=
syscalls.c:512:3: error: implicit declaration of function '__event_probe__s=
yscall_exit_unknown' [-Werror=3Dimplicit-function-declaration]</div></div><=
div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12492" class=3D""><div dir=
=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12492" class=3D"">| &nbsp; &nbsp;=
__event_probe__syscall_exit_unknown(event, id, ret, args);</div></div><div =
dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12492" class=3D""><div dir=3D"=
ltr" id=3D"yui_3_16_0_1_1455780758796_12492" class=3D""><br></div></div><di=
v dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12492" class=3D""><div dir=
=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12521" class=3D""><div dir=3D"ltr=
" id=3D"yui_3_16_0_1_1455780758796_12521" class=3D"">lttng-modules/2.7.1-r1=
/git/lttng-syscalls.c:740:2: error: implicit declaration of function 'wrapp=
er_vmalloc_sync_all' [-Werror=3Dimplicit-function-declaration]</div></div><=
/div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12492" class=3D""><d=
iv dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12521" class=3D""><div dir=
=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12521" class=3D"">| &nbsp; wrappe=
r_vmalloc_sync_all();</div></div></div><div dir=3D"ltr" id=3D"yui_3_16_0_1_=
1455780758796_12492" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780=
758796_12521" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_=
12521" class=3D""><br></div></div></div><div dir=3D"ltr" id=3D"yui_3_16_0_1=
_1455780758796_12492" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_145578=
0758796_12521" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796=
_12521" class=3D""><br></div></div></div><div dir=3D"ltr" id=3D"yui_3_16_0_=
1_1455780758796_12492" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_14557=
80758796_12521" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_145578075879=
6_12548" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12548=
" class=3D"">lttng-modules/2.7.1-r1/git/lttng-syscalls.c:777:5: error: '__e=
vent_desc___syscall_entry_unknown' undeclared (first use in this function)<=
/div></div></div></div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12=
492" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12521" cl=
ass=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12548" class=3D"=
"><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12548" class=3D"">| &nb=
sp; &nbsp; &amp;__event_desc___syscall_entry_unknown;</div></div></div></di=
v><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12492" class=3D""><div =
dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12521" class=3D""><div dir=3D"=
ltr" id=3D"yui_3_16_0_1_1455780758796_12548" class=3D""><div dir=3D"ltr" id=
=3D"yui_3_16_0_1_1455780758796_12590" class=3D""><br id=3D"yui_3_16_0_1_145=
5780758796_12592" class=3D""></div></div></div></div><div dir=3D"ltr" id=3D=
"yui_3_16_0_1_1455780758796_12492" class=3D""><div dir=3D"ltr" id=3D"yui_3_=
16_0_1_1455780758796_12521" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_=
1455780758796_12548" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780=
758796_12590" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_=
12590" class=3D"">lttng-modules/2.7.1-r1/git/lttng-syscalls.c:794:5: error:=
 '__event_desc___compat_syscall_entry_unknown' undeclared (first use in thi=
s function)</div></div></div></div></div><div dir=3D"ltr" id=3D"yui_3_16_0_=
1_1455780758796_12492" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_14557=
80758796_12521" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_145578075879=
6_12548" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12590=
" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12590" class=
=3D"">| &nbsp; &nbsp; &amp;__event_desc___compat_syscall_entry_unknown;</di=
v></div></div></div></div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796=
_12492" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12521"=
 class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12548" class=
=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12590" class=3D""><=
div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12619" class=3D""><br id=
=3D"yui_3_16_0_1_1455780758796_12621" class=3D""></div></div></div></div></=
div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12492" class=3D""><di=
v dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12521" class=3D""><div dir=
=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12548" class=3D""><div dir=3D"ltr=
" id=3D"yui_3_16_0_1_1455780758796_12590" class=3D""><div dir=3D"ltr" id=3D=
"yui_3_16_0_1_1455780758796_12619" class=3D""><div dir=3D"ltr" id=3D"yui_3_=
16_0_1_1455780758796_12619" class=3D"">lttng-modules/2.7.1-r1/git/lttng-sys=
calls.c:811:5: error: '__event_desc___compat_syscall_exit_unknown' undeclar=
ed (first use in this function)</div></div></div></div></div></div><div dir=
=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12492" class=3D""><div dir=3D"ltr=
" id=3D"yui_3_16_0_1_1455780758796_12521" class=3D""><div dir=3D"ltr" id=3D=
"yui_3_16_0_1_1455780758796_12548" class=3D""><div dir=3D"ltr" id=3D"yui_3_=
16_0_1_1455780758796_12590" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_=
1455780758796_12619" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780=
758796_12619" class=3D"">| &nbsp; &nbsp; &amp;__event_desc___compat_syscall=
_exit_unknown;</div></div></div></div></div></div><div dir=3D"ltr" id=3D"yu=
i_3_16_0_1_1455780758796_12492" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_=
0_1_1455780758796_12521" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_145=
5780758796_12548" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758=
796_12590" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_126=
19" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12641" cla=
ss=3D""><br id=3D"yui_3_16_0_1_1455780758796_12643" class=3D""></div></div>=
</div></div></div></div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_1=
2492" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12521" c=
lass=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12548" class=3D=
""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12590" class=3D""><div=
 dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12619" class=3D""><div dir=3D=
"ltr" id=3D"yui_3_16_0_1_1455780758796_12641" class=3D""><div dir=3D"ltr" i=
d=3D"yui_3_16_0_1_1455780758796_12641" class=3D"">lttng-modules/2.7.1-r1/gi=
t/lttng-syscalls.c:828:5: error: '__event_desc___syscall_exit_unknown' unde=
clared (first use in this function)</div></div></div></div></div></div></di=
v><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12492" class=3D""><div =
dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12521" class=3D""><div dir=3D"=
ltr" id=3D"yui_3_16_0_1_1455780758796_12548" class=3D""><div dir=3D"ltr" id=
=3D"yui_3_16_0_1_1455780758796_12590" class=3D""><div dir=3D"ltr" id=3D"yui=
_3_16_0_1_1455780758796_12619" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0=
_1_1455780758796_12641" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455=
780758796_12641" class=3D"">| &nbsp; &nbsp; &amp;__event_desc___syscall_exi=
t_unknown;</div></div></div></div></div></div></div><div dir=3D"ltr" id=3D"=
yui_3_16_0_1_1455780758796_12492" class=3D""><div dir=3D"ltr" id=3D"yui_3_1=
6_0_1_1455780758796_12521" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1=
455780758796_12548" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_14557807=
58796_12590" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_1=
2619" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12641" c=
lass=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12672" class=3D=
""><br id=3D"yui_3_16_0_1_1455780758796_12674" class=3D""></div></div></div=
></div></div></div></div></blockquote><div dir=3D"ltr" id=3D"yui_3_16_0_1_1=
455780758796_12356" class=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_14557807=
58796_12356" class=3D"">If I disable the syscall tracing it builds just fin=
e though. Any idea on why this may be happening?</div></div></div></blockqu=
ote><div>Hi,<br></div><div><br data-mce-bogus=3D"1"></div><div>The ARM64 ar=
chitecture support has only been added to LTTng in the<br data-mce-bogus=3D=
"1"></div><div>master branch, in preparation for the upcoming LTTng 2.8.<br=
 data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>It's l=
ikely that commenting our lttng-syscall module compilation will<br data-mce=
-bogus=3D"1"></div><div>work for lttng 2.7 (but without system call support=
). However, we</div><div>recommend trying out lttng master branches, and ev=
entually lttng</div><div>2.8, for tracing on ARM64.<br data-mce-bogus=3D"1"=
></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu</div><div><br=
 data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #101=
0FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-sty=
le:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-=
size:12pt;"><div style=3D"color:#000; background-color:#fff; font-family:He=
lveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;fo=
nt-size:13px"><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12356" clas=
s=3D""><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12356" class=3D"">=
<br></div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12356" class=3D=
"">Regards,</div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1455780758796_12356" c=
lass=3D"">&nbsp; &nbsp; &nbsp;Dragos</div></div></div><br>_________________=
______________________________<br>lttng-dev mailing list<br>lttng-dev@lists=
.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br>=
</blockquote></div><div><br></div><div data-marker=3D"__SIG_POST__">-- <br>=
</div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</d=
iv></div></body></html>
------=_Part_2135_1041404745.1455830064356--


--===============0127259312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0127259312==--
