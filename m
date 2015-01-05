From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Cleanup: lock file already taken is
	error, not warning
Date: Mon,  5 Jan 2015 15:58:49 -0500
Message-ID: <1420491529-12389-1-git-send-email-mathieu.desnoyers__47908.706990029$1420491655$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y8Ejs-0005Mf-5O
 for lttng-dev@lists.lttng.org; Mon, 05 Jan 2015 15:59:01 -0500
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

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/utils.c b/src/common/utils.c
index 3428d31..7f91dcb 100644
--- a/src/common/utils.c
+++ b/src/common/utils.c
@@ -516,7 +516,7 @@ int utils_create_lock_file(const char *filepath)
 	 */
 	ret = flock(fd, LOCK_EX | LOCK_NB);
 	if (ret) {
-		WARN("Could not get lock file %s, another instance is running.",
+		ERR("Could not get lock file %s, another instance is running.",
 			filepath);
 		if (close(fd)) {
 			PERROR("close lock file");
-- 
2.1.1
