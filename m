From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] babeltrace: make '-w' actually work
Date: Thu, 14 Feb 2013 11:52:17 +0100
Message-ID: <1360839138-16265-1-git-send-email-bigeasy__14206.0012244203$1360856465$gmane$org@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from www.linutronix.de ([62.245.132.108] helo=Galois.linutronix.de)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <bigeasy@linutronix.de>) id 1U5wQX-0005ri-FQ
	for lttng-dev@lists.lttng.org; Thu, 14 Feb 2013 05:52:29 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 converter/babeltrace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/converter/babeltrace.c b/converter/babeltrace.c
index fe7d39f..31e3d6e 100644
--- a/converter/babeltrace.c
+++ b/converter/babeltrace.c
@@ -109,7 +109,7 @@ enum {
  */
 static struct poptOption long_options[] = {
 	/* longName, shortName, argInfo, argPtr, value, descrip, argDesc */
-	{ "output", 'w', POPT_ARG_STRING, NULL, OPT_NONE, NULL, NULL },
+	{ "output", 'w', POPT_ARG_STRING, NULL, OPT_OUTPUT_PATH, NULL, NULL },
 	{ "input-format", 'i', POPT_ARG_STRING, NULL, OPT_INPUT_FORMAT, NULL, NULL },
 	{ "output-format", 'o', POPT_ARG_STRING, NULL, OPT_OUTPUT_FORMAT, NULL, NULL },
 	{ "help", 'h', POPT_ARG_NONE, NULL, OPT_HELP, NULL, NULL },
-- 
1.7.10.4
