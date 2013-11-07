From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 23/28] Add usage for --exclude option
Date: Thu,  7 Nov 2013 12:22:02 +0200
Message-ID: <1383819727-6843-4-git-send-email-jp_ikaheimonen__3982.10698408565$1383820055$gmane$org@mentor.com>
References: <1383819727-6843-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMjI-0007dg-BY
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:25 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VeMjC-0006FU-Ta from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:22:18 -0800
In-Reply-To: <1383819727-6843-1-git-send-email-jp_ikaheimonen@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/bin/lttng/commands/enable_events.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
index c3feefd..a363c3e 100644
--- a/src/bin/lttng/commands/enable_events.c
+++ b/src/bin/lttng/commands/enable_events.c
@@ -195,6 +195,12 @@ static void usage(FILE *ofp)
 	fprintf(ofp, "                           '$ctx.procname == \"demo*\"'\n");
 	fprintf(ofp, "                           '$ctx.vpid >= 4433 && $ctx.vpid < 4455'\n");
 	fprintf(ofp, "                           '$ctx.vtid == 1234'\n");
+	fprintf(ofp, "  -x, --exclude LIST\n");
+	fprintf(ofp, "                           Add exclusions to UST tracepoints:\n");
+	fprintf(ofp, "                           Events that match any of the items\n");
+	fprintf(ofp, "                           in the comma-separated LIST are not\n");
+	fprintf(ofp, "                           enabled, even if they match a wildcard\n");
+	fprintf(ofp, "                           definition of the event.\n");
 	fprintf(ofp, "\n");
 }
 
-- 
1.8.1.2
