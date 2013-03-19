From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH lttng-tools] Fix consumer_allocate_channel
	function signature
Date: Tue, 19 Mar 2013 14:10:25 -0400
Message-ID: <1363716626-25101-1-git-send-email-simon.marchi__2896.13515274159$1363716711$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1UI0zw-0007Xt-Cs
	for lttng-dev@lists.lttng.org; Tue, 19 Mar 2013 14:10:56 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Simon Marchi <simon.marchi@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 src/common/consumer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/consumer.c b/src/common/consumer.c
index 300fd2a..8730e39 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -820,7 +820,7 @@ error:
  *
  * On error, return NULL.
  */
-struct lttng_consumer_channel *consumer_allocate_channel(unsigned long key,
+struct lttng_consumer_channel *consumer_allocate_channel(uint64_t key,
 		uint64_t session_id,
 		const char *pathname,
 		const char *name,
-- 
1.7.10.4
