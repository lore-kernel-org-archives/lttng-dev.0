From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Fix: Memory leaks on unknown
	hashtable type error handling
Date: Thu, 28 Feb 2013 15:48:27 -0500
Message-ID: <1362084510-10072-4-git-send-email-christian.babeux__23818.4628346518$1362084591$gmane$org@efficios.com>
References: <1362084510-10072-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UBAPV-0001pi-Cp
	for lttng-dev@lists.lttng.org; Thu, 28 Feb 2013 15:49:01 -0500
Received: by mail-ie0-f182.google.com with SMTP id k14so2653718iea.41
	for <lttng-dev@lists.lttng.org>; Thu, 28 Feb 2013 12:48:56 -0800 (PST)
In-Reply-To: <1362084510-10072-1-git-send-email-christian.babeux@efficios.com>
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
 src/common/hashtable/hashtable.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/common/hashtable/hashtable.c b/src/common/hashtable/hashtable.c
index 24d5797..5bf85e5 100644
--- a/src/common/hashtable/hashtable.c
+++ b/src/common/hashtable/hashtable.c
@@ -90,6 +90,7 @@ struct lttng_ht *lttng_ht_new(unsigned long size, int type)
 		break;
 	default:
 		ERR("Unknown lttng hashtable type %d", type);
+		lttng_ht_destroy(ht);
 		goto error;
 	}
 
-- 
1.8.1.3
