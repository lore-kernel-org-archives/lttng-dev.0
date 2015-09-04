From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Fix: make check in OOT build with
	absolute path
Date: Fri,  4 Sep 2015 17:23:12 -0400
Message-ID: <1441401792-18815-1-git-send-email-mjeanson__12443.3136581958$1441403676$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZXyvD-0005OT-8W
 for lttng-dev@lists.lttng.org; Fri, 04 Sep 2015 17:53:48 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

The previous patch fixed the out of tree build when the configure script
was called with a path relative to the builddir but still failed when
the path was absolute. This works with both.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 tests/bin/Makefile.am        | 2 +-
 tests/bin/test_trace_read.in | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/bin/Makefile.am b/tests/bin/Makefile.am
index 0245238..086919b 100644
--- a/tests/bin/Makefile.am
+++ b/tests/bin/Makefile.am
@@ -3,5 +3,5 @@ CLEANFILES = $(noinst_SCRIPTS)
 EXTRA_DIST = test_trace_read.in
 
 $(noinst_SCRIPTS): %: %.in
-	sed "s#@TOPSRCDIR@#$(top_srcdir)#g" < $< > $@
+	sed "s#@ABSTOPSRCDIR@#$(abs_top_srcdir)#g" < $< > $@
 	chmod +x $@
diff --git a/tests/bin/test_trace_read.in b/tests/bin/test_trace_read.in
index f9410e5..761fd05 100755
--- a/tests/bin/test_trace_read.in
+++ b/tests/bin/test_trace_read.in
@@ -20,7 +20,7 @@ TESTDIR=$CURDIR/..
 
 BABELTRACE_BIN=$CURDIR/../../converter/babeltrace
 
-CTF_TRACES=$CURDIR/@TOPSRCDIR@/tests/ctf-traces
+CTF_TRACES=@ABSTOPSRCDIR@/tests/ctf-traces
 
 source $TESTDIR/utils/tap/tap.sh
 
-- 
1.9.1
