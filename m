From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-ust] Add exclusion checking
Date: Fri, 27 Sep 2013 07:14:30 +0000
Message-ID: <009B25148989C6458484484699278506E538A669__16649.7147795328$1380266151$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VPSGA-0002JW-TL
	for lttng-dev@lists.lttng.org; Fri, 27 Sep 2013 03:14:46 -0400
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
List-Id: lttng-dev@lists.lttng.org

If event enabler name contains wildcards, it's a wildcarded enabler.
Wildcarded enablers can now have exceptions to the rule; these are
called excluders. Excluders are embedded in the name of the enabler,
trailing the base name. If there are multiple excluders, they are
separated with a separator character (',').
---
 include/lttng/ust-events.h   |  6 ++++++
 liblttng-ust/lttng-events.c  | 43 ++++++++++++++++++++++++++++++++++++++++---
 liblttng-ust/lttng-ust-abi.c |  7 +++----
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/include/lttng/ust-events.h b/include/lttng/ust-events.h
index 74a3bc6..ca7be56 100644
--- a/include/lttng/ust-events.h
+++ b/include/lttng/ust-events.h
@@ -292,6 +292,12 @@ enum lttng_enabler_type {
 	LTTNG_ENABLER_EVENT,
 };
 
+/* special characters for event enablers. */
+#define LTTNG_ENABLER_WILDCARD_CHARACTER '*'
+#define LTTNG_ENABLER_WILDCARD_STRING "*"
+#define LTTNG_ENABLER_SEPARATOR_CHARACTER ','
+#define LTTNG_ENABLER_SEPARATOR_STRING ","
+
 /*
  * Enabler field, within whatever object is enabling an event. Target of
  * backward reference.
diff --git a/liblttng-ust/lttng-events.c b/liblttng-ust/lttng-events.c
index 26601a6..b1d3d1a 100644
--- a/liblttng-ust/lttng-events.c
+++ b/liblttng-ust/lttng-events.c
@@ -442,6 +442,43 @@ exist:
 }
 
 static
+int match_enabler_with_exclusions(const char * eventname,
+		const char * enablername)
+{
+
+	/* first check if matches the enabler name */
+	int name_length = strcspn(enablername, LTTNG_ENABLER_WILDCARD_STRING) + 1;
+	int matches = strncmp(enablername, eventname, name_length - 1);
+	if (matches != 0)
+		return 0;
+	matches = 1;
+	enablername = enablername + name_length;
+	while (*enablername != 0) {
+		/* find end of excluder */
+		name_length = strcspn(enablername, LTTNG_ENABLER_SEPARATOR_STRING);
+		if (strcspn(enablername, LTTNG_ENABLER_WILDCARD_STRING) < name_length) {
+			/* excluder has a wildcard */
+			if (strncmp(enablername, eventname, name_length - 1) == 0) {
+				matches = 0;
+				break;
+			}
+		} else {
+			/* no wildcard in excluder */
+			if (name_length == strlen(eventname)
+					&& strncmp(enablername, eventname, name_length) == 0) {
+				matches = 0;
+				break;
+			}
+		}
+		/* next excluder */
+		enablername = enablername + name_length;
+		if (*enablername == LTTNG_ENABLER_SEPARATOR_CHARACTER)
+			enablername++;
+	}
+	return matches;
+}
+
+static
 int lttng_desc_match_wildcard_enabler(const struct lttng_event_desc *desc,
 		struct lttng_enabler *enabler)
 {
@@ -449,9 +486,9 @@ int lttng_desc_match_wildcard_enabler(const struct lttng_event_desc *desc,
 	unsigned int has_loglevel = 0;
 
 	assert(enabler->type == LTTNG_ENABLER_WILDCARD);
-	/* Compare excluding final '*' */
-	if (strncmp(desc->name, enabler->event_param.name,
-			strlen(enabler->event_param.name) - 1))
+
+	/* Compare against the enabler specification */
+	if (!match_enabler_with_exclusions(desc->name, enabler->event_param.name))
 		return 0;
 	if (desc->loglevel) {
 		loglevel = *(*desc->loglevel);
diff --git a/liblttng-ust/lttng-ust-abi.c b/liblttng-ust/lttng-ust-abi.c
index a852aae..462eb82 100644
--- a/liblttng-ust/lttng-ust-abi.c
+++ b/liblttng-ust/lttng-ust-abi.c
@@ -875,14 +875,13 @@ long lttng_channel_cmd(int objd, unsigned int cmd, unsigned long arg,
 	{
 		struct lttng_ust_event *event_param =
 			(struct lttng_ust_event *) arg;
-		if (event_param->name[strlen(event_param->name) - 1] == '*') {
-			/* If ends with wildcard, create wildcard. */
+		/* if event name contains a wildcard, it's a wildcard event. */
+		if (strchr(event_param->name, LTTNG_ENABLER_WILDCARD_CHARACTER) != NULL)
 			return lttng_abi_create_enabler(objd, event_param,
 					owner, LTTNG_ENABLER_WILDCARD);
-		} else {
+		else
 			return lttng_abi_create_enabler(objd, event_param,
 					owner, LTTNG_ENABLER_EVENT);
-		}
 	}
 	case LTTNG_UST_CONTEXT:
 		return lttng_abi_add_context(objd,
-- 
1.8.1.2
