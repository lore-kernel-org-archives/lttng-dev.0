From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: do not print error and bug
	messages when quiet (-q) is present
Date: Mon, 11 Jan 2016 17:32:14 -0500
Message-ID: <1452551534-2130-1-git-send-email-jonathan.rajotte-julien__24472.5146833391$1452551612$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1aIl0t-000259-Gw
 for lttng-dev@lists.lttng.org; Mon, 11 Jan 2016 17:32:37 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Conform to the lttng man page

fixes #988

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/common/error.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/common/error.h b/src/common/error.h
index e0cb158..d072b00 100644
--- a/src/common/error.h
+++ b/src/common/error.h
@@ -85,9 +85,8 @@ extern int lttng_opt_mi;
 				((type & (PRINT_DBG | PRINT_DBG2 | PRINT_DBG3)) &&  \
 					lttng_opt_verbose == 3))) {                     \
 			fprintf(stderr, fmt, ## args);                          \
-		} else if (lttng_opt_quiet == 0 && (type & (PRINT_WARN))) { \
-			fprintf(stderr, fmt, ## args);                          \
-		} else if (type & (PRINT_ERR | PRINT_BUG)) {                \
+		} else if (lttng_opt_quiet == 0 &&                          \
+				(type & (PRINT_WARN | PRINT_ERR | PRINT_BUG))) {    \
 			fprintf(stderr, fmt, ## args);                          \
 		}                                                           \
 	} while (0);
-- 
2.5.0
