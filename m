From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 5/6] Tests: Cleanup tests runner
	that are no longer required
Date: Thu, 21 Mar 2013 15:56:46 -0400
Message-ID: <1363895807-17892-5-git-send-email-christian.babeux__7326.59539576179$1363895910$gmane$org@efficios.com>
References: <1363895807-17892-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UIlcL-0006j4-SU
	for lttng-dev@lists.lttng.org; Thu, 21 Mar 2013 15:57:42 -0400
Received: by mail-ie0-f178.google.com with SMTP id bn7so1516490ieb.23
	for <lttng-dev@lists.lttng.org>; Thu, 21 Mar 2013 12:57:36 -0700 (PDT)
In-Reply-To: <1363895807-17892-1-git-send-email-christian.babeux@efficios.com>
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

Test runners have been superseeded by testlists and the prove utility.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/regression/Makefile.am        |  2 +-
 tests/regression/kernel/Makefile.am |  2 +-
 tests/regression/kernel/run.sh      | 32 -------------------------
 tests/regression/run.sh             | 23 ------------------
 tests/regression/tools/Makefile.am  |  2 --
 tests/regression/tools/run.sh       | 39 ------------------------------
 tests/regression/ust/Makefile.am    |  2 +-
 tests/unit/Makefile.am              |  2 --
 tests/unit/run.sh                   | 34 --------------------------
 tests/utils/runner.sh               | 48 -------------------------------------
 10 files changed, 3 insertions(+), 183 deletions(-)
 delete mode 100755 tests/regression/kernel/run.sh
 delete mode 100755 tests/regression/run.sh
 delete mode 100755 tests/regression/tools/run.sh
 delete mode 100755 tests/unit/run.sh
 delete mode 100644 tests/utils/runner.sh

diff --git a/tests/regression/Makefile.am b/tests/regression/Makefile.am
index 3641cf1..ddb7372 100644
--- a/tests/regression/Makefile.am
+++ b/tests/regression/Makefile.am
@@ -1,6 +1,6 @@
 SUBDIRS = tools kernel ust
 
-EXTRA_DIST = run-report.py test_list.py run.sh
+EXTRA_DIST = run-report.py test_list.py
 
 if HAVE_LIBLTTNG_UST_CTL
 SUBDIRS += ust
diff --git a/tests/regression/kernel/Makefile.am b/tests/regression/kernel/Makefile.am
index cff432d..6b2b891 100644
--- a/tests/regression/kernel/Makefile.am
+++ b/tests/regression/kernel/Makefile.am
@@ -1 +1 @@
-EXTRA_DIST = run.sh test_event_basic test_all_events
+EXTRA_DIST = test_event_basic test_all_events
diff --git a/tests/regression/kernel/run.sh b/tests/regression/kernel/run.sh
deleted file mode 100755
index fe042e4..0000000
--- a/tests/regression/kernel/run.sh
+++ /dev/null
@@ -1,32 +0,0 @@
-#!/bin/bash
-#
-# Copyright (C) 2013 - Christian Babeux <christian.babeux@efficios.com>
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License
-# as published by the Free Software Foundation; only version 2
-# of the License.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
-#
-
-DIR=$(dirname $0)
-TESTDIR=$DIR/../..
-source $TESTDIR/utils/runner.sh
-
-#### ADD TESTS HERE ####
-
-tests=( $DIR/test_event_basic
-        $DIR/test_all_events )
-
-#### END TESTS HERE ####
-
-opts=("$@")
-run_tests tests[@] opts[@]
diff --git a/tests/regression/run.sh b/tests/regression/run.sh
deleted file mode 100755
index f0ea748..0000000
--- a/tests/regression/run.sh
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/bash
-#
-# Copyright (C) 2013 - Christian Babeux <christian.babeux@efficios.com>
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License
-# as published by the Free Software Foundation; only version 2
-# of the License.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
-#
-DIR=$(dirname $0)
-
-$DIR/kernel/run.sh $@
-$DIR/ust/run.sh $@
-$DIR/tools/run.sh $@
diff --git a/tests/regression/tools/Makefile.am b/tests/regression/tools/Makefile.am
index 9065a37..eef793a 100644
--- a/tests/regression/tools/Makefile.am
+++ b/tests/regression/tools/Makefile.am
@@ -1,3 +1 @@
 SUBDIRS = streaming filtering health
-
-EXTRA_DIST = run.sh
diff --git a/tests/regression/tools/run.sh b/tests/regression/tools/run.sh
deleted file mode 100755
index 4f7d2c9..0000000
--- a/tests/regression/tools/run.sh
+++ /dev/null
@@ -1,39 +0,0 @@
-#!/bin/bash
-#
-# Copyright (C) 2013 - Christian Babeux <christian.babeux@efficios.com>
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License
-# as published by the Free Software Foundation; only version 2
-# of the License.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
-#
-
-DIR=$(dirname $0)
-TESTDIR=$DIR/../..
-source $TESTDIR/utils/runner.sh
-
-#### ADD TESTS HERE ####
-
-tests=( $DIR/filtering/test_invalid_filter
-	$DIR/filtering/test_unsupported_op
-	$DIR/filtering/test_valid_filter
-	$DIR/health/test_thread_exit
-	$DIR/health/test_thread_stall
-	$DIR/health/test_tp_fail
-	$DIR/streaming/test_kernel
-	$DIR/streaming/test_ust
-	$DIR/streaming/test_high_throughput_limits )
-
-#### END TESTS HERE ####
-
-opts=("$@")
-run_tests tests[@] opts[@]
diff --git a/tests/regression/ust/Makefile.am b/tests/regression/ust/Makefile.am
index d8904bb..28256c6 100644
--- a/tests/regression/ust/Makefile.am
+++ b/tests/regression/ust/Makefile.am
@@ -2,6 +2,6 @@ if HAVE_LIBLTTNG_UST_CTL
 SUBDIRS = nprocesses high-throughput low-throughput before-after multi-session \
 		  overlap
 
-EXTRA_DIST = runall.sh run-ust-global-tests.sh test_event_basic test_event_wildcard
+EXTRA_DIST = test_event_basic test_event_wildcard
 
 endif
diff --git a/tests/unit/Makefile.am b/tests/unit/Makefile.am
index 1e4cce3..a9d65ab 100644
--- a/tests/unit/Makefile.am
+++ b/tests/unit/Makefile.am
@@ -14,8 +14,6 @@ LIBCOMMON=$(top_builddir)/src/common/libcommon.la
 LIBSESSIOND_COMM=$(top_builddir)/src/common/sessiond-comm/libsessiond-comm.la
 LIBHASHTABLE=$(top_builddir)/src/common/hashtable/libhashtable.la
 
-EXTRA_DIST = run.sh
-
 if HAVE_LIBLTTNG_UST_CTL
 noinst_PROGRAMS = test_uri test_session test_ust_data test_kernel_data
 else
diff --git a/tests/unit/run.sh b/tests/unit/run.sh
deleted file mode 100755
index a809e24..0000000
--- a/tests/unit/run.sh
+++ /dev/null
@@ -1,34 +0,0 @@
-#!/bin/bash
-#
-# Copyright (C) 2013 - Christian Babeux <christian.babeux@efficios.com>
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License
-# as published by the Free Software Foundation; only version 2
-# of the License.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
-#
-
-DIR=$(dirname $0)
-TESTDIR=$DIR/..
-source $TESTDIR/utils/runner.sh
-
-#### ADD TESTS HERE ####
-
-tests=( $DIR/test_uri
-        $DIR/test_session
-	$DIR/test_ust_data
-	$DIR/test_kernel_data )
-
-#### END TESTS HERE ####
-
-opts=("$@")
-run_tests tests[@] opts[@]
diff --git a/tests/utils/runner.sh b/tests/utils/runner.sh
deleted file mode 100644
index 8f4932a..0000000
--- a/tests/utils/runner.sh
+++ /dev/null
@@ -1,48 +0,0 @@
-#!/bin/bash
-#
-# Copyright (C) 2013 - Christian Babeux <christian.babeux@efficios.com>
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License
-# as published by the Free Software Foundation; only version 2
-# of the License.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
-#
-
-function run_tests
-{
-	declare -a tests=("${!1}")
-	declare -a tests_opts=("${!2}")
-
-	gentap=0
-
-	for test_opt in ${tests_opts[@]};
-	do
-	    case "$test_opt" in
-		--generate-tap-files) gentap=1 ;;
-		*) ;;
-	    esac
-	done
-
-	for bin in ${tests[@]};
-	do
-		if [ ! -e $bin ]; then
-			echo -e "$bin not found, skipping."
-			continue
-		fi
-
-		if [ "$gentap" -eq 1 ]; then
-			./$bin > ${bin}.tap 2>&1
-		else
-			./$bin
-		fi
-	done
-}
-- 
1.8.1.3
