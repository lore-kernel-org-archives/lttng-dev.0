From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Fix: warning 'fd' may be used
 uninitialized
Date: Thu, 29 Nov 2018 16:49:51 -0500
Message-ID: <20181129214951.1960-1-mjeanson__46264.0440477573$1543528083$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 435WQb4GCnzvv3
 for <lttng-dev@lists.lttng.org>; Thu, 29 Nov 2018 16:49:59 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Initialize fd to invalid '-1' and remove unnecessary file_opened.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 src/bin/lttng-sessiond/save.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/src/bin/lttng-sessiond/save.c b/src/bin/lttng-sessiond/save.c
index 8daf870c..6ce992b2 100644
--- a/src/bin/lttng-sessiond/save.c
+++ b/src/bin/lttng-sessiond/save.c
@@ -2284,8 +2284,7 @@ static
 int save_session(struct ltt_session *session,
 	struct lttng_save_session_attr *attr, lttng_sock_cred *creds)
 {
-	int ret, fd;
-	unsigned int file_opened = 0;	/* Indicate if the file has been opened */
+	int ret, fd = -1;
 	char config_file_path[PATH_MAX];
 	size_t len;
 	struct config_writer *writer = NULL;
@@ -2378,7 +2377,6 @@ int save_session(struct ltt_session *session,
 		ret = LTTNG_ERR_SAVE_IO_FAIL;
 		goto end;
 	}
-	file_opened = 1;
 
 	writer = config_writer_create(fd, 1);
 	if (!writer) {
@@ -2492,12 +2490,12 @@ end:
 	}
 	if (ret) {
 		/* Delete file in case of error */
-		if (file_opened && unlink(config_file_path)) {
+		if ((fd >= 0) && unlink(config_file_path)) {
 			PERROR("Unlinking XML session configuration.");
 		}
 	}
 
-	if (file_opened) {
+	if (fd >= 0) {
 		ret = close(fd);
 		if (ret) {
 			PERROR("Closing XML session configuration");
-- 
2.17.1
