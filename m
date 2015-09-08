From: Antoine Busque <abusque@efficios.com>
Subject: [PATCH lttng-ust] Fix: potential leaks in error paths
Date: Tue,  8 Sep 2015 17:33:18 -0400
Message-ID: <1441747998-22282-1-git-send-email-abusque__39608.0904327848$1441748060$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <abusque@efficios.com>) id 1ZZQWA-0000rE-Te
 for lttng-dev@lists.lttng.org; Tue, 08 Sep 2015 17:33:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5A3323405D8
 for <lttng-dev@lists.lttng.org>; Tue,  8 Sep 2015 21:33:25 +0000 (UTC)
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
 liblttng-ust/lttng-ust-elf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/liblttng-ust/lttng-ust-elf.c b/liblttng-ust/lttng-ust-elf.c
index ce58539..4de380c 100644
--- a/liblttng-ust/lttng-ust-elf.c
+++ b/liblttng-ust/lttng-ust-elf.c
@@ -545,6 +545,7 @@ int lttng_ust_elf_get_build_id(struct lttng_ust_elf *elf, uint8_t **build_id,
 	*found = _found;
 	return 0;
 error:
+	free(_build_id);
 	return -1;
 }
 
@@ -681,5 +682,6 @@ int lttng_ust_elf_get_debug_link(struct lttng_ust_elf *elf, char **filename,
 	*found = _found;
 	return 0;
 error:
+	free(_filename);
 	return -1;
 }
-- 
2.5.1
