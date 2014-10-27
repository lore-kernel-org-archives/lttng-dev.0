From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 04/24] Fix : Only link librt if
	available
Date: Mon, 27 Oct 2014 20:49:28 +0000
Message-ID: <1414442926-14381-5-git-send-email-c.briere__43758.128982927$1414443043$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout2.w2.samsung.com ([211.189.100.12]
 helo=usmailout2.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirEN-0007nj-Tt
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:38 -0400
Received: from uscpsbgex3.samsung.com
 (u124.gpu85.samsung.co.kr [203.254.195.124]) by mailout2.w2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE400GQTF6I9B30@mailout2.w2.samsung.com> for
 lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:30 -0400 (EDT)
In-reply-to: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Content-language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "jeremie.galarneau@efficios.com" <jeremie.galarneau@efficios.com>, "dgoulet@efficios.com" <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "karim.yaghmour@opersys.com" <karim.yaghmour@opersys.com>
List-Id: lttng-dev@lists.lttng.org

From: Charles Briere <c.briere@samsung.com>

Signed-off-by: Charles Briere <c.briere@samsung.com>
---
 configure.ac                            | 15 ++++++++++++++-
 src/bin/lttng-consumerd/Makefile.am     |  2 +-
 src/bin/lttng-relayd/Makefile.am        |  2 +-
 src/bin/lttng-sessiond/Makefile.am      |  2 +-
 src/common/Makefile.am                  |  2 +-
 src/common/sessiond-comm/Makefile.am    |  3 ++-
 tests/regression/tools/live/Makefile.am |  3 ++-
 tests/unit/Makefile.am                  |  9 ++++++---
 8 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/configure.ac b/configure.ac
index 487a2b9..8703284 100644
--- a/configure.ac
+++ b/configure.ac
@@ -167,6 +167,19 @@ AC_CHECK_LIB([uuid], [uuid_generate],
 	])
 ]
 )
+
+# Check for librt
+AC_CHECK_LIB([rt], [shm_open],
+[
+	AC_SUBST(LIBRT, '-lrt')
+	librt='-lrt'
+],
+[
+	AC_SUBST(LIBRT, '')
+	ilibrt=''
+]
+)
+
 AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBUUID], [test "x$have_libuuid" = "xyes"])
 AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBC_UUID], [test "x$have_libc_uuid" = "xyes"])
 
@@ -247,7 +260,7 @@ AS_IF([test "x$lttng_ust_support" = "xyes"], [
 			lttng_ust_ctl_found=yes
 		],
 		[AC_MSG_ERROR([Cannot find LTTng-UST >= 2.2.x. Use --with-lttng-ust-prefix=PREFIX to specify its location, or specify --disable-lttng-ust to build lttng-tools without LTTng-UST support.])],
-		[-lurcu-common -lurcu-bp -lurcu-cds -lrt]
+		[-lurcu-common -lurcu-bp -lurcu-cds $librt]
 	)
 ])
 AM_CONDITIONAL([HAVE_LIBLTTNG_UST_CTL], [test "x$lttng_ust_ctl_found" = xyes])
diff --git a/src/bin/lttng-consumerd/Makefile.am b/src/bin/lttng-consumerd/Makefile.am
index 28034ca..8d7a675 100644
--- a/src/bin/lttng-consumerd/Makefile.am
+++ b/src/bin/lttng-consumerd/Makefile.am
@@ -14,7 +14,7 @@ lttng_consumerd_LDADD = \
 	   $(top_builddir)/src/common/index/libindex.la \
 	   $(top_builddir)/src/common/health/libhealth.la \
 	   $(top_builddir)/src/common/testpoint/libtestpoint.la \
-	   -lrt
+	   @LIBRT@
 
 if HAVE_LIBLTTNG_UST_CTL
 lttng_consumerd_LDADD += -llttng-ust-ctl
diff --git a/src/bin/lttng-relayd/Makefile.am b/src/bin/lttng-relayd/Makefile.am
index 126cdaf..4700f1a 100644
--- a/src/bin/lttng-relayd/Makefile.am
+++ b/src/bin/lttng-relayd/Makefile.am
@@ -20,7 +20,7 @@ lttng_relayd_SOURCES = main.c lttng-relayd.h utils.h utils.c cmd.h \
                        connection.c connection.h
 
 # link on liblttngctl for check if relayd is already alive.
-lttng_relayd_LDADD = -lrt -lurcu-common -lurcu \
+lttng_relayd_LDADD = @LIBRT@ -lurcu-common -lurcu \
 		$(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la \
 		$(top_builddir)/src/common/sessiond-comm/libsessiond-comm.la \
 		$(top_builddir)/src/common/hashtable/libhashtable.la \
diff --git a/src/bin/lttng-sessiond/Makefile.am b/src/bin/lttng-sessiond/Makefile.am
index 7819222..cf75082 100644
--- a/src/bin/lttng-sessiond/Makefile.am
+++ b/src/bin/lttng-sessiond/Makefile.am
@@ -42,7 +42,7 @@ endif
 lttng_sessiond_SOURCES += lttng-sessiond.h main.c
 
 # link on liblttngctl for check if sessiond is already alive.
-lttng_sessiond_LDADD = -lrt -lurcu-common -lurcu \
+lttng_sessiond_LDADD = @LIBRT@ -lurcu-common -lurcu \
 		$(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la \
 		$(top_builddir)/src/common/sessiond-comm/libsessiond-comm.la \
 		$(top_builddir)/src/common/kernel-ctl/libkernel-ctl.la \
diff --git a/src/common/Makefile.am b/src/common/Makefile.am
index 3a2f4f0..974ce7c 100644
--- a/src/common/Makefile.am
+++ b/src/common/Makefile.am
@@ -21,7 +21,7 @@ libcommon_la_SOURCES = error.h error.c utils.c utils.h runas.c runas.h \
                        daemonize.c daemonize.h
 libcommon_la_LIBADD = \
 		-luuid \
-		-lrt \
+		@LIBRT@ \
 		$(top_builddir)/src/common/config/libconfig.la
 
 # Consumer library
diff --git a/src/common/sessiond-comm/Makefile.am b/src/common/sessiond-comm/Makefile.am
index fdffa40..23d8e68 100644
--- a/src/common/sessiond-comm/Makefile.am
+++ b/src/common/sessiond-comm/Makefile.am
@@ -6,4 +6,5 @@ noinst_LTLIBRARIES = libsessiond-comm.la
 libsessiond_comm_la_SOURCES = sessiond-comm.c sessiond-comm.h \
                               unix.c unix.h inet.c inet.h inet6.c inet6.h \
                               relayd.h agent.h
-libsessiond_comm_la_LIBADD = -lrt
+
+libsessiond_comm_la_LIBADD = @LIBRT@
diff --git a/tests/regression/tools/live/Makefile.am b/tests/regression/tools/live/Makefile.am
index ea5f417..4b99022 100644
--- a/tests/regression/tools/live/Makefile.am
+++ b/tests/regression/tools/live/Makefile.am
@@ -30,7 +30,8 @@ endif
 
 live_test_SOURCES = live_test.c
 live_test_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBRELAYD) $(LIBSESSIOND_COMM) \
-				  $(LIBHASHTABLE) $(LIBHEALTH) -lrt
+				  $(LIBHASHTABLE) $(LIBHEALTH) @LIBRT@
+
 live_test_LDADD += $(LIVE) \
 				   $(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la
 
diff --git a/tests/unit/Makefile.am b/tests/unit/Makefile.am
index dd3dd8c..169ab68 100644
--- a/tests/unit/Makefile.am
+++ b/tests/unit/Makefile.am
@@ -43,7 +43,8 @@ SESSIONS=$(top_builddir)/src/bin/lttng-sessiond/session.o	\
 
 test_session_SOURCES = test_session.c
 test_session_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBRELAYD) $(LIBSESSIOND_COMM) \
-		     $(LIBHASHTABLE) -lrt
+		     $(LIBHASHTABLE) @LIBRT@
+
 test_session_LDADD += $(SESSIONS)
 
 # UST data structures unit test
@@ -67,7 +68,8 @@ UST_DATA_TRACE=$(top_builddir)/src/bin/lttng-sessiond/trace-ust.o \
 
 test_ust_data_SOURCES = test_ust_data.c
 test_ust_data_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBRELAYD) $(LIBSESSIOND_COMM)\
-		      $(LIBHASHTABLE) -lrt -llttng-ust-ctl
+		      $(LIBHASHTABLE) @LIBRT@ -llttng-ust-ctl
+
 test_ust_data_LDADD += $(UST_DATA_TRACE)
 endif
 
@@ -82,7 +84,8 @@ KERN_DATA_TRACE=$(top_builddir)/src/bin/lttng-sessiond/trace-kernel.o	\
 
 test_kernel_data_SOURCES = test_kernel_data.c
 test_kernel_data_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBRELAYD) $(LIBSESSIOND_COMM) \
-			 $(LIBHASHTABLE) -lrt
+			 $(LIBHASHTABLE) @LIBRT@
+
 test_kernel_data_LDADD += $(KERN_DATA_TRACE)
 
 # utils suffix for unit test
-- 
2.1.2
