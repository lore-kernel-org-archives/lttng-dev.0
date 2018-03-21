From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Double free or corruption error (fasttop)
Date: Wed, 21 Mar 2018 16:22:58 -0400 (EDT)
Message-ID: <296564653.817.1521663778651.JavaMail.zimbra__17739.6672116176$1521664140$gmane$org@efficios.com>
References: <CAC-H6ttMF-CjzDH7a6bmeoOPP8JRLptYTmGJVvrx5t-G0Se_gA@mail.gmail.com>
 <1883907448.467.1521489713355.JavaMail.zimbra@efficios.com>
 <CAC-H6ttwT-tJVFE8iycjzUod2jyxHrfT1TYFhHZzyar98f6jtA@mail.gmail.com>
 <568213680.975.1521562064453.JavaMail.zimbra@efficios.com>
 <446537616.1725.1521579509437.JavaMail.zimbra@efficios.com>
 <1870456531.1798.1521582159880.JavaMail.zimbra@efficios.com>
 <268788496.560.1521653237589.JavaMail.zimbra@efficios.com>
 <CAC-H6tt-8XVLAfXPY+fwnCjetrD9HURZ3H_CVSJns0Te5AccLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_Part_813_130294797.1521663778649"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 4061f55wd3zxs4
 for <lttng-dev@lists.lttng.org>; Wed, 21 Mar 2018 16:30:53 -0400 (EDT)
In-Reply-To: <CAC-H6tt-8XVLAfXPY+fwnCjetrD9HURZ3H_CVSJns0Te5AccLw@mail.gmail.com>
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

------=_Part_813_130294797.1521663778649
Content-Type: multipart/alternative;
	boundary="=_1bfd76f7-8a40-463d-98f7-ac100f57012f"

--=_1bfd76f7-8a40-463d-98f7-ac100f57012f
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Mar 21, 2018, at 1:55 PM, Shehab Elsayed <shehabyomn@gmail.com> wrote: 

> I am so sorry for the late replies.

> I have tried the first patch you sent and the problem still happens (although
> seemingly less frequently especially with debugging enabled!!!!). I have
> attached the output I got from one of the erroneous runs.

> I will try the updated patch and let you know how it goes.

> Also, I am not sure if these points make any difference:
> 1- The error actually happens at the end of the application. It actually
> finishes execution, but then something goes wrong.
> 2- I run into this problem only for some of the benchmarks (or at least the
> problems happens much less frequently for others that I didn't run into it, not
> yet)

> Thanks you very much, and sorry again for the late replies.

No worries! Looking through your log, I notice that pthread set cancel state has problems when 
called from application threads. We do not restore the original thread's cancel state. Can you try 
with the attached patch applied on top of the previous one ? 

Thanks, 

Mathieu 

> Shehab Y. Elsayed, MSc.
> PhD Student
> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
> University of Toronto
> E-mail: [ https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11# |
> shehabyomn@gmail.com ]

> On Wed, Mar 21, 2018 at 1:27 PM, Mathieu Desnoyers < [
> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
> wrote:

>> ----- On Mar 20, 2018, at 5:42 PM, Mathieu Desnoyers < [
>> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
>> wrote:

>>> ----- On Mar 20, 2018, at 4:58 PM, Mathieu Desnoyers < [
>>> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
>>> wrote:

>>>> ----- On Mar 20, 2018, at 12:07 PM, Mathieu Desnoyers < [
>>>> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
>>>> wrote:

>>>>> ----- On Mar 19, 2018, at 4:21 PM, Shehab Elsayed < [
>>>>> mailto:shehabyomn@gmail.com | shehabyomn@gmail.com ] > wrote:

>>>>>> I did "echo "-1" > /proc/sys/kernel/perf_event_paranoid " and made sure the
>>>>>> value was actually written by "cat /proc/sys/kernel/perf_event_paranoid"

>>>>>> It executed normally 2 times but then got the same error.

>>>>> Can you provide the output when reproducing the issue with the
>>>>> LTTNG_UST_DEBUG=1 environment variable set when starting
>>>>> your test program ?

>>>> I just noticed something that might explain what goes wrong here:

>>>> lttng-context-perf-counters.c: add_thread_field() grabs the ust_lock(). Pthread
>>>> mutex
>>>> in your case is instrumented with the pthread wrapper. This "add_thread_field"
>>>> is invoked
>>>> the first time the perf counter is hit by each given thread. When this happens,
>>>> the
>>>> instrumented pthread mutex will try to call into the instrumentation tracepoint
>>>> again,
>>>> which will call add_thread_field() (again), and so on until we reach the
>>>> libringbuffer
>>>> "lib_ring_buffer_nesting" threshold of 4 calls deep.

>>>> I suspect this situation where we recursively call add_thread_field is
>>>> unexpected,
>>>> which may trigger your double-free here.

>>>> Will investigate more.

>>> Can you try with the attached patch applied ?

>> Here is an updated v2 of the patch which tests the notrace tls counter sooner
>> (before evaluating
>> filter). Please let me know how it goes.

>> Thanks,

>> Mathieu

>>> Thanks,

>>> Mathieu

>>>> Thanks,

>>>> Mathieu

>>>>> Thanks,

>>>>> Mathieu

>>>>>> Shehab Y. Elsayed, MSc.
>>>>>> PhD Student
>>>>>> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
>>>>>> University of Toronto
>>>>>> E-mail: [ https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11# |
>>>>>> shehabyomn@gmail.com ]

>>>>>> On Mon, Mar 19, 2018 at 4:01 PM, Mathieu Desnoyers < [
>>>>>> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
>>>>>> wrote:

>>>>>>> ----- On Mar 19, 2018, at 3:53 PM, Shehab Elsayed < [
>>>>>>> mailto:shehabyomn@gmail.com | shehabyomn@gmail.com ] > wrote:

>>>>>>>> cat /proc/sys/kernel/perf_event_paranoid ---> returns 1

>>>>>>>> I run the program as a normal user

>>>>>>>> The glibc version I get by running "ldd --version" is 2.17

>>>>>>> Can you reproduce the issue after you do this as root ?

>>>>>>> echo "-1" > /proc/sys/kernel/perf_event_paranoid

>>>>>>> Based on this documentation of the Linux kernel:

>>>>>>> Documentation/sysctl/kernel.txt:

>>>>>>> perf_event_paranoid:

>>>>>>> Controls use of the performance events system by unprivileged
>>>>>>> users (without CAP_SYS_ADMIN). The default value is 2.

>>>>>>> -1: Allow use of (almost) all events by all users
>>>>>>> Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
>>>>>>> >=0: Disallow ftrace function tracepoint by users without CAP_SYS_ADMIN
>>>>>>> Disallow raw tracepoint access by users without CAP_SYS_ADMIN
>>>>>>> >=1: Disallow CPU event access by users without CAP_SYS_ADMIN
>>>>>>> >=2: Disallow kernel profiling by users without CAP_SYS_ADMIN

>>>>>>> Thanks,

>>>>>>> Mathieu

>>>>>>>> Shehab Y. Elsayed, MSc.
>>>>>>>> PhD Student
>>>>>>>> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
>>>>>>>> University of Toronto
>>>>>>>> E-mail: [ https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11# |
>>>>>>>> shehabyomn@gmail.com ]

>>>>>>>> On Mon, Mar 19, 2018 at 3:31 PM, Mathieu Desnoyers < [
>>>>>>>> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
>>>>>>>> wrote:

>>>>>>>>> ---- On Mar 19, 2018, at 3:26 PM, Mathieu Desnoyers < [
>>>>>>>>> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
>>>>>>>>> wrote:

>>>>>>>>>> ----- On Mar 19, 2018, at 2:26 PM, Shehab Elsayed < [
>>>>>>>>>> mailto:shehabyomn@gmail.com | shehabyomn@gmail.com ] > wrote:

>>>>>>>>>>> Yes, I tried with only one of those contexts and I still ran into the same
>>>>>>>>>>> problem.

>>>>>>>>>> What is the setting returned by

>>>>>>>>>> cat /proc/sys/kernel/perf_event_paranoid

>>>>>>>>>> on your system ? And do you run your test program as root or normal user ?

>>>>>>>>>> Please CC the mailing list on your reply.

>>>>>>>>> I will also need to know what glibc version you have on your system.

>>>>>>>>> Thanks,

>>>>>>>>> Mathieu

>>>>>>>>>> Thanks,

>>>>>>>>>> Mathieu

>>>>>>>>>>> Shehab Y. Elsayed, MSc.
>>>>>>>>>>> PhD Student
>>>>>>>>>>> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
>>>>>>>>>>> University of Toronto
>>>>>>>>>>> E-mail: [ https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11# |
>>>>>>>>>>> shehabyomn@gmail.com ]

>>>>>>>>>>> On Mon, Mar 19, 2018 at 2:24 PM, Mathieu Desnoyers < [
>>>>>>>>>>> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
>>>>>>>>>>> wrote:

>>>>>>>>>>>> ----- On Mar 19, 2018, at 12:36 PM, Shehab Elsayed < [
>>>>>>>>>>>> mailto:shehabyomn@gmail.com | shehabyomn@gmail.com ] > wrote:

>>>>>>>>>>>>> Hi Mathieu,

>>>>>>>>>>>>> Thank you very much for your reply.

>>>>>>>>>>>>> I manually built lttng-ust from source (commit #:
>>>>>>>>>>>>> 8a208943e21700211beee3ea64180a5a534c7d2a).

>>>>>>>>>>>>> This is how I set up the tracing session:
>>>>>>>>>>>>> 1- lttng create lu_ncb_8_native -o {path}
>>>>>>>>>>>>> 2- lttng enable-event --userspace lttng_ust_pthread:pthread_mutex_lock_req
>>>>>>>>>>>>> lttng enable-event --userspace lttng_ust_pthread:pthread_mutex_lock_acq
>>>>>>>>>>>>> lttng enable-event --userspace lttng_ust_pthread:pthread_mutex_lock_trylock
>>>>>>>>>>>>> lttng enable-event --userspace lttng_ust_pthread:pthread_mutex_lock_unlock
>>>>>>>>>>>>> 3- lttng add-context -u -t procname
>>>>>>>>>>>>> lttng add-context -u -t vpid
>>>>>>>>>>>>> lttng add-context -u -t pthread_id
>>>>>>>>>>>>> lttng add-context -u -t vtid
>>>>>>>>>>>>> lttng add-context -u -t ip
>>>>>>>>>>>>> lttng add-context -u -t perf:thread:cpu-cycles
>>>>>>>>>>>>> lttng add-context -u -t perf:thread:cycles
>>>>>>>>>>>>> lttng add-context -u -t perf:thread:instructions
>>>>>>>>>>>>> 4- lttng start
>>>>>>>>>>>>> 5- LD_PRELOAD=/usr/local/lib/liblttng-ust-pthread-wrapper.so ./lu_ncb -p8 -n8096
>>>>>>>>>>>>> -b32
>>>>>>>>>>>>> 6- lttng stop
>>>>>>>>>>>>> 7- lttng destroy

>>>>>>>>>>>> Can you reproduce if you remove the following contexts ?

>>>>>>>>>>>> lttng add-context -u -t perf:thread:cpu-cycles
>>>>>>>>>>>> lttng add-context -u -t perf:thread:cycles
>>>>>>>>>>>> lttng add-context -u -t perf:thread:instructions

>>>>>>>>>>>> And if you only keep a single of those contexts ?

>>>>>>>>>>>> Thanks,

>>>>>>>>>>>> Mathieu

>>>>>>>>>>>>> Shehab Y. Elsayed, MSc.
>>>>>>>>>>>>> PhD Student
>>>>>>>>>>>>> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
>>>>>>>>>>>>> University of Toronto
>>>>>>>>>>>>> E-mail: [ https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11# |
>>>>>>>>>>>>> shehabyomn@gmail.com ]

>>>>>>>>>>>>> On Mon, Mar 19, 2018 at 12:21 PM, Mathieu Desnoyers < [
>>>>>>>>>>>>> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
>>>>>>>>>>>>> wrote:

>>>>>>>>>>>>>> ----- On Mar 16, 2018, at 5:37 PM, Shehab Elsayed < [
>>>>>>>>>>>>>> mailto:shehabyomn@gmail.com | shehabyomn@gmail.com ] > wrote:

>>>>>>>>>>>>>>> Hello All,

>>>>>>>>>>>>>>> I am trying to instrument a pthread application using the provided pthread
>>>>>>>>>>>>>>> wrapper, but I sometimes run into a "Double free or corruption error ( fasttop
>>>>>>>>>>>>>>> )" error.

>>>>>>>>>>>>>> Please provide more information about the version of lttng-ust you are using,
>>>>>>>>>>>>>> and how you setup
>>>>>>>>>>>>>> your tracing session.

>>>>>>>>>>>>>> Thanks,

>>>>>>>>>>>>>> Mathieu

>>>>>>>>>>>>>>> Here is a description of what I have tried and noticed:
>>>>>>>>>>>>>>> 1- The problem isn't consistent. It sometimes happen and sometimes works as
>>>>>>>>>>>>>>> expected.
>>>>>>>>>>>>>>> 2- From my experiments, the problem happens (more frequently at least) when
>>>>>>>>>>>>>>> adding performance counter contexts (I tried cycles, cpu _cycles and
>>>>>>>>>>>>>>> instructions).
>>>>>>>>>>>>>>> 3- I am testing using lu _ ncb from splash3 benchmark suite after setting LD _
>>>>>>>>>>>>>>> PRELOAD to use the pthread wrapper as described in the LTTng documents.
>>>>>>>>>>>>>>> 4- Here is the backtrace printed after exiting:
>>>>>>>>>>>>>>> ======= Backtrace : =========
>>>>>>>>>>>>>>> /lib64/ libc .so.6([Thread 0x7ffff5611700 ( LWP 97229) exited]
>>>>>>>>>>>>>>> / usr /local/lib/ liblttng - ust .so.0( lttng
>>>>>>>>>>>>>>> _destroy_context+0x35)[0x7ffff7471575]
>>>>>>>>>>>>>>> / usr /local/lib/ liblttng - ust .so.0( lttng
>>>>>>>>>>>>>>> _session_destroy+0x21c)[0x7ffff747363c]
>>>>>>>>>>>>>>> / usr /local/lib/ liblttng - ust .so.0(+0x1e906)[0x7ffff746d906]
>>>>>>>>>>>>>>> / usr /local/lib/ liblttng - ust .so.0( lttng _ ust _ objd _ unref
>>>>>>>>>>>>>>> +0x9f)[0x7ffff746dccf]
>>>>>>>>>>>>>>> / usr /local/lib/ liblttng - ust .so.0( lttng _ ust _ objd _ unref
>>>>>>>>>>>>>>> +0x9f)[0x7ffff746dccf]
>>>>>>>>>>>>>>> / usr /local/lib/ liblttng - ust .so.0( lttng _ ust _ objd _ unref
>>>>>>>>>>>>>>> +0x9f)[0x7ffff746dccf]
>>>>>>>>>>>>>>> / usr /local/lib/ liblttng - ust .so.0( lttng _ ust _ abi
>>>>>>>>>>>>>>> _exit+0x68)[0x7ffff746ead8]
>>>>>>>>>>>>>>> / usr /local/lib/ liblttng - ust .so.0(+0x191d3)[0x7ffff74681d3]
>>>>>>>>>>>>>>> / usr /local/lib/ liblttng - ust .so.0( lttng _ ust _exit+0x67)[0x7ffff745ed57]
>>>>>>>>>>>>>>> /lib64/ ld - linux -x86-64.so.2(+0xf85a)[0x7ffff7dec85a]
>>>>>>>>>>>>>>> /lib64/ libc .so.6(+0x38a49)[0x7ffff6ca6a49]
>>>>>>>>>>>>>>> /lib64/ libc .so.6(+0x38a95)[0x7ffff6ca6a95]
>>>>>>>>>>>>>>> / aenao -99/elsayed9/ LTTng /data/scripts/ tmp / lu _ ncb [0x401b51]
>>>>>>>>>>>>>>> /lib64/ libc .so.6(__ libc _start_main+0xf5)[0x7ffff6c8fb35]
>>>>>>>>>>>>>>> / aenao -99/elsayed9/ LTTng /data/scripts/ tmp / lu _ ncb [0x401c44]
>>>>>>>>>>>>>>> 5- Also, this is a backtrace I obtained from gdb :
>>>>>>>>>>>>>>> #0 0x00007ffff6eac1d7 in raise () from /lib64/ libc .so.6
>>>>>>>>>>>>>>> #1 0x00007ffff6ead8c8 in abort () from /lib64/ libc .so.6
>>>>>>>>>>>>>>> #2 0x00007ffff6eebf07 in __ libc _message () from /lib64/ libc .so.6
>>>>>>>>>>>>>>> #3 0x00007ffff6ef3503 in _int_free () from /lib64/ libc .so.6
>>>>>>>>>>>>>>> #4 0x00007ffff768ad25 in lttng _destroy_ perf _counter_field (
>>>>>>>>>>>>>>> field=<optimized out>) at lttng -context- perf -counters.c:418
>>>>>>>>>>>>>>> #5 0x00007ffff767a575 in lttng _destroy_context (
>>>>>>>>>>>>>>> ctx =0x7ffff0011090) at lttng -context.c:278
>>>>>>>>>>>>>>> #6 0x00007ffff767c63c in _ lttng _channel_ unmap (
>>>>>>>>>>>>>>> lttng _ chan =0x7ffff0010f40) at lttng -events.c:172
>>>>>>>>>>>>>>> #7 lttng _session_destroy (session=0x7ffff0000900)
>>>>>>>>>>>>>>> at lttng -events.c:247
>>>>>>>>>>>>>>> #8 0x00007ffff7676906 in lttng _release_session (
>>>>>>>>>>>>>>> objd =<optimized out>) at lttng - ust - abi .c:601
>>>>>>>>>>>>>>> #9 0x00007ffff7676ccf in lttng _ ust _ objd _ unref (id=1,
>>>>>>>>>>>>>>> is_owner=<optimized out>) at lttng - ust - abi .c:216
>>>>>>>>>>>>>>> #10 0x00007ffff7676ccf in lttng _ ust _ objd _ unref (id=2,
>>>>>>>>>>>>>>> is_owner=<optimized out>) at lttng - ust - abi .c:216
>>>>>>>>>>>>>>> #11 0x00007ffff7676ccf in lttng _ ust _ objd _ unref (id=id@entry=18,
>>>>>>>>>>>>>>> is_owner=is_owner@entry=1) at lttng - ust - abi .c:216
>>>>>>>>>>>>>>> #12 0x00007ffff7677ad8 in objd _table_destroy ()
>>>>>>>>>>>>>>> at lttng - ust - abi .c:235
>>>>>>>>>>>>>>> #13 lttng _ ust _ abi _exit () at lttng - ust - abi .c:1002
>>>>>>>>>>>>>>> #14 0x00007ffff76711d3 in lttng _ ust _cleanup (exiting=1)
>>>>>>>>>>>>>>> at lttng - ust -comm.c:1807
>>>>>>>>>>>>>>> #15 0x00007ffff7667d57 in lttng _ ust _exit ()
>>>>>>>>>>>>>>> at lttng - ust -comm.c:1874
>>>>>>>>>>>>>>> #16 0x00007ffff7dec85a in _ dl _ fini ()
>>>>>>>>>>>>>>> from /lib64/ ld - linux -x86-64.so.2
>>>>>>>>>>>>>>> #17 0x00007ffff6eafa49 in __run_exit_handlers ()
>>>>>>>>>>>>>>> from /lib64/ libc .so.6
>>>>>>>>>>>>>>> #18 0x00007ffff6eafa95 in exit () from /lib64/ libc .so.6
>>>>>>>>>>>>>>> #19 0x0000000000401b51 in main ( argc =<optimized out>,
>>>>>>>>>>>>>>> argv =<optimized out>) at lu .c:368

>>>>>>>>>>>>>>> Any ideas, why this happens and how to fix it?

>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>> Shehab

>>>>>>>>>>>>>>> _______________________________________________
>>>>>>>>>>>>>>> lttng-dev mailing list
>>>>>>>>>>>>>>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>>>>>>>>>>>>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>>>>>>>>>>>>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]

>>>>>>>>>>>>>> --
>>>>>>>>>>>>>> Mathieu Desnoyers
>>>>>>>>>>>>>> EfficiOS Inc.
>>>>>>>>>>>>>> [ http://www.efficios.com/ | http://www.efficios.com ]

>>>>>>>>>>>> --
>>>>>>>>>>>> Mathieu Desnoyers
>>>>>>>>>>>> EfficiOS Inc.
>>>>>>>>>>>> [ http://www.efficios.com/ | http://www.efficios.com ]

>>>>>>>>>> --
>>>>>>>>>> Mathieu Desnoyers
>>>>>>>>>> EfficiOS Inc.
>>>>>>>>>> [ http://www.efficios.com/ | http://www.efficios.com ]

>>>>>>>>> --
>>>>>>>>> Mathieu Desnoyers
>>>>>>>>> EfficiOS Inc.
>>>>>>>>> [ http://www.efficios.com/ | http://www.efficios.com ]

>>>>>>> --
>>>>>>> Mathieu Desnoyers
>>>>>>> EfficiOS Inc.
>>>>>>> [ http://www.efficios.com/ | http://www.efficios.com ]

>>>>> --
>>>>> Mathieu Desnoyers
>>>>> EfficiOS Inc.
>>>>> [ http://www.efficios.com/ | http://www.efficios.com ]

>>>> --
>>>> Mathieu Desnoyers
>>>> EfficiOS Inc.
>>>> [ http://www.efficios.com/ | http://www.efficios.com ]

>>> --
>>> Mathieu Desnoyers
>>> EfficiOS Inc.
>>> [ http://www.efficios.com/ | http://www.efficios.com ]

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> [ http://www.efficios.com/ | http://www.efficios.com ]

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_1bfd76f7-8a40-463d-98f7-ac100f57012f
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Mar 21, 2018, at 1:55 PM, Shehab Elsayed &lt;shehabyomn@gmail.=
com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockq=
uote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div><=
div><div><div><div><div>I am so sorry for the late replies.<br><br></div>I =
have tried the first patch you sent and the problem still happens (although=
 seemingly less frequently especially with debugging enabled!!!!). I have a=
ttached the output I got from one of the erroneous runs.<br><br></div>I wil=
l try the updated patch and let you know how it goes.<br><br></div>Also, I =
am not sure if these points make any difference:<br></div>1- The error actu=
ally happens at the end of the application. It actually finishes execution,=
 but then something goes wrong.<br></div>2- I run into this problem only fo=
r some of the benchmarks (or at least the problems happens much less freque=
ntly for others that I didn't run into it, not yet)<br><br></div>Thanks you=
 very much, and sorry again for the late replies.</div></blockquote><div><b=
r></div><div>No worries! Looking through your log, I notice that pthread se=
t cancel state has problems when<br data-mce-bogus=3D"1"></div><div>called =
from application threads. We do not restore the original thread's cancel st=
ate. Can you try</div><div>with the attached patch applied on top of the pr=
evious one ?<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></=
div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1=
"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"borde=
r-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-w=
eight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,A=
rial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><br></div><div class=3D"g=
mail_extra"><br clear=3D"all"><div><div class=3D"gmail_signature"><div dir=
=3D"ltr"><span data-mce-style=3D"color: #888888;" style=3D"color: #888888;"=
 color=3D"#888888">Shehab Y. Elsayed, MSc.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </span><span data-mce-style=3D"color: #=
888888;" style=3D"color: #888888;" color=3D"#888888"><br>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></span><br data=
-mce-bogus=3D"1"></div></div></div><br><div class=3D"gmail_quote">On Wed, M=
ar 21, 2018 at 1:27 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"=
mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@=
efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><=
div style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:#0=
00000"><span class=3D""><div><span id=3D"m_-8739052298097068210zwchr">-----=
 On Mar 20, 2018, at 5:42 PM, Mathieu Desnoyers &lt;<a href=3D"mailto:mathi=
eu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com=
</a>&gt; wrote:<br></span></div></span><div><span class=3D""><blockquote st=
yle=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color=
:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family=
:Helvetica,Arial,sans-serif;font-size:12pt"><div style=3D"font-family:arial=
,helvetica,sans-serif;font-size:12pt;color:#000000"><div><span id=3D"m_-873=
9052298097068210zwchr">----- On Mar 20, 2018, at 4:58 PM, Mathieu Desnoyers=
 &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">ma=
thieu.desnoyers@efficios.com</a>&gt; wrote:<br></span></div><div><blockquot=
e style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;c=
olor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fa=
mily:Helvetica,Arial,sans-serif;font-size:12pt"><div style=3D"font-family:a=
rial,helvetica,sans-serif;font-size:12pt;color:#000000"><div><span id=3D"m_=
-8739052298097068210zwchr">----- On Mar 20, 2018, at 12:07 PM, Mathieu Desn=
oyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blan=
k">mathieu.desnoyers@efficios.com</a>&gt; wrote:<br></span></div><div><bloc=
kquote style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:=
5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fo=
nt-family:Helvetica,Arial,sans-serif;font-size:12pt"><div style=3D"font-fam=
ily:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><br><div><span=
 id=3D"m_-8739052298097068210zwchr">----- On Mar 19, 2018, at 4:21 PM, Sheh=
ab Elsayed &lt;<a href=3D"mailto:shehabyomn@gmail.com" target=3D"_blank">sh=
ehabyomn@gmail.com</a>&gt; wrote:<br></span></div><div><blockquote style=3D=
"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div>I did "echo "-1=
" &gt; <span class=3D"m_-8739052298097068210gmail-m_5949702530543711213gmai=
l-im">/proc/sys/kernel/perf_event_paranoid</span>" and made sure the value =
was actually written by "cat /proc/sys/kernel/perf_event_paranoid"<br><br><=
/div><div>It executed normally 2 times but then got the same error.</div></=
div></blockquote><br><div>Can you provide the output when reproducing the i=
ssue with the<br></div><div>LTTNG_UST_DEBUG=3D1 environment variable set wh=
en starting<br></div><div>your test program ?</div></div></div></blockquote=
><div>I just noticed something that might explain what goes wrong here:<br>=
</div><br><div>lttng-context-perf-counters.c: add_thread_field() grabs the =
ust_lock(). Pthread mutex<br></div><div>in your case is instrumented with t=
he pthread wrapper. This "add_thread_field" is invoked<br></div><div>the fi=
rst time the perf counter is hit by each given thread. When this happens, t=
he<br></div><div>instrumented pthread mutex will try to call into the instr=
umentation tracepoint again,<br></div><div>which will call add_thread_field=
() (again), and so on until we reach the libringbuffer<br></div><div>"lib_r=
ing_buffer_nesting" threshold of 4 calls deep.<br></div><br><div>I suspect =
this situation where we recursively call add_thread_field is unexpected,<br=
></div><div>which may trigger your double-free here.<br></div><br><div>Will=
 investigate more.</div></div></div></blockquote><div>Can you try with the =
attached patch applied ?</div></div></div></blockquote></span><div>Here is =
an updated v2 of the patch which tests the notrace tls counter sooner (befo=
re evaluating<br></div><div>filter). Please let me know how it goes.<br></d=
iv><div><div class=3D"h5"><br><div>Thanks,<br></div><br><div>Mathieu<br></d=
iv><br><br><br><blockquote style=3D"border-left:2px solid #1010ff;margin-le=
ft:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;tex=
t-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><d=
iv style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:#00=
0000"><div><br><br><div>Thanks,<br></div><br><div>Mathieu<br></div><br><br>=
<br><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;padd=
ing-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoratio=
n:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div style=3D=
"font-family:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><div>=
<br><br><div>Thanks,<br></div><br><div>Mathieu<br></div><br><br><blockquote=
 style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;co=
lor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fam=
ily:Helvetica,Arial,sans-serif;font-size:12pt"><div style=3D"font-family:ar=
ial,helvetica,sans-serif;font-size:12pt;color:#000000"><div><br><br><div>Th=
anks,<br></div><br><div>Mathieu<br></div><br><br><blockquote style=3D"borde=
r-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-w=
eight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,A=
rial,sans-serif;font-size:12pt"><div dir=3D"ltr"><br></div><div class=3D"gm=
ail_extra"><br clear=3D"all"><div><div class=3D"m_-8739052298097068210gmail=
_signature"><div dir=3D"ltr"><span style=3D"color:#888888">Shehab Y. Elsaye=
d, MSc.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </span><span style=3D"color:#888888"><b=
r>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></span><br></di=
v></div></div><br><div class=3D"gmail_quote">On Mon, Mar 19, 2018 at 4:01 P=
M, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoy=
ers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-fam=
ily:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><span><br><br>=
<span id=3D"m_-8739052298097068210m_5949702530543711213zwchr">----- On Mar =
19, 2018, at 3:53 PM, Shehab Elsayed &lt;<a href=3D"mailto:shehabyomn@gmail=
.com" target=3D"_blank">shehabyomn@gmail.com</a>&gt; wrote:<br></span></spa=
n><div><span><blockquote style=3D"border-left:2px solid #1010ff;margin-left=
:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-=
decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div=
 dir=3D"ltr"><div><div><span class=3D"m_-8739052298097068210m_5949702530543=
711213gmail-im">cat /proc/sys/kernel/perf_event_paranoid</span> ---&gt; ret=
urns 1<br><br></div>I run the program as a normal user<br><br></div>The gli=
bc version I get by running "ldd --version" is 2.17</div></blockquote><br><=
/span><div>Can you reproduce the issue after you do this as root ?<br></div=
><br><div>echo "-1" &gt; <span class=3D"m_-8739052298097068210m_59497025305=
43711213gmail-im">/proc/sys/kernel/perf_event_paranoid</span><br></div><br>=
<div>Based on this documentation of the Linux kernel:<br></div><br><div>Doc=
umentation/sysctl/kernel.txt:<br></div><br><div>perf_event_paranoid:<br><br=
>Controls use of the performance events system by unprivileged<br>users (wi=
thout CAP_SYS_ADMIN).&nbsp; The default value is 2.<br><br>&nbsp;-1: Allow =
use of (almost) all events by all users<br>&nbsp;&nbsp;&nbsp;&nbsp; Ignore =
mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK<br>&gt;=3D0: Dis=
allow ftrace function tracepoint by users without CAP_SYS_ADMIN<br>&nbsp;&n=
bsp;&nbsp;&nbsp; Disallow raw tracepoint access by users without CAP_SYS_AD=
MIN<br>&gt;=3D1: Disallow CPU event access by users without CAP_SYS_ADMIN<b=
r>&gt;=3D2: Disallow kernel profiling by users without CAP_SYS_ADMIN<br><br=
></div><div><div class=3D"m_-8739052298097068210h5"><div>Thanks,<br></div><=
br><div>Mathieu<br></div><br><blockquote style=3D"border-left:2px solid #10=
10ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-st=
yle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font=
-size:12pt"><div dir=3D"ltr"><br></div><div class=3D"gmail_extra"><br clear=
=3D"all"><div><div class=3D"m_-8739052298097068210m_5949702530543711213gmai=
l_signature"><div dir=3D"ltr"><span style=3D"color:#888888">Shehab Y. Elsay=
ed, MSc.<br>
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
an id=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608zw=
chr">---- On Mar 19, 2018, at 3:26 PM, Mathieu Desnoyers &lt;<a href=3D"mai=
lto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@eff=
icios.com</a>&gt; wrote:<br></span></div></span><div><span><blockquote styl=
e=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#=
000;font-weight:normal;font-style:normal;text-decoration:none;font-family:H=
elvetica,Arial,sans-serif;font-size:12pt"><div style=3D"font-family:arial,h=
elvetica,sans-serif;font-size:12pt;color:#000000"><div><span id=3D"m_-87390=
52298097068210m_5949702530543711213m_4191731141621744608zwchr">----- On Mar=
 19, 2018, at 2:26 PM, Shehab Elsayed &lt;<a href=3D"mailto:shehabyomn@gmai=
l.com" target=3D"_blank">shehabyomn@gmail.com</a>&gt; wrote:<br></span></di=
v><div><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;p=
adding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decora=
tion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=
=3D"ltr">Yes, I tried with only one of those contexts and I still ran into =
the same problem.</div></blockquote><div>What is the setting returned by<br=
></div><br><div>cat /proc/sys/kernel/perf_event_paranoid<br></div><br><div>=
on your system ? And do you run your test program as root or normal user ?<=
br></div><br><div>Please CC the mailing list on your reply.</div></div></di=
v></blockquote><br></span><div>I will also need to know what glibc version =
you have on your system.<br></div><br><div>Thanks,<br></div><br><div>Mathie=
u<br></div><div><div class=3D"m_-8739052298097068210m_5949702530543711213h5=
"><br><br><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5p=
x;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-dec=
oration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div st=
yle=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:#000000"=
><div><br><br><div>Thanks,<br></div><br><div>Mathieu<br></div><br><blockquo=
te style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;=
color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-f=
amily:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><br></div=
><div class=3D"gmail_extra"><br clear=3D"all"><div><div class=3D"m_-8739052=
298097068210m_5949702530543711213m_4191731141621744608gmail_signature"><div=
 dir=3D"ltr"><span style=3D"color:#888888">Shehab Y. Elsayed, MSc.<br>
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
an id=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_=
-2379611272366386122zwchr">----- On Mar 19, 2018, at 12:36 PM, Shehab Elsay=
ed &lt;<a href=3D"mailto:shehabyomn@gmail.com" target=3D"_blank">shehabyomn=
@gmail.com</a>&gt; wrote:<br></span></div></span><div><span><blockquote sty=
le=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:=
#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:=
Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div><div><div>=
<div><div><div><div>Hi Mathieu,<br><br>Thank you very much for your reply.<=
br><br>I manually built lttng-ust from source (commit #: 8a208943e21700211b=
eee3ea64180a5a534c7d2a).<br><br></div>This is how I set up the tracing sess=
ion:<br></div>1- lttng create lu_ncb_8_native -o {path}<br></div>2- lttng e=
nable-event --userspace lttng_ust_pthread:pthread_mutex_lock_req<br>&nbsp;&=
nbsp;&nbsp; lttng enable-event --userspace lttng_ust_pthread:pthread_mutex_=
lock_acq<br>&nbsp;&nbsp;&nbsp; lttng enable-event --userspace lttng_ust_pth=
read:pthread_mutex_lock_trylock<br>&nbsp;&nbsp;&nbsp; lttng enable-event --=
userspace lttng_ust_pthread:pthread_mutex_lock_unlock<br></div>3- lttng add=
-context -u -t procname<br>&nbsp;&nbsp;&nbsp; lttng add-context -u -t vpid<=
br>&nbsp;&nbsp;&nbsp;  lttng add-context -u -t pthread_id<br>&nbsp;&nbsp;&n=
bsp;  lttng add-context -u -t vtid<br>&nbsp;&nbsp;&nbsp;  lttng add-context=
 -u -t ip<br>&nbsp;&nbsp;&nbsp;  lttng add-context -u -t perf:thread:cpu-cy=
cles<br>&nbsp;&nbsp;&nbsp;  lttng add-context -u -t perf:thread:cycles<br>&=
nbsp;&nbsp;&nbsp;  lttng add-context -u -t perf:thread:instructions<br></di=
v>4- lttng start<br>5- LD_PRELOAD=3D/usr/local/lib/liblttng-ust-pthread-wra=
pper.so ./lu_ncb -p8 -n8096 -b32<br></div>6- lttng stop<br></div>7- lttng d=
estroy</div></blockquote><br></span><div>Can you reproduce if you remove th=
e following contexts ?<br></div><span><br><div>&nbsp;&nbsp;&nbsp; lttng add=
-context -u -t perf:thread:cpu-cycles<br>&nbsp;&nbsp;&nbsp; lttng add-conte=
xt -u -t perf:thread:cycles<br>&nbsp;&nbsp;&nbsp; lttng add-context -u -t p=
erf:thread:instructions</div><br></span><div>And if you only keep a single =
of those contexts ?<br></div><br><div>Thanks,<br></div><br><div>Mathieu<br>=
</div><div><div class=3D"m_-8739052298097068210m_5949702530543711213m_41917=
31141621744608h5"><br><br><blockquote style=3D"border-left:2px solid #1010f=
f;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style=
:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-si=
ze:12pt"><div dir=3D"ltr"><br><br><br></div><div class=3D"gmail_extra"><br =
clear=3D"all"><div><div class=3D"m_-8739052298097068210m_594970253054371121=
3m_4191731141621744608m_-2379611272366386122gmail_signature"><div dir=3D"lt=
r"><span style=3D"color:#888888">Shehab Y. Elsayed, MSc.<br>
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
><div><span id=3D"m_-8739052298097068210m_5949702530543711213m_419173114162=
1744608m_-2379611272366386122m_-3928334406880738982zwchr">----- On Mar 16, =
2018, at 5:37 PM, Shehab Elsayed &lt;<a href=3D"mailto:shehabyomn@gmail.com=
" target=3D"_blank">shehabyomn@gmail.com</a>&gt; wrote:<br></span></div></s=
pan><div><span><blockquote style=3D"border-left:2px solid #1010ff;margin-le=
ft:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;tex=
t-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><d=
iv dir=3D"ltr"><div><div><div><div><div><div><div><div><div><div>Hello All,=
<br><br></div>I am trying to instrument a <span id=3D"m_-873905229809706821=
0m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928334=
406880738982:3qh.1">pthread</span> application using the provided <span id=
=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2379=
611272366386122m_-3928334406880738982:3qh.2">pthread</span> wrapper, but I =
sometimes run into a "Double free or corruption error (<span id=3D"m_-87390=
52298097068210m_5949702530543711213m_4191731141621744608m_-2379611272366386=
122m_-3928334406880738982:3qh.3">fasttop</span>)" error. </div></div></div>=
</div></div></div></div></div></div></div></blockquote><br></span><div>Plea=
se provide more information about the version of lttng-ust you are using, a=
nd how you setup<br></div><div>your tracing session.<br></div><br><div>Than=
ks,<br></div><br><div>Mathieu<br></div><br><blockquote style=3D"border-left=
:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:=
normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,s=
ans-serif;font-size:12pt"><div><div class=3D"m_-8739052298097068210m_594970=
2530543711213m_4191731141621744608m_-2379611272366386122h5"><div dir=3D"ltr=
"><div><div><div><div><div><div><div><div><div><br><br></div>Here is a desc=
ription of what I have tried and noticed:<br></div>1- The problem isn't con=
sistent. It sometimes happen and sometimes works as expected.<br></div>2- F=
rom my experiments, the problem happens (more frequently at least) when add=
ing performance counter contexts (I tried cycles, <span id=3D"m_-8739052298=
097068210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_=
-3928334406880738982:3qh.4">cpu</span>_cycles and instructions).<br></div>3=
- I am testing using <span id=3D"m_-8739052298097068210m_594970253054371121=
3m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.5">l=
u</span>_<span id=3D"m_-8739052298097068210m_5949702530543711213m_419173114=
1621744608m_-2379611272366386122m_-3928334406880738982:3qh.6">ncb</span> fr=
om splash3 benchmark suite after setting <span id=3D"m_-8739052298097068210=
m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344=
06880738982:3qh.7">LD</span>_<span id=3D"m_-8739052298097068210m_5949702530=
543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:=
3qh.8">PRELOAD</span> to use the <span id=3D"m_-8739052298097068210m_594970=
2530543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738=
982:3qh.9">pthread</span> wrapper as described in the <span id=3D"m_-873905=
2298097068210m_5949702530543711213m_4191731141621744608m_-23796112723663861=
22m_-3928334406880738982:3qh.10">LTTng</span> documents.<br></div>4- Here i=
s the <span id=3D"m_-8739052298097068210m_5949702530543711213m_419173114162=
1744608m_-2379611272366386122m_-3928334406880738982:3qh.11">backtrace</span=
> printed after exiting:<br>=3D=3D=3D=3D=3D=3D=3D <span id=3D"m_-8739052298=
097068210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_=
-3928334406880738982:3qh.12">Backtrace</span>: =3D=3D=3D=3D=3D=3D=3D=3D=3D<=
br>/lib64/<span id=3D"m_-8739052298097068210m_5949702530543711213m_41917311=
41621744608m_-2379611272366386122m_-3928334406880738982:3qh.13">libc</span>=
.so.6([Thread 0x7ffff5611700 (<span id=3D"m_-8739052298097068210m_594970253=
0543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982=
:3qh.14">LWP</span> 97229) exited]<br>/<span id=3D"m_-8739052298097068210m_=
5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928334406=
880738982:3qh.15">usr</span>/local/lib/<span id=3D"m_-8739052298097068210m_=
5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928334406=
880738982:3qh.16">liblttng</span>-<span id=3D"m_-8739052298097068210m_59497=
02530543711213m_4191731141621744608m_-2379611272366386122m_-392833440688073=
8982:3qh.17">ust</span>.so.0(<span id=3D"m_-8739052298097068210m_5949702530=
543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:=
3qh.18">lttng</span>_destroy_context+0x35)[0x7ffff7471575]<br>/<span id=3D"=
m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-23796112=
72366386122m_-3928334406880738982:3qh.19">usr</span>/local/lib/<span id=3D"=
m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-23796112=
72366386122m_-3928334406880738982:3qh.20">liblttng</span>-<span id=3D"m_-87=
39052298097068210m_5949702530543711213m_4191731141621744608m_-2379611272366=
386122m_-3928334406880738982:3qh.21">ust</span>.so.0(<span id=3D"m_-8739052=
298097068210m_5949702530543711213m_4191731141621744608m_-237961127236638612=
2m_-3928334406880738982:3qh.22">lttng</span>_session_destroy+0x21c)[0x7ffff=
747363c]<br>/<span id=3D"m_-8739052298097068210m_5949702530543711213m_41917=
31141621744608m_-2379611272366386122m_-3928334406880738982:3qh.23">usr</spa=
n>/local/lib/<span id=3D"m_-8739052298097068210m_5949702530543711213m_41917=
31141621744608m_-2379611272366386122m_-3928334406880738982:3qh.24">liblttng=
</span>-<span id=3D"m_-8739052298097068210m_5949702530543711213m_4191731141=
621744608m_-2379611272366386122m_-3928334406880738982:3qh.25">ust</span>.so=
.0(+0x1e906)[0x7ffff746d906]<br>/<span id=3D"m_-8739052298097068210m_594970=
2530543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738=
982:3qh.26">usr</span>/local/lib/<span id=3D"m_-8739052298097068210m_594970=
2530543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738=
982:3qh.27">liblttng</span>-<span id=3D"m_-8739052298097068210m_59497025305=
43711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3=
qh.28">ust</span>.so.0(<span id=3D"m_-8739052298097068210m_5949702530543711=
213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.29=
">lttng</span>_<span id=3D"m_-8739052298097068210m_5949702530543711213m_419=
1731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.30">ust</s=
pan>_<span id=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621=
744608m_-2379611272366386122m_-3928334406880738982:3qh.31">objd</span>_<spa=
n id=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-=
2379611272366386122m_-3928334406880738982:3qh.32">unref</span>+0x9f)[0x7fff=
f746dccf]<br>/<span id=3D"m_-8739052298097068210m_5949702530543711213m_4191=
731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.33">usr</sp=
an>/local/lib/<span id=3D"m_-8739052298097068210m_5949702530543711213m_4191=
731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.34">liblttn=
g</span>-<span id=3D"m_-8739052298097068210m_5949702530543711213m_419173114=
1621744608m_-2379611272366386122m_-3928334406880738982:3qh.35">ust</span>.s=
o.0(<span id=3D"m_-8739052298097068210m_5949702530543711213m_41917311416217=
44608m_-2379611272366386122m_-3928334406880738982:3qh.36">lttng</span>_<spa=
n id=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-=
2379611272366386122m_-3928334406880738982:3qh.37">ust</span>_<span id=3D"m_=
-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2379611272=
366386122m_-3928334406880738982:3qh.38">objd</span>_<span id=3D"m_-87390522=
98097068210m_5949702530543711213m_4191731141621744608m_-2379611272366386122=
m_-3928334406880738982:3qh.39">unref</span>+0x9f)[0x7ffff746dccf]<br>/<span=
 id=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2=
379611272366386122m_-3928334406880738982:3qh.40">usr</span>/local/lib/<span=
 id=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2=
379611272366386122m_-3928334406880738982:3qh.41">liblttng</span>-<span id=
=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2379=
611272366386122m_-3928334406880738982:3qh.42">ust</span>.so.0(<span id=3D"m=
_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-237961127=
2366386122m_-3928334406880738982:3qh.43">lttng</span>_<span id=3D"m_-873905=
2298097068210m_5949702530543711213m_4191731141621744608m_-23796112723663861=
22m_-3928334406880738982:3qh.44">ust</span>_<span id=3D"m_-8739052298097068=
210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-39283=
34406880738982:3qh.45">objd</span>_<span id=3D"m_-8739052298097068210m_5949=
702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344068807=
38982:3qh.46">unref</span>+0x9f)[0x7ffff746dccf]<br>/<span id=3D"m_-8739052=
298097068210m_5949702530543711213m_4191731141621744608m_-237961127236638612=
2m_-3928334406880738982:3qh.47">usr</span>/local/lib/<span id=3D"m_-8739052=
298097068210m_5949702530543711213m_4191731141621744608m_-237961127236638612=
2m_-3928334406880738982:3qh.48">liblttng</span>-<span id=3D"m_-873905229809=
7068210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3=
928334406880738982:3qh.49">ust</span>.so.0(<span id=3D"m_-87390522980970682=
10m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-392833=
4406880738982:3qh.50">lttng</span>_<span id=3D"m_-8739052298097068210m_5949=
702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344068807=
38982:3qh.51">ust</span>_<span id=3D"m_-8739052298097068210m_59497025305437=
11213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.=
52">abi</span>_exit+0x68)[0x7ffff746ead8]<br>/<span id=3D"m_-87390522980970=
68210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-392=
8334406880738982:3qh.53">usr</span>/local/lib/<span id=3D"m_-87390522980970=
68210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-392=
8334406880738982:3qh.54">liblttng</span>-<span id=3D"m_-8739052298097068210=
m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344=
06880738982:3qh.55">ust</span>.so.0(+0x191d3)[0x7ffff74681d3]<br>/<span id=
=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2379=
611272366386122m_-3928334406880738982:3qh.56">usr</span>/local/lib/<span id=
=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2379=
611272366386122m_-3928334406880738982:3qh.57">liblttng</span>-<span id=3D"m=
_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-237961127=
2366386122m_-3928334406880738982:3qh.58">ust</span>.so.0(<span id=3D"m_-873=
9052298097068210m_5949702530543711213m_4191731141621744608m_-23796112723663=
86122m_-3928334406880738982:3qh.59">lttng</span>_<span id=3D"m_-87390522980=
97068210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-=
3928334406880738982:3qh.60">ust</span>_exit+0x67)[0x7ffff745ed57]<br>/lib64=
/<span id=3D"m_-8739052298097068210m_5949702530543711213m_41917311416217446=
08m_-2379611272366386122m_-3928334406880738982:3qh.61">ld</span>-<span id=
=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2379=
611272366386122m_-3928334406880738982:3qh.62">linux</span>-x86-64.so.2(+0xf=
85a)[0x7ffff7dec85a]<br>/lib64/<span id=3D"m_-8739052298097068210m_59497025=
30543711213m_4191731141621744608m_-2379611272366386122m_-392833440688073898=
2:3qh.63">libc</span>.so.6(+0x38a49)[0x7ffff6ca6a49]<br>/lib64/<span id=3D"=
m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-23796112=
72366386122m_-3928334406880738982:3qh.64">libc</span>.so.6(+0x38a95)[0x7fff=
f6ca6a95]<br>/<span id=3D"m_-8739052298097068210m_5949702530543711213m_4191=
731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.65">aenao</=
span>-99/elsayed9/<span id=3D"m_-8739052298097068210m_5949702530543711213m_=
4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.66">LTT=
ng</span>/data/scripts/<span id=3D"m_-8739052298097068210m_5949702530543711=
213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.67=
">tmp</span>/<span id=3D"m_-8739052298097068210m_5949702530543711213m_41917=
31141621744608m_-2379611272366386122m_-3928334406880738982:3qh.68">lu</span=
>_<span id=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744=
608m_-2379611272366386122m_-3928334406880738982:3qh.69">ncb</span>[0x401b51=
]<br>/lib64/<span id=3D"m_-8739052298097068210m_5949702530543711213m_419173=
1141621744608m_-2379611272366386122m_-3928334406880738982:3qh.70">libc</spa=
n>.so.6(__<span id=3D"m_-8739052298097068210m_5949702530543711213m_41917311=
41621744608m_-2379611272366386122m_-3928334406880738982:3qh.71">libc</span>=
_start_main+0xf5)[0x7ffff6c8fb35]<br>/<span id=3D"m_-8739052298097068210m_5=
949702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344068=
80738982:3qh.72">aenao</span>-99/elsayed9/<span id=3D"m_-873905229809706821=
0m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928334=
406880738982:3qh.73">LTTng</span>/data/scripts/<span id=3D"m_-8739052298097=
068210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-39=
28334406880738982:3qh.74">tmp</span>/<span id=3D"m_-8739052298097068210m_59=
49702530543711213m_4191731141621744608m_-2379611272366386122m_-392833440688=
0738982:3qh.75">lu</span>_<span id=3D"m_-8739052298097068210m_5949702530543=
711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh=
.76">ncb</span>[0x401c44]<br></div>5- Also, this is a <span id=3D"m_-873905=
2298097068210m_5949702530543711213m_4191731141621744608m_-23796112723663861=
22m_-3928334406880738982:3qh.77">backtrace</span> I obtained from <span id=
=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2379=
611272366386122m_-3928334406880738982:3qh.78">gdb</span>:<br>#0&nbsp; 0x000=
07ffff6eac1d7 in raise () from /lib64/<span id=3D"m_-8739052298097068210m_5=
949702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344068=
80738982:3qh.79">libc</span>.so.6<br>#1&nbsp; 0x00007ffff6ead8c8 in abort (=
) from /lib64/<span id=3D"m_-8739052298097068210m_5949702530543711213m_4191=
731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.80">libc</s=
pan>.so.6<br>#2&nbsp; 0x00007ffff6eebf07 in __<span id=3D"m_-87390522980970=
68210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-392=
8334406880738982:3qh.81">libc</span>_message () from /lib64/<span id=3D"m_-=
8739052298097068210m_5949702530543711213m_4191731141621744608m_-23796112723=
66386122m_-3928334406880738982:3qh.82">libc</span>.so.6<br>#3&nbsp; 0x00007=
ffff6ef3503 in _int_free () from /lib64/<span id=3D"m_-8739052298097068210m=
_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-392833440=
6880738982:3qh.83">libc</span>.so.6<br>#4&nbsp; 0x00007ffff768ad25 in <span=
 id=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2=
379611272366386122m_-3928334406880738982:3qh.84">lttng</span>_destroy_<span=
 id=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2=
379611272366386122m_-3928334406880738982:3qh.85">perf</span>_counter_field =
(<br>&nbsp;&nbsp;&nbsp; field=3D&lt;optimized out&gt;) at <span id=3D"m_-87=
39052298097068210m_5949702530543711213m_4191731141621744608m_-2379611272366=
386122m_-3928334406880738982:3qh.86">lttng</span>-context-<span id=3D"m_-87=
39052298097068210m_5949702530543711213m_4191731141621744608m_-2379611272366=
386122m_-3928334406880738982:3qh.87">perf</span>-counters.c:418<br>#5&nbsp;=
 0x00007ffff767a575 in <span id=3D"m_-8739052298097068210m_5949702530543711=
213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.88=
">lttng</span>_destroy_context (<br><span id=3D"m_-8739052298097068210m_594=
9702530543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880=
738982:3qh.89">ctx</span>=3D0x7ffff0011090) at <span id=3D"m_-8739052298097=
068210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-39=
28334406880738982:3qh.90">lttng</span>-context.c:278<br>#6&nbsp; 0x00007fff=
f767c63c in _<span id=3D"m_-8739052298097068210m_5949702530543711213m_41917=
31141621744608m_-2379611272366386122m_-3928334406880738982:3qh.91">lttng</s=
pan>_channel_<span id=3D"m_-8739052298097068210m_5949702530543711213m_41917=
31141621744608m_-2379611272366386122m_-3928334406880738982:3qh.92">unmap</s=
pan> (<br><span id=3D"m_-8739052298097068210m_5949702530543711213m_41917311=
41621744608m_-2379611272366386122m_-3928334406880738982:3qh.93">lttng</span=
>_<span id=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744=
608m_-2379611272366386122m_-3928334406880738982:3qh.94">chan</span>=3D0x7ff=
ff0010f40) at <span id=3D"m_-8739052298097068210m_5949702530543711213m_4191=
731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.95">lttng</=
span>-events.c:172<br>#7&nbsp; <span id=3D"m_-8739052298097068210m_59497025=
30543711213m_4191731141621744608m_-2379611272366386122m_-392833440688073898=
2:3qh.96">lttng</span>_session_destroy (session=3D0x7ffff0000900)<br>&nbsp;=
&nbsp;&nbsp; at <span id=3D"m_-8739052298097068210m_5949702530543711213m_41=
91731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.97">lttng=
</span>-events.c:247<br>#8&nbsp; 0x00007ffff7676906 in <span id=3D"m_-87390=
52298097068210m_5949702530543711213m_4191731141621744608m_-2379611272366386=
122m_-3928334406880738982:3qh.98">lttng</span>_release_session (<br><span i=
d=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-237=
9611272366386122m_-3928334406880738982:3qh.99">objd</span>=3D&lt;optimized =
out&gt;) at <span id=3D"m_-8739052298097068210m_5949702530543711213m_419173=
1141621744608m_-2379611272366386122m_-3928334406880738982:3qh.100">lttng</s=
pan>-<span id=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621=
744608m_-2379611272366386122m_-3928334406880738982:3qh.101">ust</span>-<spa=
n id=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-=
2379611272366386122m_-3928334406880738982:3qh.102">abi</span>.c:601<br>#9&n=
bsp; 0x00007ffff7676ccf in <span id=3D"m_-8739052298097068210m_594970253054=
3711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3q=
h.103">lttng</span>_<span id=3D"m_-8739052298097068210m_5949702530543711213=
m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.104">=
ust</span>_<span id=3D"m_-8739052298097068210m_5949702530543711213m_4191731=
141621744608m_-2379611272366386122m_-3928334406880738982:3qh.105">objd</spa=
n>_<span id=3D"m_-8739052298097068210m_5949702530543711213m_419173114162174=
4608m_-2379611272366386122m_-3928334406880738982:3qh.106">unref</span> (id=
=3D1, <br>&nbsp;&nbsp;&nbsp; is_owner=3D&lt;optimized out&gt;) at <span id=
=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2379=
611272366386122m_-3928334406880738982:3qh.107">lttng</span>-<span id=3D"m_-=
8739052298097068210m_5949702530543711213m_4191731141621744608m_-23796112723=
66386122m_-3928334406880738982:3qh.108">ust</span>-<span id=3D"m_-873905229=
8097068210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m=
_-3928334406880738982:3qh.109">abi</span>.c:216<br>#10 0x00007ffff7676ccf i=
n <span id=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744=
608m_-2379611272366386122m_-3928334406880738982:3qh.110">lttng</span>_<span=
 id=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2=
379611272366386122m_-3928334406880738982:3qh.111">ust</span>_<span id=3D"m_=
-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2379611272=
366386122m_-3928334406880738982:3qh.112">objd</span>_<span id=3D"m_-8739052=
298097068210m_5949702530543711213m_4191731141621744608m_-237961127236638612=
2m_-3928334406880738982:3qh.113">unref</span> (id=3D2, <br>&nbsp;&nbsp;&nbs=
p; is_owner=3D&lt;optimized out&gt;) at <span id=3D"m_-8739052298097068210m=
_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-392833440=
6880738982:3qh.114">lttng</span>-<span id=3D"m_-8739052298097068210m_594970=
2530543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738=
982:3qh.115">ust</span>-<span id=3D"m_-8739052298097068210m_594970253054371=
1213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.1=
16">abi</span>.c:216<br>#11 0x00007ffff7676ccf in <span id=3D"m_-8739052298=
097068210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_=
-3928334406880738982:3qh.117">lttng</span>_<span id=3D"m_-87390522980970682=
10m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-392833=
4406880738982:3qh.118">ust</span>_<span id=3D"m_-8739052298097068210m_59497=
02530543711213m_4191731141621744608m_-2379611272366386122m_-392833440688073=
8982:3qh.119">objd</span>_<span id=3D"m_-8739052298097068210m_5949702530543=
711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh=
.120">unref</span> (id=3Did@entry=3D18, <br>&nbsp;&nbsp;&nbsp; is_owner=3Di=
s_owner@entry=3D1) at <span id=3D"m_-8739052298097068210m_59497025305437112=
13m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.121=
">lttng</span>-<span id=3D"m_-8739052298097068210m_5949702530543711213m_419=
1731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.122">ust</=
span>-<span id=3D"m_-8739052298097068210m_5949702530543711213m_419173114162=
1744608m_-2379611272366386122m_-3928334406880738982:3qh.123">abi</span>.c:2=
16<br>#12 0x00007ffff7677ad8 in <span id=3D"m_-8739052298097068210m_5949702=
530543711213m_4191731141621744608m_-2379611272366386122m_-39283344068807389=
82:3qh.124">objd</span>_table_destroy ()<br>&nbsp;&nbsp;&nbsp; at <span id=
=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2379=
611272366386122m_-3928334406880738982:3qh.125">lttng</span>-<span id=3D"m_-=
8739052298097068210m_5949702530543711213m_4191731141621744608m_-23796112723=
66386122m_-3928334406880738982:3qh.126">ust</span>-<span id=3D"m_-873905229=
8097068210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m=
_-3928334406880738982:3qh.127">abi</span>.c:235<br>#13 <span id=3D"m_-87390=
52298097068210m_5949702530543711213m_4191731141621744608m_-2379611272366386=
122m_-3928334406880738982:3qh.128">lttng</span>_<span id=3D"m_-873905229809=
7068210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3=
928334406880738982:3qh.129">ust</span>_<span id=3D"m_-8739052298097068210m_=
5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928334406=
880738982:3qh.130">abi</span>_exit () at <span id=3D"m_-8739052298097068210=
m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344=
06880738982:3qh.131">lttng</span>-<span id=3D"m_-8739052298097068210m_59497=
02530543711213m_4191731141621744608m_-2379611272366386122m_-392833440688073=
8982:3qh.132">ust</span>-<span id=3D"m_-8739052298097068210m_59497025305437=
11213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.=
133">abi</span>.c:1002<br>#14 0x00007ffff76711d3 in <span id=3D"m_-87390522=
98097068210m_5949702530543711213m_4191731141621744608m_-2379611272366386122=
m_-3928334406880738982:3qh.134">lttng</span>_<span id=3D"m_-873905229809706=
8210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928=
334406880738982:3qh.135">ust</span>_cleanup (exiting=3D1)<br>&nbsp;&nbsp;&n=
bsp; at <span id=3D"m_-8739052298097068210m_5949702530543711213m_4191731141=
621744608m_-2379611272366386122m_-3928334406880738982:3qh.136">lttng</span>=
-<span id=3D"m_-8739052298097068210m_5949702530543711213m_41917311416217446=
08m_-2379611272366386122m_-3928334406880738982:3qh.137">ust</span>-comm.c:1=
807<br>#15 0x00007ffff7667d57 in <span id=3D"m_-8739052298097068210m_594970=
2530543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738=
982:3qh.138">lttng</span>_<span id=3D"m_-8739052298097068210m_5949702530543=
711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh=
.139">ust</span>_exit ()<br>&nbsp;&nbsp;&nbsp; at <span id=3D"m_-8739052298=
097068210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_=
-3928334406880738982:3qh.140">lttng</span>-<span id=3D"m_-87390522980970682=
10m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-392833=
4406880738982:3qh.141">ust</span>-comm.c:1874<br>#16 0x00007ffff7dec85a in =
_<span id=3D"m_-8739052298097068210m_5949702530543711213m_41917311416217446=
08m_-2379611272366386122m_-3928334406880738982:3qh.142">dl</span>_<span id=
=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2379=
611272366386122m_-3928334406880738982:3qh.143">fini</span> ()<br>&nbsp;&nbs=
p; from /lib64/<span id=3D"m_-8739052298097068210m_5949702530543711213m_419=
1731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.144">ld</s=
pan>-<span id=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621=
744608m_-2379611272366386122m_-3928334406880738982:3qh.145">linux</span>-x8=
6-64.so.2<br>#17 0x00007ffff6eafa49 in __run_exit_handlers ()<br>&nbsp;&nbs=
p; from /lib64/<span id=3D"m_-8739052298097068210m_5949702530543711213m_419=
1731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.146">libc<=
/span>.so.6<br>#18 0x00007ffff6eafa95 in exit () from /lib64/<span id=3D"m_=
-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2379611272=
366386122m_-3928334406880738982:3qh.147">libc</span>.so.6<br>#19 0x00000000=
00401b51 in main (<span id=3D"m_-8739052298097068210m_5949702530543711213m_=
4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.148">ar=
gc</span>=3D&lt;optimized out&gt;, <br><span id=3D"m_-8739052298097068210m_=
5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928334406=
880738982:3qh.149">argv</span>=3D&lt;optimized out&gt;) at <span id=3D"m_-8=
739052298097068210m_5949702530543711213m_4191731141621744608m_-237961127236=
6386122m_-3928334406880738982:3qh.150">lu</span>.c:368<br><br></div>Any ide=
as, why this happens and how to fix it?<br><br></div>Thanks,<br></div><span=
 id=3D"m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2=
379611272366386122m_-3928334406880738982:3qh.151">Shehab</span><br><div><di=
v><div><div><br><br></div></div></div></div></div><br></div></div>_________=
______________________________________<br>lttng-dev mailing list<br><a href=
=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.ltt=
ng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/listinf=
o/lttng-dev</a><span class=3D"m_-8739052298097068210m_5949702530543711213m_=
4191731141621744608m_-2379611272366386122HOEnZb"><span style=3D"color:#8888=
88"><br></span></span></blockquote></div><span class=3D"m_-8739052298097068=
210m_5949702530543711213m_4191731141621744608m_-2379611272366386122HOEnZb">=
<span style=3D"color:#888888"><br><div>-- <br></div><div>Mathieu Desnoyers<=
br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">h=
ttp://www.efficios.com</a><br></div></span></span></div></div></blockquote>=
</div></div><br></blockquote></div></div></div><div><div class=3D"m_-873905=
2298097068210m_5949702530543711213m_4191731141621744608h5"><br><div>-- <br>=
</div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.effi=
cios.com" target=3D"_blank">http://www.efficios.com</a><br></div></div></di=
v></div></div></blockquote></div></div><br></blockquote></div><br><div>-- <=
br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.e=
fficios.com" target=3D"_blank">http://www.efficios.com</a><br></div></div><=
br></blockquote></div></div></div><div><div class=3D"m_-8739052298097068210=
m_5949702530543711213h5"><br><div>-- <br></div><div>Mathieu Desnoyers<br>Ef=
ficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http:/=
/www.efficios.com</a><br></div></div></div></div></div></blockquote></div><=
/div><br></blockquote></div></div></div><div><div class=3D"m_-8739052298097=
068210h5"><br><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>=
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br></div></div></div></div></div></blockquote></div></div><br></bloc=
kquote></div><br><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<=
br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficio=
s.com</a><br data-mce-bogus=3D"1"></div></div><br></blockquote></div><br><d=
iv>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http:=
//www.efficios.com" target=3D"_blank">http://www.efficios.com</a><br data-m=
ce-bogus=3D"1"></div></div><br></blockquote></div><br><div>-- <br></div><di=
v>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com"=
 target=3D"_blank">http://www.efficios.com</a><br data-mce-bogus=3D"1"></di=
v></div><br></blockquote></div></div></div><div><div class=3D"h5"><br><div>=
-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://w=
ww.efficios.com" target=3D"_blank">http://www.efficios.com</a><br data-mce-=
bogus=3D"1"></div></div></div></div></div></blockquote></div></div><br></bl=
ockquote></div><div><br></div><div data-marker=3D"__SIG_POST__">-- <br></di=
v><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div><=
/div></body></html>
--=_1bfd76f7-8a40-463d-98f7-ac100f57012f--

------=_Part_813_130294797.1521663778649
Content-Type: text/x-patch;
 name=0001-Fix-restore-original-thread-cancel-state.patch
Content-Disposition: attachment;
 filename=0001-Fix-restore-original-thread-cancel-state.patch
Content-Transfer-Encoding: base64

RnJvbSBhYzUxOTVmNGJmOTVlMjRiZDViNGZlMWQ5Y2NjN2NjY2JlNDRkY2RkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNA
ZWZmaWNpb3MuY29tPgpEYXRlOiBXZWQsIDIxIE1hciAyMDE4IDE2OjE2OjM4IC0wNDAwClN1Ympl
Y3Q6IFtSRkMgUEFUQ0hdIEZpeDogcmVzdG9yZSBvcmlnaW5hbCB0aHJlYWQgY2FuY2VsIHN0YXRl
CgpVc2VmdWwgd2hlbiB1c3RfbG9jayBpcyB1c2VkIGluIGFwcGxpY2F0aW9uIHRocmVhZHMgdGhh
dCBoYXZlIGEKZGlmZmVyZW50IGNhbmNlbCBzdGF0ZSAoZS5nLiBwZXJmIGNvdW50ZXJzIGNvbnRl
eHQpLgoKU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJz
QGVmZmljaW9zLmNvbT4KLS0tCiBsaWJsdHRuZy11c3QvbHR0bmctdXN0LWNvbW0uYyB8IDI3ICsr
KysrKysrKysrKysrKystLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMo
KyksIDExIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2xpYmx0dG5nLXVzdC9sdHRuZy11c3Qt
Y29tbS5jIGIvbGlibHR0bmctdXN0L2x0dG5nLXVzdC1jb21tLmMKaW5kZXggOTUyMGYyNDYuLjhj
NTk4NWE5IDEwMDY0NAotLS0gYS9saWJsdHRuZy11c3QvbHR0bmctdXN0LWNvbW0uYworKysgYi9s
aWJsdHRuZy11c3QvbHR0bmctdXN0LWNvbW0uYwpAQCAtOTIsNiArOTIsOCBAQCBzdGF0aWMgcHRo
cmVhZF9tdXRleF90IHVzdF9tdXRleCA9IFBUSFJFQURfTVVURVhfSU5JVElBTElaRVI7CiAvKiBB
bGxvdyBuZXN0aW5nIHRoZSB1c3RfbXV0ZXggd2l0aGluIHRoZSBzYW1lIHRocmVhZC4gKi8KIHN0
YXRpYyBERUZJTkVfVVJDVV9UTFMoaW50LCB1c3RfbXV0ZXhfbmVzdCk7CiAKK3N0YXRpYyBERUZJ
TkVfVVJDVV9UTFMoaW50LCBwdGhyZWFkX2NhbmNlbF9vbGRzdGF0ZSk7CisKIC8qIERvIG5vdCB0
cmFjZSBldmVudHMgZm9yIHRoZSBjdXJyZW50IHRocmVhZC4gKi8KIERFRklORV9VUkNVX1RMUyhp
bnQsIGx0dG5nX3VzdF9ub3RyYWNlX3RocmVhZCkgX19hdHRyaWJ1dGVfXygodmlzaWJpbGl0eSgi
aGlkZGVuIikpKTsKIApAQCAtMTQ0LDE1ICsxNDYsMTMgQEAgdm9pZCBsdHRuZ191c3RfZW5kX25v
dHJhY2Uodm9pZCkKIGludCB1c3RfbG9jayh2b2lkKQogewogCXNpZ3NldF90IHNpZ19hbGxfYmxv
Y2tlZCwgb3JpZ19tYXNrOwotCWludCByZXQsIG9sZHN0YXRlOworCWludCByZXQ7CiAKLQlyZXQg
PSBwdGhyZWFkX3NldGNhbmNlbHN0YXRlKFBUSFJFQURfQ0FOQ0VMX0RJU0FCTEUsICZvbGRzdGF0
ZSk7CisJcmV0ID0gcHRocmVhZF9zZXRjYW5jZWxzdGF0ZShQVEhSRUFEX0NBTkNFTF9ESVNBQkxF
LAorCQkmcHRocmVhZF9jYW5jZWxfb2xkc3RhdGUpOwogCWlmIChyZXQpIHsKIAkJRVJSKCJwdGhy
ZWFkX3NldGNhbmNlbHN0YXRlOiAlcyIsIHN0cmVycm9yKHJldCkpOwogCX0KLQlpZiAob2xkc3Rh
dGUgIT0gUFRIUkVBRF9DQU5DRUxfRU5BQkxFKSB7Ci0JCUVSUigicHRocmVhZF9zZXRjYW5jZWxz
dGF0ZTogdW5leHBlY3RlZCBvbGRzdGF0ZSIpOwotCX0KIAlzaWdmaWxsc2V0KCZzaWdfYWxsX2Js
b2NrZWQpOwogCXJldCA9IHB0aHJlYWRfc2lnbWFzayhTSUdfU0VUTUFTSywgJnNpZ19hbGxfYmxv
Y2tlZCwgJm9yaWdfbWFzayk7CiAJaWYgKHJldCkgewpAQCAtMTgwLDE1ICsxODAsMTMgQEAgaW50
IHVzdF9sb2NrKHZvaWQpCiB2b2lkIHVzdF9sb2NrX25vY2hlY2sodm9pZCkKIHsKIAlzaWdzZXRf
dCBzaWdfYWxsX2Jsb2NrZWQsIG9yaWdfbWFzazsKLQlpbnQgcmV0LCBvbGRzdGF0ZTsKKwlpbnQg
cmV0OwogCi0JcmV0ID0gcHRocmVhZF9zZXRjYW5jZWxzdGF0ZShQVEhSRUFEX0NBTkNFTF9ESVNB
QkxFLCAmb2xkc3RhdGUpOworCXJldCA9IHB0aHJlYWRfc2V0Y2FuY2Vsc3RhdGUoUFRIUkVBRF9D
QU5DRUxfRElTQUJMRSwKKwkJJnB0aHJlYWRfY2FuY2VsX29sZHN0YXRlKTsKIAlpZiAocmV0KSB7
CiAJCUVSUigicHRocmVhZF9zZXRjYW5jZWxzdGF0ZTogJXMiLCBzdHJlcnJvcihyZXQpKTsKIAl9
Ci0JaWYgKG9sZHN0YXRlICE9IFBUSFJFQURfQ0FOQ0VMX0VOQUJMRSkgewotCQlFUlIoInB0aHJl
YWRfc2V0Y2FuY2Vsc3RhdGU6IHVuZXhwZWN0ZWQgb2xkc3RhdGUiKTsKLQl9CiAJc2lnZmlsbHNl
dCgmc2lnX2FsbF9ibG9ja2VkKTsKIAlyZXQgPSBwdGhyZWFkX3NpZ21hc2soU0lHX1NFVE1BU0ss
ICZzaWdfYWxsX2Jsb2NrZWQsICZvcmlnX21hc2spOwogCWlmIChyZXQpIHsKQEAgLTIyMSw3ICsy
MTksNyBAQCB2b2lkIHVzdF91bmxvY2sodm9pZCkKIAlpZiAocmV0KSB7CiAJCUVSUigicHRocmVh
ZF9zaWdtYXNrOiAlcyIsIHN0cmVycm9yKHJldCkpOwogCX0KLQlyZXQgPSBwdGhyZWFkX3NldGNh
bmNlbHN0YXRlKFBUSFJFQURfQ0FOQ0VMX0VOQUJMRSwgJm9sZHN0YXRlKTsKKwlyZXQgPSBwdGhy
ZWFkX3NldGNhbmNlbHN0YXRlKHB0aHJlYWRfY2FuY2VsX29sZHN0YXRlLCAmb2xkc3RhdGUpOwog
CWlmIChyZXQpIHsKIAkJRVJSKCJwdGhyZWFkX3NldGNhbmNlbHN0YXRlOiAlcyIsIHN0cmVycm9y
KHJldCkpOwogCX0KQEAgLTQxNCw2ICs0MTIsMTIgQEAgdm9pZCBsdHRuZ19maXh1cF9sdHRuZ191
c3Rfbm90cmFjZV90bHModm9pZCkKIAlhc20gdm9sYXRpbGUgKCIiIDogOiAibSIgKFVSQ1VfVExT
KGx0dG5nX3VzdF9ub3RyYWNlX3RocmVhZCkpKTsKIH0KIAorc3RhdGljCit2b2lkIGx0dG5nX2Zp
eHVwX3B0aHJlYWRfY2FuY2VsX29sZHN0YXRlX3Rscyh2b2lkKQoreworCWFzbSB2b2xhdGlsZSAo
IiIgOiA6ICJtIiAoVVJDVV9UTFMocHRocmVhZF9jYW5jZWxfb2xkc3RhdGUpKSk7Cit9CisKIC8q
CiAgKiBGaXh1cCB1cmN1IGJwIFRMUy4KICAqLwpAQCAtNDMzLDYgKzQzNyw3IEBAIHZvaWQgbHR0
bmdfdXN0X2ZpeHVwX3Rscyh2b2lkKQogCWx0dG5nX2ZpeHVwX3Byb2NuYW1lX3RscygpOwogCWx0
dG5nX2ZpeHVwX3VzdF9tdXRleF9uZXN0X3RscygpOwogCWx0dG5nX2ZpeHVwX2x0dG5nX3VzdF9u
b3RyYWNlX3RscygpOworCWx0dG5nX2ZpeHVwX3B0aHJlYWRfY2FuY2VsX29sZHN0YXRlX3Rscygp
OwogCWx0dG5nX3VzdF9maXh1cF9mZF90cmFja2VyX3RscygpOwogfQogCi0tIAoyLjExLjAKCg==

------=_Part_813_130294797.1521663778649
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

------=_Part_813_130294797.1521663778649--
