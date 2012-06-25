From: Henrik Hautakoski <henrik@fiktivkod.org>
Subject: [PATCH 2/2] liblttng-ust-comm/lttng-ust-com.c: remove
	unnecessary goto in ustcomm_accept_unix_sock()
Date: Mon, 25 Jun 2012 13:22:51 +0200
Message-ID: <1340623371-22228-2-git-send-email-henrik__28049.1676101976$1340623428$gmane$org@fiktivkod.org>
References: <1340623371-22228-1-git-send-email-henrik@fiktivkod.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <henrik@fiktivkod.org>) id 1Sj7O5-00069M-69
	for lttng-dev@lists.lttng.org; Mon, 25 Jun 2012 07:23:21 -0400
Received: by mail-lb0-f176.google.com with SMTP id j14so7307752lbo.35
	for <lttng-dev@lists.lttng.org>; Mon, 25 Jun 2012 04:23:20 -0700 (PDT)
In-Reply-To: <1340623371-22228-1-git-send-email-henrik@fiktivkod.org>
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

Signed-off-by: Henrik Hautakoski <henrik@fiktivkod.org>
---
 liblttng-ust-comm/lttng-ust-comm.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/liblttng-ust-comm/lttng-ust-comm.c b/liblttng-ust-comm/lttng-ust-comm.c
index 078b56a..1e2fd1a 100644
--- a/liblttng-ust-comm/lttng-ust-comm.c
+++ b/liblttng-ust-comm/lttng-ust-comm.c
@@ -172,13 +172,9 @@ int ustcomm_accept_unix_sock(int sock)
 	new_fd = accept(sock, (struct sockaddr *) &sun, &len);
 	if (new_fd < 0) {
 		perror("accept");
-		goto error;
+		return -1;
 	}
-
 	return new_fd;
-
-error:
-	return -1;
 }
 
 /*
-- 
1.7.9.5
