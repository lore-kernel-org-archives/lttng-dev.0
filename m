From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Babeltrace 1.0.3
Date: Thu, 24 Jan 2013 12:14:04 -0500
Message-ID: <20130124171404.GB1677__43310.316062025$1359047723$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TyQNK-0006CA-7X
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 12:14:06 -0500
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

Important note: we discovered some unplanned symbol clash in exported
shared objects, and namespace clashes for 3 structure declarations in
the headers: struct definition, struct declaration and struct
stream_pos. In order to not introduce API changes within the 1.0.x
series, fixing these issues will require us to release a 1.1.0.
Therefore, Babeltrace 1.0.3 will likely be the last of the 1.0.x series,
moving to 1.1.x afterward.

Changelog:
2012-01-24 Babeltrace 1.0.3
        * Fix: Double free when calling bt_context_remove_trace()
        * Add missing runall.sh to dist packaging
        * Fix: alignment of compound types containing array field

Project website: http://www.efficios.com/babeltrace
Download link: http://www.efficios.com/files/babeltrace/
CTF specification: http://www.efficios.com/ctf

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
