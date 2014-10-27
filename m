From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 21/24] Android : Adding bswap
	defintions
Date: Mon, 27 Oct 2014 20:49:30 +0000
Message-ID: <1414442926-14381-22-git-send-email-c.briere__16568.8793561005$1414443362$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout2.w2.samsung.com ([211.189.100.12]
 helo=usmailout2.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirET-0007nj-2K
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:44 -0400
Received: from uscpsbgex1.samsung.com
 (u122.gpu85.samsung.co.kr [203.254.195.122]) by mailout2.w2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE400GRLF6M2U30@mailout2.w2.samsung.com> for
 lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:34 -0400 (EDT)
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

Mapping of bswap functions based on what's
available on Android's NDK

Signed-off-by: Charles Briere <c.briere@samsung.com>
---
 configure.ac               |  2 ++
 src/common/compat/endian.h | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 45c6b30..91efd17 100644
--- a/configure.ac
+++ b/configure.ac
@@ -242,6 +242,8 @@ AC_CHECK_DECL([cmm_smp_mb__before_uatomic_or], [],
 
 AC_CHECK_DECLS([gettid], [], [], [[#include <unistd.h>]])
 
+AC_CHECK_DECLS([bswap_16, bswap_32, bswap_64], [], [], [[#include <byteswap.h>]])
+
 # Check kmod library
 AC_ARG_WITH(kmod-prefix,
   AS_HELP_STRING([--with-kmod-prefix=PATH],
diff --git a/src/common/compat/endian.h b/src/common/compat/endian.h
index baea531..c03c231 100644
--- a/src/common/compat/endian.h
+++ b/src/common/compat/endian.h
@@ -21,11 +21,20 @@
 #ifdef __linux__
 #include <endian.h>
 
+#define HAVE_BSWAP (HAVE_DECL_BSWAP_16 && HAVE_DECL_BSWAP_32 && HAVE_DECL_BSWAP_64)
+#if HAVE_BSWAP
+# ifndef __bswap_16
+#  define __bswap_16(x) bswap_16(x)
+#  define __bswap_32(x) bswap_32(x)
+#  define __bswap_64(x) bswap_64(x)
+# endif
+#endif
+
 /*
  * htobe/betoh are not defined for glibc <2.9, so add them
  * explicitly if they are missing.
  */
-#ifdef __USE_BSD
+#if defined(__USE_BSD) || HAVE_BSWAP
 /* Conversion interfaces. */
 # include <byteswap.h>
 
-- 
2.1.2
