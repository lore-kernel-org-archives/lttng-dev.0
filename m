From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Clock correlation
Date: Wed, 19 Sep 2012 10:11:31 -0400
Message-ID: <20120919141131.GC16643__38408.8924307891$1348063927$gmane$org@Krystal>
References: <524C960C5DFC794E82BE548D825F05CF5BC6C751@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TEL01-000740-8u
	for lttng-dev@lists.lttng.org; Wed, 19 Sep 2012 10:11:33 -0400
Content-Disposition: inline
In-Reply-To: <524C960C5DFC794E82BE548D825F05CF5BC6C751@EU-MBX-01.mgc.mentorg.com>
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

> We have a problem with kernel and ust traces not correlating in time
> when the option --clock-raw is used. We have used babeltrace
> 1.0.0-rc1.

See commit:

commit 03798a93f959f6c694fe98f5647481947607c604
Author: Julien Desfossez <jdesfossez@efficios.com>
Date:   Fri Aug 3 14:55:00 2012 -0400

    Get rid of clock-raw and use real clock
    =

    The clock-raw does not make much sense except internally, using this
    clock for seeks and with the public API is more complicated than
    necessary.
    =

    This patch replaces the clock-raw by a clock-cycles (does not scale the
    timestamp with the frequency) and make sure all the calls that
    manipulate timestamps use the timestamp in nanoseconds with the offset
    applied.
    That way the user of the API don't need to bother with the "raw"
    timestamp which won't be convenient when dealing with multiple traces
    taken in different timezones.
    =

    Traces output before and after this patch are exactly the same
    and multiple API calls have been tested with real timestamps and
    everything seems to work fine.
    =

    Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

which got into rc5.

This quickly phased-out the --clock-raw option, but introduced a
--clock-cycles that prints timestamps in cycles.

> I have noticed that version 1.0.0-rc5 doesn't have this
> option at all anymore. Why not?

The main reason for this change is the issue you noticed about lack of
time correlation when using the raw time. So instead of changing the
behavior of "--clock-raw", we decided to remove it, and provide a
similar feature (--clock-cycles) that does not impact timestamp
correlation.

> Did anything change in the way
> timestamps and/or time offsets are generated in later versions of the
> kernel and/or user-space tracers? The traces were made with
> lttng-modules 2.0.3 and lttng-ust 2.0.5.

No changes were made to the way timestamps are generated, other than
small fixes (please refer to changelogs for details). This change is
internal to babeltrace, about the way it handle trace merge by
timestamps.

Thanks,

Mathieu

> =

> =

> Cheers,
> =

> Fredrik =D6stman
> =

> http://go.mentor.com/sourceryanalyzer/
> =

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
