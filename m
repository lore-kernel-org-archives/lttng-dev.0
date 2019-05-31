From: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
Subject: [PATCH lttng-tools] Tests: add optional test for
 setuid() wrapper
Date: Fri, 31 May 2019 17:41:35 -0400
Message-ID: <20190531214135.3041-1-gabriel.pollo-guilbert__45469.9444979028$1559338948$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45FyZp6b37zyWC
 for <lttng-dev@lists.lttng.org>; Fri, 31 May 2019 17:41:54 -0400 (EDT)
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
 .gitignore                                    |   1 +
 configure.ac                                  |   1 +
 tests/destructive/Makefile.am                 |   3 +
 tests/destructive/setuid-wrapper/Makefile.am  |   9 +
 .../destructive/setuid-wrapper/change_user.c  | 157 ++++++++++
 .../setuid-wrapper/test-setuid-wrapper        | 276 ++++++++++++++++++
 tests/destructive/setuid-wrapper/tp.c         |   2 +
 .../destructive/setuid-wrapper/tp_provider.h  |  36 +++
 8 files changed, 485 insertions(+)
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
index 6bf70b43..887c590c 100644
--- a/tests/destructive/Makefile.am
+++ b/tests/destructive/Makefile.am
@@ -1,3 +1,6 @@
+SUBDIRS = setuid-wrapper
+DIST_SUBDIRS = setuid-wrapper
+
 noinst_SCRIPTS = metadata-regeneration
 EXTRA_DIST = metadata-regeneration
 
diff --git a/tests/destructive/setuid-wrapper/Makefile.am b/tests/destructive/setuid-wrapper/Makefile.am
new file mode 100644
index 00000000..08735e6c
--- /dev/null
+++ b/tests/destructive/setuid-wrapper/Makefile.am
@@ -0,0 +1,9 @@
+AM_CPPFLAGS += -I$(srcdir)
+
+noinst_PROGRAMS = change_user
+
+change_user_SOURCES = change_user.c tp.c
+change_user_LDADD = -llttng-ust -llttng-ust-setuid $(DL_LIBS)
+
+noinst_SCRIPTS = test-setuid-wrapper
+
diff --git a/tests/destructive/setuid-wrapper/change_user.c b/tests/destructive/setuid-wrapper/change_user.c
new file mode 100644
index 00000000..99c9d28d
--- /dev/null
+++ b/tests/destructive/setuid-wrapper/change_user.c
@@ -0,0 +1,157 @@
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
+#include <sys/capability.h>
+
+#define TRACEPOINT_DEFINE
+#include "tp_provider.h"
+
+int call_setuid(int argc, char** argv)
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
+int call_seteuid(int argc, char** argv)
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
+int call_setreuid(int argc, char** argv)
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
+int call_setresuid(int argc, char** argv)
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
+	if (strcmp("setuid", call_func) == 0) {
+		ret = call_setuid(call_params_count, call_params);
+	} else if (strcmp("seteuid", call_func) == 0) {
+		ret = call_seteuid(call_params_count, call_params);
+	} else if (strcmp("setreuid", call_func) == 0) {
+		ret = call_setreuid(call_params_count, call_params);
+	} else if (strcmp("setresuid", call_func) == 0) {
+		ret = call_setresuid(call_params_count, call_params);
+	} else {
+		fprintf(stderr, "%s: %s is not a valid call\n", argv[0], argv[1]);
+		exit(1);
+	}
+
+	/* All of these system calls return -1 and set errno on error. */
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
index 00000000..3a928733
--- /dev/null
+++ b/tests/destructive/setuid-wrapper/test-setuid-wrapper
@@ -0,0 +1,276 @@
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
+TEST_USER1=alice
+TEST_USER2=bob
+ROOT_USER=root
+
+TEST_PROGRAM=./change_user
+
+SESSION_NAME=test-session
+CHANNEL_NAME=test-channel
+
+LIB_LTTNG_UST_SETUID=$(ldconfig -p | grep liblttng-ust-setuid.so | tail -n1 | sed 's/.*=> \(.*\)/\1/g')
+
+TP_BEFORE="setuid_wrapper:before"
+TP_AFTER="setuid_wrapper:after"
+
+TESTDIR=$(dirname "$0")/../..
+TESTCOUNT=272
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
+
+	local uid_expected=$(id -u "$username")
+	local msg="$tracepoint tracepoint should be in $username's ($uid_expected) trace"
+
+	local trace_dir_uid="$trace_dir/ust/uid/$uid_expected/"
+	local event_count=$(babeltrace "$trace_dir_uid" | grep -c "$tracepoint")
+	if [[ ! $event_count -eq 1 ]]; then
+		fail "$msg"
+	fi
+
+	local uid_field=$(babeltrace "$trace_dir_uid" | grep "$tracepoint" | sed 's/.*{ uid = \(.*\) }.*/\1/g')
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
+function add_capability()
+{
+	setcap CAP_SETUID+ep $TEST_PROGRAM
+}
+
+function setup_user()
+{
+	local username=$1
+
+	if ! id -u "$username" 2> /dev/null > /dev/null; then
+		useradd "$username"
+	fi
+
+	if groups "$username" | grep -q tracing; then
+		usermod -a -G tracing "$username"
+	fi
+}
+
+function setup_users()
+{
+	setup_user $TEST_USER1
+	setup_user $TEST_USER2
+}
+
+function start_tracing_session()
+{
+	local trace_path=$1
+
+	create_lttng_session_ok $SESSION_NAME "$trace_path"
+	enable_ust_lttng_channel_ok $SESSION_NAME $CHANNEL_NAME "--buffers-uid"
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
+
+	local uid_before=$(id -u "$expected_user_before")
+
+	diag "Test $command($args) as $expected_user_before ($uid_before)"
+
+	local trace_dir=$(mktemp -d)
+	start_tracing_session "$trace_dir"
+
+	su "$expected_user_before" -c "LD_PRELOAD=$LIB_LTTNG_UST_SETUID $TEST_PROGRAM $command $args"
+
+	local trace_count=$(find "$trace_dir" -maxdepth 3 -mindepth 3 | wc -l)
+	if [[ "$expected_user_before" == "$expected_user_after" ]]; then
+		local msg="$command($args) as $expected_user_before ($uid_before) should generate one trace"
+		assert_eq "$msg" 1 "$trace_count"
+	else
+		local msg="$command($args) as $expected_user_before ($uid_before) should generate two traces"
+		assert_eq "$msg" 2 "$trace_count"
+	fi
+
+	stop_lttng_tracing_ok $SESSION_NAME
+
+	assert_before "$trace_dir" "$expected_user_before"
+	assert_after "$trace_dir" "$expected_user_after"
+
+	destroy_lttng_session_ok $SESSION_NAME
+}
+
+function test_setuid()
+{
+	local expected_user_before=$1
+	local expected_user_after=$2
+	local arg_uid=$(id -u "$2")
+
+	test_program setuid "$expected_user_before" "$expected_user_after" "$arg_uid"
+}
+
+function test_seteuid()
+{
+	local expected_user_before=$1
+	local expected_user_after=$expected_user_before
+	local arg_euid=$(id -u "$2")
+
+	test_program seteuid "$expected_user_before" "$expected_user_after" "$arg_euid"
+}
+
+function test_setreuid()
+{
+	local expected_user_before=$1
+	local expected_user_after=$2
+	local arg_ruid=$(id -u "$2")
+	local arg_euid=$(id -u "$3")
+
+	test_program setreuid "$expected_user_before" "$expected_user_after" "$arg_ruid $arg_euid"
+}
+
+function test_setresuid()
+{
+	local expected_user_before=$1
+	local expected_user_after=$2
+	local arg_ruid=$(id -u "$2")
+	local arg_euid=$(id -u "$3") 
+	local arg_suid=$(id -u "$4")
+
+	test_program setresuid "$expected_user_before" "$expected_user_after" "$arg_ruid" "$arg_euid" "$arg_suid"
+}
+
+function setup_test_bench()
+{
+	add_capability
+	setup_users
+	start_lttng_sessiond
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
+	setup_test_bench
+	run_tests
+	teardown_test_bench
+}
+
+
diff --git a/tests/destructive/setuid-wrapper/tp.c b/tests/destructive/setuid-wrapper/tp.c
new file mode 100644
index 00000000..97197006
--- /dev/null
+++ b/tests/destructive/setuid-wrapper/tp.c
@@ -0,0 +1,2 @@
+#define TRACEPOINT_CREATE_PROBES
+#include "tp_provider.h"
diff --git a/tests/destructive/setuid-wrapper/tp_provider.h b/tests/destructive/setuid-wrapper/tp_provider.h
new file mode 100644
index 00000000..21f893c9
--- /dev/null
+++ b/tests/destructive/setuid-wrapper/tp_provider.h
@@ -0,0 +1,36 @@
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
2.21.0
