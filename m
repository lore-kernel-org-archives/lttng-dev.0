From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: UST in flight recorder mode
Date: Tue, 17 Jul 2012 10:54:56 -0400
Message-ID: <20120717145456.GA21849__3421.9792382375$1342536932$gmane$org@Krystal>
References: <CAPkDDd7U_jje2_sSgdZyN+GVC8Cvh9hiUefgXhUTKUpAHeRa5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Sr9Ax-00081P-9O
	for lttng-dev@lists.lttng.org; Tue, 17 Jul 2012 10:54:59 -0400
Content-Disposition: inline
In-Reply-To: <CAPkDDd7U_jje2_sSgdZyN+GVC8Cvh9hiUefgXhUTKUpAHeRa5w@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?S=E9bastien_Barth=E9l=E9my?= <barthelemy@crans.org>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* S=E9bastien Barth=E9l=E9my (barthelemy@crans.org) wrote:
> Hello,
> =

> I'm currently tracking a bug which causes a  full system freeze. It
> occurs during long running tests (after a few hours).
> =

> The system kernel is too old for being traced with LTTng, but we have a f=
ew
> UST tracepoints which I used while tracking another bug last year.
> =

> I would welcome any advice regarding a methodology to catch it.
> =

> My best idea yet is to
> =

> 1. add tracepoints  where we suspect the bug to reside
> 2. setup lttng to record in flight recorder mode

Unfortunately, even though you can set the kernel and UST tracer
channels to "--overwrite" mode, lttng-tools does not support flight
recorder mode yet.  This feature is planned for 2.1 or 2.2. It means
that you'd have to manually stop the consumer daemon while you gather
data, and only unstop it when you want to dump your buffers, if you want
to "simulate" a kind-of-working flight recorder mode.

> 3. trig the trace dump when a problem occurs
> =

> Right now, we generate not much traces, so I can just skip steps 2 and 3.
> However, I'm thinking about having having LTTng always on in the
> future, and
> thus I would need to use the flight recorder mode.
> =

> I have not found explanations or examples on how to trig the trace dump
> from software. Is there any?

We plan to implement a --snapshot command, to take a snapshot of a
flight recorder trace.

> I had a look at lttng/ust-ctl.h, which seems to be the one header I need.
> =

> I also found an old article where Mathieu was talking about "triggerring
> tracepoints", does it exist?

Not at this point.

> =

> I also saw some commits about a "filter" feature. This sound interesting
> can someone explain in a few words what this is about?

Filtering out events based on a filtering expression, directly at the
trace source, e.g.:

lttng enable-event 'ust_tests_hello:tptest' --filter 'intfield>500 && intfi=
eld<503' -u

will only record events for which the "intfield" has values within the
requested range.

One future step, once we get the snapshot command in, will be to
implement actions (or triggers), so the evaluation of some filter
expression can lead to, e.g., taking a flight recorder buffer snapshot.

Hoping this helps,

Thanks,

Mathieu

> =

> Cheers
> =

> -- Sebastian
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
