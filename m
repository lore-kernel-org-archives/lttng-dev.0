From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Fix: Do not install health tests
	helper libraries
Date: Mon,  5 Nov 2012 16:20:13 -0500
Message-ID: <1352150413-16685-1-git-send-email-christian.babeux__27438.4660101079$1352150497$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TVU6P-0007vg-Hm
	for lttng-dev@lists.lttng.org; Mon, 05 Nov 2012 16:21:01 -0500
Received: by mail-ie0-f176.google.com with SMTP id k11so10030956iea.35
	for <lttng-dev@lists.lttng.org>; Mon, 05 Nov 2012 13:20:56 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The libraries libhealthexit and libhealthstall should not be
installed on the user system. They are only useful for the
health check tests.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/tools/health/Makefile.am | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/tools/health/Makefile.am b/tests/tools/health/Makefile.am
index 9fab582..d1d4919 100644
--- a/tests/tools/health/Makefile.am
+++ b/tests/tools/health/Makefile.am
@@ -10,8 +10,6 @@ endif
 
 UTILS=
 
-lib_LTLIBRARIES=libhealthexit.la libhealthstall.la
-
 # Health thread exit ld_preloaded test lib
 libhealthexit_la_SOURCES=health_exit.c
 libhealthexit_la_LDFLAGS= -module
@@ -21,6 +19,7 @@ libhealthstall_la_SOURCES=health_stall.c
 libhealthstall_la_LDFLAGS= -module
 
 noinst_PROGRAMS = health_check
+noinst_LTLIBRARIES = libhealthexit.la libhealthstall.la
 
 health_check_SOURCES = health_check.c $(UTILS)
 health_check_LDADD = $(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la \
-- 
1.8.0
