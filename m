From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [RELEASE] LTTng-analyses v0.1
Date: Wed, 04 Feb 2015 11:06:21 -0500
Message-ID: <54D2437D.7030802__15350.7189163522$1423066064$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([85.12.144.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1YJ2TG-0005vm-Di
 for lttng-dev@lists.lttng.org; Wed, 04 Feb 2015 11:06:32 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: diamon-discuss@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: lttng-dev@lists.lttng.org

Hi everyone,

I am glad to announce the very first release of the lttng-analyses project !
https://github.com/lttng/lttng-analyses

This project is a collection of tools to extract metrics and
higher-level informations from LTTng kernel traces.

Here is a complete example that illustrates how to solve a real-world
problem with this project:
http://lttng.org/blog/2015/02/04/web-request-latency-root-cause/

The workflow with these tools is different from the traditional
debugging/monitoring tools. We trace the whole system and then analyse
the trace offline. So the cost of analysing the trace is done outside of
production. The project benefits from the low overhead of LTTng to
mostly target hard to identify performance/latency problems.

Here is the list of the implemented analyses in this release:
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

I would like to thank everyone who contributed ideas, code, reviews and
funding on this project that started almost a year ago !

Julien
