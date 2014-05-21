From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Documentation: document tracefile
	max size discarded event limitation
Date: Wed, 21 May 2014 12:10:24 -0400
Message-ID: <1400688624-28565-1-git-send-email-mathieu.desnoyers__14579.3337528177$1400688731$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Wn96M-0002Tv-RX
 for lttng-dev@lists.lttng.org; Wed, 21 May 2014 12:10:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4A968340108
 for <lttng-dev@lists.lttng.org>; Wed, 21 May 2014 16:10:46 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: David Goulet <dgoulet@efficios.com>
---
 doc/man/lttng.1                          |    2 ++
 src/bin/lttng/commands/enable_channels.c |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
index ef73b06..42105c5 100644
--- a/doc/man/lttng.1
+++ b/doc/man/lttng.1
@@ -442,6 +442,8 @@ Use shared buffer for the whole system (\-k only)
 .BR "\-C, \-\-tracefile-size SIZE"
 Maximum size of each tracefile within a stream (in bytes).
 0 means unlimited. (default: 0)
+Note: traces generated with this option may inaccurately report
+discarded events as per CTF 1.8.
 .TP
 .BR "\-W, \-\-tracefile-count COUNT"
 Used in conjunction with \-C option, this will limit the number of files
diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/commands/enable_channels.c
index 55fbae6..4a1de2c 100644
--- a/src/bin/lttng/commands/enable_channels.c
+++ b/src/bin/lttng/commands/enable_channels.c
@@ -136,6 +136,8 @@ static void usage(FILE *ofp)
 	fprintf(ofp, "  -C, --tracefile-size SIZE\n");
 	fprintf(ofp, "                           Maximum size of each tracefile within a stream (in bytes). 0 means unlimited.\n");
 	fprintf(ofp, "                               (default: %u)\n", DEFAULT_CHANNEL_TRACEFILE_SIZE);
+	fprintf(ofp, "                           Note: traces generated with this option may inaccurately report\n");
+	fprintf(ofp, "                           discarded events as per CTF 1.8.\n");
 	fprintf(ofp, "  -W, --tracefile-count COUNT\n");
 	fprintf(ofp, "                           Used in conjunction with -C option, this will limit the number\n");
 	fprintf(ofp, "                           of files created to the specified count. 0 means unlimited.\n");
-- 
1.7.10.4
