From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 3/3] Extras: Add a checkpatch git
	pre-commit hook to detect style issue
Date: Mon,  7 Jan 2013 17:12:42 -0500
Message-ID: <1357596762-14132-3-git-send-email-christian.babeux__19830.5368460298$1357596831$gmane$org@efficios.com>
References: <1357596762-14132-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TsKwP-0003YQ-Rs
	for lttng-dev@lists.lttng.org; Mon, 07 Jan 2013 17:13:10 -0500
Received: by mail-ie0-f171.google.com with SMTP id 17so24913628iea.30
	for <lttng-dev@lists.lttng.org>; Mon, 07 Jan 2013 14:13:04 -0800 (PST)
In-Reply-To: <1357596762-14132-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This commit add the checkpatch-hook script that can be installed in git
hooks folder in order to detect style issue before commiting any staged
changes.

The .checkpatch.conf file contains the appropriate options conforming to
the coding style used in the lttng-tools tree.

Also included in this commit is an install script to automatically
install the hook in the git local repo.

To override the pre-commit hook check, one can use the
`git commit --no-verify` command.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 .gitignore                     |  2 ++
 extras/.checkpatch.conf        |  7 +++++++
 extras/checkpatch-hook         | 30 ++++++++++++++++++++++++++++++
 extras/install-checkpatch-hook | 42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+)
 create mode 100644 extras/.checkpatch.conf
 create mode 100755 extras/checkpatch-hook
 create mode 100755 extras/install-checkpatch-hook

diff --git a/.gitignore b/.gitignore
index 383dbf9..e61fd07 100644
--- a/.gitignore
+++ b/.gitignore
@@ -46,6 +46,8 @@ extras/bindings/swig/python/lttng.i
 extras/bindings/swig/python/lttng.py
 extras/bindings/swig/python/lttng_wrap.c
 
+.checkpatch.conf
+
 # Tests
 test_sessions
 test_kernel_data_trace
diff --git a/extras/.checkpatch.conf b/extras/.checkpatch.conf
new file mode 100644
index 0000000..936f435
--- /dev/null
+++ b/extras/.checkpatch.conf
@@ -0,0 +1,7 @@
+# Not a kernel tree
+--no-tree
+
+# Ignore braces {} are not necessary for single statement blocks warning.
+# We enforce usage of {} even on single statement blocks.
+# See CodingStyles for more information.
+--ignore BRACES_SINGLE_STMT
diff --git a/extras/checkpatch-hook b/extras/checkpatch-hook
new file mode 100755
index 0000000..686815b
--- /dev/null
+++ b/extras/checkpatch-hook
@@ -0,0 +1,30 @@
+#!/bin/sh
+#
+# Copyright (C) - 2013 Christian Babeux <christian.babeux@efficios.com>
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License, version 2 only, as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+# more details.
+#
+# You should have received a copy of the GNU General Public License along with
+# this program; if not, write to the Free Software Foundation, Inc., 51
+# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+# To enable this hook, run the "install-checkpatch-hook" script.
+
+CHECKPATCH="extras/checkpatch.pl"
+
+if git rev-parse --verify HEAD >/dev/null 2>&1
+then
+	against=HEAD
+else
+	# Initial commit: diff against an empty tree object
+	against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
+fi
+
+git diff --cached $against -- | $CHECKPATCH --no-signoff -
diff --git a/extras/install-checkpatch-hook b/extras/install-checkpatch-hook
new file mode 100755
index 0000000..9f0e985
--- /dev/null
+++ b/extras/install-checkpatch-hook
@@ -0,0 +1,42 @@
+#!/bin/sh
+#
+# Copyright (C) - 2013 Christian Babeux <christian.babeux@efficios.com>
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License, version 2 only, as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+# more details.
+#
+# You should have received a copy of the GNU General Public License along with
+# this program; if not, write to the Free Software Foundation, Inc., 51
+# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+# Install the checkpatch pre-commit hook.
+
+DIR="$( cd "$( dirname "$0" )" && pwd )"
+
+PRECOMMIT_HOOK="../.git/hooks/pre-commit"
+PRECOMMIT_SCRIPT="checkpatch-hook"
+CHECKPATCH_CONF=".checkpatch.conf"
+
+if [ -f $PRECOMMIT_HOOK ];
+then
+   echo "File $PRECOMMIT_HOOK already exists. Aborting."
+   exit 1
+else
+    ln -s $DIR/$PRECOMMIT_SCRIPT $PRECOMMIT_HOOK
+fi
+
+if [ -f ../$CHECKPATCH_CONF ];
+then
+   echo "File ../$CHECKPATCH_CONF already exists. Aborting."
+   exit 1
+else
+    ln -s $DIR/$CHECKPATCH_CONF ../$CHECKPATCH_CONF
+fi
+
+echo "Checkpatch pre-commit hook successfully installed!"
-- 
1.8.0.2
