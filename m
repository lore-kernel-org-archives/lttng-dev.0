From: simon.marchi@polymtl.ca
Subject: [PATCH] Add --simple option to the list command
Date: Fri, 22 Jun 2012 02:29:27 -0400
Message-ID: <1340346567-11748-1-git-send-email-simon.marchi__10649.9853115112$1340346663$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nova.polymtl.ca ([132.207.4.47] helo=nova.aep.polymtl.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simark@nova.aep.polymtl.ca>) id 1ShxO8-00062S-Mc
	for lttng-dev@lists.lttng.org; Fri, 22 Jun 2012 02:30:36 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org, Simon Marchi <simark@nova.polymtl.ca>, Simon Marchi <simon.marchi@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

From: Simon Marchi <simon.marchi@polymtl.ca>

The --simple option makes "list" print one item per line, a nice format to be
parsed by scripts. For example, the bash completion script could benefit from
this feature. For now, only session listing is affected, but it would be
useful to have other kind of listing behave the same way.

Also left some comments on my path.

Signed-off-by: Simon Marchi <simark@nova.polymtl.ca>
---
 src/bin/lttng/commands/list.c |   41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
index 966be2d..cb4fb58 100644
--- a/src/bin/lttng/commands/list.c
+++ b/src/bin/lttng/commands/list.c
@@ -30,6 +30,7 @@ static int opt_kernel;
 static char *opt_channel;
 static int opt_domain;
 static int opt_fields;
+static int simple;
 #if 0
 /* Not implemented yet */
 static char *opt_cmd_name;
@@ -44,6 +45,7 @@ enum {
 	OPT_HELP = 1,
 	OPT_USERSPACE,
 	OPT_LIST_OPTIONS,
+	OPT_SIMPLE,
 };
 
 static struct lttng_handle *handle;
@@ -63,6 +65,7 @@ static struct poptOption long_options[] = {
 	{"domain",    'd', POPT_ARG_VAL, &opt_domain, 1, 0, 0},
 	{"fields",    'f', POPT_ARG_VAL, &opt_fields, 1, 0, 0},
 	{"list-options", 0, POPT_ARG_NONE, NULL, OPT_LIST_OPTIONS, NULL, NULL},
+	{"simple", 0, POPT_ARG_NONE, &simple, 0, NULL, NULL},
 	{0, 0, 0, 0, 0, 0, 0}
 };
 
@@ -80,6 +83,8 @@ static void usage(FILE *ofp)
 	fprintf(ofp, "\n");
 	fprintf(ofp, "  -h, --help              Show this help\n");
 	fprintf(ofp, "      --list-options      Simple listing of options\n");
+	fprintf(ofp, "      --simple            Prints one item per line, suitable "
+	                                       "for parsing\n");
 	fprintf(ofp, "  -k, --kernel            Select kernel domain\n");
 	fprintf(ofp, "  -u, --userspace         Select user-space domain.\n");
 	fprintf(ofp, "  -f, --fields            List event fields.\n");
@@ -566,33 +571,43 @@ static int list_sessions(const char *session_name)
 	count = lttng_list_sessions(&sessions);
 	DBG("Session count %d", count);
 	if (count < 0) {
+		/* Some error happened */
 		ret = count;
 		goto error;
 	} else if (count == 0) {
-		MSG("Currently no available tracing session");
+		/* No session available */
+		if (!simple) {
+			MSG("Currently no available tracing session");
+		}
 		goto end;
 	}
 
-	if (session_name == NULL) {
+	if (session_name == NULL && !simple) {
 		MSG("Available tracing sessions:");
 	}
 
 	for (i = 0; i < count; i++) {
 		if (session_name != NULL) {
+			/* We want to list info only about a particular session */
 			if (strncmp(sessions[i].name, session_name, NAME_MAX) == 0) {
 				session_found = 1;
-				MSG("Tracing session %s:%s", session_name, active_string(sessions[i].enabled));
-				MSG("%sTrace path: %s\n", indent4, sessions[i].path);
+
+				if (simple) {
+					MSG("%s", session_name);
+				} else {
+					MSG("Tracing session %s:%s", session_name, active_string(sessions[i].enabled));
+					MSG("%sTrace path: %s\n", indent4, sessions[i].path);
+				}
 				break;
 			}
-			continue;
-		}
-
-		MSG("  %d) %s (%s)%s", i + 1, sessions[i].name, sessions[i].path,
-				active_string(sessions[i].enabled));
-
-		if (session_found) {
-			break;
+		} else {
+			/* We want to list all sessions */
+			if (simple) {
+				MSG("%s", sessions[i].name);
+			} else {
+				MSG("  %d) %s (%s)%s", i + 1, sessions[i].name, sessions[i].path,
+					active_string(sessions[i].enabled));
+			}
 		}
 	}
 
@@ -604,7 +619,7 @@ static int list_sessions(const char *session_name)
 		goto error;
 	}
 
-	if (session_name == NULL) {
+	if (session_name == NULL && !simple) {
 		MSG("\nUse lttng list <session_name> for more details");
 	}
 
-- 
1.7.10
