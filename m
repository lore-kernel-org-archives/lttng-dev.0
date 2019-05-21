From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 5/5] fix: random: only read from
 /dev/random after its pool has received 128 bits (v5.2)
Date: Tue, 21 May 2019 16:33:14 -0400
Message-ID: <20190521203314.8577-5-mjeanson__28173.2285324082$1558470963$gmane$org@efficios.com>
References: <20190521203314.8577-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 457nXZ5PDJz10X7
 for <lttng-dev@lists.lttng.org>; Tue, 21 May 2019 16:33:34 -0400 (EDT)
In-Reply-To: <20190521203314.8577-1-mjeanson@efficios.com>
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

See upstream commit:

  commit eb9d1bf079bb438d1a066d72337092935fc770f6
  Author: Theodore Ts'o <tytso@mit.edu>
  Date:   Wed Feb 20 16:06:38 2019 -0500

    random: only read from /dev/random after its pool has received 128 bits

    Immediately after boot, we allow reads from /dev/random before its
    entropy pool has been fully initialized.  Fix this so that we don't
    allow this until the blocking pool has received 128 bits.

    We do this by repurposing the initialized flag in the entropy pool
    struct, and use the initialized flag in the blocking pool to indicate
    whether it is safe to pull from the blocking pool.

    To do this, we needed to rework when we decide to push entropy from the
    input pool to the blocking pool, since the initialized flag for the
    input pool was used for this purpose.  To simplify things, we no
    longer use the initialized flag for that purpose, nor do we use the
    entropy_total field any more.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 instrumentation/events/lttng-module/random.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/instrumentation/events/lttng-module/random.h b/instrumentation/events/lttng-module/random.h
index f165600..80b2279 100644
--- a/instrumentation/events/lttng-module/random.h
+++ b/instrumentation/events/lttng-module/random.h
@@ -38,6 +38,24 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(random__mix_pool_bytes, mix_pool_bytes_noloc
 	TP_ARGS(pool_name, bytes, IP)
 )
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0))
+LTTNG_TRACEPOINT_EVENT_MAP(credit_entropy_bits,
+
+	random_credit_entropy_bits,
+
+	TP_PROTO(const char *pool_name, int bits, int entropy_count,
+		 unsigned long IP),
+
+	TP_ARGS(pool_name, bits, entropy_count, IP),
+
+	TP_FIELDS(
+		ctf_string(pool_name, pool_name)
+		ctf_integer(int, bits, bits)
+		ctf_integer(int, entropy_count, entropy_count)
+		ctf_integer(unsigned long, IP, IP)
+	)
+)
+#else
 LTTNG_TRACEPOINT_EVENT_MAP(credit_entropy_bits,
 
 	random_credit_entropy_bits,
@@ -55,6 +73,7 @@ LTTNG_TRACEPOINT_EVENT_MAP(credit_entropy_bits,
 		ctf_integer(unsigned long, IP, IP)
 	)
 )
+#endif
 
 LTTNG_TRACEPOINT_EVENT_MAP(get_random_bytes,
 
-- 
2.17.1
