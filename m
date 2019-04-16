From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu 2/2] Check for TLS support after CC
 detection
Date: Tue, 16 Apr 2019 13:48:00 -0400
Message-ID: <20190416174800.16938-2-mjeanson__7538.66959582723$1555436997$gmane$org@efficios.com>
References: <20190416174800.16938-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44kCY020BCz1Kgd
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 13:49:07 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id A1EF61D53AC
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 13:49:01 -0400 (EDT)
In-Reply-To: <20190416174800.16938-1-mjeanson@efficios.com>
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

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index 3879f8f..475dcf5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -45,6 +45,11 @@ AC_ARG_ENABLE([compiler-tls],
 	[def_compiler_tls=$enableval],
 	[def_compiler_tls="yes"])
 
+# Checks for C compiler
+AC_USE_SYSTEM_EXTENSIONS
+AC_PROG_CC
+AC_PROG_CC_STDC
+
 # If not overridden, use ax_tls.m4 to check if TLS is available.
 AS_IF([test "x$def_compiler_tls" = "xyes"],
 	[AX_TLS([def_tls_detect=$ac_cv_tls], [:])],
@@ -54,11 +59,6 @@ AS_IF([test "x$def_tls_detect" = "x"],
 	[:],
 	[AC_DEFINE_UNQUOTED([CONFIG_RCU_TLS], $def_tls_detect)])
 
-# Checks for C compiler
-AC_USE_SYSTEM_EXTENSIONS
-AC_PROG_CC
-AC_PROG_CC_STDC
-
 # Checks for programs.
 AC_PROG_AWK
 AC_PROG_MAKE_SET
-- 
2.17.1
