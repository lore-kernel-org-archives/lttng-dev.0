From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 10/13] Missing error handling:
	consumer_signal_init should return its error status
Date: Wed, 17 Dec 2014 20:45:21 -0500
Message-ID: <1418867124-17343-11-git-send-email-mathieu.desnoyers__2015.80097568712$1418867369$gmane$org@efficios.com>
References: <1418867124-17343-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y1QA6-0006C9-0J
 for lttng-dev@lists.lttng.org; Wed, 17 Dec 2014 20:45:54 -0500
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
 src/common/consumer-timer.c | 4 +++-
 src/common/consumer-timer.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/common/consumer-timer.c b/src/common/consumer-timer.c
index e7343af..646d323 100644
--- a/src/common/consumer-timer.c
+++ b/src/common/consumer-timer.c
@@ -460,7 +460,7 @@ void consumer_timer_live_stop(struct lttng_consumer_channel *channel)
  * Block the RT signals for the entire process. It must be called from the
  * consumer main before creating the threads
  */
-void consumer_signal_init(void)
+int consumer_signal_init(void)
 {
 	int ret;
 	sigset_t mask;
@@ -471,7 +471,9 @@ void consumer_signal_init(void)
 	if (ret) {
 		errno = ret;
 		PERROR("pthread_sigmask");
+		return -1;
 	}
+	return 0;
 }
 
 /*
diff --git a/src/common/consumer-timer.h b/src/common/consumer-timer.h
index f3fac5d..baaa82b 100644
--- a/src/common/consumer-timer.h
+++ b/src/common/consumer-timer.h
@@ -50,6 +50,6 @@ void consumer_timer_live_start(struct lttng_consumer_channel *channel,
 		int live_timer_interval);
 void consumer_timer_live_stop(struct lttng_consumer_channel *channel);
 void *consumer_timer_thread(void *data);
-void consumer_signal_init(void);
+int consumer_signal_init(void);
 
 #endif /* CONSUMER_TIMER_H */
-- 
2.1.1
