From: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Subject: [PATCH lttng-tool] Fix: parse_prob_opts return the
	actual success of the function
Date: Wed, 27 Aug 2014 15:46:57 -0400
Message-ID: <1409168817-22679-1-git-send-email-jonathan.r.julien__36078.5464909442$1409168885$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@ericsson.com>)
 id 1XMjBR-0002M5-G3
 for lttng-dev@lists.lttng.org; Wed, 27 Aug 2014 15:47:11 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This bug have been triggered by the mi merging and the use of a
command_ret in enable_events functions. Previously, enable_events was
reusing the ret variable for another operation and always replacing ret.
Parse_probe_event returned the last output of sscanf which represent
the number of match and not the success of the operation.

Fixes #830

Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
---
 src/bin/lttng/commands/enable_events.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
index f62dadb..3263c58 100644
--- a/src/bin/lttng/commands/enable_events.c
+++ b/src/bin/lttng/commands/enable_events.c
@@ -247,26 +247,27 @@ static void usage(FILE *ofp)
  */
 static int parse_probe_opts(struct lttng_event *ev, char *opt)
 {
-	int ret;
+	int ret = CMD_SUCCESS;
+	int match;
 	char s_hex[19];
 #define S_HEX_LEN_SCANF_IS_A_BROKEN_API "18"	/* 18 is (19 - 1) (\0 is extra) */
 	char name[LTTNG_SYMBOL_NAME_LEN];
 
 	if (opt == NULL) {
-		ret = -1;
+		ret = CMD_ERROR;
 		goto end;
 	}
 
 	/* Check for symbol+offset */
-	ret = sscanf(opt, "%" LTTNG_SYMBOL_NAME_LEN_SCANF_IS_A_BROKEN_API
+	match = sscanf(opt, "%" LTTNG_SYMBOL_NAME_LEN_SCANF_IS_A_BROKEN_API
 			"[^'+']+%" S_HEX_LEN_SCANF_IS_A_BROKEN_API "s", name, s_hex);
-	if (ret == 2) {
+	if (match == 2) {
 		strncpy(ev->attr.probe.symbol_name, name, LTTNG_SYMBOL_NAME_LEN);
 		ev->attr.probe.symbol_name[LTTNG_SYMBOL_NAME_LEN - 1] = '\0';
 		DBG("probe symbol %s", ev->attr.probe.symbol_name);
 		if (*s_hex == '\0') {
 			ERR("Invalid probe offset %s", s_hex);
-			ret = -1;
+			ret = CMD_ERROR;
 			goto end;
 		}
 		ev->attr.probe.offset = strtoul(s_hex, NULL, 0);
@@ -277,9 +278,9 @@ static int parse_probe_opts(struct lttng_event *ev, char *opt)
 
 	/* Check for symbol */
 	if (isalpha(name[0])) {
-		ret = sscanf(opt, "%" LTTNG_SYMBOL_NAME_LEN_SCANF_IS_A_BROKEN_API "s",
+		match = sscanf(opt, "%" LTTNG_SYMBOL_NAME_LEN_SCANF_IS_A_BROKEN_API "s",
 			name);
-		if (ret == 1) {
+		if (match == 1) {
 			strncpy(ev->attr.probe.symbol_name, name, LTTNG_SYMBOL_NAME_LEN);
 			ev->attr.probe.symbol_name[LTTNG_SYMBOL_NAME_LEN - 1] = '\0';
 			DBG("probe symbol %s", ev->attr.probe.symbol_name);
@@ -291,11 +292,11 @@ static int parse_probe_opts(struct lttng_event *ev, char *opt)
 	}
 
 	/* Check for address */
-	ret = sscanf(opt, "%" S_HEX_LEN_SCANF_IS_A_BROKEN_API "s", s_hex);
-	if (ret > 0) {
+	match = sscanf(opt, "%" S_HEX_LEN_SCANF_IS_A_BROKEN_API "s", s_hex);
+	if (match > 0) {
 		if (*s_hex == '\0') {
 			ERR("Invalid probe address %s", s_hex);
-			ret = -1;
+			ret = CMD_ERROR;
 			goto end;
 		}
 		ev->attr.probe.addr = strtoul(s_hex, NULL, 0);
@@ -306,7 +307,7 @@ static int parse_probe_opts(struct lttng_event *ev, char *opt)
 	}
 
 	/* No match */
-	ret = -1;
+	ret = CMD_ERROR;
 
 end:
 	return ret;
@@ -906,7 +907,7 @@ static int enable_events(char *session_name)
 				break;
 			case LTTNG_EVENT_PROBE:
 				ret = parse_probe_opts(&ev, opt_probe);
-				if (ret < 0) {
+				if (ret) {
 					ERR("Unable to parse probe options");
 					ret = 0;
 					goto error;
@@ -914,7 +915,7 @@ static int enable_events(char *session_name)
 				break;
 			case LTTNG_EVENT_FUNCTION:
 				ret = parse_probe_opts(&ev, opt_function);
-				if (ret < 0) {
+				if (ret) {
 					ERR("Unable to parse function probe options");
 					ret = 0;
 					goto error;
-- 
2.0.4
