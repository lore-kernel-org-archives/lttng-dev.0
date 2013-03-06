From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC] New LTTng domain attributes
	(buffer/include/exclude)
Date: Wed, 6 Mar 2013 13:03:13 -0500
Message-ID: <20130306180313.GA9899__35019.8692213327$1362593061$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UDIgT-0001w2-91
	for lttng-dev@lists.lttng.org; Wed, 06 Mar 2013 13:03:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id 132B7140592
	for <lttng-dev@lists.lttng.org>; Wed,  6 Mar 2013 13:03:19 -0500 (EST)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id VRX7Dh5uhOhF for <lttng-dev@lists.lttng.org>;
	Wed,  6 Mar 2013 13:03:13 -0500 (EST)
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

Following a discussion with other LTTng forks, we are coming up with the
following idea to make soon-to-come per-user-id shared buffers for UST
tracing. We'd like to get your feedback.

Here is the idea:

Both for per-process and per-uid (shared) buffers, we'd be working on
the UST domain (-u/--userspace).

We plan to add new attributes to domains:
  --buffers-pid: per PID buffers (current UST 2.0/2.1 behavior)
  --buffers-uid: per user ID buffers (upcoming in UST 2.2)
  --buffers-global: buffers shared across the system (e.g. kernel tracing)

The UST default would stay "--buffers-pid", so just specifying "-u"
without attribute would not change the current behavior.

We plan on doing shortcuts, such as:

  -U: shortcut for -u --buffers-uid

So we can do:

lttng enable-event -U someeventA
lttng enable-event -U someeventB

rather than having to spell out the attribute argument for each
enable-event/enable-channel.

Other future attributes we plan on adding are inclusion/exclusion lists,
followed by a comma-separated list:

  --include-pid 22,33,44
  --include-uid 0,5
  --exclude-pid 12,55
  --exclude-uid 22

We believe these attributes will allow us to add those new configuration
parameters to the toolchain without confusing users.

At the API level (lttng.h), new attribute fields would be added to
struct lttng_domain. The inclusion/exclusion lists would probably be
separate "domain_set_attribute" APIs.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
