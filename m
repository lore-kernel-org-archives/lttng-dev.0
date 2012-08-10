From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 2/2] Fix: Wrong domain used when
	initializing IPv6 sockets
Date: Fri, 10 Aug 2012 13:22:52 -0400
Message-ID: <1344619372-21976-3-git-send-email-christian.babeux__17910.0896152251$1344619432$gmane$org@efficios.com>
References: <1344619372-21976-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-gh0-f176.google.com ([209.85.160.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1Szsvq-0006i0-F1
	for lttng-dev@lists.lttng.org; Fri, 10 Aug 2012 13:23:31 -0400
Received: by mail-gh0-f176.google.com with SMTP id z10so2138544ghb.35
	for <lttng-dev@lists.lttng.org>; Fri, 10 Aug 2012 10:23:29 -0700 (PDT)
In-Reply-To: <1344619372-21976-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 src/common/sessiond-comm/inet6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/sessiond-comm/inet6.c b/src/common/sessiond-comm/inet6.c
index 0d96c31..98aba04 100644
--- a/src/common/sessiond-comm/inet6.c
+++ b/src/common/sessiond-comm/inet6.c
@@ -52,7 +52,7 @@ int lttcomm_create_inet6_sock(struct lttcomm_sock *sock, int type, int proto)
 	int val = 1, ret;
 
 	/* Create server socket */
-	if ((sock->fd = socket(PF_INET, type, proto)) < 0) {
+	if ((sock->fd = socket(PF_INET6, type, proto)) < 0) {
 		PERROR("socket inet6");
 		goto error;
 	}
-- 
1.7.11.4
