From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: shm-path: handling of snprintf
	return value
Date: Fri, 18 Sep 2015 14:46:23 -0400
Message-ID: <1442601983-2536-1-git-send-email-mathieu.desnoyers__20536.2070970752$1442602087$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Zd0g5-0005n7-HM
 for lttng-dev@lists.lttng.org; Fri, 18 Sep 2015 14:46:36 -0400
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
 src/common/ust-consumer/ust-consumer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index d45707b..a342f97 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -254,7 +254,7 @@ int get_stream_shm_path(char *stream_shm_path, const char *shm_path, int cpu)
 	strncpy(stream_shm_path, shm_path, PATH_MAX);
 	stream_shm_path[PATH_MAX - 1] = '\0';
 	ret = snprintf(cpu_nr, UINT_MAX_STR_LEN, "%u", cpu);
-	if (ret != 1) {
+	if (ret < 0) {
 		ret = -1;
 		goto end;
 	}
-- 
2.1.4
