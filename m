From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [URCU PATCH 0/3] wait-free concurrent queues (wfcqueue)
Date: Tue, 2 Oct 2012 10:13:07 -0400
Message-ID: <20121002141307.GA4057__21580.9988476851$1349187245$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TJ3Dh-0001yd-J0
	for lttng-dev@lists.lttng.org; Tue, 02 Oct 2012 10:13:09 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul McKenney <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <eag0628@gmail.com>, rp@svcs.cs.pdx.edu, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Implement wait-free concurrent queues, with a new API different from
wfqueue.h, which is already provided by Userspace RCU. The advantage of
splitting the head and tail objects of the queue into different
arguments is to allow these to sit on different cache-lines, thus
eliminating false-sharing, leading to a 2.3x speed increase.

This API also introduces a "splice" operation, which moves all nodes
from one queue into another, and postpones the synchronization to either
dequeue or iteration on the list. The splice operation does not need to
touch every single node of the queue it moves them from. Moreover, the
splice operation only needs to ensure mutual exclusion with other
dequeuers, iterations, and splice operations from the list it splices
from, but acts as a simple enqueuer on the list it splices into (no
mutual exclusion needed for that list).

Feedback is welcome,

Thanks!

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
