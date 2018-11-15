From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix: typo 'retrive' ->
 'retrieve'
Date: Thu, 15 Nov 2018 12:24:47 -0500
Message-ID: <20181115172448.6171-1-mjeanson__35620.6520148136$1542302576$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42wpCB3ZxXzrGw
 for <lttng-dev@lists.lttng.org>; Thu, 15 Nov 2018 12:24:54 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 src/bin/lttng/commands/add_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/bin/lttng/commands/add_context.c b/src/bin/lttng/commands/add_context.c
index 2c29a45ca..7aef4d50f 100644
--- a/src/bin/lttng/commands/add_context.c
+++ b/src/bin/lttng/commands/add_context.c
@@ -541,7 +541,7 @@ int mi_open(void)
 
 	ret = fileno(stdout);
 	if (ret < 0) {
-		PERROR("Unable to retrive fileno of stdout");
+		PERROR("Unable to retrieve fileno of stdout");
 		ret = CMD_ERROR;
 		goto end;
 	}
-- 
2.17.1
