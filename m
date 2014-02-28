From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Babeltrace 1.2.0
Date: Fri, 28 Feb 2014 18:16:09 +0000 (UTC)
Message-ID: <1483653033.32401.1393611369672.JavaMail.zimbra__21991.42215909$1393611434$gmane$org@efficios.com>
References: <2141248164.32385.1393611290811.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WJRyk-0006dF-JV
	for lttng-dev@lists.lttng.org; Fri, 28 Feb 2014 13:16:16 -0500
In-Reply-To: <2141248164.32385.1393611290811.JavaMail.zimbra@efficios.com>
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

New and noteworthy features in the 1.2 release of Babeltrace:

1) lttng-live input plugin to read live streams with LTTng 2.4.

Getting up and running with live for kernel tracing in a nutshell
through localhost (adapt to use over the network):

# assumes you installed lttng 2.4 packages already
lttng-relayd -d  # as root
lttng-sessiond -d  # as root
lttng create mysession --live 1000000 -U net://localhost
lttng enable-event -k -a
lttng start
babeltrace -i lttng-live net://localhost   # list the viewable sessions
babeltrace -i lttng-live net://localhost/host/${HOSTNAME}/mysession
# ... now getting live view of the kernel trace ...

See LTTng Tools live-reading-howto.txt and Babeltrace lttng-live.txt
for details.

2) CTF writer library

C/C++ library and Python bindings to write CTF traces.

See include/babeltrace/ctf-writer/*.h for details.

3) Babeltrace Python bindings

Allow reading and writing CTF traces from Python. See doc/python-howto.txt
for details.

4) CTF indexes support

Support index files extension of the Common Trace Format. Those are generated
starting from LTTng 2.4.

Changelog:
2014-02-28 Babeltrace 1.2.0
        * Fix: lttng-live parse url port check

Project website: http://www.efficios.com/babeltrace
Download link: http://www.efficios.com/files/babeltrace/
CTF specification: http://www.efficios.com/ctf

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
