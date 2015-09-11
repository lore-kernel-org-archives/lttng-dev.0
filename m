From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH lttng-ust] Implement statedump notifier API
	and example
Date: Fri, 11 Sep 2015 18:03:20 -0400
Message-ID: <1442009000-22553-1-git-send-email-mathieu.desnoyers__15918.7125428163$1442009082$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZaWQ3-0006PR-Qv
 for lttng-dev@lists.lttng.org; Fri, 11 Sep 2015 18:03:46 -0400
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

Implement a statedump notifier interface so applications can dump their
state at trace start, similarly to what is done for LTTng Linux kernel
tracing.

CC: Brian Robbins <brianrob@microsoft.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 .gitignore                                         |   1 +
 doc/examples/Makefile.am                           |   9 +-
 doc/examples/demo-statedump-notifier/README        |   4 +
 .../demo-statedump-notifier.c                      |  61 ++++++++++
 .../lttng-ust-demo-statedump-provider.h            |  60 ++++++++++
 include/Makefile.am                                |   3 +-
 include/lttng/statedump-notifier.h                 |  59 +++++++++
 include/lttng/ust-events.h                         |   3 +
 liblttng-ust/Makefile.am                           |   3 +-
 liblttng-ust/lttng-events.c                        |  32 ++++-
 liblttng-ust/lttng-ust-statedump.c                 |  90 ++++++++++++++
 liblttng-ust/lttng-ust-statedump.h                 |  11 ++
 liblttng-ust/statedump-notifier.c                  | 133 +++++++++++++++++++++
 13 files changed, 463 insertions(+), 6 deletions(-)
 create mode 100644 doc/examples/demo-statedump-notifier/README
 create mode 100644 doc/examples/demo-statedump-notifier/demo-statedump-notifier.c
 create mode 100644 doc/examples/demo-statedump-notifier/lttng-ust-demo-statedump-provider.h
 create mode 100644 include/lttng/statedump-notifier.h
 create mode 100644 liblttng-ust/statedump-notifier.c

diff --git a/.gitignore b/.gitignore
index 1039b1a..b705ce0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -39,6 +39,7 @@ doc/examples/gen-tp/sample
 doc/examples/gen-tp/sample_tracepoint.h
 doc/examples/demo-tracef/demo-tracef
 doc/examples/demo-tracelog/demo-tracelog
+doc/examples/demo-statedump-notifier/demo-statedump-notifier
 
 tests/hello/hello
 tests/hello.cxx/hello
diff --git a/doc/examples/Makefile.am b/doc/examples/Makefile.am
index 3538ee6..ffdd277 100644
--- a/doc/examples/Makefile.am
+++ b/doc/examples/Makefile.am
@@ -7,6 +7,7 @@ doc_examples_demo_tracefdir = ${docdir}/examples/demo-tracef
 doc_examples_demo_tracelogdir = ${docdir}/examples/demo-tracelog
 doc_examples_clock_overridedir = ${docdir}/examples/clock-override
 doc_examples_getcpu_overridedir = ${docdir}/examples/getcpu-override
+doc_examples_demo_statedump_notifierdir = ${docdir}/examples/demo-statedump-notifier
 
 if BUILD_JAVA_AGENT_WITH_JUL
 doc_examples_java_juldir = ${docdir}/examples/java-jul
@@ -58,6 +59,12 @@ dist_doc_examples_demo_tracelog_DATA = demo-tracelog/Makefile \
 	demo-tracelog/demo-tracelog.c \
 	demo-tracelog/README
 
+dist_doc_examples_demo_statedump_notifier_DATA = \
+	demo-statedump-notifier/Makefile \
+	demo-statedump-notifier/demo-statedump-notifier.c \
+	demo-statedump-notifier/lttng-ust-demo-statedump-provider.h \
+	demo-statedump-notifier/README
+
 dist_doc_examples_clock_override_DATA = clock-override/Makefile \
 	clock-override/lttng-ust-clock-override-example.c \
 	clock-override/run-clock-override \
@@ -74,7 +81,7 @@ if NO_SHARED
 else
 # Copies are for VPATH build support
 SUBDIRS_PROXY = easy-ust demo hello-static-lib demo-tracef clock-override \
-		getcpu-override demo-tracelog
+		getcpu-override demo-tracelog demo-statedump-notifier
 
 if BUILD_GEN_TP_EXAMPLES
 SUBDIRS_PROXY += gen-tp
diff --git a/doc/examples/demo-statedump-notifier/README b/doc/examples/demo-statedump-notifier/README
new file mode 100644
index 0000000..45887fa
--- /dev/null
+++ b/doc/examples/demo-statedump-notifier/README
@@ -0,0 +1,4 @@
+This small program shows how to create an application specific statedump
+notifier handler to populate application statedump at trace start (or
+when an application connects to a session daemon that has active
+sessions).
diff --git a/doc/examples/demo-statedump-notifier/demo-statedump-notifier.c b/doc/examples/demo-statedump-notifier/demo-statedump-notifier.c
new file mode 100644
index 0000000..91a16df
--- /dev/null
+++ b/doc/examples/demo-statedump-notifier/demo-statedump-notifier.c
@@ -0,0 +1,61 @@
+/*
+ * Copyright (C) 2015  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <lttng/statedump-notifier.h>
+
+#define TRACEPOINT_DEFINE
+#define TRACEPOINT_CREATE_PROBES
+#define TP_SESSION_CHECK
+#include "lttng-ust-demo-statedump-provider.h"
+
+static struct lttng_ust_notifier notifier;
+
+static void notifier_cb(struct lttng_session *session, void *priv)
+{
+	tracepoint(lttng_ust_demo_statedump, myevent, session, 123,
+		"test string");
+	tracepoint(lttng_ust_demo_statedump, myevent, session, 444,
+		"another string");
+}
+
+int main(int argc, char **argv)
+{
+	int delay = 0;
+
+	if (argc == 2)
+		delay = atoi(argv[1]);
+
+	fprintf(stderr, "Demo program starting.\n");
+
+	lttng_ust_init_statedump_notifier(&notifier, notifier_cb, NULL);
+	lttng_ust_register_statedump_notifier(&notifier);
+
+	sleep(delay);
+
+	lttng_ust_unregister_statedump_notifier(&notifier);
+
+	fprintf(stderr, " done.\n");
+	return 0;
+}
diff --git a/doc/examples/demo-statedump-notifier/lttng-ust-demo-statedump-provider.h b/doc/examples/demo-statedump-notifier/lttng-ust-demo-statedump-provider.h
new file mode 100644
index 0000000..d214b7a
--- /dev/null
+++ b/doc/examples/demo-statedump-notifier/lttng-ust-demo-statedump-provider.h
@@ -0,0 +1,60 @@
+#undef TRACEPOINT_PROVIDER
+#define TRACEPOINT_PROVIDER lttng_ust_demo_statedump
+
+#if !defined(_TRACEPOINT_LTTNG_UST_DEMO_STATEDUMP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
+#define _TRACEPOINT_LTTNG_UST_DEMO_STATEDUMP_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * Copyright (C) 2013  Paul Woegerer <paul_woegerer@mentor.com>
+ * Copyright (C) 2015  Antoine Busque <abusque@efficios.com>
+ * Copyright (C) 2015  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <stdint.h>
+#include <unistd.h>
+#include <lttng/ust-events.h>
+#include <lttng/tracepoint.h>
+
+TRACEPOINT_EVENT(lttng_ust_demo_statedump, myevent,
+	TP_ARGS(struct lttng_session *, session,
+		int, value,
+		char *, msg),
+	TP_FIELDS(
+		ctf_integer(int64_t, myvalue, value)
+		ctf_string(mymsg, msg)
+	)
+)
+
+#endif /* _TRACEPOINT_LTTNG_UST_STATEDUMP_H */
+
+#undef TRACEPOINT_INCLUDE
+#define TRACEPOINT_INCLUDE "./lttng-ust-demo-statedump-provider.h"
+
+/* This part must be outside ifdef protection */
+#include <lttng/tracepoint-event.h>
+
+#ifdef __cplusplus
+}
+#endif
diff --git a/include/Makefile.am b/include/Makefile.am
index 44102ef..37bb0b4 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -24,7 +24,8 @@ nobase_include_HEADERS = \
 	lttng/tracelog.h \
 	lttng/lttng-ust-tracelog.h \
 	lttng/ust-clock.h \
-	lttng/ust-getcpu.h
+	lttng/ust-getcpu.h \
+	lttng/statedump-notifier.h
 
 # note: usterr-signal-safe.h, core.h and share.h need namespace cleanup.
 
diff --git a/include/lttng/statedump-notifier.h b/include/lttng/statedump-notifier.h
new file mode 100644
index 0000000..1331c1d
--- /dev/null
+++ b/include/lttng/statedump-notifier.h
@@ -0,0 +1,59 @@
+#ifndef _LTTNG_STATEDUMP_NOTIFIER_H
+#define _LTTNG_STATEDUMP_NOTIFIER_H
+
+/*
+ * Copyright 2015 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <urcu/rculist.h>
+
+/*
+ * Application statedump notifiers can be registered by applications.
+ * They will be called at trace start for a specific session, or
+ * whenever the application connects to a session daemon with an active
+ * UST session.
+ *
+ * We expect the application to call register/unregister from execution
+ * contexts that do not run concurrently with fork() or clone(). The
+ * application should unregister all its statedump notifiers before
+ * using fork() or clone().
+ *
+ * The session argument is internal to lttng-ust, should be passed
+ * to the instrumentation to trace statedump into the caller session
+ * only.
+ */
+struct lttng_session;	/* Opaque to users. */
+
+typedef void (*lttng_ust_statedump_cb)(struct lttng_session *session,
+		void *priv);
+
+struct lttng_ust_notifier {
+	lttng_ust_statedump_cb callback;
+	void *priv;
+	struct cds_list_head node;
+};
+
+void lttng_ust_init_statedump_notifier(struct lttng_ust_notifier *notifier,
+		lttng_ust_statedump_cb callback, void *priv);
+void lttng_ust_register_statedump_notifier(struct lttng_ust_notifier *notifier);
+void lttng_ust_unregister_statedump_notifier(struct lttng_ust_notifier *notifier);
+
+#endif /* _LTTNG_STATEDUMP_NOTIFIER_H */
diff --git a/include/lttng/ust-events.h b/include/lttng/ust-events.h
index b34c9d1..8726f0f 100644
--- a/include/lttng/ust-events.h
+++ b/include/lttng/ust-events.h
@@ -532,6 +532,9 @@ struct lttng_session {
 
 	/* New UST 2.4 */
 	int statedump_pending:1;
+
+	/* New UST 2.8 */
+	struct lttng_statedump_table *statedump_table;
 };
 
 struct lttng_transport {
diff --git a/liblttng-ust/Makefile.am b/liblttng-ust/Makefile.am
index 199fa03..5a67a08 100644
--- a/liblttng-ust/Makefile.am
+++ b/liblttng-ust/Makefile.am
@@ -50,7 +50,8 @@ liblttng_ust_runtime_la_SOURCES = \
 	lttng-ust-tracef-provider.h \
 	tracelog.c \
 	lttng-ust-tracelog-provider.h \
-	getenv.h
+	getenv.h \
+	statedump-notifier.c
 
 if HAVE_PERF_EVENT
 liblttng_ust_runtime_la_SOURCES += \
diff --git a/liblttng-ust/lttng-events.c b/liblttng-ust/lttng-events.c
index 25b4962..337c564 100644
--- a/liblttng-ust/lttng-events.c
+++ b/liblttng-ust/lttng-events.c
@@ -24,6 +24,7 @@
 #include <stdio.h>
 #include <urcu/list.h>
 #include <urcu/hlist.h>
+#include <urcu/rculist.h>
 #include <pthread.h>
 #include <errno.h>
 #include <sys/shm.h>
@@ -64,6 +65,7 @@
  * thread, under ust_lock protection.
  */
 
+/* RCU protected list of sessions. */
 static CDS_LIST_HEAD(sessions);
 
 struct cds_list_head *_lttng_get_sessions(void)
@@ -136,14 +138,22 @@ struct lttng_session *lttng_session_create(void)
 
 	session = zmalloc(sizeof(struct lttng_session));
 	if (!session)
-		return NULL;
+		goto error_session;
+	session->statedump_table = lttng_statedump_table_create();
+	if (!session->statedump_table)
+		goto error_st;
 	CDS_INIT_LIST_HEAD(&session->chan_head);
 	CDS_INIT_LIST_HEAD(&session->events_head);
 	CDS_INIT_LIST_HEAD(&session->enablers_head);
 	for (i = 0; i < LTTNG_UST_EVENT_HT_SIZE; i++)
 		CDS_INIT_HLIST_HEAD(&session->events_ht.table[i]);
-	cds_list_add(&session->node, &sessions);
+	cds_list_add_rcu(&session->node, &sessions);
 	return session;
+
+error_st:
+	free(session);
+error_session:
+	return NULL;
 }
 
 /*
@@ -219,6 +229,8 @@ void lttng_session_destroy(struct lttng_session *session)
 		_lttng_event_unregister(event);
 	}
 	synchronize_trace();	/* Wait for in-flight events to complete */
+	cds_list_del_rcu(&session->node);
+	synchronize_trace();	/* Session list is RCU synchronized. */
 	cds_list_for_each_entry_safe(enabler, tmpenabler,
 			&session->enablers_head, node)
 		lttng_enabler_destroy(enabler);
@@ -227,7 +239,7 @@ void lttng_session_destroy(struct lttng_session *session)
 		_lttng_event_destroy(event);
 	cds_list_for_each_entry_safe(chan, tmpchan, &session->chan_head, node)
 		_lttng_channel_unmap(chan);
-	cds_list_del(&session->node);
+	lttng_statedump_table_destroy(session->statedump_table);
 	free(session);
 }
 
@@ -698,10 +710,24 @@ void lttng_handle_pending_statedump(void *owner)
 	}
 end:
 	ust_unlock();
+
 	return;
 }
 
 /*
+ * Run newly registered notifier for each session.
+ */
+void lttng_ust_run_statedump_notifier_for_each_session(struct lttng_ust_notifier *notifier)
+{
+	struct lttng_session *session;
+
+	rcu_read_lock();
+	cds_list_for_each_entry_rcu(session, &sessions, node)
+		notifier->callback(session, notifier->priv);
+	rcu_read_unlock();
+}
+
+/*
  * Only used internally at session destruction.
  */
 static
diff --git a/liblttng-ust/lttng-ust-statedump.c b/liblttng-ust/lttng-ust-statedump.c
index 37f067f..a7fc0b3 100644
--- a/liblttng-ust/lttng-ust-statedump.c
+++ b/liblttng-ust/lttng-ust-statedump.c
@@ -30,10 +30,14 @@
 #include <stdint.h>
 #include <stddef.h>
 #include <stdio.h>
+#include <urcu/hlist.h>
+#include <lttng/statedump-notifier.h>
+#include <helper.h>
 
 #include <usterr-signal-safe.h>
 #include "lttng-tracer-core.h"
 #include "lttng-ust-statedump.h"
+#include "jhash.h"
 
 #define TRACEPOINT_DEFINE
 #define TRACEPOINT_CREATE_PROBES
@@ -56,6 +60,91 @@ struct soinfo_data {
 
 typedef void (*tracepoint_cb)(struct lttng_session *session, void *priv);
 
+#define STATEDUMP_TABLE_BITS	4
+#define STATEDUMP_TABLE_SIZE	(1 << STATEDUMP_TABLE_BITS)
+
+struct lttng_statedump_table {
+	struct cds_hlist_head statedump_table[STATEDUMP_TABLE_SIZE];
+};
+
+struct lttng_statedump_node {
+	struct lttng_ust_notifier *notifier;
+	struct cds_hlist_node node;
+};
+
+struct lttng_statedump_table *lttng_statedump_table_create(void)
+{
+	struct lttng_statedump_table *st;
+	int i;
+
+	st = zmalloc(sizeof(*st));
+	if (!st)
+		return NULL;
+	for (i = 0; i < STATEDUMP_TABLE_SIZE; i++)
+		CDS_INIT_HLIST_HEAD(&st->statedump_table[i]);
+	return st;
+}
+
+void lttng_statedump_table_destroy(struct lttng_statedump_table *st)
+{
+	struct lttng_statedump_node *sn, *t;
+	int i;
+
+	for (i = 0; i < STATEDUMP_TABLE_SIZE; i++) {
+		cds_hlist_for_each_entry_safe_2(sn, t, &st->statedump_table[i], node) {
+			cds_hlist_del(&sn->node);
+			free(sn);
+		}
+	}
+	free(st);
+}
+
+int lttng_statedump_table_add(struct lttng_statedump_table *st,
+		struct lttng_ust_notifier *notifier)
+{
+	struct cds_hlist_head *head;
+	struct cds_hlist_node *node;
+	struct lttng_statedump_node *sn;
+	uint32_t hash;
+
+	hash = jhash(&notifier, sizeof(struct lttng_ust_notifier *), 0);
+	head = &st->statedump_table[hash & (STATEDUMP_TABLE_SIZE - 1)];
+	cds_hlist_for_each_entry(sn, node, head, node) {
+		if (sn->notifier == notifier)
+			return -EEXIST;
+	}
+	sn = zmalloc(sizeof(*sn));
+	if (!sn)
+		return -ENOMEM;
+	sn->notifier = notifier;
+	cds_hlist_add_head(&sn->node, head);
+	return 0;
+}
+
+int lttng_statedump_table_del(struct lttng_statedump_table *st,
+		struct lttng_ust_notifier *notifier)
+{
+	struct cds_hlist_head *head;
+	struct cds_hlist_node *node;
+	struct lttng_statedump_node *sn;
+	uint32_t hash;
+	int found = 0;
+
+	hash = jhash(&notifier, sizeof(struct lttng_ust_notifier *), 0);
+	head = &st->statedump_table[hash & (STATEDUMP_TABLE_SIZE - 1)];
+	cds_hlist_for_each_entry(sn, node, head, node) {
+		if (sn->notifier == notifier) {
+			found = 1;
+			break;
+		}
+	}
+	if (!found)
+		return -ENOENT;
+	cds_hlist_del(&sn->node);
+	free(sn);
+	return 0;
+}
+
 /*
  * Trace statedump event into all sessions owned by the caller thread
  * for which statedump is pending.
@@ -242,6 +331,7 @@ int do_lttng_ust_statedump(void *owner)
 {
 	trace_statedump_start(owner);
 	do_baddr_statedump(owner);
+	lttng_ust_run_statedump_notifiers(owner);
 	trace_statedump_end(owner);
 
 	return 0;
diff --git a/liblttng-ust/lttng-ust-statedump.h b/liblttng-ust/lttng-ust-statedump.h
index e78774d..462bd49 100644
--- a/liblttng-ust/lttng-ust-statedump.h
+++ b/liblttng-ust/lttng-ust-statedump.h
@@ -19,11 +19,22 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
  */
 
+#include <lttng/statedump-notifier.h>
 #include <lttng/ust-events.h>
 
 void lttng_ust_statedump_init(void);
 void lttng_ust_statedump_destroy(void);
 
 int do_lttng_ust_statedump(void *owner);
+void lttng_ust_run_statedump_notifiers(void *owner);
+void lttng_ust_run_statedump_notifier_for_each_session(struct lttng_ust_notifier *notifier);
+
+struct lttng_statedump_table *lttng_statedump_table_create(void);
+void lttng_statedump_table_destroy(struct lttng_statedump_table *st);
+
+int lttng_statedump_table_add(struct lttng_statedump_table *st,
+		struct lttng_ust_notifier *notifier);
+int lttng_statedump_table_del(struct lttng_statedump_table *st,
+		struct lttng_ust_notifier *notifier);
 
 #endif /* LTTNG_UST_STATEDUMP_H */
diff --git a/liblttng-ust/statedump-notifier.c b/liblttng-ust/statedump-notifier.c
new file mode 100644
index 0000000..b263199
--- /dev/null
+++ b/liblttng-ust/statedump-notifier.c
@@ -0,0 +1,133 @@
+/*
+ * statedump-notifier.c
+ *
+ * Copyright (C) 2015 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; only
+ * version 2.1 of the License.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#define _LGPL_SOURCE
+#define _GNU_SOURCE
+#include <lttng/statedump-notifier.h>
+#include <urcu/rculist.h>
+#include <urcu-bp.h>
+#include <lttng/ust-events.h>
+#include "lttng-ust-statedump.h"
+#include "lttng-tracer-core.h"
+
+/*
+ * The notifier list is a RCU list (RCU read-side, synchronize_rcu
+ * between removal and re-use) that has updates protected by the
+ * ust_lock().
+ */
+static CDS_LIST_HEAD(notifiers);
+
+/*
+ * The ust lock ensures consistency of the notifier between the
+ * per-session notifier hash set and the notifiers list.
+ */
+void lttng_ust_init_statedump_notifier(struct lttng_ust_notifier *notifier,
+		lttng_ust_statedump_cb callback, void *priv)
+{
+	notifier->callback = callback;
+	notifier->priv = priv;
+}
+
+void lttng_ust_register_statedump_notifier(struct lttng_ust_notifier *notifier)
+{
+	struct lttng_session *session;
+	struct cds_list_head *sessionsp;
+
+	ust_lock_nocheck();
+	cds_list_add_tail_rcu(&notifier->node, &notifiers);
+
+	sessionsp = _lttng_get_sessions();
+	cds_list_for_each_entry(session, sessionsp, node) {
+		/*
+		 * Adding this notifier to the statedump table of each
+		 * session ensures that we don't have duplicate events.
+		 */
+		if (lttng_statedump_table_add(session->statedump_table, notifier))
+			abort();
+	}
+	ust_unlock();
+
+	/* Run this notifier for each session. */
+	lttng_ust_run_statedump_notifier_for_each_session(notifier);
+}
+
+void lttng_ust_unregister_statedump_notifier(struct lttng_ust_notifier *notifier)
+{
+	struct lttng_session *session;
+	struct cds_list_head *sessionsp;
+
+	ust_lock_nocheck();
+	cds_list_del_rcu(&notifier->node);
+
+	sessionsp = _lttng_get_sessions();
+	cds_list_for_each_entry(session, sessionsp, node) {
+		if (lttng_statedump_table_del(session->statedump_table, notifier))
+			abort();
+	}
+	ust_unlock();
+	/*
+	 * Ensure we wait for a grace period before letting the
+	 * application re-use the notifier.
+	 */
+	synchronize_rcu();
+}
+
+/* Returns 1 if notifier was already run, 0 otherwise. */
+static int lttng_ust_notifier_test_and_set(struct lttng_session *session,
+		struct lttng_ust_notifier *notifier)
+{
+	int ret;
+
+	if (ust_lock()) {
+		ret = -EEXIST;
+		goto unlock;
+	}
+	ret = lttng_statedump_table_add(session->statedump_table,
+			notifier);
+unlock:
+	ust_unlock();
+	if (ret == -ENOMEM)
+		abort();
+	if (ret == -EEXIST)
+		return 1;
+	return 0;
+}
+
+void lttng_ust_run_statedump_notifiers(void *owner)
+{
+	struct cds_list_head *sessionsp;
+	struct lttng_session *session;
+
+	rcu_read_lock();
+	sessionsp = _lttng_get_sessions();
+	cds_list_for_each_entry_rcu(session, sessionsp, node) {
+		struct lttng_ust_notifier *notifier;
+
+		if (session->owner != owner)
+			continue;
+		if (!session->statedump_pending)
+			continue;
+		cds_list_for_each_entry_rcu(notifier, &notifiers, node) {
+			if (!lttng_ust_notifier_test_and_set(session, notifier))
+				notifier->callback(session, notifier->priv);
+		}
+	}
+	rcu_read_unlock();
+}
-- 
2.1.4
