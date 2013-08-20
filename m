From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC] Babeltrace: LGPL plugins
Date: Tue, 20 Aug 2013 15:56:09 -0400
Message-ID: <20130820195609.GA3684__8536.25908862359$1377028627$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VBs2E-0007VX-A4
	for lttng-dev@lists.lttng.org; Tue, 20 Aug 2013 15:56:15 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: tiwg@multicore-association.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

Babeltrace is currently MIT/BSD-style licensed (except list.h, a header
containing trivial 10-lines-or-less functions which does not make the
code using it derived work).

We've been considering allowing LGPL plugins into babeltrace for a while
now for a few reasons. Mainly, we'd like to be able to take code like
the filter bytecode interpreter from LTTng-UST (which is LGPLv2.1) and
merge it into Babeltrace.

One possible way to deal with this is to allow LGPL plugins in the
babeltrace tree. We could even have configure options to disable build
of LGPL plugins entirely, pretty much like ffmpeg is doing for GPL.

The goal here is to ensure that Babeltrace can still be used as a
reference implementation of CTF writer/reader under a BSD-style license
without inhibiting development of other features that would make it more
useful.

Creating a separate project for the LGPL plugins seems like a lot of
overhead, and, frankly, I don't think the licensing question is
sufficient to justify the overhead of creating another project.

Comments/feedback is welcome,

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
