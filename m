From: Samuel Martin <s.martin49@gmail.com>
Subject: [PATCH lttng-tools] configure.ac: use $withval with
	AC_ARG_WITH
Date: Sun, 22 Nov 2015 23:38:01 +0100
Message-ID: <1448231881-7988-2-git-send-email-s.martin49__43040.5392697596$1448231945$gmane$org@gmail.com>
References: <1448231881-7988-1-git-send-email-s.martin49@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <s.martin49@gmail.com>) id 1a0dGw-0001rS-VP
 for lttng-dev@lists.lttng.org; Sun, 22 Nov 2015 17:38:18 -0500
Received: by wmec201 with SMTP id c201so83690895wme.1
 for <lttng-dev@lists.lttng.org>; Sun, 22 Nov 2015 14:38:09 -0800 (PST)
In-Reply-To: <1448231881-7988-1-git-send-email-s.martin49@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Samuel Martin <s.martin49@gmail.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index fad4de6..978e3bc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -315,7 +315,7 @@ AC_ARG_WITH(lttng-ust-prefix,
 # Check liblttng-ust-ctl library
 AC_ARG_WITH(lttng-ust,
 	AS_HELP_STRING([--without-lttng-ust],[build without LTTng-UST (Userspace Tracing) support]),
-	lttng_ust_support=$enableval, lttng_ust_support=yes)
+	lttng_ust_support=$withval, lttng_ust_support=yes)
 
 AS_IF([test "x$lttng_ust_support" = "xyes"], [
 	AC_CHECK_LIB([lttng-ust-ctl], [ustctl_recv_channel_from_consumer],
-- 
2.6.2
