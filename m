From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: live_test regression on large
	number of cpus
Date: Tue, 28 Apr 2015 17:23:34 -0400
Message-ID: <1430256214-26941-1-git-send-email-mathieu.desnoyers__31819.3164923743$1430256328$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1YnCyp-0004EM-9J
 for lttng-dev@lists.lttng.org; Tue, 28 Apr 2015 17:23:56 -0400
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

Merge fixes from Babeltrace lttng-live plugin, especially about
incorrect use of send() and recv().

Can be triggered with 32 virtual processors visible on the system with
the root_regression test suite.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tests/regression/tools/live/live_test.c | 303 +++++++++++++++++---------------
 1 file changed, 158 insertions(+), 145 deletions(-)

diff --git a/tests/regression/tools/live/live_test.c b/tests/regression/tools/live/live_test.c
index e30c391..b447733 100644
--- a/tests/regression/tools/live/live_test.c
+++ b/tests/regression/tools/live/live_test.c
@@ -80,6 +80,38 @@ struct live_session {
 };
 
 static
+ssize_t lttng_live_recv(int fd, void *buf, size_t len)
+{
+	ssize_t ret;
+	size_t copied = 0, to_copy = len;
+
+	do {
+		ret = recv(fd, buf + copied, to_copy, 0);
+		if (ret > 0) {
+			assert(ret <= to_copy);
+			copied += ret;
+			to_copy -= ret;
+		}
+	} while ((ret > 0 && to_copy > 0)
+		|| (ret < 0 && errno == EINTR));
+	if (ret > 0)
+		ret = copied;
+	/* ret = 0 means orderly shutdown, ret < 0 is error. */
+	return ret;
+}
+
+static
+ssize_t lttng_live_send(int fd, const void *buf, size_t len)
+{
+	ssize_t ret;
+
+	do {
+		ret = send(fd, buf, len, MSG_NOSIGNAL);
+	} while (ret < 0 && errno == EINTR);
+	return ret;
+}
+
+static
 int connect_viewer(char *hostname)
 {
 	struct hostent *host;
@@ -125,7 +157,7 @@ int establish_connection(void)
 {
 	struct lttng_viewer_cmd cmd;
 	struct lttng_viewer_connect connect;
-	int ret;
+	ssize_t ret_len;
 
 	cmd.cmd = htobe32(LTTNG_VIEWER_CONNECT);
 	cmd.data_size = sizeof(connect);
@@ -136,32 +168,30 @@ int establish_connection(void)
 	connect.minor = htobe32(VERSION_MINOR);
 	connect.type = htobe32(LTTNG_VIEWER_CLIENT_COMMAND);
 
-	do {
-		ret = send(control_sock, &cmd, sizeof(cmd), 0);
-	} while (ret < 0 && errno == EINTR);
-	if (ret < 0) {
+	ret_len = lttng_live_send(control_sock, &cmd, sizeof(cmd));
+	if (ret_len < 0) {
 		fprintf(stderr, "Error sending cmd\n");
 		goto error;
 	}
-	do {
-		ret = send(control_sock, &connect, sizeof(connect), 0);
-	} while (ret < 0 && errno == EINTR);
-	if (ret < 0) {
+	ret_len = lttng_live_send(control_sock, &connect, sizeof(connect));
+	if (ret_len < 0) {
 		fprintf(stderr, "Error sending version\n");
 		goto error;
 	}
 
-	do {
-		ret = recv(control_sock, &connect, sizeof(connect), 0);
-	} while (ret < 0 && errno == EINTR);
-	if (ret < 0) {
+	ret_len = lttng_live_recv(control_sock, &connect, sizeof(connect));
+	if (ret_len == 0) {
+		fprintf(stderr, "[error] Remote side has closed connection\n");
+		goto error;
+	}
+	if (ret_len < 0) {
 		fprintf(stderr, "Error receiving version\n");
 		goto error;
 	}
-	ret = 0;
+	return 0;
 
 error:
-	return ret;
+	return -1;
 }
 
 /*
@@ -172,34 +202,33 @@ int list_sessions(int *session_id)
 	struct lttng_viewer_cmd cmd;
 	struct lttng_viewer_list_sessions list;
 	struct lttng_viewer_session lsession;
-	int i, ret;
+	int i;
+	ssize_t ret_len;
 	int first_session = 0;
 
 	cmd.cmd = htobe32(LTTNG_VIEWER_LIST_SESSIONS);
 	cmd.data_size = 0;
 	cmd.cmd_version = 0;
 
-	do {
-		ret = send(control_sock, &cmd, sizeof(cmd), 0);
-	} while (ret < 0 && errno == EINTR);
-	if (ret < 0) {
+	ret_len = lttng_live_send(control_sock, &cmd, sizeof(cmd));
+	if (ret_len < 0) {
 		fprintf(stderr, "Error sending cmd\n");
 		goto error;
 	}
 
-	do {
-		ret = recv(control_sock, &list, sizeof(list), 0);
-	} while (ret < 0 && errno == EINTR);
-	if (ret < 0) {
+	ret_len = lttng_live_recv(control_sock, &list, sizeof(list));
+	if (ret_len == 0) {
+		fprintf(stderr, "[error] Remote side has closed connection\n");
+		goto error;
+	}
+	if (ret_len < 0) {
 		fprintf(stderr, "Error receiving session list\n");
 		goto error;
 	}
 
 	for (i = 0; i < be32toh(list.sessions_count); i++) {
-		do {
-			ret = recv(control_sock, &lsession, sizeof(lsession), 0);
-		} while (ret < 0 && errno == EINTR);
-		if (ret < 0) {
+		ret_len = lttng_live_recv(control_sock, &lsession, sizeof(lsession));
+		if (ret_len < 0) {
 			fprintf(stderr, "Error receiving session\n");
 			goto error;
 		}
@@ -209,52 +238,48 @@ int list_sessions(int *session_id)
 		}
 	}
 
-	ret = be32toh(list.sessions_count);
+	return be32toh(list.sessions_count);
 
 error:
-	return ret;
+	return -1;
 }
 
-int create_viewer_session()
+int create_viewer_session(void)
 {
 	struct lttng_viewer_cmd cmd;
 	struct lttng_viewer_create_session_response resp;
-	int ret;
 	ssize_t ret_len;
 
 	cmd.cmd = htobe32(LTTNG_VIEWER_CREATE_SESSION);
 	cmd.data_size = 0;
 	cmd.cmd_version = 0;
 
-	do {
-		ret_len = send(control_sock, &cmd, sizeof(cmd), 0);
-	} while (ret_len < 0 && errno == EINTR);
+	ret_len = lttng_live_send(control_sock, &cmd, sizeof(cmd));
 	if (ret_len < 0) {
 		fprintf(stderr, "[error] Error sending cmd\n");
-		ret = ret_len;
 		goto error;
 	}
 	assert(ret_len == sizeof(cmd));
 
-	do {
-		ret_len = recv(control_sock, &resp, sizeof(resp), 0);
-	} while (ret_len < 0 && errno == EINTR);
+	ret_len = lttng_live_recv(control_sock, &resp, sizeof(resp));
+	if (ret_len == 0) {
+		fprintf(stderr, "[error] Remote side has closed connection\n");
+		goto error;
+	}
 	if (ret_len < 0) {
 		fprintf(stderr, "[error] Error receiving create session reply\n");
-		ret = ret_len;
 		goto error;
 	}
 	assert(ret_len == sizeof(resp));
 
 	if (be32toh(resp.status) != LTTNG_VIEWER_CREATE_SESSION_OK) {
 		fprintf(stderr, "[error] Error creating viewer session\n");
-		ret = -1;
 		goto error;
 	}
-	ret = 0;
+	return 0;
 
 error:
-	return ret;
+	return -1;
 }
 
 int attach_session(int id)
@@ -263,11 +288,11 @@ int attach_session(int id)
 	struct lttng_viewer_attach_session_request rq;
 	struct lttng_viewer_attach_session_response rp;
 	struct lttng_viewer_stream stream;
-	int ret, i;
+	int i;
+	ssize_t ret_len;
 
 	session = zmalloc(sizeof(struct live_session));
 	if (!session) {
-		ret = -1;
 		goto error;
 	}
 
@@ -279,46 +304,44 @@ int attach_session(int id)
 	rq.session_id = htobe64(id);
 	rq.seek = htobe32(LTTNG_VIEWER_SEEK_BEGINNING);
 
-	do {
-		ret = send(control_sock, &cmd, sizeof(cmd), 0);
-	} while (ret < 0 && errno == EINTR);
-	if (ret < 0) {
+	ret_len = lttng_live_send(control_sock, &cmd, sizeof(cmd));
+	if (ret_len < 0) {
 		fprintf(stderr, "Error sending cmd\n");
 		goto error;
 	}
-	do {
-		ret = send(control_sock, &rq, sizeof(rq), 0);
-	} while (ret < 0 && errno == EINTR);
-	if (ret < 0) {
+	ret_len = lttng_live_send(control_sock, &rq, sizeof(rq));
+	if (ret_len < 0) {
 		fprintf(stderr, "Error sending attach request\n");
 		goto error;
 	}
 
-	do {
-		ret = recv(control_sock, &rp, sizeof(rp), 0);
-	} while (ret < 0 && errno == EINTR);
-	if (ret < 0) {
+	ret_len = lttng_live_recv(control_sock, &rp, sizeof(rp));
+	if (ret_len == 0) {
+		fprintf(stderr, "[error] Remote side has closed connection\n");
+		goto error;
+	}
+	if (ret_len < 0) {
 		fprintf(stderr, "Error receiving attach response\n");
 		goto error;
 	}
 	if (be32toh(rp.status) != LTTNG_VIEWER_ATTACH_OK) {
-		ret = -1;
-		goto end;
+		goto error;
 	}
 
 	session->stream_count = be32toh(rp.streams_count);
 	session->streams = zmalloc(session->stream_count *
 			sizeof(struct viewer_stream));
 	if (!session->streams) {
-		ret = -1;
 		goto error;
 	}
 
 	for (i = 0; i < be32toh(rp.streams_count); i++) {
-		do {
-			ret = recv(control_sock, &stream, sizeof(stream), 0);
-		} while (ret < 0 && errno == EINTR);
-		if (ret < 0) {
+		ret_len = lttng_live_recv(control_sock, &stream, sizeof(stream));
+		if (ret_len == 0) {
+			fprintf(stderr, "[error] Remote side has closed connection\n");
+			goto error;
+		}
+		if (ret_len < 0) {
 			fprintf(stderr, "Error receiving stream\n");
 			goto error;
 		}
@@ -330,7 +353,6 @@ int attach_session(int id)
 				MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 		if (session->streams[i].mmap_base == MAP_FAILED) {
 			fprintf(stderr, "mmap error\n");
-			ret = -1;
 			goto error;
 		}
 
@@ -338,11 +360,10 @@ int attach_session(int id)
 			session->streams[i].metadata_flag = 1;
 		}
 	}
-	ret = session->stream_count;
+	return session->stream_count;
 
-end:
 error:
-	return ret;
+	return -1;
 }
 
 int get_metadata(void)
@@ -350,6 +371,7 @@ int get_metadata(void)
 	struct lttng_viewer_cmd cmd;
 	struct lttng_viewer_get_metadata rq;
 	struct lttng_viewer_metadata_packet rp;
+	ssize_t ret_len;
 	int ret;
 	uint64_t i;
 	char *data = NULL;
@@ -369,30 +391,27 @@ int get_metadata(void)
 
 	if (metadata_stream_id < 0) {
 		fprintf(stderr, "No metadata stream found\n");
-		ret = -1;
 		goto error;
 	}
 
 	rq.stream_id = htobe64(session->streams[metadata_stream_id].id);
 
-	do {
-		ret = send(control_sock, &cmd, sizeof(cmd), 0);
-	} while (ret < 0 && errno == EINTR);
-	if (ret < 0) {
+	ret_len = lttng_live_send(control_sock, &cmd, sizeof(cmd));
+	if (ret_len < 0) {
 		fprintf(stderr, "Error sending cmd\n");
 		goto error;
 	}
-	do {
-		ret = send(control_sock, &rq, sizeof(rq), 0);
-	} while (ret < 0 && errno == EINTR);
-	if (ret < 0) {
+	ret_len = lttng_live_send(control_sock, &rq, sizeof(rq));
+	if (ret_len < 0) {
 		fprintf(stderr, "Error sending get_metadata request\n");
 		goto error;
 	}
-	do {
-		ret = recv(control_sock, &rp, sizeof(rp), 0);
-	} while (ret < 0 && errno == EINTR);
-	if (ret < 0) {
+	ret_len = lttng_live_recv(control_sock, &rp, sizeof(rp));
+	if (ret_len == 0) {
+		fprintf(stderr, "[error] Remote side has closed connection\n");
+		goto error;
+	}
+	if (ret_len < 0) {
 		fprintf(stderr, "Error receiving metadata response\n");
 		goto error;
 	}
@@ -401,21 +420,19 @@ int get_metadata(void)
 			break;
 		case LTTNG_VIEWER_NO_NEW_METADATA:
 			fprintf(stderr, "NO NEW\n");
-			ret = -1;
+			ret = 0;
 			goto end;
 		case LTTNG_VIEWER_METADATA_ERR:
 			fprintf(stderr, "ERR\n");
-			ret = -1;
-			goto end;
+			goto error;
 		default:
 			fprintf(stderr, "UNKNOWN\n");
-			ret = -1;
-			goto end;
+			goto error;
 	}
 
 	len = be64toh(rp.len);
 	if (len <= 0) {
-		goto end;
+		goto error;
 	}
 
 	data = zmalloc(len);
@@ -423,20 +440,24 @@ int get_metadata(void)
 		PERROR("relay data zmalloc");
 		goto error;
 	}
-	do {
-		ret = recv(control_sock, data, len, MSG_WAITALL);
-	} while (ret < 0 && errno == EINTR);
-	if (ret < 0) {
+	ret_len = lttng_live_recv(control_sock, data, len);
+	if (ret_len == 0) {
+		fprintf(stderr, "[error] Remote side has closed connection\n");
+		goto error_free_data;
+	}
+	if (ret_len < 0) {
 		fprintf(stderr, "Error receiving trace packet\n");
-		free(data);
-		goto error;
+		goto error_free_data;
 	}
 	free(data);
-
-	ret = (int) len;
+	ret = len;
 end:
-error:
 	return ret;
+
+error_free_data:
+	free(data);
+error:
+	return -1;
 }
 
 int get_next_index(void)
@@ -444,7 +465,7 @@ int get_next_index(void)
 	struct lttng_viewer_cmd cmd;
 	struct lttng_viewer_get_next_index rq;
 	struct lttng_viewer_index rp;
-	int ret;
+	ssize_t ret_len;
 	int id;
 
 	cmd.cmd = htobe32(LTTNG_VIEWER_GET_NEXT_INDEX);
@@ -455,27 +476,26 @@ int get_next_index(void)
 		if (session->streams[id].metadata_flag) {
 			continue;
 		}
+		memset(&rq, 0, sizeof(rq));
 		rq.stream_id = htobe64(session->streams[id].id);
 
 retry:
-		do {
-			ret = send(control_sock, &cmd, sizeof(cmd), 0);
-		} while (ret < 0 && errno == EINTR);
-		if (ret < 0) {
+		ret_len = lttng_live_send(control_sock, &cmd, sizeof(cmd));
+		if (ret_len < 0) {
 			fprintf(stderr, "Error sending cmd\n");
 			goto error;
 		}
-		do {
-			ret = send(control_sock, &rq, sizeof(rq), 0);
-		} while (ret < 0 && errno == EINTR);
-		if (ret < 0) {
+		ret_len = lttng_live_send(control_sock, &rq, sizeof(rq));
+		if (ret_len < 0) {
 			fprintf(stderr, "Error sending get_next_index request\n");
 			goto error;
 		}
-		do {
-			ret = recv(control_sock, &rp, sizeof(rp), 0);
-		} while (ret < 0 && errno == EINTR);
-		if (ret < 0) {
+		ret_len = lttng_live_recv(control_sock, &rp, sizeof(rp));
+		if (ret_len == 0) {
+			fprintf(stderr, "[error] Remote side has closed connection\n");
+			goto error;
+		}
+		if (ret_len < 0) {
 			fprintf(stderr, "Error receiving index response\n");
 			goto error;
 		}
@@ -498,11 +518,9 @@ retry:
 				break;
 			case LTTNG_VIEWER_INDEX_ERR:
 				fprintf(stderr, "(ERR)\n");
-				ret = -1;
 				goto error;
 			default:
 				fprintf(stderr, "SHOULD NOT HAPPEN\n");
-				ret = -1;
 				goto error;
 		}
 		if (!first_packet_stream_id) {
@@ -511,10 +529,10 @@ retry:
 			first_packet_stream_id = id;
 		}
 	}
-	ret = 0;
+	return 0;
 
 error:
-	return ret;
+	return -1;
 }
 
 static
@@ -524,35 +542,34 @@ int get_data_packet(int id, uint64_t offset,
 	struct lttng_viewer_cmd cmd;
 	struct lttng_viewer_get_packet rq;
 	struct lttng_viewer_trace_packet rp;
-	int ret;
+	ssize_t ret_len;
 
 	cmd.cmd = htobe32(LTTNG_VIEWER_GET_PACKET);
 	cmd.data_size = sizeof(rq);
 	cmd.cmd_version = 0;
 
+	memset(&rq, 0, sizeof(rq));
 	rq.stream_id = htobe64(session->streams[id].id);
 	/* Already in big endian. */
 	rq.offset = offset;
 	rq.len = htobe32(len);
 
-	do {
-		ret = send(control_sock, &cmd, sizeof(cmd), 0);
-	} while (ret < 0 && errno == EINTR);
-	if (ret < 0) {
+	ret_len = lttng_live_send(control_sock, &cmd, sizeof(cmd));
+	if (ret_len < 0) {
 		fprintf(stderr, "Error sending cmd\n");
 		goto error;
 	}
-	do {
-		ret = send(control_sock, &rq, sizeof(rq), 0);
-	} while (ret < 0 && errno == EINTR);
-	if (ret < 0) {
+	ret_len = lttng_live_send(control_sock, &rq, sizeof(rq));
+	if (ret_len < 0) {
 		fprintf(stderr, "Error sending get_data_packet request\n");
 		goto error;
 	}
-	do {
-		ret = recv(control_sock, &rp, sizeof(rp), 0);
-	} while (ret < 0 && errno == EINTR);
-	if (ret < 0) {
+	ret_len = lttng_live_recv(control_sock, &rp, sizeof(rp));
+	if (ret_len == 0) {
+		fprintf(stderr, "[error] Remote side has closed connection\n");
+		goto error;
+	}
+	if (ret_len < 0) {
 		fprintf(stderr, "Error receiving data response\n");
 		goto error;
 	}
@@ -560,49 +577,45 @@ int get_data_packet(int id, uint64_t offset,
 
 	switch (be32toh(rp.status)) {
 	case LTTNG_VIEWER_GET_PACKET_OK:
+		len = be32toh(rp.len);
 		break;
 	case LTTNG_VIEWER_GET_PACKET_RETRY:
 		fprintf(stderr, "RETRY\n");
-		ret = -1;
-		goto end;
+		goto error;
 	case LTTNG_VIEWER_GET_PACKET_ERR:
 		if (rp.flags & LTTNG_VIEWER_FLAG_NEW_METADATA) {
 			fprintf(stderr, "NEW_METADATA\n");
-			ret = 0;
 			goto end;
 		}
 		fprintf(stderr, "ERR\n");
-		ret = -1;
-		goto end;
+		goto error;
 	default:
 		fprintf(stderr, "UNKNOWN\n");
-		ret = -1;
-		goto end;
+		goto error;
 	}
 
-	len = be32toh(rp.len);
-	if (len <= 0) {
-		goto end;
+	if (len == 0) {
+		goto error;
 	}
 
 	if (len > mmap_size) {
 		fprintf(stderr, "mmap_size not big enough\n");
-		ret = -1;
 		goto error;
 	}
 
-	do {
-		ret = recv(control_sock, session->streams[id].mmap_base, len, MSG_WAITALL);
-	} while (ret < 0 && errno == EINTR);
-	if (ret < 0) {
+	ret_len = lttng_live_recv(control_sock, session->streams[id].mmap_base, len);
+	if (ret_len == 0) {
+		fprintf(stderr, "[error] Remote side has closed connection\n");
+		goto error;
+	}
+	if (ret_len < 0) {
 		fprintf(stderr, "Error receiving trace packet\n");
 		goto error;
 	}
-	ret = len;
-
 end:
+	return 0;
 error:
-	return ret;
+	return -1;
 }
 
 int main(int argc, char **argv)
@@ -638,7 +651,7 @@ int main(int argc, char **argv)
 
 	ret = get_data_packet(first_packet_stream_id, first_packet_offset,
 			first_packet_len);
-	ok(ret == first_packet_len,
+	ok(ret == 0,
 			"Get one data packet for stream %d, offset %d, len %d",
 			first_packet_stream_id, first_packet_offset,
 			first_packet_len);
-- 
2.1.4
