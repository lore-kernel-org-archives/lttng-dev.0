From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] fix: tests: link libpause_consumer
 on liblttng-ctl
Date: Tue, 19 Mar 2019 16:56:03 -0400
Message-ID: <20190319205603.15707-1-mjeanson__9880.97644164867$1553028989$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44P51n6r6mz17Ys
 for <lttng-dev@lists.lttng.org>; Tue, 19 Mar 2019 16:56:13 -0400 (EDT)
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

This preload test library uses symbols from liblttng-ctl which are
resolved when preloaded by GLIBC but not by MUSL.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 tests/regression/tools/notification/Makefile.am | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/regression/tools/notification/Makefile.am b/tests/regression/tools/notification/Makefile.am
index 33e95886..b869bdb1 100644
--- a/tests/regression/tools/notification/Makefile.am
+++ b/tests/regression/tools/notification/Makefile.am
@@ -20,7 +20,10 @@ FORCE_SHARED_LIB_OPTIONS = -module -shared -avoid-version \
 			   -rpath $(abs_builddir)
 
 libpause_consumer_la_SOURCES = consumer_testpoints.c
-libpause_consumer_la_LIBADD = $(top_builddir)/src/common/libcommon.la $(DL_LIBS)
+libpause_consumer_la_LIBADD = \
+	$(top_builddir)/src/common/libcommon.la \
+	$(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la \
+	$(DL_LIBS)
 libpause_consumer_la_LDFLAGS = $(FORCE_SHARED_LIB_OPTIONS)
 noinst_LTLIBRARIES = libpause_consumer.la
 
-- 
2.17.1
