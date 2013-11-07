From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 05/28] Add event exclusion data to
	ltt_ust_event structure
Date: Thu,  7 Nov 2013 12:19:43 +0200
Message-ID: <1383819583-6593-1-git-send-email-jp_ikaheimonen__10029.6107041233$1383819649$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMgw-0006zT-5F
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:19:58 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VeMgq-0005xN-Mo from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:19:52 -0800
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

Add event exclusion data to ltt_ust_event and ltt_ust_ht_key.

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/bin/lttng-sessiond/trace-ust.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/bin/lttng-sessiond/trace-ust.h b/src/bin/lttng-sessiond/trace-ust.h
index f25573a..06d0202 100644
--- a/src/bin/lttng-sessiond/trace-ust.h
+++ b/src/bin/lttng-sessiond/trace-ust.h
@@ -34,6 +34,7 @@ struct ltt_ust_ht_key {
 	const char *name;
 	const struct lttng_filter_bytecode *filter;
 	enum lttng_ust_loglevel_type loglevel;
+	const struct lttng_event_exclusion *exclusion;
 };
 
 /* Context hash table nodes */
@@ -49,6 +50,7 @@ struct ltt_ust_event {
 	struct lttng_ust_event attr;
 	struct lttng_ht_node_str node;
 	struct lttng_ust_filter_bytecode *filter;
+	const struct lttng_event_exclusion *exclusion;
 };
 
 /* UST channel */
-- 
1.8.1.2
