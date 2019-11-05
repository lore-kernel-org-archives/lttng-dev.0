From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] fix: Re-add link to urcu-bp for
 _LGPL_SOURCE tests
Date: Tue,  5 Nov 2019 11:30:24 -0500
Message-ID: <20191105163024.5085-1-mjeanson__34213.2972365775$1572971454$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 476wBg6rj0zsQr
 for <lttng-dev@lists.lttng.org>; Tue,  5 Nov 2019 11:30:35 -0500 (EST)
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

Tests with tracepoints defined with _LGPL_SOURCE require to be
explicitly linked against urcu-bp.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 tests/regression/ust/multi-session/Makefile.am      | 2 +-
 tests/utils/testapp/gen-ust-events/Makefile.am      | 2 +-
 tests/utils/testapp/gen-ust-nevents-str/Makefile.am | 2 +-
 tests/utils/testapp/gen-ust-nevents/Makefile.am     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/regression/ust/multi-session/Makefile.am b/tests/regression/ust/multi-session/Makefile.am
index 0d807a878..676c26f21 100644
--- a/tests/regression/ust/multi-session/Makefile.am
+++ b/tests/regression/ust/multi-session/Makefile.am
@@ -2,7 +2,7 @@ AM_CFLAGS += -I$(srcdir)
 
 noinst_PROGRAMS = gen-nevents
 gen_nevents_SOURCES = gen-nevents.c tp.c ust_gen_nevents.h
-gen_nevents_LDADD = $(UST_LIBS) $(DL_LIBS)
+gen_nevents_LDADD = $(UST_LIBS) -lurcu-bp $(DL_LIBS)
 
 noinst_SCRIPTS = test_multi_session
 EXTRA_DIST = test_multi_session
diff --git a/tests/utils/testapp/gen-ust-events/Makefile.am b/tests/utils/testapp/gen-ust-events/Makefile.am
index 38e620d75..8918fc80d 100644
--- a/tests/utils/testapp/gen-ust-events/Makefile.am
+++ b/tests/utils/testapp/gen-ust-events/Makefile.am
@@ -4,7 +4,7 @@ AM_CPPFLAGS += -I$(top_srcdir)/tests/utils -I$(srcdir) \
 if HAVE_LIBLTTNG_UST_CTL
 noinst_PROGRAMS = gen-ust-events
 gen_ust_events_SOURCES = gen-ust-events.c tp.c tp.h
-gen_ust_events_LDADD = $(UST_LIBS) \
+gen_ust_events_LDADD = $(UST_LIBS) -lurcu-bp \
 		$(top_builddir)/tests/utils/libtestutils.la \
 		$(DL_LIBS)
 endif
diff --git a/tests/utils/testapp/gen-ust-nevents-str/Makefile.am b/tests/utils/testapp/gen-ust-nevents-str/Makefile.am
index 0e961b4c4..27cb9efa7 100644
--- a/tests/utils/testapp/gen-ust-nevents-str/Makefile.am
+++ b/tests/utils/testapp/gen-ust-nevents-str/Makefile.am
@@ -4,7 +4,7 @@ AM_CPPFLAGS += -I$(srcdir) -I$(top_srcdir)/tests/utils \
 if HAVE_LIBLTTNG_UST_CTL
 noinst_PROGRAMS = gen-ust-nevents-str
 gen_ust_nevents_str_SOURCES = gen-ust-nevents-str.c tp.c tp.h
-gen_ust_nevents_str_LDADD = $(UST_LIBS) \
+gen_ust_nevents_str_LDADD = $(UST_LIBS) -lurcu-bp \
 		$(top_builddir)/tests/utils/libtestutils.la \
 		$(DL_LIBS)
 endif
diff --git a/tests/utils/testapp/gen-ust-nevents/Makefile.am b/tests/utils/testapp/gen-ust-nevents/Makefile.am
index c20910bd8..f85d35a13 100644
--- a/tests/utils/testapp/gen-ust-nevents/Makefile.am
+++ b/tests/utils/testapp/gen-ust-nevents/Makefile.am
@@ -4,7 +4,7 @@ AM_CPPFLAGS += -I$(srcdir) -I$(top_srcdir)/tests/utils \
 if HAVE_LIBLTTNG_UST_CTL
 noinst_PROGRAMS = gen-ust-nevents
 gen_ust_nevents_SOURCES = gen-ust-nevents.c tp.c tp.h
-gen_ust_nevents_LDADD = $(UST_LIBS) \
+gen_ust_nevents_LDADD = $(UST_LIBS) -lurcu-bp \
 		$(top_builddir)/tests/utils/libtestutils.la \
 		$(DL_LIBS)
 endif
-- 
2.17.1
