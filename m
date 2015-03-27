From: Michael Haberler <mail17@mah.priv.at>
Subject: basic questions on LTTng
Date: Fri, 27 Mar 2015 19:46:34 +0100
Message-ID: <2C003D10-DDBA-4D4C-B807-0A93A49BF6CB__18247.1731598072$1427482063$gmane$org@mah.priv.at>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mah2.mah.priv.at ([86.59.12.251] helo=mah.priv.at)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mail17@mah.priv.at>) id 1YbZHB-0004kg-L4
 for lttng-dev@lists.lttng.org; Fri, 27 Mar 2015 14:46:38 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

hello,

I've perused the docs and some of the code, and have the following questions:


- is it possible to use LTTng from Xenomai RT threads? (old mails on the Xenomai list suggest so, but it is unclear if special precautions/incantations/patches are needed)

- do tracepoints use ANY linux system services (system calls in the UST context, and kernel API in the kernel context)? (background - if that is the case with Xenomai, an RT thread could be relaxed; with RTAI things could go really haywire as RT threads are running in something similar to an IRQ context)

- are there any precautions to take when using an RT-PREEMPT kernel?

- is there a ballpark figure for the cost (roundabout ns on typical hardware) for a dormant and a fired tracepoint?

- related - does it make sense to conditionally compile in tracepoints, or are they so cheap they could just as well stay in production code?

- in our scenario, we'd like to find sources of delay which could vary according to arguments (e.g. the math library function I mentioned, which runs exceedingly long for certain argument values). Is there a way to trigger on the time delta between tracepoints, like as a filter? would the Python API help me here?


Our usage scenario will be mostly UST and maybe some kernel tracing.
Right now I'm using self-built 2.6.0 on x86 and 2.5.1 on arm7hf from the jessie stream. Xenomai is 2.6.3 and 2.6.4 on kernels at and beyond 3.8.13 at the moment. RTAI is also 3.8.13, but not the platform of choice.

A note on demons and tracing: one demon we use does the classic double fork to go into the background, and in that case the "LD_PRELOAD=liblttng-ust-fork.so" support seems not to work. Not an issue, I patched it so it can stay in the foreground which takes care of the problem. It's this piece I disabled with an option: https://github.com/machinekit/machinekit/blob/master/src/rtapi/rtapi_app.cc#L1311-L1334

thanks in advance for,

Michael
