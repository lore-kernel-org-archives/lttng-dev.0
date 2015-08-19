From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: return valid domain flag
	options on missing/invalid domain flag error
Date: Wed, 19 Aug 2015 15:47:25 -0700
Message-ID: <1440024445-29452-1-git-send-email-jonathan.rajotte-julien__33604.2785588235$1440024527$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZSC96-0008Vc-In
 for lttng-dev@lists.lttng.org; Wed, 19 Aug 2015 18:47:49 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 22ECD34048F
 for <lttng-dev@lists.lttng.org>; Wed, 19 Aug 2015 22:47:43 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: pproulx@efficios.com
List-Id: lttng-dev@lists.lttng.org

Fixes: 905

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng/commands/disable_events.c | 2 +-
 src/bin/lttng/commands/enable_events.c  | 4 ++--
 src/bin/lttng/utils.h                   | 8 +++++++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/src/bin/lttng/commands/disable_events.c b/src/bin/lttng/commands/disable_events.c
index 45e91a8..fec118a 100644
--- a/src/bin/lttng/commands/disable_events.c
+++ b/src/bin/lttng/commands/disable_events.c
@@ -185,7 +185,7 @@ static int disable_events(char *session_name)
 	} else if (opt_python) {
 		dom.type = LTTNG_DOMAIN_PYTHON;
 	} else {
-		print_missing_domain();
+		print_missing_event_domain();
 		ret = CMD_ERROR;
 		goto error;
 	}
diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
index 356fef4..662009d 100644
--- a/src/bin/lttng/commands/enable_events.c
+++ b/src/bin/lttng/commands/enable_events.c
@@ -721,7 +721,7 @@ static int enable_events(char *session_name)
 		/* Default. */
 		dom.buf_type = LTTNG_BUFFER_PER_UID;
 	} else {
-		print_missing_domain();
+		print_missing_event_domain();
 		ret = CMD_ERROR;
 		goto error;
 	}
@@ -1136,7 +1136,7 @@ static int enable_events(char *session_name)
 			strncpy(ev.name, event_name, LTTNG_SYMBOL_NAME_LEN);
 			ev.name[LTTNG_SYMBOL_NAME_LEN - 1] = '\0';
 		} else {
-			print_missing_domain();
+			print_missing_event_domain();
 			ret = CMD_ERROR;
 			goto error;
 		}
diff --git a/src/bin/lttng/utils.h b/src/bin/lttng/utils.h
index 0755731..5353490 100644
--- a/src/bin/lttng/utils.h
+++ b/src/bin/lttng/utils.h
@@ -57,9 +57,15 @@ int get_count_order_ulong(unsigned long x);
 const char *get_domain_str(enum lttng_domain_type domain);
 
 static inline
+void print_missing_event_domain(void)
+{
+	ERR("Please specify a domain (-k/-u/-j/-l/-p).");
+}
+
+static inline
 void print_missing_domain(void)
 {
-	ERR("Please specify a domain (-k/-u/-j).");
+	ERR("Please specify a domain (-k/-u).");
 }
 
 int spawn_relayd(const char *pathname, int port);
-- 
2.1.4
