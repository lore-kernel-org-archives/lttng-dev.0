From: Ben Maurer <bmaurer@fb.com>
Subject: Re: Userspace RCU: workqueue with batching, cheap wakeup,
 and work stealing
Date: Thu, 23 Oct 2014 22:09:11 +0000
Message-ID: <5CDDBDF2D36D9F43B9F5E99003F6A0D4861C3F96__7544.02000825412$1414105235$gmane$org@PRN-MBX02-1.TheFacebook.com>
References: <836028170.11148.1413630118955.JavaMail.zimbra@efficios.com>
 <1521253780.11371.1413666790992.JavaMail.zimbra@efficios.com>
 <54478D8E.1080608@cn.fujitsu.com>
 <1569300159.298.1413976834389.JavaMail.zimbra@efficios.com>
 <54488392.2030008@cn.fujitsu.com> <5448CA38.2010801@cn.fujitsu.com>
 <984401415.431.1414071012829.JavaMail.zimbra@efficios.com>
 <1736995491.608.1414081381945.JavaMail.zimbra@efficios.com>,
 <1650317292.810.1414101428789.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=5373f15c10=bmaurer@fb.com>) id 1XhQZO-0004RI-Cs
 for lttng-dev@lists.lttng.org; Thu, 23 Oct 2014 18:09:27 -0400
In-Reply-To: <1650317292.810.1414101428789.JavaMail.zimbra@efficios.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: Yannick Brosseau <yannick.brosseau@fb.com>, lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

Bounds are pretty critical :-), often during operational incidents we will get large buildups in our queues and these cause problems.

For us, one of the most critical things isn't the memory usage but the delay caused to the client. For example, if a server has a queue that incoming requests are put into if that queue grows large clients experience large delays. Since most calls to the server have a short timeout (seconds), we'd rather prevent items from entering the queue so that we fail fast.

Some of our applications switch to LIFO processing of work items when the queue is large. What this does is to focus the processing effort on recent requests -- ones which will hopefully get back to the user in time for them to see a response.

Long story short: when a queue is overloaded, we'd rather drop some requests quickly and serve the other requests with minimal queuing delay. Think of queues as bufferbloat applied to work items. In fact, we have experimented with some of the bufferbloat techniques on our work queues (specifically, CoDEL)

-b
________________________________________
From: Mathieu Desnoyers [mathieu.desnoyers@efficios.com]
Sent: Thursday, October 23, 2014 2:57 PM
To: Lai Jiangshan
Cc: lttng-dev; Paul E. McKenney; Ben Maurer; Yannick Brosseau
Subject: Re: [lttng-dev] Userspace RCU: workqueue with batching, cheap wakeup, and work stealing

The next thing I'm wondering now: should we include an
optional bound to the global workqueue size in the API ?

I've just had cases here where I stress test the queue
with very frequent dispatch, and it can fill up memory
relatively quickly if the workers have a large amount of
work to do per work-item.

I think the usual way to do this would be to make the
behavior nonblocking when the queue is full, so the
dispatcher can take action and move the work away to
another machine, or report congestion.

Thoughts ?

Thanks,

Mathieu

--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
