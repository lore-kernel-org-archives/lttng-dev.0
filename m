From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: timestamp_end field should
 include all events within sub-buffer
Date: Tue, 30 Apr 2019 13:32:12 -0400 (EDT)
Message-ID: <313470429.20622.1556645532914.JavaMail.zimbra__13204.5231571951$1556645555$gmane$org@efficios.com>
References: <20190430161259.5809-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44tpW33G6Sz1KQr
 for <lttng-dev@lists.lttng.org>; Tue, 30 Apr 2019 13:32:15 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E974118D7FB
 for <lttng-dev@lists.lttng.org>; Tue, 30 Apr 2019 13:32:13 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id zI6c5S6AzEJe for <lttng-dev@lists.lttng.org>;
 Tue, 30 Apr 2019 13:32:13 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 34B3818D7F4
 for <lttng-dev@lists.lttng.org>; Tue, 30 Apr 2019 13:32:13 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id gUTciFiJi2O2 for <lttng-dev@lists.lttng.org>;
 Tue, 30 Apr 2019 13:32:13 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
 by mail.efficios.com (Postfix) with ESMTP id 1DCE318D7EB
 for <lttng-dev@lists.lttng.org>; Tue, 30 Apr 2019 13:32:13 -0400 (EDT)
In-Reply-To: <20190430161259.5809-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Apr 30, 2019, at 12:12 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Fix for timestamp_end not including all events within sub-buffer. This
> happens if a thread is preempted/interrupted for a long time between
> reserve and commit (e.g. in the middle of a packet), which causes the
> timestamp used for timestamp_end field of the packet header to be lower
> than the timestamp of the last events in the buffer (those following the
> event that was preempted/interrupted between reserve and commit).
> 
> The fix involves sampling the timestamp when doing the last space
> reservation in a sub-buffer (which necessarily happens before doing the
> delivery after its last commit). Save this timestamp temporarily in a
> per-sub-buffer control area (we have exclusive access to that area until
> we increment the commit counter).
> 
> Then, that timestamp value will be read when delivering the sub-buffer,
> whichever event or switch happens to be the last to increment the commit
> counter to perform delivery. The timestamp value can be read without
> worrying about concurrent access, because at that point sub-buffer
> delivery has exclusive access to the sub-buffer.
> 
> This ensures the timestamp_end value is always larger or equal to the
> timestamp of the last event, always below or equal the timestamp_begin
> of the following packet, and always below or equal the timestamp of the
> first event in the following packet.

Also:

    This changes the layout of the ring buffer shared memory area, so we
    need to bump the LTTNG_UST_ABI version from 7.2 to 8.0, thus requiring
    locked-step upgrade between liblttng-ust in applications, session
    daemon, and consumer daemon. This fix therefore cannot be backported
    to existing stable releases.

With the additional:

diff --git a/include/lttng/ust-abi.h b/include/lttng/ust-abi.h
index 01e9daf4..c1e13085 100644
--- a/include/lttng/ust-abi.h
+++ b/include/lttng/ust-abi.h
@@ -46,8 +46,8 @@
 #define LTTNG_UST_COMM_MAGIC                   0xC57C57C5
 
 /* Version for ABI between liblttng-ust, sessiond, consumerd */
-#define LTTNG_UST_ABI_MAJOR_VERSION            7
-#define LTTNG_UST_ABI_MINOR_VERSION            2
+#define LTTNG_UST_ABI_MAJOR_VERSION            8
+#define LTTNG_UST_ABI_MINOR_VERSION            0
 
 enum lttng_ust_instrumentation {
        LTTNG_UST_TRACEPOINT            = 0,



> 
> Fixes: #1183
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> libringbuffer/frontend_types.h       | 14 ++++++++
> libringbuffer/ring_buffer_frontend.c | 62 ++++++++++++++++++++++++++++++++++--
> 2 files changed, 73 insertions(+), 3 deletions(-)
> 
> diff --git a/libringbuffer/frontend_types.h b/libringbuffer/frontend_types.h
> index 629abcbd..d0890408 100644
> --- a/libringbuffer/frontend_types.h
> +++ b/libringbuffer/frontend_types.h
> @@ -202,6 +202,20 @@ struct lttng_ust_lib_ring_buffer {
> 
> 	DECLARE_SHMP(struct commit_counters_cold, commit_cold);
> 					/* Commit count per sub-buffer */
> +	DECLARE_SHMP(uint64_t, ts_end);	/*
> +					 * timestamp_end per sub-buffer.
> +					 * Time is sampled by the
> +					 * switch_*_end() callbacks
> +					 * which are the last space
> +					 * reservation performed in the
> +					 * sub-buffer before it can be
> +					 * fully committed and
> +					 * delivered. This time value is
> +					 * then read by the deliver
> +					 * callback, performed by the
> +					 * last commit before the buffer
> +					 * becomes readable.
> +					 */
> 	long active_readers;		/*
> 					 * Active readers count
> 					 * standard atomic access (shared)
> diff --git a/libringbuffer/ring_buffer_frontend.c
> b/libringbuffer/ring_buffer_frontend.c
> index 9721df16..ce759ff1 100644
> --- a/libringbuffer/ring_buffer_frontend.c
> +++ b/libringbuffer/ring_buffer_frontend.c
> @@ -194,6 +194,7 @@ void lib_ring_buffer_reset(struct lttng_ust_lib_ring_buffer
> *buf,
> 	for (i = 0; i < chan->backend.num_subbuf; i++) {
> 		struct commit_counters_hot *cc_hot;
> 		struct commit_counters_cold *cc_cold;
> +		uint64_t *ts_end;
> 
> 		cc_hot = shmp_index(handle, buf->commit_hot, i);
> 		if (!cc_hot)
> @@ -201,9 +202,13 @@ void lib_ring_buffer_reset(struct lttng_ust_lib_ring_buffer
> *buf,
> 		cc_cold = shmp_index(handle, buf->commit_cold, i);
> 		if (!cc_cold)
> 			return;
> +		ts_end = shmp_index(handle, buf->ts_end, i);
> +		if (!ts_end)
> +			return;
> 		v_set(config, &cc_hot->cc, 0);
> 		v_set(config, &cc_hot->seq, 0);
> 		v_set(config, &cc_cold->cc_sb, 0);
> +		*ts_end = 0;
> 	}
> 	uatomic_set(&buf->consumed, 0);
> 	uatomic_set(&buf->record_disabled, 0);
> @@ -368,6 +373,16 @@ int lib_ring_buffer_create(struct lttng_ust_lib_ring_buffer
> *buf,
> 		goto free_commit;
> 	}
> 
> +	align_shm(shmobj, __alignof__(uint64_t));
> +	set_shmp(buf->ts_end,
> +		 zalloc_shm(shmobj,
> +			sizeof(uint64_t) * chan->backend.num_subbuf));
> +	if (!shmp(handle, buf->ts_end)) {
> +		ret = -ENOMEM;
> +		goto free_commit_cold;
> +	}
> +
> +
> 	ret = lib_ring_buffer_backend_create(&buf->backend, &chan->backend,
> 			cpu, handle, shmobj);
> 	if (ret) {
> @@ -414,6 +429,8 @@ int lib_ring_buffer_create(struct lttng_ust_lib_ring_buffer
> *buf,
> 
> 	/* Error handling */
> free_init:
> +	/* ts_end will be freed by shm teardown */
> +free_commit_cold:
> 	/* commit_cold will be freed by shm teardown */
> free_commit:
> 	/* commit_hot will be freed by shm teardown */
> @@ -1795,15 +1812,29 @@ void lib_ring_buffer_switch_old_end(struct
> lttng_ust_lib_ring_buffer *buf,
> 	unsigned long oldidx = subbuf_index(offsets->old - 1, chan);
> 	unsigned long commit_count, padding_size, data_size;
> 	struct commit_counters_hot *cc_hot;
> +	uint64_t *ts_end;
> 
> 	data_size = subbuf_offset(offsets->old - 1, chan) + 1;
> 	padding_size = chan->backend.subbuf_size - data_size;
> 	subbuffer_set_data_size(config, &buf->backend, oldidx, data_size,
> 				handle);
> 
> +	ts_end = shmp_index(handle, buf->ts_end, oldidx);
> +	if (!ts_end)
> +		return;
> 	/*
> -	 * Order all writes to buffer before the commit count update that will
> -	 * determine that the subbuffer is full.
> +	 * This is the last space reservation in that sub-buffer before
> +	 * it gets delivered. This provides exclusive access to write to
> +	 * this sub-buffer's ts_end. There are also no concurrent
> +	 * readers of that ts_end because delivery of that sub-buffer is
> +	 * postponed until the commit counter is incremented for the
> +	 * current space reservation.
> +	 */
> +	*ts_end = tsc;
> +
> +	/*
> +	 * Order all writes to buffer and store to ts_end before the commit
> +	 * count update that will determine that the subbuffer is full.
> 	 */
> 	cmm_smp_wmb();
> 	cc_hot = shmp_index(handle, buf->commit_hot, oldidx);
> @@ -1874,11 +1905,24 @@ void lib_ring_buffer_switch_new_end(struct
> lttng_ust_lib_ring_buffer *buf,
> {
> 	const struct lttng_ust_lib_ring_buffer_config *config = &chan->backend.config;
> 	unsigned long endidx, data_size;
> +	uint64_t *ts_end;
> 
> 	endidx = subbuf_index(offsets->end - 1, chan);
> 	data_size = subbuf_offset(offsets->end - 1, chan) + 1;
> 	subbuffer_set_data_size(config, &buf->backend, endidx, data_size,
> 				handle);
> +	ts_end = shmp_index(handle, buf->ts_end, endidx);
> +	if (!ts_end)
> +		return;
> +	/*
> +	 * This is the last space reservation in that sub-buffer before
> +	 * it gets delivered. This provides exclusive access to write to
> +	 * this sub-buffer's ts_end. There are also no concurrent
> +	 * readers of that ts_end because delivery of that sub-buffer is
> +	 * postponed until the commit counter is incremented for the
> +	 * current space reservation.
> +	 */
> +	*ts_end = tsc;
> }
> 
> /*
> @@ -2445,14 +2489,26 @@ void lib_ring_buffer_check_deliver_slow(const struct
> lttng_ust_lib_ring_buffer_c
> 	if (caa_likely(v_cmpxchg(config, &cc_cold->cc_sb,
> 				 old_commit_count, old_commit_count + 1)
> 		   == old_commit_count)) {
> +		uint64_t *ts_end;
> +
> 		/*
> 		 * Start of exclusive subbuffer access. We are
> 		 * guaranteed to be the last writer in this subbuffer
> 		 * and any other writer trying to access this subbuffer
> 		 * in this state is required to drop records.
> +		 *
> +		 * We can read the ts_end for the current sub-buffer
> +		 * which has been saved by the very last space
> +		 * reservation for the current sub-buffer.
> +		 *
> +		 * Order increment of commit counter before reading ts_end.
> 		 */
> +		cmm_smp_mb();
> +		ts_end = shmp_index(handle, buf->ts_end, idx);
> +		if (!ts_end)
> +			return;
> 		deliver_count_events(config, buf, idx, handle);
> -		config->cb.buffer_end(buf, tsc, idx,
> +		config->cb.buffer_end(buf, *ts_end, idx,
> 				      lib_ring_buffer_get_data_size(config,
> 								buf,
> 								idx,
> --
> 2.11.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
