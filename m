From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [lttng-tools PATCH] Fix: UST context activation
Date: Mon, 25 Mar 2013 22:35:46 -0400
Message-ID: <20130326023546.GA7176__28204.9980866306$1364265394$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UKJjn-0004rD-Ow
	for lttng-dev@lists.lttng.org; Mon, 25 Mar 2013 22:35:47 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/src/bin/lttng-sessiond/context.c b/src/bin/lttng-sessiond/context.c
index a83cb46..b55254b 100644
--- a/src/bin/lttng-sessiond/context.c
+++ b/src/bin/lttng-sessiond/context.c
@@ -262,7 +262,7 @@ int context_ust_add(struct ltt_ust_session *usess, int domain,
 	}
 
 	/* Get UST channel if defined */
-	if (channel_name != '\0') {
+	if (channel_name[0] != '\0') {
 		uchan = trace_ust_find_channel_by_name(chan_ht, channel_name);
 		if (uchan == NULL) {
 			ret = LTTNG_ERR_UST_CHAN_NOT_FOUND;

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
