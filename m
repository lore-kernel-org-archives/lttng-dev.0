From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 13/28] Add exclusion data to
	ust_app_event structure
Date: Thu,  7 Nov 2013 12:21:37 +0200
Message-ID: <1383819703-6793-4-git-send-email-jp_ikaheimonen__464.495740789239$1383819849$gmane$org@mentor.com>
References: <1383819703-6793-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMiu-0007V9-IL
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:01 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VeMip-0006DN-46 from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:21:55 -0800
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

Add exclusion data to ust_app_event and ust_app_ht_key
data structures.

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/bin/lttng-sessiond/ust-app.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/bin/lttng-sessiond/ust-app.h b/src/bin/lttng-sessiond/ust-app.h
index 680ab6f..2522557 100644
--- a/src/bin/lttng-sessiond/ust-app.h
+++ b/src/bin/lttng-sessiond/ust-app.h
@@ -50,6 +50,7 @@ struct ust_app_ht_key {
 	const char *name;
 	const struct lttng_ust_filter_bytecode *filter;
 	enum lttng_ust_loglevel_type loglevel;
+	const struct lttng_ust_event_exclusion *exclusion;
 };
 
 /*
@@ -115,6 +116,7 @@ struct ust_app_event {
 	char name[LTTNG_UST_SYM_NAME_LEN];
 	struct lttng_ht_node_str node;
 	struct lttng_ust_filter_bytecode *filter;
+	struct lttng_ust_event_exclusion *exclusion;
 };
 
 struct ust_app_stream {
-- 
1.8.1.2
