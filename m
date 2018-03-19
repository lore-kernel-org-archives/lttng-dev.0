From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Double free or corruption error (fasttop)
Date: Mon, 19 Mar 2018 14:24:34 -0400 (EDT)
Message-ID: <1858478883.106.1521483874370.JavaMail.zimbra__12737.0910639458$1521483763$gmane$org@efficios.com>
References: <CAC-H6ttMF-CjzDH7a6bmeoOPP8JRLptYTmGJVvrx5t-G0Se_gA@mail.gmail.com>
 <226204243.12548.1521476487812.JavaMail.zimbra@efficios.com>
 <CAC-H6tvncER6tVg7=fi+bk9CiU8h-wKnhOLSo3SQdrofPUmXsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2519634948700758401=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 404kxJ22LgznRD
 for <lttng-dev@lists.lttng.org>; Mon, 19 Mar 2018 14:24:35 -0400 (EDT)
In-Reply-To: <CAC-H6tvncER6tVg7=fi+bk9CiU8h-wKnhOLSo3SQdrofPUmXsw@mail.gmail.com>
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

--===============2519634948700758401==
Content-Type: multipart/alternative;
	boundary="=_3856cf7e-b65f-45f7-8a0d-c7ed65a82377"

--=_3856cf7e-b65f-45f7-8a0d-c7ed65a82377
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Mar 19, 2018, at 12:36 PM, Shehab Elsayed <shehabyomn@gmail.com> wrote: 

> Hi Mathieu,

> Thank you very much for your reply.

> I manually built lttng-ust from source (commit #:
> 8a208943e21700211beee3ea64180a5a534c7d2a).

> This is how I set up the tracing session:
> 1- lttng create lu_ncb_8_native -o {path}
> 2- lttng enable-event --userspace lttng_ust_pthread:pthread_mutex_lock_req
> lttng enable-event --userspace lttng_ust_pthread:pthread_mutex_lock_acq
> lttng enable-event --userspace lttng_ust_pthread:pthread_mutex_lock_trylock
> lttng enable-event --userspace lttng_ust_pthread:pthread_mutex_lock_unlock
> 3- lttng add-context -u -t procname
> lttng add-context -u -t vpid
> lttng add-context -u -t pthread_id
> lttng add-context -u -t vtid
> lttng add-context -u -t ip
> lttng add-context -u -t perf:thread:cpu-cycles
> lttng add-context -u -t perf:thread:cycles
> lttng add-context -u -t perf:thread:instructions
> 4- lttng start
> 5- LD_PRELOAD=/usr/local/lib/liblttng-ust-pthread-wrapper.so ./lu_ncb -p8 -n8096
> -b32
> 6- lttng stop
> 7- lttng destroy

Can you reproduce if you remove the following contexts ? 

lttng add-context -u -t perf:thread:cpu-cycles 
lttng add-context -u -t perf:thread:cycles 
lttng add-context -u -t perf:thread:instructions 

And if you only keep a single of those contexts ? 

Thanks, 

Mathieu 

> Shehab Y. Elsayed, MSc.
> PhD Student
> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
> University of Toronto
> E-mail: [ https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11# |
> shehabyomn@gmail.com ]

> On Mon, Mar 19, 2018 at 12:21 PM, Mathieu Desnoyers < [
> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
> wrote:

>> ----- On Mar 16, 2018, at 5:37 PM, Shehab Elsayed < [
>> mailto:shehabyomn@gmail.com | shehabyomn@gmail.com ] > wrote:

>>> Hello All,

>>> I am trying to instrument a pthread application using the provided pthread
>>> wrapper, but I sometimes run into a "Double free or corruption error ( fasttop
>>> )" error.

>> Please provide more information about the version of lttng-ust you are using,
>> and how you setup
>> your tracing session.

>> Thanks,

>> Mathieu

>>> Here is a description of what I have tried and noticed:
>>> 1- The problem isn't consistent. It sometimes happen and sometimes works as
>>> expected.
>>> 2- From my experiments, the problem happens (more frequently at least) when
>>> adding performance counter contexts (I tried cycles, cpu _cycles and
>>> instructions).
>>> 3- I am testing using lu _ ncb from splash3 benchmark suite after setting LD _
>>> PRELOAD to use the pthread wrapper as described in the LTTng documents.
>>> 4- Here is the backtrace printed after exiting:
>>> ======= Backtrace : =========
>>> /lib64/ libc .so.6([Thread 0x7ffff5611700 ( LWP 97229) exited]
>>> / usr /local/lib/ liblttng - ust .so.0( lttng
>>> _destroy_context+0x35)[0x7ffff7471575]
>>> / usr /local/lib/ liblttng - ust .so.0( lttng
>>> _session_destroy+0x21c)[0x7ffff747363c]
>>> / usr /local/lib/ liblttng - ust .so.0(+0x1e906)[0x7ffff746d906]
>>> / usr /local/lib/ liblttng - ust .so.0( lttng _ ust _ objd _ unref
>>> +0x9f)[0x7ffff746dccf]
>>> / usr /local/lib/ liblttng - ust .so.0( lttng _ ust _ objd _ unref
>>> +0x9f)[0x7ffff746dccf]
>>> / usr /local/lib/ liblttng - ust .so.0( lttng _ ust _ objd _ unref
>>> +0x9f)[0x7ffff746dccf]
>>> / usr /local/lib/ liblttng - ust .so.0( lttng _ ust _ abi
>>> _exit+0x68)[0x7ffff746ead8]
>>> / usr /local/lib/ liblttng - ust .so.0(+0x191d3)[0x7ffff74681d3]
>>> / usr /local/lib/ liblttng - ust .so.0( lttng _ ust _exit+0x67)[0x7ffff745ed57]
>>> /lib64/ ld - linux -x86-64.so.2(+0xf85a)[0x7ffff7dec85a]
>>> /lib64/ libc .so.6(+0x38a49)[0x7ffff6ca6a49]
>>> /lib64/ libc .so.6(+0x38a95)[0x7ffff6ca6a95]
>>> / aenao -99/elsayed9/ LTTng /data/scripts/ tmp / lu _ ncb [0x401b51]
>>> /lib64/ libc .so.6(__ libc _start_main+0xf5)[0x7ffff6c8fb35]
>>> / aenao -99/elsayed9/ LTTng /data/scripts/ tmp / lu _ ncb [0x401c44]
>>> 5- Also, this is a backtrace I obtained from gdb :
>>> #0 0x00007ffff6eac1d7 in raise () from /lib64/ libc .so.6
>>> #1 0x00007ffff6ead8c8 in abort () from /lib64/ libc .so.6
>>> #2 0x00007ffff6eebf07 in __ libc _message () from /lib64/ libc .so.6
>>> #3 0x00007ffff6ef3503 in _int_free () from /lib64/ libc .so.6
>>> #4 0x00007ffff768ad25 in lttng _destroy_ perf _counter_field (
>>> field=<optimized out>) at lttng -context- perf -counters.c:418
>>> #5 0x00007ffff767a575 in lttng _destroy_context (
>>> ctx =0x7ffff0011090) at lttng -context.c:278
>>> #6 0x00007ffff767c63c in _ lttng _channel_ unmap (
>>> lttng _ chan =0x7ffff0010f40) at lttng -events.c:172
>>> #7 lttng _session_destroy (session=0x7ffff0000900)
>>> at lttng -events.c:247
>>> #8 0x00007ffff7676906 in lttng _release_session (
>>> objd =<optimized out>) at lttng - ust - abi .c:601
>>> #9 0x00007ffff7676ccf in lttng _ ust _ objd _ unref (id=1,
>>> is_owner=<optimized out>) at lttng - ust - abi .c:216
>>> #10 0x00007ffff7676ccf in lttng _ ust _ objd _ unref (id=2,
>>> is_owner=<optimized out>) at lttng - ust - abi .c:216
>>> #11 0x00007ffff7676ccf in lttng _ ust _ objd _ unref (id=id@entry=18,
>>> is_owner=is_owner@entry=1) at lttng - ust - abi .c:216
>>> #12 0x00007ffff7677ad8 in objd _table_destroy ()
>>> at lttng - ust - abi .c:235
>>> #13 lttng _ ust _ abi _exit () at lttng - ust - abi .c:1002
>>> #14 0x00007ffff76711d3 in lttng _ ust _cleanup (exiting=1)
>>> at lttng - ust -comm.c:1807
>>> #15 0x00007ffff7667d57 in lttng _ ust _exit ()
>>> at lttng - ust -comm.c:1874
>>> #16 0x00007ffff7dec85a in _ dl _ fini ()
>>> from /lib64/ ld - linux -x86-64.so.2
>>> #17 0x00007ffff6eafa49 in __run_exit_handlers ()
>>> from /lib64/ libc .so.6
>>> #18 0x00007ffff6eafa95 in exit () from /lib64/ libc .so.6
>>> #19 0x0000000000401b51 in main ( argc =<optimized out>,
>>> argv =<optimized out>) at lu .c:368

>>> Any ideas, why this happens and how to fix it?

>>> Thanks,
>>> Shehab

>>> _______________________________________________
>>> lttng-dev mailing list
>>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> [ http://www.efficios.com/ | http://www.efficios.com ]

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_3856cf7e-b65f-45f7-8a0d-c7ed65a82377
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Mar 19, 2018, at 12:36 PM, Shehab Elsayed &lt;shehabyomn@gmail=
.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><block=
quote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5=
px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fon=
t-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div>=
<div><div><div><div><div><div>Hi Mathieu,<br><br>Thank you very much for yo=
ur reply.<br><br>I manually built lttng-ust from source (commit #: 8a208943=
e21700211beee3ea64180a5a534c7d2a).<br><br></div>This is how I set up the tr=
acing session:<br></div>1- lttng create lu_ncb_8_native -o {path}<br></div>=
2- lttng enable-event --userspace lttng_ust_pthread:pthread_mutex_lock_req<=
br>&nbsp;&nbsp;&nbsp; lttng enable-event --userspace lttng_ust_pthread:pthr=
ead_mutex_lock_acq<br>&nbsp;&nbsp;&nbsp; lttng enable-event --userspace ltt=
ng_ust_pthread:pthread_mutex_lock_trylock<br>&nbsp;&nbsp;&nbsp; lttng enabl=
e-event --userspace lttng_ust_pthread:pthread_mutex_lock_unlock<br></div>3-=
 lttng add-context -u -t procname<br>&nbsp;&nbsp;&nbsp; lttng add-context -=
u -t vpid<br>&nbsp;&nbsp;&nbsp;  lttng add-context -u -t pthread_id<br>&nbs=
p;&nbsp;&nbsp;  lttng add-context -u -t vtid<br>&nbsp;&nbsp;&nbsp;  lttng a=
dd-context -u -t ip<br>&nbsp;&nbsp;&nbsp;  lttng add-context -u -t perf:thr=
ead:cpu-cycles<br>&nbsp;&nbsp;&nbsp;  lttng add-context -u -t perf:thread:c=
ycles<br>&nbsp;&nbsp;&nbsp;  lttng add-context -u -t perf:thread:instructio=
ns<br></div>4- lttng start<br>5- LD_PRELOAD=3D/usr/local/lib/liblttng-ust-p=
thread-wrapper.so ./lu_ncb -p8 -n8096 -b32<br></div>6- lttng stop<br></div>=
7- lttng destroy</div></blockquote><div><br></div><div>Can you reproduce if=
 you remove the following contexts ?<br data-mce-bogus=3D"1"></div><div><br=
 data-mce-bogus=3D"1"></div><div>&nbsp;&nbsp;&nbsp; lttng add-context -u -t=
 perf:thread:cpu-cycles<br>&nbsp;&nbsp;&nbsp; lttng add-context -u -t perf:=
thread:cycles<br>&nbsp;&nbsp;&nbsp; lttng add-context -u -t perf:thread:ins=
tructions</div><div><br data-mce-bogus=3D"1"></div><div>And if you only kee=
p a single of those contexts ?<br data-mce-bogus=3D"1"></div><div><br data-=
mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br d=
ata-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><=
br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquo=
te style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;=
color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-f=
amily:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><br><br>=
<div><div><div><div><br></div></div></div></div></div><div class=3D"gmail_e=
xtra"><br clear=3D"all"><div><div class=3D"gmail_signature"><div dir=3D"ltr=
"><span data-mce-style=3D"color: #888888;" style=3D"color: #888888;" color=
=3D"#888888">Shehab Y. Elsayed, MSc.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </span><span data-mce-style=3D"color: #=
888888;" style=3D"color: #888888;" color=3D"#888888"><br>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></span><br data=
-mce-bogus=3D"1"></div></div></div><br><div class=3D"gmail_quote">On Mon, M=
ar 19, 2018 at 12:21 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D=
"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers=
@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div>=
<div style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:#=
000000"><span class=3D""><br><br><div><span id=3D"m_-3928334406880738982zwc=
hr">----- On Mar 16, 2018, at 5:37 PM, Shehab Elsayed &lt;<a href=3D"mailto=
:shehabyomn@gmail.com" target=3D"_blank">shehabyomn@gmail.com</a>&gt; wrote=
:<br></span></div></span><div><span class=3D""><blockquote style=3D"border-=
left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-wei=
ght:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Ari=
al,sans-serif;font-size:12pt"><div dir=3D"ltr"><div><div><div><div><div><di=
v><div><div><div><div>Hello All,<br><br></div>I am trying to instrument a <=
span id=3D"m_-3928334406880738982:3qh.1">pthread</span> application using t=
he provided <span id=3D"m_-3928334406880738982:3qh.2">pthread</span> wrappe=
r, but I sometimes run into a "Double free or corruption error (<span id=3D=
"m_-3928334406880738982:3qh.3">fasttop</span>)" error. </div></div></div></=
div></div></div></div></div></div></div></blockquote><br></span><div>Please=
 provide more information about the version of lttng-ust you are using, and=
 how you setup<br></div><div>your tracing session.<br></div><br><div>Thanks=
,<br></div><br><div>Mathieu<br></div><br><blockquote style=3D"border-left:2=
px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:no=
rmal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,san=
s-serif;font-size:12pt"><div><div class=3D"h5"><div dir=3D"ltr"><div><div><=
div><div><div><div><div><div><div><br><br></div>Here is a description of wh=
at I have tried and noticed:<br></div>1- The problem isn't consistent. It s=
ometimes happen and sometimes works as expected.<br></div>2- From my experi=
ments, the problem happens (more frequently at least) when adding performan=
ce counter contexts (I tried cycles, <span id=3D"m_-3928334406880738982:3qh=
.4">cpu</span>_cycles and instructions).<br></div>3- I am testing using <sp=
an id=3D"m_-3928334406880738982:3qh.5">lu</span>_<span id=3D"m_-39283344068=
80738982:3qh.6">ncb</span> from splash3 benchmark suite after setting <span=
 id=3D"m_-3928334406880738982:3qh.7">LD</span>_<span id=3D"m_-3928334406880=
738982:3qh.8">PRELOAD</span> to use the <span id=3D"m_-3928334406880738982:=
3qh.9">pthread</span> wrapper as described in the <span id=3D"m_-3928334406=
880738982:3qh.10">LTTng</span> documents.<br></div>4- Here is the <span id=
=3D"m_-3928334406880738982:3qh.11">backtrace</span> printed after exiting:<=
br>=3D=3D=3D=3D=3D=3D=3D <span id=3D"m_-3928334406880738982:3qh.12">Backtra=
ce</span>: =3D=3D=3D=3D=3D=3D=3D=3D=3D<br>/lib64/<span id=3D"m_-39283344068=
80738982:3qh.13">libc</span>.so.6([Thread 0x7ffff5611700 (<span id=3D"m_-39=
28334406880738982:3qh.14">LWP</span> 97229) exited]<br>/<span id=3D"m_-3928=
334406880738982:3qh.15">usr</span>/local/lib/<span id=3D"m_-392833440688073=
8982:3qh.16">liblttng</span>-<span id=3D"m_-3928334406880738982:3qh.17">ust=
</span>.so.0(<span id=3D"m_-3928334406880738982:3qh.18">lttng</span>_destro=
y_context+0x35)[0x7ffff7471575]<br>/<span id=3D"m_-3928334406880738982:3qh.=
19">usr</span>/local/lib/<span id=3D"m_-3928334406880738982:3qh.20">liblttn=
g</span>-<span id=3D"m_-3928334406880738982:3qh.21">ust</span>.so.0(<span i=
d=3D"m_-3928334406880738982:3qh.22">lttng</span>_session_destroy+0x21c)[0x7=
ffff747363c]<br>/<span id=3D"m_-3928334406880738982:3qh.23">usr</span>/loca=
l/lib/<span id=3D"m_-3928334406880738982:3qh.24">liblttng</span>-<span id=
=3D"m_-3928334406880738982:3qh.25">ust</span>.so.0(+0x1e906)[0x7ffff746d906=
]<br>/<span id=3D"m_-3928334406880738982:3qh.26">usr</span>/local/lib/<span=
 id=3D"m_-3928334406880738982:3qh.27">liblttng</span>-<span id=3D"m_-392833=
4406880738982:3qh.28">ust</span>.so.0(<span id=3D"m_-3928334406880738982:3q=
h.29">lttng</span>_<span id=3D"m_-3928334406880738982:3qh.30">ust</span>_<s=
pan id=3D"m_-3928334406880738982:3qh.31">objd</span>_<span id=3D"m_-3928334=
406880738982:3qh.32">unref</span>+0x9f)[0x7ffff746dccf]<br>/<span id=3D"m_-=
3928334406880738982:3qh.33">usr</span>/local/lib/<span id=3D"m_-39283344068=
80738982:3qh.34">liblttng</span>-<span id=3D"m_-3928334406880738982:3qh.35"=
>ust</span>.so.0(<span id=3D"m_-3928334406880738982:3qh.36">lttng</span>_<s=
pan id=3D"m_-3928334406880738982:3qh.37">ust</span>_<span id=3D"m_-39283344=
06880738982:3qh.38">objd</span>_<span id=3D"m_-3928334406880738982:3qh.39">=
unref</span>+0x9f)[0x7ffff746dccf]<br>/<span id=3D"m_-3928334406880738982:3=
qh.40">usr</span>/local/lib/<span id=3D"m_-3928334406880738982:3qh.41">libl=
ttng</span>-<span id=3D"m_-3928334406880738982:3qh.42">ust</span>.so.0(<spa=
n id=3D"m_-3928334406880738982:3qh.43">lttng</span>_<span id=3D"m_-39283344=
06880738982:3qh.44">ust</span>_<span id=3D"m_-3928334406880738982:3qh.45">o=
bjd</span>_<span id=3D"m_-3928334406880738982:3qh.46">unref</span>+0x9f)[0x=
7ffff746dccf]<br>/<span id=3D"m_-3928334406880738982:3qh.47">usr</span>/loc=
al/lib/<span id=3D"m_-3928334406880738982:3qh.48">liblttng</span>-<span id=
=3D"m_-3928334406880738982:3qh.49">ust</span>.so.0(<span id=3D"m_-392833440=
6880738982:3qh.50">lttng</span>_<span id=3D"m_-3928334406880738982:3qh.51">=
ust</span>_<span id=3D"m_-3928334406880738982:3qh.52">abi</span>_exit+0x68)=
[0x7ffff746ead8]<br>/<span id=3D"m_-3928334406880738982:3qh.53">usr</span>/=
local/lib/<span id=3D"m_-3928334406880738982:3qh.54">liblttng</span>-<span =
id=3D"m_-3928334406880738982:3qh.55">ust</span>.so.0(+0x191d3)[0x7ffff74681=
d3]<br>/<span id=3D"m_-3928334406880738982:3qh.56">usr</span>/local/lib/<sp=
an id=3D"m_-3928334406880738982:3qh.57">liblttng</span>-<span id=3D"m_-3928=
334406880738982:3qh.58">ust</span>.so.0(<span id=3D"m_-3928334406880738982:=
3qh.59">lttng</span>_<span id=3D"m_-3928334406880738982:3qh.60">ust</span>_=
exit+0x67)[0x7ffff745ed57]<br>/lib64/<span id=3D"m_-3928334406880738982:3qh=
.61">ld</span>-<span id=3D"m_-3928334406880738982:3qh.62">linux</span>-x86-=
64.so.2(+0xf85a)[0x7ffff7dec85a]<br>/lib64/<span id=3D"m_-39283344068807389=
82:3qh.63">libc</span>.so.6(+0x38a49)[0x7ffff6ca6a49]<br>/lib64/<span id=3D=
"m_-3928334406880738982:3qh.64">libc</span>.so.6(+0x38a95)[0x7ffff6ca6a95]<=
br>/<span id=3D"m_-3928334406880738982:3qh.65">aenao</span>-99/elsayed9/<sp=
an id=3D"m_-3928334406880738982:3qh.66">LTTng</span>/data/scripts/<span id=
=3D"m_-3928334406880738982:3qh.67">tmp</span>/<span id=3D"m_-39283344068807=
38982:3qh.68">lu</span>_<span id=3D"m_-3928334406880738982:3qh.69">ncb</spa=
n>[0x401b51]<br>/lib64/<span id=3D"m_-3928334406880738982:3qh.70">libc</spa=
n>.so.6(__<span id=3D"m_-3928334406880738982:3qh.71">libc</span>_start_main=
+0xf5)[0x7ffff6c8fb35]<br>/<span id=3D"m_-3928334406880738982:3qh.72">aenao=
</span>-99/elsayed9/<span id=3D"m_-3928334406880738982:3qh.73">LTTng</span>=
/data/scripts/<span id=3D"m_-3928334406880738982:3qh.74">tmp</span>/<span i=
d=3D"m_-3928334406880738982:3qh.75">lu</span>_<span id=3D"m_-39283344068807=
38982:3qh.76">ncb</span>[0x401c44]<br></div>5- Also, this is a <span id=3D"=
m_-3928334406880738982:3qh.77">backtrace</span> I obtained from <span id=3D=
"m_-3928334406880738982:3qh.78">gdb</span>:<br>#0&nbsp; 0x00007ffff6eac1d7 =
in raise () from /lib64/<span id=3D"m_-3928334406880738982:3qh.79">libc</sp=
an>.so.6<br>#1&nbsp; 0x00007ffff6ead8c8 in abort () from /lib64/<span id=3D=
"m_-3928334406880738982:3qh.80">libc</span>.so.6<br>#2&nbsp; 0x00007ffff6ee=
bf07 in __<span id=3D"m_-3928334406880738982:3qh.81">libc</span>_message ()=
 from /lib64/<span id=3D"m_-3928334406880738982:3qh.82">libc</span>.so.6<br=
>#3&nbsp; 0x00007ffff6ef3503 in _int_free () from /lib64/<span id=3D"m_-392=
8334406880738982:3qh.83">libc</span>.so.6<br>#4&nbsp; 0x00007ffff768ad25 in=
 <span id=3D"m_-3928334406880738982:3qh.84">lttng</span>_destroy_<span id=
=3D"m_-3928334406880738982:3qh.85">perf</span>_counter_field (<br>&nbsp;&nb=
sp;&nbsp; field=3D&lt;optimized out&gt;) at <span id=3D"m_-3928334406880738=
982:3qh.86">lttng</span>-context-<span id=3D"m_-3928334406880738982:3qh.87"=
>perf</span>-counters.c:418<br>#5&nbsp; 0x00007ffff767a575 in <span id=3D"m=
_-3928334406880738982:3qh.88">lttng</span>_destroy_context (<br><span id=3D=
"m_-3928334406880738982:3qh.89">ctx</span>=3D0x7ffff0011090) at <span id=3D=
"m_-3928334406880738982:3qh.90">lttng</span>-context.c:278<br>#6&nbsp; 0x00=
007ffff767c63c in _<span id=3D"m_-3928334406880738982:3qh.91">lttng</span>_=
channel_<span id=3D"m_-3928334406880738982:3qh.92">unmap</span> (<br><span =
id=3D"m_-3928334406880738982:3qh.93">lttng</span>_<span id=3D"m_-3928334406=
880738982:3qh.94">chan</span>=3D0x7ffff0010f40) at <span id=3D"m_-392833440=
6880738982:3qh.95">lttng</span>-events.c:172<br>#7&nbsp; <span id=3D"m_-392=
8334406880738982:3qh.96">lttng</span>_session_destroy (session=3D0x7ffff000=
0900)<br>&nbsp;&nbsp;&nbsp; at <span id=3D"m_-3928334406880738982:3qh.97">l=
ttng</span>-events.c:247<br>#8&nbsp; 0x00007ffff7676906 in <span id=3D"m_-3=
928334406880738982:3qh.98">lttng</span>_release_session (<br><span id=3D"m_=
-3928334406880738982:3qh.99">objd</span>=3D&lt;optimized out&gt;) at <span =
id=3D"m_-3928334406880738982:3qh.100">lttng</span>-<span id=3D"m_-392833440=
6880738982:3qh.101">ust</span>-<span id=3D"m_-3928334406880738982:3qh.102">=
abi</span>.c:601<br>#9&nbsp; 0x00007ffff7676ccf in <span id=3D"m_-392833440=
6880738982:3qh.103">lttng</span>_<span id=3D"m_-3928334406880738982:3qh.104=
">ust</span>_<span id=3D"m_-3928334406880738982:3qh.105">objd</span>_<span =
id=3D"m_-3928334406880738982:3qh.106">unref</span> (id=3D1, <br>&nbsp;&nbsp=
;&nbsp; is_owner=3D&lt;optimized out&gt;) at <span id=3D"m_-392833440688073=
8982:3qh.107">lttng</span>-<span id=3D"m_-3928334406880738982:3qh.108">ust<=
/span>-<span id=3D"m_-3928334406880738982:3qh.109">abi</span>.c:216<br>#10 =
0x00007ffff7676ccf in <span id=3D"m_-3928334406880738982:3qh.110">lttng</sp=
an>_<span id=3D"m_-3928334406880738982:3qh.111">ust</span>_<span id=3D"m_-3=
928334406880738982:3qh.112">objd</span>_<span id=3D"m_-3928334406880738982:=
3qh.113">unref</span> (id=3D2, <br>&nbsp;&nbsp;&nbsp; is_owner=3D&lt;optimi=
zed out&gt;) at <span id=3D"m_-3928334406880738982:3qh.114">lttng</span>-<s=
pan id=3D"m_-3928334406880738982:3qh.115">ust</span>-<span id=3D"m_-3928334=
406880738982:3qh.116">abi</span>.c:216<br>#11 0x00007ffff7676ccf in <span i=
d=3D"m_-3928334406880738982:3qh.117">lttng</span>_<span id=3D"m_-3928334406=
880738982:3qh.118">ust</span>_<span id=3D"m_-3928334406880738982:3qh.119">o=
bjd</span>_<span id=3D"m_-3928334406880738982:3qh.120">unref</span> (id=3Di=
d@entry=3D18, <br>&nbsp;&nbsp;&nbsp; is_owner=3Dis_owner@entry=3D1) at <spa=
n id=3D"m_-3928334406880738982:3qh.121">lttng</span>-<span id=3D"m_-3928334=
406880738982:3qh.122">ust</span>-<span id=3D"m_-3928334406880738982:3qh.123=
">abi</span>.c:216<br>#12 0x00007ffff7677ad8 in <span id=3D"m_-392833440688=
0738982:3qh.124">objd</span>_table_destroy ()<br>&nbsp;&nbsp;&nbsp; at <spa=
n id=3D"m_-3928334406880738982:3qh.125">lttng</span>-<span id=3D"m_-3928334=
406880738982:3qh.126">ust</span>-<span id=3D"m_-3928334406880738982:3qh.127=
">abi</span>.c:235<br>#13 <span id=3D"m_-3928334406880738982:3qh.128">lttng=
</span>_<span id=3D"m_-3928334406880738982:3qh.129">ust</span>_<span id=3D"=
m_-3928334406880738982:3qh.130">abi</span>_exit () at <span id=3D"m_-392833=
4406880738982:3qh.131">lttng</span>-<span id=3D"m_-3928334406880738982:3qh.=
132">ust</span>-<span id=3D"m_-3928334406880738982:3qh.133">abi</span>.c:10=
02<br>#14 0x00007ffff76711d3 in <span id=3D"m_-3928334406880738982:3qh.134"=
>lttng</span>_<span id=3D"m_-3928334406880738982:3qh.135">ust</span>_cleanu=
p (exiting=3D1)<br>&nbsp;&nbsp;&nbsp; at <span id=3D"m_-3928334406880738982=
:3qh.136">lttng</span>-<span id=3D"m_-3928334406880738982:3qh.137">ust</spa=
n>-comm.c:1807<br>#15 0x00007ffff7667d57 in <span id=3D"m_-3928334406880738=
982:3qh.138">lttng</span>_<span id=3D"m_-3928334406880738982:3qh.139">ust</=
span>_exit ()<br>&nbsp;&nbsp;&nbsp; at <span id=3D"m_-3928334406880738982:3=
qh.140">lttng</span>-<span id=3D"m_-3928334406880738982:3qh.141">ust</span>=
-comm.c:1874<br>#16 0x00007ffff7dec85a in _<span id=3D"m_-39283344068807389=
82:3qh.142">dl</span>_<span id=3D"m_-3928334406880738982:3qh.143">fini</spa=
n> ()<br>&nbsp;&nbsp; from /lib64/<span id=3D"m_-3928334406880738982:3qh.14=
4">ld</span>-<span id=3D"m_-3928334406880738982:3qh.145">linux</span>-x86-6=
4.so.2<br>#17 0x00007ffff6eafa49 in __run_exit_handlers ()<br>&nbsp;&nbsp; =
from /lib64/<span id=3D"m_-3928334406880738982:3qh.146">libc</span>.so.6<br=
>#18 0x00007ffff6eafa95 in exit () from /lib64/<span id=3D"m_-3928334406880=
738982:3qh.147">libc</span>.so.6<br>#19 0x0000000000401b51 in main (<span i=
d=3D"m_-3928334406880738982:3qh.148">argc</span>=3D&lt;optimized out&gt;, <=
br><span id=3D"m_-3928334406880738982:3qh.149">argv</span>=3D&lt;optimized =
out&gt;) at <span id=3D"m_-3928334406880738982:3qh.150">lu</span>.c:368<br>=
<br></div>Any ideas, why this happens and how to fix it?<br><br></div>Thank=
s,<br></div><span id=3D"m_-3928334406880738982:3qh.151">Shehab</span><br><d=
iv><div><div><div><br><br></div></div></div></div></div><br></div></div>___=
____________________________________________<br>lttng-dev mailing list<br><=
a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lis=
ts.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/mailman/list=
info/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</a><span class=3D"HOEnZb"><span data-mce-style=3D"color: =
#888888;" style=3D"color: #888888;" color=3D"#888888"><br></span></span></b=
lockquote></div><span class=3D"HOEnZb"><span data-mce-style=3D"color: #8888=
88;" style=3D"color: #888888;" color=3D"#888888"><br><div>-- <br></div><div=
>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" =
target=3D"_blank">http://www.efficios.com</a><br data-mce-bogus=3D"1"></div=
></span></span></div></div></blockquote></div></div><br></blockquote></div>=
<div><br></div><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu =
Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body></h=
tml>
--=_3856cf7e-b65f-45f7-8a0d-c7ed65a82377--

--===============2519634948700758401==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2519634948700758401==--
