Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E47DC7EE25
	for <lttng-dev@archiver.kernel.org>; Mon, 15 May 2023 20:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684181931;
	bh=srvrWrsyhYPCU4tG74yaWotKG7dL5roRgucGt255zRo=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=xNDNLocEX8uVdae8R3KATit3wnJTsgrlgk8IBTjkSOlG4TetAs1yHU5UBTTniOE1h
	 SpTU7JrB4u4eSPvUCmBdp51NMGzM1z0AVkTRW+yKOlF5aAYOTwXa4GXsCtl38Ei8j3
	 wFW9+ffp3AB3yOcQS9ocqvPAV4GYbc60tT9NcRdOUMMN2RtsUZ42rkfagkt8KlGC5+
	 HbfkTkb5v//qOCVcaVxlIq9fVyLmYQXrRmrSlZmvIhJZ4qe2XDpU0L37bfA84pa982
	 +UcuMDqK5tkutB4+rvXiRFnPslE70Ct+NTSvq8Xtyj/SmkK4VL7ZOozVSpJ81lPnMu
	 9dXofpZUhxVEQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QKrL30jx2z1F1g;
	Mon, 15 May 2023 16:18:51 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QKrKy0bMhz1Dkd
 for <lttng-dev@lists.lttng.org>; Mon, 15 May 2023 16:18:46 -0400 (EDT)
Received: from laura.hitronhub.home (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QKrKM69n0z12q1;
 Mon, 15 May 2023 16:18:15 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Mon, 15 May 2023 16:17:13 -0400
Message-Id: <20230515201718.9809-7-odion@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515201718.9809-1-odion@efficios.com>
References: <20230515201718.9809-1-odion@efficios.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 06/11] urcu/uatomic: Add CMM memory model
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
Cc: Olivier Dion <odion@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Introducing the URCU memory model with the following new primitives:

  - uatomic_load(addr, memory_order)

  - uatomic_store(addr, value, memory_order)
  - uatomic_and_mo(addr, mask, memory_order)
  - uatomic_or_mo(addr, mask, memory_order)
  - uatomic_add_mo(addr, value, memory_order)
  - uatomic_sub_mo(addr, value, memory_order)
  - uatomic_inc_mo(addr, memory_order)
  - uatomic_dec_mo(addr, memory_order)

  - uatomic_add_return_mo(addr, value, memory_order)
  - uatomic_sub_return_mo(addr, value, memory_order)

  - uatomic_cmpxchg_mo(addr, old, new,
                       memory_order_success,
                       memory_order_failure)

  - uatomic_cmpxchg(addr, new, memory_order)

The URCU memory model reflects the C11 memory model. The memory order
can be selected through the enum rcu_memorder.

If configured with atomic builtins, the correspondence between the URCU
memory model and the C11 memory model is a one to one. However, if not
configured with atomic builtins, the following stipulate the memory
model.

For load operations with uatomic_load(), the memory orders
CMM_RELAXED, CMM_CONSUME, CMM_ACQUIRE and CMM_SEQ_CST are allowed. A
barrier is maybe inserted before and after the load from memory
depending on the memory order:

  - CMM_RELAXED: No barrier
  - CMM_CONSUME: Memory barrier after read
  - CMM_ACQUIRE: Memory barrier after read
  - CMM_SEQ_CST: Memory barriers before and after read

For store operations with uatomic_store(), the memory orders
CMM_RELAXED, CMM_RELEASE, CMM_SEQ_CST are allowed. A barrier is maybe
inserted before and after the load from memory depending on the memory
order:

  - CMM_RELAXED: No barrier
  - CMM_RELEASE: Memory barrier before operation
  - CMM_SEQ_CST: Memory barriers before and after operation

For store operations with uatomic_and_mo(), uatomic_or_mo(),
uatomic_add_mo(), uatomic_sub_mo(), uatomic_inc_mo(), uatomic_dec_mo(),
uatomic_add_return_mo() and uatomic_sub_return_mo(), all memory orders
are allowed. A barrier is maybe inserted before and after the store to
memory depending on the memory order:

  - CMM_RELAXED: No barrier
  - CMM_ACQUIRE: Memory barrier after operation
  - CMM_CONSUME: Memory barrier after operation
  - CMM_RELEASE: Memory barrier before operation
  - CMM_ACQ_REL: Memory barriers before and after operation
  - CMM_SEQ_CST: Memory barriers before and after operation

For the compare exchange operation uatomic_cmpxchg_mo(), the success
memory order can be anything while the failure memory order cannot be
CMM_RELEASE nor CMM_ACQ_REL and cannot be stronger than the success
memory order.

For the exchange operation uatomic_xchg_mo(), any memory order is valid.

Change-Id: I213ba19c84e82a63083f00143a3142ffbdab1d52
Co-authored-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Olivier Dion <odion@efficios.com>
---
 include/urcu/static/pointer.h           |  40 +++-----
 include/urcu/uatomic.h                  |  20 ++++
 include/urcu/uatomic/builtins-generic.h |  81 +++++++++++----
 include/urcu/uatomic/builtins-x86.h     |  79 +++++++++++----
 include/urcu/uatomic/generic.h          | 128 ++++++++++++++++++++++++
 src/urcu-pointer.c                      |   9 +-
 6 files changed, 283 insertions(+), 74 deletions(-)

diff --git a/include/urcu/static/pointer.h b/include/urcu/static/pointer.h
index 9e46a57..9da8657 100644
--- a/include/urcu/static/pointer.h
+++ b/include/urcu/static/pointer.h
@@ -96,23 +96,8 @@ extern "C" {
  * -Wincompatible-pointer-types errors.  Using the statement expression
  * makes it an rvalue and gets rid of the const-ness.
  */
-#ifdef __URCU_DEREFERENCE_USE_ATOMIC_CONSUME
-# define _rcu_dereference(p) __extension__ ({						\
-				__typeof__(__extension__ ({				\
-					__typeof__(p) __attribute__((unused)) _________p0 = { 0 }; \
-					_________p0;					\
-				})) _________p1;					\
-				__atomic_load(&(p), &_________p1, __ATOMIC_CONSUME);	\
-				(_________p1);						\
-			})
-#else
-# define _rcu_dereference(p) __extension__ ({						\
-				__typeof__(p) _________p1 = CMM_LOAD_SHARED(p);		\
-				cmm_smp_read_barrier_depends();				\
-				(_________p1);						\
-			})
-#endif
-
+# define _rcu_dereference(p)			\
+	uatomic_load(&(p), CMM_CONSUME)
 /**
  * _rcu_cmpxchg_pointer - same as rcu_assign_pointer, but tests if the pointer
  * is as expected by "old". If succeeds, returns the previous pointer to the
@@ -131,8 +116,9 @@ extern "C" {
 	({								\
 		__typeof__(*p) _________pold = (old);			\
 		__typeof__(*p) _________pnew = (_new);			\
-		uatomic_cmpxchg(p, _________pold, _________pnew);	\
-	})
+		uatomic_cmpxchg_mo(p, _________pold, _________pnew,	\
+				   CMM_SEQ_CST, CMM_SEQ_CST);		\
+	});
 
 /**
  * _rcu_xchg_pointer - same as rcu_assign_pointer, but returns the previous
@@ -149,17 +135,17 @@ extern "C" {
 	__extension__					\
 	({						\
 		__typeof__(*p) _________pv = (v);	\
-		uatomic_xchg(p, _________pv);		\
+		uatomic_xchg_mo(p, _________pv,		\
+				CMM_SEQ_CST);		\
 	})
 
 
-#define _rcu_set_pointer(p, v)				\
-	do {						\
-		__typeof__(*p) _________pv = (v);	\
-		if (!__builtin_constant_p(v) || 	\
-		    ((v) != NULL))			\
-			cmm_wmb();				\
-		uatomic_set(p, _________pv);		\
+#define _rcu_set_pointer(p, v)						\
+	do {								\
+		__typeof__(*p) _________pv = (v);			\
+		uatomic_store(p, _________pv,				\
+			__builtin_constant_p(v) && (v) == NULL ?	\
+			CMM_RELAXED : CMM_RELEASE);			\
 	} while (0)
 
 /**
diff --git a/include/urcu/uatomic.h b/include/urcu/uatomic.h
index 6b57c5f..6c0d38f 100644
--- a/include/urcu/uatomic.h
+++ b/include/urcu/uatomic.h
@@ -24,6 +24,26 @@
 #include <urcu/arch.h>
 #include <urcu/config.h>
 
+#ifdef CONFIG_RCU_USE_ATOMIC_BUILTINS
+enum cmm_memorder {
+	CMM_RELAXED = __ATOMIC_RELAXED,
+	CMM_CONSUME = __ATOMIC_CONSUME,
+	CMM_ACQUIRE = __ATOMIC_ACQUIRE,
+	CMM_RELEASE = __ATOMIC_RELEASE,
+	CMM_ACQ_REL = __ATOMIC_ACQ_REL,
+	CMM_SEQ_CST = __ATOMIC_SEQ_CST,
+};
+#else
+enum cmm_memorder {
+	CMM_RELAXED,
+	CMM_CONSUME,
+	CMM_ACQUIRE,
+	CMM_RELEASE,
+	CMM_ACQ_REL,
+	CMM_SEQ_CST,
+};
+#endif
+
 #if defined(CONFIG_RCU_USE_ATOMIC_BUILTINS)
 #include <urcu/uatomic/builtins.h>
 #elif defined(URCU_ARCH_X86)
diff --git a/include/urcu/uatomic/builtins-generic.h b/include/urcu/uatomic/builtins-generic.h
index 8e6a9b5..597bd61 100644
--- a/include/urcu/uatomic/builtins-generic.h
+++ b/include/urcu/uatomic/builtins-generic.h
@@ -23,46 +23,85 @@
 
 #include <urcu/system.h>
 
-#define uatomic_set(addr, v) __atomic_store_n(addr, v, __ATOMIC_RELAXED)
+#define uatomic_store(addr, v, mo)		\
+	__atomic_store_n(addr, v, mo)
 
-#define uatomic_read(addr) __atomic_load_n(addr, __ATOMIC_RELAXED)
+#define uatomic_set(addr, v)			\
+	uatomic_store(addr, v, CMM_RELAXED)
 
-#define uatomic_cmpxchg(addr, old, new)					\
+#define uatomic_load(addr, mo)			\
+	__atomic_load_n(addr, mo)
+
+#define uatomic_read(addr)			\
+	uatomic_load(addr, CMM_RELAXED)
+
+
+#define uatomic_cmpxchg_mo(addr, old, new, mos, mof)			\
 	__extension__							\
 	({								\
 		__typeof__(*(addr)) _old = (__typeof__(*(addr)))old;	\
 		__atomic_compare_exchange_n(addr, &_old, new, 0,	\
-					    __ATOMIC_SEQ_CST,		\
-					    __ATOMIC_SEQ_CST);		\
+					    mos,			\
+					    mof);			\
 		_old;							\
 	})
 
-#define uatomic_xchg(addr, v)				\
-	__atomic_exchange_n(addr, v, __ATOMIC_SEQ_CST)
+#define uatomic_cmpxchg(addr, old, new)					\
+	uatomic_cmpxchg_mo(addr, old, new, CMM_SEQ_CST, CMM_SEQ_CST)
+
+#define uatomic_xchg_mo(addr, v, mo)		\
+	__atomic_exchange_n(addr, v, mo)
+
+#define uatomic_xchg(addr, v)			\
+	uatomic_xchg_mo(addr, v, CMM_SEQ_CST)
+
+#define uatomic_add_return_mo(addr, v, mo)	\
+	__atomic_add_fetch(addr, v, mo)
 
 #define uatomic_add_return(addr, v)			\
-	__atomic_add_fetch(addr, v, __ATOMIC_SEQ_CST)
+	uatomic_add_return_mo(addr, v, CMM_SEQ_CST)
+
+#define uatomic_sub_return_mo(addr, v, mo)	\
+	__atomic_sub_fetch(addr, v, mo)
 
 #define uatomic_sub_return(addr, v)			\
-	__atomic_sub_fetch(addr, v, __ATOMIC_SEQ_CST)
+	uatomic_sub_return_mo(addr, v, CMM_SEQ_CST)
 
-#define uatomic_and(addr, mask)					\
-	(void)__atomic_and_fetch(addr, mask, __ATOMIC_RELAXED)
+#define uatomic_and_mo(addr, mask, mo)			\
+	(void ) __atomic_and_fetch(addr, mask, mo)
 
-#define uatomic_or(addr, mask)					\
-	(void)__atomic_or_fetch(addr, mask, __ATOMIC_RELAXED)
+#define uatomic_and(addr, mask)				\
+	(void) uatomic_and_mo(addr, mask, CMM_RELAXED)
 
-#define uatomic_add(addr, v)					\
-	(void)__atomic_add_fetch(addr, v, __ATOMIC_RELAXED)
+#define uatomic_or_mo(addr, mask, mo)			\
+	(void) __atomic_or_fetch(addr, mask, mo)
 
-#define uatomic_sub(addr, v)					\
-	(void)__atomic_sub_fetch(addr, v, __ATOMIC_RELAXED)
+#define uatomic_or(addr, mask)				\
+	(void) uatomic_or_mo(addr, mask, CMM_RELAXED)
 
-#define uatomic_inc(addr)					\
-	(void)__atomic_add_fetch(addr, 1, __ATOMIC_RELAXED)
+#define uatomic_add_mo(addr, v, mo)		\
+	(void) __atomic_add_fetch(addr, v, mo)
 
-#define uatomic_dec(addr)					\
-	(void)__atomic_sub_fetch(addr, 1, __ATOMIC_RELAXED)
+#define uatomic_add(addr, v)				\
+	(void) uatomic_add_mo(addr, v, CMM_RELAXED)
+
+#define uatomic_sub_mo(addr, v, mo)		\
+	(void) __atomic_sub_fetch(addr, v, mo)
+
+#define uatomic_sub(addr, v)				\
+	(void) uatomic_sub_mo(addr, v, CMM_RELAXED)
+
+#define uatomic_inc_mo(addr, mo)		\
+	(void) __atomic_add_fetch(addr, 1, mo)
+
+#define uatomic_inc(addr)				\
+	(void) uatomic_inc_mo(addr, CMM_RELAXED)
+
+#define uatomic_dec_mo(addr, mo)		\
+	(void) __atomic_sub_fetch(addr, 1, mo)
+
+#define uatomic_dec(addr)				\
+	(void) uatomic_dec_mo(addr, CMM_RELAXED)
 
 #define cmm_smp_mb__before_uatomic_and() cmm_smp_mb()
 #define cmm_smp_mb__after_uatomic_and()  cmm_smp_mb()
diff --git a/include/urcu/uatomic/builtins-x86.h b/include/urcu/uatomic/builtins-x86.h
index a70f922..c7f3bed 100644
--- a/include/urcu/uatomic/builtins-x86.h
+++ b/include/urcu/uatomic/builtins-x86.h
@@ -23,46 +23,85 @@
 
 #include <urcu/system.h>
 
-#define uatomic_set(addr, v) __atomic_store_n(addr, v, __ATOMIC_RELAXED)
+#define uatomic_store(addr, v, mo)		\
+	__atomic_store_n(addr, v, mo)
 
-#define uatomic_read(addr) __atomic_load_n(addr, __ATOMIC_RELAXED)
+#define uatomic_set(addr, v)			\
+	uatomic_store(addr, v, CMM_RELAXED)
 
-#define uatomic_cmpxchg(addr, old, new)					\
+#define uatomic_load(addr, mo)			\
+	__atomic_load_n(addr, mo)
+
+#define uatomic_read(addr)			\
+	uatomic_load(addr, CMM_RELAXED)
+
+#define uatomic_cmpxchg_mo(addr, old, new, mos, mof)			\
 	__extension__							\
 	({								\
 		__typeof__(*(addr)) _old = (__typeof__(*(addr)))old;	\
 		__atomic_compare_exchange_n(addr, &_old, new, 0,	\
-					    __ATOMIC_SEQ_CST,		\
-					    __ATOMIC_SEQ_CST);		\
+					    mos,			\
+					    mof);			\
 		_old;							\
 	})
 
+#define uatomic_cmpxchg(addr, old, new)					\
+	uatomic_cmpxchg_mo(addr, old, new, CMM_SEQ_CST, CMM_SEQ_CST)
+
+
+#define uatomic_xchg_mo(addr, v, mo)		\
+	__atomic_exchange_n(addr, v, mo)
+
 #define uatomic_xchg(addr, v)				\
-	__atomic_exchange_n(addr, v, __ATOMIC_SEQ_CST)
+	__atomic_exchange_n(addr, v, CMM_SEQ_CST)
+
+#define uatomic_add_return_mo(addr, v, mo)	\
+	__atomic_add_fetch(addr, v, mo)
 
 #define uatomic_add_return(addr, v)			\
-	__atomic_add_fetch(addr, v, __ATOMIC_SEQ_CST)
+	uatomic_add_return_mo(addr, v, CMM_SEQ_CST)
+
+#define uatomic_sub_return_mo(addr, v, mo)	\
+	__atomic_sub_fetch(addr, v, mo)
 
 #define uatomic_sub_return(addr, v)			\
-	__atomic_sub_fetch(addr, v, __ATOMIC_SEQ_CST)
+	uatomic_sub_return_mo(addr, v, CMM_SEQ_CST)
 
-#define uatomic_and(addr, mask)					\
-	(void)__atomic_and_fetch(addr, mask, __ATOMIC_SEQ_CST)
+#define uatomic_and_mo(addr, mask, mo)			\
+	(void) __atomic_and_fetch(addr, mask, mo)
 
-#define uatomic_or(addr, mask)					\
-	(void)__atomic_or_fetch(addr, mask, __ATOMIC_SEQ_CST)
+#define uatomic_and(addr, mask)				\
+	(void) uatomic_and_mo(addr, mask, CMM_SEQ_CST)
 
-#define uatomic_add(addr, v)					\
-	(void)__atomic_add_fetch(addr, v, __ATOMIC_SEQ_CST)
+#define uatomic_or_mo(addr, mask, mo)			\
+	(void) __atomic_or_fetch(addr, mask, mo)
 
-#define uatomic_sub(addr, v)					\
-	(void)__atomic_sub_fetch(addr, v, __ATOMIC_SEQ_CST)
+#define uatomic_or(addr, mask)				\
+	(void) uatomic_or_mo(addr, mask, CMM_SEQ_CST)
 
-#define uatomic_inc(addr)					\
-	(void)__atomic_add_fetch(addr, 1, __ATOMIC_SEQ_CST)
+#define uatomic_add_mo(addr, v, mo)		\
+	(void) __atomic_add_fetch(addr, v, mo)
 
-#define uatomic_dec(addr)					\
-	(void)__atomic_sub_fetch(addr, 1, __ATOMIC_SEQ_CST)
+#define uatomic_add(addr, v)				\
+	(void) uatomic_add_mo(addr, v, CMM_SEQ_CST)
+
+#define uatomic_sub_mo(addr, v, mo)		\
+	(void) __atomic_sub_fetch(addr, v, mo)
+
+#define uatomic_sub(addr, v)				\
+	(void) uatomic_sub_mo(addr, v, CMM_SEQ_CST)
+
+#define uatomic_inc_mo(addr, mo)		\
+	(void) __atomic_add_fetch(addr, 1, mo)
+
+#define uatomic_inc(addr)				\
+	(void) uatomic_inc_mo(addr, CMM_SEQ_CST)
+
+#define uatomic_dec_mo(addr, mo)		\
+	(void) __atomic_sub_fetch(addr, 1, mo)
+
+#define uatomic_dec(addr)				\
+	(void) uatomic_dec_mo(addr, CMM_SEQ_CST)
 
 #define cmm_smp_mb__before_uatomic_and() do { } while (0)
 #define cmm_smp_mb__after_uatomic_and()  do { } while (0)
diff --git a/include/urcu/uatomic/generic.h b/include/urcu/uatomic/generic.h
index e31a19b..4ec93c5 100644
--- a/include/urcu/uatomic/generic.h
+++ b/include/urcu/uatomic/generic.h
@@ -33,10 +33,138 @@ extern "C" {
 #define uatomic_set(addr, v)	((void) CMM_STORE_SHARED(*(addr), (v)))
 #endif
 
+extern void abort(void);
+
+#define uatomic_store_op(op, addr, v, mo)	\
+	({					\
+		switch (mo) {			\
+		case CMM_ACQUIRE:		\
+		case CMM_CONSUME:		\
+		case CMM_RELAXED:		\
+			break;			\
+		case CMM_RELEASE:		\
+		case CMM_ACQ_REL:		\
+		case CMM_SEQ_CST:		\
+			cmm_smp_mb();		\
+			break;			\
+		default:			\
+			abort();		\
+		}				\
+						\
+		op(addr, v);			\
+						\
+		switch (mo) {			\
+		case CMM_ACQUIRE:		\
+		case CMM_ACQ_REL:		\
+		case CMM_CONSUME:		\
+		case CMM_SEQ_CST:		\
+			cmm_smp_mb();		\
+			break;			\
+		case CMM_RELAXED:		\
+		case CMM_RELEASE:		\
+			break;			\
+		default:			\
+			abort();		\
+		}				\
+	})
+
+#define uatomic_store(addr, v, mo)			\
+	({						\
+		switch (mo) {				\
+		case CMM_RELAXED:			\
+			break;				\
+		case CMM_RELEASE:			\
+		case CMM_SEQ_CST:			\
+			cmm_smp_mb();			\
+			break;				\
+		default:				\
+			abort();			\
+		}					\
+							\
+		uatomic_set(addr, v);			\
+							\
+		switch (mo) {				\
+		case CMM_RELAXED:			\
+		case CMM_RELEASE:			\
+			break;				\
+		case CMM_SEQ_CST:			\
+			cmm_smp_mb();			\
+			break;				\
+		default:				\
+			abort();			\
+		}					\
+	})
+
+#define uatomic_and_mo(addr, v, mo)			\
+	uatomic_store_op(uatomic_and, addr, v, mo)
+
+#define uatomic_or_mo(addr, v, mo)			\
+	uatomic_store_op(uatomic_or, addr, v, mo)
+
+#define uatomic_add_mo(addr, v, mo)			\
+	uatomic_store_op(uatomic_add, addr, v, mo)
+
+#define uatomic_sub_mo(addr, v, mo)			\
+	uatomic_store_op(uatomic_sub, addr, v, mo)
+
+#define uatomic_inc_mo(addr, mo)			\
+	uatomic_store_op(uatomic_add, addr, 1, mo)
+
+#define uatomic_dec_mo(addr, mo)			\
+	uatomic_store_op(uatomic_add, addr, -1, mo)
+
+#define uatomic_cmpxchg_mo(addr, old, new, mos, mof)	\
+	uatomic_cmpxchg(addr, old, new)
+
+#define uatomic_xchg_mo(addr, v, mo)		\
+	uatomic_xchg(addr, v)
+
+#define uatomic_xchg_mo(addr, v, mo)		\
+	uatomic_xchg(addr, v)
+
+#define uatomic_add_return_mo(addr, v, mo)	\
+	uatomic_add_return(addr, v)
+
+#define uatomic_sub_return_mo(addr, v, mo)	\
+	uatomic_sub_return(addr, v)
+
+
 #ifndef uatomic_read
 #define uatomic_read(addr)	CMM_LOAD_SHARED(*(addr))
 #endif
 
+#define uatomic_load(addr, mo)						\
+	__extension__							\
+	({								\
+		switch (mo) {						\
+		case CMM_ACQUIRE:					\
+		case CMM_CONSUME:					\
+		case CMM_RELAXED:					\
+			break;						\
+		case CMM_SEQ_CST:					\
+			cmm_smp_mb();					\
+			break;						\
+		default:						\
+			abort();					\
+		}							\
+									\
+		__typeof__(*(addr)) _rcu_value = uatomic_read(addr);	\
+									\
+		switch (mo) {						\
+		case CMM_RELAXED:					\
+			break;						\
+		case CMM_CONSUME:					\
+		case CMM_ACQUIRE:					\
+		case CMM_SEQ_CST:					\
+			cmm_smp_mb();					\
+			break;						\
+		default:						\
+			abort();					\
+		}							\
+									\
+		_rcu_value;						\
+	})
+
 #if !defined __OPTIMIZE__  || defined UATOMIC_NO_LINK_ERROR
 #ifdef ILLEGAL_INSTR
 static inline __attribute__((always_inline))
diff --git a/src/urcu-pointer.c b/src/urcu-pointer.c
index d0854ac..cea8aeb 100644
--- a/src/urcu-pointer.c
+++ b/src/urcu-pointer.c
@@ -39,19 +39,16 @@ void *rcu_dereference_sym(void *p)
 
 void *rcu_set_pointer_sym(void **p, void *v)
 {
-	cmm_wmb();
-	uatomic_set(p, v);
+	uatomic_store(p, v, CMM_RELEASE);
 	return v;
 }
 
 void *rcu_xchg_pointer_sym(void **p, void *v)
 {
-	cmm_wmb();
-	return uatomic_xchg(p, v);
+	return uatomic_xchg_mo(p, v, CMM_SEQ_CST);
 }
 
 void *rcu_cmpxchg_pointer_sym(void **p, void *old, void *_new)
 {
-	cmm_wmb();
-	return uatomic_cmpxchg(p, old, _new);
+	return uatomic_cmpxchg_mo(p, old, _new, CMM_SEQ_CST, CMM_SEQ_CST);
 }
-- 
2.39.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
