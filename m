From: Yonghong Yan <yanyh15@gmail.com>
Subject: Re: two tracepoints header files of one provider
Date: Mon, 7 Oct 2019 12:42:46 -0400
Message-ID: <CACJEY840r3D+SSGAkRnkAMpPJhQ7mUC2vj19cZFkVpgoxz1e8w__14061.134336383$1570466595$gmane$org@mail.gmail.com>
References: <CACJEY85GRrq=dHRfbnvuRqAgP_cF-ErWn4k3vK=DtCH6QvxSdQ@mail.gmail.com>
 <625499791.2728.1570465339442.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6277409960492892109=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 by lists.lttng.org (Postfix) with ESMTPS id 46n5rN13h5z17J9
 for <lttng-dev@lists.lttng.org>; Mon,  7 Oct 2019 12:43:00 -0400 (EDT)
Received: by mail-io1-xd34.google.com with SMTP id h144so30008627iof.7
 for <lttng-dev@lists.lttng.org>; Mon, 07 Oct 2019 09:42:59 -0700 (PDT)
In-Reply-To: <625499791.2728.1570465339442.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6277409960492892109==
Content-Type: multipart/alternative; boundary="00000000000092c700059454be48"

--00000000000092c700059454be48
Content-Type: text/plain; charset="UTF-8"

Thank you.

I got most. To confirm, I have two header files, each defines its own
tracepoint, they are from the same provider. The source files that use the
header files have its own #define TRACEPOINT_CREATE_PROBES and #define
TRACEPOINT_DEFINE. This won't work since two files have those defines. But
if I remove #define TRACEPOINT_CREATE_PROBES#define TRACEPOINT_DEFINE from
one of the two .c file, it should work.

tp_one.h file:

#undef TRACEPOINT_PROVIDER#define TRACEPOINT_PROVIDER hello_world
#undef TRACEPOINT_INCLUDE#define TRACEPOINT_INCLUDE "./tp_one.h"
#if !defined(_TP_ONE_H) ||
defined(TRACEPOINT_HEADER_MULTI_READ)#define _TP_ONE_H
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
    ))
#endif /* _TP_ONE_H */
#include <lttng/tracepoint-event.h>


tp_one.c

#define TRACEPOINT_CREATE_PROBES#define TRACEPOINT_DEFINE
#include "tp_one.h"


tp_two.h file:

#undef TRACEPOINT_PROVIDER#define TRACEPOINT_PROVIDER hello_world
#undef TRACEPOINT_INCLUDE#define TRACEPOINT_INCLUDE "./tp_two.h"
#if !defined(_TP_TWO_H) ||
defined(TRACEPOINT_HEADER_MULTI_READ)#define _TP_TWO_H
#include <lttng/tracepoint.h>
TRACEPOINT_EVENT(
    hello_world,
    my_second_tracepoint,
    TP_ARGS(
        int, my_integer_arg,
        char*, my_string_arg
    ),
    TP_FIELDS(
        ctf_string(my_string_field, my_string_arg)
        ctf_integer(int, my_integer_field, my_integer_arg)
    ))
#endif /* _TP_TWO_H */
#include <lttng/tracepoint-event.h>


tp_two.c

#define TRACEPOINT_CREATE_PROBES#define TRACEPOINT_DEFINE
#include "tp_two.h"


hello.c
use the two tracepoints defined in the two files.

To compile (compile file one by one).

gcc -o hello tp-one.c tp-two.c hello.c -llttng-ust -ldl




On Mon, Oct 7, 2019 at 12:22 PM Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

>
>
> ----- On Oct 7, 2019, at 9:59 AM, Yonghong Yan yanyh15@gmail.com wrote:
>
> > For lttng-ust, can I put the tracepoint definition in two files, but
> they use
> > the same provider.
>
> Based on the terminology here:
> https://lttng.org/docs/v2.10/#doc-tracing-your-own-user-application
>
> You need to have at most one instance of your tracepoint provider where
> the header is included with TRACEPOINT_CREATE_PROBES, and exactly one
> instance where TRACEPOINT_DEFINE is defined. (both can end up being within
> the same object if you wish).
>
> Then you can include your tracepoint provider header file at will across
> other compile units in your program. Just make sure none of
> TRACEPOINT_CREATE_PROBES nor TRACEPOINT_DEFINE are defined in those other
> compile units. You can therefore call tracepoints from a given probe from
> various compile units in your program.
>
> Hoping this helps clarifying things,
>
> Mathieu
>
> > Thank you.
> > Yonghong
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--00000000000092c700059454be48
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature=
" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div=
 dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Thank =
you.=C2=A0</div><div><br></div><div>I got most. To confirm, I have two head=
er files, each defines its own tracepoint, they are from the same provider.=
 The source files that use the header files have its own=C2=A0#define TRACE=
POINT_CREATE_PROBES and #define TRACEPOINT_DEFINE. This won&#39;t work sinc=
e two files have those defines. But if I remove=C2=A0#define TRACEPOINT_CRE=
ATE_PROBES#define TRACEPOINT_DEFINE from one of the two .c file, it should =
work.=C2=A0</div><div><br></div><div>tp_one.h file:</div><div><br></div><di=
v><pre class=3D"gmail-src" style=3D"margin-top:0px;margin-bottom:0px;paddin=
g:10px;border:0px;font-variant-numeric:inherit;font-variant-east-asian:inhe=
rit;font-stretch:inherit;font-size:10.5px;line-height:13.125px;font-family:=
&quot;Andale Mono WT&quot;,&quot;Andale Mono&quot;,&quot;Bitstream Vera San=
s Mono&quot;,&quot;Liberation Mono&quot;,&quot;Nimbus Mono L&quot;,&quot;Ub=
untu Mono&quot;,Monaco,Consolas,&quot;Lucida Console&quot;,&quot;Lucida San=
s Typewriter&quot;,&quot;Courier New&quot;,Courier,monospace;vertical-align=
:baseline;background-color:rgba(0,0,0,0.05);overflow-x:auto;color:rgb(26,26=
,26)"><span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;f=
ont-style:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;=
font-size:inherit;line-height:inherit;font-family:inherit;vertical-align:ba=
seline;color:rgb(153,153,153)">#undef TRACEPOINT_PROVIDER</span>
<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;font-s=
ize:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline=
;color:rgb(153,153,153)">#define TRACEPOINT_PROVIDER hello_world</span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;font-s=
ize:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline=
;color:rgb(153,153,153)">#undef TRACEPOINT_INCLUDE</span>
<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;font-s=
ize:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline=
;color:rgb(153,153,153)">#define TRACEPOINT_INCLUDE &quot;./tp_one.h&quot;<=
/span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;font-s=
ize:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline=
;color:rgb(153,153,153)">#if !defined(_TP_ONE_H) || defined(TRACEPOINT_HEAD=
ER_MULTI_READ)</span>
<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;font-s=
ize:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline=
;color:rgb(153,153,153)">#define _TP_ONE_H</span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;font-s=
ize:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline=
;color:rgb(153,153,153)">#include</span> <span class=3D"gmail-cpf" style=3D=
"margin:0px;padding:0px;border:0px;font:inherit;vertical-align:baseline">&l=
t;lttng/tracepoint.h&gt;</span><span class=3D"gmail-cp" style=3D"margin:0px=
;padding:0px;border:0px;font-style:italic;font-variant:inherit;font-weight:=
700;font-stretch:inherit;font-size:inherit;line-height:inherit;font-family:=
inherit;vertical-align:baseline;color:rgb(153,153,153)"></span>

<span class=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;font:inh=
erit;vertical-align:baseline">TRACEPOINT_EVENT</span><span class=3D"gmail-p=
" style=3D"margin:0px;padding:0px;border:0px;font:inherit;vertical-align:ba=
seline">(</span>
    <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;font=
:inherit;vertical-align:baseline">hello_world</span><span class=3D"gmail-p"=
 style=3D"margin:0px;padding:0px;border:0px;font:inherit;vertical-align:bas=
eline">,</span>
    <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;font=
:inherit;vertical-align:baseline">my_first_tracepoint</span><span class=3D"=
gmail-p" style=3D"margin:0px;padding:0px;border:0px;font:inherit;vertical-a=
lign:baseline">,</span>
    <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;font=
:inherit;vertical-align:baseline">TP_ARGS</span><span class=3D"gmail-p" sty=
le=3D"margin:0px;padding:0px;border:0px;font:inherit;vertical-align:baselin=
e">(</span>
        <span class=3D"gmail-kt" style=3D"margin:0px;padding:0px;border:0px=
;font-style:inherit;font-variant:inherit;font-weight:700;font-stretch:inher=
it;font-size:inherit;line-height:inherit;font-family:inherit;vertical-align=
:baseline;color:rgb(68,85,136)">int</span><span class=3D"gmail-p" style=3D"=
margin:0px;padding:0px;border:0px;font:inherit;vertical-align:baseline">,</=
span> <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;fo=
nt:inherit;vertical-align:baseline">my_integer_arg</span><span class=3D"gma=
il-p" style=3D"margin:0px;padding:0px;border:0px;font:inherit;vertical-alig=
n:baseline">,</span>
        <span class=3D"gmail-kt" style=3D"margin:0px;padding:0px;border:0px=
;font-style:inherit;font-variant:inherit;font-weight:700;font-stretch:inher=
it;font-size:inherit;line-height:inherit;font-family:inherit;vertical-align=
:baseline;color:rgb(68,85,136)">char</span><span class=3D"gmail-o" style=3D=
"margin:0px;padding:0px;border:0px;font-style:inherit;font-variant:inherit;=
font-weight:700;font-stretch:inherit;font-size:inherit;line-height:inherit;=
font-family:inherit;vertical-align:baseline;color:rgb(0,0,0)">*</span><span=
 class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0px;font:inherit;=
vertical-align:baseline">,</span> <span class=3D"gmail-n" style=3D"margin:0=
px;padding:0px;border:0px;font:inherit;vertical-align:baseline">my_string_a=
rg</span>
    <span class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0px;font=
:inherit;vertical-align:baseline">),</span>
    <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;font=
:inherit;vertical-align:baseline">TP_FIELDS</span><span class=3D"gmail-p" s=
tyle=3D"margin:0px;padding:0px;border:0px;font:inherit;vertical-align:basel=
ine">(</span>
        <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;=
font:inherit;vertical-align:baseline">ctf_string</span><span class=3D"gmail=
-p" style=3D"margin:0px;padding:0px;border:0px;font:inherit;vertical-align:=
baseline">(</span><span class=3D"gmail-n" style=3D"margin:0px;padding:0px;b=
order:0px;font:inherit;vertical-align:baseline">my_string_field</span><span=
 class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0px;font:inherit;=
vertical-align:baseline">,</span> <span class=3D"gmail-n" style=3D"margin:0=
px;padding:0px;border:0px;font:inherit;vertical-align:baseline">my_string_a=
rg</span><span class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0px=
;font:inherit;vertical-align:baseline">)</span>
        <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;=
font:inherit;vertical-align:baseline">ctf_integer</span><span class=3D"gmai=
l-p" style=3D"margin:0px;padding:0px;border:0px;font:inherit;vertical-align=
:baseline">(</span><span class=3D"gmail-kt" style=3D"margin:0px;padding:0px=
;border:0px;font-style:inherit;font-variant:inherit;font-weight:700;font-st=
retch:inherit;font-size:inherit;line-height:inherit;font-family:inherit;ver=
tical-align:baseline;color:rgb(68,85,136)">int</span><span class=3D"gmail-p=
" style=3D"margin:0px;padding:0px;border:0px;font:inherit;vertical-align:ba=
seline">,</span> <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;bo=
rder:0px;font:inherit;vertical-align:baseline">my_integer_field</span><span=
 class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0px;font:inherit;=
vertical-align:baseline">,</span> <span class=3D"gmail-n" style=3D"margin:0=
px;padding:0px;border:0px;font:inherit;vertical-align:baseline">my_integer_=
arg</span><span class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0p=
x;font:inherit;vertical-align:baseline">)</span>
    <span class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0px;font=
:inherit;vertical-align:baseline">)</span>
<span class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0px;font:inh=
erit;vertical-align:baseline">)</span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;font-s=
ize:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline=
;color:rgb(153,153,153)">#endif </span><span class=3D"gmail-cm" style=3D"ma=
rgin:0px;padding:0px;border:0px;font-style:italic;font-variant:inherit;font=
-weight:inherit;font-stretch:inherit;font-size:inherit;line-height:inherit;=
font-family:inherit;vertical-align:baseline;color:rgb(153,153,136)">/* _TP_=
ONE_H */</span><span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;bor=
der:0px;font-style:italic;font-variant:inherit;font-weight:700;font-stretch=
:inherit;font-size:inherit;line-height:inherit;font-family:inherit;vertical=
-align:baseline;color:rgb(153,153,153)"></span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;font-s=
ize:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline=
;color:rgb(153,153,153)">#include</span> <span class=3D"gmail-cpf" style=3D=
"margin:0px;padding:0px;border:0px;font:inherit;vertical-align:baseline">&l=
t;lttng/tracepoint-event.h&gt;</span></pre></div><div dir=3D"ltr"><br></div=
><div dir=3D"ltr"><div class=3D"gmail-title" style=3D"margin:0px;padding:3p=
x 10px 5px;border:0px;font-variant-numeric:inherit;font-variant-east-asian:=
inherit;font-stretch:inherit;font-size:10.5px;line-height:inherit;font-fami=
ly:&quot;Open Sans&quot;,Frutiger,&quot;Frutiger Linotype&quot;,Univers,Cal=
ibri,&quot;Gill Sans&quot;,&quot;Gill Sans MT&quot;,&quot;Myriad Pro&quot;,=
Myriad,&quot;DejaVu Sans Condensed&quot;,&quot;Liberation Sans&quot;,&quot;=
Nimbus Sans L&quot;,Tahoma,Geneva,&quot;Helvetica Neue&quot;,Helvetica,Aria=
l,sans-serif;vertical-align:baseline;background-color:rgb(218,224,224);colo=
r:rgb(26,26,26)"><p style=3D"margin:0px;padding:0px;border:0px;font-style:i=
nherit;font-variant:inherit;font-weight:inherit;font-stretch:inherit;font-s=
ize:11.2px;line-height:16.8px;font-family:inherit;vertical-align:baseline;c=
olor:rgb(86,101,102)"><code class=3D"gmail-file" style=3D"margin:0px 1px;pa=
dding:2px 0px;border:0px;font-style:inherit;font-variant:inherit;font-weigh=
t:inherit;font-stretch:inherit;font-size:10.08px;line-height:inherit;font-f=
amily:&quot;Andale Mono WT&quot;,&quot;Andale Mono&quot;,&quot;Bitstream Ve=
ra Sans Mono&quot;,&quot;Liberation Mono&quot;,&quot;Nimbus Mono L&quot;,&q=
uot;Ubuntu Mono&quot;,Monaco,Consolas,&quot;Lucida Console&quot;,&quot;Luci=
da Sans Typewriter&quot;,&quot;Courier New&quot;,Courier,monospace;vertical=
-align:baseline;background-color:transparent;white-space:nowrap">tp_one.c</=
code></p></div><pre class=3D"gmail-src" style=3D"margin-top:0px;margin-bott=
om:0px;padding:10px;border:0px;font-variant-numeric:inherit;font-variant-ea=
st-asian:inherit;font-stretch:inherit;font-size:10.5px;line-height:13.125px=
;font-family:&quot;Andale Mono WT&quot;,&quot;Andale Mono&quot;,&quot;Bitst=
ream Vera Sans Mono&quot;,&quot;Liberation Mono&quot;,&quot;Nimbus Mono L&q=
uot;,&quot;Ubuntu Mono&quot;,Monaco,Consolas,&quot;Lucida Console&quot;,&qu=
ot;Lucida Sans Typewriter&quot;,&quot;Courier New&quot;,Courier,monospace;v=
ertical-align:baseline;background-color:rgba(0,0,0,0.05);overflow-x:auto;co=
lor:rgb(26,26,26)"><span class=3D"gmail-cp" style=3D"margin:0px;padding:0px=
;border:0px;font-style:italic;font-variant:inherit;font-weight:700;font-str=
etch:inherit;font-size:inherit;line-height:inherit;font-family:inherit;vert=
ical-align:baseline;color:rgb(153,153,153)">#define TRACEPOINT_CREATE_PROBE=
S</span>
<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;font-s=
ize:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline=
;color:rgb(153,153,153)">#define TRACEPOINT_DEFINE</span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;font-s=
ize:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline=
;color:rgb(153,153,153)">#include</span> <span class=3D"gmail-cpf" style=3D=
"margin:0px;padding:0px;border:0px;font:inherit;vertical-align:baseline">&q=
uot;tp_one.h&quot;</span></pre></div><div dir=3D"ltr"><br></div><div dir=3D=
"ltr"><div>tp_two.h file:</div><div><br></div><div><pre class=3D"gmail-src"=
 style=3D"margin-top:0px;margin-bottom:0px;padding:10px;border:0px;font-var=
iant-numeric:inherit;font-variant-east-asian:inherit;font-stretch:inherit;f=
ont-size:10.5px;line-height:13.125px;font-family:&quot;Andale Mono WT&quot;=
,&quot;Andale Mono&quot;,&quot;Bitstream Vera Sans Mono&quot;,&quot;Liberat=
ion Mono&quot;,&quot;Nimbus Mono L&quot;,&quot;Ubuntu Mono&quot;,Monaco,Con=
solas,&quot;Lucida Console&quot;,&quot;Lucida Sans Typewriter&quot;,&quot;C=
ourier New&quot;,Courier,monospace;vertical-align:baseline;background-color=
:rgba(0,0,0,0.05);overflow-x:auto;color:rgb(26,26,26)"><span class=3D"gmail=
-cp" style=3D"margin:0px;padding:0px;border:0px;font-style:italic;font-vari=
ant:inherit;font-weight:700;font-stretch:inherit;font-size:inherit;line-hei=
ght:inherit;font-family:inherit;vertical-align:baseline;color:rgb(153,153,1=
53)">#undef TRACEPOINT_PROVIDER</span>
<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;font-s=
ize:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline=
;color:rgb(153,153,153)">#define TRACEPOINT_PROVIDER hello_world</span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;font-s=
ize:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline=
;color:rgb(153,153,153)">#undef TRACEPOINT_INCLUDE</span>
<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;font-s=
ize:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline=
;color:rgb(153,153,153)">#define TRACEPOINT_INCLUDE &quot;./tp_two.h&quot;<=
/span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;font-s=
ize:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline=
;color:rgb(153,153,153)">#if !defined(_TP_TWO_H) || defined(TRACEPOINT_HEAD=
ER_MULTI_READ)</span>
<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;font-s=
ize:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline=
;color:rgb(153,153,153)">#define _TP_TWO_H</span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;font-s=
ize:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline=
;color:rgb(153,153,153)">#include</span> <span class=3D"gmail-cpf" style=3D=
"margin:0px;padding:0px;border:0px;font:inherit;vertical-align:baseline">&l=
t;lttng/tracepoint.h&gt;</span><span class=3D"gmail-cp" style=3D"margin:0px=
;padding:0px;border:0px;font-style:italic;font-variant:inherit;font-weight:=
700;font-stretch:inherit;font-size:inherit;line-height:inherit;font-family:=
inherit;vertical-align:baseline;color:rgb(153,153,153)"></span>

<span class=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;font:inh=
erit;vertical-align:baseline">TRACEPOINT_EVENT</span><span class=3D"gmail-p=
" style=3D"margin:0px;padding:0px;border:0px;font:inherit;vertical-align:ba=
seline">(</span>
    <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;font=
:inherit;vertical-align:baseline">hello_world</span><span class=3D"gmail-p"=
 style=3D"margin:0px;padding:0px;border:0px;font:inherit;vertical-align:bas=
eline">,</span>
    <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;font=
:inherit;vertical-align:baseline">my_second_tracepoint</span><span class=3D=
"gmail-p" style=3D"margin:0px;padding:0px;border:0px;font:inherit;vertical-=
align:baseline">,</span>
    <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;font=
:inherit;vertical-align:baseline">TP_ARGS</span><span class=3D"gmail-p" sty=
le=3D"margin:0px;padding:0px;border:0px;font:inherit;vertical-align:baselin=
e">(</span>
        <span class=3D"gmail-kt" style=3D"margin:0px;padding:0px;border:0px=
;font-style:inherit;font-variant:inherit;font-weight:700;font-stretch:inher=
it;font-size:inherit;line-height:inherit;font-family:inherit;vertical-align=
:baseline;color:rgb(68,85,136)">int</span><span class=3D"gmail-p" style=3D"=
margin:0px;padding:0px;border:0px;font:inherit;vertical-align:baseline">,</=
span> <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;fo=
nt:inherit;vertical-align:baseline">my_integer_arg</span><span class=3D"gma=
il-p" style=3D"margin:0px;padding:0px;border:0px;font:inherit;vertical-alig=
n:baseline">,</span>
        <span class=3D"gmail-kt" style=3D"margin:0px;padding:0px;border:0px=
;font-style:inherit;font-variant:inherit;font-weight:700;font-stretch:inher=
it;font-size:inherit;line-height:inherit;font-family:inherit;vertical-align=
:baseline;color:rgb(68,85,136)">char</span><span class=3D"gmail-o" style=3D=
"margin:0px;padding:0px;border:0px;font-style:inherit;font-variant:inherit;=
font-weight:700;font-stretch:inherit;font-size:inherit;line-height:inherit;=
font-family:inherit;vertical-align:baseline;color:rgb(0,0,0)">*</span><span=
 class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0px;font:inherit;=
vertical-align:baseline">,</span> <span class=3D"gmail-n" style=3D"margin:0=
px;padding:0px;border:0px;font:inherit;vertical-align:baseline">my_string_a=
rg</span>
    <span class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0px;font=
:inherit;vertical-align:baseline">),</span>
    <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;font=
:inherit;vertical-align:baseline">TP_FIELDS</span><span class=3D"gmail-p" s=
tyle=3D"margin:0px;padding:0px;border:0px;font:inherit;vertical-align:basel=
ine">(</span>
        <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;=
font:inherit;vertical-align:baseline">ctf_string</span><span class=3D"gmail=
-p" style=3D"margin:0px;padding:0px;border:0px;font:inherit;vertical-align:=
baseline">(</span><span class=3D"gmail-n" style=3D"margin:0px;padding:0px;b=
order:0px;font:inherit;vertical-align:baseline">my_string_field</span><span=
 class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0px;font:inherit;=
vertical-align:baseline">,</span> <span class=3D"gmail-n" style=3D"margin:0=
px;padding:0px;border:0px;font:inherit;vertical-align:baseline">my_string_a=
rg</span><span class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0px=
;font:inherit;vertical-align:baseline">)</span>
        <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;=
font:inherit;vertical-align:baseline">ctf_integer</span><span class=3D"gmai=
l-p" style=3D"margin:0px;padding:0px;border:0px;font:inherit;vertical-align=
:baseline">(</span><span class=3D"gmail-kt" style=3D"margin:0px;padding:0px=
;border:0px;font-style:inherit;font-variant:inherit;font-weight:700;font-st=
retch:inherit;font-size:inherit;line-height:inherit;font-family:inherit;ver=
tical-align:baseline;color:rgb(68,85,136)">int</span><span class=3D"gmail-p=
" style=3D"margin:0px;padding:0px;border:0px;font:inherit;vertical-align:ba=
seline">,</span> <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;bo=
rder:0px;font:inherit;vertical-align:baseline">my_integer_field</span><span=
 class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0px;font:inherit;=
vertical-align:baseline">,</span> <span class=3D"gmail-n" style=3D"margin:0=
px;padding:0px;border:0px;font:inherit;vertical-align:baseline">my_integer_=
arg</span><span class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0p=
x;font:inherit;vertical-align:baseline">)</span>
    <span class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0px;font=
:inherit;vertical-align:baseline">)</span>
<span class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0px;font:inh=
erit;vertical-align:baseline">)</span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;font-s=
ize:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline=
;color:rgb(153,153,153)">#endif </span><span class=3D"gmail-cm" style=3D"ma=
rgin:0px;padding:0px;border:0px;font-style:italic;font-variant:inherit;font=
-weight:inherit;font-stretch:inherit;font-size:inherit;line-height:inherit;=
font-family:inherit;vertical-align:baseline;color:rgb(153,153,136)">/* _TP_=
TWO_H */</span><span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;bor=
der:0px;font-style:italic;font-variant:inherit;font-weight:700;font-stretch=
:inherit;font-size:inherit;line-height:inherit;font-family:inherit;vertical=
-align:baseline;color:rgb(153,153,153)"></span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;font-s=
ize:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline=
;color:rgb(153,153,153)">#include</span> <span class=3D"gmail-cpf" style=3D=
"margin:0px;padding:0px;border:0px;font:inherit;vertical-align:baseline">&l=
t;lttng/tracepoint-event.h&gt;</span></pre></div><div dir=3D"ltr"><br></div=
><div dir=3D"ltr"><div class=3D"gmail-title" style=3D"margin:0px;padding:3p=
x 10px 5px;border:0px;font-variant-numeric:inherit;font-variant-east-asian:=
inherit;font-stretch:inherit;font-size:10.5px;line-height:inherit;font-fami=
ly:&quot;Open Sans&quot;,Frutiger,&quot;Frutiger Linotype&quot;,Univers,Cal=
ibri,&quot;Gill Sans&quot;,&quot;Gill Sans MT&quot;,&quot;Myriad Pro&quot;,=
Myriad,&quot;DejaVu Sans Condensed&quot;,&quot;Liberation Sans&quot;,&quot;=
Nimbus Sans L&quot;,Tahoma,Geneva,&quot;Helvetica Neue&quot;,Helvetica,Aria=
l,sans-serif;vertical-align:baseline;background-color:rgb(218,224,224);colo=
r:rgb(26,26,26)"><p style=3D"margin:0px;padding:0px;border:0px;font-style:i=
nherit;font-variant:inherit;font-weight:inherit;font-stretch:inherit;font-s=
ize:11.2px;line-height:16.8px;font-family:inherit;vertical-align:baseline;c=
olor:rgb(86,101,102)"><code class=3D"gmail-file" style=3D"margin:0px 1px;pa=
dding:2px 0px;border:0px;font-style:inherit;font-variant:inherit;font-weigh=
t:inherit;font-stretch:inherit;font-size:10.08px;line-height:inherit;font-f=
amily:&quot;Andale Mono WT&quot;,&quot;Andale Mono&quot;,&quot;Bitstream Ve=
ra Sans Mono&quot;,&quot;Liberation Mono&quot;,&quot;Nimbus Mono L&quot;,&q=
uot;Ubuntu Mono&quot;,Monaco,Consolas,&quot;Lucida Console&quot;,&quot;Luci=
da Sans Typewriter&quot;,&quot;Courier New&quot;,Courier,monospace;vertical=
-align:baseline;background-color:transparent;white-space:nowrap">tp_two.c</=
code></p></div><pre class=3D"gmail-src" style=3D"margin-top:0px;margin-bott=
om:0px;padding:10px;border:0px;font-variant-numeric:inherit;font-variant-ea=
st-asian:inherit;font-stretch:inherit;font-size:10.5px;line-height:13.125px=
;font-family:&quot;Andale Mono WT&quot;,&quot;Andale Mono&quot;,&quot;Bitst=
ream Vera Sans Mono&quot;,&quot;Liberation Mono&quot;,&quot;Nimbus Mono L&q=
uot;,&quot;Ubuntu Mono&quot;,Monaco,Consolas,&quot;Lucida Console&quot;,&qu=
ot;Lucida Sans Typewriter&quot;,&quot;Courier New&quot;,Courier,monospace;v=
ertical-align:baseline;background-color:rgba(0,0,0,0.05);overflow-x:auto;co=
lor:rgb(26,26,26)"><span class=3D"gmail-cp" style=3D"margin:0px;padding:0px=
;border:0px;font-style:italic;font-variant:inherit;font-weight:700;font-str=
etch:inherit;font-size:inherit;line-height:inherit;font-family:inherit;vert=
ical-align:baseline;color:rgb(153,153,153)">#define TRACEPOINT_CREATE_PROBE=
S</span>
<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;font-s=
ize:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline=
;color:rgb(153,153,153)">#define TRACEPOINT_DEFINE</span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-stretch:inherit;font-s=
ize:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline=
;color:rgb(153,153,153)">#include</span> <span class=3D"gmail-cpf" style=3D=
"margin:0px;padding:0px;border:0px;font:inherit;vertical-align:baseline">&q=
uot;tp_two.h&quot;</span></pre></div><div dir=3D"ltr"></div></div></div></d=
iv></div></div></div></div></div></div><div><br></div><div>hello.c</div><di=
v>use the two tracepoints defined in the two files.=C2=A0</div><div><br></d=
iv><div>To compile (compile file one by one).=C2=A0</div><pre class=3D"gmai=
l-commands" style=3D"margin-top:0px;margin-bottom:0px;padding:0px;border:0p=
x;font-variant-numeric:inherit;font-variant-east-asian:inherit;font-stretch=
:inherit;font-size:10.5px;line-height:13.125px;font-family:&quot;Andale Mon=
o WT&quot;,&quot;Andale Mono&quot;,&quot;Bitstream Vera Sans Mono&quot;,&qu=
ot;Liberation Mono&quot;,&quot;Nimbus Mono L&quot;,&quot;Ubuntu Mono&quot;,=
Monaco,Consolas,&quot;Lucida Console&quot;,&quot;Lucida Sans Typewriter&quo=
t;,&quot;Courier New&quot;,Courier,monospace;vertical-align:baseline;backgr=
ound-color:transparent;overflow-x:auto;color:rgba(0,0,0,0.75)">gcc -o hello=
 tp-one.c tp-two.c hello.c -llttng-ust -ldl</pre><pre class=3D"gmail-comman=
ds" style=3D"margin-top:0px;margin-bottom:0px;padding:0px;border:0px;font-v=
ariant-numeric:inherit;font-variant-east-asian:inherit;font-stretch:inherit=
;font-size:10.5px;line-height:13.125px;font-family:&quot;Andale Mono WT&quo=
t;,&quot;Andale Mono&quot;,&quot;Bitstream Vera Sans Mono&quot;,&quot;Liber=
ation Mono&quot;,&quot;Nimbus Mono L&quot;,&quot;Ubuntu Mono&quot;,Monaco,C=
onsolas,&quot;Lucida Console&quot;,&quot;Lucida Sans Typewriter&quot;,&quot=
;Courier New&quot;,Courier,monospace;vertical-align:baseline;background-col=
or:transparent;overflow-x:auto;color:rgba(0,0,0,0.75)"><br></pre><pre class=
=3D"gmail-commands" style=3D"margin-top:0px;margin-bottom:0px;padding:0px;b=
order:0px;font-variant-numeric:inherit;font-variant-east-asian:inherit;font=
-stretch:inherit;font-size:10.5px;line-height:13.125px;font-family:&quot;An=
dale Mono WT&quot;,&quot;Andale Mono&quot;,&quot;Bitstream Vera Sans Mono&q=
uot;,&quot;Liberation Mono&quot;,&quot;Nimbus Mono L&quot;,&quot;Ubuntu Mon=
o&quot;,Monaco,Consolas,&quot;Lucida Console&quot;,&quot;Lucida Sans Typewr=
iter&quot;,&quot;Courier New&quot;,Courier,monospace;vertical-align:baselin=
e;background-color:transparent;overflow-x:auto;color:rgba(0,0,0,0.75)"><br>=
</pre><pre class=3D"gmail-commands" style=3D"margin-top:0px;margin-bottom:0=
px;padding:0px;border:0px;font-variant-numeric:inherit;font-variant-east-as=
ian:inherit;font-stretch:inherit;font-size:10.5px;line-height:13.125px;font=
-family:&quot;Andale Mono WT&quot;,&quot;Andale Mono&quot;,&quot;Bitstream =
Vera Sans Mono&quot;,&quot;Liberation Mono&quot;,&quot;Nimbus Mono L&quot;,=
&quot;Ubuntu Mono&quot;,Monaco,Consolas,&quot;Lucida Console&quot;,&quot;Lu=
cida Sans Typewriter&quot;,&quot;Courier New&quot;,Courier,monospace;vertic=
al-align:baseline;background-color:transparent;overflow-x:auto;color:rgba(0=
,0,0,0.75)"><br></pre><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Mon, Oct 7, 2019 at 12:22 PM Mathieu Desnoyers &lt;<a href=
=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><b=
r>
<br>
----- On Oct 7, 2019, at 9:59 AM, Yonghong Yan <a href=3D"mailto:yanyh15@gm=
ail.com" target=3D"_blank">yanyh15@gmail.com</a> wrote:<br>
<br>
&gt; For lttng-ust, can I put the tracepoint definition in two files, but t=
hey use<br>
&gt; the same provider.<br>
<br>
Based on the terminology here: <a href=3D"https://lttng.org/docs/v2.10/#doc=
-tracing-your-own-user-application" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lttng.org/docs/v2.10/#doc-tracing-your-own-user-application</a><br>
<br>
You need to have at most one instance of your tracepoint provider where<br>
the header is included with TRACEPOINT_CREATE_PROBES, and exactly one<br>
instance where TRACEPOINT_DEFINE is defined. (both can end up being within<=
br>
the same object if you wish).<br>
<br>
Then you can include your tracepoint provider header file at will across<br=
>
other compile units in your program. Just make sure none of <br>
TRACEPOINT_CREATE_PROBES nor TRACEPOINT_DEFINE are defined in those other<b=
r>
compile units. You can therefore call tracepoints from a given probe from<b=
r>
various compile units in your program.<br>
<br>
Hoping this helps clarifying things,<br>
<br>
Mathieu<br>
<br>
&gt; Thank you.<br>
&gt; Yonghong<br>
<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
</blockquote></div></div>

--00000000000092c700059454be48--

--===============6277409960492892109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6277409960492892109==--
