Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0009C77B75
	for <lttng-dev@archiver.kernel.org>; Mon, 15 May 2023 20:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684181927;
	bh=hJaChclnyMLswub58mPUJsD2TBHm5QwuL29bvrqnxfA=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=RKcA6+QYLGCcXyzyBIFxdKUAh6ZsSvUyMZJEIYsdMfIMnTXxYjOBOZRvaLkw4NRqx
	 FUWQvLhnJXtL4NR0akYQYtAD7RTYVTSOth1+QI/BAmivnHFvKpRU88vDzg0B2O6q5a
	 qIjk3DD4Zsy7hEa6wazQLUk9qbfeycrwHaMK8lMFfSa8YTqITAIfNUAOYeH9Lo+bV3
	 WzqUfC+IcnClbAweaGLJFUQFSHHmL35JnyKGI+D0pOK3XZFVF2HvrHkPdrp1B6R995
	 yqp/OOavBxE6PXwzabm0KZyY789jUY/gepMQfHJga0/zTYwodibAadPM4xiNftnWiU
	 iSdgmOZvtE3Ow==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QKrKy6nW7z1F1d;
	Mon, 15 May 2023 16:18:46 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QKrKx0xm1z1Dx6
 for <lttng-dev@lists.lttng.org>; Mon, 15 May 2023 16:18:45 -0400 (EDT)
Received: from laura.hitronhub.home (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QKrKL63dHz12nT;
 Mon, 15 May 2023 16:18:14 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Mon, 15 May 2023 16:17:07 -0400
Message-Id: <20230515201718.9809-1-odion@efficios.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 00/11] Add support for TSAN to liburcu
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
Cc: Olivier Dion <odion@efficios.com>, Dmitry Vyukov <dvyukov@google.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

This patch set adds support for TSAN in liburcu.

* Here are the major changes

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

* CMM annotation example

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

```
enum urcu_state reader_state(unsigned long *ctr, cmm_annotate_t *acquire_group)
{
	unsigned long v;

	v = uatomic_load(ctr, CMM_RELAXED);
	cmm_annotate_group_mem_acquire(acquire_group, ctr);
	// ...
}

void wait_for_readers(..., cmm_annotate_group *acquire_group)
{
	// ...
	switch (reader_state(..., acquire_group)) {
		// ...
	}
	// ...
}

void synchronize_rcu()
{
	cmm_annotate_define(acquire_group);
	// ...
	wait_for_readers(..., &acquire_group);
	// ...
	cmm_annotate_group_mb_acquire(&acquire_group);
	cmm_smp_mb();
}
```

* Known limitation

  The only known limitation is with the urcu-signal flavor.  Indeed, TSAN
  hijacks calls to sigaction(2) and installs its own signal handler that will
  deliver the signals to the urcu handler at synchronization points.  This is
  known to deadlock the urcu-signal flavor in at least one case.  See commit log
  of `urcu/annotate: Add CMM annotation' for a minimal reproducer outside of
  liburcu.

  Therefore, we have the intention of deprecating the urcu-signal flavor in the
  future, starting by disabling it by default.

Olivier Dion (11):
  configure: Add --disable-atomic-builtins option
  urcu/uatomic: Use atomic builtins if configured
  urcu/compiler: Use atomic builtins if configured
  urcu/arch/generic: Use atomic builtins if configured
  urcu/system: Use atomic builtins if configured
  urcu/uatomic: Add CMM memory model
  urcu-wait: Fix wait state load/store
  tests: Use uatomic for accessing global states
  benchmark: Use uatomic for accessing global states
  tests/unit/test_build: Quiet unused return value
  urcu/annotate: Add CMM annotation

 README.md                               |  11 ++
 configure.ac                            |  26 ++++
 include/Makefile.am                     |   4 +
 include/urcu/annotate.h                 | 174 ++++++++++++++++++++++++
 include/urcu/arch/generic.h             |  37 +++++
 include/urcu/compiler.h                 |  20 ++-
 include/urcu/static/pointer.h           |  40 ++----
 include/urcu/static/urcu-bp.h           |  12 +-
 include/urcu/static/urcu-common.h       |   8 +-
 include/urcu/static/urcu-mb.h           |  11 +-
 include/urcu/static/urcu-memb.h         |  26 +++-
 include/urcu/static/urcu-qsbr.h         |  29 ++--
 include/urcu/system.h                   |  21 +++
 include/urcu/uatomic.h                  |  25 +++-
 include/urcu/uatomic/builtins-generic.h | 124 +++++++++++++++++
 include/urcu/uatomic/builtins-x86.h     | 124 +++++++++++++++++
 include/urcu/uatomic/builtins.h         |  83 +++++++++++
 include/urcu/uatomic/generic.h          | 128 +++++++++++++++++
 src/rculfhash.c                         |  92 ++++++++-----
 src/urcu-bp.c                           |  17 ++-
 src/urcu-pointer.c                      |   9 +-
 src/urcu-qsbr.c                         |  31 +++--
 src/urcu-wait.h                         |  15 +-
 src/urcu.c                              |  24 ++--
 tests/benchmark/Makefile.am             |  91 +++++++------
 tests/benchmark/common-states.c         |   1 +
 tests/benchmark/common-states.h         |  51 +++++++
 tests/benchmark/test_mutex.c            |  32 +----
 tests/benchmark/test_perthreadlock.c    |  32 +----
 tests/benchmark/test_rwlock.c           |  32 +----
 tests/benchmark/test_urcu.c             |  33 +----
 tests/benchmark/test_urcu_assign.c      |  33 +----
 tests/benchmark/test_urcu_bp.c          |  33 +----
 tests/benchmark/test_urcu_defer.c       |  33 +----
 tests/benchmark/test_urcu_gc.c          |  34 +----
 tests/benchmark/test_urcu_hash.c        |   6 +-
 tests/benchmark/test_urcu_hash.h        |  15 --
 tests/benchmark/test_urcu_hash_rw.c     |  10 +-
 tests/benchmark/test_urcu_hash_unique.c |  10 +-
 tests/benchmark/test_urcu_lfq.c         |  20 +--
 tests/benchmark/test_urcu_lfs.c         |  20 +--
 tests/benchmark/test_urcu_lfs_rcu.c     |  20 +--
 tests/benchmark/test_urcu_qsbr.c        |  33 +----
 tests/benchmark/test_urcu_qsbr_gc.c     |  34 +----
 tests/benchmark/test_urcu_wfcq.c        |  22 ++-
 tests/benchmark/test_urcu_wfq.c         |  20 +--
 tests/benchmark/test_urcu_wfs.c         |  22 ++-
 tests/common/api.h                      |  12 +-
 tests/regression/rcutorture.h           | 102 ++++++++++----
 tests/unit/test_build.c                 |   8 +-
 50 files changed, 1227 insertions(+), 623 deletions(-)
 create mode 100644 include/urcu/annotate.h
 create mode 100644 include/urcu/uatomic/builtins-generic.h
 create mode 100644 include/urcu/uatomic/builtins-x86.h
 create mode 100644 include/urcu/uatomic/builtins.h
 create mode 100644 tests/benchmark/common-states.c
 create mode 100644 tests/benchmark/common-states.h

-- 
2.39.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
