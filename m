From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace-1.5 6/6] Fix: lttng-live format: do
 not error out on empty streams hang up
Date: Thu,  5 Dec 2019 01:58:09 -0500
Message-ID: <20191205065809.16728-7-mathieu.desnoyers__23563.4265862004$1575529305$gmane$org@efficios.com>
References: <20191205065809.16728-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 47T64S400Tz10hJ
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

Attaching to a stream hung up before providing any trace packet
causes ctf_open_mmap_stream_read() to return an error.

This kind of scenario can happen with the upcoming "lttng clear"
feature.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 formats/ctf/ctf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 980ebc9a..1ba9017f 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -2571,8 +2571,13 @@ int ctf_open_mmap_stream_read(struct ctf_trace *td,
 	}
 
 	ret = prepare_mmap_stream_definition(td, file_stream, packet_seek);
-	if (ret)
+	if (ret) {
+		/* We need to check for EOF here for empty files. */
+		if (unlikely(file_stream->pos.offset == EOF)) {
+			ret = 0;
+		}
 		goto error_index;
+	}
 
 	/*
 	 * For now, only a single clock per trace is supported.
-- 
2.17.1
