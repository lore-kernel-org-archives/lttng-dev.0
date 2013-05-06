From: Charles Briere <charlesbriere.flatzo@gmail.com>
Subject: [PATCH lttng-tools 03/14] Adding libext2_uuid support
Date: Mon,  6 May 2013 18:18:40 +0000
Message-ID: <1367864331-15212-3-git-send-email-charlesbriere.flatzo__47769.4817739122$1367864388$gmane$org@gmail.com>
References: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <charlesbriere.flatzo@gmail.com>) id 1UZQ06-0008WI-G6
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 14:19:02 -0400
Received: by mail-qa0-f51.google.com with SMTP id hu16so1616385qab.3
	for <lttng-dev@lists.lttng.org>; Mon, 06 May 2013 11:18:57 -0700 (PDT)
In-Reply-To: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: Charles Briere <charlesbriere.flatzo@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Charles Briere <charlesbriere.flatzo@gmail.com>
---
 configure.ac             | 1 +
 src/common/Makefile.am   | 5 +++++
 src/common/compat/uuid.h | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 618d203..b78cc94 100644
--- a/configure.ac
+++ b/configure.ac
@@ -172,6 +172,7 @@ AC_CHECK_LIB([uuid], [uuid_generate],
 )
 AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBUUID], [test "x$have_libuuid" = "xyes"])
 AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBC_UUID], [test "x$have_libc_uuid" = "xyes"])
+AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBEXT2_UUID], [test "x$have_libext2_uuid" = "xyes"])
 
 # URCU library version needed or newer
 liburcu_version=">= 0.7.2"
diff --git a/src/common/Makefile.am b/src/common/Makefile.am
index f2ea40a..6aa6c4a 100644
--- a/src/common/Makefile.am
+++ b/src/common/Makefile.am
@@ -14,7 +14,12 @@ noinst_LTLIBRARIES = libcommon.la
 
 libcommon_la_SOURCES = error.h error.c utils.c utils.h runas.c runas.h \
                        common.h futex.c futex.h uri.c uri.h defaults.c
+
+if LTTNG_BUILD_WITH_LIBEXT2_UUID
+libcommon_la_LIBADD = -lext2_uuid
+else
 libcommon_la_LIBADD = -luuid
+endif
 
 # Consumer library
 noinst_LTLIBRARIES += libconsumer.la
diff --git a/src/common/compat/uuid.h b/src/common/compat/uuid.h
index 35faf53..448d6bd 100644
--- a/src/common/compat/uuid.h
+++ b/src/common/compat/uuid.h
@@ -30,7 +30,7 @@
 #define UUID_STR_LEN		37
 #define UUID_LEN		16
 
-#ifdef LTTNG_HAVE_LIBUUID
+#if defined(LTTNG_HAVE_LIBUUID) || defined(LTTNG_HAVE_LIBEXT2_UUID)
 #include <uuid/uuid.h>
 
 /*
-- 
1.8.1.msysgit.1
