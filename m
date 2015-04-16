From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH] Update regmap instrumentation for Linux 3.19.4
	and 4.0
Date: Thu, 16 Apr 2015 16:45:09 -0400
Message-ID: <1429217109-8983-1-git-send-email-simon.marchi__14454.8771706924$1429217168$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [96.127.255.83] (helo=smtp.electronicbox.net)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <simon.marchi@polymtl.ca>) id 1Yiqey-0000Qt-EB
 for lttng-dev@lists.lttng.org; Thu, 16 Apr 2015 16:45:20 -0400
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

This is necessary after commit c6b570d97c0e77f570bb6b2ed30d372b2b1e9aae in the kernel.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 instrumentation/events/lttng-module/regmap.h | 123 +++++++++++++++++++++++++--
 1 file changed, 116 insertions(+), 7 deletions(-)

diff --git a/instrumentation/events/lttng-module/regmap.h b/instrumentation/events/lttng-module/regmap.h
index eef3c6c..7edc575 100644
--- a/instrumentation/events/lttng-module/regmap.h
+++ b/instrumentation/events/lttng-module/regmap.h
@@ -31,13 +31,29 @@ LTTNG_TRACEPOINT_EVENT_CLASS(regmap_reg,
 	)
 )
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,4))
+LTTNG_TRACEPOINT_EVENT_INSTANCE(regmap_reg, regmap_reg_write,
+
+	TP_PROTO(struct regmap *map, unsigned int reg,
+		 unsigned int val),
+
+	TP_ARGS(map, reg, val)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(regmap_reg, regmap_reg_read,
+
+	TP_PROTO(struct regmap *map, unsigned int reg,
+		 unsigned int val),
+
+	TP_ARGS(map, reg, val)
+)
+#else
 LTTNG_TRACEPOINT_EVENT_INSTANCE(regmap_reg, regmap_reg_write,
 
 	TP_PROTO(struct device *dev, unsigned int reg,
 		 unsigned int val),
 
 	TP_ARGS(dev, reg, val)
-
 )
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(regmap_reg, regmap_reg_read,
@@ -46,20 +62,69 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(regmap_reg, regmap_reg_read,
 		 unsigned int val),
 
 	TP_ARGS(dev, reg, val)
-
 )
+#endif
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,4))
+LTTNG_TRACEPOINT_EVENT_INSTANCE(regmap_reg, regmap_reg_read_cache,
+
+	TP_PROTO(struct regmap *map, unsigned int reg,
+		 unsigned int val),
+
+	TP_ARGS(map, reg, val)
+)
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
 LTTNG_TRACEPOINT_EVENT_INSTANCE(regmap_reg, regmap_reg_read_cache,
 
 	TP_PROTO(struct device *dev, unsigned int reg,
 		 unsigned int val),
 
 	TP_ARGS(dev, reg, val)
-
 )
 #endif
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,4))
+LTTNG_TRACEPOINT_EVENT_CLASS(regmap_block,
+
+	TP_PROTO(struct device *dev, unsigned int reg, int count),
+
+	TP_ARGS(dev, reg, count),
+
+	TP_FIELDS(
+		ctf_string(name, dev_name(dev))
+		ctf_integer(unsigned int, reg, reg)
+		ctf_integer(int, count, count)
+	)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(regmap_block, regmap_hw_read_start,
+
+	TP_PROTO(struct regmap *map, unsigned int reg, int count),
+
+	TP_ARGS(map, reg, count)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(regmap_block, regmap_hw_read_done,
+
+	TP_PROTO(struct regmap *map, unsigned int reg, int count),
+
+	TP_ARGS(map, reg, count)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(regmap_block, regmap_hw_write_start,
+
+	TP_PROTO(struct regmap *map, unsigned int reg, int count),
+
+	TP_ARGS(map, reg, count)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(regmap_block, regmap_hw_write_done,
+
+	TP_PROTO(struct regmap *map, unsigned int reg, int count),
+
+	TP_ARGS(map, reg, count)
+)
+#else
 LTTNG_TRACEPOINT_EVENT_CLASS(regmap_block,
 
 	TP_PROTO(struct device *dev, unsigned int reg, int count),
@@ -100,7 +165,25 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(regmap_block, regmap_hw_write_done,
 
 	TP_ARGS(dev, reg, count)
 )
+#endif
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,4))
+LTTNG_TRACEPOINT_EVENT_MAP(regcache_sync,
 
+	regmap_regcache_sync,
+
+	TP_PROTO(struct regmap *map, const char *type,
+		 const char *status),
+
+	TP_ARGS(map, type, status),
+
+	TP_FIELDS(
+		ctf_string(name, regmap_name(map))
+		ctf_string(status, status)
+		ctf_string(type, type)
+	)
+)
+#else
 LTTNG_TRACEPOINT_EVENT_MAP(regcache_sync,
 
 	regmap_regcache_sync,
@@ -116,8 +199,36 @@ LTTNG_TRACEPOINT_EVENT_MAP(regcache_sync,
 		ctf_string(type, type)
 	)
 )
+#endif
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,4))
+LTTNG_TRACEPOINT_EVENT_CLASS(regmap_bool,
+
+	TP_PROTO(struct regmap *map, bool flag),
+
+	TP_ARGS(map, flag),
+
+	TP_FIELDS(
+		ctf_string(name, regmap_name(map))
+		ctf_integer(int, flag, flag)
+	)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(regmap_bool, regmap_cache_only,
+
+	TP_PROTO(struct regmap *map, bool flag),
+
+	TP_ARGS(map, flag)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(regmap_bool, regmap_cache_bypass,
+
+	TP_PROTO(struct regmap *map, bool flag),
+
+	TP_ARGS(map, flag)
+
+)
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
 LTTNG_TRACEPOINT_EVENT_CLASS(regmap_bool,
 
 	TP_PROTO(struct device *dev, bool flag),
@@ -135,7 +246,6 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(regmap_bool, regmap_cache_only,
 	TP_PROTO(struct device *dev, bool flag),
 
 	TP_ARGS(dev, flag)
-
 )
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(regmap_bool, regmap_cache_bypass,
@@ -143,7 +253,6 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(regmap_bool, regmap_cache_bypass,
 	TP_PROTO(struct device *dev, bool flag),
 
 	TP_ARGS(dev, flag)
-
 )
 #endif
 
-- 
2.3.5
