From: "Emilio G. Cota" <cota@braap.org>
Subject: [urcu][PATCH] trivial: urcu-pointer.h:
	s/rcu_dereference_pointer/rcu_dereference/
Date: Tue,  3 Feb 2015 12:53:46 -0500
Message-ID: <1422986026-32124-1-git-send-email-cota__47832.0160219029$1422986016$gmane$org@braap.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <cota@braap.org>) id 1YIheg-0007hJ-AI
 for lttng-dev@lists.lttng.org; Tue, 03 Feb 2015 12:53:00 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 7AA93210C7
 for <lttng-dev@lists.lttng.org>; Tue,  3 Feb 2015 12:52:46 -0500 (EST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 urcu/static/urcu-pointer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/urcu/static/urcu-pointer.h b/urcu/static/urcu-pointer.h
index 4361156..a5b3e4b 100644
--- a/urcu/static/urcu-pointer.h
+++ b/urcu/static/urcu-pointer.h
@@ -122,21 +122,21 @@ extern "C" {
 /**
  * _rcu_assign_pointer - assign (publicize) a pointer to a new data structure
  * meant to be read by RCU read-side critical sections. Returns the assigned
  * value.
  *
  * Documents which pointers will be dereferenced by RCU read-side critical
  * sections and adds the required memory barriers on architectures requiring
  * them. It also makes sure the compiler does not reorder code initializing the
  * data structure before its publication.
  *
- * Should match rcu_dereference_pointer().
+ * Should match rcu_dereference().
  *
  * This macro is less than 10 lines long.  The intent is that this macro
  * meets the 10-line criterion in LGPL, allowing this function to be
  * expanded directly in non-LGPL code.
  */
 #define _rcu_assign_pointer(p, v)	_rcu_set_pointer(&(p), v)
 
 #ifdef __cplusplus 
 }
 #endif
-- 
1.8.3
