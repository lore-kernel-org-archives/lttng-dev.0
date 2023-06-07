Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA109C7EE2E
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Jun 2023 18:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1686164099;
	bh=UM+9jhvxaMAGH5OdD4Z6kUQsrEhC/tYj394m26Cb/t0=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=QPypoHC6xoE5LMXc1gaqNrsu5qnAk1wTfY6sOi2nHqPWg0Sf9iP+edEhl3MTR0Q39
	 9Lv1lBBV0gPDAxvw81LuaVBxWBoxtwkCnI+4lewA491S6o9JBzxsEfMenedPYcE5ki
	 y86yIRzpqdymTyuP+6Cc2bsOj4OvXZkXB/z21/q92woZ7rjIynsNFPd/L3FJgK3f6o
	 Kwz8fnMmJygH3KY6q1eZS3xo8rh019epM4E1po21NVfBz49713CkJytmD7/oaJR64A
	 zSt57zrfDcnWM7PoktOkQGqIGWVfs7YJjoczOwivUYR7hxwYyzrz3cON6f83XglTCN
	 DscVUyl2cAfZQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QbxNg6XSBz1XgG;
	Wed,  7 Jun 2023 14:54:59 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QbxNX3T7dz1Xkl
 for <lttng-dev@lists.lttng.org>; Wed,  7 Jun 2023 14:54:52 -0400 (EDT)
Received: from laura.hitronhub.home (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QbxNX1qFgz16t4;
 Wed,  7 Jun 2023 14:54:52 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Wed,  7 Jun 2023 14:53:52 -0400
Message-Id: <20230607185359.8125-6-odion@efficios.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515201718.9809-1-odion@efficios.com>
References: <20230515201718.9809-1-odion@efficios.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH v2 05/12] urcu/uatomic: Add CMM memory model
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

Introducing the CMM memory model with the following new primitives:

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

  - uatomic_xchg_mo(addr, value, memory_order)

  - uatomic_cmpxchg_mo(addr, old, new,
                       memory_order_success,
                       memory_order_failure)

The CMM memory model reflects the C11 memory model with an additional
CMM_SEQ_CST_FENCE memory order. The memory order can be selected through
the enum cmm_memorder.

* With Atomic Builtins

If configured with atomic builtins, the correspondence between the CMM
memory model and the C11 memory model is a one to one at the exception
of the CMM_SEQ_CST_FENCE memory order which implies the memory order
CMM_SEQ_CST and a thread fence after the operation.

* Without Atomic Builtins

However, if not configured with atomic builtins, the following stipulate
the memory model.

For load operations with uatomic_load(), the memory orders CMM_RELAXED,
CMM_CONSUME, CMM_ACQUIRE, CMM_SEQ_CST and CMM_SEQ_CST_FENCE are
allowed. A barrier may be inserted before and after the load from memory
depending on the memory order:

  - CMM_RELAXED: No barrier
  - CMM_CONSUME: Memory barrier after read
  - CMM_ACQUIRE: Memory barrier after read
  - CMM_SEQ_CST: Memory barriers before and after read
  - CMM_SEQ_CST_FENCE: Memory barriers before and after read

For store operations with uatomic_store(), the memory orders
CMM_RELAXED, CMM_RELEASE, CMM_SEQ_CST and CMM_SEQ_CST_FENCE are
allowed. A barrier may be inserted before and after the store to memory
depending on the memory order:

  - CMM_RELAXED: No barrier
  - CMM_RELEASE: Memory barrier before operation
  - CMM_SEQ_CST: Memory barriers before and after operation
  - CMM_SEQ_CST_FENCE: Memory barriers before and after operation

For load/store operations with uatomic_and_mo(), uatomic_or_mo(),
uatomic_add_mo(), uatomic_sub_mo(), uatomic_inc_mo(), uatomic_dec_mo(),
uatomic_add_return_mo() and uatomic_sub_return_mo(), all memory orders
are allowed. A barrier may be inserted before and after the operation
depending on the memory order:

  - CMM_RELAXED: No barrier
  - CMM_ACQUIRE: Memory barrier after operation
  - CMM_CONSUME: Memory barrier after operation
  - CMM_RELEASE: Memory barrier before operation
  - CMM_ACQ_REL: Memory barriers before and after operation
  - CMM_SEQ_CST: Memory barriers before and after operation
  - CMM_SEQ_CST_FENCE: Memory barriers before and after operation

For the exchange operation uatomic_xchg_mo(), any memory order is
valid. A barrier may be inserted before and after the exchange to memory
depending on the memory order:

  - CMM_RELAXED: No barrier
  - CMM_ACQUIRE: Memory barrier after operation
  - CMM_CONSUME: Memory barrier after operation
  - CMM_RELEASE: Memory barrier before operation
  - CMM_ACQ_REL: Memory barriers before and after operation
  - CMM_SEQ_CST: Memory barriers before and after operation
  - CMM_SEQ_CST_FENCE: Memory barriers before and after operation

For the compare exchange operation uatomic_cmpxchg_mo(), the success
memory order can be anything while the failure memory order cannot be
CMM_RELEASE nor CMM_ACQ_REL and cannot be stronger than the success
memory order. A barrier may be inserted before and after the store to
memory depending on the memory orders:

 Success memory order:

  - CMM_RELAXED: No barrier
  - CMM_ACQUIRE: Memory barrier after operation
  - CMM_CONSUME: Memory barrier after operation
  - CMM_RELEASE: Memory barrier before operation
  - CMM_ACQ_REL: Memory barriers before and after operation
  - CMM_SEQ_CST: Memory barriers before and after operation
  - CMM_SEQ_CST_FENCE: Memory barriers before and after operation

  Barriers after the operations are only emitted if the compare exchange
  succeed.

 Failure memory order:
  - CMM_RELAXED: No barrier
  - CMM_ACQUIRE: Memory barrier after operation
  - CMM_CONSUME: Memory barrier after operation
  - CMM_SEQ_CST: Memory barriers before and after operation
  - CMM_SEQ_CST_FENCE: Memory barriers before and after operation

  Barriers after the operations are only emitted if the compare exchange
  failed.  Barriers before the operation are never emitted by this
  memory order.

Change-Id: I213ba19c84e82a63083f00143a3142ffbdab1d52
Co-authored-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Olivier Dion <odion@efficios.com>
---
 doc/uatomic-api.md                      |   3 +-
 include/Makefile.am                     |   2 +
 include/urcu/static/pointer.h           |  40 ++--
 include/urcu/uatomic.h                  |  63 ++++++-
 include/urcu/uatomic/builtins-generic.h | 170 +++++++++++++++++
 include/urcu/uatomic/builtins.h         |  79 ++++++++
 include/urcu/uatomic/generic.h          | 234 ++++++++++++++++++++++++
 src/urcu-pointer.c                      |   9 +-
 8 files changed, 565 insertions(+), 35 deletions(-)
 create mode 100644 include/urcu/uatomic/builtins-generic.h
 create mode 100644 include/urcu/uatomic/builtins.h

diff --git a/doc/uatomic-api.md b/doc/uatomic-api.md
index 0962399..7341ee8 100644
--- a/doc/uatomic-api.md
+++ b/doc/uatomic-api.md
@@ -52,7 +52,8 @@ An atomic read-modify-write operation that performs this
 sequence of operations atomically: check if `addr` contains `old`.
 If true, then replace the content of `addr` by `new`. Return the
 value previously contained by `addr`. This function implies a full
-memory barrier before and after the atomic operation.
+memory barrier before and after the atomic operation. The second memory
+barrier is only emitted if the operation succeeded.
 
 
 ```c
diff --git a/include/Makefile.am b/include/Makefile.am
index ba1fe60..b20e56d 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -63,6 +63,8 @@ nobase_include_HEADERS = \
 	urcu/uatomic/alpha.h \
 	urcu/uatomic_arch.h \
 	urcu/uatomic/arm.h \
+	urcu/uatomic/builtins.h \
+	urcu/uatomic/builtins-generic.h \
 	urcu/uatomic/gcc.h \
 	urcu/uatomic/generic.h \
 	urcu/uatomic.h \
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
index 2fb5fd4..be857e1 100644
--- a/include/urcu/uatomic.h
+++ b/include/urcu/uatomic.h
@@ -21,9 +21,70 @@
 #ifndef _URCU_UATOMIC_H
 #define _URCU_UATOMIC_H
 
+#include <assert.h>
+
 #include <urcu/arch.h>
+#include <urcu/config.h>
 
-#if defined(URCU_ARCH_X86)
+enum cmm_memorder {
+	CMM_RELAXED = 0,
+	CMM_CONSUME = 1,
+	CMM_ACQUIRE = 2,
+	CMM_RELEASE = 3,
+	CMM_ACQ_REL = 4,
+	CMM_SEQ_CST = 5,
+	CMM_SEQ_CST_FENCE = 6,
+};
+
+#ifdef CONFIG_RCU_USE_ATOMIC_BUILTINS
+
+/*
+ * Make sure that CMM_SEQ_CST_FENCE is not equivalent to other memory orders.
+ */
+# ifdef static_assert
+static_assert(CMM_RELAXED == __ATOMIC_RELAXED, "");
+static_assert(CMM_CONSUME == __ATOMIC_CONSUME, "");
+static_assert(CMM_ACQUIRE == __ATOMIC_ACQUIRE, "");
+static_assert(CMM_RELEASE == __ATOMIC_RELEASE, "");
+static_assert(CMM_ACQ_REL == __ATOMIC_ACQ_REL, "");
+static_assert(CMM_SEQ_CST == __ATOMIC_SEQ_CST, "");
+# endif
+
+/*
+ * This is not part of the public API. It it used internally to implement the
+ * CMM_SEQ_CST_FENCE memory order.
+ *
+ * NOTE: Using switch here instead of if statement to avoid -Wduplicated-cond
+ * warning when memory order is conditionally determined.
+ */
+static inline void cmm_seq_cst_fence_after_atomic(enum cmm_memorder mo)
+{
+	switch (mo) {
+	case CMM_SEQ_CST_FENCE:
+		cmm_smp_mb();
+		break;
+	default:
+		break;
+	}
+}
+
+#endif
+
+/*
+ * This is not part of the public API. It is used internally to convert from the
+ * CMM memory model to the C11 memory model.
+ */
+static inline int cmm_to_c11(int mo)
+{
+	if (mo == CMM_SEQ_CST_FENCE) {
+		return CMM_SEQ_CST;
+	}
+	return mo;
+}
+
+#if defined(CONFIG_RCU_USE_ATOMIC_BUILTINS)
+#include <urcu/uatomic/builtins.h>
+#elif defined(URCU_ARCH_X86)
 #include <urcu/uatomic/x86.h>
 #elif defined(URCU_ARCH_PPC)
 #include <urcu/uatomic/ppc.h>
diff --git a/include/urcu/uatomic/builtins-generic.h b/include/urcu/uatomic/builtins-generic.h
new file mode 100644
index 0000000..673e888
--- /dev/null
+++ b/include/urcu/uatomic/builtins-generic.h
@@ -0,0 +1,170 @@
+/*
+ * urcu/uatomic/builtins-generic.h
+ *
+ * Copyright (c) 2023 Olivier Dion <odion@efficios.com>
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
+#ifndef _URCU_UATOMIC_BUILTINS_GENERIC_H
+#define _URCU_UATOMIC_BUILTINS_GENERIC_H
+
+#include <urcu/system.h>
+
+#define uatomic_store(addr, v, mo)				\
+	__extension__						\
+	({							\
+		__atomic_store_n(addr, v, cmm_to_c11(mo));	\
+		cmm_seq_cst_fence_after_atomic(mo);		\
+	})
+
+#define uatomic_set(addr, v)			\
+	uatomic_store(addr, v, CMM_RELAXED)
+
+#define uatomic_load(addr, mo)						\
+	__extension__							\
+	({								\
+		__typeof__(*(addr)) _value = __atomic_load_n(addr,	\
+							cmm_to_c11(mo)); \
+		cmm_seq_cst_fence_after_atomic(mo);			\
+									\
+		_value;							\
+	})
+
+#define uatomic_read(addr)			\
+	uatomic_load(addr, CMM_RELAXED)
+
+#define uatomic_cmpxchg_mo(addr, old, new, mos, mof)			\
+	__extension__							\
+	({								\
+		__typeof__(*(addr)) _old = (__typeof__(*(addr)))old;	\
+									\
+		if (__atomic_compare_exchange_n(addr, &_old, new, 0,	\
+							cmm_to_c11(mos), \
+							cmm_to_c11(mof))) { \
+			cmm_seq_cst_fence_after_atomic(mos);		\
+		} else {						\
+			cmm_seq_cst_fence_after_atomic(mof);		\
+		}							\
+		_old;							\
+	})
+
+#define uatomic_cmpxchg(addr, old, new)					\
+	uatomic_cmpxchg_mo(addr, old, new, CMM_SEQ_CST_FENCE, CMM_RELAXED)
+
+#define uatomic_xchg_mo(addr, v, mo)					\
+	__extension__							\
+	({								\
+		__typeof__((*addr)) _old = __atomic_exchange_n(addr, v,	\
+							cmm_to_c11(mo)); \
+		cmm_seq_cst_fence_after_atomic(mo);			\
+		_old;							\
+	})
+
+#define uatomic_xchg(addr, v)						\
+	uatomic_xchg_mo(addr, v, CMM_SEQ_CST_FENCE)
+
+#define uatomic_add_return_mo(addr, v, mo)				\
+	__extension__							\
+	({								\
+		__typeof__(*(addr)) _old = __atomic_add_fetch(addr, v,	\
+							cmm_to_c11(mo)); \
+		cmm_seq_cst_fence_after_atomic(mo);			\
+		_old;							\
+	})
+
+#define uatomic_add_return(addr, v)					\
+	uatomic_add_return_mo(addr, v, CMM_SEQ_CST_FENCE)
+
+#define uatomic_sub_return_mo(addr, v, mo)				\
+	__extension__							\
+	({								\
+		__typeof__(*(addr)) _old = __atomic_sub_fetch(addr, v,	\
+							cmm_to_c11(mo)); \
+		cmm_seq_cst_fence_after_atomic(mo);			\
+		_old;							\
+	})
+
+#define uatomic_sub_return(addr, v)					\
+	uatomic_sub_return_mo(addr, v, CMM_SEQ_CST_FENCE)
+
+#define uatomic_and_mo(addr, mask, mo)					\
+	__extension__							\
+	({								\
+		__typeof__(*(addr)) _old = __atomic_and_fetch(addr, mask, \
+							cmm_to_c11(mo)); \
+		cmm_seq_cst_fence_after_atomic(mo);			\
+		_old;							\
+	})
+
+#define uatomic_and(addr, mask)				\
+	(void) uatomic_and_mo(addr, mask, CMM_SEQ_CST)
+
+#define uatomic_or_mo(addr, mask, mo)					\
+	__extension__							\
+	({								\
+		__typeof__(*(addr)) _old = __atomic_or_fetch(addr, mask, \
+							cmm_to_c11(mo)); \
+		cmm_seq_cst_fence_after_atomic(mo);			\
+		_old;							\
+	})
+
+
+#define uatomic_or(addr, mask)				\
+	(void) uatomic_or_mo(addr, mask, CMM_RELAXED)
+
+#define uatomic_add_mo(addr, v, mo)			\
+	(void) uatomic_add_return_mo(addr, v, mo)
+
+#define uatomic_add(addr, v)				\
+	(void) uatomic_add_mo(addr, v, CMM_RELAXED)
+
+#define uatomic_sub_mo(addr, v, mo)			\
+	(void) uatomic_sub_return_mo(addr, v, mo)
+
+#define uatomic_sub(addr, v)				\
+	(void) uatomic_sub_mo(addr, v, CMM_RELAXED)
+
+#define uatomic_inc_mo(addr, mo)		\
+	(void) uatomic_add_mo(addr, 1, mo)
+
+#define uatomic_inc(addr)				\
+	(void) uatomic_inc_mo(addr, CMM_RELAXED)
+
+#define uatomic_dec_mo(addr, mo)		\
+	(void) uatomic_sub_mo(addr, 1, mo)
+
+#define uatomic_dec(addr)				\
+	(void) uatomic_dec_mo(addr, CMM_RELAXED)
+
+#define cmm_smp_mb__before_uatomic_and() cmm_smp_mb()
+#define cmm_smp_mb__after_uatomic_and()  cmm_smp_mb()
+
+#define cmm_smp_mb__before_uatomic_or() cmm_smp_mb()
+#define cmm_smp_mb__after_uatomic_or()  cmm_smp_mb()
+
+#define cmm_smp_mb__before_uatomic_add() cmm_smp_mb()
+#define cmm_smp_mb__after_uatomic_add()  cmm_smp_mb()
+
+#define cmm_smp_mb__before_uatomic_sub() cmm_smp_mb()
+#define cmm_smp_mb__after_uatomic_sub()  cmm_smp_mb()
+
+#define cmm_smp_mb__before_uatomic_inc() cmm_smp_mb()
+#define cmm_smp_mb__after_uatomic_inc() cmm_smp_mb()
+
+#define cmm_smp_mb__before_uatomic_dec() cmm_smp_mb()
+#define cmm_smp_mb__after_uatomic_dec() cmm_smp_mb()
+
+#endif /* _URCU_UATOMIC_BUILTINS_X86_H */
diff --git a/include/urcu/uatomic/builtins.h b/include/urcu/uatomic/builtins.h
new file mode 100644
index 0000000..82e98f8
--- /dev/null
+++ b/include/urcu/uatomic/builtins.h
@@ -0,0 +1,79 @@
+/*
+ * urcu/uatomic/builtins.h
+ *
+ * Copyright (c) 2023 Olivier Dion <odion@efficios.com>
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
+#ifndef _URCU_UATOMIC_BUILTINS_H
+#define _URCU_UATOMIC_BUILTINS_H
+
+#include <urcu/arch.h>
+
+#if defined(__has_builtin)
+# if !__has_builtin(__atomic_store_n)
+#  error "Toolchain does not support __atomic_store_n."
+# endif
+# if !__has_builtin(__atomic_load_n)
+#  error "Toolchain does not support __atomic_load_n."
+# endif
+# if !__has_builtin(__atomic_exchange_n)
+#  error "Toolchain does not support __atomic_exchange_n."
+# endif
+# if !__has_builtin(__atomic_compare_exchange_n)
+#  error "Toolchain does not support __atomic_compare_exchange_n."
+# endif
+# if !__has_builtin(__atomic_add_fetch)
+#  error "Toolchain does not support __atomic_add_fetch."
+# endif
+# if !__has_builtin(__atomic_sub_fetch)
+#  error "Toolchain does not support __atomic_sub_fetch."
+# endif
+# if !__has_builtin(__atomic_or_fetch)
+#  error "Toolchain does not support __atomic_or_fetch."
+# endif
+# if !__has_builtin(__atomic_thread_fence)
+#  error "Toolchain does not support __atomic_thread_fence."
+# endif
+# if !__has_builtin(__atomic_signal_fence)
+#  error "Toolchain does not support __atomic_signal_fence."
+# endif
+#elif defined(__GNUC__)
+# define GCC_VERSION (__GNUC__       * 10000 + \
+		       __GNUC_MINOR__ * 100   + \
+		       __GNUC_PATCHLEVEL__)
+# if  GCC_VERSION < 40700
+#  error "GCC version is too old. Version must be 4.7 or greater"
+# endif
+# undef  GCC_VERSION
+#else
+# error "Toolchain is not supported."
+#endif
+
+#if defined(__GNUC__)
+# define UATOMIC_HAS_ATOMIC_BYTE  __GCC_ATOMIC_CHAR_LOCK_FREE
+# define UATOMIC_HAS_ATOMIC_SHORT __GCC_ATOMIC_SHORT_LOCK_FREE
+#elif defined(__clang__)
+# define UATOMIC_HAS_ATOMIC_BYTE  __CLANG_ATOMIC_CHAR_LOCK_FREE
+# define UATOMIC_HAS_ATOMIC_SHORT __CLANG_ATOMIC_SHORT_LOCK_FREE
+#else
+/* #  define UATOMIC_HAS_ATOMIC_BYTE  */
+/* #  define UATOMIC_HAS_ATOMIC_SHORT */
+#endif
+
+#include <urcu/uatomic/builtins-generic.h>
+
+#endif	/* _URCU_UATOMIC_BUILTINS_H */
diff --git a/include/urcu/uatomic/generic.h b/include/urcu/uatomic/generic.h
index e31a19b..6b9c153 100644
--- a/include/urcu/uatomic/generic.h
+++ b/include/urcu/uatomic/generic.h
@@ -33,10 +33,244 @@ extern "C" {
 #define uatomic_set(addr, v)	((void) CMM_STORE_SHARED(*(addr), (v)))
 #endif
 
+extern void abort(void);
+
+#define uatomic_load_store_return_op(op, addr, v, mo)			\
+	__extension__							\
+	({								\
+									\
+		switch (mo) {						\
+		case CMM_ACQUIRE:					\
+		case CMM_CONSUME:					\
+		case CMM_RELAXED:					\
+			break;						\
+		case CMM_RELEASE:					\
+		case CMM_ACQ_REL:					\
+		case CMM_SEQ_CST:					\
+		case CMM_SEQ_CST_FENCE:					\
+			cmm_smp_mb();					\
+			break;						\
+		default:						\
+			abort();					\
+		}							\
+									\
+		__typeof__((*addr)) _value = op(addr, v);		\
+									\
+		switch (mo) {						\
+		case CMM_CONSUME:					\
+			cmm_smp_read_barrier_depends();			\
+			break;						\
+		case CMM_ACQUIRE:					\
+		case CMM_ACQ_REL:					\
+		case CMM_SEQ_CST:					\
+		case CMM_SEQ_CST_FENCE:					\
+			cmm_smp_mb();					\
+			break;						\
+		case CMM_RELAXED:					\
+		case CMM_RELEASE:					\
+			break;						\
+		default:						\
+			abort();					\
+		}							\
+		_value;							\
+	})
+
+#define uatomic_load_store_op(op, addr, v, mo)				\
+	({								\
+		switch (mo) {						\
+		case CMM_ACQUIRE:					\
+		case CMM_CONSUME:					\
+		case CMM_RELAXED:					\
+			break;						\
+		case CMM_RELEASE:					\
+		case CMM_ACQ_REL:					\
+		case CMM_SEQ_CST:					\
+		case CMM_SEQ_CST_FENCE:					\
+			cmm_smp_mb();					\
+			break;						\
+		default:						\
+			abort();					\
+		}							\
+									\
+		op(addr, v);						\
+									\
+		switch (mo) {						\
+		case CMM_CONSUME:					\
+			cmm_smp_read_barrier_depends();			\
+			break;						\
+		case CMM_ACQUIRE:					\
+		case CMM_ACQ_REL:					\
+		case CMM_SEQ_CST:					\
+		case CMM_SEQ_CST_FENCE:					\
+			cmm_smp_mb();					\
+			break;						\
+		case CMM_RELAXED:					\
+		case CMM_RELEASE:					\
+			break;						\
+		default:						\
+			abort();					\
+		}							\
+	})
+
+#define uatomic_store(addr, v, mo)			\
+	({						\
+		switch (mo) {				\
+		case CMM_RELAXED:			\
+			break;				\
+		case CMM_RELEASE:			\
+		case CMM_SEQ_CST:			\
+		case CMM_SEQ_CST_FENCE:			\
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
+		case CMM_SEQ_CST_FENCE:			\
+			cmm_smp_mb();			\
+			break;				\
+		default:				\
+			abort();			\
+		}					\
+	})
+
+#define uatomic_and_mo(addr, v, mo)				\
+	uatomic_load_store_op(uatomic_and, addr, v, mo)
+
+#define uatomic_or_mo(addr, v, mo)				\
+	uatomic_load_store_op(uatomic_or, addr, v, mo)
+
+#define uatomic_add_mo(addr, v, mo)				\
+	uatomic_load_store_op(uatomic_add, addr, v, mo)
+
+#define uatomic_sub_mo(addr, v, mo)				\
+	uatomic_load_store_op(uatomic_sub, addr, v, mo)
+
+#define uatomic_inc_mo(addr, mo)				\
+	uatomic_load_store_op(uatomic_add, addr, 1, mo)
+
+#define uatomic_dec_mo(addr, mo)				\
+	uatomic_load_store_op(uatomic_add, addr, -1, mo)
+/*
+ * NOTE: We can not just do switch (_value == (old) ? mos : mof) otherwise the
+ * compiler emit a -Wduplicated-cond warning.
+ */
+#define uatomic_cmpxchg_mo(addr, old, new, mos, mof)			\
+	__extension__							\
+	({								\
+		switch (mos) {						\
+		case CMM_ACQUIRE:					\
+		case CMM_CONSUME:					\
+		case CMM_RELAXED:					\
+			break;						\
+		case CMM_RELEASE:					\
+		case CMM_ACQ_REL:					\
+		case CMM_SEQ_CST:					\
+		case CMM_SEQ_CST_FENCE:					\
+			cmm_smp_mb();					\
+			break;						\
+		default:						\
+			abort();					\
+		}							\
+									\
+		__typeof__(*(addr)) _value = uatomic_cmpxchg(addr, old,	\
+							new);		\
+									\
+		if (_value == (old)) {					\
+			switch (mos) {					\
+			case CMM_CONSUME:				\
+				cmm_smp_read_barrier_depends();		\
+				break;					\
+			case CMM_ACQUIRE:				\
+			case CMM_ACQ_REL:				\
+			case CMM_SEQ_CST:				\
+			case CMM_SEQ_CST_FENCE:				\
+				cmm_smp_mb();				\
+				break;					\
+			case CMM_RELAXED:				\
+			case CMM_RELEASE:				\
+				break;					\
+			default:					\
+				abort();				\
+			}						\
+		} else {						\
+			switch (mof) {					\
+			case CMM_CONSUME:				\
+				cmm_smp_read_barrier_depends();		\
+				break;					\
+			case CMM_ACQUIRE:				\
+			case CMM_ACQ_REL:				\
+			case CMM_SEQ_CST:				\
+			case CMM_SEQ_CST_FENCE:				\
+				cmm_smp_mb();				\
+				break;					\
+			case CMM_RELAXED:				\
+			case CMM_RELEASE:				\
+				break;					\
+			default:					\
+				abort();				\
+			}						\
+		}							\
+		_value;							\
+	})
+
+#define uatomic_xchg_mo(addr, v, mo)				\
+	uatomic_load_store_return_op(uatomic_xchg, addr, v, mo)
+
+#define uatomic_add_return_mo(addr, v, mo)				\
+	uatomic_load_store_return_op(uatomic_add_return, addr, v)
+
+#define uatomic_sub_return_mo(addr, v, mo)				\
+	uatomic_load_store_return_op(uatomic_sub_return, addr, v)
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
+		case CMM_SEQ_CST_FENCE:					\
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
+			cmm_smp_read_barrier_depends();			\
+			break;						\
+		case CMM_ACQUIRE:					\
+		case CMM_SEQ_CST:					\
+		case CMM_SEQ_CST_FENCE:					\
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
2.40.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
