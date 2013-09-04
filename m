From: Zifei Tong <soariez@gmail.com>
Subject: [RFC PATCH lttng-ust] Add basic support for dynamic
	instrumentation
Date: Wed,  4 Sep 2013 19:02:13 +0800
Message-ID: <1378292533-18412-1-git-send-email-soariez__40113.7979155921$1378292620$gmane$org@gmail.com>
References: <CAJ7wx-EDBibZ-MO7pWfGGBdx+2yzN7pENpWpEoWAj7r5hDSGSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <soariez@gmail.com>) id 1VHAr2-0001Zs-NJ
	for lttng-dev@lists.lttng.org; Wed, 04 Sep 2013 07:02:34 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so277333pab.8
	for <lttng-dev@lists.lttng.org>; Wed, 04 Sep 2013 04:02:27 -0700 (PDT)
In-Reply-To: <CAJ7wx-EDBibZ-MO7pWfGGBdx+2yzN7pENpWpEoWAj7r5hDSGSA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Support for instrument shared libraries is not implemented yet.

You can also view the patch at:
https://github.com/5kg/lttng-ust/commit/ae460fd8c5a2d77a4303bf82df26cc8f5cb7e392
---
 include/lttng/ust-abi.h            |  30 ++++++++++-
 include/lttng/ust-ctl.h            |  19 +++++++
 include/lttng/ust-events.h         |   3 ++
 include/ust-comm.h                 |  28 ++++++++++
 liblttng-ust-comm/lttng-ust-comm.c |  76 +++++++++++++++++++++++++++
 liblttng-ust-ctl/ustctl.c          | 103 +++++++++++++++++++++++++++++++++++++
 liblttng-ust/compat.h              |  13 +++++
 liblttng-ust/lttng-events.c        |  99 ++++++++++++++++++++++++++++-------
 liblttng-ust/lttng-ust-abi.c       |  16 ++++++
 liblttng-ust/lttng-ust-comm.c      |  62 ++++++++++++++++++++++
 10 files changed, 430 insertions(+), 19 deletions(-)

diff --git a/include/lttng/ust-abi.h b/include/lttng/ust-abi.h
index 6630332..f1787d4 100644
--- a/include/lttng/ust-abi.h
+++ b/include/lttng/ust-abi.h
@@ -98,7 +98,32 @@ struct lttng_ust_stream {
 	 */
 } LTTNG_PACKED;
 
-#define LTTNG_UST_EVENT_PADDING1	16
+/*
+ * Either addr is used, or symbol_name and offset.
+ */
+#define LTTNG_UST_PROBE_PADDING	16
+struct lttng_ust_probe {
+	uint64_t addr;
+
+	uint64_t offset;
+	char symbol_name[LTTNG_UST_SYM_NAME_LEN];
+
+	char padding[LTTNG_UST_PROBE_PADDING];
+} LTTNG_PACKED;
+
+/*
+ * Instrument target
+ */
+#define LTTNG_UST_TARGET_PADDING	32
+struct lttng_ust_target {
+	uint32_t path_len;
+
+	char padding[LTTNG_UST_TARGET_PADDING];
+
+	char path[0];
+} LTTNG_PACKED;
+
+#define LTTNG_UST_EVENT_PADDING1	(16 - sizeof(struct lttng_ust_target *))
 #define LTTNG_UST_EVENT_PADDING2	(LTTNG_UST_SYM_NAME_LEN + 32)
 struct lttng_ust_event {
 	enum lttng_ust_instrumentation instrumentation;
@@ -106,10 +131,12 @@ struct lttng_ust_event {
 
 	enum lttng_ust_loglevel_type loglevel_type;
 	int loglevel;	/* value, -1: all */
+	struct lttng_ust_target *target;
 	char padding[LTTNG_UST_EVENT_PADDING1];
 
 	/* Per instrumentation type configuration */
 	union {
+		struct lttng_ust_probe probe;
 		char padding[LTTNG_UST_EVENT_PADDING2];
 	} u;
 } LTTNG_PACKED;
@@ -273,6 +300,7 @@ struct lttng_ust_filter_bytecode {
 
 /* Event FD commands */
 #define LTTNG_UST_FILTER			_UST_CMD(0xA0)
+#define LTTNG_UST_TARGET			_UST_CMD(0xA1)
 
 #define LTTNG_UST_ROOT_HANDLE	0
 
diff --git a/include/lttng/ust-ctl.h b/include/lttng/ust-ctl.h
index 3c81e50..f88fbc7 100644
--- a/include/lttng/ust-ctl.h
+++ b/include/lttng/ust-ctl.h
@@ -73,6 +73,8 @@ int ustctl_add_context(int sock, struct lttng_ust_context *ctx,
 		struct lttng_ust_object_data **context_data);
 int ustctl_set_filter(int sock, struct lttng_ust_filter_bytecode *bytecode,
 		struct lttng_ust_object_data *obj_data);
+int ustctl_set_target(int sock, struct lttng_ust_target *target,
+		struct lttng_ust_object_data *obj_data);
 
 int ustctl_enable(int sock, struct lttng_ust_object_data *object);
 int ustctl_disable(int sock, struct lttng_ust_object_data *object);
@@ -230,6 +232,7 @@ enum ustctl_socket_type {
 enum ustctl_notify_cmd {
 	USTCTL_NOTIFY_CMD_EVENT = 0,
 	USTCTL_NOTIFY_CMD_CHANNEL = 1,
+	USTCTL_NOTIFY_CMD_INSTRUMENT = 2,
 };
 
 enum ustctl_channel_header {
@@ -395,4 +398,20 @@ int ustctl_reply_register_channel(int sock,
 	enum ustctl_channel_header header_type,
 	int ret_code);			/* return code. 0 ok, negative error */
 
+/*
+ * Returns 0 on success, negative error value on error.
+ */
+int ustctl_recv_instrument_probe(int sock,
+	char *object_path,
+	char *name,
+	enum lttng_ust_instrumentation *instrumentation,
+	uint64_t *addr,
+	char *symbol,
+	uint64_t *offset);
+
+/*
+ * Returns 0 on success, negative error value on error.
+ */
+int ustctl_reply_instrument_probe(int sock, int ret_code);
+
 #endif /* _LTTNG_UST_CTL_H */
diff --git a/include/lttng/ust-events.h b/include/lttng/ust-events.h
index f40c044..4759943 100644
--- a/include/lttng/ust-events.h
+++ b/include/lttng/ust-events.h
@@ -290,6 +290,7 @@ struct lttng_probe_desc {
 enum lttng_enabler_type {
 	LTTNG_ENABLER_WILDCARD,
 	LTTNG_ENABLER_EVENT,
+	LTTNG_ENABLER_INSTRUMENT,
 };
 
 /*
@@ -536,6 +537,8 @@ int lttng_enabler_enable(struct lttng_enabler *enabler);
 int lttng_enabler_disable(struct lttng_enabler *enabler);
 int lttng_enabler_attach_bytecode(struct lttng_enabler *enabler,
 		struct lttng_ust_filter_bytecode_node *bytecode);
+int lttng_enabler_attach_target(struct lttng_enabler *enabler,
+		struct lttng_ust_target *target);
 int lttng_enabler_attach_context(struct lttng_enabler *enabler,
 		struct lttng_ust_context *ctx);
 
diff --git a/include/ust-comm.h b/include/ust-comm.h
index 7f268b7..e555da8 100644
--- a/include/ust-comm.h
+++ b/include/ust-comm.h
@@ -90,6 +90,9 @@ struct ustcomm_ust_msg {
 			uint32_t reloc_offset;
 			uint64_t seqnum;
 		} LTTNG_PACKED filter;
+		struct {
+			uint32_t data_size;	/* following target data */
+		} LTTNG_PACKED target;
 		char padding[USTCOMM_MSG_PADDING2];
 	} u;
 } LTTNG_PACKED;
@@ -160,6 +163,24 @@ struct ustcomm_notify_channel_reply {
 	char padding[USTCOMM_NOTIFY_CHANNEL_REPLY_PADDING];
 } LTTNG_PACKED;
 
+#define USTCOMM_NOTIFY_INSTRUMENT_MSG_PADDING	32
+struct ustcomm_notify_instrument_msg {
+	uint32_t instrumentation;	/* enum lttng_ust_instrumentation */
+	char name[LTTNG_UST_SYM_NAME_LEN];
+	uint64_t addr;
+	char symbol[LTTNG_UST_SYM_NAME_LEN];
+	uint64_t offset;
+	uint32_t object_path_len;
+	char padding[USTCOMM_NOTIFY_INSTRUMENT_MSG_PADDING];
+	/* followed by object_path */
+} LTTNG_PACKED;
+
+#define USTCOMM_NOTIFY_INSTRUMENT_REPLY_PADDING	32
+struct ustcomm_notify_instrument_reply {
+	int32_t ret_code;	/* 0: ok, negative: error code */
+	char padding[USTCOMM_NOTIFY_INSTRUMENT_REPLY_PADDING];
+} LTTNG_PACKED;
+
 /*
  * LTTNG_UST_TRACEPOINT_FIELD_LIST reply is followed by a
  * struct lttng_ust_field_iter field.
@@ -231,6 +252,13 @@ int ustcomm_register_channel(int sock,
 	uint32_t *chan_id,		/* channel id (output) */
 	int *header_type); 		/* header type (output) */
 
+/*
+ * Returns 0 on success, negative error value on error.
+ * Returns -EPIPE or -ECONNRESET if other end has hung up.
+ */
+int ustcomm_instrument_probe(int sock,
+	const struct lttng_ust_event *uevent);	/* userspace event */
+
 int ustcomm_setsockopt_rcv_timeout(int sock, unsigned int msec);
 int ustcomm_setsockopt_snd_timeout(int sock, unsigned int msec);
 
diff --git a/liblttng-ust-comm/lttng-ust-comm.c b/liblttng-ust-comm/lttng-ust-comm.c
index a31786a..796f654 100644
--- a/liblttng-ust-comm/lttng-ust-comm.c
+++ b/liblttng-ust-comm/lttng-ust-comm.c
@@ -1111,6 +1111,82 @@ int ustcomm_register_channel(int sock,
 }
 
 /*
+ * Returns 0 on success, negative error value on error.
+ */
+int ustcomm_instrument_probe(int sock,
+	const struct lttng_ust_event *uevent)	/* userspace event */
+{
+	ssize_t len;
+	struct {
+		struct ustcomm_notify_hdr header;
+		struct ustcomm_notify_instrument_msg m;
+	} msg;
+	struct {
+		struct ustcomm_notify_hdr header;
+		struct ustcomm_notify_instrument_reply r;
+	} reply;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.header.notify_cmd = USTCTL_NOTIFY_CMD_INSTRUMENT;
+	msg.m.instrumentation = uevent->instrumentation;
+	strncpy(msg.m.name, uevent->name, LTTNG_UST_SYM_NAME_LEN);
+	msg.m.name[LTTNG_UST_SYM_NAME_LEN - 1] = '\0';
+	msg.m.addr = uevent->u.probe.addr;
+	strncpy(msg.m.symbol, uevent->u.probe.symbol_name, LTTNG_UST_SYM_NAME_LEN);
+	msg.m.symbol[LTTNG_UST_SYM_NAME_LEN - 1] = '\0';
+	msg.m.offset = uevent->u.probe.offset;
+	msg.m.object_path_len = uevent->target->path_len;
+
+	len = ustcomm_send_unix_sock(sock, &msg, sizeof(msg));
+	if (len > 0 && len != sizeof(msg)) {
+		return -EIO;
+	}
+	if (len < 0) {
+		return len;
+	}
+
+	len = ustcomm_send_unix_sock(sock, uevent->target->path,
+			uevent->target->path_len);
+	if (len > 0 && len != uevent->target->path_len) {
+		return -EIO;
+	}
+	if (len < 0) {
+		return len;
+	}
+
+	/* receive reply */
+	len = ustcomm_recv_unix_sock(sock, &reply, sizeof(reply));
+	switch (len) {
+	case 0:	/* orderly shutdown */
+		return -EPIPE;
+	case sizeof(reply):
+		if (reply.header.notify_cmd != msg.header.notify_cmd) {
+			ERR("Unexpected result message command "
+				"expected: %u vs received: %u\n",
+				msg.header.notify_cmd, reply.header.notify_cmd);
+			return -EINVAL;
+		}
+		if (reply.r.ret_code > 0)
+			return -EINVAL;
+		if (reply.r.ret_code < 0)
+			return reply.r.ret_code;
+		DBG("Sent instrument probe notification for object \"%s\": ret_code %d\n",
+			uevent->target->path, reply.r.ret_code);
+		return 0;
+	default:
+		if (len < 0) {
+			/* Transport level error */
+			if (errno == EPIPE || errno == ECONNRESET)
+				len = -errno;
+			return len;
+		} else {
+			ERR("incorrect message size: %zd\n", len);
+			return len;
+		}
+	}
+}
+
+/*
  * Set socket reciving timeout.
  */
 int ustcomm_setsockopt_rcv_timeout(int sock, unsigned int msec)
diff --git a/liblttng-ust-ctl/ustctl.c b/liblttng-ust-ctl/ustctl.c
index 28dee5e..684c2e6 100644
--- a/liblttng-ust-ctl/ustctl.c
+++ b/liblttng-ust-ctl/ustctl.c
@@ -196,6 +196,10 @@ int ustctl_create_event(int sock, struct lttng_ust_event *ev,
 	lum.cmd = LTTNG_UST_EVENT;
 	strncpy(lum.u.event.name, ev->name,
 		LTTNG_UST_SYM_NAME_LEN);
+	lum.u.event.u.probe.addr = ev->u.probe.addr;
+	lum.u.event.u.probe.offset = ev->u.probe.offset;
+	strncpy(lum.u.event.u.probe.symbol_name, ev->u.probe.symbol_name,
+		LTTNG_UST_SYM_NAME_LEN);
 	lum.u.event.instrumentation = ev->instrumentation;
 	lum.u.event.loglevel_type = ev->loglevel_type;
 	lum.u.event.loglevel = ev->loglevel;
@@ -241,6 +245,35 @@ int ustctl_add_context(int sock, struct lttng_ust_context *ctx,
 	return ret;
 }
 
+int ustctl_set_target(int sock, struct lttng_ust_target *target,
+		struct lttng_ust_object_data *obj_data)
+{
+	struct ustcomm_ust_msg lum;
+	struct ustcomm_ust_reply lur;
+	int ret;
+
+	if (!obj_data)
+		return -EINVAL;
+
+	memset(&lum, 0, sizeof(lum));
+	lum.handle = obj_data->handle;
+	lum.cmd = LTTNG_UST_TARGET;
+	lum.u.target.data_size = sizeof(struct lttng_ust_target)
+			+ target->path_len;
+
+	ret = ustcomm_send_app_msg(sock, &lum);
+	if (ret)
+		return ret;
+	/* send var len target struct */
+	ret = ustcomm_send_unix_sock(sock, target, lum.u.target.data_size);
+	if (ret < 0) {
+		return ret;
+	}
+	if (ret != lum.u.target.data_size)
+		return -EINVAL;
+	return ustcomm_recv_app_reply(sock, &lur, lum.handle, lum.cmd);
+}
+
 int ustctl_set_filter(int sock, struct lttng_ust_filter_bytecode *bytecode,
 		struct lttng_ust_object_data *obj_data)
 {
@@ -1548,6 +1581,9 @@ int ustctl_recv_notify(int sock, enum ustctl_notify_cmd *notify_cmd)
 	case 1:
 		*notify_cmd = USTCTL_NOTIFY_CMD_CHANNEL;
 		break;
+	case 2:
+		*notify_cmd = USTCTL_NOTIFY_CMD_INSTRUMENT;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1799,6 +1835,73 @@ int ustctl_reply_register_channel(int sock,
 	return 0;
 }
 
+/*
+ * Returns 0 on success, negative error value on error.
+ */
+int ustctl_recv_instrument_probe(int sock,
+	char *object_path,
+	char *name,
+	enum lttng_ust_instrumentation *instrumentation,
+	uint64_t *addr,
+	char *symbol,
+	uint64_t *offset)
+{
+	ssize_t len;
+	struct ustcomm_notify_instrument_msg msg;
+
+	len = ustcomm_recv_unix_sock(sock, &msg, sizeof(msg));
+	if (len > 0 && len != sizeof(msg))
+		return -EIO;
+	if (len == 0)
+		return -EPIPE;
+	if (len < 0)
+		return len;
+
+	strncpy(name, msg.name, LTTNG_UST_SYM_NAME_LEN);
+	name[LTTNG_UST_SYM_NAME_LEN - 1] = '\0';
+	*instrumentation = msg.instrumentation;
+	*addr = msg.addr;
+	strncpy(symbol, msg.symbol, LTTNG_UST_SYM_NAME_LEN);
+	symbol[LTTNG_UST_SYM_NAME_LEN - 1] = '\0';
+	*offset = msg.offset;
+
+	if (msg.object_path_len <= 0) {
+		return -EINVAL;
+	}
+
+	len = ustcomm_recv_unix_sock(sock, object_path, msg.object_path_len);
+	if (len > 0 && len != msg.object_path_len)
+		return -EIO;
+	if (len == 0)
+		return -EPIPE;
+	if (len < 0)
+		return len;
+
+	return 0;
+}
+
+/*
+ * Returns 0 on success, negative error value on error.
+ */
+int ustctl_reply_instrument_probe(int sock, int ret_code)
+{
+	ssize_t len;
+	struct {
+		struct ustcomm_notify_hdr header;
+		struct ustcomm_notify_instrument_reply r;
+	} reply;
+
+	memset(&reply, 0, sizeof(reply));
+	reply.header.notify_cmd = USTCTL_NOTIFY_CMD_INSTRUMENT;
+	reply.r.ret_code = ret_code;
+	len = ustcomm_send_unix_sock(sock, &reply, sizeof(reply));
+	if (len > 0 && len != sizeof(reply))
+		return -EIO;
+	if (len < 0)
+		return len;
+	return 0;
+}
+
 static __attribute__((constructor))
 void ustctl_init(void)
 {
diff --git a/liblttng-ust/compat.h b/liblttng-ust/compat.h
index 43b2223..9504517 100644
--- a/liblttng-ust/compat.h
+++ b/liblttng-ust/compat.h
@@ -25,6 +25,7 @@
 #ifdef __linux__
 
 #include <sys/prctl.h>
+#include <unistd.h>
 
 #define LTTNG_UST_PROCNAME_LEN 17
 
@@ -34,6 +35,18 @@ void lttng_ust_getprocname(char *name)
 	(void) prctl(PR_GET_NAME, (unsigned long) name, 0, 0, 0);
 }
 
+static inline
+int lttng_ust_getexecpath(char *path)
+{
+	ssize_t len;
+
+	if ((len = readlink("/proc/self/exe", path, PATH_MAX)) != -1) {
+		path[len] = '\0';
+		return len;
+	}
+	return -1;
+}
+
 #elif defined(__FreeBSD__)
 #include <stdlib.h>
 #include <string.h>
diff --git a/liblttng-ust/lttng-events.c b/liblttng-ust/lttng-events.c
index 26601a6..36a2ed6 100644
--- a/liblttng-ust/lttng-events.c
+++ b/liblttng-ust/lttng-events.c
@@ -441,18 +441,47 @@ exist:
 	return ret;
 }
 
+/*
+ * Notify sessiond to instrument the application.
+ */
 static
-int lttng_desc_match_wildcard_enabler(const struct lttng_event_desc *desc,
+int lttng_probe_instrument(const struct lttng_ust_event *uevent,
+		struct lttng_channel *chan)
+{
+	struct lttng_session *session = chan->session;
+	int ret = 0;
+	int notify_socket;
+
+	/* TODO: check if the probe is already instrumented */
+	/* TODO: register the probe, assuming probe registered for now */
+
+	notify_socket = lttng_get_notify_socket(session->owner);
+	if (notify_socket < 0) {
+		ret = notify_socket;
+		goto socket_error;
+	}
+
+	/* Notify sessiond to do the instrumentation */
+	ret = ustcomm_instrument_probe(notify_socket, uevent);
+	if (ret < 0) {
+		DBG("Error (%d) instrument probe by sessiond", ret);
+		goto sessiond_instrument_error;
+	}
+	return 0;
+
+socket_error:
+sessiond_instrument_error:
+	return ret;
+}
+
+
+static
+int lttng_desc_loglevel_match_enabler(const struct lttng_event_desc *desc,
 		struct lttng_enabler *enabler)
 {
 	int loglevel = 0;
 	unsigned int has_loglevel = 0;
 
-	assert(enabler->type == LTTNG_ENABLER_WILDCARD);
-	/* Compare excluding final '*' */
-	if (strncmp(desc->name, enabler->event_param.name,
-			strlen(enabler->event_param.name) - 1))
-		return 0;
 	if (desc->loglevel) {
 		loglevel = *(*desc->loglevel);
 		has_loglevel = 1;
@@ -466,25 +495,40 @@ int lttng_desc_match_wildcard_enabler(const struct lttng_event_desc *desc,
 }
 
 static
-int lttng_desc_match_event_enabler(const struct lttng_event_desc *desc,
+int lttng_desc_match_wildcard_enabler(const struct lttng_event_desc *desc,
 		struct lttng_enabler *enabler)
 {
-	int loglevel = 0;
-	unsigned int has_loglevel = 0;
+	assert(enabler->type == LTTNG_ENABLER_WILDCARD);
+	/* Compare excluding final '*' */
+	if (strncmp(desc->name, enabler->event_param.name,
+			strlen(enabler->event_param.name) - 1))
+		return 0;
+	return lttng_desc_loglevel_match_enabler(desc, enabler);
+}
 
+static
+int lttng_desc_match_event_enabler(const struct lttng_event_desc *desc,
+		struct lttng_enabler *enabler)
+{
 	assert(enabler->type == LTTNG_ENABLER_EVENT);
 	if (strcmp(desc->name, enabler->event_param.name))
 		return 0;
-	if (desc->loglevel) {
-		loglevel = *(*desc->loglevel);
-		has_loglevel = 1;
-	}
-	if (!lttng_loglevel_match(loglevel,
-			has_loglevel,
-			enabler->event_param.loglevel_type,
-			enabler->event_param.loglevel))
+	return lttng_desc_loglevel_match_enabler(desc, enabler);
+}
+
+static
+int lttng_desc_match_instrument_enabler(const struct lttng_event_desc *desc,
+		struct lttng_enabler *enabler)
+{
+	char exec_path[PATH_MAX];
+
+	assert(enabler->type == LTTNG_ENABLER_INSTRUMENT);
+	if (lttng_ust_getexecpath(exec_path) == -1)
 		return 0;
-	return 1;
+	if (strcmp(exec_path, enabler->event_param.target->path))
+		return 0;
+	/* TODO: match shared libraries */
+	return lttng_desc_loglevel_match_enabler(desc, enabler);
 }
 
 static
@@ -496,6 +540,8 @@ int lttng_desc_match_enabler(const struct lttng_event_desc *desc,
 		return lttng_desc_match_wildcard_enabler(desc, enabler);
 	case LTTNG_ENABLER_EVENT:
 		return lttng_desc_match_event_enabler(desc, enabler);
+	case LTTNG_ENABLER_INSTRUMENT:
+		return lttng_desc_match_instrument_enabler(desc, enabler);
 	default:
 		return -EINVAL;
 	}
@@ -574,6 +620,15 @@ void lttng_create_event_if_missing(struct lttng_enabler *enabler)
 			if (found)
 				continue;
 
+			if (enabler->type == LTTNG_ENABLER_INSTRUMENT) {
+				ret = lttng_probe_instrument(&enabler->event_param,
+						enabler->chan);
+				if (ret) {
+					DBG("Unable to instrument probe %s, error %d",
+						enabler->event_param.name, ret);
+				}
+			}
+
 			/*
 			 * We need to create an event for this
 			 * event probe.
@@ -720,6 +775,14 @@ int lttng_enabler_attach_bytecode(struct lttng_enabler *enabler,
 	return 0;
 }
 
+int lttng_enabler_attach_target(struct lttng_enabler *enabler,
+		struct lttng_ust_target *target)
+{
+	enabler->event_param.target = target;
+	lttng_session_lazy_sync_enablers(enabler->chan->session);
+	return 0;
+}
+
 int lttng_attach_context(struct lttng_ust_context *context_param,
 		struct lttng_ctx **ctx, struct lttng_session *session)
 {
diff --git a/liblttng-ust/lttng-ust-abi.c b/liblttng-ust/lttng-ust-abi.c
index a852aae..befb9ea 100644
--- a/liblttng-ust/lttng-ust-abi.c
+++ b/liblttng-ust/lttng-ust-abi.c
@@ -875,6 +875,15 @@ long lttng_channel_cmd(int objd, unsigned int cmd, unsigned long arg,
 	{
 		struct lttng_ust_event *event_param =
 			(struct lttng_ust_event *) arg;
+
+		switch (event_param->instrumentation) {
+			case LTTNG_UST_PROBE:
+			case LTTNG_UST_FUNCTION:
+				return lttng_abi_create_enabler(objd, event_param,
+						owner, LTTNG_ENABLER_INSTRUMENT);
+			default: break;
+		}
+
 		if (event_param->name[strlen(event_param->name) - 1] == '*') {
 			/* If ends with wildcard, create wildcard. */
 			return lttng_abi_create_enabler(objd, event_param,
@@ -933,6 +942,8 @@ static const struct lttng_ust_objd_ops lttng_channel_ops = {
  *		Disable recording for this enabler
  *	LTTNG_UST_FILTER
  *		Attach a filter to an enabler.
+ *	LTTNG_UST_TARGET
+ *		Attach a target to an enabler.
  */
 static
 long lttng_enabler_cmd(int objd, unsigned int cmd, unsigned long arg,
@@ -958,6 +969,11 @@ long lttng_enabler_cmd(int objd, unsigned int cmd, unsigned long arg,
 			return ret;
 		return 0;
 	}
+	case LTTNG_UST_TARGET:
+	{
+		return lttng_enabler_attach_target(enabler,
+				(struct lttng_ust_target *) arg);
+	}
 	default:
 		return -EINVAL;
 	}
diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index 475110c..6815638 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -172,6 +172,7 @@ static const char *cmd_name_mapping[] = {
 
 	/* Event FD commands */
 	[ LTTNG_UST_FILTER ] = "Create Filter",
+	[ LTTNG_UST_TARGET ] = "Create Target",
 };
 
 static const char *str_timeout;
@@ -487,6 +488,67 @@ int handle_message(struct sock_info *sock_info,
 		}
 		break;
 	}
+	case LTTNG_UST_TARGET:
+	{
+		/* Receive filter data */
+		struct lttng_ust_target *target;
+
+		if (lum->u.target.data_size >
+				sizeof(struct lttng_ust_target) + PATH_MAX) {
+			ERR("Target data size is too large: %u bytes",
+				lum->u.target.data_size);
+			ret = -EINVAL;
+			goto error;
+		}
+
+		target = zmalloc(lum->u.target.data_size);
+		if (!target) {
+			ret = -ENOMEM;
+			goto error;
+		}
+		len = ustcomm_recv_unix_sock(sock, target,
+				lum->u.target.data_size);
+		switch (len) {
+		case 0:	/* orderly shutdown */
+			ret = 0;
+			free(target);
+			goto error;
+		default:
+			if (len == lum->u.target.data_size) {
+				DBG("target data received");
+				break;
+			} else if (len < 0) {
+				DBG("Receive failed from lttng-sessiond with errno %d", (int) -len);
+				if (len == -ECONNRESET) {
+					ERR("%s remote end closed connection", sock_info->name);
+					ret = len;
+					free(target);
+					goto error;
+				}
+				ret = len;
+				free(target);
+				goto end;
+			} else {
+				DBG("incorrect target data message size: %zd", len);
+				ret = -EINVAL;
+				free(target);
+				goto end;
+			}
+		}
+		if (ops->cmd) {
+			ret = ops->cmd(lum->handle, lum->cmd,
+					(unsigned long) target,
+					&args, sock_info);
+			if (ret) {
+				free(target);
+			}
+			/* don't free target if everything went fine. */
+		} else {
+			ret = -ENOSYS;
+			free(target);
+		}
+		break;
+	}
 	case LTTNG_UST_CHANNEL:
 	{
 		void *chan_data;
-- 
1.8.4
