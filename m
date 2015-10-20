From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: Check if pointer is
	initialized before printing
Date: Tue, 20 Oct 2015 13:58:21 -0400
Message-ID: <1445363901-31641-1-git-send-email-jonathan.rajotte-julien__20990.9893259921$1445364018$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZobBR-0007bx-GQ
 for lttng-dev@lists.lttng.org; Tue, 20 Oct 2015 13:58:55 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Prevent a segfault on premature error such arguments parsing error etc.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-relayd/main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 7fc2fb5..eebb552 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -485,9 +485,12 @@ static void print_global_objects(void)
 {
 	rcu_register_thread();
 
-	print_viewer_streams();
-	print_relay_streams();
-	print_sessions();
+	if (viewer_streams_ht)
+		print_viewer_streams();
+	if (relay_streams_ht)
+		print_relay_streams();
+	if (sessions_ht)
+		print_sessions();
 
 	rcu_unregister_thread();
 }
-- 
2.1.4
