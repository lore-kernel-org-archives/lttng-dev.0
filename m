From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Update comments regarding the
	requirement of power of 2 for sub-buffer size
Date: Fri, 10 Jul 2015 17:50:02 -0400
Message-ID: <1436565002-15575-1-git-send-email-jonathan.rajotte-julien__43348.517738241$1436565070$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZDgBY-0005Wd-0y
 for lttng-dev@lists.lttng.org; Fri, 10 Jul 2015 17:50:22 -0400
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 include/lttng/channel.h                | 2 +-
 src/bin/lttng-sessiond/lttng-ust-abi.h | 2 +-
 src/bin/lttng-sessiond/lttng-ust-ctl.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/lttng/channel.h b/include/lttng/channel.h
index 6ab0c7b..2007d06 100644
--- a/include/lttng/channel.h
+++ b/include/lttng/channel.h
@@ -33,7 +33,7 @@ extern "C" {
 #define LTTNG_CHANNEL_ATTR_PADDING1        LTTNG_SYMBOL_NAME_LEN + 12
 struct lttng_channel_attr {
 	int overwrite;                      /* 1: overwrite, 0: discard */
-	uint64_t subbuf_size;               /* bytes */
+	uint64_t subbuf_size;               /* bytes power of 2 */
 	uint64_t num_subbuf;                /* power of 2 */
 	unsigned int switch_timer_interval; /* usec */
 	unsigned int read_timer_interval;   /* usec */
diff --git a/src/bin/lttng-sessiond/lttng-ust-abi.h b/src/bin/lttng-sessiond/lttng-ust-abi.h
index 81b6149..ae3ac22 100644
--- a/src/bin/lttng-sessiond/lttng-ust-abi.h
+++ b/src/bin/lttng-sessiond/lttng-ust-abi.h
@@ -166,7 +166,7 @@ struct lttng_ust_context {
  */
 #define LTTNG_UST_CHANNEL_ATTR_PADDING	(LTTNG_UST_SYM_NAME_LEN + 32)
 struct lttng_ust_channel_attr {
-	uint64_t subbuf_size;			/* bytes */
+	uint64_t subbuf_size;			/* bytes power of 2 */
 	uint64_t num_subbuf;			/* power of 2 */
 	int overwrite;				/* 1: overwrite, 0: discard */
 	unsigned int switch_timer_interval;	/* usec */
diff --git a/src/bin/lttng-sessiond/lttng-ust-ctl.h b/src/bin/lttng-sessiond/lttng-ust-ctl.h
index 7f59b86..0bb717e 100644
--- a/src/bin/lttng-sessiond/lttng-ust-ctl.h
+++ b/src/bin/lttng-sessiond/lttng-ust-ctl.h
@@ -45,7 +45,7 @@ struct lttng_ust_lib_ring_buffer;
 
 struct ustctl_consumer_channel_attr {
 	enum lttng_ust_chan_type type;
-	uint64_t subbuf_size;			/* bytes */
+	uint64_t subbuf_size;			/* bytes power of 2 */
 	uint64_t num_subbuf;			/* power of 2 */
 	int overwrite;				/* 1: overwrite, 0: discard */
 	unsigned int switch_timer_interval;	/* usec */
-- 
2.1.4
