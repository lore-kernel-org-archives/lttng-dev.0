From: =?UTF-8?Q?Genevi=c3=a8ve_Bastien?= <gbastien@versatic.net>
Subject: Re: Lacking instrumentation for threaded IRQs
Date: Tue, 2 Oct 2018 11:40:51 -0400
Message-ID: <a3fe526e-710a-715f-05ce-36eb92602e5a__36978.1501045965$1538494803$gmane$org@versatic.net>
References: <e6194c95-9580-f24f-e8e2-1df8e67f804b@versatic.net>
 <b1c31153-da2f-0d40-a678-4428c78dd11e@klipix.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7024796966177299760=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from s056.panelboxmanager.com (s056.panelboxmanager.com
 [174.142.230.146])
 by lists.lttng.org (Postfix) with ESMTPS id 42PjzW0sDJz13n9
 for <lttng-dev@lists.lttng.org>; Tue,  2 Oct 2018 11:40:54 -0400 (EDT)
Received: from mailnull by s056.panelboxmanager.com with sa-checked (Exim 4.91)
 (envelope-from <gbastien@versatic.net>) id 1g7Mn7-005spn-Nm
 for lttng-dev@lists.lttng.org; Tue, 02 Oct 2018 11:40:54 -0400
In-Reply-To: <b1c31153-da2f-0d40-a678-4428c78dd11e@klipix.org>
Content-Language: en-US-large
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Julien Desfossez <ju@klipix.org>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============7024796966177299760==
Content-Type: multipart/alternative;
 boundary="------------A074354F291321251A58BE22"
Content-Language: en-US-large

This is a multi-part message in MIME format.
--------------A074354F291321251A58BE22
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi,

On 2018-10-02 10:23 a.m., Julien Desfossez wrote:
> On 10/01/2018 01:25 PM, Geneviève Bastien wrote:
>> Hi,
>>
>>
>> I was writing a tutorial on distributed critical path in Trace Compass.
>> I was tracing a client (my laptop on wifi) and a server. And to my
>> surprise, it didn't work! After further investigation, here's the issue:
>>
>>
>> The critical path assumes that a network packet is received in a softirq
>> that wakes up the process to whom the packet is meant. This is right for
>> ethernet network, but not wifi. Wifi packets are handled by a threaded
>> IRQ. Here's the flow:
>>
>>
>> 1- There's an irq that is handled with a return value of 2 (IRQ_WAKE_THREAD)
>>
>> 2- The 2 means to wake up a process _after_ the irq_handler_exit
>> tracepoint is hit
>>
>> 3- The IRQ thread is woken up, scheduled in and is running
>>
>> 4- The packet is received during that time
>>
>> 5- The packet reception is hence not on the critical path!
>>
>>
>> The issue we have here with the critical path for network will also be
>> an issue for all threaded irqs and there is some additional
>> instrumentation needed to be able to automatically take those into
>> account in analyses.
>>
>> There's additional instrumentation needed
>>
>> 1- To associate the wakeup of the IRQ thread to the actual IRQ. The way
>> it is now, the wakeup happens in the context of whatever else was
>> running before the IRQ handler.
>>
>> 2- To make it obvious that the IRQ thread is really an IRQ thread, so
>> whatever is running there should be considered in the context of a
>> threaded IRQ and not a simple running process.
>>
>>
>> Here are some options for each, not mutually exclusive:
>>
>> For 1-
>>
>> * Instrument the kernel: Add tracepoints to the beginning and end of
>> do_IRQ, to show the full IRQ duration, not just the handler and all
>> events happening during that time can be associated with the IRQ.
>>
>> * Instrument the kernel: Add tracepoints before and after waking
>> processes if the return value of the handler is IRQ_WAKE_THREAD. Those
>> tracepoints would be hit only if a process needs to be woken and would
>> not add overhead otherwise
>>
>> * At analysis time: Look at the return value of irq_handler_exit and if
>> 2, wait for the next waking on that CPU and associate it with the last
>> IRQ. But could there be more than one process to wakeup? Looking at the
>> kernel code, it seems that not. But this is more error-prone.
>>
>>
>> For 2-
>>
>> * Instrument the kernel: Add tracepoints to the beginning and end of the
>> irq_thread_fn function. Those events would indicate the context of a
>> threaded IRQ so all events inside can be considered the results of an IRQ.
>>
>> * Instrument LTTng: Add a field to the lttng_statedump_interrupt
>> tracepoint to add the thread handling this IRQ if available. That would
>> give this thread a special state: instead of running, whatever happens
>> there would be considered as the result of an IRQ. But only LTTng traces
>> would benefit from this tracepoint, and only if there's a statedump (so
>> not snapshot). It's sad... But would make a quick win for now.
>>
>>
>> Here's a pad showing those possible options:
>> https://hebdo.framapad.org/p/threadedirqlttnglinux8gjkh51yhfha
>>
>> What do you think? I'm mostly interested to know if there's a case to
>> add instrumentation to the kernel and where.
> For #1, I think adding the do_IRQ begin/end instrumentation, would be
> very valuable, we did it with a kretprobe in the latency-tracker, but I
> think this deserves a real tracepoint. In your example trace, we can see
> with the do_IRQ event that the whole interruption lasted 5.2
> micro-seconds, whereas the interrupt handler only lasted 482ns, so
> without this event we are clearly missing long periods of interruption.
>
> Using the "ret = 2" would work as a temporary fix, but there are some
> corner cases where it could lead us into wrong assumptions (the process
> to be woken up is exiting somehow and the interrupt arrived during a
> syscall that needed to wake another process), so I think the real fix is
> the do_IRQ instrumentation.
I agree
> For #2, I am not exactly sure why we need special events for those
> kernel threads, with the fix for #1, we know they are interrupt-related
> threads, but they are not interrupts in the sense of "doing work while
> the current task is interrupted". To me, everything this thread does is
> related to the previous source of wakeup and I would imagine every chunk
> of work it does is between an irq_thread_fn_entry/return block.
> I am not against adding this information (or the statedump approach if
> we are sure there is a 1 to 1 mapping), but I would like to understand
> more precisely what this information would add to our understanding of
> the trace.
>
We need to know that those threads are really interrupt thread for the
dependency analysis. Look at the following sequence of events:

[12:02:17.779984311] (+0.000002224) dorsallaptop *sched_waking*: {
cpu_id = 3 }, { comm = "irq/130-iwlwifi", tid = *639*, prio = -51,
target_cpu = 3 }
[12:02:17.779985668] (+0.000000565) dorsallaptop *do_IRQ_return*: {
cpu_id = 3 }, { ip = 0xFFFFFFFF89A01C30, parent_ip = 0xFFFFFFFF89A0098F }
[12:02:17.779986575] (+0.000000907) dorsallaptop *sched_switch*: {
cpu_id = 3 }, { prev_comm = "swapper/3", prev_tid = 0, prev_prio = 20,
prev_state = 0, next_comm = "irq/130-iwlwifi", next_tid = *639*,
next_prio = -51 }
[12:02:17.779998608] (+0.000011174) dorsallaptop net_if_receive_skb: {
cpu_id = 3 }, { ... }
[12:02:17.780019468] (+0.000020860) dorsallaptop sched_waking: { cpu_id
= 3 }, { comm = "wget", tid = 2430, prio = 20, target_cpu = 0 }

If we do the critical path of the wget process, with the irq/130-iwlwifi
thread considered a normal thread, we see it is woken up by an hardware
interrupt, that we know if iwlwifi, but we don't know anything else
about it, so the critical path ends up following the swapper process...
Now if we consider the irq/130-iwlwifi thread as an interrupt-running
process, we see that wget is actually woken up by the net_if_receive_skb
event and we can follow this to the packet sent by another machine.
Of course this can all be done at analysis time: if (ret = 2 and a
wakeup inside the do_IRQ but outside the irq_handler) { assume the woken
thread will be handling the interrupt } But it's the "assume" part that
I don't like. With instrumentation, we can clarify this.

--------------A074354F291321251A58BE22
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi,<br>
    </p>
    <div class="moz-cite-prefix">On 2018-10-02 10:23 a.m., Julien
      Desfossez wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:b1c31153-da2f-0d40-a678-4428c78dd11e@klipix.org">
      <pre class="moz-quote-pre" wrap="">On 10/01/2018 01:25 PM, Geneviève Bastien wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Hi,


I was writing a tutorial on distributed critical path in Trace Compass.
I was tracing a client (my laptop on wifi) and a server. And to my
surprise, it didn't work! After further investigation, here's the issue:


The critical path assumes that a network packet is received in a softirq
that wakes up the process to whom the packet is meant. This is right for
ethernet network, but not wifi. Wifi packets are handled by a threaded
IRQ. Here's the flow:


1- There's an irq that is handled with a return value of 2 (IRQ_WAKE_THREAD)

2- The 2 means to wake up a process _after_ the irq_handler_exit
tracepoint is hit

3- The IRQ thread is woken up, scheduled in and is running

4- The packet is received during that time

5- The packet reception is hence not on the critical path!


The issue we have here with the critical path for network will also be
an issue for all threaded irqs and there is some additional
instrumentation needed to be able to automatically take those into
account in analyses.

There's additional instrumentation needed

1- To associate the wakeup of the IRQ thread to the actual IRQ. The way
it is now, the wakeup happens in the context of whatever else was
running before the IRQ handler.

2- To make it obvious that the IRQ thread is really an IRQ thread, so
whatever is running there should be considered in the context of a
threaded IRQ and not a simple running process.


Here are some options for each, not mutually exclusive:

For 1-

* Instrument the kernel: Add tracepoints to the beginning and end of
do_IRQ, to show the full IRQ duration, not just the handler and all
events happening during that time can be associated with the IRQ.

* Instrument the kernel: Add tracepoints before and after waking
processes if the return value of the handler is IRQ_WAKE_THREAD. Those
tracepoints would be hit only if a process needs to be woken and would
not add overhead otherwise

* At analysis time: Look at the return value of irq_handler_exit and if
2, wait for the next waking on that CPU and associate it with the last
IRQ. But could there be more than one process to wakeup? Looking at the
kernel code, it seems that not. But this is more error-prone.


For 2-

* Instrument the kernel: Add tracepoints to the beginning and end of the
irq_thread_fn function. Those events would indicate the context of a
threaded IRQ so all events inside can be considered the results of an IRQ.

* Instrument LTTng: Add a field to the lttng_statedump_interrupt
tracepoint to add the thread handling this IRQ if available. That would
give this thread a special state: instead of running, whatever happens
there would be considered as the result of an IRQ. But only LTTng traces
would benefit from this tracepoint, and only if there's a statedump (so
not snapshot). It's sad... But would make a quick win for now.


Here's a pad showing those possible options:
<a class="moz-txt-link-freetext" href="https://hebdo.framapad.org/p/threadedirqlttnglinux8gjkh51yhfha">https://hebdo.framapad.org/p/threadedirqlttnglinux8gjkh51yhfha</a>

What do you think? I'm mostly interested to know if there's a case to
add instrumentation to the kernel and where.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
For #1, I think adding the do_IRQ begin/end instrumentation, would be
very valuable, we did it with a kretprobe in the latency-tracker, but I
think this deserves a real tracepoint. In your example trace, we can see
with the do_IRQ event that the whole interruption lasted 5.2
micro-seconds, whereas the interrupt handler only lasted 482ns, so
without this event we are clearly missing long periods of interruption.

Using the "ret = 2" would work as a temporary fix, but there are some
corner cases where it could lead us into wrong assumptions (the process
to be woken up is exiting somehow and the interrupt arrived during a
syscall that needed to wake another process), so I think the real fix is
the do_IRQ instrumentation.</pre>
    </blockquote>
    I agree
    <blockquote type="cite"
      cite="mid:b1c31153-da2f-0d40-a678-4428c78dd11e@klipix.org">
      <pre class="moz-quote-pre" wrap="">
For #2, I am not exactly sure why we need special events for those
kernel threads, with the fix for #1, we know they are interrupt-related
threads, but they are not interrupts in the sense of "doing work while
the current task is interrupted". To me, everything this thread does is
related to the previous source of wakeup and I would imagine every chunk
of work it does is between an irq_thread_fn_entry/return block.
I am not against adding this information (or the statedump approach if
we are sure there is a 1 to 1 mapping), but I would like to understand
more precisely what this information would add to our understanding of
the trace.

</pre>
    </blockquote>
    <p>We need to know that those threads are really interrupt thread
      for the dependency analysis. Look at the following sequence of
      events:</p>
    <div id="magicdomid17" class=""><span
        class="author-a-vmz80z5z89zkdz79zz75z6nez68zz65z6l">[12:02:17.779984311]
        (+0.000002224) dorsallaptop </span><span
        class="author-a-vmz80z5z89zkdz79zz75z6nez68zz65z6l b"><b>sched_waking</b></span><span
        class="author-a-vmz80z5z89zkdz79zz75z6nez68zz65z6l">: { cpu_id =
        3 }, { comm = "irq/130-iwlwifi", tid = </span><span
        class="author-a-vmz80z5z89zkdz79zz75z6nez68zz65z6l b"><b>639</b></span><span
        class="author-a-vmz80z5z89zkdz79zz75z6nez68zz65z6l">, prio =
        -51, target_cpu = 3 }</span></div>
    <div id="magicdomid19" class=""><span
        class="author-a-vmz80z5z89zkdz79zz75z6nez68zz65z6l">[12:02:17.779985668]
        (+0.000000565) dorsallaptop </span><span
        class="author-a-vmz80z5z89zkdz79zz75z6nez68zz65z6l b
        color:green"><b>do_IRQ_return</b></span><span
        class="author-a-vmz80z5z89zkdz79zz75z6nez68zz65z6l">: { cpu_id =
        3 }, { ip = 0xFFFFFFFF89A01C30, parent_ip = 0xFFFFFFFF89A0098F }</span></div>
    <div id="magicdomid20" class=""><span
        class="author-a-vmz80z5z89zkdz79zz75z6nez68zz65z6l">[12:02:17.779986575]
        (+0.000000907) dorsallaptop </span><span
        class="author-a-vmz80z5z89zkdz79zz75z6nez68zz65z6l b color:blue"><b>sched_switch</b></span><span
        class="author-a-vmz80z5z89zkdz79zz75z6nez68zz65z6l">: { cpu_id =
        3 }, { prev_comm = "swapper/3", prev_tid = 0, prev_prio = 20,
        prev_state = 0, next_comm = "irq/130-iwlwifi", next_tid = </span><span
        class="author-a-vmz80z5z89zkdz79zz75z6nez68zz65z6l b color:blue"><b>639</b></span><span
        class="author-a-vmz80z5z89zkdz79zz75z6nez68zz65z6l">, next_prio
        = -51 }</span></div>
    <span class="author-a-vmz80z5z89zkdz79zz75z6nez68zz65z6l">[12:02:17.779998608]
      (+0.000011174) dorsallaptop net_if_receive_skb: { cpu_id = 3 }, {
      ... }</span>
    <div id="magicdomid23" class=""><span
        class="author-a-vmz80z5z89zkdz79zz75z6nez68zz65z6l">[12:02:17.780019468]
        (+0.000020860) dorsallaptop sched_waking: { cpu_id = 3 }, { comm
        = "wget", tid = 2430, prio = 20, target_cpu = 0 }</span></div>
    <div class=""><span
        class="author-a-vmz80z5z89zkdz79zz75z6nez68zz65z6l"><br>
      </span></div>
    <div class=""><span
        class="author-a-vmz80z5z89zkdz79zz75z6nez68zz65z6l">If we do the
        critical path of the wget process, with the irq/130-iwlwifi
        thread considered a normal thread, we see it is woken up by an
        hardware interrupt, that we know if iwlwifi, but we don't know
        anything else about it, so the critical path ends up following
        the swapper process...<br>
      </span></div>
    <div class=""><span
        class="author-a-vmz80z5z89zkdz79zz75z6nez68zz65z6l">Now if we
        consider the irq/130-iwlwifi thread as an interrupt-running
        process, we see that wget is actually woken up by the
        net_if_receive_skb event and we can follow this to the packet
        sent by another machine. <br>
      </span></div>
    <div class=""><span
        class="author-a-vmz80z5z89zkdz79zz75z6nez68zz65z6l">Of course
        this can all be done at analysis time: if (ret = 2 and a wakeup
        inside the do_IRQ but outside the irq_handler) { assume the
        woken thread will be handling the interrupt } But it's the
        "assume" part that I don't like. With instrumentation, we can
        clarify this.<br>
      </span></div>
    <span class="author-a-vmz80z5z89zkdz79zz75z6nez68zz65z6l"></span>
  </body>
</html>

--------------A074354F291321251A58BE22--

--===============7024796966177299760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7024796966177299760==--
