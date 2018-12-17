From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu] Cleanup: compiler warning on 32-bit
 architectures
Date: Mon, 17 Dec 2018 15:23:14 -0500
Message-ID: <20181217202314.13803-1-mjeanson__40740.5612794266$1545078083$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43JXfJ5HNxz168b
 for <lttng-dev@lists.lttng.org>; Mon, 17 Dec 2018 15:23:20 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id EE6D0A5712
 for <lttng-dev@lists.lttng.org>; Mon, 17 Dec 2018 15:23:19 -0500 (EST)
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

Replace a runtime test for 64-bit arch by a preprocessor test to
fix this compiler warning on 32-bit archs :

  comparison is always true due to limited range of data type [-Wtype-limits]

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 src/rculfhash.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/src/rculfhash.c b/src/rculfhash.c
index 8942c80..d250a1d 100644
--- a/src/rculfhash.c
+++ b/src/rculfhash.c
@@ -1543,6 +1543,32 @@ void cds_lfht_create_bucket(struct cds_lfht *ht, unsigned long size)
 	}
 }
 
+#if (CAA_BITS_PER_LONG > 32)
+/*
+ * For 64-bit architectures, with max number of buckets small enough not to
+ * use the entire 64-bit memory mapping space (and allowing a fair number of
+ * hash table instances), use the mmap allocator, which is faster. Otherwise,
+ * fallback to the order allocator.
+ */
+static
+const struct cds_lfht_mm_type *get_mm_type(unsigned long max_nr_buckets)
+{
+	if (max_nr_buckets && max_nr_buckets <= (1ULL << 32))
+		return &cds_lfht_mm_mmap;
+	else
+		return &cds_lfht_mm_order;
+}
+#else
+/*
+ * For 32-bit architectures, use the order allocator.
+ */
+static
+const struct cds_lfht_mm_type *get_mm_type(unsigned long max_nr_buckets)
+{
+	return &cds_lfht_mm_order;
+}
+#endif
+
 struct cds_lfht *_cds_lfht_new(unsigned long init_size,
 			unsigned long min_nr_alloc_buckets,
 			unsigned long max_nr_buckets,
@@ -1566,24 +1592,7 @@ struct cds_lfht *_cds_lfht_new(unsigned long init_size,
 	 * Memory management plugin default.
 	 */
 	if (!mm) {
-		if (CAA_BITS_PER_LONG > 32
-				&& max_nr_buckets
-				&& max_nr_buckets <= (1ULL << 32)) {
-			/*
-			 * For 64-bit architectures, with max number of
-			 * buckets small enough not to use the entire
-			 * 64-bit memory mapping space (and allowing a
-			 * fair number of hash table instances), use the
-			 * mmap allocator, which is faster than the
-			 * order allocator.
-			 */
-			mm = &cds_lfht_mm_mmap;
-		} else {
-			/*
-			 * The fallback is to use the order allocator.
-			 */
-			mm = &cds_lfht_mm_order;
-		}
+		mm = get_mm_type(max_nr_buckets);
 	}
 
 	/* max_nr_buckets == 0 for order based mm means infinite */
-- 
2.17.1
