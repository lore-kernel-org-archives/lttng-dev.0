From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [LTTNG-UST PATCH 01/01] Added event exclusion
Date: Mon, 26 Aug 2013 12:52:37 +0000
Message-ID: <009B25148989C6458484484699278506E53869BE__48329.1372693658$1377521650$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VDwHl-0000e8-Qc
	for lttng-dev@lists.lttng.org; Mon, 26 Aug 2013 08:52:47 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "Mathieu Desnoyers (mathieu.desnoyers@efficios.com)" <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

From 3818adcb04988c6362916d9b86041d151382bf36 Mon Sep 17 00:00:00 2001
From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Date: Thu, 22 Aug 2013 13:37:36 +0300
Subject: [PATCH] Added event exclusion

Add the possibility to exclude events by prepending them with a '!'
character. That is, the commands 
lttng enable-event -u "\!met:"
lttng enable-event -a
will enable all tracepoint events (-a) except the ones
starting with 'met:' .
---
 include/lttng/ust-events.h   |  2 ++
 liblttng-ust/lttng-events.c  | 35 ++++++++++++++++++++++++++++++++++-
 liblttng-ust/lttng-ust-abi.c | 24 ++++++++++++++++++------
 3 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/include/lttng/ust-events.h b/include/lttng/ust-events.h
index f40c044..b03869a 100644
--- a/include/lttng/ust-events.h
+++ b/include/lttng/ust-events.h
@@ -290,6 +290,8 @@ struct lttng_probe_desc {
 enum lttng_enabler_type {
 	LTTNG_ENABLER_WILDCARD,
 	LTTNG_ENABLER_EVENT,
+	LTTNG_ENABLER_EXCLUDER,
+	LTTNG_ENABLER_EXCLUDER_WILDCARD,
 };
 
 /*
diff --git a/liblttng-ust/lttng-events.c b/liblttng-ust/lttng-events.c
index 26601a6..a7f0064 100644
--- a/liblttng-ust/lttng-events.c
+++ b/liblttng-ust/lttng-events.c
@@ -488,6 +488,30 @@ int lttng_desc_match_event_enabler(const struct lttng_event_desc *desc,
 }
 
 static
+int lttng_desc_match_wildcard_excluder(const struct lttng_event_desc *desc,
+		struct lttng_enabler *enabler)
+{
+	assert(enabler->type == LTTNG_ENABLER_EXCLUDER_WILDCARD);
+	/* Compare excluding final '*' , ignoring first character '!'*/
+	if (strncmp(desc->name, enabler->event_param.name + 1,
+			strlen(enabler->event_param.name) - 2))
+		return 0;
+	return 1;
+}
+
+static
+int lttng_desc_match_event_excluder(const struct lttng_event_desc *desc,
+		struct lttng_enabler *enabler)
+{
+	assert(enabler->type == LTTNG_ENABLER_EXCLUDER);
+	/* compare names, ignoring the first character '!' of the enabler */
+	if (strcmp(desc->name, enabler->event_param.name + 1))
+		return 0;
+	return 1;
+}
+
+
+static
 int lttng_desc_match_enabler(const struct lttng_event_desc *desc,
 		struct lttng_enabler *enabler)
 {
@@ -496,6 +520,10 @@ int lttng_desc_match_enabler(const struct lttng_event_desc *desc,
 		return lttng_desc_match_wildcard_enabler(desc, enabler);
 	case LTTNG_ENABLER_EVENT:
 		return lttng_desc_match_event_enabler(desc, enabler);
+	case LTTNG_ENABLER_EXCLUDER_WILDCARD:
+		return lttng_desc_match_wildcard_excluder(desc, enabler);
+	case LTTNG_ENABLER_EXCLUDER:
+		return lttng_desc_match_event_excluder(desc, enabler);
 	default:
 		return -EINVAL;
 	}
@@ -807,8 +835,13 @@ void lttng_session_sync_enablers(struct lttng_session *session)
 		cds_list_for_each_entry(enabler_ref,
 				&event->enablers_ref_head, node) {
 			if (enabler_ref->ref->enabled) {
+				if (enabler_ref->ref->type == LTTNG_ENABLER_EXCLUDER ||
+					enabler_ref->ref->type == LTTNG_ENABLER_EXCLUDER_WILDCARD) {
+					enabled = 0;
+					break;
+				}
 				enabled = 1;
-				break;
+				/* no break here, to ensure all excluders are handled */
 			}
 		}
 		/*
diff --git a/liblttng-ust/lttng-ust-abi.c b/liblttng-ust/lttng-ust-abi.c
index a852aae..e4596be 100644
--- a/liblttng-ust/lttng-ust-abi.c
+++ b/liblttng-ust/lttng-ust-abi.c
@@ -875,14 +875,26 @@ long lttng_channel_cmd(int objd, unsigned int cmd, unsigned long arg,
 	{
 		struct lttng_ust_event *event_param =
 			(struct lttng_ust_event *) arg;
-		if (event_param->name[strlen(event_param->name) - 1] == '*') {
-			/* If ends with wildcard, create wildcard. */
-			return lttng_abi_create_enabler(objd, event_param,
-					owner, LTTNG_ENABLER_WILDCARD);
+		if (event_param->name[0] == '!') {
+			if (event_param->name[strlen(event_param->name) - 1] == '*') {
+				/* excluder, with wildcard */
+				return lttng_abi_create_enabler(objd, event_param,
+					owner, LTTNG_ENABLER_EXCLUDER_WILDCARD);
+			} else {
+				/* plain excluder */
+				return lttng_abi_create_enabler(objd, event_param,
+					owner, LTTNG_ENABLER_EXCLUDER);
+			}
 		} else {
-			return lttng_abi_create_enabler(objd, event_param,
+			if (event_param->name[strlen(event_param->name) - 1] == '*') {
+				/* If ends with wildcard, create wildcard. */
+				return lttng_abi_create_enabler(objd, event_param,
+					owner, LTTNG_ENABLER_WILDCARD);
+			} else {
+				return lttng_abi_create_enabler(objd, event_param,
 					owner, LTTNG_ENABLER_EVENT);
-		}
+			}
+		}	
 	}
 	case LTTNG_UST_CONTEXT:
 		return lttng_abi_add_context(objd,
-- 
1.8.1.2
