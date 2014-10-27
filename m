From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 06/24] Fix : Do not redeclare gettid
	if found
Date: Mon, 27 Oct 2014 20:49:28 +0000
Message-ID: <1414442926-14381-7-git-send-email-c.briere__16366.5494685576$1414443141$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout4.w2.samsung.com ([211.189.100.14]
 helo=usmailout4.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirER-0007nh-K4
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:40 -0400
Received: from uscpsbgex4.samsung.com
 (u125.gpu85.samsung.co.kr [203.254.195.125]) by usmailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE400KY7F6JP620@usmailout4.samsung.com> for
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
 configure.ac            |  2 ++
 src/common/compat/tid.h | 11 +++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8703284..3460f98 100644
--- a/configure.ac
+++ b/configure.ac
@@ -213,6 +213,8 @@ AC_CHECK_DECL([cmm_smp_mb__before_uatomic_or], [],
         [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu.h>]]
 )
 
+AC_CHECK_DECLS([gettid], [], [], [[#include <unistd.h>]])
+
 # Check kmod library
 AC_ARG_WITH(kmod-prefix,
   AS_HELP_STRING([--with-kmod-prefix=PATH],
diff --git a/src/common/compat/tid.h b/src/common/compat/tid.h
index 40f562f..b420914 100644
--- a/src/common/compat/tid.h
+++ b/src/common/compat/tid.h
@@ -29,15 +29,16 @@
 #include <syscall.h>
 #endif
 
-#if defined(_syscall0)
+#if !HAVE_DECL_GETTID
+# if defined(_syscall0)
 _syscall0(pid_t, gettid)
-#elif defined(__NR_gettid)
+# elif defined(__NR_gettid)
 #include <unistd.h>
 static inline pid_t gettid(void)
 {
 	return syscall(__NR_gettid);
 }
-#else
+# else
 #include <sys/types.h>
 #include <unistd.h>
 
@@ -46,6 +47,8 @@ static inline pid_t gettid(void)
 {
 	return getpid();
 }
-#endif
+
+# endif
+#endif /* !HAVE_DECL_GETTID */
 
 #endif /* LTTNG_TID_H */
-- 
2.1.2
