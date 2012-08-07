From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: urcu rfc: privatize urcu/futex.h
Date: Tue, 7 Aug 2012 10:06:16 -0400
Message-ID: <20120807140616.GA29280__32837.6782163561$1344348407$gmane$org@Krystal>
References: <5020DBFF.3020702@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SykQL-0005jH-QS
	for lttng-dev@lists.lttng.org; Tue, 07 Aug 2012 10:06:17 -0400
Content-Disposition: inline
In-Reply-To: <5020DBFF.3020702@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

Hi Lai,

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> futex.h is in urcu/, it means it can be used by users out of the library.
> 
> But
> 
> If the user's system has futex, he should use #include <linux/futex.h>.
> If the user's system don't have futex, it is not good that if the user
> use this compat_futex.
> 
> Because the compat_futex_async()'s behavior is different from the
> futex in linux.  If the caller don't change the value of @uaddr, the
> futex(FUTEX_WAKE) in linux can also wake a thread, but
> compat_futex_async() don't.  (I guess no one use this behavior, but if
> there are someone, we give them a wrong thing)

Hrm, passing a NULL uaddr parameter is really not the targeted use-case.
We could probably just document that uaddr should not be NULL when using
compat_futex ?

> So I suggest urcu/futex.h becomes a private thing for urcu.

Well, if possible, I'd like to keep it public, since it allows us to do
wait/wakeup schemes across many OSes.

Do you have a use-case where you want to wake up all threads, even those
which are not waiting on a specific uaddr ?

> 
> Alternative implements(only describe the alternative FUTEX_WAIT):
> 1) Like compat_futex_noasync(), but use mutex_lock_signal_save() +
> pthread_cond_wait().
> Problem: the thread can't handle the signal when waiting on
> pthread_cond_wait().  (* mutex_lock_signal_save() is implemented in
> compat_arch_x86.c)

The culprit of the problem here is not really on the "wait" side, but
rather on the "wake" side. The wakeup, in urcu, is issued by
rcu_read_unlock() to wake up synchronize_rcu() (if there is one
waiting).

However, we don't want to disable signals and take a mutex each time we
do a rcu_read_unlock, because it would tremendously impact performance.
AFAIK, pthread_cond_signal() is not signal-safe, so it could not be used
without lock+signal save.

Another site where the wait/wakeup is used: in call_rcu, waking up the
worker threads. We also don't want to take a mutex there, to ensure that
call_rcu is wait-free as far as userspace code is concerned.

> 
> 2) Like the linux kernel, use use mutex_lock_signal_save() + hash table
> 	+ sleeping (use poll() + restore signal mask)
> Problem: very complex

Would this solution require a lock+signal save on the wake up site too ?

> 
> Thanks,
> Lai.
> 
> (today I found a old patchset in my private tree, tried to rebase it
> and suddenly notice this urcu/futex.h but the patchset has nothing
> related with urcu/futex.h).

I look forward to see that work!

Thanks!

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
