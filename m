From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: Close socket handle on error
Date: Fri, 20 Sep 2019 11:34:21 -0400
Message-ID: <20190920153421.67837-1-jonathan.rajotte-julien__39195.9042217181$1568993685$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46Zd776qP3zqPN
 for <lttng-dev@lists.lttng.org>; Fri, 20 Sep 2019 11:34:27 -0400 (EDT)
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

Fixes coverity #1399739

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-sessiond/client.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/bin/lttng-sessiond/client.c b/src/bin/lttng-sessiond/client.c
index 956dab8c8..870277534 100644
--- a/src/bin/lttng-sessiond/client.c
+++ b/src/bin/lttng-sessiond/client.c
@@ -1985,8 +1985,11 @@ static int create_client_sock(void)
 	/* File permission MUST be 660 */
 	ret = chmod(config.client_unix_sock_path.value, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
 	if (ret < 0) {
-		ERR("Set file permissions failed: %s", config.client_unix_sock_path.value);
+		ERR("Set file permissions failed: %s",
+				config.client_unix_sock_path.value);
 		PERROR("chmod");
+		(void) lttcomm_close_unix_sock(client_sock);
+		ret = -1;
 		goto end;
 	}
 	DBG("Created client socket (fd = %i)", client_sock);
-- 
2.17.1
