From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-modules] Fix: timestamp_end field should
 include all events within sub-buffer
Date: Tue, 30 Apr 2019 12:12:42 -0400
Message-ID: <20190430161242.5726-1-mathieu.desnoyers__4227.19800132967$1556640825$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44tmlY4n80z1KJY
 for <lttng-dev@lists.lttng.org>; Tue, 30 Apr 2019 12:12:57 -0400 (EDT)
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

Fix for timestamp_end not including all events within sub-buffer. This
happens if a thread is preempted/interrupted for a long time between
reserve and commit (e.g. in the middle of a packet), which causes the
timestamp used for timestamp_end field of the packet header to be lower
than the timestamp of the last events in the buffer (those following the
event that was preempted/interrupted between reserve and commit).

The fix involves sampling the timestamp when doing the last space
reservation in a sub-buffer (which necessarily happens before doing the
delivery after its last commit). Save this timestamp temporarily in a
per-sub-buffer control area (we have exclusive access to that area until
we increment the commit counter).

Then, that timestamp value will be read when delivering the sub-buffer,
whichever event or switch happens to be the last to increment the commit
counter to perform delivery. The timestamp value can be read without
worrying about concurrent access, because at that point sub-buffer
delivery has exclusive access to the sub-buffer.

This ensures the timestamp_end value is always larger or equal to the
timestamp of the last event, always below or equal the timestamp_begin
of the following packet, and always below or equal the timestamp of the
first event in the following packet.

Fixes: #1183
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 lib/ringbuffer/frontend_types.h       | 14 +++++++++
 lib/ringbuffer/ring_buffer_frontend.c | 54 +++++++++++++++++++++++++++++++++--
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/lib/ringbuffer/frontend_types.h b/lib/ringbuffer/frontend_types.h
index 837a926f..0d340afb 100644
--- a/lib/ringbuffer/frontend_types.h
+++ b/lib/ringbuffer/frontend_types.h
@@ -120,6 +120,20 @@ struct lib_ring_buffer {
 
 	struct commit_counters_cold *commit_cold;
 					/* Commit count per sub-buffer */
+	u64 *ts_end;			/*
+					 * timestamp_end per sub-buffer.
+					 * Time is sampled by the
+					 * switch_*_end() callbacks which
+					 * are the last space reservation
+					 * performed in the sub-buffer
+					 * before it can be fully
+					 * committed and delivered. This
+					 * time value is then read by
+					 * the deliver callback,
+					 * performed by the last commit
+					 * before the buffer becomes
+					 * readable.
+					 */
 	atomic_long_t active_readers;	/*
 					 * Active readers count
 					 * standard atomic access (shared)
diff --git a/lib/ringbuffer/ring_buffer_frontend.c b/lib/ringbuffer/ring_buffer_frontend.c
index 52afa8b0..fe5b8366 100644
--- a/lib/ringbuffer/ring_buffer_frontend.c
+++ b/lib/ringbuffer/ring_buffer_frontend.c
@@ -136,6 +136,7 @@ void lib_ring_buffer_free(struct lib_ring_buffer *buf)
 	lib_ring_buffer_print_errors(chan, buf, buf->backend.cpu);
 	lttng_kvfree(buf->commit_hot);
 	lttng_kvfree(buf->commit_cold);
+	lttng_kvfree(buf->ts_end);
 
 	lib_ring_buffer_backend_free(&buf->backend);
 }
@@ -165,6 +166,7 @@ void lib_ring_buffer_reset(struct lib_ring_buffer *buf)
 		v_set(config, &buf->commit_hot[i].cc, 0);
 		v_set(config, &buf->commit_hot[i].seq, 0);
 		v_set(config, &buf->commit_cold[i].cc_sb, 0);
+		buf->ts_end[i] = 0;
 	}
 	atomic_long_set(&buf->consumed, 0);
 	atomic_set(&buf->record_disabled, 0);
@@ -253,6 +255,17 @@ int lib_ring_buffer_create(struct lib_ring_buffer *buf,
 		goto free_commit;
 	}
 
+	buf->ts_end =
+		lttng_kvzalloc_node(ALIGN(sizeof(*buf->ts_end)
+				   * chan->backend.num_subbuf,
+				   1 << INTERNODE_CACHE_SHIFT),
+			GFP_KERNEL | __GFP_NOWARN,
+			cpu_to_node(max(cpu, 0)));
+	if (!buf->ts_end) {
+		ret = -ENOMEM;
+		goto free_commit_cold;
+	}
+
 	init_waitqueue_head(&buf->read_wait);
 	init_waitqueue_head(&buf->write_wait);
 	raw_spin_lock_init(&buf->raw_tick_nohz_spinlock);
@@ -292,6 +305,8 @@ int lib_ring_buffer_create(struct lib_ring_buffer *buf,
 
 	/* Error handling */
 free_init:
+	lttng_kvfree(buf->ts_end);
+free_commit_cold:
 	lttng_kvfree(buf->commit_cold);
 free_commit:
 	lttng_kvfree(buf->commit_hot);
@@ -1582,14 +1597,26 @@ void lib_ring_buffer_switch_old_end(struct lib_ring_buffer *buf,
 	unsigned long oldidx = subbuf_index(offsets->old - 1, chan);
 	unsigned long commit_count, padding_size, data_size;
 	struct commit_counters_hot *cc_hot;
+	u64 *ts_end;
 
 	data_size = subbuf_offset(offsets->old - 1, chan) + 1;
 	padding_size = chan->backend.subbuf_size - data_size;
 	subbuffer_set_data_size(config, &buf->backend, oldidx, data_size);
 
+	ts_end = &buf->ts_end[oldidx];
 	/*
-	 * Order all writes to buffer before the commit count update that will
-	 * determine that the subbuffer is full.
+	 * This is the last space reservation in that sub-buffer before
+	 * it gets delivered. This provides exclusive access to write to
+	 * this sub-buffer's ts_end. There are also no concurrent
+	 * readers of that ts_end because delivery of that sub-buffer is
+	 * postponed until the commit counter is incremented for the
+	 * current space reservation.
+	 */
+	*ts_end = tsc;
+
+	/*
+	 * Order all writes to buffer and store to ts_end before the commit
+	 * count update that will determine that the subbuffer is full.
 	 */
 	if (config->ipi == RING_BUFFER_IPI_BARRIER) {
 		/*
@@ -1670,10 +1697,21 @@ void lib_ring_buffer_switch_new_end(struct lib_ring_buffer *buf,
 {
 	const struct lib_ring_buffer_config *config = &chan->backend.config;
 	unsigned long endidx, data_size;
+	u64 *ts_end;
 
 	endidx = subbuf_index(offsets->end - 1, chan);
 	data_size = subbuf_offset(offsets->end - 1, chan) + 1;
 	subbuffer_set_data_size(config, &buf->backend, endidx, data_size);
+	ts_end = &buf->ts_end[endidx];
+	/*
+	 * This is the last space reservation in that sub-buffer before
+	 * it gets delivered. This provides exclusive access to write to
+	 * this sub-buffer's ts_end. There are also no concurrent
+	 * readers of that ts_end because delivery of that sub-buffer is
+	 * postponed until the commit counter is incremented for the
+	 * current space reservation.
+	 */
+	*ts_end = tsc;
 }
 
 /*
@@ -2237,14 +2275,24 @@ void lib_ring_buffer_check_deliver_slow(const struct lib_ring_buffer_config *con
 	if (likely(v_cmpxchg(config, &buf->commit_cold[idx].cc_sb,
 				 old_commit_count, old_commit_count + 1)
 		   == old_commit_count)) {
+		u64 *ts_end;
+
 		/*
 		 * Start of exclusive subbuffer access. We are
 		 * guaranteed to be the last writer in this subbuffer
 		 * and any other writer trying to access this subbuffer
 		 * in this state is required to drop records.
+		 *
+		 * We can read the ts_end for the current sub-buffer
+		 * which has been saved by the very last space
+		 * reservation for the current sub-buffer.
+		 *
+		 * Order increment of commit counter before reading ts_end.
 		 */
+		smp_mb();
+		ts_end = &buf->ts_end[idx];
 		deliver_count_events(config, buf, idx);
-		config->cb.buffer_end(buf, tsc, idx,
+		config->cb.buffer_end(buf, *ts_end, idx,
 				      lib_ring_buffer_get_data_size(config,
 								buf,
 								idx));
-- 
2.11.0
