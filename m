From: Martin Leisener <martin@leisener.de>
Subject: [PATCH lttng-modules] Fix: Building the event list
 fails on fragmented memory
Date: Mon, 08 Jun 2015 11:19:09 +0200
Message-ID: <55755E0D.7010902__27161.0936652452$1433755216$gmane$org@leisener.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.kundenserver.de ([212.227.17.24])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <martin@leisener.de>) id 1Z1tDC-00069I-Ft
 for lttng-dev@lists.lttng.org; Mon, 08 Jun 2015 05:19:20 -0400
Received: from [10.0.2.15] ([194.121.90.173]) by mrelayeu.kundenserver.de
 (mreue104) with ESMTPSA (Nemesis) id 0MUVcJ-1YbjOL0Y7f-00RKL9 for
 <lttng-dev@lists.lttng.org>; Mon, 08 Jun 2015 11:19:14 +0200
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

Hi Mathieu,

thanks for merging my arm patch! I found one more issue during my lttng-modules usages,
which can happen in low/fragmented memory situations. Please have a look, if you find this
patch useful/mergable. Again it is tested on x86 Ubuntu 12.04 LTS as well as my imx6 arm board.

Regards Martin


On a small arm imx6 solo with 256MB RAM it often happens that memory becomes fragmented rather
quickly, so that kmalloc will not be able to get enough consecutive pages (enocuntered for
example if you enable all kernel events: lttng enable-event -k syscall --all).

This patch switches the allocation to vmalloc. Tested for x86 on Ubuntu 12.04 Lts
and on imx6 solo 256MB RAM

If this patch is not applied, you can identify low and/or fragmented memory failures by
looking at the kernel ring buffer (please ignore DMA, it is due to some memory setup
misconfiguration, should read Normal):

...
[  321.993820] lttng-sessiond: page allocation failure: order:4, mode:0x1040d0
...
[  321.994711] lowmem_reserve[]: 0 0 0
[  321.994727] DMA: 801*4kB (UEMC) 424*8kB (EMC) 355*16kB (UEMC) 344*32kB (MC) 340*64kB (C) 8*128kB (C) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB 0*8192kB 0*16384kB 0*32768kB = 46068kB

Signed-off-by: Martin Leisener <martin@leisener.de>
---
 lttng-events.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/lttng-events.c b/lttng-events.c
index 7eec04c..c861f71 100644
--- a/lttng-events.c
+++ b/lttng-events.c
@@ -39,6 +39,7 @@
 #include "wrapper/file.h"
 #include <linux/jhash.h>
 #include <linux/uaccess.h>
+#include <linux/vmalloc.h>
  #include "wrapper/uuid.h"
 #include "wrapper/vmalloc.h"	/* for wrapper_vmalloc_sync_all() */
@@ -132,10 +133,10 @@ struct lttng_session *lttng_session_create(void)
 			GFP_KERNEL);
 	if (!metadata_cache)
 		goto err_free_session;
-	metadata_cache->data = kzalloc(METADATA_CACHE_DEFAULT_SIZE,
-			GFP_KERNEL);
+	metadata_cache->data = vmalloc(METADATA_CACHE_DEFAULT_SIZE);
 	if (!metadata_cache->data)
 		goto err_free_cache;
+	memset(metadata_cache->data, 0, METADATA_CACHE_DEFAULT_SIZE);
 	metadata_cache->cache_alloc = METADATA_CACHE_DEFAULT_SIZE;
 	kref_init(&metadata_cache->refcount);
 	session->metadata_cache = metadata_cache;
@@ -162,7 +163,7 @@ void metadata_cache_destroy(struct kref *kref)
 {
 	struct lttng_metadata_cache *cache =
 		container_of(kref, struct lttng_metadata_cache, refcount);
-	kfree(cache->data);
+	vfree(cache->data);
 	kfree(cache);
 }
 @@ -1523,10 +1524,15 @@ int lttng_metadata_printf(struct lttng_session *session,
 		tmp_cache_alloc_size = max_t(unsigned int,
 				session->metadata_cache->cache_alloc + len,
 				session->metadata_cache->cache_alloc << 1);
-		tmp_cache_realloc = krealloc(session->metadata_cache->data,
-				tmp_cache_alloc_size, GFP_KERNEL);
+		tmp_cache_realloc = vmalloc(tmp_cache_alloc_size);
 		if (!tmp_cache_realloc)
 			goto err;
+		else if (session->metadata_cache->data) {
+			memset(tmp_cache_realloc, 0, tmp_cache_alloc_size);
+			memcpy(tmp_cache_realloc, session->metadata_cache->data, session->metadata_cache->cache_alloc);
+			vfree(session->metadata_cache->data);
+		}
+
 		session->metadata_cache->cache_alloc = tmp_cache_alloc_size;
 		session->metadata_cache->data = tmp_cache_realloc;
 	}
-- 
1.7.9.5
