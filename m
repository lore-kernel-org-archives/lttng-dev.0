From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH babeltrace 3/5] Tests: Split lib tests in
	multiple standalone test scripts
Date: Tue, 20 Aug 2013 17:38:19 -0400
Message-ID: <1377034701-5142-3-git-send-email-christian.babeux__31065.9119896174$1377035177$gmane$org@efficios.com>
References: <1377034701-5142-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f48.google.com ([209.85.128.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1VBtdS-0005Q2-OK
	for lttng-dev@lists.lttng.org; Tue, 20 Aug 2013 17:38:49 -0400
Received: by mail-qe0-f48.google.com with SMTP id 3so557793qea.21
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 14:38:37 -0700 (PDT)
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

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 .gitignore                       |  4 ++--
 tests/lib/Makefile.am            |  5 +----
 tests/lib/runall.sh              |  9 ---------
 tests/lib/test_seek_big_trace    | 23 +++++++++++++++++++++++
 tests/lib/test_seek_empty_packet | 23 +++++++++++++++++++++++
 5 files changed, 49 insertions(+), 15 deletions(-)
 delete mode 100755 tests/lib/runall.sh
 create mode 100755 tests/lib/test_seek_big_trace
 create mode 100755 tests/lib/test_seek_empty_packet

diff --git a/.gitignore b/.gitignore
index 49297cc..2b5af7e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,5 +1,5 @@
-/tests/lib/test-bitfield
-/tests/lib/test-seeks
+/tests/lib/test_bitfield
+/tests/lib/test_seek
 *.o
 *.a
 *.la
diff --git a/tests/lib/Makefile.am b/tests/lib/Makefile.am
index a7de0a9..dac6a73 100644
--- a/tests/lib/Makefile.am
+++ b/tests/lib/Makefile.am
@@ -17,7 +17,4 @@ noinst_PROGRAMS = test_seek test_bitfield
 test_seek_SOURCES = test_seek.c
 test_bitfield_SOURCES = test_bitfield.c
 
-EXTRA_DIST = runall.sh
-
-check-am:
-	./runall.sh
+EXTRA_DIST = test_seek_big_trace test_seek_empty_packet
diff --git a/tests/lib/runall.sh b/tests/lib/runall.sh
deleted file mode 100755
index 5c28299..0000000
--- a/tests/lib/runall.sh
+++ /dev/null
@@ -1,9 +0,0 @@
-#!/bin/sh
-# run Seeks tests
-# With a trace than contains empty packets
-./test_seek ../ctf-traces/succeed/wk-heartbeat-u/ 1351532897586558519 1351532897591331194
-# With a bigger trace
-./test_seek ../ctf-traces/succeed/lttng-modules-2.0-pre5/ 61334174524234 61336381998396
-
-# run bitfield tests
-./test_bitfield
diff --git a/tests/lib/test_seek_big_trace b/tests/lib/test_seek_big_trace
new file mode 100755
index 0000000..732934f
--- /dev/null
+++ b/tests/lib/test_seek_big_trace
@@ -0,0 +1,23 @@
+#!/bin/sh
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
+CURDIR=$(dirname $0)/
+TESTDIR=$CURDIR/../
+CTF_TRACES=$TESTDIR/ctf-traces
+
+$CURDIR/test_seek $CTF_TRACES/succeed/lttng-modules-2.0-pre5/ 61334174524234 61336381998396
diff --git a/tests/lib/test_seek_empty_packet b/tests/lib/test_seek_empty_packet
new file mode 100755
index 0000000..b6ac3c6
--- /dev/null
+++ b/tests/lib/test_seek_empty_packet
@@ -0,0 +1,23 @@
+#!/bin/sh
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
+CURDIR=$(dirname $0)/
+TESTDIR=$CURDIR/../
+CTF_TRACES=$TESTDIR/ctf-traces
+
+$CURDIR/test_seek $CTF_TRACES/succeed/wk-heartbeat-u/ 1351532897586558519 1351532897591331194
-- 
1.8.3.4
