From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC] adding into middle of RCU list
Date: Thu, 22 Aug 2013 21:33:18 -0700
Message-ID: <20130822213318.49a57fa2__49478.7789219574$1377268241$gmane$org@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <stephen@networkplumber.org>) id 1VCj3v-0001sp-LA
	for lttng-dev@lists.lttng.org; Fri, 23 Aug 2013 00:33:31 -0400
Received: by mail-pb0-f53.google.com with SMTP id up15so184799pbc.12
	for <lttng-dev@lists.lttng.org>; Thu, 22 Aug 2013 21:33:22 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

I needed to add into the middle of an RCU list, does this make sense.



From a45892b0d49ac5fe449ba7e19c646cb17f7cee57 Mon Sep 17 00:00:00 2001
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Thu, 22 Aug 2013 21:27:04 -0700
Subject: [PATCH] Add list_splice_init_rcu to allow insertion into a RCU list

Simplified version of the version in kernel.
---
 urcu/rculist.h |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/urcu/rculist.h b/urcu/rculist.h
index 1fd2df3..2e8a5a0 100644
--- a/urcu/rculist.h
+++ b/urcu/rculist.h
@@ -72,6 +72,38 @@ void cds_list_del_rcu(struct cds_list_head *elem)
 	CMM_STORE_SHARED(elem->prev->next, elem->next);
 }
 
+
+/**
+ * Splice an RCU-protected list into an existing list.
+ *
+ * Note that this function blocks in synchronize_rcu()
+ *
+ * Important note: this function is not called concurrently
+ *       with other updates to the list.
+ */
+static inline void caa_list_splice_init_rcu(struct cds_list_head *list,
+					    struct cds_list_head *head)
+{
+	struct cds_list_head *first = list->next;
+	struct cds_list_head *last = list->prev;
+	struct cds_list_head *at = head->next;
+
+	if (cds_list_empty(list))
+		return;
+
+	/* "first" and "last" tracking list, so initialize it. */
+	CDS_INIT_LIST_HEAD(list);
+
+	/* Wait for any readers to finish using the list before splicing */
+	synchronize_rcu();
+
+	/* Readers are finished with the source list, so perform splice. */
+	last->next = at;
+	rcu_assign_pointer(head->next, first);
+	first->prev = head;
+	at->prev = last;
+}
+
 /*
  * Iteration through all elements of the list must be done while rcu_read_lock()
  * is held.
-- 
1.7.10.4
