From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Update .gitignore from upstream
Date: Tue, 10 Dec 2019 11:41:10 -0500
Message-ID: <20191210164114.26954-1-mjeanson__9128.6842756503$1575996170$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 47XQnP2xH5z156X
 for <lttng-dev@lists.lttng.org>; Tue, 10 Dec 2019 11:41:45 -0500 (EST)
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
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 .gitignore | 110 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 89 insertions(+), 21 deletions(-)

diff --git a/.gitignore b/.gitignore
index 38e1684..4af69a2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -7,30 +7,45 @@
 # command after changing this file, to see if there are
 # any tracked files which get ignored after the change.
 #
-# Normal rules
+# Normal rules (sorted alphabetically)
 #
 .*
+*.a
+*.asn1.[ch]
+*.bin
+*.bz2
+*.c.[012]*.*
+*.dt.yaml
+*.dtb
+*.dtb.S
+*.dwo
+*.elf
+*.gcno
+*.gz
+*.i
+*.ko
+*.lex.c
+*.ll
+*.lst
+*.lz4
+*.lzma
+*.lzo
+*.mod
+*.mod.c
 *.o
 *.o.*
-*.a
+*.patch
 *.s
-*.ko
 *.so
 *.so.dbg
-*.mod.c
-*.i
-*.lst
+*.su
 *.symtypes
-*.order
+*.tab.[ch]
+*.tar
+*.xz
+Module.symvers
 modules.builtin
-*.elf
-*.bin
-*.gz
-*.bz2
-*.lzma
-*.lzo
-*.gcno
-cscope.*
+modules.order
 
 #
 # Top-level generic files
@@ -39,25 +54,51 @@ cscope.*
 /TAGS
 /linux
 /vmlinux
+/vmlinux.32
+/vmlinux-gdb.py
 /vmlinuz
 /System.map
 /Module.markers
+/modules.builtin.modinfo
+/modules.nsdeps
 
-# ignore across tree
-Module.symvers
+#
+# RPM spec file (make rpm-pkg)
+#
+/*.spec
+
+#
+# Debian directory (make deb-pkg)
+#
+/debian/
+
+#
+# Snap directory (make snap-pkg)
+#
+/snap/
+
+#
+# tar directory (make tar*-pkg)
+#
+/tar-install/
 
 #
-# git files that we don't want to ignore even it they are dot-files
+# We don't want to ignore the following even if they are dot-files
 #
+!.clang-format
+!.cocciconfig
+!.get_maintainer.ignore
+!.gitattributes
 !.gitignore
 !.mailmap
 
 #
 # Generated include files
 #
-include/config
-include/linux/version.h
-include/generated
+/include/config/
+/include/generated/
+/include/ksym/
+/arch/*/include/generated/
 
 # stgit generated dirs
 patches-*
@@ -76,8 +117,35 @@ GRTAGS
 GSYMS
 GTAGS
 
+# id-utils files
+ID
+
 *.orig
 *~
 \#*#
 
+#
+# Leavings from module signing
+#
+extra_certificates
+signing_key.pem
+signing_key.priv
+signing_key.x509
+x509.genkey
+
+# Kconfig presets
+/all.config
+/alldef.config
+/allmod.config
+/allno.config
+/allrandom.config
+/allyes.config
+
+# Kdevelop4
+*.kdev4
+
+# Clang's compilation database file
+/compile_commands.json
+
+# lttng-modules specific
 /extra_version
-- 
2.17.1
