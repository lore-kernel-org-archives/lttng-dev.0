From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Babeltrace 1.1.0
Date: Sat, 23 Mar 2013 13:45:01 -0400
Message-ID: <20130323174501.GA30102__7027.84493701092$1364060758$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UJSV4-0003Ee-KL
	for lttng-dev@lists.lttng.org; Sat, 23 Mar 2013 13:45:02 -0400
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

Noteworthy changes:

We had to make important namespacing changes to the user-visible API
between babeltrace 1.0.x and 1.1.0 in order to ensure libbabeltrace does
not with external project symbols and types.

Changelog:
2013-03-23 Babeltrace 1.1.0
        * Reinsert "at end of stream" message for discarded events
        * Improvement: Message from babeltrace concerning discarded
          events needs improvement
        * Cleanup: typo fix
        * Cleanup: add end of line at end of verbose message
        * Fix: misleading message from babeltrace --verbose
        * Fix: babeltrace --fields all  overrides --no-delta
        * Add verbosity to stream id error message
        * Fix: Ensure the specified input format is CTF
        * Fix: Undefined behavior of double free on strlist in get_names_args
        * Fix: ctf-text: don't close stdout
        * Fix: warning message for unexpected trace byte order
        * Namespace the struct declaration
        * Namespace the struct definition
        * Namespace the struct format
        * Namespace the struct mmap_stream
        * Namespace the struct trace_descriptor
        * Namespace struct stream_pos
        * Namespace compliance for dependencies function
        * Cleanup error messages
        * Fix: babeltrace: make '-w' actually work
        * Convert the unit tests to the TAP format
        * Spelling cleanups within comments
        * Move the bitfield test to tests/lib/
        * Fix: Added a null pointer check to bt_ctf_field_name
        * Add babeltrace.pc to gitignore
        * namespacing: place flex/bison symbols under bt_yy namespace
        * namespace the lookup_integer function
        * namespace the definition functions
        * namespace the variant functions
        * namespace the declaration functions
        * namespace the collection functions
        * namespace the heap functions
        * namespace the struct functions
        * namespace the string functions
        * namespace the sequence functions
        * namespace the int functions
        * namespace the enum functions
        * namespace definition_ref and definition_unref
        * namespace declaration_ref and declaration_unref
        * namespace the array functions
        * namespace the scope_path functions
        * Hide internal functions of libbabeltrace-ctf
        * Hide internal functions of ctf-text
        * BT_HIDDEN macro
        * Namespace the lookup_enum function

Project website: http://www.efficios.com/babeltrace
Download link: http://www.efficios.com/files/babeltrace/
CTF specification: http://www.efficios.com/ctf

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
