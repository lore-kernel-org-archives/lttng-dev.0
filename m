From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Require automake >= 1.12
Date: Thu,  7 Nov 2019 14:02:55 -0500
Message-ID: <20191107190255.17406-1-mjeanson__43446.888150514$1573153407$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 478CTm4rPBz1RGW
 for <lttng-dev@lists.lttng.org>; Thu,  7 Nov 2019 14:03:08 -0500 (EST)
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
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

The test suite LOG_DRIVER statement requires that automake >= 1.12 be used
during bootstrap.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index d8ab1e0ac..10b338420 100644
--- a/configure.ac
+++ b/configure.ac
@@ -8,7 +8,7 @@ AC_CONFIG_MACRO_DIR([m4])
 AC_CANONICAL_TARGET
 AC_CANONICAL_HOST
 
-AM_INIT_AUTOMAKE([foreign dist-bzip2 no-dist-gzip tar-pax nostdinc])
+AM_INIT_AUTOMAKE([1.12 foreign dist-bzip2 no-dist-gzip tar-pax nostdinc])
 AM_MAINTAINER_MODE([enable])
 
 # Enable silent rules if available (Introduced in AM 1.11)
-- 
2.17.1
