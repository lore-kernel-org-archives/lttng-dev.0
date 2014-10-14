From: "Emilio G. Cota" <cota@braap.org>
Subject: [urcu][RFC][PATCH] lfstack,
	wfcqueue: do not pass NULL as value to atomic_xchg
Date: Mon, 13 Oct 2014 22:31:25 -0400
Message-ID: <1413253885-7187-1-git-send-email-cota__1495.03177167407$1413253972$gmane$org@braap.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <cota@braap.org>) id 1Xdru6-0007Mu-PS
 for lttng-dev@lists.lttng.org; Mon, 13 Oct 2014 22:32:03 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by gateway2.nyi.internal (Postfix) with ESMTP id 5D0652103D
 for <lttng-dev@lists.lttng.org>; Mon, 13 Oct 2014 22:31:55 -0400 (EDT)
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

atomic_xchg expects a pointer and a value. The value is sign
extended to unsigned long, and the sign is obtained from

  #define caa_is_signed_type(type)        ((type) -1 < (type) 0)

If -Wextra is enabled, gcc then throws an "ordered comparison
of pointer and null pointer" warning when the value passed to
atomic_xchg is NULL.

The appended is just a quick fix that doesn't fix the real issue.
For this I tried a few things, and the simplest change is to
just do an unconditional cast to unsigned long. This seems to work
for me but I must be missing something--FWIW here's a test program:
  https://gist.github.com/cota/9ff275d4dddde302cade

Note that Mathieu worked on this in the past. See commit
  4b5f005 gcc warning fixes: -Wsign-compare and -Wextra

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 urcu/static/lfstack.h  | 2 +-
 urcu/static/wfcqueue.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/urcu/static/lfstack.h b/urcu/static/lfstack.h
index 63af91a..32076ab 100644
--- a/urcu/static/lfstack.h
+++ b/urcu/static/lfstack.h
@@ -237,7 +237,7 @@ struct cds_lfs_head *___cds_lfs_pop_all(cds_lfs_stack_ptr_t u_s)
 	 * taking care to order writes to each node prior to the full
 	 * memory barrier after this uatomic_xchg().
 	 */
-	return uatomic_xchg(&s->head, NULL);
+	return uatomic_xchg(&s->head, 0);
 }
 
 /*
diff --git a/urcu/static/wfcqueue.h b/urcu/static/wfcqueue.h
index 48b2625..deddc5f 100644
--- a/urcu/static/wfcqueue.h
+++ b/urcu/static/wfcqueue.h
@@ -518,7 +518,7 @@ ___cds_wfcq_splice(
 		 * uatomic_xchg, as well as tail pointer vs head node
 		 * address.
 		 */
-		head = uatomic_xchg(&src_q_head->node.next, NULL);
+		head = uatomic_xchg(&src_q_head->node.next, 0);
 		if (head)
 			break;	/* non-empty */
 		if (CMM_LOAD_SHARED(src_q_tail->p) == &src_q_head->node)
-- 
1.8.3
