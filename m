From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 06/13] Misleading error handling:
	utils_create_pid_file() should return 0 on success
Date: Wed, 17 Dec 2014 20:45:17 -0500
Message-ID: <1418867124-17343-7-git-send-email-mathieu.desnoyers__22134.0569122278$1418867351$gmane$org@efficios.com>
References: <1418867124-17343-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y1QA1-0006BP-1R
 for lttng-dev@lists.lttng.org; Wed, 17 Dec 2014 20:45:49 -0500
In-Reply-To: <1418867124-17343-1-git-send-email-mathieu.desnoyers@efficios.com>
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

fprintf returns a positive value on success, which is used as return
value for utils_create_pid_file(), which is odd. This is in preparation
for main() refactoring.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/utils.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/common/utils.c b/src/common/utils.c
index e7dccb7..3428d31 100644
--- a/src/common/utils.c
+++ b/src/common/utils.c
@@ -477,10 +477,14 @@ int utils_create_pid_file(pid_t pid, const char *filepath)
 	ret = fprintf(fp, "%d\n", pid);
 	if (ret < 0) {
 		PERROR("fprintf pid file");
+		goto error;
 	}
 
-	fclose(fp);
+	if (fclose(fp)) {
+		PERROR("fclose");
+	}
 	DBG("Pid %d written in file %s", pid, filepath);
+	ret = 0;
 error:
 	return ret;
 }
-- 
2.1.1
