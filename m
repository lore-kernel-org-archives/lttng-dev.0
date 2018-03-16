From: Shehab Elsayed <shehabyomn@gmail.com>
Subject: Double free or corruption error (fasttop)
Date: Fri, 16 Mar 2018 17:37:20 -0400
Message-ID: <CAC-H6ttMF-CjzDH7a6bmeoOPP8JRLptYTmGJVvrx5t-G0Se_gA__21660.1110216745$1521236131$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4133489937848883062=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-x233.google.com (mail-lf0-x233.google.com
 [IPv6:2a00:1450:4010:c07::233])
 by lists.lttng.org (Postfix) with ESMTPS id 402zM750d7zZH
 for <lttng-dev@lists.lttng.org>; Fri, 16 Mar 2018 17:37:23 -0400 (EDT)
Received: by mail-lf0-x233.google.com with SMTP id m69-v6so17344435lfe.8
 for <lttng-dev@lists.lttng.org>; Fri, 16 Mar 2018 14:37:23 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============4133489937848883062==
Content-Type: multipart/alternative; boundary="089e082f39c0c50e5e05678e69e8"

--089e082f39c0c50e5e05678e69e8
Content-Type: text/plain; charset="UTF-8"

Hello All,

I am trying to instrument a pthread application using the provided pthread
wrapper, but I sometimes run into a "Double free or corruption error (
fasttop)" error.

Here is a description of what I have tried and noticed:
1- The problem isn't consistent. It sometimes happen and sometimes works as
expected.
2- From my experiments, the problem happens (more frequently at least) when
adding performance counter contexts (I tried cycles, cpu_cycles and
instructions).
3- I am testing using lu_ncb from splash3 benchmark suite after setting LD_
PRELOAD to use the pthread wrapper as described in the LTTng documents.
4- Here is the backtrace printed after exiting:
======= Backtrace: =========
/lib64/libc.so.6([Thread 0x7ffff5611700 (LWP 97229) exited]
/usr/local/lib/liblttng-ust.so.0(lttng_destroy_context+0x35)[0x7ffff7471575]
/usr/local/lib/liblttng-ust.so.0(lttng
_session_destroy+0x21c)[0x7ffff747363c]
/usr/local/lib/liblttng-ust.so.0(+0x1e906)[0x7ffff746d906]
/usr/local/lib/liblttng-ust.so.0(lttng_ust_objd_unref+0x9f)[0x7ffff746dccf]
/usr/local/lib/liblttng-ust.so.0(lttng_ust_objd_unref+0x9f)[0x7ffff746dccf]
/usr/local/lib/liblttng-ust.so.0(lttng_ust_objd_unref+0x9f)[0x7ffff746dccf]
/usr/local/lib/liblttng-ust.so.0(lttng_ust_abi_exit+0x68)[0x7ffff746ead8]
/usr/local/lib/liblttng-ust.so.0(+0x191d3)[0x7ffff74681d3]
/usr/local/lib/liblttng-ust.so.0(lttng_ust_exit+0x67)[0x7ffff745ed57]
/lib64/ld-linux-x86-64.so.2(+0xf85a)[0x7ffff7dec85a]
/lib64/libc.so.6(+0x38a49)[0x7ffff6ca6a49]
/lib64/libc.so.6(+0x38a95)[0x7ffff6ca6a95]
/aenao-99/elsayed9/LTTng/data/scripts/tmp/lu_ncb[0x401b51]
/lib64/libc.so.6(__libc_start_main+0xf5)[0x7ffff6c8fb35]
/aenao-99/elsayed9/LTTng/data/scripts/tmp/lu_ncb[0x401c44]
5- Also, this is a backtrace I obtained from gdb:
#0  0x00007ffff6eac1d7 in raise () from /lib64/libc.so.6
#1  0x00007ffff6ead8c8 in abort () from /lib64/libc.so.6
#2  0x00007ffff6eebf07 in __libc_message () from /lib64/libc.so.6
#3  0x00007ffff6ef3503 in _int_free () from /lib64/libc.so.6
#4  0x00007ffff768ad25 in lttng_destroy_perf_counter_field (
    field=<optimized out>) at lttng-context-perf-counters.c:418
#5  0x00007ffff767a575 in lttng_destroy_context (
    ctx=0x7ffff0011090) at lttng-context.c:278
#6  0x00007ffff767c63c in _lttng_channel_unmap (
    lttng_chan=0x7ffff0010f40) at lttng-events.c:172
#7  lttng_session_destroy (session=0x7ffff0000900)
    at lttng-events.c:247
#8  0x00007ffff7676906 in lttng_release_session (
    objd=<optimized out>) at lttng-ust-abi.c:601
#9  0x00007ffff7676ccf in lttng_ust_objd_unref (id=1,
    is_owner=<optimized out>) at lttng-ust-abi.c:216
#10 0x00007ffff7676ccf in lttng_ust_objd_unref (id=2,
    is_owner=<optimized out>) at lttng-ust-abi.c:216
#11 0x00007ffff7676ccf in lttng_ust_objd_unref (id=id@entry=18,
    is_owner=is_owner@entry=1) at lttng-ust-abi.c:216
#12 0x00007ffff7677ad8 in objd_table_destroy ()
    at lttng-ust-abi.c:235
#13 lttng_ust_abi_exit () at lttng-ust-abi.c:1002
#14 0x00007ffff76711d3 in lttng_ust_cleanup (exiting=1)
    at lttng-ust-comm.c:1807
#15 0x00007ffff7667d57 in lttng_ust_exit ()
    at lttng-ust-comm.c:1874
#16 0x00007ffff7dec85a in _dl_fini ()
   from /lib64/ld-linux-x86-64.so.2
#17 0x00007ffff6eafa49 in __run_exit_handlers ()
   from /lib64/libc.so.6
#18 0x00007ffff6eafa95 in exit () from /lib64/libc.so.6
#19 0x0000000000401b51 in main (argc=<optimized out>,
    argv=<optimized out>) at lu.c:368

Any ideas, why this happens and how to fix it?

Thanks,
Shehab

--089e082f39c0c50e5e05678e69e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div><div><div><div>Hello Al=
l,<br><br></div>I am trying to instrument a <span class=3D"" style=3D"" id=
=3D":3qh.1" tabindex=3D"-1">pthread</span> application using the provided <=
span class=3D"" style=3D"" id=3D":3qh.2" tabindex=3D"-1">pthread</span> wra=
pper, but I sometimes run into a &quot;Double free or corruption error (<sp=
an class=3D"" style=3D"" id=3D":3qh.3" tabindex=3D"-1">fasttop</span>)&quot=
; error. <br><br></div>Here is a description of what I have tried and notic=
ed:<br></div>1- The problem isn&#39;t consistent. It sometimes happen and s=
ometimes works as expected.<br></div>2- From my experiments, the problem ha=
ppens (more frequently at least) when adding performance counter contexts (=
I tried cycles, <span class=3D"" style=3D"" id=3D":3qh.4" tabindex=3D"-1">c=
pu</span>_cycles and instructions).<br></div>3- I am testing using <span cl=
ass=3D"" style=3D"" id=3D":3qh.5" tabindex=3D"-1">lu</span>_<span class=3D"=
" style=3D"" id=3D":3qh.6" tabindex=3D"-1">ncb</span> from splash3 benchmar=
k suite after setting <span class=3D"" style=3D"" id=3D":3qh.7" tabindex=3D=
"-1">LD</span>_<span class=3D"" style=3D"" id=3D":3qh.8" tabindex=3D"-1">PR=
ELOAD</span> to use the <span class=3D"" style=3D"" id=3D":3qh.9" tabindex=
=3D"-1">pthread</span> wrapper as described in the <span class=3D"" style=
=3D"" id=3D":3qh.10" tabindex=3D"-1">LTTng</span> documents.<br></div>4- He=
re is the <span class=3D"" style=3D"" id=3D":3qh.11" tabindex=3D"-1">backtr=
ace</span> printed after exiting:<br>=3D=3D=3D=3D=3D=3D=3D <span class=3D""=
 style=3D"" id=3D":3qh.12" tabindex=3D"-1">Backtrace</span>: =3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>/lib64/<span class=3D"" style=3D"" id=3D":3qh.13" tabind=
ex=3D"-1">libc</span>.so.6([Thread 0x7ffff5611700 (<span class=3D"" style=
=3D"" id=3D":3qh.14" tabindex=3D"-1">LWP</span> 97229) exited]<br>/<span cl=
ass=3D"" style=3D"" id=3D":3qh.15" tabindex=3D"-1">usr</span>/local/lib/<sp=
an class=3D"" style=3D"" id=3D":3qh.16" tabindex=3D"-1">liblttng</span>-<sp=
an class=3D"" style=3D"" id=3D":3qh.17" tabindex=3D"-1">ust</span>.so.0(<sp=
an class=3D"" style=3D"" id=3D":3qh.18" tabindex=3D"-1">lttng</span>_destro=
y_context+0x35)[0x7ffff7471575]<br>/<span class=3D"" style=3D"" id=3D":3qh.=
19" tabindex=3D"-1">usr</span>/local/lib/<span class=3D"" style=3D"" id=3D"=
:3qh.20" tabindex=3D"-1">liblttng</span>-<span class=3D"" style=3D"" id=3D"=
:3qh.21" tabindex=3D"-1">ust</span>.so.0(<span class=3D"" style=3D"" id=3D"=
:3qh.22" tabindex=3D"-1">lttng</span>_session_destroy+0x21c)[0x7ffff747363c=
]<br>/<span class=3D"" style=3D"" id=3D":3qh.23" tabindex=3D"-1">usr</span>=
/local/lib/<span class=3D"" style=3D"" id=3D":3qh.24" tabindex=3D"-1">liblt=
tng</span>-<span class=3D"" style=3D"" id=3D":3qh.25" tabindex=3D"-1">ust</=
span>.so.0(+0x1e906)[0x7ffff746d906]<br>/<span class=3D"" style=3D"" id=3D"=
:3qh.26" tabindex=3D"-1">usr</span>/local/lib/<span class=3D"" style=3D"" i=
d=3D":3qh.27" tabindex=3D"-1">liblttng</span>-<span class=3D"" style=3D"" i=
d=3D":3qh.28" tabindex=3D"-1">ust</span>.so.0(<span class=3D"" style=3D"" i=
d=3D":3qh.29" tabindex=3D"-1">lttng</span>_<span class=3D"" style=3D"" id=
=3D":3qh.30" tabindex=3D"-1">ust</span>_<span class=3D"" style=3D"" id=3D":=
3qh.31" tabindex=3D"-1">objd</span>_<span class=3D"" style=3D"" id=3D":3qh.=
32" tabindex=3D"-1">unref</span>+0x9f)[0x7ffff746dccf]<br>/<span class=3D""=
 style=3D"" id=3D":3qh.33" tabindex=3D"-1">usr</span>/local/lib/<span class=
=3D"" style=3D"" id=3D":3qh.34" tabindex=3D"-1">liblttng</span>-<span class=
=3D"" style=3D"" id=3D":3qh.35" tabindex=3D"-1">ust</span>.so.0(<span class=
=3D"" style=3D"" id=3D":3qh.36" tabindex=3D"-1">lttng</span>_<span class=3D=
"" style=3D"" id=3D":3qh.37" tabindex=3D"-1">ust</span>_<span class=3D"" st=
yle=3D"" id=3D":3qh.38" tabindex=3D"-1">objd</span>_<span class=3D"" style=
=3D"" id=3D":3qh.39" tabindex=3D"-1">unref</span>+0x9f)[0x7ffff746dccf]<br>=
/<span class=3D"" style=3D"" id=3D":3qh.40" tabindex=3D"-1">usr</span>/loca=
l/lib/<span class=3D"" style=3D"" id=3D":3qh.41" tabindex=3D"-1">liblttng</=
span>-<span class=3D"" style=3D"" id=3D":3qh.42" tabindex=3D"-1">ust</span>=
.so.0(<span class=3D"" style=3D"" id=3D":3qh.43" tabindex=3D"-1">lttng</spa=
n>_<span class=3D"" style=3D"" id=3D":3qh.44" tabindex=3D"-1">ust</span>_<s=
pan class=3D"" style=3D"" id=3D":3qh.45" tabindex=3D"-1">objd</span>_<span =
class=3D"" style=3D"" id=3D":3qh.46" tabindex=3D"-1">unref</span>+0x9f)[0x7=
ffff746dccf]<br>/<span class=3D"" style=3D"" id=3D":3qh.47" tabindex=3D"-1"=
>usr</span>/local/lib/<span class=3D"" style=3D"" id=3D":3qh.48" tabindex=
=3D"-1">liblttng</span>-<span class=3D"" style=3D"" id=3D":3qh.49" tabindex=
=3D"-1">ust</span>.so.0(<span class=3D"" style=3D"" id=3D":3qh.50" tabindex=
=3D"-1">lttng</span>_<span class=3D"" style=3D"" id=3D":3qh.51" tabindex=3D=
"-1">ust</span>_<span class=3D"" style=3D"" id=3D":3qh.52" tabindex=3D"-1">=
abi</span>_exit+0x68)[0x7ffff746ead8]<br>/<span class=3D"" style=3D"" id=3D=
":3qh.53" tabindex=3D"-1">usr</span>/local/lib/<span class=3D"" style=3D"" =
id=3D":3qh.54" tabindex=3D"-1">liblttng</span>-<span class=3D"" style=3D"" =
id=3D":3qh.55" tabindex=3D"-1">ust</span>.so.0(+0x191d3)[0x7ffff74681d3]<br=
>/<span class=3D"" style=3D"" id=3D":3qh.56" tabindex=3D"-1">usr</span>/loc=
al/lib/<span class=3D"" style=3D"" id=3D":3qh.57" tabindex=3D"-1">liblttng<=
/span>-<span class=3D"" style=3D"" id=3D":3qh.58" tabindex=3D"-1">ust</span=
>.so.0(<span class=3D"" style=3D"" id=3D":3qh.59" tabindex=3D"-1">lttng</sp=
an>_<span class=3D"" style=3D"" id=3D":3qh.60" tabindex=3D"-1">ust</span>_e=
xit+0x67)[0x7ffff745ed57]<br>/lib64/<span class=3D"" style=3D"" id=3D":3qh.=
61" tabindex=3D"-1">ld</span>-<span class=3D"" style=3D"" id=3D":3qh.62" ta=
bindex=3D"-1">linux</span>-x86-64.so.2(+0xf85a)[0x7ffff7dec85a]<br>/lib64/<=
span class=3D"" style=3D"" id=3D":3qh.63" tabindex=3D"-1">libc</span>.so.6(=
+0x38a49)[0x7ffff6ca6a49]<br>/lib64/<span class=3D"" style=3D"" id=3D":3qh.=
64" tabindex=3D"-1">libc</span>.so.6(+0x38a95)[0x7ffff6ca6a95]<br>/<span cl=
ass=3D"" style=3D"" id=3D":3qh.65" tabindex=3D"-1">aenao</span>-99/elsayed9=
/<span class=3D"" style=3D"" id=3D":3qh.66" tabindex=3D"-1">LTTng</span>/da=
ta/scripts/<span class=3D"" style=3D"" id=3D":3qh.67" tabindex=3D"-1">tmp</=
span>/<span class=3D"" style=3D"" id=3D":3qh.68" tabindex=3D"-1">lu</span>_=
<span class=3D"" style=3D"" id=3D":3qh.69" tabindex=3D"-1">ncb</span>[0x401=
b51]<br>/lib64/<span class=3D"" style=3D"" id=3D":3qh.70" tabindex=3D"-1">l=
ibc</span>.so.6(__<span class=3D"" style=3D"" id=3D":3qh.71" tabindex=3D"-1=
">libc</span>_start_main+0xf5)[0x7ffff6c8fb35]<br>/<span class=3D"" style=
=3D"" id=3D":3qh.72" tabindex=3D"-1">aenao</span>-99/elsayed9/<span class=
=3D"" style=3D"" id=3D":3qh.73" tabindex=3D"-1">LTTng</span>/data/scripts/<=
span class=3D"" style=3D"" id=3D":3qh.74" tabindex=3D"-1">tmp</span>/<span =
class=3D"" style=3D"" id=3D":3qh.75" tabindex=3D"-1">lu</span>_<span class=
=3D"" style=3D"" id=3D":3qh.76" tabindex=3D"-1">ncb</span>[0x401c44]<br></d=
iv>5- Also, this is a <span class=3D"" style=3D"" id=3D":3qh.77" tabindex=
=3D"-1">backtrace</span> I obtained from <span class=3D"" style=3D"" id=3D"=
:3qh.78" tabindex=3D"-1">gdb</span>:<br>#0=C2=A0 0x00007ffff6eac1d7 in rais=
e () from /lib64/<span class=3D"" style=3D"" id=3D":3qh.79" tabindex=3D"-1"=
>libc</span>.so.6<br>#1=C2=A0 0x00007ffff6ead8c8 in abort () from /lib64/<s=
pan class=3D"" style=3D"" id=3D":3qh.80" tabindex=3D"-1">libc</span>.so.6<b=
r>#2=C2=A0 0x00007ffff6eebf07 in __<span class=3D"" style=3D"" id=3D":3qh.8=
1" tabindex=3D"-1">libc</span>_message () from /lib64/<span class=3D"" styl=
e=3D"" id=3D":3qh.82" tabindex=3D"-1">libc</span>.so.6<br>#3=C2=A0 0x00007f=
fff6ef3503 in _int_free () from /lib64/<span class=3D"" style=3D"" id=3D":3=
qh.83" tabindex=3D"-1">libc</span>.so.6<br>#4=C2=A0 0x00007ffff768ad25 in <=
span class=3D"" style=3D"" id=3D":3qh.84" tabindex=3D"-1">lttng</span>_dest=
roy_<span class=3D"" style=3D"" id=3D":3qh.85" tabindex=3D"-1">perf</span>_=
counter_field (<br>=C2=A0=C2=A0=C2=A0 field=3D&lt;optimized out&gt;) at <sp=
an class=3D"" style=3D"" id=3D":3qh.86" tabindex=3D"-1">lttng</span>-contex=
t-<span class=3D"" style=3D"" id=3D":3qh.87" tabindex=3D"-1">perf</span>-co=
unters.c:418<br>#5=C2=A0 0x00007ffff767a575 in <span class=3D"" style=3D"" =
id=3D":3qh.88" tabindex=3D"-1">lttng</span>_destroy_context (<br>=C2=A0=C2=
=A0=C2=A0 <span class=3D"" style=3D"" id=3D":3qh.89" tabindex=3D"-1">ctx</s=
pan>=3D0x7ffff0011090) at <span class=3D"" style=3D"" id=3D":3qh.90" tabind=
ex=3D"-1">lttng</span>-context.c:278<br>#6=C2=A0 0x00007ffff767c63c in _<sp=
an class=3D"" style=3D"" id=3D":3qh.91" tabindex=3D"-1">lttng</span>_channe=
l_<span class=3D"" style=3D"" id=3D":3qh.92" tabindex=3D"-1">unmap</span> (=
<br>=C2=A0=C2=A0=C2=A0 <span class=3D"" style=3D"" id=3D":3qh.93" tabindex=
=3D"-1">lttng</span>_<span class=3D"" style=3D"" id=3D":3qh.94" tabindex=3D=
"-1">chan</span>=3D0x7ffff0010f40) at <span class=3D"" style=3D"" id=3D":3q=
h.95" tabindex=3D"-1">lttng</span>-events.c:172<br>#7=C2=A0 <span class=3D"=
" style=3D"" id=3D":3qh.96" tabindex=3D"-1">lttng</span>_session_destroy (s=
ession=3D0x7ffff0000900)<br>=C2=A0=C2=A0=C2=A0 at <span class=3D"" style=3D=
"" id=3D":3qh.97" tabindex=3D"-1">lttng</span>-events.c:247<br>#8=C2=A0 0x0=
0007ffff7676906 in <span class=3D"" style=3D"" id=3D":3qh.98" tabindex=3D"-=
1">lttng</span>_release_session (<br>=C2=A0=C2=A0=C2=A0 <span class=3D"" st=
yle=3D"" id=3D":3qh.99" tabindex=3D"-1">objd</span>=3D&lt;optimized out&gt;=
) at <span class=3D"" style=3D"" id=3D":3qh.100" tabindex=3D"-1">lttng</spa=
n>-<span class=3D"" style=3D"" id=3D":3qh.101" tabindex=3D"-1">ust</span>-<=
span class=3D"" style=3D"" id=3D":3qh.102" tabindex=3D"-1">abi</span>.c:601=
<br>#9=C2=A0 0x00007ffff7676ccf in <span class=3D"" style=3D"" id=3D":3qh.1=
03" tabindex=3D"-1">lttng</span>_<span class=3D"" style=3D"" id=3D":3qh.104=
" tabindex=3D"-1">ust</span>_<span class=3D"" style=3D"" id=3D":3qh.105" ta=
bindex=3D"-1">objd</span>_<span class=3D"" style=3D"" id=3D":3qh.106" tabin=
dex=3D"-1">unref</span> (id=3D1, <br>=C2=A0=C2=A0=C2=A0 is_owner=3D&lt;opti=
mized out&gt;) at <span class=3D"" style=3D"" id=3D":3qh.107" tabindex=3D"-=
1">lttng</span>-<span class=3D"" style=3D"" id=3D":3qh.108" tabindex=3D"-1"=
>ust</span>-<span class=3D"" style=3D"" id=3D":3qh.109" tabindex=3D"-1">abi=
</span>.c:216<br>#10 0x00007ffff7676ccf in <span class=3D"" style=3D"" id=
=3D":3qh.110" tabindex=3D"-1">lttng</span>_<span class=3D"" style=3D"" id=
=3D":3qh.111" tabindex=3D"-1">ust</span>_<span class=3D"" style=3D"" id=3D"=
:3qh.112" tabindex=3D"-1">objd</span>_<span class=3D"" style=3D"" id=3D":3q=
h.113" tabindex=3D"-1">unref</span> (id=3D2, <br>=C2=A0=C2=A0=C2=A0 is_owne=
r=3D&lt;optimized out&gt;) at <span class=3D"" style=3D"" id=3D":3qh.114" t=
abindex=3D"-1">lttng</span>-<span class=3D"" style=3D"" id=3D":3qh.115" tab=
index=3D"-1">ust</span>-<span class=3D"" style=3D"" id=3D":3qh.116" tabinde=
x=3D"-1">abi</span>.c:216<br>#11 0x00007ffff7676ccf in <span class=3D"" sty=
le=3D"" id=3D":3qh.117" tabindex=3D"-1">lttng</span>_<span class=3D"" style=
=3D"" id=3D":3qh.118" tabindex=3D"-1">ust</span>_<span class=3D"" style=3D"=
" id=3D":3qh.119" tabindex=3D"-1">objd</span>_<span class=3D"" style=3D"" i=
d=3D":3qh.120" tabindex=3D"-1">unref</span> (id=3Did@entry=3D18, <br>=C2=A0=
=C2=A0=C2=A0 is_owner=3Dis_owner@entry=3D1) at <span class=3D"" style=3D"" =
id=3D":3qh.121" tabindex=3D"-1">lttng</span>-<span class=3D"" style=3D"" id=
=3D":3qh.122" tabindex=3D"-1">ust</span>-<span class=3D"" style=3D"" id=3D"=
:3qh.123" tabindex=3D"-1">abi</span>.c:216<br>#12 0x00007ffff7677ad8 in <sp=
an class=3D"" style=3D"" id=3D":3qh.124" tabindex=3D"-1">objd</span>_table_=
destroy ()<br>=C2=A0=C2=A0=C2=A0 at <span class=3D"" style=3D"" id=3D":3qh.=
125" tabindex=3D"-1">lttng</span>-<span class=3D"" style=3D"" id=3D":3qh.12=
6" tabindex=3D"-1">ust</span>-<span class=3D"" style=3D"" id=3D":3qh.127" t=
abindex=3D"-1">abi</span>.c:235<br>#13 <span class=3D"" style=3D"" id=3D":3=
qh.128" tabindex=3D"-1">lttng</span>_<span class=3D"" style=3D"" id=3D":3qh=
.129" tabindex=3D"-1">ust</span>_<span class=3D"" style=3D"" id=3D":3qh.130=
" tabindex=3D"-1">abi</span>_exit () at <span class=3D"" style=3D"" id=3D":=
3qh.131" tabindex=3D"-1">lttng</span>-<span class=3D"" style=3D"" id=3D":3q=
h.132" tabindex=3D"-1">ust</span>-<span class=3D"" style=3D"" id=3D":3qh.13=
3" tabindex=3D"-1">abi</span>.c:1002<br>#14 0x00007ffff76711d3 in <span cla=
ss=3D"" style=3D"" id=3D":3qh.134" tabindex=3D"-1">lttng</span>_<span class=
=3D"" style=3D"" id=3D":3qh.135" tabindex=3D"-1">ust</span>_cleanup (exitin=
g=3D1)<br>=C2=A0=C2=A0=C2=A0 at <span class=3D"" style=3D"" id=3D":3qh.136"=
 tabindex=3D"-1">lttng</span>-<span class=3D"" style=3D"" id=3D":3qh.137" t=
abindex=3D"-1">ust</span>-comm.c:1807<br>#15 0x00007ffff7667d57 in <span cl=
ass=3D"" style=3D"" id=3D":3qh.138" tabindex=3D"-1">lttng</span>_<span clas=
s=3D"" style=3D"" id=3D":3qh.139" tabindex=3D"-1">ust</span>_exit ()<br>=C2=
=A0=C2=A0=C2=A0 at <span class=3D"" style=3D"" id=3D":3qh.140" tabindex=3D"=
-1">lttng</span>-<span class=3D"" style=3D"" id=3D":3qh.141" tabindex=3D"-1=
">ust</span>-comm.c:1874<br>#16 0x00007ffff7dec85a in _<span class=3D"" sty=
le=3D"" id=3D":3qh.142" tabindex=3D"-1">dl</span>_<span class=3D"" style=3D=
"" id=3D":3qh.143" tabindex=3D"-1">fini</span> ()<br>=C2=A0=C2=A0 from /lib=
64/<span class=3D"" style=3D"" id=3D":3qh.144" tabindex=3D"-1">ld</span>-<s=
pan class=3D"" style=3D"" id=3D":3qh.145" tabindex=3D"-1">linux</span>-x86-=
64.so.2<br>#17 0x00007ffff6eafa49 in __run_exit_handlers ()<br>=C2=A0=C2=A0=
 from /lib64/<span class=3D"" style=3D"" id=3D":3qh.146" tabindex=3D"-1">li=
bc</span>.so.6<br>#18 0x00007ffff6eafa95 in exit () from /lib64/<span class=
=3D"" style=3D"" id=3D":3qh.147" tabindex=3D"-1">libc</span>.so.6<br>#19 0x=
0000000000401b51 in main (<span class=3D"" style=3D"" id=3D":3qh.148" tabin=
dex=3D"-1">argc</span>=3D&lt;optimized out&gt;, <br>=C2=A0=C2=A0=C2=A0 <spa=
n class=3D"" style=3D"" id=3D":3qh.149" tabindex=3D"-1">argv</span>=3D&lt;o=
ptimized out&gt;) at <span class=3D"" style=3D"" id=3D":3qh.150" tabindex=
=3D"-1">lu</span>.c:368<br><br></div>Any ideas, why this happens and how to=
 fix it?<br><br></div>Thanks,<br></div><span class=3D"" style=3D"" id=3D":3=
qh.151" tabindex=3D"-1">Shehab</span><br><div><div><div><div><br><br></div>=
</div></div></div></div>

--089e082f39c0c50e5e05678e69e8--

--===============4133489937848883062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4133489937848883062==--
