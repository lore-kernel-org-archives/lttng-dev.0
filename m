From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] Fix: out of tree build of java agents
Date: Thu, 25 Jun 2015 19:10:54 -0400
Message-ID: <1435273854-19722-1-git-send-email-mjeanson__15611.9410916746$1435273934$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1Z8GIj-0006Ky-HG
 for lttng-dev@lists.lttng.org; Thu, 25 Jun 2015 19:11:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5D2E8340406
 for <lttng-dev@lists.lttng.org>; Thu, 25 Jun 2015 23:11:16 +0000 (UTC)
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

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 liblttng-ust-java-agent/jni/jul/Makefile.am   | 2 +-
 liblttng-ust-java-agent/jni/log4j/Makefile.am | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/liblttng-ust-java-agent/jni/jul/Makefile.am b/liblttng-ust-java-agent/jni/jul/Makefile.am
index 6c9dc28..d0d6d78 100644
--- a/liblttng-ust-java-agent/jni/jul/Makefile.am
+++ b/liblttng-ust-java-agent/jni/jul/Makefile.am
@@ -1,4 +1,4 @@
-AM_CPPFLAGS = -I$(top_srcdir)/include
+AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include
 
 lib_LTLIBRARIES = liblttng-ust-jul-jni.la
 liblttng_ust_jul_jni_la_SOURCES = lttng_ust_jul.c \
diff --git a/liblttng-ust-java-agent/jni/log4j/Makefile.am b/liblttng-ust-java-agent/jni/log4j/Makefile.am
index b734bf3..7acbccd 100644
--- a/liblttng-ust-java-agent/jni/log4j/Makefile.am
+++ b/liblttng-ust-java-agent/jni/log4j/Makefile.am
@@ -1,4 +1,4 @@
-AM_CPPFLAGS = -I$(top_srcdir)/include
+AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include
 lib_LTLIBRARIES = liblttng-ust-log4j-jni.la
 liblttng_ust_log4j_jni_la_SOURCES = lttng_ust_log4j.c \
 				  lttng_ust_log4j.h
-- 
1.9.1
