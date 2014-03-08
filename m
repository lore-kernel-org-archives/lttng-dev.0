From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Babeltrace 1.2.1
Date: Sat, 8 Mar 2014 14:02:30 +0000 (UTC)
Message-ID: <1018068216.34420.1394287350392.JavaMail.zimbra__627.446085172956$1394287387$gmane$org@efficios.com>
References: <1255384434.34419.1394287329430.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WMHpe-0003vG-82
	for lttng-dev@lists.lttng.org; Sat, 08 Mar 2014 09:02:34 -0500
In-Reply-To: <1255384434.34419.1394287329430.JavaMail.zimbra@efficios.com>
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
2014-03-08 Babeltrace 1.2.1
        * Fix: Accept an input port in the live URL when no session is provided

Project website: http://www.efficios.com/babeltrace
Download link: http://www.efficios.com/files/babeltrace/
CTF specification: http://www.efficios.com/ctf


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
