From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu] Require automake >= 1.12
Date: Thu,  7 Nov 2019 13:39:44 -0500
Message-ID: <20191107183944.13250-1-mjeanson__45670.3474673972$1573152015$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 478Byv2XTwz1RD3
 for <lttng-dev@lists.lttng.org>; Thu,  7 Nov 2019 13:39:50 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

The test suite LOG_DRIVER statement requires that automake >= 1.12 be used
during bootstrap.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 1d13ea3..df3fb7c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -12,7 +12,7 @@ AC_CONFIG_MACRO_DIR([m4])
 AC_CANONICAL_TARGET
 AC_CANONICAL_HOST
 
-AM_INIT_AUTOMAKE([foreign dist-bzip2 no-dist-gzip nostdinc])
+AM_INIT_AUTOMAKE([1.12 foreign dist-bzip2 no-dist-gzip nostdinc])
 AM_MAINTAINER_MODE([enable])
 
 # Enable silent rules if available (Introduced in AM 1.11)
-- 
2.17.1
