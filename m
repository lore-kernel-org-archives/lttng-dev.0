From: David Goulet <dgoulet@efficios.com>
Subject: [RFC] Changes to the stop command
Date: Wed, 10 Oct 2012 13:11:53 -0400
Message-ID: <5075AC59.3050704__31078.7519942552$1349889148$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TLzp6-0005bs-WF
	for lttng-dev@lists.lttng.org; Wed, 10 Oct 2012 13:11:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id A068F1872CC
	for <lttng-dev@lists.lttng.org>; Wed, 10 Oct 2012 13:12:25 -0400 (EDT)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jNl0yYq1J49E for <lttng-dev@lists.lttng.org>;
	Wed, 10 Oct 2012 13:12:25 -0400 (EDT)
Received: from 127.0.0.1 (cable-13.246.173-198.electronicbox.net
	[173.246.13.198])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id D299718724F
	for <lttng-dev@lists.lttng.org>; Wed, 10 Oct 2012 13:12:24 -0400 (EDT)
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

Hi everyone,

We discovered a week ago a "broken guarantee" which is that when a
session is stopped by either using the lttng command or the API call
lttng_stop_session the traced data MUST be ready to be read.

However, we don't offer that at all for now for both local storage and
network streaming. The stop command/call simply does _not_ wait for that
state.

Here is the proposal to fix this issue before the 2.1 stable release.
Let's add a new API call (extending it) that probes the session daemon
for the trace files state (still writing, no more data, closed, ...).

Ex: lttng_data_state(handle)

This will bring a change to the default behavior of the stop command.
From now on, it will wait by default until the data is available to read
(for both network and local). This will however be done on the client
side in order to avoid blocking the session daemon client command sub
system for an unknown amount of time.

The way I propose we proceed is to use the new API call (mention above)
on the liblttng-ctl side when a stop is done that requires it to wait.
Unfortunately, there is no clean way to do that other than an active
loop polling the session daemon...

The "no wait" use case of the stop command will also be added with a
lttng_stop_session_no_wait or something like that.

In a nutshell:

(new) lttng_data_state(handle) --> name is NOT final, please chip in for
ideas! :)
(new) lttng_stop_session_no_wait(session_name) --> naming NOT final.

(changes) lttng stop (and lttng_stop_session) will now wait for the data
to be available so babeltrace could be use right after for instance. A
--no-wait will be added as well to the UI command.

I would like everyone opinion on that because this is an important issue
that _MUST_ be fixed in 2.1 stable or at least in the 2.1.x series.

Thanks a lot!
David
