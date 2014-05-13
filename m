From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: [PATCH] tracef: add extern "C" wrapper
Date: Tue, 13 May 2014 11:33:46 +0200
Message-ID: <1399973626-6405-1-git-send-email-gerlando.falauto__19268.1030057885$1399973679$gmane$org@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-de.keymile.com ([195.8.104.250])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=0210a591ee=gerlando.falauto@keymile.com>)
 id 1Wk95w-0002Rb-C5
 for lttng-dev@lists.lttng.org; Tue, 13 May 2014 05:33:57 -0400
Received: from frodo.de.keymile.net ([10.9.1.54]:41339
 helo=mailrelay.de.keymile.net)
 by mail-de.keymile.com with esmtp (Exim 4.76)
 (envelope-from <gerlando.falauto@keymile.com>) id 1Wk95o-0004sd-06
 for lttng-dev@lists.lttng.org; Tue, 13 May 2014 11:33:48 +0200
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

Add an extern "C" wrapper so that tracef.h can be included
(and the tracef() function can be used) from C++ files, too.

Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
---
 include/lttng/tracef.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/lttng/tracef.h b/include/lttng/tracef.h
index 16a984b..45d0587 100644
--- a/include/lttng/tracef.h
+++ b/include/lttng/tracef.h
@@ -25,9 +25,17 @@
 
 #include <lttng/lttng-ust-tracef.h>
 
+#ifdef __cplusplus
+extern "C" {
+#endif
+
 extern
 void _lttng_ust_tracef(const char *fmt, ...);
 
+#ifdef __cplusplus
+}
+#endif
+
 #define tracef(fmt, ...)						\
 	do {								\
 		STAP_PROBEV(tracepoint_lttng_ust_tracef, event, ## __VA_ARGS__); \
-- 
1.8.0.1
