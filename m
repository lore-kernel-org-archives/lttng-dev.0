From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: urcu rfc: privatize urcu/futex.h
Date: Tue, 07 Aug 2012 17:12:31 +0800
Message-ID: <5020DBFF.3020702__5311.42393961108$1344332632$gmane$org@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1SygJs-0003Vw-2H
	for lttng-dev@lists.lttng.org; Tue, 07 Aug 2012 05:43:20 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

futex.h is in urcu/, it means it can be used by users out of the library.

But

If the user's system has futex, he should use #include <linux/futex.h>.
If the user's system don't have futex, it is not good that if the user use this compat_futex.

Because the compat_futex_async()'s behavior is different from the futex in linux.
If the caller don't change the value of @uaddr, the futex(FUTEX_WAKE) in linux can
also wake a thread, but compat_futex_async() don't.
(I guess no one use this behavior, but if there are someone, we give them a wrong thing)

So I suggest urcu/futex.h becomes a private thing for urcu.

Alternative implements(only describe the alternative FUTEX_WAIT):
1) Like compat_futex_noasync(), but use mutex_lock_signal_save() + pthread_cond_wait().
Problem: the thread can't handle the signal when waiting on pthread_cond_wait().
(* mutex_lock_signal_save() is implemented in compat_arch_x86.c)

2) Like the linux kernel, use use mutex_lock_signal_save() + hash table
	+ sleeping (use poll() + restore signal mask)
Problem: very complex

Thanks,
Lai.

(today I found a old patchset in my private tree, tried to rebase it and suddenly notice
this urcu/futex.h but the patchset has nothing related with urcu/futex.h).
