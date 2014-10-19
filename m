From: Ben Maurer <bmaurer@fb.com>
Subject: Re: Userspace RCU: workqueue with batching, cheap wakeup,
 and work stealing
Date: Sun, 19 Oct 2014 19:15:28 +0000
Message-ID: <5CDDBDF2D36D9F43B9F5E99003F6A0D4861BCD3E__5359.91968722573$1413824068$gmane$org@PRN-MBX02-1.TheFacebook.com>
References: <836028170.11148.1413630118955.JavaMail.zimbra@efficios.com>,
 <1521253780.11371.1413666790992.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=5369e5907e=bmaurer@fb.com>) id 1Xfvx3-0006gy-Vq
 for lttng-dev@lists.lttng.org; Sun, 19 Oct 2014 15:15:41 -0400
In-Reply-To: <1521253780.11371.1413666790992.JavaMail.zimbra@efficios.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, lttng-dev <lttng-dev@lists.lttng.org>
Cc: Yannick Brosseau <yannick.brosseau@fb.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

Hey,

That's pretty cool! Do you have any thoughts on the LifoSem implementation in folly? What are the differences in design decisions between your workqueue and lifosem?

One other folly abstraction you might want to look at is MPMCQueue -- this is our fifo workqueue that we combine with lifosem: https://github.com/facebook/folly/blob/master/folly/MPMCQueue.h.

One thing I'd point out about lifo waiting that really applies to rcu is the ability to quiesce threads. When we use futexes to implement data structures like LifoSem, we use an abstraction called MemoryIdler (https://github.com/facebook/folly/blob/master/folly/detail/MemoryIdler.h). When MemoryIdler calls futex() it passes a maximum timeout of 5 seconds. If it takes > 5 seconds to wake up the thread, MemoryIdler releases some of the local resources of that thread. For example, it calls madvise() to release unused portions of the thread's stack and tells jemalloc to free unused per-thread caches. Because we use lifo waiting, the oldest waiting threads tend to sleep for a long time. 

For RCU, I'm guessing that because you require thread registration parts of the library iterate through all active threads. An abstraction like MemoryIdler could allow threads that sleep for a long time to unregister themselves reducing the cost of iteration.

One question I've been asking myself: is there an API the kernel could be providing us to do a better job here? One of the things that annoys me about LifoSem is that we don't need exactly LIFO behavior. All we're trying to do is avoid having threads go to sleep if they could spin a bit and acquire new work. We also want inactive threads to sleep for a long time. But among threads that have been running recently, I wish we could give the kernel more freedom in choosing. For example if the most recently run thread in the LIFO stack ran on CPU 12 but a task is currently running on CPU 12, it'd be great if the kernel could choose a different thread -- one that had recently run on a CPU where it can be immediately scheduled.

Something to think about here: most applications I've seen don't really stress the performance of this queue. The bulk of the performance win we've gotten from LifoSem has been in the application itself -- LIFO wait queues increase application performance through better cache usage. I believe this is where we'd get further wins -- eg, if the kernel could do a better job of selecting which thread to use.

-b
________________________________________
From: Mathieu Desnoyers [mathieu.desnoyers@efficios.com]
Sent: Saturday, October 18, 2014 2:13 PM
To: Ben Maurer; lttng-dev
Cc: Yannick Brosseau; Paul E. McKenney; Lai Jiangshan; Stephen Hemminger
Subject: Userspace RCU: workqueue with batching, cheap wakeup, and work stealing

Hi,

I have written an implementation of a workqueue based
on wfcqueue (fifo workqueue), wfstack (lifo wait queue)
including a work-stealing scheme. I think this could
scale very naturally to large workloads, and it skips
the overhead of sys_futex when wakees are already running.
Since the wakeup scheme is very lightweight when work
is ongoing, we use it extensively.

It also makes extensive use of wfcqueue "splice" operation
to move work batch in bulk amongst queue and worker
threads. It is a O(1) operation which does not need to
touch the content of the queue.

RCU is used to lookup the sibling worker threads for
work stealing and to wake the siblings of a thread
busy handling work.

It's at:

git://git.urcu.so/urcu.git
branch: urcu/workqueue-wakeup

or gitweb of the top commit:
https://urldefense.proofpoint.com/v1/url?u=http://git.lttng.org/?p%3Duserspace-rcu.git%3Ba%3Dcommit%3Bh%3D2c6a5414ed2ab44be24211d15a5d9f1f40dbfc74&k=ZVNjlDMF0FElm4dQtryO4A%3D%3D%0A&r=ykFqYBj5kD4j7jlBP4F60A%3D%3D%0A&m=Lj6FdYEksb4oceU%2BtcZSfPjzIApytWcuNFbjvS2oDHc%3D%0A&s=f6323913816c4c2fae2116d0db4689082678cb921efaa7962e3bdede01907454

Note that this is work in progress, compile-tested only.
I also need to write extensive tests.

Feedback is welcome,

Thanks!

Mathieu
