From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 02/13] Fix: leak on UST buffer
	registry creation error
Date: Wed, 17 Dec 2014 20:45:13 -0500
Message-ID: <1418867124-17343-3-git-send-email-mathieu.desnoyers__49036.6105376326$1418867214$gmane$org@efficios.com>
References: <1418867124-17343-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y1Q9s-0006Af-Dw
 for lttng-dev@lists.lttng.org; Wed, 17 Dec 2014 20:45:41 -0500
In-Reply-To: <1418867124-17343-1-git-send-email-mathieu.desnoyers@efficios.com>
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

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/ust-app.c      | 21 ++++++++++++++++++---
 src/bin/lttng-sessiond/ust-registry.c |  4 +++-
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 891d75f..9dbd49b 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -1732,7 +1732,6 @@ static int setup_buffer_reg_pid(struct ust_app_session *ua_sess,
 		if (ret < 0) {
 			goto error;
 		}
-		buffer_reg_pid_add(reg_pid);
 	} else {
 		goto end;
 	}
@@ -1745,9 +1744,18 @@ static int setup_buffer_reg_pid(struct ust_app_session *ua_sess,
 			app->byte_order, app->version.major,
 			app->version.minor);
 	if (ret < 0) {
+		/*
+		 * reg_pid->registry->reg.ust is NULL upon error, so we need to
+		 * destroy the buffer registry, because it is always expected
+		 * that if the buffer registry can be found, its ust registry is
+		 * non-NULL.
+		 */
+		buffer_reg_pid_destroy(reg_pid);
 		goto error;
 	}
 
+	buffer_reg_pid_add(reg_pid);
+
 	DBG3("UST app buffer registry per PID created successfully");
 
 end:
@@ -1788,7 +1796,6 @@ static int setup_buffer_reg_uid(struct ltt_ust_session *usess,
 		if (ret < 0) {
 			goto error;
 		}
-		buffer_reg_uid_add(reg_uid);
 	} else {
 		goto end;
 	}
@@ -1801,13 +1808,21 @@ static int setup_buffer_reg_uid(struct ltt_ust_session *usess,
 			app->byte_order, app->version.major,
 			app->version.minor);
 	if (ret < 0) {
+		/*
+		 * reg_uid->registry->reg.ust is NULL upon error, so we need to
+		 * destroy the buffer registry, because it is always expected
+		 * that if the buffer registry can be found, its ust registry is
+		 * non-NULL.
+		 */
+		buffer_reg_uid_destroy(reg_uid, NULL);
 		goto error;
 	}
 	/* Add node to teardown list of the session. */
 	cds_list_add(&reg_uid->lnode, &usess->buffer_reg_uid_list);
 
-	DBG3("UST app buffer registry per UID created successfully");
+	buffer_reg_uid_add(reg_uid);
 
+	DBG3("UST app buffer registry per UID created successfully");
 end:
 	if (regp) {
 		*regp = reg_uid;
diff --git a/src/bin/lttng-sessiond/ust-registry.c b/src/bin/lttng-sessiond/ust-registry.c
index 3f4a962..1a00e93 100644
--- a/src/bin/lttng-sessiond/ust-registry.c
+++ b/src/bin/lttng-sessiond/ust-registry.c
@@ -608,7 +608,9 @@ void ust_registry_session_destroy(struct ust_registry_session *reg)
 	struct lttng_ht_iter iter;
 	struct ust_registry_channel *chan;
 
-	assert(reg);
+	if (!reg) {
+		return;
+	}
 
 	/* On error, EBUSY can be returned if lock. Code flow error. */
 	ret = pthread_mutex_destroy(&reg->lock);
-- 
2.1.1
