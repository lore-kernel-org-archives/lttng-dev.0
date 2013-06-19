From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Babeltrace 1.1.1
Date: Tue, 18 Jun 2013 21:06:54 -0400
Message-ID: <20130619010654.GA20379__19026.6032041565$1371604055$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Up6rW-0001cD-OB
	for lttng-dev@lists.lttng.org; Tue, 18 Jun 2013 21:07:02 -0400
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

Changelog:

2013-06-18 Babeltrace 1.1.1
        * Compare traces by stream path as secondary key
        * Fix: use index, not cur_index, for SEEK_SET validation
        * Fix: ctf-text irregular output with disabled field names
        * Support old compilers
        * Remove useless variable assignment
        * Fix: Remove extra quote after an include directive
        * Don't dereference before NULL check
        * eliminate dead code
        * fix babeltrace-log error checking
        * Fix resource leak on error path
        * Fix: handle error checking should compare against NULL
        * Remove unused array in bt_context_add_traces_recursive
        * Fix: Suppress a compiler warning (always-false condition)
        * Cleanup: remove trailing whitespaces
        * Move memstream.h and uuid.h to include/babeltrace/compat directory
        * Fix: handling of empty streams
        * Add new option --clock-offset-ns
        * Fix: add missing error return when create_event_definitions fails
        * Fix: ctf-text should link on libbabeltrace-ctf
        * Move clock to bt_trace_descriptor
        * Remove unused stream_heap
        * Move trace collection pointer to bt_trace_descriptor
        * Move bt_handle to bt_trace_descriptor
        * Move bt_context to bt_trace_descriptor
        * Privatize struct bt_trace descriptor, move trace path
        * Add backward ref from bt_stream_pos to bt_trace_descriptor
        * Fix kFreeBSD build
        * Fix: babeltrace-log timestamps should be in nsec
        * Use objstack for AST allocation
        * Remove unused gc field
        * Use objstack to store nodes
        * Use objstack for strings
        * Implement objstack for parser
        * Fix: octal and hex string handling
        * Simplify error node
        * Lexer cleanup
        * Fix: invalid integer suffix parsing
        * Test cleanup
        * Test cleanup
        * Test cleanup
        * Fix: bootstrap should call libtoolize
        * Fix bootstrap script
        * Use uint64_t for packet_map_len
        * Add smalltrace succeed/fail test cases
        * Support packets and trace files smaller than page size
        * Move ctf-metadata plugin into its own shared object
        * Implement ctf-metadata output plugin
        * Handle make_node errors with TLS dummy node
        * Remove nested expressions
        * Eliminate dead code
        * Fix: trace_collection_add() add after check
        * Handle integers in lexer rather than grammar
        * Implement perror printf
        * Support escape characters in metadata strings
        * Add error node to AST
        * Introduce macro to enforce matching enum to string for node types
        * Fix: add semantic check in grammar
        * Implement likely/unlikely ifdefs
        * Fix unary constant use after error
        * Use new print macros in ctf-parser.y
        * Print error on invalid token
        * Implement macros for error printout
        * Add line number to parser nodes
        * Fix: handle errors gracefully
        * Fix: memleak on error path
        * Add missing NULL pointer check
        * Show token in CTF parser error
        * Remove unused lineno from struct ctf_scanner
        * Show line numbers in CTF parser errors
        * Ignore Windows-style EOL character in metadata
        * Replace AM_PROG_MKDIR obsolete macro with AC_PROG_MKDIR_P

Project website: http://www.efficios.com/babeltrace
Download link: http://www.efficios.com/files/babeltrace/
CTF specification: http://www.efficios.com/ctf

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
