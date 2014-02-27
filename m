From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Babeltrace 1.2.0-rc2
Date: Thu, 27 Feb 2014 18:10:22 +0000 (UTC)
Message-ID: <2074543268.31813.1393524622584.JavaMail.zimbra__49095.0174084448$1393524695$gmane$org@efficios.com>
References: <250156299.31811.1393524575626.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WJ5Pi-0000I9-PQ
	for lttng-dev@lists.lttng.org; Thu, 27 Feb 2014 13:10:36 -0500
In-Reply-To: <250156299.31811.1393524575626.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, tiwg@multicore-association.or
List-Id: lttng-dev@lists.lttng.org

The Babeltrace project provides trace read and write libraries, as well
as a trace converter. Plugins can be created for any trace format to
allow its conversion to/from another trace format.

The main format expected to be converted to/from is the Common Trace
Format (CTF). The default input format of the "babeltrace" command is
CTF, and its default output format is a human-readable text log. The
"babeltrace-log" command converts from a text log to a CTF trace.

Noteworthy: only bugfixes here. We plan a final release tomorrow,
synchronized with LTTng 2.4 final.

Changelog:
2014-02-27 Babeltrace 1.2.0-rc2
        * Fix: events discarded timing inaccuracy
        * Fix: Move offset endianness conversion to get_data_packet
        * Fix: Remove negative comparison to unsigned value
        * Fix: Uninitialized scalar variable
        * Fix: Don't assert on metadata generation failure
        * Fix: add missing SIGTERM and SIGINT handler
        * Fix: Reverse incorrect error message argument order
        * Cleanup: add brackets to lttng-live-plugin.c
        * Cleanup lttng-live: add brackets in lttng_live_read()
        * Cleanup lttng-live: 80 columns wrapping
        * Fix: handle new streams in get_data_packet()
        * Fix: accept empty metadata on append
        * Fix: lttng-live: 100ms active poll delay
        * Fix: lttng-live await metadata
        * Fix: lttng-live recv() and send() flags, partial recv()
        * Fix: missing little endian conversion for one index field
        * Cleanup: remove logically dead code
        * Fix: untrusted value as argument
        * Fix: off by one in lttng-live path length check
        * Fix: fclose return value unchecked
        * Fix: call to append metadata when new metadata is added
        * Fix: use memstream instead of tmp file for live metadata
        * Fix: assign a trace handle to every live trace
        * Fix: get_new_metadata receive all the metadata
        * Fix: Coverity warning CWE-457: Use of Uninitialized Variable
        * Revert "Fix: get_new_metadata receive all the metadata"
        * Revert "Fix: assign a trace handle to every live trace"
        * Fix: assign a trace handle to every live trace
        * Fix: get_new_metadata receive all the metadata
        * CTF: Support incremental metadata append
        * Fix: ctf.c fscanf missing integer length check
        * Bump soname version to 1.0.0
        * Move scanner allocation/free outside of ctf_open_trace_metadata_read
        * CTF parser: prepare for incremental metadata parsing
        * Python bindings: return char arrays as strings in value()
        * Python bindings: sched_switch example clean-up
        * Fix: add missing test scripts to Makefile.am


Project website: http://www.efficios.com/babeltrace
Download link: http://www.efficios.com/files/babeltrace/
CTF specification: http://www.efficios.com/ctf


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
