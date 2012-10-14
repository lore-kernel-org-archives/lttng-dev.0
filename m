From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: urcu stack and queues updates and documentation
Date: Sun, 14 Oct 2012 13:53:32 -0400
Message-ID: <20121014175332.GA2947__16703.6473787904$1350237248$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TNSNa-0000zv-MT
	for lttng-dev@lists.lttng.org; Sun, 14 Oct 2012 13:53:34 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Paul!

I know you are currently looking at documentation of urcu data
structures. I did quite a bit of work in that area these past days. Here
is my plan:

1) I would like to deprecate, at some point, rculfqueue, wfqueue, and
   rculfstack.

2) For wfqueue, we replace it by wfcqueue, currently in the urcu master
   branch.

3) For rculfstack, we replace it by lfstack available here (volatile
   branch):

git://git.dorsal.polymtl.ca/~compudj/userspace-rcu
branch: urcu/lfstack

4) I did documentation improvements (and implemented pop_all as well as
   empty, and iterators) for wfstack here (volatile branch too):

git://git.dorsal.polymtl.ca/~compudj/userspace-rcu
branch: urcu/wfstack

5) The last one to look into would be rculfqueue. I'd really like to
   create a lfcqueue derived from wfcqueue if possible. It's the next
   item on my todo list this weekend.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
