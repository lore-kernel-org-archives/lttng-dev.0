From: Charles Briere <charlesbriere.flatzo@gmail.com>
Subject: [PATCH lttng-tools 01/14] Adding some checks for
	Android specific libraries to the configure step
Date: Mon,  6 May 2013 18:18:38 +0000
Message-ID: <1367864331-15212-1-git-send-email-charlesbriere.flatzo__19526.747291866$1367864369$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <charlesbriere.flatzo@gmail.com>) id 1UZQ03-0008WG-4d
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 14:18:59 -0400
Received: by mail-qe0-f46.google.com with SMTP id f6so2249423qej.33
	for <lttng-dev@lists.lttng.org>; Mon, 06 May 2013 11:18:53 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: Charles Briere <charlesbriere.flatzo@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Charles Briere <charlesbriere.flatzo@gmail.com>
---
 configure.ac                        | 34 ++++++++++++++++++++++++++++++----
 src/bin/lttng-consumerd/Makefile.am |  6 +++++-
 src/bin/lttng-relayd/Makefile.am    |  9 ++++++++-
 src/bin/lttng-sessiond/Makefile.am  |  6 +++++-
 tests/unit/Makefile.am              | 18 +++++++++++++-----
 5 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4f85fc1..eee025a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -41,6 +41,12 @@ AS_IF([test "x$libtool_fixup" = "xyes"],
 
 AM_CONDITIONAL([NO_SHARED], [test x$enable_shared = xno])
 
+AM_CONDITIONAL([TARGET_HOST_ANDROID], [false])
+case "${host}" in
+    *-*-linux-androideabi) AM_CONDITIONAL([TARGET_HOST_ANDROID], [true])
+    ;;
+esac
+
 AC_CHECK_HEADERS([ \
 	sys/types.h unistd.h fcntl.h string.h pthread.h limits.h \
 	signal.h stdlib.h sys/un.h sys/socket.h stdlib.h stdio.h \
@@ -108,12 +114,24 @@ AC_DEFINE_UNQUOTED([CONFIG_SESSIOND_BIN], "$SESSIOND_BIN", [Location of the sess
 
 # Check for pthread
 AC_CHECK_LIB([pthread], [pthread_create], [],
-	[AC_MSG_ERROR([Cannot find libpthread. Use [LDFLAGS]=-Ldir to specify its location.])]
+[
+    # Check for pthread in a bionic libc...
+	AC_CHECK_LIB([c], [pthread_create], [], 
+	[
+	    AC_MSG_ERROR([Cannot find libpthread. Use [LDFLAGS]=-Ldir to specify its location.])
+	])
+]
 )
 
 # Check libpopt
 AC_CHECK_LIB([popt], [poptGetContext], [],
-	[AC_MSG_ERROR([Cannot find libpopt. Use [LDFLAGS]=-Ldir to specify its location.])]
+[
+	# Check for libpopt in oprofile for Android
+	AC_CHECK_LIB([oprofile_popt], [poptGetContext], [], 
+    [
+        AC_MSG_ERROR([Cannot find libpopt. Use [LDFLAGS]=-Ldir to specify its location.])
+    ])
+]
 )
 
 # Check for libuuid
@@ -130,7 +148,15 @@ AC_CHECK_LIB([uuid], [uuid_generate],
 		have_libc_uuid=yes
 	],
 	[
-		AC_MSG_ERROR([Cannot find libuuid uuid_generate nor libc uuid_create. Use [LDFLAGS]=-Ldir to specify their location.])
+		# uuid_create not found in libc, check for bionic's impl in e2fsprog.
+		AC_CHECK_LIB([ext2_uuid], [uuid_generate],
+		[
+			AC_DEFINE_UNQUOTED([LTTNG_HAVE_LIBEXT2_UUID], 1, [Has libext2_uuid uuid support.])
+			have_libext2_uuid=yes
+		],
+		[
+			AC_MSG_ERROR([Cannot find libuuid uuid_generate, libc uuid_create nor libext2_uuid uuid_generate. Use [LDFLAGS]=-Ldir to specify their location.])
+		])
 	])
 ]
 )
@@ -175,7 +201,7 @@ AS_IF([test "x$lttng_ust_support" = "xyes"], [
 			lttng_ust_ctl_found=yes
 		],
 		[AC_MSG_ERROR([Cannot find LTTng-UST 2.1.x. Use [LDFLAGS]=-Ldir to specify its location, or specify --disable-lttng-ust to build lttng-tools without LTTng-UST support.])],
-		[-lurcu-common -lurcu-bp -lurcu-cds -lrt]
+		[-lurcu-common -lurcu-bp -lurcu-cds -lc -lrt]
 	)
 ])
 AM_CONDITIONAL([HAVE_LIBLTTNG_UST_CTL], [test "x$lttng_ust_ctl_found" = xyes])
diff --git a/src/bin/lttng-consumerd/Makefile.am b/src/bin/lttng-consumerd/Makefile.am
index a418eb4..c38590e 100644
--- a/src/bin/lttng-consumerd/Makefile.am
+++ b/src/bin/lttng-consumerd/Makefile.am
@@ -4,7 +4,7 @@ lttnglibexec_PROGRAMS = lttng-consumerd
 
 lttng_consumerd_SOURCES = lttng-consumerd.c lttng-consumerd.h
 
-lttng_consumerd_LDADD = -lrt \
+lttng_consumerd_LDADD = \
 	   $(top_builddir)/src/common/libconsumer.la \
 	   $(top_builddir)/src/common/sessiond-comm/libsessiond-comm.la \
 	   $(top_builddir)/src/common/libcommon.la
@@ -12,3 +12,7 @@ lttng_consumerd_LDADD = -lrt \
 if HAVE_LIBLTTNG_UST_CTL
 lttng_consumerd_LDADD += -llttng-ust-ctl
 endif
+
+if !TARGET_HOST_ANDROID
+lttng_consumerd_LDADD += -lrt 
+endif
diff --git a/src/bin/lttng-relayd/Makefile.am b/src/bin/lttng-relayd/Makefile.am
index ed82144..cb9076a 100644
--- a/src/bin/lttng-relayd/Makefile.am
+++ b/src/bin/lttng-relayd/Makefile.am
@@ -11,10 +11,17 @@ lttng_relayd_SOURCES = main.c lttng-relayd.h utils.h utils.c cmd.h \
                        cmd-2-1.c cmd-2-1.h \
                        cmd-2-2.c cmd-2-2.h
 
+if !TARGET_HOST_ANDROID
+lttng_relayd_LDADD = -lrt
+else
+lttng_relayd_LDADD = 
+endif
+
 # link on liblttngctl for check if relayd is already alive.
-lttng_relayd_LDADD = -lrt -lurcu-common -lurcu \
+lttng_relayd_LDADD += -lurcu-common -lurcu \
 		$(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la \
 		$(top_builddir)/src/common/sessiond-comm/libsessiond-comm.la \
 		$(top_builddir)/src/common/hashtable/libhashtable.la \
 		$(top_builddir)/src/common/libcommon.la \
 		$(top_builddir)/src/common/compat/libcompat.la
+
diff --git a/src/bin/lttng-sessiond/Makefile.am b/src/bin/lttng-sessiond/Makefile.am
index 244bc70..63e9555 100644
--- a/src/bin/lttng-sessiond/Makefile.am
+++ b/src/bin/lttng-sessiond/Makefile.am
@@ -37,7 +37,7 @@ endif
 lttng_sessiond_SOURCES += lttng-sessiond.h main.c
 
 # link on liblttngctl for check if sessiond is already alive.
-lttng_sessiond_LDADD = -lrt -lurcu-common -lurcu \
+lttng_sessiond_LDADD = -lurcu-common -lurcu \
 		$(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la \
 		$(top_builddir)/src/common/sessiond-comm/libsessiond-comm.la \
 		$(top_builddir)/src/common/kernel-ctl/libkernel-ctl.la \
@@ -49,4 +49,8 @@ lttng_sessiond_LDADD = -lrt -lurcu-common -lurcu \
 
 if HAVE_LIBLTTNG_UST_CTL
 lttng_sessiond_LDADD += -llttng-ust-ctl
+endif 
+
+if !TARGET_HOST_ANDROID
+lttng_sessiond_LDADD += -lrt
 endif
diff --git a/tests/unit/Makefile.am b/tests/unit/Makefile.am
index c9e1bfc..3a59a7c 100644
--- a/tests/unit/Makefile.am
+++ b/tests/unit/Makefile.am
@@ -33,8 +33,7 @@ SESSIONS=$(top_srcdir)/src/bin/lttng-sessiond/session.c	\
 	 $(top_srcdir)/src/common/error.c
 
 test_session_SOURCES = test_session.c $(SESSIONS)
-test_session_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBSESSIOND_COMM) $(LIBHASHTABLE) \
-					 -lrt
+test_session_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBSESSIOND_COMM) $(LIBHASHTABLE)
 
 # UST data structures unit test
 if HAVE_LIBLTTNG_UST_CTL
@@ -53,7 +52,11 @@ UST_DATA_TRACE=$(top_srcdir)/src/bin/lttng-sessiond/trace-ust.c \
 
 test_ust_data_SOURCES = test_ust_data.c $(UST_DATA_TRACE)
 test_ust_data_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBSESSIOND_COMM) $(LIBHASHTABLE) \
-					  -lrt -llttng-ust-ctl
+					  -llttng-ust-ctl
+if !TARGET_HOST_ANDROID
+test_ust_data_LDADD += -lrt
+endif
+
 endif
 
 # Kernel data structures unit test
@@ -64,5 +67,10 @@ KERN_DATA_TRACE=$(top_srcdir)/src/bin/lttng-sessiond/trace-kernel.c	\
 		$(top_srcdir)/src/common/utils.c
 
 test_kernel_data_SOURCES = test_kernel_data.c $(KERN_DATA_TRACE)
-test_kernel_data_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBSESSIOND_COMM) $(LIBHASHTABLE) \
-						 -lrt
+test_kernel_data_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBSESSIOND_COMM) $(LIBHASHTABLE)
+
+if !TARGET_HOST_ANDROID
+test_session_LDADD += -lrt
+test_kernel_data_LDADD += -lrt
+endif
+
-- 
1.8.1.msysgit.1
