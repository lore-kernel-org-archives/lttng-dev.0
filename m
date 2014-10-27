From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 07/24] Fix : need to include
 config.h if using it's definitions
Date: Mon, 27 Oct 2014 20:49:28 +0000
Message-ID: <1414442926-14381-8-git-send-email-c.briere__37354.8194453635$1414443216$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout4.w2.samsung.com ([211.189.100.14]
 helo=usmailout4.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirET-0007nh-2C
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:42 -0400
Received: from uscpsbgex3.samsung.com
 (u124.gpu85.samsung.co.kr [203.254.195.124]) by usmailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE400KYNF6JOX20@usmailout4.samsung.com> for
 lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:31 -0400 (EDT)
In-reply-to: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Content-language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "jeremie.galarneau@efficios.com" <jeremie.galarneau@efficios.com>, "dgoulet@efficios.com" <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "karim.yaghmour@opersys.com" <karim.yaghmour@opersys.com>
List-Id: lttng-dev@lists.lttng.org

From: Charles Briere <c.briere@samsung.com>

Signed-off-by: Charles Briere <c.briere@samsung.com>
---
 src/common/compat/tid.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/common/compat/tid.h b/src/common/compat/tid.h
index b420914..7645b90 100644
--- a/src/common/compat/tid.h
+++ b/src/common/compat/tid.h
@@ -25,9 +25,7 @@
 #ifndef LTTNG_TID_H
 #define LTTNG_TID_H
 
-#ifdef __linux__
-#include <syscall.h>
-#endif
+#include <config.h>
 
 #if !HAVE_DECL_GETTID
 # if defined(_syscall0)
-- 
2.1.2
