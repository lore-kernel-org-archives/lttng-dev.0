From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH urcu] Fix: Fallback mechanism not working on
	platform where TLS is unsupported
Date: Thu,  8 Nov 2012 14:13:25 -0500
Message-ID: <1352402005-26604-1-git-send-email-christian.babeux__22976.6650162221$1352402368$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TWXcp-0006Ed-D7
	for lttng-dev@lists.lttng.org; Thu, 08 Nov 2012 14:18:51 -0500
Received: by mail-ie0-f176.google.com with SMTP id k11so5396246iea.35
	for <lttng-dev@lists.lttng.org>; Thu, 08 Nov 2012 11:18:46 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The CONFIG_RCU_TLS entry in config.h.in is defined by default to "TLS".
This has the unfortunate consequence of defining CONFIG_RCU_TLS on platform
where TLS is unsupported and effectively disabling the pthread based
fallback mechanism. This macro should be #undef by default and the
AX_TLS m4 macro will properly detect if TLS is supported.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 urcu/config.h.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/urcu/config.h.in b/urcu/config.h.in
index de1d1d0..98ea365 100644
--- a/urcu/config.h.in
+++ b/urcu/config.h.in
@@ -18,4 +18,4 @@
 #undef CONFIG_RCU_ARM_HAVE_DMB
 
 /* TLS provided by the compiler. */
-#define CONFIG_RCU_TLS TLS
+#undef CONFIG_RCU_TLS
-- 
1.8.0
