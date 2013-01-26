From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [COMMIT urcu] doc/cds-api.txt: expand documentation
Date: Sat, 26 Jan 2013 10:57:31 -0500
Message-ID: <20130126155731.GA20955__14692.7126138054$1359215908$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Tz88L-0003c4-Vd
	for lttng-dev@lists.lttng.org; Sat, 26 Jan 2013 10:57:34 -0500
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

Expand explanations, reorder items to have all wait-free descriptions
first, so that the rculfqueue API comes last, since it is less
featureful and is the only API of the queues/stacks to actually rely on
RCU.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/doc/cds-api.txt b/doc/cds-api.txt
index 81d511c..8896e20 100644
--- a/doc/cds-api.txt
+++ b/doc/cds-api.txt
@@ -28,28 +28,36 @@ urcu/rcuhlist.h:
 	for implementing hash tables. Downside over rculist.h: lookup of
 	tail in O(n).
 
-urcu/rculfqueue.h:
+urcu/wfstack.h:
 
-	RCU queue with lock-free enqueue, lock-free dequeue. RCU used to
-	provide existance guarantees.
+	Stack with wait-free push and wait-free pop_all. Both blocking
+	and non-blocking pop and traversal operations are provided.
+	This stack does _not_ specifically rely on RCU.
+	Various synchronization techniques can be used to deal with
+	pop ABA. Those are detailed in the API.
 
 urcu/wfcqueue.h:
 
-	Concurrent queue with wait-free enqueue, blocking traversal.
-	This queue does _not_ use RCU.
+	Concurrent queue with wait-free enqueue. Both blocking and
+	non-blocking dequeue, splice (move all elements from one queue
+	to another), and traversal operations are provided.
+	This queue does _not_ specifically rely on RCU. Mutual exclusion
+	is used to protect dequeue, splice (from source queue) and
+	traversal (see API for details).
 	(note: deprecates urcu/wfqueue.h)
 
 urcu/lfstack.h:
 
-	RCU stack with lock-free push, lock-free dequeue. Various
-	synchronization techniques can be used to deal with "pop" ABA.
-	Those are detailed in the API.
+	Stack with lock-free push, lock-free pop, wait-free pop_all,
+	wait-free traversal. Various synchronization techniques can be
+	used to deal with pop ABA. Those are detailed in the API.
+	This stack does _not_ specifically rely on RCU.
 	(note: deprecates urcu/rculfstack.h)
 
-urcu/wfstack.h:
+urcu/rculfqueue.h:
 
-	Stack with wait-free enqueue, blocking dequeue. This stack does
-	_not_ use RCU.
+	RCU queue with lock-free enqueue, lock-free dequeue.
+	This queue relies on RCU for existence guarantees.
 
 urcu/rculfhash.h:
 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
