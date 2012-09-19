From: Wade Farnsworth <wade_farnsworth@mentor.com>
Subject: [PATCH] ring_buffer_frontend.c: include
	lttng-tracer-core.h
Date: Wed, 19 Sep 2012 12:48:56 -0700
Message-ID: <505A21A8.4080900__25923.6308666461$1348084215$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <wade_farnsworth@mentor.com>) id 1TEQHF-00018a-PT
	for lttng-dev@lists.lttng.org; Wed, 19 Sep 2012 15:49:41 -0400
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1TEQH9-0005Uh-5S from wade_farnsworth@mentor.com
	for lttng-dev@lists.lttng.org; Wed, 19 Sep 2012 12:49:35 -0700
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

In lib/ringbuffer/ring_buffer_frontend.c, RING_BUFFER_ALIGN is undefined,
leading to no alignment offset being recorded after the call to
config->cb.record_header_size() in lib_ring_buffer_try_reserve_slow().

However, lttng-ring-buffer-client.h does define RING_BUFFER_ALIGN, so
the alignment offset will be produced when the packet header is written
in lttng_write_event_header().

This discrepancy may be observed on architectures that don't set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS, such as ARM, with a babeltrace
error such as:

babeltrace: ../../include/babeltrace/ctf/types.h:206: ctf_pos_get_event:
Assertion `pos->offset <= pos->content_size' failed.
Aborted

indicating that the actual content size differs from the calculated one
due to the difference in alignment.  Including the appropriate header
file in ring_buffer_frontend.c solves the problem.

Signed-off-by: Wade Farnsworth <wade_farnsworth@mentor.com>
---
 lib/ringbuffer/ring_buffer_frontend.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/ringbuffer/ring_buffer_frontend.c b/lib/ringbuffer/ring_buffer_frontend.c
index dc0357f..a04333a 100644
--- a/lib/ringbuffer/ring_buffer_frontend.c
+++ b/lib/ringbuffer/ring_buffer_frontend.c
@@ -55,6 +55,7 @@
 #include <linux/module.h>
 #include <linux/percpu.h>
 
+#include "../../lttng-tracer-core.h"
 #include "../../wrapper/ringbuffer/config.h"
 #include "../../wrapper/ringbuffer/backend.h"
 #include "../../wrapper/ringbuffer/frontend.h"
-- 
1.7.0.4
