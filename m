From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 22/28] Add -exclude option to
	enable-event command
Date: Thu,  7 Nov 2013 12:22:01 +0200
Message-ID: <1383819727-6843-3-git-send-email-jp_ikaheimonen__6887.93551312319$1383820018$gmane$org@mentor.com>
References: <1383819727-6843-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMjH-0007cj-3N
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:24 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VeMjB-0006FP-LK from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:22:17 -0800
In-Reply-To: <1383819727-6843-1-git-send-email-jp_ikaheimonen@mentor.com>
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

Add new option --exclude (shortcut -x) for enable-event command.

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/bin/lttng/commands/enable_events.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
index a7b70c3..c3feefd 100644
--- a/src/bin/lttng/commands/enable_events.c
+++ b/src/bin/lttng/commands/enable_events.c
@@ -43,6 +43,7 @@ static char *opt_function;
 static char *opt_function_entry_symbol;
 static char *opt_channel_name;
 static char *opt_filter;
+static char *opt_exclude;
 #if 0
 /* Not implemented yet */
 static char *opt_cmd_name;
@@ -61,6 +62,7 @@ enum {
 	OPT_LOGLEVEL_ONLY,
 	OPT_LIST_OPTIONS,
 	OPT_FILTER,
+	OPT_EXCLUDE,
 };
 
 static struct lttng_handle *handle;
@@ -89,6 +91,7 @@ static struct poptOption long_options[] = {
 	{"loglevel-only",  0,     POPT_ARG_STRING, 0, OPT_LOGLEVEL_ONLY, 0, 0},
 	{"list-options", 0, POPT_ARG_NONE, NULL, OPT_LIST_OPTIONS, NULL, NULL},
 	{"filter",         'f', POPT_ARG_STRING, &opt_filter, OPT_FILTER, 0, 0},
+	{"exclude",        'x', POPT_ARG_STRING, &opt_exclude, OPT_EXCLUDE, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0}
 };
 
@@ -718,6 +721,8 @@ int cmd_enable_events(int argc, const char **argv)
 			goto end;
 		case OPT_FILTER:
 			break;
+		case OPT_EXCLUDE:
+			break;
 		default:
 			usage(stderr);
 			ret = CMD_UNDEFINED;
-- 
1.8.1.2
