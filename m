From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [lttng-tools PATCH 1/2] Fix: add missing VALGRIND ifdef
	checks and documentation
Date: Thu, 20 Feb 2014 10:23:45 -0500
Message-ID: <1392909826-4726-1-git-send-email-mathieu.desnoyers__43173.4389662326$1392909913$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1WGVTm-0003kf-CM
	for lttng-dev@lists.lttng.org; Thu, 20 Feb 2014 10:24:08 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 9C8A634021B
	for <lttng-dev@lists.lttng.org>; Thu, 20 Feb 2014 15:24:02 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 doc/Makefile.am                  |    2 +-
 doc/valgrind-howto.txt           |    4 ++++
 src/common/hashtable/rculfhash.c |    2 +-
 src/common/runas.c               |   16 +++++++++++++++-
 4 files changed, 21 insertions(+), 3 deletions(-)
 create mode 100644 doc/valgrind-howto.txt

diff --git a/doc/Makefile.am b/doc/Makefile.am
index 6f05d7a..4ff71eb 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -5,4 +5,4 @@ EXTRA_DIST = quickstart.txt streaming-howto.txt python-howto.txt \
 
 dist_doc_DATA = quickstart.txt streaming-howto.txt python-howto.txt \
 	snapshot-howto.txt calibrate.txt live-reading-howto.txt \
-	live-reading-protocol.txt
+	live-reading-protocol.txt valgrind-howto.txt
diff --git a/doc/valgrind-howto.txt b/doc/valgrind-howto.txt
new file mode 100644
index 0000000..68dcaba
--- /dev/null
+++ b/doc/valgrind-howto.txt
@@ -0,0 +1,4 @@
+Build lttng-tools with "-DVALGRIND" to create executables compatible
+with the valgrind tool. The start with e.g.:
+
+valgrind --leak-check=full lttng-sessiond
diff --git a/src/common/hashtable/rculfhash.c b/src/common/hashtable/rculfhash.c
index 0ddd21a..ee09afd 100644
--- a/src/common/hashtable/rculfhash.c
+++ b/src/common/hashtable/rculfhash.c
@@ -627,7 +627,7 @@ void free_split_items_count(struct cds_lfht *ht)
 	poison_free(ht->split_count);
 }
 
-#if defined(HAVE_SCHED_GETCPU)
+#if defined(HAVE_SCHED_GETCPU) && !defined(VALGRIND)
 static
 int ht_get_split_count_index(unsigned long hash)
 {
diff --git a/src/common/runas.c b/src/common/runas.c
index 9029f8f..5ab4271 100644
--- a/src/common/runas.c
+++ b/src/common/runas.c
@@ -77,6 +77,20 @@ struct run_as_open_data {
 	mode_t mode;
 };
 
+#ifdef VALGRIND
+static
+int use_clone(void)
+{
+	return 0;
+}
+#else
+static
+int use_clone(void)
+{
+	return !getenv("LTTNG_DEBUG_NOCLONE");
+}
+#endif
+
 /*
  * Create recursively directory using the FULL path.
  */
@@ -271,7 +285,7 @@ int run_as_noclone(int (*cmd)(void *data), void *data, uid_t uid, gid_t gid)
 static
 int run_as(int (*cmd)(void *data), void *data, uid_t uid, gid_t gid)
 {
-	if (!getenv("LTTNG_DEBUG_NOCLONE")) {
+	if (use_clone()) {
 		int ret;
 
 		DBG("Using run_as_clone");
-- 
1.7.10.4
