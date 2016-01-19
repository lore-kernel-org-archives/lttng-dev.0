From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH urcu] urcu_ref_get: API change: return
	boolean
Date: Tue, 19 Jan 2016 15:57:39 -0500
Message-ID: <1453237059-8879-1-git-send-email-mathieu.desnoyers__24597.8249855854$1453237143$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1aLdLo-0002hq-Ip
 for lttng-dev@lists.lttng.org; Tue, 19 Jan 2016 15:58:09 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: rp@svcs.cs.pdx.edu, Lai Jiangshan <jiangshanlai@gmail.com>, Chris Mason <clm@fb.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a RFC of a follow up patch based on urcu commit 7d7c5d467 "Fix:
handle reference count overflow".

Change the urcu_ref_get prototype to return a boolean, which takes the
value false if a LONG_MAX overflow would occur (get has not been
performed), or true otherwise.

This interface change also introduces a "warn_unused_result" gcc
function attribute, which will show warnings if users don't handle the
return value.

I'm wondering whether this change is useful enough to justify breaking
the API (need to bump the major library version), or if introducing a
new "urcu_ref_get_safe()" or such would be a better option ?

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Lai Jiangshan <jiangshanlai@gmail.com>
CC: Stephen Hemminger <stephen@networkplumber.org>
CC: Chris Mason <clm@fb.com>
CC: lttng-dev@lists.lttng.org
CC: rp@svcs.cs.pdx.edu
---
 urcu/ref.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/urcu/ref.h b/urcu/ref.h
index 2b803e5..42417c0 100644
--- a/urcu/ref.h
+++ b/urcu/ref.h
@@ -34,19 +34,20 @@ static inline void urcu_ref_init(struct urcu_ref *ref)
 	urcu_ref_set(ref, 1);
 }
 
-static inline void urcu_ref_get(struct urcu_ref *ref)
+static inline bool  __attribute__((warn_unused_result))
+		urcu_ref_get(struct urcu_ref *ref)
 {
 	long old, _new, res;
 
 	old = uatomic_read(&ref->refcount);
 	for (;;) {
 		if (old == LONG_MAX) {
-			abort();
+			return false;	/* Failure. */
 		}
 		_new = old + 1;
 		res = uatomic_cmpxchg(&ref->refcount, old, _new);
 		if (res == old) {
-			return;
+			return true;	/* Success. */
 		}
 		old = res;
 	}
-- 
2.1.4
