From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 09/13] Cleanup: consumerd: lines
	over 80 columns
Date: Wed, 17 Dec 2014 20:45:20 -0500
Message-ID: <1418867124-17343-10-git-send-email-mathieu.desnoyers__18991.9036384255$1418867317$gmane$org@efficios.com>
References: <1418867124-17343-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y1Q9z-0006Ax-Ir
 for lttng-dev@lists.lttng.org; Wed, 17 Dec 2014 20:45:48 -0500
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

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-consumerd/lttng-consumerd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-consumerd/lttng-consumerd.c
index d2c3ed4..d0d8398 100644
--- a/src/bin/lttng-consumerd/lttng-consumerd.c
+++ b/src/bin/lttng-consumerd/lttng-consumerd.c
@@ -206,14 +206,16 @@ static int parse_args(int argc, char **argv)
 
 	while (1) {
 		int option_index = 0;
-		c = getopt_long(argc, argv, "dhqvVku" "c:e:g:", long_options, &option_index);
+		c = getopt_long(argc, argv, "dhqvVku" "c:e:g:",
+				long_options, &option_index);
 		if (c == -1) {
 			break;
 		}
 
 		switch (c) {
 		case 0:
-			fprintf(stderr, "option %s", long_options[option_index].name);
+			fprintf(stderr, "option %s",
+				long_options[option_index].name);
 			if (optarg) {
 				fprintf(stderr, " with arg %s\n", optarg);
 				ret = -1;
-- 
2.1.1
