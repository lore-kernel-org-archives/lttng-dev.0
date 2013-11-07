From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-ust 7/7] Add a check against excluders
Date: Thu,  7 Nov 2013 12:22:35 +0200
Message-ID: <1383819755-6891-8-git-send-email-jp_ikaheimonen__43546.1284745999$1383820356$gmane$org@mentor.com>
References: <1383819755-6891-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMju-0007om-Bj
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:23:03 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VeMjo-0006Iy-UE from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:22:56 -0800
In-Reply-To: <1383819755-6891-1-git-send-email-jp_ikaheimonen@mentor.com>
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

When matching enablers with events, first check against all
excluders of the enabler. If the event matches with any of the excluders,
then the event does not match with the enabler.

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 liblttng-ust/lttng-events.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/liblttng-ust/lttng-events.c b/liblttng-ust/lttng-events.c
index 915cffb..fa5596c 100644
--- a/liblttng-ust/lttng-events.c
+++ b/liblttng-ust/lttng-events.c
@@ -491,6 +491,29 @@ static
 int lttng_desc_match_enabler(const struct lttng_event_desc *desc,
 		struct lttng_enabler *enabler)
 {
+	struct lttng_ust_excluder_node *excluder;
+
+	/* If event matches with an excluder, return 'does not match' */
+	cds_list_for_each_entry(excluder, &enabler->excluder_head, node) {
+		int found = 0;
+		int count, len;
+		char *excluder_name;
+
+		for (count = 0; count < excluder->excluder.count; count++) {
+			excluder_name = (char *)(excluder->excluder.names)
+					+ count * LTTNG_UST_SYM_NAME_LEN;
+			len = strnlen(excluder_name, LTTNG_UST_SYM_NAME_LEN);
+			if (len > 0 && excluder_name[len - 1] == '*') {
+				found = strncmp(desc->name, excluder_name, len - 1);
+			} else {
+				found = strncmp(desc->name, excluder_name,
+						LTTNG_UST_SYM_NAME_LEN - 1);
+			}
+			if (!found) {
+				return 0;
+			}
+		}
+	}
 	switch (enabler->type) {
 	case LTTNG_ENABLER_WILDCARD:
 		return lttng_desc_match_wildcard_enabler(desc, enabler);
-- 
1.8.1.2
