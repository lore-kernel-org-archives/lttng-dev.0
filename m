From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [RELEASE] LTTng-analyses v0.2
Date: Mon, 25 May 2015 15:51:12 -0400
Message-ID: <55637D30.7050604__28726.4889142991$1432583564$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1YwyP9-0008J3-LS
 for lttng-dev@lists.lttng.org; Mon, 25 May 2015 15:51:28 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, diamon-discuss@lists.linuxfoundation.org
Cc: Antoine Busque <antoine.busque@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Hi everyone,

I am glad to announce the second release of the lttng-analyses project !
https://github.com/lttng/lttng-analyses

This project is a collection of tools to extract metrics and
higher-level informations from LTTng kernel traces.

This is mostly a one-man-release: Antoine Busque did all the work of
refactoring, cleaning up the code and fixing a number of bugs.
Thanks to this work, we know have a nice architecture that will allow us
to add more analyses and integrate with other tools.

The implemented analyses did not change from the previous release, but
you might notice some differences from the output of the previous release:
- CPU usage per-process and system-wide
- Process CPU migration count
- Memory usage per-process and system-wide (as seen by the kernel)
- I/O usage (syscalls, disk, network)
- I/O operations log (with latency and usage)
- I/O latency statistics (aggregated open, read, write, sync operations)
- I/O latency frequency distribution
- Interrupt handler duration statistics (count, min, max, average stdev)
- Interrupt handler duration top
- Interrupt handler duration log
- Interrupt handler duration frequency distribution
- SoftIRQ handler latency statistics
- Syscalls usage statistics

We appreciate all kinds of feedback, use-cases and real-world
experiences, so please test it and let us know what you think about it.

Julien
