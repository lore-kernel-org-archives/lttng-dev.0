From: Henrik Hautakoski <henrik@fiktivkod.org>
Subject: [PATCH 1/2] liblttng-ust/lttng-ust-comm.c: fixing typo.
Date: Mon, 25 Jun 2012 13:22:50 +0200
Message-ID: <1340623371-22228-1-git-send-email-henrik__5916.73341482437$1340623432$gmane$org@fiktivkod.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <henrik@fiktivkod.org>) id 1Sj7Nw-00069M-8a
	for lttng-dev@lists.lttng.org; Mon, 25 Jun 2012 07:23:12 -0400
Received: by lboj14 with SMTP id j14so7307752lbo.35
	for <lttng-dev@lists.lttng.org>; Mon, 25 Jun 2012 04:23:05 -0700 (PDT)
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
 liblttng-ust/lttng-ust-comm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index 4104a3f..deca7cb 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -681,7 +681,7 @@ error:
  * This thread does not allocate any resource, except within
  * handle_message, within mutex protection. This mutex protects against
  * fork and exit.
- * The other moment it allocates resources is at socket connexion, which
+ * The other moment it allocates resources is at socket connection, which
  * is also protected by the mutex.
  */
 static
-- 
1.7.9.5
