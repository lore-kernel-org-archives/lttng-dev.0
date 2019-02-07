From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] Cleanup: fix typo 'acces' -> 'access'
Date: Thu,  7 Feb 2019 15:24:31 -0500
Message-ID: <20190207202431.21827-1-mjeanson__25208.3927671023$1549571094$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43wVCn3qtzzp9n
 for <lttng-dev@lists.lttng.org>; Thu,  7 Feb 2019 15:24:37 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id B7FB69AA2A
 for <lttng-dev@lists.lttng.org>; Thu,  7 Feb 2019 15:24:36 -0500 (EST)
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
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 liblttng-ust-dl/lttng-ust-dl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/liblttng-ust-dl/lttng-ust-dl.c b/liblttng-ust-dl/lttng-ust-dl.c
index ce2ae0e7..231e9ec3 100644
--- a/liblttng-ust-dl/lttng-ust-dl.c
+++ b/liblttng-ust-dl/lttng-ust-dl.c
@@ -107,7 +107,7 @@ void lttng_ust_dl_dlopen(void *so_base, const char *so_name,
 
 	elf = lttng_ust_elf_create(resolved_path);
 	if (!elf) {
-		ERR("could not acces file %s", resolved_path);
+		ERR("could not access file %s", resolved_path);
 		return;
 	}
 
@@ -169,7 +169,7 @@ void lttng_ust_dl_dlmopen(void *so_base, Lmid_t nsid, const char *so_name,
 
 	elf = lttng_ust_elf_create(resolved_path);
 	if (!elf) {
-		ERR("could not acces file %s", resolved_path);
+		ERR("could not access file %s", resolved_path);
 		return;
 	}
 
-- 
2.17.1
