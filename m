From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] fix: Use DL_LIBS variable in ust
 multi-lib test
Date: Thu, 24 Oct 2019 11:36:33 -0400
Message-ID: <20191024153633.17551-1-mjeanson__36369.7063455888$1571931443$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46zWZ51Q5Mz1QNq
 for <lttng-dev@lists.lttng.org>; Thu, 24 Oct 2019 11:36:45 -0400 (EDT)
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

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 tests/regression/ust/multi-lib/Makefile.am | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/regression/ust/multi-lib/Makefile.am b/tests/regression/ust/multi-lib/Makefile.am
index 0ce46a7ff..52a1635c2 100644
--- a/tests/regression/ust/multi-lib/Makefile.am
+++ b/tests/regression/ust/multi-lib/Makefile.am
@@ -3,11 +3,11 @@ EXTRA_DIST = test_multi_lib
 noinst_PROGRAMS = exec-with-callsites exec-without-callsites
 
 exec_with_callsites_SOURCES = multi-lib-test.c callsites.c
-exec_with_callsites_LDFLAGS = -ldl $(POPT_LIBS)
+exec_with_callsites_LDFLAGS = $(DL_LIBS) $(POPT_LIBS)
 exec_with_callsites_CFLAGS = $(POPT_CFLAGS) $(AM_CFLAGS) -DHAS_CALLSITES=1
 
 exec_without_callsites_SOURCES = multi-lib-test.c
-exec_without_callsites_LDFLAGS = -ldl $(POPT_LIBS) $(UST_LIBS)
+exec_without_callsites_LDFLAGS = $(DL_LIBS) $(POPT_LIBS) $(UST_LIBS)
 exec_without_callsites_LDADD = probes.o
 exec_without_callsites_CFLAGS = $(POPT_CFLAGS) $(AM_CFLAGS) -DHAS_CALLSITES=0
 
-- 
2.17.1
