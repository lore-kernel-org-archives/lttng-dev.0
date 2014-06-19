From: francis.deslauriers@efficios.com
Subject: [PATCH lttng-tools] Add vpid,
	vppid and vtid explanation in add-context help menu
Date: Wed, 18 Jun 2014 22:19:40 -0400
Message-ID: <1403144380-26702-1-git-send-email-francis.deslauriers__12876.66189387$1403144481$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <fdeslaur@gmail.com>) id 1WxRxi-0004BT-OX
 for lttng-dev@lists.lttng.org; Wed, 18 Jun 2014 22:20:29 -0400
Received: by mail-qg0-f45.google.com with SMTP id 63so1538021qgz.4
 for <lttng-dev@lists.lttng.org>; Wed, 18 Jun 2014 19:20:21 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, francis.deslauriers@efficios.com
List-Id: lttng-dev@lists.lttng.org

From: Francis Deslauriers <francis.deslauriers@efficios.com>

Signed-off-by: Francis Deslauriers <francis.deslauriers@efficios.com>
---
 src/bin/lttng/commands/add_context.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/bin/lttng/commands/add_context.c b/src/bin/lttng/commands/add_context.c
index 405b782..52d0db4 100644
--- a/src/bin/lttng/commands/add_context.c
+++ b/src/bin/lttng/commands/add_context.c
@@ -514,6 +514,9 @@ static void usage(FILE *ofp)
 	fprintf(ofp, "                           TYPE can be one of the strings below:\n");
 	print_ctx_type(ofp);
 	fprintf(ofp, "\n");
+	fprintf(ofp, "Note that the vpid, vppid and vtid context types represent the virtual process id,\n"
+			"virtual parent process id and virtual thread id as seen from the current execution context\n"
+			"as oppose to the pid, ppid and tid that are kernel internal data structures.\n\n");
 	fprintf(ofp, "Example:\n");
 	fprintf(ofp, "This command will add the context information 'prio' and two per-cpu\n"
 			"perf counters (hardware branch misses and cache misses), to all channels\n"
-- 
1.8.3.2
