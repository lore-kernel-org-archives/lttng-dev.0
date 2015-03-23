From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix:
	mm_page_alloc_extfrag	instrumentation for kernel 3.14.36
Date: Mon, 23 Mar 2015 13:45:32 +0000 (UTC)
Message-ID: <559240368.75625.1427118332169.JavaMail.zimbra__25290.0938423865$1427118387$gmane$org@efficios.com>
References: <1426965198-15490-1-git-send-email-abusque@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Ya2fh-0007gq-IU
 for lttng-dev@lists.lttng.org; Mon, 23 Mar 2015 09:45:38 -0400
In-Reply-To: <1426965198-15490-1-git-send-email-abusque@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Antoine Busque <abusque@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged into master, 2.6, 2.5, thanks!

Mathieu

----- Original Message -----
> The following commit has been backported from kernel 3.19.2 into
> 3.14.36, introducing a change to mm_page_alloc_extfrag and therefore
> provoking a build failure on a 3.14.36 kernel:
> 
> commit a4f3f96f850db69890f47984c60606a2362bee89
> Author: Vlastimil Babka <vbabka@suse.cz>
> Date:   Wed Feb 11 15:28:15 2015 -0800
> 
>     mm: when stealing freepages, also take pages created by splitting buddy
>     page
> 
>     commit 99592d598eca62bdbbf62b59941c189176dfc614 upstream.
> 
> This patch adds the proper version check to allow building on 3.14.y.
> 
> Signed-off-by: Antoine Busque <abusque@efficios.com>
> ---
>  instrumentation/events/lttng-module/kmem.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/instrumentation/events/lttng-module/kmem.h
> b/instrumentation/events/lttng-module/kmem.h
> index 3782ac6..710c9fa 100644
> --- a/instrumentation/events/lttng-module/kmem.h
> +++ b/instrumentation/events/lttng-module/kmem.h
> @@ -286,7 +286,8 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_PRINT(mm_page,
> mm_page_pcpu_drain,
>  		__entry->order, __entry->migratetype)
>  )
>  
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,2))
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,2)	\
> +	|| LTTNG_KERNEL_RANGE(3,14,36, 3,15,0))
>  
>  LTTNG_TRACEPOINT_EVENT(mm_page_alloc_extfrag,
>  
> --
> 2.3.3
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
