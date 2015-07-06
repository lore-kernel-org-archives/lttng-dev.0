From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: handle sys_futex() FUTEX_WAIT
	interrupted by signal
Date: Mon,  6 Jul 2015 17:28:34 -0400
Message-ID: <1436218114-24098-1-git-send-email-mathieu.desnoyers__15609.7744162709$1436218184$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZCDwi-0001ZM-1O
 for lttng-dev@lists.lttng.org; Mon, 06 Jul 2015 17:29:00 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

We need to handle EINTR returned by sys_futex() FUTEX_WAIT, otherwise a
signal interrupting this system call could make sys_futex return too
early, and therefore cause a synchronization issue.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/futex.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/src/common/futex.c b/src/common/futex.c
index 7f07b11..0781867 100644
--- a/src/common/futex.c
+++ b/src/common/futex.c
@@ -55,8 +55,11 @@ void futex_wait_update(int32_t *futex, int active)
 {
 	if (active) {
 		uatomic_set(futex, 1);
-		futex_async(futex, FUTEX_WAKE,
-				INT_MAX, NULL, NULL, 0);
+		if (futex_async(futex, FUTEX_WAKE,
+				INT_MAX, NULL, NULL, 0) < 0) {
+			PERROR("futex_async");
+			abort();
+		}
 	} else {
 		uatomic_set(futex, 0);
 	}
@@ -84,10 +87,23 @@ void futex_nto1_wait(int32_t *futex)
 {
 	cmm_smp_mb();
 
-	if (uatomic_read(futex) == -1) {
-		futex_async(futex, FUTEX_WAIT, -1, NULL, NULL, 0);
+	if (uatomic_read(futex) != -1)
+		goto end;
+	while (futex_async(futex, FUTEX_WAIT, -1, NULL, NULL, 0)) {
+		switch (errno) {
+		case EWOULDBLOCK:
+			/* Value already changed. */
+			goto end;
+		case EINTR:
+			/* Retry if interrupted by signal. */
+			break;	/* Get out of switch. */
+		default:
+			/* Unexpected error. */
+			PERROR("futex_async");
+			abort();
+		}
 	}
-
+end:
 	DBG("Futex n to 1 wait done");
 }
 
@@ -97,10 +113,13 @@ void futex_nto1_wait(int32_t *futex)
 LTTNG_HIDDEN
 void futex_nto1_wake(int32_t *futex)
 {
-	if (caa_unlikely(uatomic_read(futex) == -1)) {
-		uatomic_set(futex, 0);
-		futex_async(futex, FUTEX_WAKE, 1, NULL, NULL, 0);
+	if (caa_unlikely(uatomic_read(futex) != -1))
+		goto end;
+	uatomic_set(futex, 0);
+	if (futex_async(futex, FUTEX_WAKE, 1, NULL, NULL, 0) < 0) {
+		PERROR("futex_async");
+		abort();
 	}
-
+end:
 	DBG("Futex n to 1 wake done");
 }
-- 
2.1.4
