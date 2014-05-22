From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [MODULES RFC PATCH] Add PID field to block_* events
Date: Thu, 22 May 2014 10:58:17 +0000 (UTC)
Message-ID: <1299971751.21511.1400756297855.JavaMail.zimbra__9408.22343477539$1400756357$gmane$org@efficios.com>
References: <1400707755-17355-1-git-send-email-jdesfossez@efficios.com>
 <779054188.21437.1400709697119.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WnQhc-0000hr-KJ
 for lttng-dev@lists.lttng.org; Thu, 22 May 2014 06:58:28 -0400
In-Reply-To: <779054188.21437.1400709697119.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: Jens Axboe <axboe@kernel.dk>, lttng-dev@lists.lttng.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> To: "Julien Desfossez" <jdesfossez@efficios.com>
> Cc: "Jens Axboe" <axboe@kernel.dk>, lttng-dev@lists.lttng.org, "Steven Rostedt" <rostedt@goodmis.org>
> Sent: Wednesday, May 21, 2014 6:01:37 PM
> Subject: Re: [lttng-dev] [MODULES RFC PATCH] Add PID field to block_* events
> 
> CCing Jens Axboe, who really know better than I do about the block
> layer! Also adding Steven, since he maintains the Linux upstream block
> layer instrumentation (closely matching the lttng-modules version).
> 
> ----- Original Message -----
> > From: "Julien Desfossez" <jdesfossez@efficios.com>
> > To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> > Cc: lttng-dev@lists.lttng.org, "Julien Desfossez" <jdesfossez@efficios.com>
> > Sent: Wednesday, May 21, 2014 5:29:15 PM
> > Subject: [MODULES RFC PATCH] Add PID field to block_* events
> > 
> > Most of the block events have the "comm" field, but we have no way to
> > match a block event to a certain PID which makes performing accurate
> > per-process analyses difficult.
> 
> Color me clueless, but isn't the block I/O activity independent of
> the PID which triggers the I/O (e.g. issuing the read(), write(),
> (and so on) system calls) for read ahead, writeback kernel thread
> activity ? Or perhaps are those just rare special case, and for
> the usual case we can use the current PID in which the block layer
> tracepoints are hit as indicator of which PID triggered the I/O ?

Ah! But I notice now that wherever you add "current->pid", there
was already "current->comm" being saved. So I guess it is consistent
with what is already there.

Now for lttng-modules instrumentation specificness: we call those
fields "tid" (for thread id). We keep "pid" field name for tgid,
which maps to the user-space notion of "pid" (as seen from /proc).

Can you rename those fields to "tid" (if you intend to use
current->pid), or is it current->tgid that you really want ? IOW,
do you want to target a specific execution thread or the thread
group that shares a virtual memory (process) ?

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
> > 
> > Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> > ---
> >  instrumentation/events/lttng-module/block.h | 56
> >  ++++++++++++++++++++---------
> >  1 file changed, 40 insertions(+), 16 deletions(-)
> > 
> > diff --git a/instrumentation/events/lttng-module/block.h
> > b/instrumentation/events/lttng-module/block.h
> > index e3e6b4c..d983db2 100644
> > --- a/instrumentation/events/lttng-module/block.h
> > +++ b/instrumentation/events/lttng-module/block.h
> > @@ -305,6 +305,7 @@ DECLARE_EVENT_CLASS(block_rq,
> >  		__field(  unsigned int,	nr_sector		)
> >  		__field(  unsigned int,	bytes			)
> >  		__field(  unsigned int,	rwbs			)
> > +		__field(  pid_t,	pid			)
> >  		__array_text(  char,         comm,   TASK_COMM_LEN   )
> >  		__dynamic_array_hex( unsigned char,	cmd,
> >  			(rq->cmd_type == REQ_TYPE_BLOCK_PC) ?
> > @@ -323,16 +324,17 @@ DECLARE_EVENT_CLASS(block_rq,
> >  		tp_memcpy_dyn(cmd, (rq->cmd_type == REQ_TYPE_BLOCK_PC) ?
> >  					rq->cmd : NULL)
> >  		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
> > +		tp_assign(pid, current->pid)
> >  	),
> >  
> > -	TP_printk("%d,%d %s %u (%s) %llu + %u [%s]",
> > +	TP_printk("%d,%d %s %u (%s) %llu + %u [%s] %d",
> >  		  MAJOR(__entry->dev), MINOR(__entry->dev),
> >  		  __print_rwbs_flags(__entry->rwbs),
> >  		  __entry->bytes,
> >  		  __blk_dump_cmd(__get_dynamic_array(cmd),
> >  				 __get_dynamic_array_len(cmd)),
> >  		  (unsigned long long)__entry->sector,
> > -		  __entry->nr_sector, __entry->comm)
> > +		  __entry->nr_sector, __entry->comm, __entry->pid)
> >  )
> >  
> >  /**
> > @@ -389,6 +391,7 @@ TRACE_EVENT(block_bio_bounce,
> >  		__field( sector_t,	sector			)
> >  		__field( unsigned int,	nr_sector		)
> >  		__field( unsigned int,	rwbs			)
> > +		__field( pid_t,		pid			)
> >  		__array_text( char,		comm,	TASK_COMM_LEN	)
> >  	),
> >  
> > @@ -400,6 +403,7 @@ TRACE_EVENT(block_bio_bounce,
> >  		tp_assign(nr_sector, bio_sectors(bio))
> >  		blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_iter.bi_size)
> >  		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
> > +		tp_assign(pid, current->pid)
> >  #else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
> >  		tp_assign(dev, bio->bi_bdev ?
> >  					  bio->bi_bdev->bd_dev : 0)
> > @@ -407,14 +411,15 @@ TRACE_EVENT(block_bio_bounce,
> >  		tp_assign(nr_sector, bio->bi_size >> 9)
> >  		blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_size)
> >  		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
> > +		tp_assign(pid, current->pid)
> >  #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
> >  	),
> >  
> > -	TP_printk("%d,%d %s %llu + %u [%s]",
> > +	TP_printk("%d,%d %s %llu + %u [%s] %d",
> >  		  MAJOR(__entry->dev), MINOR(__entry->dev),
> >  		  __print_rwbs_flags(__entry->rwbs),
> >  		  (unsigned long long)__entry->sector,
> > -		  __entry->nr_sector, __entry->comm)
> > +		  __entry->nr_sector, __entry->comm, __entry->pid)
> >  )
> >  
> >  /**
> > @@ -485,6 +490,7 @@ DECLARE_EVENT_CLASS(block_bio_merge,
> >  		__field( sector_t,	sector			)
> >  		__field( unsigned int,	nr_sector		)
> >  		__field( unsigned int,	rwbs			)
> > +		__field( pid_t,		pid			)
> >  		__array_text( char,		comm,	TASK_COMM_LEN	)
> >  	),
> >  
> > @@ -495,20 +501,22 @@ DECLARE_EVENT_CLASS(block_bio_merge,
> >  		tp_assign(nr_sector, bio_sectors(bio))
> >  		blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_iter.bi_size)
> >  		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
> > +		tp_assign(pid, current->pid)
> >  #else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
> >  		tp_assign(dev, bio->bi_bdev->bd_dev)
> >  		tp_assign(sector, bio->bi_sector)
> >  		tp_assign(nr_sector, bio->bi_size >> 9)
> >  		blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_size)
> >  		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
> > +		tp_assign(pid, current->pid)
> >  #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
> >  	),
> >  
> > -	TP_printk("%d,%d %s %llu + %u [%s]",
> > +	TP_printk("%d,%d %s %llu + %u [%s] %d",
> >  		  MAJOR(__entry->dev), MINOR(__entry->dev),
> >  		  __print_rwbs_flags(__entry->rwbs),
> >  		  (unsigned long long)__entry->sector,
> > -		  __entry->nr_sector, __entry->comm)
> > +		  __entry->nr_sector, __entry->comm, __entry->pid)
> >  )
> >  
> >  /**
> > @@ -559,6 +567,7 @@ TRACE_EVENT(block_bio_queue,
> >  		__field( sector_t,	sector			)
> >  		__field( unsigned int,	nr_sector		)
> >  		__field( unsigned int,	rwbs			)
> > +		__field( pid_t,		pid			)
> >  		__array_text( char,		comm,	TASK_COMM_LEN	)
> >  	),
> >  
> > @@ -569,19 +578,21 @@ TRACE_EVENT(block_bio_queue,
> >  		tp_assign(nr_sector, bio_sectors(bio))
> >  		blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_iter.bi_size)
> >  		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
> > +		tp_assign(pid, current->pid)
> >  #else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
> >  		tp_assign(dev, bio->bi_bdev->bd_dev)
> >  		tp_assign(sector, bio->bi_sector)
> >  		tp_assign(nr_sector, bio->bi_size >> 9)
> >  		blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_size)
> >  		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
> > +		tp_assign(pid, current->pid)
> >  #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
> >  	),
> >  
> > -	TP_printk("%d,%d %s %llu + %u [%s]",
> > +	TP_printk("%d,%d %s %llu + %u [%s] %d",
> >  		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
> >  		  (unsigned long long)__entry->sector,
> > -		  __entry->nr_sector, __entry->comm)
> > +		  __entry->nr_sector, __entry->comm, __entry->pid)
> >  )
> >  #else
> >  DECLARE_EVENT_CLASS(block_bio,
> > @@ -595,6 +606,7 @@ DECLARE_EVENT_CLASS(block_bio,
> >  		__field( sector_t,	sector			)
> >  		__field( unsigned int,	nr_sector		)
> >  		__field( unsigned int,	rwbs			)
> > +		__field( pid_t,		pid			)
> >  		__array_text( char,		comm,	TASK_COMM_LEN	)
> >  	),
> >  
> > @@ -604,13 +616,14 @@ DECLARE_EVENT_CLASS(block_bio,
> >  		tp_assign(nr_sector, bio->bi_size >> 9)
> >  		blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_size)
> >  		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
> > +		tp_assign(pid, current->pid)
> >  	),
> >  
> > -	TP_printk("%d,%d %s %llu + %u [%s]",
> > +	TP_printk("%d,%d %s %llu + %u [%s] %d",
> >  		  MAJOR(__entry->dev), MINOR(__entry->dev),
> >  		  __print_rwbs_flags(__entry->rwbs),
> >  		  (unsigned long long)__entry->sector,
> > -		  __entry->nr_sector, __entry->comm)
> > +		  __entry->nr_sector, __entry->comm, __entry->pid)
> >  )
> >  
> >  /**
> > @@ -669,6 +682,7 @@ DECLARE_EVENT_CLASS(block_get_rq,
> >  		__field( sector_t,	sector			)
> >  		__field( unsigned int,	nr_sector		)
> >  		__field( unsigned int,	rwbs			)
> > +		__field( pid_t,		pid			)
> >  		__array_text( char,		comm,	TASK_COMM_LEN	)
> >          ),
> >  
> > @@ -680,6 +694,7 @@ DECLARE_EVENT_CLASS(block_get_rq,
> >  		blk_fill_rwbs(rwbs, bio ? bio->bi_rw : 0,
> >  			      bio ? bio_sectors(bio) : 0)
> >  		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
> > +		tp_assign(pid, current->pid)
> >  #else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
> >  		tp_assign(dev, bio ? bio->bi_bdev->bd_dev : 0)
> >  		tp_assign(sector, bio ? bio->bi_sector : 0)
> > @@ -687,14 +702,15 @@ DECLARE_EVENT_CLASS(block_get_rq,
> >  		blk_fill_rwbs(rwbs, bio ? bio->bi_rw : 0,
> >  			      bio ? bio->bi_size >> 9 : 0)
> >  		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
> > +		tp_assign(pid, current->pid)
> >  #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
> >          ),
> >  
> > -	TP_printk("%d,%d %s %llu + %u [%s]",
> > +	TP_printk("%d,%d %s %llu + %u [%s] %d",
> >  		  MAJOR(__entry->dev), MINOR(__entry->dev),
> >  		  __print_rwbs_flags(__entry->rwbs),
> >  		  (unsigned long long)__entry->sector,
> > -		  __entry->nr_sector, __entry->comm)
> > +		  __entry->nr_sector, __entry->comm, __entry->pid)
> >  )
> >  
> >  /**
> > @@ -746,14 +762,16 @@ TRACE_EVENT(block_plug,
> >  	TP_ARGS(q),
> >  
> >  	TP_STRUCT__entry(
> > +		__field( pid_t,		pid			)
> >  		__array_text( char,		comm,	TASK_COMM_LEN	)
> >  	),
> >  
> >  	TP_fast_assign(
> >  		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
> > +		tp_assign(pid, current->pid)
> >  	),
> >  
> > -	TP_printk("[%s]", __entry->comm)
> > +	TP_printk("[%s] %d", __entry->comm, __entry->pid)
> >  )
> >  
> >  DECLARE_EVENT_CLASS(block_unplug,
> > @@ -770,6 +788,7 @@ DECLARE_EVENT_CLASS(block_unplug,
> >  
> >  	TP_STRUCT__entry(
> >  		__field( int,		nr_rq			)
> > +		__field( pid_t,		pid			)
> >  		__array_text( char,		comm,	TASK_COMM_LEN	)
> >  	),
> >  
> > @@ -780,9 +799,11 @@ DECLARE_EVENT_CLASS(block_unplug,
> >  		tp_assign(nr_rq, q->rq.count[READ] + q->rq.count[WRITE])
> >  #endif
> >  		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
> > +		tp_assign(pid, current->pid)
> >  	),
> >  
> > -	TP_printk("[%s] %d", __entry->comm, __entry->nr_rq)
> > +	TP_printk("[%s] %d %d", __entry->comm, , __entry->pid,
> > +			__entry->nr_rq)
> >  )
> >  
> >  #if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39))
> > @@ -850,6 +871,7 @@ TRACE_EVENT(block_split,
> >  		__field( sector_t,	sector				)
> >  		__field( sector_t,	new_sector			)
> >  		__field( unsigned int,	rwbs		)
> > +		__field( pid_t,		pid			)
> >  		__array_text( char,		comm,		TASK_COMM_LEN	)
> >  	),
> >  
> > @@ -860,21 +882,23 @@ TRACE_EVENT(block_split,
> >  		tp_assign(new_sector, new_sector)
> >  		blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_iter.bi_size)
> >  		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
> > +		tp_assign(pid, current->pid)
> >  #else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
> >  		tp_assign(dev, bio->bi_bdev->bd_dev)
> >  		tp_assign(sector, bio->bi_sector)
> >  		tp_assign(new_sector, new_sector)
> >  		blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_size)
> >  		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
> > +		tp_assign(pid, current->pid)
> >  #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
> >  	),
> >  
> > -	TP_printk("%d,%d %s %llu / %llu [%s]",
> > +	TP_printk("%d,%d %s %llu / %llu [%s] %d",
> >  		  MAJOR(__entry->dev), MINOR(__entry->dev),
> >  		  __print_rwbs_flags(__entry->rwbs),
> >  		  (unsigned long long)__entry->sector,
> >  		  (unsigned long long)__entry->new_sector,
> > -		  __entry->comm)
> > +		  __entry->comm, __entry->pid)
> >  )
> >  
> >  /**
> > --
> > 1.9.1
> > 
> > 
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
