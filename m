From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust 4/4] Add silent mode to examples
 Makefiles
Date: Thu, 20 Dec 2018 15:22:42 -0500
Message-ID: <20181220202242.6119-4-mjeanson__17251.8016574488$1545337290$gmane$org@efficios.com>
References: <20181220202242.6119-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43LNVP3373z16cf
 for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2018 15:22:53 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 67801A7BCE
 for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2018 15:22:53 -0500 (EST)
In-Reply-To: <20181220202242.6119-1-mjeanson@efficios.com>
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
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 doc/examples/Makefile.am               | 10 +++-------
 doc/examples/clock-override/Makefile   |  7 +++++--
 doc/examples/demo-tracef/Makefile      |  7 +++++--
 doc/examples/demo-tracelog/Makefile    |  7 +++++--
 doc/examples/demo/Makefile             | 22 +++++++++++++++-------
 doc/examples/easy-ust/Makefile         | 10 +++++++---
 doc/examples/gen-tp/Makefile           | 24 +++++++++++++++---------
 doc/examples/getcpu-override/Makefile  |  7 +++++--
 doc/examples/hello-static-lib/Makefile | 13 +++++++++----
 9 files changed, 69 insertions(+), 38 deletions(-)

diff --git a/doc/examples/Makefile.am b/doc/examples/Makefile.am
index 493e07dd..d5d00b09 100644
--- a/doc/examples/Makefile.am
+++ b/doc/examples/Makefile.am
@@ -106,28 +106,24 @@ SUBDIRS_PROXY += gen-tp
 endif
 
 all-local:
-	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
+	$(AM_V_at)if [ x"$(srcdir)" != x"$(builddir)" ]; then \
 		for subdir in $(SUBDIRS_PROXY) $(SUBDIRS_JUL) $(SUBDIRS_LOG4J) $(SUBDIRS_CMAKE); do \
 			cp -pfR $(srcdir)/$$subdir $(builddir); \
 			chmod -R u+w $(builddir)/$$subdir; \
 		done; \
 	fi; \
 	if [ x"$(shell echo "$(top_srcdir)" | grep "^/" | wc -l)" = x"1" ]; then \
-		echo "Examples: absolute top_srcdir path $(top_srcdir)"; \
 		rel_src_subdir=""; \
 	else \
-		echo "Examples: relative top_srcdir path $(top_srcdir)"; \
 		rel_src_subdir="../"; \
 	fi; \
 	if [ x"$(shell echo "$(top_builddir)" | grep "^/" | wc -l)" = x"1" ]; then \
-		echo "Examples: absolute top_builddir path $(top_builddir)"; \
 		rel_build_subdir=""; \
 	else \
-		echo "Examples: relative top_builddir path $(top_builddir)"; \
 		rel_build_subdir="../"; \
 	fi; \
 	for subdir in $(SUBDIRS_PROXY); do \
-		(cd $$subdir && $(MAKE) CC="$(CC)" CPPFLAGS="$(CPPFLAGS)" AM_CPPFLAGS="$(AM_CPPFLAGS) -I$$rel_src_subdir$(top_srcdir)/include/ -I$$rel_build_subdir$(top_builddir)/include/" CFLAGS='$(CFLAGS)' AM_CFLAGS='$(AM_CFLAGS)' LDFLAGS="$(LDFLAGS)" AM_LDFLAGS='$(AM_LDFLAGS) -L../../../liblttng-ust/.libs -Wl,-rpath="$(PWD)/../../liblttng-ust/.libs/" -Wl,-rpath-link="$(PWD)/../../liblttng-ust/.libs/"' LTTNG_GEN_TP_PATH="../../../tools/" $(AM_MAKEFLAGS) all && cd ..) || exit 1; \
+		(cd $$subdir && $(MAKE) CC="$(CC)" CPPFLAGS="$(CPPFLAGS)" AM_CPPFLAGS="$(AM_CPPFLAGS) -I$$rel_src_subdir$(top_srcdir)/include/ -I$$rel_build_subdir$(top_builddir)/include/" CFLAGS='$(CFLAGS)' AM_CFLAGS='$(AM_CFLAGS)' LDFLAGS="$(LDFLAGS)" AM_LDFLAGS='$(AM_LDFLAGS) -L../../../liblttng-ust/.libs -Wl,-rpath="$(PWD)/../../liblttng-ust/.libs/" -Wl,-rpath-link="$(PWD)/../../liblttng-ust/.libs/"' LTTNG_GEN_TP_PATH="../../../tools/" AM_V_P="$(AM_V_P)" AM_V_at="$(AM_V_at)" $(AM_MAKEFLAGS) all && cd ..) || exit 1; \
 	done; \
 	if [ x"$(SUBDIRS_JUL)" != x"" ]; then \
 		for subdir in $(SUBDIRS_JUL); do \
@@ -162,7 +158,7 @@ all-local:
 
 
 clean-local:
-	@for subdir in $(SUBDIRS_PROXY); do \
+	$(AM_V_at)for subdir in $(SUBDIRS_PROXY); do \
 		if [ -d $$subdir ]; then \
 			(cd $$subdir && $(MAKE) $(AM_MAKEFLAGS) clean && cd ..) || exit 1; \
 		fi; \
diff --git a/doc/examples/clock-override/Makefile b/doc/examples/clock-override/Makefile
index 22e5dffb..bd29f179 100644
--- a/doc/examples/clock-override/Makefile
+++ b/doc/examples/clock-override/Makefile
@@ -18,15 +18,18 @@
 LIBS = -ldl	# On Linux
 #LIBS = -lc	# On BSD
 LOCAL_CPPFLAGS += -I.
+AM_V_P := :
 
 all: lttng-ust-clock-override-example.so
 
 lttng-ust-clock-override-example.o: lttng-ust-clock-override-example.c
-	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
+		$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
 		$(CFLAGS) -fpic -c -o $@ $<
 
 lttng-ust-clock-override-example.so: lttng-ust-clock-override-example.o
-	$(CC) -Wl,--no-as-needed -o $@ $(LDFLAGS) $(AM_CFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CCLD     $@"; fi; \
+		$(CC) -Wl,--no-as-needed -o $@ $(LDFLAGS) $(AM_CFLAGS) \
 		$(AM_LDFLAGS) $(CFLAGS) -shared -fpic lttng-ust-clock-override-example.o
 
 .PHONY: clean
diff --git a/doc/examples/demo-tracef/Makefile b/doc/examples/demo-tracef/Makefile
index 1e4544c4..ee207843 100644
--- a/doc/examples/demo-tracef/Makefile
+++ b/doc/examples/demo-tracef/Makefile
@@ -18,15 +18,18 @@
 LIBS = -ldl -llttng-ust	# On Linux
 #LIBS = -lc	# On BSD
 LOCAL_CPPFLAGS += -I.
+AM_V_P := :
 
 all: demo-tracef
 
 demo-tracef.o: demo-tracef.c
-	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
+		$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
 		$(CFLAGS) -c -o $@ $<
 
 demo-tracef: demo-tracef.o
-	$(CC) $(LDFLAGS) $(AM_CFLAGS) $(AM_LDFLAGS) $(CFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CCLD     $@"; fi; \
+		$(CC) $(LDFLAGS) $(AM_CFLAGS) $(AM_LDFLAGS) $(CFLAGS) \
 		-o $@ $< $(LIBS)
 
 .PHONY: clean
diff --git a/doc/examples/demo-tracelog/Makefile b/doc/examples/demo-tracelog/Makefile
index a16d6c52..0d9a20aa 100644
--- a/doc/examples/demo-tracelog/Makefile
+++ b/doc/examples/demo-tracelog/Makefile
@@ -18,15 +18,18 @@
 LIBS = -ldl -llttng-ust	# On Linux
 #LIBS = -lc	# On BSD
 LOCAL_CPPFLAGS += -I.
+AM_V_P := :
 
 all: demo-tracelog
 
 demo-tracelog.o: demo-tracelog.c
-	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
+		$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
 		$(CFLAGS) -c -o $@ $<
 
 demo-tracelog: demo-tracelog.o
-	$(CC) $(LDFLAGS) $(AM_CFLAGS) $(AM_LDFLAGS) $(CFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CCLD     $@"; fi; \
+		$(CC) $(LDFLAGS) $(AM_CFLAGS) $(AM_LDFLAGS) $(CFLAGS) \
 		-o $@ $< $(LIBS)
 
 .PHONY: clean
diff --git a/doc/examples/demo/Makefile b/doc/examples/demo/Makefile
index bb7fc173..b309ef6e 100644
--- a/doc/examples/demo/Makefile
+++ b/doc/examples/demo/Makefile
@@ -17,35 +17,43 @@
 LIBS = -ldl	# On Linux
 #LIBS = -lc	# On BSD
 LOCAL_CPPFLAGS += -I.
+AM_V_P := :
 
 all: demo lttng-ust-provider-ust-tests-demo.so lttng-ust-provider-ust-tests-demo3.so
 
 tp.o: tp.c ust_tests_demo.h
-	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
+		$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
 		$(CFLAGS) -fpic -c -o $@ $<
 
 tp2.o: tp2.c ust_tests_demo2.h
-	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
+		$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
 		$(CFLAGS) -fpic -c -o $@ $<
 
 lttng-ust-provider-ust-tests-demo.so: tp.o tp2.o
-	$(CC) -Wl,--no-as-needed -o $@ $(LDFLAGS) $(AM_CFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CCLD     $@"; fi; \
+		$(CC) -Wl,--no-as-needed -o $@ $(LDFLAGS) $(AM_CFLAGS) \
 		$(AM_LDFLAGS) $(CFLAGS) -shared -fpic tp.o tp2.o $(LIBS) -llttng-ust
 
 tp3.o: tp3.c ust_tests_demo3.h
-	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
+		$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
 		$(CFLAGS) -fpic -c -o $@ $<
 
 lttng-ust-provider-ust-tests-demo3.so: tp3.o
-	$(CC) -Wl,--no-as-needed -o $@ $(LDFLAGS) $(AM_CFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CCLD     $@"; fi; \
+		$(CC) -Wl,--no-as-needed -o $@ $(LDFLAGS) $(AM_CFLAGS) \
 		$(AM_LDFLAGS) $(CFLAGS) -shared -fpic tp3.o $(LIBS) -llttng-ust
 
 demo.o: demo.c
-	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
+		$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
 		$(CFLAGS) -c -o $@ $<
 
 demo: demo.o
-	$(CC) $(LDFLAGS) $(AM_CFLAGS) $(AM_LDFLAGS) $(CFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CCLD     $@"; fi; \
+		$(CC) $(LDFLAGS) $(AM_CFLAGS) $(AM_LDFLAGS) $(CFLAGS) \
 		-o $@ demo.o $(LIBS)
 
 .PHONY: clean
diff --git a/doc/examples/easy-ust/Makefile b/doc/examples/easy-ust/Makefile
index 02272938..9e957ccf 100644
--- a/doc/examples/easy-ust/Makefile
+++ b/doc/examples/easy-ust/Makefile
@@ -19,19 +19,23 @@
 LIBS = -ldl -llttng-ust		# On Linux
 #LIBS = -lc -llttng-ust		# On BSD
 LOCAL_CPPFLAGS += -I.
+AM_V_P := :
 
 all: sample
 
 sample: sample.o tp.o
-	$(CC) -o $@ $(LDFLAGS) $(AM_CFLAGS) $(AM_LDFLAGS) $(CFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CCLD     $@"; fi; \
+		$(CC) -o $@ $(LDFLAGS) $(AM_CFLAGS) $(AM_LDFLAGS) $(CFLAGS) \
 		sample.o tp.o $(LIBS)
 
 sample.o: sample.c sample_component_provider.h
-	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
+		$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
 		$(CFLAGS) -c -o $@ $<
 
 tp.o: tp.c sample_component_provider.h
-	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
+		$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
 		$(CFLAGS) -c -o $@ $<
 
 html: sample_component_provider.html sample.html tp.html
diff --git a/doc/examples/gen-tp/Makefile b/doc/examples/gen-tp/Makefile
index 6d9ec10d..bc172f0c 100644
--- a/doc/examples/gen-tp/Makefile
+++ b/doc/examples/gen-tp/Makefile
@@ -19,15 +19,18 @@
 
 LIBS = -ldl -llttng-ust		#On Linux
 #LIBS = -lc -llttng-ust		#On BSD
+AM_V_P := :
 
 all: sample
 
 sample: sample.o sample_tracepoint.o
-	$(CC) $(LDFLAGS) $(AM_CFLAGS) $(AM_LDFLAGS) $(CFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CCLD     $@"; fi; \
+		$(CC) $(LDFLAGS) $(AM_CFLAGS) $(AM_LDFLAGS) $(CFLAGS) \
 		-o $@ sample.o sample_tracepoint.o $(LIBS)
 
 sample.o: sample.c sample_tracepoint.h
-	$(CC) $(CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) $(CFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
+		$(CC) $(CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) $(CFLAGS) \
 		-c -o $@ $<
 
 # Use this command to compile the .c manually
@@ -38,11 +41,12 @@ sample.o: sample.c sample_tracepoint.h
 # This rule generate .o only and depends on rules for generating
 # the .h and .c
 %.o: %.tp %.c %.h
-	CPPFLAGS="$(AM_CPPFLAGS) $(CPPFLAGS)" \
-	CFLAGS="$(AM_CFLAGS) $(CFLAGS)" \
-	LDFLAGS="$(AM_LDFLAGS) $(LDFLAGS)" \
-	CC="$(CC)" \
-	$(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<
+	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
+		CPPFLAGS="$(AM_CPPFLAGS) $(CPPFLAGS)" \
+		CFLAGS="$(AM_CFLAGS) $(CFLAGS)" \
+		LDFLAGS="$(AM_LDFLAGS) $(LDFLAGS)" \
+		CC="$(CC)" \
+		$(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<
 
 # The following rule can be used to generate all files instead of having one
 # for each file type. Note that the sample.o has a dependency on the
@@ -51,10 +55,12 @@ sample.o: sample.c sample_tracepoint.h
 #	lttng-gen-tp $<
 
 %.h: %.tp
-	$(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<
+	@if $(AM_V_P); then set -x; else echo "  GEN      $@"; fi; \
+		$(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<
 
 %.c: %.tp
-	$(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<
+	@if $(AM_V_P); then set -x; else echo "  GEN      $@"; fi; \
+		$(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<
 
 .PHONY: clean
 clean:
diff --git a/doc/examples/getcpu-override/Makefile b/doc/examples/getcpu-override/Makefile
index e1e4892c..435b851d 100644
--- a/doc/examples/getcpu-override/Makefile
+++ b/doc/examples/getcpu-override/Makefile
@@ -18,15 +18,18 @@
 LIBS = -ldl	# On Linux
 #LIBS = -lc	# On BSD
 LOCAL_CPPFLAGS += -I.
+AM_V_P := :
 
 all: lttng-ust-getcpu-override-example.so
 
 lttng-ust-getcpu-override-example.o: lttng-ust-getcpu-override-example.c
-	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
+		$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
 		$(CFLAGS) -fpic -c -o $@ $<
 
 lttng-ust-getcpu-override-example.so: lttng-ust-getcpu-override-example.o
-	$(CC) -Wl,--no-as-needed -o $@ $(LDFLAGS) $(AM_CFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CCLD     $@"; fi; \
+		$(CC) -Wl,--no-as-needed -o $@ $(LDFLAGS) $(AM_CFLAGS) \
 		$(AM_LDFLAGS) $(CFLAGS) -shared -fpic lttng-ust-getcpu-override-example.o
 
 .PHONY: clean
diff --git a/doc/examples/hello-static-lib/Makefile b/doc/examples/hello-static-lib/Makefile
index cf72b35d..c5fdd31c 100644
--- a/doc/examples/hello-static-lib/Makefile
+++ b/doc/examples/hello-static-lib/Makefile
@@ -17,22 +17,27 @@
 LOCAL_CPPFLAGS += -I.
 LIBS = -ldl -llttng-ust	# On Linux
 #LIBS = -lc -llttng-ust	# On BSD
+AM_V_P := :
 
 all: hello
 
 lttng-ust-provider-hello.o: tp.c ust_tests_hello.h
-	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
+		$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
 		$(CFLAGS) -c -o $@ $<
 
 lttng-ust-provider-hello.a: lttng-ust-provider-hello.o
-	ar -rc $@ lttng-ust-provider-hello.o
+	@if $(AM_V_P); then set -x; else echo "  AR       $@"; fi; \
+		ar -rc $@ lttng-ust-provider-hello.o
 
 hello.o: hello.c
-	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
+		$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
 		$(CFLAGS) -c -o $@ $<
 
 hello: hello.o lttng-ust-provider-hello.a
-	$(CC) -o $@ $(LDFLAGS) $(CPPFLAGS) $(AM_LDFLAGS) $(AM_CFLAGS) \
+	@if $(AM_V_P); then set -x; else echo "  CCLD     $@"; fi; \
+		$(CC) -o $@ $(LDFLAGS) $(CPPFLAGS) $(AM_LDFLAGS) $(AM_CFLAGS) \
 		$(CFLAGS) hello.o lttng-ust-provider-hello.a $(LIBS)
 
 .PHONY: clean
-- 
2.17.1
