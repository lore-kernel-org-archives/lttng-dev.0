From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: add missing RCU read unlock
Date: Wed, 24 Dec 2014 12:10:01 -0500
Message-ID: <1419441001-29408-1-git-send-email-mathieu.desnoyers__43031.5767684535$1419441060$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y3pRy-0003ev-Pf
 for lttng-dev@lists.lttng.org; Wed, 24 Dec 2014 12:10:20 -0500
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

Master commit 24eb8569dc841f318d7964ca9a0ad0a4f9508a8e
"Fix: Missing RCU read locks in syscall_list_channel()"

Introduces unbalanced RCU read-side lock/unlock. Should be applied to
master and stable-2.6.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bin/lttng-sessiond/syscall.c b/src/bin/lttng-sessiond/syscall.c
index c38f891..bfe32ac 100644
--- a/src/bin/lttng-sessiond/syscall.c
+++ b/src/bin/lttng-sessiond/syscall.c
@@ -409,6 +409,7 @@ ssize_t syscall_list_channel(struct ltt_kernel_channel *kchan,
 		ksyscall = lookup_syscall(syscalls_ht, syscall_table[i].name);
 		if (ksyscall) {
 			update_event_syscall_bitness(events, i, ksyscall->index);
+			rcu_read_unlock();
 			continue;
 		}
 		ksyscall = NULL;
-- 
2.1.1
