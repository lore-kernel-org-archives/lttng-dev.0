From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 5/6] Fix: poll: show the correct
	number of fds
Date: Mon,  5 Jan 2015 16:43:07 -0500
Message-ID: <1420494188-20782-5-git-send-email-mathieu.desnoyers__26956.9253702231$1420494346$gmane$org@efficios.com>
References: <1420494188-20782-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y8FQq-0005cK-P3
 for lttng-dev@lists.lttng.org; Mon, 05 Jan 2015 16:43:26 -0500
In-Reply-To: <1420494188-20782-1-git-send-email-mathieu.desnoyers@efficios.com>
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

LTTNG_POLL_GETNB() uses wait nb_fd, which is only updated after
lttng_poll_wait returns.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/agent-thread.c |  4 +++-
 src/bin/lttng-sessiond/ht-cleanup.c   |  5 +++--
 src/bin/lttng-sessiond/main.c         |  8 ++++++--
 src/bin/lttng-sessiond/ust-thread.c   |  5 +++--
 src/common/consumer.c                 | 10 ++++++++--
 5 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/src/bin/lttng-sessiond/agent-thread.c b/src/bin/lttng-sessiond/agent-thread.c
index a9cc6e7..5f48151 100644
--- a/src/bin/lttng-sessiond/agent-thread.c
+++ b/src/bin/lttng-sessiond/agent-thread.c
@@ -307,12 +307,14 @@ void *agent_thread_manage_registration(void *data)
 	}
 
 	while (1) {
-		DBG3("[agent-thread] Manage agent polling on %d fds",
+		DBG3("[agent-thread] Manage agent polling",
 				LTTNG_POLL_GETNB(&events));
 
 		/* Inifinite blocking call, waiting for transmission */
 restart:
 		ret = lttng_poll_wait(&events, -1);
+		DBG3("[agent-thread] Manage agent return from poll on %d fds",
+				LTTNG_POLL_GETNB(&events));
 		if (ret < 0) {
 			/*
 			 * Restart interrupted system call.
diff --git a/src/bin/lttng-sessiond/ht-cleanup.c b/src/bin/lttng-sessiond/ht-cleanup.c
index 373c913..e5a2916 100644
--- a/src/bin/lttng-sessiond/ht-cleanup.c
+++ b/src/bin/lttng-sessiond/ht-cleanup.c
@@ -66,14 +66,15 @@ void *thread_ht_cleanup(void *data)
 	while (1) {
 		int handled_event;
 
-		DBG3("[ht-thread] Polling on %d fds.",
-			LTTNG_POLL_GETNB(&events));
+		DBG3("[ht-thread] Polling.");
 
 		/* Inifinite blocking call, waiting for transmission */
 restart:
 		handled_event = 0;
 		health_poll_entry();
 		ret = lttng_poll_wait(&events, -1);
+		DBG3("[ht-thread] Returning from poll on %d fds.",
+			LTTNG_POLL_GETNB(&events));
 		health_poll_exit();
 		if (ret < 0) {
 			/*
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 6bc7b1e..6fd1d1e 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -1059,12 +1059,14 @@ static void *thread_manage_kernel(void *data)
 			update_poll_flag = 0;
 		}
 
-		DBG("Thread kernel polling on %d fds", LTTNG_POLL_GETNB(&events));
+		DBG("Thread kernel polling");
 
 		/* Poll infinite value of time */
 	restart:
 		health_poll_entry();
 		ret = lttng_poll_wait(&events, -1);
+		DBG("Thread kernel return from poll on %d fds",
+				LTTNG_POLL_GETNB(&events));
 		health_poll_exit();
 		if (ret < 0) {
 			/*
@@ -1527,12 +1529,14 @@ static void *thread_manage_apps(void *data)
 	health_code_update();
 
 	while (1) {
-		DBG("Apps thread polling on %d fds", LTTNG_POLL_GETNB(&events));
+		DBG("Apps thread polling");
 
 		/* Inifinite blocking call, waiting for transmission */
 	restart:
 		health_poll_entry();
 		ret = lttng_poll_wait(&events, -1);
+		DBG("Apps thread return from poll on %d fds",
+				LTTNG_POLL_GETNB(&events));
 		health_poll_exit();
 		if (ret < 0) {
 			/*
diff --git a/src/bin/lttng-sessiond/ust-thread.c b/src/bin/lttng-sessiond/ust-thread.c
index 6f4295d..b421eb2 100644
--- a/src/bin/lttng-sessiond/ust-thread.c
+++ b/src/bin/lttng-sessiond/ust-thread.c
@@ -65,13 +65,14 @@ void *ust_thread_manage_notify(void *data)
 	health_code_update();
 
 	while (1) {
-		DBG3("[ust-thread] Manage notify polling on %d fds",
-				LTTNG_POLL_GETNB(&events));
+		DBG3("[ust-thread] Manage notify polling");
 
 		/* Inifinite blocking call, waiting for transmission */
 restart:
 		health_poll_entry();
 		ret = lttng_poll_wait(&events, -1);
+		DBG3("[ust-thread] Manage notify return from poll on %d fds",
+				LTTNG_POLL_GETNB(&events));
 		health_poll_exit();
 		if (ret < 0) {
 			/*
diff --git a/src/common/consumer.c b/src/common/consumer.c
index 1ece1d5..ef5da12 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -2190,9 +2190,12 @@ void *consumer_thread_metadata_poll(void *data)
 		}
 
 restart:
-		DBG("Metadata poll wait with %d fd(s)", LTTNG_POLL_GETNB(&events));
+		health_code_update();
 		health_poll_entry();
+		DBG("Metadata poll wait");
 		ret = lttng_poll_wait(&events, -1);
+		DBG("Metadata poll return from wait with %d fd(s)",
+				LTTNG_POLL_GETNB(&events));
 		health_poll_exit();
 		DBG("Metadata event catched in thread");
 		if (ret < 0) {
@@ -2765,9 +2768,12 @@ void *consumer_thread_channel_poll(void *data)
 		}
 
 restart:
-		DBG("Channel poll wait with %d fd(s)", LTTNG_POLL_GETNB(&events));
+		health_code_update();
+		DBG("Channel poll wait");
 		health_poll_entry();
 		ret = lttng_poll_wait(&events, -1);
+		DBG("Channel poll return from wait with %d fd(s)",
+				LTTNG_POLL_GETNB(&events));
 		health_poll_exit();
 		DBG("Channel event catched in thread");
 		if (ret < 0) {
-- 
2.1.1
