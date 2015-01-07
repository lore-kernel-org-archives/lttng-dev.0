From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: LTTng unreliable and useless under heavy loaded
	systems?
Date: Wed, 07 Jan 2015 11:56:47 -0500
Message-ID: <54AD654F.4060206__5569.64157517559$1420649902$gmane$org@efficios.com>
References: <54AD5A76.7070004@indel.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([85.12.144.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1Y8tuh-00022w-I0
 for lttng-dev@lists.lttng.org; Wed, 07 Jan 2015 11:57:00 -0500
In-Reply-To: <54AD5A76.7070004@indel.ch>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Raphael Zulliger <zulliger@indel.ch>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Raphael,

First of all, thanks for your input, it is really interesting for us to
have detailled use cases like that.

One first thing that come to mind is the amount of events enabled. When
you use "lttng enable-event -k --all", you enable around 240 trace
points (and all the syscalls), and much more if you have the sources of
your kernel on the same machine (which allows the compilation and
installation of the ext4/btrfs/kvm events). There are some very verbose
tracepoint in the default list that might not be useful for the analysis
you are trying to perform.

I understand that, you want as much information as possible since you
don't know what is exactly the problem, but instead of enabling
everything, I would suggest a more iterative approach: first just enable
the sched_switch and syscall events, and then when you get a better idea
of what is going on, enable some specific subsystems.

Also, when you increase the amount of subbuffers (and lower the
subbuf-size), you increase the rate of subbuffer switches, which is the
heaviest operation in the tracer. So you could maybe try other
parameters such as 4x8 (if you want to limit to 32MB per CPU per
channel). For the crash you got, it might be related to an out-of-memory
problem, but it will be interesting to investigate this issue.
I don't think there is a proper methodology to identify the perfect size
for your use-case (other than trial/error), writing the trace on a
dedicated and faster disk helps a lot.

I know this can be frustrating to wait for hours for a problem to appear
and end up with a huge trace that misses the important events. If the
iterative strategy is not an option for you, you might be interested by
a project I have started recently to automate the triggering of
recording LTTng snapshots based on unusual latencies detected from the
kernel [1]. The idea is to only write the trace in memory (no I/O) with
the ring-buffer in flight-recorder mode, and when an interesting event
is detected, extract the content of the ring-buffer and write it on
disk/network. The amount of background information you get in your
snapshot depends on the rate of events and size of the ring-buffer.
This project is in a really early phase and I would not advise it yet
for production use, but if you are interested by it, you can try it, the
examples work reliably for me, and if you need help setting it up or
adapting it to your needs, don't hesitate to contact me, at this stage
all the feedbacks/suggestions are important.

I hope this gives you some ideas on what could be your next steps.
Please, let us know if you manage to find a way to solve this problem.

Thanks,

Julien

[1] https://github.com/jdesfossez/latency_tracker

On 15-01-07 11:10 AM, Raphael Zulliger wrote:
> First of all: LTTng seems to be a great piece of software. Great docs
> and good visualization tools (Eclipse) are available. I mention this to
> clarify that I like LTTng...
> 
> ... unfortunately, for the issue I've started using it, it doesn't work
> very well. I contact the list because I hope you have some tips and
> tricks for me.
> 
> I have a Ubuntu 14.04/32, i5 Quadcore. The goal is to run an existing
> application as jitter less as possible. To tune the system, I've
> programmed a simple test-application which sends a UDP frame to an
> embedded system and waits for the response. If the time until test-app
> receives the response is bigger than 5ms, it consider that a big jitter
> and exits. In that case, I want to find out what caused the jitter of >
> 5ms. NOTE: I run my application with real-time prio 99 (which could
> matter in this case, I guess)
> 
> Here's how I initially run my measurement (all as sudo):
>   lttng create
>   lttng enable-channel channel0 -k
>   lttng enable-event -k --all -c channel0
>   lttng start
>   chrt -f 50 ./run_my_test-application_here
>   lttng stop
>   lttng destroy
> Then, I start compiling a kernel image and run bonnie++ to generate
> system load. It takes about 1h until a jitter > 5ms occurs... but it
> happens.
> 
> Unfortunately, whenever the big jitter (which are around 6ms up to 25ms)
> occur, LTTng is not able to record the events around the time the delay
> happened. Means: I got really nice graphs in Eclipse - but not at the
> points where it would be useful... I also verified this with "babeltrace
> .... > /dev/null" which reported the loss of various events.
> 
> I read the docs and then tried to increase the buffers. I tried several
> numbers, the final version is:
>   lttng enable-channel channel0 -k --num-subbuf 32 --subbuf-size 1M
> But it doesn't help. From my point of view, the result is still the same
> as before it doesn't obviously loose less events than before. (Side
> note: Actually, I also tried with "subbuf 16" and "subbuf-size 10M" but
> then my system crashed: X gone, no keyboard input possible anymore but
> (surprisingly) no kernel dump)
> 
> (Side note: There's one more thing to mention: The system is setup with
> isolcpu=1,2,3 (because core 1..3 run real-time apps other than the one
> mentioned here) - thus everything, including lttng daemons, ran on CPU0
> so far.)
> 
> Finally, I tried to run lttng-sessiond and lttng-consumerd on a separate
> CPU core (CPU3) and even changed policy to SCHED_FIFO and prio to 99 -
> but lttng still looses events. This really surpises me...
> 
> I do understand that it is a good feature that lttng discards events
> when buffers are full... but in my case, it seems to render lttng useless.
> (Note: I did not yes use the "buffer overwrite" feature, but I guess the
> events of interest will still be lost)
> 
> My question: Is there anything else I can do on my system (which is a
> not a production system, just a developer machine) to make lttng work
> for my scenario?
> 
> Any input is very welcome!
> Raphael
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
