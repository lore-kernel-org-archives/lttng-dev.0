From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [urcu commit] list: implement cds_list_for_each_safe()
Date: Wed, 13 Mar 2013 12:30:30 -0400
Message-ID: <20130313163030.GA17870__683.351411908184$1363192282$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UFoZV-0004To-Tn
	for lttng-dev@lists.lttng.org; Wed, 13 Mar 2013 12:30:33 -0400
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

commit 7e5b9a4d1a4a63fac405ed74c42f93abdc223794
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Wed Mar 13 12:23:11 2013 -0400

    list: implement cds_list_for_each_safe()
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

diff --git a/urcu/list.h b/urcu/list.h
index 5d04394..1d1c7b5 100644
--- a/urcu/list.h
+++ b/urcu/list.h
@@ -140,12 +140,17 @@ cds_list_splice (struct cds_list_head *add, struct cds_list_head *head)
 #define cds_list_for_each(pos, head) \
   for (pos = (head)->next; pos != (head); pos = pos->next)
 
+/* Iterate forward over the elements list. The list elements can be
+   removed from the list while doing this.  */
+#define cds_list_for_each_safe(pos, p, head) \
+  for (pos = (head)->next, p = pos->next; \
+       pos != (head); \
+       pos = p, p = pos->next)
 
 /* Iterate backward over the elements of the list.  */
 #define cds_list_for_each_prev(pos, head) \
   for (pos = (head)->prev; pos != (head); pos = pos->prev)
 
-
 /* Iterate backwards over the elements list.  The list elements can be
    removed from the list while doing this.  */
 #define cds_list_for_each_prev_safe(pos, p, head) \

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
