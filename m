From: Jon Bernard <jbernard@tuxion.com>
Subject: [PATCH lttng-tools] Link test utilities against urcu-bp
Date: Wed, 28 Nov 2012 10:13:59 -0500
Message-ID: <20121128151359.GA2051__14254.0188659497$1354116356$gmane$org@quintessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jbernard@tuxion.com>) id 1TdjKw-0002mu-JL
	for lttng-dev@lists.lttng.org; Wed, 28 Nov 2012 10:14:06 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A47DA212B5
	for <lttng-dev@lists.lttng.org>; Wed, 28 Nov 2012 10:14:00 -0500 (EST)
Received: from localhost (unknown [216.252.204.142])
	by mail.messagingengine.com (Postfix) with ESMTPA id 654E04827C5
	for <lttng-dev@lists.lttng.org>; Wed, 28 Nov 2012 10:14:00 -0500 (EST)
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The gen-ust-events utility used in several of the tests references the
'rcu_dereference_sym' symbol contained in urcu-bp.  It is necessary to link
against urcu-bp so that this symbol is resolved.

Signed-off-by: Jon Bernard <jbernard@tuxion.com>
---
 tests/tools/filtering/Makefile.am     | 2 +-
 tests/tools/streaming/Makefile.am     | 2 +-
 tests/ust/before-after/Makefile.am    | 2 +-
 tests/ust/high-throughput/Makefile.am | 2 +-
 tests/ust/multi-session/Makefile.am   | 2 +-
 tests/ust/nprocesses/Makefile.am      | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/tools/filtering/Makefile.am b/tests/tools/filtering/Makefile.am
index e1e715d..287effc 100644
--- a/tests/tools/filtering/Makefile.am
+++ b/tests/tools/filtering/Makefile.am
@@ -11,7 +11,7 @@ endif
 if HAVE_LIBLTTNG_UST_CTL
 noinst_PROGRAMS = gen-ust-events
 gen_ust_events_SOURCES = gen-ust-events.c tp.c tp.h
-gen_ust_events_LDADD = -llttng-ust
+gen_ust_events_LDADD = -llttng-ust -lurcu-bp
 endif
 
 noinst_SCRIPTS = runall unsupported-ops invalid-filters valid-filters babelstats.pl
diff --git a/tests/tools/streaming/Makefile.am b/tests/tools/streaming/Makefile.am
index 3ff8ef0..d07baa8 100644
--- a/tests/tools/streaming/Makefile.am
+++ b/tests/tools/streaming/Makefile.am
@@ -20,7 +20,7 @@ unit_tests_LDADD = $(LIBCOMMON)
 if HAVE_LIBLTTNG_UST_CTL
 noinst_PROGRAMS += gen-ust-events
 gen_ust_events_SOURCES = gen-ust-events.c tp.c tp.h
-gen_ust_events_LDADD = -llttng-ust
+gen_ust_events_LDADD = -llttng-ust -lurcu-bp
 endif
 
 noinst_SCRIPTS = runall run-ust run-kernel uri_switch
diff --git a/tests/ust/before-after/Makefile.am b/tests/ust/before-after/Makefile.am
index d197d72..80a6ba2 100644
--- a/tests/ust/before-after/Makefile.am
+++ b/tests/ust/before-after/Makefile.am
@@ -10,7 +10,7 @@ endif
 
 noinst_PROGRAMS = gen-nevents
 gen_nevents_SOURCES = gen-nevents.c tp.c ust_gen_nevents.h
-gen_nevents_LDADD = -llttng-ust
+gen_nevents_LDADD = -llttng-ust -lurcu-bp
 
 noinst_SCRIPTS = run
 EXTRA_DIST = run
diff --git a/tests/ust/high-throughput/Makefile.am b/tests/ust/high-throughput/Makefile.am
index cff8fe4..74478bd 100644
--- a/tests/ust/high-throughput/Makefile.am
+++ b/tests/ust/high-throughput/Makefile.am
@@ -10,7 +10,7 @@ endif
 
 noinst_PROGRAMS = gen-events
 gen_events_SOURCES = main.c tp.c tp.h
-gen_events_LDADD = -llttng-ust
+gen_events_LDADD = -llttng-ust -lurcu-bp
 
 noinst_SCRIPTS = run
 EXTRA_DIST = run
diff --git a/tests/ust/multi-session/Makefile.am b/tests/ust/multi-session/Makefile.am
index d197d72..80a6ba2 100644
--- a/tests/ust/multi-session/Makefile.am
+++ b/tests/ust/multi-session/Makefile.am
@@ -10,7 +10,7 @@ endif
 
 noinst_PROGRAMS = gen-nevents
 gen_nevents_SOURCES = gen-nevents.c tp.c ust_gen_nevents.h
-gen_nevents_LDADD = -llttng-ust
+gen_nevents_LDADD = -llttng-ust -lurcu-bp
 
 noinst_SCRIPTS = run
 EXTRA_DIST = run
diff --git a/tests/ust/nprocesses/Makefile.am b/tests/ust/nprocesses/Makefile.am
index 20beea0..bc3a503 100644
--- a/tests/ust/nprocesses/Makefile.am
+++ b/tests/ust/nprocesses/Makefile.am
@@ -10,7 +10,7 @@ endif
 
 noinst_PROGRAMS = gen-events-time
 gen_events_time_SOURCES = gen-events-time.c tp.c ust_gen_event.h
-gen_events_time_LDADD = -llttng-ust
+gen_events_time_LDADD = -llttng-ust -lurcu-bp
 
 noinst_SCRIPTS = run
 EXTRA_DIST = run
-- 
1.8.0
