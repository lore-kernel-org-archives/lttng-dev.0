From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 14/28] Compare also exclusions in
	ht_match_ust_app_event
Date: Thu,  7 Nov 2013 12:21:38 +0200
Message-ID: <1383819703-6793-5-git-send-email-jp_ikaheimonen__10595.1985497542$1383819862$gmane$org@mentor.com>
References: <1383819703-6793-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMiv-0007Vr-Tg
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:02 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VeMiq-0006Dj-FI from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:21:56 -0800
In-Reply-To: <1383819703-6793-1-git-send-email-jp_ikaheimonen@mentor.com>
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

In ht_match_ust_app_event, one of the matching criteria is
that the exclusions must match also. Add the code that checks if
exclusions match.

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/bin/lttng-sessiond/ust-app.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 11b588f..cc611fc 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -104,7 +104,7 @@ static int ht_match_ust_app_event(struct cds_lfht_node *node, const void *_key)
 	event = caa_container_of(node, struct ust_app_event, node.node);
 	key = _key;
 
-	/* Match the 3 elements of the key: name, filter and loglevel. */
+	/* Match the 4 elements of the key: name, filter, loglevel, exclusions */
 
 	/* Event name */
 	if (strncmp(event->attr.name, key->name, sizeof(event->attr.name)) != 0) {
@@ -140,6 +140,21 @@ static int ht_match_ust_app_event(struct cds_lfht_node *node, const void *_key)
 		}
 	}
 
+	/* One of the exclusions is NULL, fail. */
+	if ((key->exclusion && !event->exclusion) || (!key->exclusion && event->exclusion)) {
+		goto no_match;
+	}
+
+	if (key->exclusion && event->exclusion) {
+		/* Both exclusions exists, check count followed by the names. */
+		if (event->exclusion->count != key->exclusion->count ||
+				memcmp(event->exclusion->names, key->exclusion->names,
+					event->exclusion->count * LTTNG_UST_SYM_NAME_LEN) != 0) {
+			goto no_match;
+		}
+	}
+
+
 	/* Match. */
 	return 1;
 
-- 
1.8.1.2
