From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Fix: Possible buffer overflows in
	strncat() usage
Date: Mon, 20 Aug 2012 13:34:36 -0400
Message-ID: <1345484076-31111-1-git-send-email-christian.babeux__45523.6892019913$1345484115$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yx0-f176.google.com ([209.85.213.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1T3VsI-0004Mf-3Y
	for lttng-dev@lists.lttng.org; Mon, 20 Aug 2012 13:34:50 -0400
Received: by yenm12 with SMTP id m12so6538336yen.35
	for <lttng-dev@lists.lttng.org>; Mon, 20 Aug 2012 10:34:44 -0700 (PDT)
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

When using strncat, the size_t n argument must indicate the left over
space remaining in the buffer, *not* the total buffer size. Also, proper
care must be taken for the case where src contains n or more bytes and
thus allow space for the null terminating byte appended to dest
(e.g. strncat() will write n+1 bytes).

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 src/bin/lttng-sessiond/consumer.c |  5 +++--
 src/bin/lttng-sessiond/main.c     | 12 +++++++-----
 src/common/utils.c                |  2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/src/bin/lttng-sessiond/consumer.c b/src/bin/lttng-sessiond/consumer.c
index 3503e04..fe2d45a 100644
--- a/src/bin/lttng-sessiond/consumer.c
+++ b/src/bin/lttng-sessiond/consumer.c
@@ -480,9 +480,10 @@ int consumer_send_stream(int sock, struct consumer_output *dst,
 		break;
 	case CONSUMER_DST_LOCAL:
 		/* Add stream file name to stream path */
-		strncat(msg->u.stream.path_name, "/", sizeof(msg->u.stream.path_name));
+		strncat(msg->u.stream.path_name, "/",
+			sizeof(msg->u.stream.path_name) - strlen(msg->u.stream.path_name) - 1);
 		strncat(msg->u.stream.path_name, msg->u.stream.name,
-				sizeof(msg->u.stream.path_name));
+			sizeof(msg->u.stream.path_name) - strlen(msg->u.stream.path_name) - 1);
 		msg->u.stream.path_name[sizeof(msg->u.stream.path_name) - 1] = '\0';
 		/* Indicate that the stream is NOT network */
 		msg->u.stream.net_index = -1;
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index c952fc0..4ca031f 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -2278,7 +2278,8 @@ static int copy_session_consumer(int domain, struct ltt_session *session)
 	}
 
 	/* Append correct directory to subdir */
-	strncat(consumer->subdir, dir_name, sizeof(consumer->subdir));
+	strncat(consumer->subdir, dir_name,
+		sizeof(consumer->subdir) - strlen(consumer->subdir) - 1);
 	DBG3("Copy session consumer subdir %s", consumer->subdir);
 
 	ret = LTTCOMM_OK;
@@ -2809,7 +2810,8 @@ static int add_uri_to_consumer(struct consumer_output *consumer,
 
 		if (uri->stype == LTTNG_STREAM_CONTROL) {
 			/* On a new subdir, reappend the default trace dir. */
-			strncat(consumer->subdir, default_trace_dir, sizeof(consumer->subdir));
+			strncat(consumer->subdir, default_trace_dir,
+				sizeof(consumer->subdir) - strlen(consumer->subdir) - 1);
 			DBG3("Append domain trace name to subdir %s", consumer->subdir);
 		}
 
@@ -2822,7 +2824,7 @@ static int add_uri_to_consumer(struct consumer_output *consumer,
 				sizeof(consumer->dst.trace_path));
 		/* Append default trace dir */
 		strncat(consumer->dst.trace_path, default_trace_dir,
-				sizeof(consumer->dst.trace_path));
+			sizeof(consumer->dst.trace_path) - strlen(consumer->dst.trace_path) - 1);
 		/* Flag consumer as local. */
 		consumer->type = CONSUMER_DST_LOCAL;
 		break;
@@ -4257,7 +4259,7 @@ static int cmd_enable_consumer(int domain, struct ltt_session *session)
 
 		/* Append default kernel trace dir to subdir */
 		strncat(ksess->consumer->subdir, DEFAULT_KERNEL_TRACE_DIR,
-				sizeof(ksess->consumer->subdir));
+			sizeof(ksess->consumer->subdir) - strlen(ksess->consumer->subdir) - 1);
 
 		/*
 		 * @session-lock
@@ -4342,7 +4344,7 @@ static int cmd_enable_consumer(int domain, struct ltt_session *session)
 
 		/* Append default kernel trace dir to subdir */
 		strncat(usess->consumer->subdir, DEFAULT_UST_TRACE_DIR,
-				sizeof(usess->consumer->subdir));
+			sizeof(usess->consumer->subdir) - strlen(usess->consumer->subdir) - 1);
 
 		/*
 		 * @session-lock
diff --git a/src/common/utils.c b/src/common/utils.c
index 0494b23..729aa76 100644
--- a/src/common/utils.c
+++ b/src/common/utils.c
@@ -70,7 +70,7 @@ char *utils_expand_path(const char *path)
 	}
 
 	/* Add end part to expanded path */
-	strncat(expanded_path, end_path, PATH_MAX);
+	strncat(expanded_path, end_path, PATH_MAX - strlen(expanded_path) - 1);
 
 	free(cut_path);
 	return expanded_path;
-- 
1.7.11.4
