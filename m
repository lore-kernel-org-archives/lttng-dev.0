From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: correct typo in
	kernel	version number
Date: Mon, 16 Jun 2014 02:45:55 +0000 (UTC)
Message-ID: <2090385103.524.1402886755790.JavaMail.zimbra__30797.4507021301$1402886810$gmane$org@efficios.com>
References: <1402497944-2186-1-git-send-email-antoine.busque@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WwMvn-0004v2-Rd
 for lttng-dev@lists.lttng.org; Sun, 15 Jun 2014 22:46:01 -0400
In-Reply-To: <1402497944-2186-1-git-send-email-antoine.busque@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Antoine Busque <antoine.busque@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

I changed "if statement" for "preprocessor conditional". Merged,

Thanks!

Mathieu

----- Original Message -----
> From: "Antoine Busque" <antoine.busque@efficios.com>
> To: lttng-dev@lists.lttng.org
> Sent: Wednesday, June 11, 2014 10:45:44 AM
> Subject: [lttng-dev] [PATCH lttng-modules] Fix: correct typo in kernel	version number
> 
> A typo in an if statement verifying the range in which the current
> kernel's version is situated caused build failure for modules on 3.5.0
> specifically, by trying to use the new api for block_rq_complete which
> has not been backported from the 3.15 branch to the 3.5 branch.
> 
> Signed-off-by: Antoine Busque <antoine.busque@efficios.com>
> ---
>  instrumentation/events/lttng-module/block.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/instrumentation/events/lttng-module/block.h
> b/instrumentation/events/lttng-module/block.h
> index dbe6c6c..ad0a363 100644
> --- a/instrumentation/events/lttng-module/block.h
> +++ b/instrumentation/events/lttng-module/block.h
> @@ -224,7 +224,7 @@ DEFINE_EVENT(block_rq_with_error, block_rq_requeue,
>  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,5)	\
>  	|| LTTNG_KERNEL_RANGE(3,12,21, 3,13,0)		\
>  	|| LTTNG_KERNEL_RANGE(3,10,41, 3,11,0)		\
> -	|| LTTNG_KERNEL_RANGE(3,4,91, 3,5,1)		\
> +	|| LTTNG_KERNEL_RANGE(3,4,91, 3,5,0)		\
>  	|| LTTNG_KERNEL_RANGE(3,2,58, 3,3,0))
>  
>  /**
> --
> 2.0.0
> 
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
