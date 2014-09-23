From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Babeltrace 1.2.3
Date: Tue, 23 Sep 2014 16:51:45 +0000 (UTC)
Message-ID: <1391032763.26824.1411491105058.JavaMail.zimbra__47440.638280432$1411491029$gmane$org@efficios.com>
References: <1182512523.26823.1411491061379.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XWTHD-0006tI-0l
 for lttng-dev@lists.lttng.org; Tue, 23 Sep 2014 12:49:24 -0400
In-Reply-To: <1182512523.26823.1411491061379.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: Jeremie Galarneau <jgalar@efficios.com>, tiwg@multicore-association.org
List-Id: lttng-dev@lists.lttng.org

The Babeltrace project provides trace read and write libraries, as well
as a trace converter. Plugins can be created for any trace format to
allow its conversion to/from another trace format.

The main format expected to be converted to/from is the Common Trace
Format (CTF). The default input format of the "babeltrace" command is
CTF, and its default output format is a human-readable text log. The
"babeltrace-log" command converts from a text log to a CTF trace.

Changelog:
2014-09-23 Babeltrace 1.2.3
        * Fix: incorrect compiler warning
        * Fix: Don't assume that PROT_WRITE grants read permissions
        * Fix: align objstack on 8 bytes
        * Fix Python: Add a comment warning about an API limitation
        * Use BABELTRACE_HOST_NAME_MAX in test_ctf_writer.c
        * Add limits compatibility header
        * Fix: don't perform unaligned integer read/writes
        * Fix: Align buffers from objstack_alloc on sizeof(void *)
        * Fix: bt_ctf_field_type_structure_add_field argument validation

Project website: http://www.efficios.com/babeltrace
Download link: http://www.efficios.com/files/babeltrace/
CTF specification: http://www.efficios.com/ctf

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
