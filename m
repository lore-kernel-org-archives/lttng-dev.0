From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 00/13] lttng-tools leak fixes
Date: Wed, 17 Dec 2014 20:45:11 -0500
Message-ID: <1418867124-17343-1-git-send-email-mathieu.desnoyers__45890.5953252271$1418867179$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y1Q9n-0006Ad-Rm
 for lttng-dev@lists.lttng.org; Wed, 17 Dec 2014 20:45:37 -0500
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

This patchset fixes various leaks. The main reason for refactoring the
daemon main functions is to make it possible to use valgrind to spot
other leaks without being incumbered by process teardown leaks.

Mathieu Desnoyers (13):
  Fix: agents ht leaks on destroy session
  Fix: leak on UST buffer registry creation error
  Fix: ust app leak on UST buffer creation error
  Missing error handling: ust_app_ht_alloc should return error status
  Missing error handling: consumerd parse_args should return errors to
    caller
  Misleading error handling: utils_create_pid_file() should return 0 on
    success
  Cleanup: lttng-consumerd: remove stale TODO comment
  Cleanup: consumerd: use PERROR rather than perror
  Cleanup: consumerd: lines over 80 columns
  Missing error handling: consumer_signal_init should return its error
    status
  Refactor sessiond main/cleanup/ht-cleanup
  Refactor consumerd main/cleanup
  Refactor relayd main/set_options/cleanup

 src/bin/lttng-consumerd/lttng-consumerd.c | 286 +++++++----
 src/bin/lttng-relayd/live.c               | 127 +++--
 src/bin/lttng-relayd/live.h               |   5 +-
 src/bin/lttng-relayd/main.c               | 207 ++++----
 src/bin/lttng-sessiond/ht-cleanup.c       |  41 +-
 src/bin/lttng-sessiond/lttng-sessiond.h   |   4 +
 src/bin/lttng-sessiond/main.c             | 781 +++++++++++++++++++-----------
 src/bin/lttng-sessiond/trace-ust.c        |   2 +
 src/bin/lttng-sessiond/ust-app.c          |  35 +-
 src/bin/lttng-sessiond/ust-app.h          |   2 +-
 src/bin/lttng-sessiond/ust-registry.c     |   4 +-
 src/common/consumer-timer.c               |   4 +-
 src/common/consumer-timer.h               |   2 +-
 src/common/utils.c                        |   6 +-
 14 files changed, 963 insertions(+), 543 deletions(-)

-- 
2.1.1
