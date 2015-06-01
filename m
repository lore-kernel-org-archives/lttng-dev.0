From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [RELEASE] LTTngTop v0.3
Date: Mon, 01 Jun 2015 14:48:41 -0400
Message-ID: <556CA909.6000705__43591.1403307275$1433184587$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1YzUlU-0007tX-CW
 for lttng-dev@lists.lttng.org; Mon, 01 Jun 2015 14:48:54 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi everyone,

I am glad to announce the new release of LTTngTop !
git://git.lttng.org/lttngtop.git

LttngTop is an ncurses interface for reading and browsing traces
recorded by the LTTng tracer and displaying various statistics.
As of now, the cpu usage, per file/process I/O bandwidth, perf counters
and kprobe hits are displayed.

This release is the first one that handles live and offline sessions, so
you can just run "lttngtop" without any arguments and it will
automatically create and attach a local live session. You can also use
the -r argument to connect to a remote relay and attach to a remote trace.

Along with this release comes the lttngtoptrace tool that aims to
simplify the usage of LTTng live in situation where you want something
strace-alike but with more flexibility (multi-processes, whole system,
kprobe support, CPU migrations, etc) and less perturbation on the target
system.

If someone is interested to contribute to this software, I have tons of
improvement ideas and no time to implement them, so please feel free to
step in !
The 2 main topics are: rewrite in C++ with a proper state system
library, more complete I/O syscall support, semi-live enabling of perf
counters and kprobes, getting rid of the contexts (requires the state
system rework), etc.

Special thanks to Michael Jeanson for pressuring me to do this long
overdue release !

We appreciate all kinds of feedbacks, so please test it and let us know
what you think about it.

Thanks,

Julien
