From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace-1.5 0/6] Babeltrace 1.5 lttng-live
 with per-pid ust buffers
Date: Thu,  5 Dec 2019 01:58:03 -0500
Message-ID: <20191205065809.16728-1-mathieu.desnoyers__47566.5017658443$1575529145$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 47T64Q5rTVz10G0
 for <lttng-dev@lists.lttng.org>; Thu,  5 Dec 2019 01:58:14 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This series of fixes comes from testing babeltrace 1.5 lttng-live
under valgrind with per-pid lttng buffers. This was done in the
context of testing of the "lttng clear" feature.

Thanks,

Mathieu

Mathieu Desnoyers (6):
  Fix: lttng-live: use-after-free in get_next_index()
  Fix: trace-collection: trace clock use after free
  Fix: lttng-live: lttng_live_open_trace_read memory leak
  Fix: lib/iterator.c: unbalanced ctx put (leak)
  Fix: lttng-live: ctf_live_packet_seek stream hang up handling
  Fix: lttng-live format: do not error out on empty streams hang up

 formats/ctf/ctf.c                      |  7 ++++++-
 formats/lttng-live/lttng-live-comm.c   |  8 ++++++--
 formats/lttng-live/lttng-live-plugin.c |  1 +
 lib/iterator.c                         |  3 +++
 lib/trace-collection.c                 | 21 ++++++++++++++++++---
 5 files changed, 34 insertions(+), 6 deletions(-)

-- 
2.17.1
