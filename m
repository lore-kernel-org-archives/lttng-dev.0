From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: [PATCH 2/2] rculfhash: add cds_lfht_replace to the
	write operations in the comments
Date: Thu, 20 Dec 2012 18:29:33 +0800
Message-ID: <1355999373-1407-2-git-send-email-laijs__15829.9692477614$1355999432$gmane$org@cn.fujitsu.com>
References: <1355999373-1407-1-git-send-email-laijs@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1TldNl-0005yQ-QS
	for lttng-dev@lists.lttng.org; Thu, 20 Dec 2012 05:29:55 -0500
In-Reply-To: <1355999373-1407-1-git-send-email-laijs@cn.fujitsu.com>
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
 rculfhash.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/rculfhash.c b/rculfhash.c
index 7050d5c..3650ed3 100644
--- a/rculfhash.c
+++ b/rculfhash.c
@@ -129,7 +129,7 @@
  *  - cds_lfht_first followed iteration with cds_lfht_next (and/or
  *    cds_lfht_next_duplicate, although less common).
  *
- * We define "write" operations as any of cds_lfht_add,
+ * We define "write" operations as any of cds_lfht_add, cds_lfht_replace,
  * cds_lfht_add_unique (success), cds_lfht_add_replace, cds_lfht_del.
  *
  * When cds_lfht_add_unique succeeds (returns the node passed as
-- 
1.7.4.4
