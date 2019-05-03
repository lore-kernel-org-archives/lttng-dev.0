From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 0/9] lttng-tools fixes
Date: Fri,  3 May 2019 09:55:38 -0400
Message-ID: <20190503135547.12968-1-mathieu.desnoyers__43804.3510935799$1556912267$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44wYZ73rPhz1KYw
 for <lttng-dev@lists.lttng.org>; Fri,  3 May 2019 09:55:59 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, joraj@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a series of fixes to the lttng-tools tests to properly
teardown on ctrl-c. It also changes the uses of select() to
the lttng poll compat layer.

Thanks,

Mathieu

Mathieu Desnoyers (9):
  Improve handling of test SIGTERM/SIGINT
  Fix: tests: error handling in high throughput limits test
  Fix: utils.sh: handle SIGPIPE
  Fix: test: utils.sh: exit from process on full_cleanup
  Cleanup: test: don't stop relayd twice
  tests: invoke full_cleanup from script trap handlers, use modprobe -r
  epoll/poll compat: expose interruptible API
  lttng-ctl: notifications: use epoll()/poll() instead of select()
  sessiond: use epoll()/poll() instead of select()

 src/bin/lttng-sessiond/lttng-sessiond.h            |   2 +-
 src/bin/lttng-sessiond/main.c                      |   2 +-
 src/bin/lttng-sessiond/thread-utils.c              |  39 ++---
 src/common/compat/compat-epoll.c                   |   9 +-
 src/common/compat/compat-poll.c                    |   9 +-
 src/common/compat/poll.h                           |  12 +-
 src/lib/lttng-ctl/channel.c                        |  76 ++++----
 tests/regression/kernel/test_clock_override        |  10 +-
 .../regression/kernel/test_rotation_destroy_flush  |   7 +-
 tests/regression/tools/crash/test_crash            |   3 +-
 tests/regression/tools/live/test_lttng_ust         |   3 +-
 .../tools/notification/test_notification_kernel    |   2 +-
 .../tools/notification/test_notification_multi_app |   2 +-
 .../tools/notification/test_notification_ust       |   2 +-
 .../tools/streaming/test_high_throughput_limits    |  33 +++-
 .../test_rotation_destroy_flush                    |   3 +-
 tests/stress/test_multi_sessions_per_uid_10app     |   5 +-
 .../test_multi_sessions_per_uid_5app_streaming     |   5 +-
 ...lti_sessions_per_uid_5app_streaming_kill_relayd |   5 +-
 tests/utils/utils.sh                               | 193 ++++++++++++++++-----
 20 files changed, 276 insertions(+), 146 deletions(-)

-- 
2.11.0
