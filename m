From: Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: basic questions on LTTng
Date: Fri, 27 Mar 2015 15:15:30 -0400 (EDT)
Message-ID: <1433413617.2739896.1427483730218.JavaMail.zimbra__44715.2140703567$1427483819$gmane$org@polymtl.ca>
References: <2C003D10-DDBA-4D4C-B807-0A93A49BF6CB@mah.priv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <michel.dagenais@polymtl.ca>) id 1YbZj9-0004vd-Gz
 for lttng-dev@lists.lttng.org; Fri, 27 Mar 2015 15:15:32 -0400
In-Reply-To: <2C003D10-DDBA-4D4C-B807-0A93A49BF6CB@mah.priv.at>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Haberler <mail17@mah.priv.at>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


> - is it possible to use LTTng from Xenomai RT threads? (old mails on the
> Xenomai list suggest so, but it is unclear if special
> precautions/incantations/patches are needed)

I have not looked into this. There should not be big problem since LTTng is fairly self standing to minimize the impact and reliance on the rest of the kernel. Mathieu can probably tell you more about this.

> - do tracepoints use ANY linux system services (system calls in the UST
> context, and kernel API in the kernel context)? (background - if that is the
> case with Xenomai, an RT thread could be relaxed; with RTAI things could go
> really haywire as RT threads are running in something similar to an IRQ
> context)

In user-space, the interactions are at sub-buffer switch time. If I remember correctly, a few bytes are written to a pipe connected to the consumer daemon. There is also a mode where nothing is done by the traced application and the consumer daemon polls the sub-buffer metadata to detect when it is full. In kernel mode, tracepoints can appear even in interrupt and NMI contexts.

> - are there any precautions to take when using an RT-PREEMPT kernel?

We have used it with PREEMPT-RT. I do not believe that anyhting special is required.

> - is there a ballpark figure for the cost (roundabout ns on typical hardware)
> for a dormant and a fired tracepoint?

We essentially cannot measure the cost when dormant. When tracing to a file, the cost can be around 200ns. In between, you can have a conditional tracepoint (faster that a tracepoint when the condition false), and tracing to memory but not saving to disk. Tracing to memory is useful to limit the overhead while keeping the option to save a snapshot to disk of the recent events whenever a problem (latency) is encountered.

> - related - does it make sense to conditionally compile in tracepoints, or
> are they so cheap they could just as well stay in production code?

Definitely, you can keep them in production code. On systems with very limited memory, the overhead of the information stored for each tracepoint may be a concern though.

> - in our scenario, we'd like to find sources of delay which could vary
> according to arguments (e.g. the math library function I mentioned, which
> runs exceedingly long for certain argument values). Is there a way to
> trigger on the time delta between tracepoints, like as a filter? would the
> Python API help me here?

Julien has been working on the latency tracker which can be an excellent tool for such situations. You just measure the latency of a number of operations and, when a problem is encountered, you collect much more information such as stack dumps. You therefore have a very low overhead when no latency problem is present, and a lot of details when there is a problem.

http://lttng.org/blog/2015/03/18/full-stack-latencies/

> A note on demons and tracing: one demon we use does the classic double fork
> to go into the background, and in that case the
> "LD_PRELOAD=liblttng-ust-fork.so" support seems not to work. Not an issue, I
> patched it so it can stay in the foreground which takes care of the problem.
> It's this piece I disabled with an option:
> https://github.com/machinekit/machinekit/blob/master/src/rtapi/rtapi_app.cc#L1311-L1334

Julien or Mathieu should be able to help you there.
