From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Changed scheduling when using lttng
Date: Fri, 10 May 2013 10:56:20 -0400
Message-ID: <20130510145620.GH20313__24034.9350301132$1368197820$gmane$org@Krystal>
References: <CA+xJJ19OE=nrfpEoOEib-7=GrP9hD-RV7bc=aY7nqDwB59auXQ@mail.gmail.com>
	<20130426151444.GA2260@Krystal>
	<CA+xJJ199oic8pmnKM4c674Zf_NJe3AR1YxFtBTjLryv3S67nkQ@mail.gmail.com>
	<20130426153819.GA3026@Krystal>
	<CA+xJJ18ea02rKcfJmw9B2bTOBY0Mz_Wr6c+aszb3HWPDz2zRAQ@mail.gmail.com>
	<20130426161439.GA5547@Krystal>
	<CA+xJJ181-F-36Kw18Z5R9rvhzDeNfUgNQofHrowmY5raZA2Qtw@mail.gmail.com>
	<CA+xJJ19UQ_hh-rfjhor8pHCDL0XRGyW+ZfPzQiYBfdBsj=r0xg@mail.gmail.com>
	<20130430144323.GB31980@Krystal>
	<CA+xJJ19Bg0=R0yGiu5vsDu_1nSSY1uQLK4c=oe-5=ASzxbqmOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Uaok9-0006tX-Qq
	for lttng-dev@lists.lttng.org; Fri, 10 May 2013 10:56:21 -0400
Content-Disposition: inline
In-Reply-To: <CA+xJJ19Bg0=R0yGiu5vsDu_1nSSY1uQLK4c=oe-5=ASzxbqmOg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mats Liljegren <liljegren.mats2@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Mats Liljegren (liljegren.mats2@gmail.com) wrote:
> >>       --buffers-global     Use shared buffer for the whole system (-k only)
> >
> > This option would be clearer as "--buffers-per-cpu" maybe ?
> 
> This makes me even more confused... The name "buffers-global" is very
> clear to me. Opposites would be buffers private for a CPU, for a UID,
> and so on. Is the option "--buffers-global" meant to be an opposite of
> "--buffers-uid" and "--buffers-pid"? This would seems strange since
> those two are only for user space tracing while "--buffers-global" is
> for kernel tracing. By the way, isn't "--buffers-per-cpu" default? Oh
> well...

Currently, we have:

kernel tracing: --buffers-global (those are per-cpu buffers)

ust tracing: --buffers-pid, --buffers-uid (those are also per-cpu buffers)

We currently don't implement "single buffer" shared across all CPUs.

By the way, the fact that e.g. --buffers-global is only available for
kernel tracing today does not mean it will never be available for ust in
future versions.

> 
> But the real confusion lies in the fact that I cannot see the option
> being used for anything. It sets the file local variable
> opt_buffers_global, and is used for a sanity check. But I can't see it
> being used for anything else. Have I missed something here?

David ?

> 
> >
> >> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>   -C, --tracefile-size SIZE
> >>                            Maximum size of of each tracefile within a
> >> stream (in bytes).
> >>   -W, --tracefile-count COUNT
> >>                            Used in conjunction with -C option, this
> >> will limit the number
> >>                            of files created to the specified count.
> >>
> >> I look in src/bin/lttng/commands/enable_channels.c, the long option
> >> array will point to opt_buffer_global. The only use for this file
> >> private variable is for a single sanity check. I cannot see any other
> >> use of it. Have I missed something here?
> >>
> >> But in this file, function enable_channel(), I see:
> >>
> >>                 dom.buf_type = LTTNG_BUFFER_GLOBAL;
> >>
> >> This is executed for the kernel case. But my buffers are still
> >> allocated per-cpu. What is going on? Where did this configuration go?
> >> What does it do?
> >>
> >> If I take this from the other end, I'd like to use the line:
> >>     .alloc = RING_BUFFER_ALLOC_GLOBAL
> >> found in
> >>     lttng-ring-buffer-metadata-client.h
> >> How do I make this happen?
> >
> > lttng-sessiond never creates buffers shared between CPUs for now (except
> > for metadata). The "--buffers-global" option is misleading and should
> > possibly be renamed.
> 
> So it is lttng-sessiond that dictates the allocation type? I'll take a
> closer look at it.

the "lttng" command passes it to liblttng-ctl, which asks lttng-sessiond
to allocate the buffer. Then, buffer allocation is handled by either
sessiond or consumerd (depending if kernel or ust tracing), using either
the lttng-modules ABI or liblttng-ust-ctl. This is where the allocation
really happens.

Thanks,

Mathieu

> 
> /Mats

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
