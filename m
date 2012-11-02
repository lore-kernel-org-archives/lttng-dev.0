From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Fix: Missing librt dependency in
	configure check for lttng-ust-ctl
Date: Fri,  2 Nov 2012 15:03:17 -0400
Message-ID: <1351882997-23283-1-git-send-email-christian.babeux__603.162116795097$1351883070$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TUMWs-0008JA-NT
	for lttng-dev@lists.lttng.org; Fri, 02 Nov 2012 15:03:42 -0400
Received: by mail-ie0-f176.google.com with SMTP id k11so6322736iea.35
	for <lttng-dev@lists.lttng.org>; Fri, 02 Nov 2012 12:03:37 -0700 (PDT)
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

The lttng-ust-ctl library depends on librt. The AC_CHECK_LIBRARY macro
can't automatically resolve dependents libraries (ala libtool),
so any additionnals dependencies must be manually specified.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 0911b9a..72daf7e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -144,7 +144,7 @@ AS_IF([test "x$lttng_ust_support" = "xyes"], [
 			lttng_ust_ctl_found=yes
 		],
 		[AC_MSG_ERROR([Cannot find LTTng-UST. Use [LDFLAGS]=-Ldir to specify its location, or specify --disable-lttng-ust to build lttng-tools without LTTng-UST support.])],
-		[-lurcu-common -lurcu-bp -lurcu-cds]
+		[-lurcu-common -lurcu-bp -lurcu-cds -lrt]
 	)
 ])
 AM_CONDITIONAL([HAVE_LIBLTTNG_UST_CTL], [test "x$lttng_ust_ctl_found" = xyes])
-- 
1.8.0
