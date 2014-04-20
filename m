From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH liburcu] Fix lifetime of rcu_barrier()'s
 completion structure
Date: Sun, 20 Apr 2014 16:26:04 +0000 (UTC)
Message-ID: <1521906503.4500.1398011164433.JavaMail.zimbra__24183.1667292447$1398011233$gmane$org@efficios.com>
References: <53518741.3060906@cohodata.com>
 <2068111068.4340.1397937819635.JavaMail.zimbra@efficios.com>
 <53535CB2.2030407@cohodata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WbuZG-0000Nv-TK
 for lttng-dev@lists.lttng.org; Sun, 20 Apr 2014 12:26:15 -0400
In-Reply-To: <53535CB2.2030407@cohodata.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Keir Fraser <keir@cohodata.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Keir Fraser" <keir@cohodata.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Sent: Sunday, April 20, 2014 1:35:46 AM
> Subject: Re: [PATCH liburcu] Fix lifetime of rcu_barrier()'s completion structure
> 
> 
> 
> Mathieu Desnoyers wrote:
> > ----- Original Message -----
> >> From: "Keir Fraser"<keir@cohodata.com>
> >> To: lttng-dev@lists.lttng.org
> >> Cc: "Mathieu Desnoyers"<mathieu.desnoyers@efficios.com>, "Paul E.
> >> McKenney"<paulmck@linux.vnet.ibm.com>
> >> Sent: Friday, April 18, 2014 4:12:49 PM
> >> Subject: [PATCH liburcu] Fix lifetime of rcu_barrier()'s completion
> >> structure
> >>
> >> [Another attachment, I must sort out to integrate with git send-mail]
> >>
> >> rcu_barrier() can return as soon as completion.barrier_count==0, which
> >> frees the completion struct along with the rest of its stack frame. But
> >> its call_rcu callbacks may yet try to read and write completion.futex
> >> via the wake_up function.
> >>
> >> Fix this by calloc()ing the completion struct and implementing a
> >> reference count to determine when it is eventually free()d.
> >>
> >> This also fixes bug #787, since calloc() initialises all fields of the
> >> structure to zero.
> >
> > I slightly edited your patch to use urcu_ref() and uatomic_sub_return()
> > (simple style fix). Please let me know if you are OK with the attached
> > patch.
> 
> Yes that's better, in particular I don't know how I missed the existence
> of uatomic_sub_return(). Very happy with that, thanks.

No worries. As far as I am concerned, I'm still wondering how I missed the
uninitialized variable and use-after-free in rcu_barrier(). ;-)

It's now merged into master and stable-0.8.

I opened the following bug tracker entry to track this issue:

https://bugs.lttng.org/issues/788

Thanks,

Mathieu

> 
>   -- Keir
> 
> > Thanks!
> >
> > Mathieu
> >
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
