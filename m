From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH] Fix: reset out_fd_offset when we
	rotate the trace file
Date: Tue, 13 Aug 2013 17:40:28 -0400
Message-ID: <1376430028-29599-1-git-send-email-jdesfossez__43060.5734153234$1376430081$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1V9MKW-0006yB-Gg
	for lttng-dev@lists.lttng.org; Tue, 13 Aug 2013 17:40:43 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

This value is only used for the sync_file_range, but it has to be set
to 0 when we start to write in a new trace file, otherwise the values
passed to this call are bogus.

Applied to 2.3, but could probably be backported to 2.2.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/common/consumer.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/common/consumer.c b/src/common/consumer.c
index 221c348..59207da 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -1431,6 +1431,8 @@ ssize_t lttng_consumer_on_read_subbuffer_mmap(
 			outfd = stream->out_fd = ret;
 			/* Reset current size because we just perform a rotation. */
 			stream->tracefile_size_current = 0;
+			stream->out_fd_offset = 0;
+			orig_offset = 0;
 		}
 		stream->tracefile_size_current += len;
 	}
@@ -1614,6 +1616,8 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
 			outfd = stream->out_fd = ret;
 			/* Reset current size because we just perform a rotation. */
 			stream->tracefile_size_current = 0;
+			stream->out_fd_offset = 0;
+			orig_offset = 0;
 		}
 		stream->tracefile_size_current += len;
 	}
-- 
1.7.10.4
