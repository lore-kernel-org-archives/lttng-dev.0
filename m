From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: segfault when exiting process with background thread
Date: Wed, 9 Mar 2016 02:09:16 +0000 (UTC)
Message-ID: <114312835.20088.1457489356654.JavaMail.zimbra__664.886475033377$1457489447$gmane$org@efficios.com>
References: <DM3PR13MB0782B678A6ECD858863C1A8CC7B20@DM3PR13MB0782.namprd13.prod.outlook.com>
 <56DF6A86.1030407@efficios.com>
 <767354504.19909.1457483744934.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_Part_20084_1614373117.1457489356653"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1adTZ5-0004x2-3n
 for lttng-dev@lists.lttng.org; Tue, 08 Mar 2016 21:09:34 -0500
In-Reply-To: <767354504.19909.1457483744934.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

------=_Part_20084_1614373117.1457489356653
Content-Type: multipart/alternative;
	boundary="----=_Part_20085_1212777978.1457489356653"

------=_Part_20085_1212777978.1457489356653
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

The attached patch works around the issue. The problem is 
the tracepoint destructors that run in parallel with the thread 
that still exists. 

If we remove this, we leak the liblttng-ust-tracepoint.so.0 shared 
object on dlclose of the instrumented code. Not sure if we should 
care though... 

Thoughts ? 

Thanks, 

Mathieu 

----- On Mar 8, 2016, at 7:35 PM, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote: 

> Reproduced it on master (ust and tools).

> Repro with:

> lttng create
> lttng enable-event -u -a
> lttng start

> then run hello a few times, it eventually segfaults in the spawned thread.

> Looking into it.

> Thanks,

> Mathieu

> ----- On Mar 8, 2016, at 7:12 PM, Jonathan Rajotte Julien
> <Jonathan.rajotte-julien@efficios.com> wrote:

>> Hi Jeffrey,

>> Could you provide the version for lttng-ust, lttng-tools, lttng-modules (if
>> installed)?

>> Were you able to reproduce the issue on master (git) ?

>> What are the exact order of command to reproduce the problem ?

>> Thanks

>> On 2016-03-08 06:43 PM, Jeffrey Chen wrote:

>>> Hi LTTng community:

>>> We are using LTTng for our production environment. We have been noticing
>>> segfault problem when our process exit. We think the problem is due to the
>>> background thread continue to write traces, while LTTng cleanup its memory. We
>>> do not know how to fix this issue without changing LTTng code base. I have
>>> written a very simple app that could repro the problem. Most of my codes are
>>> copy pasted from the LTTng doc sample. Is there any fix that the LTTng side
>>> could do?

>>> hello.c

>>> #include <stdio.h>
>>> #include "hello-tp.h"
>>> #include <pthread.h>

>>> void* doSomeThing(void *arg)
>>> {
>>> int x;
>>> for (x = 0; x < 100000; ++x) {
>>> tracepoint(hello_world, my_first_tracepoint, x, "test");
>>> }
>>> }

>>> int main(int argc, char *argv[])
>>> {
>>> int x;

>>> getchar();

>>> pthread_t inc_x_thread;

>>> if(pthread_create(&inc_x_thread, NULL, doSomeThing, NULL)) {

>>> fprintf(stderr, "Error creating thread\n");
>>> return 1;
>>> }

>>> tracepoint(hello_world, my_first_tracepoint, 23, "hi there!");

>>> return 0;
>>> }

>>> hello-tp.c

>>> #define TRACEPOINT_CREATE_PROBES
>>> #define TRACEPOINT_DEFINE

>>> #include "hello-tp.h"

>>> hello-tp.h

>>> #undef TRACEPOINT_PROVIDER
>>> #define TRACEPOINT_PROVIDER hello_world

>>> #undef TRACEPOINT_INCLUDE
>>> #define TRACEPOINT_INCLUDE "./hello-tp.h"

>>> #if !defined(_HELLO_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
>>> #define _HELLO_TP_H

>>> #include <lttng/tracepoint.h>

>>> TRACEPOINT_EVENT(
>>> hello_world,
>>> my_first_tracepoint,
>>> TP_ARGS(
>>> int, my_integer_arg,
>>> char*, my_string_arg
>>> ),
>>> TP_FIELDS(
>>> ctf_string(my_string_field, my_string_arg)
>>> ctf_integer(int, my_integer_field, my_integer_arg)
>>> )
>>> )

>>> #endif /* _HELLO_TP_H */

>>> #include <lttng/tracepoint-event.h>

>>> Compile

>>> gcc -c -I. hello-tp.c
>>> gcc -c hello.c
>>> gcc -o hello hello.o hello-tp.o -llttng-ust -ldl -lpthread

>>> _______________________________________________
>>> lttng-dev mailing list lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

>> --
>> Jonathan R. Julien
>> Efficios

>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_20085_1212777978.1457489356653
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>The attached patch works around the issue. =
The problem is<br></div><div>the tracepoint destructors that run in paralle=
l with the thread<br data-mce-bogus=3D"1"></div><div>that still exists.<br =
data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>If we r=
emove this, we leak the liblttng-ust-tracepoint.so.0 shared<br data-mce-bog=
us=3D"1"></div><div>object on dlclose of the instrumented code. Not sure if=
 we should<br data-mce-bogus=3D"1"></div><div>care though...<br data-mce-bo=
gus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thoughts ?<br data=
-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br =
data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu=
<br data-mce-bogus=3D"1"></div><div><br></div><div><br></div><div><span id=
=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Mar 8, 2016, at 7:35 PM, Ma=
thieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt; wrote:<br></span></d=
iv><div data-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2p=
x solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:nor=
mal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans=
-serif;font-size:12pt;"><div style=3D"font-family: arial, helvetica, sans-s=
erif; font-size: 12pt; color: #000000"><div>Reproduced it on master (ust an=
d tools).<br></div><br><div>Repro with:<br></div><br><div>lttng create<br><=
/div><div>lttng enable-event -u -a<br></div><div>lttng start<br></div><br><=
div>then run hello a few times, it eventually segfaults in the spawned thre=
ad.<br></div><br><div>Looking into it.<br></div><br><div>Thanks,<br></div><=
br><div>Mathieu<br></div><br><span id=3D"zwchr">----- On Mar 8, 2016, at 7:=
12 PM, Jonathan Rajotte Julien &lt;Jonathan.rajotte-julien@efficios.com&gt;=
 wrote:<br></span><div><blockquote style=3D"border-left:2px solid #1010FF;m=
argin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:no=
rmal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:=
12pt;">Hi Jeffrey,<br>
    <br>
    Could you provide the version for lttng-ust, lttng-tools,
    lttng-modules (if installed)?<br>
    <br>
    Were you able to reproduce the issue on master (git) ?<br>
    <br>
    What are the exact order of command to reproduce the problem ?<br>
    <br>
    Thanks<br>
    <br>
    <div class=3D"moz-cite-prefix">On 2016-03-08 06:43 PM, Jeffrey Chen
      wrote:<br>
    </div>
    <blockquote cite=3D"mid:DM3PR13MB0782B678A6ECD858863C1A8CC7B20@DM3PR13M=
B0782.namprd13.prod.outlook.com">
     =20
      <style style=3D"display:none;"><!-- P {margin-top:0;margin-bottom:0;}=
 --></style>
      <div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#00000=
0;background-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;"=
>
        <p>Hi LTTng community:</p>
        <p><br>
        </p>
        <p>We are using LTTng for our production environment. We have
          been noticing segfault problem when our process exit. We think
          the problem is due to the background thread continue to write
          traces, while LTTng cleanup its memory. We do not know how to
          fix this issue without changing LTTng code base. I have
          written a very simple app that could repro the problem. Most
          of my codes are copy pasted from the LTTng doc sample. Is
          there any fix that the LTTng side could do?</p>
        <p><br>
        </p>
        <p><br>
        </p>
        <p><b><u>hello.c</u></b><br>
        </p>
        <p>#include &lt;stdio.h&gt;<br>
          #include "hello-tp.h"<br>
          #include &lt;pthread.h&gt;<br>
          <br>
          <br>
          void* doSomeThing(void *arg)<br>
          {<br>
          &nbsp;&nbsp;&nbsp; int x;<br>
          &nbsp;&nbsp;&nbsp; for (x =3D 0; x &lt; 100000; ++x) {<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tracepoint(hello_world=
, my_first_tracepoint, x,
          "test");<br>
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
          &nbsp;&nbsp;&nbsp; if(pthread_create(&amp;inc_x_thread, NULL, doS=
omeThing,
          NULL)) {<br>
          &nbsp;&nbsp; &nbsp;<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, "Error=
 creating thread\n");<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1;<br>
          &nbsp;&nbsp;&nbsp; }<br>
          <br>
          &nbsp;&nbsp;&nbsp; tracepoint(hello_world, my_first_tracepoint, 2=
3, "hi
          there!");<br>
          <br>
          &nbsp;&nbsp;&nbsp; return 0;<br>
          }</p>
        <p><br>
        </p>
        <p><b><span style=3D"text-decoration: underline;">hello-tp.c</span>=
</b><br>
        </p>
        <p>#define TRACEPOINT_CREATE_PROBES<br>
          #define TRACEPOINT_DEFINE<br>
          <br>
          #include "hello-tp.h"<br>
        </p>
        <p><br>
        </p>
        <p><b><span style=3D"text-decoration: underline;">hello-tp.h</span>=
</b></p>
        <p>#undef TRACEPOINT_PROVIDER<br>
          #define TRACEPOINT_PROVIDER hello_world<br>
          <br>
          #undef TRACEPOINT_INCLUDE<br>
          #define TRACEPOINT_INCLUDE "./hello-tp.h"<br>
          <br>
          #if !defined(_HELLO_TP_H) ||
          defined(TRACEPOINT_HEADER_MULTI_READ)<br>
          #define _HELLO_TP_H<br>
          <br>
          #include &lt;lttng/tracepoint.h&gt;<br>
          <br>
          TRACEPOINT_EVENT(<br>
          &nbsp;&nbsp;&nbsp; hello_world,<br>
          &nbsp;&nbsp;&nbsp; my_first_tracepoint,<br>
          &nbsp;&nbsp;&nbsp; TP_ARGS(<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int, my_integer_arg,<b=
r>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char*, my_string_arg<b=
r>
          &nbsp;&nbsp;&nbsp; ),<br>
          &nbsp;&nbsp;&nbsp; TP_FIELDS(<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctf_string(my_string_f=
ield, my_string_arg)<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctf_integer(int, my_in=
teger_field, my_integer_arg)<br>
          &nbsp;&nbsp;&nbsp; )<br>
          )<br>
          <br>
          #endif /* _HELLO_TP_H */<br>
          <br>
          #include &lt;lttng/tracepoint-event.h&gt;<br>
        </p>
        <p><br>
        </p>
        <p><b><span style=3D"text-decoration: underline;">Compile</span></b=
></p>
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
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre>_______________________________________________
lttng-dev mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:lttng-dev@lists.lttng.=
org" target=3D"_blank">lttng-dev@lists.lttng.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"http://lists.lttng.org/cgi-bin/m=
ailman/listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin=
/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
    <pre class=3D"moz-signature">--=20
Jonathan R. Julien
Efficios</pre>
 =20

<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev<br></blockquote></div><br><div>-- <br></div><div>Mathieu =
Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div><br>______=
_________________________________________<br>lttng-dev mailing list<br>lttn=
g-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/listinfo/lt=
tng-dev<br></blockquote></div><div><br></div><div data-marker=3D"__SIG_POST=
__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.effi=
cios.com</div></div></body></html>
------=_Part_20085_1212777978.1457489356653--

------=_Part_20084_1614373117.1457489356653
Content-Type: text/x-patch; name=workaround-destructor-vs-threads.patch
Content-Disposition: attachment;
 filename=workaround-destructor-vs-threads.patch
Content-Transfer-Encoding: base64

Y29tbWl0IGZjZjNiNGIwOWZhNDU1ODAxNDMyOGYzNGIwYTFjMzk2YTAzYjY1MTUKQXV0aG9yOiBN
YXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgpEYXRlOiAg
IFR1ZSBNYXIgOCAyMTowNTozMiAyMDE2IC0wNTAwCgogICAgV29ya2Fyb3VuZAoKZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbHR0bmcvdHJhY2Vwb2ludC5oIGIvaW5jbHVkZS9sdHRuZy90cmFjZXBvaW50
LmgKaW5kZXggMTYzNDhiOC4uZDllMjAwMyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9sdHRuZy90cmFj
ZXBvaW50LmgKKysrIGIvaW5jbHVkZS9sdHRuZy90cmFjZXBvaW50LmgKQEAgLTMwMSw2ICszMDEs
NyBAQCBfX3RyYWNlcG9pbnRzX19kZXN0cm95KHZvaWQpCiAKIAlpZiAoLS1fX3RyYWNlcG9pbnRf
cmVnaXN0ZXJlZCkKIAkJcmV0dXJuOworI2lmIDAKIAlpZiAodHJhY2Vwb2ludF9kbG9wZW4ubGli
bHR0bmd1c3RfaGFuZGxlICYmICFfX3RyYWNlcG9pbnRfcHRyc19yZWdpc3RlcmVkKSB7CiAJCXJl
dCA9IGRsY2xvc2UodHJhY2Vwb2ludF9kbG9wZW4ubGlibHR0bmd1c3RfaGFuZGxlKTsKIAkJaWYg
KHJldCkgewpAQCAtMzA5LDYgKzMxMCw3IEBAIF9fdHJhY2Vwb2ludHNfX2Rlc3Ryb3kodm9pZCkK
IAkJfQogCQltZW1zZXQoJnRyYWNlcG9pbnRfZGxvcGVuLCAwLCBzaXplb2YodHJhY2Vwb2ludF9k
bG9wZW4pKTsKIAl9CisjZW5kaWYKIH0KIAogI2VuZGlmCkBAIC00MDQsNiArNDA2LDcgQEAgX190
cmFjZXBvaW50c19fcHRyc19kZXN0cm95KHZvaWQpCiAKIAlpZiAoLS1fX3RyYWNlcG9pbnRfcHRy
c19yZWdpc3RlcmVkKQogCQlyZXR1cm47CisjaWYgMAogCWlmICh0cmFjZXBvaW50X2Rsb3Blbi50
cmFjZXBvaW50X3VucmVnaXN0ZXJfbGliKQogCQl0cmFjZXBvaW50X2Rsb3Blbi50cmFjZXBvaW50
X3VucmVnaXN0ZXJfbGliKF9fc3RhcnRfX190cmFjZXBvaW50c19wdHJzKTsKIAlpZiAodHJhY2Vw
b2ludF9kbG9wZW4ubGlibHR0bmd1c3RfaGFuZGxlICYmICFfX3RyYWNlcG9pbnRfcmVnaXN0ZXJl
ZCkgewpAQCAtNDE0LDYgKzQxNyw3IEBAIF9fdHJhY2Vwb2ludHNfX3B0cnNfZGVzdHJveSh2b2lk
KQogCQl9CiAJCW1lbXNldCgmdHJhY2Vwb2ludF9kbG9wZW4sIDAsIHNpemVvZih0cmFjZXBvaW50
X2Rsb3BlbikpOwogCX0KKyNlbmRpZgogfQogCiAjZWxzZSAvKiBUUkFDRVBPSU5UX0RFRklORSAq
Lwo=
------=_Part_20084_1614373117.1457489356653
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

------=_Part_20084_1614373117.1457489356653--
