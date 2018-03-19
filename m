From: Shehab Elsayed <shehabyomn@gmail.com>
Subject: Re: Double free or corruption error (fasttop)
Date: Mon, 19 Mar 2018 15:53:45 -0400
Message-ID: <CAC-H6tsWkYAxYFR6zsdcf+V_e3VYtDvZbYk80mc0raW-AKU5hA__33161.3858383664$1521489116$gmane$org@mail.gmail.com>
References: <CAC-H6ttMF-CjzDH7a6bmeoOPP8JRLptYTmGJVvrx5t-G0Se_gA@mail.gmail.com>
 <226204243.12548.1521476487812.JavaMail.zimbra@efficios.com>
 <CAC-H6tvncER6tVg7=fi+bk9CiU8h-wKnhOLSo3SQdrofPUmXsw@mail.gmail.com>
 <1858478883.106.1521483874370.JavaMail.zimbra@efficios.com>
 <CAC-H6tscb4SzTdu_Z+3jLjuUEqacZtyV1jGq-fd0xSXibm=mjw@mail.gmail.com>
 <1672457853.270.1521487573519.JavaMail.zimbra@efficios.com>
 <173668501.337.1521487906796.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8897821653214766862=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-x232.google.com (mail-lf0-x232.google.com
 [IPv6:2a00:1450:4010:c07::232])
 by lists.lttng.org (Postfix) with ESMTPS id 404mwD1mG4znbJ
 for <lttng-dev@lists.lttng.org>; Mon, 19 Mar 2018 15:53:47 -0400 (EDT)
Received: by mail-lf0-x232.google.com with SMTP id a22-v6so27295234lfg.9
 for <lttng-dev@lists.lttng.org>; Mon, 19 Mar 2018 12:53:47 -0700 (PDT)
In-Reply-To: <173668501.337.1521487906796.JavaMail.zimbra@efficios.com>
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

--===============8897821653214766862==
Content-Type: multipart/alternative; boundary="883d24f22b4ce1ab5d0567c950a1"

--883d24f22b4ce1ab5d0567c950a1
Content-Type: text/plain; charset="UTF-8"

cat /proc/sys/kernel/perf_event_paranoid ---> returns 1

I run the program as a normal user

The glibc version I get by running "ldd --version" is 2.17

Shehab Y. Elsayed, MSc.
PhD Student
The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
University of Toronto
E-mail: shehabyomn@gmail.com
<https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>

On Mon, Mar 19, 2018 at 3:31 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ---- On Mar 19, 2018, at 3:26 PM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Mar 19, 2018, at 2:26 PM, Shehab Elsayed <shehabyomn@gmail.com>
> wrote:
>
> Yes, I tried with only one of those contexts and I still ran into the same
> problem.
>
> What is the setting returned by
>
> cat /proc/sys/kernel/perf_event_paranoid
>
> on your system ? And do you run your test program as root or normal user ?
>
> Please CC the mailing list on your reply.
>
>
> I will also need to know what glibc version you have on your system.
>
> Thanks,
>
> Mathieu
>
>
>
>
> Thanks,
>
> Mathieu
>
>
>
> Shehab Y. Elsayed, MSc.
> PhD Student
> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
> University of Toronto
> E-mail: shehabyomn@gmail.com
> <https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>
>
> On Mon, Mar 19, 2018 at 2:24 PM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
>
>> ----- On Mar 19, 2018, at 12:36 PM, Shehab Elsayed <shehabyomn@gmail.com>
>> wrote:
>>
>> Hi Mathieu,
>>
>> Thank you very much for your reply.
>>
>> I manually built lttng-ust from source (commit #:
>> 8a208943e21700211beee3ea64180a5a534c7d2a).
>>
>> This is how I set up the tracing session:
>> 1- lttng create lu_ncb_8_native -o {path}
>> 2- lttng enable-event --userspace lttng_ust_pthread:pthread_
>> mutex_lock_req
>>     lttng enable-event --userspace lttng_ust_pthread:pthread_
>> mutex_lock_acq
>>     lttng enable-event --userspace lttng_ust_pthread:pthread_
>> mutex_lock_trylock
>>     lttng enable-event --userspace lttng_ust_pthread:pthread_
>> mutex_lock_unlock
>> 3- lttng add-context -u -t procname
>>     lttng add-context -u -t vpid
>>     lttng add-context -u -t pthread_id
>>     lttng add-context -u -t vtid
>>     lttng add-context -u -t ip
>>     lttng add-context -u -t perf:thread:cpu-cycles
>>     lttng add-context -u -t perf:thread:cycles
>>     lttng add-context -u -t perf:thread:instructions
>> 4- lttng start
>> 5- LD_PRELOAD=/usr/local/lib/liblttng-ust-pthread-wrapper.so ./lu_ncb
>> -p8 -n8096 -b32
>> 6- lttng stop
>> 7- lttng destroy
>>
>>
>> Can you reproduce if you remove the following contexts ?
>>
>>     lttng add-context -u -t perf:thread:cpu-cycles
>>     lttng add-context -u -t perf:thread:cycles
>>     lttng add-context -u -t perf:thread:instructions
>>
>> And if you only keep a single of those contexts ?
>>
>> Thanks,
>>
>> Mathieu
>>
>>
>>
>>
>>
>>
>> Shehab Y. Elsayed, MSc.
>> PhD Student
>> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
>> University of Toronto
>> E-mail: shehabyomn@gmail.com
>> <https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>
>>
>> On Mon, Mar 19, 2018 at 12:21 PM, Mathieu Desnoyers <
>> mathieu.desnoyers@efficios.com> wrote:
>>
>>>
>>>
>>> ----- On Mar 16, 2018, at 5:37 PM, Shehab Elsayed <shehabyomn@gmail.com>
>>> wrote:
>>>
>>> Hello All,
>>>
>>> I am trying to instrument a pthread application using the provided
>>> pthread wrapper, but I sometimes run into a "Double free or corruption
>>> error (fasttop)" error.
>>>
>>>
>>> Please provide more information about the version of lttng-ust you are
>>> using, and how you setup
>>> your tracing session.
>>>
>>> Thanks,
>>>
>>> Mathieu
>>>
>>>
>>>
>>> Here is a description of what I have tried and noticed:
>>> 1- The problem isn't consistent. It sometimes happen and sometimes works
>>> as expected.
>>> 2- From my experiments, the problem happens (more frequently at least)
>>> when adding performance counter contexts (I tried cycles, cpu_cycles
>>> and instructions).
>>> 3- I am testing using lu_ncb from splash3 benchmark suite after setting
>>> LD_PRELOAD to use the pthread wrapper as described in the LTTng
>>> documents.
>>> 4- Here is the backtrace printed after exiting:
>>> ======= Backtrace: =========
>>> /lib64/libc.so.6([Thread 0x7ffff5611700 (LWP 97229) exited]
>>> /usr/local/lib/liblttng-ust.so.0(lttng_destroy_context+
>>> 0x35)[0x7ffff7471575]
>>> /usr/local/lib/liblttng-ust.so.0(lttng_session_destroy+
>>> 0x21c)[0x7ffff747363c]
>>> /usr/local/lib/liblttng-ust.so.0(+0x1e906)[0x7ffff746d906]
>>> /usr/local/lib/liblttng-ust.so.0(lttng_ust_objd_unref+
>>> 0x9f)[0x7ffff746dccf]
>>> /usr/local/lib/liblttng-ust.so.0(lttng_ust_objd_unref+
>>> 0x9f)[0x7ffff746dccf]
>>> /usr/local/lib/liblttng-ust.so.0(lttng_ust_objd_unref+
>>> 0x9f)[0x7ffff746dccf]
>>> /usr/local/lib/liblttng-ust.so.0(lttng_ust_abi_exit+0x68)[
>>> 0x7ffff746ead8]
>>> /usr/local/lib/liblttng-ust.so.0(+0x191d3)[0x7ffff74681d3]
>>> /usr/local/lib/liblttng-ust.so.0(lttng_ust_exit+0x67)[0x7ffff745ed57]
>>> /lib64/ld-linux-x86-64.so.2(+0xf85a)[0x7ffff7dec85a]
>>> /lib64/libc.so.6(+0x38a49)[0x7ffff6ca6a49]
>>> /lib64/libc.so.6(+0x38a95)[0x7ffff6ca6a95]
>>> /aenao-99/elsayed9/LTTng/data/scripts/tmp/lu_ncb[0x401b51]
>>> /lib64/libc.so.6(__libc_start_main+0xf5)[0x7ffff6c8fb35]
>>> /aenao-99/elsayed9/LTTng/data/scripts/tmp/lu_ncb[0x401c44]
>>> 5- Also, this is a backtrace I obtained from gdb:
>>> #0  0x00007ffff6eac1d7 in raise () from /lib64/libc.so.6
>>> #1  0x00007ffff6ead8c8 in abort () from /lib64/libc.so.6
>>> #2  0x00007ffff6eebf07 in __libc_message () from /lib64/libc.so.6
>>> #3  0x00007ffff6ef3503 in _int_free () from /lib64/libc.so.6
>>> #4  0x00007ffff768ad25 in lttng_destroy_perf_counter_field (
>>>     field=<optimized out>) at lttng-context-perf-counters.c:418
>>> #5  0x00007ffff767a575 in lttng_destroy_context (
>>> ctx=0x7ffff0011090) at lttng-context.c:278
>>> #6  0x00007ffff767c63c in _lttng_channel_unmap (
>>> lttng_chan=0x7ffff0010f40) at lttng-events.c:172
>>> #7  lttng_session_destroy (session=0x7ffff0000900)
>>>     at lttng-events.c:247
>>> #8  0x00007ffff7676906 in lttng_release_session (
>>> objd=<optimized out>) at lttng-ust-abi.c:601
>>> #9  0x00007ffff7676ccf in lttng_ust_objd_unref (id=1,
>>>     is_owner=<optimized out>) at lttng-ust-abi.c:216
>>> #10 0x00007ffff7676ccf in lttng_ust_objd_unref (id=2,
>>>     is_owner=<optimized out>) at lttng-ust-abi.c:216
>>> #11 0x00007ffff7676ccf in lttng_ust_objd_unref (id=id@entry=18,
>>>     is_owner=is_owner@entry=1) at lttng-ust-abi.c:216
>>> #12 0x00007ffff7677ad8 in objd_table_destroy ()
>>>     at lttng-ust-abi.c:235
>>> #13 lttng_ust_abi_exit () at lttng-ust-abi.c:1002
>>> #14 0x00007ffff76711d3 in lttng_ust_cleanup (exiting=1)
>>>     at lttng-ust-comm.c:1807
>>> #15 0x00007ffff7667d57 in lttng_ust_exit ()
>>>     at lttng-ust-comm.c:1874
>>> #16 0x00007ffff7dec85a in _dl_fini ()
>>>    from /lib64/ld-linux-x86-64.so.2
>>> #17 0x00007ffff6eafa49 in __run_exit_handlers ()
>>>    from /lib64/libc.so.6
>>> #18 0x00007ffff6eafa95 in exit () from /lib64/libc.so.6
>>> #19 0x0000000000401b51 in main (argc=<optimized out>,
>>> argv=<optimized out>) at lu.c:368
>>>
>>> Any ideas, why this happens and how to fix it?
>>>
>>> Thanks,
>>> Shehab
>>>
>>>
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>>
>>> --
>>> Mathieu Desnoyers
>>> EfficiOS Inc.
>>> http://www.efficios.com
>>>
>>
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--883d24f22b4ce1ab5d0567c950a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><span class=3D"gmail-im">cat /proc/sys/kernel/pe=
rf_event_<wbr>paranoid</span> ---&gt; returns 1<br><br></div>I run the prog=
ram as a normal user<br><br></div>The glibc version I get by running &quot;=
ldd --version&quot; is 2.17<br></div><div class=3D"gmail_extra"><br clear=
=3D"all"><div><div class=3D"gmail_signature" data-smartmail=3D"gmail_signat=
ure"><div dir=3D"ltr"><font color=3D"#888888">Shehab Y. Elsayed, MSc.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </font><font color=3D"#888888"><a value=
=3D"+20124498360"><span dir=3D"ltr"></span></a><br>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></font></div></=
div></div>
<br><div class=3D"gmail_quote">On Mon, Mar 19, 2018 at 3:31 PM, Mathieu Des=
noyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.c=
om" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-family:arial,helv=
etica,sans-serif;font-size:12pt;color:#000000"><span class=3D""><div><span =
id=3D"m_4191731141621744608zwchr">---- On Mar 19, 2018, at 3:26 PM, Mathieu=
 Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"=
_blank">mathieu.desnoyers@efficios.<wbr>com</a>&gt; wrote:<br></span></div>=
</span><div><span class=3D""><blockquote style=3D"border-left:2px solid #10=
10ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-st=
yle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font=
-size:12pt"><div style=3D"font-family:arial,helvetica,sans-serif;font-size:=
12pt;color:#000000"><div><span id=3D"m_4191731141621744608zwchr">----- On M=
ar 19, 2018, at 2:26 PM, Shehab Elsayed &lt;<a href=3D"mailto:shehabyomn@gm=
ail.com" target=3D"_blank">shehabyomn@gmail.com</a>&gt; wrote:<br></span></=
div><div><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px=
;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-deco=
ration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=
=3D"ltr">Yes, I tried with only one of those contexts and I still ran into =
the same problem.</div></blockquote><div>What is the setting returned by<br=
></div><br><div>cat /proc/sys/kernel/perf_event_<wbr>paranoid<br></div><br>=
<div>on your system ? And do you run your test program as root or normal us=
er ?<br></div><br><div>Please CC the mailing list on your reply.</div></div=
></div></blockquote><div><br></div></span><div>I will also need to know wha=
t glibc version you have on your system.<br></div><div><br></div><div>Thank=
s,<br></div><div><br></div><div>Mathieu<br></div><div><div class=3D"h5"><di=
v><br></div><div><br></div><blockquote style=3D"border-left:2px solid #1010=
ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-styl=
e:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-s=
ize:12pt"><div style=3D"font-family:arial,helvetica,sans-serif;font-size:12=
pt;color:#000000"><div><div><br></div><br><div>Thanks,<br></div><br><div>Ma=
thieu<br></div><br><blockquote style=3D"border-left:2px solid #1010ff;margi=
n-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal=
;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt=
"><div dir=3D"ltr"><br></div><div class=3D"gmail_extra"><br clear=3D"all"><=
div><div class=3D"m_4191731141621744608gmail_signature"><div dir=3D"ltr"><s=
pan style=3D"color:#888888">Shehab Y. Elsayed, MSc.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </span><span style=3D"color:#888888"><b=
r>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></span><br></di=
v></div></div><br><div class=3D"gmail_quote">On Mon, Mar 19, 2018 at 2:24 P=
M, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoy=
ers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.<wbr>com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"fon=
t-family:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><span><di=
v><span id=3D"m_4191731141621744608m_-2379611272366386122zwchr">----- On Ma=
r 19, 2018, at 12:36 PM, Shehab Elsayed &lt;<a href=3D"mailto:shehabyomn@gm=
ail.com" target=3D"_blank">shehabyomn@gmail.com</a>&gt; wrote:<br></span></=
div></span><div><span><blockquote style=3D"border-left:2px solid #1010ff;ma=
rgin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:nor=
mal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:1=
2pt"><div dir=3D"ltr"><div><div><div><div><div><div><div>Hi Mathieu,<br><br=
>Thank you very much for your reply.<br><br>I manually built lttng-ust from=
 source (commit #: 8a208943e21700211beee3ea64180a<wbr>5a534c7d2a).<br><br><=
/div>This is how I set up the tracing session:<br></div>1- lttng create lu_=
ncb_8_native -o {path}<br></div>2- lttng enable-event --userspace lttng_ust=
_pthread:pthread_<wbr>mutex_lock_req<br>=C2=A0=C2=A0=C2=A0 lttng enable-eve=
nt --userspace lttng_ust_pthread:pthread_<wbr>mutex_lock_acq<br>=C2=A0=C2=
=A0=C2=A0 lttng enable-event --userspace lttng_ust_pthread:pthread_<wbr>mut=
ex_lock_trylock<br>=C2=A0=C2=A0=C2=A0 lttng enable-event --userspace lttng_=
ust_pthread:pthread_<wbr>mutex_lock_unlock<br></div>3- lttng add-context -u=
 -t procname<br>=C2=A0=C2=A0=C2=A0 lttng add-context -u -t vpid<br>=C2=A0=
=C2=A0=C2=A0  lttng add-context -u -t pthread_id<br>=C2=A0=C2=A0=C2=A0  ltt=
ng add-context -u -t vtid<br>=C2=A0=C2=A0=C2=A0  lttng add-context -u -t ip=
<br>=C2=A0=C2=A0=C2=A0  lttng add-context -u -t perf:thread:cpu-cycles<br>=
=C2=A0=C2=A0=C2=A0  lttng add-context -u -t perf:thread:cycles<br>=C2=A0=C2=
=A0=C2=A0  lttng add-context -u -t perf:thread:instructions<br></div>4- ltt=
ng start<br>5- LD_PRELOAD=3D/usr/local/lib/<wbr>liblttng-ust-pthread-wrappe=
r.<wbr>so ./lu_ncb -p8 -n8096 -b32<br></div>6- lttng stop<br></div>7- lttng=
 destroy</div></blockquote><br></span><div>Can you reproduce if you remove =
the following contexts ?<br></div><span><br><div>=C2=A0=C2=A0=C2=A0 lttng a=
dd-context -u -t perf:thread:cpu-cycles<br>=C2=A0=C2=A0=C2=A0 lttng add-con=
text -u -t perf:thread:cycles<br>=C2=A0=C2=A0=C2=A0 lttng add-context -u -t=
 perf:thread:instructions</div><br></span><div>And if you only keep a singl=
e of those contexts ?<br></div><br><div>Thanks,<br></div><br><div>Mathieu<b=
r></div><div><div class=3D"m_4191731141621744608h5"><br><br><blockquote sty=
le=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:=
#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:=
Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><br><br><div><d=
iv><br></div></div></div><div class=3D"gmail_extra"><br clear=3D"all"><div>=
<div class=3D"m_4191731141621744608m_-2379611272366386122gmail_signature"><=
div dir=3D"ltr"><span style=3D"color:#888888">Shehab Y. Elsayed, MSc.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </span><span style=3D"color:#888888"><b=
r>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></span><br></di=
v></div></div><br><div class=3D"gmail_quote">On Mon, Mar 19, 2018 at 12:21 =
PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desno=
yers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.<wbr>com</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"fo=
nt-family:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><span><b=
r><br><div><span id=3D"m_4191731141621744608m_-2379611272366386122m_-392833=
4406880738982zwchr">----- On Mar 16, 2018, at 5:37 PM, Shehab Elsayed &lt;<=
a href=3D"mailto:shehabyomn@gmail.com" target=3D"_blank">shehabyomn@gmail.c=
om</a>&gt; wrote:<br></span></div></span><div><span><blockquote style=3D"bo=
rder-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;fon=
t-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetic=
a,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div><div><div><div><di=
v><div><div><div><div><div>Hello All,<br><br></div>I am trying to instrumen=
t a <span id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880=
738982:3qh.1">pthread</span> application using the provided <span id=3D"m_4=
191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.2">pthre=
ad</span> wrapper, but I sometimes run into a &quot;Double free or corrupti=
on error (<span id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334=
406880738982:3qh.3">fasttop</span>)&quot; error. </div></div></div></div></=
div></div></div></div></div></div></blockquote><br></span><div>Please provi=
de more information about the version of lttng-ust you are using, and how y=
ou setup<br></div><div>your tracing session.<br></div><br><div>Thanks,<br><=
/div><br><div>Mathieu<br></div><br><blockquote style=3D"border-left:2px sol=
id #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;f=
ont-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-seri=
f;font-size:12pt"><div><div class=3D"m_4191731141621744608m_-23796112723663=
86122h5"><div dir=3D"ltr"><div><div><div><div><div><div><div><div><div><br>=
<br></div>Here is a description of what I have tried and noticed:<br></div>=
1- The problem isn&#39;t consistent. It sometimes happen and sometimes work=
s as expected.<br></div>2- From my experiments, the problem happens (more f=
requently at least) when adding performance counter contexts (I tried cycle=
s, <span id=3D"m_4191731141621744608m_-2379611272366386122m_-39283344068807=
38982:3qh.4">cpu</span>_cycles and instructions).<br></div>3- I am testing =
using <span id=3D"m_4191731141621744608m_-2379611272366386122m_-39283344068=
80738982:3qh.5">lu</span>_<span id=3D"m_4191731141621744608m_-2379611272366=
386122m_-3928334406880738982:3qh.6">ncb</span> from splash3 benchmark suite=
 after setting <span id=3D"m_4191731141621744608m_-2379611272366386122m_-39=
28334406880738982:3qh.7">LD</span>_<span id=3D"m_4191731141621744608m_-2379=
611272366386122m_-3928334406880738982:3qh.8">PRELOAD</span> to use the <spa=
n id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3=
qh.9">pthread</span> wrapper as described in the <span id=3D"m_419173114162=
1744608m_-2379611272366386122m_-3928334406880738982:3qh.10">LTTng</span> do=
cuments.<br></div>4- Here is the <span id=3D"m_4191731141621744608m_-237961=
1272366386122m_-3928334406880738982:3qh.11">backtrace</span> printed after =
exiting:<br>=3D=3D=3D=3D=3D=3D=3D <span id=3D"m_4191731141621744608m_-23796=
11272366386122m_-3928334406880738982:3qh.12">Backtrace</span>: =3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>/lib64/<span id=3D"m_4191731141621744608m_-2379611272366=
386122m_-3928334406880738982:3qh.13">libc</span>.so.6([Thread 0x7ffff561170=
0 (<span id=3D"m_4191731141621744608m_-2379611272366386122m_-39283344068807=
38982:3qh.14">LWP</span> 97229) exited]<br>/<span id=3D"m_41917311416217446=
08m_-2379611272366386122m_-3928334406880738982:3qh.15">usr</span>/local/lib=
/<span id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880738=
982:3qh.16">liblttng</span>-<span id=3D"m_4191731141621744608m_-23796112723=
66386122m_-3928334406880738982:3qh.17">ust</span>.<wbr>so.0(<span id=3D"m_4=
191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.18">lttn=
g</span>_destroy_context+<wbr>0x35)[0x7ffff7471575]<br>/<span id=3D"m_41917=
31141621744608m_-2379611272366386122m_-3928334406880738982:3qh.19">usr</spa=
n>/local/lib/<span id=3D"m_4191731141621744608m_-2379611272366386122m_-3928=
334406880738982:3qh.20">liblttng</span>-<span id=3D"m_4191731141621744608m_=
-2379611272366386122m_-3928334406880738982:3qh.21">ust</span>.<wbr>so.0(<sp=
an id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:=
3qh.22">lttng</span>_session_destroy+<wbr>0x21c)[0x7ffff747363c]<br>/<span =
id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh=
.23">usr</span>/local/lib/<span id=3D"m_4191731141621744608m_-2379611272366=
386122m_-3928334406880738982:3qh.24">liblttng</span>-<span id=3D"m_41917311=
41621744608m_-2379611272366386122m_-3928334406880738982:3qh.25">ust</span>.=
<wbr>so.0(+0x1e906)[0x7ffff746d906]<br>/<span id=3D"m_4191731141621744608m_=
-2379611272366386122m_-3928334406880738982:3qh.26">usr</span>/local/lib/<sp=
an id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:=
3qh.27">liblttng</span>-<span id=3D"m_4191731141621744608m_-237961127236638=
6122m_-3928334406880738982:3qh.28">ust</span>.<wbr>so.0(<span id=3D"m_41917=
31141621744608m_-2379611272366386122m_-3928334406880738982:3qh.29">lttng</s=
pan>_<span id=3D"m_4191731141621744608m_-2379611272366386122m_-392833440688=
0738982:3qh.30">ust</span>_<span id=3D"m_4191731141621744608m_-237961127236=
6386122m_-3928334406880738982:3qh.31">objd</span>_<span id=3D"m_41917311416=
21744608m_-2379611272366386122m_-3928334406880738982:3qh.32">unref</span>+<=
wbr>0x9f)[0x7ffff746dccf]<br>/<span id=3D"m_4191731141621744608m_-237961127=
2366386122m_-3928334406880738982:3qh.33">usr</span>/local/lib/<span id=3D"m=
_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.34">li=
blttng</span>-<span id=3D"m_4191731141621744608m_-2379611272366386122m_-392=
8334406880738982:3qh.35">ust</span>.<wbr>so.0(<span id=3D"m_419173114162174=
4608m_-2379611272366386122m_-3928334406880738982:3qh.36">lttng</span>_<span=
 id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3q=
h.37">ust</span>_<span id=3D"m_4191731141621744608m_-2379611272366386122m_-=
3928334406880738982:3qh.38">objd</span>_<span id=3D"m_4191731141621744608m_=
-2379611272366386122m_-3928334406880738982:3qh.39">unref</span>+<wbr>0x9f)[=
0x7ffff746dccf]<br>/<span id=3D"m_4191731141621744608m_-2379611272366386122=
m_-3928334406880738982:3qh.40">usr</span>/local/lib/<span id=3D"m_419173114=
1621744608m_-2379611272366386122m_-3928334406880738982:3qh.41">liblttng</sp=
an>-<span id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880=
738982:3qh.42">ust</span>.<wbr>so.0(<span id=3D"m_4191731141621744608m_-237=
9611272366386122m_-3928334406880738982:3qh.43">lttng</span>_<span id=3D"m_4=
191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.44">ust<=
/span>_<span id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406=
880738982:3qh.45">objd</span>_<span id=3D"m_4191731141621744608m_-237961127=
2366386122m_-3928334406880738982:3qh.46">unref</span>+<wbr>0x9f)[0x7ffff746=
dccf]<br>/<span id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334=
406880738982:3qh.47">usr</span>/local/lib/<span id=3D"m_4191731141621744608=
m_-2379611272366386122m_-3928334406880738982:3qh.48">liblttng</span>-<span =
id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh=
.49">ust</span>.<wbr>so.0(<span id=3D"m_4191731141621744608m_-2379611272366=
386122m_-3928334406880738982:3qh.50">lttng</span>_<span id=3D"m_41917311416=
21744608m_-2379611272366386122m_-3928334406880738982:3qh.51">ust</span>_<sp=
an id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:=
3qh.52">abi</span>_exit+0x68)[<wbr>0x7ffff746ead8]<br>/<span id=3D"m_419173=
1141621744608m_-2379611272366386122m_-3928334406880738982:3qh.53">usr</span=
>/local/lib/<span id=3D"m_4191731141621744608m_-2379611272366386122m_-39283=
34406880738982:3qh.54">liblttng</span>-<span id=3D"m_4191731141621744608m_-=
2379611272366386122m_-3928334406880738982:3qh.55">ust</span>.<wbr>so.0(+0x1=
91d3)[0x7ffff74681d3]<br>/<span id=3D"m_4191731141621744608m_-2379611272366=
386122m_-3928334406880738982:3qh.56">usr</span>/local/lib/<span id=3D"m_419=
1731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.57">libltt=
ng</span>-<span id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334=
406880738982:3qh.58">ust</span>.<wbr>so.0(<span id=3D"m_4191731141621744608=
m_-2379611272366386122m_-3928334406880738982:3qh.59">lttng</span>_<span id=
=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.6=
0">ust</span>_exit+0x67)[<wbr>0x7ffff745ed57]<br>/lib64/<span id=3D"m_41917=
31141621744608m_-2379611272366386122m_-3928334406880738982:3qh.61">ld</span=
>-<span id=3D"m_4191731141621744608m_-2379611272366386122m_-392833440688073=
8982:3qh.62">linux</span>-x86-64.so.2(+<wbr>0xf85a)[0x7ffff7dec85a]<br>/lib=
64/<span id=3D"m_4191731141621744608m_-2379611272366386122m_-39283344068807=
38982:3qh.63">libc</span>.so.6(+0x38a49)[<wbr>0x7ffff6ca6a49]<br>/lib64/<sp=
an id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:=
3qh.64">libc</span>.so.6(+0x38a95)[<wbr>0x7ffff6ca6a95]<br>/<span id=3D"m_4=
191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.65">aena=
o</span>-99/elsayed9/<span id=3D"m_4191731141621744608m_-237961127236638612=
2m_-3928334406880738982:3qh.66">LTTng</span>/data/<wbr>scripts/<span id=3D"=
m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.67">t=
mp</span>/<span id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334=
406880738982:3qh.68">lu</span>_<span id=3D"m_4191731141621744608m_-23796112=
72366386122m_-3928334406880738982:3qh.69">ncb</span>[0x401b51]<br>/lib64/<s=
pan id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880738982=
:3qh.70">libc</span>.so.6(__<span id=3D"m_4191731141621744608m_-23796112723=
66386122m_-3928334406880738982:3qh.71">libc</span>_start_<wbr>main+0xf5)[0x=
7ffff6c8fb35]<br>/<span id=3D"m_4191731141621744608m_-2379611272366386122m_=
-3928334406880738982:3qh.72">aenao</span>-99/elsayed9/<span id=3D"m_4191731=
141621744608m_-2379611272366386122m_-3928334406880738982:3qh.73">LTTng</spa=
n>/data/<wbr>scripts/<span id=3D"m_4191731141621744608m_-237961127236638612=
2m_-3928334406880738982:3qh.74">tmp</span>/<span id=3D"m_419173114162174460=
8m_-2379611272366386122m_-3928334406880738982:3qh.75">lu</span>_<span id=3D=
"m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.76">=
ncb</span>[0x401c44]<br></div>5- Also, this is a <span id=3D"m_419173114162=
1744608m_-2379611272366386122m_-3928334406880738982:3qh.77">backtrace</span=
> I obtained from <span id=3D"m_4191731141621744608m_-2379611272366386122m_=
-3928334406880738982:3qh.78">gdb</span>:<br>#0=C2=A0 0x00007ffff6eac1d7 in =
raise () from /lib64/<span id=3D"m_4191731141621744608m_-237961127236638612=
2m_-3928334406880738982:3qh.79">libc</span>.so.6<br>#1=C2=A0 0x00007ffff6ea=
d8c8 in abort () from /lib64/<span id=3D"m_4191731141621744608m_-2379611272=
366386122m_-3928334406880738982:3qh.80">libc</span>.so.6<br>#2=C2=A0 0x0000=
7ffff6eebf07 in __<span id=3D"m_4191731141621744608m_-2379611272366386122m_=
-3928334406880738982:3qh.81">libc</span>_message () from /lib64/<span id=3D=
"m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.82">=
libc</span>.so.6<br>#3=C2=A0 0x00007ffff6ef3503 in _int_free () from /lib64=
/<span id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880738=
982:3qh.83">libc</span>.so.6<br>#4=C2=A0 0x00007ffff768ad25 in <span id=3D"=
m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.84">l=
ttng</span>_destroy_<span id=3D"m_4191731141621744608m_-2379611272366386122=
m_-3928334406880738982:3qh.85">perf</span>_counter_<wbr>field (<br>=C2=A0=
=C2=A0=C2=A0 field=3D&lt;optimized out&gt;) at <span id=3D"m_41917311416217=
44608m_-2379611272366386122m_-3928334406880738982:3qh.86">lttng</span>-cont=
ext-<span id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880=
738982:3qh.87">perf</span>-counters.c:<wbr>418<br>#5=C2=A0 0x00007ffff767a5=
75 in <span id=3D"m_4191731141621744608m_-2379611272366386122m_-39283344068=
80738982:3qh.88">lttng</span>_destroy_context (<br><span id=3D"m_4191731141=
621744608m_-2379611272366386122m_-3928334406880738982:3qh.89">ctx</span>=3D=
0x7ffff0011090) at <span id=3D"m_4191731141621744608m_-2379611272366386122m=
_-3928334406880738982:3qh.90">lttng</span>-context.c:278<br>#6=C2=A0 0x0000=
7ffff767c63c in _<span id=3D"m_4191731141621744608m_-2379611272366386122m_-=
3928334406880738982:3qh.91">lttng</span>_channel_<span id=3D"m_419173114162=
1744608m_-2379611272366386122m_-3928334406880738982:3qh.92">unmap</span> (<=
br><span id=3D"m_4191731141621744608m_-2379611272366386122m_-39283344068807=
38982:3qh.93">lttng</span>_<span id=3D"m_4191731141621744608m_-237961127236=
6386122m_-3928334406880738982:3qh.94">chan</span>=3D0x7ffff0010f40) at <spa=
n id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3=
qh.95">lttng</span>-events.c:172<br>#7=C2=A0 <span id=3D"m_4191731141621744=
608m_-2379611272366386122m_-3928334406880738982:3qh.96">lttng</span>_sessio=
n_destroy (session=3D0x7ffff0000900)<br>=C2=A0=C2=A0=C2=A0 at <span id=3D"m=
_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.97">lt=
tng</span>-events.c:247<br>#8=C2=A0 0x00007ffff7676906 in <span id=3D"m_419=
1731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.98">lttng<=
/span>_release_session (<br><span id=3D"m_4191731141621744608m_-23796112723=
66386122m_-3928334406880738982:3qh.99">objd</span>=3D&lt;optimized out&gt;)=
 at <span id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880=
738982:3qh.100">lttng</span>-<span id=3D"m_4191731141621744608m_-2379611272=
366386122m_-3928334406880738982:3qh.101">ust</span>-<span id=3D"m_419173114=
1621744608m_-2379611272366386122m_-3928334406880738982:3qh.102">abi</span>.=
c:601<br>#9=C2=A0 0x00007ffff7676ccf in <span id=3D"m_4191731141621744608m_=
-2379611272366386122m_-3928334406880738982:3qh.103">lttng</span>_<span id=
=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.1=
04">ust</span>_<span id=3D"m_4191731141621744608m_-2379611272366386122m_-39=
28334406880738982:3qh.105">objd</span>_<span id=3D"m_4191731141621744608m_-=
2379611272366386122m_-3928334406880738982:3qh.106">unref</span> (id=3D1, <b=
r>=C2=A0=C2=A0=C2=A0 is_owner=3D&lt;optimized out&gt;) at <span id=3D"m_419=
1731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.107">lttng=
</span>-<span id=3D"m_4191731141621744608m_-2379611272366386122m_-392833440=
6880738982:3qh.108">ust</span>-<span id=3D"m_4191731141621744608m_-23796112=
72366386122m_-3928334406880738982:3qh.109">abi</span>.c:216<br>#10 0x00007f=
fff7676ccf in <span id=3D"m_4191731141621744608m_-2379611272366386122m_-392=
8334406880738982:3qh.110">lttng</span>_<span id=3D"m_4191731141621744608m_-=
2379611272366386122m_-3928334406880738982:3qh.111">ust</span>_<span id=3D"m=
_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.112">o=
bjd</span>_<span id=3D"m_4191731141621744608m_-2379611272366386122m_-392833=
4406880738982:3qh.113">unref</span> (id=3D2, <br>=C2=A0=C2=A0=C2=A0 is_owne=
r=3D&lt;optimized out&gt;) at <span id=3D"m_4191731141621744608m_-237961127=
2366386122m_-3928334406880738982:3qh.114">lttng</span>-<span id=3D"m_419173=
1141621744608m_-2379611272366386122m_-3928334406880738982:3qh.115">ust</spa=
n>-<span id=3D"m_4191731141621744608m_-2379611272366386122m_-39283344068807=
38982:3qh.116">abi</span>.c:216<br>#11 0x00007ffff7676ccf in <span id=3D"m_=
4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.117">lt=
tng</span>_<span id=3D"m_4191731141621744608m_-2379611272366386122m_-392833=
4406880738982:3qh.118">ust</span>_<span id=3D"m_4191731141621744608m_-23796=
11272366386122m_-3928334406880738982:3qh.119">objd</span>_<span id=3D"m_419=
1731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.120">unref=
</span> (id=3Did@entry=3D18, <br>=C2=A0=C2=A0=C2=A0 is_owner=3Dis_owner@ent=
ry=3D1) at <span id=3D"m_4191731141621744608m_-2379611272366386122m_-392833=
4406880738982:3qh.121">lttng</span>-<span id=3D"m_4191731141621744608m_-237=
9611272366386122m_-3928334406880738982:3qh.122">ust</span>-<span id=3D"m_41=
91731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.123">abi<=
/span>.c:216<br>#12 0x00007ffff7677ad8 in <span id=3D"m_4191731141621744608=
m_-2379611272366386122m_-3928334406880738982:3qh.124">objd</span>_table_des=
troy ()<br>=C2=A0=C2=A0=C2=A0 at <span id=3D"m_4191731141621744608m_-237961=
1272366386122m_-3928334406880738982:3qh.125">lttng</span>-<span id=3D"m_419=
1731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.126">ust</=
span>-<span id=3D"m_4191731141621744608m_-2379611272366386122m_-39283344068=
80738982:3qh.127">abi</span>.c:235<br>#13 <span id=3D"m_4191731141621744608=
m_-2379611272366386122m_-3928334406880738982:3qh.128">lttng</span>_<span id=
=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.1=
29">ust</span>_<span id=3D"m_4191731141621744608m_-2379611272366386122m_-39=
28334406880738982:3qh.130">abi</span>_exit () at <span id=3D"m_419173114162=
1744608m_-2379611272366386122m_-3928334406880738982:3qh.131">lttng</span>-<=
span id=3D"m_4191731141621744608m_-2379611272366386122m_-392833440688073898=
2:3qh.132">ust</span>-<span id=3D"m_4191731141621744608m_-23796112723663861=
22m_-3928334406880738982:3qh.133">abi</span>.c:1002<br>#14 0x00007ffff76711=
d3 in <span id=3D"m_4191731141621744608m_-2379611272366386122m_-39283344068=
80738982:3qh.134">lttng</span>_<span id=3D"m_4191731141621744608m_-23796112=
72366386122m_-3928334406880738982:3qh.135">ust</span>_cleanup (exiting=3D1)=
<br>=C2=A0=C2=A0=C2=A0 at <span id=3D"m_4191731141621744608m_-2379611272366=
386122m_-3928334406880738982:3qh.136">lttng</span>-<span id=3D"m_4191731141=
621744608m_-2379611272366386122m_-3928334406880738982:3qh.137">ust</span>-c=
omm.c:1807<br>#15 0x00007ffff7667d57 in <span id=3D"m_4191731141621744608m_=
-2379611272366386122m_-3928334406880738982:3qh.138">lttng</span>_<span id=
=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.1=
39">ust</span>_exit ()<br>=C2=A0=C2=A0=C2=A0 at <span id=3D"m_4191731141621=
744608m_-2379611272366386122m_-3928334406880738982:3qh.140">lttng</span>-<s=
pan id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880738982=
:3qh.141">ust</span>-comm.c:1874<br>#16 0x00007ffff7dec85a in _<span id=3D"=
m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.142">=
dl</span>_<span id=3D"m_4191731141621744608m_-2379611272366386122m_-3928334=
406880738982:3qh.143">fini</span> ()<br>=C2=A0=C2=A0 from /lib64/<span id=
=3D"m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.1=
44">ld</span>-<span id=3D"m_4191731141621744608m_-2379611272366386122m_-392=
8334406880738982:3qh.145">linux</span>-x86-64.so.2<br>#17 0x00007ffff6eafa4=
9 in __run_exit_handlers ()<br>=C2=A0=C2=A0 from /lib64/<span id=3D"m_41917=
31141621744608m_-2379611272366386122m_-3928334406880738982:3qh.146">libc</s=
pan>.so.6<br>#18 0x00007ffff6eafa95 in exit () from /lib64/<span id=3D"m_41=
91731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.147">libc=
</span>.so.6<br>#19 0x0000000000401b51 in main (<span id=3D"m_4191731141621=
744608m_-2379611272366386122m_-3928334406880738982:3qh.148">argc</span>=3D&=
lt;optimized out&gt;, <br><span id=3D"m_4191731141621744608m_-2379611272366=
386122m_-3928334406880738982:3qh.149">argv</span>=3D&lt;optimized out&gt;) =
at <span id=3D"m_4191731141621744608m_-2379611272366386122m_-39283344068807=
38982:3qh.150">lu</span>.c:368<br><br></div>Any ideas, why this happens and=
 how to fix it?<br><br></div>Thanks,<br></div><span id=3D"m_419173114162174=
4608m_-2379611272366386122m_-3928334406880738982:3qh.151">Shehab</span><br>=
<div><div><div><div><br><br></div></div></div></div></div><br></div></div>_=
_____________________________<wbr>_________________<br>lttng-dev mailing li=
st<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-=
dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-<wbr>b=
in/mailman/listinfo/lttng-dev</a><span class=3D"m_4191731141621744608m_-237=
9611272366386122HOEnZb"><span style=3D"color:#888888"><br></span></span></b=
lockquote></div><span class=3D"m_4191731141621744608m_-2379611272366386122H=
OEnZb"><span style=3D"color:#888888"><br><div>-- <br></div><div>Mathieu Des=
noyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_b=
lank">http://www.efficios.com</a><br></div></span></span></div></div></bloc=
kquote></div></div><br></blockquote></div></div></div><div><div class=3D"m_=
4191731141621744608h5"><br><div>-- <br></div><div>Mathieu Desnoyers<br>Effi=
ciOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://w=
ww.efficios.com</a><br></div></div></div></div></div></blockquote></div></d=
iv><br></blockquote></div><br><div>-- <br></div><div>Mathieu Desnoyers<br>E=
fficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http:=
//www.efficios.com</a></div></div><br></blockquote></div></div></div><div><=
div class=3D"h5"><div><br></div><div>-- <br></div><div>Mathieu Desnoyers<br=
>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">htt=
p://www.efficios.com</a></div></div></div></div></div></blockquote></div><b=
r></div>

--883d24f22b4ce1ab5d0567c950a1--

--===============8897821653214766862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8897821653214766862==--
