From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] RFC: Drop support for kernels
 < 3.0
Date: Thu, 8 Nov 2018 15:15:56 -0500 (EST)
Message-ID: <714803963.2305.1541708156763.JavaMail.zimbra__1749.9434682124$1541708049$gmane$org@efficios.com>
References: <20181108200351.17511-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rZKs3rXxzq3g
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 15:16:01 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 687A9240743
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 15:16:00 -0500 (EST)
In-Reply-To: <20181108200351.17511-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Nov 8, 2018, at 3:03 PM, Michael Jeanson mjeanson@efficios.com wrote:

Hi Michael,

Can you split this patch as follows ?

- One patch updating README.md.

- Individual patches removing older kernel ifdefs for instrumentation, per subsystem.

- Individual patches removing each old wrapper and along with its associated use,

- One patch removing all backport patches,

- One patch removing old stuff from Makefile and Kbuild (I think it's missing from
  your patch currently),

Also, please justify in the README.md patch commit message why the 3.0 Linux kernel
version is chosen as backward compatibility cutoff point for now.

Thanks,

Mathieu

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> README.md                                     |   2 +-
> instrumentation/events/lttng-module/block.h   |  89 +--
> instrumentation/events/lttng-module/ext4.h    | 179 +-----
> instrumentation/events/lttng-module/irq.h     |  64 --
> instrumentation/events/lttng-module/jbd2.h    |   6 -
> instrumentation/events/lttng-module/kmem.h    |   7 -
> instrumentation/events/lttng-module/kvm.h     |  10 -
> instrumentation/events/lttng-module/lock.h    |  71 +--
> .../events/lttng-module/mm_vmscan.h           |   2 +-
> instrumentation/events/lttng-module/module.h  |  22 +-
> instrumentation/events/lttng-module/net.h     |  12 -
> instrumentation/events/lttng-module/power.h   |  40 --
> instrumentation/events/lttng-module/sched.h   |  68 +--
> instrumentation/events/lttng-module/scsi.h    |   8 -
> instrumentation/events/lttng-module/skb.h     |   4 -
> .../events/lttng-module/workqueue.h           |  61 --
> .../events/lttng-module/writeback.h           |   4 -
> lib/bug.h                                     |  10 +-
> lib/ringbuffer/frontend_types.h               |   1 -
> .../backport-kallsym-sym-2.6.32.patch         |  37 --
> .../backport-splice-sym-2.6.32-34.patch       |  71 ---
> .../backport-tp-2.6.34-tracepoint-data.patch  | 559 ------------------
> .../backport-tracepoint-data-2.6.32-33.patch  | 555 -----------------
> lttng-events.c                                |   7 +-
> lttng-events.h                                |   6 +-
> lttng-kernel-version.h                        |   5 -
> lttng-statedump-impl.c                        |   9 +-
> probes/lttng-probe-lock.c                     |   5 -
> tests/probes/lttng-test.c                     |   3 +-
> wrapper/atomic.h                              |   4 -
> wrapper/kstrtox.h                             |  47 --
> wrapper/perf.h                                |  25 -
> wrapper/spinlock.h                            |  34 --
> wrapper/tracepoint.h                          |   6 -
> wrapper/uuid.h                                |  30 -
> wrapper/vzalloc.h                             |  34 --
> 36 files changed, 37 insertions(+), 2060 deletions(-)
> delete mode 100644 linux-patches/backport-kallsym-sym-2.6.32.patch
> delete mode 100644 linux-patches/backport-splice-sym-2.6.32-34.patch
> delete mode 100644 linux-patches/backport-tp-2.6.34-tracepoint-data.patch
> delete mode 100644 linux-patches/backport-tracepoint-data-2.6.32-33.patch
> delete mode 100644 wrapper/kstrtox.h
> delete mode 100644 wrapper/spinlock.h
> delete mode 100644 wrapper/uuid.h
> delete mode 100644 wrapper/vzalloc.h
> 
> diff --git a/README.md b/README.md
> index 201a579..66bf925 100644
> --- a/README.md
> +++ b/README.md
> @@ -107,7 +107,7 @@ to print traces as a human-readable text log.
> Support
> -------
> 
> -Linux kernels >= 2.6.36 are supported.
> +Linux kernels >= 3.0 are supported.
> 
> 
> Notes
> diff --git a/instrumentation/events/lttng-module/block.h
> b/instrumentation/events/lttng-module/block.h
> index e7e9449..9f77526 100644
> --- a/instrumentation/events/lttng-module/block.h
> +++ b/instrumentation/events/lttng-module/block.h
> @@ -81,24 +81,7 @@ enum {
> 			| ((rw) & REQ_FLUSH ? RWBS_FLAG_FLUSH : 0)	      \
> 			| ((rw) & REQ_FUA ? RWBS_FLAG_FUA : 0))
> 
> -#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
> -
> -#define lttng_req_op(rq)
> -#define lttng_req_rw(rq)	((rq)->cmd_flags)
> -#define lttng_bio_op(bio)
> -#define lttng_bio_rw(bio)	((bio)->bi_rw)
> -
> -#define blk_rwbs_ctf_integer(type, rwbs, op, rw, bytes)			      \
> -		ctf_integer(type, rwbs, ((rw) & WRITE ? RWBS_FLAG_WRITE :     \
> -			( (rw) & REQ_DISCARD ? RWBS_FLAG_DISCARD :	      \
> -			( (bytes) ? RWBS_FLAG_READ :			      \
> -			( 0 ))))					      \
> -			| ((rw) & REQ_RAHEAD ? RWBS_FLAG_RAHEAD : 0)	      \
> -			| ((rw) & REQ_SYNC ? RWBS_FLAG_SYNC : 0)	      \
> -			| ((rw) & REQ_META ? RWBS_FLAG_META : 0)	      \
> -			| ((rw) & REQ_SECURE ? RWBS_FLAG_SECURE : 0))
> -
> -#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
> +#else
> 
> #define lttng_req_op(rq)
> #define lttng_req_rw(rq)	((rq)->cmd_flags)
> @@ -111,28 +94,10 @@ enum {
> 			( (bytes) ? RWBS_FLAG_READ :			      \
> 			( 0 ))))					      \
> 			| ((rw) & REQ_RAHEAD ? RWBS_FLAG_RAHEAD : 0)	      \
> -			| ((rw) & REQ_HARDBARRIER ? RWBS_FLAG_BARRIER : 0)    \
> 			| ((rw) & REQ_SYNC ? RWBS_FLAG_SYNC : 0)	      \
> 			| ((rw) & REQ_META ? RWBS_FLAG_META : 0)	      \
> 			| ((rw) & REQ_SECURE ? RWBS_FLAG_SECURE : 0))
> 
> -#else
> -
> -#define lttng_req_op(rq)
> -#define lttng_req_rw(rq)	((rq)->cmd_flags)
> -#define lttng_bio_op(bio)
> -#define lttng_bio_rw(bio)	((bio)->bi_rw)
> -
> -#define blk_rwbs_ctf_integer(type, rwbs, op, rw, bytes)			      \
> -		ctf_integer(type, rwbs, ((rw) & WRITE ? RWBS_FLAG_WRITE :     \
> -			( (rw) & (1 << BIO_RW_DISCARD) ? RWBS_FLAG_DISCARD :  \
> -			( (bytes) ? RWBS_FLAG_READ :			      \
> -			( 0 ))))					      \
> -			| ((rw) & (1 << BIO_RW_AHEAD) ? RWBS_FLAG_RAHEAD : 0) \
> -			| ((rw) & (1 << BIO_RW_SYNCIO) ? RWBS_FLAG_SYNC : 0)  \
> -			| ((rw) & (1 << BIO_RW_META) ? RWBS_FLAG_META : 0)    \
> -			| ((rw) & (1 << BIO_RW_BARRIER) ? RWBS_FLAG_BARRIER : 0))
> -
> #endif
> 
> #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0))
> @@ -653,15 +618,9 @@ LTTNG_TRACEPOINT_EVENT(block_bio_bounce,
>  */
> LTTNG_TRACEPOINT_EVENT(block_bio_complete,
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,38))
> 	TP_PROTO(struct request_queue *q, struct bio *bio, int error),
> 
> 	TP_ARGS(q, bio, error),
> -#else
> -	TP_PROTO(struct request_queue *q, struct bio *bio),
> -
> -	TP_ARGS(q, bio),
> -#endif
> 
> 	TP_FIELDS(
> #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0))
> @@ -679,11 +638,7 @@ LTTNG_TRACEPOINT_EVENT(block_bio_complete,
> #else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
> 		ctf_integer(sector_t, sector, bio->bi_sector)
> 		ctf_integer(unsigned int, nr_sector, bio->bi_size >> 9)
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,38))
> 		ctf_integer(int, error, error)
> -#else
> -		ctf_integer(int, error, 0)
> -#endif
> 		blk_rwbs_ctf_integer(unsigned int, rwbs,
> 			lttng_bio_op(bio), lttng_bio_rw(bio), bio->bi_size)
> #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
> @@ -938,43 +893,17 @@ LTTNG_TRACEPOINT_EVENT(block_plug,
> 
> LTTNG_TRACEPOINT_EVENT_CLASS(block_unplug,
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
> 	TP_PROTO(struct request_queue *q, unsigned int depth, bool explicit),
> 
> 	TP_ARGS(q, depth, explicit),
> -#else
> -	TP_PROTO(struct request_queue *q),
> -
> -	TP_ARGS(q),
> -#endif
> 
> 	TP_FIELDS(
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
> 		ctf_integer(int, nr_rq, depth)
> -#else
> -		ctf_integer(int, nr_rq, q->rq.count[READ] + q->rq.count[WRITE])
> -#endif
> 		ctf_integer(pid_t, tid, current->pid)
> 		ctf_array_text(char, comm, current->comm, TASK_COMM_LEN)
> 	)
> )
> 
> -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39))
> -/**
> - * block_unplug_timer - timed release of operations requests in queue to device
> driver
> - * @q: request queue to unplug
> - *
> - * Unplug the request queue @q because a timer expired and allow block
> - * operation requests to be sent to the device driver.
> - */
> -LTTNG_TRACEPOINT_EVENT_INSTANCE(block_unplug, block_unplug_timer,
> -
> -	TP_PROTO(struct request_queue *q),
> -
> -	TP_ARGS(q)
> -)
> -#endif
> -
> /**
>  * block_unplug - release of operations requests in request queue
>  * @q: request queue to unplug
> @@ -984,21 +913,11 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(block_unplug,
> block_unplug_timer,
>  * Unplug request queue @q because device driver is scheduled to work
>  * on elements in the request queue.
>  */
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
> LTTNG_TRACEPOINT_EVENT_INSTANCE(block_unplug, block_unplug,
> -#else
> -LTTNG_TRACEPOINT_EVENT_INSTANCE(block_unplug, block_unplug_io,
> -#endif
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
> 	TP_PROTO(struct request_queue *q, unsigned int depth, bool explicit),
> 
> 	TP_ARGS(q, depth, explicit)
> -#else
> -	TP_PROTO(struct request_queue *q),
> -
> -	TP_ARGS(q)
> -#endif
> )
> 
> /**
> @@ -1051,11 +970,7 @@ LTTNG_TRACEPOINT_EVENT(block_split,
>  * An operation for a logical device has been mapped to the
>  * raw block device.
>  */
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,38))
> LTTNG_TRACEPOINT_EVENT(block_bio_remap,
> -#else
> -LTTNG_TRACEPOINT_EVENT(block_remap,
> -#endif
> 
> 	TP_PROTO(struct request_queue *q, struct bio *bio, dev_t dev,
> 		 sector_t from),
> @@ -1085,7 +1000,6 @@ LTTNG_TRACEPOINT_EVENT(block_remap,
> 	)
> )
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
> /**
>  * block_rq_remap - map request for a block operation request
>  * @q: queue holding the operation
> @@ -1114,7 +1028,6 @@ LTTNG_TRACEPOINT_EVENT(block_rq_remap,
> 			lttng_req_op(rq), lttng_req_rw(rq), blk_rq_bytes(rq))
> 	)
> )
> -#endif
> 
> #undef __print_rwbs_flags
> #undef blk_fill_rwbs
> diff --git a/instrumentation/events/lttng-module/ext4.h
> b/instrumentation/events/lttng-module/ext4.h
> index 307021a..b2ca8a7 100644
> --- a/instrumentation/events/lttng-module/ext4.h
> +++ b/instrumentation/events/lttng-module/ext4.h
> @@ -74,7 +74,6 @@ LTTNG_TRACEPOINT_EVENT(ext4_allocate_inode,
> 	)
> )
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
> LTTNG_TRACEPOINT_EVENT(ext4_evict_inode,
> 	TP_PROTO(struct inode *inode),
> 
> @@ -122,7 +121,6 @@ LTTNG_TRACEPOINT_EVENT(ext4_begin_ordered_truncate,
> 		ctf_integer(loff_t, new_size, new_size)
> 	)
> )
> -#endif
> 
> LTTNG_TRACEPOINT_EVENT_CLASS(ext4__write_begin,
> 
> @@ -203,20 +201,6 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(ext4__write_end,
> ext4_da_write_end,
> 	TP_ARGS(inode, pos, len, copied)
> )
> 
> -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,40))
> -LTTNG_TRACEPOINT_EVENT(ext4_writepage,
> -	TP_PROTO(struct inode *inode, struct page *page),
> -
> -	TP_ARGS(inode, page),
> -
> -	TP_FIELDS(
> -		ctf_integer(dev_t, dev, inode->i_sb->s_dev)
> -		ctf_integer(ino_t, ino, inode->i_ino)
> -		ctf_integer(pgoff_t, index, page->index)
> -	)
> -)
> -#endif
> -
> LTTNG_TRACEPOINT_EVENT(ext4_da_writepages,
> 	TP_PROTO(struct inode *inode, struct writeback_control *wbc),
> 
> @@ -230,16 +214,8 @@ LTTNG_TRACEPOINT_EVENT(ext4_da_writepages,
> 		ctf_integer(loff_t, range_start, wbc->range_start)
> 		ctf_integer(loff_t, range_end, wbc->range_end)
> 		ctf_integer(pgoff_t, writeback_index, inode->i_mapping->writeback_index)
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
> 		ctf_integer(int, sync_mode, wbc->sync_mode)
> -#endif
> -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37))
> -		ctf_integer(char, nonblocking, wbc->nonblocking)
> -#endif
> 		ctf_integer(char, for_kupdate, wbc->for_kupdate)
> -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39))
> -		ctf_integer(char, for_reclaim, wbc->for_reclaim)
> -#endif
> 		ctf_integer(char, range_cyclic, wbc->range_cyclic)
> 	)
> )
> @@ -277,9 +253,7 @@ LTTNG_TRACEPOINT_EVENT(ext4_da_write_pages,
> 		ctf_integer(unsigned long, first_page, mpd->first_page)
> 		ctf_integer(int, io_done, mpd->io_done)
> 		ctf_integer(int, pages_written, mpd->pages_written)
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
> 		ctf_integer(int, sync_mode, mpd->wbc->sync_mode)
> -#endif
> 	)
> )
> 
> @@ -316,22 +290,10 @@ LTTNG_TRACEPOINT_EVENT(ext4_da_writepages_result,
> 		ctf_integer(int, pages_written, pages_written)
> 		ctf_integer(long, pages_skipped, wbc->pages_skipped)
> 		ctf_integer(pgoff_t, writeback_index, inode->i_mapping->writeback_index)
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
> 		ctf_integer(int, sync_mode, wbc->sync_mode)
> -#endif
> -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33))
> -		ctf_integer(char, encountered_congestion, wbc->encountered_congestion)
> -#endif
> -#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0))
> -		ctf_integer(char, more_io, wbc->more_io)
> -#endif
> -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
> -		ctf_integer(char, no_nrwrite_index_update, wbc->no_nrwrite_index_update)
> -#endif
> 	)
> )
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
> LTTNG_TRACEPOINT_EVENT_CLASS(ext4__page_op,
> 	TP_PROTO(struct page *page),
> 
> @@ -344,14 +306,12 @@ LTTNG_TRACEPOINT_EVENT_CLASS(ext4__page_op,
> 	)
> )
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,40))
> LTTNG_TRACEPOINT_EVENT_INSTANCE(ext4__page_op, ext4_writepage,
> 
> 	TP_PROTO(struct page *page),
> 
> 	TP_ARGS(page)
> )
> -#endif
> 
> LTTNG_TRACEPOINT_EVENT_INSTANCE(ext4__page_op, ext4_readpage,
> 
> @@ -413,8 +373,6 @@ LTTNG_TRACEPOINT_EVENT(ext4_invalidatepage,
> 
> #endif
> 
> -#endif
> -
> LTTNG_TRACEPOINT_EVENT(ext4_discard_blocks,
> 	TP_PROTO(struct super_block *sb, unsigned long long blk,
> 			unsigned long long count),
> @@ -461,91 +419,46 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(ext4__mb_new_pa,
> ext4_mb_new_group_pa,
> 
> LTTNG_TRACEPOINT_EVENT(ext4_mb_release_inode_pa,
> 	TP_PROTO(
> -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,40))
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
> -		 struct super_block *sb,
> -		 struct inode *inode,
> -#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
> -		 struct super_block *sb,
> -		 struct ext4_allocation_context *ac,
> -#else
> -		 struct ext4_allocation_context *ac,
> -#endif
> -#endif
> 		 struct ext4_prealloc_space *pa,
> 		 unsigned long long block, unsigned int count),
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,40))
> 	TP_ARGS(pa, block, count),
> -#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
> -	TP_ARGS(sb, inode, pa, block, count),
> -#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
> -	TP_ARGS(sb, ac, pa, block, count),
> -#else
> -	TP_ARGS(ac, pa, block, count),
> -#endif
> 
> 	TP_FIELDS(
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,40))
> 		ctf_integer(dev_t, dev, pa->pa_inode->i_sb->s_dev)
> 		ctf_integer(ino_t, ino, pa->pa_inode->i_ino)
> -#else
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
> -		ctf_integer(dev_t, dev, sb->s_dev)
> -#else
> -		ctf_integer(dev_t, dev, ac->ac_sb->s_dev)
> -#endif
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
> -		ctf_integer(ino_t, ino, inode->i_ino)
> -#else
> -		ctf_integer(ino_t, ino,
> -			(ac && ac->ac_inode) ? ac->ac_inode->i_ino : 0)
> -#endif
> -#endif
> 		ctf_integer(__u64, block, block)
> 		ctf_integer(__u32, count, count)
> 	)
> )
> 
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
> LTTNG_TRACEPOINT_EVENT(ext4_mb_release_group_pa,
> 
> -#if (LTTNG_KERNEL_RANGE(2,6,40, 3,3,0))
> -	TP_PROTO(struct ext4_prealloc_space *pa),
> -
> -	TP_ARGS(pa),
> -#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
> 	TP_PROTO(struct super_block *sb, struct ext4_prealloc_space *pa),
> 
> 	TP_ARGS(sb, pa),
> -#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
> -	TP_PROTO(struct super_block *sb,
> -		 struct ext4_allocation_context *ac,
> -		 struct ext4_prealloc_space *pa),
> 
> -	TP_ARGS(sb, ac, pa),
> +	TP_FIELDS(
> +		ctf_integer(dev_t, dev, sb->s_dev)
> +		ctf_integer(__u64, pa_pstart, pa->pa_pstart)
> +		ctf_integer(__u32, pa_len, pa->pa_len)
> +	)
> +)
> #else
> -	TP_PROTO(struct ext4_allocation_context *ac,
> -		 struct ext4_prealloc_space *pa),
> +LTTNG_TRACEPOINT_EVENT(ext4_mb_release_group_pa,
> 
> -	TP_ARGS(ac, pa),
> -#endif
> +	TP_PROTO(struct ext4_prealloc_space *pa),
> +
> +	TP_ARGS(pa),
> 
> 	TP_FIELDS(
> -#if (LTTNG_KERNEL_RANGE(2,6,40, 3,3,0))
> 		ctf_integer(dev_t, dev, pa->pa_inode->i_sb->s_dev)
> -#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
> -		ctf_integer(dev_t, dev, sb->s_dev)
> -#else
> -		ctf_integer(dev_t, dev, ac->ac_sb->s_dev)
> -#endif
> -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37))
> -		ctf_integer(ino_t, ino,
> -			(ac && ac->ac_inode) ? ac->ac_inode->i_ino : 0)
> -#endif
> 		ctf_integer(__u64, pa_pstart, pa->pa_pstart)
> 		ctf_integer(__u32, pa_len, pa->pa_len)
> 	)
> )
> +#endif
> 
> LTTNG_TRACEPOINT_EVENT(ext4_discard_preallocations,
> 	TP_PROTO(struct inode *inode),
> @@ -609,62 +522,34 @@ LTTNG_TRACEPOINT_EVENT(ext4_allocate_blocks,
> )
> 
> LTTNG_TRACEPOINT_EVENT(ext4_free_blocks,
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
> 	TP_PROTO(struct inode *inode, __u64 block, unsigned long count,
> 		 int flags),
> 
> 	TP_ARGS(inode, block, count, flags),
> -#else
> -	TP_PROTO(struct inode *inode, __u64 block, unsigned long count,
> -		 int metadata),
> -
> -	TP_ARGS(inode, block, count, metadata),
> -#endif
> 
> 	TP_FIELDS(
> 		ctf_integer(dev_t, dev, inode->i_sb->s_dev)
> 		ctf_integer(ino_t, ino, inode->i_ino)
> 		ctf_integer(__u64, block, block)
> 		ctf_integer(unsigned long, count, count)
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
> 		ctf_integer(int, flags, flags)
> 		ctf_integer(TP_MODE_T, mode, inode->i_mode)
> -#else
> -		ctf_integer(int, metadata, metadata)
> -#endif
> 	)
> )
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
> LTTNG_TRACEPOINT_EVENT(ext4_sync_file_enter,
> -#else
> -LTTNG_TRACEPOINT_EVENT(ext4_sync_file,
> -#endif
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> 	TP_PROTO(struct file *file, int datasync),
> 
> 	TP_ARGS(file, datasync),
> -#else
> -	TP_PROTO(struct file *file, struct dentry *dentry, int datasync),
> -
> -	TP_ARGS(file, dentry, datasync),
> -#endif
> 
> 	TP_FIELDS(
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> 		ctf_integer(dev_t, dev, file->f_path.dentry->d_inode->i_sb->s_dev)
> 		ctf_integer(ino_t, ino, file->f_path.dentry->d_inode->i_ino)
> 		ctf_integer(ino_t, parent, file->f_path.dentry->d_parent->d_inode->i_ino)
> -#else
> -		ctf_integer(dev_t, dev, dentry->d_inode->i_sb->s_dev)
> -		ctf_integer(ino_t, ino, dentry->d_inode->i_ino)
> -		ctf_integer(ino_t, parent, dentry->d_parent->d_inode->i_ino)
> -#endif
> 		ctf_integer(int, datasync, datasync)
> 	)
> )
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
> LTTNG_TRACEPOINT_EVENT(ext4_sync_file_exit,
> 	TP_PROTO(struct inode *inode, int ret),
> 
> @@ -676,7 +561,6 @@ LTTNG_TRACEPOINT_EVENT(ext4_sync_file_exit,
> 		ctf_integer(int, ret, ret)
> 	)
> )
> -#endif
> 
> LTTNG_TRACEPOINT_EVENT(ext4_sync_fs,
> 	TP_PROTO(struct super_block *sb, int wait),
> @@ -766,7 +650,6 @@ LTTNG_TRACEPOINT_EVENT(ext4_mballoc_prealloc,
> )
> 
> LTTNG_TRACEPOINT_EVENT_CLASS(ext4__mballoc,
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
> 	TP_PROTO(struct super_block *sb,
> 		 struct inode *inode,
> 		 ext4_group_t group,
> @@ -774,33 +657,18 @@ LTTNG_TRACEPOINT_EVENT_CLASS(ext4__mballoc,
> 		 ext4_grpblk_t len),
> 
> 	TP_ARGS(sb, inode, group, start, len),
> -#else
> -	TP_PROTO(struct ext4_allocation_context *ac),
> -
> -	TP_ARGS(ac),
> -#endif
> 
> 	TP_FIELDS(
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
> 		ctf_integer(dev_t, dev, sb->s_dev)
> 		ctf_integer(ino_t, ino, inode ? inode->i_ino : 0)
> 		ctf_integer(int, result_start, start)
> 		ctf_integer(__u32, result_group, group)
> 		ctf_integer(int, result_len, len)
> -#else
> -		ctf_integer(dev_t, dev, ac->ac_sb->s_dev)
> -		ctf_integer(ino_t, ino, ac->ac_inode ? ac->ac_inode->i_ino : 0)
> -		ctf_integer(__u32, result_logical, ac->ac_b_ex.fe_logical)
> -		ctf_integer(int, result_start, ac->ac_b_ex.fe_start)
> -		ctf_integer(__u32, result_group, ac->ac_b_ex.fe_group)
> -		ctf_integer(int, result_len, ac->ac_b_ex.fe_len)
> -#endif
> 	)
> )
> 
> LTTNG_TRACEPOINT_EVENT_INSTANCE(ext4__mballoc, ext4_mballoc_discard,
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
> 	TP_PROTO(struct super_block *sb,
> 		 struct inode *inode,
> 		 ext4_group_t group,
> @@ -808,16 +676,10 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(ext4__mballoc,
> ext4_mballoc_discard,
> 		 ext4_grpblk_t len),
> 
> 	TP_ARGS(sb, inode, group, start, len)
> -#else
> -	TP_PROTO(struct ext4_allocation_context *ac),
> -
> -	TP_ARGS(ac)
> -#endif
> )
> 
> LTTNG_TRACEPOINT_EVENT_INSTANCE(ext4__mballoc, ext4_mballoc_free,
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
> 	TP_PROTO(struct super_block *sb,
> 		 struct inode *inode,
> 		 ext4_group_t group,
> @@ -825,14 +687,8 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(ext4__mballoc,
> ext4_mballoc_free,
> 		 ext4_grpblk_t len),
> 
> 	TP_ARGS(sb, inode, group, start, len)
> -#else
> -	TP_PROTO(struct ext4_allocation_context *ac),
> -
> -	TP_ARGS(ac)
> -#endif
> )
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
> LTTNG_TRACEPOINT_EVENT(ext4_forget,
> 	TP_PROTO(struct inode *inode, int is_metadata, __u64 block),
> 
> @@ -846,7 +702,6 @@ LTTNG_TRACEPOINT_EVENT(ext4_forget,
> 		ctf_integer(TP_MODE_T, mode, inode->i_mode)
> 	)
> )
> -#endif
> 
> #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,13,0))
> LTTNG_TRACEPOINT_EVENT(ext4_da_update_reserve_space,
> @@ -886,7 +741,7 @@ LTTNG_TRACEPOINT_EVENT(ext4_da_update_reserve_space,
> 		ctf_integer(TP_MODE_T, mode, inode->i_mode)
> 	)
> )
> -#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
> +#else
> LTTNG_TRACEPOINT_EVENT(ext4_da_update_reserve_space,
> 	TP_PROTO(struct inode *inode, int used_blocks),
> 
> @@ -940,7 +795,7 @@ LTTNG_TRACEPOINT_EVENT(ext4_da_reserve_space,
> 		ctf_integer(TP_MODE_T, mode, inode->i_mode)
> 	)
> )
> -#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
> +#else
> LTTNG_TRACEPOINT_EVENT(ext4_da_reserve_space,
> 	TP_PROTO(struct inode *inode, int md_needed),
> 
> @@ -976,7 +831,7 @@ LTTNG_TRACEPOINT_EVENT(ext4_da_release_space,
> 		ctf_integer(TP_MODE_T, mode, inode->i_mode)
> 	)
> )
> -#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
> +#else
> LTTNG_TRACEPOINT_EVENT(ext4_da_release_space,
> 	TP_PROTO(struct inode *inode, int freed_blocks),
> 
> @@ -998,7 +853,6 @@ LTTNG_TRACEPOINT_EVENT(ext4_da_release_space,
> )
> #endif
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> LTTNG_TRACEPOINT_EVENT_CLASS(ext4__bitmap_load,
> 	TP_PROTO(struct super_block *sb, unsigned long group),
> 
> @@ -1023,9 +877,7 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(ext4__bitmap_load,
> ext4_mb_buddy_bitmap_load,
> 
> 	TP_ARGS(sb, group)
> )
> -#endif
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
> LTTNG_TRACEPOINT_EVENT_INSTANCE(ext4__bitmap_load, ext4_read_block_bitmap_load,
> 
> 	TP_PROTO(struct super_block *sb, unsigned long group),
> @@ -1402,7 +1254,6 @@ LTTNG_TRACEPOINT_EVENT(ext4_load_inode,
> 		ctf_integer(ino_t, ino, inode->i_ino)
> 	)
> )
> -#endif
> 
> #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
> 
> diff --git a/instrumentation/events/lttng-module/irq.h
> b/instrumentation/events/lttng-module/irq.h
> index 6f66a5e..71553e6 100644
> --- a/instrumentation/events/lttng-module/irq.h
> +++ b/instrumentation/events/lttng-module/irq.h
> @@ -61,7 +61,6 @@ LTTNG_TRACEPOINT_EVENT(irq_handler_exit,
> 	)
> )
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
> LTTNG_TRACEPOINT_EVENT_CLASS(irq_softirq,
> 
> 	TP_PROTO(unsigned int vec_nr),
> @@ -120,69 +119,6 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(irq_softirq,
> softirq_raise,
> 
> 	TP_ARGS(vec_nr)
> )
> -#else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37)) */
> -LTTNG_TRACEPOINT_EVENT_CLASS(irq_softirq,
> -
> -	TP_PROTO(struct softirq_action *h, struct softirq_action *vec),
> -
> -	TP_ARGS(h, vec),
> -
> -	TP_FIELDS(
> -		ctf_integer(unsigned int, vec, (int)(h - vec))
> -	)
> -)
> -
> -/**
> - * softirq_entry - called immediately before the softirq handler
> - * @h: pointer to struct softirq_action
> - * @vec: pointer to first struct softirq_action in softirq_vec array
> - *
> - * When used in combination with the softirq_exit tracepoint
> - * we can determine the softirq handler runtine.
> - */
> -LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(irq_softirq, softirq_entry,
> -
> -	irq_softirq_entry,
> -
> -	TP_PROTO(struct softirq_action *h, struct softirq_action *vec),
> -
> -	TP_ARGS(h, vec)
> -)
> -
> -/**
> - * softirq_exit - called immediately after the softirq handler returns
> - * @h: pointer to struct softirq_action
> - * @vec: pointer to first struct softirq_action in softirq_vec array
> - *
> - * When used in combination with the softirq_entry tracepoint
> - * we can determine the softirq handler runtine.
> - */
> -LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(irq_softirq, softirq_exit,
> -
> -	irq_softirq_exit,
> -
> -	TP_PROTO(struct softirq_action *h, struct softirq_action *vec),
> -
> -	TP_ARGS(h, vec)
> -)
> -
> -/**
> - * softirq_raise - called immediately when a softirq is raised
> - * @h: pointer to struct softirq_action
> - * @vec: pointer to first struct softirq_action in softirq_vec array
> - *
> - * When used in combination with the softirq_entry tracepoint
> - * we can determine the softirq raise to run latency.
> - */
> -LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(irq_softirq, softirq_raise,
> -
> -	irq_softirq_raise,
> -
> -	TP_PROTO(struct softirq_action *h, struct softirq_action *vec),
> -
> -	TP_ARGS(h, vec)
> -)
> -#endif /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37)) */
> 
> #endif /*  LTTNG_TRACE_IRQ_H */
> 
> diff --git a/instrumentation/events/lttng-module/jbd2.h
> b/instrumentation/events/lttng-module/jbd2.h
> index 10e3073..a760da2 100644
> --- a/instrumentation/events/lttng-module/jbd2.h
> +++ b/instrumentation/events/lttng-module/jbd2.h
> @@ -9,13 +9,11 @@
> #include <linux/jbd2.h>
> #include <linux/version.h>
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
> #ifndef _TRACE_JBD2_DEF
> #define _TRACE_JBD2_DEF
> struct transaction_chp_stats_s;
> struct transaction_run_stats_s;
> #endif
> -#endif
> 
> LTTNG_TRACEPOINT_EVENT(jbd2_checkpoint,
> 
> @@ -103,7 +101,6 @@ LTTNG_TRACEPOINT_EVENT(jbd2_submit_inode_data,
> 	)
> )
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
> LTTNG_TRACEPOINT_EVENT(jbd2_run_stats,
> 	TP_PROTO(dev_t dev, unsigned long tid,
> 		 struct transaction_run_stats_s *stats),
> @@ -139,9 +136,7 @@ LTTNG_TRACEPOINT_EVENT(jbd2_checkpoint_stats,
> 		ctf_integer(__u32, dropped, stats->cs_dropped)
> 	)
> )
> -#endif
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
> #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
> LTTNG_TRACEPOINT_EVENT(jbd2_update_log_tail,
> #else
> @@ -161,7 +156,6 @@ LTTNG_TRACEPOINT_EVENT(jbd2_cleanup_journal_tail,
> 		ctf_integer(unsigned long, freed, freed)
> 	)
> )
> -#endif
> 
> #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
> LTTNG_TRACEPOINT_EVENT(jbd2_write_superblock,
> diff --git a/instrumentation/events/lttng-module/kmem.h
> b/instrumentation/events/lttng-module/kmem.h
> index 8270fce..2313ae8 100644
> --- a/instrumentation/events/lttng-module/kmem.h
> +++ b/instrumentation/events/lttng-module/kmem.h
> @@ -115,7 +115,6 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(kmem_free, kmem_cache_free,
> 	TP_ARGS(call_site, ptr)
> )
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
> #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
> LTTNG_TRACEPOINT_EVENT_MAP(mm_page_free, kmem_mm_page_free,
> #else
> @@ -218,11 +217,7 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(kmem_mm_page,
> mm_page_pcpu_drain,
> 
> 	kmem_mm_page_pcpu_drain,
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
> 	TP_PROTO(struct page *page, unsigned int order, int migratetype),
> -#else
> -	TP_PROTO(struct page *page, int order, int migratetype),
> -#endif
> 
> 	TP_ARGS(page, order, migratetype)
> )
> @@ -337,8 +332,6 @@ LTTNG_TRACEPOINT_EVENT_MAP(mm_page_alloc_extfrag,
> 
> #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)) */
> 
> -#endif
> -
> #endif /* LTTNG_TRACE_KMEM_H */
> 
> /* This part must be outside protection */
> diff --git a/instrumentation/events/lttng-module/kvm.h
> b/instrumentation/events/lttng-module/kvm.h
> index 62030fc..4868d89 100644
> --- a/instrumentation/events/lttng-module/kvm.h
> +++ b/instrumentation/events/lttng-module/kvm.h
> @@ -8,8 +8,6 @@
> #undef TRACE_SYSTEM
> #define TRACE_SYSTEM kvm
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,38))
> -
> LTTNG_TRACEPOINT_EVENT(kvm_userspace_exit,
> 	    TP_PROTO(__u32 reason, int errno),
> 	    TP_ARGS(reason, errno),
> @@ -19,7 +17,6 @@ LTTNG_TRACEPOINT_EVENT(kvm_userspace_exit,
> 		ctf_integer(int, errno, errno)
> 	)
> )
> -#endif
> 
> #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0))
> #if defined(__KVM_HAVE_IOAPIC)
> @@ -142,8 +139,6 @@ LTTNG_TRACEPOINT_EVENT(kvm_mmio,
> 
> #endif
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
> -
> #define kvm_fpu_load_symbol	\
> 	{0, "unload"},		\
> 	{1, "load"}
> @@ -187,9 +182,6 @@ LTTNG_TRACEPOINT_EVENT(kvm_age_page,
> 	)
> )
> #endif
> -#endif
> -
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,38))
> 
> #ifdef CONFIG_KVM_ASYNC_PF
> LTTNG_TRACEPOINT_EVENT_CLASS(kvm_async_get_page_class,
> @@ -276,8 +268,6 @@ LTTNG_TRACEPOINT_EVENT(
> 
> #endif
> 
> -#endif
> -
> #endif /* LTTNG_TRACE_KVM_MAIN_H */
> 
> /* This part must be outside protection */
> diff --git a/instrumentation/events/lttng-module/lock.h
> b/instrumentation/events/lttng-module/lock.h
> index 49e7811..c8cdc55 100644
> --- a/instrumentation/events/lttng-module/lock.h
> +++ b/instrumentation/events/lttng-module/lock.h
> @@ -1,16 +1,7 @@
> /* SPDX-License-Identifier: GPL-2.0 */
> -#include <linux/version.h>
> 
> #undef TRACE_SYSTEM
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
> #define TRACE_SYSTEM lock
> -#else
> -#define TRACE_SYSTEM lockdep
> -#define TRACE_INCLUDE_FILE lock
> -#if defined(_TRACE_LOCKDEP_H)
> -#define LTTNG_TRACE_LOCK_H
> -#endif
> -#endif
> 
> #if !defined(LTTNG_TRACE_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
> #define LTTNG_TRACE_LOCK_H
> @@ -31,14 +22,10 @@ LTTNG_TRACEPOINT_EVENT(lock_acquire,
> 	TP_FIELDS(
> 		ctf_integer(unsigned int, flags, (trylock ? 1 : 0) | (read ? 2 : 0))
> 		ctf_string(name, lock->name)
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
> 		ctf_integer_hex(void *, lockdep_addr, lock)
> -#endif
> 	)
> )
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> -
> LTTNG_TRACEPOINT_EVENT_CLASS(lock,
> 
> 	TP_PROTO(struct lockdep_map *lock, unsigned long ip),
> @@ -74,63 +61,9 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(lock, lock_acquired,
> 	TP_ARGS(lock, ip)
> )
> 
> -#endif
> -
> -#else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)) */
> -
> -LTTNG_TRACEPOINT_EVENT(lock_release,
> -
> -	TP_PROTO(struct lockdep_map *lock, int nested, unsigned long ip),
> -
> -	TP_ARGS(lock, nested, ip),
> -
> -	TP_FIELDS(
> -		ctf_string(name, lock->name)
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
> -		ctf_integer_hex(void *, lockdep_addr, lock)
> -#endif
> -	)
> -)
> -
> -#ifdef CONFIG_LOCK_STAT
> -
> -LTTNG_TRACEPOINT_EVENT(lock_contended,
> -
> -	TP_PROTO(struct lockdep_map *lock, unsigned long ip),
> -
> -	TP_ARGS(lock, ip),
> -
> -	TP_FIELDS(
> -		ctf_string(name, lock->name)
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
> -		ctf_integer_hex(void *, lockdep_addr, lock)
> -#endif
> -	)
> -)
> -
> -LTTNG_TRACEPOINT_EVENT(lock_acquired,
> -
> -	TP_PROTO(struct lockdep_map *lock, unsigned long ip, s64 waittime),
> -
> -	TP_ARGS(lock, ip, waittime),
> -
> -	TP_FIELDS(
> -		ctf_string(name, lock->name)
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
> -		ctf_integer(s64, wait_nsec, wait_nsec)
> -		ctf_integer_hex(void *, lockdep_addr, lock)
> -#else
> -		ctf_integer(unsigned long, wait_usec, (unsigned long) waittime)
> -		ctf_integer(unsigned long, wait_nsec_rem, do_div(waittime, NSEC_PER_USEC))
> -#endif
> -	)
> -)
> -
> -#endif
> -
> -#endif /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)) */
> +#endif /* CONFIG_LOCK_STAT */
> 
> -#endif
> +#endif /* CONFIG_LOCKDEP */
> 
> #endif /* LTTNG_TRACE_LOCK_H */
> 
> diff --git a/instrumentation/events/lttng-module/mm_vmscan.h
> b/instrumentation/events/lttng-module/mm_vmscan.h
> index b9cd8b0..cc7a275 100644
> --- a/instrumentation/events/lttng-module/mm_vmscan.h
> +++ b/instrumentation/events/lttng-module/mm_vmscan.h
> @@ -640,7 +640,7 @@ LTTNG_TRACEPOINT_EVENT(mm_vmscan_lru_shrink_inactive,
> 		ctf_integer(int, reclaim_flags, trace_shrink_flags(file))
> 	)
> )
> -#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
> +#else
> LTTNG_TRACEPOINT_EVENT(mm_vmscan_lru_shrink_inactive,
> 
> 	TP_PROTO(int nid, int zid,
> diff --git a/instrumentation/events/lttng-module/module.h
> b/instrumentation/events/lttng-module/module.h
> index febe8d2..89b1e79 100644
> --- a/instrumentation/events/lttng-module/module.h
> +++ b/instrumentation/events/lttng-module/module.h
> @@ -54,24 +54,16 @@ LTTNG_TRACEPOINT_EVENT(module_free,
> 
> LTTNG_TRACEPOINT_EVENT_CLASS(module_refcnt,
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> 	TP_PROTO(struct module *mod, unsigned long ip),
> 
> 	TP_ARGS(mod, ip),
> -#else
> -	TP_PROTO(struct module *mod, unsigned long ip, int refcnt),
> -
> -	TP_ARGS(mod, ip, refcnt),
> -#endif
> 
> 	TP_FIELDS(
> 		ctf_integer(unsigned long, ip, ip)
> #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0))
> 		ctf_integer(int, refcnt, atomic_read(&mod->refcnt))
> -#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> -		ctf_integer(int, refcnt, __this_cpu_read(mod->refptr->incs) +
> __this_cpu_read(mod->refptr->decs))
> #else
> -		ctf_integer(int, refcnt, refcnt)
> +		ctf_integer(int, refcnt, __this_cpu_read(mod->refptr->incs) +
> __this_cpu_read(mod->refptr->decs))
> #endif
> 		ctf_string(name, mod->name)
> 	)
> @@ -79,28 +71,16 @@ LTTNG_TRACEPOINT_EVENT_CLASS(module_refcnt,
> 
> LTTNG_TRACEPOINT_EVENT_INSTANCE(module_refcnt, module_get,
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> 	TP_PROTO(struct module *mod, unsigned long ip),
> 
> 	TP_ARGS(mod, ip)
> -#else
> -	TP_PROTO(struct module *mod, unsigned long ip, int refcnt),
> -
> -	TP_ARGS(mod, ip, refcnt)
> -#endif
> )
> 
> LTTNG_TRACEPOINT_EVENT_INSTANCE(module_refcnt, module_put,
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> 	TP_PROTO(struct module *mod, unsigned long ip),
> 
> 	TP_ARGS(mod, ip)
> -#else
> -	TP_PROTO(struct module *mod, unsigned long ip, int refcnt),
> -
> -	TP_ARGS(mod, ip, refcnt)
> -#endif
> )
> #endif /* CONFIG_MODULE_UNLOAD */
> 
> diff --git a/instrumentation/events/lttng-module/net.h
> b/instrumentation/events/lttng-module/net.h
> index 8789263..bfa14fc 100644
> --- a/instrumentation/events/lttng-module/net.h
> +++ b/instrumentation/events/lttng-module/net.h
> @@ -439,30 +439,18 @@ LTTNG_TRACEPOINT_ENUM(net_network_header,
> 
> LTTNG_TRACEPOINT_EVENT(net_dev_xmit,
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,40))
> 	TP_PROTO(struct sk_buff *skb,
> 		 int rc,
> 		 struct net_device *dev,
> 		 unsigned int skb_len),
> 
> 	TP_ARGS(skb, rc, dev, skb_len),
> -#else
> -	TP_PROTO(struct sk_buff *skb,
> -		 int rc),
> -
> -	TP_ARGS(skb, rc),
> -#endif
> 
> 	TP_FIELDS(
> 		ctf_integer_hex(void *, skbaddr, skb)
> 		ctf_integer(int, rc, rc)
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,40))
> 		ctf_integer(unsigned int, len, skb_len)
> 		ctf_string(name, dev->name)
> -#else
> -		ctf_integer(unsigned int, len, skb->len)
> -		ctf_string(name, skb->dev->name)
> -#endif
> 	)
> )
> 
> diff --git a/instrumentation/events/lttng-module/power.h
> b/instrumentation/events/lttng-module/power.h
> index 2146a37..fee6f5f 100644
> --- a/instrumentation/events/lttng-module/power.h
> +++ b/instrumentation/events/lttng-module/power.h
> @@ -9,7 +9,6 @@
> #include <linux/ktime.h>
> #include <linux/version.h>
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,38))
> LTTNG_TRACEPOINT_EVENT_CLASS(power_cpu,
> 
> 	TP_PROTO(unsigned int state, unsigned int cpu_id),
> @@ -59,7 +58,6 @@ LTTNG_TRACEPOINT_EVENT_MAP(machine_suspend,
> 		ctf_integer(u32, state, state)
> 	)
> )
> -#endif
> 
> #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
> LTTNG_TRACEPOINT_EVENT_CLASS(power_wakeup_source,
> @@ -93,12 +91,6 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(power_wakeup_source,
> wakeup_source_deactivat
> )
> #endif
> 
> -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38))
> -#undef CONFIG_EVENT_POWER_TRACING_DEPRECATED
> -#define CONFIG_EVENT_POWER_TRACING_DEPRECATED
> -#define _PWR_EVENT_AVOID_DOUBLE_DEFINING_DEPRECATED
> -#endif
> -
> #ifdef CONFIG_EVENT_POWER_TRACING_DEPRECATED
> 
> /*
> @@ -107,69 +99,39 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(power_wakeup_source,
> wakeup_source_deactivat
>  */
> LTTNG_TRACEPOINT_EVENT_CLASS(power,
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
> 	TP_PROTO(unsigned int type, unsigned int state, unsigned int cpu_id),
> 
> 	TP_ARGS(type, state, cpu_id),
> -#else
> -	TP_PROTO(unsigned int type, unsigned int state),
> -
> -	TP_ARGS(type, state),
> -#endif
> 
> 	TP_FIELDS(
> 		ctf_integer(u64, type, type)
> 		ctf_integer(u64, state, state)
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
> 		ctf_integer(u64, cpu_id, cpu_id)
> -#endif
> 	)
> )
> 
> LTTNG_TRACEPOINT_EVENT_INSTANCE(power, power_start,
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
> 	TP_PROTO(unsigned int type, unsigned int state, unsigned int cpu_id),
> 
> 	TP_ARGS(type, state, cpu_id)
> -#else
> -	TP_PROTO(unsigned int type, unsigned int state),
> -
> -	TP_ARGS(type, state)
> -#endif
> )
> 
> LTTNG_TRACEPOINT_EVENT_INSTANCE(power, power_frequency,
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
> 	TP_PROTO(unsigned int type, unsigned int state, unsigned int cpu_id),
> 
> 	TP_ARGS(type, state, cpu_id)
> -#else
> -	TP_PROTO(unsigned int type, unsigned int state),
> -
> -	TP_ARGS(type, state)
> -#endif
> )
> 
> LTTNG_TRACEPOINT_EVENT(power_end,
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
> 	TP_PROTO(unsigned int cpu_id),
> 
> 	TP_ARGS(cpu_id),
> -#else
> -	TP_PROTO(int dummy),
> -
> -	TP_ARGS(dummy),
> -#endif
> 
> 	TP_FIELDS(
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
> 		ctf_integer(u64, cpu_id, cpu_id)
> -#else
> -		ctf_integer(u64, dummy, 0xffff)
> -#endif
> 	)
> )
> 
> @@ -207,7 +169,6 @@ static inline void trace_power_frequency(u64 type, u64
> state, u64 cpuid) {};
> 
> #endif /* CONFIG_EVENT_POWER_TRACING_DEPRECATED */
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
> /*
>  * The clock events are used for clock enable/disable and for
>  *  clock rate change
> @@ -274,7 +235,6 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(power_domain,
> power_domain_target,
> 
> 	TP_ARGS(name, state, cpu_id)
> )
> -#endif
> 
> #endif /* LTTNG_TRACE_POWER_H */
> 
> diff --git a/instrumentation/events/lttng-module/sched.h
> b/instrumentation/events/lttng-module/sched.h
> index 550ce2f..77d77b2 100644
> --- a/instrumentation/events/lttng-module/sched.h
> +++ b/instrumentation/events/lttng-module/sched.h
> @@ -93,7 +93,7 @@ static inline long __trace_sched_switch_state(struct
> task_struct *p)
> 	return state;
> }
> 
> -#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> +#else
> 
> static inline long __trace_sched_switch_state(struct task_struct *p)
> {
> @@ -170,24 +170,16 @@ LTTNG_TRACEPOINT_EVENT_CLASS(sched_wakeup_template,
> #else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)) */
> LTTNG_TRACEPOINT_EVENT_CLASS(sched_wakeup_template,
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> 	TP_PROTO(struct task_struct *p, int success),
> 
> 	TP_ARGS(p, success),
> -#else
> -	TP_PROTO(struct rq *rq, struct task_struct *p, int success),
> -
> -	TP_ARGS(rq, p, success),
> -#endif
> 
> 	TP_FIELDS(
> 		ctf_array_text(char, comm, p->comm, TASK_COMM_LEN)
> 		ctf_integer(pid_t, tid, p->pid)
> 		ctf_integer(int, prio, p->prio - MAX_RT_PRIO)
> 		ctf_integer(int, success, success)
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
> 		ctf_integer(int, target_cpu, task_cpu(p))
> -#endif
> 	)
> )
> #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)) */
> @@ -224,7 +216,7 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(sched_wakeup_template,
> sched_wakeup_new,
> 	     TP_PROTO(struct task_struct *p),
> 	     TP_ARGS(p))
> 
> -#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> +#else
> 
> LTTNG_TRACEPOINT_EVENT_INSTANCE(sched_wakeup_template, sched_wakeup,
> 	     TP_PROTO(struct task_struct *p, int success),
> @@ -237,20 +229,7 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(sched_wakeup_template,
> sched_wakeup_new,
> 	     TP_PROTO(struct task_struct *p, int success),
> 	     TP_ARGS(p, success))
> 
> -#else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)) */
> -
> -LTTNG_TRACEPOINT_EVENT_INSTANCE(sched_wakeup_template, sched_wakeup,
> -	     TP_PROTO(struct rq *rq, struct task_struct *p, int success),
> -	     TP_ARGS(rq, p, success))
> -
> -/*
> - * Tracepoint for waking up a new task:
> - */
> -LTTNG_TRACEPOINT_EVENT_INSTANCE(sched_wakeup_template, sched_wakeup_new,
> -	     TP_PROTO(struct rq *rq, struct task_struct *p, int success),
> -	     TP_ARGS(rq, p, success))
> -
> -#endif /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)) */
> +#endif /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)) */
> 
> /*
>  * Tracepoint for task switches, performed by the scheduler:
> @@ -263,17 +242,12 @@ LTTNG_TRACEPOINT_EVENT(sched_switch,
> 		 struct task_struct *next),
> 
> 	TP_ARGS(preempt, prev, next),
> -#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> +#else
> 	TP_PROTO(struct task_struct *prev,
> 		 struct task_struct *next),
> 
> 	TP_ARGS(prev, next),
> -#else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)) */
> -	TP_PROTO(struct rq *rq, struct task_struct *prev,
> -		 struct task_struct *next),
> -
> -	TP_ARGS(rq, prev, next),
> -#endif /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)) */
> +#endif /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0)) */
> 
> 	TP_FIELDS(
> 		ctf_array_text(char, prev_comm,	prev->comm, TASK_COMM_LEN)
> @@ -281,10 +255,8 @@ LTTNG_TRACEPOINT_EVENT(sched_switch,
> 		ctf_integer(int, prev_prio, prev->prio - MAX_RT_PRIO)
> #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0))
> 		ctf_integer(long, prev_state, __trace_sched_switch_state(preempt, prev))
> -#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> -		ctf_integer(long, prev_state, __trace_sched_switch_state(prev))
> #else
> -		ctf_integer(long, prev_state, prev->state)
> +		ctf_integer(long, prev_state, __trace_sched_switch_state(prev))
> #endif
> 		ctf_array_text(char, next_comm, next->comm, TASK_COMM_LEN)
> 		ctf_integer(pid_t, next_tid, next->pid)
> @@ -341,15 +313,9 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(sched_process_template,
> sched_process_exit,
> /*
>  * Tracepoint for waiting on task to unschedule:
>  */
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> LTTNG_TRACEPOINT_EVENT_INSTANCE(sched_process_template, sched_wait_task,
> 	TP_PROTO(struct task_struct *p),
> 	TP_ARGS(p))
> -#else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)) */
> -LTTNG_TRACEPOINT_EVENT_INSTANCE(sched_process_template, sched_wait_task,
> -	TP_PROTO(struct rq *rq, struct task_struct *p),
> -	TP_ARGS(rq, p))
> -#endif /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)) */
> 
> /*
>  * Tracepoint for a waiting task:
> @@ -445,24 +411,6 @@ LTTNG_TRACEPOINT_EVENT_CODE(sched_process_fork,
> 	TP_code_post()
> )
> 
> -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33))
> -/*
> - * Tracepoint for sending a signal:
> - */
> -LTTNG_TRACEPOINT_EVENT(sched_signal_send,
> -
> -	TP_PROTO(int sig, struct task_struct *p),
> -
> -	TP_ARGS(sig, p),
> -
> -	TP_FIELDS(
> -		ctf_integer(int, sig, sig)
> -		ctf_array_text(char, comm, p->comm, TASK_COMM_LEN)
> -		ctf_integer(pid_t, tid, p->pid)
> -	)
> -)
> -#endif
> -
> #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
> /*
>  * Tracepoint for exec:
> @@ -482,7 +430,6 @@ LTTNG_TRACEPOINT_EVENT(sched_process_exec,
> )
> #endif
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
> /*
>  * XXX the below sched_stat tracepoints only apply to SCHED_OTHER/BATCH/IDLE
>  *     adding sched_stat support to SCHED_FIFO/RR would be welcome.
> @@ -551,7 +498,6 @@ LTTNG_TRACEPOINT_EVENT(sched_stat_runtime,
> 		ctf_integer(u64, vruntime, vruntime)
> 	)
> )
> -#endif
> 
> #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,12,0) || \
> 	LTTNG_RT_KERNEL_RANGE(4,9,27,18, 4,10,0,0) || \
> @@ -573,7 +519,7 @@ LTTNG_TRACEPOINT_EVENT(sched_pi_setprio,
> 		ctf_integer(int, newprio, pi_task ? pi_task->prio - MAX_RT_PRIO : tsk->prio -
> 		MAX_RT_PRIO)
> 	)
> )
> -#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
> +#else
> /*
>  * Tracepoint for showing priority inheritance modifying a tasks
>  * priority.
> diff --git a/instrumentation/events/lttng-module/scsi.h
> b/instrumentation/events/lttng-module/scsi.h
> index 97ee050..7882def 100644
> --- a/instrumentation/events/lttng-module/scsi.h
> +++ b/instrumentation/events/lttng-module/scsi.h
> @@ -388,7 +388,6 @@
> 		scsi_statusbyte_name(SAM_STAT_ACA_ACTIVE),	\
> 		scsi_statusbyte_name(SAM_STAT_TASK_ABORTED))
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
> #define scsi_prot_op_name(result)	{ result, #result }
> #define show_prot_op_name(val)					\
> 	__print_symbolic(val,					\
> @@ -399,7 +398,6 @@
> 		scsi_prot_op_name(SCSI_PROT_WRITE_INSERT),	\
> 		scsi_prot_op_name(SCSI_PROT_READ_PASS),		\
> 		scsi_prot_op_name(SCSI_PROT_WRITE_PASS))
> -#endif
> 
> const char *scsi_trace_parse_cdb(struct trace_seq*, unsigned char*, int);
> #define __parse_cdb(cdb, len) scsi_trace_parse_cdb(p, cdb, len)
> @@ -420,9 +418,7 @@ LTTNG_TRACEPOINT_EVENT(scsi_dispatch_cmd_start,
> 		ctf_integer(unsigned int, cmd_len, cmd->cmd_len)
> 		ctf_integer(unsigned int, data_sglen, scsi_sg_count(cmd))
> 		ctf_integer(unsigned int, prot_sglen, scsi_prot_sg_count(cmd))
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
> 		ctf_integer(unsigned char, prot_op, scsi_get_prot_op(cmd))
> -#endif
> 		ctf_sequence_hex(unsigned char, cmnd, cmd->cmnd, u32, cmd->cmd_len)
> 	)
> )
> @@ -443,9 +439,7 @@ LTTNG_TRACEPOINT_EVENT(scsi_dispatch_cmd_error,
> 		ctf_integer(unsigned int, cmd_len, cmd->cmd_len)
> 		ctf_integer(unsigned int, data_sglen, scsi_sg_count(cmd))
> 		ctf_integer(unsigned int, prot_sglen, scsi_prot_sg_count(cmd))
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
> 		ctf_integer(unsigned char, prot_op, scsi_get_prot_op(cmd))
> -#endif
> 		ctf_sequence_hex(unsigned char, cmnd, cmd->cmnd, u32, cmd->cmd_len)
> 	)
> )
> @@ -466,9 +460,7 @@ LTTNG_TRACEPOINT_EVENT_CLASS(scsi_cmd_done_timeout_template,
> 		ctf_integer(unsigned int, cmd_len, cmd->cmd_len)
> 		ctf_integer(unsigned int, data_sglen, scsi_sg_count(cmd))
> 		ctf_integer(unsigned int, prot_sglen, scsi_prot_sg_count(cmd))
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
> 		ctf_integer(unsigned char, prot_op, scsi_get_prot_op(cmd))
> -#endif
> 		ctf_sequence_hex(unsigned char, cmnd, cmd->cmnd, u32, cmd->cmd_len)
> 	)
> )
> diff --git a/instrumentation/events/lttng-module/skb.h
> b/instrumentation/events/lttng-module/skb.h
> index 6d3fd45..1726b44 100644
> --- a/instrumentation/events/lttng-module/skb.h
> +++ b/instrumentation/events/lttng-module/skb.h
> @@ -28,7 +28,6 @@ LTTNG_TRACEPOINT_EVENT_MAP(kfree_skb,
> 	)
> )
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
> LTTNG_TRACEPOINT_EVENT_MAP(consume_skb,
> 
> 	skb_consume,
> @@ -41,9 +40,7 @@ LTTNG_TRACEPOINT_EVENT_MAP(consume_skb,
> 		ctf_integer_hex(void *, skbaddr, skb)
> 	)
> )
> -#endif
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
> LTTNG_TRACEPOINT_EVENT(skb_copy_datagram_iovec,
> 
> 	TP_PROTO(const struct sk_buff *skb, int len),
> @@ -55,7 +52,6 @@ LTTNG_TRACEPOINT_EVENT(skb_copy_datagram_iovec,
> 		ctf_integer(int, len, len)
> 	)
> )
> -#endif
> 
> #endif /* LTTNG_TRACE_SKB_H */
> 
> diff --git a/instrumentation/events/lttng-module/workqueue.h
> b/instrumentation/events/lttng-module/workqueue.h
> index 07d6a53..e0ef917 100644
> --- a/instrumentation/events/lttng-module/workqueue.h
> +++ b/instrumentation/events/lttng-module/workqueue.h
> @@ -9,8 +9,6 @@
> #include <linux/workqueue.h>
> #include <linux/version.h>
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
> -
> #ifndef _TRACE_WORKQUEUE_DEF_
> #define _TRACE_WORKQUEUE_DEF_
> 
> @@ -30,7 +28,6 @@ LTTNG_TRACEPOINT_EVENT_CLASS(workqueue_work,
> 	)
> )
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
> /**
>  * workqueue_queue_work - called when a work gets queued
>  * @req_cpu:	the requested cpu
> @@ -76,7 +73,6 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(workqueue_work,
> workqueue_activate_work,
> 
> 	TP_ARGS(work)
> )
> -#endif
> 
> /**
>  * workqueue_execute_start - called immediately before the workqueue callback
> @@ -109,63 +105,6 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(workqueue_work,
> workqueue_execute_end,
> 	TP_ARGS(work)
> )
> 
> -#else
> -
> -LTTNG_TRACEPOINT_EVENT_CLASS(workqueue,
> -
> -	TP_PROTO(struct task_struct *wq_thread, struct work_struct *work),
> -
> -	TP_ARGS(wq_thread, work),
> -
> -	TP_FIELDS(
> -		ctf_array(char, thread_comm, wq_thread->comm, TASK_COMM_LEN)
> -		ctf_integer(pid_t, thread_pid, wq_thread->pid)
> -		ctf_integer_hex(work_func_t, func, work->func)
> -	)
> -)
> -
> -LTTNG_TRACEPOINT_EVENT_INSTANCE(workqueue, workqueue_insertion,
> -
> -	TP_PROTO(struct task_struct *wq_thread, struct work_struct *work),
> -
> -	TP_ARGS(wq_thread, work)
> -)
> -
> -LTTNG_TRACEPOINT_EVENT_INSTANCE(workqueue, workqueue_execution,
> -
> -	TP_PROTO(struct task_struct *wq_thread, struct work_struct *work),
> -
> -	TP_ARGS(wq_thread, work)
> -)
> -
> -/* Trace the creation of one workqueue thread on a cpu */
> -LTTNG_TRACEPOINT_EVENT(workqueue_creation,
> -
> -	TP_PROTO(struct task_struct *wq_thread, int cpu),
> -
> -	TP_ARGS(wq_thread, cpu),
> -
> -	TP_FIELDS(
> -		ctf_array(char, thread_comm, wq_thread->comm, TASK_COMM_LEN)
> -		ctf_integer(pid_t, thread_pid, wq_thread->pid)
> -		ctf_integer(int, cpu, cpu)
> -	)
> -)
> -
> -LTTNG_TRACEPOINT_EVENT(workqueue_destruction,
> -
> -	TP_PROTO(struct task_struct *wq_thread),
> -
> -	TP_ARGS(wq_thread),
> -
> -	TP_FIELDS(
> -		ctf_array(char, thread_comm, wq_thread->comm, TASK_COMM_LEN)
> -		ctf_integer(pid_t, thread_pid, wq_thread->pid)
> -	)
> -)
> -
> -#endif
> -
> #endif /*  LTTNG_TRACE_WORKQUEUE_H */
> 
> /* This part must be outside protection */
> diff --git a/instrumentation/events/lttng-module/writeback.h
> b/instrumentation/events/lttng-module/writeback.h
> index 3327a0f..feef945 100644
> --- a/instrumentation/events/lttng-module/writeback.h
> +++ b/instrumentation/events/lttng-module/writeback.h
> @@ -308,9 +308,7 @@ DEFINE_WRITEBACK_EVENT(writeback_bdi_register)
> #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)) */
> 
> DEFINE_WRITEBACK_EVENT(writeback_nowork)
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,38))
> DEFINE_WRITEBACK_EVENT(writeback_wake_background)
> -#endif
> DEFINE_WRITEBACK_EVENT(writeback_wake_thread)
> DEFINE_WRITEBACK_EVENT(writeback_wake_forker_thread)
> DEFINE_WRITEBACK_EVENT(writeback_bdi_unregister)
> @@ -661,7 +659,6 @@ LTTNG_TRACEPOINT_EVENT(writeback_sb_inodes_requeue,
> )
> #endif
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
> LTTNG_TRACEPOINT_EVENT_CLASS(writeback_congest_waited_template,
> 
> 	TP_PROTO(unsigned int usec_timeout, unsigned int usec_delayed),
> @@ -687,7 +684,6 @@
> LTTNG_TRACEPOINT_EVENT_INSTANCE(writeback_congest_waited_template,
> writeback_wai
> 
> 	TP_ARGS(usec_timeout, usec_delayed)
> )
> -#endif
> 
> #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0))
> LTTNG_TRACEPOINT_EVENT_CLASS(writeback_single_inode_template,
> diff --git a/lib/bug.h b/lib/bug.h
> index 8ddf2b0..0f3b30b 100644
> --- a/lib/bug.h
> +++ b/lib/bug.h
> @@ -8,14 +8,6 @@
> #ifndef _LTTNG_BUG_H
> #define _LTTNG_BUG_H
> 
> -#include <linux/version.h>
> -
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,38))
> -#define LTTNG_BUILD_BUG_ON(cond) BUILD_BUG_ON(cond)
> -#else
> -#define LTTNG_BUILD_BUG_ON(cond) MAYBE_BUILD_BUG_ON(cond)
> -#endif
> -
> /**
>  * BUILD_RUNTIME_BUG_ON - check condition at build (if constant) or runtime
>  * @condition: the condition which should be false.
> @@ -28,7 +20,7 @@
> #define BUILD_RUNTIME_BUG_ON(condition)				\
> 	do {							\
> 		if (__builtin_constant_p(condition))		\
> -			LTTNG_BUILD_BUG_ON(condition);		\
> +			BUILD_BUG_ON(condition);		\
> 		else						\
> 			BUG_ON(condition);			\
> 	} while (0)
> diff --git a/lib/ringbuffer/frontend_types.h b/lib/ringbuffer/frontend_types.h
> index 2b0c932..837a926 100644
> --- a/lib/ringbuffer/frontend_types.h
> +++ b/lib/ringbuffer/frontend_types.h
> @@ -15,7 +15,6 @@
> #include <linux/kref.h>
> #include <wrapper/ringbuffer/config.h>
> #include <wrapper/ringbuffer/backend_types.h>
> -#include <wrapper/spinlock.h>
> #include <lib/prio_heap/lttng_prio_heap.h>	/* For per-CPU read-side iterator */
> #include <lttng-cpuhotplug.h>
> 
> diff --git a/linux-patches/backport-kallsym-sym-2.6.32.patch
> b/linux-patches/backport-kallsym-sym-2.6.32.patch
> deleted file mode 100644
> index 2e72124..0000000
> --- a/linux-patches/backport-kallsym-sym-2.6.32.patch
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -commit e6b48d720e39d17f06a4462be4164e1a358817de
> -Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> -Date:   Sat Sep 1 17:51:33 2012 -0700
> -
> -    kallsyms: Re-enable export of kallsyms_lookup (backport)
> -
> -    Backport of part of commit:
> -
> -    commit f60d24d2ad04977b0bd9e3eb35dba2d2fa569af9
> -    Author: Frederic Weisbecker <fweisbec@gmail.com>
> -    Date:   Tue Nov 10 10:17:07 2009 +0100
> -
> -        hw-breakpoints: Fix broken hw-breakpoint sample module
> -
> -        The hw-breakpoint sample module has been broken during the
> -        hw-breakpoint internals refactoring. Propagate the changes
> -        to it.
> -
> -        Reported-by: "K. Prasad" <prasad@linux.vnet.ibm.com>
> -        Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
> -
> -    for kernel 2.6.32.x. (just the symbol export)
> -
> -    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> -
> -diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> -index 8b6b8b6..8e5288a 100644
> ---- a/kernel/kallsyms.c
> -+++ b/kernel/kallsyms.c
> -@@ -181,6 +181,7 @@ unsigned long kallsyms_lookup_name(const char *name)
> - 	}
> - 	return module_kallsyms_lookup_name(name);
> - }
> -+EXPORT_SYMBOL_GPL(kallsyms_lookup_name);
> -
> - int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
> - 				      unsigned long),
> diff --git a/linux-patches/backport-splice-sym-2.6.32-34.patch
> b/linux-patches/backport-splice-sym-2.6.32-34.patch
> deleted file mode 100644
> index 00be3b5..0000000
> --- a/linux-patches/backport-splice-sym-2.6.32-34.patch
> +++ /dev/null
> @@ -1,71 +0,0 @@
> -commit f0d902f497ee2fb747086322a31925c7fb351d7a
> -Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> -Date:   Sat Sep 1 17:47:36 2012 -0700
> -
> -    mm: export generic_pipe_buf_*() to modules (backport)
> -
> -    Backport for 2.6.32.x to 2.6.34.x of commits:
> -
> -    commit 51921cb746f56983db5a373ca68deb2b0d3ddf01
> -    Author: Miklos Szeredi <mszeredi@suse.cz>
> -    Date:   Wed May 26 08:44:22 2010 +0200
> -
> -        mm: export generic_pipe_buf_*() to modules
> -
> -        This is needed by fuse device code which wants to create pipe buffers.
> -        Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
> -
> -    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> -
> -diff --git a/fs/pipe.c b/fs/pipe.c
> -index d0cc080..0eb6f53 100644
> ---- a/fs/pipe.c
> -+++ b/fs/pipe.c
> -@@ -222,6 +222,7 @@ void *generic_pipe_buf_map(struct pipe_inode_info *pipe,
> -
> - 	return kmap(buf->page);
> - }
> -+EXPORT_SYMBOL(generic_pipe_buf_map);
> -
> - /**
> -  * generic_pipe_buf_unmap - unmap a previously mapped pipe buffer
> -@@ -241,6 +242,7 @@ void generic_pipe_buf_unmap(struct pipe_inode_info *pipe,
> - 	} else
> - 		kunmap(buf->page);
> - }
> -+EXPORT_SYMBOL(generic_pipe_buf_unmap);
> -
> - /**
> -  * generic_pipe_buf_steal - attempt to take ownership of a &pipe_buffer
> -@@ -271,6 +273,7 @@ int generic_pipe_buf_steal(struct pipe_inode_info *pipe,
> -
> - 	return 1;
> - }
> -+EXPORT_SYMBOL(generic_pipe_buf_steal);
> -
> - /**
> -  * generic_pipe_buf_get - get a reference to a &struct pipe_buffer
> -@@ -286,6 +289,7 @@ void generic_pipe_buf_get(struct pipe_inode_info *pipe,
> struct pipe_buffer *buf)
> - {
> - 	page_cache_get(buf->page);
> - }
> -+EXPORT_SYMBOL(generic_pipe_buf_get);
> -
> - /**
> -  * generic_pipe_buf_confirm - verify contents of the pipe buffer
> -@@ -301,6 +305,7 @@ int generic_pipe_buf_confirm(struct pipe_inode_info *info,
> - {
> - 	return 0;
> - }
> -+EXPORT_SYMBOL(generic_pipe_buf_confirm);
> -
> - /**
> -  * generic_pipe_buf_release - put a reference to a &struct pipe_buffer
> -@@ -315,6 +320,7 @@ void generic_pipe_buf_release(struct pipe_inode_info *pipe,
> - {
> - 	page_cache_release(buf->page);
> - }
> -+EXPORT_SYMBOL(generic_pipe_buf_release);
> -
> - static const struct pipe_buf_operations anon_pipe_buf_ops = {
> - 	.can_merge = 1,
> diff --git a/linux-patches/backport-tp-2.6.34-tracepoint-data.patch
> b/linux-patches/backport-tp-2.6.34-tracepoint-data.patch
> deleted file mode 100644
> index 0ffd7e1..0000000
> --- a/linux-patches/backport-tp-2.6.34-tracepoint-data.patch
> +++ /dev/null
> @@ -1,559 +0,0 @@
> -commit 2c2a566b64b4254c530fb0c2222b30e8a739bac9
> -Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> -Date:   Sat Sep 1 17:45:09 2012 -0700
> -
> -    tracing: Let tracepoints have data passed to tracepoint callbacks
> (backport)
> -
> -    Backport of commit 38516ab59fbc5b3bb278cf5e1fe2867c70cff32e for
> -    2.6.34.x. Keeping kABI compatibility.
> -
> -    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> -
> ----
> - include/linux/tracepoint.h             |  149
> +++++++++++++++++++++++++--------
> - kernel/tracepoint.c                    |  144 ++++++++++++++++++++++---------
> - samples/tracepoints/tp-samples-trace.h |    4 +-
> - 3 files changed, 220 insertions(+), 77 deletions(-)
> -
> -Index: linux/include/linux/tracepoint.h
> -===================================================================
> ---- linux.orig/include/linux/tracepoint.h
> -+++ linux/include/linux/tracepoint.h
> -@@ -20,12 +20,20 @@
> - struct module;
> - struct tracepoint;
> -
> -+#define HAVE_KABI_2635_TRACEPOINT
> -+
> -+struct tracepoint_func {
> -+	void *func;
> -+	void *data;
> -+	bool kabi_2635;
> -+};
> -+
> - struct tracepoint {
> - 	const char *name;		/* Tracepoint name */
> - 	int state;			/* State. */
> - 	void (*regfunc)(void);
> - 	void (*unregfunc)(void);
> --	void **funcs;
> -+	struct tracepoint_func *funcs;
> - } __attribute__((aligned(32)));		/*
> - 					 * Aligned on 32 bytes because it is
> - 					 * globally visible and gcc happily
> -@@ -43,17 +51,33 @@ struct tracepoint {
> - /*
> -  * it_func[0] is never NULL because there is at least one element in the array
> -  * when the array itself is non NULL.
> -- */
> --#define __DO_TRACE(tp, proto, args)					\
> --	do {								\
> --		void **it_func;						\
> -+ *
> -+ * Note, the proto and args passed in includes "__data" as the first
> parameter.
> -+ * The reason for this is to handle the "void" prototype. If a tracepoint
> -+ * has a "void" prototype, then it is invalid to declare a function
> -+ * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
> -+ * "void *data", where as the DECLARE_TRACE() will pass in "void *data,
> proto".
> -+  */
> -+#define __DO_TRACE(tp, data_proto, data_args, proto, args)		\
> -+ 	do {								\
> -+		struct tracepoint_func *it_func_ptr;			\
> -+		void *it_func;						\
> -+ 									\
> -+ 		rcu_read_lock_sched_notrace();				\
> -+		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
> -+		if (it_func_ptr) {					\
> -+ 			do {						\
> -+				if (it_func_ptr->kabi_2635) {		\
> -+					void *__data;			\
> - 									\
> --		rcu_read_lock_sched_notrace();				\
> --		it_func = rcu_dereference_sched((tp)->funcs);		\
> --		if (it_func) {						\
> --			do {						\
> --				((void(*)(proto))(*it_func))(args);	\
> --			} while (*(++it_func));				\
> -+					it_func = (it_func_ptr)->func;	\
> -+					__data = (it_func_ptr)->data;	\
> -+					((void(*)(data_proto))(it_func))(data_args); \
> -+				} else {				\
> -+					it_func = (it_func_ptr)->func;	\
> -+					((void(*)(proto))(it_func))(args); \
> -+				}					\
> -+			} while ((++it_func_ptr)->func);		\
> - 		}							\
> - 		rcu_read_unlock_sched_notrace();			\
> - 	} while (0)
> -@@ -63,22 +87,39 @@ struct tracepoint {
> -  * not add unwanted padding between the beginning of the section and the
> -  * structure. Force alignment to the same alignment as the section start.
> -  */
> --#define DECLARE_TRACE(name, proto, args)				\
> -+#define __DECLARE_TRACE(name, proto, args, data_proto, data_args)	\
> - 	extern struct tracepoint __tracepoint_##name;			\
> - 	static inline void trace_##name(proto)				\
> - 	{								\
> - 		if (unlikely(__tracepoint_##name.state))		\
> - 			__DO_TRACE(&__tracepoint_##name,		\
> --				TP_PROTO(proto), TP_ARGS(args));	\
> -+				TP_PROTO(data_proto),			\
> -+				TP_ARGS(data_args),			\
> -+				TP_PROTO(proto),			\
> -+				TP_ARGS(args));				\
> - 	}								\
> --	static inline int register_trace_##name(void (*probe)(proto))	\
> --	{								\
> -+	static inline int						\
> -+	register_trace_##name(void (*probe)(proto))			\
> -+ 	{								\
> - 		return tracepoint_probe_register(#name, (void *)probe);	\
> --	}								\
> --	static inline int unregister_trace_##name(void (*probe)(proto))	\
> --	{								\
> --		return tracepoint_probe_unregister(#name, (void *)probe);\
> --	}
> -+ 	}								\
> -+	static inline int						\
> -+	unregister_trace_##name(void (*probe)(proto))			\
> -+ 	{								\
> -+		return tracepoint_probe_unregister(#name, (void *)probe); \
> -+ 	}								\
> -+	static inline int						\
> -+	kabi_2635_register_trace_##name(void (*probe)(data_proto), void *data) \
> -+ 	{								\
> -+		return kabi_2635_tracepoint_probe_register(#name, (void *)probe,	\
> -+						 data);			\
> -+ 	}								\
> -+	static inline int						\
> -+	kabi_2635_unregister_trace_##name(void (*probe)(data_proto), void *data) \
> -+ 	{								\
> -+		return kabi_2635_tracepoint_probe_unregister(#name, (void *)probe, \
> -+						   data);		\
> -+ 	}
> -
> -
> - #define DEFINE_TRACE_FN(name, reg, unreg)				\
> -@@ -100,19 +141,29 @@ extern void tracepoint_update_probe_rang
> - 	struct tracepoint *end);
> -
> - #else /* !CONFIG_TRACEPOINTS */
> --#define DECLARE_TRACE(name, proto, args)				\
> --	static inline void _do_trace_##name(struct tracepoint *tp, proto) \
> --	{ }								\
> --	static inline void trace_##name(proto)				\
> --	{ }								\
> --	static inline int register_trace_##name(void (*probe)(proto))	\
> --	{								\
> --		return -ENOSYS;						\
> --	}								\
> --	static inline int unregister_trace_##name(void (*probe)(proto))	\
> --	{								\
> --		return -ENOSYS;						\
> --	}
> -+#define __DECLARE_TRACE(name, proto, args, data_proto, data_args)	\
> -+ 	static inline void trace_##name(proto)				\
> -+ 	{ }								\
> -+	static inline int						\
> -+	register_trace_##name(void (*probe)(proto))			\
> -+ 	{								\
> -+ 		return -ENOSYS;						\
> -+ 	}								\
> -+	static inline int						\
> -+	unregister_trace_##name(void (*probe)(proto))			\
> -+ 	{								\
> -+ 		return -ENOSYS;						\
> -+ 	}								\
> -+	static inline int						\
> -+	kabi_2635_register_trace_##name(void (*probe)(data_proto), void *data) \
> -+ 	{								\
> -+ 		return -ENOSYS;						\
> -+ 	}								\
> -+	static inline int						\
> -+	kabi_2635_unregister_trace_##name(void (*probe)(data_proto), void *data) \
> -+ 	{								\
> -+ 		return -ENOSYS;						\
> -+ 	}
> -
> - #define DEFINE_TRACE_FN(name, reg, unreg)
> - #define DEFINE_TRACE(name)
> -@@ -123,6 +174,28 @@ static inline void tracepoint_update_pro
> - 	struct tracepoint *end)
> - { }
> - #endif /* CONFIG_TRACEPOINTS */
> -+
> -+/*
> -+ * The need for the DECLARE_TRACE_NOARGS() is to handle the prototype
> -+ * (void). "void" is a special value in a function prototype and can
> -+ * not be combined with other arguments. Since the DECLARE_TRACE()
> -+ * macro adds a data element at the beginning of the prototype,
> -+ * we need a way to differentiate "(void *data, proto)" from
> -+ * "(void *data, void)". The second prototype is invalid.
> -+ *
> -+ * DECLARE_TRACE_NOARGS() passes "void" as the tracepoint prototype
> -+ * and "void *__data" as the callback prototype.
> -+ *
> -+ * DECLARE_TRACE() passes "proto" as the tracepoint protoype and
> -+ * "void *__data, proto" as the callback prototype.
> -+ */
> -+#define DECLARE_TRACE_NOARGS(name)					\
> -+	__DECLARE_TRACE(name, void, , void *__data, __data)
> -+#define DECLARE_TRACE(name, proto, args)				\
> -+	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
> -+			PARAMS(void *__data, proto),			\
> -+			PARAMS(__data, args))
> -+
> - #endif /* DECLARE_TRACE */
> -
> - /*
> -@@ -130,15 +203,23 @@ static inline void tracepoint_update_pro
> -  * Internal API, should not be used directly.
> -  */
> - extern int tracepoint_probe_register(const char *name, void *probe);
> -+extern int kabi_2635_tracepoint_probe_register(const char *name, void *probe,
> void *data);
> -
> - /*
> -  * Disconnect a probe from a tracepoint.
> -  * Internal API, should not be used directly.
> -  */
> --extern int tracepoint_probe_unregister(const char *name, void *probe);
> -+extern int
> -+tracepoint_probe_unregister(const char *name, void *probe);
> -+extern int
> -+kabi_2635_tracepoint_probe_unregister(const char *name, void *probe, void
> *data);
> -
> - extern int tracepoint_probe_register_noupdate(const char *name, void *probe);
> -+extern int kabi_2635_tracepoint_probe_register_noupdate(const char *name, void
> *probe,
> -+					      void *data);
> - extern int tracepoint_probe_unregister_noupdate(const char *name, void
> *probe);
> -+extern int kabi_2635_tracepoint_probe_unregister_noupdate(const char *name,
> void *probe,
> -+						void *data);
> - extern void tracepoint_probe_update_all(void);
> -
> - struct tracepoint_iter {
> -Index: linux/kernel/tracepoint.c
> -===================================================================
> ---- linux.orig/kernel/tracepoint.c
> -+++ linux/kernel/tracepoint.c
> -@@ -54,7 +54,7 @@ static struct hlist_head tracepoint_tabl
> -  */
> - struct tracepoint_entry {
> - 	struct hlist_node hlist;
> --	void **funcs;
> -+	struct tracepoint_func *funcs;
> - 	int refcount;	/* Number of times armed. 0 if disarmed. */
> - 	char name[0];
> - };
> -@@ -64,12 +64,12 @@ struct tp_probes {
> - 		struct rcu_head rcu;
> - 		struct list_head list;
> - 	} u;
> --	void *probes[0];
> -+	struct tracepoint_func probes[0];
> - };
> -
> - static inline void *allocate_probes(int count)
> - {
> --	struct tp_probes *p  = kmalloc(count * sizeof(void *)
> -+	struct tp_probes *p  = kmalloc(count * sizeof(struct tracepoint_func)
> - 			+ sizeof(struct tp_probes), GFP_KERNEL);
> - 	return p == NULL ? NULL : p->probes;
> - }
> -@@ -79,7 +79,7 @@ static void rcu_free_old_probes(struct r
> - 	kfree(container_of(head, struct tp_probes, u.rcu));
> - }
> -
> --static inline void release_probes(void *old)
> -+static inline void release_probes(struct tracepoint_func *old)
> - {
> - 	if (old) {
> - 		struct tp_probes *tp_probes = container_of(old,
> -@@ -95,15 +95,16 @@ static void debug_print_probes(struct tr
> - 	if (!tracepoint_debug || !entry->funcs)
> - 		return;
> -
> --	for (i = 0; entry->funcs[i]; i++)
> --		printk(KERN_DEBUG "Probe %d : %p\n", i, entry->funcs[i]);
> -+	for (i = 0; entry->funcs[i].func; i++)
> -+		printk(KERN_DEBUG "Probe %d : %p\n", i, entry->funcs[i].func);
> - }
> -
> --static void *
> --tracepoint_entry_add_probe(struct tracepoint_entry *entry, void *probe)
> -+static struct tracepoint_func *
> -+tracepoint_entry_add_probe(struct tracepoint_entry *entry,
> -+			   void *probe, void *data, bool kabi_2635)
> - {
> - 	int nr_probes = 0;
> --	void **old, **new;
> -+	struct tracepoint_func *old, *new;
> -
> - 	WARN_ON(!probe);
> -
> -@@ -111,8 +112,9 @@ tracepoint_entry_add_probe(struct tracep
> - 	old = entry->funcs;
> - 	if (old) {
> - 		/* (N -> N+1), (N != 0, 1) probes */
> --		for (nr_probes = 0; old[nr_probes]; nr_probes++)
> --			if (old[nr_probes] == probe)
> -+		for (nr_probes = 0; old[nr_probes].func; nr_probes++)
> -+			if (old[nr_probes].func == probe &&
> -+			    old[nr_probes].data == data)
> - 				return ERR_PTR(-EEXIST);
> - 	}
> - 	/* + 2 : one for new probe, one for NULL func */
> -@@ -120,9 +122,11 @@ tracepoint_entry_add_probe(struct tracep
> - 	if (new == NULL)
> - 		return ERR_PTR(-ENOMEM);
> - 	if (old)
> --		memcpy(new, old, nr_probes * sizeof(void *));
> --	new[nr_probes] = probe;
> --	new[nr_probes + 1] = NULL;
> -+		memcpy(new, old, nr_probes * sizeof(struct tracepoint_func));
> -+	new[nr_probes].func = probe;
> -+	new[nr_probes].data = data;
> -+	new[nr_probes].kabi_2635 = kabi_2635;
> -+	new[nr_probes + 1].func = NULL;
> - 	entry->refcount = nr_probes + 1;
> - 	entry->funcs = new;
> - 	debug_print_probes(entry);
> -@@ -130,10 +134,11 @@ tracepoint_entry_add_probe(struct tracep
> - }
> -
> - static void *
> --tracepoint_entry_remove_probe(struct tracepoint_entry *entry, void *probe)
> -+tracepoint_entry_remove_probe(struct tracepoint_entry *entry,
> -+			      void *probe, void *data)
> - {
> - 	int nr_probes = 0, nr_del = 0, i;
> --	void **old, **new;
> -+	struct tracepoint_func *old, *new;
> -
> - 	old = entry->funcs;
> -
> -@@ -142,8 +147,10 @@ tracepoint_entry_remove_probe(struct tra
> -
> - 	debug_print_probes(entry);
> - 	/* (N -> M), (N > 1, M >= 0) probes */
> --	for (nr_probes = 0; old[nr_probes]; nr_probes++) {
> --		if ((!probe || old[nr_probes] == probe))
> -+	for (nr_probes = 0; old[nr_probes].func; nr_probes++) {
> -+		if (!probe ||
> -+		    (old[nr_probes].func == probe &&
> -+		     old[nr_probes].data == data))
> - 			nr_del++;
> - 	}
> -
> -@@ -160,10 +167,11 @@ tracepoint_entry_remove_probe(struct tra
> - 		new = allocate_probes(nr_probes - nr_del + 1);
> - 		if (new == NULL)
> - 			return ERR_PTR(-ENOMEM);
> --		for (i = 0; old[i]; i++)
> --			if ((probe && old[i] != probe))
> -+		for (i = 0; old[i].func; i++)
> -+			if (probe &&
> -+			    (old[i].func != probe || old[i].data != data))
> - 				new[j++] = old[i];
> --		new[nr_probes - nr_del] = NULL;
> -+		new[nr_probes - nr_del].func = NULL;
> - 		entry->refcount = nr_probes - nr_del;
> - 		entry->funcs = new;
> - 	}
> -@@ -315,18 +323,19 @@ static void tracepoint_update_probes(voi
> - 	module_update_tracepoints();
> - }
> -
> --static void *tracepoint_add_probe(const char *name, void *probe)
> -+static struct tracepoint_func *
> -+tracepoint_add_probe(const char *name, void *probe, void *data, bool
> kabi_2635)
> - {
> - 	struct tracepoint_entry *entry;
> --	void *old;
> -+	struct tracepoint_func *old;
> -
> - 	entry = get_tracepoint(name);
> - 	if (!entry) {
> - 		entry = add_tracepoint(name);
> - 		if (IS_ERR(entry))
> --			return entry;
> -+			return (struct tracepoint_func *)entry;
> - 	}
> --	old = tracepoint_entry_add_probe(entry, probe);
> -+	old = tracepoint_entry_add_probe(entry, probe, data, kabi_2635);
> - 	if (IS_ERR(old) && !entry->refcount)
> - 		remove_tracepoint(entry);
> - 	return old;
> -@@ -340,12 +349,14 @@ static void *tracepoint_add_probe(const
> -  * Returns 0 if ok, error value on error.
> -  * The probe address must at least be aligned on the architecture pointer
> size.
> -  */
> --int tracepoint_probe_register(const char *name, void *probe)
> -+static
> -+int ___tracepoint_probe_register(const char *name, void *probe, void *data,
> -+			bool kabi_2635)
> - {
> --	void *old;
> -+	struct tracepoint_func *old;
> -
> - 	mutex_lock(&tracepoints_mutex);
> --	old = tracepoint_add_probe(name, probe);
> -+	old = tracepoint_add_probe(name, probe, data, kabi_2635);
> - 	mutex_unlock(&tracepoints_mutex);
> - 	if (IS_ERR(old))
> - 		return PTR_ERR(old);
> -@@ -354,17 +365,30 @@ int tracepoint_probe_register(const char
> - 	release_probes(old);
> - 	return 0;
> - }
> -+
> -+int kabi_2635_tracepoint_probe_register(const char *name, void *probe, void
> *data)
> -+{
> -+	return ___tracepoint_probe_register(name, probe, data, 1);
> -+}
> -+EXPORT_SYMBOL_GPL(kabi_2635_tracepoint_probe_register);
> -+
> -+
> -+int tracepoint_probe_register(const char *name, void *probe)
> -+{
> -+	return ___tracepoint_probe_register(name, probe, NULL, 0);
> -+}
> - EXPORT_SYMBOL_GPL(tracepoint_probe_register);
> -
> --static void *tracepoint_remove_probe(const char *name, void *probe)
> -+static struct tracepoint_func *
> -+tracepoint_remove_probe(const char *name, void *probe, void *data)
> - {
> - 	struct tracepoint_entry *entry;
> --	void *old;
> -+	struct tracepoint_func *old;
> -
> - 	entry = get_tracepoint(name);
> - 	if (!entry)
> - 		return ERR_PTR(-ENOENT);
> --	old = tracepoint_entry_remove_probe(entry, probe);
> -+	old = tracepoint_entry_remove_probe(entry, probe, data);
> - 	if (IS_ERR(old))
> - 		return old;
> - 	if (!entry->refcount)
> -@@ -382,12 +406,13 @@ static void *tracepoint_remove_probe(con
> -  * itself uses stop_machine(), which insures that every preempt disabled
> section
> -  * have finished.
> -  */
> --int tracepoint_probe_unregister(const char *name, void *probe)
> -+static
> -+int ___tracepoint_probe_unregister(const char *name, void *probe, void *data)
> - {
> --	void *old;
> -+	struct tracepoint_func *old;
> -
> - 	mutex_lock(&tracepoints_mutex);
> --	old = tracepoint_remove_probe(name, probe);
> -+	old = tracepoint_remove_probe(name, probe, data);
> - 	mutex_unlock(&tracepoints_mutex);
> - 	if (IS_ERR(old))
> - 		return PTR_ERR(old);
> -@@ -396,6 +421,17 @@ int tracepoint_probe_unregister(const ch
> - 	release_probes(old);
> - 	return 0;
> - }
> -+
> -+int kabi_2635_tracepoint_probe_unregister(const char *name, void *probe, void
> *data)
> -+{
> -+	return ___tracepoint_probe_unregister(name, probe, data);
> -+}
> -+EXPORT_SYMBOL_GPL(kabi_2635_tracepoint_probe_unregister);
> -+
> -+int tracepoint_probe_unregister(const char *name, void *probe)
> -+{
> -+	return ___tracepoint_probe_unregister(name, probe, NULL);
> -+}
> - EXPORT_SYMBOL_GPL(tracepoint_probe_unregister);
> -
> - static LIST_HEAD(old_probes);
> -@@ -418,12 +454,14 @@ static void tracepoint_add_old_probes(vo
> -  *
> -  * caller must call tracepoint_probe_update_all()
> -  */
> --int tracepoint_probe_register_noupdate(const char *name, void *probe)
> -+static
> -+int ___tracepoint_probe_register_noupdate(const char *name, void *probe,
> -+				       void *data, bool kabi_2635)
> - {
> --	void *old;
> -+	struct tracepoint_func *old;
> -
> - 	mutex_lock(&tracepoints_mutex);
> --	old = tracepoint_add_probe(name, probe);
> -+	old = tracepoint_add_probe(name, probe, data, kabi_2635);
> - 	if (IS_ERR(old)) {
> - 		mutex_unlock(&tracepoints_mutex);
> - 		return PTR_ERR(old);
> -@@ -432,6 +470,18 @@ int tracepoint_probe_register_noupdate(c
> - 	mutex_unlock(&tracepoints_mutex);
> - 	return 0;
> - }
> -+
> -+int kabi_2635_tracepoint_probe_register_noupdate(const char *name, void
> *probe,
> -+				       void *data)
> -+{
> -+	return ___tracepoint_probe_register_noupdate(name, probe, data, 1);
> -+}
> -+EXPORT_SYMBOL_GPL(kabi_2635_tracepoint_probe_register_noupdate);
> -+
> -+int tracepoint_probe_register_noupdate(const char *name, void *probe)
> -+{
> -+	return ___tracepoint_probe_register_noupdate(name, probe, NULL, 0);
> -+}
> - EXPORT_SYMBOL_GPL(tracepoint_probe_register_noupdate);
> -
> - /**
> -@@ -441,12 +491,14 @@ EXPORT_SYMBOL_GPL(tracepoint_probe_regis
> -  *
> -  * caller must call tracepoint_probe_update_all()
> -  */
> --int tracepoint_probe_unregister_noupdate(const char *name, void *probe)
> -+static
> -+int ___tracepoint_probe_unregister_noupdate(const char *name, void *probe,
> -+					 void *data)
> - {
> --	void *old;
> -+	struct tracepoint_func *old;
> -
> - 	mutex_lock(&tracepoints_mutex);
> --	old = tracepoint_remove_probe(name, probe);
> -+	old = tracepoint_remove_probe(name, probe, data);
> - 	if (IS_ERR(old)) {
> - 		mutex_unlock(&tracepoints_mutex);
> - 		return PTR_ERR(old);
> -@@ -455,6 +507,18 @@ int tracepoint_probe_unregister_noupdate
> - 	mutex_unlock(&tracepoints_mutex);
> - 	return 0;
> - }
> -+
> -+int kabi_2635_tracepoint_probe_unregister_noupdate(const char *name, void
> *probe,
> -+					 void *data)
> -+{
> -+	return ___tracepoint_probe_unregister_noupdate(name, probe, data);
> -+}
> -+EXPORT_SYMBOL_GPL(kabi_2635_tracepoint_probe_unregister_noupdate);
> -+
> -+int tracepoint_probe_unregister_noupdate(const char *name, void *probe)
> -+{
> -+	return ___tracepoint_probe_unregister_noupdate(name, probe, NULL);
> -+}
> - EXPORT_SYMBOL_GPL(tracepoint_probe_unregister_noupdate);
> -
> - /**
> -Index: linux/samples/tracepoints/tp-samples-trace.h
> -===================================================================
> ---- linux.orig/samples/tracepoints/tp-samples-trace.h
> -+++ linux/samples/tracepoints/tp-samples-trace.h
> -@@ -7,7 +7,5 @@
> - DECLARE_TRACE(subsys_event,
> - 	TP_PROTO(struct inode *inode, struct file *file),
> - 	TP_ARGS(inode, file));
> --DECLARE_TRACE(subsys_eventb,
> --	TP_PROTO(void),
> --	TP_ARGS());
> -+DECLARE_TRACE_NOARGS(subsys_eventb);
> - #endif
> diff --git a/linux-patches/backport-tracepoint-data-2.6.32-33.patch
> b/linux-patches/backport-tracepoint-data-2.6.32-33.patch
> deleted file mode 100644
> index e53b476..0000000
> --- a/linux-patches/backport-tracepoint-data-2.6.32-33.patch
> +++ /dev/null
> @@ -1,555 +0,0 @@
> -commit 2c2a566b64b4254c530fb0c2222b30e8a739bac9
> -Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> -Date:   Sat Sep 1 17:45:09 2012 -0700
> -
> -    tracing: Let tracepoints have data passed to tracepoint callbacks
> (backport)
> -
> -    Backport of commit 38516ab59fbc5b3bb278cf5e1fe2867c70cff32e for
> -    2.6.32.x and 2.6.33.x. Keeping kABI compatibility.
> -
> -    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> -
> ----
> - include/linux/tracepoint.h             |  141 +++++++++++++++++++++++++-------
> - kernel/tracepoint.c                    |  144
> ++++++++++++++++++++++++---------
> - samples/tracepoints/tp-samples-trace.h |    4 +-
> - 3 files changed, 216 insertions(+), 73 deletions(-)
> -
> -Index: linux/include/linux/tracepoint.h
> -===================================================================
> ---- linux.orig/include/linux/tracepoint.h
> -+++ linux/include/linux/tracepoint.h
> -@@ -20,12 +20,20 @@
> - struct module;
> - struct tracepoint;
> -
> -+#define HAVE_KABI_2635_TRACEPOINT
> -+
> -+struct tracepoint_func {
> -+	void *func;
> -+	void *data;
> -+	bool kabi_2635;
> -+};
> -+
> - struct tracepoint {
> - 	const char *name;		/* Tracepoint name */
> - 	int state;			/* State. */
> - 	void (*regfunc)(void);
> - 	void (*unregfunc)(void);
> --	void **funcs;
> -+	struct tracepoint_func *funcs;
> - } __attribute__((aligned(32)));		/*
> - 					 * Aligned on 32 bytes because it is
> - 					 * globally visible and gcc happily
> -@@ -43,17 +51,33 @@ struct tracepoint {
> - /*
> -  * it_func[0] is never NULL because there is at least one element in the array
> -  * when the array itself is non NULL.
> -+ *
> -+ * Note, the proto and args passed in includes "__data" as the first
> parameter.
> -+ * The reason for this is to handle the "void" prototype. If a tracepoint
> -+ * has a "void" prototype, then it is invalid to declare a function
> -+ * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
> -+ * "void *data", where as the DECLARE_TRACE() will pass in "void *data,
> proto".
> -  */
> --#define __DO_TRACE(tp, proto, args)					\
> -+#define __DO_TRACE(tp, data_proto, data_args, proto, args)		\
> - 	do {								\
> --		void **it_func;						\
> -+		struct tracepoint_func *it_func_ptr;			\
> -+		void *it_func;						\
> - 									\
> - 		rcu_read_lock_sched_notrace();				\
> --		it_func = rcu_dereference((tp)->funcs);			\
> --		if (it_func) {						\
> -+		it_func_ptr = rcu_dereference((tp)->funcs);		\
> -+		if (it_func_ptr) {					\
> - 			do {						\
> --				((void(*)(proto))(*it_func))(args);	\
> --			} while (*(++it_func));				\
> -+				if (it_func_ptr->kabi_2635) {		\
> -+					void *__data;			\
> -+									\
> -+					it_func = (it_func_ptr)->func;	\
> -+					__data = (it_func_ptr)->data;	\
> -+					((void(*)(data_proto))(it_func))(data_args); \
> -+				} else {				\
> -+					it_func = (it_func_ptr)->func;	\
> -+					((void(*)(proto))(it_func))(args); \
> -+				}					\
> -+			} while ((++it_func_ptr)->func);		\
> - 		}							\
> - 		rcu_read_unlock_sched_notrace();			\
> - 	} while (0)
> -@@ -63,22 +87,39 @@ struct tracepoint {
> -  * not add unwanted padding between the beginning of the section and the
> -  * structure. Force alignment to the same alignment as the section start.
> -  */
> --#define DECLARE_TRACE(name, proto, args)				\
> -+#define __DECLARE_TRACE(name, proto, args, data_proto, data_args)	\
> - 	extern struct tracepoint __tracepoint_##name;			\
> - 	static inline void trace_##name(proto)				\
> - 	{								\
> - 		if (unlikely(__tracepoint_##name.state))		\
> - 			__DO_TRACE(&__tracepoint_##name,		\
> --				TP_PROTO(proto), TP_ARGS(args));	\
> -+				TP_PROTO(data_proto),			\
> -+				TP_ARGS(data_args),			\
> -+				TP_PROTO(proto),			\
> -+				TP_ARGS(args));				\
> - 	}								\
> --	static inline int register_trace_##name(void (*probe)(proto))	\
> --	{								\
> -+	static inline int						\
> -+	register_trace_##name(void (*probe)(proto))			\
> -+ 	{								\
> - 		return tracepoint_probe_register(#name, (void *)probe);	\
> --	}								\
> --	static inline int unregister_trace_##name(void (*probe)(proto))	\
> --	{								\
> --		return tracepoint_probe_unregister(#name, (void *)probe);\
> --	}
> -+ 	}								\
> -+	static inline int						\
> -+	unregister_trace_##name(void (*probe)(proto))			\
> -+ 	{								\
> -+		return tracepoint_probe_unregister(#name, (void *)probe); \
> -+ 	}								\
> -+	static inline int						\
> -+	kabi_2635_register_trace_##name(void (*probe)(data_proto), void *data) \
> -+ 	{								\
> -+		return kabi_2635_tracepoint_probe_register(#name, (void *)probe,	\
> -+						 data);			\
> -+ 	}								\
> -+	static inline int						\
> -+	kabi_2635_unregister_trace_##name(void (*probe)(data_proto), void *data) \
> -+ 	{								\
> -+		return kabi_2635_tracepoint_probe_unregister(#name, (void *)probe, \
> -+						   data);		\
> -+ 	}
> -
> -
> - #define DEFINE_TRACE_FN(name, reg, unreg)				\
> -@@ -100,19 +141,29 @@ extern void tracepoint_update_probe_rang
> - 	struct tracepoint *end);
> -
> - #else /* !CONFIG_TRACEPOINTS */
> --#define DECLARE_TRACE(name, proto, args)				\
> --	static inline void _do_trace_##name(struct tracepoint *tp, proto) \
> --	{ }								\
> --	static inline void trace_##name(proto)				\
> --	{ }								\
> --	static inline int register_trace_##name(void (*probe)(proto))	\
> --	{								\
> --		return -ENOSYS;						\
> --	}								\
> --	static inline int unregister_trace_##name(void (*probe)(proto))	\
> --	{								\
> --		return -ENOSYS;						\
> --	}
> -+#define __DECLARE_TRACE(name, proto, args, data_proto, data_args)	\
> -+ 	static inline void trace_##name(proto)				\
> -+ 	{ }								\
> -+	static inline int						\
> -+	register_trace_##name(void (*probe)(proto))			\
> -+ 	{								\
> -+ 		return -ENOSYS;						\
> -+ 	}								\
> -+	static inline int						\
> -+	unregister_trace_##name(void (*probe)(proto))			\
> -+ 	{								\
> -+ 		return -ENOSYS;						\
> -+ 	}								\
> -+	static inline int						\
> -+	kabi_2635_register_trace_##name(void (*probe)(data_proto), void *data) \
> -+ 	{								\
> -+ 		return -ENOSYS;						\
> -+ 	}								\
> -+	static inline int						\
> -+	kabi_2635_unregister_trace_##name(void (*probe)(data_proto), void *data) \
> -+ 	{								\
> -+ 		return -ENOSYS;						\
> -+ 	}
> -
> - #define DEFINE_TRACE_FN(name, reg, unreg)
> - #define DEFINE_TRACE(name)
> -@@ -123,6 +174,28 @@ static inline void tracepoint_update_pro
> - 	struct tracepoint *end)
> - { }
> - #endif /* CONFIG_TRACEPOINTS */
> -+
> -+/*
> -+ * The need for the DECLARE_TRACE_NOARGS() is to handle the prototype
> -+ * (void). "void" is a special value in a function prototype and can
> -+ * not be combined with other arguments. Since the DECLARE_TRACE()
> -+ * macro adds a data element at the beginning of the prototype,
> -+ * we need a way to differentiate "(void *data, proto)" from
> -+ * "(void *data, void)". The second prototype is invalid.
> -+ *
> -+ * DECLARE_TRACE_NOARGS() passes "void" as the tracepoint prototype
> -+ * and "void *__data" as the callback prototype.
> -+ *
> -+ * DECLARE_TRACE() passes "proto" as the tracepoint protoype and
> -+ * "void *__data, proto" as the callback prototype.
> -+ */
> -+#define DECLARE_TRACE_NOARGS(name)					\
> -+	__DECLARE_TRACE(name, void, , void *__data, __data)
> -+#define DECLARE_TRACE(name, proto, args)				\
> -+	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
> -+			PARAMS(void *__data, proto),			\
> -+			PARAMS(__data, args))
> -+
> - #endif /* DECLARE_TRACE */
> -
> - /*
> -@@ -130,15 +203,23 @@ static inline void tracepoint_update_pro
> -  * Internal API, should not be used directly.
> -  */
> - extern int tracepoint_probe_register(const char *name, void *probe);
> -+extern int kabi_2635_tracepoint_probe_register(const char *name, void *probe,
> void *data);
> -
> - /*
> -  * Disconnect a probe from a tracepoint.
> -  * Internal API, should not be used directly.
> -  */
> --extern int tracepoint_probe_unregister(const char *name, void *probe);
> -+extern int
> -+tracepoint_probe_unregister(const char *name, void *probe);
> -+extern int
> -+kabi_2635_tracepoint_probe_unregister(const char *name, void *probe, void
> *data);
> -
> - extern int tracepoint_probe_register_noupdate(const char *name, void *probe);
> -+extern int kabi_2635_tracepoint_probe_register_noupdate(const char *name, void
> *probe,
> -+					      void *data);
> - extern int tracepoint_probe_unregister_noupdate(const char *name, void
> *probe);
> -+extern int kabi_2635_tracepoint_probe_unregister_noupdate(const char *name,
> void *probe,
> -+						void *data);
> - extern void tracepoint_probe_update_all(void);
> -
> - struct tracepoint_iter {
> -Index: linux/kernel/tracepoint.c
> -===================================================================
> ---- linux.orig/kernel/tracepoint.c
> -+++ linux/kernel/tracepoint.c
> -@@ -54,7 +54,7 @@ static struct hlist_head tracepoint_tabl
> -  */
> - struct tracepoint_entry {
> - 	struct hlist_node hlist;
> --	void **funcs;
> -+	struct tracepoint_func *funcs;
> - 	int refcount;	/* Number of times armed. 0 if disarmed. */
> - 	char name[0];
> - };
> -@@ -64,12 +64,12 @@ struct tp_probes {
> - 		struct rcu_head rcu;
> - 		struct list_head list;
> - 	} u;
> --	void *probes[0];
> -+	struct tracepoint_func probes[0];
> - };
> -
> - static inline void *allocate_probes(int count)
> - {
> --	struct tp_probes *p  = kmalloc(count * sizeof(void *)
> -+	struct tp_probes *p  = kmalloc(count * sizeof(struct tracepoint_func)
> - 			+ sizeof(struct tp_probes), GFP_KERNEL);
> - 	return p == NULL ? NULL : p->probes;
> - }
> -@@ -79,7 +79,7 @@ static void rcu_free_old_probes(struct r
> - 	kfree(container_of(head, struct tp_probes, u.rcu));
> - }
> -
> --static inline void release_probes(void *old)
> -+static inline void release_probes(struct tracepoint_func *old)
> - {
> - 	if (old) {
> - 		struct tp_probes *tp_probes = container_of(old,
> -@@ -95,15 +95,16 @@ static void debug_print_probes(struct tr
> - 	if (!tracepoint_debug || !entry->funcs)
> - 		return;
> -
> --	for (i = 0; entry->funcs[i]; i++)
> --		printk(KERN_DEBUG "Probe %d : %p\n", i, entry->funcs[i]);
> -+	for (i = 0; entry->funcs[i].func; i++)
> -+		printk(KERN_DEBUG "Probe %d : %p\n", i, entry->funcs[i].func);
> - }
> -
> --static void *
> --tracepoint_entry_add_probe(struct tracepoint_entry *entry, void *probe)
> -+static struct tracepoint_func *
> -+tracepoint_entry_add_probe(struct tracepoint_entry *entry,
> -+			   void *probe, void *data, bool kabi_2635)
> - {
> - 	int nr_probes = 0;
> --	void **old, **new;
> -+	struct tracepoint_func *old, *new;
> -
> - 	WARN_ON(!probe);
> -
> -@@ -111,8 +112,9 @@ tracepoint_entry_add_probe(struct tracep
> - 	old = entry->funcs;
> - 	if (old) {
> - 		/* (N -> N+1), (N != 0, 1) probes */
> --		for (nr_probes = 0; old[nr_probes]; nr_probes++)
> --			if (old[nr_probes] == probe)
> -+		for (nr_probes = 0; old[nr_probes].func; nr_probes++)
> -+			if (old[nr_probes].func == probe &&
> -+			    old[nr_probes].data == data)
> - 				return ERR_PTR(-EEXIST);
> - 	}
> - 	/* + 2 : one for new probe, one for NULL func */
> -@@ -120,9 +122,11 @@ tracepoint_entry_add_probe(struct tracep
> - 	if (new == NULL)
> - 		return ERR_PTR(-ENOMEM);
> - 	if (old)
> --		memcpy(new, old, nr_probes * sizeof(void *));
> --	new[nr_probes] = probe;
> --	new[nr_probes + 1] = NULL;
> -+		memcpy(new, old, nr_probes * sizeof(struct tracepoint_func));
> -+	new[nr_probes].func = probe;
> -+	new[nr_probes].data = data;
> -+	new[nr_probes].kabi_2635 = kabi_2635;
> -+	new[nr_probes + 1].func = NULL;
> - 	entry->refcount = nr_probes + 1;
> - 	entry->funcs = new;
> - 	debug_print_probes(entry);
> -@@ -130,10 +134,11 @@ tracepoint_entry_add_probe(struct tracep
> - }
> -
> - static void *
> --tracepoint_entry_remove_probe(struct tracepoint_entry *entry, void *probe)
> -+tracepoint_entry_remove_probe(struct tracepoint_entry *entry,
> -+			      void *probe, void *data)
> - {
> - 	int nr_probes = 0, nr_del = 0, i;
> --	void **old, **new;
> -+	struct tracepoint_func *old, *new;
> -
> - 	old = entry->funcs;
> -
> -@@ -142,8 +147,10 @@ tracepoint_entry_remove_probe(struct tra
> -
> - 	debug_print_probes(entry);
> - 	/* (N -> M), (N > 1, M >= 0) probes */
> --	for (nr_probes = 0; old[nr_probes]; nr_probes++) {
> --		if ((!probe || old[nr_probes] == probe))
> -+	for (nr_probes = 0; old[nr_probes].func; nr_probes++) {
> -+		if (!probe ||
> -+		    (old[nr_probes].func == probe &&
> -+		     old[nr_probes].data == data))
> - 			nr_del++;
> - 	}
> -
> -@@ -160,10 +167,11 @@ tracepoint_entry_remove_probe(struct tra
> - 		new = allocate_probes(nr_probes - nr_del + 1);
> - 		if (new == NULL)
> - 			return ERR_PTR(-ENOMEM);
> --		for (i = 0; old[i]; i++)
> --			if ((probe && old[i] != probe))
> -+		for (i = 0; old[i].func; i++)
> -+			if (probe &&
> -+			    (old[i].func != probe || old[i].data != data))
> - 				new[j++] = old[i];
> --		new[nr_probes - nr_del] = NULL;
> -+		new[nr_probes - nr_del].func = NULL;
> - 		entry->refcount = nr_probes - nr_del;
> - 		entry->funcs = new;
> - 	}
> -@@ -315,18 +323,19 @@ static void tracepoint_update_probes(voi
> - 	module_update_tracepoints();
> - }
> -
> --static void *tracepoint_add_probe(const char *name, void *probe)
> -+static struct tracepoint_func *
> -+tracepoint_add_probe(const char *name, void *probe, void *data, bool
> kabi_2635)
> - {
> - 	struct tracepoint_entry *entry;
> --	void *old;
> -+	struct tracepoint_func *old;
> -
> - 	entry = get_tracepoint(name);
> - 	if (!entry) {
> - 		entry = add_tracepoint(name);
> - 		if (IS_ERR(entry))
> --			return entry;
> -+			return (struct tracepoint_func *)entry;
> - 	}
> --	old = tracepoint_entry_add_probe(entry, probe);
> -+	old = tracepoint_entry_add_probe(entry, probe, data, kabi_2635);
> - 	if (IS_ERR(old) && !entry->refcount)
> - 		remove_tracepoint(entry);
> - 	return old;
> -@@ -340,12 +349,14 @@ static void *tracepoint_add_probe(const
> -  * Returns 0 if ok, error value on error.
> -  * The probe address must at least be aligned on the architecture pointer
> size.
> -  */
> --int tracepoint_probe_register(const char *name, void *probe)
> -+static
> -+int ___tracepoint_probe_register(const char *name, void *probe, void *data,
> -+			bool kabi_2635)
> - {
> --	void *old;
> -+	struct tracepoint_func *old;
> -
> - 	mutex_lock(&tracepoints_mutex);
> --	old = tracepoint_add_probe(name, probe);
> -+	old = tracepoint_add_probe(name, probe, data, kabi_2635);
> - 	mutex_unlock(&tracepoints_mutex);
> - 	if (IS_ERR(old))
> - 		return PTR_ERR(old);
> -@@ -354,17 +365,30 @@ int tracepoint_probe_register(const char
> - 	release_probes(old);
> - 	return 0;
> - }
> -+
> -+int kabi_2635_tracepoint_probe_register(const char *name, void *probe, void
> *data)
> -+{
> -+	return ___tracepoint_probe_register(name, probe, data, 1);
> -+}
> -+EXPORT_SYMBOL_GPL(kabi_2635_tracepoint_probe_register);
> -+
> -+
> -+int tracepoint_probe_register(const char *name, void *probe)
> -+{
> -+	return ___tracepoint_probe_register(name, probe, NULL, 0);
> -+}
> - EXPORT_SYMBOL_GPL(tracepoint_probe_register);
> -
> --static void *tracepoint_remove_probe(const char *name, void *probe)
> -+static struct tracepoint_func *
> -+tracepoint_remove_probe(const char *name, void *probe, void *data)
> - {
> - 	struct tracepoint_entry *entry;
> --	void *old;
> -+	struct tracepoint_func *old;
> -
> - 	entry = get_tracepoint(name);
> - 	if (!entry)
> - 		return ERR_PTR(-ENOENT);
> --	old = tracepoint_entry_remove_probe(entry, probe);
> -+	old = tracepoint_entry_remove_probe(entry, probe, data);
> - 	if (IS_ERR(old))
> - 		return old;
> - 	if (!entry->refcount)
> -@@ -382,12 +406,13 @@ static void *tracepoint_remove_probe(con
> -  * itself uses stop_machine(), which insures that every preempt disabled
> section
> -  * have finished.
> -  */
> --int tracepoint_probe_unregister(const char *name, void *probe)
> -+static
> -+int ___tracepoint_probe_unregister(const char *name, void *probe, void *data)
> - {
> --	void *old;
> -+	struct tracepoint_func *old;
> -
> - 	mutex_lock(&tracepoints_mutex);
> --	old = tracepoint_remove_probe(name, probe);
> -+	old = tracepoint_remove_probe(name, probe, data);
> - 	mutex_unlock(&tracepoints_mutex);
> - 	if (IS_ERR(old))
> - 		return PTR_ERR(old);
> -@@ -396,6 +421,17 @@ int tracepoint_probe_unregister(const ch
> - 	release_probes(old);
> - 	return 0;
> - }
> -+
> -+int kabi_2635_tracepoint_probe_unregister(const char *name, void *probe, void
> *data)
> -+{
> -+	return ___tracepoint_probe_unregister(name, probe, data);
> -+}
> -+EXPORT_SYMBOL_GPL(kabi_2635_tracepoint_probe_unregister);
> -+
> -+int tracepoint_probe_unregister(const char *name, void *probe)
> -+{
> -+	return ___tracepoint_probe_unregister(name, probe, NULL);
> -+}
> - EXPORT_SYMBOL_GPL(tracepoint_probe_unregister);
> -
> - static LIST_HEAD(old_probes);
> -@@ -418,12 +454,14 @@ static void tracepoint_add_old_probes(vo
> -  *
> -  * caller must call tracepoint_probe_update_all()
> -  */
> --int tracepoint_probe_register_noupdate(const char *name, void *probe)
> -+static
> -+int ___tracepoint_probe_register_noupdate(const char *name, void *probe,
> -+				       void *data, bool kabi_2635)
> - {
> --	void *old;
> -+	struct tracepoint_func *old;
> -
> - 	mutex_lock(&tracepoints_mutex);
> --	old = tracepoint_add_probe(name, probe);
> -+	old = tracepoint_add_probe(name, probe, data, kabi_2635);
> - 	if (IS_ERR(old)) {
> - 		mutex_unlock(&tracepoints_mutex);
> - 		return PTR_ERR(old);
> -@@ -432,6 +470,18 @@ int tracepoint_probe_register_noupdate(c
> - 	mutex_unlock(&tracepoints_mutex);
> - 	return 0;
> - }
> -+
> -+int kabi_2635_tracepoint_probe_register_noupdate(const char *name, void
> *probe,
> -+				       void *data)
> -+{
> -+	return ___tracepoint_probe_register_noupdate(name, probe, data, 1);
> -+}
> -+EXPORT_SYMBOL_GPL(kabi_2635_tracepoint_probe_register_noupdate);
> -+
> -+int tracepoint_probe_register_noupdate(const char *name, void *probe)
> -+{
> -+	return ___tracepoint_probe_register_noupdate(name, probe, NULL, 0);
> -+}
> - EXPORT_SYMBOL_GPL(tracepoint_probe_register_noupdate);
> -
> - /**
> -@@ -441,12 +491,14 @@ EXPORT_SYMBOL_GPL(tracepoint_probe_regis
> -  *
> -  * caller must call tracepoint_probe_update_all()
> -  */
> --int tracepoint_probe_unregister_noupdate(const char *name, void *probe)
> -+static
> -+int ___tracepoint_probe_unregister_noupdate(const char *name, void *probe,
> -+					 void *data)
> - {
> --	void *old;
> -+	struct tracepoint_func *old;
> -
> - 	mutex_lock(&tracepoints_mutex);
> --	old = tracepoint_remove_probe(name, probe);
> -+	old = tracepoint_remove_probe(name, probe, data);
> - 	if (IS_ERR(old)) {
> - 		mutex_unlock(&tracepoints_mutex);
> - 		return PTR_ERR(old);
> -@@ -455,6 +507,18 @@ int tracepoint_probe_unregister_noupdate
> - 	mutex_unlock(&tracepoints_mutex);
> - 	return 0;
> - }
> -+
> -+int kabi_2635_tracepoint_probe_unregister_noupdate(const char *name, void
> *probe,
> -+					 void *data)
> -+{
> -+	return ___tracepoint_probe_unregister_noupdate(name, probe, data);
> -+}
> -+EXPORT_SYMBOL_GPL(kabi_2635_tracepoint_probe_unregister_noupdate);
> -+
> -+int tracepoint_probe_unregister_noupdate(const char *name, void *probe)
> -+{
> -+	return ___tracepoint_probe_unregister_noupdate(name, probe, NULL);
> -+}
> - EXPORT_SYMBOL_GPL(tracepoint_probe_unregister_noupdate);
> -
> - /**
> -Index: linux/samples/tracepoints/tp-samples-trace.h
> -===================================================================
> ---- linux.orig/samples/tracepoints/tp-samples-trace.h
> -+++ linux/samples/tracepoints/tp-samples-trace.h
> -@@ -7,7 +7,5 @@
> - DECLARE_TRACE(subsys_event,
> - 	TP_PROTO(struct inode *inode, struct file *file),
> - 	TP_ARGS(inode, file));
> --DECLARE_TRACE(subsys_eventb,
> --	TP_PROTO(void),
> --	TP_ARGS());
> -+DECLARE_TRACE_NOARGS(subsys_eventb);
> - #endif
> diff --git a/lttng-events.c b/lttng-events.c
> index f1be602..566080a 100644
> --- a/lttng-events.c
> +++ b/lttng-events.c
> @@ -27,8 +27,8 @@
> #include <linux/jhash.h>
> #include <linux/uaccess.h>
> #include <linux/vmalloc.h>
> +#include <linux/uuid.h>
> 
> -#include <wrapper/uuid.h>
> #include <wrapper/vmalloc.h>	/* for wrapper_vmalloc_sync_all() */
> #include <wrapper/random.h>
> #include <wrapper/tracepoint.h>
> @@ -40,7 +40,6 @@
> #include <lttng-abi-old.h>
> #include <lttng-endian.h>
> #include <lttng-string-utils.h>
> -#include <wrapper/vzalloc.h>
> #include <wrapper/ringbuffer/backend.h>
> #include <wrapper/ringbuffer/frontend.h>
> 
> @@ -130,7 +129,7 @@ struct lttng_session *lttng_session_create(void)
> 			GFP_KERNEL);
> 	if (!metadata_cache)
> 		goto err_free_session;
> -	metadata_cache->data = lttng_vzalloc(METADATA_CACHE_DEFAULT_SIZE);
> +	metadata_cache->data = vzalloc(METADATA_CACHE_DEFAULT_SIZE);
> 	if (!metadata_cache->data)
> 		goto err_free_cache;
> 	metadata_cache->cache_alloc = METADATA_CACHE_DEFAULT_SIZE;
> @@ -1692,7 +1691,7 @@ int lttng_metadata_printf(struct lttng_session *session,
> 		tmp_cache_alloc_size = max_t(unsigned int,
> 				session->metadata_cache->cache_alloc + len,
> 				session->metadata_cache->cache_alloc << 1);
> -		tmp_cache_realloc = lttng_vzalloc(tmp_cache_alloc_size);
> +		tmp_cache_realloc = vzalloc(tmp_cache_alloc_size);
> 		if (!tmp_cache_realloc)
> 			goto err;
> 		if (session->metadata_cache->data) {
> diff --git a/lttng-events.h b/lttng-events.h
> index f5a7d23..1903706 100644
> --- a/lttng-events.h
> +++ b/lttng-events.h
> @@ -15,7 +15,7 @@
> #include <linux/kprobes.h>
> #include <linux/kref.h>
> #include <lttng-cpuhotplug.h>
> -#include <wrapper/uuid.h>
> +#include <linux/uuid.h>
> #include <wrapper/uprobes.h>
> #include <lttng-tracer.h>
> #include <lttng-abi.h>
> @@ -716,7 +716,7 @@ int lttng_add_migratable_to_ctx(struct lttng_ctx **ctx)
> 
> int lttng_add_callstack_to_ctx(struct lttng_ctx **ctx, int type);
> 
> -#if defined(CONFIG_PERF_EVENTS) && (LINUX_VERSION_CODE >=
> KERNEL_VERSION(2,6,33))
> +#if defined(CONFIG_PERF_EVENTS)
> int lttng_add_perf_counter_to_ctx(uint32_t type,
> 				  uint64_t config,
> 				  const char *name,
> @@ -891,8 +891,6 @@ int lttng_calibrate(struct lttng_kernel_calibrate
> *calibrate);
> extern const struct file_operations lttng_tracepoint_list_fops;
> extern const struct file_operations lttng_syscall_list_fops;
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> #define TRACEPOINT_HAS_DATA_ARG
> -#endif
> 
> #endif /* _LTTNG_EVENTS_H */
> diff --git a/lttng-kernel-version.h b/lttng-kernel-version.h
> index 6b545db..26f816c 100644
> --- a/lttng-kernel-version.h
> +++ b/lttng-kernel-version.h
> @@ -11,12 +11,7 @@
> #define _LTTNG_KERNEL_VERSION_H
> 
> #include <linux/version.h>
> -
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
> #include <generated/utsrelease.h>
> -#else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33)) */
> -#include <linux/utsrelease.h>
> -#endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33)) */
> 
> /*
>  * This macro checks if the kernel version is between the two specified
> diff --git a/lttng-statedump-impl.c b/lttng-statedump-impl.c
> index 6d91a2c..dc03750 100644
> --- a/lttng-statedump-impl.c
> +++ b/lttng-statedump-impl.c
> @@ -37,7 +37,6 @@
> #include <lttng-events.h>
> #include <lttng-tracer.h>
> #include <wrapper/irqdesc.h>
> -#include <wrapper/spinlock.h>
> #include <wrapper/fdtable.h>
> #include <wrapper/irq.h>
> #include <wrapper/tracepoint.h>
> @@ -354,10 +353,6 @@ int lttng_enumerate_vm_maps(struct lttng_session *session)
> 
> #ifdef CONFIG_LTTNG_HAS_LIST_IRQ
> 
> -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39))
> -#define irq_desc_get_chip(desc) get_irq_desc_chip(desc)
> -#endif
> -
> static
> int lttng_list_interrupts(struct lttng_session *session)
> {
> @@ -373,12 +368,12 @@ int lttng_list_interrupts(struct lttng_session *session)
> 			irq_desc_get_chip(desc)->name ? : "unnamed_irq_chip";
> 
> 		local_irq_save(flags);
> -		wrapper_desc_spin_lock(&desc->lock);
> +		raw_spin_lock(&desc->lock);
> 		for (action = desc->action; action; action = action->next) {
> 			trace_lttng_statedump_interrupt(session,
> 				irq, irq_chip_name, action);
> 		}
> -		wrapper_desc_spin_unlock(&desc->lock);
> +		raw_spin_unlock(&desc->lock);
> 		local_irq_restore(flags);
> 	}
> 	return 0;
> diff --git a/probes/lttng-probe-lock.c b/probes/lttng-probe-lock.c
> index b3ad230..e81eb36 100644
> --- a/probes/lttng-probe-lock.c
> +++ b/probes/lttng-probe-lock.c
> @@ -16,12 +16,7 @@
>  * Create the tracepoint static inlines from the kernel to validate that our
>  * trace event macros match the kernel we run on.
>  */
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
> #include <trace/events/lock.h>
> -#else
> -#include <trace/events/lockdep.h>
> -#endif
> -
> #include <wrapper/tracepoint.h>
> 
> /*
> diff --git a/tests/probes/lttng-test.c b/tests/probes/lttng-test.c
> index 42e48cf..d127818 100644
> --- a/tests/probes/lttng-test.c
> +++ b/tests/probes/lttng-test.c
> @@ -16,7 +16,6 @@
> #include <lttng-events.h>
> #include <lttng-tracer.h>
> #include <wrapper/tracepoint.h>
> -#include <wrapper/kstrtox.h>
> 
> #define TP_MODULE_NOAUTOLOAD
> #define LTTNG_PACKAGE_BUILD
> @@ -69,7 +68,7 @@ ssize_t lttng_test_filter_event_write(struct file *file, const
> char __user *user
> 	int ret;
> 
> 	/* Get the number of iterations */
> -	ret = lttng_kstrtouint_from_user(user_buf, count, 10, &nr_iter);
> +	ret = kstrtouint_from_user(user_buf, count, 10, &nr_iter);
> 	if (ret) {
> 		written = ret;
> 		goto end;
> diff --git a/wrapper/atomic.h b/wrapper/atomic.h
> index 51920c4..5ead899 100644
> --- a/wrapper/atomic.h
> +++ b/wrapper/atomic.h
> @@ -11,11 +11,7 @@
> #define _LTTNG_WRAPPER_ATOMIC_H
> 
> #include <linux/version.h>
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
> #include <linux/atomic.h>
> -#else
> -#include <asm/atomic.h>
> -#endif
> 
> #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0))
> static inline void lttng_smp_mb__before_atomic(void)
> diff --git a/wrapper/kstrtox.h b/wrapper/kstrtox.h
> deleted file mode 100644
> index b0c6cf8..0000000
> --- a/wrapper/kstrtox.h
> +++ /dev/null
> @@ -1,47 +0,0 @@
> -/* SPDX-License-Identifier: (GPL-2.0 or LGPL-2.1)
> - *
> - * wrapper/kstrtox.h
> - *
> - * Copyright (C) 2015 Michael Jeanson <mjeanson@efficios.com>
> - */
> -
> -#ifndef _LTTNG_WRAPPER_KSTRTOX_H
> -#define _LTTNG_WRAPPER_KSTRTOX_H
> -
> -#include <linux/version.h>
> -
> -#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0))
> -
> -#include <linux/uaccess.h>
> -
> -/* Excludes final \0. */
> -#define LTTNG_MAX_UINT_CHAR 10
> -
> -static inline
> -int __must_check lttng_kstrtouint_from_user(const char __user *ubuf,
> -		size_t count, unsigned int base, unsigned int *res)
> -{
> -	unsigned int _res;
> -	char kbuf[LTTNG_MAX_UINT_CHAR + 1], *endptr;
> -
> -	memset(kbuf, 0, sizeof(kbuf));
> -	if (copy_from_user(kbuf, ubuf, min_t(size_t, LTTNG_MAX_UINT_CHAR, count)))
> -		return -EFAULT;
> -
> -	_res = simple_strtoul(kbuf, &endptr, base);
> -	if (!endptr)
> -		return -EINVAL;
> -
> -	*res = _res;
> -	return 0;
> -}
> -#else
> -static inline
> -int __must_check lttng_kstrtouint_from_user(const char __user *ubuf,
> -		size_t count, unsigned int base, unsigned int *res)
> -{
> -	return kstrtouint_from_user(ubuf, count, base, res);
> -}
> -#endif
> -
> -#endif /* _LTTNG_WRAPPER_KSTRTOX_H */
> diff --git a/wrapper/perf.h b/wrapper/perf.h
> index 48e256c..4a7f6d8 100644
> --- a/wrapper/perf.h
> +++ b/wrapper/perf.h
> @@ -22,8 +22,6 @@ wrapper_perf_event_create_kernel_counter(struct
> perf_event_attr *attr,
> 	return perf_event_create_kernel_counter(attr, cpu, task, callback, NULL);
> }
> #else /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0)) */
> -
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
> static inline struct perf_event *
> wrapper_perf_event_create_kernel_counter(struct perf_event_attr *attr,
> 				int cpu,
> @@ -32,29 +30,6 @@ wrapper_perf_event_create_kernel_counter(struct
> perf_event_attr *attr,
> {
> 	return perf_event_create_kernel_counter(attr, cpu, task, callback);
> }
> -#else /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37)) */
> -static inline struct perf_event *
> -wrapper_perf_event_create_kernel_counter(struct perf_event_attr *attr,
> -				int cpu,
> -				struct task_struct *task,
> -				perf_overflow_handler_t callback)
> -{
> -	pid_t pid;
> -
> -	if (!task)
> -		pid = -1;
> -	else
> -		pid = task->pid;
> -
> -	return perf_event_create_kernel_counter(attr, cpu, pid, callback);
> -}
> -
> -#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37)) */
> -
> -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36))
> -#define local64_read(l)		atomic64_read(l)
> -#endif
> -
> #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0)) */
> 
> #endif /* CONFIG_PERF_EVENTS */
> diff --git a/wrapper/spinlock.h b/wrapper/spinlock.h
> deleted file mode 100644
> index b3570d4..0000000
> --- a/wrapper/spinlock.h
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -/* SPDX-License-Identifier: (GPL-2.0 or LGPL-2.1)
> - *
> - * wrapper/spinlock.h
> - *
> - * Copyright (C) 2011-2012 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> - */
> -
> -#ifndef _LTTNG_WRAPPER_SPINLOCK_H
> -#define _LTTNG_WRAPPER_SPINLOCK_H
> -
> -#include <linux/version.h>
> -
> -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33))
> -
> -#include <linux/string.h>
> -
> -#define raw_spin_lock_init(lock)					\
> -	do {								\
> -		raw_spinlock_t __lock = __RAW_SPIN_LOCK_UNLOCKED;	\
> -		memcpy(lock, &__lock, sizeof(lock));			\
> -	} while (0)
> -
> -#define raw_spin_is_locked(lock)	__raw_spin_is_locked(lock)
> -
> -#define wrapper_desc_spin_lock(lock)	spin_lock(lock)
> -#define wrapper_desc_spin_unlock(lock)	spin_unlock(lock)
> -
> -#else
> -
> -#define wrapper_desc_spin_lock(lock)	raw_spin_lock(lock)
> -#define wrapper_desc_spin_unlock(lock)	raw_spin_unlock(lock)
> -
> -#endif
> -#endif /* _LTTNG_WRAPPER_SPINLOCK_H */
> diff --git a/wrapper/tracepoint.h b/wrapper/tracepoint.h
> index 0c5a296..6ee4217 100644
> --- a/wrapper/tracepoint.h
> +++ b/wrapper/tracepoint.h
> @@ -14,12 +14,6 @@
> #include <linux/tracepoint.h>
> #include <linux/module.h>
> 
> -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
> -
> -#define DECLARE_EVENT_CLASS(name, proto, args, tstruct, assign, print)
> -
> -#endif
> -
> #ifndef HAVE_KABI_2635_TRACEPOINT
> 
> #define kabi_2635_tracepoint_probe_register tracepoint_probe_register
> diff --git a/wrapper/uuid.h b/wrapper/uuid.h
> deleted file mode 100644
> index 465754e..0000000
> --- a/wrapper/uuid.h
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -/* SPDX-License-Identifier: (GPL-2.0 or LGPL-2.1)
> - *
> - * wrapper/uuid.h
> - *
> - * Copyright (C) 2011-2012 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> - */
> -
> -#ifndef _LTTNG_WRAPPER_UUID_H
> -#define _LTTNG_WRAPPER_UUID_H
> -
> -#include <linux/version.h>
> -
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> -#include <linux/uuid.h>
> -#else
> -
> -#include <linux/random.h>
> -
> -typedef struct {
> -	__u8 b[16];
> -} uuid_le;
> -
> -static inline
> -void uuid_le_gen(uuid_le *u)
> -{
> -	generate_random_uuid(u->b);
> -}
> -
> -#endif
> -#endif /* _LTTNG_WRAPPER_UUID_H */
> diff --git a/wrapper/vzalloc.h b/wrapper/vzalloc.h
> deleted file mode 100644
> index eedaf8d..0000000
> --- a/wrapper/vzalloc.h
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -/* SPDX-License-Identifier: (GPL-2.0 or LGPL-2.1)
> - *
> - * wrapper/vzalloc.h
> - *
> - * Copyright (C) 2015 Michael Jeanson <mjeanson@efficios.com>
> - */
> -
> -#ifndef _LTTNG_WRAPPER_VZALLOC_H
> -#define _LTTNG_WRAPPER_VZALLOC_H
> -
> -#include <linux/version.h>
> -#include <linux/vmalloc.h>
> -
> -#if LTTNG_KERNEL_RANGE(2,6,36, 2,6,37)
> -static inline
> -void *lttng_vzalloc(unsigned long size)
> -{
> -	void *ret;
> -	ret = vmalloc(size);
> -	if (!ret)
> -		return NULL;
> -	memset(ret, 0, size);
> -	return ret;
> -}
> -#else
> -static inline
> -void *lttng_vzalloc(unsigned long size)
> -{
> -	return vzalloc(size);
> -}
> -#endif
> -
> -
> -#endif /* _LTTNG_WRAPPER_VZALLOC_H */
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
