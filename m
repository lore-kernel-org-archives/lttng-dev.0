From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Use --without-lttng-ust in error
	message
Date: Wed, 11 Nov 2015 14:54:17 -0500
Message-ID: <1447271657-15853-1-git-send-email-mjeanson__23757.1691898212$1447271788$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZwbTT-0006Po-FD
 for lttng-dev@lists.lttng.org; Wed, 11 Nov 2015 14:54:35 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index a46bfd3..6020596 100644
--- a/configure.ac
+++ b/configure.ac
@@ -321,7 +321,7 @@ AS_IF([test "x$lttng_ust_support" = "xyes"], [
 			AC_DEFINE([HAVE_LIBLTTNG_UST_CTL], [1], [has LTTng-UST control support])
 			lttng_ust_ctl_found=yes
 		],
-		[AC_MSG_ERROR([Cannot find LTTng-UST >= 2.2.x. Use --with-lttng-ust-prefix=PREFIX to specify its location, or specify --disable-lttng-ust to build lttng-tools without LTTng-UST support.])],
+		[AC_MSG_ERROR([Cannot find LTTng-UST >= 2.2.x. Use --with-lttng-ust-prefix=PREFIX to specify its location, or specify --without-lttng-ust to build lttng-tools without LTTng-UST support.])],
 		[-lurcu-common -lurcu-bp -lurcu-cds -lrt -ldl]
 	)
 ])
-- 
1.9.1
