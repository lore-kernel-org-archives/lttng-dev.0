From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH babeltrace 5/5] Tests: Use Perl prove as the
	testsuite runner
Date: Tue, 20 Aug 2013 17:38:21 -0400
Message-ID: <1377034701-5142-5-git-send-email-christian.babeux__30058.5415134721$1377035377$gmane$org@efficios.com>
References: <1377034701-5142-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1VBtda-0005QS-61
	for lttng-dev@lists.lttng.org; Tue, 20 Aug 2013 17:38:56 -0400
Received: by mail-qc0-f170.google.com with SMTP id i8so544184qcq.29
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 14:38:44 -0700 (PDT)
In-Reply-To: <1377034701-5142-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This commit modify the make check target to run Perl prove as the
testsuite runner.

$ cd babeltrace/tests
$ ./run.sh tests

One can also run tests manually using prove:

$ prove --exec '' path/to/test

    OR

$ prove --exec '' - < testlist

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/Makefile.am |  3 +++
 tests/run.sh      | 22 ++++++++++++++++++++++
 tests/tests       |  4 ++++
 3 files changed, 29 insertions(+)
 create mode 100755 tests/run.sh
 create mode 100644 tests/tests

diff --git a/tests/Makefile.am b/tests/Makefile.am
index b03b7e0..c0ea34e 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -1,3 +1,6 @@
 SUBDIRS = utils bin lib
 
 EXTRA_DIST = ctf-traces/**
+
+check-am:
+	./run.sh tests
diff --git a/tests/run.sh b/tests/run.sh
new file mode 100755
index 0000000..c6c50fd
--- /dev/null
+++ b/tests/run.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+#
+# Copyright (C) 2013 - Christian Babeux <christian.babeux@efficios.com>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; only version 2
+# of the License.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+#
+
+[ -z "$1" ] && echo "Error: No testlist. Please specify a testlist to run." && exit 1
+
+prove --merge --exec '' - < $1
diff --git a/tests/tests b/tests/tests
new file mode 100644
index 0000000..10efa4b
--- /dev/null
+++ b/tests/tests
@@ -0,0 +1,4 @@
+bin/test_trace_read
+lib/test_bitfield
+lib/test_seek_empty_packet
+lib/test_seek_big_trace
\ No newline at end of file
-- 
1.8.3.4
