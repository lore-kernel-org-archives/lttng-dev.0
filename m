From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Tests: Fix sleep interruption in
	health stall test
Date: Mon, 10 Dec 2012 14:46:15 -0500
Message-ID: <1355168775-4350-1-git-send-email-christian.babeux__10938.9972327792$1355168889$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1Ti9JJ-0002ty-HP
	for lttng-dev@lists.lttng.org; Mon, 10 Dec 2012 14:46:41 -0500
Received: by mail-ia0-f176.google.com with SMTP id y26so1818104iab.35
	for <lttng-dev@lists.lttng.org>; Mon, 10 Dec 2012 11:46:36 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The sleep(3) call can return the number of seconds left to sleep
if interrupted. Handle the intteruption in the health stall test.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/tools/health/health_stall.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tests/tools/health/health_stall.c b/tests/tools/health/health_stall.c
index f91bd49..38fe5f8 100644
--- a/tests/tools/health/health_stall.c
+++ b/tests/tools/health/health_stall.c
@@ -43,7 +43,10 @@ void __testpoint_thread_manage_clients_before_loop(void)
 	const char *var = "LTTNG_THREAD_MANAGE_CLIENTS_STALL";
 
 	if (check_env_var(var)) {
-		sleep(STALL_TIME);
+		unsigned int sleep_time = STALL_TIME;
+		while (sleep_time > 0) {
+			sleep_time = sleep(sleep_time);
+		}
 	}
 }
 
@@ -52,7 +55,10 @@ void __testpoint_thread_manage_kernel_before_loop(void)
 	const char *var = "LTTNG_THREAD_MANAGE_KERNEL_STALL";
 
 	if (check_env_var(var)) {
-		sleep(STALL_TIME);
+		unsigned int sleep_time = STALL_TIME;
+		while (sleep_time > 0) {
+			sleep_time = sleep(sleep_time);
+		}
 	}
 }
 
@@ -61,6 +67,9 @@ void __testpoint_thread_manage_apps_before_loop(void)
 	const char *var = "LTTNG_THREAD_MANAGE_APPS_STALL";
 
 	if (check_env_var(var)) {
-		sleep(STALL_TIME);
+		unsigned int sleep_time = STALL_TIME;
+		while (sleep_time > 0) {
+			sleep_time = sleep(sleep_time);
+		}
 	}
 }
-- 
1.8.0.1
