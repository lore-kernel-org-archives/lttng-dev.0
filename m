From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools 2/2] Revert stubbing of runas
 functions
Date: Thu, 29 Nov 2018 16:22:07 -0500
Message-ID: <20181129212207.8611-2-mjeanson__29287.7561915249$1543526426$gmane$org@efficios.com>
References: <20181129212207.8611-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 435Vpj6Nxjzvrl
 for <lttng-dev@lists.lttng.org>; Thu, 29 Nov 2018 16:22:21 -0500 (EST)
In-Reply-To: <20181129212207.8611-1-mjeanson@efficios.com>
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

All the runas functions were stubbed on builds were the sessiond isn't
built which is the case of all platforms except Linux. This was done
because of 2 new commands that require elf.h which is not present on
MacOSX. However the other commands can be used by the relayd.

Revert this and and only stub the relevant commands when "elf.h" is not
present on the system.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac            |  7 ++---
 src/common/Makefile.am  | 12 ++++----
 src/common/lttng-elf.c  |  6 ++--
 src/common/runas-stub.c | 62 -----------------------------------------
 src/common/runas.c      | 18 ++++++++++++
 5 files changed, 29 insertions(+), 76 deletions(-)
 delete mode 100644 src/common/runas-stub.c

diff --git a/configure.ac b/configure.ac
index bc92b5bd..bf1ef6f2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -194,9 +194,11 @@ AC_CHECK_HEADERS([ \
 	signal.h stdlib.h sys/un.h sys/socket.h stdlib.h stdio.h \
 	getopt.h sys/ipc.h sys/shm.h popt.h grp.h arpa/inet.h \
 	netdb.h netinet/in.h paths.h stddef.h sys/file.h sys/ioctl.h \
-	sys/mount.h sys/param.h sys/time.h
+	sys/mount.h sys/param.h sys/time.h elf.h
 ])
 
+AM_CONDITIONAL([HAVE_ELF_H], [test x$ac_cv_header_elf_h = xyes])
+
 # Basic functions check
 AC_CHECK_FUNCS([ \
 	atexit bzero clock_gettime dup2 fdatasync fls ftruncate \
@@ -873,7 +875,6 @@ build_lib_compat=no
 build_lib_consumer=no
 build_lib_hashtable=no
 build_lib_health=no
-build_lib_runas=no
 build_lib_index=no
 build_lib_kernel_consumer=no
 build_lib_kernel_ctl=no
@@ -930,7 +931,6 @@ AS_IF([test x$enable_bin_lttng_sessiond != xno],
        build_lib_relayd=yes
        build_lib_testpoint=yes
        build_lib_health=yes
-       build_lib_runas=yes
       ]
 )
 
@@ -1039,7 +1039,6 @@ AM_CONDITIONAL([BUILD_LIB_CONFIG], [test x$build_lib_config = xyes])
 AM_CONDITIONAL([BUILD_LIB_CONSUMER], [test x$build_lib_consumer = xyes])
 AM_CONDITIONAL([BUILD_LIB_HASHTABLE], [test x$build_lib_hashtable = xyes])
 AM_CONDITIONAL([BUILD_LIB_HEALTH], [test x$build_lib_health = xyes])
-AM_CONDITIONAL([BUILD_LIB_RUNAS], [test x$build_lib_runas = xyes])
 AM_CONDITIONAL([BUILD_LIB_INDEX], [test x$build_lib_index = xyes])
 AM_CONDITIONAL([BUILD_LIB_KERNEL_CONSUMER], [test x$build_lib_kernel_consumer = xyes])
 AM_CONDITIONAL([BUILD_LIB_KERNEL_CTL], [test x$build_lib_kernel_ctl = xyes])
diff --git a/src/common/Makefile.am b/src/common/Makefile.am
index d754924d..1824fe46 100644
--- a/src/common/Makefile.am
+++ b/src/common/Makefile.am
@@ -12,7 +12,7 @@ DIST_SUBDIRS = compat health hashtable kernel-ctl sessiond-comm relayd \
 noinst_LTLIBRARIES = libcommon.la
 EXTRA_DIST = mi-lttng-3.0.xsd
 
-libcommon_la_SOURCES = error.h error.c utils.c utils.h runas.h \
+libcommon_la_SOURCES = error.h error.c utils.c utils.h runas.h runas.c \
                        common.h futex.c futex.h uri.c uri.h defaults.c \
                        pipe.c pipe.h readwrite.c readwrite.h \
                        mi-lttng.h mi-lttng.c \
@@ -29,16 +29,14 @@ libcommon_la_SOURCES = error.h error.c utils.c utils.h runas.h \
                        waiter.h waiter.c \
                        userspace-probe.c event.c
 
+if HAVE_ELF_H
+libcommon_la_SOURCES += lttng-elf.h lttng-elf.c
+endif
+
 libcommon_la_LIBADD = \
 		$(top_builddir)/src/common/config/libconfig.la \
 		$(UUID_LIBS)
 
-if BUILD_LIB_RUNAS
-libcommon_la_SOURCES += runas.c lttng-elf.h lttng-elf.c
-else
-libcommon_la_SOURCES += runas-stub.c
-endif
-
 if BUILD_LIB_COMPAT
 SUBDIRS += compat
 endif
diff --git a/src/common/lttng-elf.c b/src/common/lttng-elf.c
index cb01f7bb..cd10632c 100644
--- a/src/common/lttng-elf.c
+++ b/src/common/lttng-elf.c
@@ -56,13 +56,13 @@
 	do {					\
 		switch (sizeof(x)) {		\
 		case 8:				\
-			x = be64toh(x);		\
+			x = be64toh((uint64_t)x);		\
 			break;			\
 		case 4:				\
-			x = be32toh(x);		\
+			x = be32toh((uint32_t)x);		\
 			break;			\
 		case 2:				\
-			x = be16toh(x);		\
+			x = be16toh((uint16_t)x);		\
 			break;			\
 		case 1:				\
 			break;			\
diff --git a/src/common/runas-stub.c b/src/common/runas-stub.c
deleted file mode 100644
index 7af8b6e0..00000000
--- a/src/common/runas-stub.c
+++ /dev/null
@@ -1,62 +0,0 @@
-#ifndef _RUNAS_STUB_H
-#define _RUNAS_STUB_H
-
-/*
- * Copyright (C) 2018 - Francis Deslauriers <francis.deslauriers@efficios.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, version 2 only,
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include <sys/types.h>
-#include <stdint.h>
-
-int run_as_mkdir_recursive(const char *path, mode_t mode, uid_t uid, gid_t gid)
-{
-	return -1;
-}
-int run_as_mkdir(const char *path, mode_t mode, uid_t uid, gid_t gid)
-{
-	return -1;
-}
-int run_as_open(const char *path, int flags, mode_t mode, uid_t uid, gid_t gid)
-{
-	return -1;
-}
-int run_as_unlink(const char *path, uid_t uid, gid_t gid)
-{
-	return -1;
-}
-int run_as_rmdir_recursive(const char *path, uid_t uid, gid_t gid)
-{
-	return -1;
-}
-int lttng_elf_get_symbol_offset(int fd, char *symbol, uint64_t *offset)
-{
-	return -1;
-}
-int lttng_elf_get_sdt_probe_offsets(int fd, const char *provider_name,
-		const char *probe_name, uint64_t **offsets, uint32_t *nb_probe)
-{
-	return -1;
-}
-int run_as_create_worker(char *procname)
-{
-	return -1;
-}
-void run_as_destroy_worker(void)
-{
-	return;
-}
-
-#endif /* _RUNAS_STUB_H */
diff --git a/src/common/runas.c b/src/common/runas.c
index 00c729fd..1487eb15 100644
--- a/src/common/runas.c
+++ b/src/common/runas.c
@@ -240,6 +240,7 @@ int _rmdir_recursive(struct run_as_data *data, struct run_as_ret *ret_value)
 	return ret_value->u.rmdir_recursive.ret;
 }
 
+#ifdef HAVE_ELF_H
 static
 int _extract_elf_symbol_offset(struct run_as_data *data,
 		struct run_as_ret *ret_value)
@@ -298,6 +299,23 @@ free_offset:
 end:
 	return ret;
 }
+#else
+static
+int _extract_elf_symbol_offset(struct run_as_data *data,
+		struct run_as_ret *ret_value)
+{
+	ERR("Unimplemented runas command RUN_AS_EXTRACT_ELF_SYMBOL_OFFSET");
+	return -1;
+}
+
+static
+int _extract_sdt_probe_offsets(struct run_as_data *data,
+		struct run_as_ret *ret_value)
+{
+	ERR("Unimplemented runas command RUN_AS_EXTRACT_SDT_PROBE_OFFSETS");
+	return -1;
+}
+#endif
 
 static
 run_as_fct run_as_enum_to_fct(enum run_as_cmd cmd)
-- 
2.17.1
