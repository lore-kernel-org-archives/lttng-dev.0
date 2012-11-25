From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Remove remaining semicolons
	in	TP_fast_assign blocks
Date: Sun, 25 Nov 2012 16:14:26 -0500
Message-ID: <20121125211426.GA13672__45508.872162509$1353878107$gmane$org@Krystal>
References: <1353871630-19756-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TcjX2-0005oo-KA
	for lttng-dev@lists.lttng.org; Sun, 25 Nov 2012 16:14:28 -0500
Content-Disposition: inline
In-Reply-To: <1353871630-19756-1-git-send-email-andrew_gabbasov@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Andrew Gabbasov (andrew_gabbasov@mentor.com) wrote:
> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>

Merged, thanks!

Mathieu

> ---
>  instrumentation/events/lttng-module/jbd2.h |   22 +++++++++++-----------
>  instrumentation/events/lttng-module/sock.h |    2 +-
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/instrumentation/events/lttng-module/jbd2.h b/instrumentation/events/lttng-module/jbd2.h
> index 91e2e6c..c7992c0 100644
> --- a/instrumentation/events/lttng-module/jbd2.h
> +++ b/instrumentation/events/lttng-module/jbd2.h
> @@ -25,8 +25,8 @@ TRACE_EVENT(jbd2_checkpoint,
>  	),
>  
>  	TP_fast_assign(
> -		tp_assign(dev, journal->j_fs_dev->bd_dev);
> -		tp_assign(result, result);
> +		tp_assign(dev, journal->j_fs_dev->bd_dev)
> +		tp_assign(result, result)
>  	),
>  
>  	TP_printk("dev %d,%d result %d",
> @@ -46,9 +46,9 @@ DECLARE_EVENT_CLASS(jbd2_commit,
>  	),
>  
>  	TP_fast_assign(
> -		tp_assign(dev, journal->j_fs_dev->bd_dev);
> -		tp_assign(sync_commit, commit_transaction->t_synchronous_commit);
> -		tp_assign(transaction, commit_transaction->t_tid);
> +		tp_assign(dev, journal->j_fs_dev->bd_dev)
> +		tp_assign(sync_commit, commit_transaction->t_synchronous_commit)
> +		tp_assign(transaction, commit_transaction->t_tid)
>  	),
>  
>  	TP_printk("dev %d,%d transaction %d sync %d",
> @@ -97,10 +97,10 @@ TRACE_EVENT(jbd2_end_commit,
>  	),
>  
>  	TP_fast_assign(
> -		tp_assign(dev, journal->j_fs_dev->bd_dev);
> -		tp_assign(sync_commit, commit_transaction->t_synchronous_commit);
> -		tp_assign(transaction, commit_transaction->t_tid);
> -		tp_assign(head, journal->j_tail_sequence);
> +		tp_assign(dev, journal->j_fs_dev->bd_dev)
> +		tp_assign(sync_commit, commit_transaction->t_synchronous_commit)
> +		tp_assign(transaction, commit_transaction->t_tid)
> +		tp_assign(head, journal->j_tail_sequence)
>  	),
>  
>  	TP_printk("dev %d,%d transaction %d sync %d head %d",
> @@ -119,8 +119,8 @@ TRACE_EVENT(jbd2_submit_inode_data,
>  	),
>  
>  	TP_fast_assign(
> -		tp_assign(dev, inode->i_sb->s_dev);
> -		tp_assign(ino, inode->i_ino);
> +		tp_assign(dev, inode->i_sb->s_dev)
> +		tp_assign(ino, inode->i_ino)
>  	),
>  
>  	TP_printk("dev %d,%d ino %lu",
> diff --git a/instrumentation/events/lttng-module/sock.h b/instrumentation/events/lttng-module/sock.h
> index c4e689a..b0c7411 100644
> --- a/instrumentation/events/lttng-module/sock.h
> +++ b/instrumentation/events/lttng-module/sock.h
> @@ -48,7 +48,7 @@ TRACE_EVENT(sock_exceed_buf_limit,
>  		tp_assign(sysctl_mem, prot->sysctl_mem)
>  		tp_assign(allocated, allocated)
>  		tp_assign(sysctl_rmem, prot->sysctl_rmem[0])
> -		tp_assign(rmem_alloc, atomic_read(&sk->sk_rmem_alloc));
> +		tp_assign(rmem_alloc, atomic_read(&sk->sk_rmem_alloc))
>  	),
>  
>  	TP_printk("proto:%s sysctl_mem=%ld,%ld,%ld allocated=%ld "
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
