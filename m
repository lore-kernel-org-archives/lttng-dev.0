From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Fix: int printed as uint
Date: Mon, 21 Sep 2015 15:19:30 -0400
Message-ID: <1442863170-18376-1-git-send-email-mjeanson__28825.537619605$1442863248$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1Ze6cv-0002L3-RB
 for lttng-dev@lists.lttng.org; Mon, 21 Sep 2015 15:19:51 -0400
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

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 src/common/ust-consumer/ust-consumer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index 08e6ee0..481bbeb 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -47,7 +47,7 @@
 
 #include "ust-consumer.h"
 
-#define UINT_MAX_STR_LEN 11	/* includes \0 */
+#define INT_MAX_STR_LEN 12	/* includes \0 */
 
 extern struct lttng_consumer_global_data consumer_data;
 extern int consumer_poll_timeout;
@@ -248,12 +248,12 @@ error:
 static
 int get_stream_shm_path(char *stream_shm_path, const char *shm_path, int cpu)
 {
-	char cpu_nr[UINT_MAX_STR_LEN];  /* unsigned int max len */
+	char cpu_nr[INT_MAX_STR_LEN];  /* int max len */
 	int ret;
 
 	strncpy(stream_shm_path, shm_path, PATH_MAX);
 	stream_shm_path[PATH_MAX - 1] = '\0';
-	ret = snprintf(cpu_nr, UINT_MAX_STR_LEN, "%u", cpu);
+	ret = snprintf(cpu_nr, INT_MAX_STR_LEN, "%i", cpu);
 	if (ret < 0) {
 		PERROR("snprintf");
 		goto end;
-- 
1.9.1
