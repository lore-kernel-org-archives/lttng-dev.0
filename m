From: Chidhu R <chid1989@gmail.com>
Subject: Re: Unable to include files in tracepoint provider
	header files
Date: Tue, 28 Apr 2015 11:33:19 -0700
Message-ID: <CAL1ZhOMf9jXRts-A1z_qHK4FwMW1SapwDj0wtEic4rHVK4YbZQ__15347.8778819137$1430246151$gmane$org@mail.gmail.com>
References: <CAL1ZhONvUcjoSky5+2nGbfzKoKNhNo6++zZfz_OmRAy++mC3vQ@mail.gmail.com>
 <904034208.39627.1430245628187.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1644734834=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <chid1989@gmail.com>) id 1YnAKc-0003Iu-O9
 for lttng-dev@lists.lttng.org; Tue, 28 Apr 2015 14:34:17 -0400
Received: by lbbqq2 with SMTP id qq2so2759296lbb.3
 for <lttng-dev@lists.lttng.org>; Tue, 28 Apr 2015 11:34:00 -0700 (PDT)
In-Reply-To: <904034208.39627.1430245628187.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1644734834==
Content-Type: multipart/alternative; boundary=089e012297042ec98c0514cd1bb5

--089e012297042ec98c0514cd1bb5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Great. Thank you. That worked.

On Tue, Apr 28, 2015 at 11:27 AM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ------------------------------
>
> Hello,
>
> In the example (hello) provided, I tried to print complex data types
> instead of usual ints or floats. My header file looks like this.
>
> #undef TRACEPOINT_PROVIDER
> #define TRACEPOINT_PROVIDER hello_world
>
> #undef TRACEPOINT_INCLUDE
> #define TRACEPOINT_INCLUDE "./hello-tp.h"
>
> #if !defined(HELLO_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
> #define HELLO_TP_H
>
> #include <lttng/tracepoint.h>
>
> #include "myinc.h"
>
> TRACEPOINT_EVENT(
>     hello_world,
>     my_first_tracepoint,
>     TP_ARGS(
>         const char*, my_string_arg
>     ),
>     TP_FIELDS(
>         ctf_integer(int, my_string_field, atoi(my_string_arg))
>     )
> )
>
> My include file looks like this (myinc.h)
> typedef unsigned char uuid_t;
>
> However, when I try to compile it using, lttng-gen-tp, I am getting the
> following error.
>
> root@mvm236:~/heelo_prog# lttng-gen-tp hello-tp.tp
> In file included from ././hello-tp.h:13:0,
>                  from /usr/include/lttng/ust-tracepoint-event.h:740,
>                  from /usr/include/lttng/tracepoint-event.h:58,
>                  from hello-tp.h:56,
>                  from hello-tp.c:7:
> ././myinc.h:1:1: error: expected expression before =E2=80=98typedef=E2=80=
=99
>
> Whatever I try to include, I am getting this error.
>
> Can you please help.
>
> Try adding include guards around your header myinc.h, e.g.:
>
> #ifndef _MYINC_H
> #define _MYINC_H
> typedef unsigned char uuid_t;
> #endif
>
> It will ensure the header content does not get included multiple
> times by ust-tracepoint-event.h.
>
> Thanks,
>
> Mathieu
>
>
> -- Chid
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--089e012297042ec98c0514cd1bb5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Great. Thank you. That worked.</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Tue, Apr 28, 2015 at 11:27 AM, Mathi=
eu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@effi=
cios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-family:time=
s new roman,new york,times,serif;font-size:12pt;color:#000000"><hr><div><di=
v class=3D"h5"><blockquote style=3D"border-left:2px solid #1010ff;margin-le=
ft:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;tex=
t-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><d=
iv dir=3D"ltr">Hello,<div><br></div><div>In the example (hello) provided, I=
 tried to print complex data types instead of usual ints or floats. My head=
er file looks like this.</div><div><br></div><div><div>#undef TRACEPOINT_PR=
OVIDER</div><div>#define TRACEPOINT_PROVIDER hello_world</div><div><br></di=
v><div>#undef TRACEPOINT_INCLUDE</div><div>#define TRACEPOINT_INCLUDE &quot=
;./hello-tp.h&quot;</div><div><br></div><div>#if !defined(HELLO_TP_H) || de=
fined(TRACEPOINT_HEADER_MULTI_READ)</div><div>#define HELLO_TP_H</div><div>=
<br></div><div>#include &lt;lttng/tracepoint.h&gt;</div><div><br></div><div=
>#include &quot;myinc.h&quot;</div><div><br></div><div>TRACEPOINT_EVENT(</d=
iv><div>=C2=A0 =C2=A0 hello_world,</div><div>=C2=A0 =C2=A0 my_first_tracepo=
int,</div><div>=C2=A0 =C2=A0 TP_ARGS(</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const char*, my_string_arg</div><div>=C2=A0 =C2=A0 ),</div><div>=C2=A0 =C2=
=A0 TP_FIELDS(</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctf_integer(int, my_st=
ring_field, atoi(my_string_arg))</div><div>=C2=A0 =C2=A0 )</div><div>)</div=
></div><div><br></div><div>My include file looks like this (myinc.h)</div><=
div>typedef unsigned char uuid_t;<br></div><div><br></div><div>However, whe=
n I try to compile it using, lttng-gen-tp, I am getting the following error=
.</div><div><br></div><div><div>root@mvm236:~/heelo_prog# lttng-gen-tp <a h=
ref=3D"http://hello-tp.tp" target=3D"_blank">hello-tp.tp</a><br></div><div>=
In file included from ././hello-tp.h:13:0,</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/lttng/ust-tracep=
oint-event.h:740,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from /usr/include/lttng/tracepoint-event.h:58,</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from hello-tp=
.h:56,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from hello-tp.c:7:</div><div>././myinc.h:1:1: error: expected express=
ion before =E2=80=98typedef=E2=80=99</div></div><div><br></div><div>Whateve=
r I try to include, I am getting this error.</div><div><br></div><div>Can y=
ou please help.</div></div></blockquote></div></div><div>Try adding include=
 guards around your header myinc.h, e.g.:<br></div><div><br></div><div>#ifn=
def _MYINC_H<br></div><div>#define _MYINC_H<br></div><div>typedef unsigned =
char uuid_t;<br></div><div>#endif<br></div><div><br></div><div>It will ensu=
re the header content does not get included multiple<br></div><div>times by=
 ust-tracepoint-event.h.<br></div><div><br></div><div>Thanks,<br></div><div=
><br></div><div>Mathieu<br></div><div><br></div><blockquote style=3D"border=
-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-we=
ight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Ar=
ial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div><br></div><div>-- Chid=
</div></div><br>_______________________________________________<br>lttng-de=
v mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_b=
lank">lttng-dev@lists.lttng.org</a><br><a href=3D"http://lists.lttng.org/cg=
i-bin/mailman/listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/=
cgi-bin/mailman/listinfo/lttng-dev</a><span class=3D"HOEnZb"><font color=3D=
"#888888"><br></font></span></blockquote><span class=3D"HOEnZb"><font color=
=3D"#888888"><div><br><br></div><div><br></div><div>-- <br></div><div><span=
 name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://=
www.efficios.com" target=3D"_blank">http://www.efficios.com</a><span name=
=3D"x"></span><br></div></font></span></div></div></blockquote></div><br></=
div>

--089e012297042ec98c0514cd1bb5--


--===============1644734834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1644734834==--
