From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace-1.5 5/6] Fix: lttng-live:
 ctf_live_packet_seek stream hang up handling
Date: Thu,  5 Dec 2019 01:58:08 -0500
Message-ID: <20191205065809.16728-6-mathieu.desnoyers__15035.6414889515$1575529272$gmane$org@efficios.com>
References: <20191205065809.16728-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 47T64S2lVzz10lg
 for <lttng-dev@lists.lttng.org>; Thu,  5 Dec 2019 01:58:16 -0500 (EST)
In-Reply-To: <20191205065809.16728-1-mathieu.desnoyers@efficios.com>
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

When get_next_index sets the index position to EOF,
ctf_live_packet_seek() should in turn set the stream position to EOF
to propagate the hung up state.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 formats/lttng-live/lttng-live-comm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/formats/lttng-live/lttng-live-comm.c b/formats/lttng-live/lttng-live-comm.c
index 96817f5e..484c025d 100644
--- a/formats/lttng-live/lttng-live-comm.c
+++ b/formats/lttng-live/lttng-live-comm.c
@@ -1276,7 +1276,11 @@ retry:
 				cur_index->packet_size, cur_index->offset,
 				cur_index->content_size,
 				cur_index->ts_cycles.timestamp_end);
-
+		if (cur_index->offset == EOF) {
+			pos->offset = EOF;
+			ret = -BT_PACKET_SEEK_ERROR;
+			goto end;
+		}
 	}
 
 	/*
-- 
2.17.1
