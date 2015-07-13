From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH 1/9] Move lttng utils count_order
	function to common utils
Date: Mon, 13 Jul 2015 11:28:01 -0400
Message-ID: <1436801289-17554-2-git-send-email-jdesfossez__16053.7162599669$1436801421$gmane$org@efficios.com>
References: <1436801289-17554-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZEfec-0008PK-BG
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 11:28:27 -0400
In-Reply-To: <1436801289-17554-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com, mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Part of this code was already duplicated for utils_get_count_order_u32,
move the rest of the functions in the common utils since they are going
to be useful for the consumer. Adapt the only user to use the new
version.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/bin/lttng/commands/enable_channels.c |   4 +-
 src/bin/lttng/utils.c                    | 152 -------------------------------
 src/bin/lttng/utils.h                    |  18 ----
 src/common/utils.c                       |  89 ++++++++++++++++++
 src/common/utils.h                       |   2 +
 5 files changed, 93 insertions(+), 172 deletions(-)

diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/commands/enable_channels.c
index 101617f..483dfd6 100644
--- a/src/bin/lttng/commands/enable_channels.c
+++ b/src/bin/lttng/commands/enable_channels.c
@@ -425,7 +425,7 @@ int cmd_enable_channels(int argc, const char **argv)
 				goto end;
 			}
 
-			order = get_count_order_u64(chan.attr.subbuf_size);
+			order = utils_get_count_order_u64(chan.attr.subbuf_size);
 			assert(order >= 0);
 			rounded_size = 1ULL << order;
 			if (rounded_size < chan.attr.subbuf_size) {
@@ -461,7 +461,7 @@ int cmd_enable_channels(int argc, const char **argv)
 				goto end;
 			}
 
-			order = get_count_order_u64(chan.attr.num_subbuf);
+			order = utils_get_count_order_u64(chan.attr.num_subbuf);
 			assert(order >= 0);
 			rounded_size = 1ULL << order;
 			if (rounded_size < chan.attr.num_subbuf) {
diff --git a/src/bin/lttng/utils.c b/src/bin/lttng/utils.c
index d52d462..d62c4a1 100644
--- a/src/bin/lttng/utils.c
+++ b/src/bin/lttng/utils.c
@@ -129,158 +129,6 @@ void list_cmd_options(FILE *ofp, struct poptOption *options)
 	}
 }
 
-/*
- * fls: returns the position of the most significant bit.
- * Returns 0 if no bit is set, else returns the position of the most
- * significant bit (from 1 to 32 on 32-bit, from 1 to 64 on 64-bit).
- */
-#if defined(__i386) || defined(__x86_64)
-static inline
-unsigned int fls_u32(uint32_t x)
-{
-	int r;
-
-	asm("bsrl %1,%0\n\t"
-	    "jnz 1f\n\t"
-	    "movl $-1,%0\n\t"
-	    "1:\n\t"
-	    : "=r" (r) : "rm" (x));
-	return r + 1;
-}
-#define HAS_FLS_U32
-#endif
-
-#if defined(__x86_64)
-static inline
-unsigned int fls_u64(uint64_t x)
-{
-	long r;
-
-	asm("bsrq %1,%0\n\t"
-	    "jnz 1f\n\t"
-	    "movq $-1,%0\n\t"
-	    "1:\n\t"
-	    : "=r" (r) : "rm" (x));
-	return r + 1;
-}
-#define HAS_FLS_U64
-#endif
-
-#ifndef HAS_FLS_U64
-static __attribute__((unused))
-unsigned int fls_u64(uint64_t x)
-{
-	unsigned int r = 64;
-
-	if (!x)
-		return 0;
-
-	if (!(x & 0xFFFFFFFF00000000ULL)) {
-		x <<= 32;
-		r -= 32;
-	}
-	if (!(x & 0xFFFF000000000000ULL)) {
-		x <<= 16;
-		r -= 16;
-	}
-	if (!(x & 0xFF00000000000000ULL)) {
-		x <<= 8;
-		r -= 8;
-	}
-	if (!(x & 0xF000000000000000ULL)) {
-		x <<= 4;
-		r -= 4;
-	}
-	if (!(x & 0xC000000000000000ULL)) {
-		x <<= 2;
-		r -= 2;
-	}
-	if (!(x & 0x8000000000000000ULL)) {
-		x <<= 1;
-		r -= 1;
-	}
-	return r;
-}
-#endif
-
-#ifndef HAS_FLS_U32
-static __attribute__((unused))
-unsigned int fls_u32(uint32_t x)
-{
-	unsigned int r = 32;
-
-	if (!x)
-		return 0;
-	if (!(x & 0xFFFF0000U)) {
-		x <<= 16;
-		r -= 16;
-	}
-	if (!(x & 0xFF000000U)) {
-		x <<= 8;
-		r -= 8;
-	}
-	if (!(x & 0xF0000000U)) {
-		x <<= 4;
-		r -= 4;
-	}
-	if (!(x & 0xC0000000U)) {
-		x <<= 2;
-		r -= 2;
-	}
-	if (!(x & 0x80000000U)) {
-		x <<= 1;
-		r -= 1;
-	}
-	return r;
-}
-#endif
-
-static
-unsigned int fls_ulong(unsigned long x)
-{
-#if (CAA_BITS_PER_LONG == 32)
-	return fls_u32(x);
-#else
-	return fls_u64(x);
-#endif
-}
-
-/*
- * Return the minimum order for which x <= (1UL << order).
- * Return -1 if x is 0.
- */
-int get_count_order_u32(uint32_t x)
-{
-	if (!x)
-		return -1;
-
-	return fls_u32(x - 1);
-}
-
-/*
- * Return the minimum order for which x <= (1UL << order).
- * Return -1 if x is 0.
- */
-int get_count_order_u64(uint64_t x)
-{
-	if (!x)
-		return -1;
-
-	return fls_u64(x - 1);
-}
-
-/*
- * Return the minimum order for which x <= (1UL << order).
- * Return -1 if x is 0.
- */
-int get_count_order_ulong(unsigned long x)
-{
-	if (!x)
-		return -1;
-
-	return fls_ulong(x - 1);
-}
-
 const char *get_domain_str(enum lttng_domain_type domain)
 {
 	const char *str_dom;
diff --git a/src/bin/lttng/utils.h b/src/bin/lttng/utils.h
index ea92bb9..42d7f1d 100644
--- a/src/bin/lttng/utils.h
+++ b/src/bin/lttng/utils.h
@@ -32,24 +32,6 @@ char *get_session_name_quiet(void);
 void list_commands(struct cmd_struct *commands, FILE *ofp);
 void list_cmd_options(FILE *ofp, struct poptOption *options);
 
-/*
- * Return the minimum order for which x <= (1UL << order).
- * Return -1 if x is 0.
- */
-int get_count_order_u32(uint32_t x);
-
-/*
- * Return the minimum order for which x <= (1UL << order).
- * Return -1 if x is 0.
- */
-int get_count_order_u64(uint64_t x);
-
-/*
- * Return the minimum order for which x <= (1UL << order).
- * Return -1 if x is 0.
- */
-int get_count_order_ulong(unsigned long x);
-
 const char *get_domain_str(enum lttng_domain_type domain);
 
 static inline
diff --git a/src/common/utils.c b/src/common/utils.c
index 4b733fb..21b6888 100644
--- a/src/common/utils.c
+++ b/src/common/utils.c
@@ -863,6 +863,59 @@ static __attribute__((unused)) unsigned int fls_u32(uint32_t x)
 }
 #endif
 
+#if defined(__x86_64)
+static inline
+unsigned int fls_u64(uint64_t x)
+{
+	long r;
+
+	asm("bsrq %1,%0\n\t"
+	    "jnz 1f\n\t"
+	    "movq $-1,%0\n\t"
+	    "1:\n\t"
+	    : "=r" (r) : "rm" (x));
+	return r + 1;
+}
+#define HAS_FLS_U64
+#endif
+
+#ifndef HAS_FLS_U64
+static __attribute__((unused))
+unsigned int fls_u64(uint64_t x)
+{
+	unsigned int r = 64;
+
+	if (!x)
+		return 0;
+
+	if (!(x & 0xFFFFFFFF00000000ULL)) {
+		x <<= 32;
+		r -= 32;
+	}
+	if (!(x & 0xFFFF000000000000ULL)) {
+		x <<= 16;
+		r -= 16;
+	}
+	if (!(x & 0xFF00000000000000ULL)) {
+		x <<= 8;
+		r -= 8;
+	}
+	if (!(x & 0xF000000000000000ULL)) {
+		x <<= 4;
+		r -= 4;
+	}
+	if (!(x & 0xC000000000000000ULL)) {
+		x <<= 2;
+		r -= 2;
+	}
+	if (!(x & 0x8000000000000000ULL)) {
+		x <<= 1;
+		r -= 1;
+	}
+	return r;
+}
+#endif
+
 /*
  * Return the minimum order for which x <= (1UL << order).
  * Return -1 if x is 0.
@@ -877,6 +930,42 @@ int utils_get_count_order_u32(uint32_t x)
 	return fls_u32(x - 1);
 }
 
+static
+unsigned int fls_ulong(unsigned long x)
+{
+#if (CAA_BITS_PER_LONG == 32)
+	return fls_u32(x);
+#else
+	return fls_u64(x);
+#endif
+}
+
+/*
+ * Return the minimum order for which x <= (1UL << order).
+ * Return -1 if x is 0.
+ */
+LTTNG_HIDDEN
+int utils_get_count_order_u64(uint64_t x)
+{
+	if (!x)
+		return -1;
+
+	return fls_u64(x - 1);
+}
+
+/*
+ * Return the minimum order for which x <= (1UL << order).
+ * Return -1 if x is 0.
+ */
+LTTNG_HIDDEN
+int utils_get_count_order_ulong(unsigned long x)
+{
+	if (!x)
+		return -1;
+
+	return fls_ulong(x - 1);
+}
+
 /**
  * Obtain the value of LTTNG_HOME environment variable, if exists.
  * Otherwise returns the value of HOME.
diff --git a/src/common/utils.h b/src/common/utils.h
index 05914cc..a255cfc 100644
--- a/src/common/utils.h
+++ b/src/common/utils.h
@@ -45,6 +45,8 @@ int utils_rotate_stream_file(char *path_name, char *file_name, uint64_t size,
 		int *stream_fd);
 int utils_parse_size_suffix(char const * const str, uint64_t * const size);
 int utils_get_count_order_u32(uint32_t x);
+int utils_get_count_order_u64(uint64_t x);
+int utils_get_count_order_ulong(unsigned long x);
 char *utils_get_home_dir(void);
 char *utils_get_user_home_dir(uid_t uid);
 char *utils_get_kmod_probes_list(void);
-- 
1.9.1
