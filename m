From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 3/3] Help: add -j -l -p option to
	help string
Date: Thu, 17 Sep 2015 16:37:57 -0400
Message-ID: <1442522277-31518-3-git-send-email-jonathan.rajotte-julien__9180.7845201858$1442522551$gmane$org@efficios.com>
References: <1442522277-31518-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1Zcfws-0007SB-2V
 for lttng-dev@lists.lttng.org; Thu, 17 Sep 2015 16:38:38 -0400
In-Reply-To: <1442522277-31518-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng/commands/disable_events.c | 6 +++---
 src/bin/lttng/commands/enable_events.c  | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/bin/lttng/commands/disable_events.c b/src/bin/lttng/commands/disable_events.c
index bcbc78d..07d426c 100644
--- a/src/bin/lttng/commands/disable_events.c
+++ b/src/bin/lttng/commands/disable_events.c
@@ -93,7 +93,7 @@ static struct poptOption long_options[] = {
  */
 static void usage(FILE *ofp)
 {
-	fprintf(ofp, "usage: lttng disable-event NAME[,NAME2,...] (-k | -u) [OPTIONS]\n");
+	fprintf(ofp, "usage: lttng disable-event NAME[,NAME2,...] (-k | -u | -j | -l | -p) [OPTIONS]\n");
 	fprintf(ofp, "\n");
 	fprintf(ofp, "Options:\n");
 	fprintf(ofp, "  -h, --help               Show this help\n");
@@ -101,9 +101,9 @@ static void usage(FILE *ofp)
 	fprintf(ofp, "  -s, --session NAME       Apply to session name\n");
 	fprintf(ofp, "  -c, --channel NAME       Apply to this channel\n");
 	fprintf(ofp, "  -a, --all-events         Disable all tracepoints\n");
-	fprintf(ofp, "  -k, --kernel             Apply for the kernel tracer\n");
+	fprintf(ofp, "  -k, --kernel             Apply to the kernel tracer\n");
 	fprintf(ofp, "  -u, --userspace          Apply to the user-space tracer\n");
-	fprintf(ofp, "  -j, --jul                Apply for Java application using JUL\n");
+	fprintf(ofp, "  -j, --jul                Apply to Java application using JUL\n");
 	fprintf(ofp, "  -l, --log4j              Apply to Java application using LOG4j\n");
 	fprintf(ofp, "  -p, --python             Apply to Python application using logging\n");
 	fprintf(ofp, "\n");
diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
index 972043e..5dcdd06 100644
--- a/src/bin/lttng/commands/enable_events.c
+++ b/src/bin/lttng/commands/enable_events.c
@@ -109,9 +109,9 @@ static void usage(FILE *ofp)
 	fprintf(ofp, "  -s, --session NAME       Apply to session name\n");
 	fprintf(ofp, "  -c, --channel NAME       Apply to this channel\n");
 	fprintf(ofp, "  -a, --all                Enable all tracepoints and syscalls\n");
-	fprintf(ofp, "  -k, --kernel             Apply for the kernel tracer\n");
+	fprintf(ofp, "  -k, --kernel             Apply to the kernel tracer\n");
 	fprintf(ofp, "  -u, --userspace          Apply to the user-space tracer\n");
-	fprintf(ofp, "  -j, --jul                Apply for Java application using JUL\n");
+	fprintf(ofp, "  -j, --jul                Apply to Java application using JUL\n");
 	fprintf(ofp, "  -l, --log4j              Apply for Java application using LOG4j\n");
 	fprintf(ofp, "  -p, --python             Apply for Python application\n");
 	fprintf(ofp, "\n");
-- 
2.1.4
