From: Jeffrey Chen <cpthk@live.com>
Subject: Re: segfault when exiting process with background thread
Date: Wed, 21 Sep 2016 20:00:41 +0000
Message-ID: <CY4PR13MB1414010B72D6389030477BECC7F60__47953.6076578826$1474488358$gmane$org@CY4PR13MB1414.namprd13.prod.outlook.com>
References: <DM3PR13MB0782B678A6ECD858863C1A8CC7B20@DM3PR13MB0782.namprd13.prod.outlook.com>
 <767354504.19909.1457483744934.JavaMail.zimbra@efficios.com>
 <114312835.20088.1457489356654.JavaMail.zimbra@efficios.com>
 <DM3PR15MB0768E77237D422EFE34C0014ABB40@DM3PR15MB0768.namprd15.prod.outlook.com>
 <1717932664.22109.1457635977007.JavaMail.zimbra@efficios.com>
 <BY2PR15MB0759383FF520BBE4DB105F22ABB40@BY2PR15MB0759.namprd15.prod.outlook.com>
 <75563213.22564.1457652451557.JavaMail.zimbra@efficios.com>
 <BY2PR15MB07598BAFC59EAAA6D7812019AB890@BY2PR15MB0759.namprd15.prod.outlook.com>,
 <967044216.25799.1458068418180.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1552474587449231892=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from SNT004-OMC3S47.hotmail.com (snt004-omc3s47.hotmail.com
 [65.54.51.84])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id E0C64A3B2F
 for <lttng-dev@lists.lttng.org>; Wed, 21 Sep 2016 20:06:53 +0000 (UTC)
In-Reply-To: <967044216.25799.1458068418180.JavaMail.zimbra@efficios.com>
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
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jeffrey Chen <cpthk@hotmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1552474587449231892==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR13MB1414010B72D6389030477BECC7F60CY4PR13MB1414namp_"

--_000_CY4PR13MB1414010B72D6389030477BECC7F60CY4PR13MB1414namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

It seems that some changes went in recently that caused this workaround to =
not work again. Originally, the __tracepoints__disable_destructors variable=
 should be checked around the beginning of the destructor functions (__trac=
epoints__destroy and __tracepoints__ptrs_destroy), and return the function =
when the variable is true. It is not in the beginning any more. So, the seg=
fault problem could happen. Is it possible to fix it again at your convenie=
nce? Thanks a lot.


________________________________
From: lttng-dev <lttng-dev-bounces@lists.lttng.org> on behalf of Mathieu De=
snoyers <mathieu.desnoyers@efficios.com>
Sent: Tuesday, March 15, 2016 12:00 PM
To: Jeffrey Chen
Cc: lttng-dev
Subject: Re: [lttng-dev] segfault when exiting process with background thre=
ad

Commit merged into master, thanks for your feedback!

Mathieu

----- On Mar 15, 2016, at 2:48 PM, Jeffrey Chen <cpthk@hotmail.com> wrote:

Hi Mathieu:


Will this fix be checked-in? Thanks.



________________________________
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Sent: Thursday, March 10, 2016 3:27 PM
To: Jeffrey Chen
Cc: Jonathan Rajotte Julien; lttng-dev
Subject: Re: segfault when exiting process with background thread



----- On Mar 10, 2016, at 5:59 PM, Jeffrey Chen <cpthk@hotmail.com> wrote:

Thanks, Mathieu.


Yes, the fix works as a workaround. This is also the same workaround we hav=
e now.

It seems the problem is due to a race condition, that it checked whether "t=
racepoint_dlopen.rcu_read_lock_sym_bp" is not NULL. If not NULL, it calls t=
o that. But, at this moment, memset cleared the memory.

This fix is okay with us, but I am not certain if it would break other comp=
onent, since I do not understand LTTng enough to tell. Thanks.

In addition to memset clearing that memory, dlclose() of the lttng-ust-trac=
epoint
shared object will clear the memory containing the called functions. Theref=
ore,
we need to skip both steps of the destructor if we want threads to survive =
after
this destructor execution.

Thanks,

Mathieu





________________________________
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Sent: Thursday, March 10, 2016 10:52 AM
To: Jeffrey Chen
Cc: Jonathan Rajotte Julien; lttng-dev
Subject: Re: segfault when exiting process with background thread
Hi Jeffrey,

I CC'd your @live.com address on the RFC patch. Please let me know if the a=
pproach
is OK with you (and try it out).

See:
https://lists.lttng.org/pipermail/lttng-dev/2016-March/025608.html

Thanks,

Mathieu


----- On Mar 10, 2016, at 1:35 PM, Jeffrey Chen <cpthk@hotmail.com> wrote:

Thanks Mathieu.

Is there a plan at LTTng side to fix this issue? If so, we could wait for t=
he fix. If not, we will have to workaround the problem for now (probably by=
 applying your fix ourselves). Thanks.



________________________________
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Sent: Tuesday, March 8, 2016 6:09 PM
To: Jonathan Rajotte Julien
Cc: lttng-dev
Subject: Re: [lttng-dev] segfault when exiting process with background thre=
ad
The attached patch works around the issue. The problem is
the tracepoint destructors that run in parallel with the thread
that still exists.

If we remove this, we leak the liblttng-ust-tracepoint.so.0 shared
object on dlclose of the instrumented code. Not sure if we should
care though...

Thoughts ?

Thanks,

Mathieu


----- On Mar 8, 2016, at 7:35 PM, Mathieu Desnoyers <mathieu.desnoyers@effi=
cios.com> wrote:
Reproduced it on master (ust and tools).

Repro with:

lttng create
lttng enable-event -u -a
lttng start

then run hello a few times, it eventually segfaults in the spawned thread.

Looking into it.

Thanks,

Mathieu

----- On Mar 8, 2016, at 7:12 PM, Jonathan Rajotte Julien <Jonathan.rajotte=
-julien@efficios.com> wrote:
Hi Jeffrey,

Could you provide the version for lttng-ust, lttng-tools, lttng-modules (if=
 installed)?

Were you able to reproduce the issue on master (git) ?

What are the exact order of command to reproduce the problem ?

Thanks

On 2016-03-08 06:43 PM, Jeffrey Chen wrote:

Hi LTTng community:


We are using LTTng for our production environment. We have been noticing se=
gfault problem when our process exit. We think the problem is due to the ba=
ckground thread continue to write traces, while LTTng cleanup its memory. W=
e do not know how to fix this issue without changing LTTng code base. I hav=
e written a very simple app that could repro the problem. Most of my codes =
are copy pasted from the LTTng doc sample. Is there any fix that the LTTng =
side could do?



hello.c

#include <stdio.h>
#include "hello-tp.h"
#include <pthread.h>


void* doSomeThing(void *arg)
{
    int x;
    for (x =3D 0; x < 100000; ++x) {
        tracepoint(hello_world, my_first_tracepoint, x, "test");
    }
}

int main(int argc, char *argv[])
{
    int x;

    getchar();

    pthread_t inc_x_thread;

    if(pthread_create(&inc_x_thread, NULL, doSomeThing, NULL)) {

        fprintf(stderr, "Error creating thread\n");
        return 1;
    }

    tracepoint(hello_world, my_first_tracepoint, 23, "hi there!");

    return 0;
}


hello-tp.c

#define TRACEPOINT_CREATE_PROBES
#define TRACEPOINT_DEFINE

#include "hello-tp.h"


hello-tp.h

#undef TRACEPOINT_PROVIDER
#define TRACEPOINT_PROVIDER hello_world

#undef TRACEPOINT_INCLUDE
#define TRACEPOINT_INCLUDE "./hello-tp.h"

#if !defined(_HELLO_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
#define _HELLO_TP_H

#include <lttng/tracepoint.h>

TRACEPOINT_EVENT(
    hello_world,
    my_first_tracepoint,
    TP_ARGS(
        int, my_integer_arg,
        char*, my_string_arg
    ),
    TP_FIELDS(
        ctf_string(my_string_field, my_string_arg)
        ctf_integer(int, my_integer_field, my_integer_arg)
    )
)

#endif /* _HELLO_TP_H */

#include <lttng/tracepoint-event.h>


Compile

gcc -c -I. hello-tp.c
gcc -c hello.c
gcc -o hello hello.o hello-tp.o -llttng-ust -ldl -lpthread







_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org<mailto:lttng-dev@lists.lttng.org>http://lists.ltt=
ng.org/cgi-bin/mailman/listinfo/lttng-dev


--
Jonathan R. Julien
Efficios

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com


--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com


--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com


--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

--_000_CY4PR13MB1414010B72D6389030477BECC7F60CY4PR13MB1414namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;">
<p><span>It seems that some changes went in recently that caused this worka=
round to not work again. Originally, the __tracepoints__disable_destructors=
 variable should be checked around the beginning of the destructor function=
s (<span class=3D"pl-c1">__tracepoints__destroy</span>
 and <span class=3D"pl-c1">__tracepoints__ptrs_destroy</span>), and return =
the function when the variable is true. It is not in the beginning any more=
. So, the segfault problem could happen. Is it possible to fix it again at =
your convenience? Thanks a lot.</span><br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> lttng-dev &lt;lttng=
-dev-bounces@lists.lttng.org&gt; on behalf of Mathieu Desnoyers &lt;mathieu=
.desnoyers@efficios.com&gt;<br>
<b>Sent:</b> Tuesday, March 15, 2016 12:00 PM<br>
<b>To:</b> Jeffrey Chen<br>
<b>Cc:</b> lttng-dev<br>
<b>Subject:</b> Re: [lttng-dev] segfault when exiting process with backgrou=
nd thread</font>
<div>&nbsp;</div>
</div>
<div>
<div style=3D"font-family:arial,helvetica,sans-serif; font-size:12pt; color=
:#000000">
<div>Commit merged into master, thanks for your feedback!<br>
</div>
<div><br>
</div>
<div>Mathieu<br>
</div>
<div><br>
</div>
<span id=3D"zwchr">----- On Mar 15, 2016, at 2:48 PM, Jeffrey Chen &lt;cpth=
k@hotmail.com&gt; wrote:<br>
</span>
<div>
<blockquote style=3D"border-left:2px solid #1010FF; margin-left:5px; paddin=
g-left:5px; color:#000; font-weight:normal; font-style:normal; text-decorat=
ion:none; font-family:Helvetica,Arial,sans-serif; font-size:12pt">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; ba=
ckground-color:#FFFFFF; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Hi Mathieu:</p>
<p><br>
</p>
<p>Will this fix be checked-in? Thanks.<br>
</p>
<p><br>
</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span color=3D"#000000" face=3D"Calib=
ri, sans-serif" style=3D"font-size:11pt; color:#000000; font-family:Calibri=
,sans-serif"><b>From:</b> Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.=
com&gt;<br>
<b>Sent:</b> Thursday, March 10, 2016 3:27 PM<br>
<b>To:</b> Jeffrey Chen<br>
<b>Cc:</b> Jonathan Rajotte Julien; lttng-dev<br>
<b>Subject:</b> Re: segfault when exiting process with background thread</s=
pan>
<div>&nbsp;</div>
</div>
<div>
<div style=3D"font-family:arial,helvetica,sans-serif; font-size:12pt; color=
:#000000">
<div><br>
</div>
<div><br>
</div>
<span id=3D"zwchr">----- On Mar 10, 2016, at 5:59 PM, Jeffrey Chen &lt;cpth=
k@hotmail.com&gt; wrote:<br>
</span>
<div>
<blockquote style=3D"border-left:2px solid #1010FF; margin-left:5px; paddin=
g-left:5px; color:#000; font-weight:normal; font-style:normal; text-decorat=
ion:none; font-family:Helvetica,Arial,sans-serif; font-size:12pt">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; ba=
ckground-color:#FFFFFF; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Thanks, Mathieu.</p>
<p><br>
</p>
<p>Yes, the fix works as a workaround. This is also the same workaround we =
have now.</p>
<p>It seems the problem is due to a race condition, that it checked whether=
 &quot;<span style=3D"font-size:12pt; font-family:&quot;Calibri&quot;,sans-=
serif; color:black; background:rgb(255,255,255) none repeat scroll 0% 0%">t=
racepoint_dlopen.rcu_read_lock_sym_bp</span>&quot; is
 not NULL. If not NULL, it calls to that. But, at this moment, memset clear=
ed the memory.</p>
<p>This fix is okay with us, but I am not certain if it would break other c=
omponent, since I do not understand LTTng enough to tell. Thanks.</p>
</div>
</blockquote>
<div><br>
</div>
<div>In addition to memset clearing that memory, dlclose() of the lttng-ust=
-tracepoint<br>
</div>
<div>shared object will clear the memory containing the called functions. T=
herefore,<br>
</div>
<div>we need to skip both steps of the destructor if we want threads to sur=
vive after<br>
</div>
<div>this destructor execution.<br>
</div>
<div><br>
</div>
<div>Thanks,<br>
</div>
<div><br>
</div>
<div>Mathieu<br>
</div>
<div><br>
</div>
<blockquote style=3D"border-left:2px solid #1010FF; margin-left:5px; paddin=
g-left:5px; color:#000; font-weight:normal; font-style:normal; text-decorat=
ion:none; font-family:Helvetica,Arial,sans-serif; font-size:12pt">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; ba=
ckground-color:#FFFFFF; font-family:Calibri,Arial,Helvetica,sans-serif">
<p><br>
</p>
<p><br>
</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-size:11pt; color:=
#000000; font-family:Calibri,sans-serif"><b>From:</b> Mathieu Desnoyers &lt=
;mathieu.desnoyers@efficios.com&gt;<br>
<b>Sent:</b> Thursday, March 10, 2016 10:52 AM<br>
<b>To:</b> Jeffrey Chen<br>
<b>Cc:</b> Jonathan Rajotte Julien; lttng-dev<br>
<b>Subject:</b> Re: segfault when exiting process with background thread</s=
pan></div>
<div>
<div style=3D"font-family:arial,helvetica,sans-serif; font-size:12pt; color=
:#000000">
<div>Hi Jeffrey,<br>
</div>
<div><br>
</div>
<div>I CC'd your @live.com address on the RFC patch. Please let me know if =
the approach<br>
</div>
<div>is OK with you (and try it out).<br>
</div>
<div><br>
</div>
<div>See:<br>
</div>
<div>https://lists.lttng.org/pipermail/lttng-dev/2016-March/025608.html</di=
v>
<div><br>
</div>
<div>Thanks,<br>
</div>
<div><br>
</div>
<div>Mathieu<br>
</div>
<div><br>
</div>
<div><br>
</div>
<div><span id=3D"zwchr">----- On Mar 10, 2016, at 1:35 PM, Jeffrey Chen &lt=
;cpthk@hotmail.com&gt; wrote:<br>
</span></div>
<div>
<blockquote style=3D"border-left:2px solid #1010FF; margin-left:5px; paddin=
g-left:5px; color:#000; font-weight:normal; font-style:normal; text-decorat=
ion:none; font-family:Helvetica,Arial,sans-serif; font-size:12pt">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; ba=
ckground-color:#FFFFFF; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Thanks Mathieu.</p>
<p>Is there a plan at LTTng side to fix this issue? If so, we could wait fo=
r the fix. If not, we will have to workaround the problem for now (probably=
 by applying your fix ourselves). Thanks.<br>
</p>
<p><br>
</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-size:11pt; color:=
#000000; font-family:Calibri,sans-serif"><b>From:</b> Mathieu Desnoyers &lt=
;mathieu.desnoyers@efficios.com&gt;<br>
<b>Sent:</b> Tuesday, March 8, 2016 6:09 PM<br>
<b>To:</b> Jonathan Rajotte Julien<br>
<b>Cc:</b> lttng-dev<br>
<b>Subject:</b> Re: [lttng-dev] segfault when exiting process with backgrou=
nd thread</span></div>
<div>
<div style=3D"font-family:arial,helvetica,sans-serif; font-size:12pt; color=
:#000000">
<div>The attached patch works around the issue. The problem is<br>
</div>
<div>the tracepoint destructors that run in parallel with the thread<br>
</div>
<div>that still exists.<br>
</div>
<div><br>
</div>
<div>If we remove this, we leak the liblttng-ust-tracepoint.so.0 shared<br>
</div>
<div>object on dlclose of the instrumented code. Not sure if we should<br>
</div>
<div>care though...<br>
</div>
<div><br>
</div>
<div>Thoughts ?<br>
</div>
<div><br>
</div>
<div>Thanks,<br>
</div>
<div><br>
</div>
<div>Mathieu<br>
</div>
<div><br>
</div>
<div><br>
</div>
<div><span id=3D"zwchr">----- On Mar 8, 2016, at 7:35 PM, Mathieu Desnoyers=
 &lt;mathieu.desnoyers@efficios.com&gt; wrote:<br>
</span></div>
<div>
<blockquote style=3D"border-left:2px solid #1010FF; margin-left:5px; paddin=
g-left:5px; color:#000; font-weight:normal; font-style:normal; text-decorat=
ion:none; font-family:Helvetica,Arial,sans-serif; font-size:12pt">
<div style=3D"font-family:arial,helvetica,sans-serif; font-size:12pt; color=
:#000000">
<div>Reproduced it on master (ust and tools).<br>
</div>
<br>
<div>Repro with:<br>
</div>
<br>
<div>lttng create<br>
</div>
<div>lttng enable-event -u -a<br>
</div>
<div>lttng start<br>
</div>
<br>
<div>then run hello a few times, it eventually segfaults in the spawned thr=
ead.<br>
</div>
<br>
<div>Looking into it.<br>
</div>
<br>
<div>Thanks,<br>
</div>
<br>
<div>Mathieu<br>
</div>
<br>
<span id=3D"zwchr">----- On Mar 8, 2016, at 7:12 PM, Jonathan Rajotte Julie=
n &lt;Jonathan.rajotte-julien@efficios.com&gt; wrote:<br>
</span>
<div>
<blockquote style=3D"border-left:2px solid #1010FF; margin-left:5px; paddin=
g-left:5px; color:#000; font-weight:normal; font-style:normal; text-decorat=
ion:none; font-family:Helvetica,Arial,sans-serif; font-size:12pt">
Hi Jeffrey,<br>
<br>
Could you provide the version for lttng-ust, lttng-tools, lttng-modules (if=
 installed)?<br>
<br>
Were you able to reproduce the issue on master (git) ?<br>
<br>
What are the exact order of command to reproduce the problem ?<br>
<br>
Thanks<br>
<br>
<div class=3D"moz-cite-prefix">On 2016-03-08 06:43 PM, Jeffrey Chen wrote:<=
br>
</div>
<blockquote>
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; ba=
ckground-color:#FFFFFF; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Hi LTTng community:</p>
<p><br>
</p>
<p>We are using LTTng for our production environment. We have been noticing=
 segfault problem when our process exit. We think the problem is due to the=
 background thread continue to write traces, while LTTng cleanup its memory=
. We do not know how to fix this
 issue without changing LTTng code base. I have written a very simple app t=
hat could repro the problem. Most of my codes are copy pasted from the LTTn=
g doc sample. Is there any fix that the LTTng side could do?</p>
<p><br>
</p>
<p><br>
</p>
<p><b><span style=3D"text-decoration:underline">hello.c</span></b><br>
</p>
<p>#include &lt;stdio.h&gt;<br>
#include &quot;hello-tp.h&quot;<br>
#include &lt;pthread.h&gt;<br>
<br>
<br>
void* doSomeThing(void *arg)<br>
{<br>
&nbsp;&nbsp;&nbsp; int x;<br>
&nbsp;&nbsp;&nbsp; for (x =3D 0; x &lt; 100000; &#43;&#43;x) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tracepoint(hello_world, my_first=
_tracepoint, x, &quot;test&quot;);<br>
&nbsp;&nbsp;&nbsp; }<br>
}<br>
<br>
int main(int argc, char *argv[])<br>
{<br>
&nbsp;&nbsp;&nbsp; int x;<br>
<br>
&nbsp;&nbsp;&nbsp; getchar();<br>
<br>
&nbsp;&nbsp;&nbsp; pthread_t inc_x_thread;<br>
<br>
&nbsp;&nbsp;&nbsp; if(pthread_create(&amp;inc_x_thread, NULL, doSomeThing, =
NULL)) {<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;Error crea=
ting thread\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1;<br>
&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp; tracepoint(hello_world, my_first_tracepoint, 23, &quot;h=
i there!&quot;);<br>
<br>
&nbsp;&nbsp;&nbsp; return 0;<br>
}</p>
<p><br>
</p>
<p><b><span style=3D"text-decoration:underline">hello-tp.c</span></b><br>
</p>
<p>#define TRACEPOINT_CREATE_PROBES<br>
#define TRACEPOINT_DEFINE<br>
<br>
#include &quot;hello-tp.h&quot;<br>
</p>
<p><br>
</p>
<p><b><span style=3D"text-decoration:underline">hello-tp.h</span></b></p>
<p>#undef TRACEPOINT_PROVIDER<br>
#define TRACEPOINT_PROVIDER hello_world<br>
<br>
#undef TRACEPOINT_INCLUDE<br>
#define TRACEPOINT_INCLUDE &quot;./hello-tp.h&quot;<br>
<br>
#if !defined(_HELLO_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)<br>
#define _HELLO_TP_H<br>
<br>
#include &lt;lttng/tracepoint.h&gt;<br>
<br>
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
)<br>
<br>
#endif /* _HELLO_TP_H */<br>
<br>
#include &lt;lttng/tracepoint-event.h&gt;<br>
</p>
<p><br>
</p>
<p><b><span style=3D"text-decoration:underline">Compile</span></b></p>
<p>gcc -c -I. hello-tp.c<br>
gcc -c hello.c<br>
gcc -o hello hello.o hello-tp.o -llttng-ust -ldl -lpthread<br>
<br>
</p>
<p><br>
</p>
<p><br>
</p>
<p><br>
</p>
</div>
<br>
<br>
<pre>_______________________________________________=0A=
lttng-dev mailing list=0A=
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:lttng-dev@lists.lttng.=
org" target=3D"_blank">lttng-dev@lists.lttng.org</a><a class=3D"moz-txt-lin=
k-freetext" href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-d=
ev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng=
-dev</a><br></pre>
</blockquote>
<br>
<pre class=3D"moz-signature">-- =0A=
Jonathan R. Julien=0A=
Efficios</pre>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br>
</blockquote>
</div>
<br>
<div>-- <br>
</div>
<div>Mathieu Desnoyers<br>
EfficiOS Inc.<br>
http://www.efficios.com</div>
</div>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br>
</blockquote>
</div>
<div><br>
</div>
<div>-- <br>
</div>
<div>Mathieu Desnoyers<br>
EfficiOS Inc.<br>
http://www.efficios.com</div>
</div>
</div>
</div>
</div>
<br>
</blockquote>
</div>
<div><br>
</div>
<div>-- <br>
</div>
<div>Mathieu Desnoyers<br>
EfficiOS Inc.<br>
http://www.efficios.com</div>
</div>
</div>
</div>
</div>
<br>
</blockquote>
</div>
<br>
<div>-- <br>
</div>
<div>Mathieu Desnoyers<br>
EfficiOS Inc.<br>
http://www.efficios.com</div>
</div>
</div>
</div>
</div>
<br>
</blockquote>
</div>
<br>
<div>-- <br>
</div>
<div>Mathieu Desnoyers<br>
EfficiOS Inc.<br>
http://www.efficios.com</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR13MB1414010B72D6389030477BECC7F60CY4PR13MB1414namp_--

--===============1552474587449231892==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1552474587449231892==--
