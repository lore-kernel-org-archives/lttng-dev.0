From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: segfault when exiting process with background thread
Date: Thu, 10 Mar 2016 23:27:31 +0000 (UTC)
Message-ID: <75563213.22564.1457652451557.JavaMail.zimbra__43567.2037340284$1457652492$gmane$org@efficios.com>
References: <DM3PR13MB0782B678A6ECD858863C1A8CC7B20@DM3PR13MB0782.namprd13.prod.outlook.com>
 <56DF6A86.1030407@efficios.com>
 <767354504.19909.1457483744934.JavaMail.zimbra@efficios.com>
 <114312835.20088.1457489356654.JavaMail.zimbra@efficios.com>
 <DM3PR15MB0768E77237D422EFE34C0014ABB40@DM3PR15MB0768.namprd15.prod.outlook.com>
 <1717932664.22109.1457635977007.JavaMail.zimbra@efficios.com>
 <BY2PR15MB0759383FF520BBE4DB105F22ABB40@BY2PR15MB0759.namprd15.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5992929351620477986=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 9C834A4305
 for <lttng-dev@lists.lttng.org>; Thu, 10 Mar 2016 23:27:40 +0000 (UTC)
In-Reply-To: <BY2PR15MB0759383FF520BBE4DB105F22ABB40@BY2PR15MB0759.namprd15.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jeffrey Chen <cpthk@hotmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5992929351620477986==
Content-Type: multipart/alternative;
	boundary="----=_Part_22563_2093516087.1457652451556"

------=_Part_22563_2093516087.1457652451556
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Mar 10, 2016, at 5:59 PM, Jeffrey Chen <cpthk@hotmail.com> wrote: 

> Thanks, Mathieu.

> Yes, the fix works as a workaround. This is also the same workaround we have
> now.

> It seems the problem is due to a race condition, that it checked whether "
> tracepoint_dlopen.rcu_read_lock_sym_bp " is not NULL. If not NULL, it calls to
> that. But, at this moment, memset cleared the memory.

> This fix is okay with us, but I am not certain if it would break other
> component, since I do not understand LTTng enough to tell. Thanks.

In addition to memset clearing that memory, dlclose() of the lttng-ust-tracepoint 
shared object will clear the memory containing the called functions. Therefore, 
we need to skip both steps of the destructor if we want threads to survive after 
this destructor execution. 

Thanks, 

Mathieu 

> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Sent: Thursday, March 10, 2016 10:52 AM
> To: Jeffrey Chen
> Cc: Jonathan Rajotte Julien; lttng-dev
> Subject: Re: segfault when exiting process with background thread
> Hi Jeffrey,

> I CC'd your @live.com address on the RFC patch. Please let me know if the
> approach
> is OK with you (and try it out).

> See:
> https://lists.lttng.org/pipermail/lttng-dev/2016-March/025608.html

> Thanks,

> Mathieu

> ----- On Mar 10, 2016, at 1:35 PM, Jeffrey Chen <cpthk@hotmail.com> wrote:

>> Thanks Mathieu.

>> Is there a plan at LTTng side to fix this issue? If so, we could wait for the
>> fix. If not, we will have to workaround the problem for now (probably by
>> applying your fix ourselves). Thanks.

>> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Sent: Tuesday, March 8, 2016 6:09 PM
>> To: Jonathan Rajotte Julien
>> Cc: lttng-dev
>> Subject: Re: [lttng-dev] segfault when exiting process with background thread
>> The attached patch works around the issue. The problem is
>> the tracepoint destructors that run in parallel with the thread
>> that still exists.

>> If we remove this, we leak the liblttng-ust-tracepoint.so.0 shared
>> object on dlclose of the instrumented code. Not sure if we should
>> care though...

>> Thoughts ?

>> Thanks,

>> Mathieu

>> ----- On Mar 8, 2016, at 7:35 PM, Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:

>>> Reproduced it on master (ust and tools).

>>> Repro with:

>>> lttng create
>>> lttng enable-event -u -a
>>> lttng start

>>> then run hello a few times, it eventually segfaults in the spawned thread.

>>> Looking into it.

>>> Thanks,

>>> Mathieu

>>> ----- On Mar 8, 2016, at 7:12 PM, Jonathan Rajotte Julien
>>> <Jonathan.rajotte-julien@efficios.com> wrote:

>>>> Hi Jeffrey,

>>>> Could you provide the version for lttng-ust, lttng-tools, lttng-modules (if
>>>> installed)?

>>>> Were you able to reproduce the issue on master (git) ?

>>>> What are the exact order of command to reproduce the problem ?

>>>> Thanks

>>>> On 2016-03-08 06:43 PM, Jeffrey Chen wrote:

>>>>> Hi LTTng community:

>>>>> We are using LTTng for our production environment. We have been noticing
>>>>> segfault problem when our process exit. We think the problem is due to the
>>>>> background thread continue to write traces, while LTTng cleanup its memory. We
>>>>> do not know how to fix this issue without changing LTTng code base. I have
>>>>> written a very simple app that could repro the problem. Most of my codes are
>>>>> copy pasted from the LTTng doc sample. Is there any fix that the LTTng side
>>>>> could do?

>>>>> hello.c

>>>>> #include <stdio.h>
>>>>> #include "hello-tp.h"
>>>>> #include <pthread.h>

>>>>> void* doSomeThing(void *arg)
>>>>> {
>>>>> int x;
>>>>> for (x = 0; x < 100000; ++x) {
>>>>> tracepoint(hello_world, my_first_tracepoint, x, "test");
>>>>> }
>>>>> }

>>>>> int main(int argc, char *argv[])
>>>>> {
>>>>> int x;

>>>>> getchar();

>>>>> pthread_t inc_x_thread;

>>>>> if(pthread_create(&inc_x_thread, NULL, doSomeThing, NULL)) {

>>>>> fprintf(stderr, "Error creating thread\n");
>>>>> return 1;
>>>>> }

>>>>> tracepoint(hello_world, my_first_tracepoint, 23, "hi there!");

>>>>> return 0;
>>>>> }

>>>>> hello-tp.c

>>>>> #define TRACEPOINT_CREATE_PROBES
>>>>> #define TRACEPOINT_DEFINE

>>>>> #include "hello-tp.h"

>>>>> hello-tp.h

>>>>> #undef TRACEPOINT_PROVIDER
>>>>> #define TRACEPOINT_PROVIDER hello_world

>>>>> #undef TRACEPOINT_INCLUDE
>>>>> #define TRACEPOINT_INCLUDE "./hello-tp.h"

>>>>> #if !defined(_HELLO_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
>>>>> #define _HELLO_TP_H

>>>>> #include <lttng/tracepoint.h>

>>>>> TRACEPOINT_EVENT(
>>>>> hello_world,
>>>>> my_first_tracepoint,
>>>>> TP_ARGS(
>>>>> int, my_integer_arg,
>>>>> char*, my_string_arg
>>>>> ),
>>>>> TP_FIELDS(
>>>>> ctf_string(my_string_field, my_string_arg)
>>>>> ctf_integer(int, my_integer_field, my_integer_arg)
>>>>> )
>>>>> )

>>>>> #endif /* _HELLO_TP_H */

>>>>> #include <lttng/tracepoint-event.h>

>>>>> Compile

>>>>> gcc -c -I. hello-tp.c
>>>>> gcc -c hello.c
>>>>> gcc -o hello hello.o hello-tp.o -llttng-ust -ldl -lpthread

>>>>> _______________________________________________
>>>>> lttng-dev mailing list lttng-dev@lists.lttng.org
>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

>>>> --
>>>> Jonathan R. Julien
>>>> Efficios

>>>> _______________________________________________
>>>> lttng-dev mailing list
>>>> lttng-dev@lists.lttng.org
>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

>>> --
>>> Mathieu Desnoyers
>>> EfficiOS Inc.
>>> http://www.efficios.com

>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_22563_2093516087.1457652451556
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><span id=3D"zwchr"=
 data-marker=3D"__DIVIDER__">----- On Mar 10, 2016, at 5:59 PM, Jeffrey Che=
n &lt;cpthk@hotmail.com&gt; wrote:<br></span><div data-marker=3D"__QUOTED_T=
EXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;p=
adding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decora=
tion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><style st=
yle=3D"display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style><di=
v id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;backgro=
und-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;"><p>Thank=
s, Mathieu.</p><p><br></p><p>Yes, the fix works as a workaround. This is al=
so the same workaround we have now.</p><p>It seems the problem is due to a =
race condition, that it checked whether "<span style=3D"font-size: 12pt; fo=
nt-family: &quot;Calibri&quot;,sans-serif; color: black; background: rgb(25=
5, 255, 255) none repeat scroll 0% 0%;">tracepoint_dlopen.rcu_read_lock_sym=
_bp</span>"
 is not NULL. If not NULL, it calls to that. But, at this moment, memset cl=
eared the memory.</p><p>This fix is okay with us, but I am not certain if i=
t would break other component, since I do not understand LTTng enough to te=
ll. Thanks.</p></div></blockquote><div><br></div><div>In addition to memset=
 clearing that memory, dlclose() of the lttng-ust-tracepoint<br data-mce-bo=
gus=3D"1"></div><div>shared object will clear the memory containing the cal=
led functions. Therefore,<br data-mce-bogus=3D"1"></div><div>we need to ski=
p both steps of the destructor if we want threads to survive after<br data-=
mce-bogus=3D"1"></div><div>this destructor execution.<br data-mce-bogus=3D"=
1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-b=
ogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"b=
order-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;fo=
nt-weight:normal;font-style:normal;text-decoration:none;font-family:Helveti=
ca,Arial,sans-serif;font-size:12pt;"><div id=3D"divtagdefaultwrapper" style=
=3D"font-size:12pt;color:#000000;background-color:#FFFFFF;font-family:Calib=
ri,Arial,Helvetica,sans-serif;"><p><br></p><p><br></p><br><br><div style=3D=
"color: rgb(0, 0, 0);"><hr style=3D"display:inline-block; width:98%"><div i=
d=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-size: 11pt; color: #000=
000; font-family: Calibri,sans-serif;" data-mce-style=3D"font-size: 11pt; c=
olor: #000000; font-family: Calibri,sans-serif;" color=3D"#000000" face=3D"=
Calibri, sans-serif"><b>From:</b> Mathieu Desnoyers &lt;mathieu.desnoyers@e=
fficios.com&gt;<br>
<b>Sent:</b> Thursday, March 10, 2016 10:52 AM<br>
<b>To:</b> Jeffrey Chen<br>
<b>Cc:</b> Jonathan Rajotte Julien; lttng-dev<br>
<b>Subject:</b> Re: segfault when exiting process with background thread</s=
pan></div><div><div style=3D"font-family:arial,helvetica,sans-serif; font-s=
ize:12pt; color:#000000"><div>Hi Jeffrey,<br></div><div><br></div><div>I CC=
'd your @live.com address on the RFC patch. Please let me know if the appro=
ach<br></div><div>is OK with you (and try it out).<br></div><div><br></div>=
<div>See:<br></div><div>https://lists.lttng.org/pipermail/lttng-dev/2016-Ma=
rch/025608.html</div><div><br></div><div>Thanks,<br></div><div><br></div><d=
iv>Mathieu<br></div><div><br></div><div><br></div><div><span id=3D"zwchr">-=
---- On Mar 10, 2016, at 1:35 PM, Jeffrey Chen &lt;cpthk@hotmail.com&gt; wr=
ote:<br>
</span></div><div><blockquote style=3D"border-left:2px solid #1010FF; margi=
n-left:5px; padding-left:5px; color:#000; font-weight:normal; font-style:no=
rmal; text-decoration:none; font-family:Helvetica,Arial,sans-serif; font-si=
ze:12pt"><div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#0=
00000; background-color:#FFFFFF; font-family:Calibri,Arial,Helvetica,sans-s=
erif"><p>Thanks Mathieu.</p><p>Is there a plan at LTTng side to fix this is=
sue? If so, we could wait for the fix. If not, we will have to workaround t=
he problem for now (probably by applying your fix ourselves). Thanks.<br></=
p><p><br></p><br><br><div style=3D"color:rgb(0,0,0)"><hr style=3D"display:i=
nline-block; width:98%"><div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=
=3D"font-size:11pt; color:#000000; font-family:Calibri,sans-serif"><b>From:=
</b> Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br>
<b>Sent:</b> Tuesday, March 8, 2016 6:09 PM<br>
<b>To:</b> Jonathan Rajotte Julien<br>
<b>Cc:</b> lttng-dev<br>
<b>Subject:</b> Re: [lttng-dev] segfault when exiting process with backgrou=
nd thread</span></div><div><div style=3D"font-family:arial,helvetica,sans-s=
erif; font-size:12pt; color:#000000"><div>The attached patch works around t=
he issue. The problem is<br></div><div>the tracepoint destructors that run =
in parallel with the thread<br></div><div>that still exists.<br></div><div>=
<br></div><div>If we remove this, we leak the liblttng-ust-tracepoint.so.0 =
shared<br></div><div>object on dlclose of the instrumented code. Not sure i=
f we should<br></div><div>care though...<br></div><div><br></div><div>Thoug=
hts ?<br></div><div><br></div><div>Thanks,<br></div><div><br></div><div>Mat=
hieu<br></div><div><br></div><div><br></div><div><span id=3D"zwchr">----- O=
n Mar 8, 2016, at 7:35 PM, Mathieu Desnoyers &lt;mathieu.desnoyers@efficios=
.com&gt; wrote:<br>
</span></div><div><blockquote style=3D"border-left:2px solid #1010FF; margi=
n-left:5px; padding-left:5px; color:#000; font-weight:normal; font-style:no=
rmal; text-decoration:none; font-family:Helvetica,Arial,sans-serif; font-si=
ze:12pt"><div style=3D"font-family:arial,helvetica,sans-serif; font-size:12=
pt; color:#000000"><div>Reproduced it on master (ust and tools).<br></div><=
br><div>Repro with:<br></div><br><div>lttng create<br></div><div>lttng enab=
le-event -u -a<br></div><div>lttng start<br></div><br><div>then run hello a=
 few times, it eventually segfaults in the spawned thread.<br></div><br><di=
v>Looking into it.<br></div><br><div>Thanks,<br></div><br><div>Mathieu<br><=
/div><br><span id=3D"zwchr">----- On Mar 8, 2016, at 7:12 PM, Jonathan Rajo=
tte Julien &lt;Jonathan.rajotte-julien@efficios.com&gt; wrote:<br>
</span><div><blockquote style=3D"border-left:2px solid #1010FF; margin-left=
:5px; padding-left:5px; color:#000; font-weight:normal; font-style:normal; =
text-decoration:none; font-family:Helvetica,Arial,sans-serif; font-size:12p=
t">
Hi Jeffrey,<br><br>
Could you provide the version for lttng-ust, lttng-tools, lttng-modules (if=
 installed)?<br><br>
Were you able to reproduce the issue on master (git) ?<br><br>
What are the exact order of command to reproduce the problem ?<br><br>
Thanks<br><br><div class=3D"moz-cite-prefix">On 2016-03-08 06:43 PM, Jeffre=
y Chen wrote:<br></div><blockquote><div id=3D"divtagdefaultwrapper" style=
=3D"font-size:12pt; color:#000000; background-color:#FFFFFF; font-family:Ca=
libri,Arial,Helvetica,sans-serif"><p>Hi LTTng community:</p><p><br></p><p>W=
e are using LTTng for our production environment. We have been noticing seg=
fault problem when our process exit. We think the problem is due to the bac=
kground thread continue to write traces, while LTTng cleanup its memory. We=
 do not know how to fix this
 issue without changing LTTng code base. I have written a very simple app t=
hat could repro the problem. Most of my codes are copy pasted from the LTTn=
g doc sample. Is there any fix that the LTTng side could do?</p><p><br></p>=
<p><br></p><p><b><span style=3D"text-decoration:underline">hello.c</span></=
b><br></p><p>#include &lt;stdio.h&gt;<br>
#include "hello-tp.h"<br>
#include &lt;pthread.h&gt;<br><br><br>
void* doSomeThing(void *arg)<br>
{<br>
&nbsp;&nbsp;&nbsp; int x;<br>
&nbsp;&nbsp;&nbsp; for (x =3D 0; x &lt; 100000; ++x) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tracepoint(hello_world, my_first=
_tracepoint, x, "test");<br>
&nbsp;&nbsp;&nbsp; }<br>
}<br><br>
int main(int argc, char *argv[])<br>
{<br>
&nbsp;&nbsp;&nbsp; int x;<br><br>
&nbsp;&nbsp;&nbsp; getchar();<br><br>
&nbsp;&nbsp;&nbsp; pthread_t inc_x_thread;<br><br>
&nbsp;&nbsp;&nbsp; if(pthread_create(&amp;inc_x_thread, NULL, doSomeThing, =
NULL)) {<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, "Error creating =
thread\n");<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1;<br>
&nbsp;&nbsp;&nbsp; }<br><br>
&nbsp;&nbsp;&nbsp; tracepoint(hello_world, my_first_tracepoint, 23, "hi the=
re!");<br><br>
&nbsp;&nbsp;&nbsp; return 0;<br>
}</p><p><br></p><p><b><span style=3D"text-decoration:underline">hello-tp.c<=
/span></b><br></p><p>#define TRACEPOINT_CREATE_PROBES<br>
#define TRACEPOINT_DEFINE<br><br>
#include "hello-tp.h"<br></p><p><br></p><p><b><span style=3D"text-decoratio=
n:underline">hello-tp.h</span></b></p><p>#undef TRACEPOINT_PROVIDER<br>
#define TRACEPOINT_PROVIDER hello_world<br><br>
#undef TRACEPOINT_INCLUDE<br>
#define TRACEPOINT_INCLUDE "./hello-tp.h"<br><br>
#if !defined(_HELLO_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)<br>
#define _HELLO_TP_H<br><br>
#include &lt;lttng/tracepoint.h&gt;<br><br>
TRACEPOINT_EVENT(<br>
&nbsp;&nbsp;&nbsp; hello_world,<br>
&nbsp;&nbsp;&nbsp; my_first_tracepoint,<br>
&nbsp;&nbsp;&nbsp; TP_ARGS(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int, my_integer_arg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char*, my_string_arg<br>
&nbsp;&nbsp;&nbsp; ),<br>
&nbsp;&nbsp;&nbsp; TP_FIELDS(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctf_string(my_string_field, my_s=
tring_arg)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctf_integer(int, my_integer_fiel=
d, my_integer_arg)<br>
&nbsp;&nbsp;&nbsp; )<br>
)<br><br>
#endif /* _HELLO_TP_H */<br><br>
#include &lt;lttng/tracepoint-event.h&gt;<br></p><p><br></p><p><b><span sty=
le=3D"text-decoration:underline">Compile</span></b></p><p>gcc -c -I. hello-=
tp.c<br>
gcc -c hello.c<br>
gcc -o hello hello.o hello-tp.o -llttng-ust -ldl -lpthread<br><br></p><p><b=
r></p><p><br></p><p><br></p></div><br><br><pre>____________________________=
___________________
lttng-dev mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:lttng-dev@lists.lttng.=
org" target=3D"_blank">lttng-dev@lists.lttng.org</a><a class=3D"moz-txt-lin=
k-freetext" href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-d=
ev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng=
-dev</a></pre></blockquote><br><pre class=3D"moz-signature">--=20
Jonathan R. Julien
Efficios</pre><br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote><=
/div><br><div>-- <br></div><div>Mathieu Desnoyers<br>
EfficiOS Inc.<br>
http://www.efficios.com</div></div><br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote><=
/div><div><br></div><div>-- <br></div><div>Mathieu Desnoyers<br>
EfficiOS Inc.<br>
http://www.efficios.com</div></div></div></div></div><br></blockquote></div=
><div><br></div><div>-- <br></div><div>Mathieu Desnoyers<br>
EfficiOS Inc.<br>
http://www.efficios.com</div></div></div></div></div><br></blockquote></div=
><br><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<=
br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
------=_Part_22563_2093516087.1457652451556--

--===============5992929351620477986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5992929351620477986==--
