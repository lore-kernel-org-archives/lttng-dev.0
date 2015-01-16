From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: LTTng unreliable and useless under heavy
	loaded	systems?
Date: Fri, 16 Jan 2015 20:24:11 +0000 (UTC)
Message-ID: <983257069.43886.1421439851925.JavaMail.zimbra__58.6306363858924$1421439895$gmane$org@efficios.com>
References: <54AD5A76.7070004@indel.ch> <54AD654F.4060206@efficios.com>
 <54AE8C05.5070001@indel.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YCDRF-0000zs-Bq
 for lttng-dev@lists.lttng.org; Fri, 16 Jan 2015 15:24:15 -0500
In-Reply-To: <54AE8C05.5070001@indel.ch>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Raphael Zulliger <zulliger@indel.ch>
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Raphael Zulliger" <zulliger@indel.ch>
> To: "Julien Desfossez" <jdesfossez@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Thursday, January 8, 2015 8:54:13 AM
> Subject: Re: [lttng-dev] LTTng unreliable and useless under heavy loaded	systems?
> 
> Hi
> 
> Thanks for your detailed inputs! I read the Readme of latency_tracker.
> The watch-block-event.sh you provide brought me on the track of using
> "--snapshot" which is, as Mathieu mentioned, exactly what I need. Thanks
> Mathieu as well! I'm now able to trace my system and I can successfully
> analyze the traces with Eclipse. Thanks to the --snapshot mode, the
> events that are actually important to me are now part of the trace. When
> I initially read the LTTng docs, and I came to the chapter "snapshot", I
> unfortunately decided to skip it because I (for whatever reason)
> expected something different for "snapshots" (something like the current
> state/callstacks of the CPUs).
> 
> Btw: While latency_tracker looks really great, I didn't use it so far,
> as I already have a very good trigger if a jitter occurs. But I'm glad
> to know it exists, maybe I'll use it the next time I have to optimize a
> system.
> 
> For the records, if someone finds this message on the net, I briefly
> describe how I perform the measurement:
>      lttng create --snapshot victory
>      lttng enable-channel channel0 -k --subbuf-size 16M --num-subbuf 2
>      lttng add-context -k -t procname -c channel0
>      lttng enable-event -k --all -c channel0
>      lttng start
>      chrt -f 50 ./run_my_test-application_here
>      lttng stop
>      lttng destroy
> I've extended my test application to execute 'lttng snapshot record'
> when a certain jitter occurred (cMaxMs):
>      if( dRoundTripTime > cMaxMs ) {
>         system("lttng snapshot record");
>      }
> 
> A few notes:
>    * In my case, I had to increase the subbuf sizes. The default sizes
> were to small, because my system is intentionally under heavy load.
>    * I first tried to use 'num-subbuf 1' because I thought that's ok in
> 'snapshot mode', but that caused LTTng to misbehave: it didn't create
> proper trace files. Unfortunately, it didn't yield any warning/error.
> Wouldn't it make sense to print an warning/error in that case?

Newer versions should already print an error in this case. You might
want to try upgrading.

>    * Just as a side note: With the measurement above, the trace
> sometimes still doesn't contain the events I'm interested in. But I
> guess this is just because the call to "system()" and the execution of
> lttng-consumerd may take that long so that the event in the buffer have
> already been overwritten. (I wonder whether 'lttng snapshot record' is
> optimized so that it immediately causes the tracer to stop overwriting
> old events in the buffer?)

If you care about not overwriting your buffers under heavy load, I
recommend to issue "lttng stop; lttng snapshot record" in order to
stop tracing before gathering the snapshot. This would lessen the
chances to overwrite your important trace data due to your heavy
load.

Another point: I've just submitted a patch that fixes an oddness
with snapshot: currently, only one sub-buffer is grabbed, even if
you would want to gather all the available sub-buffers. This is
http://bugs.lttng.org/issues/860 on the bug tracker. In order to
work-around this issue, I recommend having large sub-buffers (rather
than many small sub-buffers). Once the fixes are merged, it won't
matter as much.

> 
> Although it's not that important anymore, I'm curious about the
> following: Assuming that the occurrence of "my" jitter is not depending
> on timings. I could then claim that I don't care about the system slow
> down due to tracing. That said, I claim I don't really care about how
> may times LTTng must switch the subbuffers, because I guess that this
> happens right in the context of "tracing an event" - so the only thing
> the additional switchings do is to consume some CPU. But it does not
> cause more events to be lost. Am I right? (If not: How is buffer
> switching implemented, roughly?)

sub-buffer switching only consumes CPU, and also writes into a pipe
to let the consumer daemon know that there is data to read. In "discard"
tracing mode, the only thing that typically causes more events to be
discarded is having smaller buffer size. In "overwrite" (snapshot) mode,
events are never discarded. Entire sub-buffers are overwritten instead.

> 
> Thanks for your great & immediate help and keep up the great work on
> LTTng & co!

You're very welcome! I'm glad it's been useful to you!

Thanks,

Mathieu

> Raphael
> 
> P.S. Just in case someone cares: So far, I found that among others,
> kswapd0 and khugepaged are two components that cause jitter on my system.
> 
> On 01/07/2015 05:56 PM, Julien Desfossez wrote:
> > Hi Raphael,
> >
> > First of all, thanks for your input, it is really interesting for us to
> > have detailled use cases like that.
> >
> > One first thing that come to mind is the amount of events enabled. When
> > you use "lttng enable-event -k --all", you enable around 240 trace
> > points (and all the syscalls), and much more if you have the sources of
> > your kernel on the same machine (which allows the compilation and
> > installation of the ext4/btrfs/kvm events). There are some very verbose
> > tracepoint in the default list that might not be useful for the analysis
> > you are trying to perform.
> >
> > I understand that, you want as much information as possible since you
> > don't know what is exactly the problem, but instead of enabling
> > everything, I would suggest a more iterative approach: first just enable
> > the sched_switch and syscall events, and then when you get a better idea
> > of what is going on, enable some specific subsystems.
> >
> > Also, when you increase the amount of subbuffers (and lower the
> > subbuf-size), you increase the rate of subbuffer switches, which is the
> > heaviest operation in the tracer. So you could maybe try other
> > parameters such as 4x8 (if you want to limit to 32MB per CPU per
> > channel). For the crash you got, it might be related to an out-of-memory
> > problem, but it will be interesting to investigate this issue.
> > I don't think there is a proper methodology to identify the perfect size
> > for your use-case (other than trial/error), writing the trace on a
> > dedicated and faster disk helps a lot.
> >
> > I know this can be frustrating to wait for hours for a problem to appear
> > and end up with a huge trace that misses the important events. If the
> > iterative strategy is not an option for you, you might be interested by
> > a project I have started recently to automate the triggering of
> > recording LTTng snapshots based on unusual latencies detected from the
> > kernel [1]. The idea is to only write the trace in memory (no I/O) with
> > the ring-buffer in flight-recorder mode, and when an interesting event
> > is detected, extract the content of the ring-buffer and write it on
> > disk/network. The amount of background information you get in your
> > snapshot depends on the rate of events and size of the ring-buffer.
> > This project is in a really early phase and I would not advise it yet
> > for production use, but if you are interested by it, you can try it, the
> > examples work reliably for me, and if you need help setting it up or
> > adapting it to your needs, don't hesitate to contact me, at this stage
> > all the feedbacks/suggestions are important.
> >
> > I hope this gives you some ideas on what could be your next steps.
> > Please, let us know if you manage to find a way to solve this problem.
> >
> > Thanks,
> >
> > Julien
> >
> > [1] https://github.com/jdesfossez/latency_tracker
> >
> > On 15-01-07 11:10 AM, Raphael Zulliger wrote:
> >> First of all: LTTng seems to be a great piece of software. Great docs
> >> and good visualization tools (Eclipse) are available. I mention this to
> >> clarify that I like LTTng...
> >>
> >> ... unfortunately, for the issue I've started using it, it doesn't work
> >> very well. I contact the list because I hope you have some tips and
> >> tricks for me.
> >>
> >> I have a Ubuntu 14.04/32, i5 Quadcore. The goal is to run an existing
> >> application as jitter less as possible. To tune the system, I've
> >> programmed a simple test-application which sends a UDP frame to an
> >> embedded system and waits for the response. If the time until test-app
> >> receives the response is bigger than 5ms, it consider that a big jitter
> >> and exits. In that case, I want to find out what caused the jitter of >
> >> 5ms. NOTE: I run my application with real-time prio 99 (which could
> >> matter in this case, I guess)
> >>
> >> Here's how I initially run my measurement (all as sudo):
> >>    lttng create
> >>    lttng enable-channel channel0 -k
> >>    lttng enable-event -k --all -c channel0
> >>    lttng start
> >>    chrt -f 50 ./run_my_test-application_here
> >>    lttng stop
> >>    lttng destroy
> >> Then, I start compiling a kernel image and run bonnie++ to generate
> >> system load. It takes about 1h until a jitter > 5ms occurs... but it
> >> happens.
> >>
> >> Unfortunately, whenever the big jitter (which are around 6ms up to 25ms)
> >> occur, LTTng is not able to record the events around the time the delay
> >> happened. Means: I got really nice graphs in Eclipse - but not at the
> >> points where it would be useful... I also verified this with "babeltrace
> >> .... > /dev/null" which reported the loss of various events.
> >>
> >> I read the docs and then tried to increase the buffers. I tried several
> >> numbers, the final version is:
> >>    lttng enable-channel channel0 -k --num-subbuf 32 --subbuf-size 1M
> >> But it doesn't help. From my point of view, the result is still the same
> >> as before it doesn't obviously loose less events than before. (Side
> >> note: Actually, I also tried with "subbuf 16" and "subbuf-size 10M" but
> >> then my system crashed: X gone, no keyboard input possible anymore but
> >> (surprisingly) no kernel dump)
> >>
> >> (Side note: There's one more thing to mention: The system is setup with
> >> isolcpu=1,2,3 (because core 1..3 run real-time apps other than the one
> >> mentioned here) - thus everything, including lttng daemons, ran on CPU0
> >> so far.)
> >>
> >> Finally, I tried to run lttng-sessiond and lttng-consumerd on a separate
> >> CPU core (CPU3) and even changed policy to SCHED_FIFO and prio to 99 -
> >> but lttng still looses events. This really surpises me...
> >>
> >> I do understand that it is a good feature that lttng discards events
> >> when buffers are full... but in my case, it seems to render lttng useless.
> >> (Note: I did not yes use the "buffer overwrite" feature, but I guess the
> >> events of interest will still be lost)
> >>
> >> My question: Is there anything else I can do on my system (which is a
> >> not a production system, just a developer machine) to make lttng work
> >> for my scenario?
> >>
> >> Any input is very welcome!
> >> Raphael
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
