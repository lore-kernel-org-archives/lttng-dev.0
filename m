From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-ust] Build: python agent: use setup.py
	over autoconf
Date: Mon, 10 Aug 2015 14:45:34 -0400
Message-ID: <1439232334-31308-5-git-send-email-jonathan.rajotte-julien__25459.9323765889$1439232612$gmane$org@efficios.com>
References: <1439232334-31308-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZOs7J-0001W1-OU
 for lttng-dev@lists.lttng.org; Mon, 10 Aug 2015 14:48:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 762D4340541
 for <lttng-dev@lists.lttng.org>; Mon, 10 Aug 2015 18:48:08 +0000 (UTC)
In-Reply-To: <1439232334-31308-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

This change provide a valid way of installing the agent. The autoconf
python macro provide the wrong installation path for
python 3 under Debian and Ubuntu due to distro-specific packaging for
python 2.7 and 3.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 .gitignore                                        |  5 ++-
 configure.ac                                      | 10 +++++
 liblttng-ust-python-agent/Makefile.am             | 47 ++++++++++++-----------
 liblttng-ust-python-agent/__init__.py.in          | 24 ------------
 liblttng-ust-python-agent/lttngust/__init__.py.in | 24 ++++++++++++
 liblttng-ust-python-agent/setup.py.in             | 25 ++++++++++++
 6 files changed, 88 insertions(+), 47 deletions(-)
 delete mode 100644 liblttng-ust-python-agent/__init__.py.in
 create mode 100644 liblttng-ust-python-agent/lttngust/__init__.py.in
 create mode 100644 liblttng-ust-python-agent/setup.py.in

diff --git a/.gitignore b/.gitignore
index 4454fa3..1039b1a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -63,5 +63,8 @@ org_lttng_ust_agent_jul_LttngLogHandler.h
 org_lttng_ust_agent_log4j_LttngLogAppender.h
 
 # Python agent
-liblttng-ust-python-agent/__init__.py
+liblttng-ust-python-agent/lttngust/__init__.py
 liblttng-ust-python-agent/**/*.pyc
+liblttng-ust-python-agent/build
+liblttng-ust-python-agent/install_files.txt
+liblttng-ust-python-agent/setup.py
diff --git a/configure.ac b/configure.ac
index d2f7650..2f5498a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -394,6 +394,8 @@ AC_CONFIG_FILES([
 	liblttng-ust-libc-wrapper/Makefile
 	liblttng-ust-cyg-profile/Makefile
 	liblttng-ust-python-agent/Makefile
+	liblttng-ust-python-agent/setup.py
+	liblttng-ust-python-agent/lttngust/__init__.py
 	tools/Makefile
 	tests/Makefile
 	tests/hello/Makefile
@@ -405,6 +407,14 @@ AC_CONFIG_FILES([
 	lttng-ust.pc
 ])
 
+# Create link for python agent for the VPATH guru.
+AC_CONFIG_LINKS([
+	liblttng-ust-python-agent/lttngust/agent.py:liblttng-ust-python-agent/lttngust/agent.py
+	liblttng-ust-python-agent/lttngust/cmd.py:liblttng-ust-python-agent/lttngust/cmd.py
+	liblttng-ust-python-agent/lttngust/debug.py:liblttng-ust-python-agent/lttngust/debug.py
+	liblttng-ust-python-agent/lttngust/loghandler.py:liblttng-ust-python-agent/lttngust/loghandler.py
+])
+
 AC_OUTPUT
 
 AS_ECHO()
diff --git a/liblttng-ust-python-agent/Makefile.am b/liblttng-ust-python-agent/Makefile.am
index 869add4..f80b8a3 100644
--- a/liblttng-ust-python-agent/Makefile.am
+++ b/liblttng-ust-python-agent/Makefile.am
@@ -1,24 +1,3 @@
-# inputs/outputs
-LTTNGUST_PY_PACKAGE_DIR = $(srcdir)/lttngust
-LTTNGUST_PY_PACKAGE_FILES = agent.py cmd.py debug.py loghandler.py
-LTTNGUST_PY_PACKAGE_SRC = \
-	$(addprefix $(LTTNGUST_PY_PACKAGE_DIR)/,$(LTTNGUST_PY_PACKAGE_FILES))
-INIT_PY_IN = $(srcdir)/__init__.py.in
-INIT_PY = __init__.py
-
-# dist files
-EXTRA_DIST = $(INIT_PY_IN) $(LTTNGUST_PY_PACKAGE_SRC)
-
-# __init__.py with proper version string
-all-local: $(INIT_PY)
-
-$(INIT_PY): $(INIT_PY_IN)
-	$(SED) "s/@LTTNG_UST_VERSION@/$(PACKAGE_VERSION)/g" < $< > $@
-
-# Python package
-nodist_lttngust_PYTHON = $(LTTNGUST_PY_PACKAGE_SRC) $(INIT_PY)
-lttngustdir = $(pythondir)/lttngust
-
 # tracepoint provider
 AM_CPPFLAGS = $(PYTHON_INCLUDE) -I$(top_srcdir)/include/ \
 	-I$(top_builddir)/include/
@@ -28,4 +7,28 @@ liblttng_ust_python_agent_la_SOURCES = lttng_ust_python.c lttng_ust_python.h
 liblttng_ust_python_agent_la_LIBADD = -lc -llttng-ust \
 	-L$(top_builddir)/liblttng-ust/.libs
 
-CLEANFILES = $(INIT_PY)
+# Use setup.py for the installation instead of Autoconf.
+# This ease the installation process and assure a *pythonic*
+# installation.
+agent_path=lttngust
+all-local:
+	$(PYTHON) setup.py build --verbose
+
+install-exec-local:
+	if [ "$(DESTDIR)" = "" ]; then \
+		$(PYTHON) setup.py install --prefix=$(prefix) --record install_files.txt  --verbose --no-compile $(DISTSETUPOPTS);  \
+	else \
+		$(PYTHON) setup.py install --root=$(DESTDIR) --verbose install_files.txt  --prefix=$(prefix) --no-compile $(DISTSETUPOPTS); \
+	fi
+clean-local:
+	rm -rf build
+
+uninstall-local:
+	cat install_files.txt | xargs rm -rf
+	rm -rf $(DESTDIR)$(pkgpythondir)
+
+EXTRA_DIST=$(agent_path)
+
+# Remove automake generated file before dist
+dist-hook:
+	rm -rf $(distdir)/$(agent_path)/__init__.py
diff --git a/liblttng-ust-python-agent/__init__.py.in b/liblttng-ust-python-agent/__init__.py.in
deleted file mode 100644
index 0b83d10..0000000
--- a/liblttng-ust-python-agent/__init__.py.in
+++ /dev/null
@@ -1,24 +0,0 @@
-# -*- coding: utf-8 -*-
-#
-# Copyright (C) 2015 - Philippe Proulx <pproulx@efficios.com>
-#
-# This library is free software; you can redistribute it and/or modify it under
-# the terms of the GNU Lesser General Public License as published by the Free
-# Software Foundation; version 2.1 of the License.
-#
-# This library is distributed in the hope that it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
-# details.
-#
-# You should have received a copy of the GNU Lesser General Public License
-# along with this library; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
-
-from __future__ import unicode_literals
-
-# this creates the daemon threads and registers the application
-import lttngust.agent
-
-
-__version__ = '@LTTNG_UST_VERSION@'
diff --git a/liblttng-ust-python-agent/lttngust/__init__.py.in b/liblttng-ust-python-agent/lttngust/__init__.py.in
new file mode 100644
index 0000000..b70c2e8
--- /dev/null
+++ b/liblttng-ust-python-agent/lttngust/__init__.py.in
@@ -0,0 +1,24 @@
+# -*- coding: utf-8 -*-
+#
+# Copyright (C) 2015 - Philippe Proulx <pproulx@efficios.com>
+#
+# This library is free software; you can redistribute it and/or modify it under
+# the terms of the GNU Lesser General Public License as published by the Free
+# Software Foundation; version 2.1 of the License.
+#
+# This library is distributed in the hope that it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
+# details.
+#
+# You should have received a copy of the GNU Lesser General Public License
+# along with this library; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
+
+from __future__ import unicode_literals
+
+# this creates the daemon threads and registers the application
+import lttngust.agent
+
+
+__version__ = '@PACKAGE_VERSION@'
diff --git a/liblttng-ust-python-agent/setup.py.in b/liblttng-ust-python-agent/setup.py.in
new file mode 100644
index 0000000..7f21c5c
--- /dev/null
+++ b/liblttng-ust-python-agent/setup.py.in
@@ -0,0 +1,25 @@
+# -*- coding: utf-8 -*-
+#
+# Copyright (C) 2015 - Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
+#
+# This library is free software; you can redistribute it and/or modify it under
+# the terms of the GNU Lesser General Public License as published by the Free
+# Software Foundation; version 2.1 of the License.
+#
+# This library is distributed in the hope that it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
+# details.
+#
+# You should have received a copy of the GNU Lesser General Public License
+# along with this library; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
+
+from distutils.core import setup, Extension
+
+setup(name='lttngust',
+      version='@PACKAGE_VERSION@',
+      description='Lttng ust agent',
+      packages=['lttngust'],
+      package_dir={'lttngust': 'lttngust'},
+      options={'build': {'build_base': 'build'}})
-- 
2.1.4
