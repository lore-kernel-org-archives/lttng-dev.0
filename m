From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: [PATCH] configure.ac: fix "missing jni.h" error message
Date: Tue,  2 Sep 2014 16:12:55 -0400
Message-ID: <1409688775-5119-1-git-send-email-eeppeliteloop__44405.3700347014$1409688858$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1XOuRt-0000Bv-Rx
 for lttng-dev@lists.lttng.org; Tue, 02 Sep 2014 16:13:13 -0400
Received: by mail-qg0-f49.google.com with SMTP id j107so7215066qga.36
 for <lttng-dev@lists.lttng.org>; Tue, 02 Sep 2014 13:12:55 -0700 (PDT)
Received: from archeepp.alfa.com ([96.127.217.202])
 by mx.google.com with ESMTPSA id i110sm6251846qgf.29.2014.09.02.13.12.53
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 02 Sep 2014 13:12:54 -0700 (PDT)
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

DIR in --with-java-jdk=DIR must point to the JDK base
directory, not the actual JDK include directory.

Signed-off-by: Philippe Proulx <eeppeliteloop@gmail.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 726c8e9..175a0a6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -272,7 +272,7 @@ AS_IF([test "x$jni_interface" = "xyes"],[
         AC_CHECK_HEADERS([jni.h],[],[
         AC_MSG_ERROR([missing jni.h
 Make sure Sun Java, OpenJDK or GCJ is installed and that this header file exists in the system path.
-Use the --with-java-jdk=DIR flag to point to your Java include files, or disable the JNI interface.])
+Use the --with-java-jdk=DIR option to point to your JDK directory, or disable the JNI interface.])
 	])
 ])
 AM_CONDITIONAL([BUILD_JNI_INTERFACE], [test "x$jni_interface" = "xyes"])
-- 
2.1.0
