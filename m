From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 06/28] Add exclusion matching logic
	to trace_ust_ht_match_event
Date: Thu,  7 Nov 2013 12:19:55 +0200
Message-ID: <1383819595-6633-1-git-send-email-jp_ikaheimonen__217.496025334363$1383819668$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMh6-00072F-Dj
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:20:09 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VeMh0-00060R-VI from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:20:02 -0800
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

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/bin/lttng-sessiond/trace-ust.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/trace-ust.c
index b645975..c0fc3a0 100644
--- a/src/bin/lttng-sessiond/trace-ust.c
+++ b/src/bin/lttng-sessiond/trace-ust.c
@@ -75,7 +75,7 @@ int trace_ust_ht_match_event(struct cds_lfht_node *node, const void *_key)
 	event = caa_container_of(node, struct ltt_ust_event, node.node);
 	key = _key;
 
-	/* Match the 3 elements of the key: name, filter and loglevel. */
+	/* Match the 4 elements of the key: name, filter, loglevel, exclusions. */
 
 	/* Event name */
 	if (strncmp(event->attr.name, key->name, sizeof(event->attr.name)) != 0) {
@@ -111,6 +111,19 @@ int trace_ust_ht_match_event(struct cds_lfht_node *node, const void *_key)
 		}
 	}
 
+	/* If only one of the exclusions is NULL, fail. */
+	if ((key->exclusion && !event->exclusion) || (!key->exclusion && event->exclusion)) {
+		goto no_match;
+	}
+
+	if (key->exclusion && event->exclusion) {
+		/* Both exclusions exist; check count followed by names. */
+		if (event->exclusion->count != key->exclusion->count ||
+				memcmp(event->exclusion->names, key->exclusion->names,
+					event->exclusion->count * LTTNG_SYMBOL_NAME_LEN) != 0) {
+			goto no_match;
+		}
+	}
 	/* Match. */
 	return 1;
 
-- 
1.8.1.2
