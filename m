From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC] adding into middle of RCU list
Date: Fri, 23 Aug 2013 14:08:22 -0700
Message-ID: <20130823210822.GD3871__25692.8257913843$1377292168$gmane$org@linux.vnet.ibm.com>
References: <20130822213318.49a57fa2@nehalam.linuxnetplumber.net>
	<20130823164637.GB3871@linux.vnet.ibm.com>
	<20130823171653.GA16558@Krystal>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paulmck@linux.vnet.ibm.com>) id 1VCyax-00043b-EB
	for lttng-dev@lists.lttng.org; Fri, 23 Aug 2013 17:08:36 -0400
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 23 Aug 2013 15:08:29 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 13CB33E40040
	for <lttng-dev@lists.lttng.org>; Fri, 23 Aug 2013 15:08:03 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	r7NL8NAk166286
	for <lttng-dev@lists.lttng.org>; Fri, 23 Aug 2013 15:08:24 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id r7NLBEnB024403
	for <lttng-dev@lists.lttng.org>; Fri, 23 Aug 2013 15:11:14 -0600
Content-Disposition: inline
In-Reply-To: <20130823171653.GA16558@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Fri, Aug 23, 2013 at 01:16:53PM -0400, Mathieu Desnoyers wrote:
> * Paul E. McKenney (paulmck@linux.vnet.ibm.com) wrote:
> > On Thu, Aug 22, 2013 at 09:33:18PM -0700, Stephen Hemminger wrote:
> > > I needed to add into the middle of an RCU list, does this make sense.
> > > 
> > > 
> > > 
> > > From a45892b0d49ac5fe449ba7e19c646cb17f7cee57 Mon Sep 17 00:00:00 2001
> > > From: Stephen Hemminger <stephen@networkplumber.org>
> > > Date: Thu, 22 Aug 2013 21:27:04 -0700
> > > Subject: [PATCH] Add list_splice_init_rcu to allow insertion into a RCU list
> > > 
> > > Simplified version of the version in kernel.
> > > ---
> > >  urcu/rculist.h |   32 ++++++++++++++++++++++++++++++++
> > >  1 file changed, 32 insertions(+)
> > > 
> > > diff --git a/urcu/rculist.h b/urcu/rculist.h
> > > index 1fd2df3..2e8a5a0 100644
> > > --- a/urcu/rculist.h
> > > +++ b/urcu/rculist.h
> > > @@ -72,6 +72,38 @@ void cds_list_del_rcu(struct cds_list_head *elem)
> > >  	CMM_STORE_SHARED(elem->prev->next, elem->next);
> > >  }
> > >  
> > > +
> > > +/**
> > > + * Splice an RCU-protected list into an existing list.
> > > + *
> > > + * Note that this function blocks in synchronize_rcu()
> > > + *
> > > + * Important note: this function is not called concurrently
> > > + *       with other updates to the list.
> > > + */
> > > +static inline void caa_list_splice_init_rcu(struct cds_list_head *list,
> > > +					    struct cds_list_head *head)
> > > +{
> > > +	struct cds_list_head *first = list->next;
> > > +	struct cds_list_head *last = list->prev;
> > > +	struct cds_list_head *at = head->next;
> > > +
> > > +	if (cds_list_empty(list))
> > > +		return;
> > > +
> > > +	/* "first" and "last" tracking list, so initialize it. */
> > > +	CDS_INIT_LIST_HEAD(list);
> > 
> > This change is happening in the presence of readers on the list, right?
> > For this to work reliably in the presence of mischievous compilers,
> > wouldn't CDS_INIT_LIST_HEAD() need to use CMM_ACCESS_ONCE() for its
> > pointer accesses?
> 
> Actually, we have rcu_assign_pointer()/rcu_set_pointer() exactly for
> this. They even skip the memory barrier if they store a NULL pointer.
> 
> > 
> > Hmmm...  The kernel version seems to have the same issue...
> 
> The compiler memory model of the Linux kernel AFAIK does not require an
> ACCESS_ONCE() for stores to word-aligned, word-sized integers/pointers,
> even if those are expected to be read concurrently. For reference, see:
> 
> #define __rcu_assign_pointer(p, v, space) \
>         do { \
>                 smp_wmb(); \
>                 (p) = (typeof(*v) __force space *)(v); \
>         } while (0)

Or I need to fix this one as well.  ;-)

> In userspace RCU, we require to match CMM_LOAD_SHARED() with
> CMM_STORE_SHARED() (which are used by
> rcu_dereference()/rcu_{set,assign}_pointer) whenever we concurrently
> access a variable shared between threads.
> 
> So I recommend using rcu_set_pointer() in userspace RCU, but I don't
> think your patch is needed for Linux, given the Linux kernel compiler
> memory model that is less strict than userspace RCU's model.

Me, I trust compilers a lot less than I did some years back.  ;-)

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> 
> > Patch below, FWIW.
> > 
> > 							Thanx, Paul
> > 
> > > +
> > > +	/* Wait for any readers to finish using the list before splicing */
> > > +	synchronize_rcu();
> > > +
> > > +	/* Readers are finished with the source list, so perform splice. */
> > > +	last->next = at;
> > > +	rcu_assign_pointer(head->next, first);
> > > +	first->prev = head;
> > > +	at->prev = last;
> > > +}
> > > +
> > >  /*
> > >   * Iteration through all elements of the list must be done while rcu_read_lock()
> > >   * is held.
> > > -- 
> > > 1.7.10.4
> > 
> > rcu: Make list_splice_init_rcu() account for RCU readers
> > 
> > The list_splice_init_rcu() function allows a list visible to RCU readers
> > to be spliced into another list visible to RCU readers.  This is OK,
> > except for the use of INIT_LIST_HEAD(), which does pointer updates
> > without doing anything to make those updates safe for concurrent readers.
> > 
> > Of course, most of the time INIT_LIST_HEAD() is being used in reader-free
> > contexts, such as initialization or cleanup, so it is OK for it to update
> > pointers in an unsafe-for-RCU-readers manner.  This commit therefore
> > creates an INIT_LIST_HEAD_RCU() that uses ACCESS_ONCE() to make the updates
> > reader-safe.  The reason that we can use ACCESS_ONCE() instead of the more
> > typical rcu_assign_pointer() is that list_splice_init_rcu() is updating the
> > pointers to reference something that is already visible to readers, so
> > that there is no problem with pre-initialized values.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > 
> > diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> > index 4106721..45a0a9e 100644
> > --- a/include/linux/rculist.h
> > +++ b/include/linux/rculist.h
> > @@ -19,6 +19,21 @@
> >   */
> >  
> >  /*
> > + * INIT_LIST_HEAD_RCU - Initialize a list_head visible to RCU readers
> > + * @list: list to be initialized
> > + *
> > + * You should instead use INIT_LIST_HEAD() for normal initialization and
> > + * cleanup tasks, when readers have no access to the list being initialized.
> > + * However, if the list being initialized is visible to readers, you
> > + * need to keep the compiler from being too mischievous.
> > + */
> > +static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
> > +{
> > +	ACCESS_ONCE(list->next) = list;
> > +	ACCESS_ONCE(list->prev) = list;
> > +}
> > +
> > +/*
> >   * return the ->next pointer of a list_head in an rcu safe
> >   * way, we must not access it directly
> >   */
> > @@ -191,9 +206,13 @@ static inline void list_splice_init_rcu(struct list_head *list,
> >  	if (list_empty(list))
> >  		return;
> >  
> > -	/* "first" and "last" tracking list, so initialize it. */
> > +	/*
> > +	 * "first" and "last" tracking list, so initialize it.  RCU readers
> > +	 * have access to this list, so we must use INIT_LIST_HEAD_RCU()
> > +	 * instead of INIT_LIST_HEAD().
> > +	 */
> >  
> > -	INIT_LIST_HEAD(list);
> > +	INIT_LIST_HEAD_RCU(list);
> >  
> >  	/*
> >  	 * At this point, the list body still points to the source list.
> > 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
