From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH] Fix: close indexes when rotating
	the trace files
Date: Fri, 27 Nov 2015 12:12:44 -0500
Message-ID: <1448644364-21440-1-git-send-email-jdesfossez__24388.2583258257$1448644491$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1a2MZs-0002hP-GP
 for lttng-dev@lists.lttng.org; Fri, 27 Nov 2015 12:12:59 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

The consumer needs to close the old index file when doing a file
rotation before opening a new one.
The relay does not have this problem (handled with refcounts).

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/common/consumer/consumer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/common/consumer/consumer.c b/src/common/consumer/consumer.c
index 2897fb8..5a90c29 100644
--- a/src/common/consumer/consumer.c
+++ b/src/common/consumer/consumer.c
@@ -1779,6 +1779,11 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
 			outfd = stream->out_fd;
 
 			if (stream->index_fd >= 0) {
+				ret = close(stream->index_fd);
+				if (ret < 0) {
+					PERROR("Closing index");
+					goto end;
+				}
 				ret = index_create_file(stream->chan->pathname,
 						stream->name, stream->uid, stream->gid,
 						stream->chan->tracefile_size,
-- 
1.9.1
