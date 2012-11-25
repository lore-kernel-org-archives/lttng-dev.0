From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] ext3 instrumentation: fix
	of	assignment code conversion
Date: Sun, 25 Nov 2012 16:14:45 -0500
Message-ID: <20121125211445.GC13672__32709.9213762724$1353878117$gmane$org@Krystal>
References: <1353872400-19927-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TcjXK-0005qN-FY
	for lttng-dev@lists.lttng.org; Sun, 25 Nov 2012 16:14:46 -0500
Content-Disposition: inline
In-Reply-To: <1353872400-19927-1-git-send-email-andrew_gabbasov@mentor.com>
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
> Due to specifics of handling assignment code in lttng-modules,
> plain code in TP_fast_assign (outside tp_* macros) will not be reached.
> Everything should be enclosed into tp_* fragments.
> 
> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>

Merged, thanks!

Mathieu

> ---
>  instrumentation/events/lttng-module/ext3.h |   14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/instrumentation/events/lttng-module/ext3.h b/instrumentation/events/lttng-module/ext3.h
> index de80df9..f1b4aa9 100644
> --- a/instrumentation/events/lttng-module/ext3.h
> +++ b/instrumentation/events/lttng-module/ext3.h
> @@ -6,12 +6,6 @@
>  
>  #include <linux/tracepoint.h>
>  
> -#ifndef _TRACE_EXT3_DEF
> -#define _TRACE_EXT3_DEF
> -static struct dentry *dentry;
> -#endif
> -
> -
>  TRACE_EVENT(ext3_free_inode,
>  	TP_PROTO(struct inode *inode),
>  
> @@ -441,12 +435,10 @@ TRACE_EVENT(ext3_sync_file_enter,
>  	),
>  
>  	TP_fast_assign(
> -		dentry = file->f_path.dentry;
> -
> -		tp_assign(dev, dentry->d_inode->i_sb->s_dev)
> -		tp_assign(ino, dentry->d_inode->i_ino)
> +		tp_assign(dev, file->f_path.dentry->d_inode->i_sb->s_dev)
> +		tp_assign(ino, file->f_path.dentry->d_inode->i_ino)
>  		tp_assign(datasync, datasync)
> -		tp_assign(parent, dentry->d_parent->d_inode->i_ino)
> +		tp_assign(parent, file->f_path.dentry->d_parent->d_inode->i_ino)
>  	),
>  
>  	TP_printk("dev %d,%d ino %lu parent %ld datasync %d ",
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
