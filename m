From: Jeff Layton <jlayton@poochiereds.net>
Subject: Re: URCU and pthread mutex/cond variable hang
Date: Tue, 10 Mar 2015 15:25:39 -0400
Message-ID: <20150310152539.6caa9fb8__30719.391295179$1426015622$gmane$org@synchrony.poochiereds.net>
References: <20150303154014.6a166f6e@tlielax.poochiereds.net>
 <890431724.262051.1425948189016.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jlayton@poochiereds.net>) id 1YVPmu-0007Ii-Of
 for lttng-dev@lists.lttng.org; Tue, 10 Mar 2015 15:25:58 -0400
Received: by qgfi50 with SMTP id i50so4561820qgf.10
 for <lttng-dev@lists.lttng.org>; Tue, 10 Mar 2015 12:25:51 -0700 (PDT)
In-Reply-To: <890431724.262051.1425948189016.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Tue, 10 Mar 2015 00:43:09 +0000 (UTC)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- Original Message -----
> > From: "Jeff Layton" <jlayton@poochiereds.net>
> > To: lttng-dev@lists.lttng.org
> > Sent: Tuesday, March 3, 2015 3:40:14 PM
> > Subject: [lttng-dev] URCU and pthread mutex/cond variable hang
> > 
> > I've been using urcu to develop some userland code, and I've run into a
> > problem that I don't quite understand. If I register a thread and then
> > have that thread block on a pthread condition variable, then it seems
> > to cause synchronize_rcu in another thread to hang.
> > 
> > I've attached a testcase that demonstrates the problem. You have to
> > build it and link it against -lpthread and -lurcu-qsbr:
> > 
> >     $ gcc -Wall -o ./urcu_hang -lpthread -lurcu-qsbr urcu_hang.c
> > 
> > ...it will run fine. If you comment out the rcu_thread_offline/online
> > calls though, it will hang.
> > 
> > Why? Is this expected behavior or a bug in urcu?
> 
> This is because you are using the urcu QSBR flavor. For this
> flavor, the default state of a registered thread is to be
> within a RCU read-side critical section, thus to block
> synchronize_rcu() until the next rcu_quiescent_state() call
> or until the next extended quiescent state (thread offline).
> 

(facepalm)

Ahh ok. I totally missed that bit, but it makes sense now that you've
pointed it out. So does that mean that rcu_read_lock/unlock are no-ops
with QSBR?

> Therefore, you need to take care to put the threads in
> offline mode before you issue blocking operations that
> depend on completion of synchronize_rcu() to proceed further,
> which is the case of test_rcu() in your test program. Otherwise
> you create a deadlock, where main() is in a RCU read-side critical
> section while it blocks awaiting on the pthread cond var.
> Unfortuntately, the test_rcu() thread is unable to issue
> the pthread cond signal, because it is blocked on synchronize_rcu(),
> because main is itself in a RCU critical section.
> 

Yep, I've started doing that and everything is working well, but I'm a
little worried that I could eventually end up missing someplace and hang
everything. :)

> Another alternative would be to use the other URCU flavors such
> as urcu-mb, urcu-signal or urcu-membarrier. Their default state
> is to be in a RCU quiescent state, which is IMHO more intuitive
> for the users. But QSBR is the fastest flavor, but it comes at
> the expense of a somewhat more complex API.
> 

Yes, I may consider doing that instead.

> Hoping this explanation helps,
> 

It does -- many thanks!

-- 
Jeff Layton <jlayton@poochiereds.net>
