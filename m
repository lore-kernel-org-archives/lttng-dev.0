From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH lttng-tools] Use parse_size_suffix in snapshot
Date: Tue, 13 Aug 2013 14:22:31 -0400
Message-ID: <1376418151-22312-1-git-send-email-simon.marchi__65.0291367948697$1376418127$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [132.207.72.18] (helo=stationx.dorsal.polymtl.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simark@stationx.dorsal.polymtl.ca>)
	id 1V9JDS-0006jg-E1
	for lttng-dev@lists.lttng.org; Tue, 13 Aug 2013 14:21:16 -0400
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

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 src/bin/lttng/commands/snapshot.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/src/bin/lttng/commands/snapshot.c b/src/bin/lttng/commands/snapshot.c
index 56acca8..5b62fed 100644
--- a/src/bin/lttng/commands/snapshot.c
+++ b/src/bin/lttng/commands/snapshot.c
@@ -58,7 +58,7 @@ static struct poptOption snapshot_opts[] = {
 	{"ctrl-url",     'C', POPT_ARG_STRING, &opt_ctrl_url, 0, 0, 0},
 	{"data-url",     'D', POPT_ARG_STRING, &opt_data_url, 0, 0, 0},
 	{"name",         'n', POPT_ARG_STRING, &opt_output_name, 0, 0, 0},
-	{"max-size",     'm', POPT_ARG_DOUBLE, 0, OPT_MAX_SIZE, 0, 0},
+	{"max-size",     'm', POPT_ARG_STRING, 0, OPT_MAX_SIZE, 0, 0},
 	{"list-options",   0, POPT_ARG_NONE, NULL, OPT_LIST_OPTIONS, NULL, NULL},
 	{0, 0, 0, 0, 0, 0, 0}
 };
@@ -445,21 +445,12 @@ int cmd_snapshot(int argc, const char **argv)
 			char *endptr;
 			const char *opt = poptGetOptArg(pc);
 
-			/* Documented by the man page of strtoll(3). */
-			errno = 0;
-			val = strtoll(opt, &endptr, 10);
-			if ((errno == ERANGE && (val == LLONG_MAX || val == LONG_MIN))
-					|| (errno != 0 && val == 0)) {
+			if (utils_parse_size_suffix(opt, &val) < 0) {
 				ERR("Unable to handle max-size value %s", opt);
 				ret = CMD_ERROR;
 				goto end;
 			}
 
-			if (endptr == opt) {
-				ERR("No digits were found in %s", opt);
-				ret = CMD_ERROR;
-				goto end;
-			}
 			opt_max_size = val;
 
 			break;
-- 
1.7.1
