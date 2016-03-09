From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: segfault when exiting process with background thread
Date: Tue, 8 Mar 2016 19:12:54 -0500
Message-ID: <56DF6A86.1030407__29685.5788132691$1457482447$gmane$org@efficios.com>
References: <DM3PR13MB0782B678A6ECD858863C1A8CC7B20@DM3PR13MB0782.namprd13.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0582134284=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1adRkM-0004AZ-PD
 for lttng-dev@lists.lttng.org; Tue, 08 Mar 2016 19:13:04 -0500
In-Reply-To: <DM3PR13MB0782B678A6ECD858863C1A8CC7B20@DM3PR13MB0782.namprd13.prod.outlook.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jeffrey Chen <cpthk@live.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============0582134284==
Content-Type: multipart/alternative;
 boundary="------------090409020003060005000906"

This is a multi-part message in MIME format.
--------------090409020003060005000906
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeffrey,

Could you provide the version for lttng-ust, lttng-tools, lttng-modules 
(if installed)?

Were you able to reproduce the issue on master (git) ?

What are the exact order of command to reproduce the problem ?

Thanks

On 2016-03-08 06:43 PM, Jeffrey Chen wrote:
>
> Hi LTTng community:
>
>
> We are using LTTng for our production environment. We have been 
> noticing segfault problem when our process exit. We think the problem 
> is due to the background thread continue to write traces, while LTTng 
> cleanup its memory. We do not know how to fix this issue without 
> changing LTTng code base. I have written a very simple app that could 
> repro the problem. Most of my codes are copy pasted from the LTTng doc 
> sample. Is there any fix that the LTTng side could do?
>
>
>
> *_hello.c_*
>
> #include <stdio.h>
> #include "hello-tp.h"
> #include <pthread.h>
>
>
> void* doSomeThing(void *arg)
> {
>     int x;
>     for (x = 0; x < 100000; ++x) {
>         tracepoint(hello_world, my_first_tracepoint, x, "test");
>     }
> }
>
> int main(int argc, char *argv[])
> {
>     int x;
>
>     getchar();
>
>     pthread_t inc_x_thread;
>
>     if(pthread_create(&inc_x_thread, NULL, doSomeThing, NULL)) {
>
>         fprintf(stderr, "Error creating thread\n");
>         return 1;
>     }
>
>     tracepoint(hello_world, my_first_tracepoint, 23, "hi there!");
>
>     return 0;
> }
>
>
> *_hello-tp.c_*
>
> #define TRACEPOINT_CREATE_PROBES
> #define TRACEPOINT_DEFINE
>
> #include "hello-tp.h"
>
>
> *_hello-tp.h_*
>
> #undef TRACEPOINT_PROVIDER
> #define TRACEPOINT_PROVIDER hello_world
>
> #undef TRACEPOINT_INCLUDE
> #define TRACEPOINT_INCLUDE "./hello-tp.h"
>
> #if !defined(_HELLO_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
> #define _HELLO_TP_H
>
> #include <lttng/tracepoint.h>
>
> TRACEPOINT_EVENT(
>     hello_world,
>     my_first_tracepoint,
>     TP_ARGS(
>         int, my_integer_arg,
>         char*, my_string_arg
>     ),
>     TP_FIELDS(
>         ctf_string(my_string_field, my_string_arg)
>         ctf_integer(int, my_integer_field, my_integer_arg)
>     )
> )
>
> #endif /* _HELLO_TP_H */
>
> #include <lttng/tracepoint-event.h>
>
>
> *_Compile_*
>
> gcc -c -I. hello-tp.c
> gcc -c hello.c
> gcc -o hello hello.o hello-tp.o -llttng-ust -ldl -lpthread
>
>
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Jonathan R. Julien
Efficios


--------------090409020003060005000906
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DISO-8859-1"
      http-equiv=3D"Content-Type">
  </head>
  <body>
    Hi Jeffrey,<br>
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
    <blockquote
cite=3D"mid:DM3PR13MB0782B678A6ECD858863C1A8CC7B20@DM3PR13MB0782.namprd13=
.prod.outlook.com"
      type=3D"cite">
      <meta http-equiv=3D"Content-Type" content=3D"text/html;
        charset=3DISO-8859-1">
      <style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top=
:0;margin-bottom:0;} --></style>
      <div id=3D"divtagdefaultwrapper"
style=3D"font-size:12pt;color:#000000;background-color:#FFFFFF;font-famil=
y:Calibri,Arial,Helvetica,sans-serif;">
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
          =C2=A0=C2=A0=C2=A0 int x;<br>
          =C2=A0=C2=A0=C2=A0 for (x =3D 0; x &lt; 100000; ++x) {<br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracepoint(hello_wor=
ld, my_first_tracepoint, x,
          "test");<br>
          =C2=A0=C2=A0=C2=A0 }<br>
          }<br>
          <br>
          int main(int argc, char *argv[])<br>
          {<br>
          =C2=A0=C2=A0=C2=A0 int x;<br>
          <br>
          =C2=A0=C2=A0=C2=A0 getchar();<br>
          <br>
          =C2=A0=C2=A0=C2=A0 pthread_t inc_x_thread;<br>
          <br>
          =C2=A0=C2=A0=C2=A0 if(pthread_create(&amp;inc_x_thread, NULL, d=
oSomeThing,
          NULL)) {<br>
          =C2=A0=C2=A0 =C2=A0<br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "Err=
or creating thread\n");<br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;<br>
          =C2=A0=C2=A0=C2=A0 }<br>
          <br>
          =C2=A0=C2=A0=C2=A0 tracepoint(hello_world, my_first_tracepoint,=
 23, "hi
          there!");<br>
          <br>
          =C2=A0=C2=A0=C2=A0 return 0;<br>
          }</p>
        <p><br>
        </p>
        <p><b><u>hello-tp.c</u></b><br>
        </p>
        <p>#define TRACEPOINT_CREATE_PROBES<br>
          #define TRACEPOINT_DEFINE<br>
          <br>
          #include "hello-tp.h"<br>
        </p>
        <p><br>
        </p>
        <p><b><u>hello-tp.h</u></b></p>
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
          =C2=A0=C2=A0=C2=A0 hello_world,<br>
          =C2=A0=C2=A0=C2=A0 my_first_tracepoint,<br>
          =C2=A0=C2=A0=C2=A0 TP_ARGS(<br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int, my_integer_arg,=
<br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char*, my_string_arg=
<br>
          =C2=A0=C2=A0=C2=A0 ),<br>
          =C2=A0=C2=A0=C2=A0 TP_FIELDS(<br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctf_string(my_string=
_field, my_string_arg)<br>
          =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctf_integer(int, my_=
integer_field, my_integer_arg)<br>
          =C2=A0=C2=A0=C2=A0 )<br>
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
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
lttng-dev mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:lttng-dev@lists.lttn=
g.org">lttng-dev@lists.lttng.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"http://lists.lttng.org/cgi-bin=
/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listi=
nfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Jonathan R. Julien
Efficios</pre>
  </body>
</html>

--------------090409020003060005000906--


--===============0582134284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0582134284==--
