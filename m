From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Add core dump snapshot handler
	script
Date: Fri, 19 Jul 2013 16:03:11 -0400
Message-ID: <1374264191-23563-1-git-send-email-christian.babeux__23314.0694014311$1374264274$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1V0Gtq-0006Yq-6e
	for lttng-dev@lists.lttng.org; Fri, 19 Jul 2013 16:03:40 -0400
Received: by mail-qc0-f174.google.com with SMTP id m15so2555179qcq.33
	for <lttng-dev@lists.lttng.org>; Fri, 19 Jul 2013 13:03:28 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

This is a custom core dump program that will be called when a core dump occur.
The program will save the core data in CORE_PATH and also, if a root session
daemon is running, will record a snapshot of tracing data using the lttng
command line utility.

Refer to README for installation and testing instruction.

Sample output of test script:

Setup...
Spawning a session daemon
Session auto-20130626-224838 created.
Kernel channel chan enabled for session auto-20130626-224838
kernel event sched_switch created in channel chan
Tracing started for session auto-20130626-224838
Sleeping...
Crashing...
./test.sh: line 35: 16980 Segmentation fault      (core dumped)
$(dirname $0)/crash
Waiting for data availability
Tracing stopped for session auto-20130626-224838
Session auto-20130626-224838 destroyed
Core dump and snapshot should hopefully be available in
/tmp/lttng/{core,snapshot}.

/tmp/lttng
|-- core
|   `-- core.16980
`-- snapshot
    `-- snapshot
        |-- chan_0
        |-- chan_1
        |-- chan_2
        |-- chan_3
        |-- chan_4
        |-- chan_5
        |-- chan_6
        |-- chan_7
        `-- metadata

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 configure.ac                    |  1 +
 extras/Makefile.am              |  2 +-
 extras/core-handler/Makefile.am |  8 +++++
 extras/core-handler/README      | 80 +++++++++++++++++++++++++++++++++++++++++
 extras/core-handler/crash.c     | 25 +++++++++++++
 extras/core-handler/handler.sh  | 72 +++++++++++++++++++++++++++++++++++++
 extras/core-handler/install.sh  | 34 ++++++++++++++++++
 extras/core-handler/test.sh     | 43 ++++++++++++++++++++++
 8 files changed, 264 insertions(+), 1 deletion(-)
 create mode 100644 extras/core-handler/Makefile.am
 create mode 100644 extras/core-handler/README
 create mode 100644 extras/core-handler/crash.c
 create mode 100644 extras/core-handler/handler.sh
 create mode 100644 extras/core-handler/install.sh
 create mode 100644 extras/core-handler/test.sh

diff --git a/configure.ac b/configure.ac
index f4a3cd8..1a9e42d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -322,6 +322,7 @@ AC_CONFIG_FILES([
 	extras/bindings/Makefile
 	extras/bindings/swig/Makefile
 	extras/bindings/swig/python/Makefile
+	extras/core-handler/Makefile
 	src/Makefile
 	src/common/Makefile
 	src/common/kernel-ctl/Makefile
diff --git a/extras/Makefile.am b/extras/Makefile.am
index 925dc2e..52de618 100644
--- a/extras/Makefile.am
+++ b/extras/Makefile.am
@@ -1 +1 @@
-SUBDIRS = bindings
+SUBDIRS = bindings core-handler
diff --git a/extras/core-handler/Makefile.am b/extras/core-handler/Makefile.am
new file mode 100644
index 0000000..eff5443
--- /dev/null
+++ b/extras/core-handler/Makefile.am
@@ -0,0 +1,8 @@
+AM_CFLAGS = -O2 -g
+AM_LDFLAGS =
+
+noinst_PROGRAMS = crash
+crash_SOURCES = crash.c
+
+noinst_SCRIPTS = handler.sh install.sh test.sh
+EXTRA_DIST = handler.sh install.sh test.sh
diff --git a/extras/core-handler/README b/extras/core-handler/README
new file mode 100644
index 0000000..cdfab11
--- /dev/null
+++ b/extras/core-handler/README
@@ -0,0 +1,80 @@
+LTTng core dump snapshot handler
+Christian Babeux, June 2013
+
+This is a custom core dump program that will be called when a core dump occur.
+The program will save the core data in CORE_PATH and also, if a root session
+daemon is running, will record a snapshot of tracing data using the lttng
+command line utility.
+
+The core dump snapshot handler can be installed by using the provided
+install.sh script or by adding the appropriate program pipe line to
+/proc/sys/kernel/core_pattern. Refer to core(5) for more information about
+the Linux kernel core dump handling and custom handler mechanism.
+
+Installation:
+
+# ./install.sh
+Backup current core_pattern in core_pattern.bkp.
+Successfully installed core_pattern.
+
+How to use:
+
+You can use the provided test.sh script to test that the core dump snapshot
+handler is working properly:
+
+# ./test.sh
+Setup...
+Spawning a session daemon
+Session auto-20130626-224838 created.
+Kernel channel chan enabled for session auto-20130626-224838
+kernel event sched_switch created in channel chan
+Tracing started for session auto-20130626-224838
+Sleeping...
+Crashing...
+./test.sh: line 35: 16980 Segmentation fault      (core dumped)
+$(dirname $0)/crash
+Waiting for data availability
+Tracing stopped for session auto-20130626-224838
+Session auto-20130626-224838 destroyed
+Core dump and snapshot should hopefully be available in
+/tmp/lttng/{core,snapshot}.
+
+# tree /tmp/lttng
+/tmp/lttng
+|-- core
+|   `-- core.16980
+`-- snapshot
+    `-- snapshot
+        |-- chan_0
+        |-- chan_1
+        |-- chan_2
+        |-- chan_3
+        |-- chan_4
+        |-- chan_5
+        |-- chan_6
+        |-- chan_7
+        `-- metadata
+
+Chaining with other core dump handler:
+
+Some Linux distributions already use their own core dump handler
+(such as systemd 'systemd-coredump' utility). It is possible to chain these
+core dump utility with the core dump snapshot handler. In order to achieve
+this, the core dump snapshot handler must be first in the chain (e.g.
+installed in /proc/sys/kernel/core_pattern) and the other core dump
+handler must be called from within the core dump snapshot handler script.
+
+Example (chaining with systemd systemd-coredump):
+
+# cat /proc/sys/kernel/core_pattern
+|/path/to/lttng/handler.sh %p %u %g %s %t %h %e %E %c
+
+In LTTng handler.sh script:
+
+[...]
+# Save core dump from stdin.
+$MKDIR_BIN -p "${CORE_PATH}"
+
+# Optional, chain core dump handler with original systemd script.
+$CAT_BIN - | /usr/lib/systemd/systemd-coredump $p $u $g $s $t $e
+[...]
\ No newline at end of file
diff --git a/extras/core-handler/crash.c b/extras/core-handler/crash.c
new file mode 100644
index 0000000..2b9cf4a
--- /dev/null
+++ b/extras/core-handler/crash.c
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2013 - Christian Babeux <christian.babeux@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2 only,
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+
+#include <signal.h>
+
+int main(int argc, char *argv[])
+{
+	raise(SIGSEGV);
+	return 0;
+}
diff --git a/extras/core-handler/handler.sh b/extras/core-handler/handler.sh
new file mode 100644
index 0000000..3026e52
--- /dev/null
+++ b/extras/core-handler/handler.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+#
+# Copyright (C) 2013 - Christian Babeux <christian.babeux@efficios.com>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; only version 2
+# of the License.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+#
+
+# System binaries paths.
+CAT_BIN="cat"
+PGREP_BIN="pgrep"
+MKDIR_BIN="mkdir"
+LTTNG_BIN="lttng"
+
+# Core file settings.
+CORE_PATH="/tmp/lttng/core"
+CORE_PREFIX="core"
+
+# Folder where to save snapshot output.
+# Can also be a remote URI.
+SNAPSHOT_PATH="/tmp/lttng/snapshot"
+SNAPSHOT_OUTPUT="file://${SNAPSHOT_PATH}"
+
+# Sessiond binary name.
+SESSIOND_BIN_NAME="lttng-sessiond"
+
+# Core specifiers, see man core(5)
+
+p=$1 # PID of dumped process
+u=$2 # (numeric) real UID of dumped process
+g=$3 # (numeric) real GID of dumped process
+s=$4 # number of signal causing dump
+t=$5 # time of dump, expressed as seconds since the Epoch,
+     # 1970-01-01 00:00:00 +0000 (UTC)
+h=$6 # hostname (same as nodename returned by uname(2))
+e=$7 # executable filename (without path prefix)
+E=$8 # pathname of executable, with slashes ('/') replaced
+     # by exclamation marks ('!').
+c=$9 # core file size soft resource limit of crashing process
+     # (since Linux 2.6.24)
+
+# Save core dump from stdin.
+$MKDIR_BIN -p "${CORE_PATH}"
+$CAT_BIN - > "${CORE_PATH}/${CORE_PREFIX}.$p"
+
+# Optional, chain core dump handler with original systemd script.
+#$CAT_BIN - | /usr/lib/systemd/systemd-coredump $p $u $g $s $t $e
+
+# TODO: Checking for a sessiond lockfile would be more appropriate.
+if $PGREP_BIN -u root "${SESSIOND_BIN_NAME}" > /dev/null 2>&1
+then
+    # Since we are called via the kernel coredump mechanism, we need to
+    # setup our environment manually.
+    #
+    # The lttng command line tool lookup $HOME to adjust the .lttngrc
+    # path. This is useful to have automatic session name lookup.
+    export HOME="/root"
+    $MKDIR_BIN -p "${SNAPSHOT_PATH}"
+    $LTTNG_BIN snapshot add-output "${SNAPSHOT_OUTPUT}" > /dev/null 2>&1
+    $LTTNG_BIN snapshot record > /dev/null 2>&1
+fi
diff --git a/extras/core-handler/install.sh b/extras/core-handler/install.sh
new file mode 100644
index 0000000..4e8d844
--- /dev/null
+++ b/extras/core-handler/install.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+#
+# Copyright (C) 2013 - Christian Babeux <christian.babeux@efficios.com>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; only version 2
+# of the License.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+#
+
+CORE_PATTERN="/proc/sys/kernel/core_pattern"
+CORE_HANDLER_PATH="$(dirname $(readlink -e $0))/handler.sh"
+
+cat ${CORE_PATTERN} > core_pattern.bkp
+
+echo "Backup current core_pattern in core_pattern.bkp."
+
+echo "|$CORE_HANDLER_PATH %p %u %g %s %t %h %e %E %c" > ${CORE_PATTERN}
+
+if [ $? -eq 0 ]
+then
+    echo "Successfully installed core_pattern."
+else
+    echo "Installation of core_pattern failed."
+fi
diff --git a/extras/core-handler/test.sh b/extras/core-handler/test.sh
new file mode 100644
index 0000000..9c73e2d
--- /dev/null
+++ b/extras/core-handler/test.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+#
+# Copyright (C) 2013 - Christian Babeux <christian.babeux@efficios.com>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; only version 2
+# of the License.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+#
+
+LTTNG_BIN="/usr/bin/lttng"
+
+CHANNEL_NAME="chan"
+EVENT_NAME="sched_switch"
+
+echo "Setup..."
+$LTTNG_BIN create --no-output
+$LTTNG_BIN enable-channel "${CHANNEL_NAME}" -k --overwrite --output mmap
+$LTTNG_BIN enable-event "${EVENT_NAME}" -c "${CHANNEL_NAME}" -k
+$LTTNG_BIN start
+
+echo "Sleeping..."
+sleep 10
+
+echo "Crashing..."
+$(dirname $0)/crash
+
+echo "Sleeping..."
+sleep 10
+
+$LTTNG_BIN stop
+$LTTNG_BIN destroy
+
+echo "Core dump and snapshot should hopefully be available in /tmp/lttng/{core,snapshot}."
-- 
1.8.3.2
