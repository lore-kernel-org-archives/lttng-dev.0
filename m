From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: CTF viewing with timeless events
Date: Wed, 22 May 2013 10:04:41 -0400
Message-ID: <519CD079.2010701__42123.2541128576$1369231541$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1Uf9f8-0001HS-8d
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 10:05:06 -0400
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

Hello Tracing fans and mole appreciators,

I was given an interesting corner case and want to explain how I believe
it should be handled.

You are given a trace with no timestamps, and n channels.
How do you display the events?

I propose (and have implemented) that we have a secondary fallback key
to sort events.
Right now, I believe babeltrace will sort by timestamp and that's it.
The eclipse viewer sorts by timestamp and if timestamps match, it sorts
by stream file name.
In one given trace, stream file names are unique like (channel_0).

This means if you have 5 stream files with five events each, it will
always output as
"stream1: e1-e2-e3-e4-e5 stream2: e1-e2-e3-e4-e5 stream3: e1-e2-e3-e4-e5
stream4: e1-e2-e3-e4-e5 stream5: e1-e2-e3-e4-e5"

This should avoid confusion from a reader's perspective.

Comments?
