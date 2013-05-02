From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: LTTng-UST 2.0 mutex usage
Date: Thu, 2 May 2013 16:36:07 -0400
Message-ID: <20130502203606.GG15675__1581.71789157695$1367527000$gmane$org@Krystal>
References: <524C960C5DFC794E82BE548D825F05CF2834A6E5@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UY0Ea-0006UR-PU
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 16:36:08 -0400
Content-Disposition: inline
In-Reply-To: <524C960C5DFC794E82BE548D825F05CF2834A6E5@EU-MBX-01.mgc.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Oestman, Fredrik" <Fredrik_Oestman@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Oestman, Fredrik (Fredrik_Oestman@mentor.com) wrote:
> Hi,
> =

> =

> We're experimenting with tracing calls to the pthreads library using a
> LD_PRELOAD-ed interposer library, which is instrumented with UST
> tracepoints. In the startup phase, before the application has been
> called, probes are being registered, and one by one the tracepoints
> start emitting events. So some of the pthreads mutex motions of UST
> itself are being traced along.
> =

> What would be a good way of avoiding emitting events before the
> application itself has started, specifically events related to UST
> mutexes?

one way would be to implement mutexes within lttng-ust, so we would stop
using the pthread mutexes.

> The ust-ctl library appears to have a function ustctl_register_done(),
> is that useful?

No. This function is called by the session daemon when it has completed
sending all commands to the application so its internal lttng-ust state
matches that of the active tracing sessions.

We need to be aware that a lttng-ust library can interact with up to 2
session daemons: one for the user, one for root.

> (Is there an API documentation?) Or would it be better
> to find out which mutexes belong to UST and filter them out?

custom implementation of mutexes within lttng-ust sounds like the best
approach.

Thanks,

Mathieu

> By controlling our interposer library from within the application we
> can avoid the problem, but we'd rather do without recompiling the
> application, since it sort of would defeat the reason for using
> LD_PRELOAD in the first place.
> =

> =

> Cheers,
> =

> Fredrik =D6stman
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
