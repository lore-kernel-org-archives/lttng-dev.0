From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Babeltrace 1.0.2
Date: Fri, 11 Jan 2013 09:51:10 -0500
Message-ID: <20130111145110.GA15036__10491.9969024651$1357915922$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Ttfwy-00088Y-U0
	for lttng-dev@lists.lttng.org; Fri, 11 Jan 2013 09:51:17 -0500
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, tiwg@multicore-association.org
List-Id: lttng-dev@lists.lttng.org

The Babeltrace project provides trace read and write libraries, as well
as a trace converter. Plugins can be created for any trace format to
allow its conversion to/from another trace format.

The main format expected to be converted to/from is the Common Trace
Format (CTF). The default input format of the "babeltrace" command is
CTF, and its default output format is a human-readable text log. The
"babeltrace-log" command converts from a text log to a CTF trace.

Please note that the 1.0.1 tarball does not build, this is why we skip
from 1.0.0 to 1.0.2 directly.

Changelog:

2012-01-11 Babeltrace 1.0.2
        * Fix: add tests/lib missing files to Makefile.am

2012-01-11 Babeltrace 1.0.1
        * Provides a basic pkg-config file for libbabeltrace
        * Fix erroneous warning/error messages
        * Fix comment in context.h
        * Cleanup: Remove whitespace at EOL from mit-license.txt
        * Add missing permission notice in each source file
        * Adding a test which do a sequence of seek BEGIN, LAST, BEGIN, LAST
        * Run seek tests on a second trace file
        * Add #define _GNU_SOURCE to remove warning about asprintf
        * Include a test for SEEK_BEGIN and SEEK_LAST
        * Fix: Report success even if we find at least one valid stream in find_max_timestamp_ctf_stream_class
        * Fix SEEK_BEGIN for streams that do not contain any event

Project website: http://www.efficios.com/babeltrace
Download link: http://www.efficios.com/files/babeltrace/
CTF specification: http://www.efficios.com/ctf

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
