From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 4/6] Tests: Use Perl prove as the
	testsuite runner
Date: Thu, 21 Mar 2013 15:56:45 -0400
Message-ID: <1363895807-17892-4-git-send-email-christian.babeux__17294.195170007$1363895900$gmane$org@efficios.com>
References: <1363895807-17892-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UIlcF-0006i3-Lz
	for lttng-dev@lists.lttng.org; Thu, 21 Mar 2013 15:57:35 -0400
Received: by mail-ia0-f174.google.com with SMTP id b35so2891364iac.33
	for <lttng-dev@lists.lttng.org>; Thu, 21 Mar 2013 12:57:30 -0700 (PDT)
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

Currently the regression and unit testsuites are runned via a custom
runner script. By using the Perl prove utility, we can run the testsuites
and also gain additionnal features such as: parallel jobs, separate testlists,
etc.

This commit modify the make check target to run Perl prove as the testsuite
runner.

Testlist:

tests/unit_tests      : unit tests.
tests/fast_regression : a fast regression testsuite.
tests/long_regression : a long regression testsuite (includes slow tests such
                        as test_low_throughput and others).
tests/root_regression : a testsuite for tests that need root access
		        (mostly tests using lttng-modules and bandwith limits).

Running a testsuite:

$ cd lttng-tools/tests
$ ./run.sh <testsuite>

One can also run tests manually using prove:

$ prove --exec '' path/to/test

  OR

$ prove --exec '' - < testlist

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 .gitignore            |  1 -
 tests/Makefile.am     |  4 +++-
 tests/fast_regression | 14 ++++++++++++++
 tests/long_regression | 16 ++++++++++++++++
 tests/root_regression |  4 ++++
 tests/run.sh          |  6 +++---
 tests/unit_tests      |  4 ++++
 7 files changed, 44 insertions(+), 5 deletions(-)
 create mode 100644 tests/fast_regression
 create mode 100644 tests/long_regression
 create mode 100644 tests/root_regression
 create mode 100644 tests/unit_tests

diff --git a/.gitignore b/.gitignore
index ac72bf4..ee58252 100644
--- a/.gitignore
+++ b/.gitignore
@@ -62,7 +62,6 @@ gen-nevents
 gen-events-time
 gen-events
 gen-ust-events
-unit_tests
 health_check
 tests/regression/ust/overlap/demo/demo
 
diff --git a/tests/Makefile.am b/tests/Makefile.am
index b75de49..c53b2d8 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -1,4 +1,6 @@
 SUBDIRS = utils regression unit
 
 check-am:
-	./run.sh
+	./run.sh unit_tests
+	./run.sh fast_regression
+
diff --git a/tests/fast_regression b/tests/fast_regression
new file mode 100644
index 0000000..fb4ac60
--- /dev/null
+++ b/tests/fast_regression
@@ -0,0 +1,14 @@
+regression/tools/filtering/test_invalid_filter
+regression/tools/filtering/test_unsupported_op
+regression/tools/filtering/test_valid_filter
+regression/tools/health/test_thread_exit
+regression/tools/health/test_thread_stall
+regression/tools/health/test_tp_fail
+regression/tools/streaming/test_ust
+regression/ust/before-after/test_before_after
+regression/ust/buffers-uid/test_buffers_uid
+regression/ust/multi-session/test_multi_session
+regression/ust/nprocesses/test_nprocesses
+regression/ust/overlap/test_overlap
+regression/ust/test_event_basic
+regression/ust/test_event_wildcard
diff --git a/tests/long_regression b/tests/long_regression
new file mode 100644
index 0000000..8bae843
--- /dev/null
+++ b/tests/long_regression
@@ -0,0 +1,16 @@
+regression/tools/filtering/test_invalid_filter
+regression/tools/filtering/test_unsupported_op
+regression/tools/filtering/test_valid_filter
+regression/tools/health/test_thread_exit
+regression/tools/health/test_thread_stall
+regression/tools/health/test_tp_fail
+regression/tools/streaming/test_ust
+regression/ust/before-after/test_before_after
+regression/ust/buffers-uid/test_buffers_uid
+regression/ust/high-throughput/test_high_throughput
+regression/ust/low-throughput/test_lo_throughput
+regression/ust/multi-session/test_multi_session
+regression/ust/nprocesses/test_nprocesses
+regression/ust/overlap/test_overlap
+regression/ust/test_event_basic
+regression/ust/test_event_wildcard
diff --git a/tests/root_regression b/tests/root_regression
new file mode 100644
index 0000000..2ae884d
--- /dev/null
+++ b/tests/root_regression
@@ -0,0 +1,4 @@
+regression/kernel/test_all_events
+regression/kernel/test_event_basic
+regression/tools/streaming/test_high_throughput_limits
+regression/tools/streaming/test_kernel
diff --git a/tests/run.sh b/tests/run.sh
index d63c72b..c6c50fd 100755
--- a/tests/run.sh
+++ b/tests/run.sh
@@ -16,7 +16,7 @@
 # along with this program; if not, write to the Free Software
 # Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 #
-DIR=$(dirname $0)
 
-$DIR/regression/run.sh $@
-$DIR/unit/run.sh $@
+[ -z "$1" ] && echo "Error: No testlist. Please specify a testlist to run." && exit 1
+
+prove --merge --exec '' - < $1
diff --git a/tests/unit_tests b/tests/unit_tests
new file mode 100644
index 0000000..d7c68b6
--- /dev/null
+++ b/tests/unit_tests
@@ -0,0 +1,4 @@
+unit/test_kernel_data
+unit/test_session
+unit/test_uri
+unit/test_ust_data
-- 
1.8.1.3
