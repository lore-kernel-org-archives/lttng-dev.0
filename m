From: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
Subject: [PATCH lttng-ust] Fix: allocate ts_end in ringbuffer
 shared memory
Date: Fri, 10 May 2019 11:12:24 -0400
Message-ID: <20190510151224.2848-1-gabriel.pollo-guilbert__21233.2815559179$1557501180$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 450txH4TRhz1JlQ
 for <lttng-dev@lists.lttng.org>; Fri, 10 May 2019 11:12:35 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This patch allocates the memory used by the ts_end field added by commit
6c737d05. When allocating lots of subbuffer for a channel (512 or more),
zalloc_shm() will fail to allocate all the objects because the allocated memory
map didn't take account the newly added field.

Signed-off-by: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
---
 libringbuffer/ring_buffer_backend.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libringbuffer/ring_buffer_backend.c b/libringbuffer/ring_buffer_backend.c
index a0ef7446..431b8eae 100644
--- a/libringbuffer/ring_buffer_backend.c
+++ b/libringbuffer/ring_buffer_backend.c
@@ -341,6 +341,9 @@ int channel_backend_init(struct channel_backend *chanb,
 	shmsize += sizeof(struct commit_counters_hot) * num_subbuf;
 	shmsize += offset_align(shmsize, __alignof__(struct commit_counters_cold));
 	shmsize += sizeof(struct commit_counters_cold) * num_subbuf;
+	/* Sampled timestamp end */
+	shmsize += offset_align(shmsize, __alignof__(uint64_t));
+	shmsize += sizeof(uint64_t) * num_subbuf;
 
 	if (config->alloc == RING_BUFFER_ALLOC_PER_CPU) {
 		struct lttng_ust_lib_ring_buffer *buf;
-- 
2.21.0
