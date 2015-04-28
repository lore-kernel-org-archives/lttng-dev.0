From: Chidhu R <chid1989@gmail.com>
Subject: Unable to include files in tracepoint provider header
	files
Date: Tue, 28 Apr 2015 11:13:09 -0700
Message-ID: <CAL1ZhONvUcjoSky5+2nGbfzKoKNhNo6++zZfz_OmRAy++mC3vQ__34887.3548479334$1430244930$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1357911170=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f52.google.com ([209.85.215.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <chid1989@gmail.com>) id 1YnA16-00039w-Qu
 for lttng-dev@lists.lttng.org; Tue, 28 Apr 2015 14:14:03 -0400
Received: by lagv1 with SMTP id v1so2287512lag.3
 for <lttng-dev@lists.lttng.org>; Tue, 28 Apr 2015 11:13:50 -0700 (PDT)
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

--===============1357911170==
Content-Type: multipart/alternative; boundary=001a11c235dc1009270514ccd376

--001a11c235dc1009270514ccd376
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

In the example (hello) provided, I tried to print complex data types
instead of usual ints or floats. My header file looks like this.

#undef TRACEPOINT_PROVIDER
#define TRACEPOINT_PROVIDER hello_world

#undef TRACEPOINT_INCLUDE
#define TRACEPOINT_INCLUDE "./hello-tp.h"

#if !defined(HELLO_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
#define HELLO_TP_H

#include <lttng/tracepoint.h>

#include "myinc.h"

TRACEPOINT_EVENT(
    hello_world,
    my_first_tracepoint,
    TP_ARGS(
        const char*, my_string_arg
    ),
    TP_FIELDS(
        ctf_integer(int, my_string_field, atoi(my_string_arg))
    )
)

My include file looks like this (myinc.h)
typedef unsigned char uuid_t;

However, when I try to compile it using, lttng-gen-tp, I am getting the
following error.

root@mvm236:~/heelo_prog# lttng-gen-tp hello-tp.tp
In file included from ././hello-tp.h:13:0,
                 from /usr/include/lttng/ust-tracepoint-event.h:740,
                 from /usr/include/lttng/tracepoint-event.h:58,
                 from hello-tp.h:56,
                 from hello-tp.c:7:
././myinc.h:1:1: error: expected expression before =E2=80=98typedef=E2=80=
=99

Whatever I try to include, I am getting this error.

Can you please help.

-- Chid

--001a11c235dc1009270514ccd376
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>In the example (hello) provided,=
 I tried to print complex data types instead of usual ints or floats. My he=
ader file looks like this.</div><div><br></div><div><div>#undef TRACEPOINT_=
PROVIDER</div><div>#define TRACEPOINT_PROVIDER hello_world</div><div><br></=
div><div>#undef TRACEPOINT_INCLUDE</div><div>#define TRACEPOINT_INCLUDE &qu=
ot;./hello-tp.h&quot;</div><div><br></div><div>#if !defined(HELLO_TP_H) || =
defined(TRACEPOINT_HEADER_MULTI_READ)</div><div>#define HELLO_TP_H</div><di=
v><br></div><div>#include &lt;lttng/tracepoint.h&gt;</div><div><br></div><d=
iv>#include &quot;myinc.h&quot;</div><div><br></div><div>TRACEPOINT_EVENT(<=
/div><div>=C2=A0 =C2=A0 hello_world,</div><div>=C2=A0 =C2=A0 my_first_trace=
point,</div><div>=C2=A0 =C2=A0 TP_ARGS(</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const char*, my_string_arg</div><div>=C2=A0 =C2=A0 ),</div><div>=C2=A0 =
=C2=A0 TP_FIELDS(</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctf_integer(int, my=
_string_field, atoi(my_string_arg))</div><div>=C2=A0 =C2=A0 )</div><div>)</=
div></div><div><br></div><div>My include file looks like this (myinc.h)</di=
v><div>typedef unsigned char uuid_t;<br></div><div><br></div><div>However, =
when I try to compile it using, lttng-gen-tp, I am getting the following er=
ror.</div><div><br></div><div><div>root@mvm236:~/heelo_prog# lttng-gen-tp <=
a href=3D"http://hello-tp.tp">hello-tp.tp</a></div><div>In file included fr=
om ././hello-tp.h:13:0,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0from /usr/include/lttng/ust-tracepoint-event.h:740,</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from =
/usr/include/lttng/tracepoint-event.h:58,</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from hello-tp.h:56,</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from hello-tp.c:=
7:</div><div>././myinc.h:1:1: error: expected expression before =E2=80=98ty=
pedef=E2=80=99</div></div><div><br></div><div>Whatever I try to include, I =
am getting this error.</div><div><br></div><div>Can you please help.</div><=
div><br></div><div>-- Chid</div></div>

--001a11c235dc1009270514ccd376--


--===============1357911170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1357911170==--
