From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: [PATCH] lttng-ust-tracef-provider.h: fix typo
Date: Tue,  3 Jun 2014 10:01:58 +0200
Message-ID: <1401782518-32510-1-git-send-email-gerlando.falauto__15380.3256609992$1401782598$gmane$org@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-de.keymile.com ([195.8.104.250])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=02319cc1ae=gerlando.falauto@keymile.com>)
 id 1Wrjfi-0005eU-Ac
 for lttng-dev@lists.lttng.org; Tue, 03 Jun 2014 04:02:16 -0400
Received: from frodo.de.keymile.net ([10.9.1.54]:58412
 helo=mailrelay.de.keymile.net)
 by mail-de.keymile.com with esmtp (Exim 4.76)
 (envelope-from <gerlando.falauto@keymile.com>) id 1Wrjfa-0005w9-0A
 for lttng-dev@lists.lttng.org; Tue, 03 Jun 2014 10:02:06 +0200
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Gerlando Falauto <gerlando.falauto@keymile.com>
List-Id: lttng-dev@lists.lttng.org

Fix typo potentially allowing for multiple inclusions.

Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
---
 liblttng-ust/lttng-ust-tracef-provider.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/liblttng-ust/lttng-ust-tracef-provider.h b/liblttng-ust/lttng-ust-tracef-provider.h
index b759191..1e32888 100644
--- a/liblttng-ust/lttng-ust-tracef-provider.h
+++ b/liblttng-ust/lttng-ust-tracef-provider.h
@@ -2,7 +2,7 @@
 #define TRACEPOINT_PROVIDER lttng_ust_tracef
 
 #if !defined(_TRACEPOINT_LTTNG_UST_TRACEF_PROVIDER_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
-#define _TRACEPOINT_LTTNG_UST_TRACEF_PROVIER_H
+#define _TRACEPOINT_LTTNG_UST_TRACEF_PROVIDER_H
 
 /*
  * Copyright (C) 2011-2014  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
-- 
1.8.0.1
