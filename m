From: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Subject: [PATCH lttng-tool] Fix: mi: missing files on make dist
Date: Tue, 29 Jul 2014 15:24:16 -0400
Message-ID: <1406661856-20600-1-git-send-email-jonathan.r.julien__8369.81004472381$1406661952$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@ericsson.com>)
 id 1XCD11-0005wK-O6
 for lttng-dev@lists.lttng.org; Tue, 29 Jul 2014 15:24:57 -0400
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

Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
---
 src/common/Makefile.am                | 1 +
 tests/regression/tools/mi/Makefile.am | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/common/Makefile.am b/src/common/Makefile.am
index 4b623c8..7011d97 100644
--- a/src/common/Makefile.am
+++ b/src/common/Makefile.am
@@ -12,6 +12,7 @@ noinst_HEADERS = lttng-kernel.h defaults.h macros.h error.h futex.h \
 
 # Common library
 noinst_LTLIBRARIES = libcommon.la
+EXTRA_DIST = mi_lttng.xsd
 
 libcommon_la_SOURCES = error.h error.c utils.c utils.h runas.c runas.h \
                        common.h futex.c futex.h uri.c uri.h defaults.c \
diff --git a/tests/regression/tools/mi/Makefile.am b/tests/regression/tools/mi/Makefile.am
index 5586461..4c77f56 100644
--- a/tests/regression/tools/mi/Makefile.am
+++ b/tests/regression/tools/mi/Makefile.am
@@ -10,7 +10,7 @@ extract_xml_CPPFLAGS = $(XML_CPPFLAGS) $(AM_CPPFLAGS)
 extract_xml_LDADD = $(XML_LIBS)
 
 noinst_SCRIPTS = test_mi
-EXTRA_DIST =
+EXTRA_DIST = test_mi
 
 all-local:
 	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
-- 
2.0.0
