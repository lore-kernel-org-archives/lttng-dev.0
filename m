From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Babeltrace 1.2.2
Date: Tue, 22 Jul 2014 19:04:01 +0000 (UTC)
Message-ID: <638816839.18364.1406055841907.JavaMail.zimbra__17007.5402748354$1406157220$gmane$org@efficios.com>
References: <1716407469.18362.1406055814624.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XA5iK-0001KS-W7
 for lttng-dev@lists.lttng.org; Wed, 23 Jul 2014 19:12:50 -0400
In-Reply-To: <1716407469.18362.1406055814624.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
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

2014-07-22 Babeltrace 1.2.2
        * Fix: Support out of tree builds in babeltrace
        * Fix: mmap trace read the stream_id from the first packet
        * Fix: check the lttng-relayd protocol version
        * Fix: don't update the trace collection if no new streams were received
        * Fix (Python bindings): Return a string if a sequence's element are chars
        * Fix: don't use a return code in _bt_ctf_stream_append_discarded_events
        * Fix: Report the sequence's length field's value as length
        * Fix: Variable name typo in SequenceField and Event classes
        * Fix python: remove weird char at the end of line
        * Fix: add missing files to gitignore
        * Fix: ctf-text: add missing double-quotes around enum tag
        * Fix: Add missing lttng_live_should_quit checks
        * Fix: Report errors occuring in lttng_live_read

Project website: http://www.efficios.com/babeltrace
Download link: http://www.efficios.com/files/babeltrace/
CTF specification: http://www.efficios.com/ctf

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
