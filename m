From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH] Fix: only cleanup the
	agent_apps_ht_by_sock as root
Date: Thu, 30 Jul 2015 11:12:37 -0400
Message-ID: <1438269157-1473-1-git-send-email-jdesfossez__27604.6416060582$1438269224$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZKpVp-0005DS-86
 for lttng-dev@lists.lttng.org; Thu, 30 Jul 2015 11:12:50 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Commit 6a4e403927ffef4cae8726064dcf53c463eb128c introduced a bug where
we could end up iterating over the agent_apps_ht_by_sock regardless if
it was allocated or not (only when the sessiond is launched as root).

Steps to reproduce:
$ sudo lttng-sessiond -d
$ lttng-sessiond
Error: Already running daemon.
Segmentation fault (core dumped)

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/bin/lttng-sessiond/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 91dd047..5840165 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -677,7 +677,9 @@ static void sessiond_cleanup(void)
 	}
 
 	DBG("Cleaning up all agent apps");
-	agent_app_ht_clean();
+	if (is_root) {
+		agent_app_ht_clean();
+	}
 
 	DBG("Closing all UST sockets");
 	ust_app_clean_list();
-- 
1.9.1
