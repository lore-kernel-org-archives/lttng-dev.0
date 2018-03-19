From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Double free or corruption error (fasttop)
Date: Mon, 19 Mar 2018 12:21:27 -0400 (EDT)
Message-ID: <226204243.12548.1521476487812.JavaMail.zimbra__1218.45960752598$1521476379$gmane$org@efficios.com>
References: <CAC-H6ttMF-CjzDH7a6bmeoOPP8JRLptYTmGJVvrx5t-G0Se_gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1208304965344878084=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 404hCF4Lk5zn9H
 for <lttng-dev@lists.lttng.org>; Mon, 19 Mar 2018 12:21:29 -0400 (EDT)
In-Reply-To: <CAC-H6ttMF-CjzDH7a6bmeoOPP8JRLptYTmGJVvrx5t-G0Se_gA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Shehab Elsayed <shehabyomn@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1208304965344878084==
Content-Type: multipart/alternative;
	boundary="=_b3aab2b8-c453-45bf-90b0-cd1d2ee5f0ae"

--=_b3aab2b8-c453-45bf-90b0-cd1d2ee5f0ae
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Mar 16, 2018, at 5:37 PM, Shehab Elsayed <shehabyomn@gmail.com> wrote: 

> Hello All,

> I am trying to instrument a pthread application using the provided pthread
> wrapper, but I sometimes run into a "Double free or corruption error ( fasttop
> )" error.

Please provide more information about the version of lttng-ust you are using, and how you setup 
your tracing session. 

Thanks, 

Mathieu 

> Here is a description of what I have tried and noticed:
> 1- The problem isn't consistent. It sometimes happen and sometimes works as
> expected.
> 2- From my experiments, the problem happens (more frequently at least) when
> adding performance counter contexts (I tried cycles, cpu _cycles and
> instructions).
> 3- I am testing using lu _ ncb from splash3 benchmark suite after setting LD _
> PRELOAD to use the pthread wrapper as described in the LTTng documents.
> 4- Here is the backtrace printed after exiting:
> ======= Backtrace : =========
> /lib64/ libc .so.6([Thread 0x7ffff5611700 ( LWP 97229) exited]
> / usr /local/lib/ liblttng - ust .so.0( lttng
> _destroy_context+0x35)[0x7ffff7471575]
> / usr /local/lib/ liblttng - ust .so.0( lttng
> _session_destroy+0x21c)[0x7ffff747363c]
> / usr /local/lib/ liblttng - ust .so.0(+0x1e906)[0x7ffff746d906]
> / usr /local/lib/ liblttng - ust .so.0( lttng _ ust _ objd _ unref
> +0x9f)[0x7ffff746dccf]
> / usr /local/lib/ liblttng - ust .so.0( lttng _ ust _ objd _ unref
> +0x9f)[0x7ffff746dccf]
> / usr /local/lib/ liblttng - ust .so.0( lttng _ ust _ objd _ unref
> +0x9f)[0x7ffff746dccf]
> / usr /local/lib/ liblttng - ust .so.0( lttng _ ust _ abi
> _exit+0x68)[0x7ffff746ead8]
> / usr /local/lib/ liblttng - ust .so.0(+0x191d3)[0x7ffff74681d3]
> / usr /local/lib/ liblttng - ust .so.0( lttng _ ust _exit+0x67)[0x7ffff745ed57]
> /lib64/ ld - linux -x86-64.so.2(+0xf85a)[0x7ffff7dec85a]
> /lib64/ libc .so.6(+0x38a49)[0x7ffff6ca6a49]
> /lib64/ libc .so.6(+0x38a95)[0x7ffff6ca6a95]
> / aenao -99/elsayed9/ LTTng /data/scripts/ tmp / lu _ ncb [0x401b51]
> /lib64/ libc .so.6(__ libc _start_main+0xf5)[0x7ffff6c8fb35]
> / aenao -99/elsayed9/ LTTng /data/scripts/ tmp / lu _ ncb [0x401c44]
> 5- Also, this is a backtrace I obtained from gdb :
> #0 0x00007ffff6eac1d7 in raise () from /lib64/ libc .so.6
> #1 0x00007ffff6ead8c8 in abort () from /lib64/ libc .so.6
> #2 0x00007ffff6eebf07 in __ libc _message () from /lib64/ libc .so.6
> #3 0x00007ffff6ef3503 in _int_free () from /lib64/ libc .so.6
> #4 0x00007ffff768ad25 in lttng _destroy_ perf _counter_field (
> field=<optimized out>) at lttng -context- perf -counters.c:418
> #5 0x00007ffff767a575 in lttng _destroy_context (
> ctx =0x7ffff0011090) at lttng -context.c:278
> #6 0x00007ffff767c63c in _ lttng _channel_ unmap (
> lttng _ chan =0x7ffff0010f40) at lttng -events.c:172
> #7 lttng _session_destroy (session=0x7ffff0000900)
> at lttng -events.c:247
> #8 0x00007ffff7676906 in lttng _release_session (
> objd =<optimized out>) at lttng - ust - abi .c:601
> #9 0x00007ffff7676ccf in lttng _ ust _ objd _ unref (id=1,
> is_owner=<optimized out>) at lttng - ust - abi .c:216
> #10 0x00007ffff7676ccf in lttng _ ust _ objd _ unref (id=2,
> is_owner=<optimized out>) at lttng - ust - abi .c:216
> #11 0x00007ffff7676ccf in lttng _ ust _ objd _ unref (id=id@entry=18,
> is_owner=is_owner@entry=1) at lttng - ust - abi .c:216
> #12 0x00007ffff7677ad8 in objd _table_destroy ()
> at lttng - ust - abi .c:235
> #13 lttng _ ust _ abi _exit () at lttng - ust - abi .c:1002
> #14 0x00007ffff76711d3 in lttng _ ust _cleanup (exiting=1)
> at lttng - ust -comm.c:1807
> #15 0x00007ffff7667d57 in lttng _ ust _exit ()
> at lttng - ust -comm.c:1874
> #16 0x00007ffff7dec85a in _ dl _ fini ()
> from /lib64/ ld - linux -x86-64.so.2
> #17 0x00007ffff6eafa49 in __run_exit_handlers ()
> from /lib64/ libc .so.6
> #18 0x00007ffff6eafa95 in exit () from /lib64/ libc .so.6
> #19 0x0000000000401b51 in main ( argc =<optimized out>,
> argv =<optimized out>) at lu .c:368

> Any ideas, why this happens and how to fix it?

> Thanks,
> Shehab

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_b3aab2b8-c453-45bf-90b0-cd1d2ee5f0ae
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><div><span id=3D"z=
wchr" data-marker=3D"__DIVIDER__">----- On Mar 16, 2018, at 5:37 PM, Shehab=
 Elsayed &lt;shehabyomn@gmail.com&gt; wrote:<br></span></div><div data-mark=
er=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;m=
argin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:no=
rmal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:=
12pt;"><div dir=3D"ltr"><div><div><div><div><div><div><div><div><div><div>H=
ello All,<br><br></div>I am trying to instrument a <span class=3D"" style=
=3D"" id=3D":3qh.1">pthread</span> application using the provided <span cla=
ss=3D"" style=3D"" id=3D":3qh.2">pthread</span> wrapper, but I sometimes ru=
n into a "Double free or corruption error (<span class=3D"" style=3D"" id=
=3D":3qh.3">fasttop</span>)" error. </div></div></div></div></div></div></d=
iv></div></div></div></blockquote><div><br></div><div>Please provide more i=
nformation about the version of lttng-ust you are using, and how you setup<=
br data-mce-bogus=3D"1"></div><div>your tracing session.<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-b=
ogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-m=
ce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=
=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div><div><div><=
div><div><div><div><div><div><br><br></div>Here is a description of what I =
have tried and noticed:<br></div>1- The problem isn't consistent. It someti=
mes happen and sometimes works as expected.<br></div>2- From my experiments=
, the problem happens (more frequently at least) when adding performance co=
unter contexts (I tried cycles, <span class=3D"" style=3D"" id=3D":3qh.4">c=
pu</span>_cycles and instructions).<br></div>3- I am testing using <span cl=
ass=3D"" style=3D"" id=3D":3qh.5">lu</span>_<span class=3D"" style=3D"" id=
=3D":3qh.6">ncb</span> from splash3 benchmark suite after setting <span cla=
ss=3D"" style=3D"" id=3D":3qh.7">LD</span>_<span class=3D"" style=3D"" id=
=3D":3qh.8">PRELOAD</span> to use the <span class=3D"" style=3D"" id=3D":3q=
h.9">pthread</span> wrapper as described in the <span class=3D"" style=3D""=
 id=3D":3qh.10">LTTng</span> documents.<br></div>4- Here is the <span class=
=3D"" style=3D"" id=3D":3qh.11">backtrace</span> printed after exiting:<br>=
=3D=3D=3D=3D=3D=3D=3D <span class=3D"" style=3D"" id=3D":3qh.12">Backtrace<=
/span>: =3D=3D=3D=3D=3D=3D=3D=3D=3D<br>/lib64/<span class=3D"" style=3D"" i=
d=3D":3qh.13">libc</span>.so.6([Thread 0x7ffff5611700 (<span class=3D"" sty=
le=3D"" id=3D":3qh.14">LWP</span> 97229) exited]<br>/<span class=3D"" style=
=3D"" id=3D":3qh.15">usr</span>/local/lib/<span class=3D"" style=3D"" id=3D=
":3qh.16">liblttng</span>-<span class=3D"" style=3D"" id=3D":3qh.17">ust</s=
pan>.so.0(<span class=3D"" style=3D"" id=3D":3qh.18">lttng</span>_destroy_c=
ontext+0x35)[0x7ffff7471575]<br>/<span class=3D"" style=3D"" id=3D":3qh.19"=
>usr</span>/local/lib/<span class=3D"" style=3D"" id=3D":3qh.20">liblttng</=
span>-<span class=3D"" style=3D"" id=3D":3qh.21">ust</span>.so.0(<span clas=
s=3D"" style=3D"" id=3D":3qh.22">lttng</span>_session_destroy+0x21c)[0x7fff=
f747363c]<br>/<span class=3D"" style=3D"" id=3D":3qh.23">usr</span>/local/l=
ib/<span class=3D"" style=3D"" id=3D":3qh.24">liblttng</span>-<span class=
=3D"" style=3D"" id=3D":3qh.25">ust</span>.so.0(+0x1e906)[0x7ffff746d906]<b=
r>/<span class=3D"" style=3D"" id=3D":3qh.26">usr</span>/local/lib/<span cl=
ass=3D"" style=3D"" id=3D":3qh.27">liblttng</span>-<span class=3D"" style=
=3D"" id=3D":3qh.28">ust</span>.so.0(<span class=3D"" style=3D"" id=3D":3qh=
.29">lttng</span>_<span class=3D"" style=3D"" id=3D":3qh.30">ust</span>_<sp=
an class=3D"" style=3D"" id=3D":3qh.31">objd</span>_<span class=3D"" style=
=3D"" id=3D":3qh.32">unref</span>+0x9f)[0x7ffff746dccf]<br>/<span class=3D"=
" style=3D"" id=3D":3qh.33">usr</span>/local/lib/<span class=3D"" style=3D"=
" id=3D":3qh.34">liblttng</span>-<span class=3D"" style=3D"" id=3D":3qh.35"=
>ust</span>.so.0(<span class=3D"" style=3D"" id=3D":3qh.36">lttng</span>_<s=
pan class=3D"" style=3D"" id=3D":3qh.37">ust</span>_<span class=3D"" style=
=3D"" id=3D":3qh.38">objd</span>_<span class=3D"" style=3D"" id=3D":3qh.39"=
>unref</span>+0x9f)[0x7ffff746dccf]<br>/<span class=3D"" style=3D"" id=3D":=
3qh.40">usr</span>/local/lib/<span class=3D"" style=3D"" id=3D":3qh.41">lib=
lttng</span>-<span class=3D"" style=3D"" id=3D":3qh.42">ust</span>.so.0(<sp=
an class=3D"" style=3D"" id=3D":3qh.43">lttng</span>_<span class=3D"" style=
=3D"" id=3D":3qh.44">ust</span>_<span class=3D"" style=3D"" id=3D":3qh.45">=
objd</span>_<span class=3D"" style=3D"" id=3D":3qh.46">unref</span>+0x9f)[0=
x7ffff746dccf]<br>/<span class=3D"" style=3D"" id=3D":3qh.47">usr</span>/lo=
cal/lib/<span class=3D"" style=3D"" id=3D":3qh.48">liblttng</span>-<span cl=
ass=3D"" style=3D"" id=3D":3qh.49">ust</span>.so.0(<span class=3D"" style=
=3D"" id=3D":3qh.50">lttng</span>_<span class=3D"" style=3D"" id=3D":3qh.51=
">ust</span>_<span class=3D"" style=3D"" id=3D":3qh.52">abi</span>_exit+0x6=
8)[0x7ffff746ead8]<br>/<span class=3D"" style=3D"" id=3D":3qh.53">usr</span=
>/local/lib/<span class=3D"" style=3D"" id=3D":3qh.54">liblttng</span>-<spa=
n class=3D"" style=3D"" id=3D":3qh.55">ust</span>.so.0(+0x191d3)[0x7ffff746=
81d3]<br>/<span class=3D"" style=3D"" id=3D":3qh.56">usr</span>/local/lib/<=
span class=3D"" style=3D"" id=3D":3qh.57">liblttng</span>-<span class=3D"" =
style=3D"" id=3D":3qh.58">ust</span>.so.0(<span class=3D"" style=3D"" id=3D=
":3qh.59">lttng</span>_<span class=3D"" style=3D"" id=3D":3qh.60">ust</span=
>_exit+0x67)[0x7ffff745ed57]<br>/lib64/<span class=3D"" style=3D"" id=3D":3=
qh.61">ld</span>-<span class=3D"" style=3D"" id=3D":3qh.62">linux</span>-x8=
6-64.so.2(+0xf85a)[0x7ffff7dec85a]<br>/lib64/<span class=3D"" style=3D"" id=
=3D":3qh.63">libc</span>.so.6(+0x38a49)[0x7ffff6ca6a49]<br>/lib64/<span cla=
ss=3D"" style=3D"" id=3D":3qh.64">libc</span>.so.6(+0x38a95)[0x7ffff6ca6a95=
]<br>/<span class=3D"" style=3D"" id=3D":3qh.65">aenao</span>-99/elsayed9/<=
span class=3D"" style=3D"" id=3D":3qh.66">LTTng</span>/data/scripts/<span c=
lass=3D"" style=3D"" id=3D":3qh.67">tmp</span>/<span class=3D"" style=3D"" =
id=3D":3qh.68">lu</span>_<span class=3D"" style=3D"" id=3D":3qh.69">ncb</sp=
an>[0x401b51]<br>/lib64/<span class=3D"" style=3D"" id=3D":3qh.70">libc</sp=
an>.so.6(__<span class=3D"" style=3D"" id=3D":3qh.71">libc</span>_start_mai=
n+0xf5)[0x7ffff6c8fb35]<br>/<span class=3D"" style=3D"" id=3D":3qh.72">aena=
o</span>-99/elsayed9/<span class=3D"" style=3D"" id=3D":3qh.73">LTTng</span=
>/data/scripts/<span class=3D"" style=3D"" id=3D":3qh.74">tmp</span>/<span =
class=3D"" style=3D"" id=3D":3qh.75">lu</span>_<span class=3D"" style=3D"" =
id=3D":3qh.76">ncb</span>[0x401c44]<br></div>5- Also, this is a <span class=
=3D"" style=3D"" id=3D":3qh.77">backtrace</span> I obtained from <span clas=
s=3D"" style=3D"" id=3D":3qh.78">gdb</span>:<br>#0&nbsp; 0x00007ffff6eac1d7=
 in raise () from /lib64/<span class=3D"" style=3D"" id=3D":3qh.79">libc</s=
pan>.so.6<br>#1&nbsp; 0x00007ffff6ead8c8 in abort () from /lib64/<span clas=
s=3D"" style=3D"" id=3D":3qh.80">libc</span>.so.6<br>#2&nbsp; 0x00007ffff6e=
ebf07 in __<span class=3D"" style=3D"" id=3D":3qh.81">libc</span>_message (=
) from /lib64/<span class=3D"" style=3D"" id=3D":3qh.82">libc</span>.so.6<b=
r>#3&nbsp; 0x00007ffff6ef3503 in _int_free () from /lib64/<span class=3D"" =
style=3D"" id=3D":3qh.83">libc</span>.so.6<br>#4&nbsp; 0x00007ffff768ad25 i=
n <span class=3D"" style=3D"" id=3D":3qh.84">lttng</span>_destroy_<span cla=
ss=3D"" style=3D"" id=3D":3qh.85">perf</span>_counter_field (<br>&nbsp;&nbs=
p;&nbsp; field=3D&lt;optimized out&gt;) at <span class=3D"" style=3D"" id=
=3D":3qh.86">lttng</span>-context-<span class=3D"" style=3D"" id=3D":3qh.87=
">perf</span>-counters.c:418<br>#5&nbsp; 0x00007ffff767a575 in <span class=
=3D"" style=3D"" id=3D":3qh.88">lttng</span>_destroy_context (<br><span cla=
ss=3D"" style=3D"" id=3D":3qh.89">ctx</span>=3D0x7ffff0011090) at <span cla=
ss=3D"" style=3D"" id=3D":3qh.90">lttng</span>-context.c:278<br>#6&nbsp; 0x=
00007ffff767c63c in _<span class=3D"" style=3D"" id=3D":3qh.91">lttng</span=
>_channel_<span class=3D"" style=3D"" id=3D":3qh.92">unmap</span> (<br><spa=
n class=3D"" style=3D"" id=3D":3qh.93">lttng</span>_<span class=3D"" style=
=3D"" id=3D":3qh.94">chan</span>=3D0x7ffff0010f40) at <span class=3D"" styl=
e=3D"" id=3D":3qh.95">lttng</span>-events.c:172<br>#7&nbsp; <span class=3D"=
" style=3D"" id=3D":3qh.96">lttng</span>_session_destroy (session=3D0x7ffff=
0000900)<br>&nbsp;&nbsp;&nbsp; at <span class=3D"" style=3D"" id=3D":3qh.97=
">lttng</span>-events.c:247<br>#8&nbsp; 0x00007ffff7676906 in <span class=
=3D"" style=3D"" id=3D":3qh.98">lttng</span>_release_session (<br><span cla=
ss=3D"" style=3D"" id=3D":3qh.99">objd</span>=3D&lt;optimized out&gt;) at <=
span class=3D"" style=3D"" id=3D":3qh.100">lttng</span>-<span class=3D"" st=
yle=3D"" id=3D":3qh.101">ust</span>-<span class=3D"" style=3D"" id=3D":3qh.=
102">abi</span>.c:601<br>#9&nbsp; 0x00007ffff7676ccf in <span class=3D"" st=
yle=3D"" id=3D":3qh.103">lttng</span>_<span class=3D"" style=3D"" id=3D":3q=
h.104">ust</span>_<span class=3D"" style=3D"" id=3D":3qh.105">objd</span>_<=
span class=3D"" style=3D"" id=3D":3qh.106">unref</span> (id=3D1, <br>&nbsp;=
&nbsp;&nbsp; is_owner=3D&lt;optimized out&gt;) at <span class=3D"" style=3D=
"" id=3D":3qh.107">lttng</span>-<span class=3D"" style=3D"" id=3D":3qh.108"=
>ust</span>-<span class=3D"" style=3D"" id=3D":3qh.109">abi</span>.c:216<br=
>#10 0x00007ffff7676ccf in <span class=3D"" style=3D"" id=3D":3qh.110">lttn=
g</span>_<span class=3D"" style=3D"" id=3D":3qh.111">ust</span>_<span class=
=3D"" style=3D"" id=3D":3qh.112">objd</span>_<span class=3D"" style=3D"" id=
=3D":3qh.113">unref</span> (id=3D2, <br>&nbsp;&nbsp;&nbsp; is_owner=3D&lt;o=
ptimized out&gt;) at <span class=3D"" style=3D"" id=3D":3qh.114">lttng</spa=
n>-<span class=3D"" style=3D"" id=3D":3qh.115">ust</span>-<span class=3D"" =
style=3D"" id=3D":3qh.116">abi</span>.c:216<br>#11 0x00007ffff7676ccf in <s=
pan class=3D"" style=3D"" id=3D":3qh.117">lttng</span>_<span class=3D"" sty=
le=3D"" id=3D":3qh.118">ust</span>_<span class=3D"" style=3D"" id=3D":3qh.1=
19">objd</span>_<span class=3D"" style=3D"" id=3D":3qh.120">unref</span> (i=
d=3Did@entry=3D18, <br>&nbsp;&nbsp;&nbsp; is_owner=3Dis_owner@entry=3D1) at=
 <span class=3D"" style=3D"" id=3D":3qh.121">lttng</span>-<span class=3D"" =
style=3D"" id=3D":3qh.122">ust</span>-<span class=3D"" style=3D"" id=3D":3q=
h.123">abi</span>.c:216<br>#12 0x00007ffff7677ad8 in <span class=3D"" style=
=3D"" id=3D":3qh.124">objd</span>_table_destroy ()<br>&nbsp;&nbsp;&nbsp; at=
 <span class=3D"" style=3D"" id=3D":3qh.125">lttng</span>-<span class=3D"" =
style=3D"" id=3D":3qh.126">ust</span>-<span class=3D"" style=3D"" id=3D":3q=
h.127">abi</span>.c:235<br>#13 <span class=3D"" style=3D"" id=3D":3qh.128">=
lttng</span>_<span class=3D"" style=3D"" id=3D":3qh.129">ust</span>_<span c=
lass=3D"" style=3D"" id=3D":3qh.130">abi</span>_exit () at <span class=3D""=
 style=3D"" id=3D":3qh.131">lttng</span>-<span class=3D"" style=3D"" id=3D"=
:3qh.132">ust</span>-<span class=3D"" style=3D"" id=3D":3qh.133">abi</span>=
.c:1002<br>#14 0x00007ffff76711d3 in <span class=3D"" style=3D"" id=3D":3qh=
.134">lttng</span>_<span class=3D"" style=3D"" id=3D":3qh.135">ust</span>_c=
leanup (exiting=3D1)<br>&nbsp;&nbsp;&nbsp; at <span class=3D"" style=3D"" i=
d=3D":3qh.136">lttng</span>-<span class=3D"" style=3D"" id=3D":3qh.137">ust=
</span>-comm.c:1807<br>#15 0x00007ffff7667d57 in <span class=3D"" style=3D"=
" id=3D":3qh.138">lttng</span>_<span class=3D"" style=3D"" id=3D":3qh.139">=
ust</span>_exit ()<br>&nbsp;&nbsp;&nbsp; at <span class=3D"" style=3D"" id=
=3D":3qh.140">lttng</span>-<span class=3D"" style=3D"" id=3D":3qh.141">ust<=
/span>-comm.c:1874<br>#16 0x00007ffff7dec85a in _<span class=3D"" style=3D"=
" id=3D":3qh.142">dl</span>_<span class=3D"" style=3D"" id=3D":3qh.143">fin=
i</span> ()<br>&nbsp;&nbsp; from /lib64/<span class=3D"" style=3D"" id=3D":=
3qh.144">ld</span>-<span class=3D"" style=3D"" id=3D":3qh.145">linux</span>=
-x86-64.so.2<br>#17 0x00007ffff6eafa49 in __run_exit_handlers ()<br>&nbsp;&=
nbsp; from /lib64/<span class=3D"" style=3D"" id=3D":3qh.146">libc</span>.s=
o.6<br>#18 0x00007ffff6eafa95 in exit () from /lib64/<span class=3D"" style=
=3D"" id=3D":3qh.147">libc</span>.so.6<br>#19 0x0000000000401b51 in main (<=
span class=3D"" style=3D"" id=3D":3qh.148">argc</span>=3D&lt;optimized out&=
gt;, <br><span class=3D"" style=3D"" id=3D":3qh.149">argv</span>=3D&lt;opti=
mized out&gt;) at <span class=3D"" style=3D"" id=3D":3qh.150">lu</span>.c:3=
68<br><br></div>Any ideas, why this happens and how to fix it?<br><br></div=
>Thanks,<br></div><span class=3D"" style=3D"" id=3D":3qh.151">Shehab</span>=
<br><div><div><div><div><br><br></div></div></div></div></div><br>_________=
______________________________________<br>lttng-dev mailing list<br>lttng-d=
ev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttn=
g-dev<br></blockquote></div><div><br></div><div data-marker=3D"__SIG_POST__=
">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.effici=
os.com</div></div></body></html>
--=_b3aab2b8-c453-45bf-90b0-cd1d2ee5f0ae--

--===============1208304965344878084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1208304965344878084==--
