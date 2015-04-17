From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Deadlock between call_rcu thread and RCU-bp thread
 doing registration in rcu_read_lock()
Date: Fri, 17 Apr 2015 07:55:45 -0700
Message-ID: <20150417145545.GA28785__20759.385257452$1429282617$gmane$org@linux.vnet.ibm.com>
References: <551BC1E5.3020809@orc-group.com>
 <570963671.28921.1428697562974.JavaMail.zimbra@efficios.com>
 <5530D122.7060709@orc-group.com>
 <20150417141818.GM23685@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e32.co.us.ibm.com ([32.97.110.150])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <paulmck@linux.vnet.ibm.com>) id 1Yj7gR-00060Y-Rp
 for lttng-dev@lists.lttng.org; Fri, 17 Apr 2015 10:55:57 -0400
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 17 Apr 2015 08:55:50 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 8F3181FF0025
 for <lttng-dev@lists.lttng.org>; Fri, 17 Apr 2015 08:46:58 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t3HErrYK35848288
 for <lttng-dev@lists.lttng.org>; Fri, 17 Apr 2015 07:53:53 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3HEtl3p025724
 for <lttng-dev@lists.lttng.org>; Fri, 17 Apr 2015 08:55:47 -0600
Content-Disposition: inline
In-Reply-To: <20150417141818.GM23685@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Eugene Ivanov <Eugene.Ivanov@orc-group.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Fri, Apr 17, 2015 at 07:18:18AM -0700, Paul E. McKenney wrote:
> On Fri, Apr 17, 2015 at 12:23:46PM +0300, Eugene Ivanov wrote:
> > Hi Mathieu,
> > 
> > On 04/10/2015 11:26 PM, Mathieu Desnoyers wrote:
> > >----- Original Message -----
> > >>Hi,
> > >>
> > >>I use rcu-bp (0.8.6) and get deadlock between call_rcu thread and
> > >>threads willing to do rcu_read_lock():
> > >>1. Some thread is in read-side critical section.
> > >>2. call_rcu thread waits for readers in stack of rcu_bp_register(), i.e.
> > >>holds mutex.
> > >>3. Another thread enters into critical section via rcu_read_lock() and
> > >>blocks on the mutex taken by thread 2.
> > >>
> > >>Such deadlock is quite unexpected for me. Especially if RCU is used for
> > >>reference counting.
> > >Hi Eugene,
> > >
> > >Let's have a look at the reproducer below,
> > >
> > >>Originally it happened with rculfhash, below is minimized reproducer:
> > >>
> > >>#include <pthread.h>
> > >>#include <urcu-bp.h>
> > >>
> > >>struct Node
> > >>{
> > >>          struct rcu_head rcu_head;
> > >>};
> > >>
> > >>static void free_node(struct rcu_head * head)
> > >>{
> > >>          struct Node *node = caa_container_of(head, struct Node, rcu_head);
> > >>          free(node);
> > >>}
> > >>
> > >>static void * reader_thread(void * arg)
> > >>{
> > >>      rcu_read_lock();
> > >>      rcu_read_unlock();
> > >>      return NULL;
> > >>}
> > >>
> > >>int main(int argc, char * argv[])
> > >>{
> > >>      rcu_read_lock();
> > >>      struct Node * node = malloc(sizeof(*node));
> > >>      call_rcu(&node->rcu_head, free_node);
> > >>
> > >>      pthread_t read_thread_info;
> > >>      pthread_create(&read_thread_info, NULL, reader_thread, NULL);
> > >>      pthread_join(read_thread_info, NULL);
> > >This "pthread_join" blocks until reader_thread exits. It blocks
> > >while holding the RCU read-side lock. Quoting README.md:
> > >
> > >"### Interaction with mutexes
> > >
> > >One must be careful to do not cause deadlocks due to interaction of
> > >`synchronize_rcu()` and RCU read-side with mutexes. If `synchronize_rcu()`
> > >is called with a mutex held, this mutex (or any mutex which has this
> > >mutex in its dependency chain) should not be acquired from within a RCU
> > >read-side critical section.
> > >
> > >This is especially important to understand in the context of the
> > >QSBR flavor: a registered reader thread being "online" by
> > >default should be considered as within a RCU read-side critical
> > >section unless explicitly put "offline". Therefore, if
> > >`synchronize_rcu()` is called with a mutex held, this mutex, as
> > >well as any mutex which has this mutex in its dependency chain
> > >should only be taken when the RCU reader thread is "offline"
> > >(this can be performed by calling `rcu_thread_offline()`)."
> > >
> > >So what appears to happen here is that urcu-bp lazy registration
> > >grabs the rcu_gp_lock when the first rcu_read_lock is encountered.
> > >This mutex is also held when synchronize_rcu() is awaiting on
> > >reader thread's completion. So synchronize_rcu() of the call_rcu
> > >thread can block on the read-side lock held by main() (awaiting
> > >on pthread_join), which blocks the lazy registration of reader_thread,
> > >because it needs to grab that same lock.
> > >
> > >So this issue here is caused by holding the RCU read-side lock
> > >while calling pthread_join.
> > >
> > >For the QSBR flavor, you will want to put the main() thread
> > >offline before awaiting on pthread_join.
> > >
> > >Does it answer your question ?
> > 
> > Thank you for thorough explanation. The thing I still don't get is
> > related to the case, when either thread wants to hold read lock for
> > arbitrary long time to do some complicated data processing, e.g. walk
> > through huge hash table and send some network responses related to the
> > data in the table. pthread_join() can be moved out from the CS and
> > instead in CS we can have sleep(1000) or just a long loop to demonstrate
> > the case. Thread creation can be done somewhere else as well. Do I
> > understand it correctly, that if synchronize_rcu() is executed same time
> > by call_rcu thread, no other threads can be registered and unregistered
> > until reader has finished? Regarding documentation it looks as a correct
> > RCU usage, because I don't have any mutexes, just one of the threads
> > stays in CS for very long time and the only mutex involved is rcu_gp_lock.
> 
> Hmmm...
> 
> One possible way to allow this use case (if desired) is to make
> thread registration use trylock on rcu_gp_lock.  If this fails, they
> unconditionally acquire an rcu_gp_fallback_lock, and add the thread
> to a secondary list.  Then, while still holding rcu_gp_fallback_lock,
> again trylock rcu_gp_lock.  If this succeeds, move the thread(s) to the
> real list and release both locks, otherwise, release rcu_gp_fallback_lock
> and leave.
> 
> In addition, just after the grace-period machinery releases rcu_gp_lock,
> it acquires rcu_gp_fallback_lock.  If the secondary list is non-empty,
> it then re-acquires rcu_gp_lock and moves the threads to the real list.
> Finally, of course, it releases all the locks that it acquired.
> 
> The reason that this works is that a given grace period need not wait on
> threads that didn't exist before that grace period started.  Note that
> this relies on trylock never having spurious failures, which is guaranteed
> by POSIX (but sadly not C/C++'s shiny new part-of-language locks).
> 
> Seem reasonable?

No, it does not.  The list movement must occur at the start of the grace
period, otherwise the next grace period might incorrectly ignore recently
added threads.  There will therefore be some ticklishness interacting
with the grace-period-sharing optimization.  The problem is that if we
harvest the queue after moving the new threads to the list, we might
fail to wait for some readers that other updaters need us to wait on.

So perhaps a better approach is to use a simple lock hierarchy, acquiring
rcu_gp_lock before rcu_gp_fallback_lock.  Then the grace-period code
moves new threads just after harvesting updaters by simply unconditionally
acquiring rcu_gp_fallback_lock while still holding rcu_gp_lock.

New threads (and nearly dead threads) can then simply unconditionally
acquire rcu_gp_fallback_lock (which needs a better name) and always
placing themselves on the secondary list.

But nearly dead threads are a big fly in this ointment because their
TLS is guarded by the big ugly lock.  This can be handled by having a
mutex in the TLS, then making nearly-dead threads walk the list to their
element, doing hand-over-hand locking.  The resulting long thread-removal
times could be handled via a hash table or some such, but that might be
starting to get into more trouble than it is worth...

							Thanx, Paul

> > >Thanks,
> > >
> > >Mathieu
> > >
> > >
> > >
> > >>      rcu_read_unlock();
> > >>
> > >>      return 0;
> > >>}
> > >>
> > >>
> > >>Stacks:
> > >>
> > >>Thread 3 (Thread 0x7f8e2ab05700 (LWP 7386)):
> > >>#0  0x00000035cacdf343 in *__GI___poll (fds=<optimized out>,
> > >>nfds=<optimized out>, timeout=<optimized out>) at
> > >>../sysdeps/unix/sysv/linux/poll.c:87
> > >>#1  0x000000383880233e in wait_for_readers
> > >>(input_readers=0x7f8e2ab04cf0, cur_snap_readers=0x0,
> > >>qsreaders=0x7f8e2ab04ce0) at urcu-bp.c:211
> > >>#2  0x0000003838802af2 in synchronize_rcu_bp () at urcu-bp.c:272
> > >>#3  0x00000038388043a3 in call_rcu_thread (arg=0x1f7f030) at
> > >>urcu-call-rcu-impl.h:320
> > >>#4  0x00000035cb0079d1 in start_thread (arg=0x7f8e2ab05700) at
> > >>pthread_create.c:301
> > >>#5  0x00000035cace8b6d in clone () at
> > >>../sysdeps/unix/sysv/linux/x86_64/clone.S:115
> > >>Thread 2 (Thread 0x7f8e2a304700 (LWP 7387)):
> > >>#0  __lll_lock_wait () at
> > >>../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:136
> > >>#1  0x00000035cb009508 in _L_lock_854 () from /lib64/libpthread.so.0
> > >>#2  0x00000035cb0093d7 in __pthread_mutex_lock (mutex=0x3838a05ca0
> > >><rcu_gp_lock>) at pthread_mutex_lock.c:61
> > >>#3  0x0000003838801ed9 in mutex_lock (mutex=<optimized out>) at
> > >>urcu-bp.c:147
> > >>#4  0x000000383880351e in rcu_bp_register () at urcu-bp.c:493
> > >>#5  0x000000383880382e in _rcu_read_lock_bp () at urcu/static/urcu-bp.h:159
> > >>#6  rcu_read_lock_bp () at urcu-bp.c:296
> > >>#7  0x0000000000400801 in reader_thread ()
> > >>#8  0x00000035cb0079d1 in start_thread (arg=0x7f8e2a304700) at
> > >>pthread_create.c:301
> > >>#9  0x00000035cace8b6d in clone () at
> > >>../sysdeps/unix/sysv/linux/x86_64/clone.S:115
> > >>Thread 1 (Thread 0x7f8e2ab06740 (LWP 7385)):
> > >>#0  0x00000035cb00822d in pthread_join (threadid=140248569890560,
> > >>thread_return=0x0) at pthread_join.c:89
> > >>#1  0x000000000040088f in main ()
> > >>
> > >>
> > >>--
> > >>Eugene Ivanov
> > >>
> > >>
> > >>________________________________
> > >>
> > >>This e-mail is confidential and may contain legally privileged information.
> > >>It is intended only for the addressees. If you have received this e-mail in
> > >>error, kindly notify us immediately by telephone or e-mail and delete the
> > >>message from your system.
> > >>
> > >>_______________________________________________
> > >>lttng-dev mailing list
> > >>lttng-dev@lists.lttng.org
> > >>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > >>
> > 
> > --
> > Eugene Ivanov
> > 
> > 
> > ________________________________
> > 
> > This e-mail is confidential and may contain legally privileged information. It is intended only for the addressees. If you have received this e-mail in error, kindly notify us immediately by telephone or e-mail and delete the message from your system.
> > 
