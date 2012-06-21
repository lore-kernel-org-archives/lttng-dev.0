From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC] Userspace RCU library internal error handling
Date: Thu, 21 Jun 2012 12:41:13 -0400
Message-ID: <20120621164113.GA21197__25441.8559525677$1340297205$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1ShkRW-0008L3-Vf
	for lttng-dev@lists.lttng.org; Thu, 21 Jun 2012 12:41:14 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

Hi,

Currently, liburcu calls "exit(-1)" upon internal consistency error.
This is not pretty, and usually frowned upon in libraries.

One example of failure path where we use this is if pthread_mutex_lock()
would happen to fail within synchronize_rcu(). Clearly, this should
_never_ happen: it would typically be triggered only by memory
corruption (or other terrible things like that). That being said, we
clearly don't want to make "synchronize_rcu()" return errors like that
to the application, because it would complexify the application error
handling needlessly.

So instead of calling exit(-1), one possibility would be to do something
like this:

#include <signal.h>
#include <pthread.h>
#include <stdio.h>

#define urcu_die(fmt, ...)                      \
        do {    \
                fprintf(stderr, fmt, ##__VA_ARGS__);    \
                (void) pthread_kill(pthread_self(), SIGBUS);    \
        } while (0)

and call urcu_die(); in those "unrecoverable error" cases, instead of
calling exit(-1). Therefore, if an application chooses to trap those
signals, it can, which is otherwise not possible with a direct call to
exit().

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
