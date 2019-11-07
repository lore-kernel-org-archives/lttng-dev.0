From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] Require automake >= 1.12
Date: Thu,  7 Nov 2019 13:48:52 -0500
Message-ID: <20191107184852.15562-1-mjeanson__17016.534185835$1573152555$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 478C9S1FH5z1RFF
 for <lttng-dev@lists.lttng.org>; Thu,  7 Nov 2019 13:48:59 -0500 (EST)
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

The test suite LOG_DRIVER statement requires that automake >= 1.12 be used
during bootstrap.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 319cb401..001c4428 100644
--- a/configure.ac
+++ b/configure.ac
@@ -41,7 +41,7 @@ AC_CONFIG_SRCDIR([include/lttng/tracepoint.h])
 AC_CANONICAL_TARGET
 AC_CANONICAL_HOST
 
-AM_INIT_AUTOMAKE([1.9 foreign dist-bzip2 no-dist-gzip tar-ustar])
+AM_INIT_AUTOMAKE([1.12 foreign dist-bzip2 no-dist-gzip tar-ustar])
 AM_MAINTAINER_MODE([enable])
 
 # Enable silent rules if available (Introduced in AM 1.11)
-- 
2.17.1
