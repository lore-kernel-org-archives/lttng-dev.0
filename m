Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DADAC05027
	for <lttng-dev@archiver.kernel.org>; Tue, 14 Feb 2023 16:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1676393133;
	bh=ZHYFrvcwpctRq5CpCId2/y7iCLzsbq2QlAhQaXJhiNw=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=ofit+ME5I4EBVpqtEFKgMdBDERSCu0ZquoqlfM07nFmtbg5mxkjp0Wm0qEmfYq+Vl
	 inXuKLqdOmfjanMOthYM2BQ5arcR4IOvHAcS74QgnW8r4A24bwPdADIOz8JS8kNhdo
	 64TwiJ1pekX8c5K5h+o5UJSBDCj9WwjVqVlhOvbC3wFqR1gkOmGejWaCbSokqW2n5e
	 conK21fgDasEPDZu7XlIN0K1nRkTwntiIPBdnxt6R8a8+BXLXCPSgiERCwpcwC4Dbb
	 AtqKyImo4mQMWC4lHTxEpGTTuMHDV1d0C0xXkfi41YtW5D1Rgr2xMIVY/IQNRLq5W9
	 U9wvmNg2LDt8Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PGRsT1nZkz1ddl;
	Tue, 14 Feb 2023 11:45:33 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4PGRsP4Pm1z1dkS
 for <lttng-dev@lists.lttng.org>; Tue, 14 Feb 2023 11:45:29 -0500 (EST)
Received: from [172.16.0.188] (192-222-180-24.qc.cable.ebox.net
 [192.222.180.24])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4PGRsN5946zlKp;
 Tue, 14 Feb 2023 11:45:28 -0500 (EST)
Message-ID: <52cf1b10-3dd0-fc20-3cb5-9cbf1f4b72bd@efficios.com>
Date: Tue, 14 Feb 2023 11:45:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [lttng-dev] [RELEASE] Userspace RCU 0.14.0, 0.13.3, 0.12.5 [EOL]
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

This is a release announcement for the Userspace RCU project.

This is a set of releases, including the new 0.14 branch with the 0.14.0 
release, and bug fix releases for the 0.13 and 0.12 branches. The 0.12.5 
release is the last of the 0.12 branch, which reaches end of life with 
the release of 0.14.

Here are the new features introduced in urcu 0.14.0:

- C99 and C++11 are now the baseline requirements, as documented in
   README.md.

- Introduce public APIs for C++,

   An important point to consider: urcu/compiler.h needs to include
   <type_traits> in C++, which prevents including urcu/compiler.h
   from extern "C" code.

- Introduce new grace period polling APIs in urcu-memb,mb,signal,qsbr,bp
   flavors:

   struct urcu_gp_poll_state start_poll_synchronize_rcu(void);
   bool poll_state_synchronize_rcu(struct urcu_gp_poll_state state);

   This allow periodically polling to check if a started grace period has
   completed, and thus check for grace period completion and some other
   condition as well.

- rculfhash: introduce cds_lfht_node_init_deleted

   Allow initializing lfht node to "removed" state to allow querying
   whether the node is published in a hash table before it is added to
   the hash table and after it has been removed from the hash table.

- Disable signals in URCU background threads

   Applications using signalfd depend on signals being blocked in all
   threads of the process, otherwise threads with unblocked signals
   can receive them and starve the signalfd.

   While some threads in URCU do block signals (e.g. workqueue
   worker for rculfhash), the call_rcu, defer_rcu, and rculfhash
   partition_resize_helper threads do not.

   Always block all signals before creating threads, and only unblock
   SIGRCU when registering a urcu-signal thread. Restore the SIGRCU
   signal to its pre-registration blocked state on unregistration.

   For rculfhash, cds_lfht_worker_init can be removed, because its only
   effect is to block all signals except SIGRCU. Blocking all signals is
   already done by the workqueue code, and unbloking SIGRCU is now done
   by the urcu signal flavor thread regisration.

- Always use '__thread' for Thread local storage except on MSVC

   Use the GCC extension '__thread' [1] for Thread local storage on all C
   and C++ compilers except MSVC.

   While C11 and C++11 respectively offer '_Thread_local' and
   'thread_local' as potentialy faster implementations, they offer no
   guarantees of compatibility when used in a library interface which
   might be used by both C and C++ client code.

- Various test framework improvements.

- Wire up membarrier system call on Alpha. The only missing architecture
   without membarrier wired up is MIPS. https://bugs.lttng.org/issues/940


Here are the fixes introduced in urcu 0.14.0, 0.13.3 and 0.12.5:

- Fix: auto-resize hash table destroy deadlock

   Fix a deadlock for auto-resize hash tables when cds_lfht_destroy
   is called with RCU read-side lock held.

- Join call_rcu worker thread in call_rcu_data_free (eliminate leaks)

- Teardown default call_rcu worker on application exit

   Teardown the default call_rcu worker thread if there are no queued
   callbacks on process exit. This prevents leaking memory.

   Here is how an application can ensure graceful teardown of this
   worker thread:

   - An application queuing call_rcu callbacks should invoke
     rcu_barrier() before it exits.
   - When chaining call_rcu callbacks, the number of calls to
     rcu_barrier() on application exit must match at least the maximum
     number of chained callbacks.
   - If an application chains callbacks endlessly, it would have to be
     modified to stop chaining callbacks when it detects an application
     exit (e.g. with a flag), and wait for quiescence with rcu_barrier()
     after setting that flag.
   - The statements above apply to a library which queues call_rcu
     callbacks, only it needs to invoke rcu_barrier in its library
     destructor.

- Allow building on MSYS2

   Update cygwin libtool config in `configure.ac` to match MSYS2 build
   environments as well. MSYS2 is also a Windows build environment that
   produces DLLs.

Feedback is welcome!

Mathieu


Project website: https://liburcu.org
Git repository: git://git.liburcu.org/urcu.git

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
