From: Shehab Elsayed <shehabyomn@gmail.com>
Subject: Re: Double free or corruption error (fasttop)
Date: Mon, 19 Mar 2018 12:36:42 -0400
Message-ID: <CAC-H6tvncER6tVg7=fi+bk9CiU8h-wKnhOLSo3SQdrofPUmXsw__10060.010609641$1521477293$gmane$org@mail.gmail.com>
References: <CAC-H6ttMF-CjzDH7a6bmeoOPP8JRLptYTmGJVvrx5t-G0Se_gA@mail.gmail.com>
 <226204243.12548.1521476487812.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4979295052555962061=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com
 [IPv6:2a00:1450:4010:c07::242])
 by lists.lttng.org (Postfix) with ESMTPS id 404hXs4QFpznBp
 for <lttng-dev@lists.lttng.org>; Mon, 19 Mar 2018 12:36:45 -0400 (EDT)
Received: by mail-lf0-x242.google.com with SMTP id y2-v6so24293982lfc.5
 for <lttng-dev@lists.lttng.org>; Mon, 19 Mar 2018 09:36:45 -0700 (PDT)
In-Reply-To: <226204243.12548.1521476487812.JavaMail.zimbra@efficios.com>
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

--===============4979295052555962061==
Content-Type: multipart/alternative; boundary="0000000000002c94030567c69046"

--0000000000002c94030567c69046
Content-Type: text/plain; charset="UTF-8"

Hi Mathieu,

Thank you very much for your reply.

I manually built lttng-ust from source (commit #:
8a208943e21700211beee3ea64180a5a534c7d2a).

This is how I set up the tracing session:
1- lttng create lu_ncb_8_native -o {path}
2- lttng enable-event --userspace lttng_ust_pthread:pthread_mutex_lock_req
    lttng enable-event --userspace lttng_ust_pthread:pthread_mutex_lock_acq
    lttng enable-event --userspace
lttng_ust_pthread:pthread_mutex_lock_trylock
    lttng enable-event --userspace
lttng_ust_pthread:pthread_mutex_lock_unlock
3- lttng add-context -u -t procname
    lttng add-context -u -t vpid
    lttng add-context -u -t pthread_id
    lttng add-context -u -t vtid
    lttng add-context -u -t ip
    lttng add-context -u -t perf:thread:cpu-cycles
    lttng add-context -u -t perf:thread:cycles
    lttng add-context -u -t perf:thread:instructions
4- lttng start
5- LD_PRELOAD=/usr/local/lib/liblttng-ust-pthread-wrapper.so ./lu_ncb -p8
-n8096 -b32
6- lttng stop
7- lttng destroy



Shehab Y. Elsayed, MSc.
PhD Student
The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
University of Toronto
E-mail: shehabyomn@gmail.com
<https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>

On Mon, Mar 19, 2018 at 12:21 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

>
>
> ----- On Mar 16, 2018, at 5:37 PM, Shehab Elsayed <shehabyomn@gmail.com>
> wrote:
>
> Hello All,
>
> I am trying to instrument a pthread application using the provided pthread
> wrapper, but I sometimes run into a "Double free or corruption error (
> fasttop)" error.
>
>
> Please provide more information about the version of lttng-ust you are
> using, and how you setup
> your tracing session.
>
> Thanks,
>
> Mathieu
>
>
>
> Here is a description of what I have tried and noticed:
> 1- The problem isn't consistent. It sometimes happen and sometimes works
> as expected.
> 2- From my experiments, the problem happens (more frequently at least)
> when adding performance counter contexts (I tried cycles, cpu_cycles and
> instructions).
> 3- I am testing using lu_ncb from splash3 benchmark suite after setting LD
> _PRELOAD to use the pthread wrapper as described in the LTTng documents.
> 4- Here is the backtrace printed after exiting:
> ======= Backtrace: =========
> /lib64/libc.so.6([Thread 0x7ffff5611700 (LWP 97229) exited]
> /usr/local/lib/liblttng-ust.so.0(lttng_destroy_context+
> 0x35)[0x7ffff7471575]
> /usr/local/lib/liblttng-ust.so.0(lttng_session_destroy+
> 0x21c)[0x7ffff747363c]
> /usr/local/lib/liblttng-ust.so.0(+0x1e906)[0x7ffff746d906]
> /usr/local/lib/liblttng-ust.so.0(lttng_ust_objd_unref+
> 0x9f)[0x7ffff746dccf]
> /usr/local/lib/liblttng-ust.so.0(lttng_ust_objd_unref+
> 0x9f)[0x7ffff746dccf]
> /usr/local/lib/liblttng-ust.so.0(lttng_ust_objd_unref+
> 0x9f)[0x7ffff746dccf]
> /usr/local/lib/liblttng-ust.so.0(lttng_ust_abi_exit+0x68)[0x7ffff746ead8]
> /usr/local/lib/liblttng-ust.so.0(+0x191d3)[0x7ffff74681d3]
> /usr/local/lib/liblttng-ust.so.0(lttng_ust_exit+0x67)[0x7ffff745ed57]
> /lib64/ld-linux-x86-64.so.2(+0xf85a)[0x7ffff7dec85a]
> /lib64/libc.so.6(+0x38a49)[0x7ffff6ca6a49]
> /lib64/libc.so.6(+0x38a95)[0x7ffff6ca6a95]
> /aenao-99/elsayed9/LTTng/data/scripts/tmp/lu_ncb[0x401b51]
> /lib64/libc.so.6(__libc_start_main+0xf5)[0x7ffff6c8fb35]
> /aenao-99/elsayed9/LTTng/data/scripts/tmp/lu_ncb[0x401c44]
> 5- Also, this is a backtrace I obtained from gdb:
> #0  0x00007ffff6eac1d7 in raise () from /lib64/libc.so.6
> #1  0x00007ffff6ead8c8 in abort () from /lib64/libc.so.6
> #2  0x00007ffff6eebf07 in __libc_message () from /lib64/libc.so.6
> #3  0x00007ffff6ef3503 in _int_free () from /lib64/libc.so.6
> #4  0x00007ffff768ad25 in lttng_destroy_perf_counter_field (
>     field=<optimized out>) at lttng-context-perf-counters.c:418
> #5  0x00007ffff767a575 in lttng_destroy_context (
> ctx=0x7ffff0011090) at lttng-context.c:278
> #6  0x00007ffff767c63c in _lttng_channel_unmap (
> lttng_chan=0x7ffff0010f40) at lttng-events.c:172
> #7  lttng_session_destroy (session=0x7ffff0000900)
>     at lttng-events.c:247
> #8  0x00007ffff7676906 in lttng_release_session (
> objd=<optimized out>) at lttng-ust-abi.c:601
> #9  0x00007ffff7676ccf in lttng_ust_objd_unref (id=1,
>     is_owner=<optimized out>) at lttng-ust-abi.c:216
> #10 0x00007ffff7676ccf in lttng_ust_objd_unref (id=2,
>     is_owner=<optimized out>) at lttng-ust-abi.c:216
> #11 0x00007ffff7676ccf in lttng_ust_objd_unref (id=id@entry=18,
>     is_owner=is_owner@entry=1) at lttng-ust-abi.c:216
> #12 0x00007ffff7677ad8 in objd_table_destroy ()
>     at lttng-ust-abi.c:235
> #13 lttng_ust_abi_exit () at lttng-ust-abi.c:1002
> #14 0x00007ffff76711d3 in lttng_ust_cleanup (exiting=1)
>     at lttng-ust-comm.c:1807
> #15 0x00007ffff7667d57 in lttng_ust_exit ()
>     at lttng-ust-comm.c:1874
> #16 0x00007ffff7dec85a in _dl_fini ()
>    from /lib64/ld-linux-x86-64.so.2
> #17 0x00007ffff6eafa49 in __run_exit_handlers ()
>    from /lib64/libc.so.6
> #18 0x00007ffff6eafa95 in exit () from /lib64/libc.so.6
> #19 0x0000000000401b51 in main (argc=<optimized out>,
> argv=<optimized out>) at lu.c:368
>
> Any ideas, why this happens and how to fix it?
>
> Thanks,
> Shehab
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--0000000000002c94030567c69046
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div>Hi Mathieu,<br><br>Than=
k you very much for your reply.<br><br>I manually built lttng-ust from sour=
ce (commit #: 8a208943e21700211beee3ea64180a5a534c7d2a).<br><br></div>This =
is how I set up the tracing session:<br></div>1- lttng create lu_ncb_8_nati=
ve -o {path}<br></div>2- lttng enable-event --userspace lttng_ust_pthread:p=
thread_mutex_lock_req<br>=C2=A0=C2=A0=C2=A0 lttng enable-event --userspace =
lttng_ust_pthread:pthread_mutex_lock_acq<br>=C2=A0=C2=A0=C2=A0 lttng enable=
-event --userspace lttng_ust_pthread:pthread_mutex_lock_trylock<br>=C2=A0=
=C2=A0=C2=A0 lttng enable-event --userspace lttng_ust_pthread:pthread_mutex=
_lock_unlock<br></div>3- lttng add-context -u -t procname<br>=C2=A0=C2=A0=
=C2=A0 lttng add-context -u -t vpid<br>=C2=A0=C2=A0=C2=A0  lttng add-contex=
t -u -t pthread_id<br>=C2=A0=C2=A0=C2=A0  lttng add-context -u -t vtid<br>=
=C2=A0=C2=A0=C2=A0  lttng add-context -u -t ip<br>=C2=A0=C2=A0=C2=A0  lttng=
 add-context -u -t perf:thread:cpu-cycles<br>=C2=A0=C2=A0=C2=A0  lttng add-=
context -u -t perf:thread:cycles<br>=C2=A0=C2=A0=C2=A0  lttng add-context -=
u -t perf:thread:instructions<br></div>4- lttng start<br>5- LD_PRELOAD=3D/u=
sr/local/lib/liblttng-ust-pthread-wrapper.so ./lu_ncb -p8 -n8096 -b32<br></=
div>6- lttng stop<br></div>7- lttng destroy<br><br><div><div><div><div>=C2=
=A0=C2=A0=C2=A0 <br></div></div></div></div></div><div class=3D"gmail_extra=
"><br clear=3D"all"><div><div class=3D"gmail_signature" data-smartmail=3D"g=
mail_signature"><div dir=3D"ltr"><font color=3D"#888888">Shehab Y. Elsayed,=
 MSc.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </font><font color=3D"#888888"><a value=
=3D"+20124498360"><span dir=3D"ltr"></span></a><br>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></font></div></=
div></div>
<br><div class=3D"gmail_quote">On Mon, Mar 19, 2018 at 12:21 PM, Mathieu De=
snoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.=
com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-family:arial,hel=
vetica,sans-serif;font-size:12pt;color:#000000"><span class=3D""><div><br><=
/div><div><br></div><div><span id=3D"m_-3928334406880738982zwchr">----- On =
Mar 16, 2018, at 5:37 PM, Shehab Elsayed &lt;<a href=3D"mailto:shehabyomn@g=
mail.com" target=3D"_blank">shehabyomn@gmail.com</a>&gt; wrote:<br></span><=
/div></span><div><span class=3D""><blockquote style=3D"border-left:2px soli=
d #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;fo=
nt-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif=
;font-size:12pt"><div dir=3D"ltr"><div><div><div><div><div><div><div><div><=
div><div>Hello All,<br><br></div>I am trying to instrument a <span id=3D"m_=
-3928334406880738982:3qh.1">pthread</span> application using the provided <=
span id=3D"m_-3928334406880738982:3qh.2">pthread</span> wrapper, but I some=
times run into a &quot;Double free or corruption error (<span id=3D"m_-3928=
334406880738982:3qh.3">fasttop</span>)&quot; error. </div></div></div></div=
></div></div></div></div></div></div></blockquote><div><br></div></span><di=
v>Please provide more information about the version of lttng-ust you are us=
ing, and how you setup<br></div><div>your tracing session.<br></div><div><b=
r></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div><br=
></div><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;p=
adding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decora=
tion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div><div =
class=3D"h5"><div dir=3D"ltr"><div><div><div><div><div><div><div><div><div>=
<br><br></div>Here is a description of what I have tried and noticed:<br></=
div>1- The problem isn&#39;t consistent. It sometimes happen and sometimes =
works as expected.<br></div>2- From my experiments, the problem happens (mo=
re frequently at least) when adding performance counter contexts (I tried c=
ycles, <span id=3D"m_-3928334406880738982:3qh.4">cpu</span>_cycles and inst=
ructions).<br></div>3- I am testing using <span id=3D"m_-392833440688073898=
2:3qh.5">lu</span>_<span id=3D"m_-3928334406880738982:3qh.6">ncb</span> fro=
m splash3 benchmark suite after setting <span id=3D"m_-3928334406880738982:=
3qh.7">LD</span>_<span id=3D"m_-3928334406880738982:3qh.8">PRELOAD</span> t=
o use the <span id=3D"m_-3928334406880738982:3qh.9">pthread</span> wrapper =
as described in the <span id=3D"m_-3928334406880738982:3qh.10">LTTng</span>=
 documents.<br></div>4- Here is the <span id=3D"m_-3928334406880738982:3qh.=
11">backtrace</span> printed after exiting:<br>=3D=3D=3D=3D=3D=3D=3D <span =
id=3D"m_-3928334406880738982:3qh.12">Backtrace</span>: =3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>/lib64/<span id=3D"m_-3928334406880738982:3qh.13">libc</span>.=
so.6([Thread 0x7ffff5611700 (<span id=3D"m_-3928334406880738982:3qh.14">LWP=
</span> 97229) exited]<br>/<span id=3D"m_-3928334406880738982:3qh.15">usr</=
span>/local/lib/<span id=3D"m_-3928334406880738982:3qh.16">liblttng</span>-=
<span id=3D"m_-3928334406880738982:3qh.17">ust</span>.<wbr>so.0(<span id=3D=
"m_-3928334406880738982:3qh.18">lttng</span>_destroy_context+<wbr>0x35)[0x7=
ffff7471575]<br>/<span id=3D"m_-3928334406880738982:3qh.19">usr</span>/loca=
l/lib/<span id=3D"m_-3928334406880738982:3qh.20">liblttng</span>-<span id=
=3D"m_-3928334406880738982:3qh.21">ust</span>.<wbr>so.0(<span id=3D"m_-3928=
334406880738982:3qh.22">lttng</span>_session_destroy+<wbr>0x21c)[0x7ffff747=
363c]<br>/<span id=3D"m_-3928334406880738982:3qh.23">usr</span>/local/lib/<=
span id=3D"m_-3928334406880738982:3qh.24">liblttng</span>-<span id=3D"m_-39=
28334406880738982:3qh.25">ust</span>.<wbr>so.0(+0x1e906)[0x7ffff746d906]<br=
>/<span id=3D"m_-3928334406880738982:3qh.26">usr</span>/local/lib/<span id=
=3D"m_-3928334406880738982:3qh.27">liblttng</span>-<span id=3D"m_-392833440=
6880738982:3qh.28">ust</span>.<wbr>so.0(<span id=3D"m_-3928334406880738982:=
3qh.29">lttng</span>_<span id=3D"m_-3928334406880738982:3qh.30">ust</span>_=
<span id=3D"m_-3928334406880738982:3qh.31">objd</span>_<span id=3D"m_-39283=
34406880738982:3qh.32">unref</span>+<wbr>0x9f)[0x7ffff746dccf]<br>/<span id=
=3D"m_-3928334406880738982:3qh.33">usr</span>/local/lib/<span id=3D"m_-3928=
334406880738982:3qh.34">liblttng</span>-<span id=3D"m_-3928334406880738982:=
3qh.35">ust</span>.<wbr>so.0(<span id=3D"m_-3928334406880738982:3qh.36">ltt=
ng</span>_<span id=3D"m_-3928334406880738982:3qh.37">ust</span>_<span id=3D=
"m_-3928334406880738982:3qh.38">objd</span>_<span id=3D"m_-3928334406880738=
982:3qh.39">unref</span>+<wbr>0x9f)[0x7ffff746dccf]<br>/<span id=3D"m_-3928=
334406880738982:3qh.40">usr</span>/local/lib/<span id=3D"m_-392833440688073=
8982:3qh.41">liblttng</span>-<span id=3D"m_-3928334406880738982:3qh.42">ust=
</span>.<wbr>so.0(<span id=3D"m_-3928334406880738982:3qh.43">lttng</span>_<=
span id=3D"m_-3928334406880738982:3qh.44">ust</span>_<span id=3D"m_-3928334=
406880738982:3qh.45">objd</span>_<span id=3D"m_-3928334406880738982:3qh.46"=
>unref</span>+<wbr>0x9f)[0x7ffff746dccf]<br>/<span id=3D"m_-392833440688073=
8982:3qh.47">usr</span>/local/lib/<span id=3D"m_-3928334406880738982:3qh.48=
">liblttng</span>-<span id=3D"m_-3928334406880738982:3qh.49">ust</span>.<wb=
r>so.0(<span id=3D"m_-3928334406880738982:3qh.50">lttng</span>_<span id=3D"=
m_-3928334406880738982:3qh.51">ust</span>_<span id=3D"m_-392833440688073898=
2:3qh.52">abi</span>_exit+0x68)[<wbr>0x7ffff746ead8]<br>/<span id=3D"m_-392=
8334406880738982:3qh.53">usr</span>/local/lib/<span id=3D"m_-39283344068807=
38982:3qh.54">liblttng</span>-<span id=3D"m_-3928334406880738982:3qh.55">us=
t</span>.<wbr>so.0(+0x191d3)[0x7ffff74681d3]<br>/<span id=3D"m_-39283344068=
80738982:3qh.56">usr</span>/local/lib/<span id=3D"m_-3928334406880738982:3q=
h.57">liblttng</span>-<span id=3D"m_-3928334406880738982:3qh.58">ust</span>=
.<wbr>so.0(<span id=3D"m_-3928334406880738982:3qh.59">lttng</span>_<span id=
=3D"m_-3928334406880738982:3qh.60">ust</span>_exit+0x67)[<wbr>0x7ffff745ed5=
7]<br>/lib64/<span id=3D"m_-3928334406880738982:3qh.61">ld</span>-<span id=
=3D"m_-3928334406880738982:3qh.62">linux</span>-x86-64.so.2(+<wbr>0xf85a)[0=
x7ffff7dec85a]<br>/lib64/<span id=3D"m_-3928334406880738982:3qh.63">libc</s=
pan>.so.6(+0x38a49)[<wbr>0x7ffff6ca6a49]<br>/lib64/<span id=3D"m_-392833440=
6880738982:3qh.64">libc</span>.so.6(+0x38a95)[<wbr>0x7ffff6ca6a95]<br>/<spa=
n id=3D"m_-3928334406880738982:3qh.65">aenao</span>-99/elsayed9/<span id=3D=
"m_-3928334406880738982:3qh.66">LTTng</span>/data/<wbr>scripts/<span id=3D"=
m_-3928334406880738982:3qh.67">tmp</span>/<span id=3D"m_-392833440688073898=
2:3qh.68">lu</span>_<span id=3D"m_-3928334406880738982:3qh.69">ncb</span>[0=
x401b51]<br>/lib64/<span id=3D"m_-3928334406880738982:3qh.70">libc</span>.s=
o.6(__<span id=3D"m_-3928334406880738982:3qh.71">libc</span>_start_<wbr>mai=
n+0xf5)[0x7ffff6c8fb35]<br>/<span id=3D"m_-3928334406880738982:3qh.72">aena=
o</span>-99/elsayed9/<span id=3D"m_-3928334406880738982:3qh.73">LTTng</span=
>/data/<wbr>scripts/<span id=3D"m_-3928334406880738982:3qh.74">tmp</span>/<=
span id=3D"m_-3928334406880738982:3qh.75">lu</span>_<span id=3D"m_-39283344=
06880738982:3qh.76">ncb</span>[0x401c44]<br></div>5- Also, this is a <span =
id=3D"m_-3928334406880738982:3qh.77">backtrace</span> I obtained from <span=
 id=3D"m_-3928334406880738982:3qh.78">gdb</span>:<br>#0=C2=A0 0x00007ffff6e=
ac1d7 in raise () from /lib64/<span id=3D"m_-3928334406880738982:3qh.79">li=
bc</span>.so.6<br>#1=C2=A0 0x00007ffff6ead8c8 in abort () from /lib64/<span=
 id=3D"m_-3928334406880738982:3qh.80">libc</span>.so.6<br>#2=C2=A0 0x00007f=
fff6eebf07 in __<span id=3D"m_-3928334406880738982:3qh.81">libc</span>_mess=
age () from /lib64/<span id=3D"m_-3928334406880738982:3qh.82">libc</span>.s=
o.6<br>#3=C2=A0 0x00007ffff6ef3503 in _int_free () from /lib64/<span id=3D"=
m_-3928334406880738982:3qh.83">libc</span>.so.6<br>#4=C2=A0 0x00007ffff768a=
d25 in <span id=3D"m_-3928334406880738982:3qh.84">lttng</span>_destroy_<spa=
n id=3D"m_-3928334406880738982:3qh.85">perf</span>_counter_<wbr>field (<br>=
=C2=A0=C2=A0=C2=A0 field=3D&lt;optimized out&gt;) at <span id=3D"m_-3928334=
406880738982:3qh.86">lttng</span>-context-<span id=3D"m_-392833440688073898=
2:3qh.87">perf</span>-counters.c:<wbr>418<br>#5=C2=A0 0x00007ffff767a575 in=
 <span id=3D"m_-3928334406880738982:3qh.88">lttng</span>_destroy_context (<=
br><span id=3D"m_-3928334406880738982:3qh.89">ctx</span>=3D0x7ffff0011090) =
at <span id=3D"m_-3928334406880738982:3qh.90">lttng</span>-context.c:278<br=
>#6=C2=A0 0x00007ffff767c63c in _<span id=3D"m_-3928334406880738982:3qh.91"=
>lttng</span>_channel_<span id=3D"m_-3928334406880738982:3qh.92">unmap</spa=
n> (<br><span id=3D"m_-3928334406880738982:3qh.93">lttng</span>_<span id=3D=
"m_-3928334406880738982:3qh.94">chan</span>=3D0x7ffff0010f40) at <span id=
=3D"m_-3928334406880738982:3qh.95">lttng</span>-events.c:172<br>#7=C2=A0 <s=
pan id=3D"m_-3928334406880738982:3qh.96">lttng</span>_session_destroy (sess=
ion=3D0x7ffff0000900)<br>=C2=A0=C2=A0=C2=A0 at <span id=3D"m_-3928334406880=
738982:3qh.97">lttng</span>-events.c:247<br>#8=C2=A0 0x00007ffff7676906 in =
<span id=3D"m_-3928334406880738982:3qh.98">lttng</span>_release_session (<b=
r><span id=3D"m_-3928334406880738982:3qh.99">objd</span>=3D&lt;optimized ou=
t&gt;) at <span id=3D"m_-3928334406880738982:3qh.100">lttng</span>-<span id=
=3D"m_-3928334406880738982:3qh.101">ust</span>-<span id=3D"m_-3928334406880=
738982:3qh.102">abi</span>.c:601<br>#9=C2=A0 0x00007ffff7676ccf in <span id=
=3D"m_-3928334406880738982:3qh.103">lttng</span>_<span id=3D"m_-39283344068=
80738982:3qh.104">ust</span>_<span id=3D"m_-3928334406880738982:3qh.105">ob=
jd</span>_<span id=3D"m_-3928334406880738982:3qh.106">unref</span> (id=3D1,=
 <br>=C2=A0=C2=A0=C2=A0 is_owner=3D&lt;optimized out&gt;) at <span id=3D"m_=
-3928334406880738982:3qh.107">lttng</span>-<span id=3D"m_-39283344068807389=
82:3qh.108">ust</span>-<span id=3D"m_-3928334406880738982:3qh.109">abi</spa=
n>.c:216<br>#10 0x00007ffff7676ccf in <span id=3D"m_-3928334406880738982:3q=
h.110">lttng</span>_<span id=3D"m_-3928334406880738982:3qh.111">ust</span>_=
<span id=3D"m_-3928334406880738982:3qh.112">objd</span>_<span id=3D"m_-3928=
334406880738982:3qh.113">unref</span> (id=3D2, <br>=C2=A0=C2=A0=C2=A0 is_ow=
ner=3D&lt;optimized out&gt;) at <span id=3D"m_-3928334406880738982:3qh.114"=
>lttng</span>-<span id=3D"m_-3928334406880738982:3qh.115">ust</span>-<span =
id=3D"m_-3928334406880738982:3qh.116">abi</span>.c:216<br>#11 0x00007ffff76=
76ccf in <span id=3D"m_-3928334406880738982:3qh.117">lttng</span>_<span id=
=3D"m_-3928334406880738982:3qh.118">ust</span>_<span id=3D"m_-3928334406880=
738982:3qh.119">objd</span>_<span id=3D"m_-3928334406880738982:3qh.120">unr=
ef</span> (id=3Did@entry=3D18, <br>=C2=A0=C2=A0=C2=A0 is_owner=3Dis_owner@e=
ntry=3D1) at <span id=3D"m_-3928334406880738982:3qh.121">lttng</span>-<span=
 id=3D"m_-3928334406880738982:3qh.122">ust</span>-<span id=3D"m_-3928334406=
880738982:3qh.123">abi</span>.c:216<br>#12 0x00007ffff7677ad8 in <span id=
=3D"m_-3928334406880738982:3qh.124">objd</span>_table_destroy ()<br>=C2=A0=
=C2=A0=C2=A0 at <span id=3D"m_-3928334406880738982:3qh.125">lttng</span>-<s=
pan id=3D"m_-3928334406880738982:3qh.126">ust</span>-<span id=3D"m_-3928334=
406880738982:3qh.127">abi</span>.c:235<br>#13 <span id=3D"m_-39283344068807=
38982:3qh.128">lttng</span>_<span id=3D"m_-3928334406880738982:3qh.129">ust=
</span>_<span id=3D"m_-3928334406880738982:3qh.130">abi</span>_exit () at <=
span id=3D"m_-3928334406880738982:3qh.131">lttng</span>-<span id=3D"m_-3928=
334406880738982:3qh.132">ust</span>-<span id=3D"m_-3928334406880738982:3qh.=
133">abi</span>.c:1002<br>#14 0x00007ffff76711d3 in <span id=3D"m_-39283344=
06880738982:3qh.134">lttng</span>_<span id=3D"m_-3928334406880738982:3qh.13=
5">ust</span>_cleanup (exiting=3D1)<br>=C2=A0=C2=A0=C2=A0 at <span id=3D"m_=
-3928334406880738982:3qh.136">lttng</span>-<span id=3D"m_-39283344068807389=
82:3qh.137">ust</span>-comm.c:1807<br>#15 0x00007ffff7667d57 in <span id=3D=
"m_-3928334406880738982:3qh.138">lttng</span>_<span id=3D"m_-39283344068807=
38982:3qh.139">ust</span>_exit ()<br>=C2=A0=C2=A0=C2=A0 at <span id=3D"m_-3=
928334406880738982:3qh.140">lttng</span>-<span id=3D"m_-3928334406880738982=
:3qh.141">ust</span>-comm.c:1874<br>#16 0x00007ffff7dec85a in _<span id=3D"=
m_-3928334406880738982:3qh.142">dl</span>_<span id=3D"m_-392833440688073898=
2:3qh.143">fini</span> ()<br>=C2=A0=C2=A0 from /lib64/<span id=3D"m_-392833=
4406880738982:3qh.144">ld</span>-<span id=3D"m_-3928334406880738982:3qh.145=
">linux</span>-x86-64.so.2<br>#17 0x00007ffff6eafa49 in __run_exit_handlers=
 ()<br>=C2=A0=C2=A0 from /lib64/<span id=3D"m_-3928334406880738982:3qh.146"=
>libc</span>.so.6<br>#18 0x00007ffff6eafa95 in exit () from /lib64/<span id=
=3D"m_-3928334406880738982:3qh.147">libc</span>.so.6<br>#19 0x0000000000401=
b51 in main (<span id=3D"m_-3928334406880738982:3qh.148">argc</span>=3D&lt;=
optimized out&gt;, <br><span id=3D"m_-3928334406880738982:3qh.149">argv</sp=
an>=3D&lt;optimized out&gt;) at <span id=3D"m_-3928334406880738982:3qh.150"=
>lu</span>.c:368<br><br></div>Any ideas, why this happens and how to fix it=
?<br><br></div>Thanks,<br></div><span id=3D"m_-3928334406880738982:3qh.151"=
>Shehab</span><br><div><div><div><div><br><br></div></div></div></div></div=
><br></div></div>______________________________<wbr>_________________<br>lt=
tng-dev mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=
=3D"_blank">lttng-dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng=
.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">https://lists.lt=
tng.org/cgi-<wbr>bin/mailman/listinfo/lttng-dev</a><span class=3D"HOEnZb"><=
font color=3D"#888888"><br></font></span></blockquote></div><span class=3D"=
HOEnZb"><font color=3D"#888888"><div><br></div><div>-- <br></div><div>Mathi=
eu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=
=3D"_blank">http://www.efficios.com</a></div></font></span></div></div></bl=
ockquote></div><br></div>

--0000000000002c94030567c69046--

--===============4979295052555962061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4979295052555962061==--
