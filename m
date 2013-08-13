From: simon.marchi@polymtl.ca
Subject: [PATCH lttng-tools 1/5] Add --mi option to the list
	command
Date: Tue, 13 Aug 2013 16:26:21 -0400
Message-ID: <1376425585-31636-1-git-send-email-simon.marchi__47401.2949424379$1376425564$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [132.207.72.18] (helo=stationx.dorsal.polymtl.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simark@stationx.dorsal.polymtl.ca>)
	id 1V9L9R-0005ed-GO
	for lttng-dev@lists.lttng.org; Tue, 13 Aug 2013 16:25:15 -0400
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

From: Simon Marchi <simon.marchi@polymtl.ca>

The --mi option is used to ask lttng to print information in a format
easily understandable by another program. Currently, only session
printing is affected: it prints session names one per line.

The term mi stands for machine interface, and is stolen without any
remorse from GDB's lexicon.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 src/bin/lttng/commands/list.c |   35 ++++++++++++++++++++++++++---------
 1 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
index 1c7085d..9e13e6b 100644
--- a/src/bin/lttng/commands/list.c
+++ b/src/bin/lttng/commands/list.c
@@ -30,6 +30,7 @@ static int opt_kernel;
 static char *opt_channel;
 static int opt_domain;
 static int opt_fields;
+static int opt_mi;
 #if 0
 /* Not implemented yet */
 static char *opt_cmd_name;
@@ -44,6 +45,7 @@ enum {
 	OPT_HELP = 1,
 	OPT_USERSPACE,
 	OPT_LIST_OPTIONS,
+	OPT_MI,
 };
 
 static struct lttng_handle *handle;
@@ -63,6 +65,7 @@ static struct poptOption long_options[] = {
 	{"domain",    'd', POPT_ARG_VAL, &opt_domain, 1, 0, 0},
 	{"fields",    'f', POPT_ARG_VAL, &opt_fields, 1, 0, 0},
 	{"list-options", 0, POPT_ARG_NONE, NULL, OPT_LIST_OPTIONS, NULL, NULL},
+	{"mi", 0, POPT_ARG_NONE, &opt_mi, 0, NULL, NULL},
 	{0, 0, 0, 0, 0, 0, 0}
 };
 
@@ -80,6 +83,7 @@ static void usage(FILE *ofp)
 	fprintf(ofp, "\n");
 	fprintf(ofp, "  -h, --help              Show this help\n");
 	fprintf(ofp, "      --list-options      Simple listing of options\n");
+	fprintf(ofp, "      --mi                Prints data in a format suitable for parsing\n");
 	fprintf(ofp, "  -k, --kernel            Select kernel domain\n");
 	fprintf(ofp, "  -u, --userspace         Select user-space domain.\n");
 	fprintf(ofp, "  -f, --fields            List event fields.\n");
@@ -618,40 +622,53 @@ static int list_sessions(const char *session_name)
 		ERR("%s", lttng_strerror(ret));
 		goto error;
 	} else if (count == 0) {
-		MSG("Currently no available tracing session");
+		if (!opt_mi) {
+			MSG("Currently no available tracing session");
+		}
 		goto end;
 	}
 
-	if (session_name == NULL) {
+	if (session_name == NULL && !opt_mi) {
 		MSG("Available tracing sessions:");
 	}
 
 	for (i = 0; i < count; i++) {
+
 		if (session_name != NULL) {
 			if (strncmp(sessions[i].name, session_name, NAME_MAX) == 0) {
 				session_found = 1;
-				MSG("Tracing session %s: [%s%s]", session_name,
+
+				if (opt_mi) {
+					MSG("%s", session_name);
+				} else {
+					MSG("Tracing session %s: [%s%s]", session_name,
 						active_string(sessions[i].enabled),
 						snapshot_string(sessions[i].snapshot_mode));
-				MSG("%sTrace path: %s\n", indent4, sessions[i].path);
+					MSG("%sTrace path: %s\n", indent4, sessions[i].path);
+				}
+
 				break;
 			}
 		} else {
-			MSG("  %d) %s (%s) [%s%s]", i + 1, sessions[i].name, sessions[i].path,
-					active_string(sessions[i].enabled),
-					snapshot_string(sessions[i].snapshot_mode));
+			if (opt_mi) {
+				MSG("%s", sessions[i].name);
+			} else {
+				MSG("  %d) %s (%s) [%s%s]", i + 1, sessions[i].name, sessions[i].path,
+						active_string(sessions[i].enabled),
+						snapshot_string(sessions[i].snapshot_mode));
+			}
 		}
 	}
 
 	free(sessions);
 
-	if (!session_found && session_name != NULL) {
+	if (!session_found && session_name != NULL && !opt_mi) {
 		ERR("Session '%s' not found", session_name);
 		ret = CMD_ERROR;
 		goto error;
 	}
 
-	if (session_name == NULL) {
+	if (session_name == NULL && !opt_mi) {
 		MSG("\nUse lttng list <session_name> for more details");
 	}
 
-- 
1.7.1
