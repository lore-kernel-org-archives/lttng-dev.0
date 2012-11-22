From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-tools 2.1.0-rc8
Date: Thu, 22 Nov 2012 14:36:36 -0500
Message-ID: <50AE7EC4.8010809__4515.11617652631$1353613065$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TbcZl-0007Hm-8Q
	for lttng-dev@lists.lttng.org; Thu, 22 Nov 2012 14:36:41 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 1A4101873A5
	for <lttng-dev@lists.lttng.org>; Thu, 22 Nov 2012 14:37:55 -0500 (EST)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TtbZdozekeE6 for <lttng-dev@lists.lttng.org>;
	Thu, 22 Nov 2012 14:37:54 -0500 (EST)
Received: from 127.0.0.1 (cable-13.246.173-198.electronicbox.net
	[173.246.13.198])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 1EFC31873A3
	for <lttng-dev@lists.lttng.org>; Thu, 22 Nov 2012 14:37:54 -0500 (EST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Greetings everyone (including LTTng elves),

The lttng-tools project provides a session daemon (lttng-sessiond)
that acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd
for network streaming.

Ok so here is what happened. The lttng-ust tracer RC2 now supports
enabling different filters and/or loglevels for the same event which had
to be supported in lttng-tools before releasing the stable version.

That said, the lttng_set_event_filter() changed to
lttng_enable_event_with_filter(). This is due to the fact that, now with
lttng-ust, we need to keep track of events by the name/filter/loglevel
triplet rather than the event name only. For that, we needed a call that
passes these three attributes at once. The original lttng_enable_event
is still available but sets the filter to NULL.

Now, the lttng_disable_event() still only takes an event name which will
disable *all* events by that name regardless of the filter or/and loglevel.

Note that this is *not* an API breakage. We only changed the filter call
introduce in the 2.1 development cycle.

Also, the -e, --event from the lttng add-context command was removed
since lttng-ust does not support this feature (adding a context to an
event). Still, adding a context to a channel is now the only possible
option.

In a nutshell, with lttng-tools RC8 you are able to do things like that:

$ lttng enable-event ust* -u --loglevel TRACE_CRIT
$ lttng enable-event ust* -u --loglevel-only TRACE_DEBUG

Which will record every ust* wildcard event of TRACE_CRIT level and
DEBUG only.

Same concept for filters:

$ lttng enable-event ust* -u --filter "intfield < 3"
$ lttng enable-event ust-test* -u --filter "intfield > 15"

Here is the full Changelog.

2012-11-22 lttng-tools 2.1.0-rc8
    * Fix: Uninit. variable in lttng view
    * Add already enabled UST event error code
    * lttng.h API update: set filter becomes enable event with filter
    * Change the UST event hash table match function
    * Pass lttng_event struct to the set_filter API call
    * Adding context to an event is no longer possible
    * Add UST overlap tests
    * Add filter sequence number to UST
    * Fix: Typo from a previous patch in an assert()
    * Fix: Warn if session is running with lttng view
    * Fix: Add bash requirement to README for make check
    * Fix: add the notion of domain to lttng.1 man page
    * Enable additional kernel probes
    * Update CodingStyle
    * Use the new functions for default subbuf sizes
    * Add default subbuf sizes getter functions
    * Add max() and min() macro in common

Please feel free to email the list about any questions/comments
concerning this release.

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.1.0-rc8.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David
