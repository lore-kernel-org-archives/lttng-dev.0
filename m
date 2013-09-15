From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Can userspace RCU be used with shared memory?
Date: Sun, 15 Sep 2013 15:34:29 -0400
Message-ID: <20130915193429.GA22171__12700.8290416144$1379273726$gmane$org@Krystal>
References: <CAD2ZD83X2hV0hqkN-ADsMJZch5B8wJwR4bwTxP=jYgPrRnTu=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VLI5X-0000Wb-0M
	for lttng-dev@lists.lttng.org; Sun, 15 Sep 2013 15:34:36 -0400
Content-Disposition: inline
In-Reply-To: <CAD2ZD83X2hV0hqkN-ADsMJZch5B8wJwR4bwTxP=jYgPrRnTu=A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Devanjan Choudhury <devanjan.dev@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Devanjan Choudhury (devanjan.dev@gmail.com) wrote:
> Hello Mathieu,
> 
> We are interested in using userspace rcu for one of our projects.

Great!

> Our main requirement is that we have some hash tables stored in shared
> memory which will be accessed by multiple reader processes. We have one
> single writer process. Since our use case is more read intensive compared
> to write, we have choosen to use RCU to synchronize the shared data.
> 
> Now, when our writer process updates some nodes(lets say delete some node)
> in hash tables stored in shared memory, it must call synchronize_rcu(),
> before it can actually free up the node. However, one note in the
> discussion (
> http://lists.lttng.org/pipermail/lttng-dev/2012-December/019295.html)
> states that synchronize_rcu() (or call_rcu()) executing in the context of
> one process will not see the RCU read-side locks of another process. If
> this is the case, then how/when can the writer process delete the node
> permanently. Should we need to consider doing garbage collection on our own?

The currently existing flavors of userspace RCU don't support
multi-process use of shared data structures through shared memory.
Currently, we require that all threads of a process that can access data
under RCU read-side critical section be registered
(rcu_register_thread). This adds them to a linked list of threads
monitored by synchronize_rcu().

We could very well create a new flavor specifically for this use-case
though. It would rely on a shared memory area to store the linked list
of threads registered as RCU readers, so this list could be shared
between processes.

> 
> Also, if I undertsand correctly, shyncronize_rcu() does the following
> basically:
> 
> void synchronize_rcu(void) { int cpu; for_each_online_cpu(cpu) run_on(cpu);

Not exactly: it performs synchronization with each registered thread
(not cpu). The synchronization is not a "run on", but rather monitoring
variables (which updates are surrounded by memory barriers) that ensure
each monitored thread has passed through a quiescent state before
synchronize_rcu() is allowed to complete.

> }
> 
> So, when our writer process call synchronize_rcu(), it will basically be
> made to run on all the CPUs. Shouldn't this be sufficient to ensure that
> any other reader process which had started a read rcu critical section has
> completed?

No, because we cannot disable preemption from user-space, and therefore
even if you happen to run on every CPU, it does not mean that there are
no RCU critical sections still in progress within preempted threads.

Best regards,

Mathieu

> 
> 
> -- 
> Regards,
> Devanjan

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
