From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu 4/4] test_rwlock: Add per-thread count to
 verbose output
Date: Fri, 23 Nov 2018 15:27:07 -0500
Message-ID: <20181123202707.19851-4-mjeanson__4781.74814857102$1543004798$gmane$org@efficios.com>
References: <20181123202707.19851-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 431nt82F2KzyDB
 for <lttng-dev@lists.lttng.org>; Fri, 23 Nov 2018 15:27:28 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id D82C89A094
 for <lttng-dev@lists.lttng.org>; Fri, 23 Nov 2018 15:27:22 -0500 (EST)
In-Reply-To: <20181123202707.19851-1-mjeanson@efficios.com>
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
 tests/benchmark/test_rwlock.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tests/benchmark/test_rwlock.c b/tests/benchmark/test_rwlock.c
index c23e782..02073f1 100644
--- a/tests/benchmark/test_rwlock.c
+++ b/tests/benchmark/test_rwlock.c
@@ -194,8 +194,9 @@ void *thr_reader(void *_count)
 	}
 
 	*count = URCU_TLS(nr_reads);
-	printf_verbose("thread_end %s, tid %lu\n",
-			"reader", urcu_get_thread_id());
+
+	printf_verbose("thread_end %s, tid %lu, count %llu\n",
+			"reader", urcu_get_thread_id(), *count);
 	return ((void*)1);
 
 }
@@ -236,10 +237,10 @@ void *thr_writer(void *_count)
 		if (caa_unlikely(wdelay))
 			loop_sleep(wdelay);
 	}
-
-	printf_verbose("thread_end %s, tid %lu\n",
-			"writer", urcu_get_thread_id());
 	*count = URCU_TLS(nr_writes);
+
+	printf_verbose("thread_end %s, tid %lu, count %llu\n",
+			"writer", urcu_get_thread_id(), *count);
 	return ((void*)2);
 }
 
@@ -333,6 +334,7 @@ int main(int argc, char **argv)
 	printf_verbose("running test for %lu seconds, %u readers, %u writers.\n",
 		duration, nr_readers, nr_writers);
 	printf_verbose("Writer delay : %lu loops.\n", wdelay);
+	printf_verbose("Writer duration : %lu loops.\n", wduration);
 	printf_verbose("Reader duration : %lu loops.\n", rduration);
 	printf_verbose("thread %-6s, tid %lu\n",
 			"main", urcu_get_thread_id());
-- 
2.17.1
