Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C69C77B75
	for <lttng-dev@archiver.kernel.org>; Mon, 15 May 2023 20:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684181904;
	bh=otcn1ZY6IAyHX6L5YRxoiLTGmYuHhdK92AY6A7cfAdU=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=PXjJ6WF3g7UH57X6mFXKpB/47QpdQ46TII74D3rfThOEoiSzZOxpTjkfoOlaLlcmO
	 CIPi7Fw5mBNwoBRIys2JAE4YOjbRF3xjDV2g0Relg1hHD1kqpcMae659b2M36CQK47
	 9d7sfZwFl6gfhJl0ZHs2J93nuynPToYZoZyP2acBs0YIp+qBdb/+xczosZZI/iJZTI
	 stQw+N8vzl+2ftQU6pF5sYKwZLokw+2ejRt595NhEHQQyfmbALFv1QMoBYrnjleNwD
	 MMtzwOuhBoxru1cs+f2ybWj30eAdvTdfZM3p3H95pL0jYvW4pxt+nYblq9xR6JrK9O
	 d1y6EQ1jqK9Kw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QKrKX02LSz1DYT;
	Mon, 15 May 2023 16:18:24 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QKrKM42Lgz1Dh6
 for <lttng-dev@lists.lttng.org>; Mon, 15 May 2023 16:18:15 -0400 (EDT)
Received: from laura.hitronhub.home (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QKrKM1TcJz12Q1;
 Mon, 15 May 2023 16:18:15 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Mon, 15 May 2023 16:17:09 -0400
Message-Id: <20230515201718.9809-3-odion@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515201718.9809-1-odion@efficios.com>
References: <20230515201718.9809-1-odion@efficios.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 02/11] urcu/uatomic: Use atomic builtins if
 configured
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

Implement uatomic in term of atomic builtins if configured to do so.

Change-Id: I5814494c62ee507fd5d381c3ba4ccd0a80c4f4e3
Co-authored-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Olivier Dion <odion@efficios.com>
---
 include/Makefile.am                     |  3 +
 include/urcu/uatomic.h                  |  5 +-
 include/urcu/uatomic/builtins-generic.h | 85 +++++++++++++++++++++++++
 include/urcu/uatomic/builtins-x86.h     | 85 +++++++++++++++++++++++++
 include/urcu/uatomic/builtins.h         | 83 ++++++++++++++++++++++++
 5 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 include/urcu/uatomic/builtins-generic.h
 create mode 100644 include/urcu/uatomic/builtins-x86.h
 create mode 100644 include/urcu/uatomic/builtins.h

diff --git a/include/Makefile.am b/include/Makefile.am
index ba1fe60..fac941f 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -63,6 +63,9 @@ nobase_include_HEADERS = \
 	urcu/uatomic/alpha.h \
 	urcu/uatomic_arch.h \
 	urcu/uatomic/arm.h \
+	urcu/uatomic/builtins.h \
+	urcu/uatomic/builtins-generic.h \
+	urcu/uatomic/builtins-x86.h \
 	urcu/uatomic/gcc.h \
 	urcu/uatomic/generic.h \
 	urcu/uatomic.h \
diff --git a/include/urcu/uatomic.h b/include/urcu/uatomic.h
index 2fb5fd4..6b57c5f 100644
--- a/include/urcu/uatomic.h
+++ b/include/urcu/uatomic.h
@@ -22,8 +22,11 @@
 #define _URCU_UATOMIC_H
 
 #include <urcu/arch.h>
+#include <urcu/config.h>
 
-#if defined(URCU_ARCH_X86)
+#if defined(CONFIG_RCU_USE_ATOMIC_BUILTINS)
+#include <urcu/uatomic/builtins.h>
+#elif defined(URCU_ARCH_X86)
 #include <urcu/uatomic/x86.h>
 #elif defined(URCU_ARCH_PPC)
 #include <urcu/uatomic/ppc.h>
diff --git a/include/urcu/uatomic/builtins-generic.h b/include/urcu/uatomic/builtins-generic.h
new file mode 100644
index 0000000..8e6a9b5
--- /dev/null
+++ b/include/urcu/uatomic/builtins-generic.h
@@ -0,0 +1,85 @@
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
+#define uatomic_set(addr, v) __atomic_store_n(addr, v, __ATOMIC_RELAXED)
+
+#define uatomic_read(addr) __atomic_load_n(addr, __ATOMIC_RELAXED)
+
+#define uatomic_cmpxchg(addr, old, new)					\
+	__extension__							\
+	({								\
+		__typeof__(*(addr)) _old = (__typeof__(*(addr)))old;	\
+		__atomic_compare_exchange_n(addr, &_old, new, 0,	\
+					    __ATOMIC_SEQ_CST,		\
+					    __ATOMIC_SEQ_CST);		\
+		_old;							\
+	})
+
+#define uatomic_xchg(addr, v)				\
+	__atomic_exchange_n(addr, v, __ATOMIC_SEQ_CST)
+
+#define uatomic_add_return(addr, v)			\
+	__atomic_add_fetch(addr, v, __ATOMIC_SEQ_CST)
+
+#define uatomic_sub_return(addr, v)			\
+	__atomic_sub_fetch(addr, v, __ATOMIC_SEQ_CST)
+
+#define uatomic_and(addr, mask)					\
+	(void)__atomic_and_fetch(addr, mask, __ATOMIC_RELAXED)
+
+#define uatomic_or(addr, mask)					\
+	(void)__atomic_or_fetch(addr, mask, __ATOMIC_RELAXED)
+
+#define uatomic_add(addr, v)					\
+	(void)__atomic_add_fetch(addr, v, __ATOMIC_RELAXED)
+
+#define uatomic_sub(addr, v)					\
+	(void)__atomic_sub_fetch(addr, v, __ATOMIC_RELAXED)
+
+#define uatomic_inc(addr)					\
+	(void)__atomic_add_fetch(addr, 1, __ATOMIC_RELAXED)
+
+#define uatomic_dec(addr)					\
+	(void)__atomic_sub_fetch(addr, 1, __ATOMIC_RELAXED)
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
+#endif /* _URCU_UATOMIC_BUILTINS_GENERIC_H */
diff --git a/include/urcu/uatomic/builtins-x86.h b/include/urcu/uatomic/builtins-x86.h
new file mode 100644
index 0000000..a70f922
--- /dev/null
+++ b/include/urcu/uatomic/builtins-x86.h
@@ -0,0 +1,85 @@
+/*
+ * urcu/uatomic/builtins-x86.h
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
+#ifndef _URCU_UATOMIC_BUILTINS_X86_H
+#define _URCU_UATOMIC_BUILTINS_X86_H
+
+#include <urcu/system.h>
+
+#define uatomic_set(addr, v) __atomic_store_n(addr, v, __ATOMIC_RELAXED)
+
+#define uatomic_read(addr) __atomic_load_n(addr, __ATOMIC_RELAXED)
+
+#define uatomic_cmpxchg(addr, old, new)					\
+	__extension__							\
+	({								\
+		__typeof__(*(addr)) _old = (__typeof__(*(addr)))old;	\
+		__atomic_compare_exchange_n(addr, &_old, new, 0,	\
+					    __ATOMIC_SEQ_CST,		\
+					    __ATOMIC_SEQ_CST);		\
+		_old;							\
+	})
+
+#define uatomic_xchg(addr, v)				\
+	__atomic_exchange_n(addr, v, __ATOMIC_SEQ_CST)
+
+#define uatomic_add_return(addr, v)			\
+	__atomic_add_fetch(addr, v, __ATOMIC_SEQ_CST)
+
+#define uatomic_sub_return(addr, v)			\
+	__atomic_sub_fetch(addr, v, __ATOMIC_SEQ_CST)
+
+#define uatomic_and(addr, mask)					\
+	(void)__atomic_and_fetch(addr, mask, __ATOMIC_SEQ_CST)
+
+#define uatomic_or(addr, mask)					\
+	(void)__atomic_or_fetch(addr, mask, __ATOMIC_SEQ_CST)
+
+#define uatomic_add(addr, v)					\
+	(void)__atomic_add_fetch(addr, v, __ATOMIC_SEQ_CST)
+
+#define uatomic_sub(addr, v)					\
+	(void)__atomic_sub_fetch(addr, v, __ATOMIC_SEQ_CST)
+
+#define uatomic_inc(addr)					\
+	(void)__atomic_add_fetch(addr, 1, __ATOMIC_SEQ_CST)
+
+#define uatomic_dec(addr)					\
+	(void)__atomic_sub_fetch(addr, 1, __ATOMIC_SEQ_CST)
+
+#define cmm_smp_mb__before_uatomic_and() do { } while (0)
+#define cmm_smp_mb__after_uatomic_and()  do { } while (0)
+
+#define cmm_smp_mb__before_uatomic_or() do { } while (0)
+#define cmm_smp_mb__after_uatomic_or()  do { } while (0)
+
+#define cmm_smp_mb__before_uatomic_add() do { } while (0)
+#define cmm_smp_mb__after_uatomic_add()  do { } while (0)
+
+#define cmm_smp_mb__before_uatomic_sub() do { } while (0)
+#define cmm_smp_mb__after_uatomic_sub()  do { } while (0)
+
+#define cmm_smp_mb__before_uatomic_inc() do { } while (0)
+#define cmm_smp_mb__after_uatomic_inc()  do { } while (0)
+
+#define cmm_smp_mb__before_uatomic_dec() do { } while (0)
+#define cmm_smp_mb__after_uatomic_dec()  do { } while (0)
+
+#endif /* _URCU_UATOMIC_BUILTINS_X86_H */
diff --git a/include/urcu/uatomic/builtins.h b/include/urcu/uatomic/builtins.h
new file mode 100644
index 0000000..164201b
--- /dev/null
+++ b/include/urcu/uatomic/builtins.h
@@ -0,0 +1,83 @@
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
+#  if !__has_builtin(__atomic_store_n)
+#    error "Toolchain does not support __atomic_store_n."
+#  endif
+#  if !__has_builtin(__atomic_load_n)
+#    error "Toolchain does not support __atomic_load_n."
+#  endif
+#  if !__has_builtin(__atomic_exchange_n)
+#    error "Toolchain does not support __atomic_exchange_n."
+#  endif
+#  if !__has_builtin(__atomic_compare_exchange_n)
+#    error "Toolchain does not support __atomic_compare_exchange_n."
+#  endif
+#  if !__has_builtin(__atomic_add_fetch)
+#    error "Toolchain does not support __atomic_add_fetch."
+#  endif
+#  if !__has_builtin(__atomic_sub_fetch)
+#    error "Toolchain does not support __atomic_sub_fetch."
+#  endif
+#  if !__has_builtin(__atomic_or_fetch)
+#    error "Toolchain does not support __atomic_or_fetch."
+#  endif
+#  if !__has_builtin(__atomic_thread_fence)
+#    error "Toolchain does not support __atomic_thread_fence."
+#  endif
+#  if !__has_builtin(__atomic_signal_fence)
+#    error "Toolchain does not support __atomic_signal_fence."
+#  endif
+#elif defined(__GNUC__)
+#  define GCC_VERSION (__GNUC__       * 10000 + \
+		       __GNUC_MINOR__ * 100   + \
+		       __GNUC_PATCHLEVEL__)
+#  if  GCC_VERSION < 40700
+#    error "GCC version is too old. Version must be 4.7 or greater"
+#  endif
+#  undef  GCC_VERSION
+#else
+#  error "Toolchain is not supported."
+#endif
+
+#if defined(__GNUC__)
+#  define UATOMIC_HAS_ATOMIC_BYTE  __GCC_ATOMIC_CHAR_LOCK_FREE
+#  define UATOMIC_HAS_ATOMIC_SHORT __GCC_ATOMIC_SHORT_LOCK_FREE
+#elif defined(__clang__)
+#  define UATOMIC_HAS_ATOMIC_BYTE  __CLANG_ATOMIC_CHAR_LOCK_FREE
+#  define UATOMIC_HAS_ATOMIC_SHORT __CLANG_ATOMIC_SHORT_LOCK_FREE
+#else
+/* #  define UATOMIC_HAS_ATOMIC_BYTE  */
+/* #  define UATOMIC_HAS_ATOMIC_SHORT */
+#endif
+
+#if defined(URCU_ARCH_X86)
+#  include <urcu/uatomic/builtins-x86.h>
+#else
+#  include <urcu/uatomic/builtins-generic.h>
+#endif
+
+#endif	/* _URCU_UATOMIC_BUILTINS_H */
-- 
2.39.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
