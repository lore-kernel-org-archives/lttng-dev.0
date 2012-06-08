From: Danny Serres <danny.serres@efficios.com>
Subject: [Fix:lttng-tools-PATCH] Fix:Change the type of enabled
	in lttng_event to a signed int
Date: Fri,  8 Jun 2012 10:19:08 -0400
Message-ID: <1339165148-6653-1-git-send-email-danny.serres__13132.5196278796$1339165218$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <danny.serres@efficios.com>) id 1Sd02a-00010y-Us
	for lttng-dev@lists.lttng.org; Fri, 08 Jun 2012 10:19:52 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Danny Serres <danny.serres@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Danny Serres <danny.serres@efficios.com>
---
 include/lttng/lttng.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/lttng/lttng.h b/include/lttng/lttng.h
index 3b1be61..c80e282 100644
--- a/include/lttng/lttng.h
+++ b/include/lttng/lttng.h
@@ -214,7 +214,7 @@ struct lttng_event {
 	enum lttng_loglevel_type loglevel_type;
 	int loglevel;
 
-	uint32_t enabled;
+	int32_t enabled;	/* Does not apply: -1 */
 	pid_t pid;
 
 	char padding[LTTNG_EVENT_PADDING1];
-- 
1.7.9.5
