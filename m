From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace-1.5 3/6] Fix: lttng-live:
 lttng_live_open_trace_read memory leak
Date: Thu,  5 Dec 2019 01:58:06 -0500
Message-ID: <20191205065809.16728-4-mathieu.desnoyers__453.024979081817$1575529110$gmane$org@efficios.com>
References: <20191205065809.16728-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 47T64Q5q8Bz10Y2
 for <lttng-dev@lists.lttng.org>; Thu,  5 Dec 2019 01:58:14 -0500 (EST)
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

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 formats/lttng-live/lttng-live-plugin.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/formats/lttng-live/lttng-live-plugin.c b/formats/lttng-live/lttng-live-plugin.c
index ed52a995..0bebdd89 100644
--- a/formats/lttng-live/lttng-live-plugin.c
+++ b/formats/lttng-live/lttng-live-plugin.c
@@ -288,6 +288,7 @@ static int lttng_live_open_trace_read(const char *path)
 	}
 
 end_free:
+	g_array_free(ctx->session_ids, TRUE);
 	g_hash_table_destroy(ctx->session->ctf_traces);
 	free_session_streams(ctx->session);
 	g_free(ctx->session);
-- 
2.17.1
