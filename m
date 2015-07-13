From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH 6/9] Display discarded and lost
	events at destroy and stop
Date: Mon, 13 Jul 2015 11:28:06 -0400
Message-ID: <1436801289-17554-7-git-send-email-jdesfossez__30971.4000825354$1436801641$gmane$org@efficios.com>
References: <1436801289-17554-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZEfeh-0008PT-Az
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 11:28:32 -0400
In-Reply-To: <1436801289-17554-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com, mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/bin/lttng/commands/destroy.c |  1 +
 src/bin/lttng/commands/stop.c    |  1 +
 src/bin/lttng/utils.c            | 46 ++++++++++++++++++++++++++++++++++++++++
 src/bin/lttng/utils.h            |  1 +
 4 files changed, 49 insertions(+)

diff --git a/src/bin/lttng/commands/destroy.c b/src/bin/lttng/commands/destroy.c
index 3a6e3ef..01764d9 100644
--- a/src/bin/lttng/commands/destroy.c
+++ b/src/bin/lttng/commands/destroy.c
@@ -84,6 +84,7 @@ static int destroy_session(struct lttng_session *session)
 			ERR("%s", lttng_strerror(ret));
 		}
 	}
+	get_session_stats(session->name);
 
 	ret = lttng_destroy_session(session->name);
 	if (ret < 0) {
diff --git a/src/bin/lttng/commands/stop.c b/src/bin/lttng/commands/stop.c
index 5ac182b..ca048e5 100644
--- a/src/bin/lttng/commands/stop.c
+++ b/src/bin/lttng/commands/stop.c
@@ -156,6 +156,7 @@ static int stop_tracing(void)
 
 	ret = CMD_SUCCESS;
 
+	get_session_stats(session_name);
 	MSG("Tracing stopped for session %s", session_name);
 	if (lttng_opt_mi) {
 		ret = mi_print_session(session_name, 0);
diff --git a/src/bin/lttng/utils.c b/src/bin/lttng/utils.c
index d62c4a1..f71043b 100644
--- a/src/bin/lttng/utils.c
+++ b/src/bin/lttng/utils.c
@@ -26,6 +26,7 @@
 #include <signal.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
+#include <inttypes.h>
 
 #include <common/error.h>
 #include <common/utils.h>
@@ -249,3 +250,48 @@ error:
 error_socket:
 	return ret;
 }
+
+/*
+ * Get the discarded events and lost packet counts.
+ */
+void get_session_stats(const char *session_name)
+{
+	int count, nb_domains, i, j;
+	struct lttng_domain *domains = NULL;
+	struct lttng_channel *channels = NULL;
+	struct lttng_handle *handle = NULL;
+	uint64_t discarded = 0, lost = 0;
+
+	nb_domains = lttng_list_domains(session_name, &domains);
+	if (nb_domains < 0) {
+		goto end;
+	}
+	for (i = 0; i < nb_domains; i++) {
+		handle = lttng_create_handle(session_name, &domains[i]);
+		if (handle == NULL) {
+			goto end;
+		}
+		count = lttng_list_channels(handle, &channels);
+		for (j = 0; j < count; j++) {
+			discarded += channels[j].attr.discarded_events;
+			lost += channels[j].attr.lost_packets;
+		}
+	}
+	if (handle) {
+		lttng_destroy_handle(handle);
+	}
+
+	if (discarded > 0) {
+		MSG("[warning] %" PRIu64 " events discarded, please refer to "
+				"the documentation on channel configuration",
+				discarded);
+	}
+	if (lost > 0) {
+		MSG("[warning] %" PRIu64 " packets lost, please refer to "
+				"the documentation on channel configuration",
+				lost);
+	}
+
+end:
+	return;
+}
diff --git a/src/bin/lttng/utils.h b/src/bin/lttng/utils.h
index 42d7f1d..ef55799 100644
--- a/src/bin/lttng/utils.h
+++ b/src/bin/lttng/utils.h
@@ -42,5 +42,6 @@ void print_missing_domain(void)
 
 int spawn_relayd(const char *pathname, int port);
 int check_relayd(void);
+void get_session_stats(const char *session_name);
 
 #endif /* _LTTNG_UTILS_H */
-- 
1.9.1
