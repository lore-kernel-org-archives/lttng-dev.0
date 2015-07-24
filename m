From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix: pids should be numbers only
Date: Fri, 24 Jul 2015 17:42:59 -0400
Message-ID: <1437774180-32746-1-git-send-email-jonathan.rajotte-julien__43634.3087618754$1437774256$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZIkkN-0005kH-OL
 for lttng-dev@lists.lttng.org; Fri, 24 Jul 2015 17:43:16 -0400
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

Ruled out cases: word, number+word, word+number, number+word+number
Ex: foo, 123foo, foo123, 123foo123

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng/commands/track-untrack.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng/commands/track-untrack.c b/src/bin/lttng/commands/track-untrack.c
index 52442cc..639e184 100644
--- a/src/bin/lttng/commands/track-untrack.c
+++ b/src/bin/lttng/commands/track-untrack.c
@@ -96,6 +96,7 @@ int parse_pid_string(const char *_pid_string,
 	int count = 0;
 	int *pid_list = NULL;
 	char *pid_string = NULL;
+	char *endptr;
 
 	if (all && _pid_string) {
 		ERR("An empty PID string is expected with --all");
@@ -132,13 +133,16 @@ int parse_pid_string(const char *_pid_string,
 	while (one_pid_str != NULL) {
 		unsigned long v;
 
-		v = strtoul(one_pid_str, NULL, 10);
+		errno = 0;
+		v = strtoul(one_pid_str, &endptr, 10);
 		if ((v == 0 && errno == EINVAL)
-				|| (v == ULONG_MAX && errno == ERANGE)) {
+				|| (v == ULONG_MAX && errno == ERANGE)
+				|| (*one_pid_str != '\0' && *endptr != '\0')){
 			ERR("Error parsing PID %s", one_pid_str);
 			retval = CMD_ERROR;
 			goto error;
 		}
+
 		if ((long) v > INT_MAX || (int) v < 0) {
 			ERR("Invalid PID value %ld", (long) v);
 			retval = CMD_ERROR;
-- 
2.1.4
