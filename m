From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH 3/9] Reference pointers from
	ust_app_chan to parent structs
Date: Mon, 13 Jul 2015 11:28:03 -0400
Message-ID: <1436801289-17554-4-git-send-email-jdesfossez__39358.3200093873$1436801364$gmane$org@efficios.com>
References: <1436801289-17554-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZEfeb-0008PI-JN
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 11:28:26 -0400
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

To extract the lost packets and discarded events counters in per-pid
channels when an application unregisters, we need a reference to the
parent channel and session. These pointers are only there as reference
and do not provide any kind of ownership.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/bin/lttng-sessiond/ust-app.c | 5 +++++
 src/bin/lttng-sessiond/ust-app.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 6f032da..08b6a76 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -1702,6 +1702,11 @@ static void shadow_copy_session(struct ust_app_session *ua_sess,
 		 * channel and not metadata.
 		 */
 		ua_chan->attr.type = LTTNG_UST_CHAN_PER_CPU;
+		/*
+		 * Back pointers to the ust session and channel.
+		 */
+		ua_chan->usess = usess;
+		ua_chan->uchan = uchan;
 
 		lttng_ht_add_unique_str(ua_sess->channels, &ua_chan->node);
 	}
diff --git a/src/bin/lttng-sessiond/ust-app.h b/src/bin/lttng-sessiond/ust-app.h
index 66cda8c..38eaf6d 100644
--- a/src/bin/lttng-sessiond/ust-app.h
+++ b/src/bin/lttng-sessiond/ust-app.h
@@ -168,6 +168,12 @@ struct ust_app_channel {
 	struct lttng_ht_node_ulong ust_objd_node;
 	/* For delayed reclaim */
 	struct rcu_head rcu_head;
+	/*
+	 * Back pointers to the parent channel and session, no ownership,
+	 * just references.
+	 */
+	struct ltt_ust_channel *uchan;
+	struct ltt_ust_session *usess;
 };
 
 struct ust_app_session {
-- 
1.9.1
