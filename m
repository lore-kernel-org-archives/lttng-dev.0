From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 08/13] Cleanup: consumerd: use
	PERROR rather than perror
Date: Wed, 17 Dec 2014 20:45:19 -0500
Message-ID: <1418867124-17343-9-git-send-email-mathieu.desnoyers__27526.1800307364$1418867333$gmane$org@efficios.com>
References: <1418867124-17343-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y1Q9z-0006An-GA
 for lttng-dev@lists.lttng.org; Wed, 17 Dec 2014 20:45:49 -0500
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
 src/bin/lttng-consumerd/lttng-consumerd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-consumerd/lttng-consumerd.c
index 9bc3209..d2c3ed4 100644
--- a/src/bin/lttng-consumerd/lttng-consumerd.c
+++ b/src/bin/lttng-consumerd/lttng-consumerd.c
@@ -122,7 +122,7 @@ static int set_signal_handler(void)
 	sigset_t sigset;
 
 	if ((ret = sigemptyset(&sigset)) < 0) {
-		perror("sigemptyset");
+		PERROR("sigemptyset");
 		return ret;
 	}
 
@@ -130,17 +130,17 @@ static int set_signal_handler(void)
 	sa.sa_mask = sigset;
 	sa.sa_flags = 0;
 	if ((ret = sigaction(SIGTERM, &sa, NULL)) < 0) {
-		perror("sigaction");
+		PERROR("sigaction");
 		return ret;
 	}
 
 	if ((ret = sigaction(SIGINT, &sa, NULL)) < 0) {
-		perror("sigaction");
+		PERROR("sigaction");
 		return ret;
 	}
 
 	if ((ret = sigaction(SIGPIPE, &sa, NULL)) < 0) {
-		perror("sigaction");
+		PERROR("sigaction");
 		return ret;
 	}
 
-- 
2.1.1
