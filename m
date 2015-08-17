From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 0/4] Fixes for stability of lttng
	tools
Date: Mon, 17 Aug 2015 11:12:06 -0700
Message-ID: <1439835130-8852-1-git-send-email-mathieu.desnoyers__13688.2874569439$1439835202$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZROtT-0000qP-5V
 for lttng-dev@lists.lttng.org; Mon, 17 Aug 2015 14:12:25 -0400
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

With the fixes within this series, I can successfully run a stress-test
of:

- 3 loops, each spawning short-lived, UST-traced apps,
- 2 loops, each creating short-lived sessions, using tracefile rotation.
- 2 loops, each spawning babeltrace lttng-live view on their respective
  session (+1 loop trying to attach to the same session as the first).

So far, it survives very well 30+ minutes without complaining.

I did the following verifications too: that lttng-relayd ran under those
workloads with valgrind does not leak.

It passes tools make check, root regression and long regression tests on
the CI.

Mathieu Desnoyers (4):
  Fix: sessiond vs consumerd push/get metadata deadlock
  Fix: sessiond ust-app session teardown race
  Fix: sessiond should not error on channel creation vs app exit
  Fix: Relay daemon ownership and reference counting

 doc/Makefile.am                        |    3 +-
 doc/relayd-architecture.txt            |   96 +++
 src/bin/lttng-relayd/Makefile.am       |    4 +-
 src/bin/lttng-relayd/cmd-2-1.c         |   17 +-
 src/bin/lttng-relayd/cmd-2-1.h         |   10 +-
 src/bin/lttng-relayd/cmd-2-2.c         |   22 +-
 src/bin/lttng-relayd/cmd-2-2.h         |   10 +-
 src/bin/lttng-relayd/cmd-2-4.c         |   19 +-
 src/bin/lttng-relayd/cmd-2-4.h         |   10 +-
 src/bin/lttng-relayd/cmd-generic.c     |    1 +
 src/bin/lttng-relayd/cmd-generic.h     |    7 +-
 src/bin/lttng-relayd/cmd.h             |    7 +-
 src/bin/lttng-relayd/connection.c      |  128 ++--
 src/bin/lttng-relayd/connection.h      |   63 +-
 src/bin/lttng-relayd/ctf-trace.c       |  198 +++---
 src/bin/lttng-relayd/ctf-trace.h       |   66 +-
 src/bin/lttng-relayd/index.c           |  342 +++++++---
 src/bin/lttng-relayd/index.h           |   60 +-
 src/bin/lttng-relayd/live.c            | 1049 ++++++++++++++--------------
 src/bin/lttng-relayd/live.h            |   10 +-
 src/bin/lttng-relayd/lttng-relayd.h    |   23 +-
 src/bin/lttng-relayd/main.c            | 1167 +++++++++++++-------------------
 src/bin/lttng-relayd/session.c         |  214 +++---
 src/bin/lttng-relayd/session.h         |  116 ++--
 src/bin/lttng-relayd/stream-fd.c       |   58 ++
 src/bin/lttng-relayd/stream-fd.h       |   32 +
 src/bin/lttng-relayd/stream.c          |  343 ++++++++--
 src/bin/lttng-relayd/stream.h          |  130 ++--
 src/bin/lttng-relayd/utils.h           |    7 +-
 src/bin/lttng-relayd/viewer-session.c  |  164 +++++
 src/bin/lttng-relayd/viewer-session.h  |   53 ++
 src/bin/lttng-relayd/viewer-stream.c   |  325 +++++----
 src/bin/lttng-relayd/viewer-stream.h   |   83 ++-
 src/bin/lttng-sessiond/consumer.c      |    7 +-
 src/bin/lttng-sessiond/ust-app.c       |  239 +++++--
 src/bin/lttng-sessiond/ust-app.h       |    8 +-
 src/bin/lttng-sessiond/ust-consumer.c  |    5 +-
 src/common/index/ctf-index.h           |    2 +-
 src/common/index/index.c               |   13 +
 src/common/ust-consumer/ust-consumer.c |    9 +
 src/common/utils.c                     |  109 ++-
 src/common/utils.h                     |    2 +
 42 files changed, 3111 insertions(+), 2120 deletions(-)
 create mode 100644 doc/relayd-architecture.txt
 create mode 100644 src/bin/lttng-relayd/stream-fd.c
 create mode 100644 src/bin/lttng-relayd/stream-fd.h
 create mode 100644 src/bin/lttng-relayd/viewer-session.c
 create mode 100644 src/bin/lttng-relayd/viewer-session.h

-- 
2.1.4
