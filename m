From: David Goulet <dgoulet@efficios.com>
Subject: [PATCH lttng-ust v2] Add libc errno translation layer
	to UST error code
Date: Fri,  9 Nov 2012 13:16:18 -0500
Message-ID: <1352484978-19518-1-git-send-email-dgoulet__44379.6507236131$1352485018$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TWt7x-0008K6-EK
	for lttng-dev@lists.lttng.org; Fri, 09 Nov 2012 13:16:25 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Also add four new possible code being EEXIST, EINVAL, ENOSYS and EPERM.

Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 include/lttng/ust-error.h          |    6 +++++-
 liblttng-ust-comm/lttng-ust-comm.c |    4 ++++
 liblttng-ust/lttng-ust-comm.c      |   26 +++++++++++++++++++++++---
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/lttng/ust-error.h b/include/lttng/ust-error.h
index 49890a9..0d829f8 100644
--- a/include/lttng/ust-error.h
+++ b/include/lttng/ust-error.h
@@ -36,7 +36,11 @@
 enum lttng_ust_error_code {
 	LTTNG_UST_OK = 0,			/* Ok */
 	LTTNG_UST_ERR = 1024,			/* Unknown Error */
-	LTTNG_UST_ERR_NOENT,			/* No entry */
+	LTTNG_UST_ERR_NOENT = 1025,		/* No entry */
+	LTTNG_UST_ERR_EXIST = 1026,     /* Object exists */
+	LTTNG_UST_ERR_INVAL = 1027,     /* Invalid argument */
+	LTTNG_UST_ERR_PERM  = 1028,     /* Permission denied */
+	LTTNG_UST_ERR_NOSYS = 1029,     /* Not implemented */
 
 	/* MUST be last element */
 	LTTNG_UST_ERR_NR,			/* Last element */
diff --git a/liblttng-ust-comm/lttng-ust-comm.c b/liblttng-ust-comm/lttng-ust-comm.c
index 8765ea6..9a67ea1 100644
--- a/liblttng-ust-comm/lttng-ust-comm.c
+++ b/liblttng-ust-comm/lttng-ust-comm.c
@@ -44,6 +44,10 @@ static const char *ustcomm_readable_code[] = {
 	[ USTCOMM_CODE_OFFSET(LTTNG_UST_OK) ] = "Success",
 	[ USTCOMM_CODE_OFFSET(LTTNG_UST_ERR) ] = "Unknown error",
 	[ USTCOMM_CODE_OFFSET(LTTNG_UST_ERR_NOENT) ] = "No entry",
+	[ USTCOMM_CODE_OFFSET(LTTNG_UST_ERR_EXIST) ] = "Object already exists",
+	[ USTCOMM_CODE_OFFSET(LTTNG_UST_ERR_INVAL) ] = "Invalid argument",
+	[ USTCOMM_CODE_OFFSET(LTTNG_UST_ERR_PERM) ] = "Permission denied",
+	[ USTCOMM_CODE_OFFSET(LTTNG_UST_ERR_NOSYS) ] = "Not implemented",
 };
 
 /*
diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index f11b7d0..6eec73c 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -376,9 +376,29 @@ end:
 		 * we already have a more precise error message to
 		 * report.
 		 */
-		if (ret > -LTTNG_UST_ERR)
-			lur.ret_code = -LTTNG_UST_ERR;
-		else
+		if (ret > -LTTNG_UST_ERR) {
+			/* Translate code to UST error. */
+			switch (ret) {
+			case -EEXIST:
+				lur.ret_code = -LTTNG_UST_ERR_EXIST;
+				break;
+			case -EINVAL:
+				lur.ret_code = -LTTNG_UST_ERR_INVAL;
+				break;
+			case -ENOENT:
+				lur.ret_code = -LTTNG_UST_ERR_NOENT;
+				break;
+			case -EPERM:
+				lur.ret_code = -LTTNG_UST_ERR_PERM;
+				break;
+			case -ENOSYS:
+				lur.ret_code = -LTTNG_UST_ERR_NOSYS;
+				break;
+			default:
+				lur.ret_code = -LTTNG_UST_ERR;
+				break;
+			}
+		} else
 			lur.ret_code = ret;
 	}
 	if (ret >= 0) {
-- 
1.7.10.4
