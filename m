From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [rp] [RFC] Userspace RCU library internal error
	handling
Date: Thu, 21 Jun 2012 11:59:42 -0700
Message-ID: <20120621185941.GC26361__24029.8669822097$1340305222$gmane$org@leaf>
References: <20120621164113.GA21197@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <josh@joshtriplett.org>) id 1Shmbj-0000ui-4q
	for lttng-dev@lists.lttng.org; Thu, 21 Jun 2012 14:59:55 -0400
Content-Disposition: inline
In-Reply-To: <20120621164113.GA21197@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rp@svcs.cs.pdx.edu, lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

On Thu, Jun 21, 2012 at 12:41:13PM -0400, Mathieu Desnoyers wrote:
> Currently, liburcu calls "exit(-1)" upon internal consistency error.
> This is not pretty, and usually frowned upon in libraries.

Agreed.

> One example of failure path where we use this is if pthread_mutex_lock()
> would happen to fail within synchronize_rcu(). Clearly, this should
> _never_ happen: it would typically be triggered only by memory
> corruption (or other terrible things like that). That being said, we
> clearly don't want to make "synchronize_rcu()" return errors like that
> to the application, because it would complexify the application error
> handling needlessly.

I think you can safely ignore any error conditions you know you can't
trigger.  pthread_mutex_lock can only return an error under two
conditions: an uninitialized mutex, or an error-checking mutex already
locked by the current thread.  Neither of those can happen in this case.
Given that, I'd suggest either calling pthread_mutex_lock and ignoring
any possibility of error, or adding an assert.

> So instead of calling exit(-1), one possibility would be to do something
> like this:
> 
> #include <signal.h>
> #include <pthread.h>
> #include <stdio.h>
> 
> #define urcu_die(fmt, ...)                      \
>         do {    \
>                 fprintf(stderr, fmt, ##__VA_ARGS__);    \
>                 (void) pthread_kill(pthread_self(), SIGBUS);    \
>         } while (0)
> 
> and call urcu_die(); in those "unrecoverable error" cases, instead of
> calling exit(-1). Therefore, if an application chooses to trap those
> signals, it can, which is otherwise not possible with a direct call to
> exit().

It looks like you want to use signals as a kind of exception mechanism,
to allow the application to clean up (though not to recover).  assert
seems much clearer to me for "this can't happen" cases, and assert also
generates a signal that the application can catch and clean up.

- Josh Triplett
