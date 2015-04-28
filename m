From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Unable to include files in tracepoint provider
 header	files
Date: Tue, 28 Apr 2015 18:27:08 +0000 (UTC)
Message-ID: <904034208.39627.1430245628187.JavaMail.zimbra__2629.81026103279$1430245717$gmane$org@efficios.com>
References: <CAL1ZhONvUcjoSky5+2nGbfzKoKNhNo6++zZfz_OmRAy++mC3vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0048044889=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YnADx-0003FP-TL
 for lttng-dev@lists.lttng.org; Tue, 28 Apr 2015 14:27:24 -0400
In-Reply-To: <CAL1ZhONvUcjoSky5+2nGbfzKoKNhNo6++zZfz_OmRAy++mC3vQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Chidhu R <chid1989@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0048044889==
Content-Type: multipart/alternative;
	boundary="----=_Part_39626_1974021473.1430245628186"

------=_Part_39626_1974021473.1430245628186
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- Original Message -----

> Hello,

> In the example (hello) provided, I tried to print complex data types inst=
ead
> of usual ints or floats. My header file looks like this.

> #undef TRACEPOINT_PROVIDER
> #define TRACEPOINT_PROVIDER hello_world

> #undef TRACEPOINT_INCLUDE
> #define TRACEPOINT_INCLUDE "./hello-tp.h"

> #if !defined(HELLO_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
> #define HELLO_TP_H

> #include <lttng/tracepoint.h>

> #include "myinc.h"

> TRACEPOINT_EVENT(
> hello_world,
> my_first_tracepoint,
> TP_ARGS(
> const char*, my_string_arg
> ),
> TP_FIELDS(
> ctf_integer(int, my_string_field, atoi(my_string_arg))
> )
> )

> My include file looks like this (myinc.h)
> typedef unsigned char uuid_t;

> However, when I try to compile it using, lttng-gen-tp, I am getting the
> following error.

> root@mvm236:~/heelo_prog# lttng-gen-tp hello-tp.tp
> In file included from ././hello-tp.h:13:0,
> from /usr/include/lttng/ust-tracepoint-event.h:740,
> from /usr/include/lttng/tracepoint-event.h:58,
> from hello-tp.h:56,
> from hello-tp.c:7:
> ././myinc.h:1:1: error: expected expression before =E2=80=98typedef=E2=80=
=99

> Whatever I try to include, I am getting this error.

> Can you please help.

Try adding include guards around your header myinc.h, e.g.:=20

#ifndef _MYINC_H=20
#define _MYINC_H=20
typedef unsigned char uuid_t;=20
#endif=20

It will ensure the header content does not get included multiple=20
times by ust-tracepoint-event.h.=20

Thanks,=20

Mathieu=20

> -- Chid

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_39626_1974021473.1430245628186
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">Hello,<div><br></di=
v><div>In the example (hello) provided, I tried to print complex data types=
 instead of usual ints or floats. My header file looks like this.</div><div=
><br></div><div><div>#undef TRACEPOINT_PROVIDER</div><div>#define TRACEPOIN=
T_PROVIDER hello_world</div><div><br></div><div>#undef TRACEPOINT_INCLUDE</=
div><div>#define TRACEPOINT_INCLUDE "./hello-tp.h"</div><div><br></div><div=
>#if !defined(HELLO_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)</div><di=
v>#define HELLO_TP_H</div><div><br></div><div>#include &lt;lttng/tracepoint=
.h&gt;</div><div><br></div><div>#include "myinc.h"</div><div><br></div><div=
>TRACEPOINT_EVENT(</div><div>&nbsp; &nbsp; hello_world,</div><div>&nbsp; &n=
bsp; my_first_tracepoint,</div><div>&nbsp; &nbsp; TP_ARGS(</div><div>&nbsp;=
 &nbsp; &nbsp; &nbsp; const char*, my_string_arg</div><div>&nbsp; &nbsp; ),=
</div><div>&nbsp; &nbsp; TP_FIELDS(</div><div>&nbsp; &nbsp; &nbsp; &nbsp; c=
tf_integer(int, my_string_field, atoi(my_string_arg))</div><div>&nbsp; &nbs=
p; )</div><div>)</div></div><div><br></div><div>My include file looks like =
this (myinc.h)</div><div>typedef unsigned char uuid_t;<br></div><div><br></=
div><div>However, when I try to compile it using, lttng-gen-tp, I am gettin=
g the following error.</div><div><br></div><div><div>root@mvm236:~/heelo_pr=
og# lttng-gen-tp <a href=3D"http://hello-tp.tp" target=3D"_blank">hello-tp.=
tp</a><br data-mce-bogus=3D"1"></div><div>In file included from ././hello-t=
p.h:13:0,</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp;from /usr/include/lttng/ust-tracepoint-event.h:740,</div><div>&nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;from /usr/include/l=
ttng/tracepoint-event.h:58,</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp;from hello-tp.h:56,</div><div>&nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;from hello-tp.c:7:</div><div>././=
myinc.h:1:1: error: expected expression before =E2=80=98typedef=E2=80=99</d=
iv></div><div><br></div><div>Whatever I try to include, I am getting this e=
rror.</div><div><br></div><div>Can you please help.</div></div></blockquote=
><div>Try adding include guards around your header myinc.h, e.g.:<br></div>=
<div><br></div><div>#ifndef _MYINC_H<br></div><div>#define _MYINC_H<br></di=
v><div>typedef unsigned char uuid_t;<br></div><div>#endif<br></div><div><br=
></div><div>It will ensure the header content does not get included multipl=
e<br></div><div>times by ust-tracepoint-event.h.<br></div><div><br></div><d=
iv>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div><br></div><bl=
ockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-lef=
t:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;=
font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><d=
iv><br></div><div>-- Chid</div></div><br>__________________________________=
_____________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>htt=
p://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote><div=
><br><br></div><div><br></div><div>-- <br></div><div><span name=3D"x"></spa=
n>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com<span name=
=3D"x"></span><br></div></div></body></html>
------=_Part_39626_1974021473.1430245628186--


--===============0048044889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0048044889==--
