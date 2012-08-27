From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Babeltrace 1.0.0-rc5
Date: Mon, 27 Aug 2012 08:52:22 -0400
Message-ID: <20120827125222.GA2619__21828.8533892066$1346071973$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T5ynn-00026j-VC
	for lttng-dev@lists.lttng.org; Mon, 27 Aug 2012 08:52:24 -0400
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

Most of the changes in rc5 target libbabeltrace, for which the only
known users outside the babeltrace tree at this stage are lttngtop and
lttv (both under development).

There is one noteworthy change to the babeltrace command line: it now
allows specifying many input trace paths. Also, the default trace text
printout will show the hostname, process name and vpid if those are
available.  (currently, hostname is only exported by master branches of
lttng-modules and lttng-ust, not by stable-2.0).

Along with the "--clock-force-correlate" command line option, we can now
use babeltrace to show traces gathered on different machines at the same
time with lttng's monotonic clock source, which approximate the offset
from epoch.

Changelog:
2012-08-27 Babeltrace 1.0.0-rc5
        * Change default printout to add host, process names and vpid
        * Add support for trace:hostname field
        * Fix: allow specifying more than one input trace path
        * Fix: make warnings (partial errors) visible
        * Fix: --clock-force-correlate to handle trace collections gathered from v
        * Documentation: update API doc with enum functions
        * Fix: API: remove unsupported BT_SEEK_END from API
        * API documentation
        * Cleanup: shut up gcc uninitialized var warning
        * Fix: support large files on 32-bit systems
        * Fix: remove unused fts.h include
        * Fix: add missing enum support to API
        * Fix: handle clock offset with frequency different from 1GHz
        * Cleanup: update ifdef wrapper name
        * Fix: clarify bt_ctf_get_field_list
        * Fix trace-collection.h: No such file or directory that build code with l
        * Fix: check return value of bt_context_create
        * Fix: ensure mmap_base_offset is zeroed on initialization
        * Fix: Reswitch to FTW for add_traces_recursive
        * Fix: don't free unallocated index
        * Fix: don't close the metadata FD if a FP is passed
        * Add BT_SEEK_LAST type to bt_iter_pos
        * Fix: iterator.c BT_SEEK_RESTORE: check return value
        * Fix: complete error handling of babeltrace API
        * cleanup: protected -> hidden: cleanup symbol table
        * Fix: add mmap_base_offset to ctf_stream_pos
        * Fix: assign the current clock for mmap traces
        * Fix: libbabeltrace add missing static declaration
        * Fix: safety checks for opening mmap traces
        * Remove trace-collection.h from include_headers
        * Fix: protect visibility of ctf-parser functions
        * Fix: correct name of bt_ctf_field_get_error in comments and typo in man
        * Fix: wrong type in bt_ctf_get_uint64/int64
        * API cleanup name get_timestamp and get_cycles
        * fix comment struct bt_saved_pos
        * Fix: Add missing clock-types.h
        * Get rid of clock-raw and use real clock
        * Cleanup (messages): Make the wording of the signedness warning clearer
        * Fix: error path if heap_init fails
        * Fix: Remove obsolete bt_iter_seek function
        * Make the signedness warning useful with the field name
        * Fix: Restore heap for SEEK_BEGIN
        * Fix: check if handle is valid
        * Fix: iterator set_pos
        * Fix: get rid of consumed flag
        * Fix: add missing heap_copy
        * Fix: babeltrace assert() triggered by directories within trace
        * Several fixes for bt_iter_pos related functions
        * Fix iterator: various fixes
        * Fix: remove duplicate yydebug var
        * Fix babeltrace iterator lib: seek at time 0

Project website: http://www.efficios.com/babeltrace
Download link: http://www.efficios.com/files/babeltrace/
CTF specification: http://www.efficios.com/ctf

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
