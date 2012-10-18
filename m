From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Babeltrace 1.0.0-rc6
Date: Thu, 18 Oct 2012 16:50:10 -0400
Message-ID: <20121018205010.GA21434__24101.6720109203$1350593450$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TOx2h-0005Ln-Tu
	for lttng-dev@lists.lttng.org; Thu, 18 Oct 2012 16:50:11 -0400
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

We had enough fixes for another round of rc release before 1.0 final.
Mainly fixed all kinds of memory leaks, which became important when
libbabeltrace was introduced, and the scope of babeltrace became more
than just trace conversion.

Changelog:
2012-10-18 Babeltrace 1.0.0-rc6
	* Add valgrind suppression file for libpopt
	* Fix: unplug memory leak that causes popt-0.13 to segfault
	* Fix: test all close/fclose ret val, fix double close
	* Cleanup: add missing newline
	* Fix: fd leak on trace close
	* Fix memory leaks induced by lack of libpopt documentation
	* babeltrace: fix poptGetOptArg memleak
	* plugins: implement plugin unregister
	* Doc: valgrind with babeltrace (glib workaround)
	* callsites: fix memory leak
	* Fix: free all the metadata-related memory
	* Fix : Free the iterator callback arrays
	* Fix : cleanup teardown of context
	* Fix : protect static float and double declarations
	* callsite: support instruction pointer field
	* Document that list.h is LGPLv2.1, but entirely trivial
	* Fix: callsite support: list multiple callsites
	* Add callsite support
	* Fix: Allow 64-bit packet offset
	* Fix: emf uri: surround by " "
	* Handle model.emf.uri event info
	* Fix: Documentation cleanup
	* Fix: misplaced C++ ifdef
	* Fix babeltrace-log get big line when the input file last line don't have enter
	* API Fix: bt_ctf_iter_read_event_flags
	* Fix: get encoding for char arrays and sequences
	* Fix: access to declaration from declaration_field
	* Fix: get_declaration_* should not cast to field
	* Fix babeltrace-log uninitialized memory (v2)
	* Revert "Fix babeltrace-log uninitialized memory"
	* Fix babeltrace-log uninitialized memory
	* Fix: access field properties by declaration
	* Fix: check return value of get_char_array
	* Fix: C++ support to API header files

Project website: http://www.efficios.com/babeltrace
Download link: http://www.efficios.com/files/babeltrace/
CTF specification: http://www.efficios.com/ctf

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
