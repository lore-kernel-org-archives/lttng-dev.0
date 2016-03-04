From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Horrible hack to make C++ link to liburcu
Date: Fri, 4 Mar 2016 12:32:54 -0800
Message-ID: <20160304203254.GA2033__38167.4626762562$1457124801$gmane$org@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e35.co.us.ibm.com ([32.97.110.153])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <paulmck@linux.vnet.ibm.com>) id 1abwhs-00039r-G8
 for lttng-dev@lists.lttng.org; Fri, 04 Mar 2016 15:52:17 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 13:52:10 -0700
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 6EB1E1FF0023
 for <lttng-dev@lists.lttng.org>; Fri,  4 Mar 2016 13:40:18 -0700 (MST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u24Kq8nI17236040
 for <lttng-dev@lists.lttng.org>; Fri, 4 Mar 2016 20:52:08 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u24Kq8ja007069
 for <lttng-dev@lists.lttng.org>; Fri, 4 Mar 2016 15:52:08 -0500
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jiangshanlai@gmail.com
List-Id: lttng-dev@lists.lttng.org

Hello!

Still working with the C++ standards committee to add RCU to C++, and
of course one step on that path is to make C++ programs build against
liburcu.  The following hack-patch makes this work by disabling C++ access
to wfcqueue and by making C++ see the rcu_head ->next field as a void *.

This supports prototyping, but what would be the real fix?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/urcu-call-rcu.h b/urcu-call-rcu.h
index 339ebacc3f7c..d37c49e9d958 100644
--- a/urcu-call-rcu.h
+++ b/urcu-call-rcu.h
@@ -32,7 +32,9 @@
 #include <stdlib.h>
 #include <pthread.h>
 
+#ifndef __cplusplus
 #include <urcu/wfcqueue.h>
+#endif
 
 #ifdef __cplusplus
 extern "C" {
@@ -57,7 +59,11 @@ struct call_rcu_data;
  */
 
 struct rcu_head {
+#ifdef __cplusplus
+	void *next;
+#else
 	struct cds_wfcq_node next;
+#endif
 	void (*func)(struct rcu_head *head);
 };
