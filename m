From: Shehab Elsayed <shehabyomn@gmail.com>
Subject: Re: Double free or corruption error (fasttop)
Date: Thu, 22 Mar 2018 13:15:45 -0400
Message-ID: <CAC-H6tsthnrz-eFmqL+bYqo3rzFmQr0xLx5Pi3cb+zXUcpSGOQ__46084.5208297998$1521738837$gmane$org@mail.gmail.com>
References: <CAC-H6ttMF-CjzDH7a6bmeoOPP8JRLptYTmGJVvrx5t-G0Se_gA@mail.gmail.com>
 <268788496.560.1521653237589.JavaMail.zimbra@efficios.com>
 <CAC-H6tt-8XVLAfXPY+fwnCjetrD9HURZ3H_CVSJns0Te5AccLw@mail.gmail.com>
 <296564653.817.1521663778651.JavaMail.zimbra@efficios.com>
 <CAC-H6tvG0CyDsys5TmPJrM1vprNutxpo8WjVSw0jUgtGesUB+w@mail.gmail.com>
 <CAC-H6tsZOHhOozXQG8tymivKHdWTo0m3oocT3C52eszWkk4GLA@mail.gmail.com>
 <1507490904.2231.1521677620959.JavaMail.zimbra@efficios.com>
 <CAC-H6tsTjWoFJUPqfrV5GZE+yb4Jqfx7bwJDb1JrmTbLAAfqcg@mail.gmail.com>
 <474308636.2596.1521738019810.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6506159944094264847=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-x22c.google.com (mail-lf0-x22c.google.com
 [IPv6:2a00:1450:4010:c07::22c])
 by lists.lttng.org (Postfix) with ESMTPS id 406YGX3JRHzyHh
 for <lttng-dev@lists.lttng.org>; Thu, 22 Mar 2018 13:15:48 -0400 (EDT)
Received: by mail-lf0-x22c.google.com with SMTP id y2-v6so14321061lfc.5
 for <lttng-dev@lists.lttng.org>; Thu, 22 Mar 2018 10:15:48 -0700 (PDT)
In-Reply-To: <474308636.2596.1521738019810.JavaMail.zimbra@efficios.com>
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

--===============6506159944094264847==
Content-Type: multipart/alternative; boundary="883d24f22e2855156c0568037514"

--883d24f22e2855156c0568037514
Content-Type: text/plain; charset="UTF-8"

It is v2.17 (for the problematic system) and 2.23 for the other

Shehab Y. Elsayed, MSc.
PhD Student
The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
University of Toronto
E-mail: shehabyomn@gmail.com
<https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>

On Thu, Mar 22, 2018 at 1:00 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ----- On Mar 22, 2018, at 12:24 PM, Shehab Elsayed <shehabyomn@gmail.com>
> wrote:
>
> Actually, i am not sure if this would help. I have been trying to
> reproduce the problem on a different machine, but I can't. Even without the
> patches !!!!!
>
>
> Does it have the same glibc version ?
>
> Thanks,
>
> Mathieu
>
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
> On Wed, Mar 21, 2018 at 8:13 PM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
>
>> ----- On Mar 21, 2018, at 8:01 PM, Shehab Elsayed <shehabyomn@gmail.com>
>> wrote:
>>
>> Just to clarify more what I meant by custom events; I have new
>> tracepoints added in the source code of the benchmark. However, I don't
>> enable the corresponding events when I do the actual tracing.
>>
>> This is the sequence followed in building the benchmark:
>> gcc-7.2 -c -O2 -pthread -D_XOPEN_SOURCE=500 -D_POSIX_C_SOURCE=200112
>> -std=c11 -g -fno-strict-aliasing -DLTTNG_INST lu.c
>> gcc-7.2 -O2 -pthread -D_XOPEN_SOURCE=500 -D_POSIX_C_SOURCE=200112
>> -std=c11 -g -fno-strict-aliasing -DLTTNG_INST -o LU_NCB lu.o
>> ../../instrumentation/lttng_tp/tp.o -lm -llttng-ust -ldl
>>
>> LTTNG_INST is just a preprocessor flag I have and tp.o is my custom
>> tracepoints
>>
>> Could you share a repository with your custom instrumentation on github,
>> so I could
>> try it out ?
>>
>> My current problem is that I cannot reproduce your issue on my end.
>>
>> Thanks,
>>
>> Mathieu
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
>> On Wed, Mar 21, 2018 at 7:55 PM, Shehab Elsayed <shehabyomn@gmail.com>
>> wrote:
>>
>>> Still running into same problem. I attached the debug trace I got after
>>> applying the 2 patches.
>>>
>>> The benchmark I am running also includes some custom created
>>> tracepoints. I am not adding the events being traced in the files I have
>>> provided. Do you think this might be causing a problem when I have
>>> tracpoints from 2 different packages?
>>>
>>> Shehab Y. Elsayed, MSc.
>>> PhD Student
>>> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
>>> University of Toronto
>>> E-mail: shehabyomn@gmail.com
>>> <https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>
>>>
>>> On Wed, Mar 21, 2018 at 4:22 PM, Mathieu Desnoyers <
>>> mathieu.desnoyers@efficios.com> wrote:
>>>
>>>> ----- On Mar 21, 2018, at 1:55 PM, Shehab Elsayed <shehabyomn@gmail.com>
>>>> wrote:
>>>>
>>>> I am so sorry for the late replies.
>>>>
>>>> I have tried the first patch you sent and the problem still happens
>>>> (although seemingly less frequently especially with debugging enabled!!!!).
>>>> I have attached the output I got from one of the erroneous runs.
>>>>
>>>> I will try the updated patch and let you know how it goes.
>>>>
>>>> Also, I am not sure if these points make any difference:
>>>> 1- The error actually happens at the end of the application. It
>>>> actually finishes execution, but then something goes wrong.
>>>> 2- I run into this problem only for some of the benchmarks (or at least
>>>> the problems happens much less frequently for others that I didn't run into
>>>> it, not yet)
>>>>
>>>> Thanks you very much, and sorry again for the late replies.
>>>>
>>>>
>>>> No worries! Looking through your log, I notice that pthread set cancel
>>>> state has problems when
>>>> called from application threads. We do not restore the original
>>>> thread's cancel state. Can you try
>>>> with the attached patch applied on top of the previous one ?
>>>>
>>>> Thanks,
>>>>
>>>> Mathieu
>>>>
>>>>
>>>>
>>>>
>>>> Shehab Y. Elsayed, MSc.
>>>> PhD Student
>>>> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
>>>> University of Toronto
>>>> E-mail: shehabyomn@gmail.com
>>>> <https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>
>>>>
>>>> On Wed, Mar 21, 2018 at 1:27 PM, Mathieu Desnoyers <
>>>> mathieu.desnoyers@efficios.com> wrote:
>>>>
>>>>> ----- On Mar 20, 2018, at 5:42 PM, Mathieu Desnoyers <
>>>>> mathieu.desnoyers@efficios.com> wrote:
>>>>>
>>>>> ----- On Mar 20, 2018, at 4:58 PM, Mathieu Desnoyers <
>>>>> mathieu.desnoyers@efficios.com> wrote:
>>>>>
>>>>> ----- On Mar 20, 2018, at 12:07 PM, Mathieu Desnoyers <
>>>>> mathieu.desnoyers@efficios.com> wrote:
>>>>>
>>>>>
>>>>> ----- On Mar 19, 2018, at 4:21 PM, Shehab Elsayed <
>>>>> shehabyomn@gmail.com> wrote:
>>>>>
>>>>> I did "echo "-1" > /proc/sys/kernel/perf_event_paranoid" and made
>>>>> sure the value was actually written by "cat /proc/sys/kernel/perf_event_
>>>>> paranoid"
>>>>>
>>>>> It executed normally 2 times but then got the same error.
>>>>>
>>>>>
>>>>> Can you provide the output when reproducing the issue with the
>>>>> LTTNG_UST_DEBUG=1 environment variable set when starting
>>>>> your test program ?
>>>>>
>>>>> I just noticed something that might explain what goes wrong here:
>>>>>
>>>>> lttng-context-perf-counters.c: add_thread_field() grabs the
>>>>> ust_lock(). Pthread mutex
>>>>> in your case is instrumented with the pthread wrapper. This
>>>>> "add_thread_field" is invoked
>>>>> the first time the perf counter is hit by each given thread. When this
>>>>> happens, the
>>>>> instrumented pthread mutex will try to call into the instrumentation
>>>>> tracepoint again,
>>>>> which will call add_thread_field() (again), and so on until we reach
>>>>> the libringbuffer
>>>>> "lib_ring_buffer_nesting" threshold of 4 calls deep.
>>>>>
>>>>> I suspect this situation where we recursively call add_thread_field is
>>>>> unexpected,
>>>>> which may trigger your double-free here.
>>>>>
>>>>> Will investigate more.
>>>>>
>>>>> Can you try with the attached patch applied ?
>>>>>
>>>>> Here is an updated v2 of the patch which tests the notrace tls counter
>>>>> sooner (before evaluating
>>>>> filter). Please let me know how it goes.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Mathieu
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Mathieu
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Mathieu
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Mathieu
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Shehab Y. Elsayed, MSc.
>>>>> PhD Student
>>>>> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
>>>>> University of Toronto
>>>>> E-mail: shehabyomn@gmail.com
>>>>> <https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>
>>>>>
>>>>> On Mon, Mar 19, 2018 at 4:01 PM, Mathieu Desnoyers <
>>>>> mathieu.desnoyers@efficios.com> wrote:
>>>>>
>>>>>>
>>>>>>
>>>>>> ----- On Mar 19, 2018, at 3:53 PM, Shehab Elsayed <
>>>>>> shehabyomn@gmail.com> wrote:
>>>>>>
>>>>>> cat /proc/sys/kernel/perf_event_paranoid ---> returns 1
>>>>>>
>>>>>> I run the program as a normal user
>>>>>>
>>>>>> The glibc version I get by running "ldd --version" is 2.17
>>>>>>
>>>>>>
>>>>>> Can you reproduce the issue after you do this as root ?
>>>>>>
>>>>>> echo "-1" > /proc/sys/kernel/perf_event_paranoid
>>>>>>
>>>>>> Based on this documentation of the Linux kernel:
>>>>>>
>>>>>> Documentation/sysctl/kernel.txt:
>>>>>>
>>>>>> perf_event_paranoid:
>>>>>>
>>>>>> Controls use of the performance events system by unprivileged
>>>>>> users (without CAP_SYS_ADMIN).  The default value is 2.
>>>>>>
>>>>>>  -1: Allow use of (almost) all events by all users
>>>>>>      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
>>>>>> >=0: Disallow ftrace function tracepoint by users without
>>>>>> CAP_SYS_ADMIN
>>>>>>      Disallow raw tracepoint access by users without CAP_SYS_ADMIN
>>>>>> >=1: Disallow CPU event access by users without CAP_SYS_ADMIN
>>>>>> >=2: Disallow kernel profiling by users without CAP_SYS_ADMIN
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> Mathieu
>>>>>>
>>>>>>
>>>>>>
>>>>>> Shehab Y. Elsayed, MSc.
>>>>>> PhD Student
>>>>>> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
>>>>>> University of Toronto
>>>>>> E-mail: shehabyomn@gmail.com
>>>>>> <https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>
>>>>>>
>>>>>> On Mon, Mar 19, 2018 at 3:31 PM, Mathieu Desnoyers <
>>>>>> mathieu.desnoyers@efficios.com> wrote:
>>>>>>
>>>>>>> ---- On Mar 19, 2018, at 3:26 PM, Mathieu Desnoyers <
>>>>>>> mathieu.desnoyers@efficios.com> wrote:
>>>>>>>
>>>>>>> ----- On Mar 19, 2018, at 2:26 PM, Shehab Elsayed <
>>>>>>> shehabyomn@gmail.com> wrote:
>>>>>>>
>>>>>>> Yes, I tried with only one of those contexts and I still ran into
>>>>>>> the same problem.
>>>>>>>
>>>>>>> What is the setting returned by
>>>>>>>
>>>>>>> cat /proc/sys/kernel/perf_event_paranoid
>>>>>>>
>>>>>>> on your system ? And do you run your test program as root or normal
>>>>>>> user ?
>>>>>>>
>>>>>>> Please CC the mailing list on your reply.
>>>>>>>
>>>>>>>
>>>>>>> I will also need to know what glibc version you have on your system.
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>> Mathieu
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>> Mathieu
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Shehab Y. Elsayed, MSc.
>>>>>>> PhD Student
>>>>>>> The Edwards S. Rogers Sr. Dept. of Electrical and Computer
>>>>>>> Engineering
>>>>>>> University of Toronto
>>>>>>> E-mail: shehabyomn@gmail.com
>>>>>>> <https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>
>>>>>>>
>>>>>>> On Mon, Mar 19, 2018 at 2:24 PM, Mathieu Desnoyers <
>>>>>>> mathieu.desnoyers@efficios.com> wrote:
>>>>>>>
>>>>>>>> ----- On Mar 19, 2018, at 12:36 PM, Shehab Elsayed <
>>>>>>>> shehabyomn@gmail.com> wrote:
>>>>>>>>
>>>>>>>> Hi Mathieu,
>>>>>>>>
>>>>>>>> Thank you very much for your reply.
>>>>>>>>
>>>>>>>> I manually built lttng-ust from source (commit #:
>>>>>>>> 8a208943e21700211beee3ea64180a5a534c7d2a).
>>>>>>>>
>>>>>>>> This is how I set up the tracing session:
>>>>>>>> 1- lttng create lu_ncb_8_native -o {path}
>>>>>>>> 2- lttng enable-event --userspace lttng_ust_pthread:pthread_
>>>>>>>> mutex_lock_req
>>>>>>>>     lttng enable-event --userspace lttng_ust_pthread:pthread_
>>>>>>>> mutex_lock_acq
>>>>>>>>     lttng enable-event --userspace lttng_ust_pthread:pthread_
>>>>>>>> mutex_lock_trylock
>>>>>>>>     lttng enable-event --userspace lttng_ust_pthread:pthread_
>>>>>>>> mutex_lock_unlock
>>>>>>>> 3- lttng add-context -u -t procname
>>>>>>>>     lttng add-context -u -t vpid
>>>>>>>>     lttng add-context -u -t pthread_id
>>>>>>>>     lttng add-context -u -t vtid
>>>>>>>>     lttng add-context -u -t ip
>>>>>>>>     lttng add-context -u -t perf:thread:cpu-cycles
>>>>>>>>     lttng add-context -u -t perf:thread:cycles
>>>>>>>>     lttng add-context -u -t perf:thread:instructions
>>>>>>>> 4- lttng start
>>>>>>>> 5- LD_PRELOAD=/usr/local/lib/liblttng-ust-pthread-wrapper.so
>>>>>>>> ./lu_ncb -p8 -n8096 -b32
>>>>>>>> 6- lttng stop
>>>>>>>> 7- lttng destroy
>>>>>>>>
>>>>>>>>
>>>>>>>> Can you reproduce if you remove the following contexts ?
>>>>>>>>
>>>>>>>>     lttng add-context -u -t perf:thread:cpu-cycles
>>>>>>>>     lttng add-context -u -t perf:thread:cycles
>>>>>>>>     lttng add-context -u -t perf:thread:instructions
>>>>>>>>
>>>>>>>> And if you only keep a single of those contexts ?
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>>
>>>>>>>> Mathieu
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Shehab Y. Elsayed, MSc.
>>>>>>>> PhD Student
>>>>>>>> The Edwards S. Rogers Sr. Dept. of Electrical and Computer
>>>>>>>> Engineering
>>>>>>>> University of Toronto
>>>>>>>> E-mail: shehabyomn@gmail.com
>>>>>>>> <https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>
>>>>>>>>
>>>>>>>> On Mon, Mar 19, 2018 at 12:21 PM, Mathieu Desnoyers <
>>>>>>>> mathieu.desnoyers@efficios.com> wrote:
>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> ----- On Mar 16, 2018, at 5:37 PM, Shehab Elsayed <
>>>>>>>>> shehabyomn@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> Hello All,
>>>>>>>>>
>>>>>>>>> I am trying to instrument a pthread application using the
>>>>>>>>> provided pthread wrapper, but I sometimes run into a "Double free
>>>>>>>>> or corruption error (fasttop)" error.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Please provide more information about the version of lttng-ust you
>>>>>>>>> are using, and how you setup
>>>>>>>>> your tracing session.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>>
>>>>>>>>> Mathieu
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Here is a description of what I have tried and noticed:
>>>>>>>>> 1- The problem isn't consistent. It sometimes happen and sometimes
>>>>>>>>> works as expected.
>>>>>>>>> 2- From my experiments, the problem happens (more frequently at
>>>>>>>>> least) when adding performance counter contexts (I tried cycles,
>>>>>>>>> cpu_cycles and instructions).
>>>>>>>>> 3- I am testing using lu_ncb from splash3 benchmark suite after
>>>>>>>>> setting LD_PRELOAD to use the pthread wrapper as described in the
>>>>>>>>> LTTng documents.
>>>>>>>>> 4- Here is the backtrace printed after exiting:
>>>>>>>>> ======= Backtrace: =========
>>>>>>>>> /lib64/libc.so.6([Thread 0x7ffff5611700 (LWP 97229) exited]
>>>>>>>>> /usr/local/lib/liblttng-ust.so.0(lttng_destroy_context+
>>>>>>>>> 0x35)[0x7ffff7471575]
>>>>>>>>> /usr/local/lib/liblttng-ust.so.0(lttng_session_destroy+
>>>>>>>>> 0x21c)[0x7ffff747363c]
>>>>>>>>> /usr/local/lib/liblttng-ust.so.0(+0x1e906)[0x7ffff746d906]
>>>>>>>>> /usr/local/lib/liblttng-ust.so.0(lttng_ust_objd_unref+
>>>>>>>>> 0x9f)[0x7ffff746dccf]
>>>>>>>>> /usr/local/lib/liblttng-ust.so.0(lttng_ust_objd_unref+
>>>>>>>>> 0x9f)[0x7ffff746dccf]
>>>>>>>>> /usr/local/lib/liblttng-ust.so.0(lttng_ust_objd_unref+
>>>>>>>>> 0x9f)[0x7ffff746dccf]
>>>>>>>>> /usr/local/lib/liblttng-ust.so.0(lttng_ust_abi_exit+0x68)[
>>>>>>>>> 0x7ffff746ead8]
>>>>>>>>> /usr/local/lib/liblttng-ust.so.0(+0x191d3)[0x7ffff74681d3]
>>>>>>>>> /usr/local/lib/liblttng-ust.so.0(lttng_ust_exit+0x67)[
>>>>>>>>> 0x7ffff745ed57]
>>>>>>>>> /lib64/ld-linux-x86-64.so.2(+0xf85a)[0x7ffff7dec85a]
>>>>>>>>> /lib64/libc.so.6(+0x38a49)[0x7ffff6ca6a49]
>>>>>>>>> /lib64/libc.so.6(+0x38a95)[0x7ffff6ca6a95]
>>>>>>>>> /aenao-99/elsayed9/LTTng/data/scripts/tmp/lu_ncb[0x401b51]
>>>>>>>>> /lib64/libc.so.6(__libc_start_main+0xf5)[0x7ffff6c8fb35]
>>>>>>>>> /aenao-99/elsayed9/LTTng/data/scripts/tmp/lu_ncb[0x401c44]
>>>>>>>>> 5- Also, this is a backtrace I obtained from gdb:
>>>>>>>>> #0  0x00007ffff6eac1d7 in raise () from /lib64/libc.so.6
>>>>>>>>> #1  0x00007ffff6ead8c8 in abort () from /lib64/libc.so.6
>>>>>>>>> #2  0x00007ffff6eebf07 in __libc_message () from /lib64/libc.so.6
>>>>>>>>> #3  0x00007ffff6ef3503 in _int_free () from /lib64/libc.so.6
>>>>>>>>> #4  0x00007ffff768ad25 in lttng_destroy_perf_counter_field (
>>>>>>>>>     field=<optimized out>) at lttng-context-perf-counters.c:418
>>>>>>>>> #5  0x00007ffff767a575 in lttng_destroy_context (
>>>>>>>>> ctx=0x7ffff0011090) at lttng-context.c:278
>>>>>>>>> #6  0x00007ffff767c63c in _lttng_channel_unmap (
>>>>>>>>> lttng_chan=0x7ffff0010f40) at lttng-events.c:172
>>>>>>>>> #7  lttng_session_destroy (session=0x7ffff0000900)
>>>>>>>>>     at lttng-events.c:247
>>>>>>>>> #8  0x00007ffff7676906 in lttng_release_session (
>>>>>>>>> objd=<optimized out>) at lttng-ust-abi.c:601
>>>>>>>>> #9  0x00007ffff7676ccf in lttng_ust_objd_unref (id=1,
>>>>>>>>>     is_owner=<optimized out>) at lttng-ust-abi.c:216
>>>>>>>>> #10 0x00007ffff7676ccf in lttng_ust_objd_unref (id=2,
>>>>>>>>>     is_owner=<optimized out>) at lttng-ust-abi.c:216
>>>>>>>>> #11 0x00007ffff7676ccf in lttng_ust_objd_unref (id=id@entry=18,
>>>>>>>>>     is_owner=is_owner@entry=1) at lttng-ust-abi.c:216
>>>>>>>>> #12 0x00007ffff7677ad8 in objd_table_destroy ()
>>>>>>>>>     at lttng-ust-abi.c:235
>>>>>>>>> #13 lttng_ust_abi_exit () at lttng-ust-abi.c:1002
>>>>>>>>> #14 0x00007ffff76711d3 in lttng_ust_cleanup (exiting=1)
>>>>>>>>>     at lttng-ust-comm.c:1807
>>>>>>>>> #15 0x00007ffff7667d57 in lttng_ust_exit ()
>>>>>>>>>     at lttng-ust-comm.c:1874
>>>>>>>>> #16 0x00007ffff7dec85a in _dl_fini ()
>>>>>>>>>    from /lib64/ld-linux-x86-64.so.2
>>>>>>>>> #17 0x00007ffff6eafa49 in __run_exit_handlers ()
>>>>>>>>>    from /lib64/libc.so.6
>>>>>>>>> #18 0x00007ffff6eafa95 in exit () from /lib64/libc.so.6
>>>>>>>>> #19 0x0000000000401b51 in main (argc=<optimized out>,
>>>>>>>>> argv=<optimized out>) at lu.c:368
>>>>>>>>>
>>>>>>>>> Any ideas, why this happens and how to fix it?
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Shehab
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> _______________________________________________
>>>>>>>>> lttng-dev mailing list
>>>>>>>>> lttng-dev@lists.lttng.org
>>>>>>>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> Mathieu Desnoyers
>>>>>>>>> EfficiOS Inc.
>>>>>>>>> http://www.efficios.com
>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> --
>>>>>>>> Mathieu Desnoyers
>>>>>>>> EfficiOS Inc.
>>>>>>>> http://www.efficios.com
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> Mathieu Desnoyers
>>>>>>> EfficiOS Inc.
>>>>>>> http://www.efficios.com
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> Mathieu Desnoyers
>>>>>>> EfficiOS Inc.
>>>>>>> http://www.efficios.com
>>>>>>>
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Mathieu Desnoyers
>>>>>> EfficiOS Inc.
>>>>>> http://www.efficios.com
>>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> Mathieu Desnoyers
>>>>> EfficiOS Inc.
>>>>> http://www.efficios.com
>>>>>
>>>>>
>>>>> --
>>>>> Mathieu Desnoyers
>>>>> EfficiOS Inc.
>>>>> http://www.efficios.com
>>>>>
>>>>>
>>>>> --
>>>>> Mathieu Desnoyers
>>>>> EfficiOS Inc.
>>>>> http://www.efficios.com
>>>>>
>>>>>
>>>>> --
>>>>> Mathieu Desnoyers
>>>>> EfficiOS Inc.
>>>>> http://www.efficios.com
>>>>>
>>>>
>>>>
>>>> --
>>>> Mathieu Desnoyers
>>>> EfficiOS Inc.
>>>> http://www.efficios.com
>>>>
>>>
>>>
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

--883d24f22e2855156c0568037514
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">It is v2.17 (for the problematic system) and 2.23 for the =
other<br></div><div class=3D"gmail_extra"><br clear=3D"all"><div><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><f=
ont color=3D"#888888">Shehab Y. Elsayed, MSc.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </font><font color=3D"#888888"><a value=
=3D"+20124498360"><span dir=3D"ltr"></span></a><br>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></font></div></=
div></div>
<br><div class=3D"gmail_quote">On Thu, Mar 22, 2018 at 1:00 PM, Mathieu Des=
noyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.c=
om" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-family:arial,helv=
etica,sans-serif;font-size:12pt;color:#000000"><span class=3D""><div><span =
id=3D"m_4739027940679637791zwchr">----- On Mar 22, 2018, at 12:24 PM, Sheha=
b Elsayed &lt;<a href=3D"mailto:shehabyomn@gmail.com" target=3D"_blank">she=
habyomn@gmail.com</a>&gt; wrote:<br></span></div></span><div><span class=3D=
""><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;paddi=
ng-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration=
:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"lt=
r">Actually, i am not sure if this would help. I have been trying to reprod=
uce the problem on a different machine, but I can&#39;t. Even without the p=
atches !!!!!</div></blockquote><div><br></div></span><div>Does it have the =
same glibc version ?<br></div><div><div class=3D"h5"><div><br></div><div>Th=
anks,<br></div><div><br></div><div>Mathieu<br></div><div><br></div><div><br=
></div><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;p=
adding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decora=
tion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=
=3D"ltr"><br></div><div class=3D"gmail_extra"><br clear=3D"all"><div><div c=
lass=3D"m_4739027940679637791gmail_signature"><div dir=3D"ltr"><span style=
=3D"color:#888888" color=3D"#888888">Shehab Y. Elsayed, MSc.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </span><span style=3D"color:#888888" co=
lor=3D"#888888"><br>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></span><br></di=
v></div></div><br><div class=3D"gmail_quote">On Wed, Mar 21, 2018 at 8:13 P=
M, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoy=
ers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.<wbr>com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"fon=
t-family:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><span><di=
v><span id=3D"m_4739027940679637791m_1287507653871511028zwchr">----- On Mar=
 21, 2018, at 8:01 PM, Shehab Elsayed &lt;<a href=3D"mailto:shehabyomn@gmai=
l.com" target=3D"_blank">shehabyomn@gmail.com</a>&gt; wrote:<br></span></di=
v></span><div><span><blockquote style=3D"border-left:2px solid #1010ff;marg=
in-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:norma=
l;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12p=
t"><div dir=3D"ltr"><div><div>Just to clarify more what I meant by custom e=
vents; I have new tracepoints added in the source code of the benchmark. Ho=
wever, I don&#39;t enable the corresponding events when I do the actual tra=
cing.<br><br></div>This is the sequence followed in building the benchmark:=
<br>gcc-7.2 -c -O2 -pthread -D_XOPEN_SOURCE=3D500 -D_POSIX_C_SOURCE=3D20011=
2 -std=3Dc11 -g -fno-strict-aliasing -DLTTNG_INST lu.c<br>gcc-7.2 -O2 -pthr=
ead -D_XOPEN_SOURCE=3D500 -D_POSIX_C_SOURCE=3D200112 -std=3Dc11 -g -fno-str=
ict-aliasing -DLTTNG_INST -o LU_NCB lu.o ../../instrumentation/lttng_<wbr>t=
p/tp.o -lm -llttng-ust -ldl<br><br></div>LTTNG_INST is just a preprocessor =
flag I have and tp.o is my custom tracepoints</div></blockquote></span><div=
>Could you share a repository with your custom instrumentation on github, s=
o I could<br></div><div>try it out ?<br></div><br><div>My current problem i=
s that I cannot reproduce your issue on my end.<br></div><div><div class=3D=
"m_4739027940679637791h5"><br><div>Thanks,<br></div><br><div>Mathieu<br></d=
iv><br><br><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5=
px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-de=
coration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div d=
ir=3D"ltr"><br></div><div class=3D"gmail_extra"><br clear=3D"all"><div><div=
 class=3D"m_4739027940679637791m_1287507653871511028gmail_signature"><div d=
ir=3D"ltr"><span style=3D"color:#888888">Shehab Y. Elsayed, MSc.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </span><span style=3D"color:#888888"><b=
r>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></span><br></di=
v></div></div><br><div class=3D"gmail_quote">On Wed, Mar 21, 2018 at 7:55 P=
M, Shehab Elsayed <span dir=3D"ltr">&lt;<a href=3D"mailto:shehabyomn@gmail.=
com" target=3D"_blank">shehabyomn@gmail.com</a>&gt;</span> wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex"><div dir=3D"ltr"><div>Still running into same prob=
lem. I attached the debug trace I got after applying the 2 patches.<br><br>=
</div><div>The benchmark I am running also includes some custom created tra=
cepoints. I am not adding the events being traced in the files I have provi=
ded. Do you think this might be causing a problem when I have tracpoints fr=
om 2 different packages?<br></div></div><div class=3D"gmail_extra"><span><b=
r clear=3D"all"><div><div class=3D"m_4739027940679637791m_12875076538715110=
28m_1944747827822555580gmail_signature"><div dir=3D"ltr"><span style=3D"col=
or:#888888">Shehab Y. Elsayed, MSc.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </span><span style=3D"color:#888888"><b=
r>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></span><br></di=
v></div></div>
<br></span><div><div class=3D"m_4739027940679637791m_1287507653871511028h5"=
><div class=3D"gmail_quote">On Wed, Mar 21, 2018 at 4:22 PM, Mathieu Desnoy=
ers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com"=
 target=3D"_blank">mathieu.desnoyers@efficios.<wbr>com</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-family:arial,he=
lvetica,sans-serif;font-size:12pt;color:#000000"><span><div><span id=3D"m_4=
739027940679637791m_1287507653871511028m_1944747827822555580m_-437554266640=
8511362zwchr">----- On Mar 21, 2018, at 1:55 PM, Shehab Elsayed &lt;<a href=
=3D"mailto:shehabyomn@gmail.com" target=3D"_blank">shehabyomn@gmail.com</a>=
&gt; wrote:<br></span></div></span><div><span><blockquote style=3D"border-l=
eft:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weig=
ht:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Aria=
l,sans-serif;font-size:12pt"><div dir=3D"ltr"><div><div><div><div><div><div=
>I am so sorry for the late replies.<br><br></div>I have tried the first pa=
tch you sent and the problem still happens (although seemingly less frequen=
tly especially with debugging enabled!!!!). I have attached the output I go=
t from one of the erroneous runs.<br><br></div>I will try the updated patch=
 and let you know how it goes.<br><br></div>Also, I am not sure if these po=
ints make any difference:<br></div>1- The error actually happens at the end=
 of the application. It actually finishes execution, but then something goe=
s wrong.<br></div>2- I run into this problem only for some of the benchmark=
s (or at least the problems happens much less frequently for others that I =
didn&#39;t run into it, not yet)<br><br></div>Thanks you very much, and sor=
ry again for the late replies.</div></blockquote><br></span><div>No worries=
! Looking through your log, I notice that pthread set cancel state has prob=
lems when<br></div><div>called from application threads. We do not restore =
the original thread&#39;s cancel state. Can you try</div><div>with the atta=
ched patch applied on top of the previous one ?<br></div><div><div class=3D=
"m_4739027940679637791m_1287507653871511028m_1944747827822555580h5"><br><di=
v>Thanks,<br></div><br><div>Mathieu<br></div><br><br><blockquote style=3D"b=
order-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;fo=
nt-weight:normal;font-style:normal;text-decoration:none;font-family:Helveti=
ca,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><br></div><div class=
=3D"gmail_extra"><br clear=3D"all"><div><div class=3D"m_4739027940679637791=
m_1287507653871511028m_1944747827822555580m_-4375542666408511362gmail_signa=
ture"><div dir=3D"ltr"><span style=3D"color:#888888">Shehab Y. Elsayed, MSc=
.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </span><span style=3D"color:#888888"><b=
r>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></span><br></di=
v></div></div><br><div class=3D"gmail_quote">On Wed, Mar 21, 2018 at 1:27 P=
M, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoy=
ers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.<wbr>com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"fon=
t-family:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><span><di=
v><span id=3D"m_4739027940679637791m_1287507653871511028m_19447478278225555=
80m_-4375542666408511362m_-8739052298097068210zwchr">----- On Mar 20, 2018,=
 at 5:42 PM, Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@effi=
cios.com" target=3D"_blank">mathieu.desnoyers@efficios.<wbr>com</a>&gt; wro=
te:<br></span></div></span><div><span><blockquote style=3D"border-left:2px =
solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:norma=
l;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-s=
erif;font-size:12pt"><div style=3D"font-family:arial,helvetica,sans-serif;f=
ont-size:12pt;color:#000000"><div><span id=3D"m_4739027940679637791m_128750=
7653871511028m_1944747827822555580m_-4375542666408511362m_-8739052298097068=
210zwchr">----- On Mar 20, 2018, at 4:58 PM, Mathieu Desnoyers &lt;<a href=
=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoy=
ers@efficios.<wbr>com</a>&gt; wrote:<br></span></div><div><blockquote style=
=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt"><div style=3D"font-family:arial,he=
lvetica,sans-serif;font-size:12pt;color:#000000"><div><span id=3D"m_4739027=
940679637791m_1287507653871511028m_1944747827822555580m_-437554266640851136=
2m_-8739052298097068210zwchr">----- On Mar 20, 2018, at 12:07 PM, Mathieu D=
esnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_b=
lank">mathieu.desnoyers@efficios.<wbr>com</a>&gt; wrote:<br></span></div><d=
iv><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;paddi=
ng-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration=
:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div style=3D"=
font-family:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><br><d=
iv><span id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555=
580m_-4375542666408511362m_-8739052298097068210zwchr">----- On Mar 19, 2018=
, at 4:21 PM, Shehab Elsayed &lt;<a href=3D"mailto:shehabyomn@gmail.com" ta=
rget=3D"_blank">shehabyomn@gmail.com</a>&gt; wrote:<br></span></div><div><b=
lockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-le=
ft:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none=
;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><d=
iv>I did &quot;echo &quot;-1&quot; &gt; <span class=3D"m_473902794067963779=
1m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-8739052=
298097068210gmail-m_5949702530543711213gmail-im">/proc/sys/kernel/perf_even=
t_<wbr>paranoid</span>&quot; and made sure the value was actually written b=
y &quot;cat /proc/sys/kernel/perf_event_<wbr>paranoid&quot;<br><br></div><d=
iv>It executed normally 2 times but then got the same error.</div></div></b=
lockquote><br><div>Can you provide the output when reproducing the issue wi=
th the<br></div><div>LTTNG_UST_DEBUG=3D1 environment variable set when star=
ting<br></div><div>your test program ?</div></div></div></blockquote><div>I=
 just noticed something that might explain what goes wrong here:<br></div><=
br><div>lttng-context-perf-counters.c: add_thread_field() grabs the ust_loc=
k(). Pthread mutex<br></div><div>in your case is instrumented with the pthr=
ead wrapper. This &quot;add_thread_field&quot; is invoked<br></div><div>the=
 first time the perf counter is hit by each given thread. When this happens=
, the<br></div><div>instrumented pthread mutex will try to call into the in=
strumentation tracepoint again,<br></div><div>which will call add_thread_fi=
eld() (again), and so on until we reach the libringbuffer<br></div><div>&qu=
ot;lib_ring_buffer_nesting&quot; threshold of 4 calls deep.<br></div><br><d=
iv>I suspect this situation where we recursively call add_thread_field is u=
nexpected,<br></div><div>which may trigger your double-free here.<br></div>=
<br><div>Will investigate more.</div></div></div></blockquote><div>Can you =
try with the attached patch applied ?</div></div></div></blockquote></span>=
<div>Here is an updated v2 of the patch which tests the notrace tls counter=
 sooner (before evaluating<br></div><div>filter). Please let me know how it=
 goes.<br></div><div><div class=3D"m_4739027940679637791m_12875076538715110=
28m_1944747827822555580m_-4375542666408511362h5"><br><div>Thanks,<br></div>=
<br><div>Mathieu<br></div><br><br><br><blockquote style=3D"border-left:2px =
solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:norma=
l;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-s=
erif;font-size:12pt"><div style=3D"font-family:arial,helvetica,sans-serif;f=
ont-size:12pt;color:#000000"><div><br><br><div>Thanks,<br></div><br><div>Ma=
thieu<br></div><br><br><br><blockquote style=3D"border-left:2px solid #1010=
ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-styl=
e:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-s=
ize:12pt"><div style=3D"font-family:arial,helvetica,sans-serif;font-size:12=
pt;color:#000000"><div><br><br><div>Thanks,<br></div><br><div>Mathieu<br></=
div><br><br><blockquote style=3D"border-left:2px solid #1010ff;margin-left:=
5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-d=
ecoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div =
style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:#00000=
0"><div><br><br><div>Thanks,<br></div><br><div>Mathieu<br></div><br><br><bl=
ockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-lef=
t:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;=
font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><br=
></div><div class=3D"gmail_extra"><br clear=3D"all"><div><div class=3D"m_47=
39027940679637791m_1287507653871511028m_1944747827822555580m_-4375542666408=
511362m_-8739052298097068210gmail_signature"><div dir=3D"ltr"><span style=
=3D"color:#888888">Shehab Y. Elsayed, MSc.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </span><span style=3D"color:#888888"><b=
r>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></span><br></di=
v></div></div><br><div class=3D"gmail_quote">On Mon, Mar 19, 2018 at 4:01 P=
M, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoy=
ers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.<wbr>com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"fon=
t-family:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><span><br=
><br><span id=3D"m_4739027940679637791m_1287507653871511028m_19447478278225=
55580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213zwchr=
">----- On Mar 19, 2018, at 3:53 PM, Shehab Elsayed &lt;<a href=3D"mailto:s=
hehabyomn@gmail.com" target=3D"_blank">shehabyomn@gmail.com</a>&gt; wrote:<=
br></span></span><div><span><blockquote style=3D"border-left:2px solid #101=
0ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-sty=
le:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-=
size:12pt"><div dir=3D"ltr"><div><div><span class=3D"m_4739027940679637791m=
_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-873905229=
8097068210m_5949702530543711213gmail-im">cat /proc/sys/kernel/perf_event_<w=
br>paranoid</span> ---&gt; returns 1<br><br></div>I run the program as a no=
rmal user<br><br></div>The glibc version I get by running &quot;ldd --versi=
on&quot; is 2.17</div></blockquote><br></span><div>Can you reproduce the is=
sue after you do this as root ?<br></div><br><div>echo &quot;-1&quot; &gt; =
<span class=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555=
580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213gmail-i=
m">/proc/sys/kernel/perf_event_<wbr>paranoid</span><br></div><br><div>Based=
 on this documentation of the Linux kernel:<br></div><br><div>Documentation=
/sysctl/kernel.<wbr>txt:<br></div><br><div>perf_event_paranoid:<br><br>Cont=
rols use of the performance events system by unprivileged<br>users (without=
 CAP_SYS_ADMIN).=C2=A0 The default value is 2.<br><br>=C2=A0-1: Allow use o=
f (almost) all events by all users<br>=C2=A0=C2=A0=C2=A0=C2=A0 Ignore mlock=
 limit after perf_event_mlock_kb without CAP_IPC_LOCK<br>&gt;=3D0: Disallow=
 ftrace function tracepoint by users without CAP_SYS_ADMIN<br>=C2=A0=C2=A0=
=C2=A0=C2=A0 Disallow raw tracepoint access by users without CAP_SYS_ADMIN<=
br>&gt;=3D1: Disallow CPU event access by users without CAP_SYS_ADMIN<br>&g=
t;=3D2: Disallow kernel profiling by users without CAP_SYS_ADMIN<br><br></d=
iv><div><div class=3D"m_4739027940679637791m_1287507653871511028m_194474782=
7822555580m_-4375542666408511362m_-8739052298097068210h5"><div>Thanks,<br><=
/div><br><div>Mathieu<br></div><br><blockquote style=3D"border-left:2px sol=
id #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;f=
ont-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-seri=
f;font-size:12pt"><div dir=3D"ltr"><br></div><div class=3D"gmail_extra"><br=
 clear=3D"all"><div><div class=3D"m_4739027940679637791m_128750765387151102=
8m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_5949702=
530543711213gmail_signature"><div dir=3D"ltr"><span style=3D"color:#888888"=
>Shehab Y. Elsayed, MSc.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </span><span style=3D"color:#888888"><b=
r>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></span><br></di=
v></div></div><br><div class=3D"gmail_quote">On Mon, Mar 19, 2018 at 3:31 P=
M, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoy=
ers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.<wbr>com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"fon=
t-family:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><span><di=
v><span id=3D"m_4739027940679637791m_1287507653871511028m_19447478278225555=
80m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_419173=
1141621744608zwchr">---- On Mar 19, 2018, at 3:26 PM, Mathieu Desnoyers &lt=
;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathie=
u.desnoyers@efficios.<wbr>com</a>&gt; wrote:<br></span></div></span><div><s=
pan><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;padd=
ing-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoratio=
n:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div style=3D=
"font-family:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><div>=
<span id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580=
m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_41917311=
41621744608zwchr">----- On Mar 19, 2018, at 2:26 PM, Shehab Elsayed &lt;<a =
href=3D"mailto:shehabyomn@gmail.com" target=3D"_blank">shehabyomn@gmail.com=
</a>&gt; wrote:<br></span></div><div><blockquote style=3D"border-left:2px s=
olid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal=
;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-se=
rif;font-size:12pt"><div dir=3D"ltr">Yes, I tried with only one of those co=
ntexts and I still ran into the same problem.</div></blockquote><div>What i=
s the setting returned by<br></div><br><div>cat /proc/sys/kernel/perf_event=
_<wbr>paranoid<br></div><br><div>on your system ? And do you run your test =
program as root or normal user ?<br></div><br><div>Please CC the mailing li=
st on your reply.</div></div></div></blockquote><br></span><div>I will also=
 need to know what glibc version you have on your system.<br></div><br><div=
>Thanks,<br></div><br><div>Mathieu<br></div><div><div class=3D"m_4739027940=
679637791m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_=
-8739052298097068210m_5949702530543711213h5"><br><br><blockquote style=3D"b=
order-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;fo=
nt-weight:normal;font-style:normal;text-decoration:none;font-family:Helveti=
ca,Arial,sans-serif;font-size:12pt"><div style=3D"font-family:arial,helveti=
ca,sans-serif;font-size:12pt;color:#000000"><div><br><br><div>Thanks,<br></=
div><br><div>Mathieu<br></div><br><blockquote style=3D"border-left:2px soli=
d #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;fo=
nt-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif=
;font-size:12pt"><div dir=3D"ltr"><br></div><div class=3D"gmail_extra"><br =
clear=3D"all"><div><div class=3D"m_4739027940679637791m_1287507653871511028=
m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_59497025=
30543711213m_4191731141621744608gmail_signature"><div dir=3D"ltr"><span sty=
le=3D"color:#888888">Shehab Y. Elsayed, MSc.<br>
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
v><span id=3D"m_4739027940679637791m_1287507653871511028m_19447478278225555=
80m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_419173=
1141621744608m_-2379611272366386122zwchr">----- On Mar 19, 2018, at 12:36 P=
M, Shehab Elsayed &lt;<a href=3D"mailto:shehabyomn@gmail.com" target=3D"_bl=
ank">shehabyomn@gmail.com</a>&gt; wrote:<br></span></div></span><div><span>=
<blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-=
left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:no=
ne;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr">=
<div><div><div><div><div><div><div>Hi Mathieu,<br><br>Thank you very much f=
or your reply.<br><br>I manually built lttng-ust from source (commit #: 8a2=
08943e21700211beee3ea64180a<wbr>5a534c7d2a).<br><br></div>This is how I set=
 up the tracing session:<br></div>1- lttng create lu_ncb_8_native -o {path}=
<br></div>2- lttng enable-event --userspace lttng_ust_pthread:pthread_<wbr>=
mutex_lock_req<br>=C2=A0=C2=A0=C2=A0 lttng enable-event --userspace lttng_u=
st_pthread:pthread_<wbr>mutex_lock_acq<br>=C2=A0=C2=A0=C2=A0 lttng enable-e=
vent --userspace lttng_ust_pthread:pthread_<wbr>mutex_lock_trylock<br>=C2=
=A0=C2=A0=C2=A0 lttng enable-event --userspace lttng_ust_pthread:pthread_<w=
br>mutex_lock_unlock<br></div>3- lttng add-context -u -t procname<br>=C2=A0=
=C2=A0=C2=A0 lttng add-context -u -t vpid<br>=C2=A0=C2=A0=C2=A0  lttng add-=
context -u -t pthread_id<br>=C2=A0=C2=A0=C2=A0  lttng add-context -u -t vti=
d<br>=C2=A0=C2=A0=C2=A0  lttng add-context -u -t ip<br>=C2=A0=C2=A0=C2=A0  =
lttng add-context -u -t perf:thread:cpu-cycles<br>=C2=A0=C2=A0=C2=A0  lttng=
 add-context -u -t perf:thread:cycles<br>=C2=A0=C2=A0=C2=A0  lttng add-cont=
ext -u -t perf:thread:instructions<br></div>4- lttng start<br>5- LD_PRELOAD=
=3D/usr/local/lib/<wbr>liblttng-ust-pthread-wrapper.<wbr>so ./lu_ncb -p8 -n=
8096 -b32<br></div>6- lttng stop<br></div>7- lttng destroy</div></blockquot=
e><br></span><div>Can you reproduce if you remove the following contexts ?<=
br></div><span><br><div>=C2=A0=C2=A0=C2=A0 lttng add-context -u -t perf:thr=
ead:cpu-cycles<br>=C2=A0=C2=A0=C2=A0 lttng add-context -u -t perf:thread:cy=
cles<br>=C2=A0=C2=A0=C2=A0 lttng add-context -u -t perf:thread:instructions=
</div><br></span><div>And if you only keep a single of those contexts ?<br>=
</div><br><div>Thanks,<br></div><br><div>Mathieu<br></div><div><div class=
=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-43755=
42666408511362m_-8739052298097068210m_5949702530543711213m_4191731141621744=
608h5"><br><br><blockquote style=3D"border-left:2px solid #1010ff;margin-le=
ft:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;tex=
t-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><d=
iv dir=3D"ltr"><br><br><br></div><div class=3D"gmail_extra"><br clear=3D"al=
l"><div><div class=3D"m_4739027940679637791m_1287507653871511028m_194474782=
7822555580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213=
m_4191731141621744608m_-2379611272366386122gmail_signature"><div dir=3D"ltr=
"><span style=3D"color:#888888">Shehab Y. Elsayed, MSc.<br>
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
r><br><div><span id=3D"m_4739027940679637791m_1287507653871511028m_19447478=
27822555580m_-4375542666408511362m_-8739052298097068210m_594970253054371121=
3m_4191731141621744608m_-2379611272366386122m_-3928334406880738982zwchr">--=
--- On Mar 16, 2018, at 5:37 PM, Shehab Elsayed &lt;<a href=3D"mailto:sheha=
byomn@gmail.com" target=3D"_blank">shehabyomn@gmail.com</a>&gt; wrote:<br><=
/span></div></span><div><span><blockquote style=3D"border-left:2px solid #1=
010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-s=
tyle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;fon=
t-size:12pt"><div dir=3D"ltr"><div><div><div><div><div><div><div><div><div>=
<div>Hello All,<br><br></div>I am trying to instrument a <span id=3D"m_4739=
027940679637791m_1287507653871511028m_1944747827822555580m_-437554266640851=
1362m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2379=
611272366386122m_-3928334406880738982:3qh.1">pthread</span> application usi=
ng the provided <span id=3D"m_4739027940679637791m_1287507653871511028m_194=
4747827822555580m_-4375542666408511362m_-8739052298097068210m_5949702530543=
711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh=
.2">pthread</span> wrapper, but I sometimes run into a &quot;Double free or=
 corruption error (<span id=3D"m_4739027940679637791m_1287507653871511028m_=
1944747827822555580m_-4375542666408511362m_-8739052298097068210m_5949702530=
543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:=
3qh.3">fasttop</span>)&quot; error. </div></div></div></div></div></div></d=
iv></div></div></div></blockquote><br></span><div>Please provide more infor=
mation about the version of lttng-ust you are using, and how you setup<br><=
/div><div>your tracing session.<br></div><br><div>Thanks,<br></div><br><div=
>Mathieu<br></div><br><blockquote style=3D"border-left:2px solid #1010ff;ma=
rgin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:nor=
mal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:1=
2pt"><div><div class=3D"m_4739027940679637791m_1287507653871511028m_1944747=
827822555580m_-4375542666408511362m_-8739052298097068210m_59497025305437112=
13m_4191731141621744608m_-2379611272366386122h5"><div dir=3D"ltr"><div><div=
><div><div><div><div><div><div><div><br><br></div>Here is a description of =
what I have tried and noticed:<br></div>1- The problem isn&#39;t consistent=
. It sometimes happen and sometimes works as expected.<br></div>2- From my =
experiments, the problem happens (more frequently at least) when adding per=
formance counter contexts (I tried cycles, <span id=3D"m_473902794067963779=
1m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-8739052=
298097068210m_5949702530543711213m_4191731141621744608m_-237961127236638612=
2m_-3928334406880738982:3qh.4">cpu</span>_cycles and instructions).<br></di=
v>3- I am testing using <span id=3D"m_4739027940679637791m_1287507653871511=
028m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_59497=
02530543711213m_4191731141621744608m_-2379611272366386122m_-392833440688073=
8982:3qh.5">lu</span>_<span id=3D"m_4739027940679637791m_128750765387151102=
8m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_5949702=
530543711213m_4191731141621744608m_-2379611272366386122m_-39283344068807389=
82:3qh.6">ncb</span> from splash3 benchmark suite after setting <span id=3D=
"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-43755426=
66408511362m_-8739052298097068210m_5949702530543711213m_4191731141621744608=
m_-2379611272366386122m_-3928334406880738982:3qh.7">LD</span>_<span id=3D"m=
_4739027940679637791m_1287507653871511028m_1944747827822555580m_-4375542666=
408511362m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_=
-2379611272366386122m_-3928334406880738982:3qh.8">PRELOAD</span> to use the=
 <span id=3D"m_4739027940679637791m_1287507653871511028m_194474782782255558=
0m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_4191731=
141621744608m_-2379611272366386122m_-3928334406880738982:3qh.9">pthread</sp=
an> wrapper as described in the <span id=3D"m_4739027940679637791m_12875076=
53871511028m_1944747827822555580m_-4375542666408511362m_-873905229809706821=
0m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928334=
406880738982:3qh.10">LTTng</span> documents.<br></div>4- Here is the <span =
id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-437=
5542666408511362m_-8739052298097068210m_5949702530543711213m_41917311416217=
44608m_-2379611272366386122m_-3928334406880738982:3qh.11">backtrace</span> =
printed after exiting:<br>=3D=3D=3D=3D=3D=3D=3D <span id=3D"m_4739027940679=
637791m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-87=
39052298097068210m_5949702530543711213m_4191731141621744608m_-2379611272366=
386122m_-3928334406880738982:3qh.12">Backtrace</span>: =3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>/lib64/<span id=3D"m_4739027940679637791m_1287507653871511028m=
_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_594970253=
0543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982=
:3qh.13">libc</span>.so.6([Thread 0x7ffff5611700 (<span id=3D"m_47390279406=
79637791m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-=
8739052298097068210m_5949702530543711213m_4191731141621744608m_-23796112723=
66386122m_-3928334406880738982:3qh.14">LWP</span> 97229) exited]<br>/<span =
id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-437=
5542666408511362m_-8739052298097068210m_5949702530543711213m_41917311416217=
44608m_-2379611272366386122m_-3928334406880738982:3qh.15">usr</span>/local/=
lib/<span id=3D"m_4739027940679637791m_1287507653871511028m_194474782782255=
5580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_4191=
731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.16">liblttn=
g</span>-<span id=3D"m_4739027940679637791m_1287507653871511028m_1944747827=
822555580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m=
_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.17">us=
t</span>.<wbr>so.0(<span id=3D"m_4739027940679637791m_1287507653871511028m_=
1944747827822555580m_-4375542666408511362m_-8739052298097068210m_5949702530=
543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:=
3qh.18">lttng</span>_destroy_context+<wbr>0x35)[0x7ffff7471575]<br>/<span i=
d=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-4375=
542666408511362m_-8739052298097068210m_5949702530543711213m_419173114162174=
4608m_-2379611272366386122m_-3928334406880738982:3qh.19">usr</span>/local/l=
ib/<span id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555=
580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_41917=
31141621744608m_-2379611272366386122m_-3928334406880738982:3qh.20">liblttng=
</span>-<span id=3D"m_4739027940679637791m_1287507653871511028m_19447478278=
22555580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_=
4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.21">ust=
</span>.<wbr>so.0(<span id=3D"m_4739027940679637791m_1287507653871511028m_1=
944747827822555580m_-4375542666408511362m_-8739052298097068210m_59497025305=
43711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3=
qh.22">lttng</span>_session_destroy+<wbr>0x21c)[0x7ffff747363c]<br>/<span i=
d=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-4375=
542666408511362m_-8739052298097068210m_5949702530543711213m_419173114162174=
4608m_-2379611272366386122m_-3928334406880738982:3qh.23">usr</span>/local/l=
ib/<span id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555=
580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_41917=
31141621744608m_-2379611272366386122m_-3928334406880738982:3qh.24">liblttng=
</span>-<span id=3D"m_4739027940679637791m_1287507653871511028m_19447478278=
22555580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_=
4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.25">ust=
</span>.<wbr>so.0(+0x1e906)[0x7ffff746d906]<br>/<span id=3D"m_4739027940679=
637791m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-87=
39052298097068210m_5949702530543711213m_4191731141621744608m_-2379611272366=
386122m_-3928334406880738982:3qh.26">usr</span>/local/lib/<span id=3D"m_473=
9027940679637791m_1287507653871511028m_1944747827822555580m_-43755426664085=
11362m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-237=
9611272366386122m_-3928334406880738982:3qh.27">liblttng</span>-<span id=3D"=
m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-437554266=
6408511362m_-8739052298097068210m_5949702530543711213m_4191731141621744608m=
_-2379611272366386122m_-3928334406880738982:3qh.28">ust</span>.<wbr>so.0(<s=
pan id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_=
-4375542666408511362m_-8739052298097068210m_5949702530543711213m_4191731141=
621744608m_-2379611272366386122m_-3928334406880738982:3qh.29">lttng</span>_=
<span id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580=
m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_41917311=
41621744608m_-2379611272366386122m_-3928334406880738982:3qh.30">ust</span>_=
<span id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580=
m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_41917311=
41621744608m_-2379611272366386122m_-3928334406880738982:3qh.31">objd</span>=
_<span id=3D"m_4739027940679637791m_1287507653871511028m_194474782782255558=
0m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_4191731=
141621744608m_-2379611272366386122m_-3928334406880738982:3qh.32">unref</spa=
n>+<wbr>0x9f)[0x7ffff746dccf]<br>/<span id=3D"m_4739027940679637791m_128750=
7653871511028m_1944747827822555580m_-4375542666408511362m_-8739052298097068=
210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-39283=
34406880738982:3qh.33">usr</span>/local/lib/<span id=3D"m_47390279406796377=
91m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-873905=
2298097068210m_5949702530543711213m_4191731141621744608m_-23796112723663861=
22m_-3928334406880738982:3qh.34">liblttng</span>-<span id=3D"m_473902794067=
9637791m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-8=
739052298097068210m_5949702530543711213m_4191731141621744608m_-237961127236=
6386122m_-3928334406880738982:3qh.35">ust</span>.<wbr>so.0(<span id=3D"m_47=
39027940679637791m_1287507653871511028m_1944747827822555580m_-4375542666408=
511362m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-23=
79611272366386122m_-3928334406880738982:3qh.36">lttng</span>_<span id=3D"m_=
4739027940679637791m_1287507653871511028m_1944747827822555580m_-43755426664=
08511362m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-=
2379611272366386122m_-3928334406880738982:3qh.37">ust</span>_<span id=3D"m_=
4739027940679637791m_1287507653871511028m_1944747827822555580m_-43755426664=
08511362m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-=
2379611272366386122m_-3928334406880738982:3qh.38">objd</span>_<span id=3D"m=
_4739027940679637791m_1287507653871511028m_1944747827822555580m_-4375542666=
408511362m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_=
-2379611272366386122m_-3928334406880738982:3qh.39">unref</span>+<wbr>0x9f)[=
0x7ffff746dccf]<br>/<span id=3D"m_4739027940679637791m_1287507653871511028m=
_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_594970253=
0543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982=
:3qh.40">usr</span>/local/lib/<span id=3D"m_4739027940679637791m_1287507653=
871511028m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m=
_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-392833440=
6880738982:3qh.41">liblttng</span>-<span id=3D"m_4739027940679637791m_12875=
07653871511028m_1944747827822555580m_-4375542666408511362m_-873905229809706=
8210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928=
334406880738982:3qh.42">ust</span>.<wbr>so.0(<span id=3D"m_4739027940679637=
791m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-87390=
52298097068210m_5949702530543711213m_4191731141621744608m_-2379611272366386=
122m_-3928334406880738982:3qh.43">lttng</span>_<span id=3D"m_47390279406796=
37791m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-873=
9052298097068210m_5949702530543711213m_4191731141621744608m_-23796112723663=
86122m_-3928334406880738982:3qh.44">ust</span>_<span id=3D"m_47390279406796=
37791m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-873=
9052298097068210m_5949702530543711213m_4191731141621744608m_-23796112723663=
86122m_-3928334406880738982:3qh.45">objd</span>_<span id=3D"m_4739027940679=
637791m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-87=
39052298097068210m_5949702530543711213m_4191731141621744608m_-2379611272366=
386122m_-3928334406880738982:3qh.46">unref</span>+<wbr>0x9f)[0x7ffff746dccf=
]<br>/<span id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822=
555580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_41=
91731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.47">usr</=
span>/local/lib/<span id=3D"m_4739027940679637791m_1287507653871511028m_194=
4747827822555580m_-4375542666408511362m_-8739052298097068210m_5949702530543=
711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh=
.48">liblttng</span>-<span id=3D"m_4739027940679637791m_1287507653871511028=
m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_59497025=
30543711213m_4191731141621744608m_-2379611272366386122m_-392833440688073898=
2:3qh.49">ust</span>.<wbr>so.0(<span id=3D"m_4739027940679637791m_128750765=
3871511028m_1944747827822555580m_-4375542666408511362m_-8739052298097068210=
m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344=
06880738982:3qh.50">lttng</span>_<span id=3D"m_4739027940679637791m_1287507=
653871511028m_1944747827822555580m_-4375542666408511362m_-87390522980970682=
10m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-392833=
4406880738982:3qh.51">ust</span>_<span id=3D"m_4739027940679637791m_1287507=
653871511028m_1944747827822555580m_-4375542666408511362m_-87390522980970682=
10m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-392833=
4406880738982:3qh.52">abi</span>_exit+0x68)[<wbr>0x7ffff746ead8]<br>/<span =
id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-437=
5542666408511362m_-8739052298097068210m_5949702530543711213m_41917311416217=
44608m_-2379611272366386122m_-3928334406880738982:3qh.53">usr</span>/local/=
lib/<span id=3D"m_4739027940679637791m_1287507653871511028m_194474782782255=
5580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_4191=
731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.54">liblttn=
g</span>-<span id=3D"m_4739027940679637791m_1287507653871511028m_1944747827=
822555580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m=
_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.55">us=
t</span>.<wbr>so.0(+0x191d3)[0x7ffff74681d3]<br>/<span id=3D"m_473902794067=
9637791m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-8=
739052298097068210m_5949702530543711213m_4191731141621744608m_-237961127236=
6386122m_-3928334406880738982:3qh.56">usr</span>/local/lib/<span id=3D"m_47=
39027940679637791m_1287507653871511028m_1944747827822555580m_-4375542666408=
511362m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-23=
79611272366386122m_-3928334406880738982:3qh.57">liblttng</span>-<span id=3D=
"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-43755426=
66408511362m_-8739052298097068210m_5949702530543711213m_4191731141621744608=
m_-2379611272366386122m_-3928334406880738982:3qh.58">ust</span>.<wbr>so.0(<=
span id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m=
_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_419173114=
1621744608m_-2379611272366386122m_-3928334406880738982:3qh.59">lttng</span>=
_<span id=3D"m_4739027940679637791m_1287507653871511028m_194474782782255558=
0m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_4191731=
141621744608m_-2379611272366386122m_-3928334406880738982:3qh.60">ust</span>=
_exit+0x67)[<wbr>0x7ffff745ed57]<br>/lib64/<span id=3D"m_473902794067963779=
1m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-8739052=
298097068210m_5949702530543711213m_4191731141621744608m_-237961127236638612=
2m_-3928334406880738982:3qh.61">ld</span>-<span id=3D"m_4739027940679637791=
m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-87390522=
98097068210m_5949702530543711213m_4191731141621744608m_-2379611272366386122=
m_-3928334406880738982:3qh.62">linux</span>-x86-64.so.2(+<wbr>0xf85a)[0x7ff=
ff7dec85a]<br>/lib64/<span id=3D"m_4739027940679637791m_1287507653871511028=
m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_59497025=
30543711213m_4191731141621744608m_-2379611272366386122m_-392833440688073898=
2:3qh.63">libc</span>.so.6(+0x38a49)[<wbr>0x7ffff6ca6a49]<br>/lib64/<span i=
d=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-4375=
542666408511362m_-8739052298097068210m_5949702530543711213m_419173114162174=
4608m_-2379611272366386122m_-3928334406880738982:3qh.64">libc</span>.so.6(+=
0x38a95)[<wbr>0x7ffff6ca6a95]<br>/<span id=3D"m_4739027940679637791m_128750=
7653871511028m_1944747827822555580m_-4375542666408511362m_-8739052298097068=
210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-39283=
34406880738982:3qh.65">aenao</span>-99/elsayed9/<span id=3D"m_4739027940679=
637791m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-87=
39052298097068210m_5949702530543711213m_4191731141621744608m_-2379611272366=
386122m_-3928334406880738982:3qh.66">LTTng</span>/data/<wbr>scripts/<span i=
d=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-4375=
542666408511362m_-8739052298097068210m_5949702530543711213m_419173114162174=
4608m_-2379611272366386122m_-3928334406880738982:3qh.67">tmp</span>/<span i=
d=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-4375=
542666408511362m_-8739052298097068210m_5949702530543711213m_419173114162174=
4608m_-2379611272366386122m_-3928334406880738982:3qh.68">lu</span>_<span id=
=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-43755=
42666408511362m_-8739052298097068210m_5949702530543711213m_4191731141621744=
608m_-2379611272366386122m_-3928334406880738982:3qh.69">ncb</span>[0x401b51=
]<br>/lib64/<span id=3D"m_4739027940679637791m_1287507653871511028m_1944747=
827822555580m_-4375542666408511362m_-8739052298097068210m_59497025305437112=
13m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.70"=
>libc</span>.so.6(__<span id=3D"m_4739027940679637791m_1287507653871511028m=
_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_594970253=
0543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982=
:3qh.71">libc</span>_start_<wbr>main+0xf5)[0x7ffff6c8fb35]<br>/<span id=3D"=
m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-437554266=
6408511362m_-8739052298097068210m_5949702530543711213m_4191731141621744608m=
_-2379611272366386122m_-3928334406880738982:3qh.72">aenao</span>-99/elsayed=
9/<span id=3D"m_4739027940679637791m_1287507653871511028m_19447478278225555=
80m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_419173=
1141621744608m_-2379611272366386122m_-3928334406880738982:3qh.73">LTTng</sp=
an>/data/<wbr>scripts/<span id=3D"m_4739027940679637791m_128750765387151102=
8m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_5949702=
530543711213m_4191731141621744608m_-2379611272366386122m_-39283344068807389=
82:3qh.74">tmp</span>/<span id=3D"m_4739027940679637791m_128750765387151102=
8m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_5949702=
530543711213m_4191731141621744608m_-2379611272366386122m_-39283344068807389=
82:3qh.75">lu</span>_<span id=3D"m_4739027940679637791m_1287507653871511028=
m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_59497025=
30543711213m_4191731141621744608m_-2379611272366386122m_-392833440688073898=
2:3qh.76">ncb</span>[0x401c44]<br></div>5- Also, this is a <span id=3D"m_47=
39027940679637791m_1287507653871511028m_1944747827822555580m_-4375542666408=
511362m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-23=
79611272366386122m_-3928334406880738982:3qh.77">backtrace</span> I obtained=
 from <span id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822=
555580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_41=
91731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.78">gdb</=
span>:<br>#0=C2=A0 0x00007ffff6eac1d7 in raise () from /lib64/<span id=3D"m=
_4739027940679637791m_1287507653871511028m_1944747827822555580m_-4375542666=
408511362m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_=
-2379611272366386122m_-3928334406880738982:3qh.79">libc</span>.so.6<br>#1=
=C2=A0 0x00007ffff6ead8c8 in abort () from /lib64/<span id=3D"m_47390279406=
79637791m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-=
8739052298097068210m_5949702530543711213m_4191731141621744608m_-23796112723=
66386122m_-3928334406880738982:3qh.80">libc</span>.so.6<br>#2=C2=A0 0x00007=
ffff6eebf07 in __<span id=3D"m_4739027940679637791m_1287507653871511028m_19=
44747827822555580m_-4375542666408511362m_-8739052298097068210m_594970253054=
3711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3q=
h.81">libc</span>_message () from /lib64/<span id=3D"m_4739027940679637791m=
_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-873905229=
8097068210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m=
_-3928334406880738982:3qh.82">libc</span>.so.6<br>#3=C2=A0 0x00007ffff6ef35=
03 in _int_free () from /lib64/<span id=3D"m_4739027940679637791m_128750765=
3871511028m_1944747827822555580m_-4375542666408511362m_-8739052298097068210=
m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344=
06880738982:3qh.83">libc</span>.so.6<br>#4=C2=A0 0x00007ffff768ad25 in <spa=
n id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-4=
375542666408511362m_-8739052298097068210m_5949702530543711213m_419173114162=
1744608m_-2379611272366386122m_-3928334406880738982:3qh.84">lttng</span>_de=
stroy_<span id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822=
555580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_41=
91731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.85">perf<=
/span>_counter_<wbr>field (<br>=C2=A0=C2=A0=C2=A0 field=3D&lt;optimized out=
&gt;) at <span id=3D"m_4739027940679637791m_1287507653871511028m_1944747827=
822555580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m=
_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.86">lt=
tng</span>-context-<span id=3D"m_4739027940679637791m_1287507653871511028m_=
1944747827822555580m_-4375542666408511362m_-8739052298097068210m_5949702530=
543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:=
3qh.87">perf</span>-counters.c:<wbr>418<br>#5=C2=A0 0x00007ffff767a575 in <=
span id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m=
_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_419173114=
1621744608m_-2379611272366386122m_-3928334406880738982:3qh.88">lttng</span>=
_destroy_context (<br><span id=3D"m_4739027940679637791m_128750765387151102=
8m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_5949702=
530543711213m_4191731141621744608m_-2379611272366386122m_-39283344068807389=
82:3qh.89">ctx</span>=3D0x7ffff0011090) at <span id=3D"m_473902794067963779=
1m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-8739052=
298097068210m_5949702530543711213m_4191731141621744608m_-237961127236638612=
2m_-3928334406880738982:3qh.90">lttng</span>-context.c:278<br>#6=C2=A0 0x00=
007ffff767c63c in _<span id=3D"m_4739027940679637791m_1287507653871511028m_=
1944747827822555580m_-4375542666408511362m_-8739052298097068210m_5949702530=
543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:=
3qh.91">lttng</span>_channel_<span id=3D"m_4739027940679637791m_12875076538=
71511028m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_=
5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3928334406=
880738982:3qh.92">unmap</span> (<br><span id=3D"m_4739027940679637791m_1287=
507653871511028m_1944747827822555580m_-4375542666408511362m_-87390522980970=
68210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-392=
8334406880738982:3qh.93">lttng</span>_<span id=3D"m_4739027940679637791m_12=
87507653871511028m_1944747827822555580m_-4375542666408511362m_-873905229809=
7068210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-3=
928334406880738982:3qh.94">chan</span>=3D0x7ffff0010f40) at <span id=3D"m_4=
739027940679637791m_1287507653871511028m_1944747827822555580m_-437554266640=
8511362m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2=
379611272366386122m_-3928334406880738982:3qh.95">lttng</span>-events.c:172<=
br>#7=C2=A0 <span id=3D"m_4739027940679637791m_1287507653871511028m_1944747=
827822555580m_-4375542666408511362m_-8739052298097068210m_59497025305437112=
13m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.96"=
>lttng</span>_session_destroy (session=3D0x7ffff0000900)<br>=C2=A0=C2=A0=C2=
=A0 at <span id=3D"m_4739027940679637791m_1287507653871511028m_194474782782=
2555580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_4=
191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.97">lttn=
g</span>-events.c:247<br>#8=C2=A0 0x00007ffff7676906 in <span id=3D"m_47390=
27940679637791m_1287507653871511028m_1944747827822555580m_-4375542666408511=
362m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-23796=
11272366386122m_-3928334406880738982:3qh.98">lttng</span>_release_session (=
<br><span id=3D"m_4739027940679637791m_1287507653871511028m_194474782782255=
5580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_4191=
731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.99">objd</s=
pan>=3D&lt;optimized out&gt;) at <span id=3D"m_4739027940679637791m_1287507=
653871511028m_1944747827822555580m_-4375542666408511362m_-87390522980970682=
10m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-392833=
4406880738982:3qh.100">lttng</span>-<span id=3D"m_4739027940679637791m_1287=
507653871511028m_1944747827822555580m_-4375542666408511362m_-87390522980970=
68210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-392=
8334406880738982:3qh.101">ust</span>-<span id=3D"m_4739027940679637791m_128=
7507653871511028m_1944747827822555580m_-4375542666408511362m_-8739052298097=
068210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-39=
28334406880738982:3qh.102">abi</span>.c:601<br>#9=C2=A0 0x00007ffff7676ccf =
in <span id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555=
580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_41917=
31141621744608m_-2379611272366386122m_-3928334406880738982:3qh.103">lttng</=
span>_<span id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822=
555580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_41=
91731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.104">ust<=
/span>_<span id=3D"m_4739027940679637791m_1287507653871511028m_194474782782=
2555580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_4=
191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.105">obj=
d</span>_<span id=3D"m_4739027940679637791m_1287507653871511028m_1944747827=
822555580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m=
_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.106">u=
nref</span> (id=3D1, <br>=C2=A0=C2=A0=C2=A0 is_owner=3D&lt;optimized out&gt=
;) at <span id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822=
555580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_41=
91731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.107">lttn=
g</span>-<span id=3D"m_4739027940679637791m_1287507653871511028m_1944747827=
822555580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m=
_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.108">u=
st</span>-<span id=3D"m_4739027940679637791m_1287507653871511028m_194474782=
7822555580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213=
m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.109">=
abi</span>.c:216<br>#10 0x00007ffff7676ccf in <span id=3D"m_473902794067963=
7791m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-8739=
052298097068210m_5949702530543711213m_4191731141621744608m_-237961127236638=
6122m_-3928334406880738982:3qh.110">lttng</span>_<span id=3D"m_473902794067=
9637791m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-8=
739052298097068210m_5949702530543711213m_4191731141621744608m_-237961127236=
6386122m_-3928334406880738982:3qh.111">ust</span>_<span id=3D"m_47390279406=
79637791m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-=
8739052298097068210m_5949702530543711213m_4191731141621744608m_-23796112723=
66386122m_-3928334406880738982:3qh.112">objd</span>_<span id=3D"m_473902794=
0679637791m_1287507653871511028m_1944747827822555580m_-4375542666408511362m=
_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-237961127=
2366386122m_-3928334406880738982:3qh.113">unref</span> (id=3D2, <br>=C2=A0=
=C2=A0=C2=A0 is_owner=3D&lt;optimized out&gt;) at <span id=3D"m_47390279406=
79637791m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-=
8739052298097068210m_5949702530543711213m_4191731141621744608m_-23796112723=
66386122m_-3928334406880738982:3qh.114">lttng</span>-<span id=3D"m_47390279=
40679637791m_1287507653871511028m_1944747827822555580m_-4375542666408511362=
m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-23796112=
72366386122m_-3928334406880738982:3qh.115">ust</span>-<span id=3D"m_4739027=
940679637791m_1287507653871511028m_1944747827822555580m_-437554266640851136=
2m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2379611=
272366386122m_-3928334406880738982:3qh.116">abi</span>.c:216<br>#11 0x00007=
ffff7676ccf in <span id=3D"m_4739027940679637791m_1287507653871511028m_1944=
747827822555580m_-4375542666408511362m_-8739052298097068210m_59497025305437=
11213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.=
117">lttng</span>_<span id=3D"m_4739027940679637791m_1287507653871511028m_1=
944747827822555580m_-4375542666408511362m_-8739052298097068210m_59497025305=
43711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3=
qh.118">ust</span>_<span id=3D"m_4739027940679637791m_1287507653871511028m_=
1944747827822555580m_-4375542666408511362m_-8739052298097068210m_5949702530=
543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:=
3qh.119">objd</span>_<span id=3D"m_4739027940679637791m_1287507653871511028=
m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_59497025=
30543711213m_4191731141621744608m_-2379611272366386122m_-392833440688073898=
2:3qh.120">unref</span> (id=3Did@entry=3D18, <br>=C2=A0=C2=A0=C2=A0 is_owne=
r=3Dis_owner@entry=3D1) at <span id=3D"m_4739027940679637791m_1287507653871=
511028m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_59=
49702530543711213m_4191731141621744608m_-2379611272366386122m_-392833440688=
0738982:3qh.121">lttng</span>-<span id=3D"m_4739027940679637791m_1287507653=
871511028m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m=
_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-392833440=
6880738982:3qh.122">ust</span>-<span id=3D"m_4739027940679637791m_128750765=
3871511028m_1944747827822555580m_-4375542666408511362m_-8739052298097068210=
m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344=
06880738982:3qh.123">abi</span>.c:216<br>#12 0x00007ffff7677ad8 in <span id=
=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-43755=
42666408511362m_-8739052298097068210m_5949702530543711213m_4191731141621744=
608m_-2379611272366386122m_-3928334406880738982:3qh.124">objd</span>_table_=
destroy ()<br>=C2=A0=C2=A0=C2=A0 at <span id=3D"m_4739027940679637791m_1287=
507653871511028m_1944747827822555580m_-4375542666408511362m_-87390522980970=
68210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-392=
8334406880738982:3qh.125">lttng</span>-<span id=3D"m_4739027940679637791m_1=
287507653871511028m_1944747827822555580m_-4375542666408511362m_-87390522980=
97068210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-=
3928334406880738982:3qh.126">ust</span>-<span id=3D"m_4739027940679637791m_=
1287507653871511028m_1944747827822555580m_-4375542666408511362m_-8739052298=
097068210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_=
-3928334406880738982:3qh.127">abi</span>.c:235<br>#13 <span id=3D"m_4739027=
940679637791m_1287507653871511028m_1944747827822555580m_-437554266640851136=
2m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2379611=
272366386122m_-3928334406880738982:3qh.128">lttng</span>_<span id=3D"m_4739=
027940679637791m_1287507653871511028m_1944747827822555580m_-437554266640851=
1362m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-2379=
611272366386122m_-3928334406880738982:3qh.129">ust</span>_<span id=3D"m_473=
9027940679637791m_1287507653871511028m_1944747827822555580m_-43755426664085=
11362m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-237=
9611272366386122m_-3928334406880738982:3qh.130">abi</span>_exit () at <span=
 id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-43=
75542666408511362m_-8739052298097068210m_5949702530543711213m_4191731141621=
744608m_-2379611272366386122m_-3928334406880738982:3qh.131">lttng</span>-<s=
pan id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_=
-4375542666408511362m_-8739052298097068210m_5949702530543711213m_4191731141=
621744608m_-2379611272366386122m_-3928334406880738982:3qh.132">ust</span>-<=
span id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m=
_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_419173114=
1621744608m_-2379611272366386122m_-3928334406880738982:3qh.133">abi</span>.=
c:1002<br>#14 0x00007ffff76711d3 in <span id=3D"m_4739027940679637791m_1287=
507653871511028m_1944747827822555580m_-4375542666408511362m_-87390522980970=
68210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-392=
8334406880738982:3qh.134">lttng</span>_<span id=3D"m_4739027940679637791m_1=
287507653871511028m_1944747827822555580m_-4375542666408511362m_-87390522980=
97068210m_5949702530543711213m_4191731141621744608m_-2379611272366386122m_-=
3928334406880738982:3qh.135">ust</span>_cleanup (exiting=3D1)<br>=C2=A0=C2=
=A0=C2=A0 at <span id=3D"m_4739027940679637791m_1287507653871511028m_194474=
7827822555580m_-4375542666408511362m_-8739052298097068210m_5949702530543711=
213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh.13=
6">lttng</span>-<span id=3D"m_4739027940679637791m_1287507653871511028m_194=
4747827822555580m_-4375542666408511362m_-8739052298097068210m_5949702530543=
711213m_4191731141621744608m_-2379611272366386122m_-3928334406880738982:3qh=
.137">ust</span>-comm.c:1807<br>#15 0x00007ffff7667d57 in <span id=3D"m_473=
9027940679637791m_1287507653871511028m_1944747827822555580m_-43755426664085=
11362m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-237=
9611272366386122m_-3928334406880738982:3qh.138">lttng</span>_<span id=3D"m_=
4739027940679637791m_1287507653871511028m_1944747827822555580m_-43755426664=
08511362m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-=
2379611272366386122m_-3928334406880738982:3qh.139">ust</span>_exit ()<br>=
=C2=A0=C2=A0=C2=A0 at <span id=3D"m_4739027940679637791m_128750765387151102=
8m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_5949702=
530543711213m_4191731141621744608m_-2379611272366386122m_-39283344068807389=
82:3qh.140">lttng</span>-<span id=3D"m_4739027940679637791m_128750765387151=
1028m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_5949=
702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344068807=
38982:3qh.141">ust</span>-comm.c:1874<br>#16 0x00007ffff7dec85a in _<span i=
d=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-4375=
542666408511362m_-8739052298097068210m_5949702530543711213m_419173114162174=
4608m_-2379611272366386122m_-3928334406880738982:3qh.142">dl</span>_<span i=
d=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-4375=
542666408511362m_-8739052298097068210m_5949702530543711213m_419173114162174=
4608m_-2379611272366386122m_-3928334406880738982:3qh.143">fini</span> ()<br=
>=C2=A0=C2=A0 from /lib64/<span id=3D"m_4739027940679637791m_12875076538715=
11028m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_594=
9702530543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880=
738982:3qh.144">ld</span>-<span id=3D"m_4739027940679637791m_12875076538715=
11028m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_594=
9702530543711213m_4191731141621744608m_-2379611272366386122m_-3928334406880=
738982:3qh.145">linux</span>-x86-64.so.2<br>#17 0x00007ffff6eafa49 in __run=
_exit_handlers ()<br>=C2=A0=C2=A0 from /lib64/<span id=3D"m_473902794067963=
7791m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-8739=
052298097068210m_5949702530543711213m_4191731141621744608m_-237961127236638=
6122m_-3928334406880738982:3qh.146">libc</span>.so.6<br>#18 0x00007ffff6eaf=
a95 in exit () from /lib64/<span id=3D"m_4739027940679637791m_1287507653871=
511028m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_59=
49702530543711213m_4191731141621744608m_-2379611272366386122m_-392833440688=
0738982:3qh.147">libc</span>.so.6<br>#19 0x0000000000401b51 in main (<span =
id=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-437=
5542666408511362m_-8739052298097068210m_5949702530543711213m_41917311416217=
44608m_-2379611272366386122m_-3928334406880738982:3qh.148">argc</span>=3D&l=
t;optimized out&gt;, <br><span id=3D"m_4739027940679637791m_128750765387151=
1028m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_5949=
702530543711213m_4191731141621744608m_-2379611272366386122m_-39283344068807=
38982:3qh.149">argv</span>=3D&lt;optimized out&gt;) at <span id=3D"m_473902=
7940679637791m_1287507653871511028m_1944747827822555580m_-43755426664085113=
62m_-8739052298097068210m_5949702530543711213m_4191731141621744608m_-237961=
1272366386122m_-3928334406880738982:3qh.150">lu</span>.c:368<br><br></div>A=
ny ideas, why this happens and how to fix it?<br><br></div>Thanks,<br></div=
><span id=3D"m_4739027940679637791m_1287507653871511028m_194474782782255558=
0m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_4191731=
141621744608m_-2379611272366386122m_-3928334406880738982:3qh.151">Shehab</s=
pan><br><div><div><div><div><br><br></div></div></div></div></div><br></div=
></div>______________________________<wbr>_________________<br>lttng-dev ma=
iling list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank=
">lttng-dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-b=
in/mailman/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/cg=
i-<wbr>bin/mailman/listinfo/lttng-dev</a><span class=3D"m_47390279406796377=
91m_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-873905=
2298097068210m_5949702530543711213m_4191731141621744608m_-23796112723663861=
22HOEnZb"><span style=3D"color:#888888"><br></span></span></blockquote></di=
v><span class=3D"m_4739027940679637791m_1287507653871511028m_19447478278225=
55580m_-4375542666408511362m_-8739052298097068210m_5949702530543711213m_419=
1731141621744608m_-2379611272366386122HOEnZb"><span style=3D"color:#888888"=
><br><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=
=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</a><=
br></div></span></span></div></div></blockquote></div></div><br></blockquot=
e></div></div></div><div><div class=3D"m_4739027940679637791m_1287507653871=
511028m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_59=
49702530543711213m_4191731141621744608h5"><br><div>-- <br></div><div>Mathie=
u Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=
=3D"_blank">http://www.efficios.com</a><br></div></div></div></div></div></=
blockquote></div></div><br></blockquote></div><br><div>-- <br></div><div>Ma=
thieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" tar=
get=3D"_blank">http://www.efficios.com</a><br></div></div><br></blockquote>=
</div></div></div><div><div class=3D"m_4739027940679637791m_128750765387151=
1028m_1944747827822555580m_-4375542666408511362m_-8739052298097068210m_5949=
702530543711213h5"><br><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS=
 Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.e=
fficios.com</a><br></div></div></div></div></div></blockquote></div></div><=
br></blockquote></div></div></div><div><div class=3D"m_4739027940679637791m=
_1287507653871511028m_1944747827822555580m_-4375542666408511362m_-873905229=
8097068210h5"><br><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.=
<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effici=
os.com</a><br></div></div></div></div></div></blockquote></div></div><br></=
blockquote></div><br><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS I=
nc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.eff=
icios.com</a><br></div></div><br></blockquote></div><br><div>-- <br></div><=
div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.co=
m" target=3D"_blank">http://www.efficios.com</a><br></div></div><br></block=
quote></div><br><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<b=
r><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios=
.com</a><br></div></div><br></blockquote></div></div></div><div><div class=
=3D"m_4739027940679637791m_1287507653871511028m_1944747827822555580m_-43755=
42666408511362h5"><br><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS =
Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.ef=
ficios.com</a><br></div></div></div></div></div></blockquote></div></div><b=
r></blockquote></div></div></div><div><div class=3D"m_4739027940679637791m_=
1287507653871511028m_1944747827822555580h5"><br><div>-- <br></div><div>Math=
ieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" targe=
t=3D"_blank">http://www.efficios.com</a><br></div></div></div></div></div><=
/blockquote></div><br></div></div></div></blockquote></div></div><br></bloc=
kquote></div></div></div><div><div class=3D"m_4739027940679637791h5"><br><d=
iv>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http:=
//www.efficios.com" target=3D"_blank">http://www.efficios.com</a><br></div>=
</div></div></div></div></blockquote></div></div><br></blockquote></div></d=
iv></div><div><div class=3D"h5"><div><br></div><div>-- <br></div><div>Mathi=
eu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=
=3D"_blank">http://www.efficios.com</a></div></div></div></div></div></bloc=
kquote></div><br></div>

--883d24f22e2855156c0568037514--

--===============6506159944094264847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6506159944094264847==--
