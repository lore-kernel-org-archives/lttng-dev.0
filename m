From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Double free or corruption error (fasttop)
Date: Wed, 21 Mar 2018 13:27:17 -0400 (EDT)
Message-ID: <268788496.560.1521653237589.JavaMail.zimbra__31013.7883214795$1521653132$gmane$org@efficios.com>
References: <CAC-H6ttMF-CjzDH7a6bmeoOPP8JRLptYTmGJVvrx5t-G0Se_gA@mail.gmail.com>
 <173668501.337.1521487906796.JavaMail.zimbra@efficios.com>
 <CAC-H6tsWkYAxYFR6zsdcf+V_e3VYtDvZbYk80mc0raW-AKU5hA@mail.gmail.com>
 <1883907448.467.1521489713355.JavaMail.zimbra@efficios.com>
 <CAC-H6ttwT-tJVFE8iycjzUod2jyxHrfT1TYFhHZzyar98f6jtA@mail.gmail.com>
 <568213680.975.1521562064453.JavaMail.zimbra@efficios.com>
 <446537616.1725.1521579509437.JavaMail.zimbra@efficios.com>
 <1870456531.1798.1521582159880.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_Part_556_408660655.1521653237585"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 405xZQ2PdWzxVB
 for <lttng-dev@lists.lttng.org>; Wed, 21 Mar 2018 13:27:25 -0400 (EDT)
In-Reply-To: <1870456531.1798.1521582159880.JavaMail.zimbra@efficios.com>
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

------=_Part_556_408660655.1521653237585
Content-Type: multipart/alternative;
	boundary="=_421cce1e-7b82-4ae2-ba5c-12e34a0f1321"

--=_421cce1e-7b82-4ae2-ba5c-12e34a0f1321
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Mar 20, 2018, at 5:42 PM, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote: 

> ----- On Mar 20, 2018, at 4:58 PM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:

>> ----- On Mar 20, 2018, at 12:07 PM, Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:

>>> ----- On Mar 19, 2018, at 4:21 PM, Shehab Elsayed <shehabyomn@gmail.com> wrote:

>>>> I did "echo "-1" > /proc/sys/kernel/perf_event_paranoid " and made sure the
>>>> value was actually written by "cat /proc/sys/kernel/perf_event_paranoid"

>>>> It executed normally 2 times but then got the same error.

>>> Can you provide the output when reproducing the issue with the
>>> LTTNG_UST_DEBUG=1 environment variable set when starting
>>> your test program ?

>> I just noticed something that might explain what goes wrong here:

>> lttng-context-perf-counters.c: add_thread_field() grabs the ust_lock(). Pthread
>> mutex
>> in your case is instrumented with the pthread wrapper. This "add_thread_field"
>> is invoked
>> the first time the perf counter is hit by each given thread. When this happens,
>> the
>> instrumented pthread mutex will try to call into the instrumentation tracepoint
>> again,
>> which will call add_thread_field() (again), and so on until we reach the
>> libringbuffer
>> "lib_ring_buffer_nesting" threshold of 4 calls deep.

>> I suspect this situation where we recursively call add_thread_field is
>> unexpected,
>> which may trigger your double-free here.

>> Will investigate more.

> Can you try with the attached patch applied ?

Here is an updated v2 of the patch which tests the notrace tls counter sooner (before evaluating 
filter). Please let me know how it goes. 

Thanks, 

Mathieu 

> Thanks,

> Mathieu

>> Thanks,

>> Mathieu

>>> Thanks,

>>> Mathieu

>>>> Shehab Y. Elsayed, MSc.
>>>> PhD Student
>>>> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
>>>> University of Toronto
>>>> E-mail: [ https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11# |
>>>> shehabyomn@gmail.com ]

>>>> On Mon, Mar 19, 2018 at 4:01 PM, Mathieu Desnoyers < [
>>>> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
>>>> wrote:

>>>>> ----- On Mar 19, 2018, at 3:53 PM, Shehab Elsayed < [
>>>>> mailto:shehabyomn@gmail.com | shehabyomn@gmail.com ] > wrote:

>>>>>> cat /proc/sys/kernel/perf_event_paranoid ---> returns 1

>>>>>> I run the program as a normal user

>>>>>> The glibc version I get by running "ldd --version" is 2.17

>>>>> Can you reproduce the issue after you do this as root ?

>>>>> echo "-1" > /proc/sys/kernel/perf_event_paranoid

>>>>> Based on this documentation of the Linux kernel:

>>>>> Documentation/sysctl/kernel.txt:

>>>>> perf_event_paranoid:

>>>>> Controls use of the performance events system by unprivileged
>>>>> users (without CAP_SYS_ADMIN). The default value is 2.

>>>>> -1: Allow use of (almost) all events by all users
>>>>> Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
>>>>> >=0: Disallow ftrace function tracepoint by users without CAP_SYS_ADMIN
>>>>> Disallow raw tracepoint access by users without CAP_SYS_ADMIN
>>>>> >=1: Disallow CPU event access by users without CAP_SYS_ADMIN
>>>>> >=2: Disallow kernel profiling by users without CAP_SYS_ADMIN

>>>>> Thanks,

>>>>> Mathieu

>>>>>> Shehab Y. Elsayed, MSc.
>>>>>> PhD Student
>>>>>> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
>>>>>> University of Toronto
>>>>>> E-mail: [ https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11# |
>>>>>> shehabyomn@gmail.com ]

>>>>>> On Mon, Mar 19, 2018 at 3:31 PM, Mathieu Desnoyers < [
>>>>>> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
>>>>>> wrote:

>>>>>>> ---- On Mar 19, 2018, at 3:26 PM, Mathieu Desnoyers < [
>>>>>>> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
>>>>>>> wrote:

>>>>>>>> ----- On Mar 19, 2018, at 2:26 PM, Shehab Elsayed < [
>>>>>>>> mailto:shehabyomn@gmail.com | shehabyomn@gmail.com ] > wrote:

>>>>>>>>> Yes, I tried with only one of those contexts and I still ran into the same
>>>>>>>>> problem.

>>>>>>>> What is the setting returned by

>>>>>>>> cat /proc/sys/kernel/perf_event_paranoid

>>>>>>>> on your system ? And do you run your test program as root or normal user ?

>>>>>>>> Please CC the mailing list on your reply.

>>>>>>> I will also need to know what glibc version you have on your system.

>>>>>>> Thanks,

>>>>>>> Mathieu

>>>>>>>> Thanks,

>>>>>>>> Mathieu

>>>>>>>>> Shehab Y. Elsayed, MSc.
>>>>>>>>> PhD Student
>>>>>>>>> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
>>>>>>>>> University of Toronto
>>>>>>>>> E-mail: [ https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11# |
>>>>>>>>> shehabyomn@gmail.com ]

>>>>>>>>> On Mon, Mar 19, 2018 at 2:24 PM, Mathieu Desnoyers < [
>>>>>>>>> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
>>>>>>>>> wrote:

>>>>>>>>>> ----- On Mar 19, 2018, at 12:36 PM, Shehab Elsayed < [
>>>>>>>>>> mailto:shehabyomn@gmail.com | shehabyomn@gmail.com ] > wrote:

>>>>>>>>>>> Hi Mathieu,

>>>>>>>>>>> Thank you very much for your reply.

>>>>>>>>>>> I manually built lttng-ust from source (commit #:
>>>>>>>>>>> 8a208943e21700211beee3ea64180a5a534c7d2a).

>>>>>>>>>>> This is how I set up the tracing session:
>>>>>>>>>>> 1- lttng create lu_ncb_8_native -o {path}
>>>>>>>>>>> 2- lttng enable-event --userspace lttng_ust_pthread:pthread_mutex_lock_req
>>>>>>>>>>> lttng enable-event --userspace lttng_ust_pthread:pthread_mutex_lock_acq
>>>>>>>>>>> lttng enable-event --userspace lttng_ust_pthread:pthread_mutex_lock_trylock
>>>>>>>>>>> lttng enable-event --userspace lttng_ust_pthread:pthread_mutex_lock_unlock
>>>>>>>>>>> 3- lttng add-context -u -t procname
>>>>>>>>>>> lttng add-context -u -t vpid
>>>>>>>>>>> lttng add-context -u -t pthread_id
>>>>>>>>>>> lttng add-context -u -t vtid
>>>>>>>>>>> lttng add-context -u -t ip
>>>>>>>>>>> lttng add-context -u -t perf:thread:cpu-cycles
>>>>>>>>>>> lttng add-context -u -t perf:thread:cycles
>>>>>>>>>>> lttng add-context -u -t perf:thread:instructions
>>>>>>>>>>> 4- lttng start
>>>>>>>>>>> 5- LD_PRELOAD=/usr/local/lib/liblttng-ust-pthread-wrapper.so ./lu_ncb -p8 -n8096
>>>>>>>>>>> -b32
>>>>>>>>>>> 6- lttng stop
>>>>>>>>>>> 7- lttng destroy

>>>>>>>>>> Can you reproduce if you remove the following contexts ?

>>>>>>>>>> lttng add-context -u -t perf:thread:cpu-cycles
>>>>>>>>>> lttng add-context -u -t perf:thread:cycles
>>>>>>>>>> lttng add-context -u -t perf:thread:instructions

>>>>>>>>>> And if you only keep a single of those contexts ?

>>>>>>>>>> Thanks,

>>>>>>>>>> Mathieu

>>>>>>>>>>> Shehab Y. Elsayed, MSc.
>>>>>>>>>>> PhD Student
>>>>>>>>>>> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
>>>>>>>>>>> University of Toronto
>>>>>>>>>>> E-mail: [ https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11# |
>>>>>>>>>>> shehabyomn@gmail.com ]

>>>>>>>>>>> On Mon, Mar 19, 2018 at 12:21 PM, Mathieu Desnoyers < [
>>>>>>>>>>> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
>>>>>>>>>>> wrote:

>>>>>>>>>>>> ----- On Mar 16, 2018, at 5:37 PM, Shehab Elsayed < [
>>>>>>>>>>>> mailto:shehabyomn@gmail.com | shehabyomn@gmail.com ] > wrote:

>>>>>>>>>>>>> Hello All,

>>>>>>>>>>>>> I am trying to instrument a pthread application using the provided pthread
>>>>>>>>>>>>> wrapper, but I sometimes run into a "Double free or corruption error ( fasttop
>>>>>>>>>>>>> )" error.

>>>>>>>>>>>> Please provide more information about the version of lttng-ust you are using,
>>>>>>>>>>>> and how you setup
>>>>>>>>>>>> your tracing session.

>>>>>>>>>>>> Thanks,

>>>>>>>>>>>> Mathieu

>>>>>>>>>>>>> Here is a description of what I have tried and noticed:
>>>>>>>>>>>>> 1- The problem isn't consistent. It sometimes happen and sometimes works as
>>>>>>>>>>>>> expected.
>>>>>>>>>>>>> 2- From my experiments, the problem happens (more frequently at least) when
>>>>>>>>>>>>> adding performance counter contexts (I tried cycles, cpu _cycles and
>>>>>>>>>>>>> instructions).
>>>>>>>>>>>>> 3- I am testing using lu _ ncb from splash3 benchmark suite after setting LD _
>>>>>>>>>>>>> PRELOAD to use the pthread wrapper as described in the LTTng documents.
>>>>>>>>>>>>> 4- Here is the backtrace printed after exiting:
>>>>>>>>>>>>> ======= Backtrace : =========
>>>>>>>>>>>>> /lib64/ libc .so.6([Thread 0x7ffff5611700 ( LWP 97229) exited]
>>>>>>>>>>>>> / usr /local/lib/ liblttng - ust .so.0( lttng
>>>>>>>>>>>>> _destroy_context+0x35)[0x7ffff7471575]
>>>>>>>>>>>>> / usr /local/lib/ liblttng - ust .so.0( lttng
>>>>>>>>>>>>> _session_destroy+0x21c)[0x7ffff747363c]
>>>>>>>>>>>>> / usr /local/lib/ liblttng - ust .so.0(+0x1e906)[0x7ffff746d906]
>>>>>>>>>>>>> / usr /local/lib/ liblttng - ust .so.0( lttng _ ust _ objd _ unref
>>>>>>>>>>>>> +0x9f)[0x7ffff746dccf]
>>>>>>>>>>>>> / usr /local/lib/ liblttng - ust .so.0( lttng _ ust _ objd _ unref
>>>>>>>>>>>>> +0x9f)[0x7ffff746dccf]
>>>>>>>>>>>>> / usr /local/lib/ liblttng - ust .so.0( lttng _ ust _ objd _ unref
>>>>>>>>>>>>> +0x9f)[0x7ffff746dccf]
>>>>>>>>>>>>> / usr /local/lib/ liblttng - ust .so.0( lttng _ ust _ abi
>>>>>>>>>>>>> _exit+0x68)[0x7ffff746ead8]
>>>>>>>>>>>>> / usr /local/lib/ liblttng - ust .so.0(+0x191d3)[0x7ffff74681d3]
>>>>>>>>>>>>> / usr /local/lib/ liblttng - ust .so.0( lttng _ ust _exit+0x67)[0x7ffff745ed57]
>>>>>>>>>>>>> /lib64/ ld - linux -x86-64.so.2(+0xf85a)[0x7ffff7dec85a]
>>>>>>>>>>>>> /lib64/ libc .so.6(+0x38a49)[0x7ffff6ca6a49]
>>>>>>>>>>>>> /lib64/ libc .so.6(+0x38a95)[0x7ffff6ca6a95]
>>>>>>>>>>>>> / aenao -99/elsayed9/ LTTng /data/scripts/ tmp / lu _ ncb [0x401b51]
>>>>>>>>>>>>> /lib64/ libc .so.6(__ libc _start_main+0xf5)[0x7ffff6c8fb35]
>>>>>>>>>>>>> / aenao -99/elsayed9/ LTTng /data/scripts/ tmp / lu _ ncb [0x401c44]
>>>>>>>>>>>>> 5- Also, this is a backtrace I obtained from gdb :
>>>>>>>>>>>>> #0 0x00007ffff6eac1d7 in raise () from /lib64/ libc .so.6
>>>>>>>>>>>>> #1 0x00007ffff6ead8c8 in abort () from /lib64/ libc .so.6
>>>>>>>>>>>>> #2 0x00007ffff6eebf07 in __ libc _message () from /lib64/ libc .so.6
>>>>>>>>>>>>> #3 0x00007ffff6ef3503 in _int_free () from /lib64/ libc .so.6
>>>>>>>>>>>>> #4 0x00007ffff768ad25 in lttng _destroy_ perf _counter_field (
>>>>>>>>>>>>> field=<optimized out>) at lttng -context- perf -counters.c:418
>>>>>>>>>>>>> #5 0x00007ffff767a575 in lttng _destroy_context (
>>>>>>>>>>>>> ctx =0x7ffff0011090) at lttng -context.c:278
>>>>>>>>>>>>> #6 0x00007ffff767c63c in _ lttng _channel_ unmap (
>>>>>>>>>>>>> lttng _ chan =0x7ffff0010f40) at lttng -events.c:172
>>>>>>>>>>>>> #7 lttng _session_destroy (session=0x7ffff0000900)
>>>>>>>>>>>>> at lttng -events.c:247
>>>>>>>>>>>>> #8 0x00007ffff7676906 in lttng _release_session (
>>>>>>>>>>>>> objd =<optimized out>) at lttng - ust - abi .c:601
>>>>>>>>>>>>> #9 0x00007ffff7676ccf in lttng _ ust _ objd _ unref (id=1,
>>>>>>>>>>>>> is_owner=<optimized out>) at lttng - ust - abi .c:216
>>>>>>>>>>>>> #10 0x00007ffff7676ccf in lttng _ ust _ objd _ unref (id=2,
>>>>>>>>>>>>> is_owner=<optimized out>) at lttng - ust - abi .c:216
>>>>>>>>>>>>> #11 0x00007ffff7676ccf in lttng _ ust _ objd _ unref (id=id@entry=18,
>>>>>>>>>>>>> is_owner=is_owner@entry=1) at lttng - ust - abi .c:216
>>>>>>>>>>>>> #12 0x00007ffff7677ad8 in objd _table_destroy ()
>>>>>>>>>>>>> at lttng - ust - abi .c:235
>>>>>>>>>>>>> #13 lttng _ ust _ abi _exit () at lttng - ust - abi .c:1002
>>>>>>>>>>>>> #14 0x00007ffff76711d3 in lttng _ ust _cleanup (exiting=1)
>>>>>>>>>>>>> at lttng - ust -comm.c:1807
>>>>>>>>>>>>> #15 0x00007ffff7667d57 in lttng _ ust _exit ()
>>>>>>>>>>>>> at lttng - ust -comm.c:1874
>>>>>>>>>>>>> #16 0x00007ffff7dec85a in _ dl _ fini ()
>>>>>>>>>>>>> from /lib64/ ld - linux -x86-64.so.2
>>>>>>>>>>>>> #17 0x00007ffff6eafa49 in __run_exit_handlers ()
>>>>>>>>>>>>> from /lib64/ libc .so.6
>>>>>>>>>>>>> #18 0x00007ffff6eafa95 in exit () from /lib64/ libc .so.6
>>>>>>>>>>>>> #19 0x0000000000401b51 in main ( argc =<optimized out>,
>>>>>>>>>>>>> argv =<optimized out>) at lu .c:368

>>>>>>>>>>>>> Any ideas, why this happens and how to fix it?

>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>> Shehab

>>>>>>>>>>>>> _______________________________________________
>>>>>>>>>>>>> lttng-dev mailing list
>>>>>>>>>>>>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>>>>>>>>>>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>>>>>>>>>>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]

>>>>>>>>>>>> --
>>>>>>>>>>>> Mathieu Desnoyers
>>>>>>>>>>>> EfficiOS Inc.
>>>>>>>>>>>> [ http://www.efficios.com/ | http://www.efficios.com ]

>>>>>>>>>> --
>>>>>>>>>> Mathieu Desnoyers
>>>>>>>>>> EfficiOS Inc.
>>>>>>>>>> [ http://www.efficios.com/ | http://www.efficios.com ]

>>>>>>>> --
>>>>>>>> Mathieu Desnoyers
>>>>>>>> EfficiOS Inc.
>>>>>>>> [ http://www.efficios.com/ | http://www.efficios.com ]

>>>>>>> --
>>>>>>> Mathieu Desnoyers
>>>>>>> EfficiOS Inc.
>>>>>>> [ http://www.efficios.com/ | http://www.efficios.com ]

>>>>> --
>>>>> Mathieu Desnoyers
>>>>> EfficiOS Inc.
>>>>> [ http://www.efficios.com/ | http://www.efficios.com ]

>>> --
>>> Mathieu Desnoyers
>>> EfficiOS Inc.
>>> http://www.efficios.com

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_421cce1e-7b82-4ae2-ba5c-12e34a0f1321
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Mar 20, 2018, at 5:42 PM, Mathieu Desnoyers &lt;mathieu.desnoy=
ers@efficios.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TE=
XT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;pa=
dding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decorat=
ion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div style=
=3D"font-family: arial, helvetica, sans-serif; font-size: 12pt; color: #000=
000"><div><span id=3D"zwchr">----- On Mar 20, 2018, at 4:58 PM, Mathieu Des=
noyers &lt;mathieu.desnoyers@efficios.com&gt; wrote:<br></span></div><div><=
blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-l=
eft:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:non=
e;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div style=3D"fon=
t-family: arial, helvetica, sans-serif; font-size: 12pt; color: #000000"><d=
iv><span id=3D"zwchr">----- On Mar 20, 2018, at 12:07 PM, Mathieu Desnoyers=
 &lt;mathieu.desnoyers@efficios.com&gt; wrote:<br></span></div><div><blockq=
uote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div style=3D"font-fami=
ly: arial, helvetica, sans-serif; font-size: 12pt; color: #000000"><br><div=
><span id=3D"zwchr">----- On Mar 19, 2018, at 4:21 PM, Shehab Elsayed &lt;s=
hehabyomn@gmail.com&gt; wrote:<br></span></div><div><blockquote style=3D"bo=
rder-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;fon=
t-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetic=
a,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div>I did "echo "-1" =
&gt; <span class=3D"gmail-m_5949702530543711213gmail-im">/proc/sys/kernel/p=
erf_event_paranoid</span>" and made sure the value was actually written by =
"cat /proc/sys/kernel/perf_event_paranoid"<br><br></div><div>It executed no=
rmally 2 times but then got the same error.</div></div></blockquote><br><di=
v>Can you provide the output when reproducing the issue with the<br></div><=
div>LTTNG_UST_DEBUG=3D1 environment variable set when starting<br></div><di=
v>your test program ?</div></div></div></blockquote><div>I just noticed som=
ething that might explain what goes wrong here:<br></div><br><div>lttng-con=
text-perf-counters.c: add_thread_field() grabs the ust_lock(). Pthread mute=
x<br></div><div>in your case is instrumented with the pthread wrapper. This=
 "add_thread_field" is invoked<br></div><div>the first time the perf counte=
r is hit by each given thread. When this happens, the<br></div><div>instrum=
ented pthread mutex will try to call into the instrumentation tracepoint ag=
ain,<br></div><div>which will call add_thread_field() (again), and so on un=
til we reach the libringbuffer<br></div><div>"lib_ring_buffer_nesting" thre=
shold of 4 calls deep.<br></div><br><div>I suspect this situation where we =
recursively call add_thread_field is unexpected,<br></div><div>which may tr=
igger your double-free here.<br></div><br><div>Will investigate more.</div>=
</div></div></blockquote><div>Can you try with the attached patch applied ?=
</div></div></div></blockquote><div>Here is an updated v2 of the patch whic=
h tests the notrace tls counter sooner (before evaluating<br></div><div>fil=
ter). Please let me know how it goes.<br data-mce-bogus=3D"1"></div><div><b=
r data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><di=
v><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div=
><div><br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><d=
iv><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px soli=
d #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;fo=
nt-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif=
;font-size:12pt;"><div style=3D"font-family: arial, helvetica, sans-serif; =
font-size: 12pt; color: #000000"><div><div><br></div><br><div>Thanks,<br></=
div><br><div>Mathieu<br></div><br><br><br><blockquote style=3D"border-left:=
2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:n=
ormal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sa=
ns-serif;font-size:12pt;"><div style=3D"font-family: arial, helvetica, sans=
-serif; font-size: 12pt; color: #000000"><div><br><br><div>Thanks,<br></div=
><br><div>Mathieu<br></div><br><br><blockquote style=3D"border-left:2px sol=
id #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;f=
ont-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-seri=
f;font-size:12pt;"><div style=3D"font-family: arial, helvetica, sans-serif;=
 font-size: 12pt; color: #000000"><div><br><br><div>Thanks,<br></div><br><d=
iv>Mathieu<br></div><br><br><blockquote style=3D"border-left:2px solid #101=
0FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-sty=
le:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-=
size:12pt;"><div dir=3D"ltr"><br></div><div class=3D"gmail_extra"><br clear=
=3D"all"><div><div class=3D"gmail_signature"><div dir=3D"ltr"><span style=
=3D"color: #888888;">Shehab Y. Elsayed, MSc.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </span><span style=3D"color: #888888;">=
<br>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></span><br></di=
v></div></div><br><div class=3D"gmail_quote">On Mon, Mar 19, 2018 at 4:01 P=
M, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoy=
ers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-fam=
ily:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><span class=3D=
""><br><br><span id=3D"m_5949702530543711213zwchr">----- On Mar 19, 2018, a=
t 3:53 PM, Shehab Elsayed &lt;<a href=3D"mailto:shehabyomn@gmail.com" targe=
t=3D"_blank">shehabyomn@gmail.com</a>&gt; wrote:<br></span></span><div><spa=
n class=3D""><blockquote style=3D"border-left:2px solid #1010ff;margin-left=
:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-=
decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div=
 dir=3D"ltr"><div><div><span class=3D"m_5949702530543711213gmail-im">cat /p=
roc/sys/kernel/perf_event_paranoid</span> ---&gt; returns 1<br><br></div>I =
run the program as a normal user<br><br></div>The glibc version I get by ru=
nning "ldd --version" is 2.17</div></blockquote><br></span><div>Can you rep=
roduce the issue after you do this as root ?<br></div><br><div>echo "-1" &g=
t; <span class=3D"m_5949702530543711213gmail-im">/proc/sys/kernel/perf_even=
t_paranoid</span><br></div><br><div>Based on this documentation of the Linu=
x kernel:<br></div><br><div>Documentation/sysctl/kernel.txt:<br></div><br><=
div>perf_event_paranoid:<br><br>Controls use of the performance events syst=
em by unprivileged<br>users (without CAP_SYS_ADMIN).&nbsp; The default valu=
e is 2.<br><br>&nbsp;-1: Allow use of (almost) all events by all users<br>&=
nbsp;&nbsp;&nbsp;&nbsp; Ignore mlock limit after perf_event_mlock_kb withou=
t CAP_IPC_LOCK<br>&gt;=3D0: Disallow ftrace function tracepoint by users wi=
thout CAP_SYS_ADMIN<br>&nbsp;&nbsp;&nbsp;&nbsp; Disallow raw tracepoint acc=
ess by users without CAP_SYS_ADMIN<br>&gt;=3D1: Disallow CPU event access b=
y users without CAP_SYS_ADMIN<br>&gt;=3D2: Disallow kernel profiling by use=
rs without CAP_SYS_ADMIN<br><br></div><div><div class=3D"h5"><div>Thanks,<b=
r></div><br><div>Mathieu<br></div><br><blockquote style=3D"border-left:2px =
solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:norma=
l;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-s=
erif;font-size:12pt"><div dir=3D"ltr"><br></div><div class=3D"gmail_extra">=
<br clear=3D"all"><div><div class=3D"m_5949702530543711213gmail_signature">=
<div dir=3D"ltr"><span style=3D"color:#888888">Shehab Y. Elsayed, MSc.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </span><span style=3D"color:#888888"><b=
r>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></span><br></di=
v></div></div><br><div class=3D"gmail_quote">On Mon, Mar 19, 2018 at 3:31 P=
M, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoy=
ers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-fam=
ily:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><span><div><sp=
an id=3D"m_5949702530543711213m_4191731141621744608zwchr">---- On Mar 19, 2=
018, at 3:26 PM, Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@=
efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt; wrot=
e:<br></span></div></span><div><span><blockquote style=3D"border-left:2px s=
olid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal=
;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-se=
rif;font-size:12pt"><div style=3D"font-family:arial,helvetica,sans-serif;fo=
nt-size:12pt;color:#000000"><div><span id=3D"m_5949702530543711213m_4191731=
141621744608zwchr">----- On Mar 19, 2018, at 2:26 PM, Shehab Elsayed &lt;<a=
 href=3D"mailto:shehabyomn@gmail.com" target=3D"_blank">shehabyomn@gmail.co=
m</a>&gt; wrote:<br></span></div><div><blockquote style=3D"border-left:2px =
solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:norma=
l;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-s=
erif;font-size:12pt"><div dir=3D"ltr">Yes, I tried with only one of those c=
ontexts and I still ran into the same problem.</div></blockquote><div>What =
is the setting returned by<br></div><br><div>cat /proc/sys/kernel/perf_even=
t_paranoid<br></div><br><div>on your system ? And do you run your test prog=
ram as root or normal user ?<br></div><br><div>Please CC the mailing list o=
n your reply.</div></div></div></blockquote><br></span><div>I will also nee=
d to know what glibc version you have on your system.<br></div><br><div>Tha=
nks,<br></div><br><div>Mathieu<br></div><div><div class=3D"m_59497025305437=
11213h5"><br><br><blockquote style=3D"border-left:2px solid #1010ff;margin-=
left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;t=
ext-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt">=
<div style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:#=
000000"><div><br><br><div>Thanks,<br></div><br><div>Mathieu<br></div><br><b=
lockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-le=
ft:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none=
;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><b=
r></div><div class=3D"gmail_extra"><br clear=3D"all"><div><div class=3D"m_5=
949702530543711213m_4191731141621744608gmail_signature"><div dir=3D"ltr"><s=
pan style=3D"color:#888888">Shehab Y. Elsayed, MSc.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </span><span style=3D"color:#888888"><b=
r>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></span><br></di=
v></div></div><br><div class=3D"gmail_quote">On Mon, Mar 19, 2018 at 2:24 P=
M, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoy=
ers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-fam=
ily:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><span><div><sp=
an id=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122zw=
chr">----- On Mar 19, 2018, at 12:36 PM, Shehab Elsayed &lt;<a href=3D"mail=
to:shehabyomn@gmail.com" target=3D"_blank">shehabyomn@gmail.com</a>&gt; wro=
te:<br></span></div></span><div><span><blockquote style=3D"border-left:2px =
solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:norma=
l;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-s=
erif;font-size:12pt"><div dir=3D"ltr"><div><div><div><div><div><div><div>Hi=
 Mathieu,<br><br>Thank you very much for your reply.<br><br>I manually buil=
t lttng-ust from source (commit #: 8a208943e21700211beee3ea64180a5a534c7d2a=
).<br><br></div>This is how I set up the tracing session:<br></div>1- lttng=
 create lu_ncb_8_native -o {path}<br></div>2- lttng enable-event --userspac=
e lttng_ust_pthread:pthread_mutex_lock_req<br>&nbsp;&nbsp;&nbsp; lttng enab=
le-event --userspace lttng_ust_pthread:pthread_mutex_lock_acq<br>&nbsp;&nbs=
p;&nbsp; lttng enable-event --userspace lttng_ust_pthread:pthread_mutex_loc=
k_trylock<br>&nbsp;&nbsp;&nbsp; lttng enable-event --userspace lttng_ust_pt=
hread:pthread_mutex_lock_unlock<br></div>3- lttng add-context -u -t procnam=
e<br>&nbsp;&nbsp;&nbsp; lttng add-context -u -t vpid<br>&nbsp;&nbsp;&nbsp; =
 lttng add-context -u -t pthread_id<br>&nbsp;&nbsp;&nbsp;  lttng add-contex=
t -u -t vtid<br>&nbsp;&nbsp;&nbsp;  lttng add-context -u -t ip<br>&nbsp;&nb=
sp;&nbsp;  lttng add-context -u -t perf:thread:cpu-cycles<br>&nbsp;&nbsp;&n=
bsp;  lttng add-context -u -t perf:thread:cycles<br>&nbsp;&nbsp;&nbsp;  ltt=
ng add-context -u -t perf:thread:instructions<br></div>4- lttng start<br>5-=
 LD_PRELOAD=3D/usr/local/lib/liblttng-ust-pthread-wrapper.so ./lu_ncb -p8 -=
n8096 -b32<br></div>6- lttng stop<br></div>7- lttng destroy</div></blockquo=
te><br></span><div>Can you reproduce if you remove the following contexts ?=
<br></div><span><br><div>&nbsp;&nbsp;&nbsp; lttng add-context -u -t perf:th=
read:cpu-cycles<br>&nbsp;&nbsp;&nbsp; lttng add-context -u -t perf:thread:c=
ycles<br>&nbsp;&nbsp;&nbsp; lttng add-context -u -t perf:thread:instruction=
s</div><br></span><div>And if you only keep a single of those contexts ?<br=
></div><br><div>Thanks,<br></div><br><div>Mathieu<br></div><div><div class=
=3D"m_5949702530543711213m_4191731141621744608h5"><br><br><blockquote style=
=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><br><br><br></div=
><div class=3D"gmail_extra"><br clear=3D"all"><div><div class=3D"m_59497025=
30543711213m_4191731141621744608m_-2379611272366386122gmail_signature"><div=
 dir=3D"ltr"><span style=3D"color:#888888">Shehab Y. Elsayed, MSc.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </span><span style=3D"color:#888888"><b=
r>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></span><br></di=
v></div></div><br><div class=3D"gmail_quote">On Mon, Mar 19, 2018 at 12:21 =
PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desno=
yers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-fa=
mily:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><span><br><br=
><div><span id=3D"m_5949702530543711213m_4191731141621744608m_-237961127236=
6386122m_-3928334406880738982zwchr">----- On Mar 16, 2018, at 5:37 PM, Sheh=
ab Elsayed &lt;<a href=3D"mailto:shehabyomn@gmail.com" target=3D"_blank">sh=
ehabyomn@gmail.com</a>&gt; wrote:<br></span></div></span><div><span><blockq=
uote style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div><d=
iv><div><div><div><div><div><div><div><div>Hello All,<br><br></div>I am try=
ing to instrument a <span id=3D"m_5949702530543711213m_4191731141621744608m=
_-2379611272366386122m_-3928334406880738982:3qh.1">pthread</span> applicati=
on using the provided <span id=3D"m_5949702530543711213m_419173114162174460=
8m_-2379611272366386122m_-3928334406880738982:3qh.2">pthread</span> wrapper=
, but I sometimes run into a "Double free or corruption error (<span id=3D"=
m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344=
06880738982:3qh.3">fasttop</span>)" error. </div></div></div></div></div></=
div></div></div></div></div></blockquote><br></span><div>Please provide mor=
e information about the version of lttng-ust you are using, and how you set=
up<br></div><div>your tracing session.<br></div><br><div>Thanks,<br></div><=
br><div>Mathieu<br></div><br><blockquote style=3D"border-left:2px solid #10=
10ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-st=
yle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font=
-size:12pt"><div><div class=3D"m_5949702530543711213m_4191731141621744608m_=
-2379611272366386122h5"><div dir=3D"ltr"><div><div><div><div><div><div><div=
><div><div><br><br></div>Here is a description of what I have tried and not=
iced:<br></div>1- The problem isn't consistent. It sometimes happen and som=
etimes works as expected.<br></div>2- From my experiments, the problem happ=
ens (more frequently at least) when adding performance counter contexts (I =
tried cycles, <span id=3D"m_5949702530543711213m_4191731141621744608m_-2379=
611272366386122m_-3928334406880738982:3qh.4">cpu</span>_cycles and instruct=
ions).<br></div>3- I am testing using <span id=3D"m_5949702530543711213m_41=
91731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.5">lu</sp=
an>_<span id=3D"m_5949702530543711213m_4191731141621744608m_-23796112723663=
86122m_-3928334406880738982:3qh.6">ncb</span> from splash3 benchmark suite =
after setting <span id=3D"m_5949702530543711213m_4191731141621744608m_-2379=
611272366386122m_-3928334406880738982:3qh.7">LD</span>_<span id=3D"m_594970=
2530543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738=
982:3qh.8">PRELOAD</span> to use the <span id=3D"m_5949702530543711213m_419=
1731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.9">pthread=
</span> wrapper as described in the <span id=3D"m_5949702530543711213m_4191=
731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.10">LTTng</=
span> documents.<br></div>4- Here is the <span id=3D"m_5949702530543711213m=
_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.11">ba=
cktrace</span> printed after exiting:<br>=3D=3D=3D=3D=3D=3D=3D <span id=3D"=
m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344=
06880738982:3qh.12">Backtrace</span>: =3D=3D=3D=3D=3D=3D=3D=3D=3D<br>/lib64=
/<span id=3D"m_5949702530543711213m_4191731141621744608m_-23796112723663861=
22m_-3928334406880738982:3qh.13">libc</span>.so.6([Thread 0x7ffff5611700 (<=
span id=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122=
m_-3928334406880738982:3qh.14">LWP</span> 97229) exited]<br>/<span id=3D"m_=
5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928334406=
880738982:3qh.15">usr</span>/local/lib/<span id=3D"m_5949702530543711213m_4=
191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.16">libl=
ttng</span>-<span id=3D"m_5949702530543711213m_4191731141621744608m_-237961=
1272366386122m_-3928334406880738982:3qh.17">ust</span>.so.0(<span id=3D"m_5=
949702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344068=
80738982:3qh.18">lttng</span>_destroy_context+0x35)[0x7ffff7471575]<br>/<sp=
an id=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_=
-3928334406880738982:3qh.19">usr</span>/local/lib/<span id=3D"m_59497025305=
43711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3=
qh.20">liblttng</span>-<span id=3D"m_5949702530543711213m_41917311416217446=
08m_-2379611272366386122m_-3928334406880738982:3qh.21">ust</span>.so.0(<spa=
n id=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-=
3928334406880738982:3qh.22">lttng</span>_session_destroy+0x21c)[0x7ffff7473=
63c]<br>/<span id=3D"m_5949702530543711213m_4191731141621744608m_-237961127=
2366386122m_-3928334406880738982:3qh.23">usr</span>/local/lib/<span id=3D"m=
_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-392833440=
6880738982:3qh.24">liblttng</span>-<span id=3D"m_5949702530543711213m_41917=
31141621744608m_-2379611272366386122m_-3928334406880738982:3qh.25">ust</spa=
n>.so.0(+0x1e906)[0x7ffff746d906]<br>/<span id=3D"m_5949702530543711213m_41=
91731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.26">usr</=
span>/local/lib/<span id=3D"m_5949702530543711213m_4191731141621744608m_-23=
79611272366386122m_-3928334406880738982:3qh.27">liblttng</span>-<span id=3D=
"m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928334=
406880738982:3qh.28">ust</span>.so.0(<span id=3D"m_5949702530543711213m_419=
1731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.29">lttng<=
/span>_<span id=3D"m_5949702530543711213m_4191731141621744608m_-23796112723=
66386122m_-3928334406880738982:3qh.30">ust</span>_<span id=3D"m_59497025305=
43711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3=
qh.31">objd</span>_<span id=3D"m_5949702530543711213m_4191731141621744608m_=
-2379611272366386122m_-3928334406880738982:3qh.32">unref</span>+0x9f)[0x7ff=
ff746dccf]<br>/<span id=3D"m_5949702530543711213m_4191731141621744608m_-237=
9611272366386122m_-3928334406880738982:3qh.33">usr</span>/local/lib/<span i=
d=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-392=
8334406880738982:3qh.34">liblttng</span>-<span id=3D"m_5949702530543711213m=
_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.35">us=
t</span>.so.0(<span id=3D"m_5949702530543711213m_4191731141621744608m_-2379=
611272366386122m_-3928334406880738982:3qh.36">lttng</span>_<span id=3D"m_59=
49702530543711213m_4191731141621744608m_-2379611272366386122m_-392833440688=
0738982:3qh.37">ust</span>_<span id=3D"m_5949702530543711213m_4191731141621=
744608m_-2379611272366386122m_-3928334406880738982:3qh.38">objd</span>_<spa=
n id=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-=
3928334406880738982:3qh.39">unref</span>+0x9f)[0x7ffff746dccf]<br>/<span id=
=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928=
334406880738982:3qh.40">usr</span>/local/lib/<span id=3D"m_5949702530543711=
213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.41=
">liblttng</span>-<span id=3D"m_5949702530543711213m_4191731141621744608m_-=
2379611272366386122m_-3928334406880738982:3qh.42">ust</span>.so.0(<span id=
=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928=
334406880738982:3qh.43">lttng</span>_<span id=3D"m_5949702530543711213m_419=
1731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.44">ust</s=
pan>_<span id=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366=
386122m_-3928334406880738982:3qh.45">objd</span>_<span id=3D"m_594970253054=
3711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3q=
h.46">unref</span>+0x9f)[0x7ffff746dccf]<br>/<span id=3D"m_5949702530543711=
213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.47=
">usr</span>/local/lib/<span id=3D"m_5949702530543711213m_41917311416217446=
08m_-2379611272366386122m_-3928334406880738982:3qh.48">liblttng</span>-<spa=
n id=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-=
3928334406880738982:3qh.49">ust</span>.so.0(<span id=3D"m_59497025305437112=
13m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.50"=
>lttng</span>_<span id=3D"m_5949702530543711213m_4191731141621744608m_-2379=
611272366386122m_-3928334406880738982:3qh.51">ust</span>_<span id=3D"m_5949=
702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344068807=
38982:3qh.52">abi</span>_exit+0x68)[0x7ffff746ead8]<br>/<span id=3D"m_59497=
02530543711213m_4191731141621744608m_-2379611272366386122m_-392833440688073=
8982:3qh.53">usr</span>/local/lib/<span id=3D"m_5949702530543711213m_419173=
1141621744608m_-2379611272366386122m_-3928334406880738982:3qh.54">liblttng<=
/span>-<span id=3D"m_5949702530543711213m_4191731141621744608m_-23796112723=
66386122m_-3928334406880738982:3qh.55">ust</span>.so.0(+0x191d3)[0x7ffff746=
81d3]<br>/<span id=3D"m_5949702530543711213m_4191731141621744608m_-23796112=
72366386122m_-3928334406880738982:3qh.56">usr</span>/local/lib/<span id=3D"=
m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344=
06880738982:3qh.57">liblttng</span>-<span id=3D"m_5949702530543711213m_4191=
731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.58">ust</sp=
an>.so.0(<span id=3D"m_5949702530543711213m_4191731141621744608m_-237961127=
2366386122m_-3928334406880738982:3qh.59">lttng</span>_<span id=3D"m_5949702=
530543711213m_4191731141621744608m_-2379611272366386122m_-39283344068807389=
82:3qh.60">ust</span>_exit+0x67)[0x7ffff745ed57]<br>/lib64/<span id=3D"m_59=
49702530543711213m_4191731141621744608m_-2379611272366386122m_-392833440688=
0738982:3qh.61">ld</span>-<span id=3D"m_5949702530543711213m_41917311416217=
44608m_-2379611272366386122m_-3928334406880738982:3qh.62">linux</span>-x86-=
64.so.2(+0xf85a)[0x7ffff7dec85a]<br>/lib64/<span id=3D"m_594970253054371121=
3m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.63">=
libc</span>.so.6(+0x38a49)[0x7ffff6ca6a49]<br>/lib64/<span id=3D"m_59497025=
30543711213m_4191731141621744608m_-2379611272366386122m_-392833440688073898=
2:3qh.64">libc</span>.so.6(+0x38a95)[0x7ffff6ca6a95]<br>/<span id=3D"m_5949=
702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344068807=
38982:3qh.65">aenao</span>-99/elsayed9/<span id=3D"m_5949702530543711213m_4=
191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.66">LTTn=
g</span>/data/scripts/<span id=3D"m_5949702530543711213m_419173114162174460=
8m_-2379611272366386122m_-3928334406880738982:3qh.67">tmp</span>/<span id=
=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928=
334406880738982:3qh.68">lu</span>_<span id=3D"m_5949702530543711213m_419173=
1141621744608m_-2379611272366386122m_-3928334406880738982:3qh.69">ncb</span=
>[0x401b51]<br>/lib64/<span id=3D"m_5949702530543711213m_419173114162174460=
8m_-2379611272366386122m_-3928334406880738982:3qh.70">libc</span>.so.6(__<s=
pan id=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122m=
_-3928334406880738982:3qh.71">libc</span>_start_main+0xf5)[0x7ffff6c8fb35]<=
br>/<span id=3D"m_5949702530543711213m_4191731141621744608m_-23796112723663=
86122m_-3928334406880738982:3qh.72">aenao</span>-99/elsayed9/<span id=3D"m_=
5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928334406=
880738982:3qh.73">LTTng</span>/data/scripts/<span id=3D"m_59497025305437112=
13m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.74"=
>tmp</span>/<span id=3D"m_5949702530543711213m_4191731141621744608m_-237961=
1272366386122m_-3928334406880738982:3qh.75">lu</span>_<span id=3D"m_5949702=
530543711213m_4191731141621744608m_-2379611272366386122m_-39283344068807389=
82:3qh.76">ncb</span>[0x401c44]<br></div>5- Also, this is a <span id=3D"m_5=
949702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344068=
80738982:3qh.77">backtrace</span> I obtained from <span id=3D"m_59497025305=
43711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3=
qh.78">gdb</span>:<br>#0&nbsp; 0x00007ffff6eac1d7 in raise () from /lib64/<=
span id=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122=
m_-3928334406880738982:3qh.79">libc</span>.so.6<br>#1&nbsp; 0x00007ffff6ead=
8c8 in abort () from /lib64/<span id=3D"m_5949702530543711213m_419173114162=
1744608m_-2379611272366386122m_-3928334406880738982:3qh.80">libc</span>.so.=
6<br>#2&nbsp; 0x00007ffff6eebf07 in __<span id=3D"m_5949702530543711213m_41=
91731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.81">libc<=
/span>_message () from /lib64/<span id=3D"m_5949702530543711213m_4191731141=
621744608m_-2379611272366386122m_-3928334406880738982:3qh.82">libc</span>.s=
o.6<br>#3&nbsp; 0x00007ffff6ef3503 in _int_free () from /lib64/<span id=3D"=
m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344=
06880738982:3qh.83">libc</span>.so.6<br>#4&nbsp; 0x00007ffff768ad25 in <spa=
n id=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-=
3928334406880738982:3qh.84">lttng</span>_destroy_<span id=3D"m_594970253054=
3711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3q=
h.85">perf</span>_counter_field (<br>&nbsp;&nbsp;&nbsp; field=3D&lt;optimiz=
ed out&gt;) at <span id=3D"m_5949702530543711213m_4191731141621744608m_-237=
9611272366386122m_-3928334406880738982:3qh.86">lttng</span>-context-<span i=
d=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-392=
8334406880738982:3qh.87">perf</span>-counters.c:418<br>#5&nbsp; 0x00007ffff=
767a575 in <span id=3D"m_5949702530543711213m_4191731141621744608m_-2379611=
272366386122m_-3928334406880738982:3qh.88">lttng</span>_destroy_context (<b=
r><span id=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386=
122m_-3928334406880738982:3qh.89">ctx</span>=3D0x7ffff0011090) at <span id=
=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928=
334406880738982:3qh.90">lttng</span>-context.c:278<br>#6&nbsp; 0x00007ffff7=
67c63c in _<span id=3D"m_5949702530543711213m_4191731141621744608m_-2379611=
272366386122m_-3928334406880738982:3qh.91">lttng</span>_channel_<span id=3D=
"m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928334=
406880738982:3qh.92">unmap</span> (<br><span id=3D"m_5949702530543711213m_4=
191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.93">lttn=
g</span>_<span id=3D"m_5949702530543711213m_4191731141621744608m_-237961127=
2366386122m_-3928334406880738982:3qh.94">chan</span>=3D0x7ffff0010f40) at <=
span id=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122=
m_-3928334406880738982:3qh.95">lttng</span>-events.c:172<br>#7&nbsp; <span =
id=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-39=
28334406880738982:3qh.96">lttng</span>_session_destroy (session=3D0x7ffff00=
00900)<br>&nbsp;&nbsp;&nbsp; at <span id=3D"m_5949702530543711213m_41917311=
41621744608m_-2379611272366386122m_-3928334406880738982:3qh.97">lttng</span=
>-events.c:247<br>#8&nbsp; 0x00007ffff7676906 in <span id=3D"m_594970253054=
3711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3q=
h.98">lttng</span>_release_session (<br><span id=3D"m_5949702530543711213m_=
4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.99">obj=
d</span>=3D&lt;optimized out&gt;) at <span id=3D"m_5949702530543711213m_419=
1731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.100">lttng=
</span>-<span id=3D"m_5949702530543711213m_4191731141621744608m_-2379611272=
366386122m_-3928334406880738982:3qh.101">ust</span>-<span id=3D"m_594970253=
0543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982=
:3qh.102">abi</span>.c:601<br>#9&nbsp; 0x00007ffff7676ccf in <span id=3D"m_=
5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928334406=
880738982:3qh.103">lttng</span>_<span id=3D"m_5949702530543711213m_41917311=
41621744608m_-2379611272366386122m_-3928334406880738982:3qh.104">ust</span>=
_<span id=3D"m_5949702530543711213m_4191731141621744608m_-23796112723663861=
22m_-3928334406880738982:3qh.105">objd</span>_<span id=3D"m_594970253054371=
1213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.1=
06">unref</span> (id=3D1, <br>&nbsp;&nbsp;&nbsp; is_owner=3D&lt;optimized o=
ut&gt;) at <span id=3D"m_5949702530543711213m_4191731141621744608m_-2379611=
272366386122m_-3928334406880738982:3qh.107">lttng</span>-<span id=3D"m_5949=
702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344068807=
38982:3qh.108">ust</span>-<span id=3D"m_5949702530543711213m_41917311416217=
44608m_-2379611272366386122m_-3928334406880738982:3qh.109">abi</span>.c:216=
<br>#10 0x00007ffff7676ccf in <span id=3D"m_5949702530543711213m_4191731141=
621744608m_-2379611272366386122m_-3928334406880738982:3qh.110">lttng</span>=
_<span id=3D"m_5949702530543711213m_4191731141621744608m_-23796112723663861=
22m_-3928334406880738982:3qh.111">ust</span>_<span id=3D"m_5949702530543711=
213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.11=
2">objd</span>_<span id=3D"m_5949702530543711213m_4191731141621744608m_-237=
9611272366386122m_-3928334406880738982:3qh.113">unref</span> (id=3D2, <br>&=
nbsp;&nbsp;&nbsp; is_owner=3D&lt;optimized out&gt;) at <span id=3D"m_594970=
2530543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738=
982:3qh.114">lttng</span>-<span id=3D"m_5949702530543711213m_41917311416217=
44608m_-2379611272366386122m_-3928334406880738982:3qh.115">ust</span>-<span=
 id=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3=
928334406880738982:3qh.116">abi</span>.c:216<br>#11 0x00007ffff7676ccf in <=
span id=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122=
m_-3928334406880738982:3qh.117">lttng</span>_<span id=3D"m_5949702530543711=
213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.11=
8">ust</span>_<span id=3D"m_5949702530543711213m_4191731141621744608m_-2379=
611272366386122m_-3928334406880738982:3qh.119">objd</span>_<span id=3D"m_59=
49702530543711213m_4191731141621744608m_-2379611272366386122m_-392833440688=
0738982:3qh.120">unref</span> (id=3Did@entry=3D18, <br>&nbsp;&nbsp;&nbsp; i=
s_owner=3Dis_owner@entry=3D1) at <span id=3D"m_5949702530543711213m_4191731=
141621744608m_-2379611272366386122m_-3928334406880738982:3qh.121">lttng</sp=
an>-<span id=3D"m_5949702530543711213m_4191731141621744608m_-23796112723663=
86122m_-3928334406880738982:3qh.122">ust</span>-<span id=3D"m_5949702530543=
711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh=
.123">abi</span>.c:216<br>#12 0x00007ffff7677ad8 in <span id=3D"m_594970253=
0543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982=
:3qh.124">objd</span>_table_destroy ()<br>&nbsp;&nbsp;&nbsp; at <span id=3D=
"m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928334=
406880738982:3qh.125">lttng</span>-<span id=3D"m_5949702530543711213m_41917=
31141621744608m_-2379611272366386122m_-3928334406880738982:3qh.126">ust</sp=
an>-<span id=3D"m_5949702530543711213m_4191731141621744608m_-23796112723663=
86122m_-3928334406880738982:3qh.127">abi</span>.c:235<br>#13 <span id=3D"m_=
5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928334406=
880738982:3qh.128">lttng</span>_<span id=3D"m_5949702530543711213m_41917311=
41621744608m_-2379611272366386122m_-3928334406880738982:3qh.129">ust</span>=
_<span id=3D"m_5949702530543711213m_4191731141621744608m_-23796112723663861=
22m_-3928334406880738982:3qh.130">abi</span>_exit () at <span id=3D"m_59497=
02530543711213m_4191731141621744608m_-2379611272366386122m_-392833440688073=
8982:3qh.131">lttng</span>-<span id=3D"m_5949702530543711213m_4191731141621=
744608m_-2379611272366386122m_-3928334406880738982:3qh.132">ust</span>-<spa=
n id=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-=
3928334406880738982:3qh.133">abi</span>.c:1002<br>#14 0x00007ffff76711d3 in=
 <span id=3D"m_5949702530543711213m_4191731141621744608m_-23796112723663861=
22m_-3928334406880738982:3qh.134">lttng</span>_<span id=3D"m_59497025305437=
11213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.=
135">ust</span>_cleanup (exiting=3D1)<br>&nbsp;&nbsp;&nbsp; at <span id=3D"=
m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344=
06880738982:3qh.136">lttng</span>-<span id=3D"m_5949702530543711213m_419173=
1141621744608m_-2379611272366386122m_-3928334406880738982:3qh.137">ust</spa=
n>-comm.c:1807<br>#15 0x00007ffff7667d57 in <span id=3D"m_59497025305437112=
13m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.138=
">lttng</span>_<span id=3D"m_5949702530543711213m_4191731141621744608m_-237=
9611272366386122m_-3928334406880738982:3qh.139">ust</span>_exit ()<br>&nbsp=
;&nbsp;&nbsp; at <span id=3D"m_5949702530543711213m_4191731141621744608m_-2=
379611272366386122m_-3928334406880738982:3qh.140">lttng</span>-<span id=3D"=
m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344=
06880738982:3qh.141">ust</span>-comm.c:1874<br>#16 0x00007ffff7dec85a in _<=
span id=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122=
m_-3928334406880738982:3qh.142">dl</span>_<span id=3D"m_5949702530543711213=
m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.143">=
fini</span> ()<br>&nbsp;&nbsp; from /lib64/<span id=3D"m_594970253054371121=
3m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.144"=
>ld</span>-<span id=3D"m_5949702530543711213m_4191731141621744608m_-2379611=
272366386122m_-3928334406880738982:3qh.145">linux</span>-x86-64.so.2<br>#17=
 0x00007ffff6eafa49 in __run_exit_handlers ()<br>&nbsp;&nbsp; from /lib64/<=
span id=3D"m_5949702530543711213m_4191731141621744608m_-2379611272366386122=
m_-3928334406880738982:3qh.146">libc</span>.so.6<br>#18 0x00007ffff6eafa95 =
in exit () from /lib64/<span id=3D"m_5949702530543711213m_41917311416217446=
08m_-2379611272366386122m_-3928334406880738982:3qh.147">libc</span>.so.6<br=
>#19 0x0000000000401b51 in main (<span id=3D"m_5949702530543711213m_4191731=
141621744608m_-2379611272366386122m_-3928334406880738982:3qh.148">argc</spa=
n>=3D&lt;optimized out&gt;, <br><span id=3D"m_5949702530543711213m_41917311=
41621744608m_-2379611272366386122m_-3928334406880738982:3qh.149">argv</span=
>=3D&lt;optimized out&gt;) at <span id=3D"m_5949702530543711213m_4191731141=
621744608m_-2379611272366386122m_-3928334406880738982:3qh.150">lu</span>.c:=
368<br><br></div>Any ideas, why this happens and how to fix it?<br><br></di=
v>Thanks,<br></div><span id=3D"m_5949702530543711213m_4191731141621744608m_=
-2379611272366386122m_-3928334406880738982:3qh.151">Shehab</span><br><div><=
div><div><div><br><br></div></div></div></div></div><br></div></div>_______=
________________________________________<br>lttng-dev mailing list<br><a hr=
ef=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.l=
ttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo=
/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/listi=
nfo/lttng-dev</a><span class=3D"m_5949702530543711213m_4191731141621744608m=
_-2379611272366386122HOEnZb"><span style=3D"color:#888888"><br></span></spa=
n></blockquote></div><span class=3D"m_5949702530543711213m_4191731141621744=
608m_-2379611272366386122HOEnZb"><span style=3D"color:#888888"><br><div>-- =
<br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.=
efficios.com" target=3D"_blank">http://www.efficios.com</a><br></div></span=
></span></div></div></blockquote></div></div><br></blockquote></div></div><=
/div><div><div class=3D"m_5949702530543711213m_4191731141621744608h5"><br><=
div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http=
://www.efficios.com" target=3D"_blank">http://www.efficios.com</a><br></div=
></div></div></div></div></blockquote></div></div><br></blockquote></div><b=
r><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"h=
ttp://www.efficios.com" target=3D"_blank">http://www.efficios.com</a><br></=
div></div><br></blockquote></div></div></div><div><div class=3D"m_594970253=
0543711213h5"><br><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.=
<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effici=
os.com</a><br></div></div></div></div></div></blockquote></div></div><br></=
blockquote></div></div></div><div><div class=3D"h5"><br><div>-- <br></div><=
div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.co=
m" target=3D"_blank">http://www.efficios.com</a><br></div></div></div></div=
></div></blockquote></div></div><br></blockquote></div><br><div>-- <br></di=
v><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div><=
/div><br></blockquote></div><br><div>-- <br></div><div>Mathieu Desnoyers<br=
>EfficiOS Inc.<br>http://www.efficios.com</div></div><br></blockquote></div=
><br><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://ww=
w.efficios.com</div></div><br></blockquote></div><div><br></div><div data-m=
arker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.=
<br>http://www.efficios.com</div></div></body></html>
--=_421cce1e-7b82-4ae2-ba5c-12e34a0f1321--

------=_Part_556_408660655.1521653237585
Content-Type: text/x-patch;
 name=0001-Fix-perf-event-mutex-with-pthread-wrapper.patch
Content-Disposition: attachment;
 filename=0001-Fix-perf-event-mutex-with-pthread-wrapper.patch
Content-Transfer-Encoding: base64

RnJvbSA4NjcxYzZhZTgzOTYxNWMwNzc5MDQxYWJhZGE0NzAzNjgwZmJjMDAzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNA
ZWZmaWNpb3MuY29tPgpEYXRlOiBUdWUsIDIwIE1hciAyMDE4IDE3OjMyOjM2IC0wNDAwClN1Ympl
Y3Q6IFtSRkMgUEFUQ0ggdjJdIEZpeDogcGVyZiBldmVudCBtdXRleCB3aXRoIHB0aHJlYWQgd3Jh
cHBlcgoKV2UgZG8gbm90IHdhbnQgdG8gcmVjdXJzZSBpbiB0aGUgcHRocmVhZCBtdXRleCBpbnN0
cnVtZW50YXRpb24gd2hlbgpzZXR0aW5nIHVwIHRoZSBwZXJmIGNvdW50ZXJzIGZvciBhIGdpdmVu
IHRocmVhZC4KCkludHJvZHVjZSBhICJub3RyYWNlIiBwZXItdGhyZWFkIGNvdW50ZXIgdG8gaW5o
aWJpdCB0cmFjaW5nIGZvciB0aGUKY3VycmVudCB0aHJlYWQuCgpTaWduZWQtb2ZmLWJ5OiBNYXRo
aWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgotLS0KIGluY2x1
ZGUvbHR0bmcvdXN0LWV2ZW50cy5oICAgICAgICAgICAgICAgICB8ICA2ICsrKysrKwogaW5jbHVk
ZS9sdHRuZy91c3QtdHJhY2Vwb2ludC1ldmVudC5oICAgICAgIHwgIDcgKystLS0tLQogbGlibHR0
bmctdXN0L2x0dG5nLWNvbnRleHQtcGVyZi1jb3VudGVycy5jIHwgIDIgKysKIGxpYmx0dG5nLXVz
dC9sdHRuZy1ldmVudHMuYyAgICAgICAgICAgICAgICB8IDE0ICsrKysrKysrKysrKysrCiBsaWJs
dHRuZy11c3QvbHR0bmctdHJhY2VyLWNvcmUuaCAgICAgICAgICAgfCAgMyArKysKIGxpYmx0dG5n
LXVzdC9sdHRuZy11c3QtY29tbS5jICAgICAgICAgICAgICB8IDIzICsrKysrKysrKysrKysrKysr
KysrKysrCiA2IGZpbGVzIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9sdHRuZy91c3QtZXZlbnRzLmggYi9pbmNsdWRlL2x0dG5n
L3VzdC1ldmVudHMuaAppbmRleCA4NjczMzUwMy4uZjhjMTMwZjkgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvbHR0bmcvdXN0LWV2ZW50cy5oCisrKyBiL2luY2x1ZGUvbHR0bmcvdXN0LWV2ZW50cy5oCkBA
IC03MzgsNiArNzM4LDEyIEBAIHN0cnVjdCBsdHRuZ19lbnVtICpsdHRuZ191c3RfZW51bV9nZXRf
ZnJvbV9kZXNjKHN0cnVjdCBsdHRuZ19zZXNzaW9uICpzZXNzaW9uLAogdm9pZCBsdHRuZ191c3Rf
ZGxfdXBkYXRlKHZvaWQgKmlwKTsKIHZvaWQgbHR0bmdfdXN0X2ZpeHVwX2ZkX3RyYWNrZXJfdGxz
KHZvaWQpOwogCit2b2lkIGx0dG5nX3VzdF9iZWdpbl9ub3RyYWNlKHZvaWQpOwordm9pZCBsdHRu
Z191c3RfZW5kX25vdHJhY2Uodm9pZCk7CisKK2ludCBsdHRuZ191c3RfZG9fdHJhY2Uoc3RydWN0
IGx0dG5nX3Nlc3Npb24gKnNlc3Npb24sCisJCXN0cnVjdCBsdHRuZ19jaGFubmVsICpjaGFuLCBz
dHJ1Y3QgbHR0bmdfZXZlbnQgKmV2ZW50KTsKKwogLyogRm9yIGJhY2t3YXJkIGNvbXBhdGliaWxp
dHkuIExlYXZlIHRob3NlIGV4cG9ydGVkIHN5bWJvbHMgaW4gcGxhY2UuICovCiBleHRlcm4gc3Ry
dWN0IGx0dG5nX2N0eCAqbHR0bmdfc3RhdGljX2N0eDsKIHZvaWQgbHR0bmdfY29udGV4dF9pbml0
KHZvaWQpOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9sdHRuZy91c3QtdHJhY2Vwb2ludC1ldmVudC5o
IGIvaW5jbHVkZS9sdHRuZy91c3QtdHJhY2Vwb2ludC1ldmVudC5oCmluZGV4IGVjMjkyZDI0Li4w
YmMwMDJmNyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9sdHRuZy91c3QtdHJhY2Vwb2ludC1ldmVudC5o
CisrKyBiL2luY2x1ZGUvbHR0bmcvdXN0LXRyYWNlcG9pbnQtZXZlbnQuaApAQCAtNzY2LDExICs3
NjYsOCBAQCB2b2lkIF9fZXZlbnRfcHJvYmVfXyMjX3Byb3ZpZGVyIyNfX18jI19uYW1lKF9UUF9B
UkdTX0RBVEFfUFJPVE8oX2FyZ3MpKQkgICAgICBcCiAJCSh2b2lkKSBfX2R5bmFtaWNfbGVuX2lk
eDsJLyogZG9uJ3Qgd2FybiBpZiB1bnVzZWQgKi8gICAgXAogCWlmICghX1RQX1NFU1NJT05fQ0hF
Q0soc2Vzc2lvbiwgX19jaGFuLT5zZXNzaW9uKSkJCSAgICAgIFwKIAkJcmV0dXJuOwkJCQkJCQkg
ICAgICBcCi0JaWYgKGNhYV91bmxpa2VseSghQ01NX0FDQ0VTU19PTkNFKF9fY2hhbi0+c2Vzc2lv
bi0+YWN0aXZlKSkpCSAgICAgIFwKLQkJcmV0dXJuOwkJCQkJCQkgICAgICBcCi0JaWYgKGNhYV91
bmxpa2VseSghQ01NX0FDQ0VTU19PTkNFKF9fY2hhbi0+ZW5hYmxlZCkpKQkJICAgICAgXAotCQly
ZXR1cm47CQkJCQkJCSAgICAgIFwKLQlpZiAoY2FhX3VubGlrZWx5KCFDTU1fQUNDRVNTX09OQ0Uo
X19ldmVudC0+ZW5hYmxlZCkpKQkJICAgICAgXAorCWlmIChjYWFfdW5saWtlbHkoIWx0dG5nX3Vz
dF9kb190cmFjZShfX2NoYW4tPnNlc3Npb24sIF9fY2hhbiwJICAgICAgXAorCQkJCQkgICAgIF9f
ZXZlbnQpKSkJCQkgICAgICBcCiAJCXJldHVybjsJCQkJCQkJICAgICAgXAogCWlmIChjYWFfdW5s
aWtlbHkoIVRQX1JDVV9MSU5LX1RFU1QoKSkpCQkJCSAgICAgIFwKIAkJcmV0dXJuOwkJCQkJCQkg
ICAgICBcCmRpZmYgLS1naXQgYS9saWJsdHRuZy11c3QvbHR0bmctY29udGV4dC1wZXJmLWNvdW50
ZXJzLmMgYi9saWJsdHRuZy11c3QvbHR0bmctY29udGV4dC1wZXJmLWNvdW50ZXJzLmMKaW5kZXgg
YTE1NDE3Y2MuLjEzMWFhYTU0IDEwMDY0NAotLS0gYS9saWJsdHRuZy11c3QvbHR0bmctY29udGV4
dC1wZXJmLWNvdW50ZXJzLmMKKysrIGIvbGlibHR0bmctdXN0L2x0dG5nLWNvbnRleHQtcGVyZi1j
b3VudGVycy5jCkBAIC0yOTEsNiArMjkxLDcgQEAgc3RydWN0IGx0dG5nX3BlcmZfY291bnRlcl90
aHJlYWRfZmllbGQgKgogCXJldCA9IHB0aHJlYWRfc2lnbWFzayhTSUdfQkxPQ0ssICZuZXdtYXNr
LCAmb2xkbWFzayk7CiAJaWYgKHJldCkKIAkJYWJvcnQoKTsKKwlsdHRuZ191c3RfYmVnaW5fbm90
cmFjZSgpOwogCS8qIENoZWNrIGFnYWluIHdpdGggc2lnbmFscyBkaXNhYmxlZCAqLwogCWNkc19s
aXN0X2Zvcl9lYWNoX2VudHJ5X3JjdSh0aHJlYWRfZmllbGQsICZwZXJmX3RocmVhZC0+cmN1X2Zp
ZWxkX2xpc3QsCiAJCQlyY3VfZmllbGRfbm9kZSkgewpAQCAtMzE1LDYgKzMxNiw3IEBAIHN0cnVj
dCBsdHRuZ19wZXJmX2NvdW50ZXJfdGhyZWFkX2ZpZWxkICoKIAkJCSZwZXJmX2ZpZWxkLT50aHJl
YWRfZmllbGRfbGlzdCk7CiAJdXN0X3VubG9jaygpOwogc2tpcDoKKwlsdHRuZ191c3RfZW5kX25v
dHJhY2UoKTsKIAlyZXQgPSBwdGhyZWFkX3NpZ21hc2soU0lHX1NFVE1BU0ssICZvbGRtYXNrLCBO
VUxMKTsKIAlpZiAocmV0KQogCQlhYm9ydCgpOwpkaWZmIC0tZ2l0IGEvbGlibHR0bmctdXN0L2x0
dG5nLWV2ZW50cy5jIGIvbGlibHR0bmctdXN0L2x0dG5nLWV2ZW50cy5jCmluZGV4IDI1NWM0Yjk1
Li5kOGU0ZmQ3OSAxMDA2NDQKLS0tIGEvbGlibHR0bmctdXN0L2x0dG5nLWV2ZW50cy5jCisrKyBi
L2xpYmx0dG5nLXVzdC9sdHRuZy1ldmVudHMuYwpAQCAtMTI4NCwzICsxMjg0LDE3IEBAIHZvaWQg
bHR0bmdfdXN0X2NvbnRleHRfc2V0X3Nlc3Npb25fcHJvdmlkZXIoY29uc3QgY2hhciAqbmFtZSwK
IAkJfQogCX0KIH0KKworaW50IGx0dG5nX3VzdF9kb190cmFjZShzdHJ1Y3QgbHR0bmdfc2Vzc2lv
biAqc2Vzc2lvbiwKKwkJc3RydWN0IGx0dG5nX2NoYW5uZWwgKmNoYW4sIHN0cnVjdCBsdHRuZ19l
dmVudCAqZXZlbnQpCit7CisJaWYgKGNhYV91bmxpa2VseSghQ01NX0FDQ0VTU19PTkNFKHNlc3Np
b24tPmFjdGl2ZSkpKQorCQlyZXR1cm4gMDsKKwlpZiAoY2FhX3VubGlrZWx5KCFDTU1fQUNDRVNT
X09OQ0UoY2hhbi0+ZW5hYmxlZCkpKQorCQlyZXR1cm4gMDsKKwlpZiAoY2FhX3VubGlrZWx5KCFD
TU1fQUNDRVNTX09OQ0UoZXZlbnQtPmVuYWJsZWQpKSkKKwkJcmV0dXJuIDA7CisJaWYgKGNhYV91
bmxpa2VseShVUkNVX1RMUyhsdHRuZ191c3Rfbm90cmFjZV90aHJlYWQpKSA+IDApCisJCXJldHVy
biAwOworCXJldHVybiAxOworfQpkaWZmIC0tZ2l0IGEvbGlibHR0bmctdXN0L2x0dG5nLXRyYWNl
ci1jb3JlLmggYi9saWJsdHRuZy11c3QvbHR0bmctdHJhY2VyLWNvcmUuaAppbmRleCBiYTIzMmYz
Mi4uOThkNzliZTggMTAwNjQ0Ci0tLSBhL2xpYmx0dG5nLXVzdC9sdHRuZy10cmFjZXItY29yZS5o
CisrKyBiL2xpYmx0dG5nLXVzdC9sdHRuZy10cmFjZXItY29yZS5oCkBAIC0yNSw2ICsyNSw3IEBA
CiAjaW5jbHVkZSA8c3RkZGVmLmg+CiAjaW5jbHVkZSA8dXJjdS9hcmNoLmg+CiAjaW5jbHVkZSA8
dXJjdS9saXN0Lmg+CisjaW5jbHVkZSA8dXJjdS90bHMtY29tcGF0Lmg+CiAjaW5jbHVkZSA8bHR0
bmcvdXN0LXRyYWNlci5oPgogI2luY2x1ZGUgPGx0dG5nL2J1Zy5oPgogI2luY2x1ZGUgPGx0dG5n
L3JpbmdidWZmZXItY29uZmlnLmg+CkBAIC0zNyw2ICszOCw4IEBAIHN0cnVjdCBsdHRuZ19jdHhf
ZmllbGQ7CiBzdHJ1Y3QgbHR0bmdfdXN0X2xpYl9yaW5nX2J1ZmZlcl9jdHg7CiBzdHJ1Y3QgbHR0
bmdfY3R4X3ZhbHVlOwogCitleHRlcm4gREVDTEFSRV9VUkNVX1RMUyhpbnQsIGx0dG5nX3VzdF9u
b3RyYWNlX3RocmVhZCk7CisKIGludCB1c3RfbG9jayh2b2lkKSBfX2F0dHJpYnV0ZV9fICgod2Fy
bl91bnVzZWRfcmVzdWx0KSk7CiB2b2lkIHVzdF9sb2NrX25vY2hlY2sodm9pZCk7CiB2b2lkIHVz
dF91bmxvY2sodm9pZCk7CmRpZmYgLS1naXQgYS9saWJsdHRuZy11c3QvbHR0bmctdXN0LWNvbW0u
YyBiL2xpYmx0dG5nLXVzdC9sdHRuZy11c3QtY29tbS5jCmluZGV4IGQ0YWRkMWMwLi45NTIwZjI0
NiAxMDA2NDQKLS0tIGEvbGlibHR0bmctdXN0L2x0dG5nLXVzdC1jb21tLmMKKysrIGIvbGlibHR0
bmctdXN0L2x0dG5nLXVzdC1jb21tLmMKQEAgLTkyLDYgKzkyLDkgQEAgc3RhdGljIHB0aHJlYWRf
bXV0ZXhfdCB1c3RfbXV0ZXggPSBQVEhSRUFEX01VVEVYX0lOSVRJQUxJWkVSOwogLyogQWxsb3cg
bmVzdGluZyB0aGUgdXN0X211dGV4IHdpdGhpbiB0aGUgc2FtZSB0aHJlYWQuICovCiBzdGF0aWMg
REVGSU5FX1VSQ1VfVExTKGludCwgdXN0X211dGV4X25lc3QpOwogCisvKiBEbyBub3QgdHJhY2Ug
ZXZlbnRzIGZvciB0aGUgY3VycmVudCB0aHJlYWQuICovCitERUZJTkVfVVJDVV9UTFMoaW50LCBs
dHRuZ191c3Rfbm90cmFjZV90aHJlYWQpIF9fYXR0cmlidXRlX18oKHZpc2liaWxpdHkoImhpZGRl
biIpKSk7CisKIC8qCiAgKiB1c3RfZXhpdF9tdXRleCBwcm90ZWN0cyB0aHJlYWRfYWN0aXZlIHZh
cmlhYmxlIHdydCB0aHJlYWQgZXhpdC4gSXQKICAqIGNhbm5vdCBiZSBkb25lIGJ5IHVzdF9tdXRl
eCBiZWNhdXNlIHB0aHJlYWRfY2FuY2VsKCksIHdoaWNoIHRha2VzIGFuCkBAIC0xMjEsNiArMTI0
LDE5IEBAIHN0YXRpYyBpbnQgbHR0bmdfdXN0X2NvbW1fc2hvdWxkX3F1aXQ7CiBpbnQgbHR0bmdf
dXN0X2xvYWRlZCBfX2F0dHJpYnV0ZV9fKCh3ZWFrKSk7CiAKIC8qCisgKiBJbmhpYml0IGx0dG5n
LXVzdCB0cmFjaW5nIGZvciB0aGlzIHRocmVhZC4KKyAqLwordm9pZCBsdHRuZ191c3RfYmVnaW5f
bm90cmFjZSh2b2lkKQoreworCVVSQ1VfVExTKGx0dG5nX3VzdF9ub3RyYWNlX3RocmVhZCkrKzsK
K30KKwordm9pZCBsdHRuZ191c3RfZW5kX25vdHJhY2Uodm9pZCkKK3sKKwktLVVSQ1VfVExTKGx0
dG5nX3VzdF9ub3RyYWNlX3RocmVhZCk7Cit9CisKKy8qCiAgKiBSZXR1cm4gMCBvbiBzdWNjZXNz
LCAtMSBpZiBzaG91bGQgcXVpdC4KICAqIFRoZSBsb2NrIGlzIHRha2VuIGluIGJvdGggY2FzZXMu
CiAgKiBTaWduYWwtc2FmZS4KQEAgLTM5Miw2ICs0MDgsMTIgQEAgdm9pZCBsdHRuZ19maXh1cF91
c3RfbXV0ZXhfbmVzdF90bHModm9pZCkKIAlhc20gdm9sYXRpbGUgKCIiIDogOiAibSIgKFVSQ1Vf
VExTKHVzdF9tdXRleF9uZXN0KSkpOwogfQogCitzdGF0aWMKK3ZvaWQgbHR0bmdfZml4dXBfbHR0
bmdfdXN0X25vdHJhY2VfdGxzKHZvaWQpCit7CisJYXNtIHZvbGF0aWxlICgiIiA6IDogIm0iIChV
UkNVX1RMUyhsdHRuZ191c3Rfbm90cmFjZV90aHJlYWQpKSk7Cit9CisKIC8qCiAgKiBGaXh1cCB1
cmN1IGJwIFRMUy4KICAqLwpAQCAtNDEwLDYgKzQzMiw3IEBAIHZvaWQgbHR0bmdfdXN0X2ZpeHVw
X3Rscyh2b2lkKQogCWx0dG5nX2ZpeHVwX25lc3RfY291bnRfdGxzKCk7CiAJbHR0bmdfZml4dXBf
cHJvY25hbWVfdGxzKCk7CiAJbHR0bmdfZml4dXBfdXN0X211dGV4X25lc3RfdGxzKCk7CisJbHR0
bmdfZml4dXBfbHR0bmdfdXN0X25vdHJhY2VfdGxzKCk7CiAJbHR0bmdfdXN0X2ZpeHVwX2ZkX3Ry
YWNrZXJfdGxzKCk7CiB9CiAKLS0gCjIuMTEuMAoK
------=_Part_556_408660655.1521653237585
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

------=_Part_556_408660655.1521653237585--
