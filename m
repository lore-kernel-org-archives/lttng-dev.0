From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [PATCH lttng-tools 0/8] Change in poll compat layer
Date: Tue, 19 Mar 2019 17:17:27 -0400
Message-ID: <20190319211735.7187-1-ylamarre__322.239070531793$1553030314$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44P5VZ1bxVz17b5
 for <lttng-dev@lists.lttng.org>; Tue, 19 Mar 2019 17:17:42 -0400 (EDT)
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
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

This patch set fixes previously unreported bug in the poll/epoll compatibility
layer. It adds a unit test to the same compatibility layer and a few behaviour
changes to the poll flavor to match the epoll flavor.

Yannick Lamarre (8):
  Fix: lttng_poll_mod calls compat_(e)poll_add
  Add Unit test to poll compatibility layer
  Change LTTNG_POLL_GETNB behaviour for poll flavor
  Adapt poll layer behaviour to match the epoll layer
  Fix hang in thread_rotation when using compat-poll
  Change lttng_poll_wait behaviour of compat-poll to match compat-epoll
  Clean code base from redundant verification
  Fix typo

 .gitignore                                   |   1 +
 src/bin/lttng-consumerd/health-consumerd.c   |   5 -
 src/bin/lttng-relayd/health-relayd.c         |   5 -
 src/bin/lttng-relayd/live.c                  |  10 --
 src/bin/lttng-relayd/main.c                  |  16 --
 src/bin/lttng-sessiond/agent-thread.c        |   5 -
 src/bin/lttng-sessiond/client.c              |   5 -
 src/bin/lttng-sessiond/dispatch.c            |   5 -
 src/bin/lttng-sessiond/health.c              |   5 -
 src/bin/lttng-sessiond/ht-cleanup.c          |   5 -
 src/bin/lttng-sessiond/manage-apps.c         |   5 -
 src/bin/lttng-sessiond/manage-consumer.c     |  10 --
 src/bin/lttng-sessiond/manage-kernel.c       |   5 -
 src/bin/lttng-sessiond/notification-thread.c |   3 -
 src/bin/lttng-sessiond/notify-apps.c         |   5 -
 src/bin/lttng-sessiond/register.c            |   5 -
 src/common/compat/compat-poll.c              |  54 ++++--
 src/common/compat/poll.h                     |  13 +-
 src/common/consumer/consumer.c               |  10 --
 tests/unit/Makefile.am                       |   9 +-
 tests/unit/test_utils_compat_poll.c          | 246 +++++++++++++++++++++++++++
 21 files changed, 305 insertions(+), 122 deletions(-)
 create mode 100644 tests/unit/test_utils_compat_poll.c

-- 
2.11.0
