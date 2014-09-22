From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: report UST consumer channel
	creation error
Date: Mon, 22 Sep 2014 12:39:08 -0400
Message-ID: <1411403948-24108-1-git-send-email-mathieu.desnoyers__36826.2217882604$1411404807$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XW6h4-0007Rx-HR
 for lttng-dev@lists.lttng.org; Mon, 22 Sep 2014 12:42:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C031E340144
 for <lttng-dev@lists.lttng.org>; Mon, 22 Sep 2014 16:45:00 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The session daemon reports no error whatsoever when the consumer daemon
fails to create a channel. We don't want to print errors when failing to
send the channel to the UST application though, because the application
may be concurrently exiting. So only print those errors when receiving
reply from the consumerd.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/ust-app.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 4a7fada..f8e9693 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -2450,6 +2450,8 @@ static int create_channel_per_uid(struct ust_app *app,
 		/* Create the buffer registry channel object. */
 		ret = create_buffer_reg_channel(reg_uid->registry, ua_chan, &reg_chan);
 		if (ret < 0) {
+			ERR("Error creating the UST channel \"%s\" registry instance",
+				ua_chan->name);
 			goto error;
 		}
 		assert(reg_chan);
@@ -2461,6 +2463,9 @@ static int create_channel_per_uid(struct ust_app *app,
 		ret = do_consumer_create_channel(usess, ua_sess, ua_chan,
 				app->bits_per_long, reg_uid->registry->reg.ust);
 		if (ret < 0) {
+			ERR("Error creating UST channel \"%s\" on the consumer daemon",
+				ua_chan->name);
+
 			/*
 			 * Let's remove the previously created buffer registry channel so
 			 * it's not visible anymore in the session registry.
@@ -2477,6 +2482,8 @@ static int create_channel_per_uid(struct ust_app *app,
 		 */
 		ret = setup_buffer_reg_channel(reg_uid->registry, ua_chan, reg_chan);
 		if (ret < 0) {
+			ERR("Error setting up UST channel \"%s\"",
+				ua_chan->name);
 			goto error;
 		}
 
@@ -2485,6 +2492,10 @@ static int create_channel_per_uid(struct ust_app *app,
 	/* Send buffers to the application. */
 	ret = send_channel_uid_to_ust(reg_chan, app, ua_sess, ua_chan);
 	if (ret < 0) {
+		/*
+		 * Don't report error to the console, since it may be
+		 * caused by application concurrently exiting.
+		 */
 		goto error;
 	}
 
@@ -2519,6 +2530,8 @@ static int create_channel_per_pid(struct ust_app *app,
 	/* Create and add a new channel registry to session. */
 	ret = ust_registry_channel_add(registry, ua_chan->key);
 	if (ret < 0) {
+		ERR("Error creating the UST channel \"%s\" registry instance",
+			ua_chan->name);
 		goto error;
 	}
 
@@ -2526,11 +2539,17 @@ static int create_channel_per_pid(struct ust_app *app,
 	ret = do_consumer_create_channel(usess, ua_sess, ua_chan,
 			app->bits_per_long, registry);
 	if (ret < 0) {
+		ERR("Error creating UST channel \"%s\" on the consumer daemon",
+			ua_chan->name);
 		goto error;
 	}
 
 	ret = send_channel_pid_to_ust(app, ua_sess, ua_chan);
 	if (ret < 0) {
+		/*
+		 * Don't report error to the console, since it may be
+		 * caused by application concurrently exiting.
+		 */
 		goto error;
 	}
 
-- 
2.1.0
