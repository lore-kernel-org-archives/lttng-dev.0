From: Charles Briere <charlesbriere.flatzo@gmail.com>
Subject: [PATCH lttng-tools 13/14] Remove malloc in fscanf since
	it is not supported on all platforms.
Date: Mon,  6 May 2013 18:18:50 +0000
Message-ID: <1367864331-15212-13-git-send-email-charlesbriere.flatzo__48357.7543207959$1367867225$gmane$org@gmail.com>
References: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <charlesbriere.flatzo@gmail.com>) id 1UZQ0N-00006v-K1
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 14:19:19 -0400
Received: by mail-qa0-f54.google.com with SMTP id o13so1624095qaj.13
	for <lttng-dev@lists.lttng.org>; Mon, 06 May 2013 11:19:14 -0700 (PDT)
In-Reply-To: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
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

From: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>

Signed-off-by: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
---
 src/bin/lttng-sessiond/kernel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/bin/lttng-sessiond/kernel.c b/src/bin/lttng-sessiond/kernel.c
index 856d423..ed9e221 100644
--- a/src/bin/lttng-sessiond/kernel.c
+++ b/src/bin/lttng-sessiond/kernel.c
@@ -591,7 +591,7 @@ error:
 ssize_t kernel_list_events(int tracer_fd, struct lttng_event **events)
 {
 	int fd, pos, ret;
-	char *event;
+	char event[LTTNG_SYMBOL_NAME_LEN];
 	size_t nbmem, count = 0;
 	FILE *fp;
 	struct lttng_event *elist;
@@ -622,7 +622,7 @@ ssize_t kernel_list_events(int tracer_fd, struct lttng_event **events)
 		goto end;
 	}
 
-	while (fscanf(fp, "event { name = %m[^;]; };%n\n", &event, &pos) == 1) {
+	while (fscanf(fp, "event { name = %[^;]; };%n\n", &event, &pos) == 1) {
 		if (count >= nbmem) {
 			struct lttng_event *new_elist;
 
@@ -633,7 +633,6 @@ ssize_t kernel_list_events(int tracer_fd, struct lttng_event **events)
 			new_elist = realloc(elist, nbmem * sizeof(struct lttng_event));
 			if (new_elist == NULL) {
 				PERROR("realloc list events");
-				free(event);
 				free(elist);
 				count = -ENOMEM;
 				goto end;
@@ -644,7 +643,6 @@ ssize_t kernel_list_events(int tracer_fd, struct lttng_event **events)
 		elist[count].name[LTTNG_SYMBOL_NAME_LEN - 1] = '\0';
 		elist[count].enabled = -1;
 		count++;
-		free(event);
 	}
 
 	*events = elist;
-- 
1.8.1.msysgit.1
