Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8907C7EE2E
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Jun 2023 18:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1686164104;
	bh=qUjclXkKBXsPyJRtqgQZOJF+mPkcl6Ov6v7f5mIrGjI=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Tp9PgZoBJOSlZiwM1cLummMC+qfMr9ZcuOklp1gfw449lBM5IzRLWonsVnk3zmUI9
	 sXDKVOL3N8LX6WRhkxe+oaU0SIc28M82Ko6PQ9KsUGO9lG3H/D5cw3rOew5uDSJByg
	 gRb3IEg9K+ypgqRlwtZYwfpaQUEFTGhuW4crBBSvj2EY3FcTixlYQ+my4kNGyYEc3x
	 aJXMN1eVNGhbndkxjjWxrC/rglxN/RBdkhRarsAPFalXUJYkldxWPB6GO/c54Nm1qm
	 ExfOZUy47XJCf3as/FUnbn0WujINSTrDB0GqraGjVQJ+H9krvjgPGESn9oDpCwYkBw
	 euPOyvHUq1nLQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QbxNm4xVRz1Xr2;
	Wed,  7 Jun 2023 14:55:04 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QbxNg3PpHz1Y3p
 for <lttng-dev@lists.lttng.org>; Wed,  7 Jun 2023 14:54:59 -0400 (EDT)
Received: from laura.hitronhub.home (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QbxNY1nmRz174M;
 Wed,  7 Jun 2023 14:54:53 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Wed,  7 Jun 2023 14:53:57 -0400
Message-Id: <20230607185359.8125-11-odion@efficios.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515201718.9809-1-odion@efficios.com>
References: <20230515201718.9809-1-odion@efficios.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH v2 10/12] urcu/annotate: Add CMM annotation
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Cc: Olivier Dion <odion@efficios.com>, Tony Finch <dot@dotat.at>,
 "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

The CMM annotation is highly experimental and not meant to be used by
user for now, even though it is exposed in the public API since some
parts of the liburcu public API require those annotations.

The main primitive is the cmm_annotate_t which denotes a group of memory
operations associated with a memory barrier. A group follows a state
machine, starting from the `CMM_ANNOTATE_VOID' state. The following are
the only valid transitions:

  CMM_ANNOTATE_VOID -> CMM_ANNOTATE_MB (acquire & release MB)
  CMM_ANNOTATE_VOID -> CMM_ANNOTATE_LOAD (acquire memory)
  CMM_ANNOTATE_LOAD -> CMM_ANNOTATE_MB (acquire MB)

The macro `cmm_annotate_define(name)' can be used to create an
annotation object on the stack. The rest of the `cmm_annotate_*' macros
can be used to change the state of the group after validating that the
transition is allowed. Some of these macros also inject TSAN annotations
to help it understand the flow of events in the program since it does
not currently support thread fence.

Sometime, a single memory access does not need to be associated with a
group. In the case, the acquire/release macros variant without the
`group' infix can be used to annotate memory accesses.

Note that TSAN can not be used on the liburcu-signal flavor. This is
because TSAN hijacks calls to sigaction(3) and places its own handler
that will deliver the signal to the application at a synchronization
point.

Thus, the usage of TSAN on the signal flavor is undefined
behavior. However, there's at least one known behavior which is a
deadlock between readers that want to unregister them-self by locking
the `rcu_registry_lock' while a synchronize RCU is made on the writer
side which has already locked that mutex until all the registered
readers execute a memory barrier in a signal handler defined by
liburcu-signal. However, TSAN will not call the registered handler while
waiting on the mutex. Therefore, the writer spin infinitely on
pthread_kill(3p) because the reader simply never complete the handshake.

See the deadlock minimal reproducer below.

Deadlock reproducer:
```
#include <poll.h>
#include <signal.h>

#include <pthread.h>

#define SIGURCU SIGUSR1

static pthread_mutex_t rcu_registry_lock = PTHREAD_MUTEX_INITIALIZER;
static int need_mb = 0;

static void *reader_side(void *nil)
{
	(void) nil;

	pthread_mutex_lock(&rcu_registry_lock);
	pthread_mutex_unlock(&rcu_registry_lock);

	return NULL;
}

static void writer_side(pthread_t reader)
{
	__atomic_store_n(&need_mb, 1, __ATOMIC_RELEASE);
	while (__atomic_load_n(&need_mb, __ATOMIC_ACQUIRE)) {
		pthread_kill(reader, SIGURCU);
		(void) poll(NULL, 0, 1);
	}
	pthread_mutex_unlock(&rcu_registry_lock);

	pthread_join(reader, NULL);
}

static void sigrcu_handler(int signo, siginfo_t *siginfo, void *context)
{
	(void) signo;
	(void) siginfo;
	(void) context;

	__atomic_store_n(&need_mb, 0, __ATOMIC_SEQ_CST);
}

static void install_signal(void)
{
	struct sigaction act;

	act.sa_sigaction = sigrcu_handler;
	act.sa_flags     = SA_SIGINFO | SA_RESTART;

	sigemptyset(&act.sa_mask);

	(void) sigaction(SIGURCU, &act, NULL);
}

int main(void)
{
	pthread_t th;

	install_signal();

	pthread_mutex_lock(&rcu_registry_lock);
	pthread_create(&th, NULL, reader_side, NULL);

	writer_side(th);

	return 0;
}
```

Change-Id: I9c234bb311cc0f82ea9dbefdf4fee07047ab93f9
Co-authored-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Olivier Dion <odion@efficios.com>
---
 include/Makefile.am               |   1 +
 include/urcu/annotate.h           | 174 ++++++++++++++++++++++++++++++
 include/urcu/arch/generic.h       |  33 +++++-
 include/urcu/compiler.h           |  14 +++
 include/urcu/static/urcu-bp.h     |  12 ++-
 include/urcu/static/urcu-common.h |   8 +-
 include/urcu/static/urcu-mb.h     |  11 +-
 include/urcu/static/urcu-memb.h   |  26 +++--
 include/urcu/static/urcu-qsbr.h   |  29 +++--
 src/rculfhash.c                   |  92 ++++++++++------
 src/urcu-bp.c                     |  17 ++-
 src/urcu-qsbr.c                   |  31 ++++--
 src/urcu-wait.h                   |   9 +-
 src/urcu.c                        |  24 +++--
 14 files changed, 392 insertions(+), 89 deletions(-)
 create mode 100644 include/urcu/annotate.h

diff --git a/include/Makefile.am b/include/Makefile.am
index b20e56d..24151c1 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -1,4 +1,5 @@
 nobase_include_HEADERS = \
+	urcu/annotate.h \
 	urcu/arch/aarch64.h \
 	urcu/arch/alpha.h \
 	urcu/arch/arm.h \
diff --git a/include/urcu/annotate.h b/include/urcu/annotate.h
new file mode 100644
index 0000000..37e7f03
--- /dev/null
+++ b/include/urcu/annotate.h
@@ -0,0 +1,174 @@
+/*
+ * urcu/annotate.h
+ *
+ * Userspace RCU - annotation header.
+ *
+ * Copyright 2023 - Olivier Dion <odion@efficios.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+/*
+ * WARNING!
+ *
+ * This API is highly experimental. There is zero guarantees of stability
+ * between releases.
+ *
+ * You have been warned.
+ */
+#ifndef _URCU_ANNOTATE_H
+#define _URCU_ANNOTATE_H
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#include <urcu/compiler.h>
+
+enum cmm_annotate {
+	CMM_ANNOTATE_VOID,
+	CMM_ANNOTATE_LOAD,
+	CMM_ANNOTATE_STORE,
+	CMM_ANNOTATE_MB,
+};
+
+typedef enum cmm_annotate cmm_annotate_t __attribute__((unused));
+
+#define cmm_annotate_define(name)		\
+	cmm_annotate_t name = CMM_ANNOTATE_VOID
+
+#ifdef CMM_SANITIZE_THREAD
+
+# ifdef __cplusplus
+extern "C" {
+# endif
+extern void __tsan_acquire(void *);
+extern void __tsan_release(void *);
+# ifdef __cplusplus
+}
+# endif
+
+# define cmm_annotate_die(msg)						\
+	do {								\
+		fprintf(stderr,						\
+			"(" __FILE__ ":%s@%u) Annotation ERROR: %s\n",	\
+			__func__, __LINE__, msg);			\
+		abort();						\
+	} while (0)
+
+/* Only used for typechecking in macros. */
+static inline cmm_annotate_t cmm_annotate_dereference(cmm_annotate_t *group)
+{
+	return *group;
+}
+
+# define cmm_annotate_group_mb_acquire(group)				\
+	do {								\
+		switch (cmm_annotate_dereference(group)) {		\
+		case CMM_ANNOTATE_VOID:					\
+			break;						\
+		case CMM_ANNOTATE_LOAD:					\
+			break;						\
+		case CMM_ANNOTATE_STORE:				\
+			cmm_annotate_die("store for acquire group");	\
+			break;						\
+		case CMM_ANNOTATE_MB:					\
+			cmm_annotate_die(				\
+				"redundant mb for acquire group"	\
+					);				\
+			break;						\
+		}							\
+		*(group) = CMM_ANNOTATE_MB;				\
+	} while (0)
+
+# define cmm_annotate_group_mb_release(group)				\
+	do {								\
+		switch (cmm_annotate_dereference(group)) {		\
+		case CMM_ANNOTATE_VOID:					\
+			break;						\
+		case CMM_ANNOTATE_LOAD:					\
+			cmm_annotate_die("load before release group");	\
+			break;						\
+		case CMM_ANNOTATE_STORE:				\
+			cmm_annotate_die(				\
+				"store before release group"		\
+					);				\
+			break;						\
+		case CMM_ANNOTATE_MB:					\
+			cmm_annotate_die(				\
+				"redundant mb of release group"		\
+					);				\
+			break;						\
+		}							\
+		*(group) = CMM_ANNOTATE_MB;				\
+	} while (0)
+
+# define cmm_annotate_group_mem_acquire(group, mem)			\
+	do {								\
+		__tsan_acquire((void*)(mem));				\
+		switch (cmm_annotate_dereference(group)) {		\
+		case CMM_ANNOTATE_VOID:					\
+			*(group) = CMM_ANNOTATE_LOAD;			\
+			break;						\
+		case CMM_ANNOTATE_MB:					\
+			cmm_annotate_die(				\
+				"load after mb for acquire group"	\
+					);				\
+			break;						\
+		default:						\
+			break;						\
+		}							\
+	} while (0)
+
+# define cmm_annotate_group_mem_release(group, mem)		\
+	do {							\
+		__tsan_release((void*)(mem));			\
+		switch (cmm_annotate_dereference(group)) {	\
+		case CMM_ANNOTATE_MB:				\
+			break;					\
+		default:					\
+			cmm_annotate_die(			\
+				"missing mb for release group"	\
+					);			\
+		}						\
+	} while (0)
+
+# define cmm_annotate_mem_acquire(mem)		\
+	__tsan_acquire((void*)(mem))
+
+# define cmm_annotate_mem_release(mem)		\
+	__tsan_release((void*)(mem))
+#else
+
+# define cmm_annotate_group_mb_acquire(group)	\
+	(void) (group)
+
+# define cmm_annotate_group_mb_release(group)	\
+	(void) (group)
+
+# define cmm_annotate_group_mem_acquire(group, mem)	\
+	(void) (group)
+
+# define cmm_annotate_group_mem_release(group, mem)	\
+	(void) (group)
+
+# define cmm_annotate_mem_acquire(mem)		\
+	do { } while (0)
+
+# define cmm_annotate_mem_release(mem)		\
+	do { } while (0)
+
+#endif  /* CMM_SANITIZE_THREAD */
+
+#endif	/* _URCU_ANNOTATE_H */
diff --git a/include/urcu/arch/generic.h b/include/urcu/arch/generic.h
index e292c70..65dedf2 100644
--- a/include/urcu/arch/generic.h
+++ b/include/urcu/arch/generic.h
@@ -45,9 +45,38 @@ extern "C" {
 
 #ifdef CONFIG_RCU_USE_ATOMIC_BUILTINS
 
+# ifdef CMM_SANITIZE_THREAD
+/*
+ * This makes TSAN quiet about unsupported thread fence.
+ */
+static inline void _cmm_thread_fence_wrapper(void)
+{
+#   if defined(__clang__)
+#    pragma clang diagnostic push
+#    pragma clang diagnostic ignored "-Wpragmas"
+#    pragma clang diagnostic ignored "-Wunknown-warning-option"
+#    pragma clang diagnostic ignored "-Wtsan"
+#   elif defined(__GNUC__)
+#    pragma GCC diagnostic push
+#    pragma GCC diagnostic ignored "-Wpragmas"
+#    pragma GCC diagnostic ignored "-Wtsan"
+#   endif
+	__atomic_thread_fence(__ATOMIC_SEQ_CST);
+#   if defined(__clang__)
+#    pragma clang diagnostic pop
+#   elif defined(__GNUC__)
+#    pragma GCC diagnostic pop
+#   endif
+}
+# endif	 /* CMM_SANITIZE_THREAD */
+
 # ifndef cmm_smp_mb
-#  define cmm_smp_mb() __atomic_thread_fence(__ATOMIC_SEQ_CST)
-# endif
+#  ifdef CMM_SANITIZE_THREAD
+#   define cmm_smp_mb() _cmm_thread_fence_wrapper()
+#  else
+#   define cmm_smp_mb() __atomic_thread_fence(__ATOMIC_SEQ_CST)
+#  endif /* CMM_SANITIZE_THREAD */
+# endif /* !cmm_smp_mb */
 
 #endif	/* CONFIG_RCU_USE_ATOMIC_BUILTINS */
 
diff --git a/include/urcu/compiler.h b/include/urcu/compiler.h
index 3604488..b0c7850 100644
--- a/include/urcu/compiler.h
+++ b/include/urcu/compiler.h
@@ -129,4 +129,18 @@
 				+ __GNUC_PATCHLEVEL__)
 #endif
 
+/*
+ * Allow user to manually define CMM_SANITIZE_THREAD if their toolchain is not
+ * supported by this check.
+ */
+#ifndef CMM_SANITIZE_THREAD
+# if defined(__GNUC__) && defined(__SANITIZE_THREAD__)
+#  define CMM_SANITIZE_THREAD
+# elif defined(__clang__) && defined(__has_feature)
+#  if __has_feature(thread_sanitizer)
+#   define CMM_SANITIZE_THREAD
+#  endif
+# endif
+#endif	/* !CMM_SANITIZE_THREAD */
+
 #endif /* _URCU_COMPILER_H */
diff --git a/include/urcu/static/urcu-bp.h b/include/urcu/static/urcu-bp.h
index 8ba3830..3e14ef7 100644
--- a/include/urcu/static/urcu-bp.h
+++ b/include/urcu/static/urcu-bp.h
@@ -33,6 +33,7 @@
 #include <pthread.h>
 #include <unistd.h>
 
+#include <urcu/annotate.h>
 #include <urcu/debug.h>
 #include <urcu/config.h>
 #include <urcu/compiler.h>
@@ -117,7 +118,8 @@ static inline void urcu_bp_smp_mb_slave(void)
 		cmm_smp_mb();
 }
 
-static inline enum urcu_bp_state urcu_bp_reader_state(unsigned long *ctr)
+static inline enum urcu_bp_state urcu_bp_reader_state(unsigned long *ctr,
+						cmm_annotate_t *group)
 {
 	unsigned long v;
 
@@ -127,7 +129,9 @@ static inline enum urcu_bp_state urcu_bp_reader_state(unsigned long *ctr)
 	 * Make sure both tests below are done on the same version of *value
 	 * to insure consistency.
 	 */
-	v = CMM_LOAD_SHARED(*ctr);
+	v = uatomic_load(ctr, CMM_RELAXED);
+	cmm_annotate_group_mem_acquire(group, ctr);
+
 	if (!(v & URCU_BP_GP_CTR_NEST_MASK))
 		return URCU_BP_READER_INACTIVE;
 	if (!((v ^ urcu_bp_gp.ctr) & URCU_BP_GP_CTR_PHASE))
@@ -181,12 +185,14 @@ static inline void _urcu_bp_read_lock(void)
 static inline void _urcu_bp_read_unlock(void)
 {
 	unsigned long tmp;
+	unsigned long *ctr = &URCU_TLS(urcu_bp_reader)->ctr;
 
 	tmp = URCU_TLS(urcu_bp_reader)->ctr;
 	urcu_assert_debug(tmp & URCU_BP_GP_CTR_NEST_MASK);
 	/* Finish using rcu before decrementing the pointer. */
 	urcu_bp_smp_mb_slave();
-	_CMM_STORE_SHARED(URCU_TLS(urcu_bp_reader)->ctr, tmp - URCU_BP_GP_COUNT);
+	cmm_annotate_mem_release(ctr);
+	uatomic_store(ctr, tmp - URCU_BP_GP_COUNT, CMM_RELAXED);
 	cmm_barrier();	/* Ensure the compiler does not reorder us with mutex */
 }
 
diff --git a/include/urcu/static/urcu-common.h b/include/urcu/static/urcu-common.h
index 60ea8b8..32cb834 100644
--- a/include/urcu/static/urcu-common.h
+++ b/include/urcu/static/urcu-common.h
@@ -34,6 +34,7 @@
 #include <unistd.h>
 #include <stdint.h>
 
+#include <urcu/annotate.h>
 #include <urcu/config.h>
 #include <urcu/compiler.h>
 #include <urcu/arch.h>
@@ -105,7 +106,8 @@ static inline void urcu_common_wake_up_gp(struct urcu_gp *gp)
 }
 
 static inline enum urcu_state urcu_common_reader_state(struct urcu_gp *gp,
-		unsigned long *ctr)
+						unsigned long *ctr,
+						cmm_annotate_t *group)
 {
 	unsigned long v;
 
@@ -113,7 +115,9 @@ static inline enum urcu_state urcu_common_reader_state(struct urcu_gp *gp,
 	 * Make sure both tests below are done on the same version of *value
 	 * to insure consistency.
 	 */
-	v = CMM_LOAD_SHARED(*ctr);
+	v = uatomic_load(ctr, CMM_RELAXED);
+	cmm_annotate_group_mem_acquire(group, ctr);
+
 	if (!(v & URCU_GP_CTR_NEST_MASK))
 		return URCU_READER_INACTIVE;
 	if (!((v ^ gp->ctr) & URCU_GP_CTR_PHASE))
diff --git a/include/urcu/static/urcu-mb.h b/include/urcu/static/urcu-mb.h
index b97e42a..5bf7933 100644
--- a/include/urcu/static/urcu-mb.h
+++ b/include/urcu/static/urcu-mb.h
@@ -108,13 +108,14 @@ static inline void _urcu_mb_read_lock(void)
  */
 static inline void _urcu_mb_read_unlock_update_and_wakeup(unsigned long tmp)
 {
+	unsigned long *ctr = &URCU_TLS(urcu_mb_reader).ctr;
+
 	if (caa_likely((tmp & URCU_GP_CTR_NEST_MASK) == URCU_GP_COUNT)) {
-		cmm_smp_mb();
-		_CMM_STORE_SHARED(URCU_TLS(urcu_mb_reader).ctr, tmp - URCU_GP_COUNT);
-		cmm_smp_mb();
+		uatomic_store(ctr, tmp - URCU_GP_COUNT, CMM_SEQ_CST);
 		urcu_common_wake_up_gp(&urcu_mb_gp);
-	} else
-		_CMM_STORE_SHARED(URCU_TLS(urcu_mb_reader).ctr, tmp - URCU_GP_COUNT);
+	} else {
+		uatomic_store(ctr, tmp - URCU_GP_COUNT, CMM_RELAXED);
+	}
 }
 
 /*
diff --git a/include/urcu/static/urcu-memb.h b/include/urcu/static/urcu-memb.h
index c8d102f..8191ccc 100644
--- a/include/urcu/static/urcu-memb.h
+++ b/include/urcu/static/urcu-memb.h
@@ -34,6 +34,7 @@
 #include <unistd.h>
 #include <stdint.h>
 
+#include <urcu/annotate.h>
 #include <urcu/debug.h>
 #include <urcu/config.h>
 #include <urcu/compiler.h>
@@ -93,11 +94,20 @@ extern DECLARE_URCU_TLS(struct urcu_reader, urcu_memb_reader);
  */
 static inline void _urcu_memb_read_lock_update(unsigned long tmp)
 {
+	unsigned long *ctr = &URCU_TLS(urcu_memb_reader).ctr;
+
 	if (caa_likely(!(tmp & URCU_GP_CTR_NEST_MASK))) {
-		_CMM_STORE_SHARED(URCU_TLS(urcu_memb_reader).ctr, _CMM_LOAD_SHARED(urcu_memb_gp.ctr));
+		unsigned long *pgctr = &urcu_memb_gp.ctr;
+		unsigned long gctr = uatomic_load(pgctr, CMM_RELAXED);
+
+		/* Paired with following mb slave. */
+		cmm_annotate_mem_acquire(pgctr);
+		uatomic_store(ctr, gctr, CMM_RELAXED);
+
 		urcu_memb_smp_mb_slave();
-	} else
-		_CMM_STORE_SHARED(URCU_TLS(urcu_memb_reader).ctr, tmp + URCU_GP_COUNT);
+	} else {
+		uatomic_store(ctr, tmp + URCU_GP_COUNT, CMM_RELAXED);
+	}
 }
 
 /*
@@ -131,13 +141,17 @@ static inline void _urcu_memb_read_lock(void)
  */
 static inline void _urcu_memb_read_unlock_update_and_wakeup(unsigned long tmp)
 {
+	unsigned long *ctr = &URCU_TLS(urcu_memb_reader).ctr;
+
 	if (caa_likely((tmp & URCU_GP_CTR_NEST_MASK) == URCU_GP_COUNT)) {
 		urcu_memb_smp_mb_slave();
-		_CMM_STORE_SHARED(URCU_TLS(urcu_memb_reader).ctr, tmp - URCU_GP_COUNT);
+		cmm_annotate_mem_release(ctr);
+		uatomic_store(ctr, tmp - URCU_GP_COUNT, CMM_RELAXED);
 		urcu_memb_smp_mb_slave();
 		urcu_common_wake_up_gp(&urcu_memb_gp);
-	} else
-		_CMM_STORE_SHARED(URCU_TLS(urcu_memb_reader).ctr, tmp - URCU_GP_COUNT);
+	} else {
+		uatomic_store(ctr, tmp - URCU_GP_COUNT, CMM_RELAXED);
+	}
 }
 
 /*
diff --git a/include/urcu/static/urcu-qsbr.h b/include/urcu/static/urcu-qsbr.h
index b878877..864cbcf 100644
--- a/include/urcu/static/urcu-qsbr.h
+++ b/include/urcu/static/urcu-qsbr.h
@@ -35,6 +35,7 @@
 #include <unistd.h>
 #include <stdint.h>
 
+#include <urcu/annotate.h>
 #include <urcu/debug.h>
 #include <urcu/compiler.h>
 #include <urcu/arch.h>
@@ -96,11 +97,14 @@ static inline void urcu_qsbr_wake_up_gp(void)
 	}
 }
 
-static inline enum urcu_state urcu_qsbr_reader_state(unsigned long *ctr)
+static inline enum urcu_state urcu_qsbr_reader_state(unsigned long *ctr,
+						cmm_annotate_t *group)
 {
 	unsigned long v;
 
-	v = CMM_LOAD_SHARED(*ctr);
+	v = uatomic_load(ctr, CMM_RELAXED);
+	cmm_annotate_group_mem_acquire(group, ctr);
+
 	if (!v)
 		return URCU_READER_INACTIVE;
 	if (v == urcu_qsbr_gp.ctr)
@@ -155,9 +159,9 @@ static inline int _urcu_qsbr_read_ongoing(void)
  */
 static inline void _urcu_qsbr_quiescent_state_update_and_wakeup(unsigned long gp_ctr)
 {
-	cmm_smp_mb();
-	_CMM_STORE_SHARED(URCU_TLS(urcu_qsbr_reader).ctr, gp_ctr);
-	cmm_smp_mb();	/* write URCU_TLS(urcu_qsbr_reader).ctr before read futex */
+	uatomic_store(&URCU_TLS(urcu_qsbr_reader).ctr, gp_ctr, CMM_SEQ_CST);
+
+	/* write URCU_TLS(urcu_qsbr_reader).ctr before read futex */
 	urcu_qsbr_wake_up_gp();
 	cmm_smp_mb();
 }
@@ -179,7 +183,8 @@ static inline void _urcu_qsbr_quiescent_state(void)
 	unsigned long gp_ctr;
 
 	urcu_assert_debug(URCU_TLS(urcu_qsbr_reader).registered);
-	if ((gp_ctr = CMM_LOAD_SHARED(urcu_qsbr_gp.ctr)) == URCU_TLS(urcu_qsbr_reader).ctr)
+	gp_ctr = uatomic_load(&urcu_qsbr_gp.ctr, CMM_RELAXED);
+	if (gp_ctr == URCU_TLS(urcu_qsbr_reader).ctr)
 		return;
 	_urcu_qsbr_quiescent_state_update_and_wakeup(gp_ctr);
 }
@@ -195,9 +200,8 @@ static inline void _urcu_qsbr_quiescent_state(void)
 static inline void _urcu_qsbr_thread_offline(void)
 {
 	urcu_assert_debug(URCU_TLS(urcu_qsbr_reader).registered);
-	cmm_smp_mb();
-	CMM_STORE_SHARED(URCU_TLS(urcu_qsbr_reader).ctr, 0);
-	cmm_smp_mb();	/* write URCU_TLS(urcu_qsbr_reader).ctr before read futex */
+	uatomic_store(&URCU_TLS(urcu_qsbr_reader).ctr, 0, CMM_SEQ_CST);
+	/* write URCU_TLS(urcu_qsbr_reader).ctr before read futex */
 	urcu_qsbr_wake_up_gp();
 	cmm_barrier();	/* Ensure the compiler does not reorder us with mutex */
 }
@@ -212,9 +216,14 @@ static inline void _urcu_qsbr_thread_offline(void)
  */
 static inline void _urcu_qsbr_thread_online(void)
 {
+	unsigned long *pctr = &URCU_TLS(urcu_qsbr_reader).ctr;
+	unsigned long ctr;
+
 	urcu_assert_debug(URCU_TLS(urcu_qsbr_reader).registered);
 	cmm_barrier();	/* Ensure the compiler does not reorder us with mutex */
-	_CMM_STORE_SHARED(URCU_TLS(urcu_qsbr_reader).ctr, CMM_LOAD_SHARED(urcu_qsbr_gp.ctr));
+	ctr = uatomic_load(&urcu_qsbr_gp.ctr, CMM_RELAXED);
+	cmm_annotate_mem_acquire(&urcu_qsbr_gp.ctr);
+	uatomic_store(pctr, ctr, CMM_RELAXED);
 	cmm_smp_mb();
 }
 
diff --git a/src/rculfhash.c b/src/rculfhash.c
index b456415..cdc2aee 100644
--- a/src/rculfhash.c
+++ b/src/rculfhash.c
@@ -623,9 +623,7 @@ static void mutex_lock(pthread_mutex_t *mutex)
 		if (ret != EBUSY && ret != EINTR)
 			urcu_die(ret);
 		if (CMM_LOAD_SHARED(URCU_TLS(rcu_reader).need_mb)) {
-			cmm_smp_mb();
-			_CMM_STORE_SHARED(URCU_TLS(rcu_reader).need_mb, 0);
-			cmm_smp_mb();
+			uatomic_store(&URCU_TLS(rcu_reader).need_mb, 0, CMM_SEQ_CST);
 		}
 		(void) poll(NULL, 0, 10);
 	}
@@ -883,8 +881,10 @@ unsigned long _uatomic_xchg_monotonic_increase(unsigned long *ptr,
 	old1 = uatomic_read(ptr);
 	do {
 		old2 = old1;
-		if (old2 >= v)
+		if (old2 >= v) {
+			cmm_smp_mb();
 			return old2;
+		}
 	} while ((old1 = uatomic_cmpxchg(ptr, old2, v)) != old2);
 	return old2;
 }
@@ -1190,15 +1190,17 @@ int _cds_lfht_del(struct cds_lfht *ht, unsigned long size,
 	/*
 	 * The del operation semantic guarantees a full memory barrier
 	 * before the uatomic_or atomic commit of the deletion flag.
-	 */
-	cmm_smp_mb__before_uatomic_or();
-	/*
+	 *
 	 * We set the REMOVED_FLAG unconditionally. Note that there may
 	 * be more than one concurrent thread setting this flag.
 	 * Knowing which wins the race will be known after the garbage
 	 * collection phase, stay tuned!
+	 *
+	 * NOTE: The cast is here because Clang says that address argument to
+	 * atomic operation must be a pointer to integer.
 	 */
-	uatomic_or(&node->next, REMOVED_FLAG);
+	uatomic_or_mo((uintptr_t*) &node->next, REMOVED_FLAG, CMM_RELEASE);
+
 	/* We performed the (logical) deletion. */
 
 	/*
@@ -1223,7 +1225,7 @@ int _cds_lfht_del(struct cds_lfht *ht, unsigned long size,
 	 * was already set).
 	 */
 	if (!is_removal_owner(uatomic_xchg(&node->next,
-			flag_removal_owner(node->next))))
+			flag_removal_owner(uatomic_load(&node->next, CMM_RELAXED)))))
 		return 0;
 	else
 		return -ENOENT;
@@ -1389,9 +1391,10 @@ void init_table(struct cds_lfht *ht,
 
 		/*
 		 * Update table size.
+		 *
+		 * Populate data before RCU size.
 		 */
-		cmm_smp_wmb();	/* populate data before RCU size */
-		CMM_STORE_SHARED(ht->size, 1UL << i);
+		uatomic_store(&ht->size, 1UL << i, CMM_RELEASE);
 
 		dbg_printf("init new size: %lu\n", 1UL << i);
 		if (CMM_LOAD_SHARED(ht->in_progress_destroy))
@@ -1440,8 +1443,12 @@ void remove_table_partition(struct cds_lfht *ht, unsigned long i,
 		urcu_posix_assert(j >= size && j < (size << 1));
 		dbg_printf("remove entry: order %lu index %lu hash %lu\n",
 			   i, j, j);
-		/* Set the REMOVED_FLAG to freeze the ->next for gc */
-		uatomic_or(&fini_bucket->next, REMOVED_FLAG);
+		/* Set the REMOVED_FLAG to freeze the ->next for gc.
+		 *
+		 * NOTE: The cast is here because Clang says that address
+		 * argument to atomic operation must be a pointer to integer.
+		 */
+		uatomic_or((uintptr_t*) &fini_bucket->next, REMOVED_FLAG);
 		_cds_lfht_gc_bucket(parent_bucket, fini_bucket);
 	}
 	ht->flavor->read_unlock();
@@ -1667,7 +1674,14 @@ void cds_lfht_lookup(struct cds_lfht *ht, unsigned long hash,
 
 	reverse_hash = bit_reverse_ulong(hash);
 
-	size = rcu_dereference(ht->size);
+	/*
+	 * Use load acquire instead of rcu_dereference because there is no
+	 * dependency between the table size and the dereference of the bucket
+	 * content.
+	 *
+	 * This acquire is paired with the store release in init_table().
+	 */
+	size = uatomic_load(&ht->size, CMM_ACQUIRE);
 	bucket = lookup_bucket(ht, size, hash);
 	/* We can always skip the bucket node initially */
 	node = rcu_dereference(bucket->next);
@@ -1726,7 +1740,7 @@ void cds_lfht_next_duplicate(struct cds_lfht *ht __attribute__((unused)),
 		}
 		node = clear_flag(next);
 	}
-	urcu_posix_assert(!node || !is_bucket(CMM_LOAD_SHARED(node->next)));
+	urcu_posix_assert(!node || !is_bucket(uatomic_load(&node->next, CMM_RELAXED)));
 	iter->node = node;
 	iter->next = next;
 }
@@ -1750,7 +1764,7 @@ void cds_lfht_next(struct cds_lfht *ht __attribute__((unused)),
 		}
 		node = clear_flag(next);
 	}
-	urcu_posix_assert(!node || !is_bucket(CMM_LOAD_SHARED(node->next)));
+	urcu_posix_assert(!node || !is_bucket(uatomic_load(&node->next, CMM_RELAXED)));
 	iter->node = node;
 	iter->next = next;
 }
@@ -1762,7 +1776,7 @@ void cds_lfht_first(struct cds_lfht *ht, struct cds_lfht_iter *iter)
 	 * Get next after first bucket node. The first bucket node is the
 	 * first node of the linked list.
 	 */
-	iter->next = bucket_at(ht, 0)->next;
+	iter->next = uatomic_load(&bucket_at(ht, 0)->next, CMM_CONSUME);
 	cds_lfht_next(ht, iter);
 }
 
@@ -1772,7 +1786,7 @@ void cds_lfht_add(struct cds_lfht *ht, unsigned long hash,
 	unsigned long size;
 
 	node->reverse_hash = bit_reverse_ulong(hash);
-	size = rcu_dereference(ht->size);
+	size = uatomic_load(&ht->size, CMM_ACQUIRE);
 	_cds_lfht_add(ht, hash, NULL, NULL, size, node, NULL, 0);
 	ht_count_add(ht, size, hash);
 }
@@ -1787,7 +1801,7 @@ struct cds_lfht_node *cds_lfht_add_unique(struct cds_lfht *ht,
 	struct cds_lfht_iter iter;
 
 	node->reverse_hash = bit_reverse_ulong(hash);
-	size = rcu_dereference(ht->size);
+	size = uatomic_load(&ht->size, CMM_ACQUIRE);
 	_cds_lfht_add(ht, hash, match, key, size, node, &iter, 0);
 	if (iter.node == node)
 		ht_count_add(ht, size, hash);
@@ -1804,7 +1818,7 @@ struct cds_lfht_node *cds_lfht_add_replace(struct cds_lfht *ht,
 	struct cds_lfht_iter iter;
 
 	node->reverse_hash = bit_reverse_ulong(hash);
-	size = rcu_dereference(ht->size);
+	size = uatomic_load(&ht->size, CMM_ACQUIRE);
 	for (;;) {
 		_cds_lfht_add(ht, hash, match, key, size, node, &iter, 0);
 		if (iter.node == node) {
@@ -1833,7 +1847,7 @@ int cds_lfht_replace(struct cds_lfht *ht,
 		return -EINVAL;
 	if (caa_unlikely(!match(old_iter->node, key)))
 		return -EINVAL;
-	size = rcu_dereference(ht->size);
+	size = uatomic_load(&ht->size, CMM_ACQUIRE);
 	return _cds_lfht_replace(ht, size, old_iter->node, old_iter->next,
 			new_node);
 }
@@ -1843,7 +1857,7 @@ int cds_lfht_del(struct cds_lfht *ht, struct cds_lfht_node *node)
 	unsigned long size;
 	int ret;
 
-	size = rcu_dereference(ht->size);
+	size = uatomic_load(&ht->size, CMM_ACQUIRE);
 	ret = _cds_lfht_del(ht, size, node);
 	if (!ret) {
 		unsigned long hash;
@@ -1957,7 +1971,7 @@ int cds_lfht_destroy(struct cds_lfht *ht, pthread_attr_t **attr)
 		if (!cds_lfht_is_empty(ht))
 			return -EPERM;
 		/* Cancel ongoing resize operations. */
-		_CMM_STORE_SHARED(ht->in_progress_destroy, 1);
+		uatomic_store(&ht->in_progress_destroy, 1, CMM_RELAXED);
 		if (attr) {
 			*attr = ht->caller_resize_attr;
 			ht->caller_resize_attr = NULL;
@@ -2077,19 +2091,22 @@ void _do_cds_lfht_resize(struct cds_lfht *ht)
 	 * Resize table, re-do if the target size has changed under us.
 	 */
 	do {
-		if (CMM_LOAD_SHARED(ht->in_progress_destroy))
+		if (uatomic_load(&ht->in_progress_destroy, CMM_RELAXED))
 			break;
-		ht->resize_initiated = 1;
+
+		uatomic_store(&ht->resize_initiated, 1, CMM_RELAXED);
+
 		old_size = ht->size;
-		new_size = CMM_LOAD_SHARED(ht->resize_target);
+		new_size = uatomic_load(&ht->resize_target, CMM_RELAXED);
 		if (old_size < new_size)
 			_do_cds_lfht_grow(ht, old_size, new_size);
 		else if (old_size > new_size)
 			_do_cds_lfht_shrink(ht, old_size, new_size);
-		ht->resize_initiated = 0;
+
+		uatomic_store(&ht->resize_initiated, 0, CMM_RELAXED);
 		/* write resize_initiated before read resize_target */
 		cmm_smp_mb();
-	} while (ht->size != CMM_LOAD_SHARED(ht->resize_target));
+	} while (ht->size != uatomic_load(&ht->resize_target, CMM_RELAXED));
 }
 
 static
@@ -2110,7 +2127,12 @@ void resize_target_update_count(struct cds_lfht *ht,
 void cds_lfht_resize(struct cds_lfht *ht, unsigned long new_size)
 {
 	resize_target_update_count(ht, new_size);
-	CMM_STORE_SHARED(ht->resize_initiated, 1);
+
+	/*
+	 * Set flags has early as possible even in contention case.
+	 */
+	uatomic_store(&ht->resize_initiated, 1, CMM_RELAXED);
+
 	mutex_lock(&ht->resize_mutex);
 	_do_cds_lfht_resize(ht);
 	mutex_unlock(&ht->resize_mutex);
@@ -2136,10 +2158,12 @@ void __cds_lfht_resize_lazy_launch(struct cds_lfht *ht)
 {
 	struct resize_work *work;
 
-	/* Store resize_target before read resize_initiated */
-	cmm_smp_mb();
-	if (!CMM_LOAD_SHARED(ht->resize_initiated)) {
-		if (CMM_LOAD_SHARED(ht->in_progress_destroy)) {
+	/*
+	 * Store to resize_target is before read resize_initiated as guaranteed
+	 * by either cmpxchg or _uatomic_xchg_monotonic_increase.
+	 */
+	if (!uatomic_load(&ht->resize_initiated, CMM_RELAXED)) {
+		if (uatomic_load(&ht->in_progress_destroy, CMM_RELAXED)) {
 			return;
 		}
 		work = malloc(sizeof(*work));
@@ -2150,7 +2174,7 @@ void __cds_lfht_resize_lazy_launch(struct cds_lfht *ht)
 		work->ht = ht;
 		urcu_workqueue_queue_work(cds_lfht_workqueue,
 			&work->work, do_resize_cb);
-		CMM_STORE_SHARED(ht->resize_initiated, 1);
+		uatomic_store(&ht->resize_initiated, 1, CMM_RELAXED);
 	}
 }
 
diff --git a/src/urcu-bp.c b/src/urcu-bp.c
index 47fad8e..08aaa88 100644
--- a/src/urcu-bp.c
+++ b/src/urcu-bp.c
@@ -36,6 +36,7 @@
 #include <stdbool.h>
 #include <sys/mman.h>
 
+#include <urcu/annotate.h>
 #include <urcu/assert.h>
 #include <urcu/config.h>
 #include <urcu/arch.h>
@@ -220,7 +221,8 @@ static void smp_mb_master(void)
  */
 static void wait_for_readers(struct cds_list_head *input_readers,
 			struct cds_list_head *cur_snap_readers,
-			struct cds_list_head *qsreaders)
+			struct cds_list_head *qsreaders,
+			cmm_annotate_t *group)
 {
 	unsigned int wait_loops = 0;
 	struct urcu_bp_reader *index, *tmp;
@@ -235,7 +237,7 @@ static void wait_for_readers(struct cds_list_head *input_readers,
 			wait_loops++;
 
 		cds_list_for_each_entry_safe(index, tmp, input_readers, node) {
-			switch (urcu_bp_reader_state(&index->ctr)) {
+			switch (urcu_bp_reader_state(&index->ctr, group)) {
 			case URCU_BP_READER_ACTIVE_CURRENT:
 				if (cur_snap_readers) {
 					cds_list_move(&index->node,
@@ -274,6 +276,8 @@ static void wait_for_readers(struct cds_list_head *input_readers,
 
 void urcu_bp_synchronize_rcu(void)
 {
+	cmm_annotate_define(acquire_group);
+	cmm_annotate_define(release_group);
 	CDS_LIST_HEAD(cur_snap_readers);
 	CDS_LIST_HEAD(qsreaders);
 	sigset_t newmask, oldmask;
@@ -295,13 +299,14 @@ void urcu_bp_synchronize_rcu(void)
 	 * where new ptr points to. */
 	/* Write new ptr before changing the qparity */
 	smp_mb_master();
+	cmm_annotate_group_mb_release(&release_group);
 
 	/*
 	 * Wait for readers to observe original parity or be quiescent.
 	 * wait_for_readers() can release and grab again rcu_registry_lock
 	 * internally.
 	 */
-	wait_for_readers(&registry, &cur_snap_readers, &qsreaders);
+	wait_for_readers(&registry, &cur_snap_readers, &qsreaders, &acquire_group);
 
 	/*
 	 * Adding a cmm_smp_mb() which is _not_ formally required, but makes the
@@ -311,7 +316,8 @@ void urcu_bp_synchronize_rcu(void)
 	cmm_smp_mb();
 
 	/* Switch parity: 0 -> 1, 1 -> 0 */
-	CMM_STORE_SHARED(rcu_gp.ctr, rcu_gp.ctr ^ URCU_BP_GP_CTR_PHASE);
+	cmm_annotate_group_mem_release(&release_group, &rcu_gp.ctr);
+	uatomic_store(&rcu_gp.ctr, rcu_gp.ctr ^ URCU_BP_GP_CTR_PHASE, CMM_RELAXED);
 
 	/*
 	 * Must commit qparity update to memory before waiting for other parity
@@ -332,7 +338,7 @@ void urcu_bp_synchronize_rcu(void)
 	 * wait_for_readers() can release and grab again rcu_registry_lock
 	 * internally.
 	 */
-	wait_for_readers(&cur_snap_readers, NULL, &qsreaders);
+	wait_for_readers(&cur_snap_readers, NULL, &qsreaders, &acquire_group);
 
 	/*
 	 * Put quiescent reader list back into registry.
@@ -344,6 +350,7 @@ void urcu_bp_synchronize_rcu(void)
 	 * freed.
 	 */
 	smp_mb_master();
+	cmm_annotate_group_mb_acquire(&acquire_group);
 out:
 	mutex_unlock(&rcu_registry_lock);
 	mutex_unlock(&rcu_gp_lock);
diff --git a/src/urcu-qsbr.c b/src/urcu-qsbr.c
index 318ab29..fd50e80 100644
--- a/src/urcu-qsbr.c
+++ b/src/urcu-qsbr.c
@@ -34,6 +34,7 @@
 #include <errno.h>
 #include <poll.h>
 
+#include <urcu/annotate.h>
 #include <urcu/assert.h>
 #include <urcu/wfcqueue.h>
 #include <urcu/map/urcu-qsbr.h>
@@ -156,7 +157,8 @@ static void wait_gp(void)
  */
 static void wait_for_readers(struct cds_list_head *input_readers,
 			struct cds_list_head *cur_snap_readers,
-			struct cds_list_head *qsreaders)
+			struct cds_list_head *qsreaders,
+			cmm_annotate_t *group)
 {
 	unsigned int wait_loops = 0;
 	struct urcu_qsbr_reader *index, *tmp;
@@ -183,7 +185,7 @@ static void wait_for_readers(struct cds_list_head *input_readers,
 			cmm_smp_mb();
 		}
 		cds_list_for_each_entry_safe(index, tmp, input_readers, node) {
-			switch (urcu_qsbr_reader_state(&index->ctr)) {
+			switch (urcu_qsbr_reader_state(&index->ctr, group)) {
 			case URCU_READER_ACTIVE_CURRENT:
 				if (cur_snap_readers) {
 					cds_list_move(&index->node,
@@ -208,8 +210,7 @@ static void wait_for_readers(struct cds_list_head *input_readers,
 		if (cds_list_empty(input_readers)) {
 			if (wait_loops >= RCU_QS_ACTIVE_ATTEMPTS) {
 				/* Read reader_gp before write futex */
-				cmm_smp_mb();
-				uatomic_set(&urcu_qsbr_gp.futex, 0);
+				uatomic_store(&urcu_qsbr_gp.futex, 0, CMM_RELEASE);
 			}
 			break;
 		} else {
@@ -238,6 +239,8 @@ static void wait_for_readers(struct cds_list_head *input_readers,
 #if (CAA_BITS_PER_LONG < 64)
 void urcu_qsbr_synchronize_rcu(void)
 {
+	cmm_annotate_define(acquire_group);
+	cmm_annotate_define(release_group);
 	CDS_LIST_HEAD(cur_snap_readers);
 	CDS_LIST_HEAD(qsreaders);
 	unsigned long was_online;
@@ -258,6 +261,7 @@ void urcu_qsbr_synchronize_rcu(void)
 		urcu_qsbr_thread_offline();
 	else
 		cmm_smp_mb();
+	cmm_annotate_group_mb_release(&release_group);
 
 	/*
 	 * Add ourself to gp_waiters queue of threads awaiting to wait
@@ -289,7 +293,7 @@ void urcu_qsbr_synchronize_rcu(void)
 	 * wait_for_readers() can release and grab again rcu_registry_lock
 	 * internally.
 	 */
-	wait_for_readers(&registry, &cur_snap_readers, &qsreaders);
+	wait_for_readers(&registry, &cur_snap_readers, &qsreaders, &acquire_group);
 
 	/*
 	 * Must finish waiting for quiescent state for original parity
@@ -309,7 +313,8 @@ void urcu_qsbr_synchronize_rcu(void)
 	cmm_smp_mb();
 
 	/* Switch parity: 0 -> 1, 1 -> 0 */
-	CMM_STORE_SHARED(urcu_qsbr_gp.ctr, urcu_qsbr_gp.ctr ^ URCU_QSBR_GP_CTR);
+	cmm_annotate_group_mem_release(&release_group, &urcu_qsbr_gp.ctr);
+	uatomic_store(&urcu_qsbr_gp.ctr, urcu_qsbr_gp.ctr ^ URCU_QSBR_GP_CTR, CMM_RELAXED);
 
 	/*
 	 * Must commit urcu_qsbr_gp.ctr update to memory before waiting for
@@ -332,7 +337,7 @@ void urcu_qsbr_synchronize_rcu(void)
 	 * wait_for_readers() can release and grab again rcu_registry_lock
 	 * internally.
 	 */
-	wait_for_readers(&cur_snap_readers, NULL, &qsreaders);
+	wait_for_readers(&cur_snap_readers, NULL, &qsreaders, &acquire_group);
 
 	/*
 	 * Put quiescent reader list back into registry.
@@ -347,6 +352,8 @@ gp_end:
 	 * Finish waiting for reader threads before letting the old ptr being
 	 * freed.
 	 */
+	cmm_annotate_group_mb_acquire(&acquire_group);
+
 	if (was_online)
 		urcu_qsbr_thread_online();
 	else
@@ -355,6 +362,8 @@ gp_end:
 #else /* !(CAA_BITS_PER_LONG < 64) */
 void urcu_qsbr_synchronize_rcu(void)
 {
+	cmm_annotate_define(acquire_group);
+	cmm_annotate_define(release_group);
 	CDS_LIST_HEAD(qsreaders);
 	unsigned long was_online;
 	DEFINE_URCU_WAIT_NODE(wait, URCU_WAIT_WAITING);
@@ -371,6 +380,7 @@ void urcu_qsbr_synchronize_rcu(void)
 		urcu_qsbr_thread_offline();
 	else
 		cmm_smp_mb();
+	cmm_annotate_group_mb_release(&release_group);
 
 	/*
 	 * Add ourself to gp_waiters queue of threads awaiting to wait
@@ -398,7 +408,8 @@ void urcu_qsbr_synchronize_rcu(void)
 		goto out;
 
 	/* Increment current G.P. */
-	CMM_STORE_SHARED(urcu_qsbr_gp.ctr, urcu_qsbr_gp.ctr + URCU_QSBR_GP_CTR);
+	cmm_annotate_group_mem_release(&release_group, &urcu_qsbr_gp.ctr);
+	uatomic_store(&urcu_qsbr_gp.ctr, urcu_qsbr_gp.ctr + URCU_QSBR_GP_CTR, CMM_RELAXED);
 
 	/*
 	 * Must commit urcu_qsbr_gp.ctr update to memory before waiting for
@@ -421,7 +432,7 @@ void urcu_qsbr_synchronize_rcu(void)
 	 * wait_for_readers() can release and grab again rcu_registry_lock
 	 * internally.
 	 */
-	wait_for_readers(&registry, NULL, &qsreaders);
+	wait_for_readers(&registry, NULL, &qsreaders, &acquire_group);
 
 	/*
 	 * Put quiescent reader list back into registry.
@@ -436,6 +447,8 @@ gp_end:
 		urcu_qsbr_thread_online();
 	else
 		cmm_smp_mb();
+
+	cmm_annotate_group_mb_acquire(&acquire_group);
 }
 #endif  /* !(CAA_BITS_PER_LONG < 64) */
 
diff --git a/src/urcu-wait.h b/src/urcu-wait.h
index 4667a13..1ffced4 100644
--- a/src/urcu-wait.h
+++ b/src/urcu-wait.h
@@ -126,9 +126,8 @@ void urcu_wait_node_init(struct urcu_wait_node *node,
 static inline
 void urcu_adaptative_wake_up(struct urcu_wait_node *wait)
 {
-	cmm_smp_mb();
 	urcu_posix_assert(uatomic_read(&wait->state) == URCU_WAIT_WAITING);
-	uatomic_set(&wait->state, URCU_WAIT_WAKEUP);
+	uatomic_store(&wait->state, URCU_WAIT_WAKEUP, CMM_RELEASE);
 	if (!(uatomic_read(&wait->state) & URCU_WAIT_RUNNING)) {
 		if (futex_noasync(&wait->state, FUTEX_WAKE, 1,
 				NULL, NULL, 0) < 0)
@@ -150,11 +149,11 @@ void urcu_adaptative_busy_wait(struct urcu_wait_node *wait)
 	/* Load and test condition before read state */
 	cmm_smp_rmb();
 	for (i = 0; i < URCU_WAIT_ATTEMPTS; i++) {
-		if (uatomic_read(&wait->state) != URCU_WAIT_WAITING)
+		if (uatomic_load(&wait->state, CMM_ACQUIRE) != URCU_WAIT_WAITING)
 			goto skip_futex_wait;
 		caa_cpu_relax();
 	}
-	while (uatomic_read(&wait->state) == URCU_WAIT_WAITING) {
+	while (uatomic_load(&wait->state, CMM_ACQUIRE) == URCU_WAIT_WAITING) {
 		if (!futex_noasync(&wait->state, FUTEX_WAIT, URCU_WAIT_WAITING, NULL, NULL, 0)) {
 			/*
 			 * Prior queued wakeups queued by unrelated code
@@ -189,7 +188,7 @@ skip_futex_wait:
 	 * memory allocated for struct urcu_wait.
 	 */
 	for (i = 0; i < URCU_WAIT_ATTEMPTS; i++) {
-		if (uatomic_read(&wait->state) & URCU_WAIT_TEARDOWN)
+		if (uatomic_load(&wait->state, CMM_RELAXED) & URCU_WAIT_TEARDOWN)
 			break;
 		caa_cpu_relax();
 	}
diff --git a/src/urcu.c b/src/urcu.c
index c60307e..353e9bb 100644
--- a/src/urcu.c
+++ b/src/urcu.c
@@ -38,6 +38,7 @@
 #include <poll.h>
 
 #include <urcu/config.h>
+#include <urcu/annotate.h>
 #include <urcu/assert.h>
 #include <urcu/arch.h>
 #include <urcu/wfcqueue.h>
@@ -300,7 +301,8 @@ end:
  */
 static void wait_for_readers(struct cds_list_head *input_readers,
 			struct cds_list_head *cur_snap_readers,
-			struct cds_list_head *qsreaders)
+			struct cds_list_head *qsreaders,
+			cmm_annotate_t *group)
 {
 	unsigned int wait_loops = 0;
 	struct urcu_reader *index, *tmp;
@@ -323,7 +325,7 @@ static void wait_for_readers(struct cds_list_head *input_readers,
 		}
 
 		cds_list_for_each_entry_safe(index, tmp, input_readers, node) {
-			switch (urcu_common_reader_state(&rcu_gp, &index->ctr)) {
+			switch (urcu_common_reader_state(&rcu_gp, &index->ctr, group)) {
 			case URCU_READER_ACTIVE_CURRENT:
 				if (cur_snap_readers) {
 					cds_list_move(&index->node,
@@ -407,6 +409,8 @@ static void wait_for_readers(struct cds_list_head *input_readers,
 
 void synchronize_rcu(void)
 {
+	cmm_annotate_define(acquire_group);
+	cmm_annotate_define(release_group);
 	CDS_LIST_HEAD(cur_snap_readers);
 	CDS_LIST_HEAD(qsreaders);
 	DEFINE_URCU_WAIT_NODE(wait, URCU_WAIT_WAITING);
@@ -421,10 +425,11 @@ void synchronize_rcu(void)
 	 * queue before their insertion into the wait queue.
 	 */
 	if (urcu_wait_add(&gp_waiters, &wait) != 0) {
-		/* Not first in queue: will be awakened by another thread. */
+		/*
+		 * Not first in queue: will be awakened by another thread.
+		 * Implies a memory barrier after grace period.
+		 */
 		urcu_adaptative_busy_wait(&wait);
-		/* Order following memory accesses after grace period. */
-		cmm_smp_mb();
 		return;
 	}
 	/* We won't need to wake ourself up */
@@ -449,13 +454,14 @@ void synchronize_rcu(void)
 	 */
 	/* Write new ptr before changing the qparity */
 	smp_mb_master();
+	cmm_annotate_group_mb_release(&release_group);
 
 	/*
 	 * Wait for readers to observe original parity or be quiescent.
 	 * wait_for_readers() can release and grab again rcu_registry_lock
 	 * internally.
 	 */
-	wait_for_readers(&registry, &cur_snap_readers, &qsreaders);
+	wait_for_readers(&registry, &cur_snap_readers, &qsreaders, &acquire_group);
 
 	/*
 	 * Must finish waiting for quiescent state for original parity before
@@ -474,7 +480,8 @@ void synchronize_rcu(void)
 	cmm_smp_mb();
 
 	/* Switch parity: 0 -> 1, 1 -> 0 */
-	CMM_STORE_SHARED(rcu_gp.ctr, rcu_gp.ctr ^ URCU_GP_CTR_PHASE);
+	cmm_annotate_group_mem_release(&release_group, &rcu_gp.ctr);
+	uatomic_store(&rcu_gp.ctr, rcu_gp.ctr ^ URCU_GP_CTR_PHASE, CMM_RELAXED);
 
 	/*
 	 * Must commit rcu_gp.ctr update to memory before waiting for quiescent
@@ -497,7 +504,7 @@ void synchronize_rcu(void)
 	 * wait_for_readers() can release and grab again rcu_registry_lock
 	 * internally.
 	 */
-	wait_for_readers(&cur_snap_readers, NULL, &qsreaders);
+	wait_for_readers(&cur_snap_readers, NULL, &qsreaders, &acquire_group);
 
 	/*
 	 * Put quiescent reader list back into registry.
@@ -510,6 +517,7 @@ void synchronize_rcu(void)
 	 * iterates on reader threads.
 	 */
 	smp_mb_master();
+	cmm_annotate_group_mb_acquire(&acquire_group);
 out:
 	mutex_unlock(&rcu_registry_lock);
 	mutex_unlock(&rcu_gp_lock);
-- 
2.40.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
