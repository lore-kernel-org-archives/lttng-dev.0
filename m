From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 0/8] Fix racy lttng-tools tests
Date: Wed, 19 Nov 2014 22:40:24 +0100
Message-ID: <1416433232-20080-1-git-send-email-mathieu.desnoyers__23105.1652030603$1416433293$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XrCzX-0002NG-F1
 for lttng-dev@lists.lttng.org; Wed, 19 Nov 2014 16:40:50 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Mathieu Desnoyers (8):
  Fix: tests: don't use pidof to wait for test apps
  Fix: test flaky sleep and wait patterns
  Document test anti-patterns
  Fix: tests: add missing wait, document missing synchro
  Fix: high throughput test: reset bw limit on sigterm
  Fix: tests: remove killall, add missing SIGTERM handlers
  Fix: tests: wait output hide Terminate errors
  Fix: add missing synchronization point for before app test case

 tests/Makefile.am                                  |  2 +-
 tests/README                                       | 63 +++++++++++++++++
 tests/regression/tools/live/test_kernel            | 12 ++--
 tests/regression/tools/live/test_ust               | 12 ++--
 .../regression/tools/live/test_ust_tracefile_count | 12 ++--
 tests/regression/tools/mi/test_mi                  |  6 +-
 .../regression/tools/snapshots/test_ust_streaming  | 45 +++++++------
 tests/regression/tools/snapshots/ust_test          | 28 +++++---
 .../tools/streaming/test_high_throughput_limits    | 16 ++---
 tests/regression/tools/streaming/test_kernel       |  7 --
 tests/regression/tools/streaming/test_ust          | 26 +++++++-
 .../regression/ust/before-after/test_before_after  | 14 +++-
 tests/regression/ust/buffers-pid/test_buffers_pid  | 50 ++++++++------
 .../ust/high-throughput/test_high_throughput       |  9 ++-
 tests/regression/ust/java-jul/test_java_jul        | 19 +++++-
 tests/regression/ust/java-log4j/test_java_log4j    | 19 ++++--
 .../ust/multi-session/test_multi_session           |  2 +-
 tests/regression/ust/nprocesses/test_nprocesses    | 37 ++++++----
 tests/regression/ust/overlap/test_overlap          |  3 +-
 .../test_periodical_metadata_flush                 | 78 ++++++++++++++++------
 .../ust/python-logging/test_python_logging         | 10 ++-
 tests/stress/test_multi_sessions_per_uid_10app     | 13 ++--
 .../test_multi_sessions_per_uid_5app_streaming     | 13 ++--
 ...lti_sessions_per_uid_5app_streaming_kill_relayd | 20 ++++--
 .../utils/testapp/gen-ust-events/gen-ust-events.c  | 71 ++++++++++++++++----
 tests/utils/utils.sh                               |  2 +-
 26 files changed, 411 insertions(+), 178 deletions(-)
 create mode 100644 tests/README

-- 
2.1.1
