From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu] Cleanup: missing sign compare fixes
Date: Wed, 19 Dec 2018 11:44:57 -0500
Message-ID: <20181219164457.16915-1-mjeanson__40135.2943307304$1545237790$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43KgjX21zsz16LW
 for <lttng-dev@lists.lttng.org>; Wed, 19 Dec 2018 11:45:04 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 64199A744A
 for <lttng-dev@lists.lttng.org>; Wed, 19 Dec 2018 11:45:03 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 tests/benchmark/test_perthreadlock.c | 2 +-
 tests/benchmark/test_urcu_gc.c       | 4 ++--
 tests/benchmark/test_urcu_qsbr_gc.c  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/benchmark/test_perthreadlock.c b/tests/benchmark/test_perthreadlock.c
index 512b1fc..13fc820 100644
--- a/tests/benchmark/test_perthreadlock.c
+++ b/tests/benchmark/test_perthreadlock.c
@@ -207,7 +207,7 @@ void *thr_reader(void *data)
 void *thr_writer(void *data)
 {
 	unsigned long wtidx = (unsigned long)data;
-	long tidx;
+	unsigned long tidx;
 
 	printf_verbose("thread_begin %s, tid %lu\n",
 			"writer", urcu_get_thread_id());
diff --git a/tests/benchmark/test_urcu_gc.c b/tests/benchmark/test_urcu_gc.c
index 1e50e4c..34cf141 100644
--- a/tests/benchmark/test_urcu_gc.c
+++ b/tests/benchmark/test_urcu_gc.c
@@ -55,7 +55,7 @@ static unsigned long wdelay;
 
 static struct test_array *test_rcu_pointer;
 
-static unsigned int reclaim_batch = 1;
+static long reclaim_batch = 1;
 
 struct reclaim_queue {
 	void **queue;	/* Beginning of queue */
@@ -449,7 +449,7 @@ int main(int argc, char **argv)
 	printf("SUMMARY %-25s testdur %4lu nr_readers %3u rdur %6lu wdur %6lu "
 		"nr_writers %3u "
 		"wdelay %6lu nr_reads %12llu nr_writes %12llu nr_ops %12llu "
-		"batch %u\n",
+		"batch %ld\n",
 		argv[0], duration, nr_readers, rduration, wduration,
 		nr_writers, wdelay, tot_reads, tot_writes,
 		tot_reads + tot_writes, reclaim_batch);
diff --git a/tests/benchmark/test_urcu_qsbr_gc.c b/tests/benchmark/test_urcu_qsbr_gc.c
index 11f0359..26bc352 100644
--- a/tests/benchmark/test_urcu_qsbr_gc.c
+++ b/tests/benchmark/test_urcu_qsbr_gc.c
@@ -57,7 +57,7 @@ static unsigned long duration;
 
 /* read-side C.S. duration, in loops */
 static unsigned long rduration;
-static unsigned int reclaim_batch = 1;
+static long reclaim_batch = 1;
 
 struct reclaim_queue {
 	void **queue;	/* Beginning of queue */
@@ -450,7 +450,7 @@ int main(int argc, char **argv)
 	printf("SUMMARY %-25s testdur %4lu nr_readers %3u rdur %6lu wdur %6lu "
 		"nr_writers %3u "
 		"wdelay %6lu nr_reads %12llu nr_writes %12llu nr_ops %12llu "
-		"batch %u\n",
+		"batch %ld\n",
 		argv[0], duration, nr_readers, rduration, wduration,
 		nr_writers, wdelay, tot_reads, tot_writes,
 		tot_reads + tot_writes, reclaim_batch);
-- 
2.17.1
