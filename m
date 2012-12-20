From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: [PATCH 1/2] urcu: fix comments for
	cds_list_for_each_prev()
Date: Thu, 20 Dec 2012 18:29:32 +0800
Message-ID: <1355999373-1407-1-git-send-email-laijs__38147.3185298548$1355999420$gmane$org@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1TldNg-0005yQ-6S
	for lttng-dev@lists.lttng.org; Thu, 20 Dec 2012 05:29:36 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
---
 urcu/list.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/urcu/list.h b/urcu/list.h
index f27ff7b..5d04394 100644
--- a/urcu/list.h
+++ b/urcu/list.h
@@ -141,7 +141,7 @@ cds_list_splice (struct cds_list_head *add, struct cds_list_head *head)
   for (pos = (head)->next; pos != (head); pos = pos->next)
 
 
-/* Iterate forward over the elements of the list.  */
+/* Iterate backward over the elements of the list.  */
 #define cds_list_for_each_prev(pos, head) \
   for (pos = (head)->prev; pos != (head); pos = pos->prev)
 
-- 
1.7.4.4
