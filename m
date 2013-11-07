From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-ust 4/7] Add excluders to enabler structure
Date: Thu,  7 Nov 2013 12:22:32 +0200
Message-ID: <1383819755-6891-5-git-send-email-jp_ikaheimonen__15484.6246391118$1383820288$gmane$org@mentor.com>
References: <1383819755-6891-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMjq-0007nc-JO
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:59 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VeMjl-0006IK-5T from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:22:53 -0800
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

Define a structure that holds excluders and can be used in lists.
Add a list holding these structures to the enabler structure.
Initialize and destroy the list when the enabler is initialized
and destroyed.

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 include/lttng/ust-events.h  | 11 +++++++++++
 liblttng-ust/lttng-events.c |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/lttng/ust-events.h b/include/lttng/ust-events.h
index c563511..db8b9dc 100644
--- a/include/lttng/ust-events.h
+++ b/include/lttng/ust-events.h
@@ -301,6 +301,8 @@ struct lttng_enabler {
 
 	/* head list of struct lttng_ust_filter_bytecode_node */
 	struct cds_list_head filter_bytecode_head;
+	/* head list of struct lttng_ust_excluder_node */
+	struct cds_list_head excluder_head;
 	struct cds_list_head node;	/* per-session list of enablers */
 
 	struct lttng_ust_event event_param;
@@ -342,6 +344,15 @@ struct lttng_ust_filter_bytecode_node {
 	struct lttng_ust_filter_bytecode bc;
 };
 
+struct lttng_ust_excluder_node {
+	struct cds_list_head node;
+	struct lttng_enabler *enabler;
+	/*
+	 * struct lttng_ust_event_exclusion had variable sized array,
+	 * must be last field.
+	 */
+	struct lttng_ust_event_exclusion excluder;
+};
 /*
  * Filter return value masks.
  */
diff --git a/liblttng-ust/lttng-events.c b/liblttng-ust/lttng-events.c
index 26601a6..ad374f3 100644
--- a/liblttng-ust/lttng-events.c
+++ b/liblttng-ust/lttng-events.c
@@ -687,6 +687,7 @@ struct lttng_enabler *lttng_enabler_create(enum lttng_enabler_type type,
 		return NULL;
 	enabler->type = type;
 	CDS_INIT_LIST_HEAD(&enabler->filter_bytecode_head);
+	CDS_INIT_LIST_HEAD(&enabler->excluder_head);
 	memcpy(&enabler->event_param, event_param,
 		sizeof(enabler->event_param));
 	enabler->chan = chan;
@@ -767,6 +768,7 @@ static
 void lttng_enabler_destroy(struct lttng_enabler *enabler)
 {
 	struct lttng_ust_filter_bytecode_node *filter_node, *tmp_filter_node;
+	struct lttng_ust_excluder_node *excluder_node, *tmp_excluder_node;
 
 	/* Destroy filter bytecode */
 	cds_list_for_each_entry_safe(filter_node, tmp_filter_node,
@@ -774,6 +776,12 @@ void lttng_enabler_destroy(struct lttng_enabler *enabler)
 		free(filter_node);
 	}
 
+	/* Destroy excluders */
+	cds_list_for_each_entry_safe(excluder_node, tmp_excluder_node,
+			&enabler->excluder_head, node) {
+		free(excluder_node);
+	}
+
 	/* Destroy contexts */
 	lttng_destroy_context(enabler->ctx);
 
-- 
1.8.1.2
