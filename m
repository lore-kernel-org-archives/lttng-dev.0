From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: URCU and pthread mutex/cond variable hang
Date: Tue, 10 Mar 2015 00:43:09 +0000 (UTC)
Message-ID: <890431724.262051.1425948189016.JavaMail.zimbra__13889.1914430589$1425948281$gmane$org@efficios.com>
References: <20150303154014.6a166f6e@tlielax.poochiereds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YV8GS-0001TF-13
 for lttng-dev@lists.lttng.org; Mon, 09 Mar 2015 20:43:22 -0400
In-Reply-To: <20150303154014.6a166f6e@tlielax.poochiereds.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jeff Layton <jlayton@poochiereds.net>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Jeff Layton" <jlayton@poochiereds.net>
> To: lttng-dev@lists.lttng.org
> Sent: Tuesday, March 3, 2015 3:40:14 PM
> Subject: [lttng-dev] URCU and pthread mutex/cond variable hang
> 
> I've been using urcu to develop some userland code, and I've run into a
> problem that I don't quite understand. If I register a thread and then
> have that thread block on a pthread condition variable, then it seems
> to cause synchronize_rcu in another thread to hang.
> 
> I've attached a testcase that demonstrates the problem. You have to
> build it and link it against -lpthread and -lurcu-qsbr:
> 
>     $ gcc -Wall -o ./urcu_hang -lpthread -lurcu-qsbr urcu_hang.c
> 
> ...it will run fine. If you comment out the rcu_thread_offline/online
> calls though, it will hang.
> 
> Why? Is this expected behavior or a bug in urcu?

This is because you are using the urcu QSBR flavor. For this
flavor, the default state of a registered thread is to be
within a RCU read-side critical section, thus to block
synchronize_rcu() until the next rcu_quiescent_state() call
or until the next extended quiescent state (thread offline).

Therefore, you need to take care to put the threads in
offline mode before you issue blocking operations that
depend on completion of synchronize_rcu() to proceed further,
which is the case of test_rcu() in your test program. Otherwise
you create a deadlock, where main() is in a RCU read-side critical
section while it blocks awaiting on the pthread cond var.
Unfortuntately, the test_rcu() thread is unable to issue
the pthread cond signal, because it is blocked on synchronize_rcu(),
because main is itself in a RCU critical section.

Another alternative would be to use the other URCU flavors such
as urcu-mb, urcu-signal or urcu-membarrier. Their default state
is to be in a RCU quiescent state, which is IMHO more intuitive
for the users. But QSBR is the fastest flavor, but it comes at
the expense of a somewhat more complex API.

Hoping this explanation helps,

Thanks,

Mathieu



> 
> Thanks in advance!
> --
> Jeff Layton <jlayton@poochiereds.net>
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
