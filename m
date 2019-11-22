From: Norbert Lange <nolange79@gmail.com>
Subject: Re: Using lttng-ust with xenomai
Date: Fri, 22 Nov 2019 21:04:19 +0100
Message-ID: <CADYdroNn84EieoJ2ZfNKF8ZEBqcF3Ridu2LxPAFcx=X+kZsDUg__1352.97481190122$1574453086$gmane$org@mail.gmail.com>
References: <CADYdroN-i9yrpd-wjPSW36GUptRV+kOCJT=Yv6+Z5sCVBmo_SQ@mail.gmail.com>
 <2012667816.853.1574437363737.JavaMail.zimbra@efficios.com>
 <CADYdroNGcY6adA5cGTzwzsKqO7+iuWts9k8Haz8k3HSvzQfc=g@mail.gmail.com>
 <1007669875.1091.1574449410739.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 by lists.lttng.org (Postfix) with ESMTPS id 47KS7g69qyz1SHx
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 15:04:31 -0500 (EST)
Received: by mail-io1-xd43.google.com with SMTP id i11so9371078iol.13
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 12:04:31 -0800 (PST)
In-Reply-To: <1007669875.1091.1574449410739.JavaMail.zimbra@efficios.com>
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>, Xenomai <xenomai@xenomai.org>
List-Id: lttng-dev@lists.lttng.org

Am Fr., 22. Nov. 2019 um 20:03 Uhr schrieb Mathieu Desnoyers
<mathieu.desnoyers@efficios.com>:
>
> ----- On Nov 22, 2019, at 12:55 PM, Norbert Lange nolange79@gmail.com wrote:
>
> >>
> >> LTTng-UST prepares the ring buffers from lttng-ust's "listener" thread,
> >> which is injected into the process by a lttng-ust constructor.
> >>
> >> What you will care about is how the tracepoint call-site (within a Xenomai
> >> thread) interacts with the ring buffers.
> >>
> >> The "default" setup for lttng-ust ring buffers is not suitable for Xenomai
> >> threads. The lttng-ust ring buffer is split into sub-buffers, each sub-buffer
> >> corresponding to a CTF trace "packet". When a sub-buffer is filled, lttng-ust
> >> invokes "write(2)" to a pipe to let the consumer daemon know there is data
> >> available in that ring buffer. You will want to get rid of that write(2) system
> >> call from a Xenomai thread.
> >>
> >> The proper configuration is to use lttng-enable-channel(1) "--read-timer"
> >> option (see https://lttng.org/docs/v2.11/#doc-channel-read-timer). This will
> >> ensure that the consumer daemon uses a polling approach to check periodically
> >> whether data needs to be consumed within each buffer, thus removing the
> >> use of the write(2) system call on the application-side.
> >
> > Ah thanks.
> >
> > But that's configuration outside of the RT app if I understand this correctly.
> > So if one configures a tracer wrong, then the app will suddenly misbehave.
> > Would be nice to be able to somehow tell that there is only read-timer allowed.
>
> So an RT application would prohibit tracing to non-RT ring buffers ? IOW, if a
> channel is configured without the --read-timer option, nothing would appear from
> the RT threads in those buffers.
>
> Should this be per-process or per-thread ?

I dont know lttng internals, I'd give this as an option to the lttng
control-thread
for the whole process?

> >> > liburcu has configure options allow forcing the usage of this syscall
> >> > but not disabling it, which likely is necessary for Xenomai.
> >>
> >> I suspect what you'd need there is a way to allow a process to tell
> >> liburcu-bp (or liburcu) to always use the fall-back mechanism which does
> >> not rely on sys_membarrier. This could be allowed before the first use of
> >> the library. I think extending the liburcu APIs to allow this should be
> >> straightforward enough. This approach would be more flexible than requiring
> >> liburcu to be specialized at configure time. This new API would return an error
> >> if invoked with a liburcu library compiled with
> >> --disable-sys-membarrier-fallback.
> >
> > I was under the impression, that you counted clock-cycles for every operation ;)
>
> Well it's just a new API that allows tweaking the state of a boolean which controls
> branches which are already there on the fast-path. ;)
>
> > Not sure, maybe a separate lib for realtime is the better way. Having no option
> > can be considered foolproof, and sideeffects of the syscall not working would be
> > a real pain.
>
> e.g. a liburcu-bp-rt.so ? That would bring interesting integration challenges with
> lttng-ust though. Should we then build a liblttng-ust-rt.so as well ?

For my usecase, there is a xenomai-system with everything compiled from scratch,
and that would be a compile-time option, no new names.

If you want something more generic, think of such a layout:

/usr/lib/liblttng-ust.so
/usr/lib/liblttng-ust-*.so
/usr/lib/liburcu-bp.so
/usr/xenomai/lib/liburcu-bp.so

Then compile your app with RUNPATH=/usr/xenomai/lib and the
xenomai-flavour of  liburcu-bp.so
should be picked up (I believe that works even for preloaded libs).

Norbert
