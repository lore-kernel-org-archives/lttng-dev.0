From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH lttng-ust 0/2] Shared object base address tracing
Date: Mon, 11 Nov 2013 16:28:06 +0100
Message-ID: <1384183688-19038-1-git-send-email-paul_woegerer__14119.3315307193$1384183777$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VftPW-0000rc-TG
	for lttng-dev@lists.lttng.org; Mon, 11 Nov 2013 10:28:25 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

The following two patches implement https://bugs.lttng.org/issues/474

The first patch provides tracing of dlopen/dlclose calls with the use of an
LD_PRELOAD library (liblttng-ust-dl.so) using the following events:

 ust_baddr:push(void *baddr, const char*sopath, int64_t size, int64_t mtime)
 ust_baddr:pop(void *baddr)

The second patch adds support for tracing the whole state of currently loaded
shared objects at session-enable time. The corresponding events are only
emitted into the session that got enabled. The following event is used: 

 ust_baddr_statedump (same args as ust_baddr:push)


Paul Woegerer (2):
  Base-address tracing for dlopen and dlclose
  Implement base-address-state tracing

 Makefile.am                              |   2 +
 configure.ac                             |   2 +
 include/Makefile.am                      |   1 +
 include/lttng/tracepoint.h               |  12 +--
 include/lttng/ust-dl.h                   |  54 ++++++++++++
 include/lttng/ust-tracepoint-event.h     |  14 +++
 liblttng-ust-baddr/Makefile.am           |  20 +++++
 liblttng-ust-baddr/lttng-ust-baddr.c     | 111 ++++++++++++++++++++++++
 liblttng-ust-baddr/ust_baddr.c           |  20 +++++
 liblttng-ust-baddr/ust_baddr.h           |  66 ++++++++++++++
 liblttng-ust-baddr/ust_baddr_statedump.c |  21 +++++
 liblttng-ust-baddr/ust_baddr_statedump.h |  60 +++++++++++++
 liblttng-ust-dl/Makefile.am              |  17 ++++
 liblttng-ust-dl/ustdl.c                  | 144 +++++++++++++++++++++++++++++++
 liblttng-ust/lttng-events.c              |  10 +++
 liblttng-ust/lttng-tracer-core.h         |   2 +
 liblttng-ust/lttng-ust-comm.c            |  52 +++++++++++
 17 files changed, 603 insertions(+), 5 deletions(-)
 create mode 100644 include/lttng/ust-dl.h
 create mode 100644 liblttng-ust-baddr/Makefile.am
 create mode 100644 liblttng-ust-baddr/lttng-ust-baddr.c
 create mode 100644 liblttng-ust-baddr/ust_baddr.c
 create mode 100644 liblttng-ust-baddr/ust_baddr.h
 create mode 100644 liblttng-ust-baddr/ust_baddr_statedump.c
 create mode 100644 liblttng-ust-baddr/ust_baddr_statedump.h
 create mode 100644 liblttng-ust-dl/Makefile.am
 create mode 100644 liblttng-ust-dl/ustdl.c

-- 
1.8.4.2
