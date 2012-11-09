From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH 3/3] Remove previous default subbuf sizes
	definitions.
Date: Fri,  9 Nov 2012 01:39:08 -0500
Message-ID: <1352443148-7135-3-git-send-email-simon.marchi__6694.80153960666$1352443191$gmane$org@polymtl.ca>
References: <1352443148-7135-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1TWiFK-0002sv-5h
	for lttng-dev@lists.lttng.org; Fri, 09 Nov 2012 01:39:18 -0500
In-Reply-To: <1352443148-7135-1-git-send-email-simon.marchi@polymtl.ca>
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

This commit removes defines that are now unused.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 src/common/defaults.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/src/common/defaults.h b/src/common/defaults.h
index efff43e..7319b35 100644
--- a/src/common/defaults.h
+++ b/src/common/defaults.h
@@ -98,15 +98,12 @@
 /* Default channel attributes */
 #define DEFAULT_CHANNEL_NAME            "channel0"
 #define DEFAULT_CHANNEL_OVERWRITE       0       /* usec */
-/* DEFAULT_CHANNEL_SUBBUF_SIZE must always be a power of 2 */
-#define DEFAULT_CHANNEL_SUBBUF_SIZE     4096    /* bytes */
 /* DEFAULT_CHANNEL_SUBBUF_NUM must always be a power of 2 */
 #define DEFAULT_CHANNEL_SUBBUF_NUM      4
 #define DEFAULT_CHANNEL_SWITCH_TIMER    0       /* usec */
 #define DEFAULT_CHANNEL_READ_TIMER		200     /* usec */
 #define DEFAULT_CHANNEL_OUTPUT          LTTNG_EVENT_MMAP
 
-#define DEFAULT_METADATA_SUBBUF_SIZE    4096
 #define DEFAULT_METADATA_SUBBUF_NUM     2
 
 size_t get_default_channel_subbuf_size(void);
@@ -128,8 +125,6 @@ size_t get_default_kernel_channel_subbuf_size(void);
 
 /* User space defaults */
 
-/* Must be a power of 2 */
-#define DEFAULT_UST_CHANNEL_SUBBUF_SIZE     4096    /* bytes */
 /* Must be a power of 2. Update help manuall if override. */
 #define DEFAULT_UST_CHANNEL_SUBBUF_NUM      DEFAULT_CHANNEL_SUBBUF_NUM
 /* See lttng-ust.h enum lttng_ust_output */
-- 
1.7.1
