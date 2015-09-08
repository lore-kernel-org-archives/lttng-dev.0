From: Antoine Busque <abusque@efficios.com>
Subject: [PATCH lttng-ust] Fix: double free in liblttng-ust-dl
Date: Tue,  8 Sep 2015 17:24:16 -0400
Message-ID: <1441747456-20698-1-git-send-email-abusque__28785.4845323183$1441747533$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <abusque@efficios.com>) id 1ZZQNR-0000n8-FD
 for lttng-dev@lists.lttng.org; Tue, 08 Sep 2015 17:24:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 843403405D3
 for <lttng-dev@lists.lttng.org>; Tue,  8 Sep 2015 21:24:23 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Antoine Busque <abusque@efficios.com>
---
 liblttng-ust-dl/lttng-ust-dl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/liblttng-ust-dl/lttng-ust-dl.c b/liblttng-ust-dl/lttng-ust-dl.c
index d6abeff..954d9df 100644
--- a/liblttng-ust-dl/lttng-ust-dl.c
+++ b/liblttng-ust-dl/lttng-ust-dl.c
@@ -109,13 +109,11 @@ void lttng_ust_dl_dlopen(void *so_base, const char *so_name, void *ip)
 	if (has_build_id) {
 		tracepoint(lttng_ust_dl, build_id,
 			ip, so_base, build_id, build_id_len);
-		free(build_id);
 	}
 
 	if (has_debug_link) {
 		tracepoint(lttng_ust_dl, debug_link,
 			ip, so_base, dbg_file, crc);
-		free(dbg_file);
 	}
 
 end:
-- 
2.5.1
