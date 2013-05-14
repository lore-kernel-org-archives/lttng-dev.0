From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: [PATCH] Remove -pie flag for shared library
Date: Tue, 14 May 2013 16:15:32 -0400
Message-ID: <1368562532-19566-1-git-send-email-francis.giraldeau__10243.0420498878$1368562585$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1UcLdQ-00055b-2u
	for lttng-dev@lists.lttng.org; Tue, 14 May 2013 16:15:44 -0400
Received: by mail-qc0-f169.google.com with SMTP id z10so17021qcx.14
	for <lttng-dev@lists.lttng.org>; Tue, 14 May 2013 13:15:38 -0700 (PDT)
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

Some build environment with hardening enabled adds -pie flags to LDFLAGS. While
it's required for ELF binaries, it doesn't make sens for shared libraries. For
this case, filter-out the erroneous option.

Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
---
 doc/examples/demo/Makefile     | 6 ++++--
 doc/examples/easy-ust/Makefile | 4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/doc/examples/demo/Makefile b/doc/examples/demo/Makefile
index bbc8ccb..3145146 100644
--- a/doc/examples/demo/Makefile
+++ b/doc/examples/demo/Makefile
@@ -34,6 +34,8 @@ EMPTY_AUTOMAKE_TARGETS = distdir install install-data install-exec uninstall \
 $(EMPTY_AUTOMAKE_TARGETS):
 endif
 
+CLEAN_LDFLAGS = $(filter-out -pie,$(LDFLAGS))
+
 all: demo lttng-ust-provider-ust-tests-demo.so lttng-ust-provider-ust-tests-demo3.so
 
 tp.o: tp.c ust_tests_demo.h
@@ -43,13 +45,13 @@ tp2.o: tp2.c ust_tests_demo2.h
 	$(CC) $(CPPFLAGS) $(CFLAGS) -fpic -c -o $@ $<
 
 lttng-ust-provider-ust-tests-demo.so: tp.o tp2.o
-	$(CC) -shared -o $@ $(LDFLAGS) -llttng-ust $^
+	$(CC) -shared -o $@ $(CLEAN_LDFLAGS) -llttng-ust $^
 
 tp3.o: tp3.c ust_tests_demo3.h
 	$(CC) $(CPPFLAGS) $(CFLAGS) -fpic -c -o $@ $<
 
 lttng-ust-provider-ust-tests-demo3.so: tp3.o
-	$(CC) -shared -o $@ $(LDFLAGS) -llttng-ust $^
+	$(CC) -shared -o $@ $(CLEAN_LDFLAGS) -llttng-ust $^
 
 demo.o: demo.c
 	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
diff --git a/doc/examples/easy-ust/Makefile b/doc/examples/easy-ust/Makefile
index e20e53a..e95a2c5 100644
--- a/doc/examples/easy-ust/Makefile
+++ b/doc/examples/easy-ust/Makefile
@@ -36,10 +36,12 @@ EMPTY_AUTOMAKE_TARGETS = distdir install install-data install-exec uninstall \
 $(EMPTY_AUTOMAKE_TARGETS):
 endif
 
+CLEAN_LDFLAGS = $(filter-out -pie,$(LDFLAGS))
+
 all: sample
 
 sample: sample.o tp.o
-	$(CC) -o $@ $^ $(LDFLAGS) $(LIBS)
+	$(CC) -o $@ $^ $(CLEAN_LDFLAGS) $(LIBS)
 
 sample.o: sample.c sample_component_provider.h
 	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
-- 
1.8.1.2
