From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: URCU accessing rcu_head->func
Date: Mon, 3 Feb 2014 14:47:11 +0000 (UTC)
Message-ID: <199896313.17720.1391438831680.JavaMail.zimbra__30255.2050482065$1391438901$gmane$org@efficios.com>
References: <20140131201632.GA32482@pax.zz.de>
	<582363683.17541.1391398658096.JavaMail.zimbra@efficios.com>
	<20140203075259.GA25614@pax.zz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WAKns-0003qz-AF
	for lttng-dev@lists.lttng.org; Mon, 03 Feb 2014 09:47:22 -0500
In-Reply-To: <20140203075259.GA25614@pax.zz.de>
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
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Sent: Monday, February 3, 2014 2:52:59 AM
> Subject: Re: [lttng-dev] URCU accessing rcu_head->func
> 
> 
> Hi, Mathieu,
> 
> On Mon, Feb 03, 2014 at 03:37:38AM +0000, Mathieu Desnoyers wrote:
> > > 
> > > I am in the read side critical section so my structure
> > > cant appear under my feet but the above can be racy at
> > > best.
> > 
> > I guess you meant "disappear" here ?
> 
> Yep
> 
> > > What would be the best way to achieve something like:
> > > 
> > > 	"queue for call_rcu if not already queued"
> > > 
> > > Another flag with an atomic inc or something?
> > 
> > Indeed, the scheme you describe above seems to be racy, since there could
> > be
> > two or more read-side critical sections accessing the same object
> > concurrently,
> > and doing two call_rcu() enqueuing the same object (same linked list node)
> > twice
> > into the call_rcu lists will simply corrupt those lists.
> > 
> > Let me first rephrase your intent here just to make sure I understand: you
> > use
> > RCU read-side to provide existence guarantee on the "rs" object, and you
> > want
> > to enqueue the object rcuhead with call_rcu() for deletion (free_obj) after
> > a
> > grace period has elapsed.
> > 
> > Assuming you care about keeping this code path wait-free or lock-free (at
> > least),
> > using uatomic_xchg() would allow you to set an atomic flag and know, from
> > the
> > returned value, whether you "own" the object reclaim or not. You can then
> > decide
> > whether or not call_rcu() needs to be called based on the value read by
> > uatomic_xchg().
> > 
> > You could do something similar with mutexes, but then you would lose the
> > wait-freedom characteristic of this code path, which I am guessing is one
> > key reason why you use RCU read-side lock and call_rcu() in the first
> > place.
> > 
> > Does it make sense ?
> 
> I solved it a little different. I am using a RCU hash for keeping the
> data structures and i simply took the reasult of cds_lfht_del
> or cds_lfht_add_replace.
> 
> If i successfully remove my structure from the hash i queue for later
> destruction. As the removal should only happen successfully once i should
> be done.
> 
> Its just a little bit more tricky to get correct.

Indeed! We have the return value to del/add replace in place for this
kind of use-case, and it does get you the same result as using the flag
technique.

Thanks,

Mathieu

> 
> Flo
> --
> Florian Lohoff                                                 f@zz.de
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
