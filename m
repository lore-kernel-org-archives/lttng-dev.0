From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH urcu 1/2] Fix: CDS_WFCQ_WOULDBLOCK typing
	for c++
Date: Mon,  7 Mar 2016 19:33:43 -0500
Message-ID: <1457397224-10952-1-git-send-email-mathieu.desnoyers__20912.7845046625$1457397311$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ad5b1-0002tK-W2
 for lttng-dev@lists.lttng.org; Mon, 07 Mar 2016 19:33:58 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <jiangshanlai@gmail.com>, rp@svcs.cs.pdx.edu
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 urcu/wfcqueue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/urcu/wfcqueue.h b/urcu/wfcqueue.h
index 83ec219..c0bb289 100644
--- a/urcu/wfcqueue.h
+++ b/urcu/wfcqueue.h
@@ -43,7 +43,7 @@ extern "C" {
  * McKenney.
  */
 
-#define CDS_WFCQ_WOULDBLOCK	((void *) -1UL)
+#define CDS_WFCQ_WOULDBLOCK	((struct cds_wfcq_node *) -1UL)
 
 enum cds_wfcq_ret {
 	CDS_WFCQ_RET_WOULDBLOCK =	-1,
-- 
2.1.4
