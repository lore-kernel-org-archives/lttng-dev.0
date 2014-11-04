From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Babeltrace 1.2.4
Date: Tue, 4 Nov 2014 19:25:14 +0000 (UTC)
Message-ID: <1749279063.7467.1415129114372.JavaMail.zimbra__16211.2403814264$1415129191$gmane$org@efficios.com>
References: <2046333991.7462.1415128710599.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XljjH-0008FP-Ca
 for lttng-dev@lists.lttng.org; Tue, 04 Nov 2014 14:25:28 -0500
In-Reply-To: <2046333991.7462.1415128710599.JavaMail.zimbra@efficios.com>
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

This is a bugfix release.

Changelog:
2014-11-04 Babeltrace 1.2.4
        * Fix: make sure we can exit the get_new_metadata loop
        * Docs fix: Change bt_ctf_writer_create_stream return description
        * Fix: offset_s and CTF clocks with frequency != 1GHz


Project website: http://www.efficios.com/babeltrace
Download link: http://www.efficios.com/files/babeltrace/
CTF specification: http://www.efficios.com/ctf


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
