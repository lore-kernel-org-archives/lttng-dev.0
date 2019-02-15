From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools] RFC: Enforce DL_LIBS value
 instead of hard coded -ldl
Date: Fri, 15 Feb 2019 14:52:17 -0500
Message-ID: <20190215195217.5012-2-ylamarre__40330.4614753992$1550260407$gmane$org@efficios.com>
References: <20190215195217.5012-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 441P756yqRzgB7
 for <lttng-dev@lists.lttng.org>; Fri, 15 Feb 2019 14:52:33 -0500 (EST)
In-Reply-To: <20190215195217.5012-1-ylamarre@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Generated makefiles would ignore DL_LIBS value selected by configure
script and use the hard coded value -ldl. Generated makefiles will
now use DL_LIBS.

Refs: #1165

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
 src/common/testpoint/Makefile.am                           | 2 +-
 tests/regression/ust/baddr-statedump/Makefile.am           | 2 +-
 tests/regression/ust/ust-dl/Makefile.am                    | 2 +-
 tests/utils/testapp/userspace-probe-sdt-binary/Makefile.am | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/common/testpoint/Makefile.am b/src/common/testpoint/Makefile.am
index 5c15725e..a2f9d407 100644
--- a/src/common/testpoint/Makefile.am
+++ b/src/common/testpoint/Makefile.am
@@ -1,4 +1,4 @@
 noinst_LTLIBRARIES = libtestpoint.la
 
 libtestpoint_la_SOURCES = testpoint.h testpoint.c
-libtestpoint_la_LIBADD = -ldl
+libtestpoint_la_LIBADD = $(DL_LIBS)
diff --git a/tests/regression/ust/baddr-statedump/Makefile.am b/tests/regression/ust/baddr-statedump/Makefile.am
index bf327179..bf51f948 100644
--- a/tests/regression/ust/baddr-statedump/Makefile.am
+++ b/tests/regression/ust/baddr-statedump/Makefile.am
@@ -6,7 +6,7 @@ AM_CPPFLAGS += -I$(srcdir) -g
 
 noinst_PROGRAMS = prog
 prog_SOURCES = prog.c tp.c tp.h
-prog_LDADD = -llttng-ust -ldl
+prog_LDADD = -llttng-ust $(DL_LIBS)
 
 noinst_SCRIPTS = test_baddr-statedump test_baddr-statedump.py
 EXTRA_DIST = test_baddr-statedump test_baddr-statedump.py
diff --git a/tests/regression/ust/ust-dl/Makefile.am b/tests/regression/ust/ust-dl/Makefile.am
index 9889e85a..c51e072f 100644
--- a/tests/regression/ust/ust-dl/Makefile.am
+++ b/tests/regression/ust/ust-dl/Makefile.am
@@ -19,7 +19,7 @@ AM_CPPFLAGS += -I$(srcdir) -g
 
 noinst_PROGRAMS = prog
 prog_SOURCES = prog.c
-prog_LDADD = -ldl
+prog_LDADD = $(DL_LIBS)
 
 noinst_LTLIBRARIES = libzzz.la libbar.la libfoo.la libtp.la
 
diff --git a/tests/utils/testapp/userspace-probe-sdt-binary/Makefile.am b/tests/utils/testapp/userspace-probe-sdt-binary/Makefile.am
index e86939b4..d79ce0ea 100644
--- a/tests/utils/testapp/userspace-probe-sdt-binary/Makefile.am
+++ b/tests/utils/testapp/userspace-probe-sdt-binary/Makefile.am
@@ -3,7 +3,7 @@ BUILT_SOURCES = foobar_provider.h
 
 noinst_PROGRAMS = userspace-probe-sdt-binary
 userspace_probe_sdt_binary_SOURCES = userspace-probe-sdt-binary.c sema.h sema.c
-userspace_probe_sdt_binary_LDADD = foobar_provider.o libfoo.la libbar.la -ldl
+userspace_probe_sdt_binary_LDADD = foobar_provider.o libfoo.la libbar.la $(DL_LIBS)
 userspace_probe_sdt_binary_CFLAGS = -I$(abs_builddir)
 nodist_userspace_probe_sdt_binary_SOURCES = $(abs_builddir)/foobar_provider.h
 
-- 
2.11.0
