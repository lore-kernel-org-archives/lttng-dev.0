From: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
Subject: [PATCH lttng-tools v2] Tests: add optional test for
 setuid() wrapper
Date: Tue, 11 Jun 2019 16:27:52 -0400
Message-ID: <20190611202752.19231-1-gabriel.pollo-guilbert__17903.1516004883$1560284935$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45NhR25w4hz10Jm
 for <lttng-dev@lists.lttng.org>; Tue, 11 Jun 2019 16:28:30 -0400 (EDT)
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

This test requires liblttng-ust-setuid library wrapper around the family of
setuid() system calls. In per-UID mode, it makes sure that events following
one of these system calls are put in the correct buffers.

The test is destructive as it may add new users to the system and modify
their groups. It requires the LTTNG_ENABLE_DESTRUCTIVE_TESTS environment
variable to be set to "will-break-my-system".

Signed-off-by: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
---
Changes since v1:
* autotools:
  - add `HAVE_LIBLTTNG_USTCTL` check
  - remove `-llttng-ust-setuid` build flag
* test-setuid-wrapper:
  - namespace test users
  - abort if the users already exist
  - create and delete test users
  - add `--no-create-home` and `--no-create-user-group` to useradd command
  - create (and remove) tracing group if needed
  - set (and clear) SUID bit to liblttng-ust-setuid.so
  - run the test suite with PID buffers and expect single trace output
  - fix shellcheck warnings
  - cleanup and exit when SIGINT is received
* change_user.c
  - add license
  - add upper bound to argc
  - replace strcmp() with strncmp()
---
 .gitignore                                    |   1 +
 configure.ac                                  |   1 +
 tests/destructive/Makefile.am                 |   5 +
 tests/destructive/setuid-wrapper/Makefile.am  |  10 +
 .../destructive/setuid-wrapper/change_user.c  | 167 ++++++++
 .../setuid-wrapper/test-setuid-wrapper        | 369 ++++++++++++++++++
 tests/destructive/setuid-wrapper/tp.c         |  20 +
 .../destructive/setuid-wrapper/tp_provider.h  |  54 +++
 8 files changed, 627 insertions(+)
 create mode 100644 tests/destructive/setuid-wrapper/Makefile.am
 create mode 100644 tests/destructive/setuid-wrapper/change_user.c
 create mode 100755 tests/destructive/setuid-wrapper/test-setuid-wrapper
 create mode 100644 tests/destructive/setuid-wrapper/tp.c
 create mode 100644 tests/destructive/setuid-wrapper/tp_provider.h

diff --git a/.gitignore b/.gitignore
index b5d2a55a..a86c13b4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -88,6 +88,7 @@ gen-events-time
 gen-events
 gen-ust-events
 health_check
+/tests/destructive/setuid-wrapper/change_user
 /tests/regression/kernel/select_poll_epoll
 /tests/regression/tools/mi/extract_xml
 /tests/regression/tools/mi/validate_xml
diff --git a/configure.ac b/configure.ac
index 214d58ac..55b3b11f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1113,6 +1113,7 @@ AC_CONFIG_FILES([
 	src/bin/lttng-crash/Makefile
 	tests/Makefile
 	tests/destructive/Makefile
+	tests/destructive/setuid-wrapper/Makefile
 	tests/regression/Makefile
 	tests/regression/kernel/Makefile
 	tests/regression/tools/Makefile
diff --git a/tests/destructive/Makefile.am b/tests/destructive/Makefile.am
index 6bf70b43..5ac25530 100644
--- a/tests/destructive/Makefile.am
+++ b/tests/destructive/Makefile.am
@@ -1,3 +1,8 @@
+if HAVE_LIBLTTNG_UST_CTL
+SUBDIRS = setuid-wrapper
+DIST_SUBDIRS = setuid-wrapper
+endif
+
 noinst_SCRIPTS = metadata-regeneration
 EXTRA_DIST = metadata-regeneration
 
diff --git a/tests/destructive/setuid-wrapper/Makefile.am b/tests/destructive/setuid-wrapper/Makefile.am
new file mode 100644
index 00000000..3f1329ce
--- /dev/null
+++ b/tests/destructive/setuid-wrapper/Makefile.am
@@ -0,0 +1,10 @@
+if HAVE_LIBLTTNG_UST_CTL
+AM_CPPFLAGS += -I$(srcdir)
+
+noinst_PROGRAMS = change_user
+
+change_user_SOURCES = change_user.c tp.c
+change_user_LDADD = -llttng-ust $(DL_LIBS)
+
+noinst_SCRIPTS = test-setuid-wrapper
+endif
diff --git a/tests/destructive/setuid-wrapper/change_user.c b/tests/destructive/setuid-wrapper/change_user.c
new file mode 100644
index 00000000..fb207140
--- /dev/null
+++ b/tests/destructive/setuid-wrapper/change_user.c
@@ -0,0 +1,167 @@
+/*
+ * Copyright (c) - 2019 Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * as published by the Free Software Foundation; only version 2
+ * of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+
+#define TRACEPOINT_DEFINE
+#include "tp_provider.h"
+
+#define CMD_SETUID    "setuid"
+#define CMD_SETEUID   "seteuid"
+#define CMD_SETREUID  "setreuid"
+#define CMD_SETRESUID "setresuid"
+#define CMD_MAX_LENGTH sizeof(CMD_SETRESUID)
+
+static int call_setuid(int argc, char** argv)
+{
+	uid_t uid;
+
+	if (argc != 1) {
+		fprintf(stderr, "Usage: setuid UID\n");
+		exit(1);
+	}
+
+	if(sscanf(argv[0], "%u", &uid) == 0) {
+		fprintf(stderr, "sscanf: failed to parse UID=%s\n", argv[0]);
+		exit(1);
+	}
+
+	return setuid(uid);
+}
+
+static int call_seteuid(int argc, char** argv)
+{
+	uid_t uid;
+
+	if (argc != 1) {
+		fprintf(stderr, "Usage: seteuid UID\n");
+		exit(1);
+	}
+
+	if (sscanf(argv[0], "%u", &uid) == 0) {
+		fprintf(stderr, "sscanf: failed to parse UID=%s\n", argv[0]);
+		exit(1);
+	}
+
+	return seteuid(uid);
+}
+
+static int call_setreuid(int argc, char** argv)
+{
+	uid_t ruid, euid;
+
+	if (argc != 2) {
+		fprintf(stderr, "Usage: seteuid RUID EUID\n");
+		exit(1);
+	}
+
+	if (sscanf(argv[0], "%u", &ruid) == 0) {
+		fprintf(stderr, "sscanf: failed to parse RUID=%s\n", argv[0]);
+		exit(1);
+	}
+
+	if (sscanf(argv[1], "%u", &euid) == 0) {
+		fprintf(stderr, "sscanf: failed to parse EUID=%s\n", argv[1]);
+		exit(1);
+	}
+
+	return setreuid(ruid, euid);
+}
+
+static int call_setresuid(int argc, char** argv)
+{
+	uid_t ruid, euid, suid;
+
+	if (argc != 3) {
+		fprintf(stderr, "Usage: setresuid RUID EUID SUID\n");
+		exit(1);
+	}
+
+	if (sscanf(argv[0], "%u", &ruid) == 0) {
+		fprintf(stderr, "sscanf: failed to parse RUID=%s\n", argv[0]);
+		exit(1);
+	}
+
+	if (sscanf(argv[1], "%u", &euid) == 0) {
+		fprintf(stderr, "sscanf: failed to parse EUID=%s\n", argv[1]);
+		exit(1);
+	}
+
+	if (sscanf(argv[2], "%u", &suid) == 0) {
+		fprintf(stderr, "sscanf: failed to parse SUID=%s\n", argv[2]);
+		exit(1);
+	}
+
+	return setresuid(ruid, euid, suid);
+}
+
+int main(int argc, char** argv)
+{
+	char* call_func;
+	char** call_params;
+	int call_params_count, ret;
+
+	if (argc <= 1) {
+		fprintf(stderr, "Usage: %s CALL [OPTIONS]\n", argv[0]);
+		exit(1);
+	}
+
+	if (argc > 5) {
+		fprintf(stderr, "Error: too much parameter received\n");
+		exit(1);
+	}
+
+	call_func = argv[1];
+	call_params = &argv[2];
+	call_params_count = argc - 2;
+
+	tracepoint(setuid_wrapper, before, getuid());
+
+	/*
+	 * Under Linux, we could check that the program has the CAP_SETUID
+	 * capability, but the interface isn't standard and may change in the
+	 * future. If the program doesn't have the capability, the call will
+	 * simply fail with EPERM.
+	 */
+	if (strncmp(CMD_SETUID, call_func, CMD_MAX_LENGTH) == 0) {
+		ret = call_setuid(call_params_count, call_params);
+	} else if (strncmp(CMD_SETEUID, call_func, CMD_MAX_LENGTH) == 0) {
+		ret = call_seteuid(call_params_count, call_params);
+	} else if (strncmp(CMD_SETREUID, call_func, CMD_MAX_LENGTH) == 0) {
+		ret = call_setreuid(call_params_count, call_params);
+	} else if (strncmp(CMD_SETRESUID, call_func, CMD_MAX_LENGTH) == 0) {
+		ret = call_setresuid(call_params_count, call_params);
+	} else {
+		fprintf(stderr, "%s: %s is not a valid call\n", argv[0], argv[1]);
+		exit(1);
+	}
+
+	/* All of these last calls return -1 and set errno on error */
+	if (ret < 0) {
+		fprintf(stderr, "%s failed: %s\n", argv[1], strerror(errno));
+		exit(1);
+	}
+
+	tracepoint(setuid_wrapper, after, getuid());
+
+	return 0;
+}
diff --git a/tests/destructive/setuid-wrapper/test-setuid-wrapper b/tests/destructive/setuid-wrapper/test-setuid-wrapper
new file mode 100755
index 00000000..b0b60c8b
--- /dev/null
+++ b/tests/destructive/setuid-wrapper/test-setuid-wrapper
@@ -0,0 +1,369 @@
+#!/bin/bash
+#
+# Copyright (C) - 2019 Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
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
+#
+# WARNING: This test must be run with as a root. It adds a new user to the
+#          machine, changes their groups and then proceed to starts a global
+#          session daemon that record traces. It does not do any cleanup.
+
+TRACING_GROUP="tracing"
+TEST_USER1=test_destructive_setuid_user1
+TEST_USER2=test_destructive_setuid_user2
+ROOT_USER=root
+
+TEST_PROGRAM=./change_user
+
+SESSION_NAME=test-session
+CHANNEL_NAME=test-channel
+
+LIB_LTTNG_UST_SETUID=liblttng-ust-setuid.so
+LIB_LTTNG_UST_SETUID_PATH=$(ldconfig -p | grep $LIB_LTTNG_UST_SETUID | tail -n1 | sed 's/.*=> \(.*\)/\1/g')
+
+TP_BEFORE="setuid_wrapper:before"
+TP_AFTER="setuid_wrapper:after"
+
+TESTDIR=$(dirname "$0")/../..
+TESTCOUNT=488
+TESTDESC="Wrappers for setuid() system call family"
+
+source "$TESTDIR"/utils/utils.sh
+plan_tests $TESTCOUNT
+print_test_banner "$TESTDESC"
+
+function assert_eq()
+{
+	local msg=$1
+	local expected=$2
+	local got=$3
+
+	if [[ ! "$expected" == "$got" ]]; then
+		fail "$msg: expected=$expected, got=$got"
+	else
+		pass "$msg"
+	fi
+}
+
+function assert_tracepoint_in()
+{
+	local trace_dir=$1
+	local username=$2
+	local tracepoint=$3
+	local uid_expected
+	local uid_field
+	local msg
+	local trace_dir_uid
+	local event_count
+
+	uid_expected=$(id -u "$username")
+	msg="$tracepoint tracepoint should be in $username's ($uid_expected) trace"
+	trace_dir_uid="$trace_dir/ust/uid/$uid_expected/"
+	event_count=$(babeltrace "$trace_dir_uid" | grep -c "$tracepoint")
+
+	if [[ ! $event_count -eq 1 ]]; then
+		fail "$msg"
+	fi
+
+	uid_field=$(babeltrace "$trace_dir_uid" | grep "$tracepoint" | sed 's/.*{ uid = \(.*\) }.*/\1/g')
+	if [[ ! "$uid_field" == "$uid_expected" ]]; then
+		fail "$msg (UID mismatch)"
+	fi
+
+	pass "$msg"
+}
+
+function assert_before()
+{
+	local trace_dir=$1
+	local username=$2
+
+	assert_tracepoint_in "$trace_dir" "$username" $TP_BEFORE
+}
+
+function assert_after()
+{
+	local trace_dir=$1
+	local username=$2
+
+	assert_tracepoint_in "$trace_dir" "$username" $TP_AFTER
+}
+
+function check_if_user_exists()
+{
+	local username=$1
+
+	if id -u "$username" 2> /dev/null > /dev/null; then
+		echo "Unexpected system state. The $username shouldn't exist on the system."
+		exit 0
+	fi
+}
+
+function check_system_state()
+{
+	check_if_user_exists $TEST_USER1
+	check_if_user_exists $TEST_USER2
+}
+
+function setup_capabilities()
+{
+	local lib_path
+	local lib_dir
+
+	lib_path=$(readlink -f "$LIB_LTTNG_UST_SETUID_PATH")
+	lib_dir=$(dirname "$lib_path")
+
+	if ! find "$lib_dir" -perm -4000 | grep "$lib_path" > /dev/null; then
+		chmod +s "$lib_path"
+		REMOVE_SUID_BIT=1
+	else
+		REMOVE_SUID_BIT=0
+	fi
+
+	setcap CAP_SETUID+ep $TEST_PROGRAM
+}
+
+function cleanup_capabilities()
+{
+	local lib_path
+
+	lib_path=$(readlink -f "$LIB_LTTNG_UST_SETUID_PATH")
+	if [[ $REMOVE_SUID_BIT == 1 ]]; then
+		chmod -s "$lib_path"
+	fi
+
+	setcap CAP_SETUID-ep $TEST_PROGRAM
+}
+
+function setup_tracing_group()
+{
+	if ! grep -q $TRACING_GROUP /etc/group; then
+		groupadd $TRACING_GROUP
+		REMOVE_TRACING_GROUP=1
+	else
+		REMOVE_TRACING_GROUP=0
+	fi
+}
+
+function cleanup_tracing_group()
+{
+
+	if [[ $REMOVE_TRACING_GROUP -eq 1 ]]; then
+		groupdel $TRACING_GROUP
+	fi
+}
+
+function setup_users()
+{
+	useradd --no-user-group --no-create-home $TEST_USER1 -G $TRACING_GROUP
+	useradd --no-user-group --no-create-home $TEST_USER2 -G $TRACING_GROUP
+}
+
+function cleanup_users()
+{
+	userdel $TEST_USER1
+	userdel $TEST_USER2
+}
+
+function start_tracing_session()
+{
+	local trace_path=$1
+
+	create_lttng_session_ok $SESSION_NAME "$trace_path"
+	enable_ust_lttng_channel_ok $SESSION_NAME $CHANNEL_NAME "$BUFFERS_TYPE_ARG"
+	enable_ust_lttng_event_ok $SESSION_NAME $TP_BEFORE $CHANNEL_NAME
+	enable_ust_lttng_event_ok $SESSION_NAME $TP_AFTER $CHANNEL_NAME
+	start_lttng_tracing_ok $SESSION_NAME
+}
+
+function test_program()
+{
+	local command=$1
+	local expected_user_before=$2
+	local expected_user_after=$3
+	local args=${*:4}
+	local uid_before
+	local trace_dir
+	local trace_count
+	local msg
+
+	if [[ $BUFFERS_TYPE_ARG == "--buffers-pid" ]]; then
+		expected_user_after="$expected_user_before"
+	fi;
+
+	uid_before=$(id -u "$expected_user_before")
+	diag "Test $command($args) as $expected_user_before ($uid_before)"
+
+	trace_dir=$(mktemp -d)
+	start_tracing_session "$trace_dir"
+
+	su "$expected_user_before" -c "LD_PRELOAD=$LIB_LTTNG_UST_SETUID $TEST_PROGRAM $command $args"
+
+	trace_count=$(find "$trace_dir" -maxdepth 3 -mindepth 3 | wc -l)
+	if [[ "$expected_user_before" == "$expected_user_after" ]]; then
+		msg="$command($args) as $expected_user_before ($uid_before) should generate one trace"
+		assert_eq "$msg" 1 "$trace_count"
+	else
+		msg="$command($args) as $expected_user_before ($uid_before) should generate two traces"
+		assert_eq "$msg" 2 "$trace_count"
+	fi
+
+	stop_lttng_tracing_ok $SESSION_NAME
+
+	if [[ $BUFFERS_TYPE_ARG == "--buffers-uid" ]]; then
+		assert_before "$trace_dir" "$expected_user_before"
+		assert_after "$trace_dir" "$expected_user_after"
+	fi;
+
+	destroy_lttng_session_ok $SESSION_NAME
+}
+
+function test_setuid()
+{
+	local expected_user_before=$1
+	local expected_user_after=$2
+	local arg_uid
+
+	arg_uid=$(id -u "$2")
+	test_program setuid "$expected_user_before" "$expected_user_after" "$arg_uid"
+}
+
+function test_seteuid()
+{
+	local expected_user_before=$1
+	local expected_user_after=$expected_user_before
+	local arg_euid
+
+	arg_euid=$(id -u "$2")
+	test_program seteuid "$expected_user_before" "$expected_user_after" "$arg_euid"
+}
+
+function test_setreuid()
+{
+	local expected_user_before=$1
+	local expected_user_after=$2
+	local arg_ruid
+	local arg_euid
+
+	arg_ruid=$(id -u "$2")
+	arg_euid=$(id -u "$3")
+	test_program setreuid "$expected_user_before" "$expected_user_after" "$arg_ruid $arg_euid"
+}
+
+function test_setresuid()
+{
+	local expected_user_before=$1
+	local expected_user_after=$2
+	local arg_ruid
+	local arg_euid
+	local arg_suid
+
+	arg_ruid=$(id -u "$2")
+	arg_euid=$(id -u "$3")
+	arg_suid=$(id -u "$4")
+	test_program setresuid "$expected_user_before" "$expected_user_after" "$arg_ruid" "$arg_euid" "$arg_suid"
+}
+
+function setup_test_bench()
+{
+	setup_capabilities
+	setup_tracing_group
+	setup_users
+	start_lttng_sessiond
+
+	function sigint_handler()
+	{
+		teardown_test_bench
+		full_cleanup
+		exit
+	}
+
+	trap sigint_handler INT
+}
+
+function run_tests()
+{
+	# setuid() tests
+	test_setuid $TEST_USER1 "$TEST_USER1"
+	test_setuid $TEST_USER1 "$TEST_USER2"
+	test_setuid $TEST_USER1 "$ROOT_USER"
+
+	test_setuid $ROOT_USER $TEST_USER1
+	test_setuid $ROOT_USER $TEST_USER2
+	test_setuid $ROOT_USER $ROOT_USER
+
+	# seteuid() tests
+	test_seteuid $TEST_USER1 $TEST_USER1
+	test_seteuid $TEST_USER1 $TEST_USER2
+	test_seteuid $TEST_USER1 $ROOT_USER
+
+	test_seteuid $ROOT_USER $TEST_USER1
+	test_seteuid $ROOT_USER $TEST_USER2
+	test_seteuid $ROOT_USER $ROOT_USER
+
+	# setreuid() tests
+	test_setreuid $TEST_USER1 $TEST_USER1 $TEST_USER1
+	test_setreuid $TEST_USER1 $TEST_USER2 $TEST_USER2
+	test_setreuid $TEST_USER1 $ROOT_USER $ROOT_USER
+
+	test_setreuid $ROOT_USER $TEST_USER1 $TEST_USER1
+	test_setreuid $ROOT_USER $TEST_USER2 $TEST_USER2
+	test_setreuid $ROOT_USER $ROOT_USER $ROOT_USER
+
+	# setresuid() tests
+	test_setresuid $TEST_USER1 $TEST_USER1 $TEST_USER1 $TEST_USER1
+	test_setresuid $TEST_USER1 $TEST_USER1 $TEST_USER1 $TEST_USER2
+	test_setresuid $TEST_USER1 $TEST_USER1 $TEST_USER1 $ROOT_USER
+
+	test_setresuid $TEST_USER1 $TEST_USER2 $TEST_USER2 $TEST_USER1
+	test_setresuid $TEST_USER1 $TEST_USER2 $TEST_USER2 $TEST_USER2
+	test_setresuid $TEST_USER1 $TEST_USER2 $TEST_USER2 $ROOT_USER
+
+	test_setresuid $TEST_USER1 $ROOT_USER $ROOT_USER $TEST_USER1
+	test_setresuid $TEST_USER1 $ROOT_USER $ROOT_USER $TEST_USER2
+	test_setresuid $TEST_USER1 $ROOT_USER $ROOT_USER $ROOT_USER
+}
+
+function teardown_test_bench()
+{
+	stop_lttng_sessiond
+	cleanup_users
+	cleanup_tracing_group
+	cleanup_capabilities
+}
+
+if [ "$(id -u)" == "0" ]; then
+	IS_ROOT=1
+else
+	IS_ROOT=0
+fi
+
+if ! destructive_tests_enabled ; then
+	echo "You need to set the LTTNG_ENABLE_DESTRUCTIVE_TESTS to \"will-break-my-system\" as argument to run this test"
+	exit 0
+fi
+
+skip $IS_ROOT "Root access is needed. Skipping all tests." $TESTCOUNT ||
+{
+	check_system_state
+	setup_test_bench
+
+	BUFFERS_TYPE_ARG="--buffers-uid"
+	run_tests
+
+	BUFFERS_TYPE_ARG="--buffers-pid"
+	run_tests
+
+	teardown_test_bench
+}
diff --git a/tests/destructive/setuid-wrapper/tp.c b/tests/destructive/setuid-wrapper/tp.c
new file mode 100644
index 00000000..015a7f4f
--- /dev/null
+++ b/tests/destructive/setuid-wrapper/tp.c
@@ -0,0 +1,20 @@
+/*
+ * Copyright (c) - 2019 Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * as published by the Free Software Foundation; only version 2
+ * of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#define TRACEPOINT_CREATE_PROBES
+#include "tp_provider.h"
diff --git a/tests/destructive/setuid-wrapper/tp_provider.h b/tests/destructive/setuid-wrapper/tp_provider.h
new file mode 100644
index 00000000..e7b50d25
--- /dev/null
+++ b/tests/destructive/setuid-wrapper/tp_provider.h
@@ -0,0 +1,54 @@
+/*
+ * Copyright (c) - 2019 Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * as published by the Free Software Foundation; only version 2
+ * of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#undef TRACEPOINT_PROVIDER
+#define TRACEPOINT_PROVIDER setuid_wrapper
+
+#undef TRACEPOINT_INCLUDE
+#define TRACEPOINT_INCLUDE "./tp_provider.h"
+
+#if !defined(_TP_PROVIDER_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
+#define _TP_PROVIDER_H
+
+#include <lttng/tracepoint.h>
+
+TRACEPOINT_EVENT(
+	setuid_wrapper,
+	before,
+	TP_ARGS(
+		unsigned int, uid
+	),
+	TP_FIELDS(
+		ctf_integer(unsigned int, uid, uid)
+	)
+)
+
+TRACEPOINT_EVENT(
+	setuid_wrapper,
+	after,
+	TP_ARGS(
+		unsigned int, uid
+	),
+	TP_FIELDS(
+		ctf_integer(unsigned int, uid, uid)
+	)
+)
+
+#endif /* _TP_PROVIDER_H */
+
+#include <lttng/tracepoint-event.h>
-- 
2.22.0
