From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] Fix: make check in OOT build with
	absolute path
Date: Fri,  4 Sep 2015 17:31:31 -0400
Message-ID: <1441402291-3306-1-git-send-email-mjeanson__32411.5378004082$1441404529$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZXz9M-0005Y3-QJ
 for lttng-dev@lists.lttng.org; Fri, 04 Sep 2015 18:08:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 53BF33404E9
 for <lttng-dev@lists.lttng.org>; Fri,  4 Sep 2015 21:31:47 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The previous patch fixed the out of tree build when the configure script
was called with a path relative to the builddir but still failed when
the path was absolute. This works with both.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 tests/ust-elf/Makefile.am     | 2 +-
 tests/ust-elf/test_ust_elf.in | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/ust-elf/Makefile.am b/tests/ust-elf/Makefile.am
index 368e427..92337e7 100644
--- a/tests/ust-elf/Makefile.am
+++ b/tests/ust-elf/Makefile.am
@@ -10,5 +10,5 @@ CLEANFILES = $(noinst_SCRIPTS)
 EXTRA_DIST = test_ust_elf.in $(srcdir)/data/**
 
 $(noinst_SCRIPTS): %: %.in
-	sed "s#@TOPSRCDIR@#$(top_srcdir)#g" < $< > $@
+	sed "s#@ABSTOPSRCDIR@#$(abs_top_srcdir)#g" < $< > $@
 	chmod +x $@
diff --git a/tests/ust-elf/test_ust_elf.in b/tests/ust-elf/test_ust_elf.in
index 5cfbff6..03a995f 100755
--- a/tests/ust-elf/test_ust_elf.in
+++ b/tests/ust-elf/test_ust_elf.in
@@ -1,4 +1,4 @@
 #!/bin/bash
 
 TEST_DIR=$(dirname $0)
-./${TEST_DIR}/prog $TEST_DIR/@TOPSRCDIR@/tests/ust-elf
+./${TEST_DIR}/prog @ABSTOPSRCDIR@/tests/ust-elf
-- 
1.9.1
