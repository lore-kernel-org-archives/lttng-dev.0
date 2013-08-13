From: simon.marchi@polymtl.ca
Subject: [PATCH lttng-tools 3/5] Add --list-commands option to
	the snapshot command
Date: Tue, 13 Aug 2013 16:26:23 -0400
Message-ID: <1376425585-31636-3-git-send-email-simon.marchi__42699.6725648225$1376425770$gmane$org@polymtl.ca>
References: <1376425585-31636-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [132.207.72.18] (helo=stationx.dorsal.polymtl.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simark@stationx.dorsal.polymtl.ca>)
	id 1V9L9b-0005gE-2y
	for lttng-dev@lists.lttng.org; Tue, 13 Aug 2013 16:25:26 -0400
In-Reply-To: <1376425585-31636-1-git-send-email-simon.marchi@polymtl.ca>
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

It lists snapshot sub-commands. This involves moving list_commands
to utils so that commands can use it.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 src/bin/lttng/commands/snapshot.c |    5 +++++
 src/bin/lttng/lttng.c             |   21 +--------------------
 src/bin/lttng/utils.c             |   19 +++++++++++++++++++
 src/bin/lttng/utils.h             |    3 +++
 4 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/src/bin/lttng/commands/snapshot.c b/src/bin/lttng/commands/snapshot.c
index 56acca8..7d49299 100644
--- a/src/bin/lttng/commands/snapshot.c
+++ b/src/bin/lttng/commands/snapshot.c
@@ -49,6 +49,7 @@ enum {
 	OPT_HELP = 1,
 	OPT_LIST_OPTIONS,
 	OPT_MAX_SIZE,
+	OPT_LIST_COMMANDS,
 };
 
 static struct poptOption snapshot_opts[] = {
@@ -60,6 +61,7 @@ static struct poptOption snapshot_opts[] = {
 	{"name",         'n', POPT_ARG_STRING, &opt_output_name, 0, 0, 0},
 	{"max-size",     'm', POPT_ARG_DOUBLE, 0, OPT_MAX_SIZE, 0, 0},
 	{"list-options",   0, POPT_ARG_NONE, NULL, OPT_LIST_OPTIONS, NULL, NULL},
+	{"list-commands",  0, POPT_ARG_NONE, NULL, OPT_LIST_COMMANDS},
 	{0, 0, 0, 0, 0, 0, 0}
 };
 
@@ -439,6 +441,9 @@ int cmd_snapshot(int argc, const char **argv)
 		case OPT_LIST_OPTIONS:
 			list_cmd_options(stdout, snapshot_opts);
 			goto end;
+		case OPT_LIST_COMMANDS:
+			list_commands(actions, stdout);
+			goto end;
 		case OPT_MAX_SIZE:
 		{
 			long long int val;
diff --git a/src/bin/lttng/lttng.c b/src/bin/lttng/lttng.c
index 5755db6..dc9dd92 100644
--- a/src/bin/lttng/lttng.c
+++ b/src/bin/lttng/lttng.c
@@ -151,25 +151,6 @@ static void list_options(FILE *ofp)
 }
 
 /*
- *  list_commands
- *
- *  List commands line by line. This is mostly for bash auto completion and to
- *  avoid difficult parsing.
- */
-static void list_commands(FILE *ofp)
-{
-	int i = 0;
-	struct cmd_struct *cmd = NULL;
-
-	cmd = &commands[i];
-	while (cmd->name != NULL) {
-		fprintf(ofp, "%s\n", cmd->name);
-		i++;
-		cmd = &commands[i];
-	}
-}
-
-/*
  * clean_exit
  */
 static void clean_exit(int code)
@@ -466,7 +447,7 @@ static int parse_args(int argc, char **argv)
 			ret = 0;
 			goto end;
 		case OPT_DUMP_COMMANDS:
-			list_commands(stdout);
+			list_commands(commands, stdout);
 			ret = 0;
 			goto end;
 		default:
diff --git a/src/bin/lttng/utils.c b/src/bin/lttng/utils.c
index 6041655..e40c3fd 100644
--- a/src/bin/lttng/utils.c
+++ b/src/bin/lttng/utils.c
@@ -25,6 +25,7 @@
 
 #include "conf.h"
 #include "utils.h"
+#include "command.h"
 
 /*
  *  get_session_name
@@ -56,6 +57,24 @@ error:
 	return NULL;
 }
 
+/*
+ *  list_commands
+ *
+ *  List commands line by line. This is mostly for bash auto completion and to
+ *  avoid difficult parsing.
+ */
+void list_commands(struct cmd_struct *commands, FILE *ofp)
+{
+	int i = 0;
+	struct cmd_struct *cmd = NULL;
+
+	cmd = &commands[i];
+	while (cmd->name != NULL) {
+		fprintf(ofp, "%s\n", cmd->name);
+		i++;
+		cmd = &commands[i];
+	}
+}
 
 /*
  * list_cmd_options
diff --git a/src/bin/lttng/utils.h b/src/bin/lttng/utils.h
index 57bec12..fb973ca 100644
--- a/src/bin/lttng/utils.h
+++ b/src/bin/lttng/utils.h
@@ -20,7 +20,10 @@
 
 #include <popt.h>
 
+struct cmd_struct;
+
 char *get_session_name(void);
+void list_commands(struct cmd_struct *commands, FILE *ofp);
 void list_cmd_options(FILE *ofp, struct poptOption *options);
 
 /*
-- 
1.7.1
