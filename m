From: Samuel Martin <s.martin49@gmail.com>
Subject: [PATCH lttng-tools] tests/unit: fix object files'
	location
Date: Wed,  2 Dec 2015 00:36:45 +0100
Message-ID: <1449013005-9745-1-git-send-email-s.martin49__40169.7514848367$1449013079$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <s.martin49@gmail.com>) id 1a3uTf-0007ya-FL
 for lttng-dev@lists.lttng.org; Tue, 01 Dec 2015 18:36:58 -0500
Received: by wmww144 with SMTP id w144so34766597wmw.0
 for <lttng-dev@lists.lttng.org>; Tue, 01 Dec 2015 15:36:49 -0800 (PST)
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

Referring to *.o files under a .libs/ directory is not recommended
because this belongs to libtool's innards.

Indeed, libtool decides to place the *.o files in an
implementation-specific location:
- PIC *.o files go into a .libs/ directory;
- non-PIC *.o files are generated along side to their corresponding
  source files.

Using PIC objects to build executable is legit, thought it may
introduce some minor overhead at runtime.

However, hard-coding these PIC object files in the Makefile.am to build
executables breaks the build in case of static only build.

In this case, no PIC object files is generated, so the linker will not
found some of the needed objects files.

Changing these dependencies' path fixes the static build, keeping the
shared one ok, though the non-PIC object files are now always built.

Fixes #983.

Fix tested on git master and v2.6 with no change needed.

Signed-off-by: Samuel Martin <s.martin49@gmail.com>
---
 tests/unit/Makefile.am | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/unit/Makefile.am b/tests/unit/Makefile.am
index c0c9c45..7bfe65a 100644
--- a/tests/unit/Makefile.am
+++ b/tests/unit/Makefile.am
@@ -34,9 +34,9 @@ SESSIONS=$(top_builddir)/src/bin/lttng-sessiond/session.o	\
 	 $(top_builddir)/src/bin/lttng-sessiond/consumer.o \
 	 $(top_builddir)/src/bin/lttng-sessiond/utils.o \
 	 $(top_builddir)/src/bin/lttng-sessiond/snapshot.o \
-	 $(top_builddir)/src/common/.libs/uri.o \
-	 $(top_builddir)/src/common/.libs/utils.o \
-	 $(top_builddir)/src/common/.libs/error.o \
+	 $(top_builddir)/src/common/uri.o \
+	 $(top_builddir)/src/common/utils.o \
+	 $(top_builddir)/src/common/error.o \
 	 $(top_builddir)/src/common/health/libhealth.la \
 	 $(top_builddir)/src/common/sessiond-comm/libsessiond-comm.la
 
@@ -60,8 +60,8 @@ UST_DATA_TRACE=$(top_builddir)/src/bin/lttng-sessiond/trace-ust.o \
 		   $(top_builddir)/src/bin/lttng-sessiond/session.o \
 		   $(top_builddir)/src/bin/lttng-sessiond/snapshot.o \
 		   $(top_builddir)/src/bin/lttng-sessiond/agent.o \
-		   $(top_builddir)/src/common/.libs/uri.o \
-		   $(top_builddir)/src/common/.libs/utils.o \
+		   $(top_builddir)/src/common/uri.o \
+		   $(top_builddir)/src/common/utils.o \
 		   $(top_builddir)/src/common/health/libhealth.la \
 		   $(top_builddir)/src/common/sessiond-comm/libsessiond-comm.la
 
@@ -75,8 +75,8 @@ endif
 KERN_DATA_TRACE=$(top_builddir)/src/bin/lttng-sessiond/trace-kernel.o	\
 		$(top_builddir)/src/bin/lttng-sessiond/consumer.o	\
 		$(top_builddir)/src/bin/lttng-sessiond/utils.o \
-		$(top_builddir)/src/common/.libs/uri.o \
-		$(top_builddir)/src/common/.libs/utils.o \
+		$(top_builddir)/src/common/uri.o \
+		$(top_builddir)/src/common/utils.o \
 		$(top_builddir)/src/common/health/libhealth.la \
 		$(top_builddir)/src/common/sessiond-comm/libsessiond-comm.la
 
@@ -86,8 +86,8 @@ test_kernel_data_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBRELAYD) $(LIBSESSIOND_COMM)
 test_kernel_data_LDADD += $(KERN_DATA_TRACE)
 
 # utils suffix for unit test
-UTILS_SUFFIX=$(top_builddir)/src/common/.libs/utils.o \
-		$(top_builddir)/src/common/.libs/runas.o
+UTILS_SUFFIX=$(top_builddir)/src/common/utils.o \
+		$(top_builddir)/src/common/runas.o
 
 # parse_size_suffix unit test
 test_utils_parse_size_suffix_SOURCES = test_utils_parse_size_suffix.c
-- 
2.6.2
