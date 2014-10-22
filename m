From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Userspace RCU: workqueue with batching, cheap wakeup,
 and work stealing
Date: Wed, 22 Oct 2014 12:44:07 +0000 (UTC)
Message-ID: <1886004391.395.1413981847391.JavaMail.zimbra__43308.570693671$1413981907$gmane$org@efficios.com>
References: <836028170.11148.1413630118955.JavaMail.zimbra@efficios.com>
 <1521253780.11371.1413666790992.JavaMail.zimbra@efficios.com>
 <5CDDBDF2D36D9F43B9F5E99003F6A0D4861BCD3E@PRN-MBX02-1.TheFacebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XgvH2-0002Zu-MD
 for lttng-dev@lists.lttng.org; Wed, 22 Oct 2014 08:44:22 -0400
In-Reply-To: <5CDDBDF2D36D9F43B9F5E99003F6A0D4861BCD3E@PRN-MBX02-1.TheFacebook.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Ben Maurer <bmaurer@fb.com>
Cc: Yannick Brosseau <yannick.brosseau@fb.com>, lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Ben Maurer" <bmaurer@fb.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "lttng-dev" <lttng-dev@lists.lttng.org>
> Cc: "Yannick Brosseau" <yannick.brosseau@fb.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Lai Jiangshan"
> <laijs@cn.fujitsu.com>, "Stephen Hemminger" <stephen@networkplumber.org>
> Sent: Sunday, October 19, 2014 3:15:28 PM
> Subject: RE: Userspace RCU: workqueue with batching, cheap wakeup, and work stealing
> 
> Hey,
> 
> That's pretty cool! Do you have any thoughts on the LifoSem implementation in
> folly? What are the differences in design decisions between your workqueue
> and lifosem?

Hi Ben,

I have to admit that I did not have time to look at thoroughly as I would
have liked at the Folly implementation. So I'll focus on the design guidelines
I'm aiming at for my workqueue implementation, and we'll be able to find out
the comparison with folly from there. (more below)

> 
> One other folly abstraction you might want to look at is MPMCQueue -- this is
> our fifo workqueue that we combine with lifosem:
> https://github.com/facebook/folly/blob/master/folly/MPMCQueue.h.
> 
> One thing I'd point out about lifo waiting that really applies to rcu is the
> ability to quiesce threads. When we use futexes to implement data structures
> like LifoSem, we use an abstraction called MemoryIdler
> (https://github.com/facebook/folly/blob/master/folly/detail/MemoryIdler.h).
> When MemoryIdler calls futex() it passes a maximum timeout of 5 seconds. If
> it takes > 5 seconds to wake up the thread, MemoryIdler releases some of the
> local resources of that thread. For example, it calls madvise() to release
> unused portions of the thread's stack and tells jemalloc to free unused
> per-thread caches. Because we use lifo waiting, the oldest waiting threads
> tend to sleep for a long time.
> 
> For RCU, I'm guessing that because you require thread registration parts of
> the library iterate through all active threads. An abstraction like
> MemoryIdler could allow threads that sleep for a long time to unregister
> themselves reducing the cost of iteration.

Yes, this could indeed speed up iteration a bit.

> 
> One question I've been asking myself: is there an API the kernel could be
> providing us to do a better job here? One of the things that annoys me about
> LifoSem is that we don't need exactly LIFO behavior. All we're trying to do
> is avoid having threads go to sleep if they could spin a bit and acquire new
> work. We also want inactive threads to sleep for a long time. But among
> threads that have been running recently, I wish we could give the kernel
> more freedom in choosing. For example if the most recently run thread in the
> LIFO stack ran on CPU 12 but a task is currently running on CPU 12, it'd be
> great if the kernel could choose a different thread -- one that had recently
> run on a CPU where it can be immediately scheduled.
> 
> Something to think about here: most applications I've seen don't really
> stress the performance of this queue. The bulk of the performance win we've
> gotten from LifoSem has been in the application itself -- LIFO wait queues
> increase application performance through better cache usage. I believe this
> is where we'd get further wins -- eg, if the kernel could do a better job of
> selecting which thread to use.

Ah-Ah! Well this is exactly one of the thing I'm trying to achieve with my
workqueue/waitqueue implementation: provide exact LIFO ordering of wakeups.
All done in user-space. I achieve this by having one futex int32_t per worker,
and by pushing the worker structures into a stack (lfstack). Therefore, the
LIFO ordering of wait (stack push) and wakeup (stack pop) is all done in
userspace. Also, the waiters are responsible for busy-waiting for a while
before calling futex wait, which achieve adaptative busy-wait/blocking
similarly to pthread mutexes.

I try to bias speed and low latency guarantees in favor of the dispatcher
(equivalent of your "network" thread). All the dispatcher has to do is to
enqueue work into the workqueue (xchg + store), and then wakeup one
worker thread (waitqueue stack pop (cmpxchg), check if worker is running,
if not, futex wake).

Worker threads grab the entire content of the workqueue when they are
looking for work to do. It minimizes the amount of cacheline bouncing
that would be otherwise caused by picking work items one by one. We
can do this efficiently thanks to wfcqueue splicing operation, which
allow moving the entire content of a queue without locking and without
touching the internal nodes of the queue.

In order to make sure we don't end up in situations where a thread would
grab a lot of work, and delay its execution while other threads are
waiting, I added a work-stealing scheme between neighboring threads.
When a thread is busy processing a work item, it awakens one of its
siblings, and the sibling is going to try to steal the entire work
batch owned by the busy thread. It should allow work batches to trickle
nicely amongst workers. Worker threads always do this when they wake up:
try to pick up work from the system workqueue, if no work is available,
then they try to steal work from a neighbor.

Another goal I have in this design is that if the system is in a state
where all workers are always busy, no calls to sys_futex() are required.
All the synchronization is done in user-space.

Comments, thoughts ?

Thanks,

Mathieu


> 
> -b
> ________________________________________
> From: Mathieu Desnoyers [mathieu.desnoyers@efficios.com]
> Sent: Saturday, October 18, 2014 2:13 PM
> To: Ben Maurer; lttng-dev
> Cc: Yannick Brosseau; Paul E. McKenney; Lai Jiangshan; Stephen Hemminger
> Subject: Userspace RCU: workqueue with batching, cheap wakeup, and work
> stealing
> 
> Hi,
> 
> I have written an implementation of a workqueue based
> on wfcqueue (fifo workqueue), wfstack (lifo wait queue)
> including a work-stealing scheme. I think this could
> scale very naturally to large workloads, and it skips
> the overhead of sys_futex when wakees are already running.
> Since the wakeup scheme is very lightweight when work
> is ongoing, we use it extensively.
> 
> It also makes extensive use of wfcqueue "splice" operation
> to move work batch in bulk amongst queue and worker
> threads. It is a O(1) operation which does not need to
> touch the content of the queue.
> 
> RCU is used to lookup the sibling worker threads for
> work stealing and to wake the siblings of a thread
> busy handling work.
> 
> It's at:
> 
> git://git.urcu.so/urcu.git
> branch: urcu/workqueue-wakeup
> 
> or gitweb of the top commit:
> https://urldefense.proofpoint.com/v1/url?u=http://git.lttng.org/?p%3Duserspace-rcu.git%3Ba%3Dcommit%3Bh%3D2c6a5414ed2ab44be24211d15a5d9f1f40dbfc74&k=ZVNjlDMF0FElm4dQtryO4A%3D%3D%0A&r=ykFqYBj5kD4j7jlBP4F60A%3D%3D%0A&m=Lj6FdYEksb4oceU%2BtcZSfPjzIApytWcuNFbjvS2oDHc%3D%0A&s=f6323913816c4c2fae2116d0db4689082678cb921efaa7962e3bdede01907454
> 
> Note that this is work in progress, compile-tested only.
> I also need to write extensive tests.
> 
> Feedback is welcome,
> 
> Thanks!
> 
> Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
