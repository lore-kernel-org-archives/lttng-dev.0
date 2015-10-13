From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 1/2] Fix: initialize getline linesize argument
	to 0
Date: Tue, 13 Oct 2015 14:44:05 -0400
Message-ID: <1444761846-9008-1-git-send-email-mathieu.desnoyers__37482.7304542579$1444761907$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Zm4Yb-0007DH-N0
 for lttng-dev@lists.lttng.org; Tue, 13 Oct 2015 14:44:19 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com, mjeanson@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

It works by accident because getline() reallocates based on the initial
pointer, but doing this falls into a blind spot of the Linux man pages.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 converter/babeltrace-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/converter/babeltrace-log.c b/converter/babeltrace-log.c
index c6f751e..5900b32 100644
--- a/converter/babeltrace-log.c
+++ b/converter/babeltrace-log.c
@@ -318,7 +318,7 @@ void trace_text(FILE *input, int output)
 	struct ctf_stream_pos pos;
 	ssize_t len;
 	char *line = NULL, *nl;
-	size_t linesize;
+	size_t linesize = 0;
 	int ret;
 
 	memset(&pos, 0, sizeof(pos));
-- 
2.1.4
