From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools stable-2.11] fix: check for
 lttng-ust >= 2.11 at configure
Date: Wed, 23 Oct 2019 11:08:34 -0400
Message-ID: <20191023150834.6885-1-mjeanson__21637.4959026993$1571843343$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46yv0946FszqFn
 for <lttng-dev@lists.lttng.org>; Wed, 23 Oct 2019 11:08:41 -0400 (EDT)
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

We don't support building lttng-tools against an older version of
lttng-ust, make this check explicitly at configure.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5c4073ef8..357e2b888 100644
--- a/configure.ac
+++ b/configure.ac
@@ -562,14 +562,13 @@ AC_ARG_WITH([lttng-ust],
 
 AS_IF([test "x$with_lttng_ust" = "xyes"],
   [
-    AC_CHECK_LIB([lttng-ust-ctl], [ustctl_recv_channel_from_consumer],
+    AC_CHECK_LIB([lttng-ust-ctl], [lttng_ust_enum_get_from_desc],
       [
         AC_DEFINE([HAVE_LIBLTTNG_UST_CTL], [1])
       ],
       [
-        AC_MSG_FAILURE([Cannot find LTTng-UST >= 2.2.x. Use [LDFLAGS]=-Ldir and [CPPFLAGS]=-Idir to specify its location, or specify --without-lttng-ust to build lttng-tools without LTTng-UST support.])
-      ],
-      [-lurcu-common -lurcu-bp -lurcu-cds -lrt -ldl]
+        AC_MSG_FAILURE([Cannot find LTTng-UST >= 2.11.x. Use [LDFLAGS]=-Ldir and [CPPFLAGS]=-Idir to specify its location, or specify --without-lttng-ust to build lttng-tools without LTTng-UST support.])
+      ]
     )
   ]
 )
-- 
2.17.1
