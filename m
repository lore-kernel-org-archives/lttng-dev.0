From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [URCU PATCH 1/3] wfcqueue:
	implement	concurrency-efficient queue
Date: Wed, 10 Oct 2012 00:50:12 -0400
Message-ID: <20121010045012.GA32082__3637.36314834586$1349844650$gmane$org@Krystal>
References: <20121002141307.GA4057@Krystal> <20121002141444.GB4057@Krystal>
	<5074E3F5.3080005@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TLoFK-0007QM-Pe
	for lttng-dev@lists.lttng.org; Wed, 10 Oct 2012 00:50:14 -0400
Content-Disposition: inline
In-Reply-To: <5074E3F5.3080005@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: Lai Jiangshan <eag0628@gmail.com>, lttng-dev@lists.lttng.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> On 10/02/2012 10:14 PM, Mathieu Desnoyers wrote:
[...]
> > --- /dev/null
> > +++ b/urcu/wfcqueue.h
> > @@ -0,0 +1,263 @@
> > +#ifndef _URCU_WFCQUEUE_H
> > +#define _URCU_WFCQUEUE_H
> > +
> > +/*
> > + * wfcqueue.h
> > + *
> > + * Userspace RCU library - Concurrent Queue with Wait-Free Enqueue/Blocking Dequeue
> > + *
> > + * Copyright 2010-2012 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > + * Copyright 2011-2012 - Lai Jiangshan <laijs@cn.fujitsu.com>
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2.1 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, write to the Free Software
> > + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> > + */
> > +
> > +#include <pthread.h>
> > +#include <assert.h>
> > +#include <stdbool.h>
> > +#include <urcu/compiler.h>
> > +#include <urcu/arch.h>
> > +
> > +#ifdef __cplusplus
> > +extern "C" {
> > +#endif
> > +
> > +/*
> > + * Concurrent queue with wait-free enqueue/blocking dequeue.
> > + *
> > + * Inspired from half-wait-free/half-blocking queue implementation done by
> > + * Paul E. McKenney.
> > + */
> > +
> > +struct cds_wfcq_node {
> > +	struct cds_wfcq_node *next;
> > +};
> > +
> > +/*
> > + * Do not put head and tail on the same cache-line if concurrent
> > + * enqueue/dequeue are expected from many CPUs. This eliminates
> > + * false-sharing between enqueue and dequeue.
> > + */
> > +struct cds_wfcq_head {
> > +	struct cds_wfcq_node node;
> > +	pthread_mutex_t lock;
> > +};
> > +
> > +struct cds_wfcq_tail {
> > +	struct cds_wfcq_node *p;
> > +};
> 
> Why use "p" here?

For lack of imagination. ;)  Do you have something better to propose ?

> 
> I don't see the commits in the public git-tree. Or you forgot to update the
> tree and make "http" address happy.

I have pushed those into the userspace RCU master branch a couple of
days after posting them to the mailing lists. I just synchronized my
urcu/wfcqueue volatile dev branch, but I expect to drop it soon, since
it's now merged back into master.

Thanks!

Mathieu

> 
> Thanks,
> Lai

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
