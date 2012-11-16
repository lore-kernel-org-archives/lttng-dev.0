From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH] wfcqueue: Fix lock and unlock functions
Date: Thu, 15 Nov 2012 16:24:12 -0800
Message-ID: <20121116002412.GA32432__47873.6036377542$1353025517$gmane$org@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paulmck@linux.vnet.ibm.com>) id 1TZ9jM-0008F3-7u
	for lttng-dev@lists.lttng.org; Thu, 15 Nov 2012 19:24:24 -0500
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 15 Nov 2012 17:24:17 -0700
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 5E0483E4003F
	for <lttng-dev@lists.lttng.org>; Thu, 15 Nov 2012 17:24:13 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	qAG0OEPe238528
	for <lttng-dev@lists.lttng.org>; Thu, 15 Nov 2012 17:24:14 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id qAG0ODYw009738
	for <lttng-dev@lists.lttng.org>; Thu, 15 Nov 2012 17:24:14 -0700
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: eag0628@gmail.com, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

The current implementation of cds_wfcq_dequeue_lock() and
cds_wfcq_dequeue_unlock() entails mutually assured recursion.
Redirect to _cds_wfcq_dequeue_lock() and _cds_wfcq_dequeue_unlock(),
respectively.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/wfcqueue.c b/wfcqueue.c
index 3474ee0..90b810e 100644
--- a/wfcqueue.c
+++ b/wfcqueue.c
@@ -57,13 +57,13 @@ void cds_wfcq_enqueue(struct cds_wfcq_head *head,
 void cds_wfcq_dequeue_lock(struct cds_wfcq_head *head,
 		struct cds_wfcq_tail *tail)
 {
-	cds_wfcq_dequeue_lock(head, tail);
+	_cds_wfcq_dequeue_lock(head, tail);
 }
 
 void cds_wfcq_dequeue_unlock(struct cds_wfcq_head *head,
 		struct cds_wfcq_tail *tail)
 {
-	cds_wfcq_dequeue_unlock(head, tail);
+	_cds_wfcq_dequeue_unlock(head, tail);
 }
 
 struct cds_wfcq_node *cds_wfcq_dequeue_blocking(
