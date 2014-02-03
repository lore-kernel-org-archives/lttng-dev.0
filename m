From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: URCU accessing rcu_head->func
Date: Mon, 3 Feb 2014 03:37:38 +0000 (UTC)
Message-ID: <582363683.17541.1391398658096.JavaMail.zimbra__3327.43900730765$1391398719$gmane$org@efficios.com>
References: <20140131201632.GA32482@pax.zz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WAALv-0006jL-ST
	for lttng-dev@lists.lttng.org; Sun, 02 Feb 2014 22:37:44 -0500
In-Reply-To: <20140131201632.GA32482@pax.zz.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Florian Lohoff <f@zz.de>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Florian Lohoff" <f@zz.de>
> To: lttng-dev@lists.lttng.org
> Sent: Friday, January 31, 2014 3:16:32 PM
> Subject: [lttng-dev] URCU accessing rcu_head->func
> 
> 
> Hi,
> 
> i am having multiple timer which can issue a call_rcu on an object using
> an rcu_head.
> 
> It can happen than an object is already on the call_rcu list
> for destruction and another timer fires.
> 
> So i am doing something like this.
> 
> 	if (!rs->rcuhead.func) {
> 		call_rcu(&rs->rcuhead, free_obj);
> 	}
> 
> I have a feeling in my gut that this didnt blow up
> just by accident and i am doing something utterly stupid.
> 
> I am in the read side critical section so my structure
> cant appear under my feet but the above can be racy at
> best.

I guess you meant "disappear" here ?

> 
> What would be the best way to achieve something like:
> 
> 	"queue for call_rcu if not already queued"
> 
> Another flag with an atomic inc or something?

Indeed, the scheme you describe above seems to be racy, since there could be
two or more read-side critical sections accessing the same object concurrently,
and doing two call_rcu() enqueuing the same object (same linked list node) twice
into the call_rcu lists will simply corrupt those lists.

Let me first rephrase your intent here just to make sure I understand: you use
RCU read-side to provide existence guarantee on the "rs" object, and you want
to enqueue the object rcuhead with call_rcu() for deletion (free_obj) after a
grace period has elapsed.

Assuming you care about keeping this code path wait-free or lock-free (at least),
using uatomic_xchg() would allow you to set an atomic flag and know, from the
returned value, whether you "own" the object reclaim or not. You can then decide
whether or not call_rcu() needs to be called based on the value read by
uatomic_xchg().

You could do something similar with mutexes, but then you would lose the
wait-freedom characteristic of this code path, which I am guessing is one
key reason why you use RCU read-side lock and call_rcu() in the first place.

Does it make sense ?

Thanks,

Mathieu



> 
> Flo
> --
> Florian Lohoff                                                 f@zz.de
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
