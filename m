From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: cppcheck linter cleanups
Date: Mon, 17 Dec 2012 18:32:27 -0500
Message-ID: <20121217233227.GA12560__43222.8568628945$1355787213$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TkkAm-0003J3-Cg
	for lttng-dev@lists.lttng.org; Mon, 17 Dec 2012 18:32:36 -0500
Content-Disposition: inline
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

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 41afcca..4de6613 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -1273,14 +1273,16 @@ int relay_recv_metadata(struct lttcomm_relayd_hdr *recv_hdr,
 
 	if (data_buffer_size < data_size) {
 		/* In case the realloc fails, we can free the memory */
-		char *tmp_data_ptr = data_buffer;
-		data_buffer = realloc(data_buffer, data_size);
-		if (!data_buffer) {
+		char *tmp_data_ptr;
+
+		tmp_data_ptr = realloc(data_buffer, data_size);
+		if (!tmp_data_ptr) {
 			ERR("Allocating data buffer");
-			free(tmp_data_ptr);
+			free(data_buffer);
 			ret = -1;
 			goto end;
 		}
+		data_buffer = tmp_data_ptr;
 		data_buffer_size = data_size;
 	}
 	memset(data_buffer, 0, data_size);
@@ -1354,7 +1356,7 @@ int relay_send_version(struct lttcomm_relayd_hdr *recv_hdr,
 	 * structure considering that the other side will adapt.
 	 */
 
-	ret = sscanf(VERSION, "%u.%u", &reply.major, &reply.minor);
+	ret = sscanf(VERSION, "%10u.%10u", &reply.major, &reply.minor);
 	if (ret < 2) {
 		ERR("Error in scanning version");
 		ret = -1;
@@ -1693,14 +1695,16 @@ int relay_process_data(struct relay_command *cmd, struct lttng_ht *streams_ht)
 
 	data_size = be32toh(data_hdr.data_size);
 	if (data_buffer_size < data_size) {
-		char *tmp_data_ptr = data_buffer;
-		data_buffer = realloc(data_buffer, data_size);
-		if (!data_buffer) {
+		char *tmp_data_ptr;
+
+		tmp_data_ptr = realloc(data_buffer, data_size);
+		if (!tmp_data_ptr) {
 			ERR("Allocating data buffer");
-			free(tmp_data_ptr);
+			free(data_buffer);
 			ret = -1;
 			goto end_unlock;
 		}
+		data_buffer = tmp_data_ptr;
 		data_buffer_size = data_size;
 	}
 	memset(data_buffer, 0, data_size);
@@ -2054,7 +2058,7 @@ int main(int argc, char **argv)
 
 	/* Parse arguments */
 	progname = argv[0];
-	if ((ret = parse_args(argc, argv) < 0)) {
+	if ((ret = parse_args(argc, argv)) < 0) {
 		goto exit;
 	}
 
diff --git a/src/bin/lttng-sessiond/consumer.c b/src/bin/lttng-sessiond/consumer.c
index fd9e1e6..66cdc24 100644
--- a/src/bin/lttng-sessiond/consumer.c
+++ b/src/bin/lttng-sessiond/consumer.c
@@ -112,7 +112,6 @@ error:
  */
 void consumer_output_send_destroy_relayd(struct consumer_output *consumer)
 {
-	int ret;
 	struct lttng_ht_iter iter;
 	struct consumer_socket *socket;
 
@@ -123,6 +122,8 @@ void consumer_output_send_destroy_relayd(struct consumer_output *consumer)
 		rcu_read_lock();
 		cds_lfht_for_each_entry(consumer->socks->ht, &iter.iter, socket,
 				node.node) {
+			int ret;
+
 			/* Send destroy relayd command */
 			ret = consumer_send_destroy_relayd(socket, consumer);
 			if (ret < 0) {
diff --git a/src/bin/lttng-sessiond/kernel.c b/src/bin/lttng-sessiond/kernel.c
index 00172e8..3471fd9 100644
--- a/src/bin/lttng-sessiond/kernel.c
+++ b/src/bin/lttng-sessiond/kernel.c
@@ -556,7 +556,6 @@ ssize_t kernel_list_events(int tracer_fd, struct lttng_event **events)
 	int fd, pos, ret;
 	char *event;
 	size_t nbmem, count = 0;
-	ssize_t size;
 	FILE *fp;
 	struct lttng_event *elist;
 
@@ -584,7 +583,7 @@ ssize_t kernel_list_events(int tracer_fd, struct lttng_event **events)
 		goto end;
 	}
 
-	while ((size = fscanf(fp, "event { name = %m[^;]; };%n\n", &event, &pos)) == 1) {
+	while (fscanf(fp, "event { name = %m[^;]; };%n\n", &event, &pos) == 1) {
 		if (count >= nbmem) {
 			struct lttng_event *new_elist;
 
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index f2cf285..91fba26 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -461,7 +461,7 @@ static void cleanup(void)
 static int send_unix_sock(int sock, void *buf, size_t len)
 {
 	/* Check valid length */
-	if (len <= 0) {
+	if (len == 0) {
 		return -1;
 	}
 
@@ -1677,10 +1677,10 @@ error:
 static int join_consumer_thread(struct consumer_data *consumer_data)
 {
 	void *status;
-	int ret;
 
 	/* Consumer pid must be a real one. */
 	if (consumer_data->pid > 0) {
+		int ret;
 		ret = kill(consumer_data->pid, SIGTERM);
 		if (ret) {
 			ERR("Error killing consumer daemon");
@@ -1859,7 +1859,7 @@ error:
  */
 static int start_consumerd(struct consumer_data *consumer_data)
 {
-	int ret, err;
+	int ret;
 
 	/*
 	 * Set the listen() state on the socket since there is a possible race
@@ -1902,6 +1902,8 @@ end:
 error:
 	/* Cleanup already created socket on error. */
 	if (consumer_data->err_sock >= 0) {
+		int err;
+
 		err = close(consumer_data->err_sock);
 		if (err < 0) {
 			PERROR("close consumer data error socket");
@@ -3848,7 +3850,7 @@ int main(int argc, char **argv)
 
 	/* Parse arguments */
 	progname = argv[0];
-	if ((ret = parse_args(argc, argv) < 0)) {
+	if ((ret = parse_args(argc, argv)) < 0) {
 		goto error;
 	}
 
diff --git a/src/bin/lttng-sessiond/trace-kernel.c b/src/bin/lttng-sessiond/trace-kernel.c
index e8c381a..f38cf3d 100644
--- a/src/bin/lttng-sessiond/trace-kernel.c
+++ b/src/bin/lttng-sessiond/trace-kernel.c
@@ -85,7 +85,6 @@ error:
  */
 struct ltt_kernel_session *trace_kernel_create_session(char *path)
 {
-	int ret;
 	struct ltt_kernel_session *lks = NULL;
 
 	/* Allocate a new ltt kernel session */
@@ -117,6 +116,8 @@ struct ltt_kernel_session *trace_kernel_create_session(char *path)
 	lks->tmp_consumer = NULL;
 
 	if (path && strlen(path) > 0) {
+		int ret;
+
 		/* Use the default consumer output which is the tracing session path. */
 		ret = snprintf(lks->consumer->dst.trace_path, PATH_MAX,
 				"%s" DEFAULT_KERNEL_TRACE_DIR, path);
@@ -330,11 +331,11 @@ error:
  */
 void trace_kernel_destroy_stream(struct ltt_kernel_stream *stream)
 {
-	int ret;
-
 	DBG("[trace] Closing stream fd %d", stream->fd);
 	/* Close kernel fd */
 	if (stream->fd >= 0) {
+		int ret;
+
 		ret = close(stream->fd);
 		if (ret) {
 			PERROR("close");
@@ -351,9 +352,9 @@ void trace_kernel_destroy_stream(struct ltt_kernel_stream *stream)
  */
 void trace_kernel_destroy_event(struct ltt_kernel_event *event)
 {
-	int ret;
-
 	if (event->fd >= 0) {
+		int ret;
+
 		DBG("[trace] Closing event fd %d", event->fd);
 		/* Close kernel fd */
 		ret = close(event->fd);
@@ -412,11 +413,11 @@ void trace_kernel_destroy_channel(struct ltt_kernel_channel *channel)
  */
 void trace_kernel_destroy_metadata(struct ltt_kernel_metadata *metadata)
 {
-	int ret;
-
 	DBG("[trace] Closing metadata fd %d", metadata->fd);
 	/* Close kernel fd */
 	if (metadata->fd >= 0) {
+		int ret;
+
 		ret = close(metadata->fd);
 		if (ret) {
 			PERROR("close");
diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/trace-ust.c
index 1fda555..3d9390d 100644
--- a/src/bin/lttng-sessiond/trace-ust.c
+++ b/src/bin/lttng-sessiond/trace-ust.c
@@ -183,7 +183,6 @@ error:
 struct ltt_ust_session *trace_ust_create_session(char *path,
 		unsigned int session_id, struct lttng_domain *domain)
 {
-	int ret;
 	struct ltt_ust_session *lus;
 
 	/* Allocate a new ltt ust session */
@@ -219,6 +218,8 @@ struct ltt_ust_session *trace_ust_create_session(char *path,
 
 	/* Use the default consumer output which is the tracing session path. */
 	if (path && strlen(path) > 0) {
+		int ret;
+
 		ret = snprintf(lus->consumer->dst.trace_path, PATH_MAX,
 				"%s" DEFAULT_UST_TRACE_DIR, path);
 		if (ret < 0) {
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index a632574..b746713 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -1038,7 +1038,6 @@ error:
 static struct ust_app_session *create_ust_app_session(
 		struct ltt_ust_session *usess, struct ust_app *app)
 {
-	int ret;
 	struct ust_app_session *ua_sess;
 
 	health_code_update(&health_thread_cmd);
@@ -1058,6 +1057,8 @@ static struct ust_app_session *create_ust_app_session(
 	health_code_update(&health_thread_cmd);
 
 	if (ua_sess->handle == -1) {
+		int ret;
+
 		ret = ustctl_create_session(app->sock);
 		if (ret < 0) {
 			ERR("Creating session for app pid %d", app->pid);
@@ -1588,11 +1589,11 @@ int ust_app_list_events(struct lttng_event **events)
 	size_t nbmem, count = 0;
 	struct lttng_ht_iter iter;
 	struct ust_app *app;
-	struct lttng_event *tmp;
+	struct lttng_event *tmp_event;
 
 	nbmem = UST_APP_EVENT_LIST_SIZE;
-	tmp = zmalloc(nbmem * sizeof(struct lttng_event));
-	if (tmp == NULL) {
+	tmp_event = zmalloc(nbmem * sizeof(struct lttng_event));
+	if (tmp_event == NULL) {
 		PERROR("zmalloc ust app events");
 		ret = -ENOMEM;
 		goto error;
@@ -1624,29 +1625,31 @@ int ust_app_list_events(struct lttng_event **events)
 			health_code_update(&health_thread_cmd);
 			if (count >= nbmem) {
 				/* In case the realloc fails, we free the memory */
-				void *tmp_ptr = (void *) tmp;
+				void *ptr;
+
 				DBG2("Reallocating event list from %zu to %zu entries", nbmem,
 						2 * nbmem);
 				nbmem *= 2;
-				tmp = realloc(tmp, nbmem * sizeof(struct lttng_event));
-				if (tmp == NULL) {
+				ptr = realloc(tmp_event, nbmem * sizeof(struct lttng_event));
+				if (ptr == NULL) {
 					PERROR("realloc ust app events");
-					free(tmp_ptr);
+					free(tmp_event);
 					ret = -ENOMEM;
 					goto rcu_error;
 				}
+				tmp_event = ptr;
 			}
-			memcpy(tmp[count].name, uiter.name, LTTNG_UST_SYM_NAME_LEN);
-			tmp[count].loglevel = uiter.loglevel;
-			tmp[count].type = (enum lttng_event_type) LTTNG_UST_TRACEPOINT;
-			tmp[count].pid = app->pid;
-			tmp[count].enabled = -1;
+			memcpy(tmp_event[count].name, uiter.name, LTTNG_UST_SYM_NAME_LEN);
+			tmp_event[count].loglevel = uiter.loglevel;
+			tmp_event[count].type = (enum lttng_event_type) LTTNG_UST_TRACEPOINT;
+			tmp_event[count].pid = app->pid;
+			tmp_event[count].enabled = -1;
 			count++;
 		}
 	}
 
 	ret = count;
-	*events = tmp;
+	*events = tmp_event;
 
 	DBG2("UST app list events done (%zu events)", count);
 
@@ -1666,11 +1669,11 @@ int ust_app_list_event_fields(struct lttng_event_field **fields)
 	size_t nbmem, count = 0;
 	struct lttng_ht_iter iter;
 	struct ust_app *app;
-	struct lttng_event_field *tmp;
+	struct lttng_event_field *tmp_event;
 
 	nbmem = UST_APP_EVENT_LIST_SIZE;
-	tmp = zmalloc(nbmem * sizeof(struct lttng_event_field));
-	if (tmp == NULL) {
+	tmp_event = zmalloc(nbmem * sizeof(struct lttng_event_field));
+	if (tmp_event == NULL) {
 		PERROR("zmalloc ust app event fields");
 		ret = -ENOMEM;
 		goto error;
@@ -1702,34 +1705,36 @@ int ust_app_list_event_fields(struct lttng_event_field **fields)
 			health_code_update(&health_thread_cmd);
 			if (count >= nbmem) {
 				/* In case the realloc fails, we free the memory */
-				void *tmp_ptr = (void *) tmp;
+				void *ptr;
+
 				DBG2("Reallocating event field list from %zu to %zu entries", nbmem,
 						2 * nbmem);
 				nbmem *= 2;
-				tmp = realloc(tmp, nbmem * sizeof(struct lttng_event_field));
-				if (tmp == NULL) {
+				ptr = realloc(tmp_event, nbmem * sizeof(struct lttng_event_field));
+				if (ptr == NULL) {
 					PERROR("realloc ust app event fields");
-					free(tmp_ptr);
+					free(tmp_event);
 					ret = -ENOMEM;
 					goto rcu_error;
 				}
+				tmp_event = ptr;
 			}
 
-			memcpy(tmp[count].field_name, uiter.field_name, LTTNG_UST_SYM_NAME_LEN);
-			tmp[count].type = uiter.type;
-			tmp[count].nowrite = uiter.nowrite;
+			memcpy(tmp_event[count].field_name, uiter.field_name, LTTNG_UST_SYM_NAME_LEN);
+			tmp_event[count].type = uiter.type;
+			tmp_event[count].nowrite = uiter.nowrite;
 
-			memcpy(tmp[count].event.name, uiter.event_name, LTTNG_UST_SYM_NAME_LEN);
-			tmp[count].event.loglevel = uiter.loglevel;
-			tmp[count].event.type = LTTNG_UST_TRACEPOINT;
-			tmp[count].event.pid = app->pid;
-			tmp[count].event.enabled = -1;
+			memcpy(tmp_event[count].event.name, uiter.event_name, LTTNG_UST_SYM_NAME_LEN);
+			tmp_event[count].event.loglevel = uiter.loglevel;
+			tmp_event[count].event.type = LTTNG_UST_TRACEPOINT;
+			tmp_event[count].event.pid = app->pid;
+			tmp_event[count].event.enabled = -1;
 			count++;
 		}
 	}
 
 	ret = count;
-	*fields = tmp;
+	*fields = tmp_event;
 
 	DBG2("UST app list event fields done (%zu events)", count);
 
diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
index 1a53448..b6c18e1 100644
--- a/src/bin/lttng/commands/enable_events.c
+++ b/src/bin/lttng/commands/enable_events.c
@@ -255,7 +255,7 @@ int loglevel_str_to_value(const char *inputstr)
 	int i = 0;
 	char str[LTTNG_SYMBOL_NAME_LEN];
 
-	while (inputstr[i] != '\0' && i < LTTNG_SYMBOL_NAME_LEN) {
+	while (i < LTTNG_SYMBOL_NAME_LEN && inputstr[i] != '\0') {
 		str[i] = toupper(inputstr[i]);
 		i++;
 	}
diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
index 28e1864..48b2c82 100644
--- a/src/bin/lttng/commands/list.c
+++ b/src/bin/lttng/commands/list.c
@@ -680,8 +680,7 @@ error:
  */
 int cmd_list(int argc, const char **argv)
 {
-	int opt, i, ret = CMD_SUCCESS;
-	int nb_domain;
+	int opt, ret = CMD_SUCCESS;
 	const char *session_name;
 	static poptContext pc;
 	struct lttng_domain domain;
@@ -778,6 +777,8 @@ int cmd_list(int argc, const char **argv)
 				goto end;
 			}
 		} else {
+			int i, nb_domain;
+
 			/* We want all domain(s) */
 			nb_domain = lttng_list_domains(session_name, &domains);
 			if (nb_domain < 0) {
diff --git a/src/bin/lttng/commands/view.c b/src/bin/lttng/commands/view.c
index 68ee4fa..e3eff22 100644
--- a/src/bin/lttng/commands/view.c
+++ b/src/bin/lttng/commands/view.c
@@ -278,7 +278,7 @@ error:
  */
 static int view_trace(void)
 {
-	int ret, count, i, found = 0;
+	int ret;
 	char *session_name, *trace_path;
 	struct lttng_session *sessions = NULL;
 
@@ -314,6 +314,8 @@ static int view_trace(void)
 	DBG("Viewing trace for session %s", session_name);
 
 	if (session_name) {
+		int i, count, found = 0;
+
 		/* Getting all sessions */
 		count = lttng_list_sessions(&sessions);
 		if (count < 0) {
diff --git a/src/common/sessiond-comm/sessiond-comm.c b/src/common/sessiond-comm/sessiond-comm.c
index 8ced847..799290c 100644
--- a/src/common/sessiond-comm/sessiond-comm.c
+++ b/src/common/sessiond-comm/sessiond-comm.c
@@ -78,7 +78,7 @@ const char *lttcomm_get_readable_code(enum lttcomm_return_code code)
 {
 	code = -code;
 
-	if (code < LTTCOMM_CONSUMERD_COMMAND_SOCK_READY && code > LTTCOMM_NR) {
+	if (code < LTTCOMM_CONSUMERD_COMMAND_SOCK_READY || code > LTTCOMM_NR) {
 		code = LTTCOMM_NR;
 	}
 
diff --git a/src/common/sessiond-comm/unix.c b/src/common/sessiond-comm/unix.c
index bbf030f..46076e5 100644
--- a/src/common/sessiond-comm/unix.c
+++ b/src/common/sessiond-comm/unix.c
@@ -257,6 +257,7 @@ ssize_t lttcomm_send_fds_unix_sock(int sock, int *fds, size_t nb_fd)
 	char dummy = 0;
 
 	memset(&msg, 0, sizeof(msg));
+	memset(tmp, 0, CMSG_SPACE(sizeof_fds) * sizeof(char));
 
 	if (nb_fd > LTTCOMM_MAX_SEND_FDS)
 		return -EINVAL;
@@ -380,6 +381,7 @@ ssize_t lttcomm_send_creds_unix_sock(int sock, void *buf, size_t len)
 #endif /* __linux__ */
 
 	memset(&msg, 0, sizeof(msg));
+	memset(anc_buf, 0, CMSG_SPACE(sizeof_cred) * sizeof(char));
 
 	iov[0].iov_base = buf;
 	iov[0].iov_len = len;
diff --git a/src/common/uri.c b/src/common/uri.c
index 3550af9..f64a0de 100644
--- a/src/common/uri.c
+++ b/src/common/uri.c
@@ -342,7 +342,6 @@ ssize_t uri_parse(const char *str_uri, struct lttng_uri **uris)
 	 * so we can define the control and data port.
 	 */
 	while (*purl == ':') {
-		int port;
 		const char *port_b, *port_e;
 		char *port_f;
 
@@ -369,6 +368,8 @@ ssize_t uri_parse(const char *str_uri, struct lttng_uri **uris)
 		port_e = purl;
 
 		if (port_b != port_e) {
+			int port;
+
 			port_f = utils_strdupdelim(port_b, port_e);
 			if (port_f == NULL) {
 				goto free_error;
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index b49f59c..e5c5256 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -484,13 +484,14 @@ int lttng_ustconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
 	struct lttng_ust_shm_handle *handle;
 	struct lttng_ust_lib_ring_buffer *buf;
 	char dummy;
-	ssize_t readlen;
 
 	DBG("In read_subbuffer (wait_fd: %d, stream key: %d)",
 		stream->wait_fd, stream->key);
 
 	/* We can consume the 1 byte written into the wait_fd by UST */
 	if (!stream->hangup_flush_done) {
+		ssize_t readlen;
+
 		do {
 			readlen = read(stream->wait_fd, &dummy, 1);
 		} while (readlen == -1 && errno == EINTR);
diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
index 96351bd..775d1c3 100644
--- a/src/lib/lttng-ctl/lttng-ctl.c
+++ b/src/lib/lttng-ctl/lttng-ctl.c
@@ -90,7 +90,6 @@ static void set_default_url_attr(struct lttng_uri *uri,
 static ssize_t parse_str_urls_to_uri(const char *ctrl_url, const char *data_url,
 		struct lttng_uri **uris)
 {
-	int ret;
 	unsigned int equal = 1, idx = 0;
 	/* Add the "file://" size to the URL maximum size */
 	char url[PATH_MAX + 7];
@@ -115,6 +114,8 @@ static ssize_t parse_str_urls_to_uri(const char *ctrl_url, const char *data_url,
 	 * Check if first character is a '/' or else reject the URL.
 	 */
 	if (ctrl_url && ctrl_url[0] == '/') {
+		int ret;
+
 		ret = snprintf(url, sizeof(url), "file://%s", ctrl_url);
 		if (ret < 0) {
 			PERROR("snprintf file url");
@@ -414,7 +415,6 @@ error:
  */
 static int set_session_daemon_path(void)
 {
-	int ret;
 	int in_tgroup = 0;	/* In tracing group */
 	uid_t uid;
 
@@ -431,6 +431,8 @@ static int set_session_daemon_path(void)
 	}
 
 	if (uid != 0) {
+		int ret;
+
 		if (in_tgroup) {
 			/* Tracing group */
 			ret = try_connect_sessiond(sessiond_sock_path);
@@ -1496,7 +1498,6 @@ int lttng_disable_consumer(struct lttng_handle *handle)
  */
 static int set_health_socket_path(void)
 {
-	int ret;
 	int in_tgroup = 0;	/* In tracing group */
 	uid_t uid;
 	const char *home;
@@ -1514,6 +1515,8 @@ static int set_health_socket_path(void)
 	}
 
 	if (uid != 0) {
+		int ret;
+
 		/*
 		 * With GNU C <  2.1, snprintf returns -1 if the target buffer is too small;
 		 * With GNU C >= 2.1, snprintf returns the required size (excluding closing null)
@@ -1601,7 +1604,6 @@ error:
 int _lttng_create_session_ext(const char *name, const char *url,
 		const char *datetime)
 {
-	int ret;
 	ssize_t size;
 	struct lttcomm_session_msg lsm;
 	struct lttng_uri *uris = NULL;
@@ -1624,6 +1626,8 @@ int _lttng_create_session_ext(const char *name, const char *url,
 	lsm.u.uri.size = size;
 
 	if (size > 0 && uris[0].dtype != LTTNG_DST_PATH && strlen(uris[0].subdir) == 0) {
+		int ret;
+
 		ret = snprintf(uris[0].subdir, sizeof(uris[0].subdir), "%s-%s", name,
 				datetime);
 		if (ret < 0) {

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
