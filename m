From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 05/13] Missing error handling:
	consumerd parse_args should return errors to caller
Date: Wed, 17 Dec 2014 20:45:16 -0500
Message-ID: <1418867124-17343-6-git-send-email-mathieu.desnoyers__26266.6630711921$1418867300$gmane$org@efficios.com>
References: <1418867124-17343-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y1Q9x-0006Ax-BA
 for lttng-dev@lists.lttng.org; Wed, 17 Dec 2014 20:45:46 -0500
In-Reply-To: <1418867124-17343-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

In preparation for having main() handle the return value.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-consumerd/lttng-consumerd.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-consumerd/lttng-consumerd.c
index 299776a..ceb1da4 100644
--- a/src/bin/lttng-consumerd/lttng-consumerd.c
+++ b/src/bin/lttng-consumerd/lttng-consumerd.c
@@ -186,9 +186,9 @@ static void usage(FILE *fp)
 /*
  * daemon argument parsing
  */
-static void parse_args(int argc, char **argv)
+static int parse_args(int argc, char **argv)
 {
-	int c;
+	int c, ret = 0;
 
 	static struct option long_options[] = {
 		{ "consumerd-cmd-sock", 1, 0, 'c' },
@@ -218,6 +218,8 @@ static void parse_args(int argc, char **argv)
 			fprintf(stderr, "option %s", long_options[option_index].name);
 			if (optarg) {
 				fprintf(stderr, " with arg %s\n", optarg);
+				ret = -1;
+				goto end;
 			}
 			break;
 		case 'c':
@@ -260,9 +262,12 @@ static void parse_args(int argc, char **argv)
 #endif
 		default:
 			usage(stderr);
-			exit(EXIT_FAILURE);
+			ret = -1;
+			goto end;
 		}
 	}
+end:
+	return ret;
 }
 
 /*
-- 
2.1.1
