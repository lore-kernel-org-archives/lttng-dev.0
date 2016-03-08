From: Jeffrey Chen <cpthk@live.com>
Subject: segfault when exiting process with background thread
Date: Tue, 8 Mar 2016 23:43:35 +0000
Message-ID: <DM3PR13MB0782B678A6ECD858863C1A8CC7B20__24278.155671391$1457480691$gmane$org@DM3PR13MB0782.namprd13.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0389831573=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from snt004-omc4s5.hotmail.com ([65.55.90.208])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <cpthk@live.com>) id 1adRHz-0003wz-Kq
 for lttng-dev@lists.lttng.org; Tue, 08 Mar 2016 18:43:45 -0500
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0389831573==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM3PR13MB0782B678A6ECD858863C1A8CC7B20DM3PR13MB0782namp_"

--_000_DM3PR13MB0782B678A6ECD858863C1A8CC7B20DM3PR13MB0782namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

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





--_000_DM3PR13MB0782B678A6ECD858863C1A8CC7B20DM3PR13MB0782namp_
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
<p><b><u>hello-tp.c</u></b><br>
</p>
<p>#define TRACEPOINT_CREATE_PROBES<br>
#define TRACEPOINT_DEFINE<br>
<br>
#include &quot;hello-tp.h&quot;<br>
</p>
<p><br>
</p>
<p><b><u>hello-tp.h</u></b></p>
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
<p><b><u>Compile</u></b></p>
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
</body>
</html>

--_000_DM3PR13MB0782B678A6ECD858863C1A8CC7B20DM3PR13MB0782namp_--


--===============0389831573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0389831573==--
