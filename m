From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [rp] [RFC PATCH urcu] Add "last" output parameter
	to pop/dequeue
Date: Tue, 15 Jan 2013 10:38:25 -0800
Message-ID: <20130115183825.GR3384__2409.34469406984$1358275750$gmane$org@linux.vnet.ibm.com>
References: <20121213114456.GA9780@Krystal>
	<20121214163609.GD2542@linux.vnet.ibm.com>
	<20121217144008.GA5086@Krystal>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paulmck@linux.vnet.ibm.com>) id 1TvBYW-00043S-SS
	for lttng-dev@lists.lttng.org; Tue, 15 Jan 2013 13:48:17 -0500
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 15 Jan 2013 13:48:11 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 460BC6E8041
	for <lttng-dev@lists.lttng.org>; Tue, 15 Jan 2013 13:48:05 -0500 (EST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	r0FIm5dc353738
	for <lttng-dev@lists.lttng.org>; Tue, 15 Jan 2013 13:48:05 -0500
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id r0FIkd34032055
	for <lttng-dev@lists.lttng.org>; Tue, 15 Jan 2013 11:46:40 -0700
Content-Disposition: inline
In-Reply-To: <20121217144008.GA5086@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

[Sorry for the delay, finally getting back to this.]

On Mon, Dec 17, 2012 at 09:40:09AM -0500, Mathieu Desnoyers wrote:
> * Paul E. McKenney (paulmck@linux.vnet.ibm.com) wrote:
> > On Thu, Dec 13, 2012 at 06:44:56AM -0500, Mathieu Desnoyers wrote:
> > > I noticed that in addition to having:
> > > 
> > > - push/enqueue returning whether the stack/queue was empty prior to the
> > >   operation,
> > > - pop_all/splice, by nature, emptying the stack/queue,
> > > 
> > > it can be interesting to make pop/dequeue operations return whether they
> > > are returning the last element of the stack/queue (therefore emptying
> > > it). This allow extending the test-cases covering the number of empty
> > > stack/queue encountered by both push/enqueuer and pop/dequeuer threads
> > > not only to push/enqueue paired with pop_all/splice, but also to
> > > pop/dequeue.
> > > 
> > > In the case of wfstack, this unfortunately requires to modify an already
> > > exposed API. As a RFC, one question we should answer is how we want to
> > > handle the way forward: should we add new functions to the wfstack API
> > > and leave the existing ones alone ? 
> > > 
> > > Thoughts ?
> > 
> > Hmmm...  What is the use case, given that a push might happen immediately
> > after the pop said that the stack/queue was empty?  Of course, if we
> > somehow know that there are no concurrent pushes, we could instead
> > check for empty.
> > 
> > So what am I missing here?
> 
> The setup for those use-cases is the following (I'm using the stack as
> example, but the same applies to queue):
> 
> - we have N threads doing push and using the push return value that
>   states whether it pushed into an empty stack.
> - we have M threads doing "pop", using the return value to know if it
>   pops a stack into an empty-stack-state. Following the locking
>   requirements, we protect those M threads'pop by a mutex, but they
>   don't need to be protected against push.
> 
> Just to help understanding where the idea comes from, let's start with
> another use-case that is similar (push/pop_all). Knowing whether we
> pushed into an empty stack along with pop_all become very useful when
> you want to combine the stack with a higher level batching semantic
> linked to the elements present within the stack.
> 
> In the case of grace period batching, for instance, I used
> "push"/"pop_all" to provide this kind of semantic: if we push into an
> empty stack, we know we will have to go through the grace period. If we
> are pushed into a non-empty stack, we just wait to be awakened by the
> first thread which was pushed into the stack. This requires that we use
> "pop_all" before going though the grace period.
> 
> Now more specifically about "pop", one use-case I have in mind is
> energy-efficient handling of empty stacks. With M threads executing
> "pop", let's suppose we want them to be blocked on a futex when there is
> nothing to do. Now the tricky part is: how can we do this without adding
> overhead (extra load/stores) to the stack ?
> 
> If we have the ability to know whether we are popping the last element
> of a stack, we can use this information to go into a futex wait state
> after having handled the last element. Since the threads doing "push"
> would monitor whether they push into an empty stack, they would wake us
> whenever needed.
> 
> If instead we choose to simply wait until one of the M threads discovers
> that the stack is actually empty, we are issuing extra "pop" (which
> fails) each time the stack is empty. In the worse-case, if a queue
> always flip between 0 and 1 elements, we double the number of "pop"
> needed to handle the same amount of nodes.
> 
> Otherwise, if we choose to add an explicit check to see whether the
> stack is empty, we are adding an extra load of the head node for every
> pop.
> 
> Another use-case I see is low-overhead monitoring of stack usage
> efficiency. For this kind of use-case, we might want to know, both
> within push and pop threads, if we are underutilizing our system
> resources. Having the ability to know that we are reaching empty state
> without any extra overhead to stack memory traffic gives us this
> ability.
> 
> I must admit that the use-cases for returning whether pop takes the last
> element is not as strong as the batching case with push/pop_all, mainly
> because AFAIU, we can achieve the same result by doing an extra check of
> stack emptiness state (either by an explicit empty() check, or by
> issuing an extra pop that will see an empty stack). What we are saving
> here is the extra overhead on stack cache-lines cause by this extra
> check.
> 
> Another use-case, although maybe less compelling, is for validation.
> With concurrent threads doing push/pop/pop_all operations on the stack,
> we can perform the following check: If we empty the stack at the end of
> test execution, the
> 
>   number of push-to-empty-stack
> 
>       must be equal to the
> 
>   number of pop_all-from-non-empty-stack
>    + number of pop-last-element-from-non-empty-stack
> 
> We should note that this validation could not be performed if "pop" is
> not returning whether it popped the last stack element (checked
> atomically with the pop operation). This is a use-case where adding an
> extra check on the pop-side would not work (it needs to be performed
> atomically with pop).
> 
> And maybe there are other use-cases that are currently beyond my
> imagination too.
> 
> Thoughts ?

Sounds like a job for a separate API member that can be added when
needed.  I do admit that you have legitimate use cases, but I do not
believe that they will be the common case.

Maybe due to failure of imagination on my part, but...  ;-)

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> 
> > 
> > 							Thanx, Paul
> > 
> > > Thanks,
> > > 
> > > Mathieu
> > > 
> > > ---
> > > diff --git a/tests/test_urcu_wfcq.c b/tests/test_urcu_wfcq.c
> > > index 91285a5..de9566d 100644
> > > --- a/tests/test_urcu_wfcq.c
> > > +++ b/tests/test_urcu_wfcq.c
> > > @@ -168,6 +168,7 @@ static DEFINE_URCU_TLS(unsigned long long, nr_successful_dequeues);
> > >  static DEFINE_URCU_TLS(unsigned long long, nr_successful_enqueues);
> > >  static DEFINE_URCU_TLS(unsigned long long, nr_empty_dest_enqueues);
> > >  static DEFINE_URCU_TLS(unsigned long long, nr_splice);
> > > +static DEFINE_URCU_TLS(unsigned long long, nr_dequeue_last);
> > > 
> > >  static unsigned int nr_enqueuers;
> > >  static unsigned int nr_dequeuers;
> > > @@ -228,11 +229,15 @@ fail:
> > >  static void do_test_dequeue(enum test_sync sync)
> > >  {
> > >  	struct cds_wfcq_node *node;
> > > +	bool last;
> > > 
> > >  	if (sync == TEST_SYNC_MUTEX)
> > > -		node = cds_wfcq_dequeue_blocking(&head, &tail);
> > > +		node = cds_wfcq_dequeue_blocking(&head, &tail, &last);
> > >  	else
> > > -		node = __cds_wfcq_dequeue_blocking(&head, &tail);
> > > +		node = __cds_wfcq_dequeue_blocking(&head, &tail, &last);
> > > +
> > > +	if (last)
> > > +		URCU_TLS(nr_dequeue_last)++;
> > > 
> > >  	if (node) {
> > >  		free(node);
> > > @@ -263,6 +268,7 @@ static void do_test_splice(enum test_sync sync)
> > >  		break;
> > >  	case CDS_WFCQ_RET_DEST_EMPTY:
> > >  		URCU_TLS(nr_splice)++;
> > > +		URCU_TLS(nr_dequeue_last)++;
> > >  		/* ok */
> > >  		break;
> > >  	case CDS_WFCQ_RET_DEST_NON_EMPTY:
> > > @@ -325,16 +331,21 @@ static void *thr_dequeuer(void *_count)
> > >  	count[0] = URCU_TLS(nr_dequeues);
> > >  	count[1] = URCU_TLS(nr_successful_dequeues);
> > >  	count[2] = URCU_TLS(nr_splice);
> > > +	count[3] = URCU_TLS(nr_dequeue_last);
> > >  	return ((void*)2);
> > >  }
> > > 
> > > -static void test_end(unsigned long long *nr_dequeues)
> > > +static void test_end(unsigned long long *nr_dequeues,
> > > +		unsigned long long *nr_dequeue_last)
> > >  {
> > >  	struct cds_wfcq_node *node;
> > > +	bool last;
> > > 
> > >  	do {
> > > -		node = cds_wfcq_dequeue_blocking(&head, &tail);
> > > +		node = cds_wfcq_dequeue_blocking(&head, &tail, &last);
> > >  		if (node) {
> > > +			if (last)
> > > +				(*nr_dequeue_last)++;
> > >  			free(node);
> > >  			(*nr_dequeues)++;
> > >  		}
> > > @@ -367,7 +378,7 @@ int main(int argc, char **argv)
> > >  	unsigned long long tot_successful_enqueues = 0,
> > >  			   tot_successful_dequeues = 0,
> > >  			   tot_empty_dest_enqueues = 0,
> > > -			   tot_splice = 0;
> > > +			   tot_splice = 0, tot_dequeue_last = 0;
> > >  	unsigned long long end_dequeues = 0;
> > >  	int i, a, retval = 0;
> > > 
> > > @@ -480,7 +491,7 @@ int main(int argc, char **argv)
> > >  	tid_enqueuer = malloc(sizeof(*tid_enqueuer) * nr_enqueuers);
> > >  	tid_dequeuer = malloc(sizeof(*tid_dequeuer) * nr_dequeuers);
> > >  	count_enqueuer = malloc(3 * sizeof(*count_enqueuer) * nr_enqueuers);
> > > -	count_dequeuer = malloc(3 * sizeof(*count_dequeuer) * nr_dequeuers);
> > > +	count_dequeuer = malloc(4 * sizeof(*count_dequeuer) * nr_dequeuers);
> > >  	cds_wfcq_init(&head, &tail);
> > > 
> > >  	next_aff = 0;
> > > @@ -493,7 +504,7 @@ int main(int argc, char **argv)
> > >  	}
> > >  	for (i = 0; i < nr_dequeuers; i++) {
> > >  		err = pthread_create(&tid_dequeuer[i], NULL, thr_dequeuer,
> > > -				     &count_dequeuer[3 * i]);
> > > +				     &count_dequeuer[4 * i]);
> > >  		if (err != 0)
> > >  			exit(1);
> > >  	}
> > > @@ -533,34 +544,37 @@ int main(int argc, char **argv)
> > >  		err = pthread_join(tid_dequeuer[i], &tret);
> > >  		if (err != 0)
> > >  			exit(1);
> > > -		tot_dequeues += count_dequeuer[3 * i];
> > > -		tot_successful_dequeues += count_dequeuer[3 * i + 1];
> > > -		tot_splice += count_dequeuer[3 * i + 2];
> > > +		tot_dequeues += count_dequeuer[4 * i];
> > > +		tot_successful_dequeues += count_dequeuer[4 * i + 1];
> > > +		tot_splice += count_dequeuer[4 * i + 2];
> > > +		tot_dequeue_last += count_dequeuer[4 * i + 3];
> > >  	}
> > >  	
> > > -	test_end(&end_dequeues);
> > > +	test_end(&end_dequeues, &tot_dequeue_last);
> > > 
> > >  	printf_verbose("total number of enqueues : %llu, dequeues %llu\n",
> > >  		       tot_enqueues, tot_dequeues);
> > >  	printf_verbose("total number of successful enqueues : %llu, "
> > >  		       "enqueues to empty dest : %llu, "
> > >  		       "successful dequeues %llu, "
> > > -		       "splice : %llu\n",
> > > +		       "splice : %llu, dequeue_last : %llu\n",
> > >  		       tot_successful_enqueues,
> > >  		       tot_empty_dest_enqueues,
> > >  		       tot_successful_dequeues,
> > > -		       tot_splice);
> > > +		       tot_splice, tot_dequeue_last);
> > >  	printf("SUMMARY %-25s testdur %4lu nr_enqueuers %3u wdelay %6lu "
> > >  		"nr_dequeuers %3u "
> > >  		"rdur %6lu nr_enqueues %12llu nr_dequeues %12llu "
> > >  		"successful enqueues %12llu enqueues to empty dest %12llu "
> > >  		"successful dequeues %12llu splice %12llu "
> > > +		"dequeue_last %llu "
> > >  		"end_dequeues %llu nr_ops %12llu\n",
> > >  		argv[0], duration, nr_enqueuers, wdelay,
> > >  		nr_dequeuers, rduration, tot_enqueues, tot_dequeues,
> > >  		tot_successful_enqueues,
> > >  		tot_empty_dest_enqueues,
> > > -		tot_successful_dequeues, tot_splice, end_dequeues,
> > > +		tot_successful_dequeues, tot_splice, tot_dequeue_last,
> > > +		end_dequeues,
> > >  		tot_enqueues + tot_dequeues);
> > > 
> > >  	if (tot_successful_enqueues != tot_successful_dequeues + end_dequeues) {
> > > @@ -576,12 +590,11 @@ int main(int argc, char **argv)
> > >  	 * exactly as many empty queues than the number of non-empty
> > >  	 * src splice.
> > >  	 */
> > > -	if (test_wait_empty && test_splice && !test_dequeue
> > > -			&& tot_empty_dest_enqueues != tot_splice) {
> > > +	if (tot_empty_dest_enqueues != tot_dequeue_last) {
> > >  		printf("WARNING! Discrepancy between empty enqueue (%llu) and "
> > > -			"number of non-empty splice (%llu)\n",
> > > +			"number of dequeue of last element (%llu)\n",
> > >  			tot_empty_dest_enqueues,
> > > -			tot_splice);
> > > +			tot_dequeue_last);
> > >  		retval = 1;
> > >  	}
> > >  	free(count_enqueuer);
> > > diff --git a/tests/test_urcu_wfs.c b/tests/test_urcu_wfs.c
> > > index 259ca24..6c54153 100644
> > > --- a/tests/test_urcu_wfs.c
> > > +++ b/tests/test_urcu_wfs.c
> > > @@ -171,6 +171,7 @@ static DEFINE_URCU_TLS(unsigned long long, nr_successful_dequeues);
> > >  static DEFINE_URCU_TLS(unsigned long long, nr_successful_enqueues);
> > >  static DEFINE_URCU_TLS(unsigned long long, nr_empty_dest_enqueues);
> > >  static DEFINE_URCU_TLS(unsigned long long, nr_pop_all);
> > > +static DEFINE_URCU_TLS(unsigned long long, nr_pop_last);
> > > 
> > >  static unsigned int nr_enqueuers;
> > >  static unsigned int nr_dequeuers;
> > > @@ -230,14 +231,17 @@ fail:
> > >  static void do_test_pop(enum test_sync sync)
> > >  {
> > >  	struct cds_wfs_node *node;
> > > +	bool last;
> > > 
> > >  	if (sync == TEST_SYNC_MUTEX)
> > >  		cds_wfs_pop_lock(&s);
> > > -	node = __cds_wfs_pop_blocking(&s);
> > > +	node = __cds_wfs_pop_blocking(&s, &last);
> > >  	if (sync == TEST_SYNC_MUTEX)
> > >  		cds_wfs_pop_unlock(&s);
> > > 
> > >  	if (node) {
> > > +		if (last)
> > > +			URCU_TLS(nr_pop_last)++;
> > >  		free(node);
> > >  		URCU_TLS(nr_successful_dequeues)++;
> > >  	}
> > > @@ -260,6 +264,7 @@ static void do_test_pop_all(enum test_sync sync)
> > >  		return;
> > > 
> > >  	URCU_TLS(nr_pop_all)++;
> > > +	URCU_TLS(nr_pop_last)++;
> > > 
> > >  	cds_wfs_for_each_blocking_safe(head, node, n) {
> > >  		free(node);
> > > @@ -308,24 +313,30 @@ static void *thr_dequeuer(void *_count)
> > > 
> > >  	printf_verbose("dequeuer thread_end, thread id : %lx, tid %lu, "
> > >  		       "dequeues %llu, successful_dequeues %llu "
> > > -		       "pop_all %llu\n",
> > > +		       "pop_all %llu pop_last %llu\n",
> > >  		       pthread_self(),
> > >  			(unsigned long) gettid(),
> > >  		       URCU_TLS(nr_dequeues), URCU_TLS(nr_successful_dequeues),
> > > -		       URCU_TLS(nr_pop_all));
> > > +		       URCU_TLS(nr_pop_all),
> > > +		       URCU_TLS(nr_pop_last));
> > >  	count[0] = URCU_TLS(nr_dequeues);
> > >  	count[1] = URCU_TLS(nr_successful_dequeues);
> > >  	count[2] = URCU_TLS(nr_pop_all);
> > > +	count[3] = URCU_TLS(nr_pop_last);
> > >  	return ((void*)2);
> > >  }
> > > 
> > > -static void test_end(struct cds_wfs_stack *s, unsigned long long *nr_dequeues)
> > > +static void test_end(struct cds_wfs_stack *s, unsigned long long *nr_dequeues,
> > > +		unsigned long long *nr_pop_last)
> > >  {
> > >  	struct cds_wfs_node *node;
> > > +	bool last;
> > > 
> > >  	do {
> > > -		node = cds_wfs_pop_blocking(s);
> > > +		node = cds_wfs_pop_blocking(s, &last);
> > >  		if (node) {
> > > +			if (last)
> > > +				(*nr_pop_last)++;
> > >  			free(node);
> > >  			(*nr_dequeues)++;
> > >  		}
> > > @@ -358,7 +369,7 @@ int main(int argc, char **argv)
> > >  	unsigned long long tot_successful_enqueues = 0,
> > >  			   tot_successful_dequeues = 0,
> > >  			   tot_empty_dest_enqueues = 0,
> > > -			   tot_pop_all = 0;
> > > +			   tot_pop_all = 0, tot_pop_last = 0;
> > >  	unsigned long long end_dequeues = 0;
> > >  	int i, a, retval = 0;
> > > 
> > > @@ -471,7 +482,7 @@ int main(int argc, char **argv)
> > >  	tid_enqueuer = malloc(sizeof(*tid_enqueuer) * nr_enqueuers);
> > >  	tid_dequeuer = malloc(sizeof(*tid_dequeuer) * nr_dequeuers);
> > >  	count_enqueuer = malloc(3 * sizeof(*count_enqueuer) * nr_enqueuers);
> > > -	count_dequeuer = malloc(3 * sizeof(*count_dequeuer) * nr_dequeuers);
> > > +	count_dequeuer = malloc(4 * sizeof(*count_dequeuer) * nr_dequeuers);
> > >  	cds_wfs_init(&s);
> > > 
> > >  	next_aff = 0;
> > > @@ -484,7 +495,7 @@ int main(int argc, char **argv)
> > >  	}
> > >  	for (i = 0; i < nr_dequeuers; i++) {
> > >  		err = pthread_create(&tid_dequeuer[i], NULL, thr_dequeuer,
> > > -				     &count_dequeuer[3 * i]);
> > > +				     &count_dequeuer[4 * i]);
> > >  		if (err != 0)
> > >  			exit(1);
> > >  	}
> > > @@ -524,34 +535,36 @@ int main(int argc, char **argv)
> > >  		err = pthread_join(tid_dequeuer[i], &tret);
> > >  		if (err != 0)
> > >  			exit(1);
> > > -		tot_dequeues += count_dequeuer[3 * i];
> > > -		tot_successful_dequeues += count_dequeuer[3 * i + 1];
> > > -		tot_pop_all += count_dequeuer[3 * i + 2];
> > > +		tot_dequeues += count_dequeuer[4 * i];
> > > +		tot_successful_dequeues += count_dequeuer[4 * i + 1];
> > > +		tot_pop_all += count_dequeuer[4 * i + 2];
> > > +		tot_pop_last += count_dequeuer[4 * i + 3];
> > >  	}
> > >  	
> > > -	test_end(&s, &end_dequeues);
> > > +	test_end(&s, &end_dequeues, &tot_pop_last);
> > > 
> > >  	printf_verbose("total number of enqueues : %llu, dequeues %llu\n",
> > >  		       tot_enqueues, tot_dequeues);
> > >  	printf_verbose("total number of successful enqueues : %llu, "
> > >  		       "enqueues to empty dest : %llu, "
> > >  		       "successful dequeues %llu, "
> > > -		       "pop_all : %llu\n",
> > > +		       "pop_all : %llu, pop_last : %llu\n",
> > >  		       tot_successful_enqueues,
> > >  		       tot_empty_dest_enqueues,
> > >  		       tot_successful_dequeues,
> > > -		       tot_pop_all);
> > > +		       tot_pop_all, tot_pop_last);
> > >  	printf("SUMMARY %-25s testdur %4lu nr_enqueuers %3u wdelay %6lu "
> > >  		"nr_dequeuers %3u "
> > >  		"rdur %6lu nr_enqueues %12llu nr_dequeues %12llu "
> > >  		"successful enqueues %12llu enqueues to empty dest %12llu "
> > >  		"successful dequeues %12llu pop_all %12llu "
> > > -		"end_dequeues %llu nr_ops %12llu\n",
> > > +		"pop_last %llu end_dequeues %llu nr_ops %12llu\n",
> > >  		argv[0], duration, nr_enqueuers, wdelay,
> > >  		nr_dequeuers, rduration, tot_enqueues, tot_dequeues,
> > >  		tot_successful_enqueues,
> > >  		tot_empty_dest_enqueues,
> > > -		tot_successful_dequeues, tot_pop_all, end_dequeues,
> > > +		tot_successful_dequeues, tot_pop_all, tot_pop_last,
> > > +		end_dequeues,
> > >  		tot_enqueues + tot_dequeues);
> > >  	if (tot_successful_enqueues != tot_successful_dequeues + end_dequeues) {
> > >  		printf("WARNING! Discrepancy between nr succ. enqueues %llu vs "
> > > @@ -561,16 +574,14 @@ int main(int argc, char **argv)
> > >  		retval = 1;
> > >  	}
> > >  	/*
> > > -	 * If only using pop_all to dequeue, the enqueuer should see
> > > -	 * exactly as many empty queues than the number of non-empty
> > > -	 * stacks dequeued.
> > > +	 * The enqueuer should see exactly as many empty queues than the
> > > +	 * number of non-empty stacks dequeued.
> > >  	 */
> > > -	if (test_wait_empty && test_pop_all && !test_pop
> > > -			&& tot_empty_dest_enqueues != tot_pop_all) {
> > > +	if (tot_empty_dest_enqueues != tot_pop_last) {
> > >  		printf("WARNING! Discrepancy between empty enqueue (%llu) and "
> > > -			"number of non-empty pop_all (%llu)\n",
> > > +			"number of pop last (%llu)\n",
> > >  			tot_empty_dest_enqueues,
> > > -			tot_pop_all);
> > > +			tot_pop_last);
> > >  		retval = 1;
> > >  	}
> > >  	free(count_enqueuer);
> > > diff --git a/urcu/static/wfcqueue.h b/urcu/static/wfcqueue.h
> > > index 4b3535a..33c99ed 100644
> > > --- a/urcu/static/wfcqueue.h
> > > +++ b/urcu/static/wfcqueue.h
> > > @@ -352,16 +352,23 @@ ___cds_wfcq_next_nonblocking(struct cds_wfcq_head *head,
> > >  static inline struct cds_wfcq_node *
> > >  ___cds_wfcq_dequeue(struct cds_wfcq_head *head,
> > >  		struct cds_wfcq_tail *tail,
> > > +		bool *last,
> > >  		int blocking)
> > >  {
> > >  	struct cds_wfcq_node *node, *next;
> > > 
> > > -	if (_cds_wfcq_empty(head, tail))
> > > +	if (_cds_wfcq_empty(head, tail)) {
> > > +		if (last)
> > > +			*last = 0;
> > >  		return NULL;
> > > +	}
> > > 
> > >  	node = ___cds_wfcq_node_sync_next(&head->node, blocking);
> > > -	if (!blocking && node == CDS_WFCQ_WOULDBLOCK)
> > > +	if (!blocking && node == CDS_WFCQ_WOULDBLOCK) {
> > > +		if (last)
> > > +			*last = 0;
> > >  		return CDS_WFCQ_WOULDBLOCK;
> > > +	}
> > > 
> > >  	if ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
> > >  		/*
> > > @@ -379,8 +386,11 @@ ___cds_wfcq_dequeue(struct cds_wfcq_head *head,
> > >  		 * content.
> > >  		 */
> > >  		_cds_wfcq_node_init(&head->node);
> > > -		if (uatomic_cmpxchg(&tail->p, node, &head->node) == node)
> > > +		if (uatomic_cmpxchg(&tail->p, node, &head->node) == node) {
> > > +			if (last)
> > > +				*last = 1;
> > >  			return node;
> > > +		}
> > >  		next = ___cds_wfcq_node_sync_next(node, blocking);
> > >  		/*
> > >  		 * In nonblocking mode, if we would need to block to
> > > @@ -389,6 +399,8 @@ ___cds_wfcq_dequeue(struct cds_wfcq_head *head,
> > >  		 */
> > >  		if (!blocking && next == CDS_WFCQ_WOULDBLOCK) {
> > >  			head->node.next = node;
> > > +			if (last)
> > > +				*last = 0;
> > >  			return CDS_WFCQ_WOULDBLOCK;
> > >  		}
> > >  	}
> > > @@ -400,6 +412,8 @@ ___cds_wfcq_dequeue(struct cds_wfcq_head *head,
> > > 
> > >  	/* Load q->head.next before loading node's content */
> > >  	cmm_smp_read_barrier_depends();
> > > +	if (last)
> > > +		*last = 0;
> > >  	return node;
> > >  }
> > > 
> > > @@ -414,9 +428,9 @@ ___cds_wfcq_dequeue(struct cds_wfcq_head *head,
> > >   */
> > >  static inline struct cds_wfcq_node *
> > >  ___cds_wfcq_dequeue_blocking(struct cds_wfcq_head *head,
> > > -		struct cds_wfcq_tail *tail)
> > > +		struct cds_wfcq_tail *tail, bool *last)
> > >  {
> > > -	return ___cds_wfcq_dequeue(head, tail, 1);
> > > +	return ___cds_wfcq_dequeue(head, tail, last, 1);
> > >  }
> > > 
> > >  /*
> > > @@ -427,9 +441,9 @@ ___cds_wfcq_dequeue_blocking(struct cds_wfcq_head *head,
> > >   */
> > >  static inline struct cds_wfcq_node *
> > >  ___cds_wfcq_dequeue_nonblocking(struct cds_wfcq_head *head,
> > > -		struct cds_wfcq_tail *tail)
> > > +		struct cds_wfcq_tail *tail, bool *last)
> > >  {
> > > -	return ___cds_wfcq_dequeue(head, tail, 0);
> > > +	return ___cds_wfcq_dequeue(head, tail, last, 0);
> > >  }
> > > 
> > >  /*
> > > @@ -542,12 +556,12 @@ ___cds_wfcq_splice_nonblocking(
> > >   */
> > >  static inline struct cds_wfcq_node *
> > >  _cds_wfcq_dequeue_blocking(struct cds_wfcq_head *head,
> > > -		struct cds_wfcq_tail *tail)
> > > +		struct cds_wfcq_tail *tail, bool *last)
> > >  {
> > >  	struct cds_wfcq_node *retval;
> > > 
> > >  	_cds_wfcq_dequeue_lock(head, tail);
> > > -	retval = ___cds_wfcq_dequeue_blocking(head, tail);
> > > +	retval = ___cds_wfcq_dequeue_blocking(head, tail, last);
> > >  	_cds_wfcq_dequeue_unlock(head, tail);
> > >  	return retval;
> > >  }
> > > diff --git a/urcu/static/wfstack.h b/urcu/static/wfstack.h
> > > index 9bc9519..2ebda27 100644
> > > --- a/urcu/static/wfstack.h
> > > +++ b/urcu/static/wfstack.h
> > > @@ -161,23 +161,35 @@ ___cds_wfs_node_sync_next(struct cds_wfs_node *node, int blocking)
> > > 
> > >  static inline
> > >  struct cds_wfs_node *
> > > -___cds_wfs_pop(struct cds_wfs_stack *s, int blocking)
> > > +___cds_wfs_pop(struct cds_wfs_stack *s, bool *last, int blocking)
> > >  {
> > >  	struct cds_wfs_head *head, *new_head;
> > >  	struct cds_wfs_node *next;
> > > 
> > >  	for (;;) {
> > >  		head = CMM_LOAD_SHARED(s->head);
> > > -		if (___cds_wfs_end(head))
> > > +		if (___cds_wfs_end(head)) {
> > > +			if (last)
> > > +				*last = 0;
> > >  			return NULL;
> > > +		}
> > >  		next = ___cds_wfs_node_sync_next(&head->node, blocking);
> > > -		if (!blocking && next == CDS_WFS_WOULDBLOCK)
> > > +		if (!blocking && next == CDS_WFS_WOULDBLOCK) {
> > > +			if (last)
> > > +				*last = 0;
> > >  			return CDS_WFS_WOULDBLOCK;
> > > +		}
> > >  		new_head = caa_container_of(next, struct cds_wfs_head, node);
> > > -		if (uatomic_cmpxchg(&s->head, head, new_head) == head)
> > > +		if (uatomic_cmpxchg(&s->head, head, new_head) == head) {
> > > +			if (last)
> > > +				*last = ___cds_wfs_end(new_head);
> > >  			return &head->node;
> > > -		if (!blocking)
> > > +		}
> > > +		if (!blocking) {
> > > +			if (last)
> > > +				*last = 0;
> > >  			return CDS_WFS_WOULDBLOCK;
> > > +		}
> > >  		/* busy-loop if head changed under us */
> > >  	}
> > >  }
> > > @@ -200,9 +212,9 @@ ___cds_wfs_pop(struct cds_wfs_stack *s, int blocking)
> > >   */
> > >  static inline
> > >  struct cds_wfs_node *
> > > -___cds_wfs_pop_blocking(struct cds_wfs_stack *s)
> > > +___cds_wfs_pop_blocking(struct cds_wfs_stack *s, bool *last)
> > >  {
> > > -	return ___cds_wfs_pop(s, 1);
> > > +	return ___cds_wfs_pop(s, last, 1);
> > >  }
> > > 
> > >  /*
> > > @@ -213,9 +225,9 @@ ___cds_wfs_pop_blocking(struct cds_wfs_stack *s)
> > >   */
> > >  static inline
> > >  struct cds_wfs_node *
> > > -___cds_wfs_pop_nonblocking(struct cds_wfs_stack *s)
> > > +___cds_wfs_pop_nonblocking(struct cds_wfs_stack *s, bool *last)
> > >  {
> > > -	return ___cds_wfs_pop(s, 0);
> > > +	return ___cds_wfs_pop(s, last, 0);
> > >  }
> > > 
> > >  /*
> > > @@ -284,12 +296,12 @@ static inline void _cds_wfs_pop_unlock(struct cds_wfs_stack *s)
> > >   */
> > >  static inline
> > >  struct cds_wfs_node *
> > > -_cds_wfs_pop_blocking(struct cds_wfs_stack *s)
> > > +_cds_wfs_pop_blocking(struct cds_wfs_stack *s, bool *last)
> > >  {
> > >  	struct cds_wfs_node *retnode;
> > > 
> > >  	_cds_wfs_pop_lock(s);
> > > -	retnode = ___cds_wfs_pop_blocking(s);
> > > +	retnode = ___cds_wfs_pop_blocking(s, last);
> > >  	_cds_wfs_pop_unlock(s);
> > >  	return retnode;
> > >  }
> > > diff --git a/urcu/wfcqueue.h b/urcu/wfcqueue.h
> > > index b6be9f3..4b9e73b 100644
> > > --- a/urcu/wfcqueue.h
> > > +++ b/urcu/wfcqueue.h
> > > @@ -197,7 +197,8 @@ extern bool cds_wfcq_enqueue(struct cds_wfcq_head *head,
> > >   */
> > >  extern struct cds_wfcq_node *cds_wfcq_dequeue_blocking(
> > >  		struct cds_wfcq_head *head,
> > > -		struct cds_wfcq_tail *tail);
> > > +		struct cds_wfcq_tail *tail,
> > > +		bool *last);
> > > 
> > >  /*
> > >   * cds_wfcq_splice_blocking: enqueue all src_q nodes at the end of dest_q.
> > > @@ -229,7 +230,8 @@ extern enum cds_wfcq_ret cds_wfcq_splice_blocking(
> > >   */
> > >  extern struct cds_wfcq_node *__cds_wfcq_dequeue_blocking(
> > >  		struct cds_wfcq_head *head,
> > > -		struct cds_wfcq_tail *tail);
> > > +		struct cds_wfcq_tail *tail,
> > > +		bool *last);
> > > 
> > >  /*
> > >   * __cds_wfcq_dequeue_nonblocking: dequeue a node from a wait-free queue.
> > > @@ -239,7 +241,8 @@ extern struct cds_wfcq_node *__cds_wfcq_dequeue_blocking(
> > >   */
> > >  extern struct cds_wfcq_node *__cds_wfcq_dequeue_nonblocking(
> > >  		struct cds_wfcq_head *head,
> > > -		struct cds_wfcq_tail *tail);
> > > +		struct cds_wfcq_tail *tail,
> > > +		bool *last);
> > > 
> > >  /*
> > >   * __cds_wfcq_splice_blocking: enqueue all src_q nodes at the end of dest_q.
> > > diff --git a/urcu/wfstack.h b/urcu/wfstack.h
> > > index 03fee8f..1e4b848 100644
> > > --- a/urcu/wfstack.h
> > > +++ b/urcu/wfstack.h
> > > @@ -147,7 +147,8 @@ extern int cds_wfs_push(struct cds_wfs_stack *s, struct cds_wfs_node *node);
> > >   *
> > >   * Calls __cds_wfs_pop_blocking with an internal pop mutex held.
> > >   */
> > > -extern struct cds_wfs_node *cds_wfs_pop_blocking(struct cds_wfs_stack *s);
> > > +extern struct cds_wfs_node *cds_wfs_pop_blocking(struct cds_wfs_stack *s,
> > > +		bool *last);
> > > 
> > >  /*
> > >   * cds_wfs_pop_all_blocking: pop all nodes from a stack.
> > > @@ -219,7 +220,8 @@ extern void cds_wfs_pop_unlock(struct cds_wfs_stack *s);
> > >   * 3) Ensuring that only ONE thread can call __cds_wfs_pop_blocking()
> > >   *    and __cds_wfs_pop_all(). (multi-provider/single-consumer scheme).
> > >   */
> > > -extern struct cds_wfs_node *__cds_wfs_pop_blocking(struct cds_wfs_stack *s);
> > > +extern struct cds_wfs_node *__cds_wfs_pop_blocking(struct cds_wfs_stack *s,
> > > +		bool *last);
> > > 
> > >  /*
> > >   * __cds_wfs_pop_nonblocking: pop a node from the stack.
> > > @@ -227,7 +229,8 @@ extern struct cds_wfs_node *__cds_wfs_pop_blocking(struct cds_wfs_stack *s);
> > >   * Same as __cds_wfs_pop_blocking, but returns CDS_WFS_WOULDBLOCK if
> > >   * it needs to block.
> > >   */
> > > -extern struct cds_wfs_node *__cds_wfs_pop_nonblocking(struct cds_wfs_stack *s);
> > > +extern struct cds_wfs_node *__cds_wfs_pop_nonblocking(struct cds_wfs_stack *s,
> > > +		bool *last);
> > > 
> > >  /*
> > >   * __cds_wfs_pop_all: pop all nodes from a stack.
> > > diff --git a/wfcqueue.c b/wfcqueue.c
> > > index ab0eb93..7baefdf 100644
> > > --- a/wfcqueue.c
> > > +++ b/wfcqueue.c
> > > @@ -68,9 +68,10 @@ void cds_wfcq_dequeue_unlock(struct cds_wfcq_head *head,
> > > 
> > >  struct cds_wfcq_node *cds_wfcq_dequeue_blocking(
> > >  		struct cds_wfcq_head *head,
> > > -		struct cds_wfcq_tail *tail)
> > > +		struct cds_wfcq_tail *tail,
> > > +		bool *last)
> > >  {
> > > -	return _cds_wfcq_dequeue_blocking(head, tail);
> > > +	return _cds_wfcq_dequeue_blocking(head, tail, last);
> > >  }
> > > 
> > >  enum cds_wfcq_ret cds_wfcq_splice_blocking(
> > > @@ -85,16 +86,18 @@ enum cds_wfcq_ret cds_wfcq_splice_blocking(
> > > 
> > >  struct cds_wfcq_node *__cds_wfcq_dequeue_blocking(
> > >  		struct cds_wfcq_head *head,
> > > -		struct cds_wfcq_tail *tail)
> > > +		struct cds_wfcq_tail *tail,
> > > +		bool *last)
> > >  {
> > > -	return ___cds_wfcq_dequeue_blocking(head, tail);
> > > +	return ___cds_wfcq_dequeue_blocking(head, tail, last);
> > >  }
> > > 
> > >  struct cds_wfcq_node *__cds_wfcq_dequeue_nonblocking(
> > >  		struct cds_wfcq_head *head,
> > > -		struct cds_wfcq_tail *tail)
> > > +		struct cds_wfcq_tail *tail,
> > > +		bool *last)
> > >  {
> > > -	return ___cds_wfcq_dequeue_nonblocking(head, tail);
> > > +	return ___cds_wfcq_dequeue_nonblocking(head, tail, last);
> > >  }
> > > 
> > >  enum cds_wfcq_ret __cds_wfcq_splice_blocking(
> > > diff --git a/wfstack.c b/wfstack.c
> > > index 4ccb6b9..041703b 100644
> > > --- a/wfstack.c
> > > +++ b/wfstack.c
> > > @@ -48,9 +48,10 @@ int cds_wfs_push(struct cds_wfs_stack *s, struct cds_wfs_node *node)
> > >  	return _cds_wfs_push(s, node);
> > >  }
> > > 
> > > -struct cds_wfs_node *cds_wfs_pop_blocking(struct cds_wfs_stack *s)
> > > +struct cds_wfs_node *cds_wfs_pop_blocking(struct cds_wfs_stack *s,
> > > +		bool *last)
> > >  {
> > > -	return _cds_wfs_pop_blocking(s);
> > > +	return _cds_wfs_pop_blocking(s, last);
> > >  }
> > > 
> > >  struct cds_wfs_head *cds_wfs_pop_all_blocking(struct cds_wfs_stack *s)
> > > @@ -83,14 +84,16 @@ void cds_wfs_pop_unlock(struct cds_wfs_stack *s)
> > >  	_cds_wfs_pop_unlock(s);
> > >  }
> > > 
> > > -struct cds_wfs_node *__cds_wfs_pop_blocking(struct cds_wfs_stack *s)
> > > +struct cds_wfs_node *__cds_wfs_pop_blocking(struct cds_wfs_stack *s,
> > > +		bool *last)
> > >  {
> > > -	return ___cds_wfs_pop_blocking(s);
> > > +	return ___cds_wfs_pop_blocking(s, last);
> > >  }
> > > 
> > > -struct cds_wfs_node *__cds_wfs_pop_nonblocking(struct cds_wfs_stack *s)
> > > +struct cds_wfs_node *__cds_wfs_pop_nonblocking(struct cds_wfs_stack *s,
> > > +		bool *last)
> > >  {
> > > -	return ___cds_wfs_pop_nonblocking(s);
> > > +	return ___cds_wfs_pop_nonblocking(s, last);
> > >  }
> > > 
> > >  struct cds_wfs_head *__cds_wfs_pop_all(struct cds_wfs_stack *s)
> > > 
> > > -- 
> > > Mathieu Desnoyers
> > > Operating System Efficiency R&D Consultant
> > > EfficiOS Inc.
> > > http://www.efficios.com
> > > 
> > 
> 
> -- 
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> rp mailing list
> rp@svcs.cs.pdx.edu
> http://svcs.cs.pdx.edu/mailman/listinfo/rp
> 
