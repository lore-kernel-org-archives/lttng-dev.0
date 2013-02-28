From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Fix: Memory leak on error paths of
	relay_add_stream
Date: Thu, 28 Feb 2013 15:48:24 -0500
Message-ID: <1362084510-10072-1-git-send-email-christian.babeux__5439.15466773814$1362084580$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UBAPF-0001o7-9Y
	for lttng-dev@lists.lttng.org; Thu, 28 Feb 2013 15:48:45 -0500
Received: by mail-ie0-f178.google.com with SMTP id c13so2618305ieb.23
	for <lttng-dev@lists.lttng.org>; Thu, 28 Feb 2013 12:48:39 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On error paths the memory allocated for stream is never freed.

Also, fix undefined behavior on asprintf alloc failure. According to
asprintf(3), the content of the pointer passed to it is undefined if
an alloc failure occurs, so we could end up freeing a pointer in an
undefined state. Force its value to NULL.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 src/bin/lttng-relayd/main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 4f9d742..00b7ea3 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -941,6 +941,7 @@ int relay_add_stream(struct lttcomm_relayd_hdr *recv_hdr,
 	ret = asprintf(&path, "%s/%s", root_path, stream_info.channel_name);
 	if (ret < 0) {
 		PERROR("asprintf stream path");
+		path = NULL;
 		goto end;
 	}
 
@@ -963,13 +964,17 @@ int relay_add_stream(struct lttcomm_relayd_hdr *recv_hdr,
 end:
 	free(path);
 	free(root_path);
+
+	reply.handle = htobe64(stream->stream_handle);
 	/* send the session id to the client or a negative return code on error */
 	if (ret < 0) {
 		reply.ret_code = htobe32(LTTNG_ERR_UNK);
+		/* stream was not properly added to the ht, so free it */
+		free(stream);
 	} else {
 		reply.ret_code = htobe32(LTTNG_OK);
 	}
-	reply.handle = htobe64(stream->stream_handle);
+
 	send_ret = cmd->sock->ops->sendmsg(cmd->sock, &reply,
 			sizeof(struct lttcomm_relayd_status_stream), 0);
 	if (send_ret < 0) {
-- 
1.8.1.3
