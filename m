From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: notrace missing in lttng-ust
Date: Mon, 1 Oct 2012 11:29:01 -0400
Message-ID: <20121001152901.GA13944__22847.1071379774$1349105392$gmane$org@Krystal>
References: <4FED6718.1000205@mentor.com> <20120630181600.GB30747@Krystal>
	<4FF2A31D.9020100@mentor.com> <20120717141301.GA21204@Krystal>
	<506916A9.2050308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TIhva-0007BM-SW
	for lttng-dev@lists.lttng.org; Mon, 01 Oct 2012 11:29:02 -0400
Content-Disposition: inline
In-Reply-To: <506916A9.2050308@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Giraldeau <francis.giraldeau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> Le 2012-07-17 10:13, Mathieu Desnoyers a =E9crit :
> > * Woegerer, Paul (Paul_Woegerer@mentor.com) wrote:
> >> Hi Mathieu,
> >>
> >> here is the revised patch that makes tracepoint.h and  =

> >> ust-tracepoint-event.h robust against -finstrument-functions.
> > =

> > I think we want to make the notrace always active. I don't see the point
> > in letting UST lib be compiled with those tracing stubs in place.
> =

> I just hit a case where it would have been useful to profile lttng-ust
> itself.
> =

> When generating events in a tight loop, the average time to execute a
> simple tracepoint is about 280ns on my machine. But the problem is that
> once in a while (once out of a million execution) the latency bump to a
> blazing 100us. I agree, it's still fast, but nonetheless the maximum is
> ~350 times more than the average, which is strange.

interesting indeed. I would expect this time might be spent in the
"write" to the fifo to wakeup the consumerd, but even then it is
surprising, as this is supposed to be a non-blocking fifo.

> I tried many profiling tools (perf, valgrind, etc.) and none was
> providing good results. It's no point to use lttng-ust itself (are
> tracepoints reentrants?).

that might not work indeed. Something about infinite recursion.

You might want to try kernel tracing, and see if this time is spent
anywhere in the kernel when doing UST tracing.

> So, I decided to try -finstrument-functions
> stuff with a small pre-allocated ringbuffer to get the lowest latency
> possible. Well, it turns out that I was getting no results for the
> tracepoint, because function instrumentation is disabled.

no, don't. you'll run into infinite recursion too.

> =

> I tried to re-enable it, but then the instrumented app fails with this
> error message:
> =

> /usr/local/include/lttng/ust-tracepoint-event.h:646:
> __lttng_events_init__npt: Assertion `!ret' failed.

Doing something like that might require that you LD_PRELOAD
liblttng-ust-tracepoint.so, so that its constructor runs before the
constructor registering the .so that contains the function callback.

Thanks,

Mathieu

> =

> I confess that I didn't look deeply into this problem, but it's quite
> strange that the init fails in the case function instrumentation is
> enabled. Could it be related to the dlopen() done at registration? Maybe
> somebody has an idea, because I saw screenshots of similar profiling
> previously on the ML ;) Here is the configuration options to lttng-ust
> (the profiling library is miniprof[1]):
> =

> ./configure CFLAGS=3D"-finstrument-functions" LIBS=3D"-lminiprof"
> LDFLAGS=3D"-L/usr/local/lib -Wl,-E"
> =

> Cheers,
> =

> Francis
> =

> [1] https://github.com/giraldeau/miniprof
> =




-- =

Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
