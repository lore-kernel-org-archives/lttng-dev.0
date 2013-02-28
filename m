From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Fix: Memory leaks when calling
	get_cmdline_by_pid
Date: Thu, 28 Feb 2013 15:48:28 -0500
Message-ID: <1362084510-10072-5-git-send-email-christian.babeux__7696.9133028344$1362084594$gmane$org@efficios.com>
References: <1362084510-10072-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UBAPc-0001rU-04
	for lttng-dev@lists.lttng.org; Thu, 28 Feb 2013 15:49:08 -0500
Received: by mail-ie0-f175.google.com with SMTP id c12so2627337ieb.20
	for <lttng-dev@lists.lttng.org>; Thu, 28 Feb 2013 12:49:02 -0800 (PST)
In-Reply-To: <1362084510-10072-1-git-send-email-christian.babeux@efficios.com>
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

Callers of get_cmdline_by_pid must free(3) the returned string.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 src/bin/lttng/commands/list.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
index 8fec91f..5429df4 100644
--- a/src/bin/lttng/commands/list.c
+++ b/src/bin/lttng/commands/list.c
@@ -294,6 +294,7 @@ static int list_ust_events(void)
 	struct lttng_handle *handle;
 	struct lttng_event *event_list;
 	pid_t cur_pid = 0;
+	char *cmdline = NULL;
 
 	memset(&domain, 0, sizeof(domain));
 
@@ -322,7 +323,9 @@ static int list_ust_events(void)
 	for (i = 0; i < size; i++) {
 		if (cur_pid != event_list[i].pid) {
 			cur_pid = event_list[i].pid;
-			MSG("\nPID: %d - Name: %s", cur_pid, get_cmdline_by_pid(cur_pid));
+			cmdline = get_cmdline_by_pid(cur_pid);
+			MSG("\nPID: %d - Name: %s", cur_pid, cmdline);
+			free(cmdline);
 		}
 		print_events(&event_list[i]);
 	}
@@ -349,6 +352,8 @@ static int list_ust_event_fields(void)
 	struct lttng_handle *handle;
 	struct lttng_event_field *event_field_list;
 	pid_t cur_pid = 0;
+	char *cmdline = NULL;
+
 	struct lttng_event cur_event;
 
 	memset(&domain, 0, sizeof(domain));
@@ -379,7 +384,9 @@ static int list_ust_event_fields(void)
 	for (i = 0; i < size; i++) {
 		if (cur_pid != event_field_list[i].event.pid) {
 			cur_pid = event_field_list[i].event.pid;
-			MSG("\nPID: %d - Name: %s", cur_pid, get_cmdline_by_pid(cur_pid));
+			cmdline = get_cmdline_by_pid(cur_pid);
+			MSG("\nPID: %d - Name: %s", cur_pid, cmdline);
+			free(cmdline);
 		}
 		if (strcmp(cur_event.name, event_field_list[i].event.name) != 0) {
 			print_events(&event_field_list[i].event);
-- 
1.8.1.3
