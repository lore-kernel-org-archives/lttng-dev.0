From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: two tracepoints header files of one provider
Date: Mon, 7 Oct 2019 15:53:20 -0400 (EDT)
Message-ID: <1474014060.3818.1570478000537.JavaMail.zimbra__2330.72172138549$1570478023$gmane$org@efficios.com>
References: <CACJEY85GRrq=dHRfbnvuRqAgP_cF-ErWn4k3vK=DtCH6QvxSdQ@mail.gmail.com>
 <625499791.2728.1570465339442.JavaMail.zimbra@efficios.com>
 <CACJEY840r3D+SSGAkRnkAMpPJhQ7mUC2vj19cZFkVpgoxz1e8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8298902561311741112=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46nB4174V8z17Qf
 for <lttng-dev@lists.lttng.org>; Mon,  7 Oct 2019 15:53:21 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 664B126833E
 for <lttng-dev@lists.lttng.org>; Mon,  7 Oct 2019 15:53:21 -0400 (EDT)
In-Reply-To: <CACJEY840r3D+SSGAkRnkAMpPJhQ7mUC2vj19cZFkVpgoxz1e8w@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yonghong Yan <yanyh15@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8298902561311741112==
Content-Type: multipart/alternative;
	boundary="=_668692e4-bc7c-4a45-9bc5-9a7dccef048a"

--=_668692e4-bc7c-4a45-9bc5-9a7dccef048a
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Oct 7, 2019, at 12:42 PM, Yonghong Yan <yanyh15@gmail.com> wrote: 

> Thank you.

> I got most. To confirm, I have two header files, each defines its own
> tracepoint, they are from the same provider. The source files that use the
> header files have its own #define TRACEPOINT_CREATE_PROBES and #define
> TRACEPOINT_DEFINE. This won't work since two files have those defines. But if I
> remove #define TRACEPOINT_CREATE_PROBES#define TRACEPOINT_DEFINE from one of
> the two .c file, it should work.

The example below is bogus. 

Each of your tp_one.h and tp_two.h should have its own provider name, not "hello_world" for both. 

You should _only_ have a single header implementation file per provider name within an application. 

In my previous email, I was only refering to a case where you would want to define+create probes within 
a compile unit, and use the tracepoints (call them) from various other compile units in the program. 

Thanks, 

Mathieu 

> tp_one.h file:

> #undef TRACEPOINT_PROVIDER #define TRACEPOINT_PROVIDER hello_world #undef
> TRACEPOINT_INCLUDE #define TRACEPOINT_INCLUDE "./tp_one.h" #if
> !defined(_TP_ONE_H) || defined(TRACEPOINT_HEADER_MULTI_READ) #define _TP_ONE_H
> #include <lttng/tracepoint.h> TRACEPOINT_EVENT ( hello_world ,
> my_first_tracepoint , TP_ARGS ( int , my_integer_arg , char * , my_string_arg
> ), TP_FIELDS ( ctf_string ( my_string_field , my_string_arg ) ctf_integer ( int
> , my_integer_field , my_integer_arg ) ) ) #endif /* _TP_ONE_H */ #include
> <lttng/tracepoint-event.h>

> tp_one.c
> #define TRACEPOINT_CREATE_PROBES #define TRACEPOINT_DEFINE #include "tp_one.h"

> tp_two.h file:

> #undef TRACEPOINT_PROVIDER #define TRACEPOINT_PROVIDER hello_world #undef
> TRACEPOINT_INCLUDE #define TRACEPOINT_INCLUDE "./tp_two.h" #if
> !defined(_TP_TWO_H) || defined(TRACEPOINT_HEADER_MULTI_READ) #define _TP_TWO_H
> #include <lttng/tracepoint.h> TRACEPOINT_EVENT ( hello_world ,
> my_second_tracepoint , TP_ARGS ( int , my_integer_arg , char * , my_string_arg
> ), TP_FIELDS ( ctf_string ( my_string_field , my_string_arg ) ctf_integer ( int
> , my_integer_field , my_integer_arg ) ) ) #endif /* _TP_TWO_H */ #include
> <lttng/tracepoint-event.h>

> tp_two.c
> #define TRACEPOINT_CREATE_PROBES #define TRACEPOINT_DEFINE #include "tp_two.h"

> hello.c
> use the two tracepoints defined in the two files.

> To compile (compile file one by one).
> gcc -o hello tp-one.c tp-two.c hello.c -llttng-ust -ldl

> On Mon, Oct 7, 2019 at 12:22 PM Mathieu Desnoyers < [
> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
> wrote:

>> ----- On Oct 7, 2019, at 9:59 AM, Yonghong Yan [ mailto:yanyh15@gmail.com |
>> yanyh15@gmail.com ] wrote:

>> > For lttng-ust, can I put the tracepoint definition in two files, but they use
>> > the same provider.

>> Based on the terminology here: [
>> https://lttng.org/docs/v2.10/#doc-tracing-your-own-user-application |
>> https://lttng.org/docs/v2.10/#doc-tracing-your-own-user-application ]

>> You need to have at most one instance of your tracepoint provider where
>> the header is included with TRACEPOINT_CREATE_PROBES, and exactly one
>> instance where TRACEPOINT_DEFINE is defined. (both can end up being within
>> the same object if you wish).

>> Then you can include your tracepoint provider header file at will across
>> other compile units in your program. Just make sure none of
>> TRACEPOINT_CREATE_PROBES nor TRACEPOINT_DEFINE are defined in those other
>> compile units. You can therefore call tracepoints from a given probe from
>> various compile units in your program.

>> Hoping this helps clarifying things,

>> Mathieu

>> > Thank you.
>> > Yonghong

>> > _______________________________________________
>> > lttng-dev mailing list
>> > [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> [ http://www.efficios.com/ | http://www.efficios.com ]

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_668692e4-bc7c-4a45-9bc5-9a7dccef048a
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><div><span id=3D"z=
wchr" data-marker=3D"__DIVIDER__">----- On Oct 7, 2019, at 12:42 PM, Yongho=
ng Yan &lt;yanyh15@gmail.com&gt; wrote:<br></span></div><div data-marker=3D=
"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin=
-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;=
text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;=
"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div =
dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"=
ltr"><div>Thank you.&nbsp;</div><br><div>I got most. To confirm, I have two=
 header files, each defines its own tracepoint, they are from the same prov=
ider. The source files that use the header files have its own&nbsp;#define =
TRACEPOINT_CREATE_PROBES and #define TRACEPOINT_DEFINE. This won't work sin=
ce two files have those defines. But if I remove&nbsp;#define TRACEPOINT_CR=
EATE_PROBES#define TRACEPOINT_DEFINE from one of the two .c file, it should=
 work.&nbsp;</div></div></div></div></div></div></div></div></div></div></b=
lockquote><div>The example below is bogus.<br></div><div><br data-mce-bogus=
=3D"1"></div><div>Each of your tp_one.h and tp_two.h should have its own pr=
ovider name, not "hello_world" for both.<br data-mce-bogus=3D"1"></div><div=
><br data-mce-bogus=3D"1"></div><div>You should _only_ have a single header=
 implementation file per provider name within an application.<br data-mce-b=
ogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>In my previous em=
ail, I was only refering to a case where you would want to define+create pr=
obes within<br data-mce-bogus=3D"1"></div><div>a compile unit, and use the =
tracepoints (call them) from various other compile units in the program.<br=
 data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks=
,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Ma=
thieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><di=
v><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid=
 #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;fon=
t-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;=
font-size:12pt;"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r"><div dir=3D"ltr"><br><div>tp_one.h file:</div><br><div><pre class=3D"gma=
il-src" style=3D"margin-top:0px;margin-bottom:0px;padding:10px;border:0px;f=
ont-size:10.5px;line-height:13.125px;font-family:'andale mono wt' , 'andale=
 mono' , 'bitstream vera sans mono' , 'liberation mono' , 'nimbus mono l' ,=
 'ubuntu mono' , 'monaco' , 'consolas' , 'lucida console' , 'lucida sans ty=
pewriter' , 'courier new' , 'courier' , monospace;vertical-align:baseline;b=
ackground-color:rgba( 0 , 0 , 0 , 0.05 );color:rgb( 26 , 26 , 26 )"><span c=
lass=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-style:ita=
lic;font-variant:inherit;font-weight:700;font-size:inherit;line-height:inhe=
rit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153 , 153 =
)">#undef TRACEPOINT_PROVIDER</span>
<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-size:inherit;line-heig=
ht:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153=
 , 153 )">#define TRACEPOINT_PROVIDER hello_world</span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-size:inherit;line-heig=
ht:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153=
 , 153 )">#undef TRACEPOINT_INCLUDE</span>
<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-size:inherit;line-heig=
ht:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153=
 , 153 )">#define TRACEPOINT_INCLUDE "./tp_one.h"</span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-size:inherit;line-heig=
ht:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153=
 , 153 )">#if !defined(_TP_ONE_H) || defined(TRACEPOINT_HEADER_MULTI_READ)<=
/span>
<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-size:inherit;line-heig=
ht:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153=
 , 153 )">#define _TP_ONE_H</span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-size:inherit;line-heig=
ht:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153=
 , 153 )">#include</span> <span class=3D"gmail-cpf" style=3D"margin:0px;pad=
ding:0px;border:0px;font:inherit;vertical-align:baseline">&lt;lttng/tracepo=
int.h&gt;</span>

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
;font-style:inherit;font-variant:inherit;font-weight:700;font-size:inherit;=
line-height:inherit;font-family:inherit;vertical-align:baseline;color:rgb( =
68 , 85 , 136 )">int</span><span class=3D"gmail-p" style=3D"margin:0px;padd=
ing:0px;border:0px;font:inherit;vertical-align:baseline">,</span> <span cla=
ss=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;font:inherit;vert=
ical-align:baseline">my_integer_arg</span><span class=3D"gmail-p" style=3D"=
margin:0px;padding:0px;border:0px;font:inherit;vertical-align:baseline">,</=
span>
        <span class=3D"gmail-kt" style=3D"margin:0px;padding:0px;border:0px=
;font-style:inherit;font-variant:inherit;font-weight:700;font-size:inherit;=
line-height:inherit;font-family:inherit;vertical-align:baseline;color:rgb( =
68 , 85 , 136 )">char</span><span class=3D"gmail-o" style=3D"margin:0px;pad=
ding:0px;border:0px;font-style:inherit;font-variant:inherit;font-weight:700=
;font-size:inherit;line-height:inherit;font-family:inherit;vertical-align:b=
aseline;color:rgb( 0 , 0 , 0 )">*</span><span class=3D"gmail-p" style=3D"ma=
rgin:0px;padding:0px;border:0px;font:inherit;vertical-align:baseline">,</sp=
an> <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;font=
:inherit;vertical-align:baseline">my_string_arg</span>
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
;border:0px;font-style:inherit;font-variant:inherit;font-weight:700;font-si=
ze:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline;=
color:rgb( 68 , 85 , 136 )">int</span><span class=3D"gmail-p" style=3D"marg=
in:0px;padding:0px;border:0px;font:inherit;vertical-align:baseline">,</span=
> <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;font:i=
nherit;vertical-align:baseline">my_integer_field</span><span class=3D"gmail=
-p" style=3D"margin:0px;padding:0px;border:0px;font:inherit;vertical-align:=
baseline">,</span> <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;=
border:0px;font:inherit;vertical-align:baseline">my_integer_arg</span><span=
 class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0px;font:inherit;=
vertical-align:baseline">)</span>
    <span class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0px;font=
:inherit;vertical-align:baseline">)</span>
<span class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0px;font:inh=
erit;vertical-align:baseline">)</span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-size:inherit;line-heig=
ht:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153=
 , 153 )">#endif </span><span class=3D"gmail-cm" style=3D"margin:0px;paddin=
g:0px;border:0px;font-style:italic;font-variant:inherit;font-weight:inherit=
;font-size:inherit;line-height:inherit;font-family:inherit;vertical-align:b=
aseline;color:rgb( 153 , 153 , 136 )">/* _TP_ONE_H */</span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-size:inherit;line-heig=
ht:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153=
 , 153 )">#include</span> <span class=3D"gmail-cpf" style=3D"margin:0px;pad=
ding:0px;border:0px;font:inherit;vertical-align:baseline">&lt;lttng/tracepo=
int-event.h&gt;</span></pre></div><div dir=3D"ltr"><br></div><div dir=3D"lt=
r"><div style=3D"margin:0px;padding:3px 10px 5px;border:0px;font-size:10.5p=
x;line-height:inherit;font-family:'open sans' , 'frutiger' , 'frutiger lino=
type' , 'univers' , 'calibri' , 'gill sans' , 'gill sans mt' , 'myriad pro'=
 , 'myriad' , 'dejavu sans condensed' , 'liberation sans' , 'nimbus sans l'=
 , 'tahoma' , 'geneva' , 'helvetica neue' , 'helvetica' , 'arial' , sans-se=
rif;vertical-align:baseline;background-color:rgb( 218 , 224 , 224 );color:r=
gb( 26 , 26 , 26 )"><p style=3D"margin:0px;padding:0px;border:0px;font-styl=
e:inherit;font-variant:inherit;font-weight:inherit;font-size:11.2px;line-he=
ight:16.8px;font-family:inherit;vertical-align:baseline;color:rgb( 86 , 101=
 , 102 )"><code class=3D"gmail-file" style=3D"margin:0px 1px;padding:2px 0p=
x;border:0px;font-style:inherit;font-variant:inherit;font-weight:inherit;fo=
nt-size:10.08px;line-height:inherit;font-family:'andale mono wt' , 'andale =
mono' , 'bitstream vera sans mono' , 'liberation mono' , 'nimbus mono l' , =
'ubuntu mono' , 'monaco' , 'consolas' , 'lucida console' , 'lucida sans typ=
ewriter' , 'courier new' , 'courier' , monospace;vertical-align:baseline;ba=
ckground-color:transparent;white-space:nowrap">tp_one.c</code></p></div><pr=
e class=3D"gmail-src" style=3D"margin-top:0px;margin-bottom:0px;padding:10p=
x;border:0px;font-size:10.5px;line-height:13.125px;font-family:'andale mono=
 wt' , 'andale mono' , 'bitstream vera sans mono' , 'liberation mono' , 'ni=
mbus mono l' , 'ubuntu mono' , 'monaco' , 'consolas' , 'lucida console' , '=
lucida sans typewriter' , 'courier new' , 'courier' , monospace;vertical-al=
ign:baseline;background-color:rgba( 0 , 0 , 0 , 0.05 );color:rgb( 26 , 26 ,=
 26 )"><span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;=
font-style:italic;font-variant:inherit;font-weight:700;font-size:inherit;li=
ne-height:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 15=
3 , 153 , 153 )">#define TRACEPOINT_CREATE_PROBES</span>
<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-size:inherit;line-heig=
ht:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153=
 , 153 )">#define TRACEPOINT_DEFINE</span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-size:inherit;line-heig=
ht:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153=
 , 153 )">#include</span> <span class=3D"gmail-cpf" style=3D"margin:0px;pad=
ding:0px;border:0px;font:inherit;vertical-align:baseline">"tp_one.h"</span>=
</pre></div><div dir=3D"ltr"><br></div><div dir=3D"ltr"><div>tp_two.h file:=
</div><br><div><pre class=3D"gmail-src" style=3D"margin-top:0px;margin-bott=
om:0px;padding:10px;border:0px;font-size:10.5px;line-height:13.125px;font-f=
amily:'andale mono wt' , 'andale mono' , 'bitstream vera sans mono' , 'libe=
ration mono' , 'nimbus mono l' , 'ubuntu mono' , 'monaco' , 'consolas' , 'l=
ucida console' , 'lucida sans typewriter' , 'courier new' , 'courier' , mon=
ospace;vertical-align:baseline;background-color:rgba( 0 , 0 , 0 , 0.05 );co=
lor:rgb( 26 , 26 , 26 )"><span class=3D"gmail-cp" style=3D"margin:0px;paddi=
ng:0px;border:0px;font-style:italic;font-variant:inherit;font-weight:700;fo=
nt-size:inherit;line-height:inherit;font-family:inherit;vertical-align:base=
line;color:rgb( 153 , 153 , 153 )">#undef TRACEPOINT_PROVIDER</span>
<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-size:inherit;line-heig=
ht:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153=
 , 153 )">#define TRACEPOINT_PROVIDER hello_world</span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-size:inherit;line-heig=
ht:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153=
 , 153 )">#undef TRACEPOINT_INCLUDE</span>
<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-size:inherit;line-heig=
ht:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153=
 , 153 )">#define TRACEPOINT_INCLUDE "./tp_two.h"</span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-size:inherit;line-heig=
ht:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153=
 , 153 )">#if !defined(_TP_TWO_H) || defined(TRACEPOINT_HEADER_MULTI_READ)<=
/span>
<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-size:inherit;line-heig=
ht:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153=
 , 153 )">#define _TP_TWO_H</span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-size:inherit;line-heig=
ht:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153=
 , 153 )">#include</span> <span class=3D"gmail-cpf" style=3D"margin:0px;pad=
ding:0px;border:0px;font:inherit;vertical-align:baseline">&lt;lttng/tracepo=
int.h&gt;</span>

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
;font-style:inherit;font-variant:inherit;font-weight:700;font-size:inherit;=
line-height:inherit;font-family:inherit;vertical-align:baseline;color:rgb( =
68 , 85 , 136 )">int</span><span class=3D"gmail-p" style=3D"margin:0px;padd=
ing:0px;border:0px;font:inherit;vertical-align:baseline">,</span> <span cla=
ss=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;font:inherit;vert=
ical-align:baseline">my_integer_arg</span><span class=3D"gmail-p" style=3D"=
margin:0px;padding:0px;border:0px;font:inherit;vertical-align:baseline">,</=
span>
        <span class=3D"gmail-kt" style=3D"margin:0px;padding:0px;border:0px=
;font-style:inherit;font-variant:inherit;font-weight:700;font-size:inherit;=
line-height:inherit;font-family:inherit;vertical-align:baseline;color:rgb( =
68 , 85 , 136 )">char</span><span class=3D"gmail-o" style=3D"margin:0px;pad=
ding:0px;border:0px;font-style:inherit;font-variant:inherit;font-weight:700=
;font-size:inherit;line-height:inherit;font-family:inherit;vertical-align:b=
aseline;color:rgb( 0 , 0 , 0 )">*</span><span class=3D"gmail-p" style=3D"ma=
rgin:0px;padding:0px;border:0px;font:inherit;vertical-align:baseline">,</sp=
an> <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;font=
:inherit;vertical-align:baseline">my_string_arg</span>
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
;border:0px;font-style:inherit;font-variant:inherit;font-weight:700;font-si=
ze:inherit;line-height:inherit;font-family:inherit;vertical-align:baseline;=
color:rgb( 68 , 85 , 136 )">int</span><span class=3D"gmail-p" style=3D"marg=
in:0px;padding:0px;border:0px;font:inherit;vertical-align:baseline">,</span=
> <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;border:0px;font:i=
nherit;vertical-align:baseline">my_integer_field</span><span class=3D"gmail=
-p" style=3D"margin:0px;padding:0px;border:0px;font:inherit;vertical-align:=
baseline">,</span> <span class=3D"gmail-n" style=3D"margin:0px;padding:0px;=
border:0px;font:inherit;vertical-align:baseline">my_integer_arg</span><span=
 class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0px;font:inherit;=
vertical-align:baseline">)</span>
    <span class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0px;font=
:inherit;vertical-align:baseline">)</span>
<span class=3D"gmail-p" style=3D"margin:0px;padding:0px;border:0px;font:inh=
erit;vertical-align:baseline">)</span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-size:inherit;line-heig=
ht:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153=
 , 153 )">#endif </span><span class=3D"gmail-cm" style=3D"margin:0px;paddin=
g:0px;border:0px;font-style:italic;font-variant:inherit;font-weight:inherit=
;font-size:inherit;line-height:inherit;font-family:inherit;vertical-align:b=
aseline;color:rgb( 153 , 153 , 136 )">/* _TP_TWO_H */</span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-size:inherit;line-heig=
ht:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153=
 , 153 )">#include</span> <span class=3D"gmail-cpf" style=3D"margin:0px;pad=
ding:0px;border:0px;font:inherit;vertical-align:baseline">&lt;lttng/tracepo=
int-event.h&gt;</span></pre></div><div dir=3D"ltr"><br></div><div dir=3D"lt=
r"><div style=3D"margin:0px;padding:3px 10px 5px;border:0px;font-size:10.5p=
x;line-height:inherit;font-family:'open sans' , 'frutiger' , 'frutiger lino=
type' , 'univers' , 'calibri' , 'gill sans' , 'gill sans mt' , 'myriad pro'=
 , 'myriad' , 'dejavu sans condensed' , 'liberation sans' , 'nimbus sans l'=
 , 'tahoma' , 'geneva' , 'helvetica neue' , 'helvetica' , 'arial' , sans-se=
rif;vertical-align:baseline;background-color:rgb( 218 , 224 , 224 );color:r=
gb( 26 , 26 , 26 )"><p style=3D"margin:0px;padding:0px;border:0px;font-styl=
e:inherit;font-variant:inherit;font-weight:inherit;font-size:11.2px;line-he=
ight:16.8px;font-family:inherit;vertical-align:baseline;color:rgb( 86 , 101=
 , 102 )"><code class=3D"gmail-file" style=3D"margin:0px 1px;padding:2px 0p=
x;border:0px;font-style:inherit;font-variant:inherit;font-weight:inherit;fo=
nt-size:10.08px;line-height:inherit;font-family:'andale mono wt' , 'andale =
mono' , 'bitstream vera sans mono' , 'liberation mono' , 'nimbus mono l' , =
'ubuntu mono' , 'monaco' , 'consolas' , 'lucida console' , 'lucida sans typ=
ewriter' , 'courier new' , 'courier' , monospace;vertical-align:baseline;ba=
ckground-color:transparent;white-space:nowrap">tp_two.c</code></p></div><pr=
e class=3D"gmail-src" style=3D"margin-top:0px;margin-bottom:0px;padding:10p=
x;border:0px;font-size:10.5px;line-height:13.125px;font-family:'andale mono=
 wt' , 'andale mono' , 'bitstream vera sans mono' , 'liberation mono' , 'ni=
mbus mono l' , 'ubuntu mono' , 'monaco' , 'consolas' , 'lucida console' , '=
lucida sans typewriter' , 'courier new' , 'courier' , monospace;vertical-al=
ign:baseline;background-color:rgba( 0 , 0 , 0 , 0.05 );color:rgb( 26 , 26 ,=
 26 )"><span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;=
font-style:italic;font-variant:inherit;font-weight:700;font-size:inherit;li=
ne-height:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 15=
3 , 153 , 153 )">#define TRACEPOINT_CREATE_PROBES</span>
<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-size:inherit;line-heig=
ht:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153=
 , 153 )">#define TRACEPOINT_DEFINE</span>

<span class=3D"gmail-cp" style=3D"margin:0px;padding:0px;border:0px;font-st=
yle:italic;font-variant:inherit;font-weight:700;font-size:inherit;line-heig=
ht:inherit;font-family:inherit;vertical-align:baseline;color:rgb( 153 , 153=
 , 153 )">#include</span> <span class=3D"gmail-cpf" style=3D"margin:0px;pad=
ding:0px;border:0px;font:inherit;vertical-align:baseline">"tp_two.h"</span>=
</pre></div></div></div></div></div></div></div></div></div></div><br><div>=
hello.c</div><div>use the two tracepoints defined in the two files.&nbsp;</=
div><br><div>To compile (compile file one by one).&nbsp;</div><pre class=3D=
"gmail-commands" style=3D"margin-top:0px;margin-bottom:0px;padding:0px;bord=
er:0px;font-size:10.5px;line-height:13.125px;font-family:'andale mono wt' ,=
 'andale mono' , 'bitstream vera sans mono' , 'liberation mono' , 'nimbus m=
ono l' , 'ubuntu mono' , 'monaco' , 'consolas' , 'lucida console' , 'lucida=
 sans typewriter' , 'courier new' , 'courier' , monospace;vertical-align:ba=
seline;background-color:transparent;color:rgba( 0 , 0 , 0 , 0.75 )">gcc -o =
hello tp-one.c tp-two.c hello.c -llttng-ust -ldl</pre><pre class=3D"gmail-c=
ommands" style=3D"margin-top:0px;margin-bottom:0px;padding:0px;border:0px;f=
ont-size:10.5px;line-height:13.125px;font-family:'andale mono wt' , 'andale=
 mono' , 'bitstream vera sans mono' , 'liberation mono' , 'nimbus mono l' ,=
 'ubuntu mono' , 'monaco' , 'consolas' , 'lucida console' , 'lucida sans ty=
pewriter' , 'courier new' , 'courier' , monospace;vertical-align:baseline;b=
ackground-color:transparent;color:rgba( 0 , 0 , 0 , 0.75 )"><br></pre><pre =
class=3D"gmail-commands" style=3D"margin-top:0px;margin-bottom:0px;padding:=
0px;border:0px;font-size:10.5px;line-height:13.125px;font-family:'andale mo=
no wt' , 'andale mono' , 'bitstream vera sans mono' , 'liberation mono' , '=
nimbus mono l' , 'ubuntu mono' , 'monaco' , 'consolas' , 'lucida console' ,=
 'lucida sans typewriter' , 'courier new' , 'courier' , monospace;vertical-=
align:baseline;background-color:transparent;color:rgba( 0 , 0 , 0 , 0.75 )"=
><br></pre><pre class=3D"gmail-commands" style=3D"margin-top:0px;margin-bot=
tom:0px;padding:0px;border:0px;font-size:10.5px;line-height:13.125px;font-f=
amily:'andale mono wt' , 'andale mono' , 'bitstream vera sans mono' , 'libe=
ration mono' , 'nimbus mono l' , 'ubuntu mono' , 'monaco' , 'consolas' , 'l=
ucida console' , 'lucida sans typewriter' , 'courier new' , 'courier' , mon=
ospace;vertical-align:baseline;background-color:transparent;color:rgba( 0 ,=
 0 , 0 , 0.75 )"><br></pre><div class=3D"elided-text"><div dir=3D"ltr">On M=
on, Oct 7, 2019 at 12:22 PM Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu=
.desnoyers@efficios.com" target=3D"_blank" rel=3D"nofollow noopener norefer=
rer">mathieu.desnoyers@efficios.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb( 204 , 204 , 204 );padding-left:1ex"><br>
<br>
----- On Oct 7, 2019, at 9:59 AM, Yonghong Yan <a href=3D"mailto:yanyh15@gm=
ail.com" target=3D"_blank" rel=3D"nofollow noopener noreferrer">yanyh15@gma=
il.com</a> wrote:<br>
<br>
&gt; For lttng-ust, can I put the tracepoint definition in two files, but t=
hey use<br>
&gt; the same provider.<br>
<br>
Based on the terminology here: <a href=3D"https://lttng.org/docs/v2.10/#doc=
-tracing-your-own-user-application" rel=3D"noreferrer nofollow noopener nor=
eferrer" target=3D"_blank">https://lttng.org/docs/v2.10/#doc-tracing-your-o=
wn-user-application</a><br>
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
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank" rel=3D"=
nofollow noopener noreferrer">lttng-dev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer nofollow noopener noreferrer" target=3D"_blank">https://=
lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer nofollow noopener nor=
eferrer" target=3D"_blank">http://www.efficios.com</a><br>
</blockquote></div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_668692e4-bc7c-4a45-9bc5-9a7dccef048a--

--===============8298902561311741112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8298902561311741112==--
