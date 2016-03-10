From: Jeffrey Chen <cpthk@hotmail.com>
Subject: Re: segfault when exiting process with background thread
Date: Thu, 10 Mar 2016 18:35:07 +0000
Message-ID: <DM3PR15MB0768E77237D422EFE34C0014ABB40__10231.1134724461$1457634954$gmane$org@DM3PR15MB0768.namprd15.prod.outlook.com>
References: <DM3PR13MB0782B678A6ECD858863C1A8CC7B20@DM3PR13MB0782.namprd13.prod.outlook.com>
 <56DF6A86.1030407@efficios.com>
 <767354504.19909.1457483744934.JavaMail.zimbra@efficios.com>,
 <114312835.20088.1457489356654.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8700183460835140578=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from BLU004-OMC4S24.hotmail.com (blu004-omc4s24.hotmail.com
 [65.55.111.163])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 48BFDA0A7C
 for <lttng-dev@lists.lttng.org>; Thu, 10 Mar 2016 18:35:11 +0000 (UTC)
In-Reply-To: <114312835.20088.1457489356654.JavaMail.zimbra@efficios.com>
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
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Rajotte
 Julien <Jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8700183460835140578==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM3PR15MB0768E77237D422EFE34C0014ABB40DM3PR15MB0768namp_"

--_000_DM3PR15MB0768E77237D422EFE34C0014ABB40DM3PR15MB0768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

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
lttng-dev@lists.lttng.org<mailto:lttng-dev@lists.lttng.org>
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



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

--_000_DM3PR15MB0768E77237D422EFE34C0014ABB40DM3PR15MB0768namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Thanks Mathieu.</p>
<p>Is there a plan at LTTng side to fix this issue? If so, we could wait fo=
r the fix. If not, we will have to workaround the problem for now (probably=
 by applying your fix ourselves). Thanks.<br>
</p>
<p><br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Mathieu Desnoyers &=
lt;mathieu.desnoyers@efficios.com&gt;<br>
<b>Sent:</b> Tuesday, March 8, 2016 6:09 PM<br>
<b>To:</b> Jonathan Rajotte Julien<br>
<b>Cc:</b> lttng-dev<br>
<b>Subject:</b> Re: [lttng-dev] segfault when exiting process with backgrou=
nd thread</font>
<div>&nbsp;</div>
</div>
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
<p><b><u>hello.c</u></b><br>
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
&nbsp;&nbsp; &nbsp;<br>
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
<fieldset class=3D"mimeAttachmentHeader"></fieldset> <br>
<pre>_______________________________________________=0A=
lttng-dev mailing list=0A=
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:lttng-dev@lists.lttng.=
org" target=3D"_blank">lttng-dev@lists.lttng.org</a>=0A=
<a class=3D"moz-txt-link-freetext" href=3D"http://lists.lttng.org/cgi-bin/m=
ailman/listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin=
/mailman/listinfo/lttng-dev</a>=0A=
</pre>
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
</body>
</html>

--_000_DM3PR15MB0768E77237D422EFE34C0014ABB40DM3PR15MB0768namp_--

--===============8700183460835140578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8700183460835140578==--
