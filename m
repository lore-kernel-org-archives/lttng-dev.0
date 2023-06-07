Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA30C7EE23
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Jun 2023 18:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1686164093;
	bh=2WO7lhyoyRgdx7aMp5ReiHFKKBmSmTcSqK1yQNdCGIs=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Uhr06veH1gUMf6i8k53F1kVJiJdYZEHHy1JXuy+INDADByUw/o4qrjmpKKKjK5OS6
	 l9sYj/gGXmYuRDV3m4dl4yTEhEsBfi2Prihe+ZDT7V041244imSYhdOdE1XYh4H2sX
	 FgMg+JtAzKnNeMZZHUTqJ1+TKhtyXdWpvlK4f247ftRhlQmihP6NXh8HwPlXHqcjuw
	 Lr8d6a1CQCX+dNMTYRDsr6JIx+6YeORmsO57Fcpj0pdOJYvifjR5klVz615RzmixjG
	 EEjk3rH6/AueMmzQEQzOiqH89OrMPc/IwqTCZ+AKjfRDAKbx2qNcbbM58ynVQpe9YB
	 DhHxwQRMRMqGw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QbxNY0H5Xz1Xkp;
	Wed,  7 Jun 2023 14:54:53 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QbxNT4X3Rz1XgC
 for <lttng-dev@lists.lttng.org>; Wed,  7 Jun 2023 14:54:49 -0400 (EDT)
Received: from laura.hitronhub.home (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QbxNS3C1vz16hX;
 Wed,  7 Jun 2023 14:54:48 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Wed,  7 Jun 2023 14:53:47 -0400
Message-Id: <20230607185359.8125-1-odion@efficios.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515201718.9809-1-odion@efficios.com>
References: <20230515201718.9809-1-odion@efficios.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH v2 00/12] Add support for TSAN to liburcu
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

This patch set adds support for TSAN in liburcu.
    
* Change since v1

** Adding CMM_SEQ_CST_FENCE memory order to the CMM memory model

   The C11 memory model is incompatible with the memory model used by liburcu,
   since the semantic of the C11 memory model is based on a happen-before
   (acquire/release) relationship of memory accesses, while liburcu is based on
   memory barriers and relaxed memory accesses.

   To circumvent this, a new memory order called CMM_SEQ_CST_FENCE is
   introduced.  It implies a CMM_SEQ_CST while emitting a thread fence after the
   operation.  Operations that were documented as emitting memory barriers
   before and after the operation are implemented now in term of this new memory
   order to keep compatibility.

   However, this model is redundant in some cases and the memory orders were
   changed internally in liburcu to simply use the CMM_SEQ_CST.

** Adding cmm_emit_legacy_smp_mb() to queue/stack APIs

   The queue/stack APIs document implicit memory barriers before or after
   operation.  These are now optionally emitted only if
   CONFIG_RCU_EMIT_LEGACY_MB is defined in urcu/config.h or manually defined by
   the user before including liburcu.  That way, users can opt-in even if the
   system headers were configured without this feature.

   However, users can not opt-out of that feature if configured by the system.

* v1

** Here are the major changes

  - Usage of compiler atomic builtins is added to the uatomic API.  This is
    required for TSAN to understand atomic memory accesses.  If the compiler
    supports such builtins, they are used by default.  User can opt-out and use
    the legacy implementation of the uatomic API by using the
    `--disable-atomic-builtins' configuration option.

  - The CMM memory model is introduced but yet formalized. It tries to be as
    close as possible to the C11 memory model while offering primitives such as
    cmm_smp_wmb(), cmm_smp_rmb() and cmm_mb() that can't be expressed in it.
    For example, cmm_mb() can be used for ordering memory accesses to MMIO
    devices, which is out of the scope of the C11 memory model.

  - The CMM annotation layer is a new public API that is highly experimental and
    not guaranteed to be stable at this stage.  It serves the dual purpose of
    verifying local (intra-thread) relaxed atomic accesses ordering with a
    memory barrier and global (inter-thread) relaxed atomic accesses with a
    shared state.  The second purpose is necessary for TSAN to understand memory
    accesses ordering since it does not fully support thread fence yet.

** CMM annotation example

  Consider the following pseudo-code of writer side in synchronize_rcu().  An
  acquire group is defined on the stack of the writer.  Annotations are made
  onto the group to ensure ordering of relaxed memory accesses in reader_state()
  before the memory barrier at the end of synchronize_rcu().  It also helps TSAN
  to understand that the relaxed accesses in reader_state() act like acquire
  accesses because of the memory barrier in synchronize_rcu().

  In other words, the purpose of this annotation is to convert a group of
  load-acquire memory operations into load-relaxed memory operations followed by
  a single memory barrier.  This highly benefits weakly ordered architectures by
  having a constant number of memory barriers instead of being linearly
  proportional to the number of loads.  This does not benefit TSO
  architectures.  


Olivier Dion (12):
  configure: Add --disable-atomic-builtins option
  urcu/compiler: Use atomic builtins if configured
  urcu/arch/generic: Use atomic builtins if configured
  urcu/system: Use atomic builtins if configured
  urcu/uatomic: Add CMM memory model
  urcu-wait: Fix wait state load/store
  tests: Use uatomic for accessing global states
  benchmark: Use uatomic for accessing global states
  tests/unit/test_build: Quiet unused return value
  urcu/annotate: Add CMM annotation
  Add cmm_emit_legacy_smp_mb()
  tests: Add tests for checking race conditions

 README.md                               |  11 ++
 configure.ac                            |  39 ++++
 doc/uatomic-api.md                      |   3 +-
 include/Makefile.am                     |   3 +
 include/urcu/annotate.h                 | 174 ++++++++++++++++++
 include/urcu/arch.h                     |   6 +
 include/urcu/arch/generic.h             |  37 ++++
 include/urcu/compiler.h                 |  22 ++-
 include/urcu/config.h.in                |   6 +
 include/urcu/static/lfstack.h           |  25 ++-
 include/urcu/static/pointer.h           |  40 ++--
 include/urcu/static/rculfqueue.h        |  14 +-
 include/urcu/static/rculfstack.h        |   8 +-
 include/urcu/static/urcu-bp.h           |  12 +-
 include/urcu/static/urcu-common.h       |   8 +-
 include/urcu/static/urcu-mb.h           |  11 +-
 include/urcu/static/urcu-memb.h         |  26 ++-
 include/urcu/static/urcu-qsbr.h         |  29 ++-
 include/urcu/static/wfcqueue.h          |  68 +++----
 include/urcu/static/wfqueue.h           |   9 +-
 include/urcu/static/wfstack.h           |  24 ++-
 include/urcu/system.h                   |  21 +++
 include/urcu/uatomic.h                  |  63 ++++++-
 include/urcu/uatomic/builtins-generic.h | 170 +++++++++++++++++
 include/urcu/uatomic/builtins.h         |  79 ++++++++
 include/urcu/uatomic/generic.h          | 234 ++++++++++++++++++++++++
 src/rculfhash.c                         |  92 ++++++----
 src/urcu-bp.c                           |  17 +-
 src/urcu-pointer.c                      |   9 +-
 src/urcu-qsbr.c                         |  31 +++-
 src/urcu-wait.h                         |  15 +-
 src/urcu.c                              |  24 ++-
 tests/benchmark/Makefile.am             |  91 ++++-----
 tests/benchmark/common-states.c         |   1 +
 tests/benchmark/common-states.h         |  51 ++++++
 tests/benchmark/test_mutex.c            |  32 +---
 tests/benchmark/test_perthreadlock.c    |  32 +---
 tests/benchmark/test_rwlock.c           |  32 +---
 tests/benchmark/test_urcu.c             |  33 +---
 tests/benchmark/test_urcu_assign.c      |  33 +---
 tests/benchmark/test_urcu_bp.c          |  33 +---
 tests/benchmark/test_urcu_defer.c       |  33 +---
 tests/benchmark/test_urcu_gc.c          |  34 +---
 tests/benchmark/test_urcu_hash.c        |   6 +-
 tests/benchmark/test_urcu_hash.h        |  15 --
 tests/benchmark/test_urcu_hash_rw.c     |  10 +-
 tests/benchmark/test_urcu_hash_unique.c |  10 +-
 tests/benchmark/test_urcu_lfq.c         |  20 +-
 tests/benchmark/test_urcu_lfs.c         |  20 +-
 tests/benchmark/test_urcu_lfs_rcu.c     |  20 +-
 tests/benchmark/test_urcu_qsbr.c        |  33 +---
 tests/benchmark/test_urcu_qsbr_gc.c     |  34 +---
 tests/benchmark/test_urcu_wfcq.c        |  22 +--
 tests/benchmark/test_urcu_wfq.c         |  20 +-
 tests/benchmark/test_urcu_wfs.c         |  22 +--
 tests/common/api.h                      |  12 +-
 tests/regression/rcutorture.h           | 106 +++++++----
 tests/unit/test_build.c                 |   8 +-
 tests/unit/test_lfstack.c               |  90 +++++++++
 tests/unit/test_wfcqueue.c              | 119 ++++++++++++
 tests/unit/test_wfqueue.c               |  91 +++++++++
 tests/unit/test_wfstack.c               |  90 +++++++++
 62 files changed, 1799 insertions(+), 684 deletions(-)
 create mode 100644 include/urcu/annotate.h
 create mode 100644 include/urcu/uatomic/builtins-generic.h
 create mode 100644 include/urcu/uatomic/builtins.h
 create mode 100644 tests/benchmark/common-states.c
 create mode 100644 tests/benchmark/common-states.h
 create mode 100644 tests/unit/test_lfstack.c
 create mode 100644 tests/unit/test_wfcqueue.c
 create mode 100644 tests/unit/test_wfqueue.c
 create mode 100644 tests/unit/test_wfstack.c

-- 
2.40.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
