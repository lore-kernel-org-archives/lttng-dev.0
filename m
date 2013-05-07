From: David Goulet <dgoulet@efficios.com>
Subject: [PATCH lttng-tools] Fix: change default UST per UID
	subbuffer size
Date: Tue,  7 May 2013 12:04:52 -0400
Message-ID: <1367942692-10203-1-git-send-email-dgoulet__42046.7425873086$1367942755$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UZkO6-0003G3-OZ
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 12:05:11 -0400
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

The default per UID subbuffer size are changed from 4096 bytes to 131072
bytes (128k).

Fixes #524

Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 src/bin/lttng-sessiond/channel.c |   40 +++++++++++++++++++++++++-------------
 src/bin/lttng-sessiond/channel.h |    3 ++-
 src/bin/lttng-sessiond/cmd.c     |   14 ++++++++-----
 src/common/defaults.c            |    9 ++++++---
 src/common/defaults.h            |   25 ++++++++++++++++++------
 src/lib/lttng-ctl/lttng-ctl.c    |    6 +++++-
 6 files changed, 67 insertions(+), 30 deletions(-)

diff --git a/src/bin/lttng-sessiond/channel.c b/src/bin/lttng-sessiond/channel.c
index ff2db69..e402d35 100644
--- a/src/bin/lttng-sessiond/channel.c
+++ b/src/bin/lttng-sessiond/channel.c
@@ -33,7 +33,8 @@
 /*
  * Return allocated channel attributes.
  */
-struct lttng_channel *channel_new_default_attr(int dom)
+struct lttng_channel *channel_new_default_attr(int dom,
+		enum lttng_buffer_type type)
 {
 	struct lttng_channel *chan;
 
@@ -53,6 +54,7 @@ struct lttng_channel *channel_new_default_attr(int dom)
 
 	switch (dom) {
 	case LTTNG_DOMAIN_KERNEL:
+		assert(type == LTTNG_BUFFER_GLOBAL);
 		chan->attr.subbuf_size =
 			default_get_kernel_channel_subbuf_size();
 		chan->attr.num_subbuf = DEFAULT_KERNEL_CHANNEL_SUBBUF_NUM;
@@ -61,12 +63,15 @@ struct lttng_channel *channel_new_default_attr(int dom)
 		chan->attr.read_timer_interval = DEFAULT_KERNEL_CHANNEL_READ_TIMER;
 		break;
 	case LTTNG_DOMAIN_UST:
-#if 0
-	case LTTNG_DOMAIN_UST_PID:
-	case LTTNG_DOMAIN_UST_PID_FOLLOW_CHILDREN:
-	case LTTNG_DOMAIN_UST_EXEC_NAME:
-#endif
-		chan->attr.subbuf_size = default_get_ust_channel_subbuf_size();
+		switch (type) {
+		case LTTNG_BUFFER_PER_UID:
+			chan->attr.subbuf_size = default_get_ust_uid_channel_subbuf_size();
+			break;
+		case LTTNG_BUFFER_PER_PID:
+		default:
+			chan->attr.subbuf_size = default_get_ust_pid_channel_subbuf_size();
+			break;
+		}
 		chan->attr.num_subbuf = DEFAULT_UST_CHANNEL_SUBBUF_NUM;
 		chan->attr.output = DEFAULT_UST_CHANNEL_OUTPUT;
 		chan->attr.switch_timer_interval = DEFAULT_UST_CHANNEL_SWITCH_TIMER;
@@ -158,7 +163,8 @@ int channel_kernel_create(struct ltt_kernel_session *ksession,
 
 	/* Creating channel attributes if needed */
 	if (attr == NULL) {
-		defattr = channel_new_default_attr(LTTNG_DOMAIN_KERNEL);
+		defattr = channel_new_default_attr(LTTNG_DOMAIN_KERNEL,
+				LTTNG_BUFFER_GLOBAL);
 		if (defattr == NULL) {
 			ret = LTTNG_ERR_FATAL;
 			goto error;
@@ -237,7 +243,7 @@ int channel_ust_create(struct ltt_ust_session *usess,
 
 	/* Creating channel attributes if needed */
 	if (attr == NULL) {
-		defattr = channel_new_default_attr(LTTNG_DOMAIN_UST);
+		defattr = channel_new_default_attr(LTTNG_DOMAIN_UST, type);
 		if (defattr == NULL) {
 			ret = LTTNG_ERR_FATAL;
 			goto error;
@@ -245,11 +251,6 @@ int channel_ust_create(struct ltt_ust_session *usess,
 		attr = defattr;
 	}
 
-	if (attr->attr.subbuf_size < DEFAULT_UST_CHANNEL_SUBBUF_SIZE) {
-		ret = LTTNG_ERR_INVALID;
-		goto error;
-	}
-
 	/*
 	 * Validate UST buffer size and number of buffers: must both be power of 2
 	 * and nonzero. We validate right here for UST, because applications will
@@ -285,7 +286,18 @@ int channel_ust_create(struct ltt_ust_session *usess,
 	/* Validate buffer type. */
 	switch (type) {
 	case LTTNG_BUFFER_PER_PID:
+		if (attr->attr.subbuf_size <
+				default_get_ust_pid_channel_subbuf_size()) {
+			ret = LTTNG_ERR_INVALID;
+			goto error;
+		}
+		break;
 	case LTTNG_BUFFER_PER_UID:
+		if (attr->attr.subbuf_size <
+				default_get_ust_uid_channel_subbuf_size()) {
+			ret = LTTNG_ERR_INVALID;
+			goto error;
+		}
 		break;
 	default:
 		ret = LTTNG_ERR_BUFFER_NOT_SUPPORTED;
diff --git a/src/bin/lttng-sessiond/channel.h b/src/bin/lttng-sessiond/channel.h
index 7fbbb4c..15cabea 100644
--- a/src/bin/lttng-sessiond/channel.h
+++ b/src/bin/lttng-sessiond/channel.h
@@ -30,7 +30,8 @@ int channel_kernel_enable(struct ltt_kernel_session *ksession,
 int channel_kernel_create(struct ltt_kernel_session *ksession,
 		struct lttng_channel *chan, int kernel_pipe);
 
-struct lttng_channel *channel_new_default_attr(int domain);
+struct lttng_channel *channel_new_default_attr(int domain,
+		enum lttng_buffer_type type);
 
 int channel_ust_create(struct ltt_ust_session *usess,
 		struct lttng_channel *attr, enum lttng_buffer_type type);
diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index 5d2cba1..528665a 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -1106,7 +1106,7 @@ int cmd_add_context(struct ltt_session *session, int domain,
 		if (chan_count == 0) {
 			struct lttng_channel *attr;
 			/* Create default channel */
-			attr = channel_new_default_attr(domain);
+			attr = channel_new_default_attr(domain, usess->buffer_type);
 			if (attr == NULL) {
 				ret = LTTNG_ERR_FATAL;
 				goto error;
@@ -1166,7 +1166,8 @@ int cmd_enable_event(struct ltt_session *session, struct lttng_domain *domain,
 		kchan = trace_kernel_get_channel_by_name(channel_name,
 				session->kernel_session);
 		if (kchan == NULL) {
-			attr = channel_new_default_attr(LTTNG_DOMAIN_KERNEL);
+			attr = channel_new_default_attr(LTTNG_DOMAIN_KERNEL,
+					LTTNG_BUFFER_GLOBAL);
 			if (attr == NULL) {
 				ret = LTTNG_ERR_FATAL;
 				goto error;
@@ -1216,7 +1217,8 @@ int cmd_enable_event(struct ltt_session *session, struct lttng_domain *domain,
 				channel_name);
 		if (uchan == NULL) {
 			/* Create default channel */
-			attr = channel_new_default_attr(LTTNG_DOMAIN_UST);
+			attr = channel_new_default_attr(LTTNG_DOMAIN_UST,
+					usess->buffer_type);
 			if (attr == NULL) {
 				ret = LTTNG_ERR_FATAL;
 				goto error;
@@ -1286,7 +1288,8 @@ int cmd_enable_event_all(struct ltt_session *session,
 				session->kernel_session);
 		if (kchan == NULL) {
 			/* Create default channel */
-			attr = channel_new_default_attr(LTTNG_DOMAIN_KERNEL);
+			attr = channel_new_default_attr(LTTNG_DOMAIN_KERNEL,
+					LTTNG_BUFFER_GLOBAL);
 			if (attr == NULL) {
 				ret = LTTNG_ERR_FATAL;
 				goto error;
@@ -1350,7 +1353,8 @@ int cmd_enable_event_all(struct ltt_session *session,
 				channel_name);
 		if (uchan == NULL) {
 			/* Create default channel */
-			attr = channel_new_default_attr(LTTNG_DOMAIN_UST);
+			attr = channel_new_default_attr(LTTNG_DOMAIN_UST,
+					usess->buffer_type);
 			if (attr == NULL) {
 				ret = LTTNG_ERR_FATAL;
 				goto error;
diff --git a/src/common/defaults.c b/src/common/defaults.c
index ccdbaf4..39afda2 100644
--- a/src/common/defaults.c
+++ b/src/common/defaults.c
@@ -24,7 +24,8 @@
 size_t default_channel_subbuf_size;
 size_t default_metadata_subbuf_size;
 size_t default_kernel_channel_subbuf_size;
-size_t default_ust_channel_subbuf_size;
+size_t default_ust_pid_channel_subbuf_size;
+size_t default_ust_uid_channel_subbuf_size;
 
 static void __attribute__((constructor)) init_defaults(void)
 {
@@ -44,6 +45,8 @@ static void __attribute__((constructor)) init_defaults(void)
 		max(DEFAULT_METADATA_SUBBUF_SIZE, page_size);
 	default_kernel_channel_subbuf_size =
 		max(DEFAULT_KERNEL_CHANNEL_SUBBUF_SIZE, page_size);
-	default_ust_channel_subbuf_size =
-		max(DEFAULT_UST_CHANNEL_SUBBUF_SIZE, page_size);
+	default_ust_pid_channel_subbuf_size =
+		max(DEFAULT_UST_PID_CHANNEL_SUBBUF_SIZE, page_size);
+	default_ust_uid_channel_subbuf_size =
+		max(DEFAULT_UST_UID_CHANNEL_SUBBUF_SIZE, page_size);
 }
diff --git a/src/common/defaults.h b/src/common/defaults.h
index fb6a975..4606976 100644
--- a/src/common/defaults.h
+++ b/src/common/defaults.h
@@ -148,7 +148,8 @@
 /* User space defaults */
 
 /* Must be a power of 2 */
-#define DEFAULT_UST_CHANNEL_SUBBUF_SIZE     4096    /* bytes */
+#define DEFAULT_UST_PID_CHANNEL_SUBBUF_SIZE 4096    /* bytes */
+#define DEFAULT_UST_UID_CHANNEL_SUBBUF_SIZE 131072  /* bytes */
 /* Must be a power of 2. Update help manuall if override. */
 #define DEFAULT_UST_CHANNEL_SUBBUF_NUM      DEFAULT_CHANNEL_SUBBUF_NUM
 /* See lttng-ust.h enum lttng_ust_output */
@@ -202,10 +203,10 @@
 
 extern size_t default_channel_subbuf_size;
 extern size_t default_metadata_subbuf_size;
-extern size_t default_ust_channel_subbuf_size;
+extern size_t default_ust_pid_channel_subbuf_size;
+extern size_t default_ust_uid_channel_subbuf_size;
 extern size_t default_kernel_channel_subbuf_size;
 
-
 /*
  * Returns the default subbuf size.
  *
@@ -243,15 +244,27 @@ size_t default_get_kernel_channel_subbuf_size(void)
 }
 
 /*
- * Returns the default subbuf size for the UST domain.
+ * Returns the default subbuf size for the UST domain per PID.
+ *
+ * This function depends on a value that is set at constructor time, so it is
+ * unsafe to call it from another constructor.
+ */
+static inline
+size_t default_get_ust_pid_channel_subbuf_size(void)
+{
+	return default_ust_pid_channel_subbuf_size;
+}
+
+/*
+ * Returns the default subbuf size for the UST domain per UID.
  *
  * This function depends on a value that is set at constructor time, so it is
  * unsafe to call it from another constructor.
  */
 static inline
-size_t default_get_ust_channel_subbuf_size(void)
+size_t default_get_ust_uid_channel_subbuf_size(void)
 {
-	return default_ust_channel_subbuf_size;
+	return default_ust_uid_channel_subbuf_size;
 }
 
 #endif /* _DEFAULTS_H */
diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
index 3787e29..96c3ccd 100644
--- a/src/lib/lttng-ctl/lttng-ctl.c
+++ b/src/lib/lttng-ctl/lttng-ctl.c
@@ -1403,7 +1403,11 @@ void lttng_channel_set_default_attr(struct lttng_domain *domain,
 		attr->switch_timer_interval = DEFAULT_UST_CHANNEL_SWITCH_TIMER;
 		attr->read_timer_interval = DEFAULT_UST_CHANNEL_READ_TIMER;
 
-		attr->subbuf_size = default_get_ust_channel_subbuf_size();
+		if (domain->buf_type == LTTNG_BUFFER_PER_UID) {
+			attr->subbuf_size = default_get_ust_uid_channel_subbuf_size();
+		} else {
+			attr->subbuf_size = default_get_ust_pid_channel_subbuf_size();
+		}
 		attr->num_subbuf = DEFAULT_UST_CHANNEL_SUBBUF_NUM;
 		attr->output = DEFAULT_UST_CHANNEL_OUTPUT;
 		attr->tracefile_size = DEFAULT_UST_CHANNEL_TRACEFILE_SIZE;
-- 
1.7.10.4
